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
--   Date and Time:   19:36 Friday October 2, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 121
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00121
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>121);
end;
/
prompt --application/pages/page_00121
begin
wwv_flow_api.create_page(
 p_id=>121
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>'Linha do Tempo (Colab x Fato)'
,p_step_title=>'Linha do Tempo (Colab x Fato)'
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
'}',
''))
,p_step_template=>wwv_flow_api.id(281503476810280346565)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_LinhaTempo.css / Natcorp_LinhaTempo.js)',
'',
unistr('No alto do relat\00F3rio, um seletor com tr\00EAs jeitos de ver os mesmos fatos:'),
'  Tabela      o Interactive Report de sempre;',
unistr('  Trajet\00F3ria  um Gantt com uma linha por colaborador (c\00F3digo - nome, centro de custo e'),
unistr('              situa\00E7\00E3o): fechada, um tracinho por mudan\00E7a; tocar no nome abre as faixas da'),
unistr('              pessoa (uma por fato). Busca por nome ou matr\00EDcula, ordem (Nome, Mais fatos, Mais'),
'              recente), abrir/fechar todos, zoom de anos a dias;',
unistr('  Cronologia  os fatos por ano, com o nome de quem \00E9 cada um, a mesma busca e filtros por assunto.'),
unistr('Os dados v\00EAm do processo Ajax Callback NC_LINHA_TEMPO_DADOS desta p\00E1gina, com o FROM e o WHERE'),
unistr('copiados do relat\00F3rio (os filtros do \00FAltimo Pesquisar, que est\00E3o na sess\00E3o, e a checagem de'),
unistr('acesso); o sal\00E1rio s\00F3 para quem pode ver (f_acesso_salario_apex, no servidor). At\00E9 20000 fatos.'),
unistr('Mudou o filtro do relat\00F3rio? Rode de novo aplicar-linhatempo-pagina121.py na exporta\00E7\00E3o.'),
'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/LINHATEMPO-MANUTENCAO.md.'))
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20261002184621'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281379284075972665591)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503489212020346637)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P121_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281379286806228665594)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P121_FATO'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281379288442284665595)
,p_plug_name=>unistr('Relat\00F3rio')
,p_region_name=>'IR_1'
,p_parent_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492405269346640)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa||'' - ''||initcap(nome_empresa) Empresa,',
'       filial||'' - ''||initcap(nome_filial) Filial,',
'       cod_ccusto||'' - ''||initcap(nome_ccusto) CCusto,',
'       matricula||'' - ''||initcap(nome) Colaborador,',
unistr('       situacao||'' - ''||initcap(nome_situacao) Situa\00E7\00E3o,'),
unistr('       vinculo||'' - ''||initcap(nome_vinculo) V\00EDnculo,'),
'       fato Fato,',
unistr('       case when upper(Fato) NOT IN (''SAL\00C1RIO'',''SALARIO'') then '),
'                 case when cod_valor_fato is not null then decode(cod_valor_fato,''0'','' '',cod_valor_fato||'' - '')||valor_fato else valor_fato end',
unistr('            when upper(Fato) IN (''SAL\00C1RIO'',''SALARIO'') and f_acesso_salario_apex(cod_empresa, matricula, filial, :p_usuario) = ''S'' then'),
'                 valor_fato',
unistr('       end Descri\00E7\00E3o,'),
'       percentual Percentual,',
'       data_ini Data_Inicial,',
'       data_fim Data_Final,',
'       initcap(motivo_movto) Motivo,',
'       dt_mudanca,',
'       cod_sindicato',
'  from vw_BI_linha_do_tempo i',
' where ((instr('',''||:p121_empresa_ind||'','','',''||i.cod_empresa||'','') > 0) or (:p121_empresa_ind is null))',
'   and ((instr('',''||:p121_filial_ind||'','','',''||i.filial||'','') > 0) or (:p121_filial_ind is null))',
'   and ((instr('',''||:p121_ccusto_ind||'','','',''||i.cod_ccusto||'','') > 0)    or (:p121_ccusto_ind is null))',
'   and ((instr('',''||:p121_matricula_ind||'','','',''||i.matricula||'','') > 0) or (:p121_matricula_ind is null))',
'   and ((instr('',''||:P121_situacao_IND||'','','',''||i.situacao||'','') > 0) or (nvl(:P121_situacao_IND,''T'') = ''T''))',
'   --and ((i.situacao < ''90'' and :P121_situacao_IND = ''A'') or (i.situacao >= ''90'' and :P121_situacao_IND = ''D'') or (:P121_situacao_IND = ''T'') or (:p121_situacao_ind is null))',
'   and ((instr('',''||:p121_vinculo_ind||'','','',''||i.vinculo||'','') > 0) or (:p121_vinculo_ind is null))',
'   and ((instr('',''||:p121_fato||'','','',''||fato||'','') > 0))',
'   --Chamado 36429 - Andre - 21-02-2025',
'   /*and ((data_ini >= nvl(:p121_data_ini,data_ini)) ',
'   and (data_fim is null or (data_fim is not null and data_fim <= nvl(:p121_data_ini,data_fim))))*/',
'   and ((data_ini between nvl(:p121_data_ini,data_ini) and nvl(:p121_data_fim,data_fim))',
'                  or (:p121_data_fim is null or (data_fim between nvl(:p121_data_ini,data_ini) and nvl(:p121_data_fim,data_fim)))) -- Guilherme -- 30/05/2025 chamado 38384, ajuste para encontrar quando data_fim for nula',
'   and ((NVL(:P121_chk_colaboradores_diretos,''S'') = ''S'' and ',
'         exists (select 1 ',
'                   from centro_de_custo cc',
'                  where cc.cod_empresa      = i.cod_empresa',
'                    and cc.cod              = i.cod_ccusto',
'                    and cc.cod_emp_gestor   = :p_empresa_user',
'                    and cc.matricula_gestor = :p_matricula_user',
'              union',
'                select 1 ',
'                  from centro_de_custo cy ',
'                 where cy.cod_emp_gestor      = i.cod_empresa',
'                   and cy.matricula_gestor    = i.matricula',
'                   and cy.cod_ccusto_superior = :p_ccusto_user',
'                )) OR',
'        (NVL(:P121_chk_colaboradores_diretos,''S'') = ''N'' and ',
'         F_ACESSO(I.COD_EMPRESA, I.MATRICULA, I.FILIAL, I.CD_NIVEL) = ''S''))',
' order by cod_empresa, matricula, data_ini, fato'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(281379288855752665597)
,p_name=>unistr('Hist\00F3rico Cadastral')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Filtre sua Pesquisa.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>46634663678220075
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379288913956665598)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'K'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P121_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379289347546665599)
,p_db_column_name=>'FILIAL'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P121_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379289760684665600)
,p_db_column_name=>'CCUSTO'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Ccusto'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P121_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379290163955665600)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Colaborador'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P121_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379290591060665601)
,p_db_column_name=>unistr('SITUA\00C7\00C3O')
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P121_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379290935631665601)
,p_db_column_name=>unistr('V\00CDNCULO')
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P121_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379291295621665602)
,p_db_column_name=>'FATO'
,p_display_order=>70
,p_column_identifier=>'Q'
,p_column_label=>'Fato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379291777660665602)
,p_db_column_name=>unistr('DESCRI\00C7\00C3O')
,p_display_order=>80
,p_column_identifier=>'R'
,p_column_label=>unistr('Descri\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379292110402665602)
,p_db_column_name=>'DATA_INICIAL'
,p_display_order=>90
,p_column_identifier=>'S'
,p_column_label=>'Data inicial'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379292547764665602)
,p_db_column_name=>'DATA_FINAL'
,p_display_order=>100
,p_column_identifier=>'T'
,p_column_label=>'Data final'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281379292920669665603)
,p_db_column_name=>'MOTIVO'
,p_display_order=>110
,p_column_identifier=>'U'
,p_column_label=>'Motivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(254009183932128359106)
,p_db_column_name=>'PERCENTUAL'
,p_display_order=>120
,p_column_identifier=>'V'
,p_column_label=>'Percentual'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(92715472978044796200)
,p_db_column_name=>'DT_MUDANCA'
,p_display_order=>130
,p_column_identifier=>'W'
,p_column_label=>unistr('Data Mudan\00E7a')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(92715473133402796201)
,p_db_column_name=>'COD_SINDICATO'
,p_display_order=>140
,p_column_identifier=>'X'
,p_column_label=>unistr('C\00F3digo Sindicato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(281379293340074665603)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'466392'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:FILIAL:CCUSTO:COLABORADOR:SITUA\00C7\00C3O:V\00CDNCULO:FATO:DESCRI\00C7\00C3O:PERCENTUAL:DATA_INICIAL:DATA_FINAL:MOTIVO::DT_MUDANCA:COD_SINDICATO')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281379297699245665606)
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
 p_id=>wwv_flow_api.id(281379298104383665606)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268762555999650830116)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(268764742959198334842)
,p_button_sequence=>111
,p_button_plug_id=>wwv_flow_api.id(281379298104383665606)
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
 p_id=>wwv_flow_api.id(268764743284659336073)
,p_button_sequence=>121
,p_button_plug_id=>wwv_flow_api.id(281379298104383665606)
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
 p_id=>wwv_flow_api.id(281379298508901665607)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_button_name=>'p121_btn_filtar_ind2'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281379284457911665593)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281379284075972665591)
,p_button_name=>'p121_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P121_EMP.,&P121_MAT.,&P121_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281379298911849665607)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_button_name=>'p121_btn_limpar_filtros'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Limpar Filtros'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-eraser'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(58333042056189174689)
,p_button_sequence=>131
,p_button_plug_id=>wwv_flow_api.id(281379288442284665595)
,p_button_name=>'IA_1'
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
 p_id=>wwv_flow_api.id(58333015803625048211)
,p_name=>'P121_FLG'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333015989297048212)
,p_name=>'P121_MSG'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333016074960048213)
,p_name=>'P121_USER_PROMPT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333016123272048214)
,p_name=>'P121_SYS_PROMPT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58333016208800048215)
,p_name=>'P121_STATIC_ID_IR'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379284797444665593)
,p_name=>'P121_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281379284075972665591)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_colspan=>2
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>'select foto from fotos where cod_empresa = :p121_emp and matricula = :p121_mat'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379285209294665593)
,p_name=>'P121_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281379284075972665591)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_column=>3
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
 p_id=>wwv_flow_api.id(281379285688627665594)
,p_name=>'P121_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281379284075972665591)
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
 p_id=>wwv_flow_api.id(281379285994180665594)
,p_name=>'P121_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281379284075972665591)
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
 p_id=>wwv_flow_api.id(281379286427344665594)
,p_name=>'P121_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281379284075972665591)
,p_prompt=>unistr('Data de Admiss\00E3o')
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
 p_id=>wwv_flow_api.id(281379287223384665595)
,p_name=>'P121_CHAMADOR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379287674347665595)
,p_name=>'P121_EMP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379288015565665595)
,p_name=>'P121_MAT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281379286806228665594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379299330979665607)
,p_name=>'P121_CHK_COLABORADORES_DIRETOS'
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_api.id(268762555999650830116)
,p_item_default=>'N'
,p_prompt=>'Colaboradores Diretos'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_display_when=>'P121_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379299743249665607)
,p_name=>'P121_EMPRESA_IND'
,p_item_sequence=>21
,p_item_plug_id=>wwv_flow_api.id(268762555999650830116)
,p_prompt=>'Empresas'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod||'' - ''||initcap(nvl(e.nome_abrev,e.nome)) descricao, e.cod codigo ',
'  from empresas e',
' WHERE ((nvl(:P121_CHK_COLABORADORES_DIRETOS,''N'') = ''N'') or',
'       (NVL(:P121_CHK_COLABORADORES_DIRETOS,''N'') = ''S'' and ',
'         exists (select 1 ',
'                   from centro_de_custo cc',
'                  where cc.cod_empresa = e.cod',
'                    and cc.cod_emp_gestor = :p_empresa_user',
'                    and cc.matricula_gestor = :p_matricula_user',
'                )))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P121_CHK_COLABORADORES_DIRETOS'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P121_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379300114396665609)
,p_name=>'P121_FILIAL_IND'
,p_item_sequence=>31
,p_item_plug_id=>wwv_flow_api.id(268762555999650830116)
,p_prompt=>'Filiais'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_filial||'' - ''||Initcap(nvl(f.sigla,f.nome_filial)) descricao, f.cod_filial',
'  from filiais f',
'where ((instr('',''||:p121_empresa_ind||'','','',''||f.cod_empresa||'','') > 0) or (:p121_empresa_ind is null))',
'AND ((nvl(:p121_chk_colaboradores_diretos,''N'') = ''N'') or',
'       (nvl(:p121_chk_colaboradores_diretos,''N'') = ''S'' and ',
'         exists (select 1 ',
'                   from centro_de_custo cc, filial_ccusto fc',
'                  where cc.cod_empresa = fc.cod_empresa',
'                    and cc.cod = fc.cod_ccusto',
'                    and cc.cod_empresa = f.cod_empresa',
'                    and fc.cod_filial = f.cod_filial',
'                    and cc.cod_emp_gestor = :p_empresa_user',
'                    and cc.matricula_gestor = :p_matricula_user)))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P121_EMPRESA_IND,P121_CHK_COLABORADORES_DIRETOS'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P121_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379300520455665609)
,p_name=>'P121_CCUSTO_IND'
,p_item_sequence=>41
,p_item_plug_id=>wwv_flow_api.id(268762555999650830116)
,p_prompt=>'Centro de Custo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct fc.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(fc.cod_empresa, fc.cod_ccusto)) descricao, fc.cod_ccusto ',
'from filial_ccusto fc',
'where ((instr('',''||:p121_empresa_ind||'','','',''||fc.cod_empresa||'','') > 0) or (:p121_empresa_ind is null))',
'and ((instr('',''||:p121_filial_ind||'','','',''||fc.cod_filial||'','') > 0) or (:p121_filial_ind is null))',
'and ((nvl(:p121_chk_colaboradores_diretos,''N'') = ''N'' and f_acesso_cc_pg_apex(fc.cod_empresa, fc.cod_ccusto, :p_usuario, :p_painel) = ''S'') or',
'       (nvl(:p121_chk_colaboradores_diretos,''N'') = ''S'' and ',
'         exists (select 1 ',
'                   from centro_de_custo cc',
'                  where cc.cod_empresa = fc.cod_empresa',
'                    and cc.cod = fc.cod_ccusto',
'                    and cc.cod_emp_gestor = :p_empresa_user',
'                    and cc.matricula_gestor = :p_matricula_user)))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P121_EMPRESA_IND,P121_FILIAL_IND,P121_CHK_COLABORADORES_DIRETOS'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P121_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379300904462665609)
,p_name=>'P121_MATRICULA_IND'
,p_item_sequence=>71
,p_item_plug_id=>wwv_flow_api.id(268762555999650830116)
,p_prompt=>unistr('Matr\00EDcula')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(p.nome) d, i.matricula',
'  from informacoes_funcionais i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and (:P121_situacao_IND  is null or ',
'        ((i.SITUACAO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P121_situacao_IND, '','')) t))',
'         or (:P121_situacao_IND = ''T''))) ',
'   --and ((i.situacao < ''90'' and :P121_situacao_IND = ''A'') or (i.situacao >= ''90'' and :P121_situacao_IND = ''D'') or (:P121_situacao_IND = ''T'') or (:p121_situacao_ind is null))',
'   and (:P121_EMPRESA_IND     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P121_EMPRESA_IND, '','')) t))',
'   and (:P121_FILIAL_IND      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P121_FILIAL_IND, '','')) t))',
'   and (:P121_CCUSTO_IND      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P121_CCUSTO_IND, '','')) t))',
'   and (:P121_VINCULO_IND     is null or i.vinculo       in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P121_VINCULO_IND, '','')) t))',
'   and ((nvl(:p121_chk_colaboradores_diretos,''N'') = ''S'' and ',
'         exists (select 1 ',
'                   from centro_de_custo cc',
'                  where cc.cod_empresa = i.cod_empresa',
'                    and cc.cod = i.cod_ccusto',
'                    and cc.cod_emp_gestor = :p_empresa_user',
'                    and cc.matricula_gestor = :p_matricula_user',
'                  union',
'                  select 1 ',
'                  from centro_de_custo cy ',
'                  where cy.cod_emp_gestor = i.cod_empresa',
'                   and cy.matricula_gestor = i.matricula',
'                   and cy.cod_ccusto_superior = :p_ccusto_user',
'               union',
'                   SELECT 1',
'                   FROM SUB_CCUSTO S',
'                  WHERE S.COD_EMPRESA = I.COD_EMPRESA',
'                    AND S.COD_CCUSTO = I.COD_CCUSTO',
'                    AND S.COD_SUB_CCUSTO = I.COD_SUB_CCUSTO',
'                    AND s.cod_emp_gestor = :P_EMPRESA_USER',
'                    and s.mat_gestor = :P_MATRICULA_USER',
'                )) OR',
'        (nvl(:p121_chk_colaboradores_diretos,''N'') = ''N''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P121_CHK_COLABORADORES_DIRETOS,P121_EMPRESA_IND,P121_FILIAL_IND,P121_CCUSTO_IND,P121_VINCULO_IND,P121_SITUACAO_IND'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P121_MAT'
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
 p_id=>wwv_flow_api.id(281379301329656665610)
,p_name=>'P121_SITUACAO_IND'
,p_item_sequence=>105
,p_item_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD||''-''|| INITCAP(NOME) Situacao',
'   ,   cod',
'FROM sit_func',
'where cod <> ''EE''',
'union',
'SELECT ''Todos'' Situacao',
'   ,   ''T''',
'FROM sit_func',
'order by COD',
''))
,p_cSize=>30
,p_display_when=>'P121_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379301741303665610)
,p_name=>'P121_VINCULO_IND'
,p_item_sequence=>61
,p_item_plug_id=>wwv_flow_api.id(268762555999650830116)
,p_prompt=>unistr('V\00EDnculo')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from vinculo_empreg',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_display_when=>'P121_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379302134181665611)
,p_name=>'P121_FATO'
,p_is_required=>true
,p_item_sequence=>81
,p_item_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_prompt=>'Fato'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(fato) descricao, fato cod  ',
'  from vw_BI_linha_do_tempo i',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513458569346680)
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
 p_id=>wwv_flow_api.id(281379302511808665611)
,p_name=>'P121_DATA_INI'
,p_item_sequence=>91
,p_item_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_prompt=>'Data Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281379302991513665611)
,p_name=>'P121_DATA_FIM'
,p_item_sequence=>101
,p_item_plug_id=>wwv_flow_api.id(281379298104383665606)
,p_prompt=>'Data Final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281379307457101665615)
,p_name=>'Refresh Linha do Tempo'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P121_FATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281379306535605665615)
,p_name=>'Submit Page Linha do Tempo'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P121_FATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281379307003679665615)
,p_event_id=>wwv_flow_api.id(281379306535605665615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281379304713722665613)
,p_name=>'Refresh_Ind'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281379298508901665607)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281379305245684665613)
,p_event_id=>wwv_flow_api.id(281379304713722665613)
,p_event_result=>'TRUE'
,p_action_sequence=>150
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281379305595926665614)
,p_name=>'Limpar Filtros'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281379298911849665607)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281379306115657665615)
,p_event_id=>wwv_flow_api.id(281379305595926665614)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P121_EMPRESA_IND,P121_FILIAL_IND,P121_CCUSTO_IND,P121_MATRICULA_IND,P121_VINCULO_IND,P121_FATO,P121_DATA_INI,P121_DATA_FIM'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268764744609068342986)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(268764742959198334842)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268764745024785342988)
,p_event_id=>wwv_flow_api.id(268764744609068342986)
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
 p_id=>wwv_flow_api.id(268764745363319344440)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(268764743284659336073)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268764745795552344441)
,p_event_id=>wwv_flow_api.id(268764745363319344440)
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
 p_id=>wwv_flow_api.id(58333040600939171795)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>70
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58333041020320171795)
,p_event_id=>wwv_flow_api.id(58333040600939171795)
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
'  apex.item("P121_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P121_SYS_PROMPT").setValue("Voc\00EA \00E9 um especialista de gest\00E3o dos colaboradores em RH e Departamento Pessoal.");'),
unistr('  apex.item("P121_USER_PROMPT").setValue("Analise os dados de hist\00F3ricos dos colaboradores a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58333041511010171796)
,p_event_id=>wwv_flow_api.id(58333040600939171795)
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
'      v_region_static_id varchar2(100) := :P121_STATIC_ID_IR; --''IR_REGION'';',
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
'      v_system_prompt := :P121_SYS_PROMPT;',
'      v_user_prompt := :P121_USER_PROMPT;  --''Analise os dados a seguir.'';',
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
'      :P121_flg := v_status;',
'      :P121_msg := v_mensagem;',
'',
'    END;'))
,p_attribute_02=>'P121_USER_PROMPT,P121_SYS_PROMPT,P121_STATIC_ID_IR'
,p_attribute_03=>'P121_FLG,P121_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281379304300668665613)
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
 p_id=>wwv_flow_api.id(281379303967673665613)
,p_process_sequence=>20
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
'       i.cod_empresa cod_emp,',
'       i.matricula mat',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p121_emp',
'   and i.matricula = :p121_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p121_cod_empresa := v_c1.empresa;',
':p121_matricula := v_c1.matricula;',
':p121_situacao := v_c1.situacao;',
':p121_dt_admissao := v_c1.dt_admissao;',
'',
'if v_c1.matricula is not null then',
':p121_empresa_ind := v_c1.cod_emp;',
':p121_matricula_ind := v_c1.mat;',
'end if;',
'',
'exception',
'when others then',
':p121_cod_empresa := :p121_emp;',
':p121_matricula := :p121_mat;',
'',
':p121_empresa_ind := v_c1.cod_emp;',
':p121_matricula_ind := v_c1.mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28299020001210000001)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_LINHA_TEMPO_DADOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Entrega os fatos da Linha do Tempo (v\00E1rios colaboradores) ao Natcorp_LinhaTempo.js, em JSON.'),
unistr('-- O FROM e o WHERE s\00E3o os do relat\00F3rio (copiados pelo aplicar-linhatempo-pagina121.py): os filtros'),
unistr('-- do \00FAltimo Pesquisar (na sess\00E3o) e a checagem de acesso. O sal\00E1rio s\00F3 para quem pode ver.'),
'declare',
'  c_limite constant pls_integer := 20000;',
'  v_n      pls_integer := 0;',
'  v_cortou boolean := false;',
'  procedure data_json(p_nome varchar2, p_data date) is',
'  begin',
'    apex_json.open_object(p_nome);',
'    if p_data is not null then',
'      apex_json.write(''year'', to_number(to_char(p_data, ''yyyy'')));',
'      apex_json.write(''month'', to_number(to_char(p_data, ''mm'')));',
'      apex_json.write(''day'', to_number(to_char(p_data, ''dd'')));',
'    end if;',
'    apex_json.close_object;',
'  end;',
'begin',
'  apex_json.open_object;',
'  apex_json.open_array(''events'');',
'  for r in (',
'    select i.cod_empresa, i.matricula, initcap(i.nome) nome,',
unistr('           i.cod_ccusto||'' - ''||initcap(i.nome_ccusto)||'' \00B7 ''||initcap(i.nome_situacao) sub,'),
'           i.fato, i.data_ini, i.data_fim, i.percentual, initcap(i.motivo_movto) motivo,',
unistr('           case when upper(i.fato) not in (''SAL\00C1RIO'', ''SALARIO'') then'),
'                     case when i.cod_valor_fato is not null then decode(i.cod_valor_fato, ''0'', '' '', i.cod_valor_fato||'' - '')||i.valor_fato else i.valor_fato end',
'                when f_acesso_salario_apex(i.cod_empresa, i.matricula, i.filial, :p_usuario) = ''S'' then',
'                     i.valor_fato',
'           end descricao,',
unistr('           case when upper(i.fato) in (''SAL\00C1RIO'', ''SALARIO'') then ''S'' else ''N'' end eh_salario'),
'      from vw_BI_linha_do_tempo i',
'     where ((instr('',''||:p121_empresa_ind||'','','',''||i.cod_empresa||'','') > 0) or (:p121_empresa_ind is null))',
'       and ((instr('',''||:p121_filial_ind||'','','',''||i.filial||'','') > 0) or (:p121_filial_ind is null))',
'       and ((instr('',''||:p121_ccusto_ind||'','','',''||i.cod_ccusto||'','') > 0)    or (:p121_ccusto_ind is null))',
'       and ((instr('',''||:p121_matricula_ind||'','','',''||i.matricula||'','') > 0) or (:p121_matricula_ind is null))',
'       and ((instr('',''||:P121_situacao_IND||'','','',''||i.situacao||'','') > 0) or (nvl(:P121_situacao_IND,''T'') = ''T''))',
'       --and ((i.situacao < ''90'' and :P121_situacao_IND = ''A'') or (i.situacao >= ''90'' and :P121_situacao_IND = ''D'') or (:P121_situacao_IND = ''T'') or (:p121_situacao_ind is null))',
'       and ((instr('',''||:p121_vinculo_ind||'','','',''||i.vinculo||'','') > 0) or (:p121_vinculo_ind is null))',
'       and ((instr('',''||:p121_fato||'','','',''||fato||'','') > 0))',
'       --Chamado 36429 - Andre - 21-02-2025',
'       /*and ((data_ini >= nvl(:p121_data_ini,data_ini)) ',
'       and (data_fim is null or (data_fim is not null and data_fim <= nvl(:p121_data_ini,data_fim))))*/',
'       and ((data_ini between nvl(:p121_data_ini,data_ini) and nvl(:p121_data_fim,data_fim))',
'                      or (:p121_data_fim is null or (data_fim between nvl(:p121_data_ini,data_ini) and nvl(:p121_data_fim,data_fim)))) -- Guilherme -- 30/05/2025 chamado 38384, ajuste para encontrar quando data_fim for nula',
'       and ((NVL(:P121_chk_colaboradores_diretos,''S'') = ''S'' and ',
'             exists (select 1 ',
'                       from centro_de_custo cc',
'                      where cc.cod_empresa      = i.cod_empresa',
'                        and cc.cod              = i.cod_ccusto',
'                        and cc.cod_emp_gestor   = :p_empresa_user',
'                        and cc.matricula_gestor = :p_matricula_user',
'                  union',
'                    select 1 ',
'                      from centro_de_custo cy ',
'                     where cy.cod_emp_gestor      = i.cod_empresa',
'                       and cy.matricula_gestor    = i.matricula',
'                       and cy.cod_ccusto_superior = :p_ccusto_user',
'                    )) OR',
'            (NVL(:P121_chk_colaboradores_diretos,''S'') = ''N'' and ',
'             F_ACESSO(I.COD_EMPRESA, I.MATRICULA, I.FILIAL, I.CD_NIVEL) = ''S''))',
'     order by i.cod_empresa, i.matricula, i.data_ini, i.fato) loop',
'    if r.eh_salario = ''S'' and r.descricao is null then',
unistr('      continue;   -- quem n\00E3o pode ver sal\00E1rio n\00E3o recebe nenhuma linha de sal\00E1rio'),
'    end if;',
'    if v_n >= c_limite then',
'      v_cortou := true;',
'      exit;',
'    end if;',
'    v_n := v_n + 1;',
'    apex_json.open_object;',
'    apex_json.write(''group'', r.fato);',
'    data_json(''start_date'', r.data_ini);',
'    data_json(''end_date'', r.data_fim);',
'    apex_json.open_object(''text'');',
'    apex_json.write(''headline'', ''(''||r.fato||'') ''||trim(r.descricao)',
'      ||case when r.eh_salario = ''S'' and r.percentual is not null then '' Percentual: ''||r.percentual end',
'      ||case when r.motivo is not null then '' Motivo: ''||r.motivo end);',
'    apex_json.write(''text'', r.fato);',
'    apex_json.close_object;',
'    apex_json.open_object(''quem'');',
'    apex_json.write(''id'', r.cod_empresa||''-''||r.matricula);',
'    apex_json.write(''mat'', to_char(r.matricula));',
'    apex_json.write(''nome'', r.nome);',
'    apex_json.write(''sub'', r.sub);',
'    apex_json.close_object;',
'    apex_json.close_object;',
'  end loop;',
'  apex_json.close_array;',
'  apex_json.write(''cortado'', v_cortou);',
'  apex_json.close_object;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>unistr('Natcorp_LinhaTempo.js: a Trajet\00F3ria e a Cronologia pedem os fatos aqui (apex.server.process). FROM/WHERE copiados do relat\00F3rio pelo aplicar-linhatempo-pagina121.py. Guia: LINHATEMPO-MANUTENCAO.md.')
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
