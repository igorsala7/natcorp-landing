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
,p_default_id_offset=>784797347607055121
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 200 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     200
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   23:07 Friday October 2, 2026
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
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('F\00E9rias')
,p_step_title=>unistr('F\00E9rias')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_step_template=>wwv_flow_api.id(281503476810280346565)
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
 p_id=>wwv_flow_api.id(274144793613974073329)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268749326605123109032)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378461022812680736)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281417152242908913695)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378808332708947520)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
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
 p_id=>wwv_flow_api.id(281378809946369947522)
,p_plug_name=>'Linha do Tempo'
,p_region_name=>'LI_1'
,p_parent_plug_id=>wwv_flow_api.id(281378808332708947520)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
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
 p_id=>wwv_flow_api.id(281378810455347947523)
,p_name=>'COLABORADOR'
,p_data_type=>'VARCHAR2'
,p_is_visible=>true
,p_display_sequence=>30
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(281378810924922947524)
,p_name=>'SCR_SITUACAO'
,p_data_type=>'VARCHAR2'
,p_is_visible=>true
,p_display_sequence=>40
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(281378811463586947524)
,p_name=>'DATA_INI'
,p_data_type=>'DATE'
,p_is_visible=>true
,p_display_sequence=>50
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(281378811896779947525)
,p_name=>'DATA_FIM'
,p_data_type=>'DATE'
,p_is_visible=>true
,p_display_sequence=>60
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(281378812469753947525)
,p_name=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_visible=>true
,p_display_sequence=>10
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(281378812966229947526)
,p_name=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_visible=>true
,p_display_sequence=>20
,p_escape_on_http_output=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378813295543947526)
,p_plug_name=>unistr('F\00E9rias')
,p_region_name=>'IR_1'
,p_parent_plug_id=>wwv_flow_api.id(281378808332708947520)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492405269346640)
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
 p_id=>wwv_flow_api.id(281378813766712947527)
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
 p_id=>wwv_flow_api.id(280612097823549543119)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'AH'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280612097946689543120)
,p_db_column_name=>'FILIAL'
,p_display_order=>20
,p_column_identifier=>'AI'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280612097597830543116)
,p_db_column_name=>'SCR_CCUSTO'
,p_display_order=>30
,p_column_identifier=>'AE'
,p_column_label=>unistr('Centro de Custo (C\00E9lula)')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280612097628444543117)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>40
,p_column_identifier=>'AF'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280612097777960543118)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>50
,p_column_identifier=>'AG'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378813810974947527)
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
 p_id=>wwv_flow_api.id(281378814202336947528)
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
 p_id=>wwv_flow_api.id(281378815029847947529)
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
 p_id=>wwv_flow_api.id(281378815819867947530)
,p_db_column_name=>'SCR_SITUACAO'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>unistr('Situa\00E7\00E3o (F\00E9rias)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148021687308152089549)
,p_db_column_name=>'COD_SINDICATO'
,p_display_order=>100
,p_column_identifier=>'AO'
,p_column_label=>unistr('C\00F3digo Sindicato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148021687121366089547)
,p_db_column_name=>'DESC_SINDICATO'
,p_display_order=>110
,p_column_identifier=>'AM'
,p_column_label=>'Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378816196170947531)
,p_db_column_name=>'DT_INIC_PER_FERIAS'
,p_display_order=>120
,p_column_identifier=>'H'
,p_column_label=>unistr('Data Inicial Per\00EDodo Aquisitivo')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378816635951947532)
,p_db_column_name=>'DT_FIM_PER_FERIAS'
,p_display_order=>130
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Final Per\00EDodo Aquisitivo')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378817029508947532)
,p_db_column_name=>'SALDO'
,p_display_order=>140
,p_column_identifier=>'J'
,p_column_label=>'Saldo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378817485853947533)
,p_db_column_name=>'FALTA_HORA'
,p_display_order=>150
,p_column_identifier=>'K'
,p_column_label=>'Faltas'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378817827526947533)
,p_db_column_name=>'FALTA_MINUTO'
,p_display_order=>160
,p_column_identifier=>'L'
,p_column_label=>'Falta minuto'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378818655649947534)
,p_db_column_name=>'DT_SAIDA_PARC1'
,p_display_order=>180
,p_column_identifier=>'N'
,p_column_label=>unistr('Data Sa\00EDda Parc. 1')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378819054943947534)
,p_db_column_name=>'DT_RETORNO_PARC1'
,p_display_order=>190
,p_column_identifier=>'O'
,p_column_label=>'Data Retorno Parc. 1'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378819416434947535)
,p_db_column_name=>'NUM_DIAS_PARC1'
,p_display_order=>200
,p_column_identifier=>'P'
,p_column_label=>unistr('N\00BA Dias Parc. 1')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378819855306947535)
,p_db_column_name=>'DIAS_ABONO_PEC1'
,p_display_order=>210
,p_column_identifier=>'Q'
,p_column_label=>'Dias Abono Parc. 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378820667607947536)
,p_db_column_name=>'OPCAO_13SAL1'
,p_display_order=>220
,p_column_identifier=>'S'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Sal. Parc. 1')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378821011187947536)
,p_db_column_name=>'DT_SAIDA_PARC2'
,p_display_order=>230
,p_column_identifier=>'T'
,p_column_label=>unistr('Data Sa\00EDda Parc. 2')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378821395947947537)
,p_db_column_name=>'DT_RETORNO_PARC2'
,p_display_order=>240
,p_column_identifier=>'U'
,p_column_label=>'Data Retorno Parc. 2'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378821891942947537)
,p_db_column_name=>'NUM_DIAS_PARC2'
,p_display_order=>250
,p_column_identifier=>'V'
,p_column_label=>unistr('N\00BA Dias Parc. 2')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378822288489947537)
,p_db_column_name=>'DIAS_ABONO_PEC2'
,p_display_order=>260
,p_column_identifier=>'W'
,p_column_label=>'Dias Abono Parc. 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378822662758947539)
,p_db_column_name=>'OPCAO_13SAL2'
,p_display_order=>270
,p_column_identifier=>'X'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Sal. Parc. 2')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280866958133839804082)
,p_db_column_name=>'DT_SAIDA_PARC4'
,p_display_order=>280
,p_column_identifier=>'Y'
,p_column_label=>unistr('Data Sa\00EDda Parc. 3')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280866958200522804083)
,p_db_column_name=>'DT_RETORNO_PARC4'
,p_display_order=>290
,p_column_identifier=>'Z'
,p_column_label=>'Data Retorno Parc. 3'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280866958335747804084)
,p_db_column_name=>'NUM_DIAS_PARC4'
,p_display_order=>300
,p_column_identifier=>'AA'
,p_column_label=>unistr('N\00BA Dias Parc. 3')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280866958402932804085)
,p_db_column_name=>'DIAS_ABONO_PEC4'
,p_display_order=>310
,p_column_identifier=>'AB'
,p_column_label=>'Dias Abono Parc. 3'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280866958542122804086)
,p_db_column_name=>'OPCAO_13SAL4'
,p_display_order=>320
,p_column_identifier=>'AC'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Sal. Parc. 3')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378820256566947536)
,p_db_column_name=>'OBSERVACOES'
,p_display_order=>330
,p_column_identifier=>'R'
,p_column_label=>unistr('Observa\00E7\00F5es')
,p_column_link=>'f?p=&APP_ID.:27:&SESSION.::&DEBUG.::P27_OBSERVACOES:#OBSERVACOES#'
,p_column_linktext=>'Obs.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(280612097434700543115)
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
 p_id=>wwv_flow_api.id(280612098039413543121)
,p_db_column_name=>'DT_LIM_PROG_FERIAS'
,p_display_order=>350
,p_column_identifier=>'AJ'
,p_column_label=>unistr('Data Limite de Programa\00E7\00E3o de F\00E9rias')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(230163758787512275771)
,p_db_column_name=>'SITUACAO_FUNCIONAL'
,p_display_order=>360
,p_column_identifier=>'AK'
,p_column_label=>unistr('Situa\00E7\00E3o Funcional')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P26_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(230205146574300626122)
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
 p_id=>wwv_flow_api.id(148021687470078089550)
,p_db_column_name=>'USUARIO_PROG'
,p_display_order=>380
,p_column_identifier=>'AP'
,p_column_label=>unistr('Usu\00E1rio 1')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148021687545118089551)
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
 p_id=>wwv_flow_api.id(148021687623965089552)
,p_db_column_name=>'USUARIO_PROG2'
,p_display_order=>400
,p_column_identifier=>'AR'
,p_column_label=>unistr('Usu\00E1rio 2')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148021687726426089553)
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
 p_id=>wwv_flow_api.id(148021687875219089554)
,p_db_column_name=>'USUARIO_PROG4'
,p_display_order=>420
,p_column_identifier=>'AT'
,p_column_label=>unistr('Usu\00E1rio 3')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148021687954194089555)
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
 p_id=>wwv_flow_api.id(122607448148475761465)
,p_db_column_name=>'VINCULO'
,p_display_order=>440
,p_column_identifier=>'AV'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(88416397116037095452)
,p_db_column_name=>'SCR_FALTAS'
,p_display_order=>450
,p_column_identifier=>'AW'
,p_column_label=>'Scr Faltas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(88416397239840095453)
,p_db_column_name=>'DT_PAGTO_PARC1'
,p_display_order=>460
,p_column_identifier=>'AX'
,p_column_label=>'Data Pagto Parc. 1'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(88416397311924095454)
,p_db_column_name=>'DT_PAGTO_PARC2'
,p_display_order=>470
,p_column_identifier=>'AY'
,p_column_label=>'Data Pagto Parc. 2'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(88416397390004095455)
,p_db_column_name=>'DT_PAGTO_PARC4'
,p_display_order=>480
,p_column_identifier=>'AZ'
,p_column_label=>'Data Pagto Parc. 3'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(281378823087648947540)
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
 p_id=>wwv_flow_api.id(281378824692293947542)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P26_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(268749542957031424729)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(268749543289417425824)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-minus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(268738103284798145561)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281378825137077947543)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281378824692293947542)
,p_button_name=>'p26_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P26_EMP.,&P26_MAT.,&P26_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(58333024599139067028)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_button_name=>'IA'
,p_button_static_id=>'BTN_IA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
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
 p_id=>wwv_flow_api.id(58333014591316048198)
,p_name=>'P26_FLG'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333014615425048199)
,p_name=>'P26_MSG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333014758998048200)
,p_name=>'P26_STATIC_ID_IR'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333014797724048201)
,p_name=>'P26_USER_PROMPT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333014952693048202)
,p_name=>'P26_SYS_PROMPT'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268738103696695145566)
,p_name=>'P26_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738104091272145571)
,p_name=>'P26_UTILIZA_SECAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268738104449981145574)
,p_name=>'P26_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738104921784145576)
,p_name=>'P26_CCUSTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738105298775145580)
,p_name=>'P26_UNIDADE_ADM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738105644303145583)
,p_name=>'P26_ATIVIDADE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738106039172145587)
,p_name=>'P26_CARGO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738106912070145591)
,p_name=>'P26_MATRICULA_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
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
 p_id=>wwv_flow_api.id(268738107303457145593)
,p_name=>'P26_DATA_INI'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_prompt=>'Data Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268738107721492145596)
,p_name=>'P26_DATA_FIM'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_prompt=>'Data Final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268738108113293145597)
,p_name=>'P26_PESQUISA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378809183521947521)
,p_name=>'P26_SITUACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(268749326605123109032)
,p_item_default=>'N'
,p_prompt=>unistr('Situa\00E7\00E3o Funcional')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Ativos;S,Afastados;F,Desligados;D,Todos;N'
,p_cHeight=>1
,p_display_when=>'P26_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378809503124947522)
,p_name=>'P26_CHK_PENDENTES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(274144793613974073329)
,p_item_default=>'S'
,p_prompt=>unistr('F\00E9rias Pendentes')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Apenas Pendentes;S,Todas as Situa\00E7\00F5es;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378823590493947541)
,p_name=>'P26_EMP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378823975406947541)
,p_name=>'P26_MAT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378824364111947542)
,p_name=>'P26_CHAMADOR'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281378813295543947526)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378825519924947543)
,p_name=>'P26_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281378824692293947542)
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378825902702947544)
,p_name=>'P26_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281378824692293947542)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378826370420947544)
,p_name=>'P26_SIT_FUNC'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281378824692293947542)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378826708760947544)
,p_name=>'P26_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281378824692293947542)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378827157568947545)
,p_name=>'P26_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281378824692293947542)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268749543437589427104)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(268749542957031424729)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268749543858038427107)
,p_event_id=>wwv_flow_api.id(268749543437589427104)
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
 p_id=>wwv_flow_api.id(268749544307338428216)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(268749543289417425824)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268749544708168428217)
,p_event_id=>wwv_flow_api.id(268749544307338428216)
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
 p_id=>wwv_flow_api.id(268749327368147109040)
,p_name=>'Pesquisar'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(268738103284798145561)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268749744795322396691)
,p_event_id=>wwv_flow_api.id(268749327368147109040)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(58333023176098065085)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>40
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58333023500435065088)
,p_event_id=>wwv_flow_api.id(58333023176098065085)
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
 p_id=>wwv_flow_api.id(58333024065585065088)
,p_event_id=>wwv_flow_api.id(58333023176098065085)
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
 p_id=>wwv_flow_api.id(281378828242889947546)
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
 p_id=>wwv_flow_api.id(281378828636040947547)
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
 p_id=>wwv_flow_api.id(281378829052733947547)
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
 p_id=>wwv_flow_api.id(28299020000260000001)
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
