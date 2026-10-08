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
,p_default_application_id=>2937
,p_default_id_offset=>795299883281732340
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   03:01 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 6
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00006
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>6);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Cadastro de Dados de Funcion\00E1rios')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Cadastro de Dados de Funcion\00E1rios')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_chained=>'N'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260901151413'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166660200841960394534)
,p_plug_name=>unistr('Dados de Funcion\00E1rio')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166662430945560082926)
,p_plug_name=>'Tabs Container Region'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(177921844724398886873)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(9874441889896977460)
,p_name=>'Acidentes/Incidentes'
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_template=>wwv_flow_api.id(177816125415896099441)
,p_display_sequence=>100
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  aa.cod_empresa||''-''||fnct_nome_empresa(aa.cod_empresa)nm_empresa,',
'        aa.matricula||''-''||fnct_nome_func(aa.cod_empresa,aa.matricula) nm_colab, ',
'        aa.cod_analise_acidente,',
'        aa.dt_acidente,',
'        aa.hor_acidente,',
'        aa.dt_ult_dia_trab,',
unistr('        decode(aa.cod_acidente_tipo, ''1'', ''T\00EDpico'',''2'',''Doen\00E7a Ocupacional'',''3'',''Trajeto'',''4'',''Incidente'')tipo ,'),
unistr('        decode(aa.class_acidente,''1'',''F\00EDsico'',''2'',''Qu\00EDmico'',3,''Biol\00F3gico'',''4'',''Ergon\00F4mico'',''5'',''Acidente/Mec\00E2nico'')classifica\00E7\00E3o, '),
unistr('        decode(aa.ind_trajeto,''S'',''Sim'',''N\00E3o'') ind_trajeto,'),
unistr('        decode(af.ind_acidente_anterior,''S'',''Sim'',''N\00E3o'') ind_acidente_anterior,'),
'        aa.cod_med_emit_cat||''-''||fnct_nome_medico(null,aa.cod_med_emit_cat,aa.origem_med_cat)nm_medico,',
unistr('        decode(aa.afastamento_imediato, ''S'',''Sim'',''N\00E3o'') afastamento_imediato,'),
unistr('        decode(af.ind_afastamento,''S'',''Sim'',''N\00E3o'') ind_afastamento,'),
'        af.quantidade_dias_afastamento,',
'        af.cid,',
'        aa.espec_local_acidente, ',
'        aa.observacao, ',
'        af.observacao_cat, ',
'        af.diagno_provavel,',
'        ''<a href="'' || ',
'            regexp_substr(',
'                apex_page.get_url(',
'                    p_application => ''SEG_CTRL_'' || :P_BASE, ',
'                    p_page        => 31,',
'                    p_items       => ''P31_ROWID'',',
'                    p_values      => ROWIDTOCHAR(aa.rowid)',
'                ), ',
'                ''f\?p=[^'''']+''',
'            ) || ',
'        ''" target="_blank" class="t-Button t-Button--noLabel t-Button--icon">'' ||',
'        '' <span class="fa fa-search"></span>'' ||',
'        ''</a>'' AS visualizar',
'  from analise_acidente aa ,analise_func af',
' where aa.cod_empresa = af.cod_empresa',
'   and aa.matricula = af.matricula',
'   and aa.cod_analise_acidente = af.cod_analise_acidente',
'   and aa.cod_empresa = :P6_COD_EMPRESA',
'   and aa.matricula = :P6_MATRICULA',
''))
,p_read_only_when_type=>'ALWAYS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
,p_query_row_template=>wwv_flow_api.id(177921851386904886888)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('N\00E3o existe nenhuma consulta.')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874442984855977471)
,p_query_column_id=>1
,p_column_alias=>'NM_EMPRESA'
,p_column_display_sequence=>2
,p_column_heading=>'Empresa'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443048683977472)
,p_query_column_id=>2
,p_column_alias=>'NM_COLAB'
,p_column_display_sequence=>3
,p_column_heading=>'Colaborador'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443165481977473)
,p_query_column_id=>3
,p_column_alias=>'COD_ANALISE_ACIDENTE'
,p_column_display_sequence=>4
,p_column_heading=>unistr('C\00F3d. Analise Acidente')
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443245717977474)
,p_query_column_id=>4
,p_column_alias=>'DT_ACIDENTE'
,p_column_display_sequence=>5
,p_column_heading=>'Data Acidente'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443365396977475)
,p_query_column_id=>5
,p_column_alias=>'HOR_ACIDENTE'
,p_column_display_sequence=>6
,p_column_heading=>'Hora Acidente'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443467523977476)
,p_query_column_id=>6
,p_column_alias=>'DT_ULT_DIA_TRAB'
,p_column_display_sequence=>7
,p_column_heading=>unistr('Data \00DAltimo Dia Trab.')
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443565661977477)
,p_query_column_id=>7
,p_column_alias=>'TIPO'
,p_column_display_sequence=>8
,p_column_heading=>'Tipo'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443669362977478)
,p_query_column_id=>8
,p_column_alias=>unistr('CLASSIFICA\00C7\00C3O')
,p_column_display_sequence=>9
,p_column_heading=>unistr('Classifica\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443742137977479)
,p_query_column_id=>9
,p_column_alias=>'IND_TRAJETO'
,p_column_display_sequence=>10
,p_column_heading=>'Trajeto'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874443898488977480)
,p_query_column_id=>10
,p_column_alias=>'IND_ACIDENTE_ANTERIOR'
,p_column_display_sequence=>11
,p_column_heading=>'Acidente Anterior'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444096878977482)
,p_query_column_id=>11
,p_column_alias=>'NM_MEDICO'
,p_column_display_sequence=>12
,p_column_heading=>unistr('M\00E9dico')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444185686977483)
,p_query_column_id=>12
,p_column_alias=>'AFASTAMENTO_IMEDIATO'
,p_column_display_sequence=>13
,p_column_heading=>'Afastamento Imediato'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444319646977484)
,p_query_column_id=>13
,p_column_alias=>'IND_AFASTAMENTO'
,p_column_display_sequence=>14
,p_column_heading=>'Afastamento'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444364829977485)
,p_query_column_id=>14
,p_column_alias=>'QUANTIDADE_DIAS_AFASTAMENTO'
,p_column_display_sequence=>15
,p_column_heading=>'Qtd Dias Afastamento'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444437092977486)
,p_query_column_id=>15
,p_column_alias=>'CID'
,p_column_display_sequence=>16
,p_column_heading=>'CID'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444524427977487)
,p_query_column_id=>16
,p_column_alias=>'ESPEC_LOCAL_ACIDENTE'
,p_column_display_sequence=>17
,p_column_heading=>'Local Acidente'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9874444687507977488)
,p_query_column_id=>17
,p_column_alias=>'OBSERVACAO'
,p_column_display_sequence=>18
,p_column_heading=>unistr('Observa\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9896412587051597739)
,p_query_column_id=>18
,p_column_alias=>'OBSERVACAO_CAT'
,p_column_display_sequence=>19
,p_column_heading=>unistr('Observa\00E7\00E3o CAT')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9896412722086597740)
,p_query_column_id=>19
,p_column_alias=>'DIAGNO_PROVAVEL'
,p_column_display_sequence=>20
,p_column_heading=>unistr('Diagno Prov\00E1vel')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(9896413510850597748)
,p_query_column_id=>20
,p_column_alias=>'VISUALIZAR'
,p_column_display_sequence=>1
,p_column_heading=>'Visualizar'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125892277494880201718)
,p_plug_name=>unistr('Consulta M\00E9dica Ocupacional')
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cmo.cod_empresa',
'       , cmo.matricula',
'       , cmo.cod_tipo_consulta||'' - ''||(select initcap(descricao) ',
'                 from tipo_consulta tc ',
'                 where tc.cod_tipo_consulta = cmo.cod_tipo_consulta ) tipo_consulta',
'       , cmo.data_agd_consulta',
'       , cmo.cod_cargo_prop||'' - ''||(select initcap(nome) from cargos c where c.cod = cmo.cod_cargo_prop) cod_cargo_prop',
'       , cmo.cod_local_pret||'' - ''||(select initcap(descricao) ',
'                                            from local_trab l',
'                                            where l.COD_LOCAL_TRAB = cmo.cod_local_pret)  cod_local_pret',
unistr('       , decode(cmo.ind_outras_doencas, ''S'', ''Sim'', ''N'', ''N\00E3o'') outras_doencas'),
'       , cmo.desc_outras_doencas',
unistr('       , decode(cmo.ind_uso_medicamento_od, ''S'', ''Sim'', ''N'', ''N\00E3o'') uso_medicamento_od'),
unistr('       , decode(cmo.ind_gestante, ''S'', ''Sim'', ''N'', ''N\00E3o'') gestante'),
'       , cmo.num_semana_gestacao',
unistr('       , decode(cmo.ind_pre_natal, ''S'', ''Sim'', ''N'', ''N\00E3o'') pre_natal'),
unistr('       , cmo.ind_local_pre_natal --decode(cmo.ind_local_pre_natal, ''S'', ''Sim'', ''N'', ''N\00E3o'') local_pre_natal '),
unistr('       , decode(cmo.ind_amamentando, ''S'', ''Sim'', ''N'', ''N\00E3o'') amamentando'),
'       , replace(replace(cmo.anamnese_desc , chr(13), ''''), chr(10), '''') anamnese_desc',
'       , replace(replace(cmo.antecedente_pess_desc , chr(13), ''''), chr(10), '''') antecedente_pess_desc',
'       , replace(replace(cmo.antecedente_fam_dec , chr(13), ''''), chr(10), '''') antecedente_fam_dec',
'       , replace(replace(cmo.antecedente_ocup_desc , chr(13), ''''), chr(10), '''') antecedente_ocup_desc',
'       , replace(replace(cmo.uso_medicamento_desc , chr(13), ''''), chr(10), '''') uso_medicamento_desc',
'       , cmo.pressao_arterial',
'       , cmo.temperatura',
'       , cmo.pulsacao',
'       , replace(replace(cmo.exame_fisico_desc , chr(13), ''''), chr(10), '''') exame_fisico_desc',
unistr('       , decode(cmo.ind_trab_compativel_obsaso, ''S'', ''Sim'', ''N'', ''N\00E3o'') trab_compativel_obsaso'),
unistr('       , decode(cmo.ind_trab_comp_gestlac_obsaso, ''S'', ''Sim'', ''N'', ''N\00E3o'') trab_comp_gestlac_obsaso'),
'       , cmo.obsaso_desc',
'       , cmo.cod_resultado_aso||'' - ''||(select initcap(descricao) ',
'                                               from resultado r ',
'                                               where r.cod_resultado = cmo.cod_resultado_aso',
'                                               and tipo_resultado = ''A'' ) cod_resultado_aso',
'       --, cmo.validade_result_aso',
'       , (select max(dt_prox_exame_period)',
'            from exame_func ef',
'            where cod_empresa = cmo.cod_empresa',
'            and matricula = cmo.matricula',
'            and cod_exame = ''ASO'' ) validade_result_aso',
'       , cmo.cod_prest_serv||'' - ''||(select initcap(nome) ',
'                                            from prestador_servico ps ',
'                                            where ps.cod_prest_serv = cmo.cod_prest_serv',
'                                            and tipo_prest_serv = 1) cod_prest_serv',
'       , cmo.usuario',
'       , cmo.dt_atualizacao',
'from consulta_med_ocupacional cmo',
'where 1=1',
'and cmo.cod_empresa = :P6_COD_EMPRESA',
'and cmo.matricula = :P6_MATRICULA',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
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
 p_id=>wwv_flow_api.id(125892277562096201719)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'ANDRE.BONI'
,p_internal_uid=>588049102580892406
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892277734817201720)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892277779242201721)
,p_db_column_name=>'MATRICULA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892277933763201722)
,p_db_column_name=>'TIPO_CONSULTA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Tipo Consulta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278043553201723)
,p_db_column_name=>'DATA_AGD_CONSULTA'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Data Agd Consulta'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278149380201724)
,p_db_column_name=>'COD_CARGO_PROP'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Cod Cargo Prop'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278200187201725)
,p_db_column_name=>'COD_LOCAL_PRET'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Cod Local Pret'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278287962201726)
,p_db_column_name=>'OUTRAS_DOENCAS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Outras Doencas'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278447773201727)
,p_db_column_name=>'DESC_OUTRAS_DOENCAS'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Desc Outras Doencas'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278527663201728)
,p_db_column_name=>'USO_MEDICAMENTO_OD'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Uso Medicamento Od'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278599549201729)
,p_db_column_name=>'GESTANTE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Gestante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278668517201730)
,p_db_column_name=>'NUM_SEMANA_GESTACAO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Num Semana Gestacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278843058201731)
,p_db_column_name=>'PRE_NATAL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Pre Natal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892278946195201732)
,p_db_column_name=>'IND_LOCAL_PRE_NATAL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Ind Local Pre Natal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279018857201733)
,p_db_column_name=>'AMAMENTANDO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Amamentando'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279065969201734)
,p_db_column_name=>'ANAMNESE_DESC'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Anamnese Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279220462201735)
,p_db_column_name=>'ANTECEDENTE_PESS_DESC'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Antecedente Pess Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279322740201736)
,p_db_column_name=>'ANTECEDENTE_FAM_DEC'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Antecedente Fam Dec'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279387846201737)
,p_db_column_name=>'ANTECEDENTE_OCUP_DESC'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Antecedente Ocup Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279556426201738)
,p_db_column_name=>'USO_MEDICAMENTO_DESC'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Uso Medicamento Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279580478201739)
,p_db_column_name=>'PRESSAO_ARTERIAL'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Pressao Arterial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279679510201740)
,p_db_column_name=>'TEMPERATURA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Temperatura'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279817894201741)
,p_db_column_name=>'PULSACAO'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Pulsacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279924086201742)
,p_db_column_name=>'EXAME_FISICO_DESC'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Exame Fisico Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892279986356201743)
,p_db_column_name=>'TRAB_COMPATIVEL_OBSASO'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Trab Compativel Obsaso'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280123567201744)
,p_db_column_name=>'TRAB_COMP_GESTLAC_OBSASO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Trab Comp Gestlac Obsaso'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280224084201745)
,p_db_column_name=>'OBSASO_DESC'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>'Obsaso Desc'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280301753201746)
,p_db_column_name=>'COD_RESULTADO_ASO'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Cod Resultado Aso'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280380199201747)
,p_db_column_name=>'VALIDADE_RESULT_ASO'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Validade Result Aso'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280518783201748)
,p_db_column_name=>'COD_PREST_SERV'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>'Cod Prest Serv'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280574606201749)
,p_db_column_name=>'USUARIO'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125892280715221201750)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>'Dt Atualizacao'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(125893379353340632219)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'5891509'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:MATRICULA:TIPO_CONSULTA:DATA_AGD_CONSULTA:COD_CARGO_PROP:COD_LOCAL_PRET:OUTRAS_DOENCAS:DESC_OUTRAS_DOENCAS:USO_MEDICAMENTO_OD:GESTANTE:NUM_SEMANA_GESTACAO:PRE_NATAL:IND_LOCAL_PRE_NATAL:AMAMENTANDO:ANAMNESE_DESC:ANTECEDENTE_PESS_DESC:ANTEC'
||'EDENTE_FAM_DEC:ANTECEDENTE_OCUP_DESC:USO_MEDICAMENTO_DESC:PRESSAO_ARTERIAL:TEMPERATURA:PULSACAO:EXAME_FISICO_DESC:TRAB_COMPATIVEL_OBSASO:TRAB_COMP_GESTLAC_OBSASO:OBSASO_DESC:COD_RESULTADO_ASO:VALIDADE_RESULT_ASO:COD_PREST_SERV:USUARIO:DT_ATUALIZACAO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(131501806948525427114)
,p_plug_name=>unistr('Descri\00E7\00E3o de Atividades')
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(131501805913006427104)
,p_plug_name=>unistr('Descri\00E7\00E3o de Atividades')
,p_parent_plug_id=>wwv_flow_api.id(131501806948525427114)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.descr_func ',
'  from PERFIL_PROFISIOGRAFICO a,',
'       informacoes_funcionais b',
' where b.cod_empresa = a.cod_empresa',
'   and b.filial = a.cod_filial',
'   and b.cargo = a.cod_cargo',
'   and b.cod_localizacao = a.cod_local_trab',
'   and b.funcao = a.cod_funcao',
'   and b.cod_empresa = :P6_COD_EMPRESA',
'   and b.matricula = :P6_MATRICULA;',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
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
 p_id=>wwv_flow_api.id(131501805774813427103)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>63902469671877335526
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(68966103402526595219)
,p_db_column_name=>'DESCR_FUNC'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('Descri\00E7\00E3o de Atividades')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(131479834482159333618)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'13667676'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCR_FUNC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166662430568110082923)
,p_plug_name=>unistr('Doen\00E7as')
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_func_doenca',
'      ,cod_empresa',
'      ,matricula',
'      ,dc_matricula',
'      ,cod_doenca',
'      ,dt_inicio',
'      ,dt_termino',
'      ,dt_termino - dt_inicio',
'      ,usuario',
'      ,dt_atualizacao',
'  from func_doenca',
' where cod_empresa = :P6_COD_EMPRESA',
'   and matricula = :P6_MATRICULA;'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ALWAYS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431437461082931)
,p_name=>'COD_FUNC_DOENCA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_FUNC_DOENCA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_default_type=>'SEQUENCE'
,p_default_expression=>'SEQ_FUNC_DOENCA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431520631082932)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P6_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431572678082933)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P6_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431746289082934)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P6_COD_EMPRESA',
'   and matricula = :P6_MATRICULA'))
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431795697082935)
,p_name=>'COD_DOENCA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_DOENCA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('Doen\00E7a')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166662468646390256708)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
end;
/
begin
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431900154082936)
,p_name=>'DT_INICIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_INICIO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data In\00EDcio')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662431996343082937)
,p_name=>'DT_TERMINO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_TERMINO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data T\00E9rmino')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662432087624082938)
,p_name=>'DT_TERMINO-DT_INICIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_TERMINO-DT_INICIO'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Qtd. Dias'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662432215698082939)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Usu\00E1rio')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':APP_USER'
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662432329206082940)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Data Atualiza\00E7\00E3o')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'to_char(sysdate,''dd/mm/rrrr'')'
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662432469533082942)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166662432645249082943)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(166662431301566082930)
,p_internal_uid=>641580141937828111
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_max_row_count=>100000
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(166662457155852225770)
,p_interactive_grid_id=>wwv_flow_api.id(166662431301566082930)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(166662457219994225770)
,p_report_id=>wwv_flow_api.id(166662457155852225770)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662457676580225772)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(166662431437461082931)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662458175678225775)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(166662431520631082932)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662458667966225777)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166662431572678082933)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662459258096225778)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(166662431746289082934)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662459663616225780)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(166662431795697082935)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662460209445225782)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(166662431900154082936)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662460741173225784)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(166662431996343082937)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662461216042225786)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(166662432087624082938)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662461684561225788)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(166662432215698082939)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662462211807225790)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(166662432329206082940)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166662471292882276030)
,p_view_id=>wwv_flow_api.id(166662457219994225770)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(166662432469533082942)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(166662430814187082925)
,p_name=>'Consultas'
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_template=>wwv_flow_api.id(177816125415896099441)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cm.cod_empresa',
'      ,cm.matricula matricula',
'      ,cm.dc_matricula dc_matricula',
'      ,to_char(cm.dt_consulta,''dd/mm/yyyy'') dt_consulta',
'      ,to_char(cm.dt_consulta_hh,''00'') ||'':''|| to_char(cm.dt_consulta_mm,''00'') hora',
'      ,(select cod_tipo_consulta||'' - ''||descricao',
'          from tipo_consulta tc',
'         where tc.cod_tipo_consulta = cm.cod_tipo_consulta) tipo_consulta',
'      ,(select cod_prest_serv||'' - ''||ps.nome ',
'          from prestador_servico ps ',
'         where ps.cod_prest_serv = cm.cod_prest_serv',
'           and ps.tipo_prest_serv = cm.tipo_prest_serv)  medico',
'      ,(select en.cod_entidade||'' - ''||en.nome_entidade',
'          from entidade en',
'         where en.cod_entidade  = cm.cod_entidade',
'           and en.tipo_entidade = cm.tipo_entidade) entidade     ',
'       ,(select es.cod_especialidade||'' - ''||es.descricao',
'          from especialidade es',
'         where es.cod_especialidade = cm.cod_especialidade) especialidade,',
'      ''<a href="'' ||',
'    apex_page.get_url(',
'        p_page   => 40,',
'        p_items  => ''P40_ROWID'',',
'        p_values => cm.rowid',
'    ) ||''" class="t-Button t-Button--noLabel t-Button--icon">',
'            <span class="fa fa-search"></span>',
'        </a>'' as visualizar',
'',
' from consulta_medica cm',
'where cm.cod_empresa = :P6_COD_EMPRESA',
'  and cm.matricula = :P6_MATRICULA',
'order by cm.dt_consulta'))
,p_read_only_when_type=>'ALWAYS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
,p_query_row_template=>wwv_flow_api.id(177921851386904886888)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('N\00E3o existe nenhuma consulta.')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662432851702082945)
,p_query_column_id=>1
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662432909992082946)
,p_query_column_id=>2
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433058559082947)
,p_query_column_id=>3
,p_column_alias=>'DC_MATRICULA'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433091651082948)
,p_query_column_id=>4
,p_column_alias=>'DT_CONSULTA'
,p_column_display_sequence=>5
,p_column_heading=>'Data Consulta'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433258694082949)
,p_query_column_id=>5
,p_column_alias=>'HORA'
,p_column_display_sequence=>6
,p_column_heading=>'Hora'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433298691082950)
,p_query_column_id=>6
,p_column_alias=>'TIPO_CONSULTA'
,p_column_display_sequence=>7
,p_column_heading=>'Tipo da Consulta'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433370042082951)
,p_query_column_id=>7
,p_column_alias=>'MEDICO'
,p_column_display_sequence=>8
,p_column_heading=>unistr('M\00E9dico')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433525314082952)
,p_query_column_id=>8
,p_column_alias=>'ENTIDADE'
,p_column_display_sequence=>9
,p_column_heading=>'Entidade'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(166662433605226082953)
,p_query_column_id=>9
,p_column_alias=>'ESPECIALIDADE'
,p_column_display_sequence=>10
,p_column_heading=>'Especialidade'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(14344472660000698163)
,p_query_column_id=>10
,p_column_alias=>'VISUALIZAR'
,p_column_display_sequence=>1
,p_column_heading=>'Visualizar'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166662431124357082928)
,p_plug_name=>'Atestados'
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa',
'      ,matricula	 ',
'      ,dc_matricula',
'      ,cod_atestado_medico',
'      ,ocupacional',
'      ,cod_motivo',
'      ,desc_motivo',
'      ,dt_atestado_medico',
'      ,cod_entidade',
'      ,tipo_entidade',
'      ,cod_prest_serv',
'      ,tipo_prest_serv',
'      ,cod_doenca',
'      ,dt_inicio_afastamento',
'      ,hora_inicio_afastamento',
'      ,qtde_dias_afastamento',
'      ,dt_termino_afastamento',
'      ,hora_termino_afastamento',
'      ,qtde_horas_abonadas',
'      ,usuario',
'      ,dt_atualizacao',
' from atestado_funcionario ',
'where cod_empresa = :P6_COD_EMPRESA',
'  and matricula = :P6_MATRICULA'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ALWAYS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102862853768649)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P6_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102998060768650)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P6_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103127132768651)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P6_COD_EMPRESA',
'   and matricula = :P6_MATRICULA'))
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103221144768652)
,p_name=>'COD_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ATESTADO_MEDICO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('C\00F3digo')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663286908056623451)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103291223768653)
,p_name=>'OCUPACIONAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OCUPACIONAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Ocupacional?'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663252488110389885)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103366055768654)
,p_name=>'COD_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_MOTIVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('C\00F3digo Motivo')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_max_length=>3
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663294037110644480)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103505786768655)
,p_name=>'DESC_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESC_MOTIVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Motivo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>30
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103650968768656)
,p_name=>'DT_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATESTADO_MEDICO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Data'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103700983768657)
,p_name=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Entidade'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod_entidade||'' - ''||e.nome_entidade d',
'      ,e.cod_entidade r',
'  from entidade e',
' where e.tipo_entidade = nvl(:TIPO_ENTIDADE, e.tipo_entidade) -- :TIPO_ENTIDADE'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_cascade_parent_items=>'TIPO_ENTIDADE'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103802002768658)
,p_name=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>130
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'1'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663103953469768659)
,p_name=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('M\00E9dico')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome d',
'      ,cod r',
'  from vw_medicos',
' where origem = ''MI''',
'union all',
'select cod||'' - ''||nome d',
'      ,cod r',
'  from vw_medicos',
' where origem = ''ME''	 ',
' order by 1'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104035044768660)
,p_name=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'1'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104109225768661)
,p_name=>'COD_DOENCA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_DOENCA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'C.I.D.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166662468646390256708)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104228502768662)
,p_name=>'DT_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_INICIO_AFASTAMENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data In\00EDcio')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104286082768663)
,p_name=>'HORA_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_INICIO_AFASTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Hora In\00EDcio')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_format_mask=>'00:00'
,p_is_required=>false
,p_max_length=>5
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104458795768664)
,p_name=>'QTDE_DIAS_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QTDE_DIAS_AFASTAMENTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Qtd. Dias'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'RIGHT'
,p_attribute_05=>'BOTH'
,p_item_attributes=>'readonly="readonly"'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104540077768665)
,p_name=>'DT_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_TERMINO_AFASTAMENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data T\00E9rmino')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104590411768666)
,p_name=>'HORA_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_TERMINO_AFASTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Hora T\00E9rmino')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_format_mask=>'00:00'
,p_is_required=>false
,p_max_length=>5
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104723337768667)
,p_name=>'QTDE_HORAS_ABONADAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QTDE_HORAS_ABONADAS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Qtd. Horas Abonadas'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_format_mask=>'00:00'
,p_is_required=>false
,p_max_length=>5
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104835150768668)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>230
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':APP_USER'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663104926997768669)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>240
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'to_char(sysdate,''dd/mm/rrrr'')'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663259614604578920)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663259684327578921)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
end;
/
begin
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663259815198578922)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(166663102838847768648)
,p_internal_uid=>642251679219513829
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(161347559215439747726)
,p_update_authorization_scheme=>wwv_flow_api.id(161347559704688747727)
,p_delete_authorization_scheme=>wwv_flow_api.id(161347559474643747726)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(166663265727545579853)
,p_interactive_grid_id=>wwv_flow_api.id(166663102838847768648)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(166663265850155579853)
,p_report_id=>wwv_flow_api.id(166663265727545579853)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663266263468579855)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(166663102862853768649)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663266776543579858)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(166663102998060768650)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663267306773579862)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166663103127132768651)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663267761398579865)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(166663103221144768652)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>192
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663268359487579868)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(166663103291223768653)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>106
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663268795763579871)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(166663103366055768654)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>199
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663269312144579874)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(166663103505786768655)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>178
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663269842260579877)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(166663103650968768656)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>108
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663270347603579880)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(166663103700983768657)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>211
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663270826252579883)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(166663103802002768658)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663271276155579885)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(166663103953469768659)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>201
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663271769541579887)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(166663104035044768660)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663272283406579889)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(166663104109225768661)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>207
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663272839753579891)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(166663104228502768662)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>97
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663273311023579893)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(166663104286082768663)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>102
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663273801454579896)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(166663104458795768664)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>102
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663274271852579898)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(166663104540077768665)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>109
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663274766572579901)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(166663104590411768666)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>117
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663275335793579904)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(166663104723337768667)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663275813527579906)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(166663104835150768668)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663276293468579908)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(166663104926997768669)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663276791608579910)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(166663259614604578920)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663277305059579912)
,p_view_id=>wwv_flow_api.id(166663265850155579853)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(166663259684327578921)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166662431225939082929)
,p_plug_name=>unistr('Restri\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(177816125415896099441)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166663100488070768625)
,p_plug_name=>'Exames'
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  E.cod_empresa	   ',
'        ,E.matricula	   ',
'        ,E.dc_matricula  	',
'        ,E.cod_exame	   ',
'        ,E.dt_exame	   ',
'        ,R.COD_RESULTADO||'' - ''||INITCAP(R.DESCRICAO) RESULTADO, R.COD_RESULTADO	',
'        ,E.cod_prest_serv_origem',
'        ,E.cod_prest_serv	',
'        ,T.COD_ENTIDADE||'' - ''||INITCAP(T.NOME_ENTIDADE) ENTIDADE, T.COD_ENTIDADE	        	',
'        ,E.dt_prox_exame_period 	',
'        ,E.usuario	',
'        ,E.dt_atualizacao	',
'        ,E.tipo_prest_serv ',
'        ,E.tipo_entidade 	',
'        ,E.tipo_exame	',
'        ,E.ocupacional 	',
'        ,E.complemento_exame 	',
'',
'from exame_func E, RESULTADO R, ENTIDADE T',
'    where E.COD_RESULTADO = R.COD_RESULTADO',
'    AND   E.COD_ENTIDADE = T.COD_ENTIDADE(+)',
'    AND   E.TIPO_ENTIDADE = T.TIPO_ENTIDADE(+)',
'    AND   E.TIPO_ENTIDADE IN(1,7)',
'    AND cod_empresa = :P6_COD_EMPRESA',
'    and matricula = :P6_MATRICULA;'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ALWAYS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(142292739470170101581)
,p_name=>'RESULTADO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RESULTADO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Resultado'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>38
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(142292739688822101583)
,p_name=>'ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Entidade'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>78
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663100672058768627)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P6_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663100826495768628)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P6_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663100922806768629)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P6_COD_EMPRESA',
'   and matricula = :P6_MATRICULA'))
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663100969714768630)
,p_name=>'COD_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EXAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Exame'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663137504590817270)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101084038768631)
,p_name=>'DT_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_EXAME'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Data Exame'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101172965768632)
,p_name=>'COD_RESULTADO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_RESULTADO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101285109768633)
,p_name=>'COD_PREST_SERV_ORIGEM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV_ORIGEM'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Origem'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select e.cod_entidade||'' - ''||e.nome_entidade d',
'      ,e.cod_entidade r',
'  from entidade e',
' where e.tipo_entidade = ''1'' --nvl(:TIPO_PREST_SERV, e.tipo_entidade) '))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101442441768634)
,p_name=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('M\00E9dico')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome d',
'      ,cod r',
'  from vw_medicos',
' where nvl(cod_empresa, :COD_EMPRESA) = :COD_EMPRESA ',
' order by 1 '))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_cascade_parent_items=>'COD_EMPRESA'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101550182768635)
,p_name=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101618265768636)
,p_name=>'DT_PROX_EXAME_PERIOD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_PROX_EXAME_PERIOD'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data Pr\00F3ximo Exame')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101714602768637)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>170
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':APP_USER'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101791105768638)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>180
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'to_char(sysdate,''dd/mm/rrrr'')'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663101924420768639)
,p_name=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>190
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102007090768640)
,p_name=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>200
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102119877768641)
,p_name=>'TIPO_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_EXAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo Exame'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663244795284334940)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102191319768642)
,p_name=>'OCUPACIONAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OCUPACIONAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Ocupacional?'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663252488110389885)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102301141768643)
,p_name=>'COMPLEMENTO_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPLEMENTO_EXAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Complemento Exame'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>230
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102551554768645)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663102610485768646)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(166663100606262768626)
,p_internal_uid=>642249446634513807
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(161347559215439747726)
,p_update_authorization_scheme=>wwv_flow_api.id(161347559704688747727)
,p_delete_authorization_scheme=>wwv_flow_api.id(161347559474643747726)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(166663190274716081543)
,p_interactive_grid_id=>wwv_flow_api.id(166663100606262768626)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(166663190412032081543)
,p_report_id=>wwv_flow_api.id(166663190274716081543)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(142295203782103250729)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(142292739470170101581)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(142295204787898250737)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(142292739688822101583)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>130
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166020867128360391418)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(166663102551554768645)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663190891444081545)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(166663100672058768627)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663191366948081547)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(166663100826495768628)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663191859652081549)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166663100922806768629)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663192416321081551)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(166663100969714768630)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>215
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663192761969081553)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(166663101084038768631)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>138
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663193273161081555)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(166663101172965768632)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>118
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663193804611081557)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(166663101285109768633)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>253
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663194325922081560)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(166663101442441768634)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>243
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663194772663081562)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(166663101550182768635)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>261
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663195331280081564)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(166663101618265768636)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>153
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663195849971081566)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(166663101714602768637)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663196345833081568)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(166663101791105768638)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663196817773081570)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(166663101924420768639)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663197321802081572)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(166663102007090768640)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663197844230081574)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(166663102119877768641)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>99
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663198354591081576)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(166663102191319768642)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>122
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663198854969081578)
,p_view_id=>wwv_flow_api.id(166663190412032081543)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(166663102301141768643)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>161
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166664191171494027837)
,p_plug_name=>'Vacinas'
,p_parent_plug_id=>wwv_flow_api.id(166662430945560082926)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.rowid,',
'       f.cod_empresa,',
'       f.matricula,',
'       f.dc_matricula,',
'       f.cod_vacina,',
'       f.dt_vacina,',
'       f.dt_prox_dose,',
'       f.cod_dose,',
'       f.cod_entidade,',
'       f.tipo_entidade,',
'       f.complemento_vacina,',
'       f.custo_vacina,',
'       f.usuario,',
'       f.dt_atualizacao,',
'       e.cod_entidade || '' - '' || e.nome_entidade as nome_entidade',
'  from vacina_func  f',
'      ,entidade     e',
' where f.cod_entidade  = e.cod_entidade (+)',
'   and f.tipo_entidade = e.tipo_entidade (+)',
'   and f.cod_empresa   = :P6_COD_EMPRESA',
'   and f.matricula     = :P6_MATRICULA'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P6_COD_EMPRESA,P6_MATRICULA'
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
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(166664363606198913422)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>unistr('Nenhuma vacina\00E7\00E3o encontrada.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'VINICIUS_DAMARQUES'
,p_internal_uid=>643512446570658603
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664363758954913423)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664363808375913424)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664363885463913425)
,p_db_column_name=>'MATRICULA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664363964196913426)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Dc matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364149897913427)
,p_db_column_name=>'COD_VACINA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Vacina'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166664297971446604625)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364381802913430)
,p_db_column_name=>'COD_DOSE'
,p_display_order=>60
,p_column_identifier=>'H'
,p_column_label=>'Dose'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166664294315443595940)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364220636913428)
,p_db_column_name=>'DT_VACINA'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Data'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/yyyy'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364303084913429)
,p_db_column_name=>'DT_PROX_DOSE'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>unistr('Data pr\00F3x. dose')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/yyyy'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364485656913431)
,p_db_column_name=>'COD_ENTIDADE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Cod entidade'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364614169913432)
,p_db_column_name=>'TIPO_ENTIDADE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Tipo entidade'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364746455913433)
,p_db_column_name=>'COMPLEMENTO_VACINA'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364839095913434)
,p_db_column_name=>'CUSTO_VACINA'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664365239577913438)
,p_db_column_name=>'NOME_ENTIDADE'
,p_display_order=>130
,p_column_identifier=>'P'
,p_column_label=>'Entidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364897970913435)
,p_db_column_name=>'USUARIO'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166664364985587913436)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>unistr('Data Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_format_mask=>'dd/mm/yyyy hh24:mi:ss'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(166664384000881916447)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6435329'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_ENTIDADE:COD_VACINA:COD_DOSE:DT_VACINA:DT_PROX_DOSE:COMPLEMENTO_VACINA:CUSTO_VACINA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167301755751576047440)
,p_plug_name=>unistr('Dados de Funcion\00E1rio - Medicina do Trabalho')
,p_icon_css_classes=>'fa-address-book-o'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921841000262886869)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(167714865964028895971)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(177921863862945886917)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_plug_header=>unistr('<p>Dados de Funcion\00E1rios</p>')
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166660201189750394538)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166663261391703578938)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_button_name=>'SAVE_REST'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166660204244112394568)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660200997262394536)
,p_name=>'P6_MATRICULA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>unistr('Matr\00EDcula')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>1
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660201114938394537)
,p_name=>'P6_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660201355758394539)
,p_name=>'P6_FILIAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660201416421394540)
,p_name=>'P6_CARGO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_CARGOS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome',
'      ,cod',
'from cargos',
'order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660201541298394541)
,p_name=>'P6_COD_CCUSTO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Setor de Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660202824938394554)
,p_name=>'P6_COD_LOCALIZACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Local Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660202897085394555)
,p_name=>'P6_TIPO_SANGUINEO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>unistr('Tipo Sangu\00CDneo')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_SANGUINEO'
,p_lov=>'.'||wwv_flow_api.id(166662302930648483563)||'.'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660202973336394556)
,p_name=>'P6_FATOR_RH'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Fator RH'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_FATOR_RH'
,p_lov=>'.'||wwv_flow_api.id(166662305668566490472)||'.'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660203656551394562)
,p_name=>'P6_NOME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>unistr('Funcion\00E1rio')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660203675822394563)
,p_name=>'P6_PREDIO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Predio'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660203820477394564)
,p_name=>'P6_ANDAR'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Andar'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>1
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660203909610394565)
,p_name=>'P6_SALA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Sala'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>1
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166660203979015394566)
,p_name=>'P6_IDADE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_prompt=>'Idade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>1
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166663260835077578932)
,p_name=>'P6_COD_EMPRESA_REST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_item_default=>':P6_COD_EMPRESA'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166663260909846578933)
,p_name=>'P6_MATRICULA_REST'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_item_default=>':P6_MATRICULA'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166663261014778578934)
,p_name=>'P6_MATRICULA_DC_REST'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P6_COD_EMPRESA',
'   and matricula = :P6_MATRICULA'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166663261065708578935)
,p_name=>'P6_RESTRICAO_REST'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>100
,p_cMaxlength=>2000
,p_cHeight=>6
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166663261218663578936)
,p_name=>'P6_USUARIO_REST'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_item_default=>':APP_USER'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166663261341922578937)
,p_name=>'P6_DT_ATUALIZACAO_REST'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166662431225939082929)
,p_item_default=>'to_char(sysdate,''dd/mm/rrrr'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166685297867496052865)
,p_name=>'P6_PAGE_REQUEST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166660200841960394534)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166663261556603578939)
,p_validation_name=>'P6_RESTRICAO is not null'
,p_validation_sequence=>10
,p_validation=>'P6_RESTRICAO_REST'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'O campo deve ser informado.'
,p_when_button_pressed=>wwv_flow_api.id(166663261391703578938)
,p_associated_item=>wwv_flow_api.id(166663261065708578935)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166662430360438082921)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166660201189750394538)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166662430508662082922)
,p_event_id=>wwv_flow_api.id(166662430360438082921)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166663260250298578926)
,p_name=>'Motivo'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(166662431124357082928)
,p_triggering_element=>'COD_MOTIVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166663260328104578927)
,p_event_id=>wwv_flow_api.id(166663260250298578926)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' select mot.descricao',
'   into :DESC_MOTIVO',
'   from motivo_alteracoes mot ',
'  where ind_situacao = ''S''',
'    and mot.cod = :COD_MOTIVO;',
'exception',
' when no_data_found then',
'  :DESC_MOTIVO := ''-'';',
'end; '))
,p_attribute_02=>'COD_MOTIVO'
,p_attribute_03=>'DESC_MOTIVO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166663260390350578928)
,p_name=>'QTDE_DIAS_AFASTAMENTO'
,p_event_sequence=>30
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(166662431124357082928)
,p_triggering_element=>'DT_TERMINO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166663260487245578929)
,p_event_id=>wwv_flow_api.id(166663260390350578928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':QTDE_DIAS_AFASTAMENTO := to_number((to_date(:DT_TERMINO_AFASTAMENTO,''dd/mm/yyyy'') - to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'') + 1));'
,p_attribute_02=>'DT_INICIO_AFASTAMENTO,DT_TERMINO_AFASTAMENTO'
,p_attribute_03=>'QTDE_DIAS_AFASTAMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166660204132535394567)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Retorna Dados Funcion\00E1rio')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    select (select distinct fi.cod_filial||'' - ''||fi.nome_filial',
'            from filiais fi',
'            where fi.cod_empresa = infu.cod_empresa',
'              and fi.cod_filial = infu.filial) filial',
'          ,inpe.nome',
'          ,infu.cargo',
'          ,(select distinct infu.cod_ccusto||'' - ''||cc.nome ',
'              from centro_de_custo cc',
'             where infu.cod_empresa = cc.cod_empresa ',
'               and infu.cod_ccusto = cc.cod) setor',
'          ,cod_local_trab||'' - ''|| descricao local',
'          ,lotr.predio',
'          ,lotr.andar',
'          ,lotr.sala              ',
'          ,inpe.tipo_sanguineo',
'          ,inpe.fator_rh',
'          ,trunc(trunc(sysdate - inpe.dt_nasc)/360) idade',
'',
'      into :P6_FILIAL',
'          ,:P6_NOME',
'          ,:P6_CARGO',
'          ,:P6_COD_CCUSTO',
'          ,:P6_COD_LOCALIZACAO',
'          ,:P6_PREDIO',
'          ,:P6_ANDAR',
'          ,:P6_SALA',
'          ,:P6_TIPO_SANGUINEO',
'          ,:P6_FATOR_RH',
'          ,:P6_IDADE            ',
'',
'      from informacoes_funcionais infu',
'          ,inf_pessoais inpe',
'          ,local_trab lotr',
'          ',
'     where infu.cod_empresa = inpe.cod_empresa',
'       and infu.matricula = inpe.matricula',
'       and lotr.cod_local_trab = infu.cod_localizacao',
'       and infu.cod_empresa = :P6_COD_EMPRESA',
'       and infu.matricula = :P6_MATRICULA;',
'',
'exception',
'    when no_data_found then',
'        :P6_FILIAL := null;',
'        :P6_NOME := null;',
'        :P6_CARGO := null;',
'        :P6_COD_CCUSTO := null;',
'        :P6_COD_LOCALIZACAO := null;',
'        :P6_PREDIO := null;',
'        :P6_ANDAR := null;',
'        :P6_SALA := null;',
'        :P6_TIPO_SANGUINEO := null;',
'        :P6_FATOR_RH := null;',
'        :P6_IDADE := null;',
'',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':P6_COD_EMPRESA is not null and :P6_MATRICULA is not null'
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166663261900320578943)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Retorna Dados Restri\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
' select cod_empresa',
'       ,matricula',
'       ,dc_matricula',
'       ,restricao',
'       ,usuario',
'       ,dt_atualizacao',
'  into :P6_COD_EMPRESA_REST',
'      ,:P6_MATRICULA_REST',
'      ,:P6_MATRICULA_DC_REST',
'      ,:P6_RESTRICAO_REST',
'      ,:P6_USUARIO_REST',
'      ,:P6_DT_ATUALIZACAO_REST     ',
'  from  restricao_medica',
' where cod_empresa = :P6_COD_EMPRESA',
'   and matricula = :P6_MATRICULA',
'   and dc_matricula = (select dc_matricula',
'                         from informacoes_funcionais',
'                        where cod_empresa = :P6_COD_EMPRESA',
'                          and matricula = :P6_MATRICULA);',
'exception',
' when no_data_found then',
'  :P6_COD_EMPRESA_REST := null;',
'  :P6_MATRICULA_REST := null;',
'  :P6_MATRICULA_DC_REST := null;',
'  :P6_RESTRICAO_REST := null;',
'  :P6_USUARIO_REST := null;',
'  :P6_DT_ATUALIZACAO_REST  := null;',
'end;                         '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':P6_COD_EMPRESA is not null and :P6_MATRICULA is not null'
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166660204356578394569)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Salva Dados Funcion\00E1rio')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :REQUEST = ''SAVE'' then',
'    ',
'     update inf_pessoais',
'        set tipo_sanguineo = :P6_TIPO_SANGUINEO',
'           ,fator_rh = :P6_FATOR_RH',
'      where cod_empresa = :P6_COD_EMPRESA',
'        and matricula = :P6_MATRICULA;',
'   ',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166660204244112394568)
,p_process_success_message=>unistr('Informa\00E7\00F5es Salvas com sucesso.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166662432673304082944)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166662430568110082923)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>unistr('Doen\00E7as - Save Interactive Grid Data')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166663102711730768647)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166663100488070768625)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Exames - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166663259920211578923)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166662431124357082928)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Atestados - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166663261850283578942)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Salva Dados Restri\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :REQUEST = ''SAVE_REST'' then',
' ',
' begin',
' insert into restricao_medica (cod_empresa, matricula, dc_matricula, restricao, usuario, dt_atualizacao)',
' values (:P6_COD_EMPRESA_REST, :P6_MATRICULA_REST, :P6_MATRICULA_DC_REST, :P6_RESTRICAO_REST, :P6_USUARIO_REST, :P6_DT_ATUALIZACAO_REST);',
' ',
' exception',
' when others then',
' ',
'   update restricao_medica ',
'      set restricao = :P6_RESTRICAO_REST,',
'          usuario = :p_usuario,',
'          dt_atualizacao = sysdate',
'    where cod_empresa = :P6_COD_EMPRESA_REST',
'      and matricula = :P6_MATRICULA_REST;',
' ',
' end;',
'  ',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166663261391703578938)
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
