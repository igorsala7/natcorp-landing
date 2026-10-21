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
--   Date and Time:   22:54 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 21
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00021
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>21);
end;
/
prompt --application/pages/page_00021
begin
wwv_flow_api.create_page(
 p_id=>21
,p_user_interface_id=>wwv_flow_api.id(57485040171637710988)
,p_name=>unistr('Hist\00F3rico Financeiro')
,p_step_title=>unistr('Hist\00F3rico Financeiro')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_HistFin.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_HistFin.css'
,p_step_template=>wwv_flow_api.id(57484998059769710817)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_upd_yyyymmddhh24miss=>'20251210141222'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(251571956696510943757)
,p_plug_name=>unistr('Hist\00F3rico Financeiro')
,p_region_name=>'HST'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(57485013654758710892)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'FUNC_BODY_RETURNING_SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_sql varchar2(32767);',
'',
'begin',
'v_sql :=  ''with inf as (select i.cod_empresa, ',
'                    i.matricula',
'               from informacoes_funcionais i',
'              where i.COD_EMPRESA = nvl(:p21_emp, nvl(:p21_empresa, i.cod_empresa))'';',
'',
'-- NATCORP 09/10: sem Pesquisar o relatorio nao roda (abrir a pagina nao paga a consulta inteira).',
'-- Aberto pela ficha do colaborador (P21_MAT), roda como antes.',
'if :P21_MAT is null and nvl(:P21_PESQUISA, ''N'') <> ''S'' then',
'  v_sql := v_sql||'' and 1 = 0'';',
'end if;',
'',
'',
'if :p21_FILIAL_ini is not null then',
'  v_sql := v_sql||'' and i.FILIAL BETWEEN :p21_FILIAL_ini and :p21_FILIAL_fim'';',
'end if;',
'',
'if :p21_CCUSTO_ini is not null then',
'  v_sql := v_sql||'' and i.COD_CCUSTO BETWEEN :p21_CCUSTO_ini and :p21_CCUSTO_fim'';',
'end if;',
'',
'if :p21_dt_adm_ini is not null then',
'  v_sql := v_sql||'' and i.dt_admissao_basica between :p21_dt_adm_ini and :p21_dt_adm_fim'';',
'end if;',
'',
'if :P21_SINDICATO is not null then',
'  v_sql := v_sql||'' and i.num_sind_diss in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SINDICATO, '''':'''')) t)'';',
'end if;',
'',
'if :P21_SITUACOES is not null then',
'  v_sql := v_sql||'' and i.situacao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SITUACOES, '''':'''')) t)'';',
'end if;',
'',
'if :P21_VINCULOS is not null then',
'  v_sql := v_sql||'' and i.vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_VINCULOS, '''':'''')) t)'';',
'end if;',
'',
'if :p21_matricula_ini is not null then',
'  v_sql := v_sql||'' and i.MATRICULA between nvl(:p21_mat, nvl(:p21_matricula_ini, i.matricula)) and     nvl(:p21_mat, nvl(:p21_matricula_fim, i.matricula))'';',
'end if;',
'',
'--v_sql := v_sql||'' and F_Acesso_PG_Apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel) = ''''S'''''';',
'',
'v_sql := v_sql|| '' ),',
'hist as (select h.cod_empresa, ',
'                    h.matricula,',
'                    h.filial, ',
'                    h.cod_ccusto,',
'                    h.unidade_adm,',
'                    h.cod_atividade,',
'                    h.local_trab,',
'                    h.cod_ccusto_cont,',
'                    h.dt_admissao_basica,',
'                    h.num_sind_diss,',
'                    h.vinculo,',
'                    h.situacao,',
'                    h.dt_situacao,',
'                    h.data_ref,',
'                    h.data_retencao,',
'                    h.cod_ocorr,',
'                    h.nome_ocorrencia,',
'                    h.unidade1,',
'                    h.unidade2,',
'                    h.valor,',
'                    h.dt_inic_val,',
'                    h.dt_fin_val,',
'                    h.horas_ferias,',
'                    h.incid_liq,',
'                    h.ORIGEM,',
'                    h.USUARIO,',
'                    h.DT_ULT_ATLZ,',
'                    h.cod_gerencial,',
'                    h.tipo_rubrica,',
'                    h.cnpj_empresa,',
'                    h.num_cpf cpf,',
'                    h.cod_cargo,',
'                    h.nome_cargo,',
'                    h.dt_admissao',
'               from MWV_HISTORICOS h,',
'                    configuracoes c',
'               where (:P21_DATA_REF is not null and h.data_ref in (select /*+ cardinality (t 1)*/ TO_DATE(column_value,''''DD/MM/YYYY'''') column_value from table(apex_string.split(:P21_DATA_REF, '''':'''')) t))'';',
'               ',
'if :p21_CCUSTO_CONT_ini is not null then',
'v_sql := v_sql|| '' and h.COD_CCUSTO_CONT BETWEEN :p21_CCUSTO_CONT_ini and :p21_CCUSTO_CONT_fim'';',
'end if;',
'',
'if :P21_DT_RETENCAO_INI is not null then',
'v_sql := v_sql|| '' and h.data_retencao between :P21_DT_RETENCAO_INI and :P21_DT_RETENCAO_FIM'';',
'end if;',
'',
'if :P21_tipo_rubrica is not null then',
'v_sql := v_sql|| '' and h.tipo_rubrica in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_tipo_rubrica, '''':'''')) t)'';',
'end if;',
'',
'if :P21_cod_ocorr is not null then',
'v_sql := v_sql|| '' and h.cod_ocorr in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_cod_ocorr, '''':'''')) t)'';',
'end if;',
'',
'',
'v_sql := v_sql|| '' AND h.origem in (:p21_h_finan_acm, :p21_h_ferias, :p21_h_resc, :p21_h_13, :p21_h_adiant, :p21_h_part, :p21_h_Recalc, :p21_h_Diversos, :p21_h_Diversos_Acm)',
'                ',
'                 and ((NVL(:p21_ocultar, ''''N'''') = ''''S'''' AND',
'                     ((c.quatro_digitos_ocorr = ''''S'''' and h.cod_ocorr not in (9996, 9997, 9998, 9999)) or (c.quatro_digitos_ocorr = ''''N'''' and h.cod_ocorr not in (996, 997, 998, 999))) ',
'                      ) OR',
'                     (NVL(:p21_ocultar, ''''N'''') = ''''N'''' AND h.cod_ocorr IS NOT NULL))',
'                AND NOT EXISTS (SELECT 1',
'                                  FROM MWV_HISTORICOS_MES HM ',
'                                 WHERE HM.COD_EMPRESA = H.COD_EMPRESA',
'                                   AND HM.MATRICULA   = H.MATRICULA',
'                                   AND HM.DATA_REF    = H.DATA_REF',
'                                   AND HM.COD_OCORR   = H.COD_OCORR',
'                                   AND HM.ORIGEM      = ''''13 Salario'''')',
'                union all',
'                select h.cod_empresa, ',
'                    h.matricula,',
'                    h.filial, ',
'                    h.cod_ccusto,',
'                    h.unidade_adm,',
'                    h.cod_atividade,',
'                    h.local_trab,',
'                    h.cod_ccusto_cont,',
'                    h.dt_admissao_basica,',
'                    h.num_sind_diss,',
'                    h.vinculo,',
'                    h.situacao,',
'                    h.dt_situacao,',
'                    h.data_ref,',
'                    h.data_retencao,',
'                    h.cod_ocorr,',
'                    h.nome_ocorrencia,',
'                    h.unidade1,',
'                    h.unidade2,',
'                    h.valor,',
'                    h.dt_inic_val,',
'                    h.dt_fin_val,',
'                    h.horas_ferias,',
'                    h.incid_liq,',
'                    h.ORIGEM,',
'                    h.USUARIO,',
'                    h.DT_ULT_ATLZ,',
'                    h.cod_gerencial,',
'                    h.tipo_rubrica,',
'                    h.cnpj_empresa,',
'                    h.num_cpf cpf,',
'                    h.cod_cargo,',
'                    h.nome_cargo,',
'                    h.dt_admissao',
'              from MWV_HISTORICOS_MES h,',
'                    configuracoes c',
'             where (:P21_DATA_REF is not null and h.data_ref in (select /*+ cardinality (t 1)*/ TO_DATE(column_value,''''DD/MM/YYYY'''') column_value  from table(apex_string.split(:P21_DATA_REF, '''':'''')) t))'';',
'',
'if :p21_CCUSTO_CONT_ini is not null then',
'v_sql := v_sql|| '' and h.COD_CCUSTO_CONT BETWEEN :p21_CCUSTO_CONT_ini and :p21_CCUSTO_CONT_fim'';',
'end if;',
'',
'if :P21_DT_RETENCAO_INI is not null then',
'v_sql := v_sql|| '' and h.data_retencao between :P21_DT_RETENCAO_INI and :P21_DT_RETENCAO_FIM'';',
'end if;',
'',
'if :P21_tipo_rubrica is not null then',
'v_sql := v_sql|| '' and tipo_rubrica in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_tipo_rubrica, '''':'''')) t)'';',
'end if;',
'',
'if :P21_cod_ocorr is not null then',
'v_sql := v_sql|| '' and cod_ocorr in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_cod_ocorr, '''':'''')) t)'';',
'end if;',
'',
'v_sql := v_sql|| '' AND h.origem in (:P21_H_FINAN, :P21_H_FERIAS, :P21_H_RESC, :P21_H_13, :P21_H_ADIANT, :P21_H_PART, :P21_H_RECALC, :P21_H_DIVERSOS, :P21_H_DIVERSOS_ACM )',
'               and ((NVL(:p21_ocultar, ''''N'''') = ''''S'''' AND',
'                   ((c.quatro_digitos_ocorr = ''''S'''' and h.cod_ocorr not in (9996, 9997, 9998, 9999)) or (c.quatro_digitos_ocorr = ''''N'''' and h.cod_ocorr not in (996, 997, 998, 999)))',
'                    ) OR',
'                   (NVL(:p21_ocultar, ''''N'''') = ''''N'''' AND h.cod_ocorr IS NOT NULL))',
'        )',
'         select v.cod_empresa,',
'       v.COD_EMPRESA || '''' - '''' ||',
'       (select initcap(fnct_nome_empresa(v.cod_empresa, ''''S'''')) from dual) Empresa,',
'       v.FILIAL || '''' - '''' ||',
'       (select initcap(fnct_nome_filial(v.cod_empresa, v.FILIAL)) from dual) Filial,',
'       v.COD_CCUSTO || '''' - '''' ||',
'       (select initcap(fnct_nome_ccusto(v.cod_empresa, v.cod_ccusto)) from dual) CCusto,',
'       v.unidade_adm || '''' - '''' ||',
'       (select initcap(fnct_nome_unidade_adm(v.cod_empresa, null, v.unidade_adm)) from dual) unidade_adm,',
'       v.cod_atividade || '''' - '''' ||',
'       (select initcap(fnct_nome_atividade(v.cod_atividade)) from dual) atividade,',
'       v.local_trab || '''' - '''' ||',
'       (select initcap(fnct_nome_local_trab(v.local_trab)) from dual) local_trab,',
'       V.cod_ccusto_cont cod_ccusto_contab,',
'       v.cod_ccusto_cont || '''' - '''' ||(select initcap(fnct_nome_ccusto_contab(v.cod_empresa, v.cod_ccusto_cont)) from dual) CCusto_Contab,',
'       v.MATRICULA,',
'       (select Initcap(fnct_nome_func(v.cod_empresa, v.matricula)) from dual) nome,',
'       v.dt_admissao_basica,',
'       v.NUM_SIND_DISS || '''' - '''' ||',
'       (select initcap(fnct_nome_sindicato(v.cod_empresa, v.NUM_SIND_DISS, ''''S'''')) from dual) sindicato,',
'       v.VINCULO,',
'       v.SITUACAO,',
'       v.DT_SITUACAO,',
'       v.DATA_REF,',
'       v.DATA_RETENCAO,',
'       v.COD_OCORR,',
'       Initcap(v.NOME_OCORRENCIA) nome_ocorrencia,',
'       v.UNIDADE1,',
'       v.UNIDADE2,       ',
'       DECODE((select F_Acesso_Salario_Apex(V.COD_EMPRESA, V.MATRICULA, V.FILIAL, :P_USUARIO) from dual),''''S'''',V.VALOR, NULL) VALOR,',
'       v.DT_INIC_VAL,',
'       v.DT_FIN_VAL,',
'       v.HORAS_FERIAS,',
unistr('       decode(v.INCID_LIQ, ''''S'''', ''''Sim'''', ''''N'''', ''''N\00E3o'''') incid_liq,'),
'       v.ORIGEM,',
'       v.USUARIO,',
'       v.DT_ULT_ATLZ,',
'       (select Fnct_Nome_Cod_Gerencial(v.COD_GERENCIAL) from dual) cod_gerencial,',
'       v.tipo_rubrica,',
'       v.cnpj_empresa,',
'       v.cpf cpf,',
'       v.cod_cargo,',
'       v.nome_cargo,',
'       v.dt_admissao',
'  from hist v, inf i',
' where v.cod_empresa = i.cod_empresa',
'   and v.matricula = i.matricula',
'   ORDER BY 1,10,19'';  ',
'',
'  ',
'   RETURN ( v_sql);',
'end;   '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P21_FILIAL_INI,P21_FILIAL_FIM,P21_CCUSTO_INI,P21_CCUSTO_FIM, P21_DT_ADM_INI,P21_DT_ADM_FIM,P21_SINDICATO,P21_SITUACOES, P21_VINCULOS,P21_MATRICULA_INI,P21_DATA_REF,P21_CCUSTO_CONT_INI,P21_CCUSTO_CONT_FIM,P21_DT_RETENCAO_INI,P21_DT_RETENCAO_FIM, P21_T'
||'IPO_R'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(251571957116311943757)
,p_name=>unistr('Hist\00F3rico Financeiro')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>unistr('O m\00E1ximo que este relat\00F3rio suporta \00E9 de #MAX_ROW_COUNT# registros. Por favor, aplique o filtro para reduzir o n\00FAmero de registros.')
,p_no_data_found_message=>unistr('Nenhum Dado Encontrado. Preencha os Par\00E2metros e Pesquise.')
,p_max_rows_per_page=>'50'
,p_allow_save_rpt_public=>'Y'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>224366868069304923641
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441750541138142394)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'AD'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441750925274142394)
,p_db_column_name=>'FILIAL'
,p_display_order=>20
,p_column_identifier=>'AE'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441751259314142394)
,p_db_column_name=>'CCUSTO'
,p_display_order=>30
,p_column_identifier=>'AF'
,p_column_label=>unistr('C.Custo (C\00E9lula)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441749305904142393)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>50
,p_column_identifier=>'AA'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441749746843142393)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>60
,p_column_identifier=>'AB'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441750112161142394)
,p_db_column_name=>'LOCAL_TRAB'
,p_display_order=>70
,p_column_identifier=>'AC'
,p_column_label=>'Local Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441752498764142395)
,p_db_column_name=>'COD_CCUSTO_CONTAB'
,p_display_order=>90
,p_column_identifier=>'D'
,p_column_label=>unistr('C\00F3d. C.Custo Contab.')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441752915035142395)
,p_db_column_name=>'MATRICULA'
,p_display_order=>110
,p_column_identifier=>'E'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441753255118142396)
,p_db_column_name=>'NOME'
,p_display_order=>120
,p_column_identifier=>'F'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441751722971142395)
,p_db_column_name=>'SINDICATO'
,p_display_order=>130
,p_column_identifier=>'AG'
,p_column_label=>'Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441753689739142396)
,p_db_column_name=>'VINCULO'
,p_display_order=>140
,p_column_identifier=>'H'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441754144809142396)
,p_db_column_name=>'SITUACAO'
,p_display_order=>150
,p_column_identifier=>'I'
,p_column_label=>'Situacao'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441754533861142396)
,p_db_column_name=>'DT_SITUACAO'
,p_display_order=>160
,p_column_identifier=>'J'
,p_column_label=>'Dt Situacao'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441759263754142399)
,p_db_column_name=>'ORIGEM'
,p_display_order=>170
,p_column_identifier=>'V'
,p_column_label=>'Origem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441754891255142396)
,p_db_column_name=>'DATA_REF'
,p_display_order=>180
,p_column_identifier=>'K'
,p_column_label=>unistr('Data Refer\00EAncia')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441755290482142397)
,p_db_column_name=>'DATA_RETENCAO'
,p_display_order=>190
,p_column_identifier=>'L'
,p_column_label=>unistr('Data Reten\00E7\00E3o')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441755710459142397)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>200
,p_column_identifier=>'M'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441758924005142399)
,p_db_column_name=>'INCID_LIQ'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>unistr('Incide L\00EDquido')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441756048496142397)
,p_db_column_name=>'NOME_OCORRENCIA'
,p_display_order=>220
,p_column_identifier=>'N'
,p_column_label=>unistr('Nome Ocorr\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441752073338142395)
,p_db_column_name=>'COD_GERENCIAL'
,p_display_order=>230
,p_column_identifier=>'Z'
,p_column_label=>'Categoria'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441756509195142397)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>240
,p_column_identifier=>'O'
,p_column_label=>'Unidade1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441756850669142398)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>250
,p_column_identifier=>'P'
,p_column_label=>'Unidade2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441757324235142398)
,p_db_column_name=>'VALOR'
,p_display_order=>260
,p_column_identifier=>'Q'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441757647922142398)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>270
,p_column_identifier=>'R'
,p_column_label=>'Data Valor Inicial'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441758114756142398)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>280
,p_column_identifier=>'S'
,p_column_label=>'Data Valor Final'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441758533400142398)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>290
,p_column_identifier=>'T'
,p_column_label=>'Horas Ferias'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441759723035142399)
,p_db_column_name=>'USUARIO'
,p_display_order=>300
,p_column_identifier=>'W'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441760075425142399)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>310
,p_column_identifier=>'X'
,p_column_label=>'Dt Ult Atlz'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441748934526142393)
,p_db_column_name=>'TIPO_RUBRICA'
,p_display_order=>320
,p_column_identifier=>'AH'
,p_column_label=>'Tipo de Rubrica'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441748127210142392)
,p_db_column_name=>'DT_ADMISSAO_BASICA'
,p_display_order=>330
,p_column_identifier=>'AI'
,p_column_label=>unistr('Dt. Admiss\00E3o B\00E1sica')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441748512783142393)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>340
,p_column_identifier=>'AJ'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441746066380142391)
,p_db_column_name=>'CNPJ_EMPRESA'
,p_display_order=>350
,p_column_identifier=>'AK'
,p_column_label=>'CNPJ Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441746484919142391)
,p_db_column_name=>'CPF'
,p_display_order=>360
,p_column_identifier=>'AL'
,p_column_label=>'CPF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441746878488142392)
,p_db_column_name=>'COD_CARGO'
,p_display_order=>370
,p_column_identifier=>'AM'
,p_column_label=>unistr('C\00F3d. Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441747312592142392)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>380
,p_column_identifier=>'AN'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441747647228142392)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>390
,p_column_identifier=>'AO'
,p_column_label=>unistr('Dt. Admiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28441745692896142390)
,p_db_column_name=>'CCUSTO_CONTAB'
,p_display_order=>400
,p_column_identifier=>'AP'
,p_column_label=>'C. Custo (Contab)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872766234312522055)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Aut\00F4nomos - Confer\00EAncia Anal\00EDtica Piv\00F4')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'12367120'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441801489248142433)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_name=>unistr('AUT\00D4NOMOS')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'AG LIKE ''999%'''
,p_condition_sql=>'"SINDICATO" LIKE ''999%'''
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441801938215142433)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441802294535142433)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441802688611142434)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441803110301142434)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441803531322142434)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441803894800142434)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(238872769392597522060)
,p_report_id=>wwv_flow_api.id(238872766234312522055)
,p_pivot_columns=>'APXWS_CC_001:APXWS_CC_006'
,p_row_columns=>'EMPRESA:MATRICULA:NOME'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(28441804639399142435)
,p_pivot_id=>wwv_flow_api.id(238872769392597522060)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VALOR'
,p_db_column_name=>'PFC1'
,p_column_label=>'Valor'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_sum=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872793871384103724)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Aut\00F4nomos - Importa\00E7\00E3o Desconto L\00EDquido J\00E1 Pago')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366881'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'APXWS_CC_005:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441777582511142417)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_name=>unistr('FILTRO AUTON\00D4MOS / OCORRENCIAS')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'AG LIKE ''999%'' AND  M IN (999,620,9999,5620) AND Q > 0'
,p_condition_sql=>'"SINDICATO" LIKE ''999%'' AND  "COD_OCORR" IN (999,620,9999,5620) AND "VALOR" > 0'
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441777968397142417)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441778350458142417)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441778784427142418)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441779203192142418)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441779596327142418)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441779961434142418)
,p_report_id=>wwv_flow_api.id(238872793871384103724)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872800246643134425)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Aut\00F4nomos Confer\00EAncia Folha - Anal\00EDtica')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366913'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:ORIGEM:MATRICULA:NOME:DATA_REF:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441780775719142419)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_name=>unistr('AUT\00D4NOMOS')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'AG LIKE ''999%'''
,p_condition_sql=>'"SINDICATO" LIKE ''999%'''
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441781206722142419)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441781621403142419)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441781958110142419)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441782414115142420)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441782801816142420)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441783181654142420)
,p_report_id=>wwv_flow_api.id(238872800246643134425)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872806622129167098)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Aut\00F4nomos Confer\00EAncia Folha - Sint\00E9tica')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'12366945'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:ORIGEM:DATA_REF:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001:'
);
end;
/
begin
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441783982258142420)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_name=>unistr('AUT\00D4NOMOS')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'AG LIKE ''999%'''
,p_condition_sql=>'"SINDICATO" LIKE ''999%'''
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441784355214142421)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441784751283142421)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441785212163142421)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441785632548142421)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441786024445142421)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441786347007142422)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(28441786821615142422)
,p_report_id=>wwv_flow_api.id(238872806622129167098)
,p_group_by_columns=>'EMPRESA:ORIGEM:DATA_REF:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001'
,p_function_01=>'SUM'
,p_function_column_01=>'APXWS_CC_002'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>'Provento'
,p_function_format_mask_01=>'999G999G999G999G990D00'
,p_function_sum_01=>'Y'
,p_function_02=>'SUM'
,p_function_column_02=>'APXWS_CC_003'
,p_function_db_column_name_02=>'APXWS_GBFC_02'
,p_function_label_02=>'Desconto'
,p_function_format_mask_02=>'999G999G999G999G990D00'
,p_function_sum_02=>'Y'
,p_function_03=>'SUM'
,p_function_column_03=>'APXWS_CC_004'
,p_function_db_column_name_03=>'APXWS_GBFC_03'
,p_function_label_03=>'Base'
,p_function_format_mask_03=>'999G999G999G999G990D00'
,p_function_sum_03=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872811316641181114)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Confer\00EAncia Folha - Anal\00EDtica')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366981'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:ORIGEM:MATRICULA:NOME:DATA_REF:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001:UNIDADE1:UNIDADE2:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441787578827142423)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_name=>unistr('N\00E3o Aut\00F4nomos')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'NOT  AG LIKE ''999%'''
,p_condition_sql=>'NOT  "SINDICATO" LIKE ''999%'''
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441787954923142423)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441788436798142423)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441788824865142423)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441789231300142424)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441789572636142425)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441789975019142425)
,p_report_id=>wwv_flow_api.id(238872811316641181114)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872815466701201886)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Confer\00EAncia Folha - Anal\00EDtica Piv\00F4')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'12367013'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441790754770142426)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_name=>unistr('Valida N\00E3o Aut\00F4nomos e somente Proventos/Descontos')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'U = ''Sim'' AND NOT  AG LIKE ''999%'''
,p_condition_sql=>'"INCID_LIQ" = ''Sim'' AND NOT  "SINDICATO" LIKE ''999%'''
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441791175633142426)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441791568171142426)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441792000035142427)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441792398278142427)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441792841735142427)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441793149224142427)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(238872818741421201892)
,p_report_id=>wwv_flow_api.id(238872815466701201886)
,p_pivot_columns=>'APXWS_CC_001:APXWS_CC_006'
,p_row_columns=>'EMPRESA:MATRICULA:NOME'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(28441793942245142428)
,p_pivot_id=>wwv_flow_api.id(238872818741421201892)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VALOR'
,p_db_column_name=>'PFC1'
,p_column_label=>'Valor'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_sum=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872820976972209536)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Confer\00EAncia Folha - Sint\00E9tica')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'12367052'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:ORIGEM:DATA_REF:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001:'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441794729379142428)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_name=>unistr('N\00E3o Aut\00F4nomos')
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_expr_type=>'ROW'
,p_expr=>'NOT  AG LIKE ''999%'''
,p_condition_sql=>'NOT  "SINDICATO" LIKE ''999%'''
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441795123656142429)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441795468926142429)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441795912288142429)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441796305782142429)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441796682084142429)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441797116501142430)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(28441797535348142430)
,p_report_id=>wwv_flow_api.id(238872820976972209536)
,p_group_by_columns=>'EMPRESA:ORIGEM:DATA_REF:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001'
,p_function_01=>'SUM'
,p_function_column_01=>'APXWS_CC_002'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>'Provento'
,p_function_format_mask_01=>'999G999G999G999G990D00'
,p_function_sum_01=>'Y'
,p_function_02=>'SUM'
,p_function_column_02=>'APXWS_CC_003'
,p_function_db_column_name_02=>'APXWS_GBFC_02'
,p_function_label_02=>'Desconto'
,p_function_format_mask_02=>'999G999G999G999G990D00'
,p_function_sum_02=>'Y'
,p_function_03=>'SUM'
,p_function_column_03=>'APXWS_CC_004'
,p_function_db_column_name_03=>'APXWS_GBFC_03'
,p_function_label_03=>'Base'
,p_function_format_mask_03=>'999G999G999G999G990D00'
,p_function_sum_03=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238872990736266802094)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Confer\00EAncia de L\00EDquido de Rescis\00E3o')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367088'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:MATRICULA:NOME:DATA_RETENCAO:COD_OCORR:NOME_OCORRENCIA:APXWS_CC_001:APXWS_CC_004:'
,p_sum_columns_on_break=>'APXWS_CC_004'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441798295483142431)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'='
,p_expr=>'996'
,p_condition_sql=>'"COD_OCORR" = to_number(#APXWS_EXPR#)'
,p_condition_display=>'#APXWS_COL_NAME# = #APXWS_EXPR_NUMBER#  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441798728336142431)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441799130599142432)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441799471873142432)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441799885668142432)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441800271667142432)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441800671015142433)
,p_report_id=>wwv_flow_api.id(238872990736266802094)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(238876231533712157554)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Comparativo Mensal'
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'12367159'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441805432069142435)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441805807504142435)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441806204112142436)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441806583450142436)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441806972872142436)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441807368756142436)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(238876234344243157609)
,p_report_id=>wwv_flow_api.id(238876231533712157554)
,p_pivot_columns=>'DATA_REF'
,p_row_columns=>'COD_OCORR:NOME_OCORRENCIA'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(28441808075198142437)
,p_pivot_id=>wwv_flow_api.id(238876234344243157609)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VALOR'
,p_db_column_name=>'PFC1'
,p_column_label=>'Valor'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_sum=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042053743248018475)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf Dependentes IRRF Folha, Resc, F\00E9rias')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367194'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441808927623142437)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'971,9971'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 971, 9971  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441809324792142438)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441809652336142438)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441810097489142438)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441810470997142438)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441810873305142439)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441811279544142439)
,p_report_id=>wwv_flow_api.id(239042053743248018475)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042058796595025482)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf Dependentes 13\00BA Sal\00E1rio')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367226'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441812068795142439)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'975,9975'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 975, 9975  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441812466175142440)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441812877356142440)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441813293625142440)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441813727881142440)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441814073729142441)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441814506418142441)
,p_report_id=>wwv_flow_api.id(239042058796595025482)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042064495233032539)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf INSS Folha, Resc, F\00E9rias')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367258'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441815204275142441)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'510, 707, 517, 5510, 5707, 5517'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#, #APXWS_EXPR_VAL5#, #APXWS_EXPR_VAL6#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 510, 707, 517, 5510, 5707, 5517  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441815613495142442)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441816037287142442)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441816437811142442)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441816761217142442)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
end;
/
begin
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441817165067142443)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441817591831142443)
,p_report_id=>wwv_flow_api.id(239042064495233032539)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042069311922041086)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf INSS 13\00BA Sal\00E1rio')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367289'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441818431361142443)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'716, 717, 5716, 5717'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 716, 717, 5716, 5717  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441818840663142443)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441819220174142444)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441819567416142444)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441819991377142444)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441820386676142444)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441820796853142445)
,p_report_id=>wwv_flow_api.id(239042069311922041086)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042074306985047397)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf IRRF Folha, Resc, F\00E9rias')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367321'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441821615761142445)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'520, 519, 569, 5520, 5519, 5569'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#, #APXWS_EXPR_VAL5#, #APXWS_EXPR_VAL6#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 520, 519, 569, 5520, 5519, 5569  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441821993427142445)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441822395669142446)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441822795832142446)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441823196667142446)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441823614427142446)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441823956366142446)
,p_report_id=>wwv_flow_api.id(239042074306985047397)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042080337286053961)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf IRRF 13\00BA Sal\00E1rio')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12367353'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441824782133142447)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'718, 705, 5718, 5705'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 718, 705, 5718, 5705  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441825204295142447)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441825581840142447)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441826031741142447)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441826361060142448)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441826784778142448)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441827232341142448)
,p_report_id=>wwv_flow_api.id(239042080337286053961)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042085087062060732)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf Pens\00E3o Folha, Resc, F\00E9rias')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366714'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441760865122142403)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'620, 621, 622, 626, 623, 730, 732, 5620, 5621, 5622, 5626, 5623, 5730, 5732'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#, #APXWS_EXPR_VAL5#, #APXWS_EXPR_VAL6#, #APXWS_EXPR_VAL7#, #APXWS_EXPR_VAL8#, #APXWS_EXPR_VAL9#, #APXWS_EXPR_VAL10#, #APXWS_EXPR_VAL11#, #APXWS_EXPR_VAL12#, #AP'
||'XWS_EXPR_VAL13#, #APXWS_EXPR_VAL14#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 620, 621, 622, 626, 623, 730, 732, 5620, 5621, 5622, 5626, 5623, 5730, 5732  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441761296873142404)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441761674227142404)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441762116995142405)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441762513024142405)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441762943545142405)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441763249081142406)
,p_report_id=>wwv_flow_api.id(239042085087062060732)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042089905559065409)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf Pens\00E3o 13\00BA Sal\00E1rio')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366746'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441764104009142407)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'727, 729, 625, 5727, 5729, 5625'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#, #APXWS_EXPR_VAL5#, #APXWS_EXPR_VAL6#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 727, 729, 625, 5727, 5729, 5625  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441764455054142407)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441764899981142407)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441765297660142407)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441765675019142408)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441766099626142408)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441766541062142408)
,p_report_id=>wwv_flow_api.id(239042089905559065409)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042095164515074467)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Dirf PPR'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366778'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441767261893142408)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'124, 132, 149, 24'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 124, 132, 149, 24  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441767722259142409)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441768124278142409)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441768474976142409)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441768862405142409)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441769269880142410)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441769726771142410)
,p_report_id=>wwv_flow_api.id(239042095164515074467)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(239042099852324079604)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Dirf Prev Priv Folha, Resc, F\00E9rias')
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366810'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:DT_ADMISSAO_BASICA:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL::COD_EMPRES'
||'A:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(28441770501355142410)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'COD_OCORR'
,p_operator=>'in'
,p_expr=>'670, 671, 672, 673'
,p_condition_sql=>'"COD_OCORR" in (#APXWS_EXPR_VAL1#, #APXWS_EXPR_VAL2#, #APXWS_EXPR_VAL3#, #APXWS_EXPR_VAL4#)'
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# 670, 671, 672, 673  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441770913770142411)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441771272835142411)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441771656630142411)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441772145310142411)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441772462346142412)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441772873827142412)
,p_report_id=>wwv_flow_api.id(239042099852324079604)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(251443432562524108672)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Ocorr\00EAncias por Matr\00EDcula')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'12366842'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'MATRICULA:NOME:ORIGEM:DATA_REF:DATA_RETENCAO:COD_OCORR:INCID_LIQ:NOME_OCORRENCIA:COD_GERENCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL'
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(242539705700920462088)
,p_report_id=>wwv_flow_api.id(251443432562524108672)
,p_pivot_columns=>'TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA'
,p_row_columns=>'MATRICULA:NOME:DATA_REF'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(28441774002457142414)
,p_pivot_id=>wwv_flow_api.id(242539705700920462088)
,p_display_seq=>1
,p_function_name=>'SUM'
,p_column_name=>'VALOR'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G990D90'
,p_display_sum=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(251571966747487943764)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'12366853'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:CNPJ_EMPRESA:FILIAL:CCUSTO:CCUSTO_CONTAB:UNIDADE_ADM:ATIVIDADE:LOCAL_TRAB:MATRICULA:NOME:CPF:DT_ADMISSAO_BASICA:DT_ADMISSAO:COD_CARGO:NOME_CARGO:SINDICATO:ORIGEM:DATA_REF:DATA_RETENCAO:TIPO_RUBRICA:COD_OCORR:NOME_OCORRENCIA:INCID_LIQ:COD_GERE'
||'NCIAL:UNIDADE1:UNIDADE2:VALOR:DT_INIC_VAL:DT_FIN_VAL:COD_EMPRESA:APXWS_CC_001:APXWS_CC_002:APXWS_CC_003:APXWS_CC_004:APXWS_CC_005:APXWS_CC_006:'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441774748517142415)
,p_report_id=>wwv_flow_api.id(251571966747487943764)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN ''01-Provento'' WHEN AH LIKE ''%Desc%'' THEN ''02-Desconto'' ELSE ''03-Base / Informativa'' END '
,p_column_type=>'STRING'
,p_column_label=>unistr('Tipo Ocorr\00EAncia')
,p_report_label=>unistr('Tipo Ocorr\00EAncia')
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441775205773142415)
,p_report_id=>wwv_flow_api.id(251571966747487943764)
,p_db_column_name=>'APXWS_CC_002'
,p_column_identifier=>'C02'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Prov%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Provento'
,p_report_label=>'Provento'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441775570198142416)
,p_report_id=>wwv_flow_api.id(251571966747487943764)
,p_db_column_name=>'APXWS_CC_003'
,p_column_identifier=>'C03'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Desc%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Desconto'
,p_report_label=>'Desconto'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441776017282142416)
,p_report_id=>wwv_flow_api.id(251571966747487943764)
,p_db_column_name=>'APXWS_CC_004'
,p_column_identifier=>'C04'
,p_computation_expr=>'CASE WHEN AH LIKE ''%Infor%'' THEN  Q else 0 end'
,p_format_mask=>'999G999G999G999G990D00'
,p_column_type=>'NUMBER'
,p_column_label=>'Base'
,p_report_label=>'Base'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441776361804142416)
,p_report_id=>wwv_flow_api.id(251571966747487943764)
,p_db_column_name=>'APXWS_CC_005'
,p_column_identifier=>'C05'
,p_computation_expr=>'LPAD(  AJ,3,''0'')||LPAD( E,6,''0'')||TO_CHAR( K,''DD/MM/YYYY'')||CASE WHEN  M = 999 THEN ''650000000'' ELSE ''659000000'' END||LPAD(TO_CHAR( Q*100),15,''0'')'
,p_column_type=>'STRING'
,p_column_label=>'IMPORTACAO'
,p_report_label=>'IMPORTACAO'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(28441776775995142416)
,p_report_id=>wwv_flow_api.id(251571966747487943764)
,p_db_column_name=>'APXWS_CC_006'
,p_column_identifier=>'C06'
,p_computation_expr=>'TO_CHAR( M) ||'' - ''|| N'
,p_column_type=>'STRING'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_report_label=>unistr('Ocorr\00EAncia')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(251571967256954943765)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(57485014174799710894)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(251571976065072943771)
,p_plug_name=>'Totais'
,p_region_name=>'TOTAIS'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(57485010461509710889)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P21_EMP, :P21_MAT);',
'',
'return v_return;',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(251572671620941674264)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(57485014174799710894)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P21_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28441844116186142461)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_button_name=>'p21_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(57485034850326710935)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P21_EMP.,&P21_MAT.,&P21_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28441828271585142453)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_button_name=>'p21_btn_pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(57485035140117710938)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28441827573659142449)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(251571956696510943757)
,p_button_name=>'BT_LANCTO'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(57485035140117710938)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Lan\00E7amentos')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=MVF_MENU_&P_BASE.:5:&SESSION.::&DEBUG.:RP,5:P5_PROCESSO,P5_APP_ANT,P5_PAG_ANT,P5_EMPRESAS,P5_MATRICULAS,P5_FILIAIS,P5_CCUSTOS,P5_SINDICATOS,P5_DATAREF,P5_SITUACOES,P5_VINCULOS:&P21_PROCESSO.,PO_&P_BASE.,21,&P21_EMP_AUX.,&P21_MAT_AUX.,&P21_FIL_AUX.,&P21_CCST_AUX.,&P21_SIND_AUX.,&P21_DTREF_AUX.,&P21_SIT_AUX.,&P21_VINC_AUX.'
,p_button_condition=>'P21_PESQUISA'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-tasks'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28427605879662232125)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(251571956696510943757)
,p_button_name=>'IA'
,p_button_static_id=>'BTN_IA'
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
 p_id=>wwv_flow_api.id(28427604928757225837)
,p_name=>'P21_MSG'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427605203518228529)
,p_name=>'P21_STATIC_ID_IR'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28427605503681229953)
,p_name=>'P21_USER_PROMPT'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441828667698142453)
,p_name=>'P21_EMPRESA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) descricao, cod codigo',
'  from empresas',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_display_when=>'P21_EMP'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441829079017142454)
,p_name=>'P21_FILIAL_INI'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Filial Inicial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||initcap(nome_filial) nome, cod_filial cod',
'  from filiais',
' where cod_empresa = :p21_empresa',
' order by 2'))
,p_lov_cascade_parent_items=>'P21_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441829502037142454)
,p_name=>'P21_FILIAL_FIM'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Filial Final'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||initcap(nome_filial) nome, cod_filial cod',
'  from filiais',
' where cod_empresa = :p21_empresa',
' order by 2 desc'))
,p_lov_cascade_parent_items=>'P21_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441829903554142455)
,p_name=>'P21_CCUSTO_INI'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Centro de Custo Inicial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct c.cod||'' - ''||trim(initcap(c.nome)) nome, c.cod codigo',
'  from centro_de_custo c, filial_ccusto f',
' where c.cod_empresa = :p21_empresa',
'   and c.cod_empresa = f.cod_empresa',
'   and c.cod = f.cod_ccusto',
'   and f.cod_filial between :p21_filial_ini and :p21_filial_fim',
'   and F_Acesso_CC(c.cod_empresa, cod_ccusto) = ''S''',
' order by 2'))
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441830295768142455)
,p_name=>'P21_CCUSTO_FIM'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Centro de Custo Final'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct c.cod||'' - ''||trim(initcap(c.nome)) nome, c.cod codigo',
'  from centro_de_custo c, filial_ccusto f',
' where c.cod_empresa = :p21_empresa',
'   and c.cod_empresa = f.cod_empresa',
'   and c.cod = f.cod_ccusto',
'   and f.cod_filial between :p21_filial_ini and :p21_filial_fim',
'   and F_Acesso_CC(c.cod_empresa, cod_ccusto) = ''S''',
' order by 2 desc'))
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441830649109142455)
,p_name=>'P21_CCUSTO_CONT_INI'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Centro de Custo Contab. Inicial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod||'' - ''||trim(initcap(a.nome)) nome, a.cod codigo',
'  from ccusto_contab a',
' where a.cod_empresa = :p21_empresa',
' order by 2'))
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441831079683142456)
,p_name=>'P21_CCUSTO_CONT_FIM'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Centro de Custo Contab. Final'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod||'' - ''||trim(initcap(a.nome)) nome, a.cod codigo',
'  from ccusto_contab a',
' where a.cod_empresa = :p21_empresa',
' order by 2 desc',
' '))
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441831511406142456)
,p_name=>'P21_DT_ADM_INI'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Data Adm. B\00E1sica Inicial')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441831854657142456)
,p_name=>'P21_DT_ADM_FIM'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Data Adm. B\00E1sica Final')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441832322171142456)
,p_name=>'P21_DT_RETENCAO_INI'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Data Reten\00E7\00E3o Inicial')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441832647705142456)
,p_name=>'P21_DT_RETENCAO_FIM'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Data Reten\00E7\00E3o Final')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441833077871142456)
,p_name=>'P21_SITUACOES'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome, cod',
'  from sit_func',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441833468073142456)
,p_name=>'P21_VINCULOS'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('V\00EDnculo')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome, cod',
'  from vinculo_empreg',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441833913589142456)
,p_name=>'P21_SINDICATO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Sindicato'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome, cod',
'  from sindicatos',
' where (:p21_empresa is null or cod_empresa = :p21_empresa)',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P21_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441834307454142457)
,p_name=>'P21_MATRICULA_INI'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Matr\00EDcula Inicial')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) nome, matricula cod',
'  from informacoes_funcionais',
' where (:p21_empresa is null or cod_empresa = :p21_empresa)',
'   and (:p21_filial_ini is null or filial between :p21_filial_ini and :p21_filial_fim)',
'   and (:p21_ccusto_ini is null or cod_ccusto between :p21_ccusto_ini and :p21_ccusto_fim)',
'   and (:p21_dt_adm_ini is null or dt_admissao_basica between :p21_dt_adm_ini and :p21_dt_adm_fim)',
'   and (:P21_SINDICATO is null or num_sind_diss in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SINDICATO, '':'')) t))',
'   and (:P21_SITUACOES is null or situacao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SITUACOES, '':'')) t))',
'   and (:P21_VINCULOS is null or vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_VINCULOS, '':'')) t))',
' order by 2'))
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM,P21_CCUSTO_INI,P21_CCUSTO_FIM,P21_DT_ADM_INI,P21_DT_ADM_FIM,P21_SITUACOES,P21_VINCULOS,P21_SINDICATO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441834690453142457)
,p_name=>'P21_MATRICULA_FIM'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Matr\00EDcula Final')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) nome, matricula cod',
'  from informacoes_funcionais',
' where (:p21_empresa is null or cod_empresa = :p21_empresa)',
'   and (:p21_filial_ini is null or filial between :p21_filial_ini and :p21_filial_fim)',
'   and (:p21_ccusto_ini is null or cod_ccusto between :p21_ccusto_ini and :p21_ccusto_fim)',
'   and (:p21_dt_adm_ini is null or dt_admissao_basica between :p21_dt_adm_ini and :p21_dt_adm_fim)',
'   and (:P21_SINDICATO is null or num_sind_diss in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SINDICATO, '':'')) t))',
'   and (:P21_SITUACOES is null or situacao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SITUACOES, '':'')) t))',
'   and (:P21_VINCULOS is null or vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_VINCULOS, '':'')) t))',
' order by 2 desc'))
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM,P21_CCUSTO_INI,P21_CCUSTO_FIM,P21_DT_ADM_INI,P21_DT_ADM_FIM,P21_SITUACOES,P21_VINCULOS,P21_SINDICATO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P21_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441835082959142457)
,p_name=>'P21_DATA_REF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Meses'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select display, data_ref',
'  from list_hist_finan_datas',
' where trunc(data_ref,''month'') >= add_months(trunc(sysdate,''month''),-61)',
'order by 2 desc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441835534595142457)
,p_name=>'P21_TIPO_RUBRICA'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Tipo de Evento'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr(' select distinct DECODE(o.tipo_rubrica, 1, ''Vencimento, Provento ou Pens\00E3o'', 2, ''Desconto'', 3, ''Informativa'', 4, ''Informativa Dedutora'') d, '),
unistr(' DECODE(o.tipo_rubrica, 1, ''Vencimento, Provento ou Pens\00E3o'', 2, ''Desconto'', 3, ''Informativa'', 4, ''Informativa Dedutora'') c'),
' --o.tipo_rubrica c',
'   from ocorr_pagto o',
'  where (:p21_empresa is null or o.cod_empresa = :p21_empresa)',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P21_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441835862162142457)
,p_name=>'P21_COD_OCORR'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Ocorr\00EAncia')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('SELECT distinct o.cod||'' - ''||o.nome||'' (''||DECODE(o.tipo_rubrica, 1, ''Vencimento, Provento ou Pens\00E3o'', 2, ''Desconto'', 3, ''Informativa'', 4, ''Informativa Dedutora'')||'')'' d,'),
' o.cod c',
'  FROM OCORR_PAGTO o',
' where (:p21_empresa is null or o.cod_empresa = :p21_empresa)',
unistr('   and (:P21_TIPO_RUBRICA is null or DECODE(o.tipo_rubrica, 1, ''Vencimento, Provento ou Pens\00E3o'', 2, ''Desconto'', 3, ''Informativa'', 4, ''Informativa Dedutora'') in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_TIPO_RUBRIC')
||'A, '':'')) t))   ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P21_EMPRESA,P21_TIPO_RUBRICA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441836255454142457)
,p_name=>'P21_DATA_REF_INI'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441836724755142458)
,p_name=>'P21_DATA_REF_FIM'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441837131799142458)
,p_name=>'P21_H_FINAN'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Financeiro (M\00EAs Atual)')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Folha,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441837481964142458)
,p_name=>'P21_H_FINAN_ACM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Financeiro (Meses Anteriores)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Folha Acm.,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441837866552142458)
,p_name=>'P21_H_RESC'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Rescis\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Rescisao,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441838300037142458)
,p_name=>'P21_H_13'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('13\00BA Sal\00E1rio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;13 Salario,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441838712144142458)
,p_name=>'P21_H_PART'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Participa\00E7\00E3o dos Lucros')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Participacao,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441839127278142458)
,p_name=>'P21_H_FERIAS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('F\00E9rias')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Ferias,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441839521744142458)
,p_name=>'P21_H_ADIANT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Adiantamento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Adiantamento,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441839884475142458)
,p_name=>'P21_H_RECALC'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Rescis\00E3o Rec\00E1lculo')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Resc. Recalc.,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441840319277142459)
,p_name=>'P21_H_DIVERSOS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>unistr('Diversos (M\00EAs Atual)')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Diversos,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441840709178142459)
,p_name=>'P21_H_DIVERSOS_ACM'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Diversos (Meses Anteriores)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;Diversos Acm,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441841145012142459)
,p_name=>'P21_OCULTAR'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(251571967256954943765)
,p_prompt=>'Ocultar Totais'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441841750078142460)
,p_name=>'P21_TOTAL_PROVENTOS'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(251571976065072943771)
,p_prompt=>'Total Proventos e Descontos'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441842169855142460)
,p_name=>'P21_TOTAL_DESCONTOS'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(251571976065072943771)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441842610316142460)
,p_name=>'P21_TOTAL_BASES'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(251571976065072943771)
,p_prompt=>'Total Bases'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441842978704142460)
,p_name=>'P21_TOTAL_UNIDADE_1'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(251571976065072943771)
,p_prompt=>'Total Unidade 1 e 2'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441843445988142460)
,p_name=>'P21_TOTAL_UNIDADE_2'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(251571976065072943771)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441844492891142461)
,p_name=>'P21_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = :P21_EMP',
'                  and matricula   = :P21_MAT',
'                  ), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P21_EMP || ''|'' || :P21_MAT',
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
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441844890643142461)
,p_name=>'P21_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441845299748142461)
,p_name=>'P21_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441845734330142462)
,p_name=>'P21_MATRICULA1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441846116576142462)
,p_name=>'P21_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(57485034525793710931)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441846451795142462)
,p_name=>'P21_EMP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441846921616142462)
,p_name=>'P21_MAT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441847254575142462)
,p_name=>'P21_CHAMADOR'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441847648377142462)
,p_name=>'P21_PESQUISA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441848109975142462)
,p_name=>'P21_PROCESSO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441848496646142462)
,p_name=>'P21_EMP_AUX'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441848931592142463)
,p_name=>'P21_FIL_AUX'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441849261861142463)
,p_name=>'P21_CCST_AUX'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441849671754142463)
,p_name=>'P21_MAT_AUX'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441850066065142463)
,p_name=>'P21_SIND_AUX'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441850516433142463)
,p_name=>'P21_DTREF_AUX'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441850873230142463)
,p_name=>'P21_SIT_AUX'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28441851251565142463)
,p_name=>'P21_VINC_AUX'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(251572671620941674264)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28441854904245142468)
,p_name=>'Popula_Data'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P21_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28441855423049142469)
,p_event_id=>wwv_flow_api.id(28441854904245142468)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ADD_MONTHS(dt_ref_folha,-1) data_ini, dt_ref_folha data_fim',
'  from parametros_recursos_humanos',
' where cod_empresa = NVL(:p21_emp, :P21_EMPRESA);',
'     ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p21_data_ref_ini is null then',
'',
':p21_DATA_REF_INI := v_c1.data_ini;',
':p21_DATA_REF_FIM := v_c1.data_fim;',
'	 ',
'  -- :p21_data_ref := v_c1.data_ini||'':''||v_c1.data_fim;',
'   ',
'end if;',
'',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P21_EMP,P21_EMPRESA,P21_DATA_REF_INI'
,p_attribute_03=>'P21_DATA_REF_INI,P21_DATA_REF_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28441855783189142469)
,p_name=>'Submit'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(28441828271585142453)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28441856280703142470)
,p_event_id=>wwv_flow_api.id(28441855783189142469)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P21_PESQUISA := ''S'';',
'  --',
'  :P21_PROCESSO  := NULL;',
'  :P21_EMP_AUX   := NULL;',
'  :P21_FIL_AUX   := NULL;',
'  :P21_CCST_AUX  := NULL;',
'  :P21_MAT_AUX   := NULL;',
'  :P21_SIND_AUX  := NULL;',
'  :P21_DTREF_AUX := NULL;',
'  :P21_SIT_AUX   := NULL;',
'  :P21_VINC_AUX  := NULL;',
'  --',
'  IF :P21_H_FINAN <> ''N'' OR :P21_H_FINAN_ACM <> ''N'' OR :P21_H_RESC <> ''N'' THEN',
'    :P21_PROCESSO := 1;',
'  END IF;',
'  --',
'  IF :P21_H_13 <> ''N'' THEN',
'    :P21_PROCESSO := :P21_PROCESSO||''4'';',
'  END IF;  ',
'  --',
'  IF :P21_H_PART <> ''N'' THEN',
'    :P21_PROCESSO := :P21_PROCESSO||''5'';',
'  END IF;   ',
'  --',
'  IF :P21_H_FERIAS <> ''N'' THEN',
'    :P21_PROCESSO := :P21_PROCESSO||''3'';',
'  END IF;    ',
'  --',
'  IF :P21_H_ADIANT <> ''N'' THEN',
'    :P21_PROCESSO := :P21_PROCESSO||''2'';',
'  END IF; ',
'  --',
'  IF :P21_H_DIVERSOS <> ''N'' OR :P21_H_DIVERSOS_ACM <> ''N'' THEN',
'    :P21_PROCESSO := :P21_PROCESSO||''6'';',
'  END IF;    ',
'  --',
'  IF :P21_PROCESSO NOT IN(1,2,3,4,5,6) THEN',
'    :P21_PROCESSO := NULL;',
'  END IF;',
'  --',
'  :P21_EMP_AUX  := :P21_EMPRESA;',
'  --',
'  IF :P21_SINDICATO IS NOT NULL THEN',
'    IF INSTR(:P21_SINDICATO,'':'') > 0 THEN',
'      :P21_SIND_AUX := REPLACE(REPLACE(:P21_SINDICATO,'':'',''_''||:P21_EMPRESA||'':'')||''_''||:P21_EMPRESA,'':'',''-'');',
'    ELSE',
'      :P21_SIND_AUX := :P21_SINDICATO||''_''||:P21_EMPRESA;',
'    END IF;',
'  END IF;',
'  --',
'  IF :P21_DATA_REF IS NOT NULL THEN',
'    :P21_DTREF_AUX := REPLACE(:P21_DATA_REF,'':'',''-'');',
'  END IF;',
'  --',
'  IF :P21_SITUACOES IS NOT NULL THEN',
'    :P21_SIT_AUX := REPLACE(:P21_SITUACOES,'':'',''-'');',
'  END IF;  ',
'  --',
'  IF :P21_VINCULOS IS NOT NULL THEN',
'    :P21_VINC_AUX := REPLACE(:P21_VINCULOS,'':'',''-'');',
'  END IF;',
'  --',
'  IF :P21_FILIAL_INI = :P21_FILIAL_FIM THEN',
'    :P21_FIL_AUX := :P21_FILIAL_INI||''_''||:P21_EMPRESA;',
'  END IF;',
'  --',
'  IF :P21_CCUSTO_INI = :P21_CCUSTO_FIM THEN',
'    :P21_CCST_AUX := :P21_CCUSTO_INI||''_''||:P21_FILIAL_INI||''_''||:P21_EMPRESA;',
'  END IF;  ',
'  --',
'  IF :P21_MATRICULA_INI = :P21_MATRICULA_FIM THEN',
'    :P21_MAT_AUX := :P21_MATRICULA_INI||''_''||:P21_EMPRESA;',
'  END IF;   ',
'END;'))
,p_attribute_02=>'P21_PESQUISA,P21_PROCESSO,P21_H_FINAN,P21_H_FINAN_ACM,P21_H_RESC,P21_H_13,P21_H_PART,P21_H_FERIAS,P21_H_ADIANT,P21_H_DIVERSOS,P21_H_DIVERSOS_ACM,P21_EMP_AUX,P21_FIL_AUX,P21_CCST_AUX,P21_MAT_AUX,P21_EMPRESA,P21_FILIAL_INI,P21_FILIAL_FIM,P21_CCUSTO_INI'
||',P21_CCUSTO_FIM,P21_MATRICULA_INI,P21_MATRICULA_FIM,P21_DATA_REF,P21_SINDICATO,P21_SIND_AUX,P21_DTREF_AUX,P21_SIT_AUX,P21_VINC_AUX,P21_SITUACOES,P21_VINCULOS'
,p_attribute_03=>'P21_PESQUISA,P21_PROCESSO,P21_EMP_AUX,P21_FIL_AUX,P21_CCST_AUX,P21_MAT_AUX,P21_SIND_AUX,P21_DTREF_AUX,P21_SIT_AUX,P21_VINC_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28441856801024142470)
,p_event_id=>wwv_flow_api.id(28441855783189142469)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'IF :P21_MATRICULA_INI IS NULL THEN',
'SELECT MIN(MATRICULA) COD',
'    INTO :P21_MATRICULA_INI',
'  FROM INFORMACOES_FUNCIONAIS',
' WHERE COD_EMPRESA = :P21_EMPRESA;',
' END IF;',
' ',
' IF :P21_MATRICULA_FIM IS NULL THEN ',
' SELECT MAX(MATRICULA) COD',
'     INTO :P21_MATRICULA_FIM',
'  FROM INFORMACOES_FUNCIONAIS',
' WHERE COD_EMPRESA = :P21_EMPRESA;',
' END IF;',
' ',
' END;'))
,p_attribute_02=>'P21_EMPRESA'
,p_attribute_03=>'P21_MATRICULA_INI,P21_MATRICULA_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28441857278775142470)
,p_event_id=>wwv_flow_api.id(28441855783189142469)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28441857717342142470)
,p_name=>unistr('Disable Hist\00F3rico')
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(251571967256954943765)
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28441858160904142470)
,p_event_id=>wwv_flow_api.id(28441857717342142470)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#HST'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28427603286369217746)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>40
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427604186392217746)
,p_event_id=>wwv_flow_api.id(28427603286369217746)
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
'  apex.item("P21_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P21_USER_PROMPT").setValue("Analise os dados de an\00E1lise de hist\00F3ricos financeiros a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28427603636867217746)
,p_event_id=>wwv_flow_api.id(28427603286369217746)
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
'  v_region_static_id varchar2(100) := :P21_STATIC_ID_IR; --''IR_REGION'';',
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
'  v_user_prompt := :P21_USER_PROMPT;  --''Analise os dados a seguir.'';',
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
'  :P21_flg := v_status;',
'  :P21_msg := v_mensagem;',
'',
'END;'))
,p_attribute_02=>'P21_STATIC_ID_IR,P21_USER_PROMT'
,p_attribute_03=>'P21_FLG,P21_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28441852927266142467)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_campos_2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ADD_MONTHS(dt_ref_folha,-1) data_ini, dt_ref_folha data_fim',
'  from parametros_recursos_humanos',
' where cod_empresa = NVL(:p21_emp, :P21_EMPRESA);',
'     ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'--raise_application_error(-20000,:p21_data_ref||''usuario ''||:p_usuario);',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'/*',
'if :p21_data_ref_ini is null then',
'',
':p21_DATA_REF_INI := v_c1.data_ini;',
':p21_DATA_REF_FIM := v_c1.data_fim;',
'	 ',
':p21_h_finan     := ''Folha'';',
':p21_h_finan_acm := ''Folha Acm.'';',
'',
'end if;',
'*/',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28441854113124142468)
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
 p_id=>wwv_flow_api.id(28441853664107142468)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ADD_MONTHS(dt_ref_folha,-1) data_ini, dt_ref_folha data_fim',
'  from parametros_recursos_humanos',
' where cod_empresa = NVL(:p21_emp, :P21_EMPRESA);',
'     ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p21_data_ref is null then',
'',
':p21_DATA_REF := v_c1.data_fim;',
'	 ',
':p21_h_finan     := ''Folha'';',
':p21_h_finan_acm := ''Folha Acm.'';',
'',
'end if;',
'',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28441854462914142468)
,p_process_sequence=>40
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
' where i.cod_empresa = :p21_emp',
'   and i.matricula = :p21_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p21_cod_empresa := v_c1.empresa;',
':p21_matricula1 := v_c1.matricula;',
':p21_situacao := v_c1.situacao;',
':p21_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p21_cod_empresa := :p21_emp;',
':p21_matricula1 := :p21_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28441853303874142467)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Totais'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'with inf as (select i.cod_empresa, ',
'                    i.matricula',
'               from informacoes_funcionais i',
'             where i.COD_EMPRESA = nvl(:p21_emp, nvl(:p21_empresa, i.cod_empresa))',
'               AND (:p21_FILIAL_ini is null or i.FILIAL BETWEEN :p21_FILIAL_ini and :p21_FILIAL_fim)',
'               AND (:p21_CCUSTO_ini is null or i.COD_CCUSTO BETWEEN :p21_CCUSTO_ini and :p21_CCUSTO_fim)',
'               and (:p21_dt_adm_ini is null or i.dt_admissao_basica between :p21_dt_adm_ini and :p21_dt_adm_fim)',
'               and (:P21_SINDICATO is null or i.num_sind_diss in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SINDICATO, '':'')) t))',
'               and (:P21_SITUACOES is null or i.situacao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_SITUACOES, '':'')) t))',
'               and (:P21_VINCULOS is null or i.vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_VINCULOS, '':'')) t))',
'               AND (:p21_matricula_ini is null or i.MATRICULA between    nvl(:p21_mat, nvl(:p21_matricula_ini, i.matricula)) and     nvl(:p21_mat, nvl(:p21_matricula_fim, i.matricula)) )',
'             --  and F_Acesso_PG_Apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel) = ''S''',
'            ),',
'hist as (select h.cod_empresa, h.matricula, h.unidade1, h.unidade2, h.cod_ocorr, h.incid_liq, h.valor',
'               from MWV_HISTORICOS h, configuracoes c',
'              where (:P21_DATA_REF is not null and h.data_ref in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_DATA_REF, '':'')) t))',
'                 AND (:p21_CCUSTO_CONT_ini is null or h.COD_CCUSTO_CONT BETWEEN :p21_CCUSTO_CONT_ini and :p21_CCUSTO_CONT_fim)',
'                 and (:P21_DT_RETENCAO_INI is null or h.data_retencao between :P21_DT_RETENCAO_INI and :P21_DT_RETENCAO_FIM)',
'                 and (:P21_tipo_rubrica is null or h.tipo_rubrica in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_tipo_rubrica, '':'')) t))',
'                 and (:P21_cod_ocorr is null or h.cod_ocorr in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_cod_ocorr, '':'')) t))',
'                 AND h.origem in (:p21_h_finan_acm, :p21_h_ferias, :p21_h_resc, :p21_h_13, :p21_h_adiant, :p21_h_part, :p21_h_Recalc, :p21_h_Diversos, :p21_h_Diversos_Acm)',
'                -- AND (:P21_H_FINAN_ACM = ''Folha Acm.'' ) ????',
'                 and ((NVL(:p21_ocultar, ''N'') = ''S'' AND',
'                     ((c.quatro_digitos_ocorr = ''S'' and h.cod_ocorr not in (9996, 9997, 9998, 9999)) or (c.quatro_digitos_ocorr = ''N'' and h.cod_ocorr not in (996, 997, 998, 999))) ',
'                      ) OR',
'                     (NVL(:p21_ocultar, ''N'') = ''N'' AND h.cod_ocorr IS NOT NULL))',
'                AND NOT EXISTS (SELECT 1',
'                                  FROM VIEW_MAT_HISTORICOS_MES HM ',
'                                 WHERE HM.COD_EMPRESA = H.COD_EMPRESA',
'                                   AND HM.MATRICULA   = H.MATRICULA',
'                                   AND HM.DATA_REF    = H.DATA_REF',
'                                   AND HM.COD_OCORR   = H.COD_OCORR)',
'                union all',
'                select h.cod_empresa, h.matricula, h.unidade1, h.unidade2, h.cod_ocorr, h.incid_liq, h.valor',
'               from MWV_HISTORICOS_MES h, configuracoes c',
'              where (:P21_DATA_REF is not null and h.data_ref in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_DATA_REF, '':'')) t))',
'                 AND (:p21_CCUSTO_CONT_ini is null or h.COD_CCUSTO_CONT BETWEEN :p21_CCUSTO_CONT_ini and :p21_CCUSTO_CONT_fim)',
'                 and (:P21_DT_RETENCAO_INI is null or h.data_retencao between :P21_DT_RETENCAO_INI and :P21_DT_RETENCAO_FIM)',
'                 and (:P21_tipo_rubrica is null or h.tipo_rubrica in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_tipo_rubrica, '':'')) t))',
'                 and (:P21_cod_ocorr is null or h.cod_ocorr in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P21_cod_ocorr, '':'')) t))',
'                 AND h.origem in (:p21_h_finan_acm, :p21_h_ferias, :p21_h_resc, :p21_h_13, :p21_h_adiant, :p21_h_part, :p21_h_Recalc, :p21_h_Diversos, :p21_h_Diversos_Acm)',
'                -- AND (:P21_H_FINAN_ACM = ''Folha Acm.'' ) ????',
'                 and ((NVL(:p21_ocultar, ''N'') = ''S'' AND',
'                     ((c.quatro_digitos_ocorr = ''S'' and h.cod_ocorr not in (9996, 9997, 9998, 9999)) or (c.quatro_digitos_ocorr = ''N'' and h.cod_ocorr not in (996, 997, 998, 999))) ',
'                      ) OR',
'                     (NVL(:p21_ocultar, ''N'') = ''N'' AND h.cod_ocorr IS NOT NULL)))',
'select ''Unidade 1: '' || nvl(SUM(v.unidade1), 0) || '' Unidade 2: '' ||',
' nvl(SUM(v.unidade2), 0) Total_Unidade_1_2,',
'       ''Proventos: '' ||',
'       trim(to_char(nvl(SUM(CASE',
'                              WHEN ((c.quatro_digitos_ocorr = ''S'' and v.COD_OCORR <= 4999) or (c.quatro_digitos_ocorr = ''N'' and v.COD_OCORR <= 499)) AND v.incid_liq = ''S'' THEN',
'                               v.valor',
'                              ELSE',
'                               0',
'                            END),',
'                        0),',
'                    ''FML999G999G999G999G990D00'')) || '' Descontos: '' ||',
'       trim(to_char(nvl(SUM(CASE',
'                              WHEN ((c.quatro_digitos_ocorr = ''S'' and v.COD_OCORR between 5000 and 8999) or (c.quatro_digitos_ocorr = ''N'' and v.COD_OCORR between 500 and 899)) AND v.incid_liq = ''S'' THEN',
'                               v.valor',
'                              ELSE',
'                               0',
'                            END),',
'                        0),',
'                    ''FML999G999G999G999G990D00'')) PROVENTOS_DESCONTOS,',
'       trim(to_char(nvl(SUM(CASE',
'                              WHEN ((c.quatro_digitos_ocorr = ''S'' and v.COD_OCORR between 1 and 8999) or (c.quatro_digitos_ocorr = ''N'' and v.COD_OCORR between 1 and 899)) AND v.incid_liq = ''N'' THEN',
'                               v.valor',
'                              ELSE',
'                               0',
'                            END + CASE',
'                              WHEN ((c.quatro_digitos_ocorr = ''S'' and v.COD_OCORR between 9900 and 9995) or (c.quatro_digitos_ocorr = ''N'' and v.COD_OCORR between 900 and 995)) THEN',
'                               v.valor',
'                              ELSE',
'                               0',
'                            END),',
'                        0),',
'                    ''FML999G999G999G999G990D00'')) BASES',
'  from hist v, inf i, configuracoes c',
' where v.cod_empresa = i.cod_empresa',
'   and v.matricula = i.matricula;',
'',
'v_c1 c1%rowtype;',
'',
'BEGIN',
'-- NATCORP 09/10: sem Pesquisar nao calcula (a mesma regra do relatorio).',
'IF :P21_MAT IS NULL AND NVL(:P21_PESQUISA, ''N'') <> ''S'' THEN RETURN; END IF;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p21_total_unidade_1 := v_c1.Total_Unidade_1_2;',
':p21_total_proventos := v_c1.proventos_descontos;',
':p21_total_bases := v_c1.bases;',
'',
'EXCEPTION WHEN OTHERS THEN',
'',
'NULL;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990921000000000002)
,p_process_sequence=>60
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_HISTFIN_INDICADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - resumo da folha (Natcorp_HistFin.js). FONTE: brand/apex/app/NC_HISTFIN_INDICADORES.plsql.sql',
'   (guia HISTFIN-MANUTENCAO.md). Mude la e aplique de novo com aplicar-histfin-pagina21.py. */',
'declare',
'  l_hoje   date := trunc(sysdate);',
'  l_passo  varchar2(30) := ''inicio'';',
'  l_saida  clob;',
'  l_pos    pls_integer := 1;',
'  l_4dig   varchar2(1);',
'  l_lim_p  number; l_lim_d1 number; l_lim_d2 number; l_tot1 number; l_tot2 number;',
'  l_refs   varchar2(4000) := ''|'';          /* os meses escolhidos "|AAAAMMDD|...|" */',
'  l_min    date; l_max date; l_ult date; l_ant date;',
'  l_sind   varchar2(32767) := '':'' || :P21_SINDICATO || '':'';',
'  l_sit    varchar2(32767) := '':'' || :P21_SITUACOES || '':'';',
'  l_vinc   varchar2(32767) := '':'' || :P21_VINCULOS || '':'';',
'  l_trub   varchar2(32767) := '':'' || :P21_TIPO_RUBRICA || '':'';',
'  l_ocor   varchar2(32767) := '':'' || :P21_COD_OCORR || '':'';',
'  l_adm_ini date; l_adm_fim date; l_ret_ini date; l_ret_fim date;',
'',
'  type t_num is table of number index by varchar2(400);',
'  type t_txt is table of varchar2(4000) index by varchar2(400);',
'  type t_p  is record (n varchar2(400), q varchar2(400), s varchar2(400), t varchar2(1000), v number, a number, b number);',
'  type t_ps is table of t_p index by varchar2(400);',
'  visto t_num; acesso t_txt; nomecat t_txt; nomecc t_txt; nomefun t_txt;',
'  m_p t_num; m_d t_num; m_n t_num;                     /* por mês "AAAAMMDD" */',
'  pm_p t_num; pm_d t_num;                              /* por pessoa+mês */',
'  c_p t_num; c_d t_num; cn_p t_num; cn_d t_num;        /* por categoria: R$ e pessoas */',
'  s_q t_num; s_n t_num; s_k t_txt;                     /* por centro de custo */',
'  o_q t_num; e_q t_num;                                /* por origem / encargos da empresa por verba */',
'  he_v t_num; he_h t_num; fa_v t_num; p_cc t_txt;      /* por pessoa: hora extra (R$, horas), faltas, setor */',
'  r_a t_num; r_b t_num;                                /* verba nos 2 últimos meses */',
'  l_a t_num; l_b t_num;                                /* líquido da pessoa nos 2 últimos meses */',
'  l_prov number := 0; l_desc number := 0; l_n number := 0; l_sem number := 0;',
'  l_he number := 0; l_heh number := 0; l_enc number := 0; l_fa number := 0;',
'  l_neg t_ps; n_neg number := 0;',
'  vazio_n t_num; vazio_t t_txt;                         /* grupo sem 2º número / sem texto de busca */',
'  /* a regra do relatório (09/10): sem Pesquisar não calcula; aberto pela ficha (P21_MAT), calcula */',
'  l_pesq boolean := :P21_MAT is not null or nvl(:P21_PESQUISA, ''N'') = ''S'';',
'',
'  function d(p date) return varchar2 is begin return to_char(p, ''DD/MM/YYYY''); end;',
'  /* data de um item da página (texto no formato do app, ou dd/mm/aaaa) - nunca quebra */',
'  function dt(p varchar2) return date is',
'  begin',
'    if p is null then return null; end if;',
'    begin return to_date(p); exception when others then null; end;',
'    return to_date(substr(trim(p), 1, 10), ''DD/MM/RRRR'');',
'  exception when others then return null;',
'  end;',
'  function primeira(k varchar2) return boolean is',
'  begin',
'    if visto.exists(k) then return false; end if;',
'    visto(k) := 1; return true;',
'  end;',
'  procedure soma(a in out nocopy t_num, k varchar2, v number) is',
'    l_k varchar2(400) := nvl(substr(k, 1, 400), ''(sem informação)'');',
'  begin',
'    if a.exists(l_k) then a(l_k) := a(l_k) + v; else a(l_k) := v; end if;',
'  end;',
'  function val(a t_num, k varchar2) return number is',
'  begin',
'    if a.exists(k) then return a(k); end if; return 0;',
'  end;',
'  function pode(p_emp number, p_mat number, p_fil number) return boolean is',
'    k varchar2(100) := p_emp || ''|'' || p_mat;',
'  begin',
'    if not acesso.exists(k) then',
'      begin acesso(k) := nvl(F_Acesso_Salario_Apex(p_emp, p_mat, p_fil, :P_USUARIO), ''N'');',
'      exception when others then acesso(k) := ''N''; end;',
'    end if;',
'    return acesso(k) = ''S'';',
'  end;',
'  function categoria(p_cod varchar2) return varchar2 is',
'    k varchar2(100) := nvl(p_cod, ''-'');',
'  begin',
'    if not nomecat.exists(k) then',
'      begin nomecat(k) := nvl(initcap(Fnct_Nome_Cod_Gerencial(p_cod)), ''Sem categoria'');',
'      exception when others then nomecat(k) := ''Sem categoria''; end;',
'    end if;',
'    return nomecat(k);',
'  end;',
'  function setor(p_emp number, p_cc number) return varchar2 is',
'    k varchar2(100) := p_emp || ''|'' || p_cc;',
'  begin',
'    if not nomecc.exists(k) then',
'      begin nomecc(k) := substr(p_cc || '' - '' || initcap(fnct_nome_ccusto(p_emp, p_cc)), 1, 400);',
'      exception when others then nomecc(k) := to_char(p_cc); end;',
'    end if;',
'    return nomecc(k);',
'  end;',
'  function nome(pk varchar2) return varchar2 is',
'    l_emp number := to_number(substr(pk, 1, instr(pk, ''|'') - 1));',
'    l_mat number := to_number(substr(pk, instr(pk, ''|'') + 1));',
'  begin',
'    if not nomefun.exists(pk) then',
'      begin nomefun(pk) := substr(l_mat || '' - '' || initcap(fnct_nome_func(l_emp, l_mat)), 1, 400);',
'      exception when others then nomefun(pk) := to_char(l_mat); end;',
'    end if;',
'    return nomefun(pk);',
'  end;',
'  function pessoa(pk varchar2, p_t varchar2, p_v number) return t_p is',
'    l t_p; l_n varchar2(400) := nome(pk);',
'  begin',
'    l.n := l_n; l.q := case when instr(l_n, '' - '') > 0 then substr(l_n, instr(l_n, '' - '') + 3) else l_n end;',
'    l.s := case when p_cc.exists(pk) then p_cc(pk) end; l.t := p_t; l.v := p_v;',
'    return l;',
'  end;',
'  function desc_v(v number) return varchar2 is',
'  begin',
'    return to_char(999999999999 - least(999999999999, round(abs(nvl(v, 0)) * 100)), ''FM000000000000'');',
'  end;',
'  procedure lista(p_nome varchar2, a t_ps, p_max pls_integer default 300) is',
'    k varchar2(400) := a.first; i pls_integer := 0;',
'  begin',
'    apex_json.open_array(p_nome);',
'    while k is not null and i < p_max loop',
'      i := i + 1;',
'      apex_json.open_object;',
'      apex_json.write(''n'', a(k).n); apex_json.write(''q'', a(k).q); apex_json.write(''s'', a(k).s);',
'      if a(k).t is not null then apex_json.write(''t'', a(k).t); end if;',
'      if a(k).v is not null then apex_json.write(''v'', round(a(k).v, 2)); end if;',
'      if a(k).a is not null then apex_json.write(''a'', round(a(k).a, 2)); end if;',
'      if a(k).b is not null then apex_json.write(''b'', round(a(k).b, 2)); end if;',
'      apex_json.close_object;',
'      k := a.next(k);',
'    end loop;',
'    apex_json.close_array;',
'  end;',
'  /* os N maiores de um grupo (q), com pessoas (n) e o texto para buscar (k) */',
'  procedure maiores(p_nome varchar2, q t_num, p_n pls_integer, p_qtd t_num, p_chave t_txt) is',
'    usado t_num; k varchar2(400); melhor varchar2(400);',
'  begin',
'    apex_json.open_array(p_nome);',
'    for x in 1 .. p_n loop',
'      melhor := null; k := q.first;',
'      while k is not null loop',
'        if not usado.exists(k) and (melhor is null or q(k) > q(melhor)) then melhor := k; end if;',
'        k := q.next(k);',
'      end loop;',
'      exit when melhor is null;',
'      usado(melhor) := 1;',
'      apex_json.open_object;',
'      apex_json.write(''t'', melhor); apex_json.write(''q'', round(q(melhor), 2));',
'      if p_qtd.exists(melhor) then apex_json.write(''n'', p_qtd(melhor)); end if;',
'      if p_chave.exists(melhor) then apex_json.write(''k'', p_chave(melhor)); end if;',
'      apex_json.close_object;',
'    end loop;',
'    apex_json.close_array;',
'  end;',
'  /* uma pessoa do mapa de valores numa lista ordenada do maior para o menor */',
'  procedure top_pessoas(p_nome varchar2, a t_num, p_extra t_num, p_unid varchar2) is',
'    k varchar2(400) := a.first; l t_ps;',
'  begin',
'    while k is not null loop',
'      if a(k) > 0 then',
'        l(desc_v(a(k)) || ''|'' || k) := pessoa(k,',
'          case when p_extra.exists(k) and p_extra(k) > 0 then trim(to_char(p_extra(k), ''FM999G999G990D9'', ''NLS_NUMERIC_CHARACTERS='''',.'''''')) || '' '' || p_unid end, a(k));',
'      end if;',
'      k := a.next(k);',
'    end loop;',
'    lista(p_nome, l, 30);',
'  end;',
'',
'begin',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''hoje'', d(l_hoje));',
'',
'  l_passo := ''parametros'';',
'  begin select nvl(quatro_digitos_ocorr, ''N'') into l_4dig from configuracoes where rownum = 1;',
'  exception when others then l_4dig := ''N''; end;',
'  if l_4dig = ''S'' then l_lim_p := 4999; l_lim_d1 := 5000; l_lim_d2 := 8999; l_tot1 := 9996; l_tot2 := 9999;',
'  else                 l_lim_p := 499;  l_lim_d1 := 500;  l_lim_d2 := 899;  l_tot1 := 996;  l_tot2 := 999; end if;',
'  apex_json.write(''quatro'', l_4dig);',
'  apex_json.write(''sem_pesquisa'', not l_pesq);',
'  l_adm_ini := dt(:P21_DT_ADM_INI); l_adm_fim := dt(:P21_DT_ADM_FIM);',
'  l_ret_ini := dt(:P21_DT_RETENCAO_INI); l_ret_fim := dt(:P21_DT_RETENCAO_FIM);',
'',
'  /* os meses escolhidos no Período (dd/mm/aaaa:dd/mm/aaaa...): a faixa min-max usa o índice, a lista confere */',
'  declare l_resto varchar2(32767) := :P21_DATA_REF || '':''; l_x varchar2(40); l_dt date;',
'  begin',
'    while l_resto is not null and instr(l_resto, '':'') > 0 loop',
'      l_x := substr(l_resto, 1, instr(l_resto, '':'') - 1);',
'      l_resto := substr(l_resto, instr(l_resto, '':'') + 1);',
'      l_dt := dt(l_x);',
'      if l_dt is not null then',
'        l_refs := l_refs || to_char(l_dt, ''YYYYMMDD'') || ''|'';',
'        if l_min is null or l_dt < l_min then l_min := l_dt; end if;',
'        if l_max is null or l_dt > l_max then l_max := l_dt; end if;',
'        if l_ult is null or l_dt > l_ult then l_ant := l_ult; l_ult := l_dt;',
'        elsif l_dt < l_ult and (l_ant is null or l_dt > l_ant) then l_ant := l_dt; end if;',
'      end if;',
'    end loop;',
'  end;',
'',
'  if l_min is not null and l_pesq then',
'    l_passo := ''linhas'';',
'    for r in (',
'      with inf as (select i.cod_empresa, i.matricula, i.filial',
'                     from informacoes_funcionais i',
'                    where i.cod_empresa = nvl(:P21_EMP, nvl(:P21_EMPRESA, i.cod_empresa))',
'                      and (:P21_FILIAL_INI is null or i.filial between :P21_FILIAL_INI and :P21_FILIAL_FIM)',
'                      and (:P21_CCUSTO_INI is null or i.cod_ccusto between :P21_CCUSTO_INI and :P21_CCUSTO_FIM)',
'                      and (l_adm_ini is null or i.dt_admissao_basica between l_adm_ini and l_adm_fim)',
'                      and (:P21_SINDICATO is null or instr(l_sind, '':'' || i.num_sind_diss || '':'') > 0)',
'                      and (:P21_SITUACOES is null or instr(l_sit, '':'' || i.situacao || '':'') > 0)',
'                      and (:P21_VINCULOS is null or instr(l_vinc, '':'' || i.vinculo || '':'') > 0)',
'                      and (:P21_MATRICULA_INI is null or i.matricula between nvl(:P21_MAT, nvl(:P21_MATRICULA_INI, i.matricula))',
'                                                                         and nvl(:P21_MAT, nvl(:P21_MATRICULA_FIM, i.matricula)))),',
'           hist as (select h.cod_empresa, h.matricula, h.cod_ccusto, h.data_ref, h.cod_ocorr, h.nome_ocorrencia, h.cod_gerencial,',
'                           h.incid_liq, h.valor, h.unidade1, h.origem',
'                      from mwv_historicos h',
'                     where h.data_ref between l_min and l_max',
'                       and instr(l_refs, ''|'' || to_char(h.data_ref, ''YYYYMMDD'') || ''|'') > 0',
'                       and (:P21_CCUSTO_CONT_INI is null or h.cod_ccusto_cont between :P21_CCUSTO_CONT_INI and :P21_CCUSTO_CONT_FIM)',
'                       and (l_ret_ini is null or h.data_retencao between l_ret_ini and l_ret_fim)',
'                       and (:P21_TIPO_RUBRICA is null or instr(l_trub, '':'' || h.tipo_rubrica || '':'') > 0)',
'                       and (:P21_COD_OCORR is null or instr(l_ocor, '':'' || h.cod_ocorr || '':'') > 0)',
'                       and h.origem in (:P21_H_FINAN_ACM, :P21_H_FERIAS, :P21_H_RESC, :P21_H_13, :P21_H_ADIANT, :P21_H_PART, :P21_H_RECALC, :P21_H_DIVERSOS, :P21_H_DIVERSOS_ACM)',
'                       and h.cod_ocorr is not null',
'                       and not exists (select 1 from view_mat_historicos_mes hm',
'                                        where hm.cod_empresa = h.cod_empresa and hm.matricula = h.matricula',
'                                          and hm.data_ref = h.data_ref and hm.cod_ocorr = h.cod_ocorr)',
'                    union all',
'                    select h.cod_empresa, h.matricula, h.cod_ccusto, h.data_ref, h.cod_ocorr, h.nome_ocorrencia, h.cod_gerencial,',
'                           h.incid_liq, h.valor, h.unidade1, h.origem',
'                      from mwv_historicos_mes h',
'                     where h.data_ref between l_min and l_max',
'                       and instr(l_refs, ''|'' || to_char(h.data_ref, ''YYYYMMDD'') || ''|'') > 0',
'                       and (:P21_CCUSTO_CONT_INI is null or h.cod_ccusto_cont between :P21_CCUSTO_CONT_INI and :P21_CCUSTO_CONT_FIM)',
'                       and (l_ret_ini is null or h.data_retencao between l_ret_ini and l_ret_fim)',
'                       and (:P21_TIPO_RUBRICA is null or instr(l_trub, '':'' || h.tipo_rubrica || '':'') > 0)',
'                       and (:P21_COD_OCORR is null or instr(l_ocor, '':'' || h.cod_ocorr || '':'') > 0)',
'                       and h.origem in (:P21_H_FINAN, :P21_H_FERIAS, :P21_H_RESC, :P21_H_13, :P21_H_ADIANT, :P21_H_PART, :P21_H_RECALC, :P21_H_DIVERSOS, :P21_H_DIVERSOS_ACM)',
'                       and h.cod_ocorr is not null)',
'      select v.cod_empresa, v.matricula, i.filial, v.cod_ccusto, v.data_ref, v.cod_ocorr, v.nome_ocorrencia, v.cod_gerencial,',
'             v.incid_liq, v.valor, v.unidade1, v.origem',
'        from hist v, inf i',
'       where v.cod_empresa = i.cod_empresa',
'         and v.matricula = i.matricula',
'    ) loop',
'      declare',
'        pk   varchar2(100) := r.cod_empresa || ''|'' || r.matricula;',
'        mk   varchar2(10) := to_char(r.data_ref, ''YYYYMMDD'');',
'        cod  number := r.cod_ocorr;',
'        tipo varchar2(1);',
'        vlr  number := nvl(r.valor, 0);',
'        cat  varchar2(400);',
'        ucat varchar2(400);',
'        rub  varchar2(400);',
'      begin',
'        if cod between l_tot1 and l_tot2 then null;              /* os totais da folha: não contam de novo */',
'        elsif not pode(r.cod_empresa, r.matricula, r.filial) then',
'          if primeira(''S|'' || pk) then l_sem := l_sem + 1; end if;',
'        else',
'          tipo := case when cod <= l_lim_p and r.incid_liq = ''S'' then ''P''',
'                       when cod between l_lim_d1 and l_lim_d2 and r.incid_liq = ''S'' then ''D''',
'                       else ''B'' end;',
'          cat := categoria(r.cod_gerencial);',
'          ucat := upper(translate(cat, ''ÁÀÃÂÉÊÍÓÔÕÚÇáàãâéêíóôõúç'', ''AAAAEEIOOOUCaaaaeeiooouc''));',
'          if not p_cc.exists(pk) then p_cc(pk) := setor(r.cod_empresa, r.cod_ccusto); end if;',
'          if primeira(''N|'' || mk || ''|'' || pk) then soma(m_n, mk, 1); end if;',
'          if primeira(''P|'' || pk) then l_n := l_n + 1; end if;',
'          rub := substr(cod || '' - '' || initcap(r.nome_ocorrencia), 1, 400);',
'          if tipo = ''P'' then',
'            l_prov := l_prov + vlr; soma(m_p, mk, vlr); soma(pm_p, mk || ''|'' || pk, vlr);',
'            soma(c_p, cat, vlr); if primeira(''CP|'' || cat || ''|'' || pk) then soma(cn_p, cat, 1); end if;',
'            soma(s_q, p_cc(pk), vlr); s_k(p_cc(pk)) := to_char(r.cod_ccusto);',
'            if primeira(''SN|'' || p_cc(pk) || ''|'' || pk) then soma(s_n, p_cc(pk), 1); end if;',
'            soma(o_q, replace(replace(r.origem, '' Acm.'', ''''), '' Acm'', ''''), vlr);',
'            if ucat like ''HORAS EXTRAS%'' then',
'              l_he := l_he + vlr; l_heh := l_heh + nvl(r.unidade1, 0); soma(he_v, pk, vlr); soma(he_h, pk, nvl(r.unidade1, 0));',
'            end if;',
'          elsif tipo = ''D'' then',
'            l_desc := l_desc + vlr; soma(m_d, mk, vlr); soma(pm_d, mk || ''|'' || pk, vlr);',
'            soma(c_d, cat, vlr); if primeira(''CD|'' || cat || ''|'' || pk) then soma(cn_d, cat, 1); end if;',
'            if ucat like ''FALTAS%'' then l_fa := l_fa + vlr; soma(fa_v, pk, vlr); end if;',
'          end if;',
'          if ucat like ''ENCARGOS EMPRESA%'' then l_enc := l_enc + vlr; soma(e_q, rub, vlr); end if;',
'          /* para "o que mais mudou": verbas de provento e desconto nos 2 últimos meses */',
'          if tipo in (''P'', ''D'') and l_ant is not null then',
'            if r.data_ref = l_ult then soma(r_b, rub, case when tipo = ''D'' then -vlr else vlr end);',
'            elsif r.data_ref = l_ant then soma(r_a, rub, case when tipo = ''D'' then -vlr else vlr end); end if;',
'            if r.data_ref = l_ult then soma(l_b, pk, case when tipo = ''D'' then -vlr else vlr end);',
'            elsif r.data_ref = l_ant then soma(l_a, pk, case when tipo = ''D'' then -vlr else vlr end); end if;',
'          end if;',
'        end if;',
'      end;',
'    end loop;',
'  end if;',
'',
'  l_passo := ''negativos'';',
'  /* SALDO NEGATIVO: descontos maiores que os ganhos no mês (a pessoa fica devendo). Líquido ZERO não',
'     entra: é o normal de quem passou o mês de férias ou recebeu tudo adiantado */',
'  declare k varchar2(400); l_mk varchar2(10); l_pk varchar2(100); l_liq number;',
'  begin',
'    k := pm_d.first;',
'    while k is not null loop',
'      l_liq := val(pm_p, k) - pm_d(k);',
'      if l_liq < -0.004 then',
'        l_mk := substr(k, 1, 8); l_pk := substr(k, 10);',
'        n_neg := n_neg + 1;',
'        l_neg(l_mk || ''|'' || desc_v(l_liq) || ''|'' || l_pk) := pessoa(l_pk,',
'          to_char(to_date(l_mk, ''YYYYMMDD''), ''MM/YYYY'') || '' · ganhou '' || to_char(val(pm_p, k), ''FM999G999G990D00'', ''NLS_NUMERIC_CHARACTERS='''',.'''''')',
'          || '' e teve '' || to_char(pm_d(k), ''FM999G999G990D00'', ''NLS_NUMERIC_CHARACTERS='''',.'''''') || '' de desconto'', l_liq);',
'      end if;',
'      k := pm_d.next(k);',
'    end loop;',
'  end;',
'',
'  l_passo := ''json'';',
'  apex_json.write(''sem_acesso'', l_sem);',
'  if l_ult is not null then apex_json.write(''ult'', d(l_ult)); end if;',
'  if l_ant is not null then apex_json.write(''ant'', d(l_ant)); end if;',
'  apex_json.open_array(''meses'');',
'  declare k varchar2(400) := m_n.first;',
'  begin',
'    while k is not null loop',
'      apex_json.open_object;',
'      apex_json.write(''m'', substr(k, 1, 4) || ''-'' || substr(k, 5, 2));',
'      apex_json.write(''p'', round(val(m_p, k), 2)); apex_json.write(''d'', round(val(m_d, k), 2)); apex_json.write(''n'', m_n(k));',
'      apex_json.close_object;',
'      k := m_n.next(k);',
'    end loop;',
'  end;',
'  apex_json.close_array;',
'  apex_json.open_object(''agora'');',
'  apex_json.write(''prov'', round(l_prov, 2));',
'  apex_json.write(''desc'', round(l_desc, 2));',
'  apex_json.write(''liq'', round(l_prov - l_desc, 2));',
'  apex_json.write(''pessoas'', l_n);',
'  apex_json.write(''he'', round(l_he, 2));',
'  apex_json.write(''he_horas'', round(l_heh, 1));',
'  apex_json.write(''he_pessoas'', he_v.count);',
'  apex_json.write(''negativos'', n_neg);',
'  apex_json.write(''faltas'', round(l_fa, 2));',
'  apex_json.write(''faltas_pessoas'', fa_v.count);',
'  apex_json.write(''encargos'', round(l_enc, 2));',
'  apex_json.close_object;',
'',
'  lista(''negativos'', l_neg);',
'  top_pessoas(''hepessoas'', he_v, he_h, ''horas'');',
'  top_pessoas(''faltaspessoas'', fa_v, vazio_n, '''');',
'  maiores(''catp'', c_p, 20, cn_p, vazio_t);',
'  maiores(''catd'', c_d, 20, cn_d, vazio_t);',
'  maiores(''setores'', s_q, 40, s_n, s_k);',
'  maiores(''origens'', o_q, 12, vazio_n, vazio_t);',
'  maiores(''encargos'', e_q, 12, vazio_n, vazio_t);',
'',
'  l_passo := ''mudou'';',
'  /* as verbas que mais mudaram (em R$, para mais ou para menos) e as pessoas cujo líquido mais mudou */',
'  declare k varchar2(400); l_v t_num; l_ord t_ps; l_x t_p;',
'  begin',
'    k := r_a.first;',
'    while k is not null loop l_v(k) := val(r_b, k) - r_a(k); k := r_a.next(k); end loop;',
'    k := r_b.first;',
'    while k is not null loop if not r_a.exists(k) then l_v(k) := r_b(k); end if; k := r_b.next(k); end loop;',
'    k := l_v.first;',
'    while k is not null loop',
'      if abs(l_v(k)) >= 0.01 then',
'        l_x.n := k; l_x.q := k; l_x.s := null; l_x.t := null; l_x.v := l_v(k); l_x.a := val(r_a, k); l_x.b := val(r_b, k);',
'        l_ord(desc_v(l_v(k)) || ''|'' || k) := l_x;',
'      end if;',
'      k := l_v.next(k);',
'    end loop;',
'    lista(''mudou'', l_ord, 15);',
'    l_ord.delete;',
'    k := l_a.first;',
'    while k is not null loop',
'      if l_b.exists(k) and abs(l_b(k) - l_a(k)) >= 0.01 then',
'        l_x := pessoa(k, null, l_b(k) - l_a(k)); l_x.a := l_a(k); l_x.b := l_b(k);',
'        l_ord(desc_v(l_b(k) - l_a(k)) || ''|'' || k) := l_x;',
'      end if;',
'      k := l_a.next(k);',
'    end loop;',
'    lista(''pessoasmudou'', l_ord, 30);',
'  end;',
'',
'  apex_json.close_object;',
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
