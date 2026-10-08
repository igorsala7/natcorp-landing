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
--   Date and Time:   02:36 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 17
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00017
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>17);
end;
/
prompt --application/pages/page_00017
begin
wwv_flow_api.create_page(
 p_id=>17
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>'Dados Funcionais'
,p_step_title=>'Dados Funcionais'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Ficha.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Ficha.js'
,p_group_id=>wwv_flow_api.id(281462206901186531443)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#BTN_BENEFICIOS {margin-top: 24px}',
'#BTTPVINC {margin-top: 24px}',
'#BTDUPVINC {margin-top: 24px}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Ficha.css / Natcorp_Ficha.js)',
'',
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
unistr('  nc-df-colaborador  Colaborador: o alto (faixa da marca, foto, nome, situa\00E7\00E3o, 6 fatos e as'),
unistr('                     a\00E7\00F5es da p\00E1gina, que continuam sendo os bot\00F5es do APEX).'),
unistr('  nc-df-info         Informa\00E7\00F5es: as abas viram navega\00E7\00E3o lateral (com busca "/") e se\00E7\00F5es'),
unistr('                     por assunto; Dependentes em cart\00F5es, Ocorr\00EAncias em linha do tempo, com a'),
'                     tabela original a um clique.',
unistr('  nc-df-beneficios   Benef\00EDcios Relat\00F3rio (janela Benef\00EDcios): cart\00F5es por grupo, com todas'),
unistr('                     as linhas (o relat\00F3rio vinha de 15 em 15).'),
'',
unistr('Nada \00E9 gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.'),
'Guia: brand/apex/app/FICHA-MANUTENCAO.md.'))
,p_last_updated_by=>'MARCELO.SENA'
,p_last_upd_yyyymmddhh24miss=>'20260612161339'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(280864458300133824578)
,p_plug_name=>unistr('Benef\00EDcios')
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(281503491494631346639)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281399607293403466173)
,p_name=>unistr('Benef\00EDcios Relat\00F3rio')
,p_region_css_classes=>'nc-df-beneficios'
,p_parent_plug_id=>wwv_flow_api.id(280864458300133824578)
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader:t-Region--scrollBody:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(replace(b.INDICE,''_'','' '')) indice,',
unistr('       case when p.beneficio = ''S'' then b.CODIGO||'' - ''||Initcap(b.DESCRICAO_FAMILIA) end Benef\00EDcio,'),
unistr('       case when p.beneficio = ''S'' then b.TIPO||'' - ''||Initcap(b.DESCRICAO_TIPO) end Tipo_Benef\00EDcio,'),
unistr('       b.DT_INICIO Data_In\00EDcio,'),
'       b.DT_FIM Data_Fim,',
unistr('       case when p.beneficio_valor = ''S'' then b.VALOR_BENEFICIO end Valor_Benef\00EDcio'),
'       -- Alterada da view materializada para view normal - Andre - chamado 31477',
'  from VW_BI_BENEFICIOS_V0 /*VW_BI_BENEFICIOS*/ b, permissao_func p',
'  where p.id_usuario = usuario.busca_user',
'    and b.cod_empresa = :p17_emp',
'    and b.matricula = :p17_mat',
'  ORDER BY b.indice, b.codigo, b.tipo, b.dt_inicio desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P17_EMP,P17_MAT'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_break_cols=>'1:2'
,p_query_no_data_found=>unistr('Nenhum Benef\00EDcio Encontrado xxxxxxx')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_break_type_flag=>'REPEAT_HEADINGS_ON_BREAK_1'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(278901604245402941482)
,p_query_column_id=>1
,p_column_alias=>'INDICE'
,p_column_display_sequence=>1
,p_column_heading=>unistr('\00CDndice')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(280865254395470048797)
,p_query_column_id=>2
,p_column_alias=>unistr('BENEF\00CDCIO')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(280865254774786048798)
,p_query_column_id=>3
,p_column_alias=>unistr('TIPO_BENEF\00CDCIO')
,p_column_display_sequence=>3
,p_column_heading=>unistr('Tipo de Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(278901604336478941483)
,p_query_column_id=>4
,p_column_alias=>unistr('DATA_IN\00CDCIO')
,p_column_display_sequence=>5
,p_column_heading=>unistr('Data In\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(278901604437664941484)
,p_query_column_id=>5
,p_column_alias=>'DATA_FIM'
,p_column_display_sequence=>6
,p_column_heading=>'Data Fim'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(278901604504088941485)
,p_query_column_id=>6
,p_column_alias=>unistr('VALOR_BENEF\00CDCIO')
,p_column_display_sequence=>4
,p_column_heading=>unistr('Valor Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462267488181567714)
,p_plug_name=>'Colaborador'
,p_region_css_classes=>'nc-df-colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462275130173567722)
,p_plug_name=>unistr('Informa\00E7\00F5es')
,p_region_css_classes=>'nc-df-info'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'Y'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268959105469397328521)
,p_plug_name=>'Dependentes'
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:t-Region--stacked:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'    IF pkg_acesso_po.fnct_botao(NULL, :P_USUARIO, ''DEPENDENTES'', ''DADOS DO COLABORADOR'', ''DADOS CADASTRAIS'', P_PAINEL => :P_PAINEL)',
'    then',
'       RETURN TRUE;',
'    else',
'       RETURN FALSE;',
'    end if;',
'',
'END;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281760193903116385748)
,p_plug_name=>'Dependentes - IR'
,p_parent_plug_id=>wwv_flow_api.id(268959105469397328521)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492405269346640)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'D.COD_EMPRESA,',
'D.MATRICULA,',
'D.DC_MATRICULA,',
'D.NUM_DEPEND,',
'D.NOME_DEPEND,',
'D.GRAU_PARENTESCO,',
'D.CONDICAO_DEPEND,',
'D.INCID_IR,',
'D.INCID_SF,',
'D.INCID_PLANO_MED,',
'D.EST_NASC,',
'D.DT_NASC,',
'D.CART_VACIN,',
'D.CODIGO_PLANO,',
'D.CODIGO_TIPO,',
'D.CIDADE_NASC,',
'D.CARTORIO,',
'D.NUM_REGISTRO,',
'D.NUM_LIVRO,',
'D.NUM_FOLHA,',
'D.DATA_CERTIDAO,',
'D.IND_AGREGADO,',
'D.DATA_BAIXA,',
'D.SEXO_DEPEND,',
'D.DT_DEPENDENTE,',
'D.CD_NIVEL,',
'SUBSTR(LPAD(D.NUM_CPF_CONJUGE,9,0),1,3)||''.''||',
'SUBSTR(LPAD(D.NUM_CPF_CONJUGE,9,0),4,3)||''.''||',
'SUBSTR(LPAD(D.NUM_CPF_CONJUGE,9,0),7,3)||''-''||',
'LPAD(D.DC_CPF_CONJUGE,2,0) NUM_CPF,',
'D.INCID_AUX_CRECHE,',
'D.MAE_DEPEND,',
'SUBSTR(LPAD(D.CPF_MAE_DEPEND,9,0),1,3)||''.''||',
'SUBSTR(LPAD(D.CPF_MAE_DEPEND,9,0),4,3)||''.''||',
'SUBSTR(LPAD(D.CPF_MAE_DEPEND,9,0),7,3)||''-''||',
'LPAD(D.DC_CPF_MAE_DEPEND,2,0) NUM_CPF_MAE,',
'D.FREQ_ESCOLAR,',
'D.MANEQUIM,',
'D.CALCADO,',
'D.CODIGO_PLANO2,',
'D.CODIGO_TIPO2,',
'D.DT_ADESAO,',
'D.DT_ADESAO2,',
'D.FORMS_ATLZ,',
'D.FORMS_ATLZ2,',
'D.DT_ADESAO_FINAL,',
'D.DT_ADESAO2_FINAL,',
'D.TIPO_CERTIDAO,',
'D.DECL_NASC_VIVOS,',
'D.AUX_EXCEPCIONAL,',
'D.OPTANTE_SEGURO,',
'D.OPTOU_PL_MED,',
'D.OPTOU_PL_ODO,',
'D.COD_NACIONAL_SAUDE,',
'D.MOT_INATIVACAO,',
'D.ESTADO_CIVIL,',
'D.COD_ENTIDADE_CRECHE,',
'D.TIPO_ENTIDADE_CRECHE,',
'D.DT_AUX_CRECHE_INICIAL,',
'D.DT_AUX_CRECHE_FINAL,',
'D.OBSERVACAO_AM,',
'D.OBSERVACAO_AO,',
'D.PAIS_NASCIMENTO,',
'D.PAIS_NACIONALIDADE,',
'D.DEPRPPS,',
'D.USUARIO,',
'D.DT_ATUALIZACAO,',
unistr('decode(class_trab_estrang,1,''Refugiado'',2, ''Solicitante de ref\00FAgio'',3,''Perman\00EAncia no Brasil em raz\00E3o de reuni\00E3o familiar'',4,''Beneficiado pelo acordo entre pa\00EDses do Mercosul'',5,''Dependente de agente diplom\00E1tico e/ou consular de'',6,''Beneficiado pelo ')
||unistr('Tratado de Amizade, Coopera\00E7\00E3o e'',7,''Outra condi\00E7\00E3o'') classif_estrangeiro'),
'from DEPENDENTES D',
'where D.cod_empresa = :p17_emp',
'  and D.matricula   = :p17_mat',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(281760194317968385749)
,p_name=>'Dependentes'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dependente Cadastrado'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:RP,22:P22_COD_EMPRESA,P22_MATRICULA,P22_NUM_DEPEND,P22_CHAMADOR:&P17_EMP.,&P17_MAT.,#NUM_DEPEND#,17'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>13076181020482931531
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981808194643261543)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P17_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981813267459261548)
,p_db_column_name=>'MATRICULA'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P17_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981813652499261548)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>unistr('Dc. Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P17_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981814017371261549)
,p_db_column_name=>'NUM_DEPEND'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Num. Dependente'
,p_column_type=>'NUMBER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981814410455261549)
,p_db_column_name=>'NOME_DEPEND'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Nome Dependente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981814798946261550)
,p_db_column_name=>'GRAU_PARENTESCO'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Grau de Parentesco'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981815254261261550)
,p_db_column_name=>'CONDICAO_DEPEND'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>unistr('Condi\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981815626672261550)
,p_db_column_name=>'INCID_IR'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Incide I.R.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981816049941261551)
,p_db_column_name=>'INCID_SF'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>unistr('Incide Sal. Fam\00EDlia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981816493652261551)
,p_db_column_name=>'INCID_PLANO_MED'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>unistr('Incide Plano M\00E9dico')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981816890567261551)
,p_db_column_name=>'EST_NASC'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Estado de Nascimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981817291159261552)
,p_db_column_name=>'DT_NASC'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Data de Nascimento'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981817651764261552)
,p_db_column_name=>'CART_VACIN'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>unistr('Carteira de Vacina\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981818048790261552)
,p_db_column_name=>'USUARIO'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981818404364261553)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Dt Atualizacao'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981818858907261553)
,p_db_column_name=>'CODIGO_PLANO'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Codigo Plano'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981819210476261553)
,p_db_column_name=>'CODIGO_TIPO'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Codigo Tipo'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981819634889261554)
,p_db_column_name=>'CIDADE_NASC'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Cidade Nasc'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981820086842261554)
,p_db_column_name=>'CARTORIO'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Cartorio'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981820422117261555)
,p_db_column_name=>'NUM_REGISTRO'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Num Registro'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981820825591261555)
,p_db_column_name=>'NUM_LIVRO'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Num Livro'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981821210520261555)
,p_db_column_name=>'NUM_FOLHA'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Num Folha'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981821681204261556)
,p_db_column_name=>'DATA_CERTIDAO'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>'Data Certidao'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981821998676261556)
,p_db_column_name=>'IND_AGREGADO'
,p_display_order=>25
,p_column_identifier=>'Y'
,p_column_label=>'Ind Agregado'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981822475970261557)
,p_db_column_name=>'DATA_BAIXA'
,p_display_order=>26
,p_column_identifier=>'Z'
,p_column_label=>'Data Baixa'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981799297792261527)
,p_db_column_name=>'SEXO_DEPEND'
,p_display_order=>27
,p_column_identifier=>'AA'
,p_column_label=>'Sexo Depend'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981799784633261528)
,p_db_column_name=>'DT_DEPENDENTE'
,p_display_order=>28
,p_column_identifier=>'AB'
,p_column_label=>'Dt Dependente'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981800136803261528)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>29
,p_column_identifier=>'AC'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981800594563261529)
,p_db_column_name=>'INCID_AUX_CRECHE'
,p_display_order=>32
,p_column_identifier=>'AF'
,p_column_label=>'Incid Aux Creche'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981800976568261529)
,p_db_column_name=>'MAE_DEPEND'
,p_display_order=>33
,p_column_identifier=>'AG'
,p_column_label=>'Mae Depend'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981801358995261530)
,p_db_column_name=>'FREQ_ESCOLAR'
,p_display_order=>36
,p_column_identifier=>'AJ'
,p_column_label=>'Freq Escolar'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981801733778261531)
,p_db_column_name=>'MANEQUIM'
,p_display_order=>37
,p_column_identifier=>'AK'
,p_column_label=>'Manequim'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981802108258261531)
,p_db_column_name=>'CALCADO'
,p_display_order=>38
,p_column_identifier=>'AL'
,p_column_label=>'Calcado'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981802591804261532)
,p_db_column_name=>'CODIGO_PLANO2'
,p_display_order=>39
,p_column_identifier=>'AM'
,p_column_label=>'Codigo Plano2'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981802995110261532)
,p_db_column_name=>'CODIGO_TIPO2'
,p_display_order=>40
,p_column_identifier=>'AN'
,p_column_label=>'Codigo Tipo2'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981803340585261533)
,p_db_column_name=>'DT_ADESAO'
,p_display_order=>41
,p_column_identifier=>'AO'
,p_column_label=>'Dt Adesao'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981803742380261534)
,p_db_column_name=>'DT_ADESAO2'
,p_display_order=>42
,p_column_identifier=>'AP'
,p_column_label=>'Dt Adesao2'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981804176788261534)
,p_db_column_name=>'FORMS_ATLZ'
,p_display_order=>43
,p_column_identifier=>'AQ'
,p_column_label=>'Forms Atlz'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981804590328261535)
,p_db_column_name=>'FORMS_ATLZ2'
,p_display_order=>44
,p_column_identifier=>'AR'
,p_column_label=>'Forms Atlz2'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981804917618261535)
,p_db_column_name=>'DT_ADESAO_FINAL'
,p_display_order=>45
,p_column_identifier=>'AS'
,p_column_label=>'Dt Adesao Final'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981805383827261536)
,p_db_column_name=>'DT_ADESAO2_FINAL'
,p_display_order=>46
,p_column_identifier=>'AT'
,p_column_label=>'Dt Adesao2 Final'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981805716124261536)
,p_db_column_name=>'TIPO_CERTIDAO'
,p_display_order=>47
,p_column_identifier=>'AU'
,p_column_label=>'Tipo Certidao'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981806137749261539)
,p_db_column_name=>'DECL_NASC_VIVOS'
,p_display_order=>48
,p_column_identifier=>'AV'
,p_column_label=>'Decl Nasc Vivos'
,p_column_type=>'NUMBER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981806500498261539)
,p_db_column_name=>'AUX_EXCEPCIONAL'
,p_display_order=>49
,p_column_identifier=>'AW'
,p_column_label=>'Aux Excepcional'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981806936392261540)
,p_db_column_name=>'OPTANTE_SEGURO'
,p_display_order=>50
,p_column_identifier=>'AX'
,p_column_label=>'Optante Seguro'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981807387346261542)
,p_db_column_name=>'OPTOU_PL_MED'
,p_display_order=>51
,p_column_identifier=>'AY'
,p_column_label=>'Optou Pl Med'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981807751845261543)
,p_db_column_name=>'OPTOU_PL_ODO'
,p_display_order=>52
,p_column_identifier=>'AZ'
,p_column_label=>'Optou Pl Odo'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981808567057261544)
,p_db_column_name=>'COD_NACIONAL_SAUDE'
,p_display_order=>53
,p_column_identifier=>'BA'
,p_column_label=>'Cod Nacional Saude'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981808947207261544)
,p_db_column_name=>'MOT_INATIVACAO'
,p_display_order=>54
,p_column_identifier=>'BB'
,p_column_label=>'Mot Inativacao'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981809383164261544)
,p_db_column_name=>'ESTADO_CIVIL'
,p_display_order=>55
,p_column_identifier=>'BC'
,p_column_label=>'Estado Civil'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981809784299261545)
,p_db_column_name=>'COD_ENTIDADE_CRECHE'
,p_display_order=>56
,p_column_identifier=>'BD'
,p_column_label=>'Cod Entidade Creche'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981810162133261545)
,p_db_column_name=>'TIPO_ENTIDADE_CRECHE'
,p_display_order=>57
,p_column_identifier=>'BE'
,p_column_label=>'Tipo Entidade Creche'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981810526998261545)
,p_db_column_name=>'DT_AUX_CRECHE_INICIAL'
,p_display_order=>58
,p_column_identifier=>'BF'
,p_column_label=>'Dt Aux Creche Inicial'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981810926838261546)
,p_db_column_name=>'DT_AUX_CRECHE_FINAL'
,p_display_order=>59
,p_column_identifier=>'BG'
,p_column_label=>'Dt Aux Creche Final'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981811325140261546)
,p_db_column_name=>'OBSERVACAO_AM'
,p_display_order=>60
,p_column_identifier=>'BH'
,p_column_label=>'Observacao Am'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981811732687261547)
,p_db_column_name=>'OBSERVACAO_AO'
,p_display_order=>61
,p_column_identifier=>'BI'
,p_column_label=>'Observacao Ao'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981812145132261547)
,p_db_column_name=>'PAIS_NASCIMENTO'
,p_display_order=>62
,p_column_identifier=>'BJ'
,p_column_label=>'Pais Nascimento'
,p_column_type=>'NUMBER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981812569325261547)
,p_db_column_name=>'PAIS_NACIONALIDADE'
,p_display_order=>63
,p_column_identifier=>'BK'
,p_column_label=>'Pais Nacionalidade'
,p_column_type=>'NUMBER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981812868467261548)
,p_db_column_name=>'DEPRPPS'
,p_display_order=>64
,p_column_identifier=>'BL'
,p_column_label=>'Deprpps'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981798156836261525)
,p_db_column_name=>'NUM_CPF'
,p_display_order=>74
,p_column_identifier=>'BM'
,p_column_label=>'Num cpf'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(268981798592541261526)
,p_db_column_name=>'NUM_CPF_MAE'
,p_display_order=>84
,p_column_identifier=>'BN'
,p_column_label=>'Num cpf mae'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(79821414381162685019)
,p_db_column_name=>'CLASSIF_ESTRANGEIRO'
,p_display_order=>94
,p_column_identifier=>'BO'
,p_column_label=>'Classif Estrangeiro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(281760219966939385773)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2978095'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NUM_DEPEND:NOME_DEPEND:GRAU_PARENTESCO:NUM_CPF:CONDICAO_DEPEND:INCID_IR:INCID_SF:INCID_PLANO_MED:EST_NASC:DT_NASC:CART_VACIN:CODIGO_PLANO:CODIGO_TIPO:CIDADE_NASC:CARTORIO:NUM_REGISTRO:NUM_LIVRO:NUM_FOLHA:DATA_CERTIDAO:IND_AGREGADO:DATA_BAIXA:SEXO_DEP'
||'END:DT_DEPENDENTE:INCID_AUX_CRECHE:MAE_DEPEND:NUM_CPF_MAE:FREQ_ESCOLAR:MANEQUIM:CALCADO:CODIGO_PLANO2:CODIGO_TIPO2:DT_ADESAO:DT_ADESAO2:FORMS_ATLZ:FORMS_ATLZ2:DT_ADESAO_FINAL:DT_ADESAO2_FINAL:TIPO_CERTIDAO:DECL_NASC_VIVOS:AUX_EXCEPCIONAL:OPTANTE_SEGU'
||'RO:OPTOU_PL_MED:OPTOU_PL_ODO:COD_NACIONAL_SAUDE:MOT_INATIVACAO:ESTADO_CIVIL:COD_ENTIDADE_CRECHE:TIPO_ENTIDADE_CRECHE:DT_AUX_CRECHE_INICIAL:DT_AUX_CRECHE_FINAL:OBSERVACAO_AM:OBSERVACAO_AO:PAIS_NASCIMENTO:PAIS_NACIONALIDADE:DEPRPPS:CLASSIF_ESTRANGEIRO'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(272439702098143772199)
,p_name=>unistr('Ocorr\00EAncias Disciplinares')
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select d.dt_ocorr_discip data_ocorr\00EAncia,'),
unistr('       d.cod_ocorr_discip||'' - ''||initcap(o.descricao) ocorr\00EAncia, '),
'       d.dt_inicio,',
'       d.motivo, ',
unistr('       decode(d.ind_suspensao,''S'',''Sim'',''N'',''N\00E3o'') suspenso,'),
unistr('       decode(d.adv_verbal,''S'',''Sim'',''N'',''N\00E3o'') adv_verbal,'),
unistr('       decode(d.adv_escrita,''S'',''Sim'',''N'',''N\00E3o'') adv_escrita,'),
unistr('       decode(d.concluido,''S'',''Sim'',''N'',''N\00E3o'') concluido,'),
'       d.protocolo,',
'       d.usuario_conclusao,',
'       d.dt_conclusao,',
'       d.qtde_dias Dias',
'  from DISCIPLINA_FUNC d, ocorrencias_disciplinares o',
' where d.cod_empresa = o.cod_empresa',
'   and d.cod_ocorr_discip = o.cod',
'   and d.cod_empresa = :p17_emp',
'   and d.matricula = :p17_mat',
' order by dt_ocorr_discip desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P17_EMP,P17_MAT'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_break_cols=>'1:2'
,p_query_no_data_found=>unistr('Nenhuma Ocorr\00EAncia Registrada.')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_break_type_flag=>'REPEAT_HEADINGS_ON_BREAK_1'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(272439702811268772206)
,p_query_column_id=>1
,p_column_alias=>unistr('DATA_OCORR\00CANCIA')
,p_column_display_sequence=>1
,p_column_heading=>unistr('Data Ocorr\00EAncia')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(272439702918659772207)
,p_query_column_id=>2
,p_column_alias=>unistr('OCORR\00CANCIA')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Ocorr\00EAncia')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(139728048694307337735)
,p_query_column_id=>3
,p_column_alias=>'DT_INICIO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Data In\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(272439703010076772208)
,p_query_column_id=>4
,p_column_alias=>'MOTIVO'
,p_column_display_sequence=>4
,p_column_heading=>'Motivo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(272439703085090772209)
,p_query_column_id=>5
,p_column_alias=>'SUSPENSO'
,p_column_display_sequence=>5
,p_column_heading=>'Suspenso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254078358681762772313)
,p_query_column_id=>6
,p_column_alias=>'ADV_VERBAL'
,p_column_display_sequence=>7
,p_column_heading=>'Adv Verbal'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254078358810926772314)
,p_query_column_id=>7
,p_column_alias=>'ADV_ESCRITA'
,p_column_display_sequence=>8
,p_column_heading=>'Adv Escrita'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254078358863360772315)
,p_query_column_id=>8
,p_column_alias=>'CONCLUIDO'
,p_column_display_sequence=>9
,p_column_heading=>'Entregue'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254078358994661772316)
,p_query_column_id=>9
,p_column_alias=>'PROTOCOLO'
,p_column_display_sequence=>10
,p_column_heading=>'Protocolo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254078359041280772317)
,p_query_column_id=>10
,p_column_alias=>'USUARIO_CONCLUSAO'
,p_column_display_sequence=>11
,p_column_heading=>unistr('Usu\00E1rio Conclus\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254078359141357772318)
,p_query_column_id=>11
,p_column_alias=>'DT_CONCLUSAO'
,p_column_display_sequence=>12
,p_column_heading=>unistr('Data Conclus\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(272439703193533772210)
,p_query_column_id=>12
,p_column_alias=>'DIAS'
,p_column_display_sequence=>6
,p_column_heading=>'Dias'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462277936847567725)
,p_plug_name=>'Dados Pessoais'
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462299924642567744)
,p_plug_name=>'Documentos'
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462311931102567753)
,p_plug_name=>unistr('Lota\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462321100408567761)
,p_plug_name=>'Folha'
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462326276070567765)
,p_plug_name=>unistr('Cargos / Sal\00E1rios')
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281462344673815567783)
,p_plug_name=>unistr('Hor\00E1rio')
,p_parent_plug_id=>wwv_flow_api.id(281462275130173567722)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281463533161050216064)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281417152242908913695)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16255537139710426053)
,p_button_sequence=>330
,p_button_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_button_name=>'BT_TPVINC'
,p_button_static_id=>'BTTPVINC'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--iconLeft:t-Button--pillStart:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Tipos V\00EDnculos')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=CV_&P_BASE.:44:&SESSION.::&DEBUG.:RP,44:P44_EMP,P44_MAT,P44_DC_MAT,P44_FIL,P_ALTERA_PESS_FUNC:&P17_EMP.,&P17_MAT.,,,N'
,p_button_condition=>'pkg_AdmPessInfPessFunc.fnc_VerifDuploVinculo(pEmpresa => :P17_EMP) = ''S'''
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-link'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16255537242750426054)
,p_button_sequence=>340
,p_button_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_button_name=>'BT_HISTDUPVINC'
,p_button_static_id=>'BTDUPVINC'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--iconLeft:t-Button--pillStart:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Duplo V\00EDnculo')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=CV_&P_BASE.:46:&SESSION.::&DEBUG.:RP,46:P46_EMP,P46_MAT,P46_FIL:&P17_EMP.,&P17_MAT.,'
,p_button_condition=>'pkg_AdmPessInfPessFunc.fnc_VerifDuploVinculo(pEmpresa => :P17_EMP) = ''S'''
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-h-square'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(280864458457911824579)
,p_button_sequence=>360
,p_button_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_button_name=>'BENEFICIOS'
,p_button_static_id=>'BTN_BENEFICIOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--pillEnd'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Benef\00EDcios')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-search'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281463532408229216057)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_button_name=>'p17_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P17_EMP.,&P17_MAT.,&P17_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281345364136359115443)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_button_name=>'p17_documentos'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Documentos'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=CONS_GED_&P_BASE.:865:&SESSION.::&DEBUG.:RP,865:P865_EMP,P865_MAT,P865_TIPO:&P17_EMP.,&P17_MAT.,COLABORADOR'
,p_icon_css_classes=>'fa-book'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63092403867436464463)
,p_name=>'P17_TP_REGISTRO_PONTO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>unistr('Tipo de Marca\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(63092403999663464464)
,p_name=>'P17_MARCA_PONTO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>'Marca Ponto'
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
 p_id=>wwv_flow_api.id(63092404110779464465)
,p_name=>'P17_TOLER_PONTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>unistr('Toler\00E2ncia')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(63092404125285464466)
,p_name=>'P17_PENOSIDADE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>'Penosidade'
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
 p_id=>wwv_flow_api.id(79821415635775685032)
,p_name=>'P17_TMPRESID'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Tempo Resid\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Prazo indeterminado;1,Prazo determinado;2'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(101208231457476014525)
,p_name=>'P17_NR_RESERVISTA'
,p_item_sequence=>608
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('N\00BA Reservista')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107421467763045780036)
,p_name=>'P17_NOME_SOCIAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_prompt=>'Nome Social'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(137475479969705497557)
,p_name=>'P17_IND_CONTR_SINDICAL'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>'Pagou Sindicato no Ano ?'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(272421563744585781395)||'.'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(137475480224856497559)
,p_name=>'P17_DESC_CONTRIB_ASSIST'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>unistr('Paga Contribui\00E7\00E3o Sindicato ?')
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(272421563744585781395)||'.'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140735890422877195020)
,p_name=>'P17_DESCR_MOT_SIT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_prompt=>unistr('Mot Altera\00E7\00E3o Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268868551921384611658)
,p_name=>'P17_TIPO_MODALIDADE'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Tipo de Modalidade'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Presencial;P,Semi-Presencial;S,Home-Office;H,Teletrabalho;T'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>6
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268868552835296611667)
,p_name=>'P17_VLR_AUX_TIPO_MODALIDADE'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Valor de Aux\00EDlio (Tipo de Modalidade)')
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269040366941600171019)
,p_name=>'P17_OPEN_MODAL'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269040367332109171023)
,p_name=>'P17_PAGE_MODAL'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269040367495825171024)
,p_name=>'P17_APP_MODAL'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269040367539906171025)
,p_name=>'P17_URL_MODAL'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269040367688605171026)
,p_name=>'P17_PARAM_MODAL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269040367796793171027)
,p_name=>'P17_PARAM_VALUES_MODAL'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(280864457989475824575)
,p_name=>'P17_REMUNERACAO_VARIAVEL'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Benef\00EDcios')
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(280864458131893824576)
,p_name=>'P17_PERC_BENEFICIO_VARIAVEL'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('% Benef\00EDcios')
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(280864458198520824577)
,p_name=>'P17_TOTAL_REMUNERACAO'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Total Remunera\00E7\00E3o')
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462269553247567715)
,p_name=>'P17_FOTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = :P17_EMP',
'                  and matricula   = :P17_MAT',
'                  ), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P17_EMP || ''|'' || :P17_MAT',
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
 p_id=>wwv_flow_api.id(281462269963246567718)
,p_name=>'P17_COD_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462271554466567720)
,p_name=>'P17_NOME_EMPRESA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462271865454567720)
,p_name=>'P17_MATRICULA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462273547379567721)
,p_name=>'P17_EMP'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462273924488567721)
,p_name=>'P17_MAT'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462274268211567721)
,p_name=>'P17_NOME'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462275870266567724)
,p_name=>'P17_DT_ADMISSAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_prompt=>unistr('Data Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462276720141567724)
,p_name=>'P17_SITUACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462278363962567726)
,p_name=>'P17_SEXO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Sexo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Masculino;M,Feminino;F'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462278753407567727)
,p_name=>'P17_DESC_EST_CIV'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Estado Civil'
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
 p_id=>wwv_flow_api.id(281462279078503567727)
,p_name=>'P17_DT_NASC'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Data de Nascimento'
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
 p_id=>wwv_flow_api.id(281462279556163567727)
,p_name=>'P17_DESCR_PAIS_NACIONALIDADE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Pa\00EDs Nacionalidade')
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
 p_id=>wwv_flow_api.id(281462279871440567727)
,p_name=>'P17_UF_NACTO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'UF Nascimento'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462280348254567728)
,p_name=>'P17_DESCR_PAIS_NASCIMENTO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Pa\00EDs Nascimento')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462280740546567728)
,p_name=>'P17_NACIONALIDADE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Nacionalidade'
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
 p_id=>wwv_flow_api.id(281462281083282567728)
,p_name=>'P17_DESCR_GRP_ETNICO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Grupo \00C9tnico')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462281497027567729)
,p_name=>'P17_DESC_INSTR'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Grau de Instru\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462281949865567729)
,p_name=>'P17_NOME_FORMACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Forma\00E7\00E3o')
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
 p_id=>wwv_flow_api.id(281462282334199567729)
,p_name=>'P17_DISPLAY1_2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462283101729567730)
,p_name=>'P17_NOME_LOGRADOURO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462283512154567731)
,p_name=>'P17_ENDERECO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Endere\00E7o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462283872090567731)
,p_name=>'P17_BAIRRO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462284300778567731)
,p_name=>'P17_DISPLAY1_2_2_1_1_1'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462284749460567731)
,p_name=>'P17_CIDADE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462285147525567732)
,p_name=>'P17_UF'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462285561621567732)
,p_name=>'P17_CEP'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462285959055567732)
,p_name=>'P17_DISPLAY1_1'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462286285766567732)
,p_name=>'P17_NUMERO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462286732287567733)
,p_name=>'P17_COMPLEM'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462287082377567733)
,p_name=>'P17_COMPLEMENTO_CEP'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462287502607567733)
,p_name=>'P17_NOME_MAE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Nome da M\00E3e')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462289162553567734)
,p_name=>'P17_DDD'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Telefone'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462289473292567734)
,p_name=>'P17_TELEFONE'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462289869814567735)
,p_name=>'P17_DDD_CELULAR'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Celular'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462290671839567735)
,p_name=>'P17_CELULAR'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462291493249567736)
,p_name=>'P17_E_MAIL_FUNCIONAL'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'E-mail Funcional'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462291922652567736)
,p_name=>'P17_E_MAIL_PESSOAL'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'E-Mail Pessoal'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462293134297567738)
,p_name=>'P17_IND_DEF_FIS'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Deficiente'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462293497983567738)
,p_name=>'P17_IND_DEF_FIS_BR'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Deficiente Reabilitado'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462293936725567738)
,p_name=>'P17_RAIS_IND_DEF_AUDITIVA'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Defici\00EAncia Auditiva')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462294340832567738)
,p_name=>'P17_RAIS_IND_DEF_FISICO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Defici\00EAncia F\00EDsica')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462294673690567739)
,p_name=>'P17_RAIS_IND_DEF_MENTAL'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Defici\00EAncia Mental')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462295114701567739)
,p_name=>'P17_RAIS_IND_DEF_MULTIPLA'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Defici\00EAncia Multipla')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462295510709567739)
,p_name=>'P17_RAIS_IND_DEF_VISUAL'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>unistr('Defici\00EAncia Visual')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462295914441567741)
,p_name=>'P17_DISPLAY1_1_1_1_1'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462296344018567742)
,p_name=>'P17_BANCO'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Banco'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462296670133567742)
,p_name=>'P17_AGENCIA'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462297154660567742)
,p_name=>'P17_NUM_CONTA'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462297504179567742)
,p_name=>'P17_DC_CONTA'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462297867150567743)
,p_name=>'P17_MODALIDADE'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Modalidade'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462298336360567743)
,p_name=>'P17_TIPO_CONTA'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462298756976567743)
,p_name=>'P17_DESCR_TP_BANC'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Descr. Tipo de Conta'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462299157904567744)
,p_name=>'P17_DISPLAY1_2_1_1_1_1_1_1'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462300293822567745)
,p_name=>'P17_NUM_IDENTIDADE'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('N\00BA de Identidade')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462300763607567745)
,p_name=>'P17_TIPO_IDENT'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>'Tipo de Identidade'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462301068310567745)
,p_name=>'P17_EMISSAO_IDENT'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('Data de Emiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462301489966567746)
,p_name=>'P17_EST_EMIS_IDENT'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('Estado de Emiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462301881588567746)
,p_name=>'P17_NUM_CART_PROF'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('N\00BA de Carteira Profissional')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462302271173567746)
,p_name=>'P17_SER_CART_PROF'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462303488432567747)
,p_name=>'P17_NUM_TIT_ELEITOR'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('N\00BA de T\00EDtulo de Eleitor')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462303868353567747)
,p_name=>'P17_ZON_TIT_ELEITOR'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462304312575567747)
,p_name=>'P17_SEC_TIT_ELEITOR'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462305072758567748)
,p_name=>'P17_NUM_PIS_PASEP'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>'PIS/PASEP'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462306699697567749)
,p_name=>'P17_NUM_CPF'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('N\00BA de CPF')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462308362706567750)
,p_name=>'P17_DC_CPF'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462308706973567750)
,p_name=>'P17_RESIDE_BRASIL'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>'Reside no Brasil'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462309073999567751)
,p_name=>'P17_CLASS_TRAB_ESTRANG'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281462277936847567725)
,p_prompt=>'Classif. Estrangeiro'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC(,):Refugiado1Solicitante de ref\00FAgio2Perman\00EAncia no Brasil em raz\00E3o de reuni\00E3o familiar3Beneficiado pelo acordo entre pa\00EDses do Mercosul4Dependente de agente diplom\00E1tico e/ou consular de5Beneficiado pelo Tratado de Amizade, Coopera\00E7')
||unistr('\00E3o e6Outra condi\00E7\00E3o7')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462310278758567751)
,p_name=>'P17_NR_RIC'
,p_item_sequence=>600
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('Registro de Identifica\00E7\00E3o Civil')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462310731707567752)
,p_name=>'P17_ORGAO_EMIS_RIC'
,p_item_sequence=>680
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462311069565567752)
,p_name=>'P17_DT_EMIS_RIC'
,p_item_sequence=>690
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462312305578567753)
,p_name=>'P17_FILIAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462312705656567753)
,p_name=>'P17_NOME_FILIAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462313121329567754)
,p_name=>'P17_DT_FILIAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Data de Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462313484769567754)
,p_name=>'P17_COD_CCUSTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'C.Custo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462313910864567754)
,p_name=>'P17_NOME_CCUSTO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462314325643567754)
,p_name=>'P17_DT_CCUSTO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Data de C.Custo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462314684854567757)
,p_name=>'P17_CUSTO_CONTAB'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>unistr('C.Custo Cont\00E1bil')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462315505044567757)
,p_name=>'P17_NOME_CCUSTO_CONTAB'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462315950999567757)
,p_name=>'P17_CLASS_CCUSTO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Class. C.Custo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462316732138567758)
,p_name=>'P17_DESCR_CLASS_CCUSTO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462317089025567758)
,p_name=>'P17_UNIDADE_ADM'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Unidade Administrativa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462317480543567758)
,p_name=>'P17_DISPLAY_5_1_1'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462317938915567759)
,p_name=>'P17_DESCR_UNID_ADM'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462318320970567759)
,p_name=>'P17_LOCAL_TRAB'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281462311931102567753)
,p_prompt=>'Local'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462321474326567762)
,p_name=>'P17_VINCULO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>unistr('V\00EDnculo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462322355461567762)
,p_name=>'P17_DESC_VINCULO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462322704130567762)
,p_name=>'P17_SINDICATO'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>'Sindicato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462323467306567763)
,p_name=>'P17_NOME_SINDICATO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462323935555567763)
,p_name=>'P17_SINDICALIZADO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>'Sindicalizado'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462324687434567764)
,p_name=>'P17_ADTO_SALARIAL'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>'Adiantamento Salarial'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462325070453567764)
,p_name=>'P17_PERC_ADIANT'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>'% Adiantamento'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462325507268567764)
,p_name=>'P17_CAT_P_SEFIP'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281462321100408567761)
,p_prompt=>'Categoria Sefip'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462326732670567765)
,p_name=>'P17_CARGO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462327104095567766)
,p_name=>'P17_NOME_CARGO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462327512274567766)
,p_name=>'P17_DT_CARGO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'Data de Cargo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462327918184567766)
,p_name=>'P17_FUNCAO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462328338860567766)
,p_name=>'P17_NOME_FUNCAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462328672392567767)
,p_name=>'P17_DT_FUNCAO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Data de Fun\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462329088095567767)
,p_name=>'P17_COD_CBO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('C\00F3d. CBO')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462329955030567767)
,p_name=>'P17_DC_CBO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462330339592567768)
,p_name=>'P17_CLASS_CARGO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'Class. Cargo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462331093668567769)
,p_name=>'P17_COD_GRUPO_TRABALHO'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('C\00F3d. Grupo de Trabalho')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462331529291567769)
,p_name=>'P17_DISPLAY_6_1_1'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462331941334567769)
,p_name=>'P17_DESCR_GRUPO_TRAB'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462332323854567769)
,p_name=>'P17_SALARIO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Sal\00E1rio')
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462332673164567770)
,p_name=>'P17_DT_SALARIO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Data de Sal\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462333106018567770)
,p_name=>'P17_MOT_ALT_SAL'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Motivo de Altera\00E7\00E3o de Sal\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462333913439567773)
,p_name=>'P17_DESCR_MOT_SAL'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462334299683567774)
,p_name=>'P17_PERC_INSALUB'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'% Insalubridade'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462334677421567774)
,p_name=>'P17_PERC_PERIC'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'% Periculosidade'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462335106416567774)
,p_name=>'P17_COD_TIPO_MAO_OBRA'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Tipo de M\00E3o de Obra')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462335883265567775)
,p_name=>'P17_TIPO_SALARIO'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('Tipo de Sal\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462336665509567776)
,p_name=>'P17_DESC_TIPO_SALARIO'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462337127839567776)
,p_name=>'P17_COD_CATEGORIA'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('C\00F3d. de Categoria')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462337888366567777)
,p_name=>'P17_COD_CAT_GRUPOS_SALARIAIS'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('C\00F3d. Categoria Grupos Salariais')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462338698853567777)
,p_name=>'P17_GRUPO_SALARIAL'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'Grupo Salarial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462339508900567778)
,p_name=>'P17_PONTO_DE_FX'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>'Ponto de Faixa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P17_EMP, :P17_MAT);',
'',
'return v_return;',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462340324656567778)
,p_name=>'P17_NUM_REGISTRO'
,p_item_sequence=>630
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('N\00FAmero de Registro')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462341150337567780)
,p_name=>'P17_REGIAO'
,p_item_sequence=>640
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('Regi\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462341920179567780)
,p_name=>'P17_SIGLA_CONS_REG'
,p_item_sequence=>650
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>'Sigla de Conselho Regional'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462342276098567780)
,p_name=>'P17_DT_EMIS_CONS_REG'
,p_item_sequence=>660
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>unistr('Data de Emiss\00E3o de Conselho Regional')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462342686450567781)
,p_name=>'P17_DT_VAL_CONS_REG'
,p_item_sequence=>670
,p_item_plug_id=>wwv_flow_api.id(281462299924642567744)
,p_prompt=>'Data de Validade de Conselho Regional'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462343466236567782)
,p_name=>'P17_COD_CARGO_CIPA'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_prompt=>unistr('C\00F3digo Cargo CIPA')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462343948295567782)
,p_name=>'P17_DISPLAY_6_1_1_1_1_1_1_1_1_1_1_1_1_1'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462344275191567782)
,p_name=>'P17_DESCR_CARGO_CIPA'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(281462326276070567765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462345076114567783)
,p_name=>'P17_REG_TRAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>'Regime de Trabalho'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(281462346749483567784)
,p_name=>'P17_JORNADA_MENSAL_H'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>'Jornada Mensal Horas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(281462347109653567784)
,p_name=>'P17_JORNADA_MENSAL_M'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281462348329511567785)
,p_name=>'P17_DT_REG_TRAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>'Data de Regime de Trabalho'
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
 p_id=>wwv_flow_api.id(281462349890004567786)
,p_name=>'P17_COD_HORARIO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_prompt=>unistr('C\00F3d. Hor\00E1rio')
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
 p_id=>wwv_flow_api.id(281462351500604567788)
,p_name=>'P17_DESC_HORARIO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281462344673815567783)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281463531877523216052)
,p_name=>'P17_CHAMADOR'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281462267488181567714)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280864458483762824580)
,p_name=>'Show Beneficios'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(280864458457911824579)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280864458627211824581)
,p_event_id=>wwv_flow_api.id(280864458483762824580)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(280864458300133824578)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268868552641216611665)
,p_name=>'Disable Some Items'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868552712945611666)
,p_event_id=>wwv_flow_api.id(268868552641216611665)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P17_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137475480057987497558)
,p_event_id=>wwv_flow_api.id(268868552641216611665)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P17_IND_CONTR_SINDICAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137475480341191497560)
,p_event_id=>wwv_flow_api.id(268868552641216611665)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P17_DESC_CONTRIB_ASSIST'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269040367025203171020)
,p_name=>'Open Modal'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_OPEN_MODAL'
,p_condition_element=>'P17_OPEN_MODAL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269040367999222171030)
,p_event_id=>wwv_flow_api.id(269040367025203171020)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'eval(apex.item("P17_URL_MODAL").getValue());'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281462598033259693259)
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
 p_id=>wwv_flow_api.id(281462352168335567789)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Declare',
'',
'cursor c1 is',
'SELECT COD_EMPRESA,            ',
'NOME_EMPRESA            ,',
'cod_empresa||'' - ''||initcap(nome_empresa) empresa,',
'MATRICULA            ,',
'NOME                ,',
'matricula||'' - ''||initcap(nome) funcionario,',
'sexo                ,',
'initcap(desc_est_civ) desc_est_civ            ,',
'dt_nasc                ,',
'initcap(descr_pais_nascimento) descr_pais_nascimento        ,',
'initcap(descr_pais_nacionalidade) descr_pais_nacionalidade    ,',
'initcap(fnct_nome_nacionalidade (nacionalidade)) nacionalidade,',
'uf_nacto            ,',
'Initcap(descr_grp_etnico) descr_grp_etnico       ,',
'Initcap(desc_instr) desc_instr            ,',
'Initcap(nome_formacao) nome_formacao            ,',
'Initcap(nome_logradouro) nome_logradouro            ,',
'Initcap(nome_logradouro)||'' ''||Initcap(endereco)||'', ''||numero||'' ''||Initcap(complem)||'' - ''||Initcap(bairro)||'' - ''||Initcap(cidade)||''/''||uf||'' cep: ''||LPAD(CEP,5,0)||''-''||LPAD(COMPLEMENTO_CEP,3,0) endereco            ,',
'numero                ,',
'Initcap(complem) complem                ,',
'Initcap(bairro) bairro                ,',
'Initcap(cidade) cidade                ,',
'uf                ,',
'cep  numero_cep              ,',
'complemento_cep            ,',
'LPAD(CEP,5,0)||''-''||LPAD(COMPLEMENTO_CEP,3,0) cep,',
'initcap(nome_mae) nome_mae            ,',
'ddd                ,',
'telefone            ,',
'''(''||ddd||'') ''||telefone ddd_telefone,',
'ddd_celular            ,',
'celular                ,',
'''(''||ddd_celular||'') ''||celular ddd_telefone_celular,',
'e_mail_funcional        ,',
'e_mail_pessoal            ,',
'IND_DEF_FIS            ,',
'IND_DEF_FIS_BR            ,',
'RAIS_IND_DEF_AUDITIVA        ,',
'RAIS_IND_DEF_FISICO        ,',
'RAIS_IND_DEF_MENTAL        ,',
'RAIS_IND_DEF_MULTIPLA        ,',
'RAIS_IND_DEF_VISUAL        ,',
unistr('''Banco: ''||BANCO||'' Ag\00EAncia: ''||AGENCIA||'' N\00BA Conta: ''||NUM_CONTA||'' D\00EDgito: ''||dc_conta BANCO,'),
'AGENCIA                ,',
'NUM_CONTA            ,',
'DC_CONTA            ,',
'MODALIDADE            ,',
'cod_tp_trans_bca TIPO_CONTA            ,',
'initcap(DESCR_TP_BANC) descr_tp_banc            ,',
'num_identidade            ,',
'tipo_ident            ,',
'emissao_ident            ,',
'est_emis_ident            ,',
'num_cart_prof||''-''||ser_cart_prof NUM_CART_PROF            ,',
'ser_cart_prof            ,',
unistr('''N\00BA: ''||num_tit_eleitor||'' Zona: ''||zon_tit_eleitor||'' Se\00E7\00E3o: ''||sec_tit_eleitor num_tit_eleitor,'),
'zon_tit_eleitor            ,',
'sec_tit_eleitor            ,',
'num_pis_pasep            ,',
'num_cpf                ,',
'dc_cpf                ,',
' SUBSTR(LPAD(NUM_CPF,9,0),1,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF,9,0),4,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF,9,0),7,3)||''-''||',
' LPAD(DC_CPF,2,0) CPF_FUNC,',
'RESIDE_BRASIL            ,',
'CLASS_TRAB_ESTRANG        ,',
unistr('''N\00BA: ''||NR_RIC||'' \00D3rg\00E3o: ''||ORGAO_EMIS_RIC||'' Data: ''||DT_EMIS_RIC NR_RIC,'),
'ORGAO_EMIS_RIC            ,',
'DT_EMIS_RIC            ,',
'DT_EMIS_CONS_REG        ,',
'DT_VAL_CONS_REG            ,',
'dt_admissao            ,',
'situacao||'' - ''||Initcap(nome_situacao)||'' - ''||dt_situacao SITUACAO ,',
'Initcap(nome_situacao) desc_situacao            ,',
'dt_situacao            ,',
'filial||'' - ''||Initcap(nome_filial) filial                ,',
'Initcap(nome_filial) nome_filial            ,',
'dt_filial            ,',
'cod_ccusto ||'' - ''||Initcap(nome_ccusto) cod_ccusto           ,',
'Initcap(nome_ccusto) nome_ccusto            ,',
'dt_ccusto            ,',
'custo_contab||'' - ''||Initcap(nome_ccusto_contab)  ccusto_contab          ,',
'Initcap(nome_ccusto_contab) nome_ccusto_contab        ,',
'CLASS_CCUSTO||'' - ''||Initcap(DESCR_CLASS_CCUSTO) class_ccusto            ,',
'Initcap(DESCR_CLASS_CCUSTO) descr_class_ccusto        ,',
'unidade_adm||'' - ''||Initcap(descr_unid_adm) unidade_adm             ,',
'Initcap(descr_unid_adm) descr_unid_adm            ,',
'cod_localizacao||'' - ''||descr_local local_trab            ,',
'--descr_local nome_local_trab            ,',
'--local_trab            ,',
'--nome_local_trab            ,',
'--ramal1                ,',
'--ramal2                ,',
'--predio                ,',
'--andar                ,',
'--sala                ,',
'cargo||'' - ''||Initcap(nome_cargos) cargo                ,',
'Initcap(nome_cargos) nome_cargo            ,',
'dt_cargo            ,',
'funcao||'' - ''||Initcap(nome_funcao) funcao                ,',
'Initcap(nome_funcao) nome_funcao            ,',
'dt_cargo dt_funcao            ,',
'cod_cbo||''-''||dc_cbo cod_cbo                ,',
'dc_cbo                ,',
'class_cargo            ,',
'cod_grupo_trabalho||'' - ''||Initcap(descr_grupo_trab) cod_grupo_trabalho        ,',
'Initcap(descr_grupo_trab) descr_grupo_trab        ,',
'DECODE (F_Acesso_Salario_Apex (COD_EMPRESA, MATRICULA, FILIAL, :P_USUARIO),''S'', SALARIO,0) SALARIO,',
'DT_SALARIO            ,',
'MOT_ALT_SAL||'' - ''||Initcap(DESCR_MOT_SAL) mot_alt_sal            ,',
'Initcap(DESCR_MOT_SAL) descr_mot_sal            ,',
'PERC_INSALUB            ,',
'PERC_PERIC            ,',
'decode(COD_TIPO_MAO_OBRA,''D'', ''Direta'',''I'',''Indireta'',cod_tipo_mao_obra) cod_tipo_mao_obra,',
'Initcap(FNCT_NOME_TIPO_SALARIO(TIPO_SALARIO)) tipo_salario            ,',
'--desc_tipo_salario        ,',
'COD_CATEGORIA            ,',
'COD_CAT_GRUPOS_SALARIAIS    ,',
'GRUPO_SALARIAL            ,',
'PONTO_DE_FX            ,',
'NUM_REGISTRO            ,',
'REGIAO                ,',
'SIGLA_CONS_REG            ,',
'COD_CARGO_CIPA||'' - ''||DESCR_CARGO_CIPA cod_cargo_cipa            ,',
'DESCR_CARGO_CIPA        ,',
'vinculo||'' - ''||Initcap(nome_vinculo) vinculo                ,',
'Initcap(nome_vinculo) desc_vinculo         ,',
'SINDICALIZADO            ,',
'NUM_SIND_DISs||'' - ''||Initcap(NOME_SINDICATO) num_sind_diss          ,',
'Initcap(NOME_SINDICATO) nome_sindicato            ,',
'NUM_SIND_CAT            ,',
'Initcap(NOME_SIND_CAT) nome_sind_cat            ,',
'ADTO_SALARIAL            ,',
'PERC_ADIANT            ,',
'CAT_P_SEFIP            ,',
'reg_trab            ,',
'''Horas: ''||jornada_mensal_h||'' Minutos: ''||jornada_mensal_m   jornada_mensal_h    ,',
'jornada_mensal_m        ,',
'dt_reg_trab            ,',
'COD_HORARIO||'' - ''||Initcap(DESC_HORARIO) cod_horario            ,',
'Initcap(DESC_HORARIO) desc_horario         ,',
'remuneracao_variavel,',
'perc_beneficio_variavel,',
'total_remuneracao,',
'tipo_modalidade,',
'vlr_aux_tipo_modalidade,',
'mot_alt_situacao||'' - ''||descr_mot_sit desc_mot_sit,',
'IND_CONTR_SINDICAL,',
'DESC_CONTRIB_ASSIST,',
'NOME_SOCIAL,',
'CERTIF_RESERV,',
'TMPRESID,',
unistr('DECODE(MARCA_PONTO,''S'',''Sim'',''N'',''N\00E3o'') MARCA_PONTO,'),
'tp_registro_ponto',
'FROM VW_CONSULTA_PESS_FUNC_V1 i--VW_CONSULTA_PESS_FUNC',
'where cod_empresa = :p17_EMP',
'  and matricula = :p17_MAT',
'  AND ((I.COD_EMPRESA = :P_EMPRESA_USER AND I.MATRICULA = :P_MATRICULA_USER)',
'OR EXISTS (SELECT 1',
'             FROM USUARIO_ORACLE U, INFORMACOES_FUNCIONAIS IX',
'            WHERE U.CD_EMPRESA = IX.COD_EMPRESA (+)',
'              AND U.CD_MATRICULA = IX.MATRICULA (+)',
'              AND u.cd_empresa_negativa <> I.cod_empresa',
'              AND u.cd_matricula_negativa <> I.matricula',
'              AND U.NM_USUARIO_ORACLE = :P_USUARIO',
'              AND EXISTS (SELECT 1 ',
'                            FROM USUARIO_ORACLE_FILIAIS UF',
'                           WHERE UF.CD_EMPRESA = I.COD_EMPRESA',
'                             AND UF.CD_FILIAL = I.FILIAL',
'                             AND UF.NM_USUARIO_ORACLE = U.NM_USUARIO_ORACLE)',
'              AND EXISTS (SELECT 1 ',
'                            FROM USUARIO_ORACLE_CCUSTO UC',
'                           WHERE UC.COD_EMPRESA = I.COD_EMPRESA',
'                             AND UC.COD_CCUSTO = I.COD_CCUSTO',
'                             AND UC.NM_USUARIO_ORACLE = U.NM_USUARIO_ORACLE)',
'              AND EXISTS (SELECT 1',
'                            FROM organizacao_detalhe od',
'                           WHERE od.cd_nivel_pai = U.cd_nivel',
'                             AND od.cd_nivel_filho = I.CD_NIVEL',
'                             AND od.cd_nivel_filho IS NOT NULL',
'                             AND od.cd_nivel_filho <> u.cd_nivel_negativo)',
'              AND ((:P_PAINEL = ''PO'') OR ',
'                   (NVL(u.pg_visualiza_diretos,''S'') = ''N'' or (',
'           EXISTS (SELECT 1',
'                             FROM centro_de_custo cx',
'                            WHERE cx.cod_empresa = i.cod_empresa',
'                              AND cx.cod = i.cod_ccusto',
'                              AND cx.cod_emp_gestor = u.cd_empresa',
'                              AND cx.matricula_gestor = u.cd_matricula',
'                           UNION',
'                           SELECT 1',
'                             FROM centro_de_custo cy',
'                            WHERE cy.cod_emp_gestor = i.cod_empresa ',
'                              AND cy.matricula_gestor = i.matricula',
'                              AND cy.cod_ccusto_superior = ix.cod_ccusto',
'                          union',
'                           SELECT 1',
'                           FROM SUB_CCUSTO S',
'                          WHERE S.COD_EMPRESA = I.COD_EMPRESA',
'                            AND S.COD_CCUSTO = I.COD_CCUSTO',
'                            AND S.COD_SUB_CCUSTO = I.COD_SUB_CCUSTO',
'                            AND s.cod_emp_gestor = :P_EMPRESA_USER',
'                            and s.mat_gestor = :P_MATRICULA_USER',
'                           ))))',
'           ));',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
unistr('select ''Local: ''||i.cod_localizacao||'' - ''||Initcap(l.descricao)||'', Pr\00E9dio: ''||l.predio||'', Andar: ''||l.andar||'', Sala: ''||l.sala||'', Ramal 1: ''||i.ramal1||'', Ramal 2: ''||i.ramal2 local'),
'  from informacoes_funcionais i, local_trab l',
' where i.cod_localizacao = l.cod_local_trab',
'   and i.cod_empresa = :p17_EMP',
'   and i.matricula   = :p17_MAT;',
'',
'v_c2 c2%rowtype;',
'',
'cursor c3 (v_cod varchar2) is',
'  select DESCRICAO desc_cat_grupos_salariais',
'    from categoria_grupos_salariais',
'   WHERE COD_CAT_GRUPOS_SALARIAIS = v_cod',
'     and rownum <=1;',
'',
'v_c3 c3%rowtype;',
'',
'begin',
'',
'open  c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.matricula is not null then',
'',
'open  c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'open  c3(v_c1.cod_cat_grupos_salariais);',
'fetch c3 into v_c3;',
'close c3;',
'',
'end if;',
'',
'/*',
':p17_emp := v_c1.cod_empresa;',
':p17_mat := v_c1.matricula;',
'*/',
':p17_cod_empresa := v_c1.empresa;--v_c1.cod_empresa;',
'--:p17_nome_empresa := v_c1.nome_empresa;',
':p17_matricula := v_c1.funcionario; --v_c1.matricula;',
'--:p17_nome := v_c1.nome;',
'',
'-- Dados Pessoais ---',
':P17_sexo            := v_c1.sexo                 ;',
':P17_desc_est_civ        :=  v_c1.desc_est_civ             ;',
':P17_dt_nasc            :=  v_c1.dt_nasc             ;',
':P17_descr_pais_nascimento    :=  v_c1.descr_pais_nascimento     ;',
':P17_descr_pais_nacionalidade    :=  v_c1.descr_pais_nacionalidade  ;',
':P17_nacionalidade        :=  v_c1.nacionalidade         ;',
':P17_uf_nacto            :=  v_c1.uf_nacto             ;',
':P17_descr_grp_etnico        :=  v_c1.descr_grp_etnico         ;',
':P17_desc_instr            :=  v_c1.desc_instr             ;',
':P17_nome_formacao        :=  v_c1.nome_formacao         ;',
':P17_nome_logradouro        :=  v_c1.nome_logradouro         ;',
':P17_endereco            :=  v_c1.endereco             ;',
':P17_numero            :=  v_c1.numero             ;',
':P17_complem            :=  v_c1.complem             ;',
':P17_bairro            :=  v_c1.bairro             ;',
':P17_cidade            :=  v_c1.cidade             ;',
':P17_uf                :=  v_c1.uf                 ;',
':P17_cep                :=  v_c1.cep                 ;',
':P17_complemento_cep        :=  v_c1.complemento_cep         ;',
':P17_nome_mae            :=  v_c1.nome_mae             ;',
':P17_ddd                :=  v_c1.ddd_telefone                 ;',
':P17_telefone            :=  v_c1.telefone             ;',
':P17_ddd_celular            :=  v_c1.ddd_telefone_celular             ;',
':P17_celular            :=  v_c1.celular             ;',
':P17_e_mail_funcional        :=  v_c1.e_mail_funcional         ;',
':P17_e_mail_pessoal        :=  v_c1.e_mail_pessoal         ;',
':P17_IND_DEF_FIS            :=  v_c1.IND_DEF_FIS             ;',
':P17_IND_DEF_FIS_BR        :=  v_c1.IND_DEF_FIS_BR         ;',
':P17_RAIS_IND_DEF_AUDITIVA    :=  v_c1.RAIS_IND_DEF_AUDITIVA     ;',
':P17_RAIS_IND_DEF_FISICO        :=  v_c1.RAIS_IND_DEF_FISICO         ;',
':P17_RAIS_IND_DEF_MENTAL        :=  v_c1.RAIS_IND_DEF_MENTAL         ;',
':P17_RAIS_IND_DEF_MULTIPLA    :=  v_c1.RAIS_IND_DEF_MULTIPLA     ;',
':P17_RAIS_IND_DEF_VISUAL        :=  v_c1.RAIS_IND_DEF_VISUAL         ;',
':P17_BANCO            :=  v_c1.BANCO             ;',
':P17_AGENCIA            :=  v_c1.AGENCIA             ;',
':P17_NUM_CONTA            :=  v_c1.NUM_CONTA             ;',
':P17_DC_CONTA            :=  v_c1.DC_CONTA             ;',
':P17_MODALIDADE            :=  v_c1.MODALIDADE             ;',
':P17_TIPO_CONTA            :=  v_c1.TIPO_CONTA             ;',
':P17_DESCR_TP_BANC        :=  v_c1.DESCR_TP_BANC         ;',
':P17_DESCR_mot_sit        :=  v_c1.desc_mot_sit;',
':P17_NOME_SOCIAL          := V_C1.NOME_SOCIAL;',
'',
'',
'-- Documentos ---',
':P17_num_identidade        :=  v_c1.num_identidade        ;',
':P17_tipo_ident            :=  v_c1.tipo_ident            ;',
':P17_emissao_ident        :=  v_c1.emissao_ident        ;',
':P17_est_emis_ident        :=  v_c1.est_emis_ident        ;',
':P17_num_cart_prof        :=  v_c1.num_cart_prof        ;',
':P17_ser_cart_prof        :=  v_c1.ser_cart_prof        ;',
':P17_num_tit_eleitor        :=  v_c1.num_tit_eleitor        ;',
':P17_zon_tit_eleitor        :=  v_c1.zon_tit_eleitor        ;',
':P17_sec_tit_eleitor        :=  v_c1.sec_tit_eleitor        ;',
':P17_num_pis_pasep        :=  v_c1.num_pis_pasep        ;',
':P17_num_cpf            :=  v_c1.cpf_func; --v_c1.num_cpf            ;',
':P17_dc_cpf            :=  v_c1.dc_cpf            ;',
':P17_RESIDE_BRASIL        :=  v_c1.RESIDE_BRASIL        ;',
':P17_CLASS_TRAB_ESTRANG        :=  v_c1.CLASS_TRAB_ESTRANG        ;',
':P17_TMPRESID        :=  v_c1.TMPRESID        ;',
':P17_NR_RIC                :=  v_c1.NR_RIC            ;',
':P17_NR_RESERVISTA         := v_c1.CERTIF_RESERV;',
':P17_ORGAO_EMIS_RIC        :=  v_c1.ORGAO_EMIS_RIC        ;',
':P17_DT_EMIS_RIC            :=  v_c1.DT_EMIS_RIC            ;',
':P17_DT_EMIS_CONS_REG        :=  v_c1.DT_EMIS_CONS_REG        ;',
':P17_DT_VAL_CONS_REG        :=  v_c1.DT_VAL_CONS_REG        ;',
'',
unistr('-- Identifica\00E7\00E3o ---                       ;'),
':P17_dt_admissao            :=  v_c1.dt_admissao          ;',
':P17_situacao            :=  v_c1.situacao     ;',
'--:P17_desc_situacao        :=  v_c1.desc_situacao  ;',
'--:P17_dt_situacao            :=  v_c1.dt_situacao       ;',
'',
unistr('-- Lota\00E7\00E3o ---'),
':P17_filial            :=  v_c1.filial            ;',
':P17_nome_filial            :=  v_c1.nome_filial            ;',
':P17_dt_filial            :=  v_c1.dt_filial            ;',
':P17_cod_ccusto            :=  v_c1.cod_ccusto            ;',
':P17_nome_ccusto            :=  v_c1.nome_ccusto            ;',
':P17_dt_ccusto            :=  v_c1.dt_ccusto            ;',
':P17_custo_contab        :=  v_c1.ccusto_contab        ;',
':P17_nome_ccusto_contab        :=  v_c1.nome_ccusto_contab        ;',
':P17_CLASS_CCUSTO        :=  v_c1.CLASS_CCUSTO            ;',
':P17_DESCR_CLASS_CCUSTO        :=  v_c1.DESCR_CLASS_CCUSTO        ;',
':P17_unidade_adm            :=  v_c1.unidade_adm            ;',
':P17_descr_unid_adm        :=  v_c1.descr_unid_adm        ;',
':P17_local_trab            :=  v_c2.local            ;',
'/*:P17_nome_local_trab        :=  v_c1.nome_local_trab        ;',
':P17_ramal1            :=  v_c1.ramal1            ;',
':P17_ramal2            :=  v_c1.ramal2            ;',
':P17_predio            :=  v_c1.predio            ;',
':P17_andar            := v_c1. andar            ;',
':P17_sala            :=  v_c1.sala                ;*/',
'',
'-- Cargo ---',
':P17_cargo            :=  v_c1.cargo            ;',
':P17_nome_cargo            :=  v_c1.nome_cargo            ;',
':P17_dt_cargo            := v_c1.dt_cargo            ;',
':P17_funcao            :=  v_c1.funcao            ;',
':P17_nome_funcao            :=  v_c1.nome_funcao            ;',
':P17_dt_funcao            :=  v_c1.dt_funcao            ;',
':P17_cod_cbo            :=  v_c1.cod_cbo            ;',
':P17_dc_cbo            :=  v_c1.dc_cbo            ;',
':P17_class_cargo            :=  v_c1.class_cargo            ;',
':P17_cod_grupo_trabalho        :=  v_c1.cod_grupo_trabalho        ;',
':P17_descr_grupo_trab    :=  v_c1.descr_grupo_trab        ;',
':P17_SALARIO            := v_c1.SALARIO            ;',
':P17_DT_SALARIO            :=  v_c1.DT_SALARIO            ;',
':P17_MOT_ALT_SAL            :=  v_c1.MOT_ALT_SAL            ;',
':P17_DESCR_MOT_SAL        :=  v_c1.DESCR_MOT_SAL        ;',
':P17_PERC_INSALUB        :=  v_c1.PERC_INSALUB            ;',
':P17_PERC_PERIC            :=  v_c1.PERC_PERIC            ;',
':P17_COD_TIPO_MAO_OBRA        :=  v_c1.COD_TIPO_MAO_OBRA        ;',
':P17_tipo_salario        :=  v_c1.tipo_salario            ;',
'--:P17_desc_tipo_salario        :=  v_c1.desc_tipo_salario        ;',
':P17_COD_CATEGORIA        :=  v_c1.COD_CATEGORIA        ;',
':P17_COD_CAT_GRUPOS_SALARIAIS    :=  v_c1.COD_CAT_GRUPOS_SALARIAIS||'' - ''||v_c3.desc_cat_grupos_salariais;',
':P17_GRUPO_SALARIAL        :=  v_c1.GRUPO_SALARIAL        ;',
':P17_PONTO_DE_FX            :=  v_c1.PONTO_DE_FX            ;',
':P17_NUM_REGISTRO        :=  v_c1.NUM_REGISTRO            ;',
':P17_REGIAO            :=  v_c1.REGIAO            ;',
':P17_SIGLA_CONS_REG        :=  v_c1.SIGLA_CONS_REG        ;',
':P17_COD_CARGO_CIPA        :=  v_c1.COD_CARGO_CIPA        ;',
':P17_DESCR_CARGO_CIPA        :=  v_c1.DESCR_CARGO_CIPA        ;',
'                            ',
'-- Folha ---                        ',
':P17_vinculo            :=  v_c1.vinculo            ;',
':P17_desc_vinculo        :=  v_c1.desc_vinculo            ;',
':P17_SINDICALIZADO        :=  v_c1.SINDICALIZADO        ;',
':P17_SINDICATO        :=  v_c1.NUM_SIND_DISS            ;',
':P17_NOME_SINDICATO        :=  v_c1.NOME_SINDICATO        ;',
'--:P17_NUM_SIND_CAT        :=  v_c1.NUM_SIND_CAT            ;',
'--:P17_NOME_SIND_CAT        :=  v_c1.NOME_SIND_CAT        ;',
':P17_ADTO_SALARIAL        :=  v_c1.ADTO_SALARIAL        ;',
':P17_PERC_ADIANT            :=  v_c1.PERC_ADIANT            ;',
':P17_CAT_P_SEFIP            :=  v_c1.CAT_P_SEFIP            ;',
'                    ',
unistr('-- Hor\00E1rio ---                '),
':P17_reg_trab            :=  v_c1.reg_trab            ;',
':P17_jornada_mensal_h        :=  v_c1.jornada_mensal_h        ;',
':P17_jornada_mensal_m        :=  v_c1.jornada_mensal_m        ;',
':P17_dt_reg_trab            :=  v_c1.dt_reg_trab            ;',
':P17_COD_HORARIO            :=  v_c1.COD_HORARIO            ;',
':P17_DESC_HORARIO        :=  v_c1.DESC_HORARIO            ;',
'',
':P17_remuneracao_variavel := v_c1.remuneracao_variavel;',
':P17_perc_beneficio_variavel := v_c1.perc_beneficio_variavel;',
':P17_total_remuneracao := v_c1.total_remuneracao;',
'',
':P17_tipo_modalidade := v_c1.tipo_modalidade;',
':P17_VLR_AUX_TIPO_MODALIDADE := v_c1.VLR_AUX_TIPO_MODALIDADE;',
'                 ',
':p17_param_modal := replace(:p17_param_modal,''$'','','');',
':p17_param_values_modal := replace(:p17_param_values_modal,''$'','','');        ',
'',
'/* Chamado 30489 - Inclusao de duas novas colunas - Andre - 12-07-2023*/',
':P17_IND_CONTR_SINDICAL := v_c1.IND_CONTR_SINDICAL;                ',
':P17_DESC_CONTRIB_ASSIST := v_c1.DESC_CONTRIB_ASSIST;    ',
':P17_TP_REGISTRO_PONTO   := v_c1.TP_REGISTRO_PONTO;',
':P17_MARCA_PONTO         := v_c1.MARCA_PONTO;',
'             ',
'             ',
unistr('select toler_ponto,decode(PENOSIDADE,''N'',''N\00E3o'',''S'',''Sim'')'),
'into :P17_toler_ponto, :P17_penosidade',
'from  informacoes_funcionais  ',
'where cod_empresa = v_c1.cod_empresa and',
'      matricula   = v_c1.matricula;',
'             ',
':p17_url_modal :=',
'apex_page.get_url (p_application => nvl(:p17_APP_MODAL,:APP_ID),',
'                   p_page        => :p17_PAGE_MODAL,',
'                   p_items       => :p17_param_modal,',
'                   p_values      => :p17_param_values_modal,',
'                   p_clear_cache => :p17_PAGE_MODAL',
'                   );                ',
'                 ',
'exception',
'when others then',
'null;',
'',
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
