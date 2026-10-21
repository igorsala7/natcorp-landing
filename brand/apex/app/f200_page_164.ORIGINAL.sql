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
--   Date and Time:   23:30 Thursday October 8, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 164
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00164
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>164);
end;
/
prompt --application/pages/page_00164
begin
wwv_flow_api.create_page(
 p_id=>164
,p_user_interface_id=>wwv_flow_api.id(283867044223119591244)
,p_name=>unistr('Benef\00EDcios')
,p_step_title=>unistr('Benef\00EDcios')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
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
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20251211125545'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(114108792152355958193)
,p_plug_name=>unistr('Benef\00EDcios Processo')
,p_region_name=>'IR_1'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
'Alt.1, chamado 39329, trat. reg. duplicados, PSMarconato/Ana/Rosi, 21/07/2025.',
'*/',
'SELECT b.indice',
'       ,b.cod_empresa',
'       , b.nome_empresa',
'       , b.filial',
'       , b.nome_filial',
'       , b.cod_ccusto',
'       , b.nome_ccusto',
'       , b.UNIDADE_ADM',
'       , b.DESC_UNID_ADM',
'       , b.COD_ATIVIDADE',
'       , b.DESC_ATIVIDADE',
'       , b.CLASS_CCUSTO',
'       , b.DESC_CLASS_CCUSTO',
'       , b.CPF',
'       , b.MATRICULA',
'       , b.NOME',
'       , b.MES_ADMISSAO',
'       , b.ANO_ADMISSAO',
'       , b.SITUACAO',
'       , b.NOME_SITUACAO',
'       , b.MES_SITUACAO',
'       , b.ANO_SITUACAO',
'       , b.MOT_ALT_SITUACAO',
'       , b.DESC_MOTIVO_SITUACAO',
'       , b.VINCULO',
'       , b.NOME_VINCULO',
'       , b.VAGA',
'       , b.CARGO',
'       , b.NOME_CARGOS',
'       , b.CLASS_CARGO',
'       , b.DESC_CLASS_CARGO',
'       , b.FUNCAO',
'       , b.NOME_FUNCAO',
'       , b.COD_LOCALIZACAO',
'       , b.DESC_LOCAL',
'       , b.MES_NASC',
'       , b.ANO_NASC',
'       , b.IDADE',
'       , b.SEXO',
'       , b.ESTADO_CIVIL',
'       , b.DESC_EST_CIVIL',
'       , b.INSTRUCAO',
'       , b.DESC_INSTR',
'       , b.FORMACAO_ESCOLAR',
'       , b.NOME_FORMACAO',
'       , b.FAIXA_SALARIO',
'       , b.FAIXA_IDADE',
'       , b.FX_TEMPO_CASA',
'       , b.TEMPO_CASA',
'       , b.CODIGO COD_BENEFICIO',
'       , b.DESCRICAO_FAMILIA',
'       , b.TIPO',
'       , b.DESCRICAO_TIPO ',
'       , nvl(b.VL_BENEFICIO, u.qtde_dias_uteis * cm.custo_nova_tarifa * u.qtde_dia_passes )  VL_BENEFICIO',
'       , (select x.quantidade ',
'            from INCOR_BENEFICIOS_FUNCIONAIS x',
'           where x.cod_empresa = b.cod_empresa',
'             and x.matricula = b.matricula',
'             and to_char(x.tipo) = b.tipo',
'             and x.dt_inicio = to_date(b.dt_inicio,''dd/mm/rrrr'')',
'             and x.flag = b.codigo',
'           ) QTDADE_DIARIA',
'       --, NVL(b.QTDADE_DIARIA, u.qtde_dia_passes) QTDADE_DIARIA',
'       , b.VALOR_PARTE_EMPRESA',
'       , NVL(b.CUSTO_UNITARIO,cm.custo_nova_tarifa)CUSTO_UNITARIO',
'       , b.DIAS_COMPRA',
'       , b.DIAS_COMPLETOS',
'       , b.DIAS_SALDO_CARTAO SALDO_EXCEDENTE',
'       , b.DIAS_EXCEDENTES',
'       , b.DIAS_FALTAS',
'       , b.DIAS_FALTAS_ATEST',
'       , b.DIAS_ATEST',
'       , b.DIAS_FERIAS',
'       , b.DIAS_AFASTAMENTO',
'       , b.VLR_TOTAL  VALOR_COMPRA',
'       , b.DATA_CASAMENTO',
'       , b.DT_INICIO',
'       , b.DT_FIM',
'       , b.DATA_REF DATA_REFERENCIA',
'       , b.NR_CARTAO',
'       , b.ENDERECO',
'       , b.NOME_LOGR',
'       , b.COMPLEM',
'       , b.BAIRRO',
'       , b.CIDADE',
'       , b.UF',
'       , b.COMPLEMENTO CEP',
'       , b.TELEFONE',
'       , b.DDD_CELL',
'       , b.TELEFONE_CELULAR',
'       , b.E_MAIL',
'       , b.NUM_REGISTRO',
'       , b.NUM_PIS_PASEP',
'       , b.NUM_CART_PROF',
'       , b.NOME_MAE',
unistr('       , DECODE(b.IND_SUSPENSO,''S'',''Sim'', ''N'',''N\00E3o'') IND_SUSPENSO'),
'       , b.VALOR_MINIMO',
'       , b.VALOR_MAXIMO',
'       , b.VALOR_UNITARIO',
'       , b.DT_NASC',
'       , b.COD_CCUSTO_CONT',
'       , b.DESC_CCUSTO_CONT',
'FROM BI_BENEFICIOS B, MEIO_FUNC x, utilizacao U, custo_meio cm',
'WHERE b.USUARIO = :P_USUARIO',
'and B.COD_EMPRESA = x.cod_empresa',
'and B.MATRICULA   = x.matricula',
'AND B.TIPO        = to_char(X.COD_LOC)',
'AND U.COD_UTILIZACAO = x.COD_UTILIZACAO',
'AND B.cod_empresa = cm.cod_empresa ',
'AND B.TIPO = to_char(cm.cod_loc) ',
'AND cm.empresa_vale = x.EMPRESA_VALE',
'AND b.indice = ''VALE TRANSPORTE''/*Alt.1, incl. cond.*/',
'',
'union',
'',
'SELECT c.indice',
'       ,c.cod_empresa',
'       , c.nome_empresa',
'       , c.filial',
'       , c.nome_filial',
'       , c.cod_ccusto',
'       , c.nome_ccusto',
'       , c.UNIDADE_ADM',
'       , c.DESC_UNID_ADM',
'       , c.COD_ATIVIDADE',
'       , c.DESC_ATIVIDADE',
'       , c.CLASS_CCUSTO',
'       , c.DESC_CLASS_CCUSTO',
'       , c.CPF',
'       , c.MATRICULA',
'       , c.NOME',
'       , c.MES_ADMISSAO',
'       , c.ANO_ADMISSAO',
'       , c.SITUACAO',
'       , c.NOME_SITUACAO',
'       , c.MES_SITUACAO',
'       , c.ANO_SITUACAO',
'       , c.MOT_ALT_SITUACAO',
'       , c.DESC_MOTIVO_SITUACAO',
'       , c.VINCULO',
'       , c.NOME_VINCULO',
'       , c.VAGA',
'       , c.CARGO',
'       , c.NOME_CARGOS',
'       , c.CLASS_CARGO',
'       , c.DESC_CLASS_CARGO',
'       , c.FUNCAO',
'       , c.NOME_FUNCAO',
'       , c.COD_LOCALIZACAO',
'       , c.DESC_LOCAL',
'       , c.MES_NASC',
'       , c.ANO_NASC',
'       , c.IDADE',
'       , c.SEXO',
'       , c.ESTADO_CIVIL',
'       , c.DESC_EST_CIVIL',
'       , c.INSTRUCAO',
'       , c.DESC_INSTR',
'       , c.FORMACAO_ESCOLAR',
'       , c.NOME_FORMACAO',
'       , c.FAIXA_SALARIO',
'       , c.FAIXA_IDADE',
'       , c.FX_TEMPO_CASA',
'       , c.TEMPO_CASA',
'       , c.CODIGO COD_BENEFICIO',
'       , c.DESCRICAO_FAMILIA',
'       , c.TIPO',
'       , c.DESCRICAO_TIPO ',
'       , c.VL_BENEFICIO',
'       , (select x.quantidade ',
'            from INCOR_BENEFICIOS_FUNCIONAIS x',
'           where x.cod_empresa = c.cod_empresa',
'             and x.matricula = c.matricula',
'             and to_char(x.tipo) = c.tipo',
'             and x.dt_inicio = to_date(c.dt_inicio,''dd/mm/rrrr'')',
'             and x.flag = c.codigo',
'           ) QTDADE_DIARIA',
'       --, c.QTDADE_DIARIA',
'       , c.VALOR_PARTE_EMPRESA',
'       , c.CUSTO_UNITARIO',
'       , c.DIAS_COMPRA',
'       , c.DIAS_COMPLETOS',
'       , c.DIAS_SALDO_CARTAO SALDO_EXCEDENTE',
'       , c.DIAS_EXCEDENTES',
'       , c.DIAS_FALTAS',
'       , c.DIAS_FALTAS_ATEST',
'       , c.DIAS_ATEST',
'       , c.DIAS_FERIAS',
'       , c.DIAS_AFASTAMENTO',
'       , c.VLR_TOTAL  VALOR_COMPRA',
'       , c.DATA_CASAMENTO',
'       , c.DT_INICIO',
'       , c.DT_FIM',
'       , c.DATA_REF DATA_REFERENCIA',
'       , c.NR_CARTAO',
'       , c.ENDERECO',
'       , c.NOME_LOGR',
'       , c.COMPLEM',
'       , c.BAIRRO',
'       , c.CIDADE',
'       , c.UF',
'       , c.COMPLEMENTO CEP',
'       , c.TELEFONE',
'       , c.DDD_CELL',
'       , c.TELEFONE_CELULAR',
'       , c.E_MAIL',
'       , c.NUM_REGISTRO',
'       , c.NUM_PIS_PASEP',
'       , c.NUM_CART_PROF',
'       , c.NOME_MAE      ',
unistr('       , DECODE(c.IND_SUSPENSO,''S'',''Sim'', ''N'',''N\00E3o'') IND_SUSPENSO'),
'       , c.VALOR_MINIMO',
'       , c.VALOR_MAXIMO',
'       , c.VALOR_UNITARIO',
'       , c.DT_NASC',
'       , c.COD_CCUSTO_CONT',
'       , c.DESC_CCUSTO_CONT',
'FROM BI_BENEFICIOS c',
'WHERE USUARIO = :P_USUARIO',
'and c.indice <> ''VALE TRANSPORTE''',
'/*ORDER BY b.indice',
'      , b.COD_EMPRESA',
'      , b.FILIAL',
'      , b.COD_CCUSTO',
'      , b.MATRICULA',
'      , b.codigo',
'      , b.tipo',
'      , b.dt_inicio desc*/',
'ORDER BY 1',
'      , 2',
'      , 4',
'      , 6',
'      , 15',
'      , 50',
'      , 52',
'      , 69 desc;      '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P164_OPCAO'
,p_plug_display_when_cond2=>'C'
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
 p_id=>wwv_flow_api.id(114108792259728958194)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'ANDRE.BONI'
,p_internal_uid=>31949661491692502
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108792327058958195)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('C\00F3d. Empresa')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108792434226958196)
,p_db_column_name=>'FUNCAO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108792558655958197)
,p_db_column_name=>'NOME_FUNCAO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Nome Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108792643919958198)
,p_db_column_name=>'COD_LOCALIZACAO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('C\00F3d. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108792783100958199)
,p_db_column_name=>'DESC_LOCAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Descr. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108792914128958201)
,p_db_column_name=>'DESC_UNID_ADM'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Descr. Unid. Adm. (Cliente)'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793028434958202)
,p_db_column_name=>'MES_NASC'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>unistr('M\00EAs do Nascimento')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793196909958203)
,p_db_column_name=>'ANO_NASC'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Ano do Nascimento'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793359957958205)
,p_db_column_name=>'SEXO'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793491611958206)
,p_db_column_name=>'ESTADO_CIVIL'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793514767958207)
,p_db_column_name=>'DESC_EST_CIVIL'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Descr. Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793680194958208)
,p_db_column_name=>'INSTRUCAO'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>unistr('Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793768875958209)
,p_db_column_name=>'DESC_INSTR'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>unistr('Descr. Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793839230958210)
,p_db_column_name=>'FORMACAO_ESCOLAR'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>unistr('Forma\00E7\00E3o Escolar')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108793941131958211)
,p_db_column_name=>'NOME_FORMACAO'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>unistr('Descr. Forma\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794088186958212)
,p_db_column_name=>'FAIXA_SALARIO'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>unistr('Faixa de Sal\00E1rio')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794109391958213)
,p_db_column_name=>'FAIXA_IDADE'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Faixa de Idade'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794245661958214)
,p_db_column_name=>'FX_TEMPO_CASA'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>'Faixa de Tempo de Casa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794596337958217)
,p_db_column_name=>'DESCRICAO_FAMILIA'
,p_display_order=>230
,p_column_identifier=>'T'
,p_column_label=>unistr('Descri\00E7\00E3o Fam\00EDlia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794641063958218)
,p_db_column_name=>'TIPO'
,p_display_order=>240
,p_column_identifier=>'U'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794708268958219)
,p_db_column_name=>'DESCRICAO_TIPO'
,p_display_order=>250
,p_column_identifier=>'V'
,p_column_label=>'Descr. Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108794987755958221)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>270
,p_column_identifier=>'W'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108795128168958223)
,p_db_column_name=>'INDICE'
,p_display_order=>290
,p_column_identifier=>'X'
,p_column_label=>unistr('\00CDndice')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108795678500958228)
,p_db_column_name=>'COD_ATIVIDADE'
,p_display_order=>340
,p_column_identifier=>'Y'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108795728208958229)
,p_db_column_name=>'DESC_ATIVIDADE'
,p_display_order=>350
,p_column_identifier=>'Z'
,p_column_label=>unistr('Desc. Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796160253958233)
,p_db_column_name=>'ENDERECO'
,p_display_order=>390
,p_column_identifier=>'AA'
,p_column_label=>'Endereco'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796290514958234)
,p_db_column_name=>'NOME_LOGR'
,p_display_order=>400
,p_column_identifier=>'AB'
,p_column_label=>'Nome Logr'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796302952958235)
,p_db_column_name=>'COMPLEM'
,p_display_order=>410
,p_column_identifier=>'AC'
,p_column_label=>'Complem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796492642958236)
,p_db_column_name=>'BAIRRO'
,p_display_order=>420
,p_column_identifier=>'AD'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796584276958237)
,p_db_column_name=>'CIDADE'
,p_display_order=>430
,p_column_identifier=>'AE'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796658642958238)
,p_db_column_name=>'UF'
,p_display_order=>440
,p_column_identifier=>'AF'
,p_column_label=>'Uf'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108796959531958241)
,p_db_column_name=>'DDD_CELL'
,p_display_order=>470
,p_column_identifier=>'AH'
,p_column_label=>'Ddd Cell'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108797197498958193)
,p_db_column_name=>'E_MAIL'
,p_display_order=>490
,p_column_identifier=>'AI'
,p_column_label=>'E Mail'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108797239020958194)
,p_db_column_name=>'NUM_REGISTRO'
,p_display_order=>500
,p_column_identifier=>'AJ'
,p_column_label=>'Num Registro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108797572105958197)
,p_db_column_name=>'FILIAL'
,p_display_order=>530
,p_column_identifier=>'AK'
,p_column_label=>unistr('C\00F3d. Filial')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108797691226958198)
,p_db_column_name=>'NOME_MAE'
,p_display_order=>540
,p_column_identifier=>'AL'
,p_column_label=>'Nome Mae'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108797871681958200)
,p_db_column_name=>'VALOR_PARTE_EMPRESA'
,p_display_order=>560
,p_column_identifier=>'AM'
,p_column_label=>'Valor Parte Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108797981681958201)
,p_db_column_name=>'CUSTO_UNITARIO'
,p_display_order=>570
,p_column_identifier=>'AN'
,p_column_label=>'Custo Unitario'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798075333958202)
,p_db_column_name=>'DIAS_COMPLETOS'
,p_display_order=>580
,p_column_identifier=>'AO'
,p_column_label=>'Dias Completos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798223422958204)
,p_db_column_name=>'DIAS_EXCEDENTES'
,p_display_order=>600
,p_column_identifier=>'AQ'
,p_column_label=>'Dias Excedentes'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798328570958205)
,p_db_column_name=>'DIAS_FALTAS'
,p_display_order=>610
,p_column_identifier=>'AR'
,p_column_label=>'Dias Faltas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798429236958206)
,p_db_column_name=>'DIAS_FALTAS_ATEST'
,p_display_order=>620
,p_column_identifier=>'AS'
,p_column_label=>'Dias Faltas Atest'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798512869958207)
,p_db_column_name=>'DIAS_ATEST'
,p_display_order=>630
,p_column_identifier=>'AT'
,p_column_label=>'Dias Atest'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798604456958208)
,p_db_column_name=>'DIAS_FERIAS'
,p_display_order=>640
,p_column_identifier=>'AU'
,p_column_label=>'Dias Ferias'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798853631958210)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>660
,p_column_identifier=>'AV'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108798954611958211)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>670
,p_column_identifier=>'AW'
,p_column_label=>unistr('C\00F3d. C.Custo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799078587958212)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>680
,p_column_identifier=>'AX'
,p_column_label=>'Nome C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799137088958213)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>690
,p_column_identifier=>'AY'
,p_column_label=>'Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799264909958214)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>700
,p_column_identifier=>'AZ'
,p_column_label=>'Descr. Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799375689958215)
,p_db_column_name=>'CPF'
,p_display_order=>710
,p_column_identifier=>'BA'
,p_column_label=>'CPF'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799519429958217)
,p_db_column_name=>'NOME'
,p_display_order=>730
,p_column_identifier=>'BB'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799604581958218)
,p_db_column_name=>'MES_ADMISSAO'
,p_display_order=>740
,p_column_identifier=>'BC'
,p_column_label=>unistr('M\00EAs de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799766430958219)
,p_db_column_name=>'ANO_ADMISSAO'
,p_display_order=>750
,p_column_identifier=>'BD'
,p_column_label=>unistr('Ano de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799874343958220)
,p_db_column_name=>'SITUACAO'
,p_display_order=>760
,p_column_identifier=>'BE'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108799941005958221)
,p_db_column_name=>'NOME_SITUACAO'
,p_display_order=>770
,p_column_identifier=>'BF'
,p_column_label=>unistr('Descr. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800003371958222)
,p_db_column_name=>'MES_SITUACAO'
,p_display_order=>780
,p_column_identifier=>'BG'
,p_column_label=>unistr('M\00EAs da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800155266958223)
,p_db_column_name=>'ANO_SITUACAO'
,p_display_order=>790
,p_column_identifier=>'BH'
,p_column_label=>unistr('Ano da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800230096958224)
,p_db_column_name=>'MOT_ALT_SITUACAO'
,p_display_order=>800
,p_column_identifier=>'BI'
,p_column_label=>unistr('Mot. Alt. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800333660958225)
,p_db_column_name=>'DESC_MOTIVO_SITUACAO'
,p_display_order=>810
,p_column_identifier=>'BJ'
,p_column_label=>unistr('Descr. Motivo de Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800445086958226)
,p_db_column_name=>'VINCULO'
,p_display_order=>820
,p_column_identifier=>'BK'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800525323958227)
,p_db_column_name=>'NOME_VINCULO'
,p_display_order=>830
,p_column_identifier=>'BL'
,p_column_label=>unistr('Descr. V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800636400958228)
,p_db_column_name=>'VAGA'
,p_display_order=>840
,p_column_identifier=>'BM'
,p_column_label=>'Vaga'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800779647958229)
,p_db_column_name=>'CARGO'
,p_display_order=>850
,p_column_identifier=>'BN'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800858126958230)
,p_db_column_name=>'NOME_CARGOS'
,p_display_order=>860
,p_column_identifier=>'BO'
,p_column_label=>'Nome do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108800929837958231)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>870
,p_column_identifier=>'BP'
,p_column_label=>'Classif. do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801068573958232)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>880
,p_column_identifier=>'BQ'
,p_column_label=>'Descr. Classif. Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801239312958234)
,p_db_column_name=>'MATRICULA'
,p_display_order=>900
,p_column_identifier=>'BS'
,p_column_label=>'Matricula'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801329164958235)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>910
,p_column_identifier=>'BT'
,p_column_label=>'Unidade Adm'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801443223958236)
,p_db_column_name=>'IDADE'
,p_display_order=>920
,p_column_identifier=>'BU'
,p_column_label=>'Idade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801559084958237)
,p_db_column_name=>'TEMPO_CASA'
,p_display_order=>930
,p_column_identifier=>'BV'
,p_column_label=>'Tempo Casa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801732711958239)
,p_db_column_name=>'TELEFONE'
,p_display_order=>950
,p_column_identifier=>'BX'
,p_column_label=>'Telefone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801896379958240)
,p_db_column_name=>'TELEFONE_CELULAR'
,p_display_order=>960
,p_column_identifier=>'BY'
,p_column_label=>'Telefone Celular'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108801967782958241)
,p_db_column_name=>'NUM_PIS_PASEP'
,p_display_order=>970
,p_column_identifier=>'BZ'
,p_column_label=>'Num Pis Pasep'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108802034848958242)
,p_db_column_name=>'NUM_CART_PROF'
,p_display_order=>980
,p_column_identifier=>'CA'
,p_column_label=>'Num Cart Prof'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108808391906229893)
,p_db_column_name=>'DATA_CASAMENTO'
,p_display_order=>990
,p_column_identifier=>'CB'
,p_column_label=>'Data Casamento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108808627187229896)
,p_db_column_name=>'DT_INICIO'
,p_display_order=>1020
,p_column_identifier=>'CE'
,p_column_label=>'Dt Inicio'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108808771158229897)
,p_db_column_name=>'DT_FIM'
,p_display_order=>1030
,p_column_identifier=>'CF'
,p_column_label=>'Dt Fim'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108808947740229899)
,p_db_column_name=>'DIAS_COMPRA'
,p_display_order=>1050
,p_column_identifier=>'CH'
,p_column_label=>'Dias Compra'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108809203636229902)
,p_db_column_name=>'NR_CARTAO'
,p_display_order=>1080
,p_column_identifier=>'CK'
,p_column_label=>'Nr Cartao'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108809391869229903)
,p_db_column_name=>'VL_BENEFICIO'
,p_display_order=>1090
,p_column_identifier=>'CL'
,p_column_label=>'Vl Beneficio'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(114108809468491229904)
,p_db_column_name=>'DIAS_AFASTAMENTO'
,p_display_order=>1100
,p_column_identifier=>'CM'
,p_column_label=>'Dias Afastamento'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(110942374273316485572)
,p_db_column_name=>'COD_BENEFICIO'
,p_display_order=>1110
,p_column_identifier=>'CP'
,p_column_label=>'Cod Beneficio'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(110942374366261485573)
,p_db_column_name=>'SALDO_EXCEDENTE'
,p_display_order=>1120
,p_column_identifier=>'CQ'
,p_column_label=>'Saldo Excedente'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(110942374488350485574)
,p_db_column_name=>'VALOR_COMPRA'
,p_display_order=>1130
,p_column_identifier=>'CR'
,p_column_label=>'Valor Compra'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(110942374532791485575)
,p_db_column_name=>'DATA_REFERENCIA'
,p_display_order=>1140
,p_column_identifier=>'CS'
,p_column_label=>'Data Referencia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(110942374674699485576)
,p_db_column_name=>'CEP'
,p_display_order=>1150
,p_column_identifier=>'CT'
,p_column_label=>'Cep'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104075637904790881452)
,p_db_column_name=>'IND_SUSPENSO'
,p_display_order=>1160
,p_column_identifier=>'CU'
,p_column_label=>'Ind Suspenso'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104075637958648881453)
,p_db_column_name=>'VALOR_MINIMO'
,p_display_order=>1170
,p_column_identifier=>'CV'
,p_column_label=>unistr('Valor M\00EDnimo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104075638122517881454)
,p_db_column_name=>'VALOR_MAXIMO'
,p_display_order=>1180
,p_column_identifier=>'CW'
,p_column_label=>unistr('Valor M\00E1ximo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104075638194240881455)
,p_db_column_name=>'VALOR_UNITARIO'
,p_display_order=>1190
,p_column_identifier=>'CX'
,p_column_label=>unistr('Valor Unit\00E1rio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(94441765702554659796)
,p_db_column_name=>'DT_NASC'
,p_display_order=>1200
,p_column_identifier=>'CY'
,p_column_label=>'Data Nascimento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(94441765803666659797)
,p_db_column_name=>'COD_CCUSTO_CONT'
,p_display_order=>1210
,p_column_identifier=>'CZ'
,p_column_label=>unistr('C\00F3digo Centro Custo Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(94441765852215659798)
,p_db_column_name=>'DESC_CCUSTO_CONT'
,p_display_order=>1220
,p_column_identifier=>'DA'
,p_column_label=>unistr('Descri\00E7\00E3o Centro Custo Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(88431270268916725656)
,p_db_column_name=>'QTDADE_DIARIA'
,p_display_order=>1230
,p_column_identifier=>'DB'
,p_column_label=>'Qtdade Diaria'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(114108841944260246053)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'319994'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INDICE:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:UNIDADE_ADM:DESC_UNID_ADM:COD_ATIVIDADE:DESC_ATIVIDADE:CLASS_CCUSTO:DESC_CLASS_CCUSTO:CPF:MATRICULA:NOME:MES_ADMISSAO:ANO_ADMISSAO:SITUACAO:NOME_SITUACAO:MES_SITUACAO:ANO_SITUA'
||'CAO:MOT_ALT_SITUACAO:DESC_MOTIVO_SITUACAO:VINCULO:NOME_VINCULO:VAGA:CARGO:NOME_CARGOS:CLASS_CARGO:DESC_CLASS_CARGO:FUNCAO:NOME_FUNCAO:COD_LOCALIZACAO:DESC_LOCAL:MES_NASC:ANO_NASC:IDADE:SEXO:ESTADO_CIVIL:DESC_EST_CIVIL:INSTRUCAO:DESC_INSTR:FORMACAO_ES'
||'COLAR:NOME_FORMACAO:FAIXA_SALARIO:FAIXA_IDADE:FX_TEMPO_CASA:TEMPO_CASA:COD_BENEFICIO:DESCRICAO_FAMILIA:TIPO:DESCRICAO_TIPO:VL_BENEFICIO:VALOR_PARTE_EMPRESA:CUSTO_UNITARIO:DIAS_COMPRA:DIAS_COMPLETOS:SALDO_EXCEDENTE:DIAS_EXCEDENTES:DIAS_FALTAS:DIAS_FAL'
||'TAS_ATEST:DIAS_ATEST:DIAS_FERIAS:DIAS_AFASTAMENTO:VALOR_COMPRA:DATA_CASAMENTO:DT_INICIO:DT_FIM:DATA_REFERENCIA:NR_CARTAO:ENDERECO:NOME_LOGR:BAIRRO:CIDADE:UF:COMPLEM:CEP:TELEFONE:DDD_CELL:TELEFONE_CELULAR:E_MAIL:NUM_REGISTRO:NUM_PIS_PASEP:NUM_CART_PRO'
||'F:NOME_MAE::IND_SUSPENSO:VALOR_MINIMO:VALOR_MAXIMO:VALOR_UNITARIO:DT_NASC:COD_CCUSTO_CONT:DESC_CCUSTO_CONT'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(260963960030635451149)
,p_plug_name=>unistr('Benef\00EDcios - Dependentes')
,p_region_name=>'IR_4'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'       i.COD_EMPRESA,',
'       i.NOME_EMPRESA,',
'       i.FILIAL,',
'       i.NOME_FILIAL,',
'       i.COD_CCUSTO,',
'       i.NOME_CCUSTO,',
'       i.CLASS_CCUSTO,',
'       i.DESC_CLASS_CCUSTO,',
'       case when pp.cpf = ''S'' then SUBSTR(LPAD(i.CPF,11,0),1,3)||''.''||',
'    SUBSTR(LPAD(i.CPF,11,0),4,3)||''.''||',
'    SUBSTR(LPAD(i.CPF,11,0),7,3)||''-''||',
'    SUBSTR(LPAD(i.CPF,11,0),10,2) end CPF,',
'       i.MATRICULA,',
'       case when pp.nome = ''S'' then i.NOME end NOME,',
'       i.MES_ADMISSAO,',
'       i.ANO_ADMISSAO,',
'       i.SITUACAO,',
'       case when pf.situacao = ''S'' then i.NOME_SITUACAO end NOME_SITUACAO,',
'       i.MES_SITUACAO,',
'       i.ANO_SITUACAO,',
'       i.MOT_ALT_SITUACAO,',
'       i.DESC_MOTIVO_SITUACAO,',
'       i.VINCULO,',
'       case when pf.vinculo = ''S'' then i.NOME_VINCULO end NOME_VINCULO,',
'       i.VAGA,',
'       i.CARGO,',
'       case when pf.cargo = ''S'' then i.NOME_CARGOS end NOME_CARGOS,',
'       i.CLASS_CARGO,',
'       i.DESC_CLASS_CARGO,',
'       i.FUNCAO,',
'       case when pf.cargo = ''S'' then i.NOME_FUNCAO end NOME_FUNCAO,',
'       i.COD_LOCALIZACAO,',
'       case when pf.local_trab = ''S'' then i.DESC_LOCAL end DESC_LOCAL,',
'       i.UNIDADE_ADM,',
'       i.DESC_UNID_ADM,',
'       case when pp.dt_nasc = ''S'' then i.MES_NASC end MES_NASC,',
'       case when pp.dt_nasc = ''S'' then i.ANO_NASC end ANO_NASC,',
'       case when pp.dt_nasc = ''S'' then i.IDADE end IDADE,',
'       case when pp.sexo = ''S'' then i.SEXO end SEXO,',
'       i.ESTADO_CIVIL,',
'       case when pp.estado_civil = ''S'' then i.DESC_EST_CIVIL end DESC_EST_CIVIL,',
'       i.INSTRUCAO,',
'       case when pp.grau_instrucao = ''S'' then i.DESC_INSTR end DESC_INSTR,',
'       i.FORMACAO_ESCOLAR,',
'       case when pp.formacao = ''S'' then i.NOME_FORMACAO end NOME_FORMACAO,',
'       case when pf.salario = ''S'' then i.FAIXA_SALARIO end FAIXA_SALARIO,',
'       case when pp.dt_nasc = ''S'' then i.FAIXA_IDADE end FAIXA_IDADE,',
'       i.FX_TEMPO_CASA,',
'       i.TEMPO_CASA,',
'       i.num_depend,',
'       case when pd.nome = ''S'' then i.nome_depend end nome_depend,',
'       i.dt_dependente,',
'       case when pd.conjuge_cpf = ''S'' and i.num_cpf_conjuge is not null then ',
'      SUBSTR(LPAD(i.num_cpf_conjuge ,11,0),1,3)||''.''||',
'          SUBSTR(LPAD(i.num_cpf_conjuge ,11,0),4,3)||''.''||',
'          SUBSTR(LPAD(i.num_cpf_conjuge ,11,0),7,3)||''-''||',
'          SUBSTR(LPAD(i.num_cpf_conjuge ,11,0),10,2)',
'       end num_cpf_conjuge,',
'       case when pd.grau_parent = ''S'' then i.grau_parentesco end grau_parentesco,',
'       case when pd.condicao = ''S'' then i.condicao_depend end condicao_depend,',
'       case when pd.agregado = ''S'' then i.ind_agregado end ind_agregado,',
'       case when pd.ir = ''S'' then i.incid_ir end incid_ir,',
'       i.data_baixa,',
'       case when pd.sal_fam = ''S'' then i.incid_sf end incid_sf,',
'       case when pd.local_nasc = ''S'' then i.est_nasc end est_nasc,',
'       case when pd.dt_nasc = ''S'' then i.dt_nasc end dt_nasc,',
'       case when pd.local_nasc = ''S'' then i.cidade_nasc end cidade_nasc,',
'       case when pd.cart_vac = ''S'' then i.cart_vacin end cart_vacin,',
'       case when pd.sexo = ''S'' then i.sexo_depend end sexo_depend,',
'       i.incid_aux_creche,',
'       case when pd.mae = ''S'' then i.mae_depend end mae_depend,',
'       case when pd.mae_cpf = ''S'' then i.cpf_mae_depend end cpf_mae_depend,',
'       case when pd.mae_cpf = ''S'' then i.dc_cpf_mae_depend end dc_cpf_mae_depend,',
'       replace(i.INDICE,''_'','' '') indice,',
'       case when pf.beneficio = ''S'' then i.CODIGO end CODIGO,',
'       case when pf.beneficio = ''S'' then i.DESCRICAO end DESCRICAO_FAMILIA,',
'       case when pf.beneficio = ''S'' then i.CODIGO_TIPO end TIPO,',
'       case when pf.beneficio = ''S'' then i.TIPO end DESCRICAO_TIPO,',
'       i.DT_INICIO,',
'       i.DT_FIM,',
'       i.CD_NIVEL,',
'       cod_plano,',
'       cod_tipo,',
'       dt_adesao,',
'       dt_adesao_final,',
'       case when pf.beneficio_valor = ''S'' then i.VALOR_BENEFICIO end VALOR_BENEFICIO,',
'       case when pf.beneficio_valor = ''S'' then i.VLR_TOTAL end VLR_TOTAL,',
'       i.DATA_REF,',
'       i.COD_ATIVIDADE,',
'       FNCT_NOME_ATIVIDADE(i.COD_ATIVIDADE) DESC_ATIVIDADE,',
'       i.valor_parte_empresa,',
'       i.cod_ccusto_cont,',
'       i.desc_ccusto_cont,',
'       i.idade_dependente,',
'       i.faixa_idade_dependente',
'  from VW_BI_BENEFICIOS_DEPEND I, permissao_func pf, permissao_pess pp, permissao_depend pd',
'  where pf.id_usuario = pp.id_usuario',
'    and pf.id_usuario = pd.id_usuario',
'    and pf.id_usuario = usuario.busca_user',
'    and i.cod_empresa = nvl(:p164_emp,cod_empresa)',
'    and i.matricula = nvl(:p164_mat,matricula)',
'    and ((i.situacao < ''90'' and :p164_situacao_1 = ''A'') or (i.situacao >= ''90'' and :p164_situacao_1 = ''D'') or (:p164_situacao_1 = ''T''))',
'    and (:P164_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_EMPRESA, '','')) t))',
'    and (:P164_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_FILIAL, '','')) t))',
'    and (:P164_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_CCUSTO, '','')) t))',
'    and (:P164_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_UNIDADE_ADM, '','')) t))',
'    and (:P164_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_ATIVIDADE, '','')) t))',
'    and (:P164_MATRICULA_1 is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_MATRICULA_1, '','')) t))',
'    and (:P164_INDICE      is null or i.INDICE        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_INDICE, '','')) t))',
'    and F_Acesso(i.cod_empresa, i.matricula, i.filial, i.cd_nivel) = ''S''',
'  ORDER BY indice, COD_EMPRESA, FILIAL, COD_CCUSTO, MATRICULA, codigo, tipo, dt_inicio desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P164_EMP,P164_MAT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P164_OPCAO'
,p_plug_display_when_cond2=>'D'
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
 p_id=>wwv_flow_api.id(260963960168651451150)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>873828568637488542
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960242508451151)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('C\00F3d. Empresa')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960385493451152)
,p_db_column_name=>'FUNCAO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960473239451153)
,p_db_column_name=>'NOME_FUNCAO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Nome Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960577148451154)
,p_db_column_name=>'COD_LOCALIZACAO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('C\00F3d. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960679754451155)
,p_db_column_name=>'DESC_LOCAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Descr. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960744765451156)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960888050451157)
,p_db_column_name=>'DESC_UNID_ADM'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Descr. Unid. Adm. (Cliente)'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260963960953352451158)
,p_db_column_name=>'MES_NASC'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('M\00EAs do Nascimento')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978363913484345309)
,p_db_column_name=>'ANO_NASC'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Ano do Nascimento'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364017754345310)
,p_db_column_name=>'IDADE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364101332345311)
,p_db_column_name=>'SEXO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364232601345312)
,p_db_column_name=>'ESTADO_CIVIL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364330794345313)
,p_db_column_name=>'DESC_EST_CIVIL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Descr. Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364477295345314)
,p_db_column_name=>'INSTRUCAO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364506841345315)
,p_db_column_name=>'DESC_INSTR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('Descr. Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364667959345316)
,p_db_column_name=>'FORMACAO_ESCOLAR'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('Forma\00E7\00E3o Escolar')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364776316345317)
,p_db_column_name=>'NOME_FORMACAO'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>unistr('Descr. Forma\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364896722345318)
,p_db_column_name=>'FAIXA_SALARIO'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Faixa de Sal\00E1rio')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978364989090345319)
,p_db_column_name=>'FAIXA_IDADE'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Faixa de Idade'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365084982345320)
,p_db_column_name=>'FX_TEMPO_CASA'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Faixa de Tempo de Casa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365176731345321)
,p_db_column_name=>'TEMPO_CASA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tempo de Casa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365247747345322)
,p_db_column_name=>'CODIGO'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>unistr('C\00F3digo Benef\00EDcio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365300388345323)
,p_db_column_name=>'DESCRICAO_FAMILIA'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>unistr('Descri\00E7\00E3o Fam\00EDlia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365431740345324)
,p_db_column_name=>'TIPO'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365555619345325)
,p_db_column_name=>'DESCRICAO_TIPO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Descr. Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365647968345326)
,p_db_column_name=>'DT_INICIO'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Data In\00EDcio')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365705940345327)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365898891345328)
,p_db_column_name=>'DT_FIM'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Data Fim'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978365994836345329)
,p_db_column_name=>'INDICE'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>unistr('\00CDndice')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366039865345330)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>'Cd nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366102927345331)
,p_db_column_name=>'VALOR_BENEFICIO'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>unistr('Valor de Benef\00EDcio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366250202345332)
,p_db_column_name=>'VLR_TOTAL'
,p_display_order=>320
,p_column_identifier=>'AF'
,p_column_label=>'Valor de Compra'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366316087345333)
,p_db_column_name=>'DATA_REF'
,p_display_order=>330
,p_column_identifier=>'AG'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366475615345334)
,p_db_column_name=>'COD_ATIVIDADE'
,p_display_order=>340
,p_column_identifier=>'AH'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366501896345335)
,p_db_column_name=>'DESC_ATIVIDADE'
,p_display_order=>350
,p_column_identifier=>'AI'
,p_column_label=>unistr('Desc. Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366691403345336)
,p_db_column_name=>'FILIAL'
,p_display_order=>360
,p_column_identifier=>'AJ'
,p_column_label=>unistr('C\00F3d. Filial')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366746568345337)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>370
,p_column_identifier=>'AK'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366882827345338)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>unistr('C\00F3d. C.Custo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978366909416345339)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>390
,p_column_identifier=>'AM'
,p_column_label=>'Nome C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367096611345340)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>400
,p_column_identifier=>'AN'
,p_column_label=>'Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367149731345341)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>410
,p_column_identifier=>'AO'
,p_column_label=>'Descr. Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367289979345342)
,p_db_column_name=>'CPF'
,p_display_order=>420
,p_column_identifier=>'AP'
,p_column_label=>'CPF'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367310331345343)
,p_db_column_name=>'MATRICULA'
,p_display_order=>430
,p_column_identifier=>'AQ'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367405686345344)
,p_db_column_name=>'NOME'
,p_display_order=>440
,p_column_identifier=>'AR'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367577548345345)
,p_db_column_name=>'MES_ADMISSAO'
,p_display_order=>450
,p_column_identifier=>'AS'
,p_column_label=>unistr('M\00EAs de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367697700345346)
,p_db_column_name=>'ANO_ADMISSAO'
,p_display_order=>460
,p_column_identifier=>'AT'
,p_column_label=>unistr('Ano de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367762436345347)
,p_db_column_name=>'SITUACAO'
,p_display_order=>470
,p_column_identifier=>'AU'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367845301345348)
,p_db_column_name=>'NOME_SITUACAO'
,p_display_order=>480
,p_column_identifier=>'AV'
,p_column_label=>unistr('Descr. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978367976531345349)
,p_db_column_name=>'MES_SITUACAO'
,p_display_order=>490
,p_column_identifier=>'AW'
,p_column_label=>unistr('M\00EAs da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368097844345350)
,p_db_column_name=>'ANO_SITUACAO'
,p_display_order=>500
,p_column_identifier=>'AX'
,p_column_label=>unistr('Ano da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368106687345351)
,p_db_column_name=>'MOT_ALT_SITUACAO'
,p_display_order=>510
,p_column_identifier=>'AY'
,p_column_label=>unistr('Mot. Alt. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368243449345352)
,p_db_column_name=>'DESC_MOTIVO_SITUACAO'
,p_display_order=>520
,p_column_identifier=>'AZ'
,p_column_label=>unistr('Descr. Motivo de Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368381507345353)
,p_db_column_name=>'VINCULO'
,p_display_order=>530
,p_column_identifier=>'BA'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368468272345354)
,p_db_column_name=>'NOME_VINCULO'
,p_display_order=>540
,p_column_identifier=>'BB'
,p_column_label=>unistr('Descr. V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368525913345355)
,p_db_column_name=>'VAGA'
,p_display_order=>550
,p_column_identifier=>'BC'
,p_column_label=>'Vaga'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368601108345356)
,p_db_column_name=>'CARGO'
,p_display_order=>560
,p_column_identifier=>'BD'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368717936345357)
,p_db_column_name=>'NOME_CARGOS'
,p_display_order=>570
,p_column_identifier=>'BE'
,p_column_label=>'Nome do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368881535345358)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>580
,p_column_identifier=>'BF'
,p_column_label=>'Classif. do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978368902559345309)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>590
,p_column_identifier=>'BG'
,p_column_label=>'Descr. Classif. Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369035409345310)
,p_db_column_name=>'NUM_DEPEND'
,p_display_order=>600
,p_column_identifier=>'BH'
,p_column_label=>unistr('N\00BA Dependente')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369129972345311)
,p_db_column_name=>'NOME_DEPEND'
,p_display_order=>610
,p_column_identifier=>'BI'
,p_column_label=>'Nome Dependente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369243341345312)
,p_db_column_name=>'DT_DEPENDENTE'
,p_display_order=>620
,p_column_identifier=>'BJ'
,p_column_label=>'Data do Dependente'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369428292345314)
,p_db_column_name=>'GRAU_PARENTESCO'
,p_display_order=>640
,p_column_identifier=>'BL'
,p_column_label=>'Grau de Parentesco'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369550915345315)
,p_db_column_name=>'CONDICAO_DEPEND'
,p_display_order=>650
,p_column_identifier=>'BM'
,p_column_label=>unistr('Condi\00E7\00E3o Dependente')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369666297345316)
,p_db_column_name=>'IND_AGREGADO'
,p_display_order=>660
,p_column_identifier=>'BN'
,p_column_label=>'Ind. Agregado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369724920345317)
,p_db_column_name=>'INCID_IR'
,p_display_order=>670
,p_column_identifier=>'BO'
,p_column_label=>'Incid. IR'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369819967345318)
,p_db_column_name=>'DATA_BAIXA'
,p_display_order=>680
,p_column_identifier=>'BP'
,p_column_label=>'Data Baixa'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978369996843345319)
,p_db_column_name=>'INCID_SF'
,p_display_order=>690
,p_column_identifier=>'BQ'
,p_column_label=>'Incid. Sal. Fam.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370097662345320)
,p_db_column_name=>'EST_NASC'
,p_display_order=>700
,p_column_identifier=>'BR'
,p_column_label=>'UF Nascimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370165339345321)
,p_db_column_name=>'DT_NASC'
,p_display_order=>710
,p_column_identifier=>'BS'
,p_column_label=>'Data de Nascimento Dependente'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370263846345322)
,p_db_column_name=>'CIDADE_NASC'
,p_display_order=>720
,p_column_identifier=>'BT'
,p_column_label=>'Cidade de Nascimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370318820345323)
,p_db_column_name=>'CART_VACIN'
,p_display_order=>730
,p_column_identifier=>'BU'
,p_column_label=>unistr('Carteira de Vacina\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370434845345324)
,p_db_column_name=>'SEXO_DEPEND'
,p_display_order=>740
,p_column_identifier=>'BV'
,p_column_label=>'Sexo do Dependente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370588718345325)
,p_db_column_name=>'INCID_AUX_CRECHE'
,p_display_order=>750
,p_column_identifier=>'BW'
,p_column_label=>'Incid. Aux. Creche'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370678209345326)
,p_db_column_name=>'MAE_DEPEND'
,p_display_order=>760
,p_column_identifier=>'BX'
,p_column_label=>unistr('M\00E3e Dependente')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370701599345327)
,p_db_column_name=>'CPF_MAE_DEPEND'
,p_display_order=>770
,p_column_identifier=>'BY'
,p_column_label=>unistr('CPF M\00E3e Dependente')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370851389345328)
,p_db_column_name=>'DC_CPF_MAE_DEPEND'
,p_display_order=>780
,p_column_identifier=>'BZ'
,p_column_label=>unistr('DC CPF M\00E3e Dependente')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978370990934345329)
,p_db_column_name=>'COD_PLANO'
,p_display_order=>790
,p_column_identifier=>'CA'
,p_column_label=>unistr('C\00F3d. Plano')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978371087333345330)
,p_db_column_name=>'COD_TIPO'
,p_display_order=>800
,p_column_identifier=>'CB'
,p_column_label=>unistr('C\00F3d. Tipo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978371162426345331)
,p_db_column_name=>'DT_ADESAO'
,p_display_order=>810
,p_column_identifier=>'CC'
,p_column_label=>unistr('Data de Ades\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978371220532345332)
,p_db_column_name=>'DT_ADESAO_FINAL'
,p_display_order=>820
,p_column_identifier=>'CD'
,p_column_label=>unistr('Data de Ades\00E3o Final')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261080036251504288258)
,p_db_column_name=>'NUM_CPF_CONJUGE'
,p_display_order=>830
,p_column_identifier=>'CE'
,p_column_label=>unistr('N\00BA CPF Dependente')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150486718437296035866)
,p_db_column_name=>'VALOR_PARTE_EMPRESA'
,p_display_order=>840
,p_column_identifier=>'CF'
,p_column_label=>'Valor Parte Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(91802979805558622039)
,p_db_column_name=>'COD_CCUSTO_CONT'
,p_display_order=>850
,p_column_identifier=>'CG'
,p_column_label=>unistr('C\00F3digo Centro Custo Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(92260003071838011490)
,p_db_column_name=>'DESC_CCUSTO_CONT'
,p_display_order=>860
,p_column_identifier=>'CH'
,p_column_label=>unistr('Descri\00E7\00E3o Centro Custo Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(92260003239259011491)
,p_db_column_name=>'IDADE_DEPENDENTE'
,p_display_order=>870
,p_column_identifier=>'CI'
,p_column_label=>'Idade do Dependente'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(92260003269851011492)
,p_db_column_name=>'FAIXA_IDADE_DEPENDENTE'
,p_display_order=>880
,p_column_identifier=>'CJ'
,p_column_label=>'Faixa de Idade do Dependente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(260978399700033417406)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'8882682'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'INDICE:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:UNIDADE_ADM:DESC_UNID_ADM:COD_ATIVIDADE:DESC_ATIVIDADE:CLASS_CCUSTO:DESC_CLASS_CCUSTO:CPF:MATRICULA:NOME:MES_ADMISSAO:ANO_ADMISSAO:SITUACAO:NOME_SITUACAO:MES_SITUACAO:ANO_SITUA'
||'CAO:MOT_ALT_SITUACAO:DESC_MOTIVO_SITUACAO:VINCULO:NOME_VINCULO:VAGA:CARGO:NOME_CARGOS:CLASS_CARGO:DESC_CLASS_CARGO:FUNCAO:NOME_FUNCAO:COD_LOCALIZACAO:DESC_LOCAL:MES_NASC:ANO_NASC:IDADE:SEXO:ESTADO_CIVIL:DESC_EST_CIVIL:INSTRUCAO:DESC_INSTR:FORMACAO_ES'
||'COLAR:NOME_FORMACAO:FAIXA_SALARIO:FAIXA_IDADE:FX_TEMPO_CASA:TEMPO_CASA:NUM_DEPEND:NOME_DEPEND:GRAU_PARENTESCO:DT_NASC:NUM_CPF_CONJUGE:DT_DEPENDENTE:CONDICAO_DEPEND:IND_AGREGADO:INCID_IR:DATA_BAIXA:INCID_SF:CIDADE_NASC:EST_NASC:CART_VACIN:SEXO_DEPEND:'
||'INCID_AUX_CRECHE:MAE_DEPEND:CPF_MAE_DEPEND:DC_CPF_MAE_DEPEND:CODIGO:DESCRICAO_FAMILIA:TIPO:DESCRICAO_TIPO:COD_PLANO:COD_TIPO:DT_ADESAO:DT_ADESAO_FINAL:VALOR_BENEFICIO:VLR_TOTAL:VALOR_PARTE_EMPRESA:DT_INICIO:DT_FIM:DATA_REF::COD_CCUSTO_CONT:DESC_CCUST'
||'O_CONT:IDADE_DEPENDENTE:FAIXA_IDADE_DEPENDENTE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(267665677691874219862)
,p_plug_name=>unistr('Benef\00EDcios - Anterior')
,p_region_name=>'IR_3'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'       i.COD_EMPRESA,',
'       i.NOME_EMPRESA,',
'       i.FILIAL,',
'       i.NOME_FILIAL,',
'       i.COD_CCUSTO,',
'       i.NOME_CCUSTO,',
'       i.CLASS_CCUSTO,',
'       i.DESC_CLASS_CCUSTO,',
'       SUBSTR(LPAD(i.CPF,11,0),1,3)||''.''||',
'    SUBSTR(LPAD(i.CPF,11,0),4,3)||''.''||',
'    SUBSTR(LPAD(i.CPF,11,0),7,3)||''-''||',
'    SUBSTR(LPAD(i.CPF,11,0),10,2) CPF,',
'       i.MATRICULA,',
'       i.NOME,',
'       i.MES_ADMISSAO,',
'       i.ANO_ADMISSAO,',
'       i.SITUACAO,',
'       i.NOME_SITUACAO,',
'       i.MES_SITUACAO,',
'       i.ANO_SITUACAO,',
'       i.MOT_ALT_SITUACAO,',
'       i.DESC_MOTIVO_SITUACAO,',
'       i.VINCULO,',
'       i.NOME_VINCULO,',
'       i.VAGA,',
'       i.CARGO,',
'       i.NOME_CARGOS,',
'       i.CLASS_CARGO,',
'       i.DESC_CLASS_CARGO,',
'       i.FUNCAO,',
'       i.NOME_FUNCAO,',
'       i.COD_LOCALIZACAO,',
'       i.DESC_LOCAL,',
'       i.UNIDADE_ADM,',
'       i.DESC_UNID_ADM,',
'       i.MES_NASC,',
'       i.ANO_NASC,',
'       i.IDADE,',
'       i.SEXO,',
'       i.ESTADO_CIVIL,',
'       i.DESC_EST_CIVIL,',
'       i.INSTRUCAO,',
'       i.DESC_INSTR,',
'       i.FORMACAO_ESCOLAR,',
'       i.NOME_FORMACAO,',
'       i.FAIXA_SALARIO,',
'       i.FAIXA_IDADE,',
'       i.FX_TEMPO_CASA,',
'       i.TEMPO_CASA,',
'       replace(i.INDICE,''_'','' '') indice,',
'       i.CODIGO,',
'       i.DESCRICAO_FAMILIA,',
'       i.TIPO,',
'       i.DESCRICAO_TIPO,',
'       i.DT_INICIO,',
'       i.DT_FIM,',
'       i.CD_NIVEL,',
'       i.VALOR_BENEFICIO,',
'       i.VLR_TOTAL,',
'       i.DATA_REF,',
'       i.COD_ATIVIDADE,',
'       FNCT_NOME_ATIVIDADE(i.COD_ATIVIDADE) DESC_ATIVIDADE,',
'       Qtdade_diaria qtd_diaria,',
'       Custo_unitario,',
'       Dias_compra',
'  from VW_BI_BENEFICIOS_V0 I',
'  where i.cod_empresa = nvl(:p164_emp,cod_empresa)',
'    and i.matricula = nvl(:p164_mat,matricula)',
'    and ((i.situacao < ''90'' and :p164_situacao_1 = ''A'') or (i.situacao >= ''90'' and :p164_situacao_1 = ''D'') or (:p164_situacao_1 = ''T''))',
'    and (:P164_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_EMPRESA, '','')) t))',
'    and (:P164_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_FILIAL, '','')) t))',
'    and (:P164_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_CCUSTO, '','')) t))',
'    and (:P164_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_UNIDADE_ADM, '','')) t))',
'    and (:P164_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_ATIVIDADE, '','')) t))',
'    and (:P164_MATRICULA_1 is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_MATRICULA_1, '','')) t))',
'    and (:P164_INDICE      is null or i.INDICE        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_INDICE, '','')) t))',
'    and F_Acesso_PG_Apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel) = ''S''',
'  ORDER BY indice, COD_EMPRESA, FILIAL, COD_CCUSTO, MATRICULA, codigo, tipo, dt_inicio desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P164_EMP,P164_MAT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P164_OPCAO'
,p_plug_display_when_cond2=>'CX'
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
 p_id=>wwv_flow_api.id(267665677770364219863)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>1680605831480964422
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665677870259219864)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('C\00F3d. Empresa')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665677963272219865)
,p_db_column_name=>'FUNCAO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678067004219866)
,p_db_column_name=>'NOME_FUNCAO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Nome Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678218582219867)
,p_db_column_name=>'COD_LOCALIZACAO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('C\00F3d. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678258657219868)
,p_db_column_name=>'DESC_LOCAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Descr. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678345907219869)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678513413219870)
,p_db_column_name=>'DESC_UNID_ADM'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Descr. Unid. Adm. (Cliente)'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678575994219871)
,p_db_column_name=>'MES_NASC'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('M\00EAs do Nascimento')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678654144219872)
,p_db_column_name=>'ANO_NASC'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Ano do Nascimento'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678766816219873)
,p_db_column_name=>'IDADE'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678852540219874)
,p_db_column_name=>'SEXO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665678970774219875)
,p_db_column_name=>'ESTADO_CIVIL'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679047131219876)
,p_db_column_name=>'DESC_EST_CIVIL'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Descr. Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679193235219877)
,p_db_column_name=>'INSTRUCAO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679239871219878)
,p_db_column_name=>'DESC_INSTR'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('Descr. Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679367572219879)
,p_db_column_name=>'FORMACAO_ESCOLAR'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('Forma\00E7\00E3o Escolar')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679439177219880)
,p_db_column_name=>'NOME_FORMACAO'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>unistr('Descr. Forma\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679586491219881)
,p_db_column_name=>'FAIXA_SALARIO'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>unistr('Faixa de Sal\00E1rio')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679715855219882)
,p_db_column_name=>'FAIXA_IDADE'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Faixa de Idade'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679760404219883)
,p_db_column_name=>'FX_TEMPO_CASA'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Faixa de Tempo de Casa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665679867886219884)
,p_db_column_name=>'TEMPO_CASA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Tempo de Casa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680007705219885)
,p_db_column_name=>'CODIGO'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>unistr('C\00F3digo Benef\00EDcio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680071781219886)
,p_db_column_name=>'DESCRICAO_FAMILIA'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>unistr('Descri\00E7\00E3o Fam\00EDlia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680237397219887)
,p_db_column_name=>'TIPO'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680334119219888)
,p_db_column_name=>'DESCRICAO_TIPO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Descr. Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680400423219889)
,p_db_column_name=>'DT_INICIO'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Data In\00EDcio')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680468223219890)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267665680603677219891)
,p_db_column_name=>'DT_FIM'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Data Fim'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667001980685233142)
,p_db_column_name=>'INDICE'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>unistr('\00CDndice')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002071180233143)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>'Cd nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002149314233144)
,p_db_column_name=>'VALOR_BENEFICIO'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>unistr('Valor de Benef\00EDcio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002318233233145)
,p_db_column_name=>'VLR_TOTAL'
,p_display_order=>320
,p_column_identifier=>'AF'
,p_column_label=>'Valor de Compra'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002398775233146)
,p_db_column_name=>'DATA_REF'
,p_display_order=>330
,p_column_identifier=>'AG'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002534585233147)
,p_db_column_name=>'COD_ATIVIDADE'
,p_display_order=>340
,p_column_identifier=>'AH'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002636093233148)
,p_db_column_name=>'DESC_ATIVIDADE'
,p_display_order=>350
,p_column_identifier=>'AI'
,p_column_label=>unistr('Desc. Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002731812233149)
,p_db_column_name=>'FILIAL'
,p_display_order=>360
,p_column_identifier=>'AJ'
,p_column_label=>unistr('C\00F3d. Filial')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002834191233150)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>370
,p_column_identifier=>'AK'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002935093233151)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>unistr('C\00F3d. C.Custo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667002976047233152)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>390
,p_column_identifier=>'AM'
,p_column_label=>'Nome C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003133549233153)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>400
,p_column_identifier=>'AN'
,p_column_label=>'Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003183031233154)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>410
,p_column_identifier=>'AO'
,p_column_label=>'Descr. Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003268976233155)
,p_db_column_name=>'CPF'
,p_display_order=>420
,p_column_identifier=>'AP'
,p_column_label=>'CPF'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003361629233156)
,p_db_column_name=>'MATRICULA'
,p_display_order=>430
,p_column_identifier=>'AQ'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003529197233157)
,p_db_column_name=>'NOME'
,p_display_order=>440
,p_column_identifier=>'AR'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003595963233158)
,p_db_column_name=>'MES_ADMISSAO'
,p_display_order=>450
,p_column_identifier=>'AS'
,p_column_label=>unistr('M\00EAs de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003721348233159)
,p_db_column_name=>'ANO_ADMISSAO'
,p_display_order=>460
,p_column_identifier=>'AT'
,p_column_label=>unistr('Ano de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003776822233160)
,p_db_column_name=>'SITUACAO'
,p_display_order=>470
,p_column_identifier=>'AU'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667003928286233161)
,p_db_column_name=>'NOME_SITUACAO'
,p_display_order=>480
,p_column_identifier=>'AV'
,p_column_label=>unistr('Descr. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004010218233162)
,p_db_column_name=>'MES_SITUACAO'
,p_display_order=>490
,p_column_identifier=>'AW'
,p_column_label=>unistr('M\00EAs da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004053693233163)
,p_db_column_name=>'ANO_SITUACAO'
,p_display_order=>500
,p_column_identifier=>'AX'
,p_column_label=>unistr('Ano da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004143487233164)
,p_db_column_name=>'MOT_ALT_SITUACAO'
,p_display_order=>510
,p_column_identifier=>'AY'
,p_column_label=>unistr('Mot. Alt. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004266020233165)
,p_db_column_name=>'DESC_MOTIVO_SITUACAO'
,p_display_order=>520
,p_column_identifier=>'AZ'
,p_column_label=>unistr('Descr. Motivo de Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004405874233166)
,p_db_column_name=>'VINCULO'
,p_display_order=>530
,p_column_identifier=>'BA'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004521376233167)
,p_db_column_name=>'NOME_VINCULO'
,p_display_order=>540
,p_column_identifier=>'BB'
,p_column_label=>unistr('Descr. V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004626438233168)
,p_db_column_name=>'VAGA'
,p_display_order=>550
,p_column_identifier=>'BC'
,p_column_label=>'Vaga'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004671214233169)
,p_db_column_name=>'CARGO'
,p_display_order=>560
,p_column_identifier=>'BD'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004836152233170)
,p_db_column_name=>'NOME_CARGOS'
,p_display_order=>570
,p_column_identifier=>'BE'
,p_column_label=>'Nome do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667004888365233171)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>580
,p_column_identifier=>'BF'
,p_column_label=>'Classif. do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(267667005021954233172)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>590
,p_column_identifier=>'BG'
,p_column_label=>'Descr. Classif. Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261048834635157450209)
,p_db_column_name=>'QTD_DIARIA'
,p_display_order=>600
,p_column_identifier=>'BH'
,p_column_label=>'Qtd Diaria'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261048834714240450210)
,p_db_column_name=>'CUSTO_UNITARIO'
,p_display_order=>610
,p_column_identifier=>'BI'
,p_column_label=>'Custo Unitario'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261048834862536450211)
,p_db_column_name=>'DIAS_COMPRA'
,p_display_order=>620
,p_column_identifier=>'BJ'
,p_column_label=>'Dias Compra'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(267667025423414255971)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'16819535'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'INDICE:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:UNIDADE_ADM:DESC_UNID_ADM:COD_ATIVIDADE:DESC_ATIVIDADE:CLASS_CCUSTO:DESC_CLASS_CCUSTO:CPF:MATRICULA:NOME:MES_ADMISSAO:ANO_ADMISSAO:SITUACAO:NOME_SITUACAO:MES_SITUACAO:ANO_SITUA'
||'CAO:MOT_ALT_SITUACAO:DESC_MOTIVO_SITUACAO:VINCULO:NOME_VINCULO:VAGA:CARGO:NOME_CARGOS:CLASS_CARGO:DESC_CLASS_CARGO:FUNCAO:NOME_FUNCAO:COD_LOCALIZACAO:DESC_LOCAL:MES_NASC:ANO_NASC:IDADE:SEXO:ESTADO_CIVIL:DESC_EST_CIVIL:INSTRUCAO:DESC_INSTR:FORMACAO_ES'
||'COLAR:NOME_FORMACAO:FAIXA_SALARIO:FAIXA_IDADE:FX_TEMPO_CASA:TEMPO_CASA:CODIGO:DESCRICAO_FAMILIA:TIPO:DESCRICAO_TIPO:VALOR_BENEFICIO:VLR_TOTAL:QTD_DIARIA:CUSTO_UNITARIO:DIAS_COMPRA:DT_INICIO:DT_FIM:DATA_REF:'
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(275999657292013867664)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P164_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(271112852107280353542)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283741460634010892045)
,p_plug_name=>unistr('Benef\00EDcios')
,p_region_name=>'IR_2'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'       i.COD_EMPRESA,',
'       i.NOME_EMPRESA,',
'       i.FILIAL,',
'       i.NOME_FILIAL,',
'       i.COD_CCUSTO,',
'       i.NOME_CCUSTO,',
'       i.CLASS_CCUSTO,',
'       i.DESC_CLASS_CCUSTO,',
'       case when pp.cpf = ''S'' then SUBSTR(LPAD(i.CPF,11,0),1,3)||''.''|| -- pp.cpf = ''S''',
'    SUBSTR(LPAD(i.CPF,11,0),4,3)||''.''||',
'    SUBSTR(LPAD(i.CPF,11,0),7,3)||''-''||',
'    SUBSTR(LPAD(i.CPF,11,0),10,2) end CPF,',
'       i.MATRICULA,',
'       case when pp.nome = ''S'' then i.NOME end NOME, -- pp.nome = ''S''',
'       i.MES_ADMISSAO,',
'       i.ANO_ADMISSAO,',
'       i.SITUACAO,',
'       case when pf.situacao = ''S'' then i.NOME_SITUACAO end NOME_SITUACAO, --pf.situacao = ''S''',
'       i.MES_SITUACAO,',
'       i.ANO_SITUACAO,',
'       i.MOT_ALT_SITUACAO,',
'       i.DESC_MOTIVO_SITUACAO,',
'       i.VINCULO,',
'       case when pf.vinculo = ''S'' then i.NOME_VINCULO end NOME_VINCULO, -- pf.vinculo = ''S''',
'       i.VAGA,',
'       i.CARGO,',
'       case when pf.cargo = ''S'' then i.NOME_CARGOS end NOME_CARGOS, -- pf.cargo = ''S''',
'       i.CLASS_CARGO,',
'       i.DESC_CLASS_CARGO,',
'       i.FUNCAO,',
'       case when pf.cargo = ''S'' then i.NOME_FUNCAO end NOME_FUNCAO, --pf.cargo = ''S''',
'       i.COD_LOCALIZACAO,',
'       case when pf.local_trab = ''S'' then i.DESC_LOCAL end DESC_LOCAL, -- pf.local_trab = ''S''',
'       i.UNIDADE_ADM,',
'       i.DESC_UNID_ADM,',
'       case when pp.dt_nasc = ''S'' then i.MES_NASC end MES_NASC, -- pp.dt_nasc = ''S''',
'       case when pp.dt_nasc = ''S'' then i.ANO_NASC end ANO_NASC, -- pp.dt_nasc = ''S''',
'       case when pp.dt_nasc = ''S'' then i.IDADE end IDADE, -- pp.dt_nasc = ''S''',
'       case when pp.sexo = ''S'' then i.SEXO end SEXO, -- pp.sexo = ''S''',
'       i.ESTADO_CIVIL,',
'       case when pp.estado_civil = ''S'' then i.DESC_EST_CIVIL end DESC_EST_CIVIL, -- pp.estado_civil = ''S''',
'       i.INSTRUCAO,',
'       case when pp.grau_instrucao = ''S'' then i.DESC_INSTR end DESC_INSTR, -- pp.grau_instrucao = ''S''',
'       i.FORMACAO_ESCOLAR,',
'       case when pp.formacao = ''S'' then i.NOME_FORMACAO end NOME_FORMACAO, -- pp.formacao = ''S''',
'       i.FAIXA_SALARIO,',
'       i.FAIXA_IDADE,',
'       i.FX_TEMPO_CASA,',
'       i.TEMPO_CASA,',
'       replace(i.INDICE,''_'','' '') indice,',
'       case when pf.beneficio = ''S'' then i.CODIGO end CODIGO, -- pf.beneficio = ''S''',
'       case when pf.beneficio = ''S'' then i.DESCRICAO_FAMILIA end DESCRICAO_FAMILIA, -- pf.beneficio = ''S''',
'       case when pf.beneficio = ''S'' then i.TIPO end TIPO, -- pf.beneficio = ''S''',
'       case when pf.beneficio = ''S'' then i.DESCRICAO_TIPO end DESCRICAO_TIPO, -- pf.beneficio = ''S''',
'       i.DT_INICIO,',
'       i.DT_FIM,',
'       i.CD_NIVEL,',
'       case when pf.beneficio_valor = ''S'' then i.VALOR_BENEFICIO end VALOR_BENEFICIO, -- pf.beneficio_valor = ''S''',
'       case when pf.beneficio_valor = ''S'' then i.VLR_TOTAL end VLR_TOTAL, -- pf.beneficio_valor = ''S''',
'       i.DATA_REF,',
'       i.COD_ATIVIDADE,',
'       --FNCT_NOME_ATIVIDADE(i.COD_ATIVIDADE) DESC_ATIVIDADE,',
'       I.DESC_ATIVIDADE,',
'       Qtdade_diaria qtd_diaria,',
'       Custo_unitario,',
'       Dias_compra,',
'       i.nr_cartao,',
'       i.endereco,',
'       i.NOME_LOGR,',
'       i.complem,    ',
'       i.bairro,',
'       i.cidade,',
'       i.uf,',
'       i.complemento,',
'       i.telefone,',
'       i.ddd_cell,',
'       i.telefone_celular,',
'       i.e_mail,',
'       i.num_registro,',
'       i.num_pis_pasep,',
'       i.num_cart_prof,',
'       i.nome_mae,',
'       i.Data_Casamento,',
'       i.valor_parte_empresa,',
'       ',
'       i.DIAS_COMPLETOS,',
'       i.DIAS_SALDO_CARTAO,  ',
'       i.DIAS_EXCEDENTES,  ',
'       i.DIAS_FALTAS,  ',
'       i.DIAS_FALTAS_ATEST,              ',
'       i.DIAS_ATEST,  ',
'       i.DIAS_FERIAS,  ',
'       i.DIAS_AFAST',
'  from VW_BI_BENEFICIOS_V0 I, permissao_func pf, permissao_pess pp',
'  where pf.id_usuario = pp.id_usuario',
'    and pf.id_usuario = usuario.busca_user',
'    and ((:P164_PESQUISA is not null) and (',
'            ((:P164_INDICE_N is null or i.FLAG_INDICE in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_INDICE_N, '','')) t)) and (',
'     i.cod_empresa = nvl(:p164_emp,cod_empresa)',
'    and i.matricula = nvl(:p164_mat,matricula)',
'    and ((i.situacao < ''90'' and :p164_situacao_1 = ''A'') or (i.situacao >= ''90'' and :p164_situacao_1 = ''D'') or (:p164_situacao_1 = ''T''))',
'    and (:P164_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_EMPRESA, '','')) t))',
'    and (:P164_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_FILIAL, '','')) t))',
'    and (:P164_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_CCUSTO, '','')) t))',
'    and (:P164_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_UNIDADE_ADM, '','')) t))',
'    and (:P164_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_ATIVIDADE, '','')) t))',
'    and (:P164_MATRICULA_1 is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_MATRICULA_1, '','')) t))',
'    --and ',
'    and F_Acesso(i.cod_empresa, i.matricula, i.filial, i.cd_nivel) = ''S''',
'            ))))',
'  ORDER BY indice, COD_EMPRESA, FILIAL, COD_CCUSTO, MATRICULA, codigo, tipo, dt_inicio desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P164_EMP,P164_MAT,P164_INDICE_N,P164_INDICE,P164_PESQUISA,P164_MATRICULA_1,P164_ATIVIDADE,P164_UNIDADE_ADM,P164_CCUSTO,P164_FILIAL,P164_EMPRESA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_show_nulls_as=>' - '
,p_plug_display_condition_type=>'NEVER'
,p_pagination_display_position=>'BOTTOM_RIGHT'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(283741461018217892046)
,p_name=>unistr('Benef\00EDcios')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>45281525172202016
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741461104203892047)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>unistr('C\00F3d. Empresa')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741471575486892060)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741473095043892061)
,p_db_column_name=>'FILIAL'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>unistr('C\00F3d. Filial')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741473590331892062)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741473901092892062)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>unistr('C\00F3d. C.Custo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741474381560892063)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Nome C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741474694638892063)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741475145978892064)
,p_db_column_name=>'DESC_CLASS_CCUSTO'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Descr. Class. C.Custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741475542026892064)
,p_db_column_name=>'CPF'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'CPF'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741475972909892064)
,p_db_column_name=>'MATRICULA'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741476381606892065)
,p_db_column_name=>'NOME'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741476774330892065)
,p_db_column_name=>'MES_ADMISSAO'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>unistr('M\00EAs de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741477096198892066)
,p_db_column_name=>'ANO_ADMISSAO'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>unistr('Ano de Admiss\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741477524304892066)
,p_db_column_name=>'SITUACAO'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741477937544892066)
,p_db_column_name=>'NOME_SITUACAO'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>unistr('Descr. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741478328812892067)
,p_db_column_name=>'MES_SITUACAO'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>unistr('M\00EAs da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741478703433892067)
,p_db_column_name=>'ANO_SITUACAO'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>unistr('Ano da Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741479128231892067)
,p_db_column_name=>'MOT_ALT_SITUACAO'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>unistr('Mot. Alt. Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741479541674892068)
,p_db_column_name=>'DESC_MOTIVO_SITUACAO'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>unistr('Descr. Motivo de Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741479955796892068)
,p_db_column_name=>'VINCULO'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741480316759892068)
,p_db_column_name=>'NOME_VINCULO'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>unistr('Descr. V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741480694178892069)
,p_db_column_name=>'VAGA'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Vaga'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741481186243892069)
,p_db_column_name=>'CARGO'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741481554149892070)
,p_db_column_name=>'NOME_CARGOS'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>'Nome do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741481981999892071)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>25
,p_column_identifier=>'Y'
,p_column_label=>'Classif. do Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741482330577892071)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>26
,p_column_identifier=>'Z'
,p_column_label=>'Descr. Classif. Cargo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741461543754892048)
,p_db_column_name=>'FUNCAO'
,p_display_order=>27
,p_column_identifier=>'AA'
,p_column_label=>unistr('Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741461959127892048)
,p_db_column_name=>'NOME_FUNCAO'
,p_display_order=>28
,p_column_identifier=>'AB'
,p_column_label=>unistr('Nome Fun\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741462303065892049)
,p_db_column_name=>'COD_LOCALIZACAO'
,p_display_order=>29
,p_column_identifier=>'AC'
,p_column_label=>unistr('C\00F3d. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741462780596892049)
,p_db_column_name=>'DESC_LOCAL'
,p_display_order=>30
,p_column_identifier=>'AD'
,p_column_label=>unistr('Descr. Localiza\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741463112588892050)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>31
,p_column_identifier=>'AE'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741463588050892050)
,p_db_column_name=>'DESC_UNID_ADM'
,p_display_order=>32
,p_column_identifier=>'AF'
,p_column_label=>'Descr. Unid. Adm. (Cliente)'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741463960225892050)
,p_db_column_name=>'MES_NASC'
,p_display_order=>33
,p_column_identifier=>'AG'
,p_column_label=>unistr('M\00EAs do Nascimento')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741464356676892051)
,p_db_column_name=>'ANO_NASC'
,p_display_order=>34
,p_column_identifier=>'AH'
,p_column_label=>'Ano do Nascimento'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741464785852892051)
,p_db_column_name=>'IDADE'
,p_display_order=>35
,p_column_identifier=>'AI'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741465152983892052)
,p_db_column_name=>'SEXO'
,p_display_order=>36
,p_column_identifier=>'AJ'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741465586688892052)
,p_db_column_name=>'ESTADO_CIVIL'
,p_display_order=>37
,p_column_identifier=>'AK'
,p_column_label=>'Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741465898250892052)
,p_db_column_name=>'DESC_EST_CIVIL'
,p_display_order=>38
,p_column_identifier=>'AL'
,p_column_label=>'Descr. Estado Civil'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741466349184892054)
,p_db_column_name=>'INSTRUCAO'
,p_display_order=>39
,p_column_identifier=>'AM'
,p_column_label=>unistr('Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741466782371892054)
,p_db_column_name=>'DESC_INSTR'
,p_display_order=>40
,p_column_identifier=>'AN'
,p_column_label=>unistr('Descr. Instru\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741467161488892055)
,p_db_column_name=>'FORMACAO_ESCOLAR'
,p_display_order=>41
,p_column_identifier=>'AO'
,p_column_label=>unistr('Forma\00E7\00E3o Escolar')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741467559051892055)
,p_db_column_name=>'NOME_FORMACAO'
,p_display_order=>42
,p_column_identifier=>'AP'
,p_column_label=>unistr('Descr. Forma\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741467936571892056)
,p_db_column_name=>'FAIXA_SALARIO'
,p_display_order=>43
,p_column_identifier=>'AQ'
,p_column_label=>unistr('Faixa de Sal\00E1rio')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741468343657892056)
,p_db_column_name=>'FAIXA_IDADE'
,p_display_order=>44
,p_column_identifier=>'AR'
,p_column_label=>'Faixa de Idade'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741468761439892057)
,p_db_column_name=>'FX_TEMPO_CASA'
,p_display_order=>45
,p_column_identifier=>'AS'
,p_column_label=>'Faixa de Tempo de Casa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741469149348892057)
,p_db_column_name=>'TEMPO_CASA'
,p_display_order=>46
,p_column_identifier=>'AT'
,p_column_label=>'Tempo de Casa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P164_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741469555123892058)
,p_db_column_name=>'CODIGO'
,p_display_order=>48
,p_column_identifier=>'AV'
,p_column_label=>unistr('C\00F3digo Benef\00EDcio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741469901428892058)
,p_db_column_name=>'DESCRICAO_FAMILIA'
,p_display_order=>49
,p_column_identifier=>'AW'
,p_column_label=>unistr('Descri\00E7\00E3o Fam\00EDlia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741470308330892059)
,p_db_column_name=>'TIPO'
,p_display_order=>50
,p_column_identifier=>'AX'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741470743652892059)
,p_db_column_name=>'DESCRICAO_TIPO'
,p_display_order=>51
,p_column_identifier=>'AY'
,p_column_label=>'Descr. Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281265129414846185989)
,p_db_column_name=>'VALOR_BENEFICIO'
,p_display_order=>61
,p_column_identifier=>'BD'
,p_column_label=>unistr('Valor de Benef\00EDcio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741471146580892059)
,p_db_column_name=>'DT_INICIO'
,p_display_order=>71
,p_column_identifier=>'AZ'
,p_column_label=>unistr('Data In\00EDcio')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741471896842892060)
,p_db_column_name=>'DT_FIM'
,p_display_order=>81
,p_column_identifier=>'BA'
,p_column_label=>'Data Fim'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741472296426892061)
,p_db_column_name=>'INDICE'
,p_display_order=>91
,p_column_identifier=>'BB'
,p_column_label=>unistr('\00CDndice')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283741472722426892061)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>101
,p_column_identifier=>'BC'
,p_column_label=>'Cd nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271124980131256351453)
,p_db_column_name=>'VLR_TOTAL'
,p_display_order=>111
,p_column_identifier=>'BE'
,p_column_label=>'Valor de Compra'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271124980224034351454)
,p_db_column_name=>'DATA_REF'
,p_display_order=>121
,p_column_identifier=>'BF'
,p_column_label=>unistr('Data de Refer\00EAncia')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271061231569964831302)
,p_db_column_name=>'COD_ATIVIDADE'
,p_display_order=>131
,p_column_identifier=>'BG'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271061231696762831303)
,p_db_column_name=>'DESC_ATIVIDADE'
,p_display_order=>141
,p_column_identifier=>'BH'
,p_column_label=>unistr('Desc. Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978371318634345333)
,p_db_column_name=>'QTD_DIARIA'
,p_display_order=>151
,p_column_identifier=>'BI'
,p_column_label=>unistr('Qtd. Di\00E1ria')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(260978371507241345335)
,p_db_column_name=>'DIAS_COMPRA'
,p_display_order=>171
,p_column_identifier=>'BK'
,p_column_label=>'Dias de Compra'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882237958016804)
,p_db_column_name=>'NR_CARTAO'
,p_display_order=>181
,p_column_identifier=>'BL'
,p_column_label=>'Nr Cartao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882332590016805)
,p_db_column_name=>'ENDERECO'
,p_display_order=>191
,p_column_identifier=>'BM'
,p_column_label=>'Endereco'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882502581016806)
,p_db_column_name=>'NOME_LOGR'
,p_display_order=>201
,p_column_identifier=>'BN'
,p_column_label=>'Nome Logr'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882596420016807)
,p_db_column_name=>'COMPLEM'
,p_display_order=>211
,p_column_identifier=>'BO'
,p_column_label=>'Complem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882663155016808)
,p_db_column_name=>'BAIRRO'
,p_display_order=>221
,p_column_identifier=>'BP'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882774452016809)
,p_db_column_name=>'CIDADE'
,p_display_order=>231
,p_column_identifier=>'BQ'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882857925016810)
,p_db_column_name=>'UF'
,p_display_order=>241
,p_column_identifier=>'BR'
,p_column_label=>'Uf'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441882946289016811)
,p_db_column_name=>'COMPLEMENTO'
,p_display_order=>251
,p_column_identifier=>'BS'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883056254016812)
,p_db_column_name=>'TELEFONE'
,p_display_order=>261
,p_column_identifier=>'BT'
,p_column_label=>'Telefone'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883161716016813)
,p_db_column_name=>'DDD_CELL'
,p_display_order=>271
,p_column_identifier=>'BU'
,p_column_label=>'Ddd Cell'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883291075016814)
,p_db_column_name=>'TELEFONE_CELULAR'
,p_display_order=>281
,p_column_identifier=>'BV'
,p_column_label=>'Telefone Celular'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883390793016815)
,p_db_column_name=>'E_MAIL'
,p_display_order=>291
,p_column_identifier=>'BW'
,p_column_label=>'E Mail'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883449854016816)
,p_db_column_name=>'NUM_REGISTRO'
,p_display_order=>301
,p_column_identifier=>'BX'
,p_column_label=>'Num Registro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883601745016817)
,p_db_column_name=>'NUM_PIS_PASEP'
,p_display_order=>311
,p_column_identifier=>'BY'
,p_column_label=>'Num Pis Pasep'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883665439016818)
,p_db_column_name=>'NUM_CART_PROF'
,p_display_order=>321
,p_column_identifier=>'BZ'
,p_column_label=>'Num Cart Prof'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883794546016819)
,p_db_column_name=>'NOME_MAE'
,p_display_order=>331
,p_column_identifier=>'CA'
,p_column_label=>'Nome Mae'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256441883903165016820)
,p_db_column_name=>'DATA_CASAMENTO'
,p_display_order=>341
,p_column_identifier=>'CB'
,p_column_label=>'Data Casamento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(150486718279771035865)
,p_db_column_name=>'VALOR_PARTE_EMPRESA'
,p_display_order=>351
,p_column_identifier=>'CC'
,p_column_label=>'Valor Parte Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334638971233331683)
,p_db_column_name=>'CUSTO_UNITARIO'
,p_display_order=>361
,p_column_identifier=>'CD'
,p_column_label=>'Custo Unitario'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639120037331684)
,p_db_column_name=>'DIAS_COMPLETOS'
,p_display_order=>371
,p_column_identifier=>'CE'
,p_column_label=>'Dias Completos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639223014331685)
,p_db_column_name=>'DIAS_SALDO_CARTAO'
,p_display_order=>381
,p_column_identifier=>'CF'
,p_column_label=>'Dias Saldo Cartao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639249767331686)
,p_db_column_name=>'DIAS_EXCEDENTES'
,p_display_order=>391
,p_column_identifier=>'CG'
,p_column_label=>'Dias Excedentes'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639390786331687)
,p_db_column_name=>'DIAS_FALTAS'
,p_display_order=>401
,p_column_identifier=>'CH'
,p_column_label=>'Dias Faltas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639509993331688)
,p_db_column_name=>'DIAS_FALTAS_ATEST'
,p_display_order=>411
,p_column_identifier=>'CI'
,p_column_label=>'Dias Faltas Atest'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639535312331689)
,p_db_column_name=>'DIAS_ATEST'
,p_display_order=>421
,p_column_identifier=>'CJ'
,p_column_label=>'Dias Atest'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639639554331690)
,p_db_column_name=>'DIAS_FERIAS'
,p_display_order=>431
,p_column_identifier=>'CK'
,p_column_label=>'Dias Ferias'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(115334639780220331691)
,p_db_column_name=>'DIAS_AFAST'
,p_display_order=>441
,p_column_identifier=>'CL'
,p_column_label=>'Dias Afast'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(283741482756590892072)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'453033'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'INDICE:COD_EMPRESA:NOME_EMPRESA:FILIAL:NOME_FILIAL:COD_CCUSTO:NOME_CCUSTO:UNIDADE_ADM:DESC_UNID_ADM:COD_ATIVIDADE:DESC_ATIVIDADE:CLASS_CCUSTO:DESC_CLASS_CCUSTO:CPF:MATRICULA:NOME:MES_ADMISSAO:ANO_ADMISSAO:SITUACAO:NOME_SITUACAO:MES_SITUACAO:ANO_SITUA'
||'CAO:MOT_ALT_SITUACAO:DESC_MOTIVO_SITUACAO:VINCULO:NOME_VINCULO:VAGA:CARGO:NOME_CARGOS:CLASS_CARGO:DESC_CLASS_CARGO:FUNCAO:NOME_FUNCAO:COD_LOCALIZACAO:DESC_LOCAL:MES_NASC:ANO_NASC:IDADE:SEXO:ESTADO_CIVIL:DESC_EST_CIVIL:INSTRUCAO:DESC_INSTR:FORMACAO_ES'
||'COLAR:NOME_FORMACAO:FAIXA_SALARIO:FAIXA_IDADE:FX_TEMPO_CASA:TEMPO_CASA:CODIGO:DESCRICAO_FAMILIA:TIPO:DESCRICAO_TIPO:VALOR_BENEFICIO:QTD_DIARIA:VALOR_PARTE_EMPRESA:CUSTO_UNITARIO:DIAS_COMPRA:DIAS_COMPLETOS:DIAS_SALDO_CARTAO:DIAS_EXCEDENTES:DIAS_FALTAS'
||':DIAS_FALTAS_ATEST:DIAS_ATEST:DIAS_FERIAS:DIAS_AFAST:VLR_TOTAL:DATA_CASAMENTO:DT_INICIO:DT_FIM:DATA_REF:NR_CARTAO:ENDERECO:NOME_LOGR:COMPLEM:BAIRRO:CIDADE:UF:COMPLEMENTO:TELEFONE:DDD_CELL:TELEFONE_CELULAR:E_MAIL:NUM_REGISTRO:NUM_PIS_PASEP:NUM_CART_PR'
||'OF:NOME_MAE:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283741483214724892073)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867014512991591145)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P164_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283741484743478892075)
,p_plug_name=>'Dados'
,p_parent_plug_id=>wwv_flow_api.id(283741483214724892073)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283741486735501892080)
,p_plug_name=>'Foto'
,p_parent_plug_id=>wwv_flow_api.id(283741483214724892073)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283741487591307892081)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60696540339837292711)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(283741460634010892045)
,p_button_name=>'IA_2'
,p_button_static_id=>'BTN_IA_2'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
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
 p_id=>wwv_flow_api.id(60696540485070292712)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(267665677691874219862)
,p_button_name=>'IA_3'
,p_button_static_id=>'BTN_IA_3'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
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
 p_id=>wwv_flow_api.id(60696540511827292713)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(260963960030635451149)
,p_button_name=>'IA_4'
,p_button_static_id=>'BTN_IA_4'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
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
 p_id=>wwv_flow_api.id(271113081498880767553)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(275999657292013867664)
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
 p_id=>wwv_flow_api.id(271113081788882769301)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(275999657292013867664)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271101657030143743302)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(275999657292013867664)
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
 p_id=>wwv_flow_api.id(193363261658175053502)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_button_name=>'Pesquisar_dep'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(283741483494783892073)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(283741483214724892073)
,p_button_name=>'p164_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,73:P13_EMP,P13_MAT,P13_CHAMADOR:&P164_EMP.,&P164_MAT.,&P164_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60696556839681375463)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(114108792152355958193)
,p_button_name=>'IA_1'
,p_button_static_id=>'BTN_IA_1'
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
 p_id=>wwv_flow_api.id(60696540674665292714)
,p_name=>'P164_FLG'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696540729770292715)
,p_name=>'P164_MSG'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696540835793292716)
,p_name=>'P164_STATIC_ID_IR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696540925655292717)
,p_name=>'P164_USER_PROMPT'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696541002233292718)
,p_name=>'P164_SYS_PROMPT'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(193356428246744209997)
,p_name=>'P164_INDICE_N'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_prompt=>unistr('\00CDndice')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  case',
unistr('            when rownum = 1 then ''PACOTE DE BENEF\00CDCIOS'''),
'            when rownum = 2 then ''VALE TRANSPORTE''',
unistr('            when rownum = 3 then ''PLANO M\00C9DICO'''),
unistr('            when rownum = 4 then ''PLANO ODONTOL\00D3GICO'''),
unistr('            when rownum = 5 then ''PREVID\00CANCIA'''),
'        end DESC_,',
'        rownum ID_',
'from    dual connect by level <= 5'))
,p_lov_cascade_parent_items=>'P164_OPCAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(260963959877787451147)
,p_name=>'P164_OPCAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_prompt=>unistr('Op\00E7\00E3o de Consulta')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Colaboradores;C,Dependentes;D'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(260963959973752451148)
,p_name=>'P164_INDICE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_prompt=>unistr('\00CDndice old')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select ''PACOTE DE BENEF\00CDCIOS'' d, ''PACOTE DE BENEFICIOS'' c'),
'  from dual',
' where (:p164_opcao = ''C'' or :p164_opcao = ''D'')',
' union',
'select ''VALE TRANSPORTE'' d, ''VALE TRANSPORTE'' c',
'  from dual',
' where (:p164_opcao = ''C'')',
' union ',
unistr('select ''PLANO M\00C9DICO'' d, ''PLANO MEDICO'' c'),
'  from dual',
' where (:p164_opcao = ''C'' or :p164_opcao = ''D'')',
' union ',
unistr('select ''PLANO ODONTOL\00D3GICO'' d, ''PLANO ODONTOLOGICO'' c'),
'  from dual',
' where (:p164_opcao = ''C'' or :p164_opcao = ''D'')',
' union ',
unistr('select ''PREVID\00CANCIA'' d, ''PREVIDENCIA'' c'),
'  from dual',
' where (:p164_opcao = ''C'')',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P164_OPCAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101657453719743303)
,p_name=>'P164_SITUACAO_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_item_default=>'A'
,p_prompt=>unistr('Situa\00E7\00E3o Funcional')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Ativos;A,Demitidos;D,Todos;T'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101657881277743305)
,p_name=>'P164_EMPRESA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' WHERE ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101658267098743306)
,p_name=>'P164_UTILIZA_SECAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(275999657292013867664)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101658702515743307)
,p_name=>'P164_FILIAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(nvl(sigla,nome_filial)) descricao, cod_filial',
'  from filiais ',
'where ((instr('',''||:p164_empresa||'','','',''||cod_empresa||'','') > 0) or (:p164_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P164_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101659041867743308)
,p_name=>'P164_CCUSTO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p164_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p164_empresa, '','')) t))',
'and (:p164_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p164_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc(c.cod_empresa, c.cod) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P164_EMPRESA,P164_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101659475983743309)
,p_name=>'P164_UNIDADE_ADM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p164_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p164_empresa is null))',
'       and ((instr('',''||:p164_filial||'','','',''||a.cod_filial||'','') > 0) or (:p164_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p164_ccusto',
'       and ((instr('',''||:p164_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p164_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p164_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p164_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p164_empresa is null))',
'       and ((instr('',''||:p164_filial||'','','',''||a.cod_filial||'','') > 0) or (:p164_filial is null))',
'       and :p164_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P164_EMPRESA,P164_FILIAL,P164_CCUSTO,P164_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101659856578743310)
,p_name=>'P164_ATIVIDADE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p164_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p164_empresa is null))',
'   and ((instr('',''||:p164_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p164_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p164_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p164_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P164_CCUSTO,P164_UNIDADE_ADM,P164_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101660231624743311)
,p_name=>'P164_CARGO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101660645679743312)
,p_name=>'P164_MATRICULA_1'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(p.nome) d, i.matricula',
'  from informacoes_funcionais i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and ((i.situacao < ''90'' and :p164_situacao_1 = ''A'') or (i.situacao >= ''90'' and :p164_situacao_1 = ''D'') or (:p164_situacao_1 = ''T''))',
'   and (:P164_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_EMPRESA, '','')) t))',
'   and (:P164_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_FILIAL, '','')) t))',
'   and (:P164_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_CCUSTO, '','')) t))',
'   and (:P164_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_UNIDADE_ADM, '','')) t))',
'   and (:P164_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P164_ATIVIDADE, '','')) t))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P164_CCUSTO,P164_UNIDADE_ADM,P164_UTILIZA_SECAO,P164_ATIVIDADE,P164_SITUACAO_1,P164_EMPRESA,P164_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(271101661055268743313)
,p_name=>'P164_PESQUISA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(271112852107280353542)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283741483959156892074)
,p_name=>'P164_EMP'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(283741483214724892073)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283741484309368892074)
,p_name=>'P164_MAT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(283741483214724892073)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283741485102078892078)
,p_name=>'P164_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283741484743478892075)
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
 p_id=>wwv_flow_api.id(283741485567868892079)
,p_name=>'P164_MATRICULA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(283741484743478892075)
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
 p_id=>wwv_flow_api.id(283741485921028892079)
,p_name=>'P164_SITUACAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(283741484743478892075)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(283741486348972892080)
,p_name=>'P164_DT_ADMISSAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(283741484743478892075)
,p_prompt=>unistr('Data de Admiss\00E3o')
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
 p_id=>wwv_flow_api.id(283741487179589892081)
,p_name=>'P164_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(283741486735501892080)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'height="100" width="80"'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>'select foto from fotos where cod_empresa = :p164_emp and matricula = :p164_mat'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271101662325623758873)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P164_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271101662654876758875)
,p_event_id=>wwv_flow_api.id(271101662325623758873)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p164_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p164_empresa||'','','',''||cod_empresa||'','') > 0) or (:p164_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P164_EMPRESA'
,p_attribute_03=>'P164_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271113081984562770653)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113081498880767553)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113082336890770655)
,p_event_id=>wwv_flow_api.id(271113081984562770653)
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
 p_id=>wwv_flow_api.id(271113082782975772015)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113081788882769301)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113083169372772016)
,p_event_id=>wwv_flow_api.id(271113082782975772015)
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
 p_id=>wwv_flow_api.id(193356428347241209998)
,p_name=>'click_Pesquisar'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271101657030143743302)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261024856053496)
,p_event_id=>wwv_flow_api.id(193356428347241209998)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92173994377877176339)
,p_event_id=>wwv_flow_api.id(193356428347241209998)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P164_PESQUISA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(193363261202743053497)
,p_name=>'alt_P164_OPCAO'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P164_OPCAO'
,p_condition_element=>'P164_OPCAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261234792053498)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P164_INDICE_N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363262035269053506)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(271101657030143743302)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261391094053499)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P164_INDICE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261568522053501)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P164_INDICE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261784258053503)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(271101657030143743302)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261461014053500)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P164_INDICE_N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363261952502053505)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(193363261658175053502)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(102381382987878216233)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(193363262149086053507)
,p_event_id=>wwv_flow_api.id(193363261202743053497)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(60696557167236377129)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>60
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60696557579356377132)
,p_event_id=>wwv_flow_api.id(60696557167236377129)
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
'  apex.item("P164_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P164_SYS_PROMPT").setValue("Voc\00EA \00E9 um especialista de gest\00E3o de benef\00EDcios dos colaboradores em RH e Departamento Pessoal.");'),
unistr('  apex.item("P164_USER_PROMPT").setValue("Analise os dados de benef\00EDcios a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60696557958816377132)
,p_event_id=>wwv_flow_api.id(60696557167236377129)
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
'      v_region_static_id varchar2(100) := :P164_STATIC_ID_IR; --''IR_REGION'';',
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
'      v_system_prompt := :P164_SYS_PROMPT;',
'      v_user_prompt := :P164_USER_PROMPT;  --''Analise os dados a seguir.'';',
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
'      :P164_flg := v_status;',
'      :P164_msg := v_mensagem;',
'',
'    END;'))
,p_attribute_02=>'P164_USER_PROMPT,P164_SYS_PROMPT,P164_STATIC_ID_IR'
,p_attribute_03=>'P164_FLG,P164_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(114108809791641229907)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Processo Consulta'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    lv_retorno varchar2(50);',
'    lv_lote    varchar2(50);',
'begin',
'    :P164_PESQUISA := 1;',
'    lv_retorno :=',
'    PKG_CONSULTA_BENEFICIOS.FCN_CONSULTA_BENEFICIOS(  p_cod_empresa    => :P164_EMPRESA',
'                                                    , p_filial         => :P164_FILIAL',
'                                                    , p_centro_custo   => :P164_CCUSTO',
'                                                    , p_unidade_adm    => :P164_UNIDADE_ADM',
'                                                    , p_atividade      => :P164_ATIVIDADE',
'                                                    , p_matricula      => :P164_MATRICULA_1',
'                                                    , p_pesquisa       => :P164_PESQUISA',
'                                                    , p_indice_n       => :P164_INDICE_N',
'                                                    , p_situacao1      => :P164_SITUACAO_1',
'                                                    , p_cod_empresa1   => NULL',
'                                                    , p_matricula1     => NULL',
'                                                    , p_base           => :P_BASE',
'                                                    , p_painel         => :P_PAINEL',
'                                                    , p_usuario        => :P_USUARIO );',
'    if lv_retorno is not null then',
'        apex_error.add_error(p_message => lv_retorno',
'                , p_display_location => apex_error.c_inline_in_notification );',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283741488538009892084)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_colab'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P164_EMP is not null and :P164_MAT is not null then',
'    select  max(A.COD_EMPRESA||'' - ''||initcap(A.NOME)),',
'            max(C.MATRICULA||'' - ''||initcap(C.NOME)),',
'            max(D.COD||'' - ''||initcap(D.NOME)),',
'            max(B.DT_ADMISSAO)',
'    into    :P164_COD_EMPRESA,',
'            :P164_MATRICULA,',
'            :P164_SITUACAO,',
'            :P164_DT_ADMISSAO',
'    from    EMPRESAS A,',
'            INFORMACOES_FUNCIONAIS B,',
'            INF_PESSOAIS C,',
'            SIT_FUNC D',
'    where   A.COD_EMPRESA = B.COD_EMPRESA',
'    and     A.COD_EMPRESA = C.COD_EMPRESA',
'    and     B.MATRICULA = C.MATRICULA',
'    and     B.SITUACAO = D.COD',
'    and     B.COD_EMPRESA = :P164_EMP',
'    and     B.MATRICULA = :P164_MAT;',
'end if;',
'/*',
'if :P164_EMPRESA is null then',
'    select  min(A.COD)',
'    into    :P164_EMPRESA',
'    from    EMPRESAS A',
'    where   :P_PAINEL = ''PO'' ',
'    or      nvl(A.DT_ENCERRAMENTO,trunc(sysdate)) >= trunc(sysdate);',
'end if;',
'*/',
'if :P164_OPCAO is null then',
'    :P164_OPCAO := ''C'';',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(193356428185633209996)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_colab_old'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       i.cod_cargo_cipa,',
'       i.data_car_cipa',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p164_emp',
'   and i.matricula = :p164_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p164_cod_empresa := v_c1.empresa;',
':p164_matricula := v_c1.matricula;',
':p164_situacao := v_c1.situacao;',
':p164_dt_admissao := v_c1.dt_admissao;',
'/*',
'begin',
'  select cod_cargo_cipa||'' - ''||initcap(descr_cargo_cipa)||'' - ''||v_c1.data_car_cipa',
'    into :p164_cargo_Cipa',
'    from cargo_cipa',
'   where cod_cargo_cipa = v_c1.cod_cargo_cipa;',
'exception',
'  when no_data_found then',
'    null;',
'end;  ',
'*/',
'',
'if :p164_opcao is null then',
':p164_opcao := ''C'';',
'end if;',
'',
'exception',
'when others then',
':p164_cod_empresa := :p164_emp;',
':p164_matricula := :p164_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
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
