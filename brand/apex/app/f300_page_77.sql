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
,p_default_application_id=>300
,p_default_id_offset=>785128738853783604
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 300 - Painel do Colaborador - Natcorp
--
-- Application Export:
--   Application:     300
--   Name:            Painel do Colaborador - Natcorp
--   Date and Time:   16:26 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 77
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00077
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>77);
end;
/
prompt --application/pages/page_00077
begin
wwv_flow_api.create_page(
 p_id=>77
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>unistr('Requisi\00E7\00E3o de F\00E9rias')
,p_step_title=>unistr('Requisi\00E7\00E3o de F\00E9rias')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_FeriasConsulta.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_FeriasConsulta.css'
,p_group_id=>wwv_flow_api.id(145399453552557440291)
,p_inline_css=>'.t-fht-thead{ overflow: auto !important; }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_FeriasConsulta.css / Natcorp_FeriasConsulta.js)',
'',
'Os pedidos de ferias em cartoes, para o colaborador no celular: cartao curto do colaborador, "Pedir ferias" (o',
'botao Criar Requisicao original, com as acoes dele), "Suas proximas ferias", a situacao em botoes com a contagem,',
'e cada pedido com as partes (sai, volta, dias, dias vendidos, 13o), o periodo aquisitivo e o saldo, "Ver pedido" e',
'"Pedir de novo" (os links originais). Cancelados e reprovados ficam guardados num botao. "Ver como tabela" mostra o',
'relatorio original com as ferramentas. Os dados sao lidos do relatorio pelo titulo das colunas: renomear coluna = conferir.',
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/FERIASCONSULTA-MANUTENCAO.md.'))
,p_last_upd_yyyymmddhh24miss=>'20241105164117'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145369627688161617867)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(145393053751274394435)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(145492038528010058625)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145397133518818539357)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P77_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145397137428190539391)
,p_plug_name=>unistr('Requisi\00E7\00E3o de F\00E9rias')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492016720374058578)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       c.solicitacao requisicao,',
'       c.dt_solicitacao data_abertura,',
'       c.cod_empresa||'' - ''||initcap(fnct_nome_empresa(c.cod_empresa)) Empresa, ',
'       r.matricula||'' - ''||initcap(fnct_nome_func(r.cod_empresa, r.matricula)) Matricula_Solicitada,',
'       c.cod_empresa_solicitante||'' - ''||Initcap(fnct_nome_empresa(c.cod_empresa_solicitante)) Empresa_Solicitante,',
'       c.mat_solicitante||'' - ''||initcap(fnct_nome_func(c.cod_empresa_solicitante, c.mat_solicitante)) Solicitante,',
unistr('       decode(sit_requisicao, 1,''Aberta'',2,''Conclu\00EDda'',3,''Cancelada'',4,''Reprovada'',5,''Aprovada'',6,''Suspensa'') Situacao,'),
'       r.cod_empresa,',
'       r.cod_solicitacao,',
'       c.cod_empresa_solicitante,',
'       c.mat_solicitante,',
'       r.matricula,',
'       r.DT_INIC_PER_FERIAS,',
'       r.DT_FIM_PER_FERIAS,',
'       r.SALDO,',
'       r.DT_SAIDA_PARC1,',
'       r.DT_RETORNO_PARC1,',
'       r.NUM_DIAS_PARC1,',
'       r.DIAS_ABONO_PEC1,',
'       r.OPCAO_13SAL1,',
'       r.DT_SAIDA_PARC2,',
'       r.DT_RETORNO_PARC2,',
'       r.NUM_DIAS_PARC2,',
'       r.DIAS_ABONO_PEC2,',
'       r.OPCAO_13SAL2,',
'       r.DT_SAIDA_PARC4,',
'       r.DT_RETORNO_PARC4,',
'       r.NUM_DIAS_PARC4,',
'       r.DIAS_ABONO_PEC4,',
'       r.OPCAO_13SAL4,',
'       case',
'           when nvl(a.RECRIAR_REQ_CONCL_FUNC,''N'') = ''S'' and r.sit_requisicao not in (3,4) then',
unistr('               ''<a href="''||apex_util.prepare_url(''f?p=''||:APP_ID||'':78:''||:APP_SESSION||''::''||:DEBUG||'':78:P78_EMP_A,P78_MAT_A,P78_COD_REQ,P78_FLAG_CTRL:''||R.COD_EMPRESA||'',''||R.MATRICULA||'',''||R.COD_SOLICITACAO||'',1'')||''" title="Recriar Requisi\00E7\00E3o"')
||'><span class="fa fa-file-new" aria-hidden="true"></span></a>''',
'       end LINKS',
'  from consulta_requisicoes c,',
'       REQUISICAO_FERIAS r,',
'       informacoes_funcionais i,',
'       FERIAS_PARAMETROS a',
' where upper(c.tipo_req) = ''REQ_FERIAS''',
'   and r.cod_empresa     = i.cod_empresa',
'   and r.matricula       = i.matricula',
'   and i.cod_empresa = a.cod_empresa',
'   and i.filial = a.cod_filial',
'   and c.cod_empresa     = r.cod_empresa',
'   and c.solicitacao     = r.cod_solicitacao',
'   and r.cod_empresa = nvl(:p77_emp, :P_EMPRESA_USER)',
'   and r.matricula   = nvl(:p77_mat, :P_MATRICULA_USER)',
' order by solicitacao desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(145397137833439539394)
,p_name=>unistr('Requisi\00E7\00E3o de Pessoal')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>unistr('Nenhuma Requisi\00E7\00E3o Cadastrada')
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:78:&SESSION.::&DEBUG.:78:P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA:#COD_EMPRESA#,#REQUISICAO#,#MATRICULA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#e2.gif"  border="0">'
,p_owner=>'IGOR'
,p_internal_uid=>93515149324688793
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397137961185539402)
,p_db_column_name=>'REQUISICAO'
,p_display_order=>20
,p_column_identifier=>'AX'
,p_column_label=>unistr('Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397138287772539409)
,p_db_column_name=>'DATA_ABERTURA'
,p_display_order=>30
,p_column_identifier=>'AY'
,p_column_label=>'Data de Abertura'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397139175760539410)
,p_db_column_name=>'EMPRESA'
,p_display_order=>50
,p_column_identifier=>'BA'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397140729488539411)
,p_db_column_name=>'EMPRESA_SOLICITANTE'
,p_display_order=>110
,p_column_identifier=>'BF'
,p_column_label=>'Empresa Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397141084758539415)
,p_db_column_name=>'SOLICITANTE'
,p_display_order=>120
,p_column_identifier=>'BG'
,p_column_label=>'Solicitante'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA_SOLICITANTE#,#MAT_SOLICITANTE#'
,p_column_linktext=>'#SOLICITANTE#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397141543750539415)
,p_db_column_name=>'SITUACAO'
,p_display_order=>130
,p_column_identifier=>'BH'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397141974388539415)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>140
,p_column_identifier=>'BI'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397142349152539416)
,p_db_column_name=>'COD_EMPRESA_SOLICITANTE'
,p_display_order=>160
,p_column_identifier=>'BK'
,p_column_label=>'Cod empresa solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397142774729539416)
,p_db_column_name=>'MAT_SOLICITANTE'
,p_display_order=>170
,p_column_identifier=>'BL'
,p_column_label=>'Mat solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397143484221539417)
,p_db_column_name=>'MATRICULA_SOLICITADA'
,p_display_order=>200
,p_column_identifier=>'BO'
,p_column_label=>unistr('Matr\00EDcula Solicitada')
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MAT_SOLICITADO#'
,p_column_linktext=>'#MATRICULA_SOLICITADA#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397458976772221402)
,p_db_column_name=>'COD_SOLICITACAO'
,p_display_order=>210
,p_column_identifier=>'BR'
,p_column_label=>'Cod solicitacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145397459018439221403)
,p_db_column_name=>'MATRICULA'
,p_display_order=>220
,p_column_identifier=>'BS'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775846921671036920)
,p_db_column_name=>'DT_INIC_PER_FERIAS'
,p_display_order=>230
,p_column_identifier=>'BT'
,p_column_label=>unistr('Dt. Per\00EDodo In\00EDcio')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847069767036921)
,p_db_column_name=>'DT_FIM_PER_FERIAS'
,p_display_order=>240
,p_column_identifier=>'BU'
,p_column_label=>unistr('Dt. Per\00EDodo Fim')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847146527036922)
,p_db_column_name=>'SALDO'
,p_display_order=>250
,p_column_identifier=>'BV'
,p_column_label=>'Saldo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847205004036923)
,p_db_column_name=>'DT_SAIDA_PARC1'
,p_display_order=>260
,p_column_identifier=>'BW'
,p_column_label=>unistr('Dt. Sa\00EDda Parcela 1')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847319397036924)
,p_db_column_name=>'DT_RETORNO_PARC1'
,p_display_order=>270
,p_column_identifier=>'BX'
,p_column_label=>'Dt. Retorno Parcela 1'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847406601036925)
,p_db_column_name=>'NUM_DIAS_PARC1'
,p_display_order=>280
,p_column_identifier=>'BY'
,p_column_label=>unistr('N\00BA Dias Parcela 1')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847527778036926)
,p_db_column_name=>'DIAS_ABONO_PEC1'
,p_display_order=>290
,p_column_identifier=>'BZ'
,p_column_label=>unistr('N\00BA Dias Abono Parcela 1')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847641536036927)
,p_db_column_name=>'OPCAO_13SAL1'
,p_display_order=>300
,p_column_identifier=>'CA'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Parcela 1')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847743172036928)
,p_db_column_name=>'DT_SAIDA_PARC2'
,p_display_order=>310
,p_column_identifier=>'CB'
,p_column_label=>unistr('Dt. Sa\00EDda Parcela 2')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847793637036929)
,p_db_column_name=>'DT_RETORNO_PARC2'
,p_display_order=>320
,p_column_identifier=>'CC'
,p_column_label=>'Dt. Retorno Parcela 2'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775847970781036930)
,p_db_column_name=>'NUM_DIAS_PARC2'
,p_display_order=>330
,p_column_identifier=>'CD'
,p_column_label=>unistr('N\00BA Dias Parcela 2')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848075057036931)
,p_db_column_name=>'DIAS_ABONO_PEC2'
,p_display_order=>340
,p_column_identifier=>'CE'
,p_column_label=>unistr('N\00BA Dias Abono Parcela 2')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848167464036932)
,p_db_column_name=>'OPCAO_13SAL2'
,p_display_order=>350
,p_column_identifier=>'CF'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Parcela 2')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848203954036933)
,p_db_column_name=>'DT_SAIDA_PARC4'
,p_display_order=>360
,p_column_identifier=>'CG'
,p_column_label=>unistr('Dt. Sa\00EDda Parcela 3')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848367415036934)
,p_db_column_name=>'DT_RETORNO_PARC4'
,p_display_order=>370
,p_column_identifier=>'CH'
,p_column_label=>'Dt. Retorno Parcela 3'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848447601036935)
,p_db_column_name=>'NUM_DIAS_PARC4'
,p_display_order=>380
,p_column_identifier=>'CI'
,p_column_label=>unistr('N\00BA Dias Parcela 3')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848490976036936)
,p_db_column_name=>'DIAS_ABONO_PEC4'
,p_display_order=>390
,p_column_identifier=>'CJ'
,p_column_label=>unistr('N\00BA Dias Abono Parcela 3')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(142775848659821036937)
,p_db_column_name=>'OPCAO_13SAL4'
,p_display_order=>400
,p_column_identifier=>'CK'
,p_column_label=>unistr('Op\00E7\00E3o 13\00BA Parcela 3')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(95224307705315456105)
,p_db_column_name=>'LINKS'
,p_display_order=>410
,p_column_identifier=>'CL'
,p_column_label=>'&nbsp;'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(145397144730224539420)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'935221'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'LINKS:REQUISICAO:DATA_ABERTURA:SITUACAO:EMPRESA:MATRICULA_SOLICITADA:DT_INIC_PER_FERIAS:DT_FIM_PER_FERIAS:SALDO:DT_SAIDA_PARC1:DT_RETORNO_PARC1:NUM_DIAS_PARC1:DIAS_ABONO_PEC1:OPCAO_13SAL1:DT_SAIDA_PARC2:DT_RETORNO_PARC2:NUM_DIAS_PARC2:DIAS_ABONO_PEC2'
||':OPCAO_13SAL2:DT_SAIDA_PARC4:DT_RETORNO_PARC4:NUM_DIAS_PARC4:DIAS_ABONO_PEC4:OPCAO_13SAL4:EMPRESA_SOLICITANTE:SOLICITANTE:'
,p_sort_column_1=>'COD_REQ'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145397133906323539370)
,p_button_sequence=>540
,p_button_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_button_name=>'p77_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P77_EMP.,&P77_MAT.,&P77_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145397145275848539427)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(145397137428190539391)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(145397151605454539447)
,p_branch_name=>'Ir'
,p_branch_action=>'f?p=&APP_ID.:78:&SESSION.::&DEBUG.:RP,78:P78_COD_EMPRESA,P78_MATRICULA:&P_EMPRESA_USER.,&P_MATRICULA_USER.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_branch_condition=>'P77_OK'
,p_branch_condition_text=>'S'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(67474150140233633325)
,p_name=>'P77_ALERT_ACAO_JURIDICO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397134242223539378)
,p_name=>'P77_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p77_emp',
'                               and matricula   = :p77_mat), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P77_EMP || ''|'' || :P77_MAT',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
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
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397134680733539388)
,p_name=>'P77_COD_EMPRESA1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397135012154539389)
,p_name=>'P77_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397135475898539389)
,p_name=>'P77_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397135841739539389)
,p_name=>'P77_DT_ADMISSAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397136235179539390)
,p_name=>'P77_EMP'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397136653831539390)
,p_name=>'P77_MAT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397137067121539390)
,p_name=>'P77_CHAMADOR'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(145397133518818539357)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397145680983539428)
,p_name=>'P77_FLAG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(145397137428190539391)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397146050733539428)
,p_name=>'P77_MENSAGEM'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(145397137428190539391)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145397146464061539428)
,p_name=>'P77_OK'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(145397137428190539391)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145397148824240539442)
,p_name=>unistr('Page Load: Valida\00E7\00F5es')
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145397145275848539427)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P77_MAT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145397149325886539444)
,p_event_id=>wwv_flow_api.id(145397148824240539442)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p77_mensagem := null;',
'',
'pkg_ferias.Valida_Matricula_Solicitado(:p77_EMP, :p77_MAT, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p77_ok       := ''N'';',
'    :p77_flag     := v_flg_retorno;',
'    :p77_mensagem := v_msg_retorno;',
' else',
'    :p77_flag     := null;',
'    :p77_mensagem := null;',
'    :p77_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P77_EMP,P77_MAT'
,p_attribute_03=>'P77_MENSAGEM,P77_FLAG,P77_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(67474150211660633326)
,p_name=>unistr('Mensagem e N\00E3o Submete')
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145397145275848539427)
,p_condition_element=>'P77_ALERT_ACAO_JURIDICO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67474150301955633327)
,p_event_id=>wwv_flow_api.id(67474150211660633326)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Colaborador com a\00E7\00E3o judicial de f\00E9rias, atendendo ao processo suas f\00E9rias s\00E3o compuls\00F3rias')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145397149703221539444)
,p_name=>'Ir'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145397145275848539427)
,p_condition_element=>'P77_ALERT_ACAO_JURIDICO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145397150240834539445)
,p_event_id=>wwv_flow_api.id(145397149703221539444)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145397147889201539434)
,p_name=>'Dispara Alerta'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P77_MENSAGEM'
,p_condition_element=>'P77_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145397148437704539439)
,p_event_id=>wwv_flow_api.id(145397147889201539434)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P77_FLAG'').value == "Q") {',
'alertify.confirm($v(''P77_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P77_FLAG'').value = ''S'';',
'        $x(''P77_MENSAGEM'').value = '''';',
'        $x(''P77_OK'').value = ''S'';',
'        $(''#P77_CREATE'').show();',
'    } else {',
'        $x(''P77_OK'').value = ''N'';',
'        $(''#P77_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P77_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P77_FLAG'').value == "N") {',
'            $(''#P77_CREATE'').hide();',
'        } else {',
'            $(''#P77_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P77_MENSAGEM''));',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145397150601524539445)
,p_name=>'Carrega Plugin'
,p_event_sequence=>100
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145397151157680539445)
,p_event_id=>wwv_flow_api.id(145397150601524539445)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Teste'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145397147580125539432)
,p_process_sequence=>10
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
' where i.cod_empresa = :p77_emp',
'   and i.matricula = :p77_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p77_cod_empresa1 := v_c1.empresa;',
':p77_matricula := v_c1.matricula;',
':p77_situacao := v_c1.situacao;',
':p77_dt_admissao := v_c1.dt_admissao;',
'',
':p77_OK := ''S'';',
'',
'if :P77_MATRICULA is not null then',
'    begin',
'        select ''S''',
'            into :P77_ALERT_ACAO_JURIDICO',
'        from campo_de_cadastro',
'        where campo = ''ACAO_JUDICIAL''',
'        and texto = ''S''',
'        and chave_de_tabela = :P77_MAT;',
'        --and empresa = :P77_EMP;',
'    exception',
'        when others then',
'           :P77_ALERT_ACAO_JURIDICO := ''N'';',
'    end;',
'end if;',
'',
'exception',
'when others then',
':p77_cod_empresa1 := :p77_emp;',
':p77_matricula := :p77_mat;',
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
