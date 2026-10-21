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
--   Date and Time:   22:28 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 58
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00058
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>58);
end;
/
prompt --application/pages/page_00058
begin
wwv_flow_api.create_page(
 p_id=>58
,p_user_interface_id=>wwv_flow_api.id(57485040171637710988)
,p_name=>unistr('Comparativos de Hist\00F3ricos Financeiros - Tabular')
,p_step_title=>unistr('Comparativos de Hist\00F3ricos Financeiros - Tabular')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ConsolFolha.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(function () {',
'  // ---------- util: parse/format moeda ----------',
'  function parseNumberFromText(txt) {',
'    if (!txt && txt !== 0) return NaN;',
'    let s = String(txt).replace(/\u00A0/g, '' '').trim();',
'    if (s === '''') return NaN;',
'    s = s.replace(/[^\d\.\,\-\(\)]/g, '''');',
'    if (s === '''') return NaN;',
'    let negative = false;',
'    if (s.indexOf(''('') !== -1 && s.indexOf('')'') !== -1) {',
'      negative = true;',
'      s = s.replace(/[()]/g, '''');',
'    }',
'    if (s.indexOf(''.'') !== -1 && s.indexOf('','') !== -1) {',
'      s = s.replace(/\./g, '''').replace(/,/g, ''.'');',
'    } else if (s.indexOf('','') !== -1 && s.indexOf(''.'') === -1) {',
'      s = s.replace(/,/g, ''.'');',
'    }',
'    let n = Number(s);',
'    return negative ? -n : n;',
'  }',
'',
'  function formatTdAsCurrency(td, num) {',
'    td.textContent = num.toLocaleString(''pt-BR'', {',
'      style: ''currency'',',
'      currency: ''BRL''',
'    });',
'    td.style.textAlign = ''right'';',
'    td.style.whiteSpace = ''nowrap'';',
'    td.setAttribute(''data-apex-curr'', ''1'');',
'  }',
'',
'  function formatCurrencyInRegion(region) {',
'    try {',
'      const ths = Array.from(region.querySelectorAll(''th.a-IRR-header''));',
'      if (!ths.length) return;',
'',
'      const thsMes = ths.filter(th => {',
'        const t = th.innerText.trim();',
'        return t.includes(''/'') && /\d{2,4}/.test(t);',
'      });',
'',
'      if (!thsMes.length) return;',
'',
'      thsMes.forEach(th => {',
'        const thId = th.id;',
'        if (!thId) return;',
'',
'        const cells = region.querySelectorAll(''td[headers~="'' + thId + ''"]'');',
'        cells.forEach(td => {',
'          if (td.getAttribute(''data-apex-curr'') === ''1'') return;',
'          const n = parseNumberFromText(td.innerText.trim());',
'          if (!isNaN(n)) formatTdAsCurrency(td, n);',
'        });',
'      });',
'',
'    } catch (e) {',
'      console.error(''Erro formatCurrencyInRegion:'', e);',
'    }',
'  }',
'',
unistr('  // ---------- \00CDcones S / N ----------'),
'  const colunasAlvo = [',
'    "Incide INSS",',
'    "Incide FGTS",',
'    "Incide IR",',
unistr('    "Incide L\00EDquido"'),
'  ];',
'',
'  function findThByText(region, textoProcurado) {',
'    const ths = Array.from(region.querySelectorAll(''th''));',
'    const tLower = textoProcurado.trim().toLowerCase();',
'    for (let th of ths) {',
'      const txt = th.textContent.trim().toLowerCase().replace(/\s+/g, '' '');',
'      if (txt === tLower) return th;',
'      if (txt.includes(tLower)) return th;',
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
'            td.innerHTML = "<span class=''fa fa-check-square-o'' style=''color:green;font-size:16px''></span>";',
'            td.setAttribute(''data-orig'', ''S'');',
'          } else {',
'            td.innerHTML = "";',
'            td.removeAttribute(''data-orig'');',
'          }',
'        });',
'      });',
'    } catch (e) {',
'      console.error(''Erro aplicarIconesNaRegiao:'', e);',
'    }',
'  }',
'',
unistr('  // ---------- Aplicar nas regi\00F5es ----------'),
'  function aplicarEmTodasAsRegioes() {',
'    const regioes = document.querySelectorAll(''.t-IRR-region'');',
'    regioes.forEach(region => {',
unistr('      // limpa flags de formata\00E7\00E3o anterior'),
'      region.querySelectorAll(''td[data-apex-curr="1"]'').forEach(td => td.removeAttribute(''data-apex-curr''));',
'      formatCurrencyInRegion(region);',
'      aplicarIconesNaRegiao(region);',
'    });',
'  }',
'',
'  // on load',
'  document.addEventListener(''DOMContentLoaded'', function () {',
'    setTimeout(aplicarEmTodasAsRegioes, 150);',
'  });',
'',
'  // ao atualizar qualquer IR',
'  apex.jQuery(document).on(''apexafterrefresh'', ''.t-IRR-region'', function (e) {',
'    const region = e.target;',
'    if (!region) return;',
'    region.querySelectorAll(''td[data-apex-curr="1"]'').forEach(td => td.removeAttribute(''data-apex-curr''));',
'    setTimeout(function () {',
'      formatCurrencyInRegion(region);',
'      aplicarIconesNaRegiao(region);',
'    }, 80);',
'  });',
'',
unistr('  // caso o script seja executado ap\00F3s o carregamento do DOM'),
'  if (document.readyState === ''complete'' || document.readyState === ''interactive'') {',
'    setTimeout(aplicarEmTodasAsRegioes, 150);',
'  }',
'',
'})();',
''))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ConsolFolha.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}',
'/*',
'#REP1 .t-fht-thead{',
'    overflow: auto !important ;',
'}*/'))
,p_step_template=>wwv_flow_api.id(57484998059769710817)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20261013222756'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10818753110074028125)
,p_plug_name=>'4 - Empresa/Filial/Unid. Adm. - EFUA  '
,p_region_name=>'IR_4'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr3 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr3 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'    RETURN ''',
'    SELECT',
'        cod_empresa,',
'        nome_empresa,',
'        filial,',
'        nome_filial,',
'        unidade_adm,',
'        desc_unidade_adm,',
'        cod_ocorr,',
'        nome_cod_ocorr,',
'        cod_gerencial,',
'        nome_cod_gerencial,',
'        "Horas Ferias",',
'        "Origem",         ',
'        "Incid INSS",',
'        "Incid FGTS",',
'        "Incid IR",',
unistr('        "Incid l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.unidade_adm,',
'            x.desc_unidade_adm,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",          ',
'            (SELECT p.incid_iapas ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
'                AND p.cod = x.cod_ocorr) AS "Incid INSS",',
'            (SELECT p.incid_ir ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
'                AND p.cod = x.cod_ocorr) AS "Incid FGTS",',
'            (SELECT p.incid_fgts ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
'                AND p.cod = x.cod_ocorr) AS "Incid IR",',
'            (SELECT p.incid_liq ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
unistr('                AND p.cod = x.cod_ocorr) AS "Incid l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr3 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_FILIAL IS NULL ',
'                OR x.filial IN (',
'                      SELECT COLUMN_VALUE',
'                        FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'                ))',
'          AND (:P58_UNIDADM IS NULL',
'                OR x.unidade_adm IN (',
'                      SELECT COLUMN_VALUE',
'                        FROM TABLE(APEX_STRING.split(:P58_UNIDADM, '''':'''')) ',
'                ))',
'          AND (x.cod_ocorr = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, unidade_adm, cod_ocorr, cod_gerencial',
'    '';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFUA'''
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
 p_id=>wwv_flow_api.id(10818753293576028127)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1387823221647798507
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818753418862028128)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818754599287028140)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818754676451028141)
,p_db_column_name=>'Origem'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818754788631028142)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818754949145028143)
,p_db_column_name=>'FILIAL'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818754993315028144)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755281524028147)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755451408028148)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755485924028149)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755632443028150)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755751064028151)
,p_db_column_name=>'Incid INSS'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755848803028152)
,p_db_column_name=>'Incid FGTS'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818755915488028153)
,p_db_column_name=>'Incid IR'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818756015719028154)
,p_db_column_name=>unistr('Incid l\00EDquido')
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10818756450405028158)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861394268239946)
,p_db_column_name=>'DT01'
,p_display_order=>320
,p_column_identifier=>'AJ'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861480309239947)
,p_db_column_name=>'DT02'
,p_display_order=>330
,p_column_identifier=>'AK'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861612058239948)
,p_db_column_name=>'DT03'
,p_display_order=>340
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861739545239949)
,p_db_column_name=>'DT04'
,p_display_order=>350
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861851871239950)
,p_db_column_name=>'DT05'
,p_display_order=>360
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861925247239951)
,p_db_column_name=>'DT06'
,p_display_order=>370
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862002427239952)
,p_db_column_name=>'DT07'
,p_display_order=>380
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862101674239953)
,p_db_column_name=>'DT08'
,p_display_order=>390
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862199492239954)
,p_db_column_name=>'DT09'
,p_display_order=>400
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862307562239955)
,p_db_column_name=>'DT10'
,p_display_order=>410
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862406069239956)
,p_db_column_name=>'DT11'
,p_display_order=>420
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862559221239957)
,p_db_column_name=>'DT12'
,p_display_order=>430
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862637359239958)
,p_db_column_name=>'DT13'
,p_display_order=>440
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862695260239959)
,p_db_column_name=>'DT14'
,p_display_order=>450
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862783484239960)
,p_db_column_name=>'DT15'
,p_display_order=>460
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822862968122239961)
,p_db_column_name=>'DT16'
,p_display_order=>470
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863025826239962)
,p_db_column_name=>'DT17'
,p_display_order=>480
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863079216239963)
,p_db_column_name=>'DT18'
,p_display_order=>490
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823800425475173070)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>500
,p_column_identifier=>'BB'
,p_column_label=>'Unidade Adm.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824361774682514921)
,p_db_column_name=>'DESC_UNIDADE_ADM'
,p_display_order=>510
,p_column_identifier=>'BC'
,p_column_label=>'Nome Unidade Adm.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10822941972265349725)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'13920120'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:UNIDADE_ADM:DESC_UNIDADE_ADM:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:Origem:Incid INSS:Incid FGTS:Incid IR:Incid l\00EDquido:Tipo Rubrica:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08')
||':DT07:DT06:DT05:DT04:DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10820400962435631139)
,p_plug_name=>'1 - Empresa - E'
,p_region_name=>'IR_1'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE         ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr4 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr4 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'           ',
'    RETURN ''    SELECT',
'        cod_empresa,',
'        nome_empresa,',
'        cod_ocorr,',
'        nome_cod_ocorr,',
'        cod_gerencial,',
'        nome_cod_gerencial,',
'        origem,',
'        "Incid INSS",',
'        "Incid FGTS",',
'        "Incid IR",',
unistr('        "Incid l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            x.nome_cod_gerencial,',
'            (SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "Incid INSS",',
'            (SELECT p.incid_ir    FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "Incid FGTS",',
'            (SELECT p.incid_fgts  FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "Incid IR",',
unistr('            (SELECT p.incid_liq   FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "Incid l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'            ,x.horas_ferias',
'            ,(CASE x.horas_ferias',
unistr('                WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('                WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'                WHEN 326 THEN ''''Folha''''',
unistr('                WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('                WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'                WHEN 318 THEN ''''Adiantamento''''',
'              END) origem',
'        FROM tb_ocorr4 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (x.cod_ocorr = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY cod_empresa, cod_ocorr',
'    '';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P58_EMPRESA,P58_DATA_REF1,P58_DATA_REF2,P58_CODAUX'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''E'''
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
 p_id=>wwv_flow_api.id(10820401096107631141)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>1389471024179401521
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820401181866631142)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820401282114631143)
,p_db_column_name=>'ORIGEM'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820402724999631157)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>160
,p_column_identifier=>'C'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820402815894631158)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>170
,p_column_identifier=>'D'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820402890465631159)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>180
,p_column_identifier=>'E'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403023496631160)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>190
,p_column_identifier=>'F'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403153474631161)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>200
,p_column_identifier=>'G'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403252229631162)
,p_db_column_name=>'Incid INSS'
,p_display_order=>210
,p_column_identifier=>'H'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403318395631163)
,p_db_column_name=>'Incid FGTS'
,p_display_order=>220
,p_column_identifier=>'I'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403459246631164)
,p_db_column_name=>'Incid IR'
,p_display_order=>230
,p_column_identifier=>'J'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403552882631165)
,p_db_column_name=>unistr('Incid l\00EDquido')
,p_display_order=>240
,p_column_identifier=>'K'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10820403883684631169)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>280
,p_column_identifier=>'L'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821086526351726822)
,p_db_column_name=>'DT01'
,p_display_order=>290
,p_column_identifier=>'M'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821086583049726823)
,p_db_column_name=>'DT02'
,p_display_order=>300
,p_column_identifier=>'N'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821086729352726824)
,p_db_column_name=>'DT03'
,p_display_order=>310
,p_column_identifier=>'O'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821086832445726825)
,p_db_column_name=>'DT04'
,p_display_order=>320
,p_column_identifier=>'P'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821086913998726826)
,p_db_column_name=>'DT05'
,p_display_order=>330
,p_column_identifier=>'Q'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087065351726827)
,p_db_column_name=>'DT06'
,p_display_order=>340
,p_column_identifier=>'R'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087074508726828)
,p_db_column_name=>'DT07'
,p_display_order=>350
,p_column_identifier=>'S'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087242786726829)
,p_db_column_name=>'DT08'
,p_display_order=>360
,p_column_identifier=>'T'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087344199726830)
,p_db_column_name=>'DT09'
,p_display_order=>370
,p_column_identifier=>'U'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087457347726831)
,p_db_column_name=>'DT10'
,p_display_order=>380
,p_column_identifier=>'V'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087485594726832)
,p_db_column_name=>'DT11'
,p_display_order=>390
,p_column_identifier=>'W'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087584617726833)
,p_db_column_name=>'DT12'
,p_display_order=>400
,p_column_identifier=>'X'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087720349726834)
,p_db_column_name=>'DT13'
,p_display_order=>410
,p_column_identifier=>'Y'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087848192726835)
,p_db_column_name=>'DT14'
,p_display_order=>420
,p_column_identifier=>'Z'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087969735726836)
,p_db_column_name=>'DT15'
,p_display_order=>430
,p_column_identifier=>'AA'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821087999856726837)
,p_db_column_name=>'DT16'
,p_display_order=>440
,p_column_identifier=>'AB'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821088102412726838)
,p_db_column_name=>'DT17'
,p_display_order=>450
,p_column_identifier=>'AC'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821088227417726839)
,p_db_column_name=>'DT18'
,p_display_order=>460
,p_column_identifier=>'AD'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(10821107294947740139)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'13901773'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_EMPRESA:NOME_EMPRESA:COD_OCORR:NOME_COD_OCORR:COD_GERENCIAL:NOME_COD_GERENCIAL:ORIGEM:Incid INSS:Incid FGTS:Incid IR:Incid l\00EDquido:Tipo Rubrica:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426271553181397175)
,p_plug_name=>unistr('5 - Empresa/Divis\00E3o - ED ')
,p_region_name=>'IR_5'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE    ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr5 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr5 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        cod_divisao                     AS divisao,',
'        desc_cod_divisao                AS nome_divisao,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",       ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.cod_divisao,',
'            x.desc_cod_divisao,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr5 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_DIVISAO IS NULL OR ',
'                x.cod_divisao IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_DIVISAO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY cod_divisao, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''ED'''
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
 p_id=>wwv_flow_api.id(28426271705799397176)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237285056980400618
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426271804894397177)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426271871497397178)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426271982710397179)
,p_db_column_name=>'DIVISAO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Divisao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272072967397180)
,p_db_column_name=>'NOME_DIVISAO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Divisao'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272153695397181)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Ocorrencia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272262230397182)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Ocorrencia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272353890397183)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272510440397184)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525631974770332)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>90
,p_column_identifier=>'BL'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525762312770333)
,p_db_column_name=>'Origem'
,p_display_order=>100
,p_column_identifier=>'BM'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272563657397185)
,p_db_column_name=>'Incide INSS'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272737591397186)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272761130397187)
,p_db_column_name=>'Incide IR'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426272932657397188)
,p_db_column_name=>unistr('Incide l\00EDquido')
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753561639946940)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>150
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863222211239964)
,p_db_column_name=>'DT01'
,p_display_order=>160
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863305409239965)
,p_db_column_name=>'DT02'
,p_display_order=>170
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863413197239966)
,p_db_column_name=>'DT03'
,p_display_order=>180
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863521288239967)
,p_db_column_name=>'DT04'
,p_display_order=>190
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863644926239968)
,p_db_column_name=>'DT05'
,p_display_order=>200
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863755496239969)
,p_db_column_name=>'DT06'
,p_display_order=>210
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822863846383239970)
,p_db_column_name=>'DT07'
,p_display_order=>220
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823524564838770321)
,p_db_column_name=>'DT08'
,p_display_order=>230
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823524577692770322)
,p_db_column_name=>'DT09'
,p_display_order=>240
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823524753143770323)
,p_db_column_name=>'DT10'
,p_display_order=>250
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823524774847770324)
,p_db_column_name=>'DT11'
,p_display_order=>260
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823524897955770325)
,p_db_column_name=>'DT12'
,p_display_order=>270
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525047138770326)
,p_db_column_name=>'DT13'
,p_display_order=>280
,p_column_identifier=>'BF'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525079417770327)
,p_db_column_name=>'DT14'
,p_display_order=>290
,p_column_identifier=>'BG'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525200036770328)
,p_db_column_name=>'DT15'
,p_display_order=>300
,p_column_identifier=>'BH'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525304313770329)
,p_db_column_name=>'DT16'
,p_display_order=>310
,p_column_identifier=>'BI'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525394762770330)
,p_db_column_name=>'DT17'
,p_display_order=>320
,p_column_identifier=>'BJ'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525475221770331)
,p_db_column_name=>'DT18'
,p_display_order=>330
,p_column_identifier=>'BK'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426305504793508369)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12373189'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:DIVISAO:NOME_DIVISAO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Incide INSS:Incide FGTS:Incide IR:Incide l\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT')
||'01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426274068764397200)
,p_plug_name=>'6 - Empresa/Regional - ER '
,p_region_name=>'IR_6'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE    ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr5 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr5 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        cod_regional                    AS regional,',
'        desc_cod_regional               AS nome_regional,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",         ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.cod_regional,',
'            x.desc_cod_regional,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr6 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_REGIONAL IS NULL OR ',
'                x.cod_regional IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_REGIONAL, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY cod_regional, cod_ocorr, cod_gerencial',
''';',
'END;',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''ER'''
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
 p_id=>wwv_flow_api.id(28426274232538397201)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237287583719400643
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274294220397202)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274369978397203)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274514543397204)
,p_db_column_name=>'REGIONAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Regional'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274573863397205)
,p_db_column_name=>'NOME_REGIONAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Regional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274675641397206)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Ocorrencia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274768183397207)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Ocorrencia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426274889565397208)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426306258373518659)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426306364864518660)
,p_db_column_name=>'Incide INSS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426306495954518661)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426306557103518662)
,p_db_column_name=>'Incide IR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426306728819518663)
,p_db_column_name=>unistr('Incide l\00EDquido')
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753509045946939)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>130
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525835358770334)
,p_db_column_name=>'DT01'
,p_display_order=>140
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525969621770335)
,p_db_column_name=>'DT02'
,p_display_order=>150
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823525973006770336)
,p_db_column_name=>'DT03'
,p_display_order=>160
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526103087770337)
,p_db_column_name=>'DT04'
,p_display_order=>170
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526233209770338)
,p_db_column_name=>'DT05'
,p_display_order=>180
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526323869770339)
,p_db_column_name=>'DT06'
,p_display_order=>190
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526443194770340)
,p_db_column_name=>'DT07'
,p_display_order=>200
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526497819770341)
,p_db_column_name=>'DT08'
,p_display_order=>210
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526619659770342)
,p_db_column_name=>'DT09'
,p_display_order=>220
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526673292770343)
,p_db_column_name=>'DT10'
,p_display_order=>230
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526855805770344)
,p_db_column_name=>'DT11'
,p_display_order=>240
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526941014770345)
,p_db_column_name=>'DT12'
,p_display_order=>250
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823526997987770346)
,p_db_column_name=>'DT13'
,p_display_order=>260
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527081050770347)
,p_db_column_name=>'DT14'
,p_display_order=>270
,p_column_identifier=>'BF'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527186497770348)
,p_db_column_name=>'DT15'
,p_display_order=>280
,p_column_identifier=>'BG'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527313819770349)
,p_db_column_name=>'DT16'
,p_display_order=>290
,p_column_identifier=>'BH'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527460523770350)
,p_db_column_name=>'DT17'
,p_display_order=>300
,p_column_identifier=>'BI'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527510283770351)
,p_db_column_name=>'DT18'
,p_display_order=>310
,p_column_identifier=>'BJ'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527621280770352)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>320
,p_column_identifier=>'BK'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527690679770353)
,p_db_column_name=>'Origem'
,p_display_order=>330
,p_column_identifier=>'BL'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426324141782527757)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12373375'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:REGIONAL:NOME_REGIONAL:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Incide INSS:Incide FGTS:Incide IR:Incide l\00EDquido:DT18:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT17:DT04:DT03:DT02:')
||'DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426307944182518675)
,p_plug_name=>'7 - Empresa/Filial/CCusto/Cargo- EFCCCAR '
,p_region_name=>'IR_7'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE     ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr7 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr7 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'    RETURN ''',
'    SELECT',
'        cod_empresa                   AS empresa,',
'        nome_empresa                  AS nome_empresa,',
'        filial                        AS filial,',
'        nome_filial                   AS nome_filial,',
'        cod_ccusto                    AS centro_de_custo,',
'        nome_ccusto                   AS nome_centro_de_custo,',
'        class_ccusto                  AS classe_centro_custo,',
'        desc_class_ccusto             AS descricao_classe_ccusto,',
'        cargo                         AS cargo,',
'        nome_cargo                    AS nome_cargo,',
'        class_cargo                   AS classe_cargo,',
'        desc_class_cargo              AS descricao_classe_cargo,',
'        cod_ocorr                     AS ocorrencia,',
'        nome_cod_ocorr                AS nome_ocorrencia,',
'        cod_gerencial                 AS gerencial,',
'        nome_cod_gerencial            AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",         ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.cod_ccusto,',
'            x.nome_ccusto,',
'            x.class_ccusto,',
'            x.desc_class_ccusto,',
'            x.cargo,',
'            x.nome_cargo,',
'            x.class_cargo,',
'            x.desc_class_cargo,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr7 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_FILIAL IS NULL OR ',
'               x.filial IN (',
'                   SELECT COLUMN_VALUE',
'                     FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ))',
'          AND (:P58_CCUSTO IS NULL OR ',
'               x.cod_ccusto IN (',
'                   SELECT COLUMN_VALUE',
'                     FROM TABLE(APEX_STRING.split(:P58_CCUSTO, '''':'''')) ))',
'          AND (:P58_CARGO IS NULL OR ',
'               x.cargo IN (',
'                   SELECT COLUMN_VALUE',
'                     FROM TABLE(APEX_STRING.split(:P58_CARGO, '''':'''')) ))',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, cod_ccusto, class_ccusto, cargo, class_cargo, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFCCCAR'''
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
 p_id=>wwv_flow_api.id(28426307990808518676)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237321341989522118
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308093668518677)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308206402518678)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308310164518679)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308427268518680)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308547591518681)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308573960518682)
,p_db_column_name=>'NOME_CENTRO_DE_CUSTO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308654451518683)
,p_db_column_name=>'CLASSE_CENTRO_CUSTO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Classe Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308845331518684)
,p_db_column_name=>'DESCRICAO_CLASSE_CCUSTO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Classe Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426308884234518685)
,p_db_column_name=>'CARGO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309035468518686)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309088834518687)
,p_db_column_name=>'CLASSE_CARGO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Classe Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309225197518688)
,p_db_column_name=>'DESCRICAO_CLASSE_CARGO'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Nome Classe Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309344464518689)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309376503518690)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309548050518691)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309635381518692)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309721503518693)
,p_db_column_name=>'Incide INSS'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309824292518694)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309870846518695)
,p_db_column_name=>'Incide IR'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426309965006518696)
,p_db_column_name=>unistr('Incide l\00EDquido')
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753360842946938)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527772730770354)
,p_db_column_name=>'DT01'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823527885137770355)
,p_db_column_name=>'DT02'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528001324770356)
,p_db_column_name=>'DT03'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528160080770357)
,p_db_column_name=>'DT04'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528187746770358)
,p_db_column_name=>'DT05'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528277206770359)
,p_db_column_name=>'DT06'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528416044770360)
,p_db_column_name=>'DT07'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528565908770361)
,p_db_column_name=>'DT08'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528663533770362)
,p_db_column_name=>'DT09'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528699041770363)
,p_db_column_name=>'DT10'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528824869770364)
,p_db_column_name=>'DT11'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823528883491770365)
,p_db_column_name=>'DT12'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823529003438770366)
,p_db_column_name=>'DT13'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823529110528770367)
,p_db_column_name=>'DT14'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823529205098770368)
,p_db_column_name=>'DT15'
,p_display_order=>430
,p_column_identifier=>'BF'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823529308974770369)
,p_db_column_name=>'DT16'
,p_display_order=>440
,p_column_identifier=>'BG'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823529439388770370)
,p_db_column_name=>'DT17'
,p_display_order=>450
,p_column_identifier=>'BH'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588239862866521)
,p_db_column_name=>'DT18'
,p_display_order=>460
,p_column_identifier=>'BI'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588303181866522)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>470
,p_column_identifier=>'BJ'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588405402866523)
,p_db_column_name=>'Origem'
,p_display_order=>480
,p_column_identifier=>'BK'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426341337595585954)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12373547'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CENTRO_DE_CUSTO:NOME_CENTRO_DE_CUSTO:CLASSE_CENTRO_CUSTO:DESCRICAO_CLASSE_CCUSTO:CARGO:NOME_CARGO:CLASSE_CARGO:DESCRICAO_CLASSE_CARGO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Inci'
||unistr('de INSS:Incide FGTS:Incide IR:Incide l\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426311237019518708)
,p_plug_name=>'8 - Empresa/CCusto- ECC '
,p_region_name=>'IR_8'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE     ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'    ',
'',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr8 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr8 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
' SELECT cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        cod_ccusto                      AS centro_de_custo,',
'        nome_ccusto                     AS nome_centro_de_custo,',
'        class_ccusto                    AS classe_centro_custo,',
'        desc_class_ccusto               AS desc_classe_centro_custo,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",         ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.cod_ccusto,',
'            x.nome_ccusto,',
'            x.class_ccusto,',
'            x.desc_class_ccusto,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr8 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_CCUSTO IS NULL OR ',
'                x.cod_ccusto IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_CCUSTO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY cod_ccusto, class_ccusto, cod_ocorr, cod_gerencial',
''';',
'',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''ECC'''
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
 p_id=>wwv_flow_api.id(28426344073325631859)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237357424506635301
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344235267631860)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344278317631861)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344388334631862)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Centro De Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344499518631863)
,p_db_column_name=>'NOME_CENTRO_DE_CUSTO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Centro De Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344624165631864)
,p_db_column_name=>'CLASSE_CENTRO_CUSTO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Classe Centro Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344711663631865)
,p_db_column_name=>'DESC_CLASSE_CENTRO_CUSTO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Desc Classe Centro Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344757944631866)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Ocorrencia'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426344864980631867)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Ocorrencia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426345004157631868)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426345069366631869)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426345188164631870)
,p_db_column_name=>'Incide INSS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426345330684631871)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426345372959631872)
,p_db_column_name=>'Incide IR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426345534806631873)
,p_db_column_name=>unistr('Incide l\00EDquido')
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753272340946937)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588500956866524)
,p_db_column_name=>'DT01'
,p_display_order=>230
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588574633866525)
,p_db_column_name=>'DT02'
,p_display_order=>240
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588730777866526)
,p_db_column_name=>'DT03'
,p_display_order=>250
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588772019866527)
,p_db_column_name=>'DT04'
,p_display_order=>260
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588892309866528)
,p_db_column_name=>'DT05'
,p_display_order=>270
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823588975337866529)
,p_db_column_name=>'DT06'
,p_display_order=>280
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589149339866530)
,p_db_column_name=>'DT07'
,p_display_order=>290
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589225462866531)
,p_db_column_name=>'DT08'
,p_display_order=>300
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589349025866532)
,p_db_column_name=>'DT09'
,p_display_order=>310
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589419179866533)
,p_db_column_name=>'DT10'
,p_display_order=>320
,p_column_identifier=>'BF'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589479078866534)
,p_db_column_name=>'DT11'
,p_display_order=>330
,p_column_identifier=>'BG'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589648635866535)
,p_db_column_name=>'DT12'
,p_display_order=>340
,p_column_identifier=>'BH'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589677187866536)
,p_db_column_name=>'DT13'
,p_display_order=>350
,p_column_identifier=>'BI'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589775020866537)
,p_db_column_name=>'DT14'
,p_display_order=>360
,p_column_identifier=>'BJ'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589933198866538)
,p_db_column_name=>'DT15'
,p_display_order=>370
,p_column_identifier=>'BK'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823589978236866539)
,p_db_column_name=>'DT16'
,p_display_order=>380
,p_column_identifier=>'BL'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590110757866540)
,p_db_column_name=>'DT17'
,p_display_order=>390
,p_column_identifier=>'BM'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590192462866541)
,p_db_column_name=>'DT18'
,p_display_order=>400
,p_column_identifier=>'BN'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590272271866542)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>410
,p_column_identifier=>'BO'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590410999866543)
,p_db_column_name=>'Origem'
,p_display_order=>420
,p_column_identifier=>'BP'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426363858598645028)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12373773'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:CENTRO_DE_CUSTO:NOME_CENTRO_DE_CUSTO:CLASSE_CENTRO_CUSTO:DESC_CLASSE_CENTRO_CUSTO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Incide INSS:Incide FGTS:Incide IR:Incide l\00EDquido:DT18:DT17:DT16:DT15:DT14:D')
||'T13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426346656215631885)
,p_plug_name=>'9 - Empresa/Cargo - ECAR '
,p_region_name=>'IR_9'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE     ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr9 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr9 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        cargo                           AS cargo,',
'        nome_cargo                      AS nome_cargo,',
'        class_cargo                     AS classe_cargo,',
'        desc_class_cargo                AS desc_classe_cargo,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",         ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.cargo,',
'            x.nome_cargo,',
'            x.class_cargo,',
'            x.desc_class_cargo,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr9 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_CARGO IS NULL OR ',
'                x.cargo IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_CARGO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY cargo, class_cargo, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''ECAR'''
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
 p_id=>wwv_flow_api.id(28426346848532631886)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237360199713635328
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426346885288631887)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426346956670631888)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347096760631889)
,p_db_column_name=>'CARGO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347229924631890)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347277045631891)
,p_db_column_name=>'CLASSE_CARGO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Classe Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347400847631892)
,p_db_column_name=>'DESC_CLASSE_CARGO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Classe Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347475591631893)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347608258631894)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347662861631895)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347766304631896)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347852519631897)
,p_db_column_name=>'Incide INSS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426347962449631898)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426348077126631899)
,p_db_column_name=>'Incide IR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426348175753631900)
,p_db_column_name=>unistr('Incide l\00EDquido')
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753158456946936)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590499310866544)
,p_db_column_name=>'DT01'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590652272866545)
,p_db_column_name=>'DT02'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590714468866546)
,p_db_column_name=>'DT03'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590869669866547)
,p_db_column_name=>'DT04'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590942713866548)
,p_db_column_name=>'DT05'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823590990266866549)
,p_db_column_name=>'DT06'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591080451866550)
,p_db_column_name=>'DT07'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591231277866551)
,p_db_column_name=>'DT08'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591306944866552)
,p_db_column_name=>'DT09'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591448808866553)
,p_db_column_name=>'DT10'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591512817866554)
,p_db_column_name=>'DT11'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591617060866555)
,p_db_column_name=>'DT12'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591723757866556)
,p_db_column_name=>'DT13'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591857719866557)
,p_db_column_name=>'DT14'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823591964676866558)
,p_db_column_name=>'DT15'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592035303866559)
,p_db_column_name=>'DT16'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592109059866560)
,p_db_column_name=>'DT17'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592193753866561)
,p_db_column_name=>'DT18'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592272890866562)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592462906866563)
,p_db_column_name=>'Origem'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426383599656720479)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12373970'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:CARGO:NOME_CARGO:CLASSE_CARGO:DESC_CLASSE_CARGO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Incide INSS:Incide FGTS:Incide IR:Incide l\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:')
||'DT06:DT05:DT04:DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426364961133709762)
,p_plug_name=>'10 - Empresa/Categoria CCusto - ECATCCUS '
,p_region_name=>'IR_10'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE     ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr10 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr10 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        class_ccusto                    AS classe_ccusto,',
'        desc_class_ccusto               AS desc_classe_ccusto,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.class_ccusto,',
'            x.desc_class_ccusto,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr10 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_CLASSCTO IS NULL OR ',
'                x.class_ccusto IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_CLASSCTO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY class_ccusto, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''ECATCCUS'''
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
 p_id=>wwv_flow_api.id(28426365132556709763)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237378483737713205
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365198161709764)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365278860709765)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365359135709766)
,p_db_column_name=>'CLASSE_CCUSTO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Classe Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365545776709767)
,p_db_column_name=>'DESC_CLASSE_CCUSTO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Classe Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365626128709768)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365741489709769)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365755482709770)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426365925420709771)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426366041797709772)
,p_db_column_name=>'Incide INSS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426366090675709773)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426366183551709774)
,p_db_column_name=>'Incide IR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426366313043709775)
,p_db_column_name=>unistr('Incide L\00EDquido')
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753099026946935)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592515222866564)
,p_db_column_name=>'DT01'
,p_display_order=>210
,p_column_identifier=>'AJ'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592614768866565)
,p_db_column_name=>'DT02'
,p_display_order=>220
,p_column_identifier=>'AK'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592752084866566)
,p_db_column_name=>'DT03'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592828650866567)
,p_db_column_name=>'DT04'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823592911793866568)
,p_db_column_name=>'DT05'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823593067956866569)
,p_db_column_name=>'DT06'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823593113533866570)
,p_db_column_name=>'DT07'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823795485886173021)
,p_db_column_name=>'DT08'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823795650436173022)
,p_db_column_name=>'DT09'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823795672798173023)
,p_db_column_name=>'DT10'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823795814637173024)
,p_db_column_name=>'DT11'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823795968685173025)
,p_db_column_name=>'DT12'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823795976865173026)
,p_db_column_name=>'DT13'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796074778173027)
,p_db_column_name=>'DT14'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796184403173028)
,p_db_column_name=>'DT15'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796354559173029)
,p_db_column_name=>'DT16'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796391336173030)
,p_db_column_name=>'DT17'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796490772173031)
,p_db_column_name=>'DT18'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796587970173032)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10823796757412173033)
,p_db_column_name=>'Origem'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426398627059753098)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12374120'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:CLASSE_CCUSTO:DESC_CLASSE_CCUSTO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Incide INSS:Incide FGTS:Incide IR:Incide L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:')
||'DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426367477162709787)
,p_plug_name=>'11 - Empresa/Categoria Cargo - ECATCAR '
,p_region_name=>'IR_11'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE     ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr11 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr11 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        class_cargo                     AS classe_cargo,',
'        desc_class_cargo                AS desc_classe_cargo,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "Incide INSS",',
'        "Incide FGTS",',
'        "Incide IR",',
unistr('        "Incide L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.class_cargo,',
'            x.desc_class_cargo,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",             ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide INSS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide FGTS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "Incide IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "Incide L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr11 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_CLASSCGO IS NULL OR ',
'                x.class_cargo IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_CLASSCGO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY class_cargo, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''ECATCAR'''
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
 p_id=>wwv_flow_api.id(28426367597225709788)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237380948406713230
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426367717896709789)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426367767066709790)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426367932126709791)
,p_db_column_name=>'CLASSE_CARGO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Classe Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368000317709792)
,p_db_column_name=>'DESC_CLASSE_CARGO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Classe Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368137519709793)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368207173709794)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368295942709795)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368350201709796)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368495811709797)
,p_db_column_name=>'Incide INSS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368621303709798)
,p_db_column_name=>'Incide FGTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368697776709799)
,p_db_column_name=>'Incide IR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426368753312709800)
,p_db_column_name=>unistr('Incide L\00EDquido')
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184752963828946934)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824361936109514922)
,p_db_column_name=>'DT01'
,p_display_order=>210
,p_column_identifier=>'AJ'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362039820514923)
,p_db_column_name=>'DT02'
,p_display_order=>220
,p_column_identifier=>'AK'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362157958514924)
,p_db_column_name=>'DT03'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362208651514925)
,p_db_column_name=>'DT04'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362362416514926)
,p_db_column_name=>'DT05'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362393705514927)
,p_db_column_name=>'DT06'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362509295514928)
,p_db_column_name=>'DT07'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362627856514929)
,p_db_column_name=>'DT08'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362698105514930)
,p_db_column_name=>'DT09'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362868578514931)
,p_db_column_name=>'DT10'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824362934139514932)
,p_db_column_name=>'DT11'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363038999514933)
,p_db_column_name=>'DT12'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363156485514934)
,p_db_column_name=>'DT13'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363212666514935)
,p_db_column_name=>'DT14'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363274499514936)
,p_db_column_name=>'DT15'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363464872514937)
,p_db_column_name=>'DT16'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363553589514938)
,p_db_column_name=>'DT17'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363649504514939)
,p_db_column_name=>'DT18'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363729845514940)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363852245514941)
,p_db_column_name=>'Origem'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426418244803851595)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12374316'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:CLASSE_CARGO:DESC_CLASSE_CARGO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:Incide INSS:Incide FGTS:Incide IR:Incide L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT')
||'03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426400451121837162)
,p_plug_name=>'12 - Empresa/Filial/Categoria CCusto - EFCCCUS '
,p_region_name=>'IR_12'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr13 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr13 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        filial                          AS filial,',
'        nome_filial                     AS nome_filial,',
'        class_ccusto                    AS classe_ccusto,',
'        desc_class_ccusto               AS desc_classe_ccusto,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.class_ccusto,',
'            x.desc_class_ccusto,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial)  AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr13 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_FILIAL IS NULL OR ',
'                x.filial IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'                )',
'              )',
'          AND (',
'                :P58_CLASSCTO IS NULL OR ',
'                x.class_ccusto IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_CLASSCTO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, class_ccusto, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFCCCUS'''
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
 p_id=>wwv_flow_api.id(28426400633804837163)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237413984985840605
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426400731479837164)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426400789025837165)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426400936864837166)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426400986319837167)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401107828837168)
,p_db_column_name=>'CLASSE_CCUSTO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Classe Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401158412837169)
,p_db_column_name=>'DESC_CLASSE_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Classe Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401269699837170)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401401330837171)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401544287837172)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401632429837173)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401689464837174)
,p_db_column_name=>'INSS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401764993837175)
,p_db_column_name=>'FGTS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426401944076837176)
,p_db_column_name=>'IR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426402048700837177)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184752878242946933)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824363912637514942)
,p_db_column_name=>'DT01'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364047898514943)
,p_db_column_name=>'DT02'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364097446514944)
,p_db_column_name=>'DT03'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364268223514945)
,p_db_column_name=>'DT04'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364276174514946)
,p_db_column_name=>'DT05'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364468329514947)
,p_db_column_name=>'DT06'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364554309514948)
,p_db_column_name=>'DT07'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364624707514949)
,p_db_column_name=>'DT08'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364701927514950)
,p_db_column_name=>'DT09'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364838859514951)
,p_db_column_name=>'DT10'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824364930833514952)
,p_db_column_name=>'DT11'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365013393514953)
,p_db_column_name=>'DT12'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365072500514954)
,p_db_column_name=>'DT13'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365225420514955)
,p_db_column_name=>'DT14'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365281942514956)
,p_db_column_name=>'DT15'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365459358514957)
,p_db_column_name=>'DT16'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365475932514958)
,p_db_column_name=>'DT17'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365591849514959)
,p_db_column_name=>'DT18'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570636084564268)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570750783564269)
,p_db_column_name=>'Origem'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426433079005893306)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12374465'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CLASSE_CCUSTO:DESC_CLASSE_CCUSTO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02')
||':DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426403194090837189)
,p_plug_name=>'13 - Empresa/Filial/Cargo - EFCAR '
,p_region_name=>'IR_13'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>170
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr14 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr14 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa                     AS empresa,',
'        nome_empresa                    AS nome_empresa,',
'        filial                          AS filial,',
'        nome_filial                     AS nome_filial,',
'        cargo                           AS cargo,',
'        nome_cargo                      AS nome_cargo,',
'        cod_ocorr                       AS ocorrencia,',
'        nome_cod_ocorr                  AS nome_ocorrencia,',
'        cod_gerencial                   AS gerencial,',
'        nome_cod_gerencial              AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",       ',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.cargo,',
'            x.nome_cargo,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr14 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (',
'                :P58_FILIAL IS NULL OR ',
'                x.filial IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'                )',
'              )',
'          AND (',
'                :P58_CARGO IS NULL OR ',
'                x.cargo IN (',
'                    SELECT COLUMN_VALUE',
'                      FROM TABLE(APEX_STRING.split(:P58_CARGO, '''':'''')) ',
'                )',
'              )',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, cargo, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFCAR'''
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
 p_id=>wwv_flow_api.id(28426403309697837190)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237416660878840632
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403359484837191)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403486017837192)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403560158837193)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403739174837194)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403768584837195)
,p_db_column_name=>'CARGO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403850812837196)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426403971738837197)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404077703837198)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404201321837199)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404304965837200)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404369913837201)
,p_db_column_name=>'INSS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404452769837202)
,p_db_column_name=>'FGTS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404624874837203)
,p_db_column_name=>'IR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426404689859837204)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184752779041946932)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365757793514960)
,p_db_column_name=>'DT01'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365817742514961)
,p_db_column_name=>'DT02'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824365885694514962)
,p_db_column_name=>'DT03'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366027260514963)
,p_db_column_name=>'DT04'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366138725514964)
,p_db_column_name=>'DT05'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366234320514965)
,p_db_column_name=>'DT06'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366295447514966)
,p_db_column_name=>'DT07'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366399349514967)
,p_db_column_name=>'DT08'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366494559514968)
,p_db_column_name=>'DT09'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366634146514969)
,p_db_column_name=>'DT10'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824366715148514970)
,p_db_column_name=>'DT11'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494424773535821)
,p_db_column_name=>'DT12'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494552139535822)
,p_db_column_name=>'DT13'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494631588535823)
,p_db_column_name=>'DT14'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494756888535824)
,p_db_column_name=>'DT15'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494853544535825)
,p_db_column_name=>'DT16'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494935879535826)
,p_db_column_name=>'DT17'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824494974047535827)
,p_db_column_name=>'DT18'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570791412564270)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824653491172681721)
,p_db_column_name=>'Origem'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426454596739952164)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12374680'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CARGO:NOME_CARGO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426436131412934466)
,p_plug_name=>'14 - Empresa/Filial/Class Cargo - EFCCAR '
,p_region_name=>'IR_14'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>180
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr15 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr15 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa         AS empresa,',
'        nome_empresa        AS nome_empresa,',
'        filial              AS filial,',
'        nome_filial         AS nome_filial,',
'        class_cargo         AS class_cargo,',
'        desc_class_cargo    AS desc_class_cargo,',
'        cod_ocorr           AS ocorrencia,',
'        nome_cod_ocorr      AS nome_ocorrencia,',
'        cod_gerencial       AS gerencial,',
'        nome_cod_gerencial  AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.class_cargo,',
'            x.desc_class_cargo,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr15 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_FILIAL IS NULL OR x.filial IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'              ))',
'          AND (:P58_CLASSCGO IS NULL OR x.class_cargo IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_CLASSCGO, '''':'''')) ',
'              ))',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, class_cargo, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFCCAR'''
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
 p_id=>wwv_flow_api.id(28426436179508934467)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237449530689937909
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436334028934468)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436443162934469)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436512664934470)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436635556934471)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436674445934472)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436786534934473)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426436909410934474)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437033670934475)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437104970934476)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437204188934477)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437292830934478)
,p_db_column_name=>'INSS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437426749934479)
,p_db_column_name=>'FGTS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437537627934480)
,p_db_column_name=>'IR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426437594507934481)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184752654540946931)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495127854535828)
,p_db_column_name=>'DT01'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495183110535829)
,p_db_column_name=>'DT02'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495370805535830)
,p_db_column_name=>'DT03'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495447004535831)
,p_db_column_name=>'DT04'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495500118535832)
,p_db_column_name=>'DT05'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495630617535833)
,p_db_column_name=>'DT06'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495752048535834)
,p_db_column_name=>'DT07'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495868795535835)
,p_db_column_name=>'DT08'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824495913780535836)
,p_db_column_name=>'DT09'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496011001535837)
,p_db_column_name=>'DT10'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496150577535838)
,p_db_column_name=>'DT11'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496235887535839)
,p_db_column_name=>'DT12'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496293289535840)
,p_db_column_name=>'DT13'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496375888535841)
,p_db_column_name=>'DT14'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496500011535842)
,p_db_column_name=>'DT15'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496662887535843)
,p_db_column_name=>'DT16'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496708197535844)
,p_db_column_name=>'DT17'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496868601535845)
,p_db_column_name=>'DT18'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824653646371681722)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824653704743681723)
,p_db_column_name=>'Origem'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426469025378008322)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12374824'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:CLASS_CARGO:DESC_CLASS_CARGO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT0')
||'1:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426438761497934493)
,p_plug_name=>unistr('15 - Empresa/Filial/M\00E3o Obra/CCusto - EFCMO ')
,p_region_name=>'IR_15'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>190
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr17 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr17 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          );',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa           AS empresa,',
'        nome_empresa          AS nome_empresa,',
'        filial                AS filial,',
'        nome_filial           AS nome_filial,',
'        cod_tipo_mao_obra     AS tipo_mao_obra,',
'        desc_cod_tp_mao_obra  AS desc_tipo_mao_obra,',
'        cod_ccusto            AS ccusto,',
'        nome_ccusto           AS nome_ccusto,',
'        class_ccusto          AS class_ccusto,',
'        desc_class_ccusto     AS desc_class_ccusto,',
'        cod_ocorr             AS ocorrencia,',
'        nome_cod_ocorr        AS nome_ocorrencia,',
'        cod_gerencial         AS gerencial,',
'        nome_cod_gerencial    AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.cod_tipo_mao_obra,',
'            x.desc_cod_tp_mao_obra,',
'            x.cod_ccusto,',
'            x.nome_ccusto,',
'            x.class_ccusto,',
'            x.desc_class_ccusto,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",             ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr17 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_FILIAL IS NULL OR x.filial IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'              ))',
'          AND (:P58_MAOBRA IS NULL OR x.cod_tipo_mao_obra IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_MAOBRA, '''':'''')) ',
'              ))',
'          AND (:P58_CCUSTO IS NULL OR x.cod_ccusto IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_CCUSTO, '''':'''')) ',
'              ))',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, cod_tipo_mao_obra, cod_ccusto, class_ccusto, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFCMO'''
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
 p_id=>wwv_flow_api.id(28426438926451934494)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237452277632937936
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439028376934495)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439084291934496)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439169517934497)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439342565934498)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439417007934499)
,p_db_column_name=>'TIPO_MAO_OBRA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Tipo M\00E3o de Obra')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439463887934500)
,p_db_column_name=>'DESC_TIPO_MAO_OBRA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Tipo M\00E3o de Obra')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439568165934501)
,p_db_column_name=>'CCUSTO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439679874934502)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439781037934503)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426439868081934504)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Nome Classifica\00E7\00E3o Centro de Custo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426440045869934505)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426440131066934506)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426440159717934507)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426440327633934508)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426469822187022059)
,p_db_column_name=>'INSS'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426469920052022060)
,p_db_column_name=>'FGTS'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426469970066022061)
,p_db_column_name=>'IR'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426470079509022062)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184752556846946930)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824496926434535846)
,p_db_column_name=>'DT01'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497059638535847)
,p_db_column_name=>'DT02'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497108878535848)
,p_db_column_name=>'DT03'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497195435535849)
,p_db_column_name=>'DT04'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497346699535850)
,p_db_column_name=>'DT05'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497433878535851)
,p_db_column_name=>'DT06'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497482364535852)
,p_db_column_name=>'DT07'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497575999535853)
,p_db_column_name=>'DT08'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497729436535854)
,p_db_column_name=>'DT09'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497814164535855)
,p_db_column_name=>'DT10'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824497951040535856)
,p_db_column_name=>'DT11'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498060271535857)
,p_db_column_name=>'DT12'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498121857535858)
,p_db_column_name=>'DT13'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498260964535859)
,p_db_column_name=>'DT14'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498358627535860)
,p_db_column_name=>'DT15'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498393536535861)
,p_db_column_name=>'DT16'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498551087535862)
,p_db_column_name=>'DT17'
,p_display_order=>430
,p_column_identifier=>'BF'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498658674535863)
,p_db_column_name=>'DT18'
,p_display_order=>440
,p_column_identifier=>'BG'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824653793365681724)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>450
,p_column_identifier=>'BH'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824653947191681725)
,p_db_column_name=>'Origem'
,p_display_order=>460
,p_column_identifier=>'BI'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426489249349043331)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12375027'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:TIPO_MAO_OBRA:DESC_TIPO_MAO_OBRA:CCUSTO:NOME_CCUSTO:CLASS_CCUSTO:DESC_CLASS_CCUSTO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12')
||':DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426471253752022074)
,p_plug_name=>'16 - Empresa/Filial/Unidade Adm/CCusto - EFUCC  '
,p_region_name=>'IR_16'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>200
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr18 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr18 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          );',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa        AS empresa,',
'        nome_empresa       AS nome_empresa,',
'        filial             AS filial,',
'        nome_filial        AS nome_filial,',
'        unidade_adm        AS unidade_adm,',
'        desc_unidade_adm   AS desc_unidade_adm,',
'        cod_ccusto         AS ccusto,',
'        nome_ccusto        AS nome_ccusto,',
'        cod_ocorr          AS ocorrencia,',
'        nome_cod_ocorr     AS nome_ocorrencia,',
'        cod_gerencial      AS gerencial,',
'        nome_cod_gerencial AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.unidade_adm,',
'            x.desc_unidade_adm,',
'            x.cod_ccusto,',
'            x.nome_ccusto,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr18 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_FILIAL  IS NULL OR x.filial IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'              ))',
'          AND (:P58_UNIDADM IS NULL OR x.unidade_adm IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_UNIDADM, '''':'''')) ',
'              ))',
'          AND (:P58_CCUSTO  IS NULL OR x.cod_ccusto IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_CCUSTO, '''':'''')) ',
'              ))',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, unidade_adm, cod_ccusto, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFUCC'''
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
 p_id=>wwv_flow_api.id(28426471401977022075)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237484753158025517
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426471496876022076)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426471565360022077)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426471722457022078)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426471780643022079)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426471857360022080)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Unidade Administrativa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472014653022081)
,p_db_column_name=>'DESC_UNIDADE_ADM'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Unidade Administrativa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472131175022082)
,p_db_column_name=>'CCUSTO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472224909022083)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472309107022084)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472389639022085)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472516385022086)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472634591022087)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472651165022088)
,p_db_column_name=>'INSS'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472753604022089)
,p_db_column_name=>'FGTS'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472910135022090)
,p_db_column_name=>'IR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426472990208022091)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184752420585946929)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498767835535864)
,p_db_column_name=>'DT01'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498774472535865)
,p_db_column_name=>'DT02'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498957185535866)
,p_db_column_name=>'DT03'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824498976625535867)
,p_db_column_name=>'DT04'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824499131773535868)
,p_db_column_name=>'DT05'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824499271857535869)
,p_db_column_name=>'DT06'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824499303529535870)
,p_db_column_name=>'DT07'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824565961647564221)
,p_db_column_name=>'DT08'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824565988465564222)
,p_db_column_name=>'DT09'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566080917564223)
,p_db_column_name=>'DT10'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566209210564224)
,p_db_column_name=>'DT11'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566328669564225)
,p_db_column_name=>'DT12'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566379998564226)
,p_db_column_name=>'DT13'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566537967564227)
,p_db_column_name=>'DT14'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566580775564228)
,p_db_column_name=>'DT15'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566740100564229)
,p_db_column_name=>'DT16'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566870980564230)
,p_db_column_name=>'DT17'
,p_display_order=>410
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566968418564231)
,p_db_column_name=>'DT18'
,p_display_order=>420
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824654003966681726)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>430
,p_column_identifier=>'BF'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824654116675681727)
,p_db_column_name=>'Origem'
,p_display_order=>440
,p_column_identifier=>'BG'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426507789546239652)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12375212'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:UNIDADE_ADM:DESC_UNIDADE_ADM:CCUSTO:NOME_CCUSTO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05')
||':DT04:DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426474192951022103)
,p_plug_name=>'17 - Empresa/Local Trabalho - EL '
,p_region_name=>'IR_17'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>210
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr19 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr19 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          );',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa        AS empresa,',
'        nome_empresa       AS nome_empresa,',
'        local_trab         AS local_trab,',
'        desc_local_trab    AS desc_local_trab,',
'        cod_ocorr          AS ocorrencia,',
'        nome_cod_ocorr     AS nome_ocorrencia,',
'        cod_gerencial      AS gerencial,',
'        nome_cod_gerencial AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.local_trab,',
'            x.desc_local_trab,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr19 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_LOCAL IS NULL OR x.local_trab IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_LOCAL, '''':'''')) ',
'              ))',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY local_trab, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EL'''
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
 p_id=>wwv_flow_api.id(28426474288949022104)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237487640130025546
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426474431798022105)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426474504130022106)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426474579137022107)
,p_db_column_name=>'LOCAL_TRAB'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Local de Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426474667839022108)
,p_db_column_name=>'DESC_LOCAL_TRAB'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Local de Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509002508288459)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509095754288460)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509238401288461)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509285373288462)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509377378288463)
,p_db_column_name=>'INSS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509463603288464)
,p_db_column_name=>'FGTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509580200288465)
,p_db_column_name=>'IR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426509669209288466)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23166133897200997480)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824566986106564232)
,p_db_column_name=>'DT01'
,p_display_order=>210
,p_column_identifier=>'AJ'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567130519564233)
,p_db_column_name=>'DT02'
,p_display_order=>220
,p_column_identifier=>'AK'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567271309564234)
,p_db_column_name=>'DT03'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567338702564235)
,p_db_column_name=>'DT04'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567411605564236)
,p_db_column_name=>'DT05'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567510869564237)
,p_db_column_name=>'DT06'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567634318564238)
,p_db_column_name=>'DT07'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567695074564239)
,p_db_column_name=>'DT08'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567822912564240)
,p_db_column_name=>'DT09'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824567909712564241)
,p_db_column_name=>'DT10'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568002562564242)
,p_db_column_name=>'DT11'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568080242564243)
,p_db_column_name=>'DT12'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568196889564244)
,p_db_column_name=>'DT13'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568317909564245)
,p_db_column_name=>'DT14'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568387774564246)
,p_db_column_name=>'DT15'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568475273564247)
,p_db_column_name=>'DT16'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568620354564248)
,p_db_column_name=>'DT17'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568689949564249)
,p_db_column_name=>'DT18'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824654184616681728)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824654368673681729)
,p_db_column_name=>'Origem'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426526818969304659)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12375402'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:LOCAL_TRAB:DESC_LOCAL_TRAB:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426510873906288478)
,p_plug_name=>unistr('18 - Empresa/Unid. Neg\00F3cio - EU ')
,p_region_name=>'IR_18'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>220
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr20 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr20 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          );',
'',
'RETURN ''',
'    SELECT',
'        cod_empresa        AS empresa,',
'        nome_empresa       AS nome_empresa,',
'        cod_un_negocio     AS un_negocio,',
'        nome_un_negocio    AS nome_un_negocio,',
'        cod_ocorr          AS ocorrencia,',
'        nome_cod_ocorr     AS nome_ocorrencia,',
'        cod_gerencial      AS gerencial,',
'        nome_cod_gerencial AS nome_gerencial,',
'        "Horas Ferias",',
'        "Origem",        ',
'        "INSS",',
'        "FGTS",',
'        "IR",',
unistr('        "L\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.cod_un_negocio,',
'            x.nome_un_negocio,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) AS nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",            ',
'            (SELECT p.incid_iapas',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "INSS",',
'            (SELECT p.incid_fgts',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "FGTS",',
'            (SELECT p.incid_ir',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod = x.cod_ocorr) AS "IR",',
'            (SELECT p.incid_liq',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
unistr('                AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr20 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_UNIDNEG IS NULL OR x.cod_un_negocio IN (',
'                SELECT COLUMN_VALUE',
'                  FROM TABLE(APEX_STRING.split(:P58_UNIDNEG, '''':'''')) ',
'              ))',
'          AND (x.cod_ocorr     = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY cod_un_negocio, cod_ocorr, cod_gerencial',
''';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EU'''
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
 p_id=>wwv_flow_api.id(28426511015111288479)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1237524366292291921
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511100269288480)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511150102288481)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511262189288482)
,p_db_column_name=>'UN_NEGOCIO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Unidade de Neg\00F3cio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511426677288483)
,p_db_column_name=>'NOME_UN_NEGOCIO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Nome Unidade de Neg\00F3cio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511485703288484)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511629487288485)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511718308288486)
,p_db_column_name=>'GERENCIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511803925288487)
,p_db_column_name=>'NOME_GERENCIAL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426511877751288488)
,p_db_column_name=>'INSS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426512046217288489)
,p_db_column_name=>'FGTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426512147969288490)
,p_db_column_name=>'IR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426512213387288491)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23166133994755997481)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568790186564250)
,p_db_column_name=>'DT01'
,p_display_order=>210
,p_column_identifier=>'AJ'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824568932143564251)
,p_db_column_name=>'DT02'
,p_display_order=>220
,p_column_identifier=>'AK'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569062938564252)
,p_db_column_name=>'DT03'
,p_display_order=>230
,p_column_identifier=>'AL'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569112922564253)
,p_db_column_name=>'DT04'
,p_display_order=>240
,p_column_identifier=>'AM'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569237676564254)
,p_db_column_name=>'DT05'
,p_display_order=>250
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569317860564255)
,p_db_column_name=>'DT06'
,p_display_order=>260
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569399253564256)
,p_db_column_name=>'DT07'
,p_display_order=>270
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569524878564257)
,p_db_column_name=>'DT08'
,p_display_order=>280
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569645991564258)
,p_db_column_name=>'DT09'
,p_display_order=>290
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569673577564259)
,p_db_column_name=>'DT10'
,p_display_order=>300
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569863457564260)
,p_db_column_name=>'DT11'
,p_display_order=>310
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569910004564261)
,p_db_column_name=>'DT12'
,p_display_order=>320
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824569979788564262)
,p_db_column_name=>'DT13'
,p_display_order=>330
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570139317564263)
,p_db_column_name=>'DT14'
,p_display_order=>340
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570259445564264)
,p_db_column_name=>'DT15'
,p_display_order=>350
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570354197564265)
,p_db_column_name=>'DT16'
,p_display_order=>360
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570439582564266)
,p_db_column_name=>'DT17'
,p_display_order=>370
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824570500813564267)
,p_db_column_name=>'DT18'
,p_display_order=>380
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824654451841681730)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>390
,p_column_identifier=>'BB'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10824654571779681731)
,p_db_column_name=>'Origem'
,p_display_order=>400
,p_column_identifier=>'BC'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426540917356326343)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12375543'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:NOME_EMPRESA:UN_NEGOCIO:NOME_UN_NEGOCIO:OCORRENCIA:NOME_OCORRENCIA:Tipo Rubrica:GERENCIAL:NOME_GERENCIAL:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28426672056428359305)
,p_plug_name=>'3 - Empresa/Filial/CCusto - EFCC '
,p_region_name=>'IR_3'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE      ',
'    v_cols_in  VARCHAR2(32767);',
'    v_cols_out VARCHAR2(32767);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr1 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr1 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'    RETURN ''',
'    SELECT',
'        cod_empresa,',
'        nome_empresa,',
'        filial,',
'        nome_filial,',
'        cod_ccusto,',
'        nome_ccusto,',
'        cod_ocorr,',
'        nome_cod_ocorr,',
'        cod_gerencial,',
'        nome_cod_gerencial,',
'        "Horas Ferias",',
'        "Origem",         ',
'        "Incid INSS",',
'        "Incid FGTS",',
'        "Incid IR",',
unistr('        "Incid l\00EDquido",'),
'        "Tipo Rubrica",',
'        '' || v_cols_out || ''',
'    FROM (',
'        SELECT',
'            x.cod_empresa,',
'            x.nome_empresa,',
'            x.filial,',
'            x.nome_filial,',
'            x.cod_ccusto,',
'            x.nome_ccusto,',
'            x.cod_ocorr,',
'            x.nome_cod_ocorr,',
'            x.cod_gerencial,',
'            UPPER(x.nome_cod_gerencial) nome_cod_gerencial,',
'            x.horas_ferias       AS "Horas Ferias",',
'            (CASE x.horas_ferias',
unistr('               WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('               WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'               WHEN 326 THEN ''''Folha''''',
unistr('               WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('               WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'               WHEN 318 THEN ''''Adiantamento''''',
'            END) AS "Origem",          ',
'            (SELECT p.incid_iapas ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
'                AND p.cod = x.cod_ocorr) AS "Incid INSS",',
'            (SELECT p.incid_ir ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
'                AND p.cod = x.cod_ocorr) AS "Incid FGTS",',
'            (SELECT p.incid_fgts ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
'                AND p.cod = x.cod_ocorr) AS "Incid IR",',
'            (SELECT p.incid_liq ',
'               FROM ocorr_pagto p ',
'              WHERE p.cod_empresa = x.cod_empresa ',
unistr('                AND p.cod = x.cod_ocorr) AS "Incid l\00EDquido",'),
'            (SELECT DECODE(p.tipo_rubrica,',
'                           1, ''''Provento'''',',
'                           2, ''''Desconto'''',',
'                           3, ''''Informativa'''',',
'                           4, ''''Informativa Dedutora'''')',
'               FROM ocorr_pagto p',
'              WHERE p.cod_empresa = x.cod_empresa',
'                AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'            TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'            x.tot_valor',
'        FROM tb_ocorr1 x',
'        WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'          AND x.cod_empresa = :P58_EMPRESA',
'          AND (:P58_FILIAL IS NULL ',
'                OR x.filial IN (',
'                      SELECT COLUMN_VALUE',
'                        FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':'''')) ',
'                ))',
'          AND (:P58_CCUSTO IS NULL',
'                OR x.cod_ccusto IN (',
'                      SELECT COLUMN_VALUE',
'                        FROM TABLE(APEX_STRING.split(:P58_CCUSTO, '''':'''')) ',
'                ))',
'          AND (x.cod_ocorr = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'          AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'    )',
'    PIVOT (',
'        SUM(tot_valor)',
'        FOR periodo IN ('' || v_cols_in || '')',
'    )',
'    ORDER BY filial, cod_ccusto, cod_ocorr, cod_gerencial',
'    '';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EFCC'''
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
 p_id=>wwv_flow_api.id(28426671871125359304)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1236532799190230208
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671814228359303)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671703086359302)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671604466359301)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671542476359300)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671377955359299)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Centro de Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671363043359298)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Nome Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671238582359297)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671089285359296)
,p_db_column_name=>'NOME_COD_OCORR'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426671060654359295)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426670905484359294)
,p_db_column_name=>'NOME_COD_GERENCIAL'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426670770439359293)
,p_db_column_name=>'Incid INSS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide INSS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426670678325359292)
,p_db_column_name=>'Incid FGTS'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426670636563359291)
,p_db_column_name=>'Incid IR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28426670533079359290)
,p_db_column_name=>unistr('Incid l\00EDquido')
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753733374946942)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817718384317251649)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817718475895251650)
,p_db_column_name=>'Origem'
,p_display_order=>390
,p_column_identifier=>'AM'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859656474239928)
,p_db_column_name=>'DT01'
,p_display_order=>400
,p_column_identifier=>'AN'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859737759239929)
,p_db_column_name=>'DT02'
,p_display_order=>410
,p_column_identifier=>'AO'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859780527239930)
,p_db_column_name=>'DT03'
,p_display_order=>420
,p_column_identifier=>'AP'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859890898239931)
,p_db_column_name=>'DT04'
,p_display_order=>430
,p_column_identifier=>'AQ'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860014998239932)
,p_db_column_name=>'DT05'
,p_display_order=>440
,p_column_identifier=>'AR'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860135925239933)
,p_db_column_name=>'DT06'
,p_display_order=>450
,p_column_identifier=>'AS'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860193653239934)
,p_db_column_name=>'DT07'
,p_display_order=>460
,p_column_identifier=>'AT'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860340423239935)
,p_db_column_name=>'DT08'
,p_display_order=>470
,p_column_identifier=>'AU'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860411110239936)
,p_db_column_name=>'DT09'
,p_display_order=>480
,p_column_identifier=>'AV'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860488875239937)
,p_db_column_name=>'DT10'
,p_display_order=>490
,p_column_identifier=>'AW'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860663183239938)
,p_db_column_name=>'DT11'
,p_display_order=>500
,p_column_identifier=>'AX'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860726045239939)
,p_db_column_name=>'DT12'
,p_display_order=>510
,p_column_identifier=>'AY'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860812253239940)
,p_db_column_name=>'DT13'
,p_display_order=>520
,p_column_identifier=>'AZ'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822860897772239941)
,p_db_column_name=>'DT14'
,p_display_order=>530
,p_column_identifier=>'BA'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861025097239942)
,p_db_column_name=>'DT15'
,p_display_order=>540
,p_column_identifier=>'BB'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861132398239943)
,p_db_column_name=>'DT16'
,p_display_order=>550
,p_column_identifier=>'BC'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861263100239944)
,p_db_column_name=>'DT17'
,p_display_order=>560
,p_column_identifier=>'BD'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822861324578239945)
,p_db_column_name=>'DT18'
,p_display_order=>570
,p_column_identifier=>'BE'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28426244416576276235)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12372578'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:COD_OCORR:NOME_COD_OCORR:Tipo Rubrica:COD_GERENCIAL:NOME_COD_GERENCIAL:Origem:Incid INSS:Incid FGTS:Incid IR:Incid l\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:')
||'DT06:DT05:DT04:DT03:DT02:DT01:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28427176367695919130)
,p_plug_name=>'2 - Empresa/Filial - EF '
,p_region_name=>'IR_2'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE       ',
'    v_cols_in   VARCHAR2(4000);',
'    v_cols_out  VARCHAR2(4000);',
'BEGIN',
'    SELECT LISTAGG(',
'             '''''''' || TO_CHAR(data_ref,''MM/YYYY'') || '''''' AS "A'' || LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_in',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr2 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'           ); ',
'    SELECT LISTAGG(',
'             ''"A'' || LPAD(rn,2,''0'') || ''" AS "'' || ''DT''||LPAD(rn,2,''0'') || ''"''',
'           , '','')',
'           WITHIN GROUP (ORDER BY rn)',
'      INTO v_cols_out',
'      FROM (',
'             SELECT x.data_ref, ROW_NUMBER() OVER (ORDER BY x.data_ref) rn',
'               FROM (SELECT x1.data_ref',
'                       FROM (SELECT DISTINCT d.data_ref',
'                               FROM tb_ocorr2 d',
'                              WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                             ORDER BY d.data_ref DESC) x1',
'                     WHERE ROWNUM < 19) x',
'          ); ',
'',
'    RETURN ''',
'    SELECT',
'            "Empresa",',
'            "Nome Empresa",',
'            "Filial",',
'            "Nome Filial",',
unistr('            "Ocorr\00EAncia",'),
unistr('            "Nome Ocorr\00EAncia",'),
'            "Gerencial",',
'            "Nome Gerencial",',
'            "Horas Ferias",',
'            "Origem",',
'            "INSS",',
'            "FGTS",',
'            "IR",',
unistr('            "L\00EDquido",'),
'            "Tipo Rubrica",',
'            '' || v_cols_out || ''',
'        FROM (',
'              SELECT x.cod_empresa        AS "Empresa",',
'                     x.nome_empresa       AS "Nome Empresa",',
'                     x.filial             AS "Filial",',
'                     x.nome_filial        AS "Nome Filial",',
unistr('                     x.cod_ocorr          AS "Ocorr\00EAncia",'),
unistr('                     x.nome_cod_ocorr     AS "Nome Ocorr\00EAncia",'),
'                     x.cod_gerencial      AS "Gerencial",',
'                     x.nome_cod_gerencial AS "Nome Gerencial",',
'                     x.horas_ferias       AS "Horas Ferias",',
'                     (CASE x.horas_ferias',
unistr('                        WHEN 131 THEN ''''13\00BA Sal\00E1rio'''''),
unistr('                        WHEN 132 THEN ''''13\00BA Sal\00E1rio'''''),
'                        WHEN 326 THEN ''''Folha''''',
unistr('                        WHEN 334 THEN ''''Rescis\00E3o'''''),
unistr('                        WHEN 584 THEN ''''Rescis\00E3o Complementar'''''),
'                        WHEN 318 THEN ''''Adiantamento''''',
'                     END) AS "Origem",',
'                     (SELECT p.incid_iapas FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "INSS",',
'                     (SELECT p.incid_ir    FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "FGTS",',
'                     (SELECT p.incid_fgts  FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "IR",',
unistr('                     (SELECT p.incid_liq   FROM ocorr_pagto p WHERE p.cod_empresa = x.cod_empresa AND p.cod = x.cod_ocorr) AS "L\00EDquido",'),
'                     (SELECT DECODE(p.tipo_rubrica,',
'                                    1, ''''Provento'''',',
'                                    2, ''''Desconto'''',',
'                                    3, ''''Informativa'''',',
'                                    4, ''''Informativa Dedutora'''')',
'                        FROM ocorr_pagto p',
'                       WHERE p.cod_empresa = x.cod_empresa',
'                         AND p.cod          = x.cod_ocorr) AS "Tipo Rubrica",',
'                     TO_CHAR(x.data_ref, ''''MM/YYYY'''') AS periodo,',
'                     x.tot_valor',
'                FROM tb_ocorr2 x',
'               WHERE x.data_ref >= ADD_MONTHS(TRUNC(data_ref,''''MM''''), -18)',
'                 AND x.cod_empresa = :P58_EMPRESA',
'                 AND (:P58_FILIAL IS NULL OR ',
'                      x.filial IN (SELECT COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P58_FILIAL, '''':''''))))',
'                 AND (x.cod_ocorr = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'                 AND (x.cod_gerencial = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'             )',
'         PIVOT (',
'             SUM(tot_valor)',
'             FOR periodo IN ('' || v_cols_in || '')',
'         )',
unistr('        ORDER BY "Empresa", "Filial", "Ocorr\00EAncia"'),
'    '';',
'END;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P58_PESQUISA = ''S'' AND :P58_HISTOCORR = ''EF'''
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
 p_id=>wwv_flow_api.id(28427176514672919131)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>1222087467665899015
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427176604971919132)
,p_db_column_name=>'Empresa'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427176697925919133)
,p_db_column_name=>'Nome Empresa'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427176808346919134)
,p_db_column_name=>'Filial'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427176926536919135)
,p_db_column_name=>'Nome Filial'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427176967992919136)
,p_db_column_name=>unistr('Ocorr\00EAncia')
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177109176919137)
,p_db_column_name=>unistr('Nome Ocorr\00EAncia')
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177222356919138)
,p_db_column_name=>'Gerencial'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Gerencial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177277112919139)
,p_db_column_name=>'Nome Gerencial'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nome Gerencial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177349074919140)
,p_db_column_name=>'INSS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Incide INSS'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<span class="inss" data-value="#INSS#"></span>',
'',
'',
'',
'',
'#INSS#',
'',
'',
''))
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177480235919141)
,p_db_column_name=>'FGTS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Incide FGTS'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177569131919142)
,p_db_column_name=>'IR'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Incide IR'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28427177715761919143)
,p_db_column_name=>unistr('L\00EDquido')
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(23184753834257946943)
,p_db_column_name=>'Tipo Rubrica'
,p_display_order=>200
,p_column_identifier=>'AP'
,p_column_label=>'Tipo Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817718188415251647)
,p_db_column_name=>'Horas Ferias'
,p_display_order=>360
,p_column_identifier=>'BF'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10817718311193251648)
,p_db_column_name=>'Origem'
,p_display_order=>370
,p_column_identifier=>'BG'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090325065726860)
,p_db_column_name=>'DT01'
,p_display_order=>380
,p_column_identifier=>'BU'
,p_column_label=>'&P21_DT1.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090406328726861)
,p_db_column_name=>'DT02'
,p_display_order=>390
,p_column_identifier=>'BV'
,p_column_label=>'&P21_DT2.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090518773726862)
,p_db_column_name=>'DT03'
,p_display_order=>400
,p_column_identifier=>'BW'
,p_column_label=>'&P21_DT3.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090586298726863)
,p_db_column_name=>'DT04'
,p_display_order=>410
,p_column_identifier=>'BX'
,p_column_label=>'&P21_DT4.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090677952726864)
,p_db_column_name=>'DT05'
,p_display_order=>420
,p_column_identifier=>'BY'
,p_column_label=>'&P21_DT5.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090797500726865)
,p_db_column_name=>'DT06'
,p_display_order=>430
,p_column_identifier=>'BZ'
,p_column_label=>'&P21_DT6.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821090876826726866)
,p_db_column_name=>'DT07'
,p_display_order=>440
,p_column_identifier=>'CA'
,p_column_label=>'&P21_DT7.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821091020612726867)
,p_db_column_name=>'DT08'
,p_display_order=>450
,p_column_identifier=>'CB'
,p_column_label=>'&P21_DT8.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821091162329726868)
,p_db_column_name=>'DT09'
,p_display_order=>460
,p_column_identifier=>'CC'
,p_column_label=>'&P21_DT9.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821091253205726869)
,p_db_column_name=>'DT10'
,p_display_order=>470
,p_column_identifier=>'CD'
,p_column_label=>'&P21_DT10.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10821091364411726870)
,p_db_column_name=>'DT11'
,p_display_order=>480
,p_column_identifier=>'CE'
,p_column_label=>'&P21_DT11.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822858957959239921)
,p_db_column_name=>'DT12'
,p_display_order=>490
,p_column_identifier=>'CF'
,p_column_label=>'&P21_DT12.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822858972194239922)
,p_db_column_name=>'DT13'
,p_display_order=>500
,p_column_identifier=>'CG'
,p_column_label=>'&P21_DT13.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859074452239923)
,p_db_column_name=>'DT14'
,p_display_order=>510
,p_column_identifier=>'CH'
,p_column_label=>'&P21_DT14.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859207039239924)
,p_db_column_name=>'DT15'
,p_display_order=>520
,p_column_identifier=>'CI'
,p_column_label=>'&P21_DT15.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859358811239925)
,p_db_column_name=>'DT16'
,p_display_order=>530
,p_column_identifier=>'CJ'
,p_column_label=>'&P21_DT16.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859372242239926)
,p_db_column_name=>'DT17'
,p_display_order=>540
,p_column_identifier=>'CK'
,p_column_label=>'&P21_DT17.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(10822859501404239927)
,p_db_column_name=>'DT18'
,p_display_order=>550
,p_column_identifier=>'CL'
,p_column_label=>'&P21_DT18.'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(28427699455757223790)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'12226105'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('Empresa:Nome Empresa:Filial:Nome Filial:Ocorr\00EAncia:Nome Ocorr\00EAncia:Tipo Rubrica:Gerencial:Nome Gerencial:Origem:INSS:FGTS:IR:L\00EDquido:DT18:DT17:DT16:DT15:DT14:DT13:DT12:DT11:DT10:DT09:DT08:DT07:DT06:DT05:DT04:DT03:DT02:DT01:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(117900008841179759735)
,p_plug_name=>unistr('Comparativos de Hist\00F3ricos Financeiros - Tabular')
,p_icon_css_classes=>'fa-history'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--noPadding:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(57485012599711710891)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('<p><i>Comparativos de Hist\00F3ricos Financeiros - Tabular</i></p>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(203876955645423590120)
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
 p_id=>wwv_flow_api.id(28427008301698789086)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(203876955645423590120)
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
 p_id=>wwv_flow_api.id(28427006379243789085)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(117900008841179759735)
,p_button_name=>'RESET'
,p_button_static_id=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:58:&SESSION.::&DEBUG.:RP,55:P58_PESQUISA:'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28427006757644789085)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(117900008841179759735)
,p_button_name=>'BACK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>':P58_APP_ANT IS NOT NULL AND :P58_PAG_ANT IS NOT NULL'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-undo-arrow'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(10818753220225028126)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10818753110074028125)
,p_button_name=>'IA_4_1'
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
 p_id=>wwv_flow_api.id(10820401037955631140)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10820400962435631139)
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
 p_id=>wwv_flow_api.id(28426433069119151341)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(28427176367695919130)
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
 p_id=>wwv_flow_api.id(28426433140904151342)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(28426672056428359305)
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
 p_id=>wwv_flow_api.id(28426433332981151344)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(28426271553181397175)
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
 p_id=>wwv_flow_api.id(28426478047307112295)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(28426274068764397200)
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
 p_id=>wwv_flow_api.id(28426478134427112296)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(28426307944182518675)
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
 p_id=>wwv_flow_api.id(28426478203727112297)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(28426311237019518708)
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
 p_id=>wwv_flow_api.id(28426478366693112298)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(28426346656215631885)
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
 p_id=>wwv_flow_api.id(28426478460715112299)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(28426364961133709762)
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
 p_id=>wwv_flow_api.id(28426478582629112300)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(28426367477162709787)
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
 p_id=>wwv_flow_api.id(28426478617849112301)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(28426400451121837162)
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
 p_id=>wwv_flow_api.id(28426478708664112302)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(28426403194090837189)
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
 p_id=>wwv_flow_api.id(28426478827489112303)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(28426436131412934466)
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
 p_id=>wwv_flow_api.id(28426478973544112304)
,p_button_sequence=>180
,p_button_plug_id=>wwv_flow_api.id(28426438761497934493)
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
 p_id=>wwv_flow_api.id(28426479045142112305)
,p_button_sequence=>190
,p_button_plug_id=>wwv_flow_api.id(28426471253752022074)
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
 p_id=>wwv_flow_api.id(28426479108879112306)
,p_button_sequence=>200
,p_button_plug_id=>wwv_flow_api.id(28426474192951022103)
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
 p_id=>wwv_flow_api.id(28426479225024112307)
,p_button_sequence=>210
,p_button_plug_id=>wwv_flow_api.id(28426510873906288478)
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
 p_id=>wwv_flow_api.id(10821088414337726841)
,p_name=>'P21_DT1'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821088657884726843)
,p_name=>'P21_DT2'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821088736603726844)
,p_name=>'P21_DT3'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821088805175726845)
,p_name=>'P21_DT4'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821088898809726846)
,p_name=>'P21_DT5'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089018213726847)
,p_name=>'P21_DT6'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089139910726848)
,p_name=>'P21_DT7'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089223269726849)
,p_name=>'P21_DT8'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089367068726850)
,p_name=>'P21_DT9'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089470205726851)
,p_name=>'P21_DT10'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089565048726852)
,p_name=>'P21_DT11'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089581764726853)
,p_name=>'P21_DT12'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089708985726854)
,p_name=>'P21_DT13'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089811583726855)
,p_name=>'P21_DT14'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089947538726856)
,p_name=>'P21_DT15'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821089989687726857)
,p_name=>'P21_DT16'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821090136691726858)
,p_name=>'P21_DT17'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10821090217956726859)
,p_name=>'P21_DT18'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426475541165080056)
,p_name=>'P58_FLG'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426475830700081628)
,p_name=>'P58_MSG'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426476092489086141)
,p_name=>'P58_STATIC_ID_IR'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28426476480815088321)
,p_name=>'P58_USER_PROMPT'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427007243949789085)
,p_name=>'P58_APP_ANT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(117900008841179759735)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427007570574789086)
,p_name=>'P58_PAG_ANT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(117900008841179759735)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427008727743789086)
,p_name=>'P58_PESQUISA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427009122889789086)
,p_name=>'P58_CODAUX'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427009457763789087)
,p_name=>'P58_HISTOCORR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
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
 p_id=>wwv_flow_api.id(28427009859519789087)
,p_name=>'P58_EMPRESA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
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
 p_id=>wwv_flow_api.id(28427010274858789087)
,p_name=>'P58_FILIAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'FILIAIS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT f.cod_filial||''-''||f.nome_filial det',
'      ,f.cod_filial                     ret',
'  FROM filiais f',
' WHERE f.cod_empresa = :P58_EMPRESA',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P58_EMPRESA'
,p_ajax_items_to_submit=>'P58_EMPRESA'
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
 p_id=>wwv_flow_api.id(28427010654877789087)
,p_name=>'P58_MAOBRA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>unistr('TIPOS M\00C3O DE OBRA')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:D - Direta;D,I - Indireta;I'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P58_EMPRESA'
,p_ajax_items_to_submit=>'P58_EMPRESA'
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
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427011076121789087)
,p_name=>'P58_UNIDADM'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'UNID. ADMINISTRATIVAS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P58_FILIAL,'':'') > 0 OR :P58_FILIAL IS NULL THEN ''[''||x.cod_filial||''] ''||x.cod_unidade_adm||''-''||x.descricao',
'          ELSE x.cod_unidade_adm||''-''||x.descricao END) det',
'      ,x.cod_unidade_adm                   ret',
'  FROM unidade_administrativa x',
' WHERE x.cod_empresa = :P58_EMPRESA ',
'   AND (:P58_FILIAL IS NULL OR x.cod_filial IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P58_FILIAL, '':'')) t))',
'   AND (x.cod_unidade_adm = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P58_FILIAL'
,p_ajax_items_to_submit=>'P58_EMPRESA,P58_FILIAL'
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
 p_id=>wwv_flow_api.id(28427011460064789087)
,p_name=>'P58_CCUSTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'CENTROS DE CUSTO'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.nome det',
'      ,x.cod              ret',
'  FROM centro_de_custo x',
' WHERE x.cod_empresa = :P58_EMPRESA',
'   AND (x.cod = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P58_EMPRESA'
,p_ajax_items_to_submit=>'P58_EMPRESA'
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
 p_id=>wwv_flow_api.id(28427011910071789088)
,p_name=>'P58_DIVISAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>unistr('DIVIS\00D5ES')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_divisao||''-''||x.descricao det',
'      ,x.cod_divisao                   ret',
'  FROM divisao x',
' WHERE (x.cod_divisao = :P58_CODAUX OR :P58_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(28427012288620789088)
,p_name=>'P58_REGIONAL'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'REGIONAIS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_regional||''-''||x.descricao det',
'      ,x.cod_regional                   ret',
'  FROM regional x',
' WHERE (x.cod_regional = :P58_CODAUX OR :P58_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(28427012717270789088)
,p_name=>'P58_CARGO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'CARGOS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.nome det',
'      ,x.cod              ret',
'  FROM cargos x',
' WHERE (x.cod = :P58_CODAUX OR :P58_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(28427013069624789088)
,p_name=>'P58_CLASSCTO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'CATEGORIAS C.CUSTO'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.descricao det',
'      ,x.cod                   ret',
'  FROM class_ccusto x',
' WHERE (x.cod = :P58_CODAUX OR :P58_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(28427013535897789088)
,p_name=>'P58_CLASSCGO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'CATEGORIAS CARGOS'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod||''-''||x.descricao det',
'      ,x.cod                   ret',
'  FROM class_cargo x',
' WHERE (x.cod = :P58_CODAUX OR :P58_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(28427013929556789088)
,p_name=>'P58_LOCAL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>'LOCAIS TRABALHO'
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_local_trab||''-''||x.descricao det',
'      ,x.cod_local_trab                   ret',
'  FROM local_trab x',
' WHERE (x.cod_local_trab = :P58_CODAUX OR :P58_CODAUX IS NULL)',
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
 p_id=>wwv_flow_api.id(28427014276629789088)
,p_name=>'P58_UNIDNEG'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_prompt=>unistr('UNID. NEG\00D3CIOS')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.cod_un_negocio||''-''||x.nome_un_negocio det',
'      ,x.cod_un_negocio                         ret',
'  FROM unidade_de_negocio x',
' WHERE x.cod_empresa = :P58_EMPRESA',
'   AND (x.cod_un_negocio = :P58_CODAUX OR :P58_CODAUX IS NULL)',
'ORDER BY 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P58_EMPRESA'
,p_ajax_items_to_submit=>'P58_EMPRESA'
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
 p_id=>wwv_flow_api.id(28427014676684789088)
,p_name=>'P58_DATA_REF1'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
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
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(48170330020142690098)
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
 p_id=>wwv_flow_api.id(28427015082926789088)
,p_name=>'P58_DATA_REF2'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
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
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(48170330020142690098)
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
 p_id=>wwv_flow_api.id(28427015470642789089)
,p_name=>'P58_MONRRRR_1'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427015869458789089)
,p_name=>'P58_MONRRRR_2'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427604635795223498)
,p_name=>'P21_FLG'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(203876955645423590120)
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(28427016392810789091)
,p_validation_name=>unistr('Valida Tipo Hist\00F3rico')
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P58_HISTOCORR IS NULL THEN',
unistr('    vReturn := ''TIPO HIST\00D3RICO deve ser informado!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(28427009457763789087)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(28427016752876789091)
,p_validation_name=>'Valida Empresa'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P58_HISTOCORR IS NOT NULL THEN',
'    IF :P58_EMPRESA IS NULL THEN',
'      vReturn := ''EMPRESA deve ser informada!'';',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(28427009859519789087)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(28427017229781789091)
,p_validation_name=>'Valida DtRef 1'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P58_HISTOCORR IS NOT NULL THEN',
'    IF :P58_DATA_REF1 IS NULL THEN',
unistr('      vReturn := ''PER\00CDODO 1 deve ser informado!'';'),
'    ELSE',
'      IF :P58_DATA_REF2 IS NOT NULL THEN',
'        IF TO_DATE(:P58_DATA_REF1, ''DD/MM/RRRR'') > TO_DATE(:P58_DATA_REF2, ''DD/MM/RRRR'') THEN',
unistr('          vReturn := ''PER\00CDODO 1 n\00E3o deve ser MAIOR que per\00EDodo 2!'';'),
'        END IF;',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(28427014676684789088)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(28427017567322789091)
,p_validation_name=>'Valida DtRef 2'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P58_HISTOCORR IS NOT NULL THEN',
'    IF :P58_DATA_REF2 IS NULL THEN',
unistr('      vReturn := ''PER\00CDODO 2 deve ser informado!'';'),
'    ELSE',
'      IF :P58_DATA_REF1 IS NOT NULL THEN',
'        IF TO_DATE(:P58_DATA_REF2, ''DD/MM/RRRR'') < TO_DATE(:P58_DATA_REF1, ''DD/MM/RRRR'') THEN',
unistr('          vReturn := ''PER\00CDODO 2 n\00E3o deve ser MENOR que per\00EDodo 1!'';'),
'        END IF;',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(28427015082926789088)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427019238908789092)
,p_name=>'Start Spinner'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(28427006757644789085)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427019699673789093)
,p_event_id=>wwv_flow_api.id(28427019238908789092)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner55= apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427020077388789093)
,p_name=>'Pesquisa'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(28427008301698789086)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427020569257789093)
,p_event_id=>wwv_flow_api.id(28427020077388789093)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_PESQUISA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427021054978789093)
,p_event_id=>wwv_flow_api.id(28427020077388789093)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427021528680789093)
,p_name=>'Disable Report'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(203876955645423590120)
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427021970244789093)
,p_event_id=>wwv_flow_api.id(28427021528680789093)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#REP1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427022387116789093)
,p_name=>'Open Proporcionaliza'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33081966447842721523)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427022824608789093)
,p_name=>unistr('Open Inclus\00E3o Autom\00E1tica')
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33084326672415006087)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427025052131789094)
,p_name=>'Executa Proporcionalizar'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_EXECPROPORC'
,p_condition_element=>'P58_EXECPROPORC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427025595564789094)
,p_event_id=>wwv_flow_api.id(28427025052131789094)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  pkg_AdmPessPoliticasParamCalc.prc_TipoATSProporcionalizar(pAts       => :P58_ATS',
'                                                           ,pEmp       => :P58_EMPRESAS',
'                                                           ,pOcorrFol  => :P58_OCORRFOLHA',
'                                                           ,pOcorrFer  => :P58_OCORRFERIAS',
'                                                           ,pOcorrMat  => :P58_OCORRMATERN',
'                                                           ,pSind      => :P58_SINDICATOS',
'                                                           ,pTpPgto    => :P58_TIPOPGTO',
'                                                           ,pTempDe    => :P58_TEMPODE',
'                                                           ,pProporcSN => :P58_LST_PROPORC',
'                                                           ,pUser      => :P_USUARIO);',
'  --',
'  :P58_EXECPROPORC := NULL;',
'  :P58_LST_PROPORC := NULL;',
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
,p_attribute_02=>'P58_EMPRESA,P58_OCORRFOLHA,P58_OCORRFERIAS,P58_OCORRMATERN,P58_SINDICATOS,P58_TIPOPGTO,P58_TEMPODE,P58_LST_PROPORC'
,p_attribute_03=>'P58_EXECPROPORC,P58_LST_PROPORC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427026592896789094)
,p_event_id=>wwv_flow_api.id(28427025052131789094)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_LST_PROPORC,P58_EXECPROPORC'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427027039177789094)
,p_name=>unistr('Executa Inclus\00E3o Autom\00E1tica ALL')
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_EXECAUTOMATIC'
,p_condition_element=>'P58_EXECAUTOMATIC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427027488040789094)
,p_event_id=>wwv_flow_api.id(28427027039177789094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  pkg_AdmPessPoliticasParamCalc.prc_UpdInfFuncAllATS(pAts       => :P58_ATS',
'                                                    ,pEmp       => :P58_EMPRESAS',
'                                                    ,pOcorrFol  => :P58_OCORRFOLHA',
'                                                    ,pOcorrFer  => :P58_OCORRFERIAS',
'                                                    ,pOcorrMat  => :P58_OCORRMATERN',
'                                                    ,pSind      => :P58_SINDICATOS',
'                                                    ,pTpPgto    => :P58_TIPOPGTO',
'                                                    ,pTempDe    => :P58_TEMPODE',
'                                                    ,pUser      => :P_USUARIO);                                                           ',
'  --',
'  :P58_EXECAUTOMATIC := NULL;',
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
,p_attribute_02=>'P58_EMPRESA,P58_OCORRFOLHA,P58_OCORRFERIAS,P58_OCORRMATERN,P58_SINDICATOS,P58_TIPOPGTO,P58_TEMPODE,P58_EXECAUTOMATIC'
,p_attribute_03=>'P58_EXECAUTOMATIC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427028487556789095)
,p_event_id=>wwv_flow_api.id(28427027039177789094)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_EXECAUTOMATIC'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427028908041789095)
,p_name=>'Set Executa Automatic'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33084328559739006106)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427029374388789095)
,p_event_id=>wwv_flow_api.id(28427028908041789095)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P58_EXECAUTOMATIC := ''S'';',
'END;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427029774040789095)
,p_name=>'Show Hide Filtros'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427030269379789095)
,p_event_id=>wwv_flow_api.id(28427029774040789095)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_EMPRESA,P58_DATA_REF1,P58_DATA_REF2'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427030840746789095)
,p_event_id=>wwv_flow_api.id(28427029774040789095)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_EMPRESA,P58_DATA_REF1,P58_DATA_REF2'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427031158107789095)
,p_name=>'Show Hide Filtros EF'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EF,EFCC,EFUA,EFCCCAR,EFCCCUS,EFCAR,EFCCAR,EFCMO,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427031729671789096)
,p_event_id=>wwv_flow_api.id(28427031158107789095)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_FILIAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427032193141789096)
,p_event_id=>wwv_flow_api.id(28427031158107789095)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_FILIAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427032669624789096)
,p_event_id=>wwv_flow_api.id(28427031158107789095)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_FILIAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427033097259789096)
,p_name=>'Show Hide Filtros EFCC'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCC,EFCCCAR,ECC,EFCMO,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427033570364789096)
,p_event_id=>wwv_flow_api.id(28427033097259789096)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CCUSTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427034146475789096)
,p_event_id=>wwv_flow_api.id(28427033097259789096)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CCUSTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427034613657789096)
,p_event_id=>wwv_flow_api.id(28427033097259789096)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CCUSTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427035020323789096)
,p_name=>'Show Hide Filtros EFUA'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFUA,EFUCC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427035525698789096)
,p_event_id=>wwv_flow_api.id(28427035020323789096)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_UNIDADM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427035985571789096)
,p_event_id=>wwv_flow_api.id(28427035020323789096)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_UNIDADM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427036502828789097)
,p_event_id=>wwv_flow_api.id(28427035020323789096)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_UNIDADM'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427036923606789097)
,p_name=>'Show Hide Filtros ED'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ED'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427037403848789097)
,p_event_id=>wwv_flow_api.id(28427036923606789097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_DIVISAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427037916671789097)
,p_event_id=>wwv_flow_api.id(28427036923606789097)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_DIVISAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427038380120789097)
,p_event_id=>wwv_flow_api.id(28427036923606789097)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_DIVISAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427038801736789097)
,p_name=>'Show Hide Filtros ER'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ER'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427039280719789097)
,p_event_id=>wwv_flow_api.id(28427038801736789097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_REGIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427039782261789097)
,p_event_id=>wwv_flow_api.id(28427038801736789097)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_REGIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427040253843789097)
,p_event_id=>wwv_flow_api.id(28427038801736789097)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_REGIONAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427040714635789097)
,p_name=>'Show Hide Filtros EFCCCAR'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'EFCCCAR,ECAR,EFCAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427041666290789097)
,p_event_id=>wwv_flow_api.id(28427040714635789097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427042229672789098)
,p_event_id=>wwv_flow_api.id(28427040714635789097)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427041216077789097)
,p_event_id=>wwv_flow_api.id(28427040714635789097)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CARGO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427023239229789093)
,p_name=>'Show Hide Filtros ECATCCUS'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ECATCCUS,EFCCCUS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427023676434789093)
,p_event_id=>wwv_flow_api.id(28427023239229789093)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CLASSCTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427024245678789094)
,p_event_id=>wwv_flow_api.id(28427023239229789093)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CLASSCTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427024675869789094)
,p_event_id=>wwv_flow_api.id(28427023239229789093)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CLASSCTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427048344601789099)
,p_name=>'Show Hide Filtros ECATCAR'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'ECATCAR,EFCCAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427048751143789099)
,p_event_id=>wwv_flow_api.id(28427048344601789099)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CLASSCGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427049305157789099)
,p_event_id=>wwv_flow_api.id(28427048344601789099)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CLASSCGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427049807953789099)
,p_event_id=>wwv_flow_api.id(28427048344601789099)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_CLASSCGO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427042608090789098)
,p_name=>'Show Hide Filtros EFCMO'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'EFCMO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427043133639789098)
,p_event_id=>wwv_flow_api.id(28427042608090789098)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_MAOBRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427043572954789098)
,p_event_id=>wwv_flow_api.id(28427042608090789098)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_MAOBRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427044092977789098)
,p_event_id=>wwv_flow_api.id(28427042608090789098)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_MAOBRA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427044505257789098)
,p_name=>'Show Hide Filtros EL'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'EL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427044983239789098)
,p_event_id=>wwv_flow_api.id(28427044505257789098)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_LOCAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427045502464789098)
,p_event_id=>wwv_flow_api.id(28427044505257789098)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_LOCAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427045951804789098)
,p_event_id=>wwv_flow_api.id(28427044505257789098)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_LOCAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427046359986789098)
,p_name=>'Show Hide Filtros EU'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P58_HISTOCORR'
,p_condition_element=>'P58_HISTOCORR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'EU'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427046878421789098)
,p_event_id=>wwv_flow_api.id(28427046359986789098)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_UNIDNEG'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427047389485789098)
,p_event_id=>wwv_flow_api.id(28427046359986789098)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_UNIDNEG'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427047913368789099)
,p_event_id=>wwv_flow_api.id(28427046359986789098)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P58_UNIDNEG'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28426474137660076900)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>250
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28426475007538076901)
,p_event_id=>wwv_flow_api.id(28426474137660076900)
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
'  apex.item("P58_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P58_USER_PROMPT").setValue("Analise os dados de comparativos de hist\00F3ricos financeiros a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28426474519476076901)
,p_event_id=>wwv_flow_api.id(28426474137660076900)
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
'  v_region_static_id varchar2(100) := :P58_STATIC_ID_IR; --''IR_REGION'';',
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
'  v_user_prompt := :P58_USER_PROMPT;  --''Analise os dados a seguir.'';',
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
'  :P58_flg := v_status;',
'  :P58_msg := v_mensagem;',
'',
'END;'))
,p_attribute_02=>'P58_STATIC_ID_IR,P58_USER_PROMT'
,p_attribute_03=>'P58_FLG,P58_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14952053285733856560)
,p_name=>unistr('Expandir IR ap\00F3s Pesquisa')
,p_event_sequence=>260
,p_condition_element=>'P58_PESQUISA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'SX'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14952053335779856561)
,p_event_id=>wwv_flow_api.id(14952053285733856560)
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
 p_id=>wwv_flow_api.id(28427017925725789091)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set MONRRRR'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P58_MONRRRR_1 := TO_CHAR(TO_DATE(:P58_DATA_REF1, ''DD/MM/RRRR''), ''MON/RRRR'');',
'  :P58_MONRRRR_2 := TO_CHAR(TO_DATE(:P58_DATA_REF2, ''DD/MM/RRRR''), ''MON/RRRR'');',
'END;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(10821088570727726842)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Itens Data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cData IS',
'    SELECT ''E''origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr4 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x',
'     WHERE :P58_HISTOCORR = ''E''        ',
'    UNION',
'    SELECT ''EF'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr2 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EF''        ',
'    UNION',
'    SELECT ''EFCC'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr1 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFCC''      ',
'    UNION',
'    SELECT ''EFUA'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr3 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFUA'' ',
'    UNION',
'    SELECT ''ED'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr5 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''ED'' ',
'    UNION',
'    SELECT ''ER'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr6 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''ER'' ',
'    UNION',
'    SELECT ''EFCCCAR'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr7 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFCCCAR''',
'    UNION',
'    SELECT ''ECC'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr8 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''ECC''  ',
'    UNION',
'    SELECT ''EECARCC'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr9 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''ECAR'' ',
'    UNION',
'    SELECT ''ECATCCUS'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr10 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''ECATCCUS''',
'    UNION',
'    SELECT ''ECATCAR'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr11 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''ECATCAR''',
'    UNION',
'    SELECT ''EFCCCUS'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr13 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFCCCUS'' ',
'    UNION',
'    SELECT ''EFCAR'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr14 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFCAR'' ',
'    UNION',
'    SELECT ''EFCMO'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr17 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFCMO'' ',
'    UNION',
'    SELECT ''EFUCC'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr18 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EFUCC''',
'    UNION',
'    SELECT ''EL'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr19 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EL''',
'    UNION',
'    SELECT ''EU'' origem, x.data_ref, TO_CHAR(x.data_ref, ''MON/RRRR'') DTMMRRRR, ROW_NUMBER() OVER (ORDER BY data_ref) rn',
'      FROM (SELECT x1.data_ref',
'              FROM (SELECT DISTINCT d.data_ref',
'                      FROM tb_ocorr20 d',
'                     WHERE d.data_ref >= ADD_MONTHS(TRUNC(d.data_ref,''MM''), -18)',
'                    ORDER BY data_ref DESC) x1',
'             WHERE ROWNUM < 19) x          ',
'     WHERE :P58_HISTOCORR = ''EU'';             ',
'  --',
'  TYPE typ_TabData IS TABLE OF cData%ROWTYPE INDEX BY BINARY_INTEGER;',
'  t_TabData    typ_TabData;',
'BEGIN',
'  t_TabData.DELETE;',
'  --',
'  OPEN cData;',
'  FETCH cData BULK COLLECT INTO t_TabData;',
'  CLOSE cData;',
'  --',
'  IF t_TabData.COUNT > 0 THEN',
'    FOR i IN t_TabData.FIRST..t_TabData.LAST LOOP',
'      IF t_TabData(i).rn = 1 THEN',
'        :P21_DT1 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 2 THEN',
'        :P21_DT2 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 3 THEN',
'        :P21_DT3 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 4 THEN',
'        :P21_DT4 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 5 THEN',
'        :P21_DT5 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 6 THEN',
'        :P21_DT6 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 7 THEN',
'        :P21_DT7 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 8 THEN',
'        :P21_DT8 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 9 THEN',
'        :P21_DT9 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 10 THEN',
'        :P21_DT10 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 11 THEN',
'        :P21_DT11 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 12 THEN',
'        :P21_DT12 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 13 THEN',
'        :P21_DT13 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 14 THEN',
'        :P21_DT14 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 15 THEN',
'        :P21_DT15 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 16 THEN',
'        :P21_DT16 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 17 THEN',
'        :P21_DT17 := t_TabData(i).DTMMRRRR;  ',
'      ELSIF t_TabData(i).rn = 18 THEN',
'        :P21_DT18 := t_TabData(i).DTMMRRRR;  ',
'      END IF;',
'    END LOOP;',
'  END IF;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990958000000000002)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_TAB_RESUMO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - 18 fechamentos (Natcorp_ConsolFolha.js). FONTE: brand/apex/app/NC_TAB_RESUMO.plsql.sql',
'   (guia TABFOLHA-MANUTENCAO.md). Mude la e aplique de novo com aplicar-tabfolha-pagina58.py. SO LE: nao grava nada. */',
'declare',
'  l_ir     varchar2(30) := apex_application.g_x01;',
'  l_cod    varchar2(30) := upper(trim(apex_application.g_x02));',
'  l_tab    varchar2(30);',
'  l_datas  varchar2(4000);',
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
unistr('  c58      t_txt;          /* NOME DA COLUNA (mai\00FAsculo) na tabela da 58 -> nome como est\00E1 */'),
unistr('  n58      t_txt;          /* tipo de n\00EDvel ("Filial", "Centro de custo"...) -> coluna de NOME na 58 */'),
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
'  /* o nome da coluna na tabela da 58, ou null */',
'  function em58(p_col varchar2) return varchar2 is',
'  begin',
'    return case when p_col is not null and c58.exists(upper(p_col)) then c58(upper(p_col)) end;',
'  end;',
'begin',
'  if l_ir is null or not regexp_like(l_ir, ''^IR_[0-9]{1,2}$'') then',
unistr('    htp.prn(''{"erro":"relat\00F3rio n\00E3o informado"}''); return;'),
'  end if;',
'  if l_cod is null or instr('',E,EF,EFCC,EFUA,ED,ER,EFCCCAR,ECC,ECAR,ECATCCUS,ECATCAR,EFCCCUS,EFCAR,EFCCAR,EFCMO,EFUCC,EL,EU,'', '','' || l_cod || '','') = 0 then',
unistr('    htp.prn(''{"erro":"tipo hist\00F3rico inv\00E1lido"}''); return;'),
'  end if;',
'',
unistr('  /* -- a tabela da 58 que est\00E1 na tela: os NOMES das colunas, dos metadados do relat\00F3rio (a fonte'),
unistr('        dela \00E9 uma fun\00E7\00E3o PL/SQL que devolve o SQL: n\00E3o d\00E1 para abrir como subconsulta) -- */'),
'  l_passo := ''colunas58'';',
'  for r in (select c.column_alias a',
'              from apex_application_page_ir_col c',
'              join apex_application_page_regions g on g.region_id = c.region_id',
'             where g.application_id = :APP_ID and g.page_id = :APP_PAGE_ID and g.static_id = l_ir) loop',
'    c58(upper(r.a)) := r.a;',
'    if regexp_like(upper(r.a), ''^(NOME|DESC)'') and not n58.exists(nome_nivel(r.a)) then n58(nome_nivel(r.a)) := r.a; end if;',
'  end loop;',
'',
unistr('  /* -- a consulta da Consolida\00E7\00E3o (p\00E1gina 50) do mesmo tipo, com os filtros desta p\00E1gina -- */'),
'  l_passo := ''consulta50'';',
'  select region_source into l_src',
'    from apex_application_page_regions',
'   where application_id = :APP_ID and page_id = 50',
'     and upper(condition_expression1) = ''P50_OCORRENCIA'' and upper(trim(condition_expression2)) = l_cod',
'     and region_source is not null',
'     and rownum = 1;',
'  l_src := limpa(l_src);',
'',
'  /* -- os 18 meses: a regra da tabela da 58 (as 18 datas distintas mais recentes da tabela base) -- */',
'  l_passo := ''meses'';',
'  l_tab := upper(regexp_substr(l_src, ''from\s+(TB_OCORR[0-9]+)'', 1, 1, ''i'', 1));',
'  if l_tab is null or not regexp_like(l_tab, ''^TB_OCORR[0-9]{1,3}$'') then',
unistr('    htp.prn(''{"erro":"tabela base n\00E3o encontrada para '' || l_cod || ''"}''); return;'),
'  end if;',
'  execute immediate ''select listagg(to_char(data_ref, ''''DD/MM/YYYY''''), '''':'''') within group (order by data_ref) '' ||',
'                    ''from (select data_ref from (select distinct data_ref from '' || l_tab || '' order by data_ref desc) where rownum < 19)''',
'    into l_datas;',
'  if l_datas is null then',
'    htp.prn(''{"erro":"sem fechamentos em '' || l_tab || ''"}''); return;',
'  end if;',
'  l_src := regexp_replace(l_src, '':P50_DATA_REF([^A-Za-z0-9_]|$)'', '''''''' || l_datas || ''''''\1'', 1, 0, ''i'');',
'  l_src := regexp_replace(l_src, '':P50_'', '':P58_'', 1, 0, ''i'');',
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
unistr('  /* os nomes para FILTRAR s\00E3o os da tabela da 58 (os pap\00E9is foram achados na consulta da 50) */'),
'  apex_json.open_object(''cols'');',
'  apex_json.write(''rubn'', coalesce(em58(''NOME_COD_OCORR''), em58(''NOME_OCORRENCIA'')));',
'  apex_json.write(''catn'', coalesce(em58(''NOME_COD_GERENCIAL''), em58(''NOME_GERENCIAL'')));',
'  apex_json.write(''orig'', em58(''ORIGEM''));',
'  apex_json.write(''tipo'', em58(''TIPO RUBRICA''));',
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
unistr('    /* a coluna do NOME do n\00EDvel na tabela da 58: o mesmo nome, ou a de NOME do mesmo tipo de n\00EDvel'),
unistr('       (NOME_CCUSTO na 50 = NOME_CENTRO_DE_CUSTO na 58); sem nenhuma, o c\00F3digo */'),
'    declare l_cn varchar2(400) := coalesce(em58(niv_nom(n)), case when n58.exists(niv_rot(n)) then n58(niv_rot(n)) end); begin',
'      apex_json.write(''col'', case when l_cn is null then em58(niv_cod(n)) end);',
'      apex_json.write(''colNome'', l_cn);',
'    end;',
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
