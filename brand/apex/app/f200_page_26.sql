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
,p_default_application_id=>200
,p_default_id_offset=>805756123742460090
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 200 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     200
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   22:35 Thursday October 8, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 26
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00026
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>26);
end;
/
prompt --application/pages/page_00026
begin
wwv_flow_api.create_page(
 p_id=>26
,p_user_interface_id=>wwv_flow_api.id(283867044223119591244)
,p_name=>unistr('F\00E9rias')
,p_step_title=>unistr('F\00E9rias')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js',
'#WORKSPACE_IMAGES#Natcorp_FeriasPainel.js'))
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css',
'#WORKSPACE_IMAGES#Natcorp_FeriasPainel.css'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_step_template=>wwv_flow_api.id(283867002111251591073)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_LinhaTempo.css / Natcorp_LinhaTempo.js)',
'',
unistr('No alto do relat\00F3rio, um seletor com tr\00EAs jeitos de ver as mesmas f\00E9rias:'),
'  Tabela      o Interactive Report de sempre;',
unistr('  Trajet\00F3ria  um Gantt com uma linha por colaborador e, dentro, uma faixa por per\00EDodo aquisitivo:'),
unistr('              a faixa clara \00E9 o per\00EDodo aquisitivo; o contorno tracejado, o per\00EDodo para gozar'),
unistr('              (at\00E9 a data limite de in\00EDcio); as barras cheias, as parcelas (sa\00EDda -> retorno);'),
unistr('              o losango, o prazo para iniciar (vermelho vencido com saldo, \00E2mbar at\00E9 60 dias).'),
unistr('              Abre em ordem de urg\00EAncia, com busca, zoom de anos a dias e arrastar para rolar;'),
unistr('  Cronologia  as parcelas e os prazos por ano, com o nome de quem \00E9 cada um.'),
unistr('Os dados v\00EAm do processo Ajax Callback NC_LINHA_TEMPO_DADOS desta p\00E1gina, com o FROM e o WHERE'),
unistr('copiados do relat\00F3rio (os filtros do \00FAltimo Pesquisar, que est\00E3o na sess\00E3o): TODOS os per\00EDodos,'),
unistr('n\00E3o s\00F3 a p\00E1gina aberta da Tabela. At\00E9 20000 per\00EDodos.'),
unistr('Mudou o filtro do relat\00F3rio? Rode de novo aplicar-linhatempo-pagina26.py na exporta\00E7\00E3o.'),
'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/LINHATEMPO-MANUTENCAO.md.'))
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260409145908'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276508318914945317837)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(271112851906094353540)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283741986323783925244)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(283780677543880158203)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(283867039513876591195)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283742333633680192028)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283742335247341192030)
,p_plug_name=>'Linha do Tempo'
,p_region_name=>'LI_1'
,p_parent_plug_id=>wwv_flow_api.id(283742333633680192028)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select F.COD_EMPRESA, ',
'       F.MATRICULA,',
'       F.MATRICULA||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) colaborador,',
'      -- F.IND_SITUACAO_PERIODO,',
unistr('       CASE WHEN f.ind_situacao_periodo = ''P'' THEN ''Pendente''||'' Per\00EDodo Aquisitivo: ''||F.DT_INIC_PER_FERIAS||'' - ''||F.DT_FIM_PER_FERIAS'),
unistr('            WHEN f.ind_situacao_periodo = ''R'' THEN ''Parcial''||'' Per\00EDodo Aquisitivo: ''||F.DT_INIC_PER_FERIAS||'' - ''||F.DT_FIM_PER_FERIAS'),
unistr('            WHEN f.ind_situacao_periodo = ''C'' THEN ''Cancelado''||'' Per\00EDodo Aquisitivo: ''||F.DT_INIC_PER_FERIAS||'' - ''||F.DT_FIM_PER_FERIAS'),
unistr('            WHEN f.ind_situacao_periodo = ''Q'' THEN ''Quitado''||'' Per\00EDodo Aquisitivo: ''||F.DT_INIC_PER_FERIAS||'' - ''||F.DT_FIM_PER_FERIAS'),
unistr('            WHEN f.ind_situacao_periodo = ''G'' THEN ''Gozado''||'' Per\00EDodo Aquisitivo: ''||F.DT_INIC_PER_FERIAS||'' - ''||F.DT_FIM_PER_FERIAS'),
'            END scr_situacao,',
'       nvl(nvl(F.DT_SAIDA_PARC1,F.DT_SAIDA_PARC2),F.DT_INIC_PER_FERIAS) data_ini,',
'       nvl(nvl(F.DT_RETORNO_PARC1,F.DT_RETORNO_PARC2),F.DT_FIM_PER_FERIAS) data_fim',
'  from ferias f,',
'       INFORMACOES_FUNCIONAIS I',
' where F.COD_EMPRESA = I.COD_EMPRESA',
'   AND F.MATRICULA   = I.MATRICULA',
'   and ((i.cod_empresa = :p26_emp',
'   and i.matricula = :p26_mat) or :p26_mat is null)',
'    and ((F.ind_situacao_periodo <> ''G''      and nvl(:P26_chk_pendentes,''N'') = ''S'') or ',
'         (F.ind_situacao_periodo is not null and nvl(:P26_chk_pendentes,''N'') = ''N''))',
'   and (:P26_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_EMPRESA, '','')) t))',
'   and (:P26_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_FILIAL, '','')) t))',
'   and (:P26_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_CCUSTO, '','')) t))',
'   and (:P26_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_UNIDADE_ADM, '','')) t))',
'   and (:P26_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_ATIVIDADE, '','')) t))',
'   and (:P26_MATRICULA_1 is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_MATRICULA_1, '','')) t))',
'   AND ((i.situacao < ''90''      and :P26_SITUACAO = ''S'') or ',
'        (i.situacao is not null and :P26_SITUACAO = ''N''))      ',
'   and (:P26_DATA_INI IS NULL OR ((F.DT_SAIDA_PARC1   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_SAIDA_PARC2   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_SAIDA_PARC4   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_RETORNO_PARC1 between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_RETORNO_PARC2 between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_RETORNO_PARC4 between :P26_DATA_INI and :P26_DATA_FIM)))',
' order by COD_EMPRESA,MATRICULA,DT_INIC_PER_FERIAS desc'))
,p_plug_source_type=>'PLUGIN_COM.SB.REGION.TIMELINE'
,p_ajax_items_to_submit=>'P26_EMP,P26_MAT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_no_data_found=>'Nenhum Dado Encontrado'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P26_MAT'
,p_attribute_01=>'Linha do Tempo'
,p_attribute_02=>'Acontecimentos Cadastrais do Colaborador'
,p_attribute_06=>'DATA_INI'
,p_attribute_07=>'SCR_SITUACAO'
,p_attribute_08=>'SCR_SITUACAO'
,p_attribute_09=>'DATA_FIM'
,p_attribute_11=>'COLABORADOR'
,p_attribute_12=>'N'
,p_attribute_16=>'700'
,p_attribute_17=>'pt-br'
,p_attribute_18=>'top'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(283742335756319192031)
,p_name=>'COLABORADOR'
,p_data_type=>'VARCHAR2'
,p_is_visible=>true
,p_display_sequence=>30
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(283742336225894192032)
,p_name=>'SCR_SITUACAO'
,p_data_type=>'VARCHAR2'
,p_is_visible=>true
,p_display_sequence=>40
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(283742336764558192032)
,p_name=>'DATA_INI'
,p_data_type=>'DATE'
,p_is_visible=>true
,p_display_sequence=>50
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(283742337197751192033)
,p_name=>'DATA_FIM'
,p_data_type=>'DATE'
,p_is_visible=>true
,p_display_sequence=>60
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(283742337770725192033)
,p_name=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_visible=>true
,p_display_sequence=>10
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(283742338267201192034)
,p_name=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_visible=>true
,p_display_sequence=>20
,p_escape_on_http_output=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283742338596515192034)
,p_plug_name=>unistr('F\00E9rias')
,p_region_name=>'IR_1'
,p_parent_plug_id=>wwv_flow_api.id(283742333633680192028)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select F.empresa, ',
'       f.matricula||'' - ''||INITCAP(fnct_nome_func(f.cod_empresa, f.matricula)) SCR_NOME,',
'       F.Filial,',
'       F.SCR_CCUSTO,',
'       F.Unidade_Adm,',
'       F.Atividade,',
'       F.scr_situacao,',
'       s.cod cod_sindicato,',
'       s.nome desc_sindicato,',
'       F.DT_INIC_PER_FERIAS,',
'       F.DT_FIM_PER_FERIAS,',
'       F.SALDO,',
'       F.FALTA_HORA,',
'       F.FALTA_MINUTO,',
'       F.SCR_FALTAS,',
'       F.DT_SAIDA_PARC1,',
'       F.DT_RETORNO_PARC1,',
'       F.NUM_DIAS_PARC1,',
'       F.DIAS_ABONO_PEC1,',
'       F.OBSERVACOES,',
'       F.OPCAO_13SAL1,',
'       F.DT_SAIDA_PARC2,',
'       F.DT_RETORNO_PARC2,',
'       F.NUM_DIAS_PARC2,',
'       F.DIAS_ABONO_PEC2,',
'       F.OPCAO_13SAL2,',
'       F.DT_SAIDA_PARC4,',
'       F.DT_RETORNO_PARC4,',
'       F.NUM_DIAS_PARC4,',
'       F.DIAS_ABONO_PEC4,',
'       F.OPCAO_13SAL4,',
'       F.DT_LIM_INIC_FERIAS,',
'       F.DT_LIM_PROG_FERIAS,',
'       f.cod_empresa,',
'       f.matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao)) situacao_funcional,',
'       i.dt_situacao data_situacao,',
'       f.usuario_prog,',
'       f.dt_atualizacao_prog, ',
'       f.usuario_prog2, ',
'       f.dt_atualizacao_prog2,',
'       f.usuario_prog4, ',
'       f.dt_atualizacao_prog4,',
'       i.vinculo||'' - ''||Initcap(v.nome) vinculo,',
'       f.dt_pagto_parc1,',
'       f.dt_pagto_parc2,',
'       f.dt_pagto_parc4',
'  from VW_CONSULTA_FERIAS F, INFORMACOES_FUNCIONAIS I, SINDICATOS S, vinculo_empreg v',
' where f.cod_empresa = i.cod_empresa',
'   and f.matricula = i.matricula',
'   and i.num_sind_diss = s.cod ',
'   and i.cod_empresa  = s.cod_empresa',
'   and i.vinculo (+) = v.cod',
'   and ((F.cod_empresa = :p26_emp',
'   and F.matricula = :p26_mat) or :p26_mat is null)',
'   and ((F.ind_situacao_periodo <> ''G''      and nvl(:P26_chk_pendentes,''N'') = ''S'') or ',
'        (F.ind_situacao_periodo is not null and nvl(:P26_chk_pendentes,''N'') = ''N''))',
'   and (:P26_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_EMPRESA, '','')) t))',
'   and (:P26_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_FILIAL, '','')) t))',
'   and (:P26_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_CCUSTO, '','')) t))',
'   and (:P26_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_UNIDADE_ADM, '','')) t))',
'   and (:P26_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_ATIVIDADE, '','')) t))',
'   and (:P26_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_CARGO, '','')) t))',
'   and (:P26_MATRICULA_1 is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_MATRICULA_1, '','')) t))',
'   AND ((i.situacao =''01''     and :P26_SITUACAO = ''S'') or ',
'        (i.situacao =''14''     and :P26_SITUACAO = ''F'') or',
'       ((i.situacao between ''02'' and ''89'') and :P26_SITUACAO = ''F'') or ',
'        (i.situacao >= ''90''      and :P26_SITUACAO = ''D'') or ',
'        (i.situacao is not null and :P26_SITUACAO = ''N''))      ',
'   and (:P26_DATA_INI IS NULL OR ((F.DT_SAIDA_PARC1   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_SAIDA_PARC2   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_SAIDA_PARC4   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_RETORNO_PARC1 between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_RETORNO_PARC2 between :P26_DATA_INI and :P26_DATA_FIM) or ',
'        (F.DT_RETORNO_PARC4 between :P26_DATA_INI and :P26_DATA_FIM)))',
' order by COD_EMPRESA,MATRICULA,DT_INIC_PER_FERIAS desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P26_SITUACAO,P26_CHK_PENDENTES'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
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
 p_id=>wwv_flow_api.id(283742339067684192035)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'Para mais resultados, filtre sua consulta.'
,p_max_rows_per_page=>'50'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>46159574638502005
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975623124520787627)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'AH'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975623247660787628)
,p_db_column_name=>'FILIAL'
,p_display_order=>20
,p_column_identifier=>'AI'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975622898801787624)
,p_db_column_name=>'SCR_CCUSTO'
,p_display_order=>30
,p_column_identifier=>'AE'
,p_column_label=>unistr('Centro de Custo (C\00E9lula)')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975622929415787625)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>40
,p_column_identifier=>'AF'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975623078931787626)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>50
,p_column_identifier=>'AG'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742339111946192035)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>60
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742339503308192036)
,p_db_column_name=>'MATRICULA'
,p_display_order=>70
,p_column_identifier=>'B'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742340330819192037)
,p_db_column_name=>'SCR_NOME'
,p_display_order=>80
,p_column_identifier=>'D'
,p_column_label=>'Colaborador'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#SCR_NOME#'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742341120839192038)
,p_db_column_name=>'SCR_SITUACAO'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>unistr('Situa\00E7\00E3o (F\00E9rias)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385212609123334057)
,p_db_column_name=>'COD_SINDICATO'
,p_display_order=>100
,p_column_identifier=>'AO'
,p_column_label=>unistr('C\00F3digo Sindicato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385212422337334055)
,p_db_column_name=>'DESC_SINDICATO'
,p_display_order=>110
,p_column_identifier=>'AM'
,p_column_label=>'Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742341497142192039)
,p_db_column_name=>'DT_INIC_PER_FERIAS'
,p_display_order=>120
,p_column_identifier=>'H'
,p_column_label=>unistr('Data Inicial Per\00EDodo Aquisitivo')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742341936923192040)
,p_db_column_name=>'DT_FIM_PER_FERIAS'
,p_display_order=>130
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Final Per\00EDodo Aquisitivo')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742342330480192040)
,p_db_column_name=>'SALDO'
,p_display_order=>140
,p_column_identifier=>'J'
,p_column_label=>'Saldo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742342786825192041)
,p_db_column_name=>'FALTA_HORA'
,p_display_order=>150
,p_column_identifier=>'K'
,p_column_label=>'Faltas'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742343128498192041)
,p_db_column_name=>'FALTA_MINUTO'
,p_display_order=>160
,p_column_identifier=>'L'
,p_column_label=>'Falta minuto'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742343956621192042)
,p_db_column_name=>'DT_SAIDA_PARC1'
,p_display_order=>180
,p_column_identifier=>'N'
,p_column_label=>unistr('Data Sa\00EDda Parc. 1')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742344355915192042)
,p_db_column_name=>'DT_RETORNO_PARC1'
,p_display_order=>190
,p_column_identifier=>'O'
,p_column_label=>'Data Retorno Parc. 1'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742344717406192043)
,p_db_column_name=>'NUM_DIAS_PARC1'
,p_display_order=>200
,p_column_identifier=>'P'
,p_column_label=>unistr('N\00BA Dias Parc. 1')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742345156278192043)
,p_db_column_name=>'DIAS_ABONO_PEC1'
,p_display_order=>210
,p_column_identifier=>'Q'
,p_column_label=>'Dias Abono Parc. 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742345968579192044)
,p_db_column_name=>'OPCAO_13SAL1'
,p_display_order=>220
,p_column_identifier=>'S'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Sal. Parc. 1')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742346312159192044)
,p_db_column_name=>'DT_SAIDA_PARC2'
,p_display_order=>230
,p_column_identifier=>'T'
,p_column_label=>unistr('Data Sa\00EDda Parc. 2')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742346696919192045)
,p_db_column_name=>'DT_RETORNO_PARC2'
,p_display_order=>240
,p_column_identifier=>'U'
,p_column_label=>'Data Retorno Parc. 2'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742347192914192045)
,p_db_column_name=>'NUM_DIAS_PARC2'
,p_display_order=>250
,p_column_identifier=>'V'
,p_column_label=>unistr('N\00BA Dias Parc. 2')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742347589461192045)
,p_db_column_name=>'DIAS_ABONO_PEC2'
,p_display_order=>260
,p_column_identifier=>'W'
,p_column_label=>'Dias Abono Parc. 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742347963730192047)
,p_db_column_name=>'OPCAO_13SAL2'
,p_display_order=>270
,p_column_identifier=>'X'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Sal. Parc. 2')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283230483434811048590)
,p_db_column_name=>'DT_SAIDA_PARC4'
,p_display_order=>280
,p_column_identifier=>'Y'
,p_column_label=>unistr('Data Sa\00EDda Parc. 3')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283230483501494048591)
,p_db_column_name=>'DT_RETORNO_PARC4'
,p_display_order=>290
,p_column_identifier=>'Z'
,p_column_label=>'Data Retorno Parc. 3'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283230483636719048592)
,p_db_column_name=>'NUM_DIAS_PARC4'
,p_display_order=>300
,p_column_identifier=>'AA'
,p_column_label=>unistr('N\00BA Dias Parc. 3')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283230483703904048593)
,p_db_column_name=>'DIAS_ABONO_PEC4'
,p_display_order=>310
,p_column_identifier=>'AB'
,p_column_label=>'Dias Abono Parc. 3'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283230483843094048594)
,p_db_column_name=>'OPCAO_13SAL4'
,p_display_order=>320
,p_column_identifier=>'AC'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Sal. Parc. 3')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283742345557538192044)
,p_db_column_name=>'OBSERVACOES'
,p_display_order=>330
,p_column_identifier=>'R'
,p_column_label=>unistr('Observa\00E7\00F5es')
,p_column_link=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.::P27_OBSERVACOES:#OBSERVACOES#'
,p_column_linktext=>'Obs.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975622735671787623)
,p_db_column_name=>'DT_LIM_INIC_FERIAS'
,p_display_order=>340
,p_column_identifier=>'AD'
,p_column_label=>unistr('Data Limite In\00EDcio de F\00E9rias')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(282975623340384787629)
,p_db_column_name=>'DT_LIM_PROG_FERIAS'
,p_display_order=>350
,p_column_identifier=>'AJ'
,p_column_label=>unistr('Data Limite de Programa\00E7\00E3o de F\00E9rias')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(232527284088483520279)
,p_db_column_name=>'SITUACAO_FUNCIONAL'
,p_display_order=>360
,p_column_identifier=>'AK'
,p_column_label=>unistr('Situa\00E7\00E3o Funcional')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(232568671875271870630)
,p_db_column_name=>'DATA_SITUACAO'
,p_display_order=>370
,p_column_identifier=>'AL'
,p_column_label=>unistr('Data de Situa\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385212771049334058)
,p_db_column_name=>'USUARIO_PROG'
,p_display_order=>380
,p_column_identifier=>'AP'
,p_column_label=>unistr('Usu\00E1rio 1')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385212846089334059)
,p_db_column_name=>'DT_ATUALIZACAO_PROG'
,p_display_order=>390
,p_column_identifier=>'AQ'
,p_column_label=>unistr('Data Atualiza\00E7\00E3o 1')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385212924936334060)
,p_db_column_name=>'USUARIO_PROG2'
,p_display_order=>400
,p_column_identifier=>'AR'
,p_column_label=>unistr('Usu\00E1rio 2')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385213027397334061)
,p_db_column_name=>'DT_ATUALIZACAO_PROG2'
,p_display_order=>410
,p_column_identifier=>'AS'
,p_column_label=>unistr('Data Atualiza\00E7\00E3o 2')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385213176190334062)
,p_db_column_name=>'USUARIO_PROG4'
,p_display_order=>420
,p_column_identifier=>'AT'
,p_column_label=>unistr('Usu\00E1rio 3')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150385213255165334063)
,p_db_column_name=>'DT_ATUALIZACAO_PROG4'
,p_display_order=>430
,p_column_identifier=>'AU'
,p_column_label=>unistr('Data Atualiza\00E7\00E3o 3')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(124970973449447005973)
,p_db_column_name=>'VINCULO'
,p_display_order=>440
,p_column_identifier=>'AV'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(90779922417008339960)
,p_db_column_name=>'SCR_FALTAS'
,p_display_order=>450
,p_column_identifier=>'AW'
,p_column_label=>'Scr Faltas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(90779922540811339961)
,p_db_column_name=>'DT_PAGTO_PARC1'
,p_display_order=>460
,p_column_identifier=>'AX'
,p_column_label=>'Data Pagto Parc. 1'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(90779922612895339962)
,p_db_column_name=>'DT_PAGTO_PARC2'
,p_display_order=>470
,p_column_identifier=>'AY'
,p_column_label=>'Data Pagto Parc. 2'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(90779922690975339963)
,p_db_column_name=>'DT_PAGTO_PARC4'
,p_display_order=>480
,p_column_identifier=>'AZ'
,p_column_label=>'Data Pagto Parc. 3'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(283742348388620192048)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'461689'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'EMPRESA:FILIAL:SCR_NOME:SITUACAO_FUNCIONAL:DATA_SITUACAO:SCR_CCUSTO:UNIDADE_ADM:ATIVIDADE:SCR_SITUACAO:DT_INIC_PER_FERIAS:DT_FIM_PER_FERIAS:DT_LIM_INIC_FERIAS:DT_LIM_PROG_FERIAS:SALDO:DT_SAIDA_PARC1:DT_RETORNO_PARC1:DT_PAGTO_PARC1:NUM_DIAS_PARC1:DIAS'
||'_ABONO_PEC1:OPCAO_13SAL1:DT_SAIDA_PARC2:DT_RETORNO_PARC2:DT_PAGTO_PARC2:NUM_DIAS_PARC2:DIAS_ABONO_PEC2:OPCAO_13SAL2:DT_SAIDA_PARC4:DT_RETORNO_PARC4:DT_PAGTO_PARC4:NUM_DIAS_PARC4:DIAS_ABONO_PEC4:OPCAO_13SAL4:OBSERVACOES:DESC_SINDICATO:COD_SINDICATO:US'
||'UARIO_PROG:DT_ATUALIZACAO_PROG:USUARIO_PROG2:DT_ATUALIZACAO_PROG2:USUARIO_PROG4:DT_ATUALIZACAO_PROG4:VINCULO:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283742349993265192050)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P26_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271113068258002669237)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271113068590388670332)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-minus'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271101628585769390069)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(283742350438049192051)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(283742349993265192050)
,p_button_name=>'p26_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P26_EMP.,&P26_MAT.,&P26_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60696549900110311536)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_button_name=>'IA'
,p_button_static_id=>'BTN_IA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
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
 p_id=>wwv_flow_api.id(60696539892287292706)
,p_name=>'P26_FLG'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696539916396292707)
,p_name=>'P26_MSG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696540059969292708)
,p_name=>'P26_STATIC_ID_IR'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696540098695292709)
,p_name=>'P26_USER_PROMPT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696540253664292710)
,p_name=>'P26_SYS_PROMPT'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101628997666390074)
,p_name=>'P26_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' WHERE ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101629392243390079)
,p_name=>'P26_UTILIZA_SECAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101629750952390082)
,p_name=>'P26_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(nvl(sigla,nome_filial)) descricao, cod_filial',
'  from filiais ',
'where ((instr('',''||:p26_empresa||'','','',''||cod_empresa||'','') > 0) or (:p26_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P26_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101630222755390084)
,p_name=>'P26_CCUSTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p26_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p26_empresa, '','')) t))',
'and (:p26_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p26_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P26_EMPRESA,P26_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101630599746390088)
,p_name=>'P26_UNIDADE_ADM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p26_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p26_empresa is null))',
'       and ((instr('',''||:p26_filial||'','','',''||a.cod_filial||'','') > 0) or (:p26_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       --and s.cod_ccusto = :p26_ccusto',
'       and ((instr('',''||:p26_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p26_ccusto is null))',
'       and s.ativo = ''S''',
'       and nvl(:p26_utiliza_secao, ''N'') = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p26_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p26_empresa is null))',
'       and ((instr('',''||:p26_filial||'','','',''||a.cod_filial||'','') > 0) or (:p26_filial is null))',
'       and nvl(:p26_utiliza_secao, ''N'') = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P26_EMPRESA,P26_FILIAL,P26_CCUSTO,P26_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101630945274390091)
,p_name=>'P26_ATIVIDADE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p26_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p26_empresa is null))',
'   and ((instr('',''||:p26_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p26_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p26_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p26_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P26_CCUSTO,P26_UNIDADE_ADM,P26_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101631340143390095)
,p_name=>'P26_CARGO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101632213041390099)
,p_name=>'P26_MATRICULA_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) d, i.matricula',
'  from informacoes_funcionais i',
' where (:P26_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_EMPRESA, '','')) t))',
'   and (:P26_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_FILIAL, '','')) t))',
'   and (:P26_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_CCUSTO, '','')) t))',
'   and (:P26_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_UNIDADE_ADM, '','')) t))',
'   and (:P26_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_ATIVIDADE, '','')) t))',
'   AND ((i.situacao < ''90''      and :P26_SITUACAO = ''S'') or ',
'        (i.situacao = ''14''      and :P26_SITUACAO = ''F'') or ',
'        (i.situacao is not null and :P26_SITUACAO = ''N''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P26_CCUSTO,P26_UNIDADE_ADM,P26_ATIVIDADE,P26_EMPRESA,P26_FILIAL,P26_CARGO,P26_SITUACAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101632604428390101)
,p_name=>'P26_DATA_INI'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_prompt=>'Data Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101633022463390104)
,p_name=>'P26_DATA_FIM'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_prompt=>'Data Final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101633414264390105)
,p_name=>'P26_PESQUISA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742334484493192029)
,p_name=>'P26_SITUACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(271112851906094353540)
,p_item_default=>'N'
,p_prompt=>unistr('Situa\00E7\00E3o Funcional')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Ativos;S,Afastados;F,Desligados;D,Todos;N'
,p_cHeight=>1
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742334804096192030)
,p_name=>'P26_CHK_PENDENTES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276508318914945317837)
,p_item_default=>'S'
,p_prompt=>unistr('F\00E9rias Pendentes')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Apenas Pendentes;S,Todas as Situa\00E7\00F5es;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742348891465192049)
,p_name=>'P26_EMP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742349276378192049)
,p_name=>'P26_MAT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742349665083192050)
,p_name=>'P26_CHAMADOR'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(283742338596515192034)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742350820896192051)
,p_name=>'P26_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(283742349993265192050)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = :P26_EMP',
'                  and matricula   = :P26_MAT',
'                  ), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P26_EMP || ''|'' || :P26_MAT',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_colspan=>2
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742351203674192052)
,p_name=>'P26_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283742349993265192050)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742351671392192052)
,p_name=>'P26_SIT_FUNC'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(283742349993265192050)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742352009732192052)
,p_name=>'P26_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(283742349993265192050)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283742352458540192053)
,p_name=>'P26_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(283742349993265192050)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271113068738560671612)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113068258002669237)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113069159009671615)
,p_event_id=>wwv_flow_api.id(271113068738560671612)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var element = document.getElementById(''PARAMETROS_ITENS'');',
'',
'element.classList.add("expandRegion");',
'element.classList.remove("collapseRegion");',
'',
'apex.item("OPEN_PARAMETROS").hide();',
'apex.item("CLOSE_PARAMETROS").show();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271113069608309672724)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113068590388670332)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113070009139672725)
,p_event_id=>wwv_flow_api.id(271113069608309672724)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var element = document.getElementById(''PARAMETROS_ITENS'');',
'',
'element.classList.remove("expandRegion");',
'element.classList.add("collapseRegion");',
'',
'apex.item("CLOSE_PARAMETROS").hide();',
'apex.item("OPEN_PARAMETROS").show();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271112852669118353548)
,p_name=>'Pesquisar'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271101628585769390069)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113270096293641199)
,p_event_id=>wwv_flow_api.id(271112852669118353548)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60696548477069309593)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>40
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60696548801406309596)
,p_event_id=>wwv_flow_api.id(60696548477069309593)
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
'  apex.item("P26_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P26_SYS_PROMPT").setValue("Voc\00EA \00E9 um especialista em RH e Departamento Pessoal.");'),
unistr('  apex.item("P26_USER_PROMPT").setValue("Analise os dados de f\00E9rias a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60696549366556309596)
,p_event_id=>wwv_flow_api.id(60696548477069309593)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    DECLARE',
'',
'      V_RESP    CLOB;',
'      V_FILES   VARCHAR2(4000);',
'',
'      V_SYSTEM_PROMPT CLOB;',
'      V_USER_PROMPT CLOB;',
'      ',
'      v_id_system_prompt NUMBER;',
'      v_servico varchar2(100) := ''N8N'';',
'      v_llm varchar2(100) := ''GEMINI'';',
'      v_region_static_id varchar2(100) := :P26_STATIC_ID_IR; --''IR_REGION'';',
'      v_region_name varchar2(100);',
'      v_opcao_arq_prompt varchar2(100) := ''CSV'';',
'      ',
'      v_ir_report_log_id number;',
'      v_chart_log_id number;',
'      ',
'      v_status varchar2(10);',
'      v_mensagem varchar2(4000);',
'      ',
'    BEGIN',
'',
'      v_system_prompt := :P26_SYS_PROMPT;',
'      v_user_prompt := :P26_USER_PROMPT;  --''Analise os dados a seguir.'';',
'',
'      v_ir_report_log_id := ',
'      pkg_ai.fnct_gerar_csv_ir(',
'      p_app_id => :app_id,',
'      p_page_id => :app_page_id,',
'      p_region_static_id => v_region_static_id,',
'      p_region_name => v_region_name,',
'      p_servico => v_servico,',
'      p_user_prompt => v_user_prompt,',
'      p_user_prompt_aux => null,',
'      p_sys_prompt => v_system_prompt,',
'      p_status => v_status,',
'      p_mensagem => v_mensagem',
'      );',
'',
'      pkg_chatbot.prc_chat(',
'      p_servico => v_servico,',
'      p_client_id => :p_base,',
'      p_user_id => :p_usuario,',
'      p_cod_empresa => :p_empresa_user,',
'      p_matricula => :p_matricula_user,',
'      p_id_system_prompt => v_id_system_prompt,',
'      p_app_id => :app_id,',
'      p_page_id => :app_page_id,',
'      p_region_static_id => v_region_static_id,',
'      p_region_name => v_region_name,',
'      p_system_prompt => v_system_prompt,',
'      p_simples => ''S'',',
'      p_llm => v_llm,',
'      p_role => ''user'',',
'      p_user_prompt => v_user_prompt,',
'      p_user_prompt_adicional => null,',
'      p_ia => ''S'',',
'      p_mostrar => ''S'',',
'      p_temperature => null,',
'      p_ir_report_log_id => v_ir_report_log_id,',
'      p_opcao_arq_prompt => v_opcao_arq_prompt,',
'      p_response => V_RESP,',
'      p_output_files => V_FILES,',
'      p_status => v_status,',
'      p_mensagem => v_mensagem',
'      );',
'',
'      :P26_flg := v_status;',
'      :P26_msg := v_mensagem;',
'',
'    END;'))
,p_attribute_02=>'P26_USER_PROMPT,P26_SYS_PROMPT,P26_STATIC_ID_IR'
,p_attribute_03=>'P26_FLG,P26_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283742353543861192054)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283742353937012192055)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'--if :p26_situacao is null then',
'   --:p26_situacao := ''N''; -- ch43731',
'--end if;',
'',
'if :p26_chk_pendentes is null then',
'   :p26_chk_pendentes := ''S'';',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283742354353705192055)
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
'       i.dt_admissao',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p26_emp',
'   and i.matricula = :p26_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p26_cod_empresa := v_c1.empresa;',
':p26_matricula := v_c1.matricula;',
':p26_sit_func := v_c1.situacao;',
':p26_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p26_cod_empresa := :p26_emp;',
':p26_matricula := :p26_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(30662545301231244509)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_LINHA_TEMPO_DADOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Entrega os per\00EDodos de f\00E9rias ao Natcorp_LinhaTempo.js (Trajet\00F3ria e Cronologia), em JSON.'),
unistr('-- O FROM e o WHERE s\00E3o os do relat\00F3rio (copiados pelo aplicar-linhatempo-pagina26.py): os filtros'),
unistr('-- do \00FAltimo Pesquisar (na sess\00E3o). Todos os per\00EDodos, n\00E3o s\00F3 a p\00E1gina aberta da Tabela.'),
'declare',
'  c_limite constant pls_integer := 20000;',
'  v_n      pls_integer := 0;',
'  v_cortou boolean := false;',
'  function d(p_data date) return varchar2 is begin return to_char(p_data, ''dd/mm/yyyy''); end;',
'  procedure parcela(p_n number, p_sai date, p_ret date, p_pag date, p_dias number, p_abono number, p_13 varchar2) is',
'  begin',
'    if p_sai is null then return; end if;',
'    apex_json.open_object;',
'    apex_json.write(''n'', p_n);',
'    apex_json.write(''saida'', d(p_sai));',
'    apex_json.write(''retorno'', d(p_ret));',
'    apex_json.write(''pagto'', d(p_pag));',
'    apex_json.write(''dias'', p_dias);',
'    apex_json.write(''abono'', p_abono);',
'    apex_json.write(''dec'', p_13);',
'    apex_json.close_object;',
'  end;',
'begin',
'  apex_json.open_object;',
'  apex_json.open_array(''ferias'');',
'  for r in (',
'    select f.cod_empresa, f.matricula, initcap(fnct_nome_func(f.cod_empresa, f.matricula)) nome,',
'           f.scr_ccusto ccusto, i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao)) sit_func,',
'           f.scr_situacao sit, f.dt_inic_per_ferias aq_ini, f.dt_fim_per_ferias aq_fim,',
'           f.dt_lim_inic_ferias lim_ini, f.dt_lim_prog_ferias lim_prog, f.saldo,',
'           f.dt_saida_parc1 s1, f.dt_retorno_parc1 r1, f.dt_pagto_parc1 p1, f.num_dias_parc1 d1, f.dias_abono_pec1 a1, f.opcao_13sal1 o1,',
'           f.dt_saida_parc2 s2, f.dt_retorno_parc2 r2, f.dt_pagto_parc2 p2, f.num_dias_parc2 d2, f.dias_abono_pec2 a2, f.opcao_13sal2 o2,',
'           f.dt_saida_parc4 s3, f.dt_retorno_parc4 r3, f.dt_pagto_parc4 p3, f.num_dias_parc4 d3, f.dias_abono_pec4 a3, f.opcao_13sal4 o3',
'      from VW_CONSULTA_FERIAS F, INFORMACOES_FUNCIONAIS I, SINDICATOS S, vinculo_empreg v',
'     where f.cod_empresa = i.cod_empresa',
'       and f.matricula = i.matricula',
'       and i.num_sind_diss = s.cod ',
'       and i.cod_empresa  = s.cod_empresa',
'       and i.vinculo (+) = v.cod',
'       and ((F.cod_empresa = :p26_emp',
'       and F.matricula = :p26_mat) or :p26_mat is null)',
'       and ((F.ind_situacao_periodo <> ''G''      and nvl(:P26_chk_pendentes,''N'') = ''S'') or ',
'            (F.ind_situacao_periodo is not null and nvl(:P26_chk_pendentes,''N'') = ''N''))',
'       and (:P26_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_EMPRESA, '','')) t))',
'       and (:P26_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_FILIAL, '','')) t))',
'       and (:P26_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_CCUSTO, '','')) t))',
'       and (:P26_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_UNIDADE_ADM, '','')) t))',
'       and (:P26_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_ATIVIDADE, '','')) t))',
'       and (:P26_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_CARGO, '','')) t))',
'       and (:P26_MATRICULA_1 is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P26_MATRICULA_1, '','')) t))',
'       AND ((i.situacao =''01''     and :P26_SITUACAO = ''S'') or ',
'            (i.situacao =''14''     and :P26_SITUACAO = ''F'') or',
'           ((i.situacao between ''02'' and ''89'') and :P26_SITUACAO = ''F'') or ',
'            (i.situacao >= ''90''      and :P26_SITUACAO = ''D'') or ',
'            (i.situacao is not null and :P26_SITUACAO = ''N''))      ',
'       and (:P26_DATA_INI IS NULL OR ((F.DT_SAIDA_PARC1   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'            (F.DT_SAIDA_PARC2   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'            (F.DT_SAIDA_PARC4   between :P26_DATA_INI and :P26_DATA_FIM) or ',
'            (F.DT_RETORNO_PARC1 between :P26_DATA_INI and :P26_DATA_FIM) or ',
'            (F.DT_RETORNO_PARC2 between :P26_DATA_INI and :P26_DATA_FIM) or ',
'            (F.DT_RETORNO_PARC4 between :P26_DATA_INI and :P26_DATA_FIM)))',
'     order by f.cod_empresa, f.matricula, f.dt_inic_per_ferias desc) loop',
'    if v_n >= c_limite then',
'      v_cortou := true;',
'      exit;',
'    end if;',
'    v_n := v_n + 1;',
'    apex_json.open_object;',
'    apex_json.write(''emp'', r.cod_empresa);',
'    apex_json.write(''mat'', r.matricula);',
'    apex_json.write(''nome'', r.nome);',
'    apex_json.write(''ccusto'', r.ccusto);',
'    apex_json.write(''sit_func'', r.sit_func);',
'    apex_json.write(''sit'', r.sit);',
'    apex_json.write(''aq_ini'', d(r.aq_ini));',
'    apex_json.write(''aq_fim'', d(r.aq_fim));',
'    apex_json.write(''lim_ini'', d(r.lim_ini));',
'    apex_json.write(''lim_prog'', d(r.lim_prog));',
'    apex_json.write(''saldo'', r.saldo);',
'    apex_json.open_array(''parcelas'');',
'    parcela(1, r.s1, r.r1, r.p1, r.d1, r.a1, r.o1);',
'    parcela(2, r.s2, r.r2, r.p2, r.d2, r.a2, r.o2);',
'    parcela(3, r.s3, r.r3, r.p3, r.d3, r.a3, r.o3);',
'    apex_json.close_array;',
'    apex_json.close_object;',
'  end loop;',
'  apex_json.close_array;',
'  apex_json.write(''cortado'', v_cortou);',
'  apex_json.close_object;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>unistr('Natcorp_LinhaTempo.js: a Trajet\00F3ria e a Cronologia de F\00E9rias pedem os per\00EDodos aqui (apex.server.process). FROM/WHERE copiados do relat\00F3rio pelo aplicar-linhatempo-pagina26.py. Guia: LINHATEMPO-MANUTENCAO.md.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990026000000000002)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_FERIAS_INDICADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - painel de ferias (Natcorp_FeriasPainel.js). FONTE: brand/apex/app/NC_FERIAS_INDICADORES.plsql.sql',
'   (guia FERIASPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-feriaspainel-pagina26.py. */',
'declare',
'  l_hoje    date := trunc(sysdate);',
'  l_dini    date;                     /* filtro de datas da página (parcelas nesse intervalo) */',
'  l_dfim    date;',
'  l_cal_ini date;                     /* janela do calendário de saídas */',
'  l_cal_fim date;',
'  l_emp varchar2(32767) := '','' || :P26_EMPRESA || '','';     f_emp number := case when :P26_EMPRESA is null then 0 else 1 end;',
'  l_fil varchar2(32767) := '','' || :P26_FILIAL || '','';      f_fil number := case when :P26_FILIAL is null then 0 else 1 end;',
'  l_cc  varchar2(32767) := '','' || :P26_CCUSTO || '','';      f_cc  number := case when :P26_CCUSTO is null then 0 else 1 end;',
'  l_un  varchar2(32767) := '','' || :P26_UNIDADE_ADM || '',''; f_un  number := case when :P26_UNIDADE_ADM is null then 0 else 1 end;',
'  l_at  varchar2(32767) := '','' || :P26_ATIVIDADE || '','';   f_at  number := case when :P26_ATIVIDADE is null then 0 else 1 end;',
'  l_car varchar2(32767) := '','' || :P26_CARGO || '','';       f_car number := case when :P26_CARGO is null then 0 else 1 end;',
'  l_mat varchar2(32767) := '','' || :P26_MATRICULA_1 || '',''; f_mat number := case when :P26_MATRICULA_1 is null then 0 else 1 end;',
'  l_passo varchar2(30) := ''inicio'';',
'  l_t0    number := dbms_utility.get_time;',
'  l_t1    number;',
'  l_saida clob;',
'  l_pos   pls_integer := 1;',
'',
'  type t_num is table of number index by varchar2(400);',
'  type t_dat is table of date index by varchar2(400);',
'  type t_txt is table of varchar2(400) index by varchar2(400);',
'  visto   t_num;                      /* chaves já contadas */',
'  cc_de   t_txt;                      /* centro de custo de cada pessoa ("emp|mat") */',
'  fe_sai  t_dat; fe_ret t_dat;        /* de férias hoje: saída e retorno */',
'  s30_sai t_dat;                      /* sai nos próximos 30 dias: a 1ª saída */',
'  ve_lim  t_dat; ve_dias t_num; ve_n t_num;   /* prazo vencido: o limite mais antigo, saldo, períodos */',
'  v60_lim t_dat; v60_dias t_num;      /* vence em até 60 dias */',
'  ac_n    t_num; ac_dias t_num;       /* períodos completos com saldo (acumulado e "mais dias") */',
'  futura  t_num;                      /* período ("emp|mat|aq_ini") com saída de hoje em diante */',
'  q_mes   t_num;                      /* saídas por mês (pessoas) */',
'  q_set   t_num; d_set t_num;         /* períodos vencidos e dias por centro de custo */',
'  l_pessoas number := 0; l_dias number := 0; l_venc number := 0; l_periodos number := 0;',
'  l_cp number := 0; l_p1 number := 0; l_p2 number := 0; l_p3 number := 0; l_abono number := 0; l_dec number := 0;',
'',
'  function data_de(p varchar2) return date is',
'  begin',
'    if p is null then return null; end if;',
'    begin return to_date(p, ''DD/MM/YYYY''); exception when others then return to_date(p); end;',
'  end;',
'  function d(p date) return varchar2 is begin return to_char(p, ''DD/MM/YYYY''); end;',
'  function primeira(k varchar2) return boolean is',
'  begin',
'    if visto.exists(k) then return false; end if;',
'    visto(k) := 1; return true;',
'  end;',
'  procedure soma(a in out nocopy t_num, k varchar2, v number) is',
'  begin',
'    if a.exists(k) then a(k) := a(k) + v; else a(k) := v; end if;',
'  end;',
'  procedure menor(a in out nocopy t_dat, k varchar2, v date) is',
'  begin',
'    if v is null then return; end if;',
'    if not a.exists(k) or v < a(k) then a(k) := v; end if;',
'  end;',
'  function nome(k varchar2) return varchar2 is',
'    l_e varchar2(200) := substr(k, 1, instr(k, ''|'') - 1);',
'    l_m varchar2(200) := substr(k, instr(k, ''|'') + 1);',
'  begin',
'    return l_m || '' - '' || initcap(fnct_nome_func(l_e, l_m));',
'  end;',
'  /* uma pessoa na lista: nome, centro de custo e as datas daquela situação */',
'  procedure pessoa(k varchar2, p_a date, p_b date, p_n number) is',
'  begin',
'    apex_json.open_object;',
'    apex_json.write(''n'', nome(k));',
'    apex_json.write(''s'', case when cc_de.exists(k) then cc_de(k) end);',
'    if p_a is not null then apex_json.write(''a'', d(p_a)); end if;',
'    if p_b is not null then apex_json.write(''b'', d(p_b)); end if;',
'    if p_n is not null then apex_json.write(''x'', p_n); end if;',
'    apex_json.close_object;',
'  end;',
'  /* os N maiores de um grupo (q; empate: d) - t = o próprio texto da chave ou o nome da pessoa */',
'  procedure maiores(p_lista varchar2, q t_num, dd t_num, p_n pls_integer, p_pessoa boolean, p_min number) is',
'    usado t_num; k varchar2(400); melhor varchar2(400);',
'  begin',
'    apex_json.open_array(p_lista);',
'    for x in 1 .. p_n loop',
'      melhor := null; k := q.first;',
'      while k is not null loop',
'        if not usado.exists(k) and q(k) >= p_min',
'           and (melhor is null or q(k) > q(melhor) or (q(k) = q(melhor) and dd(k) > dd(melhor))) then',
'          melhor := k;',
'        end if;',
'        k := q.next(k);',
'      end loop;',
'      exit when melhor is null;',
'      usado(melhor) := 1;',
'      apex_json.open_object;',
'      apex_json.write(''t'', case when p_pessoa then nome(melhor) else melhor end);',
'      apex_json.write(''q'', q(melhor)); apex_json.write(''d'', dd(melhor));',
'      if p_pessoa and cc_de.exists(melhor) then apex_json.write(''s'', cc_de(melhor)); end if;',
'      apex_json.close_object;',
'    end loop;',
'    apex_json.close_array;',
'  end;',
'  /* uma parcela de um período: hoje / próximos 30 dias / calendário / futura */',
'  procedure parcela(k varchar2, kp varchar2, p_sai date, p_ret date, p_dias number) is',
'    l_ret date;',
'  begin',
'    if p_sai is null then return; end if;',
'    l_ret := nvl(p_ret, p_sai + nvl(p_dias, 0));',
'    if p_sai <= l_hoje and l_hoje < l_ret then fe_sai(k) := p_sai; fe_ret(k) := l_ret; end if;',
'    if p_sai > l_hoje and p_sai <= l_hoje + 30 then menor(s30_sai, k, p_sai); end if;',
'    if p_sai >= l_hoje then futura(kp) := 1; end if;',
'    if p_sai between l_cal_ini and l_cal_fim and primeira(''M|'' || to_char(p_sai, ''YYYY-MM'') || ''|'' || k) then',
'      soma(q_mes, to_char(p_sai, ''YYYY-MM''), 1);',
'    end if;',
'  end;',
'begin',
'  l_dini := data_de(:P26_DATA_INI);',
'  l_dfim := nvl(data_de(:P26_DATA_FIM), l_hoje);',
'  if l_dini is not null then',
'    l_cal_ini := trunc(l_dini, ''MM''); l_cal_fim := l_dfim;',
'  else                                  /* sem filtro: 2 meses para trás e 9 para a frente */',
'    l_cal_ini := add_months(trunc(l_hoje, ''MM''), -2); l_cal_fim := last_day(add_months(l_hoje, 9));',
'  end if;',
'',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''hoje'', d(l_hoje));',
'  apex_json.write(''cal_ini'', d(l_cal_ini));',
'  apex_json.write(''cal_fim'', d(l_cal_fim));',
'',
'  l_passo := ''periodos'';',
'  for r in (',
'    select f.cod_empresa emp, f.matricula mat, f.scr_ccusto cc,',
'           f.dt_inic_per_ferias aq_ini, f.dt_fim_per_ferias aq_fim, f.dt_lim_inic_ferias lim_ini, nvl(f.saldo, 0) saldo,',
'           f.dt_saida_parc1 s1, f.dt_retorno_parc1 r1, f.num_dias_parc1 d1, f.dias_abono_pec1 a1, f.opcao_13sal1 o1,',
'           f.dt_saida_parc2 s2, f.dt_retorno_parc2 r2, f.num_dias_parc2 d2, f.dias_abono_pec2 a2, f.opcao_13sal2 o2,',
'           f.dt_saida_parc4 s3, f.dt_retorno_parc4 r3, f.num_dias_parc4 d3, f.dias_abono_pec4 a3, f.opcao_13sal4 o3',
'      from VW_CONSULTA_FERIAS F, INFORMACOES_FUNCIONAIS I, SINDICATOS S, vinculo_empreg v',
'     where f.cod_empresa = i.cod_empresa',
'       and f.matricula = i.matricula',
'       and i.num_sind_diss = s.cod',
'       and i.cod_empresa = s.cod_empresa',
'       and i.vinculo (+) = v.cod',
'       and ((f.cod_empresa = :P26_EMP and f.matricula = :P26_MAT) or :P26_MAT is null)',
'       and ((f.ind_situacao_periodo <> ''G'' and nvl(:P26_CHK_PENDENTES, ''N'') = ''S'') or',
'            (f.ind_situacao_periodo is not null and nvl(:P26_CHK_PENDENTES, ''N'') = ''N''))',
'       and (f_emp = 0 or instr(l_emp, '','' || i.cod_empresa || '','') > 0)',
'       and (f_fil = 0 or instr(l_fil, '','' || i.filial || '','') > 0)',
'       and (f_cc  = 0 or instr(l_cc,  '','' || i.cod_ccusto || '','') > 0)',
'       and (f_un  = 0 or instr(l_un,  '','' || i.unidade_adm || '','') > 0)',
'       and (f_at  = 0 or instr(l_at,  '','' || i.cod_atividade || '','') > 0)',
'       and (f_car = 0 or instr(l_car, '','' || i.cargo || '','') > 0)',
'       and (f_mat = 0 or instr(l_mat, '','' || i.matricula || '','') > 0)',
'       and ((i.situacao = ''01'' and :P26_SITUACAO = ''S'') or',
'            (i.situacao = ''14'' and :P26_SITUACAO = ''F'') or',
'            ((i.situacao between ''02'' and ''89'') and :P26_SITUACAO = ''F'') or',
'            (i.situacao >= ''90'' and :P26_SITUACAO = ''D'') or',
'            (i.situacao is not null and :P26_SITUACAO = ''N''))',
'       and (l_dini is null or (f.dt_saida_parc1 between l_dini and l_dfim or f.dt_saida_parc2 between l_dini and l_dfim',
'                            or f.dt_saida_parc4 between l_dini and l_dfim or f.dt_retorno_parc1 between l_dini and l_dfim',
'                            or f.dt_retorno_parc2 between l_dini and l_dfim or f.dt_retorno_parc4 between l_dini and l_dfim))',
'  ) loop',
'    declare',
'      k  varchar2(400) := r.emp || ''|'' || r.mat;',
'      kp varchar2(400) := k || ''|'' || to_char(r.aq_ini, ''YYYYMMDD'');',
'      np pls_integer := 0;',
'    begin',
'      if primeira(''P|'' || k) then l_pessoas := l_pessoas + 1; cc_de(k) := r.cc; end if;',
'      parcela(k, kp, r.s1, r.r1, r.d1);',
'      parcela(k, kp, r.s2, r.r2, r.d2);',
'      parcela(k, kp, r.s3, r.r3, r.d3);',
'      /* como tiram (períodos com alguma parcela marcada) */',
'      if r.s1 is not null then np := np + 1; end if;',
'      if r.s2 is not null then np := np + 1; end if;',
'      if r.s3 is not null then np := np + 1; end if;',
'      if np > 0 then',
'        l_cp := l_cp + 1;',
'        if np = 1 then l_p1 := l_p1 + 1; elsif np = 2 then l_p2 := l_p2 + 1; else l_p3 := l_p3 + 1; end if;',
'        if nvl(r.a1, 0) + nvl(r.a2, 0) + nvl(r.a3, 0) > 0 then l_abono := l_abono + 1; end if;',
'        if upper(substr(r.o1, 1, 1)) = ''S'' or upper(substr(r.o2, 1, 1)) = ''S'' or upper(substr(r.o3, 1, 1)) = ''S'' then l_dec := l_dec + 1; end if;',
'      end if;',
'      /* saldo e prazos */',
'      if r.saldo > 0 then',
'        l_periodos := l_periodos + 1;',
'        l_dias := l_dias + r.saldo;',
'        if r.aq_fim < l_hoje then',
'          l_venc := l_venc + r.saldo;',
'          soma(ac_n, k, 1); soma(ac_dias, k, r.saldo);',
'        end if;',
'        if r.lim_ini < l_hoje then',
'          menor(ve_lim, k, r.lim_ini); soma(ve_dias, k, r.saldo); soma(ve_n, k, 1);',
'          /* chave de array nunca nula (ORA-06502): período sem centro de custo vai para um grupo próprio */',
'          soma(q_set, nvl(r.cc, ''(sem centro de custo)''), 1); soma(d_set, nvl(r.cc, ''(sem centro de custo)''), r.saldo);',
'        elsif r.lim_ini <= l_hoje + 60 and not futura.exists(kp) then',
'          menor(v60_lim, k, r.lim_ini); soma(v60_dias, k, r.saldo);',
'        end if;',
'      end if;',
'    end;',
'  end loop;',
'  l_t1 := dbms_utility.get_time;',
'',
'  l_passo := ''listas'';',
'  apex_json.write(''pessoas'', l_pessoas);',
'  apex_json.open_object(''agora'');',
'  apex_json.write(''ferias'', fe_sai.count);',
'  apex_json.write(''saem30'', s30_sai.count);',
'  apex_json.write(''vencido'', ve_lim.count);',
'  apex_json.write(''vence60'', v60_lim.count);',
'  declare k varchar2(400) := ac_n.first; n number := 0; begin',
'    while k is not null loop if ac_n(k) >= 2 then n := n + 1; end if; k := ac_n.next(k); end loop;',
'    apex_json.write(''acumulado'', n);',
'  end;',
'  apex_json.close_object;',
'',
'  /* quem são (até 300 em cada lista) */',
'  declare',
'    k varchar2(400); n pls_integer;',
'  begin',
'    apex_json.open_array(''ferias''); k := fe_sai.first; n := 0;',
'    while k is not null and n < 300 loop pessoa(k, fe_sai(k), fe_ret(k), null); n := n + 1; k := fe_sai.next(k); end loop;',
'    apex_json.close_array;',
'    apex_json.open_array(''saem30''); k := s30_sai.first; n := 0;',
'    while k is not null and n < 300 loop pessoa(k, s30_sai(k), null, null); n := n + 1; k := s30_sai.next(k); end loop;',
'    apex_json.close_array;',
'    apex_json.open_array(''vencido''); k := ve_lim.first; n := 0;',
'    while k is not null and n < 300 loop pessoa(k, ve_lim(k), null, ve_dias(k)); n := n + 1; k := ve_lim.next(k); end loop;',
'    apex_json.close_array;',
'    apex_json.open_array(''vence60''); k := v60_lim.first; n := 0;',
'    while k is not null and n < 300 loop pessoa(k, v60_lim(k), null, v60_dias(k)); n := n + 1; k := v60_lim.next(k); end loop;',
'    apex_json.close_array;',
'    apex_json.open_array(''acumulado''); k := ac_n.first; n := 0;',
'    while k is not null and n < 300 loop',
'      if ac_n(k) >= 2 then pessoa(k, null, null, ac_dias(k)); n := n + 1; end if;',
'      k := ac_n.next(k);',
'    end loop;',
'    apex_json.close_array;',
'  end;',
'',
'  apex_json.open_object(''saldo'');',
'  apex_json.write(''dias'', l_dias);',
'  apex_json.write(''vencidos'', l_venc);',
'  apex_json.write(''periodos'', l_periodos);',
'  apex_json.write(''em_dia'', l_pessoas - ve_lim.count);',
'  apex_json.close_object;',
'',
'  apex_json.open_array(''meses'');',
'  declare m varchar2(400) := q_mes.first; begin',
'    while m is not null loop',
'      apex_json.open_object; apex_json.write(''m'', m); apex_json.write(''q'', q_mes(m)); apex_json.close_object;',
'      m := q_mes.next(m);',
'    end loop;',
'  end;',
'  apex_json.close_array;',
'',
'  maiores(''setores'', q_set, d_set, 30, false, 1);',
'  maiores(''maissaldo'', ac_dias, ac_n, 30, true, 1);',
'',
'  apex_json.open_object(''como'');',
'  apex_json.write(''periodos'', l_cp);',
'  apex_json.write(''p1'', l_p1); apex_json.write(''p2'', l_p2); apex_json.write(''p3'', l_p3);',
'  apex_json.write(''abono'', l_abono); apex_json.write(''dec'', l_dec);',
'  apex_json.close_object;',
'',
'  apex_json.open_object(''tempos'');',
'  apex_json.write(''periodos'', l_t1 - l_t0);',
'  apex_json.write(''listas'', dbms_utility.get_time - l_t1);',
'  apex_json.close_object;',
'  apex_json.close_object;',
'',
'  l_saida := apex_json.get_clob_output;',
'  apex_json.free_output;',
'  while l_pos <= dbms_lob.getlength(l_saida) loop',
'    htp.prn(dbms_lob.substr(l_saida, 8000, l_pos));',
'    l_pos := l_pos + 8000;',
'  end loop;',
'exception',
'  when others then',
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
