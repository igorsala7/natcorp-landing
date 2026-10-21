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
,p_default_application_id=>9503
,p_default_id_offset=>0
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9503 - Frequência - Lançamentos
--
-- Application Export:
--   Application:     9503
--   Name:            Frequência - Lançamentos
--   Date and Time:   15:14 Monday October 19, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 204
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00204
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>204);
end;
/
prompt --application/pages/page_00204
begin
wwv_flow_api.create_page(
 p_id=>204
,p_user_interface_id=>wwv_flow_api.id(209353596631966209865)
,p_name=>'Abono Individual'
,p_step_title=>'Abono Individual'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_PontoPainel.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Captura clique em links dentro do Interactive Report',
'$(document).on("click", "a.coluna-link", function() {',
'  apex.widget.waitPopup();',
'})'))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_PontoPainel.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'td[headers=FOTO] img { height: 50px }',
'',
'.t-Report-colHead {',
'vertical-align: bottom;',
'padding: 10px;',
'font-weight: 700;',
'-webkit-font-smoothing: antialiased;',
'}',
'',
'.t-Report-cell, .t-Report-colHead {',
'padding: 7px;',
'border-left: 1px solid #dadada;',
'border-top: 1px solid #dadada;',
'}',
'',
'.t-Region-headerItems {padding: 4px;}',
'.t-Region-headerItems--title {padding: 4px;}',
'.t-Button {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--icon {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--iconRight {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--noLabel {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--iconOnly {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--noUI {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.a-IRR-toolbar {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px; padding: 2px; 2px; 2px; 2px;}',
'',
'.a-IRR-buttons .t-Button {',
'    margin-bottom: 0px;',
'}',
'',
'.a-IRR-controlGroup {',
'    margin-bottom: 0px;',
'}',
'',
'.t-Button--hideShow.t-Button {',
'    margin-bottom: 4px;',
'    margin-top: 4px;',
'}',
'',
'.t-Button--hideShow {',
'    margin-bottom: 4px;',
'    margin-top: 4px;',
'}',
'',
'body.waiting * {',
'  cursor: progress !important;',
'}'))
,p_step_template=>wwv_flow_api.id(209353554520098209694)
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Consulte os colaboradores diretos que fazem parte do Centro de Custo onde voc\00EA \00E9 gestor ou os colaboradores que voc\00EA tem acesso \00E0 visualizar.')
,p_last_updated_by=>'BRUNO.SOUSA'
,p_last_upd_yyyymmddhh24miss=>'20260505164129'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(197525649454428321779)
,p_plug_name=>'Tratativa de Abono Individual'
,p_icon_css_classes=>'fa-user'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(209353569060040209768)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>'<p></p>'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(212980871264797793726)
,p_plug_name=>unistr('Par\00E2metros')
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(209353570635128209771)
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(221162085120176324348)
,p_plug_name=>'Colaboradores'
,p_region_name=>'COLABORADORES'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(209353570115087209769)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct COD_EMPRESA, NOME_EMPRESA, FILIAL, NOME_FILIAL, COD_CCUSTO, NOME_CCUSTO, unidade_adm, Atividade, COD_CCUSTO_CONT, CARGO, colaborador, sindicato,  SITUACAO,  ',
'    DT_SITUACAO, DT_ADMISSAO, vinculo, MATRICULA, Tipo, cod_emp_gestor, mat_gestor, gestor ',
'FROM (',
'SELECT -- distinct ',
'       i.cod_empresa COD_EMPRESA, ',
'       i.cod_empresa||'' - ''||Initcap(fnct_nome_empresa(i.cod_empresa,''S'')) NOME_EMPRESA, ',
'       i.FILIAL FILIAL, ',
'       i.FILIAL||'' - ''||Initcap(fnct_nome_filial(i.cod_empresa, i.filial,''S'')) NOME_FILIAL, ',
'       i.cod_ccusto COD_CCUSTO, ',
'       i.cod_ccusto||'' - ''||Initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) NOME_CCUSTO,',
'       i.unidade_adm||'' - ''||Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       C.COD_CCUSTO_CONT, ',
'       i.cargo||'' - ''||Initcap(fnct_nome_cargo(i.cargo)) CARGO, ',
'       I.MATRICULA||'' - ''||Initcap(fnct_nome_func(i.cod_empresa, i.matricula)) colaborador, ',
'       i.num_sind_diss||'' - ''||initcap(fnct_nome_sindicato(i.cod_empresa, i.num_sind_diss,''S'')) sindicato,',
'       i.situacao||'' - ''||Initcap(fnct_nome_situacao(i.situacao)) SITUACAO, ',
'       I.DT_SITUACAO, ',
'       I.DT_ADMISSAO, ',
'       Initcap(fnct_nome_vinculo(i.vinculo)) vinculo,',
'       I.MATRICULA,',
'       ''Colaborador'' Tipo,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.cod_emp_gestor',
'           END cod_emp_gestor,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.matricula_gestor',
'           END mat_gestor,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor||'' - ''||initcap(fnct_nome_func (cx.cod_emp_gestor,',
'                                              cx.matricula_gestor',
'                                             ))',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.matricula_gestor||'' - ''||initcap(fnct_nome_func (c.cod_emp_gestor, c.matricula_gestor))',
'           END gestor',
'  FROM INFORMACOES_FUNCIONAIS I,',
'       CENTRO_DE_CUSTO C,',
'       sub_ccusto sc,',
'       pe_escalas_excecoes e',
' WHERE i.cod_empresa = c.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   ',
'   AND  i.cod_empresa = SC.cod_empresa(+)',
'   and i.COD_SUB_CCUSTO = SC.COD_SUB_CCUSTO(+)',
'   and c.cod = SC.COD_CCUSTO(+) ',
'',
'   and i.cod_empresa = e.cod_empresa',
'   and i.matricula = e.matricula',
'   and i.marca_ponto = ''S''',
'  ',
'    AND CASE WHEN :P_PAINEL = ''PG'' AND I.MATRICULA = :P_MATRICULA_USER THEN',
'        1',
'    ELSE',
'        2',
'    END = 2 ',
'',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
'',
' and ((sc.mat_gestor = :P_MATRICULA_USER or sc.mat_subs = :P_MATRICULA_USER)   ',
'   OR (C.MATRICULA_GESTOR = :P_MATRICULA_USER or C.MATRICULA_SUPLENTE = :P_MATRICULA_USER))',
'   AND (NVL(:P204_chk_colaboradores_diretos, ''S'') = ''S'' )',
'    ',
'--AND F_Acesso_PG_Apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel, ''PONTO'') = ''S''',
'   and ((i.situacao < ''90'' and :p204_situacao = ''A'') or (situacao >= ''90'' and :p204_situacao = ''D'') or (:p204_situacao = ''T''))',
'   and (:p204_empresa     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_EMPRESA, '','')) t))',
'   and (:p204_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_FILIAL, '','')) t))',
'   and (:p204_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_CCUSTO, '','')) t))',
'   and (:p204_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_UNIDADE_ADM, '','')) t))',
'   and (:p204_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_ATIVIDADE, '','')) t))',
'   and (:p204_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_CARGO, '','')) t))',
'   and (:p204_MATRICULA   is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_MATRICULA, '','')) t))',
'',
'',
'UNION',
'',
'SELECT -- distinct ',
'       i.cod_empresa COD_EMPRESA, ',
'       i.cod_empresa||'' - ''||Initcap(fnct_nome_empresa(i.cod_empresa,''S'')) NOME_EMPRESA, ',
'       i.FILIAL FILIAL, ',
'       i.FILIAL||'' - ''||Initcap(fnct_nome_filial(i.cod_empresa, i.filial,''S'')) NOME_FILIAL, ',
'       i.cod_ccusto COD_CCUSTO, ',
'       i.cod_ccusto||'' - ''||Initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) NOME_CCUSTO,',
'       i.unidade_adm||'' - ''||Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       C.COD_CCUSTO_CONT, ',
'       i.cargo||'' - ''||Initcap(fnct_nome_cargo(i.cargo)) CARGO, ',
'       I.MATRICULA||'' - ''||Initcap(fnct_nome_func(i.cod_empresa, i.matricula)) colaborador, ',
'       i.num_sind_diss||'' - ''||initcap(fnct_nome_sindicato(i.cod_empresa, i.num_sind_diss,''S'')) sindicato,',
'       i.situacao||'' - ''||Initcap(fnct_nome_situacao(i.situacao)) SITUACAO, ',
'       I.DT_SITUACAO, ',
'       I.DT_ADMISSAO, ',
'       Initcap(fnct_nome_vinculo(i.vinculo)) vinculo,',
'       I.MATRICULA,',
'       ''Colaborador'' Tipo,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.cod_emp_gestor',
'           END cod_emp_gestor,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.matricula_gestor',
'           END mat_gestor,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor||'' - ''||initcap(fnct_nome_func (cx.cod_emp_gestor,',
'                                              cx.matricula_gestor',
'                                             ))',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.matricula_gestor||'' - ''||initcap(fnct_nome_func (c.cod_emp_gestor, c.matricula_gestor))',
'           END gestor',
'  FROM INFORMACOES_FUNCIONAIS I,',
'  CENTRO_DE_CUSTO C,',
'       pe_escalas_excecoes e',
' WHERE i.cod_empresa = c.cod_empresa --(+)',
'   and i.cod_ccusto = c.cod --(+)',
'    ',
'    AND CASE WHEN :P_PAINEL = ''PG'' AND I.MATRICULA = :P_MATRICULA_USER THEN',
'        1',
'    ELSE',
'        2',
'    END = 2',
'    ',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
'      ',
'   and i.cod_empresa = e.cod_empresa',
'   and i.matricula = e.matricula',
'   and i.marca_ponto = ''S''',
'   AND (NVL(:P204_chk_colaboradores_diretos,''N'') = ''N'' )',
'  -- AND F_Acesso_PG_Apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel, ''PONTO'') = ''S''',
'   and ((i.situacao < ''90'' and :p204_situacao = ''A'') or (situacao >= ''90'' and :p204_situacao = ''D'') or (:p204_situacao = ''T''))',
'   and (:p204_empresa     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_EMPRESA, '','')) t))',
'   and (:p204_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_FILIAL, '','')) t))',
'   and (:p204_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_CCUSTO, '','')) t))',
'   and (:p204_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_UNIDADE_ADM, '','')) t))',
'   and (:p204_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_ATIVIDADE, '','')) t))',
'   and (:p204_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_CARGO, '','')) t))',
'   and (:p204_MATRICULA   is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p204_MATRICULA, '','')) t))',
')'))
,p_plug_source_type=>'NATIVE_IR'
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
 p_id=>wwv_flow_api.id(221162085262626324349)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'Para mais resultados, filtre sua pesquisa.'
,p_no_data_found_message=>'Para ver os resultados, filtre sua consulta.'
,p_allow_save_rpt_public=>'Y'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:RP,203:P203_EMP,P203_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_detail_link_attr=>'class="coluna-link"'
,p_owner=>'IGOR'
,p_internal_uid=>25271045629577308238
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793806512016039087)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793806838991039087)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793807296258039088)
,p_db_column_name=>'FILIAL'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793807668080039088)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793808081419039089)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'C.Custo'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793808460009039089)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>unistr('Centro de Custo (C\00E9lula)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793808833051039090)
,p_db_column_name=>'COD_CCUSTO_CONT'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'C.Custo Cont.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793805662071039086)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>90
,p_column_identifier=>'V'
,p_column_label=>'Colaborador'
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#COLABORADOR#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793809249972039091)
,p_db_column_name=>'CARGO'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793809709432039091)
,p_db_column_name=>'SITUACAO'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793810896393039093)
,p_db_column_name=>'VINCULO'
,p_display_order=>120
,p_column_identifier=>'P'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793810078331039092)
,p_db_column_name=>'DT_SITUACAO'
,p_display_order=>130
,p_column_identifier=>'N'
,p_column_label=>unistr('Data de Situa\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793810455634039093)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>unistr('Data de Admiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793805303706039085)
,p_db_column_name=>'TIPO'
,p_display_order=>150
,p_column_identifier=>'T'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793806050792039086)
,p_db_column_name=>'MATRICULA'
,p_display_order=>160
,p_column_identifier=>'W'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793802508774039082)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>180
,p_column_identifier=>'Y'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793802854247039082)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>190
,p_column_identifier=>'Z'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793803239391039083)
,p_db_column_name=>'SINDICATO'
,p_display_order=>200
,p_column_identifier=>'AA'
,p_column_label=>'Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793803696770039083)
,p_db_column_name=>'COD_EMP_GESTOR'
,p_display_order=>210
,p_column_identifier=>'AB'
,p_column_label=>'Cod emp gestor'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793804054202039084)
,p_db_column_name=>'MAT_GESTOR'
,p_display_order=>220
,p_column_identifier=>'AC'
,p_column_label=>'Mat gestor'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(196793804493891039084)
,p_db_column_name=>'GESTOR'
,p_display_order=>230
,p_column_identifier=>'AD'
,p_column_label=>'Gestor'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMP_GESTOR#,#MAT_GESTOR#'
,p_column_linktext=>'#GESTOR#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(212116253066270785539)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dados B\00E1sicos')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'9027716'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_EMPRESA:NOME_FILIAL:NOME_CCUSTO:UNIDADE_ADM:ATIVIDADE:COLABORADOR:CARGO:SINDICATO:SITUACAO:GESTOR'
,p_sort_column_1=>'TIPO'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'COD_EMPRESA'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'FILIAL'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'COD_CCUSTO'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'MATRICULA'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(212116256380591800200)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dados B\00E1sicos (Resumido)')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'9027720'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_EMPRESA:NOME_FILIAL:NOME_CCUSTO:COLABORADOR:CARGO:SITUACAO:GESTOR'
,p_sort_column_1=>'TIPO'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'COD_EMPRESA'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'FILIAL'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'COD_CCUSTO'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'MATRICULA'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(221162232981552780047)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'9027724'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_EMPRESA:NOME_FILIAL:NOME_CCUSTO:UNIDADE_ADM:ATIVIDADE:COLABORADOR:CARGO:SINDICATO:SITUACAO:DT_SITUACAO:COD_CCUSTO_CONT:DT_ADMISSAO:VINCULO:GESTOR'
,p_sort_column_1=>'TIPO'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'COD_EMPRESA'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'FILIAL'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'COD_CCUSTO'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'MATRICULA'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(196793796628949039075)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(209353591600446209815)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(196793816017325039099)
,p_branch_name=>'pede_login'
,p_branch_action=>'f?p=&APP_ID.:900:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_HEADER'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_USUARIO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(196793797000580039075)
,p_name=>'P204_CHK_COLABORADORES_DIRETOS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>'Colaboradores Diretos'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(209353590986122209808)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr(' - Indique "Sim" para consultar os colaboradores diretos que fazem parte do Centro de Custo onde voc\00EA \00E9 gestor.'),
'',
unistr(' - Indique "N\00E3o" para consultar os colaboradores que voc\00EA tem acesso \00E0 visualizar, indepente se \00E9 do seu Centro de Custo.')))
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(196793797877977039076)
,p_name=>'P204_SITUACAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_item_default=>'A'
,p_prompt=>unistr('Situa\00E7\00E3o Funcional')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Ativos;A,Demitidos;D,Todos;T'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(209353590986122209808)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(196793798256022039077)
,p_name=>'P204_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod||'' - ''||initcap(nvl(e.nome_abrev,e.nome)) descricao, e.cod codigo ',
'  from empresas e',
' WHERE ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
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
 p_id=>wwv_flow_api.id(196793798704877039077)
,p_name=>'P204_UTILIZA_SECAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(196793799033540039077)
,p_name=>'P204_FILIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_filial||'' - ''||Initcap(nvl(f.sigla,f.nome_filial)) descricao, f.cod_filial',
'  from filiais f',
'where ((instr('',''||:p204_empresa||'','','',''||f.cod_empresa||'','') > 0) or (:p204_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P204_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
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
 p_id=>wwv_flow_api.id(196793799432187039078)
,p_name=>'P204_CCUSTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(f.cod_empresa, f.cod_ccusto)) descricao, f.cod_ccusto ',
'from filial_ccusto f, centro_de_custo c',
'where f.cod_empresa = c.cod_empresa',
'and f.cod_ccusto = c.cod',
'--and ((:P_PAINEL = ''PO'') or (sysdate between c.dt_inic_vige and nvl(c.dt_fim_vige, sysdate)))',
'and ((instr('',''||:p204_empresa||'','','',''||f.cod_empresa||'','') > 0) or (:p204_empresa is null))',
'and ((instr('',''||:p204_filial||'','','',''||f.cod_filial||'','') > 0) or (:p204_filial is null))',
'and f_acesso_cc(c.cod_empresa, c.cod) = ''S''',
'order by 2',
'',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P204_EMPRESA,P204_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
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
 p_id=>wwv_flow_api.id(196793799788908039078)
,p_name=>'P204_UNIDADE_ADM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p204_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p204_empresa is null))',
'       and ((instr('',''||:p204_filial||'','','',''||a.cod_filial||'','') > 0) or (:p204_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p204_ccusto',
'       and ((instr('',''||:p204_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p204_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p204_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p204_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p204_empresa is null))',
'       and ((instr('',''||:p204_filial||'','','',''||a.cod_filial||'','') > 0) or (:p204_filial is null))',
'       and :p204_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P204_EMPRESA,P204_FILIAL,P204_CCUSTO,P204_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
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
 p_id=>wwv_flow_api.id(196793800163379039078)
,p_name=>'P204_ATIVIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p204_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p204_empresa is null))',
'   and ((instr('',''||:p204_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p204_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p204_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p204_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P204_CCUSTO,P204_UNIDADE_ADM,P204_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(196793800620680039079)
,p_name=>'P204_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
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
 p_id=>wwv_flow_api.id(196793800996683039079)
,p_name=>'P204_MATRICULA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) d, i.matricula',
'  from informacoes_funcionais i',
' where ((i.situacao < ''90'' and :p204_situacao = ''A'') or (i.situacao >= ''90'' and :p204_situacao = ''D'') or (:p204_situacao = ''T''))',
'   and (:P204_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P204_EMPRESA, '','')) t))',
'   and (:P204_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P204_FILIAL, '','')) t))',
'   and (:P204_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P204_CCUSTO, '','')) t))',
'   and (:P204_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P204_UNIDADE_ADM, '','')) t))',
'   and (:P204_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P204_ATIVIDADE, '','')) t))',
'   AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P204_CCUSTO,P204_UNIDADE_ADM,P204_UTILIZA_SECAO,P204_ATIVIDADE,P204_EMPRESA,P204_FILIAL,P204_CHK_COLABORADORES_DIRETOS,P204_SITUACAO,P204_CARGO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(209353590986122209808)
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
 p_id=>wwv_flow_api.id(196793801366402039080)
,p_name=>'P204_PESQUISA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(212980871264797793726)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(196793813617589039097)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P204_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(196793814094763039098)
,p_event_id=>wwv_flow_api.id(196793813617589039097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p204_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p204_empresa||'','','',''||cod_empresa||'','') > 0) or (:p204_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P204_EMPRESA'
,p_attribute_03=>'P204_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(196793814467557039098)
,p_name=>'Pesquisa'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(196793796628949039075)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(196793815524866039099)
,p_event_id=>wwv_flow_api.id(196793814467557039098)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(196793813191596039097)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SETA_USER'
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
 p_id=>wwv_flow_api.id(196793812788635039097)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POPULA_GESTOR2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'IF :p204_CHK_COLABORADORES_DIRETOS IS NULL THEN',
'  IF :P_PAINEL = ''PO'' THEN',
'     :p204_CHK_COLABORADORES_DIRETOS := ''N'';',
'  ELSE',
'     :p204_CHK_COLABORADORES_DIRETOS := ''S'';',
'  END IF;',
'END IF;',
'',
'if :P204_SITUACAO is null then',
':P204_SITUACAO := ''A'';',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990204000000000002)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_PONTO_INDICADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - painel "Conferencia do ponto" (Natcorp_PontoPainel.js). FONTE: brand/apex/app/NC_PONTO_INDICADORES.plsql.sql',
'   (guia PONTOPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-pontopainel-pagina204.py. */',
'declare',
'  MAX_PES   constant pls_integer := 8000;      /* acima disso o painel pede para filtrar */',
unistr('  MAX_DIAS  constant pls_integer := 62;        /* per\00EDodo maior que isso: s\00F3 os primeiros 62 dias */'),
'  l_hoje    date := trunc(sysdate);',
'  l_saida   clob;',
'  l_cru     clob;',
'  l_buf     varchar2(32767);',
'  l_passo   varchar2(30) := ''inicio'';',
'  l_t0      number := dbms_utility.get_time;',
'  l_t1      number;',
'  l_t2      number;',
'  l_n       pls_integer;',
'  l_pi      pls_integer;',
'  l_off     pls_integer;',
'  l_len     pls_integer;',
'  l_total   pls_integer := 0;',
'  l_cortou  boolean := false;',
'  l_u0      varchar2(4000);',
'  l_url     varchar2(4000);',
'  l_corte   pls_integer;',
'  l_dims    sys.odcivarchar2list := sys.odcivarchar2list(''emp'', ''fil'', ''cc'', ''un'', ''at'', ''car'', ''sind'', ''gest'', ''vin'');',
'',
unistr('  /* os filtros do relat\00F3rio: ",700,91," e a linha entra quando ",c\00F3digo," est\00E1 dentro */'),
'  l_emp varchar2(32767) := '','' || :P204_EMPRESA || '','';     f_emp number := case when :P204_EMPRESA is null then 0 else 1 end;',
'  l_fil varchar2(32767) := '','' || :P204_FILIAL || '','';      f_fil number := case when :P204_FILIAL is null then 0 else 1 end;',
'  l_cc  varchar2(32767) := '','' || :P204_CCUSTO || '','';      f_cc  number := case when :P204_CCUSTO is null then 0 else 1 end;',
'  l_un  varchar2(32767) := '','' || :P204_UNIDADE_ADM || '',''; f_un  number := case when :P204_UNIDADE_ADM is null then 0 else 1 end;',
'  l_at  varchar2(32767) := '','' || :P204_ATIVIDADE || '','';   f_at  number := case when :P204_ATIVIDADE is null then 0 else 1 end;',
'  l_car varchar2(32767) := '','' || :P204_CARGO || '','';       f_car number := case when :P204_CARGO is null then 0 else 1 end;',
'  l_mat varchar2(32767) := '','' || :P204_MATRICULA || '','';   f_mat number := case when :P204_MATRICULA is null then 0 else 1 end;',
'  l_sit  varchar2(10)   := nvl(:P204_SITUACAO, ''A'');',
'  l_dir  varchar2(10)   := :P204_CHK_COLABORADORES_DIRETOS;',
'',
'  type t_num is table of number index by varchar2(400);',
'  type t_txt is table of varchar2(4000) index by varchar2(400);',
'  type t_lin is table of varchar2(4000) index by pls_integer;',
unistr('  cache   t_num;      /* "dim|empresa|c\00F3digo" -> n\00FAmero do nome */'),
unistr('  por_rot t_num;      /* "dim|nome" -> n\00FAmero (dois c\00F3digos com o MESMO nome viram um s\00F3, como na tabela) */'),
'  qtd     t_num;      /* dim -> quantos nomes */',
unistr('  rot     t_txt;      /* "dim#n\00FAmero" -> nome */'),
unistr('  pes     t_num;      /* "empresa|matr\00EDcula" -> n\00FAmero da pessoa */'),
unistr('  pes_ini t_lin;      /* n\00FAmero da pessoa -> in\00EDcio do per\00EDodo (yyyymmdd) */'),
unistr('  pes_len t_num;      /* n\00FAmero da pessoa -> dias do per\00EDodo */'),
unistr('  dm      t_lin;      /* n\00FAmero da pessoa -> batidas por dia */'),
unistr('  da      t_lin;      /* n\00FAmero da pessoa -> ajustadas por dia */'),
unistr('  lin     t_lin;      /* n\00FAmero da pessoa -> a linha de "pes", pronta */'),
unistr('  rq      t_lin;      /* n\00FAmero da pessoa -> os pedidos abertos dela, prontos */'),
unistr('  l_ne    pls_integer := 0;   /* quantos itens j\00E1 foram para "ev" */'),
unistr('  nom     t_lin;      /* n\00FAmero da pessoa -> "mat - Nome" */'),
unistr('  pers    t_num;      /* "ini|fim" -> n\00FAmero do per\00EDodo */'),
unistr('  pers_t  t_lin;      /* n\00FAmero do per\00EDodo -> ''["ini","fim"]'' */'),
unistr('  evn     t_num;      /* "B|cod" / "P|cod" -> n\00FAmero do evento */'),
unistr('  evs_t   t_lin;      /* n\00FAmero do evento -> nome */'),
unistr('  evs_k   t_lin;      /* n\00FAmero do evento -> C / D / H */'),
'  l_npes  pls_integer := 0;',
'  l_nper  pls_integer := 0;',
'  l_nev   pls_integer := 0;',
'',
'  procedure descarrega is',
'  begin',
'    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;',
'  end;',
'  procedure cru(p varchar2) is',
'  begin',
'    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;',
'    l_buf := l_buf || p;',
'  end;',
'  procedure manda(c clob, p_ate number) is',
'    p number := 1;',
'  begin',
'    while p <= p_ate loop',
'      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));',
'      p := p + 8000;',
'    end loop;',
'  end;',
'  function js(p varchar2) return varchar2 is',
'  begin',
'    return ''"'' || apex_escape.json(p) || ''"'';',
'  end;',
'  function n(p number) return varchar2 is',
'  begin',
'    return to_char(nvl(p, 0), ''FM99999999990'');',
'  end;',
'',
unistr('  /* o nome de um c\00F3digo, IGUAL ao da coluna do relat\00F3rio */'),
'  function nome_dim(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2) return varchar2 is',
'    r varchar2(4000);',
'  begin',
'    if p_dim = ''gest'' and p_cod2 is null then return ''Sem gestor''; end if;',
unistr('    if p_cod is null and p_dim <> ''vin'' then return ''N\00E3o informado''; end if;'),
'    begin',
'      r := case p_dim',
'             when ''emp''  then p_cod || '' - '' || initcap(fnct_nome_empresa(p_cod, ''S''))',
'             when ''fil''  then p_cod || '' - '' || initcap(fnct_nome_filial(p_emp, p_cod, ''S''))',
'             when ''cc''   then p_cod || '' - '' || initcap(fnct_nome_ccusto(p_emp, p_cod))',
'             when ''un''   then p_cod || '' - '' || initcap(fnct_nome_unidade_adm(p_emp, null, p_cod))',
'             when ''at''   then p_cod || '' - '' || initcap(fnct_nome_atividade(p_cod))',
'             when ''car''  then p_cod || '' - '' || initcap(fnct_nome_cargo(p_cod))',
'             when ''sind'' then p_cod || '' - '' || initcap(fnct_nome_sindicato(p_emp, p_cod, ''S''))',
'             when ''gest'' then p_cod2 || '' - '' || initcap(fnct_nome_func(p_cod, p_cod2))',
'             when ''vin''  then initcap(fnct_nome_vinculo(p_cod))',
'           end;',
'    exception when others then r := p_cod;',
'    end;',
unistr('    return substr(nvl(r, ''N\00E3o informado''), 1, 380);'),
'  end;',
unistr('  /* o n\00FAmero do nome (cria na primeira vez) */'),
'  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2 default null) return pls_integer is',
'    k varchar2(400) := p_dim || ''|'' || p_emp || ''|'' || p_cod || ''|'' || p_cod2;',
'    t varchar2(400);',
'    i pls_integer;',
'  begin',
'    if cache.exists(k) then return cache(k); end if;',
'    t := nome_dim(p_dim, p_emp, p_cod, p_cod2);',
'    if por_rot.exists(p_dim || ''|'' || t) then',
'      i := por_rot(p_dim || ''|'' || t);',
'    else',
'      i := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;',
'      qtd(p_dim) := i + 1;',
'      rot(p_dim || ''#'' || i) := t;',
'      por_rot(p_dim || ''|'' || t) := i;',
'    end if;',
'    cache(k) := i;',
'    return i;',
'  end;',
unistr('  /* troca o caractere da posi\00E7\00E3o p (1 = primeiro dia) de uma tira de dias */'),
'  function poe(s varchar2, p pls_integer, c varchar2) return varchar2 is',
'  begin',
'    return substr(s, 1, p - 1) || c || substr(s, p + 1);',
'  end;',
'begin',
'  dbms_lob.createtemporary(l_cru, true);',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''v'', 1);',
'  apex_json.write(''hoje'', to_char(l_hoje, ''dd/mm/yyyy''));',
'  apex_json.write(''painel'', :P_PAINEL);',
'',
'  l_passo := ''consulta'';',
'  l_t1 := dbms_utility.get_time;',
'  cru(''"ev":['');',
'  for r in (',
'    with pop as (',
unistr('      /* A CONSULTA DO RELAT\00D3RIO, s\00F3 com os c\00F3digos. Metade 1: "Colaboradores Diretos" = Sim */'),
'      select distinct',
'             i.cod_empresa emp, i.matricula mat, i.filial fil, i.cod_ccusto cc, i.unidade_adm un, i.cod_atividade ativ,',
'             i.cargo car, i.num_sind_diss sind, i.vinculo vin, i.situacao sit,',
'             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor',
'                    then (select cx.cod_emp_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)',
'                  when i.matricula <> c.matricula_gestor then c.cod_emp_gestor end gemp,',
'             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor',
'                    then (select cx.matricula_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)',
'                  when i.matricula <> c.matricula_gestor then c.matricula_gestor end gmat',
'        from informacoes_funcionais i, centro_de_custo c, sub_ccusto sc, pe_escalas_excecoes e',
'       where i.cod_empresa = c.cod_empresa',
'         and i.cod_ccusto = c.cod',
'         and i.cod_empresa = sc.cod_empresa(+)',
'         and i.cod_sub_ccusto = sc.cod_sub_ccusto(+)',
'         and c.cod = sc.cod_ccusto(+)',
'         and i.cod_empresa = e.cod_empresa',
'         and i.matricula = e.matricula',
'         and i.marca_ponto = ''S''',
'         and case when :P_PAINEL = ''PG'' and i.matricula = :P_MATRICULA_USER then 1 else 2 end = 2',
'         and pkg_matricula_listagem.retorna_mostra(p_cod_empresa => :P_EMPRESA_USER, p_matricula => :P_MATRICULA_USER,',
'                                                   p_usuario => :P_USUARIO, p_logado => i.matricula, p_painel => :P_PAINEL) = ''S''',
'         and ((sc.mat_gestor = :P_MATRICULA_USER or sc.mat_subs = :P_MATRICULA_USER)',
'           or (c.matricula_gestor = :P_MATRICULA_USER or c.matricula_suplente = :P_MATRICULA_USER))',
'         and nvl(l_dir, ''S'') = ''S''',
'         and ((i.situacao < ''90'' and l_sit = ''A'') or (i.situacao >= ''90'' and l_sit = ''D'') or (l_sit = ''T''))',
'         and (f_emp = 0 or instr(l_emp, '','' || i.cod_empresa || '','') > 0)',
'         and (f_fil = 0 or instr(l_fil, '','' || i.filial || '','') > 0)',
'         and (f_cc  = 0 or instr(l_cc,  '','' || i.cod_ccusto || '','') > 0)',
'         and (f_un  = 0 or instr(l_un,  '','' || i.unidade_adm || '','') > 0)',
'         and (f_at  = 0 or instr(l_at,  '','' || i.cod_atividade || '','') > 0)',
'         and (f_car = 0 or instr(l_car, '','' || i.cargo || '','') > 0)',
'         and (f_mat = 0 or instr(l_mat, '','' || i.matricula || '','') > 0)',
'      union',
unistr('      /* Metade 2: "Colaboradores Diretos" = N\00E3o (todos que o usu\00E1rio pode ver) */'),
'      select distinct',
'             i.cod_empresa, i.matricula, i.filial, i.cod_ccusto, i.unidade_adm, i.cod_atividade,',
'             i.cargo, i.num_sind_diss, i.vinculo, i.situacao,',
'             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor',
'                    then (select cx.cod_emp_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)',
'                  when i.matricula <> c.matricula_gestor then c.cod_emp_gestor end,',
'             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor',
'                    then (select cx.matricula_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)',
'                  when i.matricula <> c.matricula_gestor then c.matricula_gestor end',
'        from informacoes_funcionais i, centro_de_custo c, pe_escalas_excecoes e',
'       where i.cod_empresa = c.cod_empresa',
'         and i.cod_ccusto = c.cod',
'         and case when :P_PAINEL = ''PG'' and i.matricula = :P_MATRICULA_USER then 1 else 2 end = 2',
'         and pkg_matricula_listagem.retorna_mostra(p_cod_empresa => :P_EMPRESA_USER, p_matricula => :P_MATRICULA_USER,',
'                                                   p_usuario => :P_USUARIO, p_logado => i.matricula, p_painel => :P_PAINEL) = ''S''',
'         and i.cod_empresa = e.cod_empresa',
'         and i.matricula = e.matricula',
'         and i.marca_ponto = ''S''',
'         and nvl(l_dir, ''N'') = ''N''',
'         and ((i.situacao < ''90'' and l_sit = ''A'') or (i.situacao >= ''90'' and l_sit = ''D'') or (l_sit = ''T''))',
'         and (f_emp = 0 or instr(l_emp, '','' || i.cod_empresa || '','') > 0)',
'         and (f_fil = 0 or instr(l_fil, '','' || i.filial || '','') > 0)',
'         and (f_cc  = 0 or instr(l_cc,  '','' || i.cod_ccusto || '','') > 0)',
'         and (f_un  = 0 or instr(l_un,  '','' || i.unidade_adm || '','') > 0)',
'         and (f_at  = 0 or instr(l_at,  '','' || i.cod_atividade || '','') > 0)',
'         and (f_car = 0 or instr(l_car, '','' || i.cargo || '','') > 0)',
'         and (f_mat = 0 or instr(l_mat, '','' || i.matricula || '','') > 0)',
'    ),',
'    prh as (',
unistr('      /* o per\00EDodo do ponto de cada empresa, pelo painel (o mesmo do popula_colab da 203) */'),
'      select cod_empresa,',
'             trunc(max(case :P_PAINEL when ''PO'' then data_ini_ref_ponto',
'                                      when ''PG'' then nvl(dt_ini_ponto_gestor, data_ini_ref_ponto)',
'                                      else dt_ini_ponto_colab end)) ini,',
'             trunc(max(case :P_PAINEL when ''PO'' then data_fim_ref_ponto',
'                                      when ''PG'' then nvl(dt_fim_ponto_gestor, data_fim_ref_ponto)',
'                                      else dt_fim_ponto_colab end)) fim',
'        from parametros_recursos_humanos',
'       group by cod_empresa',
'    ),',
'    per as (',
'      select /*+ materialize */ p.*, x.ini, x.fim,',
unistr('             /* jornada do tipo 2 no fim do per\00EDodo (a mesma pergunta do quadro "Per\00EDodo" da 203) */'),
'             case when x.fim is null then 0 else',
'               (select count(*) from pe_jornadas j',
'                 where j.tipo_jornada = 2',
'                   and j.cod_jornada = nvl(fnct_pe_retorna_jornada(p.emp, p.mat, x.fim, ''S''),',
'                                           fnct_pe_retorna_jornada(p.emp, p.mat, x.fim, ''N''))) end t2',
'        from pop p, prh x',
'       where x.cod_empresa(+) = p.emp',
'    )',
'    /* P = cada pessoa */',
'    select 0 ord, ''P'' k, to_char(p.emp) emp, to_char(p.mat) mat,',
'           to_char(p.fil) a1, to_char(p.cc) a2, to_char(p.un) a3, to_char(p.ativ) a4, to_char(p.car) a5,',
'           to_char(p.sind) a6, to_char(p.vin) a7, to_char(p.sit) a8, to_char(p.gemp) a9, to_char(p.gmat) a10,',
'           to_char(p.ini, ''yyyymmdd'') || ''|'' || to_char(p.fim, ''yyyymmdd'') a11,',
'           p.t2 n1, cast(null as number) n2, cast(null as number) n3',
'      from per p',
'    union all',
unistr('    /* M = batidas de cada dia do per\00EDodo */'),
'    select 1, ''M'', to_char(t.cod_empresa), to_char(t.matricula),',
'           to_char(trunc(nvl(t.vira_dia, t.data_ponto)), ''yyyymmdd''), null, null, null, null, null, null, null, null, null, null,',
'           count(case when nvl(t.hora_batida_abono, t.hora_batida) is not null or t.cod_justificativa is not null then 1 end),',
'           count(t.hora_batida_abono),',
'           count(*)',
'      from per p, pe_tratamento_batimentos t',
'     where t.cod_empresa = p.emp',
'       and t.matricula = p.mat',
'       and nvl(t.vira_dia, t.data_ponto) between p.ini and p.fim',
'     group by t.cod_empresa, t.matricula, trunc(nvl(t.vira_dia, t.data_ponto))',
'    union all',
unistr('    /* E = eventos da apura\00E7\00E3o, banco de horas (cr\00E9dito / d\00E9bito) */'),
'    select 2, ''E'', to_char(a.cod_empresa), to_char(a.matricula),',
'           b.tipo, ''B|'' || a.cod_evento, a.cod_evento || '' - '' || b.descricao, null, null, null, null, null, null, null, null,',
'           sum(case when regexp_like(a.qtd_horas, ''^-?[0-9]+:[0-9]{1,2}$'')',
'                    then to_number(substr(a.qtd_horas, 1, instr(a.qtd_horas, '':'') - 1)) * 60 + to_number(substr(a.qtd_horas, instr(a.qtd_horas, '':'') + 1))',
'                    else 0 end), null, null',
'      from per p, pe_resultado_apuracao a, pe_eventos_banco b',
'     where a.cod_empresa = p.emp',
'       and a.matricula = p.mat',
'       and a.tipo_evento = ''BANCO''',
'       and a.id_apuracao != 9020',
'       and nvl(a.plantao, ''N'') = ''N''',
'       and ((p.t2 > 0 and a.id_apuracao > 9000 and a.data = p.fim) or (p.t2 = 0 and a.data between p.ini and p.fim))',
'       and a.cod_empresa = b.cod_empresa',
'       and a.cod_evento = b.cod_evento_banco',
'     group by a.cod_empresa, a.matricula, b.tipo, a.cod_evento, b.descricao',
'    union all',
unistr('    /* E = eventos da apura\00E7\00E3o que v\00E3o para a folha */'),
'    select 2, ''E'', to_char(a.cod_empresa), to_char(a.matricula),',
'           ''H'', ''P|'' || a.cod_evento, a.cod_evento || '' - '' || f.descricao, null, null, null, null, null, null, null, null,',
'           sum(case when regexp_like(a.qtd_horas, ''^-?[0-9]+:[0-9]{1,2}$'')',
'                    then to_number(substr(a.qtd_horas, 1, instr(a.qtd_horas, '':'') - 1)) * 60 + to_number(substr(a.qtd_horas, instr(a.qtd_horas, '':'') + 1))',
'                    else 0 end), null, null',
'      from per p, pe_resultado_apuracao a, pe_eventos_folha f',
'     where a.cod_empresa = p.emp',
'       and a.matricula = p.mat',
'       and a.tipo_evento = ''PONTO''',
'       and a.id_apuracao != 9020',
'       and nvl(a.plantao, ''N'') = ''N''',
'       and ((p.t2 > 0 and a.id_apuracao > 9000 and a.data = p.fim) or (p.t2 = 0 and a.data between p.ini and p.fim))',
'       and a.cod_empresa = f.cod_empresa',
'       and a.cod_evento = f.cod_evento_folha',
'     group by a.cod_empresa, a.matricula, a.cod_evento, f.descricao',
'    union all',
unistr('    /* R = pedidos abertos: ajuste de marca\00E7\00E3o */'),
'    select 3, ''R'', to_char(r.cod_empresa), to_char(r.matricula), ''0'', null, null, null, null, null, null, null, null, null, null,',
'           count(distinct r.cod_req), max(l_hoje - trunc(r.dt_req)), null',
'      from per p, pe_req_tratamento_batimentos r',
'     where r.cod_empresa = p.emp',
'       and r.matricula = p.mat',
'       and r.cod_sit_req = 1',
'       and r.data_ponto between p.ini and p.fim',
'     group by r.cod_empresa, r.matricula',
'    union all',
unistr('    /* R = pedidos abertos: apura\00E7\00E3o */'),
'    select 3, ''R'', to_char(r.cod_empresa), to_char(r.matricula), ''1'', null, null, null, null, null, null, null, null, null, null,',
'           count(distinct r.cod_req), max(l_hoje - trunc(c.dt_solicitacao)), null',
'      from per p, pe_req_apuracao r, consulta_requisicoes c',
'     where r.cod_empresa = p.emp',
'       and r.matricula = p.mat',
'       and r.cod_sit_req = 1',
'       and r.data_ponto between p.ini and p.fim',
'       and upper(c.tipo_req) = ''REQ_APURA''',
'       and c.cod_empresa = r.cod_empresa',
'       and c.solicitacao = r.cod_req',
'     group by r.cod_empresa, r.matricula',
'    union all',
'    /* R = pedidos abertos: hora extra */',
'    select 3, ''R'', to_char(r.cod_empresa), to_char(r.matricula), ''2'', null, null, null, null, null, null, null, null, null, null,',
'           count(distinct r.cod_req), max(l_hoje - trunc(c.dt_solicitacao)), null',
'      from per p, pe_req_hora_extra r, consulta_requisicoes c',
'     where r.cod_empresa = p.emp',
'       and r.matricula = p.mat',
'       and r.cod_sit_req = 1',
'       and r.data_ponto between p.ini and p.fim',
'       and upper(c.tipo_req) = ''REQ_HE''',
'       and c.cod_empresa = r.cod_empresa',
'       and c.solicitacao = r.cod_req',
'     group by r.cod_empresa, r.matricula',
'     order by 1',
'  ) loop',
'    if r.k = ''P'' then',
'      l_total := l_total + 1;',
'      if l_npes >= MAX_PES then',
'        l_cortou := true;',
'      elsif not pes.exists(r.emp || ''|'' || r.mat) then',
'        l_pi := l_npes;',
'        l_npes := l_npes + 1;',
'        pes(r.emp || ''|'' || r.mat) := l_pi;',
unistr('        /* o per\00EDodo: "yyyymmdd|yyyymmdd" -> n\00FAmero; os dias viram uma tira de zeros */'),
'        if r.a11 <> ''|'' then',
'          if not pers.exists(r.a11) then',
'            pers(r.a11) := l_nper;',
'            pers_t(l_nper) := ''["'' || to_char(to_date(substr(r.a11, 1, 8), ''yyyymmdd''), ''dd/mm/yyyy'') || ''","'' ||',
'                              to_char(to_date(substr(r.a11, 10, 8), ''yyyymmdd''), ''dd/mm/yyyy'') || ''"]'';',
'            l_nper := l_nper + 1;',
'          end if;',
'          pes_ini(l_pi) := substr(r.a11, 1, 8);',
'          l_len := least(MAX_DIAS, to_date(substr(r.a11, 10, 8), ''yyyymmdd'') - to_date(substr(r.a11, 1, 8), ''yyyymmdd'') + 1);',
'          if l_len < 1 then l_len := 1; end if;',
'          pes_len(to_char(l_pi)) := l_len;',
'          dm(l_pi) := rpad(''0'', l_len, ''0'');',
'          da(l_pi) := rpad(''0'', l_len, ''0'');',
'        else',
'          pes_len(to_char(l_pi)) := 0;',
'          dm(l_pi) := '''';',
'          da(l_pi) := '''';',
'        end if;',
'        /* o link da 203, com o checksum (a 203 exige) */',
'        l_url := apex_page.get_url(p_page => 203, p_clear_cache => ''RP,203'', p_items => ''P203_EMP,P203_MAT'',',
'                                   p_values => r.emp || '','' || r.mat);',
'        if l_u0 is null and instr(l_url, ''P203_EMP,P203_MAT:'') > 0 then',
'          l_u0 := substr(l_url, 1, instr(l_url, ''P203_EMP,P203_MAT:'') + length(''P203_EMP,P203_MAT:'') - 1);',
'        end if;',
'        if l_u0 is not null and substr(l_url, 1, length(l_u0)) = l_u0 then l_url := substr(l_url, length(l_u0) + 1);',
'        else l_url := ''!'' || l_url; end if;',
'        lin(l_pi) := ''['' || ix(''emp'', r.emp, r.emp) || '','' || ix(''fil'', r.emp, r.a1) || '','' || ix(''cc'', r.emp, r.a2) || '','' ||',
'                     ix(''un'', r.emp, r.a3) || '','' || ix(''at'', r.emp, r.a4) || '','' || ix(''car'', r.emp, r.a5) || '','' ||',
'                     ix(''sind'', r.emp, r.a6) || '','' || ix(''gest'', r.a9, r.a9, r.a10) || '','' || ix(''vin'', r.emp, r.a7) || '','' ||',
'                     case when r.a11 <> ''|'' then to_char(pers(r.a11)) else ''-1'' end || '','' ||',
'                     case when r.a8 = ''01'' then ''1'' else ''0'' end || '','' || js(l_url) || '']'';',
'        begin',
'          nom(l_pi) := r.mat || '' - '' || initcap(fnct_nome_func(r.emp, r.mat));',
'        exception when others then nom(l_pi) := r.mat;',
'        end;',
'      end if;',
'    elsif pes.exists(r.emp || ''|'' || r.mat) then',
'      l_pi := pes(r.emp || ''|'' || r.mat);',
'      if r.k = ''M'' then',
'        if pes_ini.exists(l_pi) then',
'          l_off := to_date(r.a1, ''yyyymmdd'') - to_date(pes_ini(l_pi), ''yyyymmdd'') + 1;',
'          if l_off between 1 and pes_len(to_char(l_pi)) then',
'            dm(l_pi) := poe(dm(l_pi), l_off, to_char(least(9, nvl(r.n1, 0))));',
'            da(l_pi) := poe(da(l_pi), l_off, to_char(least(9, nvl(r.n2, 0))));',
'          end if;',
'        end if;',
'      elsif r.k = ''E'' then',
'        if nvl(r.n1, 0) <> 0 then',
'          if not evn.exists(r.a2) then',
'            evn(r.a2) := l_nev;',
'            evs_t(l_nev) := substr(r.a3, 1, 300);',
'            evs_k(l_nev) := nvl(r.a1, ''H'');',
'            l_nev := l_nev + 1;',
'          end if;',
'          cru(case when l_ne > 0 then '','' end || ''['' || l_pi || '','' || evn(r.a2) || '','' || n(r.n1) || '']'');',
'          l_ne := l_ne + 1;',
'        end if;',
'      elsif r.k = ''R'' then',
'        rq(l_pi) := case when rq.exists(l_pi) then rq(l_pi) || '','' end ||',
'                    ''['' || l_pi || '','' || r.a1 || '','' || n(r.n1) || '','' || n(r.n2) || '']'';',
'      end if;',
'    end if;',
'  end loop;',
'  l_t2 := dbms_utility.get_time;',
'',
unistr('  /* "ev" foi aberto antes do la\00E7o; fecha. Depois: pes, dm, da, req, per, evs */'),
'  l_passo := ''montar'';',
'  cru(''],"pes":['');',
'  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then '','' end || lin(i)); end loop;',
'  cru(''],"dm":['');',
'  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then '','' end || ''"'' || dm(i) || ''"''); end loop;',
'  cru(''],"da":['');',
'  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then '','' end || ''"'' || da(i) || ''"''); end loop;',
'  cru(''],"req":['');',
'  l_n := 0;',
'  for i in 0 .. l_npes - 1 loop',
'    if rq.exists(i) then cru(case when l_n > 0 then '','' end || rq(i)); l_n := l_n + 1; end if;',
'  end loop;',
'  cru(''],"per":['');',
'  for i in 0 .. l_nper - 1 loop cru(case when i > 0 then '','' end || pers_t(i)); end loop;',
'  cru(''],"evs":['');',
'  for i in 0 .. l_nev - 1 loop cru(case when i > 0 then '','' end || ''['' || js(evs_t(i)) || '',"'' || evs_k(i) || ''"]''); end loop;',
'  cru('']'');',
'  descarrega;',
'',
'  apex_json.write(''total'', l_total);',
'  apex_json.write(''cortou'', l_cortou);',
'  apex_json.write(''u0'', l_u0);',
'  apex_json.open_object(''dims'');',
'  for j in 1 .. l_dims.count loop',
'    apex_json.open_array(l_dims(j));',
'    if qtd.exists(l_dims(j)) then',
'      for k in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || ''#'' || k)); end loop;',
'    end if;',
'    apex_json.close_array;',
'  end loop;',
'  apex_json.close_object;',
'  apex_json.open_array(''nomes'');',
'  for i in 0 .. l_npes - 1 loop apex_json.write(nom(i)); end loop;',
'  apex_json.close_array;',
'  apex_json.open_object(''tempos'');',
'  apex_json.write(''consulta'', l_t2 - l_t1);',
'  apex_json.write(''total'', dbms_utility.get_time - l_t0);',
'  apex_json.close_object;',
'  apex_json.close_object;',
'  l_saida := apex_json.get_clob_output;',
'  apex_json.free_output;',
'',
'  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + ev/pes/dm/da/req/per/evs + "}" */',
'  l_corte := dbms_lob.getlength(l_saida);',
'  while l_corte > 0 and dbms_lob.substr(l_saida, 1, l_corte) <> ''}'' loop l_corte := l_corte - 1; end loop;',
'  manda(l_saida, l_corte - 1);',
'  htp.prn('','');',
'  manda(l_cru, dbms_lob.getlength(l_cru));',
'  htp.prn(''}'');',
'  dbms_lob.freetemporary(l_cru);',
'exception',
'  when others then',
'    apex_json.free_output;',
'    if l_cru is not null and dbms_lob.istemporary(l_cru) = 1 then dbms_lob.freetemporary(l_cru); end if;',
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
