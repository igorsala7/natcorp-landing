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
--   Date and Time:   21:30 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 55
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00055
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>55);
end;
/
prompt --application/pages/page_00055
begin
wwv_flow_api.create_page(
 p_id=>55
,p_user_interface_id=>wwv_flow_api.id(57485040171637710988)
,p_name=>unistr('Comparativos de Hist\00F3ricos Financeiros')
,p_step_title=>unistr('Comparativos de Hist\00F3ricos Financeiros')
,p_autocomplete_on_off=>'OFF'
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
unistr('  // encontra <th> dentro da regi\00E3o pelo texto vis\00EDvel'),
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
'          if (valor === "SIM") {',
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
'  function processarTodasAsRegioes() {',
'    const regioes = document.querySelectorAll(''.t-IRR-region'');',
'    regioes.forEach(function (region) {',
'      aplicarIconesNaRegiao(region);',
'    });',
'  }',
'',
unistr('  // Roda ao carregar a p\00E1gina'),
'  document.addEventListener(''DOMContentLoaded'', function () {',
'    setTimeout(processarTodasAsRegioes, 120);',
'  });',
'',
unistr('  // Quando qualquer regi\00E3o com classe t-IRR-region for atualizada'),
'  apex.jQuery(document).on(''apexafterrefresh'', ''.t-IRR-region'', function (e) {',
'    const region = e.target;',
'    setTimeout(function () {',
'      aplicarIconesNaRegiao(region);',
'    }, 80);',
'  });',
'',
unistr('  // Se o script for injetado ap\00F3s DOM pronto'),
'  if (document.readyState === ''complete'' || document.readyState === ''interactive'') {',
'    setTimeout(processarTodasAsRegioes, 120);',
'  }',
'})();'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_step_template=>wwv_flow_api.id(57484998059769710817)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'365785'
,p_last_upd_yyyymmddhh24miss=>'20260528122617'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30856334232860202989)
,p_plug_name=>'2 - Empresa/Filial - EF'
,p_region_name=>'IR_2'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr2 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           --AND (x.filial     = :P55_FILIAL OR :P55_FILIAL IS NULL)',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr2 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           --AND (x.filial     = :P55_FILIAL OR :P55_FILIAL IS NULL)',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+) ',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EF'''
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
 p_id=>wwv_flow_api.id(30856334384033202990)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1213106480158992812
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335003262202996)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334422359202991)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335660435203003)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335729091203004)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335493854203001)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334554780202992)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334693125202993)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334800118202994)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334819581202995)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335048841202997)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335154756202998)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335222706202999)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335308347203000)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856335545757203002)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744710421577314)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744889276577315)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744993551577316)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859745093307577317)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10813964533263180817)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805415139819161)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805543580819162)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30856932074435944613)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12137042'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30856336614851203013)
,p_plug_name=>'3 - Empresa/Filial/CCusto - EFCC'
,p_region_name=>'IR_3'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.cod_ccusto, a.nome_ccusto',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cod_ccusto, x.nome_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr1 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))            ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cod_ccusto, x.nome_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr1 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.cod_ccusto    = b.cod_ccusto(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+) ',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_CCUSTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFCC'''
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
 p_id=>wwv_flow_api.id(30856336749048203014)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1213108845173992836
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337337158203020)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856336862782203015)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856338029978203027)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856338111991203028)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858721772305360479)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>'C.Custo'
,p_column_html_expression=>'<nobr>#COD_CCUSTO#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858721892202360480)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>'Nome Centro de Custo'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337836601203025)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856336930740203016)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337005909203017)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337144990203018)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337279108203019)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>110
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337458774203021)
,p_db_column_name=>'MES1'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337567836203022)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337633467203023)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337768727203024)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856337997709203026)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>160
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744359867577310)
,p_db_column_name=>'INSS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744468328577311)
,p_db_column_name=>'FGTS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744563007577312)
,p_db_column_name=>'IR'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744614472577313)
,p_db_column_name=>'LIQ'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814166439355709629)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805597424819163)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805717586819164)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858732032016367320)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12155042'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858722792844360489)
,p_plug_name=>'4 - Empresa/Filial/Unid. Adm. - EFUA'
,p_region_name=>'IR_4'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.unidade_adm, a.desc_unidade_adm',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.unidade_adm, x.desc_unidade_adm',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr3 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_UNIDADM IS NULL OR x.unidade_adm IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_UNIDADM, '':'')) t))            ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.unidade_adm, x.desc_unidade_adm',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr3 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (:P55_UNIDADM IS NULL OR x.unidade_adm IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_UNIDADM, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.unidade_adm   = b.unidade_adm(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+) ',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_UNIDADM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFUA'''
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
 p_id=>wwv_flow_api.id(30858722830538360490)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215494926664150312
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723471980360496)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858722943357360491)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858724168097360503)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858724272726360504)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858724538629360507)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>'<nobr>Unidade Adm.</nobr>'
,p_column_html_expression=>'<nobr>#UNIDADE_ADM#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858724695600360508)
,p_db_column_name=>'DESC_UNIDADE_ADM'
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>'<nobr>Nome Unidade Adm.</nobr>'
,p_column_html_expression=>'<nobr>#DESC_UNIDADE_ADM#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723922215360501)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723100954360492)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723180944360493)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723280800360494)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723342889360495)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>110
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723570002360497)
,p_db_column_name=>'MES1'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723661986360498)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723731574360499)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858723836510360500)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858724019188360502)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>160
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743914519577306)
,p_db_column_name=>'INSS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744077136577307)
,p_db_column_name=>'FGTS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744172218577308)
,p_db_column_name=>'IR'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859744276697577309)
,p_db_column_name=>'LIQ'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814166591095709630)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805808827819165)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805895644819166)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858771636300833874)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12155438'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:UNIDADE_ADM:DESC_UNIDADE_ADM:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858725233450360514)
,p_plug_name=>unistr('5 - Empresa/Divis\00E3o - ED')
,p_region_name=>'IR_5'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.cod_divisao, a.desc_cod_divisao',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.cod_divisao, x.desc_cod_divisao',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr5 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_DIVISAO IS NULL OR x.cod_divisao IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_DIVISAO, '':'')) t)) ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.cod_divisao, x.desc_cod_divisao',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr5 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_DIVISAO IS NULL OR x.cod_divisao IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_DIVISAO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.cod_divisao   = b.cod_divisao(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+) ',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_DIVISAO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''ED'''
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
 p_id=>wwv_flow_api.id(30858725403436360515)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215497499562150337
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858725915227360521)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858725475141360516)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858789513034979982)
,p_db_column_name=>'COD_DIVISAO'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>unistr('Divis\00E3o')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858789649074979983)
,p_db_column_name=>'DESC_COD_DIVISAO'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>unistr('<nobr>Nome Divis\00E3o</nobr>')
,p_column_html_expression=>'<nobr>#DESC_COD_DIVISAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858726436111360526)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858725600581360517)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858725635167360518)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858725764554360519)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858725858701360520)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858726039301360522)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858726169060360523)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858726221965360524)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858726324382360525)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858726518910360527)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743532797577302)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743674292577303)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743796228577304)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743810172577305)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814166643439709631)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810806024920819167)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810806091564819168)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858801615305009640)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12155738'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:COD_DIVISAO:DESC_COD_DIVISAO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858790541653979992)
,p_plug_name=>'6 - Empresa/Regional - ER'
,p_region_name=>'IR_6'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.cod_regional, a.desc_cod_regional',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.cod_regional, x.desc_cod_regional',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr6 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_REGIONAL IS NULL OR x.cod_regional IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_REGIONAL, '':'')) t)) ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.cod_regional, x.desc_cod_regional',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr6 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_REGIONAL IS NULL OR x.cod_regional IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_REGIONAL, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.cod_regional  = b.cod_regional(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+) ',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_REGIONAL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''ER'''
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
 p_id=>wwv_flow_api.id(30858790651309979993)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215562747435769815
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791267216979999)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858790784576979994)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858792108482980008)
,p_db_column_name=>'COD_REGIONAL'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Regional'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858792235833980009)
,p_db_column_name=>'DESC_COD_REGIONAL'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'<nobr>Nome Regional</nobr>'
,p_column_html_expression=>'<nobr>#DESC_COD_REGIONAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791712130980004)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858790814700979995)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858790965219979996)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791098449979997)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791170465979998)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791339040980000)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791447516980001)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791560806980002)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791613640980003)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858791857062980005)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743198357577298)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743215031577299)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743390634577300)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743486226577301)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814166786322709632)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810806222328819169)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810806360626819170)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858833599775166696)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12156057'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:COD_REGIONAL:DESC_COD_REGIONAL:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TIPO_RUBRICA:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858792870682980015)
,p_plug_name=>'7 - Empresa/Filial/CCusto/Cargo- EFCCCAR'
,p_region_name=>'IR_7'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.cod_ccusto, a.nome_ccusto, a.class_ccusto, a.desc_class_ccusto, a.cargo, a.nome_cargo, a.class_cargo, a.desc_class_cargo',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cod_ccusto, x.nome_ccusto, x.class_ccusto, x.desc_class_ccusto, x.cargo, x.nome_cargo, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr7 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))            ',
'           AND (:P55_CARGO  IS NULL OR x.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CARGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cod_ccusto, x.nome_ccusto, x.class_ccusto, x.desc_class_ccusto, x.cargo, x.nome_cargo, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr7 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))',
'           AND (:P55_CARGO  IS NULL OR x.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CARGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.cod_ccusto    = b.cod_ccusto(+)',
'   AND a.class_ccusto  = b.class_ccusto(+)',
'   AND a.cargo         = b.cargo(+)   ',
'   AND a.class_cargo   = b.class_cargo(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9,11,13,15;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_CCUSTO,P55_CARGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFCCCAR'''
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
 p_id=>wwv_flow_api.id(30858792965025980016)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215565061151769838
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793529178980022)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793004033980017)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918287813497481)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918397991497482)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918467140497483)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>'C.Custo'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918592289497484)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>'<nobr>Nome Centro de Custo</nobr>'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918606848497485)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>70
,p_column_identifier=>'Q'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918790105497486)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>80
,p_column_identifier=>'R'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918890119497487)
,p_db_column_name=>'CARGO'
,p_display_order=>90
,p_column_identifier=>'S'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858918915284497488)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>100
,p_column_identifier=>'T'
,p_column_label=>'Nome Cargo'
,p_column_html_expression=>'<nobr>#NOME_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919063170497489)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>110
,p_column_identifier=>'U'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o Cargo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919152097497490)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>120
,p_column_identifier=>'V'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o Cargo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858794011733980027)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793182842980018)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>140
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793230482980019)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>150
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793307157980020)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>160
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793425434980021)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>170
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793674228980023)
,p_db_column_name=>'MES1'
,p_display_order=>180
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793799074980024)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>190
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793849690980025)
,p_db_column_name=>'MES2'
,p_display_order=>200
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858793928370980026)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>210
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858794126740980028)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>220
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742753851577294)
,p_db_column_name=>'INSS'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742809327577295)
,p_db_column_name=>'FGTS'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742909815577296)
,p_db_column_name=>'IR'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859743082265577297)
,p_db_column_name=>'LIQ'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814166902135709633)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817715597518251621)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817715722831251622)
,p_db_column_name=>'ORIGEM'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858930136110564115)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12157023'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:CLASS_CCUSTO:DESC_CLASS_CCUSTO:CARGO:NOME_CARGO:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIG'
||'EM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858919255100497491)
,p_plug_name=>'8 - Empresa/CCusto- ECC'
,p_region_name=>'IR_8'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.cod_ccusto, a.nome_ccusto, a.class_ccusto, a.desc_class_ccusto',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.cod_ccusto, x.nome_ccusto, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr8 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))            ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.cod_ccusto, x.nome_ccusto, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr8 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.cod_ccusto    = b.cod_ccusto(+)',
'   AND a.class_ccusto  = b.class_ccusto(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_CCUSTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''ECC'''
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
 p_id=>wwv_flow_api.id(30858919334015497492)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215691430141287314
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919956424497498)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919445542497493)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920838349497507)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>50
,p_column_identifier=>'M'
,p_column_label=>'C.Custo'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920971366497508)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'N'
,p_column_label=>'<nobr>Nome Centro de Custo</nobr>'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858921070401497509)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>70
,p_column_identifier=>'O'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858921131764497510)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>80
,p_column_identifier=>'P'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920408814497503)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919587067497494)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>140
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919651746497495)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>150
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919724338497496)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>160
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858919876633497497)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>170
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920099282497499)
,p_db_column_name=>'MES1'
,p_display_order=>180
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920157938497500)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>190
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920288583497501)
,p_db_column_name=>'MES2'
,p_display_order=>200
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920388978497502)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>210
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858920588020497504)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>220
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742388634577290)
,p_db_column_name=>'INSS'
,p_display_order=>230
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742443545577291)
,p_db_column_name=>'FGTS'
,p_display_order=>240
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742572222577292)
,p_db_column_name=>'IR'
,p_display_order=>250
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742669913577293)
,p_db_column_name=>'LIQ'
,p_display_order=>260
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814166958603709634)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>270
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817715820121251623)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>280
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817715897095251624)
,p_db_column_name=>'ORIGEM'
,p_display_order=>290
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858940361012724926)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12157125'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:COD_CCUSTO:NOME_CCUSTO:CLASS_CCUSTO:DESC_CLASS_CCUSTO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858921622700497515)
,p_plug_name=>'9 - Empresa/Cargo - ECAR'
,p_region_name=>'IR_9'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.cargo, a.nome_cargo, a.class_cargo, a.desc_class_cargo',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.cargo, x.nome_cargo, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr9 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CARGO IS NULL OR x.cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CARGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.cargo, x.nome_cargo, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr9 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CARGO IS NULL OR x.cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CARGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.cargo         = b.cargo(+)   ',
'   AND a.class_cargo   = b.class_cargo(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_CARGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''ECAR'''
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
 p_id=>wwv_flow_api.id(30858921720703497516)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215693816829287338
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922357045497522)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858921898034497517)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858941547012809383)
,p_db_column_name=>'CARGO'
,p_display_order=>30
,p_column_identifier=>'Q'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858941611733809384)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>40
,p_column_identifier=>'R'
,p_column_label=>'Nome Cargo'
,p_column_html_expression=>'<nobr>#NOME_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858941769545809385)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>50
,p_column_identifier=>'S'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o Cargo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858941871918809386)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>60
,p_column_identifier=>'T'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o Cargo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922857562497527)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858921937153497518)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922007166497519)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922121952497520)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922243163497521)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>110
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922469840497523)
,p_db_column_name=>'MES1'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922583019497524)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922643058497525)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922723103497526)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858922922328497528)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>160
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741938056577286)
,p_db_column_name=>'INSS'
,p_display_order=>170
,p_column_identifier=>'U'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742020592577287)
,p_db_column_name=>'FGTS'
,p_display_order=>180
,p_column_identifier=>'V'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742161921577288)
,p_db_column_name=>'IR'
,p_display_order=>190
,p_column_identifier=>'W'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859742286149577289)
,p_db_column_name=>'LIQ'
,p_display_order=>200
,p_column_identifier=>'X'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167019522709635)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'Y'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817715978516251625)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'Z'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716163009251626)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'AA'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858957955047831968)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12157301'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:CARGO:NOME_CARGO:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858942451628809392)
,p_plug_name=>'10 - Empresa/Categoria CCusto - ECATCCUS'
,p_region_name=>'IR_10'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>100
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.class_ccusto, a.desc_class_ccusto',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr10 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CLASSCTO IS NULL OR x.class_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr10 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CLASSCTO IS NULL OR x.class_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.class_ccusto  = b.class_ccusto(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_CLASSCTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''ECATCCUS'''
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
 p_id=>wwv_flow_api.id(30858942520862809393)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215714616988599215
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943199490809399)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858942627667809394)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858944224929809410)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858944376808809411)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943676208809404)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858942767750809395)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858942863614809396)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943002416809397)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943064724809398)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943260583809400)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943343097809401)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943499090809402)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943544042809403)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858943731017809405)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741530695577282)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741678019577283)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741797267577284)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741849627577285)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167146581709636)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716251305251627)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716318154251628)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30858969309806008115)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12157415'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:CLASS_CCUSTO:DESC_CLASS_CCUSTO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30858944917457809417)
,p_plug_name=>'11 - Empresa/Categoria Cargo - ECATCAR'
,p_region_name=>'IR_11'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.class_cargo, a.desc_class_cargo',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr11 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CLASSCGO IS NULL OR x.class_cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr11 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_CLASSCGO IS NULL OR x.class_cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.class_cargo   = b.class_cargo(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_CLASSCGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''ECATCAR'''
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
 p_id=>wwv_flow_api.id(30858945083936809418)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1215717180062599240
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945634190809424)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945129353809419)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859258991579353883)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o Cargo</nobr>')
,p_column_html_expression=>'<nobr>#CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259071889353884)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o Cargo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859258517565353879)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945261917809420)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945321009809421)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945450997809422)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945527598809423)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945775778809425)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945814250809426)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858945966109809427)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30858946080281809428)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859258657583353880)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859690245491231728)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741247593577279)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741375092577280)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859741453640577281)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167278639709637)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716419462251629)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716478746251630)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859270510876390602)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12160427'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859259138211353885)
,p_plug_name=>'13 - Empresa/Filial/Categoria CCusto - EFCCCUS'
,p_region_name=>'IR_12'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>120
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.class_ccusto, a.desc_class_ccusto',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr13 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL   IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_CLASSCTO IS NULL OR x.class_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr13 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL   IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (:P55_CLASSCTO IS NULL OR x.class_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.class_ccusto  = b.class_ccusto(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_CLASSCTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFCCCUS'''
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
 p_id=>wwv_flow_api.id(30859259252909353886)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216031349035143708
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259831864353892)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'F'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259359105353887)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260736494353901)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260869212353902)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260907130353903)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_html_expression=>'<nobr>#CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261101158353904)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o CCusto</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260378525353897)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259443335353888)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259599023353889)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'C'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259696504353890)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'D'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259718416353891)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>110
,p_column_identifier=>'E'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859259951670353893)
,p_db_column_name=>'MES1'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260099021353894)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260105545353895)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260255438353896)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859260404982353898)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>160
,p_column_identifier=>'L'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689868730231724)
,p_db_column_name=>'INSS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689988695231725)
,p_db_column_name=>'FGTS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859690066098231726)
,p_db_column_name=>'IR'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859690108571231727)
,p_db_column_name=>'LIQ'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167330239709638)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716572809251631)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716771033251632)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859289396523569711)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12160615'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CLASS_CCUSTO:DESC_CLASS_CCUSTO:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:TIPO_RUBRICA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859261150367353905)
,p_plug_name=>'14 - Empresa/Filial/Cargo - EFCAR'
,p_region_name=>'IR_13'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>130
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.cargo, a.nome_cargo',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cargo, x.nome_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr14 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_CARGO  IS NULL OR x.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CARGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cargo, x.nome_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr14 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (:P55_CARGO  IS NULL OR x.cargo IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CARGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.cargo         = b.cargo(+)   ',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_CARGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFCAR'''
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
 p_id=>wwv_flow_api.id(30859261205123353906)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216033301249143728
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261879129353912)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261311100353907)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262573087353919)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262676811353920)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262924250353923)
,p_db_column_name=>'CARGO'
,p_display_order=>50
,p_column_identifier=>'N'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859263075636353924)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>60
,p_column_identifier=>'O'
,p_column_label=>'Nome Cargo'
,p_column_html_expression=>'<nobr>#NOME_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262312914353917)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'J'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261463915353908)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859263187406353925)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'P'
,p_column_label=>'Gerencial'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261669319353910)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'C'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261767658353911)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>110
,p_column_identifier=>'D'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859261989472353913)
,p_db_column_name=>'MES1'
,p_display_order=>120
,p_column_identifier=>'F'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262094973353914)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>130
,p_column_identifier=>'G'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262166923353915)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262242949353916)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>150
,p_column_identifier=>'I'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859262425505353918)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>160
,p_column_identifier=>'K'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689446387231720)
,p_db_column_name=>'INSS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689583482231721)
,p_db_column_name=>'FGTS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689687928231722)
,p_db_column_name=>'IR'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689728897231723)
,p_db_column_name=>'LIQ'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide Liqu\00EDdo')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167493735709639)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716840999251633)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817716937755251634)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859310049881781329)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12160822'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CARGO:NOME_CARGO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859263281868353926)
,p_plug_name=>'15 - Empresa/Filial/Class Cargo - EFCCAR'
,p_region_name=>'IR_14'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>140
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.class_cargo, a.desc_class_cargo',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr15 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL   IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_CLASSCGO IS NULL OR x.class_cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.class_cargo, x.desc_class_cargo',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr15 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL   IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'           AND (:P55_CLASSCGO IS NULL OR x.class_cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CLASSCGO, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.class_cargo   = b.class_cargo(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_CLASSCGO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFCCAR'''
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
 p_id=>wwv_flow_api.id(30859263356635353927)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216035452761143749
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325067007904782)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859263493129353928)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325732726904789)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325882590904790)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859326226347904794)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>50
,p_column_identifier=>'Q'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o Cargo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859326346665904795)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>60
,p_column_identifier=>'R'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o Cargo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325541763904787)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'J'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859324710858904779)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859326453311904796)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'S'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859324877813904780)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'C'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859324920136904781)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>110
,p_column_identifier=>'D'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325175613904783)
,p_db_column_name=>'MES1'
,p_display_order=>120
,p_column_identifier=>'F'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325216405904784)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>130
,p_column_identifier=>'G'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325310003904785)
,p_db_column_name=>'MES2'
,p_display_order=>140
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325429030904786)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>150
,p_column_identifier=>'I'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859325607940904788)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>160
,p_column_identifier=>'K'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689096145231716)
,p_db_column_name=>'INSS'
,p_display_order=>170
,p_column_identifier=>'T'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689158037231717)
,p_db_column_name=>'FGTS'
,p_display_order=>180
,p_column_identifier=>'U'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689270898231718)
,p_db_column_name=>'IR'
,p_display_order=>190
,p_column_identifier=>'V'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859689339928231719)
,p_db_column_name=>'LIQ'
,p_display_order=>200
,p_column_identifier=>'W'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167524708709640)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>210
,p_column_identifier=>'X'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717060507251635)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>220
,p_column_identifier=>'Y'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717093716251636)
,p_db_column_name=>'ORIGEM'
,p_display_order=>230
,p_column_identifier=>'Z'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859343706483967310)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12161159'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CLASS_CARGO:DESC_CLASS_CARGO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859327053454904802)
,p_plug_name=>unistr('17 - Empresa/Filial/M\00E3o Obra/CCusto - EFCMO')
,p_region_name=>'IR_15'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>150
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.cod_tipo_mao_obra, a.desc_cod_tp_mao_obra, a.cod_ccusto, a.nome_ccusto, a.class_ccusto, a.desc_class_ccusto',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cod_tipo_mao_obra, x.desc_cod_tp_mao_obra, x.cod_ccusto, x.nome_ccusto, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr17 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_MAOBRA IS NULL OR x.cod_tipo_mao_obra IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_MAOBRA, '':'')) t))           ',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))            ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.cod_tipo_mao_obra, x.desc_cod_tp_mao_obra, x.cod_ccusto, x.nome_ccusto, x.class_ccusto, x.desc_class_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr17 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))            ',
'           AND (:P55_MAOBRA IS NULL OR x.cod_tipo_mao_obra IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_MAOBRA, '':'')) t))           ',
'           AND (:P55_CCUSTO IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.cod_tipo_mao_obra = b.cod_tipo_mao_obra(+)',
'   AND a.cod_ccusto    = b.cod_ccusto(+)',
'   AND a.class_ccusto  = b.class_ccusto(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9,11,13;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_MAOBRA,P55_CCUSTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFCMO'''
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
 p_id=>wwv_flow_api.id(30859327186259904803)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216099282385694625
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327693911904808)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327228583904804)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328332201904815)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328464929904816)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328839945904820)
,p_db_column_name=>'COD_TIPO_MAO_OBRA'
,p_display_order=>50
,p_column_identifier=>'Q'
,p_column_label=>unistr('<nobr>Tipo M\00E3o Obra</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328970297904821)
,p_db_column_name=>'DESC_COD_TP_MAO_OBRA'
,p_display_order=>60
,p_column_identifier=>'R'
,p_column_label=>unistr('<nobr>Nome Tipo M\00E3o Obra</nobr>')
,p_column_html_expression=>'<nobr>#DESC_COD_TP_MAO_OBRA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859329034162904822)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>70
,p_column_identifier=>'S'
,p_column_label=>'C.Custo'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859329202332904823)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>80
,p_column_identifier=>'T'
,p_column_label=>'Nome Centro de Custo'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859329302072904824)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>90
,p_column_identifier=>'U'
,p_column_label=>unistr('<nobr>Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859329320360904825)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>100
,p_column_identifier=>'V'
,p_column_label=>unistr('<nobr>Nome Classifica\00E7\00E3o C.Custo</nobr>')
,p_column_html_expression=>'<nobr>#DESC_CLASS_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328114662904813)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327338057904805)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>120
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328751502904819)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>130
,p_column_identifier=>'P'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327478698904806)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>140
,p_column_identifier=>'C'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327571457904807)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>150
,p_column_identifier=>'D'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327749279904809)
,p_db_column_name=>'MES1'
,p_display_order=>160
,p_column_identifier=>'F'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327879413904810)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>170
,p_column_identifier=>'G'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859327966949904811)
,p_db_column_name=>'MES2'
,p_display_order=>180
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328054535904812)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>190
,p_column_identifier=>'I'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859328227580904814)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>200
,p_column_identifier=>'K'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688668309231712)
,p_db_column_name=>'INSS'
,p_display_order=>210
,p_column_identifier=>'W'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688752835231713)
,p_db_column_name=>'FGTS'
,p_display_order=>220
,p_column_identifier=>'X'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688822164231714)
,p_db_column_name=>'IR'
,p_display_order=>230
,p_column_identifier=>'Y'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688923923231715)
,p_db_column_name=>'LIQ'
,p_display_order=>240
,p_column_identifier=>'Z'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167682053709641)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>250
,p_column_identifier=>'AA'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717231116251637)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>260
,p_column_identifier=>'AB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717313158251638)
,p_db_column_name=>'ORIGEM'
,p_display_order=>270
,p_column_identifier=>'AC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859578069752691419)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12163502'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_TIPO_MAO_OBRA:DESC_COD_TP_MAO_OBRA:COD_CCUSTO:NOME_CCUSTO:CLASS_CCUSTO:DESC_CLASS_CCUSTO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERC'
||'ENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859329477668904826)
,p_plug_name=>'18 - Empresa/Filial/Unidade Adm/CCusto - EFUCC'
,p_region_name=>'IR_16'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>160
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.filial, a.nome_filial, a.unidade_adm, a.desc_unidade_adm, a.cod_ccusto, a.nome_ccusto',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.unidade_adm, x.desc_unidade_adm, x.cod_ccusto, x.nome_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr18 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL  IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t)) ',
'           AND (:P55_UNIDADM IS NULL OR x.unidade_adm IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_UNIDADM, '':'')) t))            ',
'           AND (:P55_CCUSTO  IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))            ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.filial, x.nome_filial, x.unidade_adm, x.desc_unidade_adm, x.cod_ccusto, x.nome_ccusto',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr18 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_FILIAL  IS NULL OR x.filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))            ',
'           AND (:P55_UNIDADM IS NULL OR x.unidade_adm IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_UNIDADM, '':'')) t))            ',
'           AND (:P55_CCUSTO  IS NULL OR x.cod_ccusto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_CCUSTO, '':'')) t))',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.filial        = b.filial(+)',
'   AND a.unidade_adm   = b.unidade_adm(+)',
'   AND a.cod_ccusto    = b.cod_ccusto(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7,9,11;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_FILIAL,P55_CCUSTO,P55_UNIDADM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EFUCC'''
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
 p_id=>wwv_flow_api.id(30859329596367904827)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216101692493694649
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584369975790982)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859329660250904828)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859585099651790989)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859585200959790990)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Nome Filial'
,p_column_html_expression=>'<nobr>#NOME_FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859585557402790994)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'Q'
,p_column_label=>'C.Custo'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859585656604790995)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>70
,p_column_identifier=>'R'
,p_column_label=>'<nobr>Nome Centro de Custo</nobr>'
,p_column_html_expression=>'<nobr>#NOME_CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859585911554790998)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>80
,p_column_identifier=>'U'
,p_column_label=>'<nobr>Unidade Adm.</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859586041718790999)
,p_db_column_name=>'DESC_UNIDADE_ADM'
,p_display_order=>90
,p_column_identifier=>'V'
,p_column_label=>'<nobr>Nome Unidade Adm.</nobr>'
,p_column_html_expression=>'<nobr>#DESC_UNIDADE_ADM#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584903403790987)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584055132790979)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>110
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859585297800790991)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>120
,p_column_identifier=>'N'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584127644790980)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>130
,p_column_identifier=>'C'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584231656790981)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>140
,p_column_identifier=>'D'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584490516790983)
,p_db_column_name=>'MES1'
,p_display_order=>150
,p_column_identifier=>'F'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584550931790984)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>160
,p_column_identifier=>'G'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584628874790985)
,p_db_column_name=>'MES2'
,p_display_order=>170
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584795222790986)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>180
,p_column_identifier=>'I'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859584941046790988)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>190
,p_column_identifier=>'K'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688264122231708)
,p_db_column_name=>'INSS'
,p_display_order=>200
,p_column_identifier=>'W'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688373129231709)
,p_db_column_name=>'FGTS'
,p_display_order=>210
,p_column_identifier=>'X'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688481899231710)
,p_db_column_name=>'IR'
,p_display_order=>220
,p_column_identifier=>'Y'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688523079231711)
,p_db_column_name=>'LIQ'
,p_display_order=>230
,p_column_identifier=>'Z'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167716634709642)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>240
,p_column_identifier=>'AA'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717393999251639)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>250
,p_column_identifier=>'AB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717526475251640)
,p_db_column_name=>'ORIGEM'
,p_display_order=>260
,p_column_identifier=>'AC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859603473390910718)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12163756'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:UNIDADE_ADM:DESC_UNIDADE_ADM:COD_CCUSTO:NOME_CCUSTO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859586636692791005)
,p_plug_name=>'19 - Empresa/Local Trabalho - EL'
,p_region_name=>'IR_17'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>170
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.local_trab, a.desc_local_trab',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.local_trab, x.desc_local_trab',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr19 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_LOCAL IS NULL OR x.local_trab IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_LOCAL, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.local_trab, x.desc_local_trab',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr19 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_LOCAL IS NULL OR x.local_trab IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_LOCAL, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.local_trab    = b.local_trab(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_LOCAL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EL'''
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
 p_id=>wwv_flow_api.id(30859586719528791006)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216358815654580828
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587254927791011)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859586901684791007)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859588636780791025)
,p_db_column_name=>'LOCAL_TRAB'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'<nobr>Local Trabalho</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859588719029791026)
,p_db_column_name=>'DESC_LOCAL_TRAB'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'<nobr>Nome Local Trabalho</nobr>'
,p_column_html_expression=>'<nobr>#DESC_LOCAL_TRAB#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587734026791016)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'J'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859586906077791008)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859588167166791020)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'L'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587069953791009)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'C'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587120038791010)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'D'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587333006791012)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'F'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587456244791013)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'G'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587542547791014)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587644009791015)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'I'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859587826565791017)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'K'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687863612231704)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687963529231705)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688064197231706)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859688122934231707)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167902150709643)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717623169251641)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717743710251642)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859623902415090715)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12163960'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:LOCAL_TRAB:DESC_LOCAL_TRAB:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(30859685686392231682)
,p_plug_name=>unistr('20 - Empresa/Unid. Neg\00F3cio - EU')
,p_region_name=>'IR_18'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>180
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.cod_un_negocio, a.nome_un_negocio',
'      ,a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.cod_un_negocio, x.nome_un_negocio',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr20 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_UNIDNEG IS NULL OR x.cod_un_negocio IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_UNIDNEG, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.cod_un_negocio, x.nome_un_negocio',
'              ,x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr20 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (:P55_UNIDNEG IS NULL OR x.cod_un_negocio IN(SELECT /*+ cardinality (t1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_UNIDNEG, '':'')) t))           ',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
' WHERE a.cod_empresa    = b.cod_empresa(+)',
'   AND a.cod_un_negocio = b.cod_un_negocio(+)',
'   AND a.cod_ocorr      = b.cod_ocorr(+)',
'   AND a.cod_gerencial  = b.cod_gerencial(+)',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'ORDER BY 3,5,7;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2,P55_UNIDNEG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''EU'''
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
 p_id=>wwv_flow_api.id(30859685800241231683)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1216457896367021505
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686243961231688)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859685881257231684)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687217833231698)
,p_db_column_name=>'COD_UN_NEGOCIO'
,p_display_order=>30
,p_column_identifier=>'O'
,p_column_label=>unistr('<nobr>Unidade Neg\00F3cio</nobr>')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687314266231699)
,p_db_column_name=>'NOME_UN_NEGOCIO'
,p_display_order=>40
,p_column_identifier=>'P'
,p_column_label=>unistr('<nobr>Nome Unidade de Neg\00F3cio</nobr>')
,p_column_html_expression=>'<nobr>#NOME_UN_NEGOCIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686714781231693)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'J'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859685915710231685)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'B'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686953594231695)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'L'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686018323231686)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'C'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686111020231687)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'D'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686305098231689)
,p_db_column_name=>'MES1'
,p_display_order=>100
,p_column_identifier=>'F'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686461239231690)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>110
,p_column_identifier=>'G'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686514396231691)
,p_db_column_name=>'MES2'
,p_display_order=>120
,p_column_identifier=>'H'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686653408231692)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>130
,p_column_identifier=>'I'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859686885199231694)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>140
,p_column_identifier=>'K'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687493795231700)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687540542231701)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687680425231702)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859687731973231703)
,p_db_column_name=>'LIQ'
,p_display_order=>180
,p_column_identifier=>'T'
,p_column_label=>unistr('L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10814167968098709644)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>190
,p_column_identifier=>'U'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717850926251643)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>200
,p_column_identifier=>'V'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817717902204251644)
,p_db_column_name=>'ORIGEM'
,p_display_order=>210
,p_column_identifier=>'W'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(30859707431371270873)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12164796'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:COD_UN_NEGOCIO:NOME_UN_NEGOCIO:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35301223269159359135)
,p_plug_name=>'1 - Empresa - E'
,p_region_name=>'IR_1'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.cod_empresa, a.nome_empresa, a.cod_ocorr, a.nome_cod_ocorr, a.cod_gerencial, UPPER(a.nome_cod_gerencial) nome_cod_gerencial',
'      ,a.tot_valor tot_valor1, TO_CHAR(a.data_ref,''MON/RRRR'') mes1, b.tot_valor tot_valor2, TO_CHAR(b.data_ref,''MON/RRRR'') mes2',
'      ,(b.tot_valor - a.tot_valor) difValor',
'      ,(CASE a.tot_valor WHEN 0 THEN 0 ELSE (((b.tot_valor - a.tot_valor)*100)/a.tot_valor) END) Percentual',
'      ,(SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) inss',
'      ,(SELECT p.incid_ir FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) fgts',
'      ,(SELECT p.incid_fgts FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) ir',
'      ,(SELECT p.incid_liq FROM ocorr_pagto p WHERE p.cod_empresa = a.cod_empresa AND p.cod = a.cod_ocorr) liq      ',
'      ,DECODE(c.tipo_rubrica,',
'              1, ''Provento'',',
'              2, ''Desconto'',',
'              3, ''Informativa'',',
'              4, ''Informativa Dedutora'') AS tipo_rubrica',
'     ,a.horas_ferias',
unistr('     ,(DECODE(a.horas_ferias, 131,''13\00BA Sal\00E1rio'', 132,''13\00BA Sal\00E1rio'', 326,''Folha'', 334,''Rescis\00E3o'', 584,''Rescis\00E3o Complementar'', 318,''Adiantamento'')) origem               '),
'  FROM (SELECT x.cod_empresa, x.nome_empresa, x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr4 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) a',
'      ,(SELECT x.cod_empresa, x.nome_empresa, x.cod_ocorr, x.nome_cod_ocorr, x.cod_gerencial, x.nome_cod_gerencial, x.tot_valor, x.data_ref, x.horas_ferias',
'          FROM tb_ocorr4 x',
'         WHERE x.data_ref    = TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'')',
'           AND x.cod_empresa = :P55_EMPRESA',
'           AND (x.cod_ocorr     = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'           AND (x.cod_gerencial = :P55_CODAUX OR :P55_CODAUX IS NULL)) b',
'     , ocorr_pagto c',
'     ',
'        ',
' WHERE a.cod_empresa   = b.cod_empresa(+)',
'   AND a.cod_ocorr     = b.cod_ocorr(+)',
'   AND a.cod_gerencial = b.cod_gerencial(+) ',
'   ',
'   AND a.cod_empresa = c.cod_empresa(+) ',
'   AND a.cod_ocorr = c.cod(+) ',
'        ',
'ORDER BY 3,5'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P55_PESQUISA = ''S'' AND :P55_HISTOCORR = ''E'''
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(35301223635353359135)
,p_name=>'Report 1'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>5657995731479148957
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856272508143774197)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333368827202980)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'AV'
,p_column_label=>'Nome Empresa'
,p_column_html_expression=>'<nobr>#NOME_EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856272938119774198)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333495143202981)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>50
,p_column_identifier=>'AW'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#NOME_COD_OCORR#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333568893202982)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>60
,p_column_identifier=>'AX'
,p_column_label=>' Gerencial'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333636619202983)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'AY'
,p_column_label=>'Nome Gerencial'
,p_column_html_expression=>'<nobr>#NOME_COD_GERENCIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333835827202985)
,p_db_column_name=>'MES1'
,p_display_order=>80
,p_column_identifier=>'BA'
,p_column_label=>'MES1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333747103202984)
,p_db_column_name=>'TOT_VALOR1'
,p_display_order=>90
,p_column_identifier=>'AZ'
,p_column_label=>'GGG'
,p_report_label=>'&P55_MONRRRR_1.'
,p_sync_form_label=>'N'
,p_column_html_expression=>'<nobr>#TOT_VALOR1#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856333979368202986)
,p_db_column_name=>'TOT_VALOR2'
,p_display_order=>100
,p_column_identifier=>'BB'
,p_column_label=>'&P55_MONRRRR_2.'
,p_column_html_expression=>'<nobr>#TOT_VALOR2#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334077631202987)
,p_db_column_name=>'MES2'
,p_display_order=>110
,p_column_identifier=>'BC'
,p_column_label=>'Mes2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856334140777202988)
,p_db_column_name=>'DIFVALOR'
,p_display_order=>120
,p_column_identifier=>'BD'
,p_column_label=>unistr('Diferen\00E7a')
,p_column_html_expression=>'<nobr>#DIFVALOR#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30856264150577774195)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>130
,p_column_identifier=>'U'
,p_column_label=>'%'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859745116085577318)
,p_db_column_name=>'INSS'
,p_display_order=>140
,p_column_identifier=>'BE'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859745254409577319)
,p_db_column_name=>'FGTS'
,p_display_order=>150
,p_column_identifier=>'BF'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859745330958577320)
,p_db_column_name=>'IR'
,p_display_order=>160
,p_column_identifier=>'BG'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30859745424338577321)
,p_db_column_name=>'LIQ'
,p_display_order=>170
,p_column_identifier=>'BH'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'CENTER'
,p_rpt_named_lov=>wwv_flow_api.id(30856299467732774213)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10813964483523180816)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>180
,p_column_identifier=>'BI'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805235372819159)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>190
,p_column_identifier=>'BJ'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10810805290231819160)
,p_db_column_name=>'ORIGEM'
,p_display_order=>200
,p_column_identifier=>'BK'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(35301232428751371010)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12130486'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:COD_OCORR:NOME_COD_OCORR:TIPO_RUBRICA:COD_GERENCIAL:NOME_COD_GERENCIAL:TOT_VALOR1:TOT_VALOR2:DIFVALOR:ORIGEM:PERCENTUAL:INSS:FGTS:IR:LIQ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(116678246493156990828)
,p_plug_name=>unistr('Comparativos de Hist\00F3ricos Financeiros')
,p_icon_css_classes=>'fa-history'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--noPadding:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(57485012599711710891)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('<p><i>Comparativo de Hist\00F3ricos Financeiros entre dois per\00EDodos</i></p>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202655193297400821213)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(57485014174799710894)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30856281125874774203)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(57485035140117710938)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30856278470185774202)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(116678246493156990828)
,p_button_name=>'RESET'
,p_button_static_id=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:55:&SESSION.::&DEBUG.:RP,55:P55_PESQUISA:'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(30856278872414774202)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(116678246493156990828)
,p_button_name=>'BACK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>':P55_APP_ANT IS NOT NULL AND :P55_PAG_ANT IS NOT NULL'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-undo-arrow'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28426457280528909611)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(35301223269159359135)
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
 p_id=>wwv_flow_api.id(28426431352115151324)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(30856334232860202989)
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
 p_id=>wwv_flow_api.id(28426431439421151325)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(30856336614851203013)
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
 p_id=>wwv_flow_api.id(28426431551261151326)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(30858722792844360489)
,p_button_name=>'IA_4'
,p_button_static_id=>'BTN_IA_4'
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
 p_id=>wwv_flow_api.id(28426431640362151327)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(30858725233450360514)
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
 p_id=>wwv_flow_api.id(28426431745389151328)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(30858790541653979992)
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
 p_id=>wwv_flow_api.id(28426431807984151329)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(30858792870682980015)
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
 p_id=>wwv_flow_api.id(28426431906390151330)
,p_button_sequence=>180
,p_button_plug_id=>wwv_flow_api.id(30858919255100497491)
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
 p_id=>wwv_flow_api.id(28426432045743151331)
,p_button_sequence=>190
,p_button_plug_id=>wwv_flow_api.id(30858921622700497515)
,p_button_name=>'IA_9'
,p_button_static_id=>'BTN_IA_9'
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
 p_id=>wwv_flow_api.id(28426432138205151332)
,p_button_sequence=>200
,p_button_plug_id=>wwv_flow_api.id(30858942451628809392)
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
 p_id=>wwv_flow_api.id(28426432236339151333)
,p_button_sequence=>210
,p_button_plug_id=>wwv_flow_api.id(30858944917457809417)
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
 p_id=>wwv_flow_api.id(28426432311225151334)
,p_button_sequence=>220
,p_button_plug_id=>wwv_flow_api.id(30859259138211353885)
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
 p_id=>wwv_flow_api.id(28426432471202151335)
,p_button_sequence=>230
,p_button_plug_id=>wwv_flow_api.id(30859261150367353905)
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
 p_id=>wwv_flow_api.id(28426432524549151336)
,p_button_sequence=>240
,p_button_plug_id=>wwv_flow_api.id(30859263281868353926)
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
 p_id=>wwv_flow_api.id(28426432667605151337)
,p_button_sequence=>250
,p_button_plug_id=>wwv_flow_api.id(30859327053454904802)
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
 p_id=>wwv_flow_api.id(28426432755717151338)
,p_button_sequence=>260
,p_button_plug_id=>wwv_flow_api.id(30859329477668904826)
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
 p_id=>wwv_flow_api.id(28426432884945151339)
,p_button_sequence=>270
,p_button_plug_id=>wwv_flow_api.id(30859586636692791005)
,p_button_name=>'IA_17'
,p_button_static_id=>'BTN_IA_17'
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
 p_id=>wwv_flow_api.id(28426432891286151340)
,p_button_sequence=>280
,p_button_plug_id=>wwv_flow_api.id(30859685686392231682)
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
 p_id=>wwv_flow_api.id(28426456043596902349)
,p_name=>'P55_FLG'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426456336957903817)
,p_name=>'P55_MSG'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426456645169905689)
,p_name=>'P55_STATIC_ID_IR'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426456962372907671)
,p_name=>'P55_USER_PROMPT'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30669353665560172527)
,p_name=>'P55_DATA_REF2'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>unistr('PER\00CDODO 2')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.display  det',
'      ,x.data_ref ret',
'  FROM list_hist_finan_datas x',
' WHERE TRUNC(x.data_ref, ''MONTH'') >= ADD_MONTHS(TRUNC(SYSDATE, ''MONTH''),-61)',
'ORDER BY 2 DESC '))
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
,p_attribute_07=>unistr('Per\00EDodos')
,p_attribute_08=>'350'
,p_attribute_09=>'450'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856279221149774202)
,p_name=>'P55_APP_ANT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(116678246493156990828)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856279695133774202)
,p_name=>'P55_PAG_ANT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(116678246493156990828)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856281530204774203)
,p_name=>'P55_PESQUISA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856281952515774203)
,p_name=>'P55_CODAUX'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856282296775774203)
,p_name=>'P55_EMPRESA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
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
 p_id=>wwv_flow_api.id(30856322176073958946)
,p_name=>'P55_HISTOCORR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>unistr('TIPO HIST\00D3RICO')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>unistr('STATIC2(,):EmpresaEEmpresa, FilialEFEmpresa, Filial, CCustoEFCCEmpresa, Filial, Unid. Adm.EFUAEmpresa, Divis\00E3oEDEmpresa, Regional EREmpresa, Filial, Ccusto, Cargo EFCCCAREmpresa, Centro de Custo ECCEmpresa, Cargo ECAREmpresa, Cate')
||'goria de Ccusto ECATCCUSEmpresa, Categoria de CargoECATCAREmpresa, Filial, Class CustoEFCCCUSEmpresa, Filial, Cargo EFCAREmpresa, Filial, Class Cargo EFCCAREmpresa, Filial, Obra, CcustoEFCMOEmpresa, Filial, Unidade adm, CCusto EFUCCEmpr'
||unistr('esa, LocalELEmpresa, Unidade de Neg\00F3cioEU')
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
,p_attribute_05=>'N'
,p_attribute_07=>unistr('Comparativos de Hist\00F3ricos')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856330974325119140)
,p_name=>'P55_DATA_REF1'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>unistr('PER\00CDODO 1')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.display  det',
'      ,x.data_ref ret',
'  FROM list_hist_finan_datas x',
' WHERE TRUNC(x.data_ref, ''MONTH'') >= ADD_MONTHS(TRUNC(SYSDATE, ''MONTH''),-61)',
'ORDER BY 2 DESC '))
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
,p_attribute_07=>unistr('Per\00EDodos')
,p_attribute_08=>'350'
,p_attribute_09=>'450'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30856335890004203005)
,p_name=>'P55_FILIAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'FILIAIS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT f.cod_filial||''-''||f.nome_filial det',
'      ,f.cod_filial                     ret',
'  FROM filiais f',
' WHERE f.cod_empresa = :P55_EMPRESA',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P55_EMPRESA'
,p_ajax_items_to_submit=>'P55_EMPRESA'
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
 p_id=>wwv_flow_api.id(30856336214436203009)
,p_name=>'P55_CCUSTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'CENTROS DE CUSTO'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.nome det',
'      ,x.cod              ret',
'  FROM centro_de_custo x',
' WHERE x.cod_empresa = :P55_EMPRESA',
'   AND (x.cod = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P55_EMPRESA'
,p_ajax_items_to_submit=>'P55_EMPRESA'
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
 p_id=>wwv_flow_api.id(30858722298108360484)
,p_name=>'P55_UNIDADM'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'UNID. ADMINISTRATIVAS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P55_FILIAL,'':'') > 0 OR :P55_FILIAL IS NULL THEN ''[''||x.cod_filial||''] ''||x.cod_unidade_adm||''-''||x.descricao',
'          ELSE x.cod_unidade_adm||''-''||x.descricao END) det',
'      ,x.cod_unidade_adm                   ret',
'  FROM unidade_administrativa x',
' WHERE x.cod_empresa = :P55_EMPRESA ',
'   AND (:P55_FILIAL IS NULL OR x.cod_filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P55_FILIAL, '':'')) t))',
'   AND (x.cod_unidade_adm = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P55_FILIAL'
,p_ajax_items_to_submit=>'P55_EMPRESA,P55_FILIAL'
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
 p_id=>wwv_flow_api.id(30858724780133360509)
,p_name=>'P55_DIVISAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>unistr('DIVIS\00D5ES')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_divisao||''-''||x.descricao det',
'      ,x.cod_divisao                   ret',
'  FROM divisao x',
' WHERE (x.cod_divisao = :P55_CODAUX OR :P55_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(30858790089434979987)
,p_name=>'P55_REGIONAL'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'REGIONAIS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_regional||''-''||x.descricao det',
'      ,x.cod_regional                   ret',
'  FROM regional x',
' WHERE (x.cod_regional = :P55_CODAUX OR :P55_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(30858792370331980010)
,p_name=>'P55_CARGO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'CARGOS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.nome det',
'      ,x.cod              ret',
'  FROM cargos x',
' WHERE (x.cod = :P55_CODAUX OR :P55_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(30858941918393809387)
,p_name=>'P55_CLASSCTO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'CATEGORIAS C.CUSTO'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.descricao det',
'      ,x.cod                   ret',
'  FROM class_ccusto x',
' WHERE (x.cod = :P55_CODAUX OR :P55_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(30858944475070809412)
,p_name=>'P55_CLASSCGO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'CATEGORIAS CARGOS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.descricao det',
'      ,x.cod                   ret',
'  FROM class_cargo x',
' WHERE (x.cod = :P55_CODAUX OR :P55_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(30859326542009904797)
,p_name=>'P55_MAOBRA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>unistr('TIPOS M\00C3O DE OBRA')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:D - Direta;D,I - Indireta;I'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P55_EMPRESA'
,p_ajax_items_to_submit=>'P55_EMPRESA'
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
,p_attribute_07=>unistr('Tipos M\00E3o de Obra')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30859586158538791000)
,p_name=>'P55_LOCAL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>'LOCAIS TRABALHO'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_local_trab||''-''||x.descricao det',
'      ,x.cod_local_trab                   ret',
'  FROM local_trab x',
' WHERE (x.cod_local_trab = :P55_CODAUX OR :P55_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(30859588821739791027)
,p_name=>'P55_UNIDNEG'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_prompt=>unistr('UNID. NEG\00D3CIOS')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_un_negocio||''-''||x.nome_un_negocio det',
'      ,x.cod_un_negocio                         ret',
'  FROM unidade_de_negocio x',
' WHERE x.cod_empresa = :P55_EMPRESA',
'   AND (x.cod_un_negocio = :P55_CODAUX OR :P55_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P55_EMPRESA'
,p_ajax_items_to_submit=>'P55_EMPRESA'
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
 p_id=>wwv_flow_api.id(30859745928817577326)
,p_name=>'P55_MONRRRR_1'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30859746168197577328)
,p_name=>'P55_MONRRRR_2'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(202655193297400821213)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(30669353046147172521)
,p_validation_name=>unistr('Valida Tipo Hist\00F3rico')
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P55_HISTOCORR IS NULL THEN',
unistr('    vReturn := ''TIPO HIST\00D3RICO deve ser informado!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(30856322176073958946)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(30669353162233172522)
,p_validation_name=>'Valida Empresa'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P55_HISTOCORR IS NOT NULL THEN',
'    IF :P55_EMPRESA IS NULL THEN',
'      vReturn := ''EMPRESA deve ser informada!'';',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(30856282296775774203)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(30669353721943172528)
,p_validation_name=>'Valida DtRef 1'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P55_HISTOCORR IS NOT NULL THEN',
'    IF :P55_DATA_REF1 IS NULL THEN',
unistr('      vReturn := ''PER\00CDODO 1 deve ser informado!'';'),
'    ELSE',
'      IF :P55_DATA_REF2 IS NOT NULL THEN',
'        IF TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'') > TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'') THEN',
unistr('          vReturn := ''PER\00CDODO 1 n\00E3o deve ser MAIOR que per\00EDodo 2!'';'),
'        END IF;',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(30856330974325119140)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(30856333284664202979)
,p_validation_name=>'Valida DtRef 2'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P55_HISTOCORR IS NOT NULL THEN',
'    IF :P55_DATA_REF2 IS NULL THEN',
unistr('      vReturn := ''PER\00CDODO 2 deve ser informado!'';'),
'    ELSE',
'      IF :P55_DATA_REF1 IS NOT NULL THEN',
'        IF TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR'') < TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR'') THEN',
unistr('          vReturn := ''PER\00CDODO 2 n\00E3o deve ser MENOR que per\00EDodo 1!'';'),
'        END IF;',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(30669353665560172527)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856286144409774207)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(35301223269159359135)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856286647746774208)
,p_event_id=>wwv_flow_api.id(30856286144409774207)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(35301223269159359135)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856287009117774208)
,p_name=>'Start Spinner'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(30856278872414774202)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856287543691774208)
,p_event_id=>wwv_flow_api.id(30856287009117774208)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner55= apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856289761278774209)
,p_name=>'Pesquisa'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(30856281125874774203)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856290206420774209)
,p_event_id=>wwv_flow_api.id(30856289761278774209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_PESQUISA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856290752992774209)
,p_event_id=>wwv_flow_api.id(30856289761278774209)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856291182762774209)
,p_name=>'Disable Report'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(202655193297400821213)
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856291656921774209)
,p_event_id=>wwv_flow_api.id(30856291182762774209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#REP1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856293002269774209)
,p_name=>'Open Proporcionaliza'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33081966447842721523)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856293850608774210)
,p_name=>unistr('Open Inclus\00E3o Autom\00E1tica')
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33084326672415006087)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856294759421774210)
,p_name=>'Executa Proporcionalizar'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_EXECPROPORC'
,p_condition_element=>'P55_EXECPROPORC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856295245941774211)
,p_event_id=>wwv_flow_api.id(30856294759421774210)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  pkg_AdmPessPoliticasParamCalc.prc_TipoATSProporcionalizar(pAts       => :P55_ATS',
'                                                           ,pEmp       => :P55_EMPRESAS',
'                                                           ,pOcorrFol  => :P55_OCORRFOLHA',
'                                                           ,pOcorrFer  => :P55_OCORRFERIAS',
'                                                           ,pOcorrMat  => :P55_OCORRMATERN',
'                                                           ,pSind      => :P55_SINDICATOS',
'                                                           ,pTpPgto    => :P55_TIPOPGTO',
'                                                           ,pTempDe    => :P55_TEMPODE',
'                                                           ,pProporcSN => :P55_LST_PROPORC',
'                                                           ,pUser      => :P_USUARIO);',
'  --',
'  :P55_EXECPROPORC := NULL;',
'  :P55_LST_PROPORC := NULL;',
'END;',
'',
'',
'',
'',
'',
'',
'',
'',
'',
''))
,p_attribute_02=>'P55_EMPRESA,P55_OCORRFOLHA,P55_OCORRFERIAS,P55_OCORRMATERN,P55_SINDICATOS,P55_TIPOPGTO,P55_TEMPODE,P55_LST_PROPORC'
,p_attribute_03=>'P55_EXECPROPORC,P55_LST_PROPORC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856295747670774211)
,p_event_id=>wwv_flow_api.id(30856294759421774210)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(35301223269159359135)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856296205949774211)
,p_event_id=>wwv_flow_api.id(30856294759421774210)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_LST_PROPORC,P55_EXECPROPORC'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856296689590774211)
,p_name=>unistr('Executa Inclus\00E3o Autom\00E1tica ALL')
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_EXECAUTOMATIC'
,p_condition_element=>'P55_EXECAUTOMATIC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856297159108774211)
,p_event_id=>wwv_flow_api.id(30856296689590774211)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  pkg_AdmPessPoliticasParamCalc.prc_UpdInfFuncAllATS(pAts       => :P55_ATS',
'                                                    ,pEmp       => :P55_EMPRESAS',
'                                                    ,pOcorrFol  => :P55_OCORRFOLHA',
'                                                    ,pOcorrFer  => :P55_OCORRFERIAS',
'                                                    ,pOcorrMat  => :P55_OCORRMATERN',
'                                                    ,pSind      => :P55_SINDICATOS',
'                                                    ,pTpPgto    => :P55_TIPOPGTO',
'                                                    ,pTempDe    => :P55_TEMPODE',
'                                                    ,pUser      => :P_USUARIO);                                                           ',
'  --',
'  :P55_EXECAUTOMATIC := NULL;',
'END;',
'',
'',
'',
'',
'',
'',
'',
'',
'',
''))
,p_attribute_02=>'P55_EMPRESA,P55_OCORRFOLHA,P55_OCORRFERIAS,P55_OCORRMATERN,P55_SINDICATOS,P55_TIPOPGTO,P55_TEMPODE,P55_EXECAUTOMATIC'
,p_attribute_03=>'P55_EXECAUTOMATIC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856297682970774211)
,p_event_id=>wwv_flow_api.id(30856296689590774211)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(35301223269159359135)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856298120100774211)
,p_event_id=>wwv_flow_api.id(30856296689590774211)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_EXECAUTOMATIC'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856298581029774211)
,p_name=>'Set Executa Automatic'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33084328559739006106)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856299079760774211)
,p_event_id=>wwv_flow_api.id(30856298581029774211)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P55_EXECAUTOMATIC := ''S'';',
'END;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30669353271333172523)
,p_name=>'Show Hide Filtros'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30669353332451172524)
,p_event_id=>wwv_flow_api.id(30669353271333172523)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30669353439765172525)
,p_event_id=>wwv_flow_api.id(30669353271333172523)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_EMPRESA,P55_DATA_REF1,P55_DATA_REF2'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856335923265203006)
,p_name=>'Show Hide Filtros EF'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EF,EFCC,EFUA,EFCCCAR,EFCCCUS,EFCAR,EFCCAR,EFCMO,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856336019253203007)
,p_event_id=>wwv_flow_api.id(30856335923265203006)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_FILIAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856336139074203008)
,p_event_id=>wwv_flow_api.id(30856335923265203006)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_FILIAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858789914249979986)
,p_event_id=>wwv_flow_api.id(30856335923265203006)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_FILIAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30856336347122203010)
,p_name=>'Show Hide Filtros EFCC'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCC,EFCCCAR,ECC,EFCMO,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856336466756203011)
,p_event_id=>wwv_flow_api.id(30856336347122203010)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CCUSTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30856336584865203012)
,p_event_id=>wwv_flow_api.id(30856336347122203010)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CCUSTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858789901282979985)
,p_event_id=>wwv_flow_api.id(30856336347122203010)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CCUSTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30858722379172360485)
,p_name=>'Show Hide Filtros EFUA'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFUA,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858722464931360486)
,p_event_id=>wwv_flow_api.id(30858722379172360485)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_UNIDADM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858722598119360487)
,p_event_id=>wwv_flow_api.id(30858722379172360485)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_UNIDADM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858789720088979984)
,p_event_id=>wwv_flow_api.id(30858722379172360485)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_UNIDADM'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30858724809688360510)
,p_name=>'Show Hide Filtros ED'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ED'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858724994308360511)
,p_event_id=>wwv_flow_api.id(30858724809688360510)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_DIVISAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858725074490360512)
,p_event_id=>wwv_flow_api.id(30858724809688360510)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_DIVISAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858725148860360513)
,p_event_id=>wwv_flow_api.id(30858724809688360510)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_DIVISAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30858790156183979988)
,p_name=>'Show Hide Filtros ER'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ER'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858790350129979990)
,p_event_id=>wwv_flow_api.id(30858790156183979988)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_REGIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858790483672979991)
,p_event_id=>wwv_flow_api.id(30858790156183979988)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_REGIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858790254948979989)
,p_event_id=>wwv_flow_api.id(30858790156183979988)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_REGIONAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30858792473245980011)
,p_name=>'Show Hide Filtros EFCCCAR'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCCCAR,ECAR,EFCAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858792695137980013)
,p_event_id=>wwv_flow_api.id(30858792473245980011)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858792788844980014)
,p_event_id=>wwv_flow_api.id(30858792473245980011)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858792580669980012)
,p_event_id=>wwv_flow_api.id(30858792473245980011)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CARGO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30858942030065809388)
,p_name=>'Show Hide Filtros ECATCCUS'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ECATCCUS,EFCCCUS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858942136777809389)
,p_event_id=>wwv_flow_api.id(30858942030065809388)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CLASSCTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858942225111809390)
,p_event_id=>wwv_flow_api.id(30858942030065809388)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CLASSCTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858942401337809391)
,p_event_id=>wwv_flow_api.id(30858942030065809388)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CLASSCTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30858944581708809413)
,p_name=>'Show Hide Filtros ECATCAR'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ECATCAR,EFCCAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858944656716809414)
,p_event_id=>wwv_flow_api.id(30858944581708809413)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CLASSCGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858944706481809415)
,p_event_id=>wwv_flow_api.id(30858944581708809413)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CLASSCGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30858944832068809416)
,p_event_id=>wwv_flow_api.id(30858944581708809413)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_CLASSCGO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30859326648803904798)
,p_name=>'Show Hide Filtros EFCMO'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'EFCMO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859326798617904799)
,p_event_id=>wwv_flow_api.id(30859326648803904798)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_MAOBRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859326885270904800)
,p_event_id=>wwv_flow_api.id(30859326648803904798)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_MAOBRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859326919757904801)
,p_event_id=>wwv_flow_api.id(30859326648803904798)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_MAOBRA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30859586248736791001)
,p_name=>'Show Hide Filtros EL'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'EL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859586318788791002)
,p_event_id=>wwv_flow_api.id(30859586248736791001)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_LOCAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859586430606791003)
,p_event_id=>wwv_flow_api.id(30859586248736791001)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_LOCAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859586593229791004)
,p_event_id=>wwv_flow_api.id(30859586248736791001)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_LOCAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30859588935482791028)
,p_name=>'Show Hide Filtros EU'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P55_HISTOCORR'
,p_condition_element=>'P55_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'EU'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859685460429231680)
,p_event_id=>wwv_flow_api.id(30859588935482791028)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_UNIDNEG'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859685602537231681)
,p_event_id=>wwv_flow_api.id(30859588935482791028)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_UNIDNEG'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30859685387951231679)
,p_event_id=>wwv_flow_api.id(30859588935482791028)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P55_UNIDNEG'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28426454609087899684)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>250
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28426455532136899688)
,p_event_id=>wwv_flow_api.id(28426454609087899684)
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
'  apex.item("P55_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P55_USER_PROMPT").setValue("Analise os dados dos comparativos de hist\00F3ricos financeiros a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28426455086230899688)
,p_event_id=>wwv_flow_api.id(28426454609087899684)
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
'  v_region_static_id varchar2(100) := :P55_STATIC_ID_IR; --''IR_REGION'';',
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
'  v_user_prompt := :P55_USER_PROMPT;  --''Analise os dados a seguir.'';',
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
'  :P55_flg := v_status;',
'  :P55_msg := v_mensagem;',
'',
'END;'))
,p_attribute_02=>'P55_STATIC_ID_IR,P55_USER_PROMT'
,p_attribute_03=>'P55_FLG,P55_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(10813218860383997821)
,p_name=>unistr('Expandir IR ap\00F3s Pesquisa')
,p_event_sequence=>260
,p_condition_element=>'P55_PESQUISA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10813219242600997821)
,p_event_id=>wwv_flow_api.id(10813218860383997821)
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
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(30859746003904577327)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set MONRRRR'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P55_MONRRRR_1 := TO_CHAR(TO_DATE(:P55_DATA_REF1, ''DD/MM/RRRR''), ''MON/RRRR'');',
'  :P55_MONRRRR_2 := TO_CHAR(TO_DATE(:P55_DATA_REF2, ''DD/MM/RRRR''), ''MON/RRRR'');',
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
