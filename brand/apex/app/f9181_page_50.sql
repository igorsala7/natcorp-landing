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
,p_default_application_id=>9181
,p_default_id_offset=>800956978219246940
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9181 - Adm. Pessoal | Folha de Pagamento - Menu
--
-- Application Export:
--   Application:     9181
--   Name:            Adm. Pessoal | Folha de Pagamento - Menu
--   Date and Time:   18:08 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 50
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00050
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>50);
end;
/
prompt --application/pages/page_00050
begin
wwv_flow_api.create_page(
 p_id=>50
,p_user_interface_id=>wwv_flow_api.id(57485040171637710988)
,p_name=>unistr('Consolida\00E7\00E3o do Hist\00F3rico Financeiro')
,p_step_title=>unistr('Consolida\00E7\00E3o do Hist\00F3rico Financeiro')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ConsolFolha.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(function () {',
unistr('  // nomes exatos das colunas nesta p\00E1gina'),
'  const colunasAlvo = [',
'    "INSS",',
'    "FGTS",',
'    "IR",',
unistr('    "L\00EDquido"'),
'  ];',
'',
unistr('  // encontra th dentro da region pelo texto vis\00EDvel (case-insensitive, tolerante a espa\00E7os)'),
'  function findThByText(region, textoProcurado) {',
'    const ths = Array.from(region.querySelectorAll(''th''));',
'    const tLower = textoProcurado.trim().toLowerCase();',
'    for (let th of ths) {',
'      const txt = th.textContent.trim().toLowerCase().replace(/\s+/g, '' '');',
'      if (txt === tLower) return th;',
'      if (txt.indexOf(tLower) !== -1) return th;',
'    }',
'    return null;',
'  }',
'',
'  function aplicarIconesNaRegiao(region) {',
'    try {',
'      colunasAlvo.forEach(function (tituloColuna) {',
'        const th = findThByText(region, tituloColuna);',
'        if (!th) return;',
'        const thId = th.id;',
'        if (!thId) return;',
'',
'        const celulas = region.querySelectorAll(''td[headers~="'' + thId + ''"]'');',
'        celulas.forEach(function (td) {',
'          const valor = td.textContent.trim().toUpperCase();',
'          if (valor === "S") {',
'            td.innerHTML = "<span class=''fa fa-check-square-o'' aria-hidden=''true'' style=''color:green;font-size:16px''></span>";',
'            td.setAttribute(''data-orig-value'', ''S'');',
'          } else {',
'            td.innerHTML = "";',
'            td.removeAttribute(''data-orig-value'');',
'          }',
'        });',
'      });',
'    } catch (e) {',
'      console.error(''aplicarIconesNaRegiao:'', e);',
'    }',
'  }',
'',
'  function initAllReports() {',
unistr('    // Seleciona todas as regi\00F5es do tipo Interactive Report'),
'    const regions = document.querySelectorAll(''.t-IRR-region, .a-IRR-region'');',
'',
'    regions.forEach(function (region) {',
'      aplicarIconesNaRegiao(region);',
'',
'      const regionId = region.id;',
'      if (!regionId) return;',
'',
'      // Remove eventuais listeners duplicados',
'      apex.jQuery(document).off(''apexafterrefresh'', ''#'' + regionId);',
'',
unistr('      // Adiciona listener para aplicar novamente ap\00F3s refresh'),
'      apex.jQuery(document).on(''apexafterrefresh'', ''#'' + regionId, function () {',
'        const refreshedRegion = document.getElementById(regionId);',
'        if (!refreshedRegion) return;',
'',
unistr('        // Delay para garantir que o DOM est\00E1 pronto'),
'        setTimeout(function () {',
'          aplicarIconesNaRegiao(refreshedRegion);',
'        }, 80);',
'      });',
'    });',
'  }',
'',
'  // Executa quando o DOM estiver pronto',
'  document.addEventListener(''DOMContentLoaded'', function () {',
'    setTimeout(initAllReports, 120);',
'  });',
'',
unistr('  // Garante execu\00E7\00E3o mesmo que DOM j\00E1 esteja carregado'),
'  if (document.readyState === ''complete'' || document.readyState === ''interactive'') {',
'    setTimeout(initAllReports, 120);',
'  }',
'})();',
''))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ConsolFolha.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*#RID .t-fht-thead{',
'    overflow: auto !important ;',
'}*/'))
,p_step_template=>wwv_flow_api.id(57484998059769710817)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'MARCELO.SENA'
,p_last_upd_yyyymmddhh24miss=>'20260610165750'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30851015012533129617)
,p_plug_name=>'4 - Empresa / Filial / Unid. Adm. '
,p_region_name=>'IR_4'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.ROWID,',
'       t.cod_empresa,',
'       t.nome_empresa,',
'       t.filial,',
'       t.nome_filial,',
'       t.unidade_adm,',
'       t.desc_unidade_adm,',
'       t.cod_ocorr,',
'       t.nome_cod_ocorr,',
'       t.cod_gerencial,',
'       t.nome_cod_gerencial,',
'       t.qtde_func,',
'       t.tot_horas,',
'       t.tot_min,',
'       t.data_ref,',
'       t.tot_valor,',
'       a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,t.horas_ferias',
unistr('     ,(DECODE(t.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem '),
'  from TB_OCORR3 t',
'  ',
'    LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = t.cod_empresa',
'       AND a.cod = t.cod_ocorr',
'       ',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND t.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR t.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))  ',
'   AND (:P50_UNIDADM IS NULL OR t.unidade_adm IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_UNIDADM, '':'')) t))   ',
'  order by t.DATA_REF, t.COD_EMPRESA, t.FILIAL, to_number(t.COD_OCORR), to_number(t.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_UNIDADM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFUA'
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
 p_id=>wwv_flow_api.id(30851015224503129619)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1207787320628919441
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851015314739129620)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851015461638129621)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851015512740129622)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851015701575129623)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851015761130129624)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851015851158129625)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852724730533763884)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852724897896763885)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852725000070763886)
,p_db_column_name=>'FILIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852725082144763887)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852725119567763888)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Unidade Administrativa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852725220472763889)
,p_db_column_name=>'DESC_UNIDADE_ADM'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Nome Unidade Admistrativa'
,p_column_html_expression=>'<nobr>#DESC_UNIDADE_ADM#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852725861099763895)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852725958170763896)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726056134763897)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331985651304288)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333585706304304)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333658821304305)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333711620304306)
,p_db_column_name=>'INCID_IR'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333853206304307)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540302501339823)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802265127819129)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802320575819130)
,p_db_column_name=>'ORIGEM'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30852737826004782787)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12095100'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:UNIDADE_ADM:DESC_UNIDADE_ADM:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30852815628960043679)
,p_plug_name=>unistr('5 - Empresa / Divis\00E3o')
,p_region_name=>'IR_5'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.ROWID,',
'       t.data_ref,',
'       t.cod_empresa,',
'       t.nome_empresa,',
'       t.cod_divisao,',
'       t.desc_cod_divisao,',
'       t.cod_ocorr,',
'       t.nome_cod_ocorr,',
'       t.cod_gerencial,',
'       t.nome_cod_gerencial,',
'       t.qtde_func,',
'       t.tot_horas,',
'       t.tot_min,',
'       t.tot_valor,',
'       a.incid_iapas INSS,',
'       a.incid_fgts FGTS,',
'       a.incid_ir IR,',
'       a.incid_liq Liquido,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,t.horas_ferias',
unistr('     ,(DECODE(t.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR5 t',
'',
' LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = t.cod_empresa',
'       AND a.cod = t.cod_ocorr',
'',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(t.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'    AND t.cod_empresa = :P50_EMPRESA',
'    AND (:P50_DIVISAO IS NULL OR t.cod_divisao IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_DIVISAO, '':'')) t))    ',
'  order by t.DATA_REF, t.COD_EMPRESA, to_number(t.COD_OCORR), to_number(t.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_DIVISAO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'ED'
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
 p_id=>wwv_flow_api.id(30852815712878043680)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209587809003833502
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852815817699043681)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852815954152043682)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852816066765043683)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852816164068043684)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852816280826043685)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852816344533043686)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852816417673043687)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852816516104043688)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852817082309043693)
,p_db_column_name=>'COD_DIVISAO'
,p_display_order=>130
,p_column_identifier=>'I'
,p_column_label=>unistr('Divis\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852817191853043694)
,p_db_column_name=>'DESC_COD_DIVISAO'
,p_display_order=>140
,p_column_identifier=>'J'
,p_column_label=>unistr('Nome Divis\00E3o')
,p_column_html_expression=>'<nobr>#DESC_COD_DIVISAO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852817567864043698)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>180
,p_column_identifier=>'L'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852817607286043699)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>190
,p_column_identifier=>'M'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852817781396043700)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>200
,p_column_identifier=>'N'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333971900304308)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>210
,p_column_identifier=>'O'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334102816304309)
,p_db_column_name=>'INSS'
,p_display_order=>220
,p_column_identifier=>'P'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334117682304310)
,p_db_column_name=>'FGTS'
,p_display_order=>230
,p_column_identifier=>'Q'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334269486304311)
,p_db_column_name=>'IR'
,p_display_order=>240
,p_column_identifier=>'R'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334303907304312)
,p_db_column_name=>'LIQUIDO'
,p_display_order=>250
,p_column_identifier=>'S'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540232898339822)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>260
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802384288819131)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>270
,p_column_identifier=>'U'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802549519819132)
,p_db_column_name=>'ORIGEM'
,p_display_order=>280
,p_column_identifier=>'V'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30852827264681058293)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12095994'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:COD_DIVISAO:DESC_COD_DIVISAO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INSS:FGTS:IR:LIQUIDO:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30852819409415043717)
,p_plug_name=>'6 - Empresa / Regional  '
,p_region_name=>'IR_6'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.ROWID,',
'      f.data_ref,',
'       f.cod_empresa,',
'       f.nome_empresa,',
'       f.cod_regional,',
'       f.desc_cod_regional,',
'       f.cod_ocorr,',
'       f.nome_cod_ocorr,',
'       f.cod_gerencial,',
'       f.nome_cod_gerencial,',
'       f.qtde_func,',
'       f.tot_horas,',
'       f.tot_min,',
'       f.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,f.horas_ferias',
unistr('     ,(DECODE(f.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR6 f',
'',
'  LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = f.cod_empresa',
'       AND a.cod = f.cod_ocorr',
'',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(f.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND f.cod_empresa = :P50_EMPRESA',
'   AND (:P50_REGIONAL IS NULL OR f.cod_regional IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_REGIONAL, '':'')) t))   ',
'  order by f.DATA_REF, f.COD_EMPRESA, to_number(f.COD_OCORR), to_number(f.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_REGIONAL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'ER'
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
 p_id=>wwv_flow_api.id(30852819545524043718)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209591641649833540
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852819615421043719)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852819762268043720)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852819842235043721)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852819959585043722)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852820011484043723)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852820182564043724)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852820225533043725)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852820319594043726)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852833299595108183)
,p_db_column_name=>'COD_REGIONAL'
,p_display_order=>150
,p_column_identifier=>'I'
,p_column_label=>'Regional'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852833320139108184)
,p_db_column_name=>'DESC_COD_REGIONAL'
,p_display_order=>160
,p_column_identifier=>'J'
,p_column_label=>'Nome Regional'
,p_column_html_expression=>'<nobr>#DESC_COD_REGIONAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852833551330108186)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>180
,p_column_identifier=>'K'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852833616573108187)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>190
,p_column_identifier=>'L'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852833771391108188)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>200
,p_column_identifier=>'M'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852833878230108189)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>210
,p_column_identifier=>'N'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334453291304313)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>220
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334519768304314)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>230
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334606241304315)
,p_db_column_name=>'INCID_IR'
,p_display_order=>240
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334757642304316)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>250
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540115613339821)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>260
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802627173819133)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>270
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802768908819134)
,p_db_column_name=>'ORIGEM'
,p_display_order=>280
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30852843438892117715)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12096156'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:COD_REGIONAL:DESC_COD_REGIONAL:COD_GERENCIAL:NOME_COD_GERENCIAL:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30852833964699108190)
,p_plug_name=>'7 - Empresa / Filial / Ccusto / Cargo'
,p_region_name=>'IR_7'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select g.ROWID,',
'     g.cod_empresa,',
'     g.nome_empresa,',
'       g.filial,',
'       g.nome_filial,',
'       g.cod_ccusto,',
'       g.nome_ccusto,',
'       g.class_ccusto,',
'       g.desc_class_ccusto,',
'       g.cargo,',
'       g.nome_cargo,',
'       g.class_cargo,',
'       g.desc_class_cargo,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       g.nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas "INSS",',
'       a.incid_fgts "FGTS",',
'       a.incid_ir "IR",',
unistr('       a.incid_liq "L\00EDquido",'),
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR7 g',
'',
'  LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'       ',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA  ',
'   AND (:P50_FILIAL IS NULL OR g.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))',
'   AND (:P50_CCUSTO IS NULL OR g.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CCUSTO, '':'')) t))  ',
'   AND (:P50_CARGO  IS NULL OR g.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CARGO, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA, g.FILIAL, to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CCUSTO,P50_CARGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFCCCAR'
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
 p_id=>wwv_flow_api.id(30852834098174108191)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209606194299898013
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834130101108192)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834298625108193)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834329511108194)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834478350108195)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834599555108196)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834692731108197)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852834743498108198)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835294530108203)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>120
,p_column_identifier=>'H'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835491609108205)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835562400108206)
,p_db_column_name=>'FILIAL'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835615391108207)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>160
,p_column_identifier=>'K'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835732973108208)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>170
,p_column_identifier=>'L'
,p_column_label=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835825474108209)
,p_db_column_name=>'CARGO'
,p_display_order=>180
,p_column_identifier=>'M'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852835940776108210)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>190
,p_column_identifier=>'N'
,p_column_label=>unistr('Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836093180108211)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>200
,p_column_identifier=>'O'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836141420108212)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>210
,p_column_identifier=>'P'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836264933108213)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>220
,p_column_identifier=>'Q'
,p_column_label=>'Nome Centro de Custo'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836339195108214)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>230
,p_column_identifier=>'R'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Centro de Custo')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836480729108215)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>240
,p_column_identifier=>'S'
,p_column_label=>'Nome Cargo'
,p_column_html_expression=>'<nobr>#NOME_CARGO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836574699108216)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>250
,p_column_identifier=>'T'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Cargo')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836686742108217)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>260
,p_column_identifier=>'U'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852836755610108218)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>270
,p_column_identifier=>'V'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334829793304317)
,p_db_column_name=>'INSS'
,p_display_order=>280
,p_column_identifier=>'W'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854334924969304318)
,p_db_column_name=>'FGTS'
,p_display_order=>290
,p_column_identifier=>'X'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335091207304319)
,p_db_column_name=>'IR'
,p_display_order=>300
,p_column_identifier=>'Y'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335192368304320)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>310
,p_column_identifier=>'Z'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540094533339820)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>320
,p_column_identifier=>'AA'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802848682819135)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>330
,p_column_identifier=>'AB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802895548819136)
,p_db_column_name=>'ORIGEM'
,p_display_order=>340
,p_column_identifier=>'AC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30852853602007249710)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12096257'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:CLASS_CCUSTO:DESC_CLASS_CCUSTO:CARGO:NOME_CARGO:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MI'
||unistr('N:TOT_VALOR:ORIGEM:INSS:FGTS:IR:L\00EDquido:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30852870297159488594)
,p_plug_name=>'8 - Empresa / Centro de Custo'
,p_region_name=>'IR_8'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select g.ROWID,',
'     g.cod_empresa,',
'     g.nome_empresa,',
'',
'       g.cod_ccusto,',
'       g.nome_ccusto,',
'       g.class_ccusto,',
'       g.desc_class_ccusto,',
'',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR8 g',
'',
' LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_CCUSTO IS NULL OR g.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CCUSTO, '':'')) t))      ',
'  order by g.DATA_REF, g.COD_EMPRESA,  to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_CCUSTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'ECC'
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
 p_id=>wwv_flow_api.id(30852870351496488595)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209642447622278417
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852870495960488596)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852870526014488597)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852870625780488598)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852870765478488599)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852870901920488600)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852870945346488601)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852871085126488602)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852871142396488603)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852871285718488604)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852871490835488606)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852871516154488607)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852871823064488610)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852872078714488612)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Nome Centro de Custo'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852872180727488613)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Centro de Custo')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852872406503488616)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852872519739488617)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335263460304321)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335350287304322)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335429787304323)
,p_db_column_name=>'INCID_IR'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335563044304324)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539968940339819)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803048255819137)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803096568819138)
,p_db_column_name=>'ORIGEM'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30852897779033601027)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12096699'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:COD_GERENCIAL:NOME_COD_GERENCIAL:COD_OCORR:NOME_COD_OCORR:COD_CCUSTO:NOME_CCUSTO:CLASS_CCUSTO:DESC_CLASS_CCUSTO:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853136190460919286)
,p_plug_name=>'9 - Empresa / Cargo '
,p_region_name=>'IR_9'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'g.cod_empresa,',
'     g.nome_empresa,',
'     ',
'       g.cargo,',
'       g.nome_cargo,',
'       g.class_cargo,',
'       g.desc_class_cargo,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR9 g',
'',
'    LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'       ',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_CARGO  IS NULL OR g.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CARGO, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA,  to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_CARGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'ECAR'
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
 p_id=>wwv_flow_api.id(30853136265505919287)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209908361631709109
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136356895919288)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136489012919289)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136512534919290)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136680770919291)
,p_db_column_name=>'CARGO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136753403919292)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Nome Cargo'
,p_column_html_expression=>'<nobr>#NOME_CARGO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136814021919293)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853136950399919294)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Cargo')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137100782919295)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137195204919296)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137263286919297)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137304562919298)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137413260919299)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137601666919300)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137630627919301)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137707980919302)
,p_db_column_name=>'DATA_REF'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853137902982919303)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335693113304325)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335756482304326)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335837903304327)
,p_db_column_name=>'INCID_IR'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854335922189304328)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539808040339818)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803221121819139)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803364238819140)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853163320209067279)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12099355'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:CARGO:NOME_CARGO:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853137936412919304)
,p_plug_name=>'10 - Empresa / Categoria de Ccusto '
,p_region_name=>'IR_10'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.class_ccusto,',
'       g.desc_class_ccusto,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR10 g',
'',
'    LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'       ',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_CLASSCTO IS NULL OR g.class_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CLASSCTO, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA,  to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_CLASSCTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'ECATCCUS'
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
 p_id=>wwv_flow_api.id(30853138041012919305)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209910137138709127
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853138163605919306)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853138262019919307)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853138371114919308)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853138965147919314)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>90
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139009354919315)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'E'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139197979919316)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>110
,p_column_identifier=>'F'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139261738919317)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139316962919318)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139429869919319)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139579378919320)
,p_db_column_name=>'DATA_REF'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139604976919321)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>160
,p_column_identifier=>'K'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139710227919322)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>170
,p_column_identifier=>'L'
,p_column_label=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853139853358919323)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>180
,p_column_identifier=>'M'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854826847399772579)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>190
,p_column_identifier=>'O'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854826938904772580)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>200
,p_column_identifier=>'P'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827095301772581)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>210
,p_column_identifier=>'Q'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827116671772582)
,p_db_column_name=>'INCID_IR'
,p_display_order=>220
,p_column_identifier=>'R'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827209350772583)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>230
,p_column_identifier=>'S'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539740917339817)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>240
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803464512819141)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>250
,p_column_identifier=>'U'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803474980819142)
,p_db_column_name=>'ORIGEM'
,p_display_order=>260
,p_column_identifier=>'V'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853419297314921835)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12101914'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:CLASS_CCUSTO:DESC_CLASS_CCUSTO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853140034852919325)
,p_plug_name=>'11 - Empresa / Categoria de Cargo'
,p_region_name=>'IR_11'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.class_cargo,',
'       g.desc_class_cargo,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR11 g',
'',
'LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_CLASSCGO IS NULL OR g.class_cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CLASSCGO, '':'')) t))    ',
'  order by g.DATA_REF, g.COD_EMPRESA,  to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_CLASSCGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'ECATCAR'
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
 p_id=>wwv_flow_api.id(30853140133884919326)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1209912230010709148
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853140295870919327)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853140334716919328)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853427564661127979)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853427691720127980)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853427773803127981)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853427894686127982)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853427914452127983)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853428040017127984)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853428153998127985)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853428247268127986)
,p_db_column_name=>'DATA_REF'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853428365375127987)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853428732488127991)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>unistr('Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853428817137127992)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827322535772584)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827450519772585)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827560823772586)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827652177772587)
,p_db_column_name=>'INCID_IR'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827763181772588)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>210
,p_column_identifier=>'S'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539665792339816)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>220
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803631315819143)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>230
,p_column_identifier=>'U'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803697298819144)
,p_db_column_name=>'ORIGEM'
,p_display_order=>240
,p_column_identifier=>'V'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853437592389139461)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12102097'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853428918762127993)
,p_plug_name=>'12 - Empresa / Filial / Class Custo'
,p_region_name=>'IR_12'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.filial,',
'       g.nome_filial,',
'       g.class_ccusto,',
'       g.desc_class_ccusto,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR13 g',
'',
'LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'       ',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR g.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t)) ',
'   AND (:P50_CLASSCTO IS NULL OR g.class_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CLASSCTO, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA, g.FILIAL, to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CLASSCTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFCCCUS'
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
 p_id=>wwv_flow_api.id(30853429012302127994)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210201108427917816
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429201342127995)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429290406127996)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429366063127997)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429501966127998)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429576153127999)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429606539128000)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429761356128001)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429889282128002)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853429988293128003)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853430041254128004)
,p_db_column_name=>'DATA_REF'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853430202450128005)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853430562566128009)
,p_db_column_name=>'FILIAL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853430681134128010)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853430789512128011)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853430835787128012)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Centro de Custo')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827834120772589)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854827996427772590)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828096550772591)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828151071772592)
,p_db_column_name=>'INCID_IR'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828280238772593)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539507253339815)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803790614819145)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810803876181819146)
,p_db_column_name=>'ORIGEM'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853445080393201107)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12102172'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CLASS_CCUSTO:DESC_CLASS_CCUSTO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853430977276128013)
,p_plug_name=>'13 - Empresa / Filial / Cargo'
,p_region_name=>'IR_13'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.filial,',
'       g.nome_filial,',
'       g.cargo,',
'       g.nome_cargo,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR14 g',
'',
' LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR g.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))',
'   AND (:P50_CARGO  IS NULL OR g.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CARGO, '':'')) t))   ',
'  order by  g.DATA_REF,  g.COD_EMPRESA,  g.FILIAL, to_number( g.COD_OCORR), to_number( g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CARGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFCAR'
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
 p_id=>wwv_flow_api.id(30853431012291128014)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210203108416917836
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431195423128015)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431243344128016)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431322131128017)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431457877128018)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431645118128020)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431803347128021)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431881915128022)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853431946339128023)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853432076129128024)
,p_db_column_name=>'DATA_REF'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853432185112128025)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853432367826128027)
,p_db_column_name=>'FILIAL'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853432469022128028)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853449367155252081)
,p_db_column_name=>'CARGO'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853449500190252082)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>'Nome Cargo'
,p_column_html_expression=>'<nobr>#NOME_CARGO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853449529928252083)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853449685189252084)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>'Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828352590772594)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828407587772595)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828543149772596)
,p_db_column_name=>'INCID_IR'
,p_display_order=>210
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828622743772597)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>220
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539455951339814)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>230
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804026383819147)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>240
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804086299819148)
,p_db_column_name=>'ORIGEM'
,p_display_order=>250
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853468523661384821)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12102407'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CARGO:NOME_CARGO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853449730246252085)
,p_plug_name=>'14 - Empresa / Filial / Class Cargo'
,p_region_name=>'IR_14'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.filial,',
'       g.nome_filial,',
'       g.class_cargo,',
'       g.desc_class_cargo,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR15 g',
'',
' LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR g.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))',
'   AND (:P50_CLASSCGO IS NULL OR g.class_cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CLASSCGO, '':'')) t))    ',
'  order by g.DATA_REF, g.COD_EMPRESA, g.FILIAL, to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CLASSCGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFCCAR'
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
 p_id=>wwv_flow_api.id(30853449833679252086)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210221929805041908
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853449991284252087)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450046518252088)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450106565252089)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450241430252090)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450345799252091)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450437042252092)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450580876252093)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450671191252094)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450706430252095)
,p_db_column_name=>'DATA_REF'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450862920252096)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853450941812252097)
,p_db_column_name=>'FILIAL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853451055943252098)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853451390782252101)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853451550404252103)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>unistr('Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853451614536252104)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853451761518252105)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828800040772598)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828845942772599)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854828997347772600)
,p_db_column_name=>'INCID_IR'
,p_display_order=>210
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829081640772601)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>220
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539320436339813)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>230
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804219113819149)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>240
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804351738819150)
,p_db_column_name=>'ORIGEM'
,p_display_order=>250
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853507065602877753)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12102792'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_OCORR:CLASS_CARGO:DESC_CLASS_CARGO:COD_GERENCIAL:NOME_COD_OCORR:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853451832793252106)
,p_plug_name=>'15 - Empresa / Filial / Obra, Ccusto'
,p_region_name=>'IR_15'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.filial,',
'       g.nome_filial,',
'       g.cod_tipo_mao_obra,',
'       g.desc_cod_tp_mao_obra,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR17 g',
'',
'   LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR g.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t)) ',
'   AND (:P50_CCUSTO IS NULL OR g.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CCUSTO, '':'')) t))  ',
'   AND (:P50_MAOBRA IS NULL OR g.cod_tipo_mao_obra IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_MAOBRA, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA, g.FILIAL, to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CCUSTO,P50_MAOBRA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFCMO'
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
 p_id=>wwv_flow_api.id(30853451993298252107)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210224089424041929
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452076942252108)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452128157252109)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452209373252110)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452359646252111)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452490527252112)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452544073252113)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452697677252114)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452802746252115)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452807941252116)
,p_db_column_name=>'DATA_REF'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853452917222252117)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853453062863252118)
,p_db_column_name=>'FILIAL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853453132732252119)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853453265413252120)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853453537421252123)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853453665818252124)
,p_db_column_name=>'COD_TIPO_MAO_OBRA'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>unistr('Tipo M\00E3o de Obra')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853453796763252125)
,p_db_column_name=>'DESC_COD_TP_MAO_OBRA'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Nome Tipo M\00E3o de Obra')
,p_column_html_expression=>'<nobr>#DESC_COD_TP_MAO_OBRA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829136332772602)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829302941772603)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829369725772604)
,p_db_column_name=>'INCID_IR'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829431238772605)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539210118339812)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804379335819151)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804542821819152)
,p_db_column_name=>'ORIGEM'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853854968396175471)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12106271'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_OCORR:COD_GERENCIAL:NOME_COD_OCORR:COD_TIPO_MAO_OBRA:DESC_COD_TP_MAO_OBRA:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853453842728252126)
,p_plug_name=>'16 - Empresa / Filial / Unidade_adm / CCusto '
,p_region_name=>'IR_16'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>170
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.filial,',
'       g.nome_filial,',
'       g.UNIDADE_ADM,',
'       g.DESC_UNIDADE_ADM,',
'       g.COD_CCUSTO,',
'       g.NOME_CCUSTO,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR18 g',
'  LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR g.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))',
'   AND (:P50_CCUSTO IS NULL OR g.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CCUSTO, '':'')) t)) ',
'   AND (:P50_UNIDADM IS NULL OR g.unidade_adm IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_UNIDADM, '':'')) t))      ',
'  order by g.DATA_REF, g.COD_EMPRESA, g.FILIAL, to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CCUSTO,P50_UNIDADM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFUCC'
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
 p_id=>wwv_flow_api.id(30853453929356252127)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210226025482041949
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853454052899252128)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853856781326212079)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853856815735212080)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853856968692212081)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857050319212082)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857121554212083)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857277520212084)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857326492212085)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857443205212086)
,p_db_column_name=>'DATA_REF'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857544755212087)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857660156212088)
,p_db_column_name=>'FILIAL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857747024212089)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857866287212090)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853857931986212091)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853858249424212094)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'Unidade Adm'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853858337760212095)
,p_db_column_name=>'DESC_UNIDADE_ADM'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Desc Unidade Adm'
,p_column_html_expression=>'<NOBR>#DESC_UNIDADE_ADM#</NOBR>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853858427246212096)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Cod Ccusto'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853858592502212097)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>180
,p_column_identifier=>'T'
,p_column_label=>'Nome Ccusto'
,p_column_html_expression=>'<NOBR>#NOME_CCUSTO#</NOBR>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829526424772606)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>190
,p_column_identifier=>'U'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829680947772607)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>200
,p_column_identifier=>'V'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829774721772608)
,p_db_column_name=>'INCID_IR'
,p_display_order=>210
,p_column_identifier=>'W'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829894264772609)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>220
,p_column_identifier=>'X'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539118328339811)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>230
,p_column_identifier=>'Y'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804671218819153)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>240
,p_column_identifier=>'Z'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804733782819154)
,p_db_column_name=>'ORIGEM'
,p_display_order=>250
,p_column_identifier=>'AA'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30853873568552443768)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12106457'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:UNIDADE_ADM:DESC_UNIDADE_ADM:COD_CCUSTO:NOME_CCUSTO:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_'
||'IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853858654388212098)
,p_plug_name=>'17 - Empresa / Local '
,p_region_name=>'IR_17'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>180
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.local_trab,',
'       g.desc_local_trab,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR19 g',
'',
'  LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_LOCAL IS NULL OR g.local_trab IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_LOCAL, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA,  to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_LOCAL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EL'
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
 p_id=>wwv_flow_api.id(30853858765923212099)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210630862049001921
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853858814462212100)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853858969695212101)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859064572212102)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859171266212103)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859220647212104)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859345997212105)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859454355212106)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859525315212107)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859633216212108)
,p_db_column_name=>'DATA_REF'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853859801181212109)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853860070600212112)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853860165535212113)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853860636212212118)
,p_db_column_name=>'LOCAL_TRAB'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>'Local Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853860758650212119)
,p_db_column_name=>'DESC_LOCAL_TRAB'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>'Nome Local Trabalho'
,p_column_html_expression=>'<nobr>#DESC_LOCAL_TRAB#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854829955582772610)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830049382772611)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830170773772612)
,p_db_column_name=>'INCID_IR'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830220493772613)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165539049813339810)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804852146819155)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810804891532819156)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30854327392464224606)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12110995'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:LOCAL_TRAB:DESC_LOCAL_TRAB:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30853860819283212120)
,p_plug_name=>unistr('18 - Empresa / Unidade de Neg\00F3cio')
,p_region_name=>'IR_18'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>190
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT g.rowid,',
'       g.cod_empresa,',
'       g.nome_empresa, ',
'       g.cod_un_negocio,',
'       g.nome_un_negocio,',
'       g.cod_ocorr,',
'       g.nome_cod_ocorr,',
'       g.cod_gerencial,',
'       upper(g.nome_cod_gerencial) nome_cod_gerencial,',
'       g.qtde_func,',
'       g.tot_horas,',
'       g.tot_min,',
'       g.data_ref,',
'       g.tot_valor,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,g.horas_ferias',
unistr('     ,(DECODE(g.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'FROM TB_OCORR20 g',
'',
'  LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = g.cod_empresa',
'       AND a.cod = g.cod_ocorr',
'       ',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(g.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND g.cod_empresa = :P50_EMPRESA',
'   AND (:P50_UNIDNEG IS NULL OR g.cod_un_negocio IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_UNIDNEG, '':'')) t))   ',
'  order by g.DATA_REF, g.COD_EMPRESA,  to_number(g.COD_OCORR), to_number(g.COD_GERENCIAL)',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_UNIDNEG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EU'
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
 p_id=>wwv_flow_api.id(30853860930345212121)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1210633026471001943
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861024178212122)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861141195212123)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861254366212124)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861350638212125)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#<nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861491126212126)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861517878212127)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30853861604657212128)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331099770304279)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331194570304280)
,p_db_column_name=>'DATA_REF'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331235866304281)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331345952304282)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331428474304283)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331733169304286)
,p_db_column_name=>'COD_UN_NEGOCIO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Unidade de Neg\00F3cio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854331852395304287)
,p_db_column_name=>'NOME_UN_NEGOCIO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Nome Unidade de Neg\00F3cio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830324990772614)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830462455772615)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830582652772616)
,p_db_column_name=>'INCID_IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854830696164772617)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165538933558339809)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805006821819157)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805150847819158)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30854341227243319139)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12111134'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:COD_EMPRESA:NOME_EMPRESA:COD_UN_NEGOCIO:NOME_UN_NEGOCIO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32038749817952298283)
,p_plug_name=>'2 - Empresa, Filial'
,p_region_name=>'IR_2'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.ROWID,',
'       t.COD_EMPRESA  as EMPRESA,',
'       t.NOME_EMPRESA,',
'       t.FILIAL as FILIAL,',
'       t.NOME_FILIAL,',
'       t.COD_OCORR as OCORRENCIA,',
'       t.NOME_COD_OCORR,',
'       t.COD_GERENCIAL as GERENCIAL,',
'       UPPER(t.NOME_COD_GERENCIAL) NOME_COD_GERENCIAL,',
'       t.QTDE_FUNC,',
'       t.TOT_HORAS,',
'       t.TOT_MIN,',
'       t.DATA_REF,',
'       t.TOT_VALOR,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,t.horas_ferias',
unistr('     ,(DECODE(t.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  from TB_OCORR2 t',
'  ',
'      LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = t.cod_empresa',
'       AND a.cod = t.cod_ocorr',
'       ',
'  WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(t.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND t.cod_empresa = :P50_EMPRESA   ',
'   AND (:P50_FILIAL IS NULL OR t.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))',
'  order by t.DATA_REF, t.COD_EMPRESA,t.FILIAL, to_number(t.COD_OCORR), to_number(t.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EF'
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
 p_id=>wwv_flow_api.id(32038750046039298285)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>2395522142165088107
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851992063960950464)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851992427708950464)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851992866758950465)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851993281839950465)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851993674705950465)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851994095229950465)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727242533763909)
,p_db_column_name=>'EMPRESA'
,p_display_order=>140
,p_column_identifier=>'K'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727341064763910)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>150
,p_column_identifier=>'L'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727416751763911)
,p_db_column_name=>'FILIAL'
,p_display_order=>160
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727522469763912)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>170
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727653059763913)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>180
,p_column_identifier=>'O'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727712880763914)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>190
,p_column_identifier=>'P'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727843199763915)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>200
,p_column_identifier=>'Q'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332506931304294)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>210
,p_column_identifier=>'R'
,p_column_label=>'Ocorrencia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332673047304295)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>220
,p_column_identifier=>'S'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332769910304296)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>230
,p_column_identifier=>'T'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332893797304297)
,p_db_column_name=>'INCID_IR'
,p_display_order=>240
,p_column_identifier=>'U'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332945142304298)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>250
,p_column_identifier=>'V'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540598499339825)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>260
,p_column_identifier=>'W'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810801794740819125)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>270
,p_column_identifier=>'X'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810801928438819126)
,p_db_column_name=>'ORIGEM'
,p_display_order=>280
,p_column_identifier=>'Y'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(32059779496022888890)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12087681'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:GERENCIAL:NOME_COD_GERENCIAL:OCORRENCIA:NOME_COD_OCORR:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32059770737168869853)
,p_plug_name=>'1 - Empresa'
,p_region_name=>'IR_1'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT t.ROWID,',
'       t.COD_EMPRESA AS EMPRESA,',
'       t.NOME_EMPRESA,',
'       t.COD_OCORR AS OCORRENCIA,',
'       t.NOME_COD_OCORR,',
'       t.COD_GERENCIAL AS GERENCIAL,',
'       UPPER(t.NOME_COD_GERENCIAL) NOME_COD_GERENCIAL,',
'       t.QTDE_FUNC,',
'       t.TOT_HORAS,',
'       t.TOT_MIN,',
'       t.DATA_REF,',
'       t.TOT_VALOR,',
'       a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'       DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,t.horas_ferias',
unistr('     ,(DECODE(t.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem              '),
'  FROM TB_OCORR4 t',
'  LEFT JOIN ocorr_pagto a',
'         ON a.cod_empresa = t.cod_empresa',
'        AND a.cod         = t.cod_ocorr',
' WHERE ((',
'         :P50_DATA_REF IS NOT NULL',
'         AND TO_CHAR(t.DATA_REF, ''MM/YYYY'') IN (',
'               SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'                 FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'         )',
'       ) OR :P50_DATA_REF IS NULL)',
'   AND t.cod_empresa = :P50_EMPRESA    ',
' ORDER BY t.DATA_REF, t.COD_EMPRESA, TO_NUMBER(t.COD_OCORR), TO_NUMBER(t.COD_GERENCIAL)'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'E'
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
 p_id=>wwv_flow_api.id(32059770899162869855)
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>2416542995288659677
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851987328017950456)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851987728491950458)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851988175196950458)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851988552959950458)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851988958447950458)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851989339437950458)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727933262763916)
,p_db_column_name=>'EMPRESA'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852728098314763917)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852728141718763918)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852728248240763919)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>130
,p_column_identifier=>'N'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852728396225763920)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332040335304289)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Ocorrencia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332133410304290)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>160
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332275831304291)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332379339304292)
,p_db_column_name=>'INCID_IR'
,p_display_order=>180
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854332426634304293)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>190
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540687827339826)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>200
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810801601139819123)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>210
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810801704372819124)
,p_db_column_name=>'ORIGEM'
,p_display_order=>220
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(32059822942144089137)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12087630'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:EMPRESA:NOME_EMPRESA:GERENCIAL:NOME_COD_GERENCIAL:OCORRENCIA:NOME_COD_OCORR:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCID_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(33267368897525853050)
,p_plug_name=>'3 - Empresa, Filial, CCusto'
,p_region_name=>'IR_3'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select t.ROWID,',
'       t.COD_EMPRESA as EMPRESA,',
'       t.NOME_EMPRESA as NOME_EMPRESA,',
'       t.FILIAL as FILIAL,',
'       t.NOME_FILIAL as NOME_FILIAL,',
'       t.COD_CCUSTO as CENTRO_DE_CUSTO,',
'       t.NOME_CCUSTO as NOME_CCUSTO,',
'       t.CLASS_CCUSTO as CLASSIFICACAO_CENTRO_DE_CUSTO,',
'       t.DESC_CLASS_CCUSTO as NOME_CLASS_CCUSTO,',
'       t.COD_OCORR as OCORRENCIA,',
'       t.NOME_COD_OCORR AS NOME_COD_OCORR,',
'       t.COD_GERENCIAL as GERENCIAL,',
'       UPPER(t.NOME_COD_GERENCIAL) AS NOME_GERENCIAL,',
'       t.QTDE_FUNC,',
'       t.TOT_HORAS,',
'       t.TOT_MIN,',
'       t.DATA_REF,',
'       t.TOT_VALOR,',
'       t.DT_ATUALIZACAO,',
'       t.USUARIO,',
'        a.incid_iapas,',
'       a.incid_fgts,',
'       a.incid_ir,',
'       a.incid_liq,',
'        DECODE(a.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,t.horas_ferias',
unistr('     ,(DECODE(t.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  from TB_OCORR1 t',
'    LEFT JOIN ocorr_pagto a',
'        ON a.cod_empresa = t.cod_empresa',
'       AND a.cod = t.cod_ocorr',
' WHERE ((',
'        :P50_DATA_REF IS NOT NULL',
'        AND TO_CHAR(t.DATA_REF, ''MM/YYYY'') IN (',
'              SELECT TO_CHAR(TO_DATE(column_value, ''DD/MM/YYYY''), ''MM/YYYY'')',
'              FROM TABLE(apex_string.split(:P50_DATA_REF, '':'')) t',
'        )',
'      ) OR :P50_DATA_REF IS  NULL)',
'   AND t.cod_empresa = :P50_EMPRESA',
'   AND (:P50_FILIAL IS NULL OR t.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t)) ',
'   AND (:P50_CCUSTO IS NULL OR t.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_CCUSTO, '':'')) t))   ',
'  order by t.DATA_REF, t.COD_EMPRESA,t.FILIAL,t.COD_CCUSTO, to_number(t.COD_OCORR), to_number(t.COD_GERENCIAL)',
'  ',
'',
'  '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P50_EMPRESA,P50_FILIAL,P50_CCUSTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P50_OCORRENCIA'
,p_plug_display_when_cond2=>'EFCC'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(33267369312661853050)
,p_name=>unistr('Relat\00F3rio 1')
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>3624141408787642872
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851999547892950467)
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
 p_id=>wwv_flow_api.id(30852001184723950467)
,p_db_column_name=>'DATA_REF'
,p_display_order=>10
,p_column_identifier=>'Q'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851999908024950467)
,p_db_column_name=>'QTDE_FUNC'
,p_display_order=>110
,p_column_identifier=>'N'
,p_column_label=>unistr('Quantidade Funcion\00E1rios')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852000305194950467)
,p_db_column_name=>'TOT_HORAS'
,p_display_order=>120
,p_column_identifier=>'O'
,p_column_label=>'Unidade 1'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852000802825950467)
,p_db_column_name=>'TOT_MIN'
,p_display_order=>130
,p_column_identifier=>'P'
,p_column_label=>'Unidade 2'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852001583581950467)
,p_db_column_name=>'TOT_VALOR'
,p_display_order=>140
,p_column_identifier=>'R'
,p_column_label=>'Total Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852001955555950467)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>150
,p_column_identifier=>'S'
,p_column_label=>'Dt Atualizacao'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852002391867950468)
,p_db_column_name=>'USUARIO'
,p_display_order=>160
,p_column_identifier=>'T'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30851998351626950467)
,p_db_column_name=>'CLASSIFICACAO_CENTRO_DE_CUSTO'
,p_display_order=>170
,p_column_identifier=>'X'
,p_column_label=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_column_html_expression=>'<nobr>#CLASSIFICACAO_CENTRO_DE_CUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726210937763899)
,p_db_column_name=>'EMPRESA'
,p_display_order=>200
,p_column_identifier=>'AB'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726331944763900)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>210
,p_column_identifier=>'AC'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726429813763901)
,p_db_column_name=>'FILIAL'
,p_display_order=>220
,p_column_identifier=>'AD'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726563502763902)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>230
,p_column_identifier=>'AE'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726666477763903)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>240
,p_column_identifier=>'AF'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726731431763904)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>250
,p_column_identifier=>'AG'
,p_column_label=>'Nome Centro de Custo'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726879117763905)
,p_db_column_name=>'NOME_CLASS_CCUSTO'
,p_display_order=>260
,p_column_identifier=>'AH'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Centro de Custo')
,p_column_html_expression=>'<nobr>#NOME_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852726980589763906)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>270
,p_column_identifier=>'AI'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727090035763907)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>280
,p_column_identifier=>'AJ'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30852727129292763908)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>290
,p_column_identifier=>'AK'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333041730304299)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>300
,p_column_identifier=>'AL'
,p_column_label=>'Ocorrencia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333174251304300)
,p_db_column_name=>'INCID_IAPAS'
,p_display_order=>310
,p_column_identifier=>'AM'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333257319304301)
,p_db_column_name=>'INCID_FGTS'
,p_display_order=>320
,p_column_identifier=>'AN'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333344359304302)
,p_db_column_name=>'INCID_IR'
,p_display_order=>330
,p_column_identifier=>'AO'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30854333435195304303)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>340
,p_column_identifier=>'AP'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23165540405578339824)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>350
,p_column_identifier=>'AQ'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802060951819127)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>360
,p_column_identifier=>'AR'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810802147151819128)
,p_db_column_name=>'ORIGEM'
,p_display_order=>370
,p_column_identifier=>'AS'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(33267378736109853538)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12087748'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_REF:EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CENTRO_DE_CUSTO:NOME_CCUSTO:CLASSIFICACAO_CENTRO_DE_CUSTO:NOME_CLASS_CCUSTO:GERENCIAL:NOME_GERENCIAL:OCORRENCIA:NOME_COD_OCORR:TIPO_RUBRICA:QTDE_FUNC:TOT_HORAS:TOT_MIN:TOT_VALOR:ORIGEM:INCID_IAPAS:INCI'
||'D_FGTS:INCID_IR:INCID_LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(67715688918641114022)
,p_plug_name=>unistr('Consolida\00E7\00E3o do Hist\00F3rico Financeiro')
,p_icon_css_classes=>'fa-code-group'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--noPadding:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(57485012599711710891)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('<p><i>Consolida\00E7\00E3o do Hist\00F3rico Financeiro</i></p>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(194491521594005209084)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(57485014174799710894)
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426429866873151309)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(30851015012533129617)
,p_button_name=>'IA_4'
,p_button_static_id=>'BTN_IA_4'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'IA'
,p_button_position=>'BELOW_BOX'
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430313100151314)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(30853136190460919286)
,p_button_name=>'IA_9'
,p_button_static_id=>'BTN_IA_9'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'IA'
,p_button_position=>'BELOW_BOX'
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426431111992151322)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(30853858654388212098)
,p_button_name=>'IA_17'
,p_button_static_id=>'BTN_IA_17'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'IA'
,p_button_position=>'BELOW_BOX'
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30852004550117950469)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(57485035140117710938)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
,p_button_cattributes=>'style=''margin-top:20px;'''
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30852003878061950468)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(67715688918641114022)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.:RP,50:P50_PESQUISA:'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426428492394151296)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(32059770737168869853)
,p_button_name=>'IA_1'
,p_button_static_id=>'BTN_IA_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426429618444151307)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(32038749817952298283)
,p_button_name=>'IA_2'
,p_button_static_id=>'BTN_IA_2'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426429688094151308)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(33267368897525853050)
,p_button_name=>'IA_3'
,p_button_static_id=>'BTN_IA_3'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426429980928151310)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(30852815628960043679)
,p_button_name=>'IA_5'
,p_button_static_id=>'BTN_IA_5'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430051914151311)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(30852819409415043717)
,p_button_name=>'IA_6'
,p_button_static_id=>'BTN_IA_6'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430149413151312)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(30852833964699108190)
,p_button_name=>'IA_7'
,p_button_static_id=>'BTN_IA_7'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430287354151313)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(30852870297159488594)
,p_button_name=>'IA_8'
,p_button_static_id=>'BTN_IA_8'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430446839151315)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(30853137936412919304)
,p_button_name=>'IA_10'
,p_button_static_id=>'BTN_IA_10'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430575801151316)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(30853140034852919325)
,p_button_name=>'IA_11'
,p_button_static_id=>'BTN_IA_11'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430660189151317)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(30853428918762127993)
,p_button_name=>'IA_12'
,p_button_static_id=>'BTN_IA_12'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430736656151318)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(30853430977276128013)
,p_button_name=>'IA_13'
,p_button_static_id=>'BTN_IA_13'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430860313151319)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(30853449730246252085)
,p_button_name=>'IA_14'
,p_button_static_id=>'BTN_IA_14'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430950972151320)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(30853451832793252106)
,p_button_name=>'IA_15'
,p_button_static_id=>'BTN_IA_15'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426430997771151321)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(30853453842728252126)
,p_button_name=>'IA_16'
,p_button_static_id=>'BTN_IA_16'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426431193469151323)
,p_button_sequence=>180
,p_button_plug_id=>wwv_flow_api.id(30853860819283212120)
,p_button_name=>'IA_18'
,p_button_static_id=>'BTN_IA_18'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
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
 p_id=>wwv_flow_api.id(8036754770307145986)
,p_name=>'P50_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'FILIAIS'
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT f.cod_filial||''-''||f.nome_filial det',
'      ,f.cod_filial                     ret',
'  FROM filiais f',
' WHERE f.cod_empresa = :P50_EMPRESA',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P50_EMPRESA'
,p_ajax_items_to_submit=>'P50_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
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
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8036759780897184223)
,p_name=>'P50_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'EMPRESA'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COPY OF LOV_EMPRESAS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT e.cod||'' - ''||e.nome dsc',
'      ,e.cod                ret',
'  FROM empresas e',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330277295690101)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Empresas'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8036764062693208623)
,p_name=>'P50_CCUSTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'CENTROS DE CUSTO'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.nome det',
'      ,x.cod              ret',
'  FROM centro_de_custo x',
' WHERE x.cod_empresa = :P50_EMPRESA',
'   AND (x.cod = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P50_EMPRESA'
,p_ajax_items_to_submit=>'P50_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
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
 p_id=>wwv_flow_api.id(8036789688520516601)
,p_name=>'P50_CODAUX'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037161250922564457)
,p_name=>'P50_UNIDADM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'UNID. ADMINISTRATIVAS'
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P50_FILIAL,'':'') > 0 OR :P50_FILIAL IS NULL THEN ''[''||x.cod_filial||''] ''||x.cod_unidade_adm||''-''||x.descricao',
'          ELSE x.cod_unidade_adm||''-''||x.descricao END) det',
'      ,x.cod_unidade_adm                   ret',
'  FROM unidade_administrativa x',
' WHERE x.cod_empresa = :P50_EMPRESA ',
'   AND (:P50_FILIAL IS NULL OR x.cod_filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P50_FILIAL, '':'')) t))',
'   AND (x.cod_unidade_adm = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P50_FILIAL'
,p_ajax_items_to_submit=>'P50_FILIAL,P50_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Unidades Administrativas'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037167734276609788)
,p_name=>'P50_DIVISAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>unistr('DIVIS\00D5ES')
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_divisao||''-''||x.descricao det',
'      ,x.cod_divisao                   ret',
'  FROM divisao x',
' WHERE (x.cod_divisao = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Divis\00F5es')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037251822810679327)
,p_name=>'P50_REGIONAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'REGIONAIS'
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_regional||''-''||x.descricao det',
'      ,x.cod_regional                   ret',
'  FROM regional x',
' WHERE (x.cod_regional = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2; '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Regionais'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037280312095714204)
,p_name=>'P50_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'CARGOS'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.nome det',
'      ,x.cod              ret',
'  FROM cargos x',
' WHERE (x.cod = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
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
 p_id=>wwv_flow_api.id(8037406439285817466)
,p_name=>'P50_CLASSCTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'CATEGORIAS C.CUSTO'
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.descricao det',
'      ,x.cod                   ret',
'  FROM class_ccusto x',
' WHERE (x.cod = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Categorias de C.Custo'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037500430187834505)
,p_name=>'P50_CLASSCGO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'CATEGORIAS CARGOS'
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.descricao det',
'      ,x.cod                   ret',
'  FROM class_cargo x',
' WHERE (x.cod = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Categorias de Cargos'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037508521570902123)
,p_name=>'P50_MAOBRA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>unistr('TIPOS M\00C3O DE OBRA')
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:D - Direta;D,I - Indireta;I'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Tipos M\00E3o de Obra')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037527139207160810)
,p_name=>'P50_LOCAL'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>'LOCAIS TRABALHO'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_local_trab||''-''||x.descricao det',
'      ,x.cod_local_trab                   ret',
'  FROM local_trab x',
' WHERE (x.cod_local_trab = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2; '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Locais de Trabalho'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8037531759573183049)
,p_name=>'P50_UNIDNEG'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>unistr('UNID. NEG\00D3CIOS')
,p_placeholder=>'-  Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_un_negocio||''-''||x.nome_un_negocio det',
'      ,x.cod_un_negocio                         ret',
'  FROM unidade_de_negocio x',
' WHERE x.cod_empresa = :P50_EMPRESA',
'   AND (x.cod_un_negocio = :P50_CODAUX OR :P50_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P50_EMPRESA'
,p_ajax_items_to_submit=>'P50_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Unidades de Neg\00F3cio')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426428621604151297)
,p_name=>'P50_FLG'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426428704313151298)
,p_name=>'P50_MSG'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426428860619151299)
,p_name=>'P50_STATIC_ID_IR'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426429399568151305)
,p_name=>'P50_USER_PROMT'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30852004987074950469)
,p_name=>'P50_OCORRENCIA'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>unistr('HIST\00D3RICO POR:')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>unistr('STATIC2(,):EmpresaEEmpresa, FilialEFEmpresa, Filial, CCustoEFCCEmpresa, Filial, Unid. Adm.EFUAEmpresa, Divis\00E3oEDEmpresa, Regional EREmpresa, Filial, Ccusto, Cargo EFCCCAREmpresa, Centro de Custo ECCEmpresa, Cargo ECAREmpresa, Cate')
||'goria de Ccusto ECATCCUSEmpresa, Categoria de CargoECATCAREmpresa, Filial, Class CustoEFCCCUSEmpresa, Filial, Cargo EFCAREmpresa, Filial, Class Cargo EFCCAREmpresa, Filial, Obra, CcustoEFCMOEmpresa, Filial, Unidade adm, CCusto EFUCCEmpr'
||unistr('esa, LocalELEmpresa, Unidade de Neg\00F3cioEU')
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>unistr('Consolida\00E7\00E3o de Ocorr\00EAncias por:')
,p_attribute_08=>'500'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30852005367293950470)
,p_name=>'P50_PESQUISA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30852338431456801271)
,p_name=>'P50_DATA_REF'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(194491521594005209084)
,p_prompt=>unistr('PER\00CDODOS')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select display, data_ref',
'  from list_hist_finan_datas',
' where trunc(data_ref,''month'') >= add_months(trunc(sysdate,''month''),-61)',
'order by 2 desc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(48170330020142690098)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8036760090182186533)
,p_validation_name=>'Valida Empresa'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P50_OCORRENCIA IS NOT NULL THEN',
'    IF :P50_EMPRESA IS NULL THEN',
'      vReturn := ''EMPRESA deve ser informada!'';',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(8036759780897184223)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30852008249442950478)
,p_name=>unistr('Editar Relat\00F3rio - Caixa de Di\00E1logo Fechada 1')
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(33267368897525853050)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30852008707728950478)
,p_event_id=>wwv_flow_api.id(30852008249442950478)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(33267368897525853050)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30852007342575950477)
,p_name=>unistr('Editar Relat\00F3rio - Caixa de Di\00E1logo Fechada 2')
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(32038749817952298283)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30852007806348950478)
,p_event_id=>wwv_flow_api.id(30852007342575950477)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(32038749817952298283)
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30851013176871129598)
,p_name=>unistr('Editar Relat\00F3rio - Caixa de Di\00E1logo Fechada 3')
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(32059770737168869853)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30851013230794129599)
,p_event_id=>wwv_flow_api.id(30851013176871129598)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(32059770737168869853)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30852009134204950478)
,p_name=>'Pesquisar'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(30852004550117950469)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30852010197208950478)
,p_event_id=>wwv_flow_api.id(30852009134204950478)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_PESQUISA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30852009645855950478)
,p_event_id=>wwv_flow_api.id(30852009134204950478)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28426429155233151302)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>60
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28426429261191151303)
,p_event_id=>wwv_flow_api.id(28426429155233151302)
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
'  apex.item("P50_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P50_USER_PROMPT").setValue("Analise os dados da consolida\00E7\00E3o do hist\00F3rico financeiro a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28426429352509151304)
,p_event_id=>wwv_flow_api.id(28426429155233151302)
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
'  v_region_static_id varchar2(100) := :P50_STATIC_ID_IR; --''IR_REGION'';',
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
'  v_user_prompt := :P50_USER_PROMPT;  --''Analise os dados a seguir.'';',
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
'  :p50_flg := v_status;',
'  :p50_msg := v_mensagem;',
'',
'END;'))
,p_attribute_02=>'P50_STATIC_ID_IR,P50_USER_PROMT'
,p_attribute_03=>'P50_FLG,P50_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(10813218015006995267)
,p_name=>unistr('Expandir IR ap\00F3s Pesquisa')
,p_event_sequence=>70
,p_condition_element=>'P50_PESQUISA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10813218462797995271)
,p_event_id=>wwv_flow_api.id(10813218015006995267)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'document.querySelectorAll(''button[aria-label="Maximizar"]'').forEach(function(btn) {',
'    if (btn.getAttribute(''aria-expanded'') === ''false'') {',
'        btn.click();',
'    }',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8036754974492153746)
,p_name=>'Show Hide Filtros'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034967181086788075)
,p_event_id=>wwv_flow_api.id(8036754974492153746)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_EMPRESA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8036755663764153750)
,p_event_id=>wwv_flow_api.id(8036754974492153746)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_EMPRESA,P50_FILIAL,P50_CCUSTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034967409667788077)
,p_name=>'Show Hide Filtros EF'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EF,EFCC,EFUA,EFCCCAR,EFCCCUS,EFCAR,EFCCAR,EFCMO,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034967532763788078)
,p_event_id=>wwv_flow_api.id(8034967409667788077)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_FILIAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034967590820788079)
,p_event_id=>wwv_flow_api.id(8034967409667788077)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_FILIAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968051129788083)
,p_event_id=>wwv_flow_api.id(8034967409667788077)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_FILIAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034967686853788080)
,p_name=>'Show Hide Filtros EFCC'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCC,EFCCCAR,ECC,EFCMO,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034967851407788081)
,p_event_id=>wwv_flow_api.id(8034967686853788080)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CCUSTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034967886728788082)
,p_event_id=>wwv_flow_api.id(8034967686853788080)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CCUSTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968157719788084)
,p_event_id=>wwv_flow_api.id(8034967686853788080)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CCUSTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034968263577788085)
,p_name=>'Show Hide Filtros EFUA'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFUA,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968275554788086)
,p_event_id=>wwv_flow_api.id(8034968263577788085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_UNIDADM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968397091788087)
,p_event_id=>wwv_flow_api.id(8034968263577788085)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_UNIDADM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968547481788088)
,p_event_id=>wwv_flow_api.id(8034968263577788085)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_UNIDADM'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034968570547788089)
,p_name=>'Show Hide Filtros ED'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ED'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968760981788090)
,p_event_id=>wwv_flow_api.id(8034968570547788089)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_DIVISAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968786183788091)
,p_event_id=>wwv_flow_api.id(8034968570547788089)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_DIVISAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034968873189788092)
,p_event_id=>wwv_flow_api.id(8034968570547788089)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_DIVISAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034969022030788093)
,p_name=>'Show Hide Filtros ER'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ER'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969101487788094)
,p_event_id=>wwv_flow_api.id(8034969022030788093)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_REGIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969258527788095)
,p_event_id=>wwv_flow_api.id(8034969022030788093)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_REGIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969326635788096)
,p_event_id=>wwv_flow_api.id(8034969022030788093)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_REGIONAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034969416815788097)
,p_name=>'Show Hide Filtros EFCCCAR'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCCCAR,ECAR,EFCAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969545356788098)
,p_event_id=>wwv_flow_api.id(8034969416815788097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969636485788099)
,p_event_id=>wwv_flow_api.id(8034969416815788097)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969706352788100)
,p_event_id=>wwv_flow_api.id(8034969416815788097)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CARGO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034969846389788101)
,p_name=>'Show Hide Filtros ECATCCUS'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ECATCCUS,EFCCCUS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034969923785788102)
,p_event_id=>wwv_flow_api.id(8034969846389788101)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CLASSCTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970038078788103)
,p_event_id=>wwv_flow_api.id(8034969846389788101)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CLASSCTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970158673788104)
,p_event_id=>wwv_flow_api.id(8034969846389788101)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CLASSCTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034970233903788105)
,p_name=>'Show Hide Filtros ECATCAR'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ECATCAR,EFCCAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970308168788106)
,p_event_id=>wwv_flow_api.id(8034970233903788105)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CLASSCGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970402445788107)
,p_event_id=>wwv_flow_api.id(8034970233903788105)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CLASSCGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970516421788108)
,p_event_id=>wwv_flow_api.id(8034970233903788105)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_CLASSCGO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8034970586351788109)
,p_name=>'Show Hide Filtros EFCMO'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCMO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970752705788110)
,p_event_id=>wwv_flow_api.id(8034970586351788109)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_MAOBRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8034970788070788111)
,p_event_id=>wwv_flow_api.id(8034970586351788109)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_MAOBRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037509594675919162)
,p_event_id=>wwv_flow_api.id(8034970586351788109)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_MAOBRA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8037509664529919163)
,p_name=>'Show Hide Filtros EL'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037509822601919164)
,p_event_id=>wwv_flow_api.id(8037509664529919163)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_LOCAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037509929932919165)
,p_event_id=>wwv_flow_api.id(8037509664529919163)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_LOCAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037509982089919166)
,p_event_id=>wwv_flow_api.id(8037509664529919163)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_LOCAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8037510118269919167)
,p_name=>'Show Hide Filtros EU'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P50_OCORRENCIA'
,p_condition_element=>'P50_OCORRENCIA'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EU'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037510218689919168)
,p_event_id=>wwv_flow_api.id(8037510118269919167)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_UNIDNEG'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037510415433919170)
,p_event_id=>wwv_flow_api.id(8037510118269919167)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_UNIDNEG'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8037510328974919169)
,p_event_id=>wwv_flow_api.id(8037510118269919167)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P50_UNIDNEG'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990950000000000002)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_CONSOL_RESUMO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - resumo da folha (Natcorp_ConsolFolha.js). FONTE: brand/apex/app/NC_CONSOL_RESUMO.plsql.sql',
'   (guia CONSOLFOLHA-MANUTENCAO.md). Mude la e aplique de novo com aplicar-consolfolha-pagina50.py. SO LE: nao grava nada. */',
'declare',
'  l_ir     varchar2(30) := apex_application.g_x01;',
'  l_src    clob;',
'  l_sql    clob;',
'  l_ctx    apex_exec.t_context;',
'  l_passo  varchar2(40) := ''inicio'';',
'  l_ncol   pls_integer;',
'  type t_txt is table of varchar2(400) index by varchar2(400);',
'  type t_num is table of number index by varchar2(400);',
'  type t_lst is table of varchar2(400) index by pls_integer;',
'  col      t_lst;          /* as colunas da consulta, na ordem */',
'  papel    t_txt;          /* papel -> nome da coluna */',
'  usado    t_num;          /* nome da coluna -> 1 */',
'  niv_cod  t_lst;  niv_nom t_lst;  niv_rot t_lst;',
'  l_nniv   pls_integer := 0;',
'  por_rot  t_num;  qtd t_num;  rot t_txt;',
'  pes      t_num;          /* AAAAMM -> pessoas */',
'  l_dims   varchar2(32767);',
'  l_k      varchar2(400);',
'',
unistr('  /* a consulta de um relat\00F3rio pronta para virar subconsulta: sem o ";" (ou "/") do fim - o APEX'),
unistr('     aceita no relat\00F3rio, o Oracle n\00E3o aceita dentro de "select * from ( ... )" (ORA-00907, 13/10) - e'),
unistr('     com uma quebra de linha no fim, para um coment\00E1rio "--" na \00FAltima linha n\00E3o engolir o ")" */'),
'  function limpa(p clob) return clob is',
'  begin',
'    return regexp_replace(p, ''[[:space:];/]+$'', '''') || chr(10);',
'  end;',
'  function q(p varchar2) return varchar2 is begin return ''"'' || replace(p, ''"'', '''') || ''"''; end;',
'  function ix(p_dim varchar2, p_rot varchar2) return pls_integer is',
unistr('    r varchar2(400) := substr(nvl(p_rot, ''N\00E3o informado''), 1, 380);'),
'    n pls_integer;',
'  begin',
'    if not por_rot.exists(p_dim || ''|'' || r) then',
'      n := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;',
'      por_rot(p_dim || ''|'' || r) := n; rot(p_dim || ''#'' || n) := r; qtd(p_dim) := n + 1;',
'    end if;',
'    return por_rot(p_dim || ''|'' || r);',
'  end;',
'  /* o primeiro nome da lista que existe na consulta vira o papel */',
'  procedure acha(p_papel varchar2, p_nomes sys.odcivarchar2list) is',
'  begin',
'    for i in 1 .. p_nomes.count loop',
'      for j in 1 .. l_ncol loop',
'        if upper(col(j)) = upper(p_nomes(i)) and not usado.exists(col(j)) then',
'          papel(p_papel) := col(j); usado(col(j)) := 1; return;',
'        end if;',
'      end loop;',
'    end loop;',
'  end;',
'  function c(p_papel varchar2) return varchar2 is',
'  begin',
'    return case when papel.exists(p_papel) then ''x.'' || q(papel(p_papel)) else ''null'' end;',
'  end;',
'  function nome_nivel(p_col varchar2) return varchar2 is',
'    u varchar2(100) := upper(p_col);',
'  begin',
'    return case',
unistr('      when u like ''%CLASS%CARGO%'' then ''Classifica\00E7\00E3o do cargo'''),
unistr('      when u like ''%CLASS%C%CUSTO%'' or u like ''%CLASSIFICACAO%'' then ''Classifica\00E7\00E3o do c. custo'''),
'      when u like ''%FILIAL%'' then ''Filial''',
'      when u like ''%UNIDADE_ADM%'' then ''Unidade adm.''',
'      when u like ''%CCUSTO%'' or u like ''%CENTRO_DE_CUSTO%'' then ''Centro de custo''',
'      when u like ''%CARGO%'' then ''Cargo''',
unistr('      when u like ''%DIVISAO%'' then ''Divis\00E3o'''),
'      when u like ''%REGIONAL%'' then ''Regional''',
unistr('      when u like ''%MAO_OBRA%'' then ''M\00E3o de obra'''),
'      when u like ''%LOCAL%'' then ''Local de trabalho''',
unistr('      when u like ''%UN_NEGOCIO%'' then ''Unidade de neg\00F3cio'''),
'      else initcap(replace(p_col, ''_'', '' ''))',
'    end;',
'  end;',
'begin',
'  if l_ir is null or not regexp_like(l_ir, ''^IR_[0-9]{1,2}$'') then',
unistr('    htp.prn(''{"erro":"relat\00F3rio n\00E3o informado"}''); return;'),
'  end if;',
'',
unistr('  /* -- a consulta do relat\00F3rio que est\00E1 na tela -- */'),
'  l_passo := ''consulta'';',
'  select region_source into l_src',
'    from apex_application_page_regions',
'   where application_id = :APP_ID and page_id = :APP_PAGE_ID and static_id = l_ir;',
'  l_src := limpa(l_src);',
'',
'  /* -- as colunas (sem trazer linhas) -- */',
'  l_passo := ''colunas'';',
'  l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db,',
'                                        p_sql_query => ''select * from ('' || l_src || '') where 1 = 0'');',
'  l_ncol := apex_exec.get_column_count(l_ctx);',
'  for j in 1 .. l_ncol loop col(j) := apex_exec.get_column(l_ctx, j).name; end loop;',
'  apex_exec.close(l_ctx);',
'',
'  acha(''mes'',   sys.odcivarchar2list(''DATA_REF''));',
'  acha(''valor'', sys.odcivarchar2list(''TOT_VALOR''));',
'  acha(''qtde'',  sys.odcivarchar2list(''QTDE_FUNC''));',
'  acha(''tipo'',  sys.odcivarchar2list(''TIPO_RUBRICA''));',
'  acha(''orig'',  sys.odcivarchar2list(''ORIGEM''));',
unistr('  acha(''liq'',   sys.odcivarchar2list(''INCID_LIQ'', ''LIQUIDO'', ''L\00EDquido''));'),
'  acha(''rubc'',  sys.odcivarchar2list(''COD_OCORR'', ''OCORRENCIA''));',
'  acha(''rubn'',  sys.odcivarchar2list(''NOME_COD_OCORR''));',
'  acha(''catn'',  sys.odcivarchar2list(''NOME_COD_GERENCIAL'', ''NOME_GERENCIAL''));',
unistr('  /* o que n\00E3o \00E9 n\00EDvel */'),
'  for j in 1 .. l_ncol loop',
'    if upper(col(j)) in (''ROWID'', ''COD_EMPRESA'', ''EMPRESA'', ''NOME_EMPRESA'', ''COD_GERENCIAL'', ''GERENCIAL'', ''TOT_HORAS'', ''TOT_MIN'',',
'                         ''INCID_IAPAS'', ''INCID_FGTS'', ''INCID_IR'', ''INSS'', ''FGTS'', ''IR'', ''HORAS_FERIAS'', ''DT_ATUALIZACAO'', ''USUARIO'') then',
'      usado(col(j)) := 1;',
'    end if;',
'  end loop;',
'  if not papel.exists(''mes'') or not papel.exists(''valor'') then',
unistr('    htp.prn(''{"erro":"o relat\00F3rio '' || l_ir || '' n\00E3o tem DATA_REF e TOT_VALOR"}''); return;'),
'  end if;',
unistr('  /* os N\00CDVEIS: o que sobrou, aos pares (c\00F3digo, nome) */'),
'  declare j pls_integer := 1; begin',
'    while j <= l_ncol loop',
'      if not usado.exists(col(j)) then',
'        l_nniv := l_nniv + 1;',
'        niv_cod(l_nniv) := col(j);',
'        if j < l_ncol and not usado.exists(col(j + 1)) and regexp_like(upper(col(j + 1)), ''^(NOME|DESC)'') then',
'          niv_nom(l_nniv) := col(j + 1); j := j + 1;',
'        else niv_nom(l_nniv) := null;',
'        end if;',
'        niv_rot(l_nniv) := nome_nivel(niv_cod(l_nniv));',
'        l_dims := l_dims || '', x.'' || q(niv_cod(l_nniv));',
'      end if;',
'      j := j + 1;',
'    end loop;',
'  end;',
'',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''v'', 2);',
'  apex_json.write(''ir'', l_ir);',
'  apex_json.open_object(''cols'');',
'  declare l_ps sys.odcivarchar2list := sys.odcivarchar2list(''rubc'', ''rubn'', ''catn'', ''orig'', ''tipo''); begin',
'    for j in 1 .. l_ps.count loop',
'      if papel.exists(l_ps(j)) then apex_json.write(l_ps(j), papel(l_ps(j))); end if;',
'    end loop;',
'  end;',
'  apex_json.close_object;',
'',
unistr('  /* -- as verbas: m\00EAs x origem x tipo x incide no l\00EDquido x verba -- */'),
'  l_passo := ''verbas'';',
'  l_sql := ''select to_char('' || c(''mes'') || '', ''''YYYYMM'''') m, '' || c(''orig'') || '' o, '' || c(''tipo'') || '' t, nvl('' || c(''liq'') || '', ''''N'''') l, '' ||',
'           c(''rubc'') || '' || '''' - '''' || '' || c(''rubn'') || '' r, '' || c(''catn'') || '' g, sum('' || c(''valor'') || '') v, max('' || c(''qtde'') || '') p '' ||',
'           ''from ('' || l_src || '') x group by to_char('' || c(''mes'') || '', ''''YYYYMM''''), '' || c(''orig'') || '', '' || c(''tipo'') || '', nvl('' || c(''liq'') || '', ''''N''''), '' ||',
'           c(''rubc'') || '', '' || c(''rubn'') || '', '' || c(''catn'');',
'  l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => l_sql);',
'  apex_json.open_array(''rub'');',
'  while apex_exec.next_row(l_ctx) loop',
'    apex_json.open_array;',
'    apex_json.write(apex_exec.get_varchar2(l_ctx, 1));',
'    apex_json.write(ix(''origem'', nvl(apex_exec.get_varchar2(l_ctx, 2), ''Outras'')));',
'    apex_json.write(ix(''tipo'', nvl(apex_exec.get_varchar2(l_ctx, 3), ''Sem tipo'')));',
'    apex_json.write(case when apex_exec.get_varchar2(l_ctx, 4) = ''S'' then 1 else 0 end);',
'    apex_json.write(ix(''verba'', apex_exec.get_varchar2(l_ctx, 5)));',
'    apex_json.write(ix(''cat'', apex_exec.get_varchar2(l_ctx, 6)));',
'    apex_json.write(round(nvl(apex_exec.get_number(l_ctx, 7), 0), 2));',
'    apex_json.write(nvl(apex_exec.get_number(l_ctx, 8), 0));',
'    apex_json.close_array;',
'  end loop;',
'  apex_json.close_array;',
'  apex_exec.close(l_ctx);',
'',
unistr('  /* -- quem recebeu na Folha, por m\00EAs -- */'),
'  l_passo := ''pessoas'';',
'  l_sql := ''select m, sum(p) from (select to_char('' || c(''mes'') || '', ''''YYYYMM'''') m'' || l_dims || '', max('' || c(''qtde'') || '') p '' ||',
'           ''from ('' || l_src || '') x where '' || c(''orig'') || '' = ''''Folha'''' and '' || c(''tipo'') || '' = ''''Provento'''' '' ||',
'           ''group by to_char('' || c(''mes'') || '', ''''YYYYMM'''')'' || l_dims || '') group by m'';',
'  l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => l_sql);',
'  apex_json.open_object(''pessoas'');',
'  while apex_exec.next_row(l_ctx) loop',
'    apex_json.write(apex_exec.get_varchar2(l_ctx, 1), nvl(apex_exec.get_number(l_ctx, 2), 0));',
'  end loop;',
'  apex_json.close_object;',
'  apex_exec.close(l_ctx);',
'',
unistr('  /* -- cada n\00EDvel: ganhos, descontos e pessoas por membro e m\00EAs (os que incidem no l\00EDquido) -- */'),
'  l_passo := ''niveis'';',
'  apex_json.open_array(''niveis'');',
'  for n in 1 .. l_nniv loop',
'    apex_json.open_object;',
'    apex_json.write(''nome'', niv_rot(n));',
'    apex_json.write(''col'', niv_cod(n));',
'    apex_json.write(''colNome'', niv_nom(n));',
unistr('    /* por dentro: grupo do relat\00F3rio (todos os n\00EDveis) x m\00EAs; por fora: s\00F3 este n\00EDvel */'),
'    l_sql := ''select m, cod, nom, sum(g), sum(d), sum(p) from ('' ||',
'             ''select to_char('' || c(''mes'') || '', ''''YYYYMM'''') m, x.'' || q(niv_cod(n)) || '' cod, '' ||',
'             case when niv_nom(n) is not null then ''max(x.'' || q(niv_nom(n)) || '')'' else ''null'' end || '' nom'' ||',
'             '', sum(case when '' || c(''tipo'') || '' = ''''Provento'''' and nvl('' || c(''liq'') || '', ''''N'''') = ''''S'''' then '' || c(''valor'') || '' end) g'' ||',
'             '', sum(case when '' || c(''tipo'') || '' = ''''Desconto'''' and nvl('' || c(''liq'') || '', ''''N'''') = ''''S'''' then '' || c(''valor'') || '' end) d'' ||',
'             '', max(case when '' || c(''orig'') || '' = ''''Folha'''' and '' || c(''tipo'') || '' = ''''Provento'''' then '' || c(''qtde'') || '' end) p'' ||',
'             '' from ('' || l_src || '') x group by to_char('' || c(''mes'') || '', ''''YYYYMM'''')'' || l_dims ||',
'             '') group by m, cod, nom'';',
'    l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => l_sql);',
'    apex_json.open_array(''v'');',
'    while apex_exec.next_row(l_ctx) loop',
'      l_k := ''niv'' || n;',
'      apex_json.open_array;',
'      apex_json.write(ix(l_k, apex_exec.get_varchar2(l_ctx, 2) ||',
'                              case when apex_exec.get_varchar2(l_ctx, 3) is not null then '' - '' || apex_exec.get_varchar2(l_ctx, 3) end));',
'      apex_json.write(apex_exec.get_varchar2(l_ctx, 1));',
'      apex_json.write(round(nvl(apex_exec.get_number(l_ctx, 4), 0), 2));',
'      apex_json.write(round(nvl(apex_exec.get_number(l_ctx, 5), 0), 2));',
'      apex_json.write(nvl(apex_exec.get_number(l_ctx, 6), 0));',
'      apex_json.close_array;',
'    end loop;',
'    apex_json.close_array;',
'    apex_exec.close(l_ctx);',
'    apex_json.open_array(''membros'');',
'    if qtd.exists(''niv'' || n) then',
'      for i in 0 .. qtd(''niv'' || n) - 1 loop apex_json.write(rot(''niv'' || n || ''#'' || i)); end loop;',
'    end if;',
'    apex_json.close_array;',
'    apex_json.close_object;',
'  end loop;',
'  apex_json.close_array;',
'',
'  /* -- os nomes -- */',
'  apex_json.open_object(''nomes'');',
'  declare l_ks sys.odcivarchar2list := sys.odcivarchar2list(''origem'', ''tipo'', ''verba'', ''cat''); begin',
unistr('    for j in 1 .. l_ks.count loop                 /* la\00E7o na cole\00E7\00E3o: TABLE() aqui d\00E1 ORA-22905 nesta base */'),
'      apex_json.open_array(l_ks(j));',
'      if qtd.exists(l_ks(j)) then for i in 0 .. qtd(l_ks(j)) - 1 loop apex_json.write(rot(l_ks(j) || ''#'' || i)); end loop; end if;',
'      apex_json.close_array;',
'    end loop;',
'  end;',
'  apex_json.close_object;',
'  apex_json.close_object;',
'  l_sql := apex_json.get_clob_output;',
'  apex_json.free_output;',
'  declare p pls_integer := 1; t pls_integer := dbms_lob.getlength(l_sql); begin',
'    while p <= t loop htp.prn(dbms_lob.substr(l_sql, 8000, p)); p := p + 8000; end loop;',
'  end;',
'exception',
'  when others then',
'    begin apex_exec.close(l_ctx); exception when others then null; end;',
'    apex_json.free_output;',
'    htp.prn(''{"erro":"'' || apex_escape.json(sqlerrm || '' [passo: '' || l_passo || '']'') || ''"}'');',
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
