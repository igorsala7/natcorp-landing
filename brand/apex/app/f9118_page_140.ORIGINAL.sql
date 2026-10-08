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
,p_default_application_id=>9118
,p_default_id_offset=>697103804116150100
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9118 - Avaliações - Processos
--
-- Application Export:
--   Application:     9118
--   Name:            Avaliações - Processos
--   Date and Time:   03:50 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 140
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00140
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>140);
end;
/
prompt --application/pages/page_00140
begin
wwv_flow_api.create_page(
 p_id=>140
,p_user_interface_id=>wwv_flow_api.id(88927852534180042432)
,p_name=>unistr('Avalia\00E7\00E3o')
,p_step_title=>unistr('Avalia\00E7\00E3o')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.hideBackground{',
'    opacity: 1 !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260811153356'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(33297398057967305273)
,p_plug_name=>'Resultado'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>22
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
' FROM  Av_Aplica_Avaliacoes_Itens',
' WHERE COD_EMP_AVALIADO   = :P140_COD_EMP_AVALIADO',
' AND   COD_MAT_AVALIADO   = :P140_COD_MAT_AVALIADO',
' AND   COD_EMP_AVALIADOR  = :P140_COD_EMP_AVALIADOR',
' AND   COD_MAT_AVALIADOR  = :P140_COD_MAT_AVALIADOR',
' AND   COD_AVALIACAO      = :P140_COD_AVALIACAO',
' AND   DATA_AVALIACAO     = :P140_DATA_AVALIACAO',
' AND   TIPO_AVALIACAO     = :P140_TIPO_AVALIACAO'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(33297398480816305277)
,p_plug_name=>unistr('Relat\00F3rio: Avalia\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--large:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927825106663042335)
,p_plug_display_sequence=>42
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(37771763460649520179)
,p_plug_name=>'Aviso'
,p_region_name=>'AVISO'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--info:t-Alert--removeHeading'
,p_plug_template=>wwv_flow_api.id(88927816969431042300)
,p_plug_display_sequence=>62
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(53709741578601898240)
,p_plug_name=>'Recurso do Avaliado'
,p_region_name=>'RECURSO_AVALIADO'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>4
,p_plug_display_column=>5
,p_plug_display_point=>'REGION_POSITION_05'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select nvl(ind_recurso,''N'') ind_recurso',
'  from av_avaliacoes a',
' where a.cod_avaliacao = :p140_cod_avaliacao;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select ''S'' existe',
'  from AV_APLICA_AVALIACOES',
'where cod_avaliacao = :p140_cod_avaliacao',
'and cod_emp_avaliado = :p140_cod_emp_avaliado',
'and cod_mat_avaliado = :p140_cod_mat_avaliado',
'and cod_emp_avaliador = :p140_cod_emp_avaliador',
'and cod_mat_avaliador = :p140_cod_mat_avaliador',
'and data_avaliacao = :p140_data_avaliacao',
'and (:p140_cod_ciclo is null or cod_ciclo = :p140_cod_ciclo)',
'and SOLICITA_RECURSO = ''S'';',
'',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'if nvl(v_c2.existe,''N'') = ''N'' then',
'',
'  if :p140_tipo_avaliacao <> ''C'' then',
'    if :p140_rowid is not null then',
'    ',
'      open c1;',
'      fetch c1 into v_c1;',
'      close c1;',
'      ',
'      if v_c1.ind_recurso = ''S'' then',
'        if :p140_cod_emp_avaliado = :p_empresa_user and',
'           :p140_cod_mat_avaliado = :p_matricula_user and',
'           :p140_ind_aceite is null then',
'         return true;',
'        else',
'         return false;',
'        end if;',
'      else',
'        return false;',
'      end if;',
'      ',
'    else',
'        return false;',
'    end if;',
'  else',
'    return false;',
'  end if;',
'',
'else',
'',
'return false;',
'',
'end if;',
'',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(53709833344112972132)
,p_plug_name=>'Container'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>72
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_plug_display_when_condition=>'P140_PERMITE_CONSULTAR'
,p_plug_display_when_cond2=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(86967095710669551470)
,p_name=>unistr('Plano de Sucess\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_template=>wwv_flow_api.id(88927826537342042338)
,p_display_sequence=>92
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s."ROWID",',
'       s.cod_emp_avaliado,',
'       s.cod_mat_avaliado,',
'       s.cod_emp_avaliador,',
'       s.cod_mat_avaliador,',
'       s.cod_avaliacao,',
'       s.data_avaliacao,',
'       s.cod_emp_substituto,',
'       s.cod_mat_substituto,',
'       s.cod_emp_substituto||'' - ''||initcap(fnct_nome_empresa(s.cod_emp_substituto)) empresa,',
'       s.cod_mat_substituto||'' - ''||initcap(fnct_nome_func(s.cod_emp_substituto,s.cod_mat_substituto)) colaborador,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa,i.filial)) filial,',
'       i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa,i.cod_ccusto)) ccusto,',
'       i.cargo||'' - ''||initcap(fnct_nome_cargo(i.cargo)) cargo,',
'       i.dt_admissao',
'  from AV_SUBSTITUICOES s, informacoes_funcionais i',
' where s.cod_emp_substituto = i.cod_empresa',
'   and s.cod_mat_substituto = i.matricula',
'   and s.cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and s.cod_mat_avaliado = :p140_cod_mat_avaliado',
'   and s.cod_emp_avaliador = :p140_cod_emp_avaliador',
'   and s.cod_mat_avaliador = :p140_cod_mat_avaliador',
'   and s.cod_avaliacao = :p140_cod_avaliacao',
'   and s.data_avaliacao = :p140_data_avaliacao',
' order by s.cod_emp_substituto, s.cod_mat_substituto '))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(88927835348896042354)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em Adicionar +.'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320720711941011654)
,p_query_column_id=>1
,p_column_alias=>'ROWID'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:143:&SESSION.::&DEBUG.:RP,143:P143_ROWID:#ROWID#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_lov_show_nulls=>'YES'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320721091886011654)
,p_query_column_id=>2
,p_column_alias=>'COD_EMP_AVALIADO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320721491022011654)
,p_query_column_id=>3
,p_column_alias=>'COD_MAT_AVALIADO'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320721839698011654)
,p_query_column_id=>4
,p_column_alias=>'COD_EMP_AVALIADOR'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320716326045011649)
,p_query_column_id=>5
,p_column_alias=>'COD_MAT_AVALIADOR'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320716701959011650)
,p_query_column_id=>6
,p_column_alias=>'COD_AVALIACAO'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320717045545011650)
,p_query_column_id=>7
,p_column_alias=>'DATA_AVALIACAO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320717467264011650)
,p_query_column_id=>8
,p_column_alias=>'COD_EMP_SUBSTITUTO'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320717908560011650)
,p_query_column_id=>9
,p_column_alias=>'COD_MAT_SUBSTITUTO'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320718250658011651)
,p_query_column_id=>10
,p_column_alias=>'EMPRESA'
,p_column_display_sequence=>10
,p_column_heading=>'Empresa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320718708195011652)
,p_query_column_id=>11
,p_column_alias=>'COLABORADOR'
,p_column_display_sequence=>11
,p_column_heading=>'Colaborador'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMP_SUBSTITUTO#,#COD_MAT_SUBSTITUTO#'
,p_column_linktext=>'#COLABORADOR#'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320719115750011652)
,p_query_column_id=>12
,p_column_alias=>'FILIAL'
,p_column_display_sequence=>12
,p_column_heading=>'Filial'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320719456694011653)
,p_query_column_id=>13
,p_column_alias=>'CCUSTO'
,p_column_display_sequence=>13
,p_column_heading=>'Centro de Custo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320719911520011653)
,p_query_column_id=>14
,p_column_alias=>'CARGO'
,p_column_display_sequence=>14
,p_column_heading=>'Cargo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320720269404011653)
,p_query_column_id=>15
,p_column_alias=>'DT_ADMISSAO'
,p_column_display_sequence=>15
,p_column_heading=>unistr('Data de Admiss\00E3o')
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86989880819763426661)
,p_plug_name=>'Search'
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>32
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(86989884064293426669)
,p_name=>unistr('Quest\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_template=>wwv_flow_api.id(88927826537342042338)
,p_display_sequence=>42
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a."ROWID",',
'       a.COD_EMPRESA,',
'       a.COD_AVALIACAO,',
'       a.COD_ITEM_AVALIACAO,',
'       a.PESO,',
'       a.RESPOSTA_MULTIPLA,',
'       i.descricao,',
'       a.ESPECIFICACAO,',
'       a.OBSERVACAO,',
'       a.USUARIO,',
'       a.DT_ATUALIZACAO,',
'       a.COD_COMP,',
'       c.descricao Competencia,',
'       a.cod_grupo_comp,',
'       g.descricao grupo_competencia,',
'       a.INDICADOR,',
'       a.ORDEM_ITEM,',
'      (Select nvl(v.resposta_dissertativa,initcap(i.texto)) resposta',
'           From Av_Aplica_Avaliacoes_Itens v, av_sub_itens_avaliacao i',
'          Where v.cod_emp_avaliador = i.cod_empresa (+)',
'            and v.cod_avaliacao = i.cod_avaliacao (+)',
'            and v.Cod_Item_Avaliacao = i.cod_item_avaliacao (+)',
'            and v.Cod_Emp_Avaliado       = :p140_Cod_Emp_Avaliado',
'            And v.Cod_Mat_Avaliado       = :p140_Cod_Mat_Avaliado',
'            And v.Cod_Emp_Avaliador      = :p140_Cod_Emp_Avaliador',
'            And v.Cod_Mat_Avaliador      = :p140_Cod_Mat_Avaliador',
'            And v.Cod_Avaliacao          = :p140_Cod_Avaliacao',
'            And v.Data_Avaliacao         = :p140_Data_Avaliacao',
'            And v.Cod_Item_Avaliacao     = a.Cod_Item_Avaliacao',
'            And v.Tipo_Avaliacao         = :p140_tipo_avaliacao',
'            And v.Cod_Ciclo = NVL(:p140_cod_ciclo_aux,:p140_cod_ciclo)',
'            And v.Cod_Sub_Item_Avaliacao = i.Cod_Sub_Item_Avaliacao (+) FETCH FIRST 1 ROWS ONLY) Resposta,',
'       (Select v.nota_item',
'           From Av_Aplica_Avaliacoes_Itens v, av_sub_itens_avaliacao i',
'          Where v.cod_emp_avaliador = i.cod_empresa (+)',
'            and v.cod_avaliacao = i.cod_avaliacao (+)',
'            and v.Cod_Item_Avaliacao = i.cod_item_avaliacao (+)',
'            and v.Cod_Emp_Avaliado       = :p140_Cod_Emp_Avaliado',
'            And v.Cod_Mat_Avaliado       = :p140_Cod_Mat_Avaliado',
'            And v.Cod_Emp_Avaliador      = :p140_Cod_Emp_Avaliador',
'            And v.Cod_Mat_Avaliador      = :p140_Cod_Mat_Avaliador',
'            And v.Cod_Avaliacao          = :p140_Cod_Avaliacao',
'            And v.Data_Avaliacao         = :p140_Data_Avaliacao',
'            And v.Cod_Item_Avaliacao     = a.Cod_Item_Avaliacao',
'            And v.Tipo_Avaliacao         = :p140_tipo_avaliacao',
'            and v.Cod_Ciclo = NVL(:p140_cod_ciclo_aux,:p140_cod_ciclo)',
'            And v.Cod_Sub_Item_Avaliacao = i.Cod_Sub_Item_Avaliacao (+) FETCH FIRST 1 ROWS ONLY) Nota',
'  from AV_COMPOSICAO_AVALIACAO a, av_competencia c, av_Item_avaliacao i, AV_GRUPO_COMPETENCIA G',
' where a.cod_grupo_comp = g.codigo (+)',
'  -- and a.cod_grupo_comp = c.cod_grupo_competencia (+)',
'   and a.cod_comp = c.codigo (+)',
'   and a.cod_item_avaliacao = i.codigo',
'   and a.cod_empresa = :p140_cod_emp_avaliado',
'   and a.cod_avaliacao = :p140_cod_avaliacao',
'order by cod_avaliacao, ordem_item'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P140_COD_EMP_AVALIADO,P140_COD_AVALIACAO,P140_TIPO_AVALIACAO,P140_COD_CICLO,P140_COD_CICLO_AUX'
,p_query_row_template=>wwv_flow_api.id(88927835348896042354)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'Nenhum Dado Encontrado'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320724867737011658)
,p_query_column_id=>1
,p_column_alias=>'ROWID'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:144:&SESSION.::&DEBUG.:RP,144:P144_COD_EMPRESA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_DATA_AVALIACAO,P144_COD_AVALIACAO,P144_TIPO_AVALIACAO,P144_ORDEM_ITEM,P144_ROWID,P144_MATRICULA,P144_COD_CICLO,P144_DESABILITA_QUESTOES_AUX'
||',P144_COD_CICLO_AUX,P144_IND_ACEITE,P144_REAVALIACAO:&P140_COD_EMP_AVALIADO.,&P140_COD_EMP_AVALIADOR.,&P140_COD_MAT_AVALIADOR.,&P140_DATA_AVALIACAO.,&P140_COD_AVALIACAO.,&P140_TIPO_AVALIACAO.,#ORDEM_ITEM#,#ROWID#,&P140_COD_MAT_AVALIADO.,&P140_COD_CIC'
||'LO.,&P140_DESABILITA_QUESTOES_AUX.,&P140_COD_CICLO_AUX.,&P140_IND_ACEITE.,&P140_REAVALIACAO.'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil-alt.png" class="apex-edit-pencil-alt" alt="">'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320725270090011658)
,p_query_column_id=>2
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320725692122011658)
,p_query_column_id=>3
,p_column_alias=>'COD_AVALIACAO'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320726087405011659)
,p_query_column_id=>4
,p_column_alias=>'COD_ITEM_AVALIACAO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320726443860011659)
,p_query_column_id=>5
,p_column_alias=>'PESO'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320726882501011659)
,p_query_column_id=>6
,p_column_alias=>'RESPOSTA_MULTIPLA'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320727254817011660)
,p_query_column_id=>7
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>10
,p_column_heading=>unistr('Especifica\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320727689790011660)
,p_query_column_id=>8
,p_column_alias=>'ESPECIFICACAO'
,p_column_display_sequence=>11
,p_column_heading=>unistr('Descri\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_column_hit_highlight=>'&P140_REPORT_SEARCH.'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320728085236011660)
,p_query_column_id=>9
,p_column_alias=>'OBSERVACAO'
,p_column_display_sequence=>12
,p_column_heading=>unistr('Observa\00E7\00E3o / Pergunta')
,p_use_as_row_header=>'N'
,p_column_hit_highlight=>'&P140_REPORT_SEARCH.'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320728522223011661)
,p_query_column_id=>10
,p_column_alias=>'USUARIO'
,p_column_display_sequence=>13
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320728884837011661)
,p_query_column_id=>11
,p_column_alias=>'DT_ATUALIZACAO'
,p_column_display_sequence=>14
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320729262834011661)
,p_query_column_id=>12
,p_column_alias=>'COD_COMP'
,p_column_display_sequence=>15
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320729694313011661)
,p_query_column_id=>13
,p_column_alias=>'COMPETENCIA'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Compet\00EAncia')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37810847452835334363)
,p_query_column_id=>14
,p_column_alias=>'COD_GRUPO_COMP'
,p_column_display_sequence=>19
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37810847535844334364)
,p_query_column_id=>15
,p_column_alias=>'GRUPO_COMPETENCIA'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Grupo de Compet\00EAncia')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320730032199011662)
,p_query_column_id=>16
,p_column_alias=>'INDICADOR'
,p_column_display_sequence=>16
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320730462846011662)
,p_query_column_id=>17
,p_column_alias=>'ORDEM_ITEM'
,p_column_display_sequence=>2
,p_column_heading=>'Ordem'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320730913024011662)
,p_query_column_id=>18
,p_column_alias=>'RESPOSTA'
,p_column_display_sequence=>17
,p_column_heading=>'Resposta'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53701760182702047140)
,p_query_column_id=>19
,p_column_alias=>'NOTA'
,p_column_display_sequence=>18
,p_column_heading=>'Nota'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86990094093204190768)
,p_plug_name=>'Plano de Desenvolvimento'
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>52
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Retirado valida\00E7\00E3o Read-Only (Adriana/Patr\00EDcia) 30/04/2025'),
'if :P_MATRICULA_USER = nvl(:P140_cod_mat_avaliado_aux,:P140_cod_mat_avaliado) then',
'   RETURN TRUE;',
'else',
'   RETURN FALSE;',
'end if;'))
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86990094850914190776)
,p_plug_name=>unistr('Coment\00E1rio')
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>72
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86990095649582190784)
,p_plug_name=>unistr('Conclus\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>82
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(86990148862742365349)
,p_name=>'Feedback'
,p_parent_plug_id=>wwv_flow_api.id(53709833344112972132)
,p_template=>wwv_flow_api.id(88927826537342042338)
,p_display_sequence=>62
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select "ROWID",',
'cod_emp_avaliado,',
'       cod_mat_avaliado,',
'       cod_emp_avaliador,',
'       cod_mat_avaliador,',
'       cod_avaliacao,',
'       data_avaliacao,',
'       cod_sequencia,',
'       aspecto_melhorar,',
'       como_melhorar,',
'       tempo_meses',
'  from AV_AVALIACOES_MELHORIAS',
' where cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and cod_mat_avaliado = :p140_cod_mat_avaliado',
'   and cod_emp_avaliador = :p140_cod_emp_avaliador',
'   and cod_mat_avaliador = :p140_cod_mat_avaliador',
'   and cod_avaliacao = :p140_cod_avaliacao',
'   and data_avaliacao = :p140_data_avaliacao',
' order by cod_sequencia'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_AVALIACAO'
,p_query_row_template=>wwv_flow_api.id(88927835348896042354)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_break_cols=>'0'
,p_query_no_data_found=>'Clique em Adicionar +.'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_break_type_flag=>'DEFAULT_BREAK_FORMATTING'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320756435299011686)
,p_query_column_id=>1
,p_column_alias=>'ROWID'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:142:&SESSION.::&DEBUG.:RP,142:P142_ROWID:#ROWID#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_column_alignment=>'CENTER'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P_PAINEL'
,p_display_when_condition2=>'PG'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320756837396011686)
,p_query_column_id=>2
,p_column_alias=>'COD_EMP_AVALIADO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320757266229011686)
,p_query_column_id=>3
,p_column_alias=>'COD_MAT_AVALIADO'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320757710942011686)
,p_query_column_id=>4
,p_column_alias=>'COD_EMP_AVALIADOR'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320758113348011687)
,p_query_column_id=>5
,p_column_alias=>'COD_MAT_AVALIADOR'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320758496403011687)
,p_query_column_id=>6
,p_column_alias=>'COD_AVALIACAO'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320758881469011687)
,p_query_column_id=>7
,p_column_alias=>'DATA_AVALIACAO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320759260865011688)
,p_query_column_id=>8
,p_column_alias=>'COD_SEQUENCIA'
,p_column_display_sequence=>8
,p_column_heading=>unistr('Sequ\00EAncia')
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320759689393011688)
,p_query_column_id=>9
,p_column_alias=>'ASPECTO_MELHORAR'
,p_column_display_sequence=>9
,p_column_heading=>'Aspecto a Melhorar'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320760061463011688)
,p_query_column_id=>10
,p_column_alias=>'COMO_MELHORAR'
,p_column_display_sequence=>10
,p_column_heading=>'Como Melhorar'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(63320760489065011689)
,p_query_column_id=>11
,p_column_alias=>'TEMPO_MESES'
,p_column_display_sequence=>11
,p_column_heading=>'Tempo (Meses)'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(81854435566039133208)
,p_plug_name=>'&P140_TITULO_AVALIACAO.'
,p_icon_css_classes=>'fa-check-square-o'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--noPadding:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(88927824962254042335)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86989937016878630365)
,p_plug_name=>unistr('Avalia\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>12
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(33297398377920305276)
,p_plug_name=>unistr('Relat\00F3rios')
,p_parent_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P140_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86989975531363555865)
,p_plug_name=>'Avaliado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(88927822824052042333)
,p_plug_display_sequence=>52
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86989977057313555870)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86989977894835555872)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86990572402901522261)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(55506748342532125257)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(53709741578601898240)
,p_button_name=>'Aprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--iconLeft:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_image_alt=>unistr('Concordo com a Avalia\00E7\00E3o')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   ',
'   V_VALIDA_DATA NUMBER := 0;',
'   vbool boolean;',
'',
'begin',
'',
'SELECT COUNT(1)',
'INTO V_VALIDA_DATA',
'  FROM AV_CICLOS  ',
' WHERE COD_EMPRESA = :P140_COD_EMP_AVALIADO ',
'   AND COD_CICLO = :P140_COD_CICLO',
'   AND ((TRUNC(SYSDATE) >= TRUNC(DT_INI_CICLO) AND  TRUNC(SYSDATE) <= TRUNC(DT_FIM_CICLO)) ',
'		AND (TRUNC(SYSDATE) >= TRUNC(DT_INI_AVAL_CONSENSO) AND  TRUNC(SYSDATE) <= TRUNC(DT_FIM_AVAL_CONSENSO)));',
'',
'',
'if V_VALIDA_DATA = 0 then',
'   vbool := FALSE;',
'ELSE ',
'   vbool := TRUE;',
'end if;',
'',
'if vbool then ',
'    IF NVL(:P140_TIPO_AVALIACAO, ''G'') != ''A'' THEN',
'        vbool := TRUE;',
'    ELSE',
'        vbool :=  FALSE;',
'    END IF;',
'end if;',
'return vbool;',
'',
'exception',
'    when others then',
'     return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(33297398486031305278)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(33297398480816305277)
,p_button_name=>'CHAMA_AVALIACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Avalia\00E7\00E3o')
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P140_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-pdf-o'
,p_grid_new_row=>'Y'
,p_grid_column_span=>4
,p_grid_column=>5
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(55506748380303125258)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(53709741578601898240)
,p_button_name=>'Rejeitar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_image_alt=>unistr('Discordo com a Avalia\00E7\00E3o')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:146:&SESSION.::&DEBUG.:RP,146:P146_COD_EMP_AVALIADO,P146_COD_MAT_AVALIADO,P146_COD_EMP_AVALIADOR_PRIMEIRO,P146_COD_MAT_AVALIADOR_PRIMEIRO,P146_COD_AVALIACAO,P146_COD_CICLO,P146_DATA_AVALIACAO,P146_TIPO_AVALIACAO:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.,&P140_COD_EMP_AVALIADOR.,&P140_COD_MAT_AVALIADOR.,&P140_COD_AVALIACAO.,&P140_COD_CICLO.,&P140_DATA_AVALIACAO.,&P140_TIPO_AVALIACAO.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   ',
'   V_VALIDA_DATA NUMBER := 0;',
'   vbool boolean;',
'',
'begin',
'',
'SELECT COUNT(1)',
'INTO V_VALIDA_DATA',
'  FROM AV_CICLOS  ',
' WHERE COD_EMPRESA = :P140_COD_EMP_AVALIADO ',
'   AND COD_CICLO = :P140_COD_CICLO',
'   AND ((TRUNC(SYSDATE) >= TRUNC(DT_INI_CICLO) AND  TRUNC(SYSDATE) <= TRUNC(DT_FIM_CICLO)) ',
'		AND (TRUNC(SYSDATE) >= TRUNC(DT_INI_AVAL_CONSENSO) AND  TRUNC(SYSDATE) <= TRUNC(DT_FIM_AVAL_CONSENSO)));',
'',
'',
'',
'if V_VALIDA_DATA = 0 then',
'   vbool := FALSE;',
'ELSE ',
'   vbool := TRUE;',
'end if;',
'',
'if vbool then ',
'    IF NVL(:P140_TIPO_AVALIACAO, ''G'') != ''A'' THEN',
'        vbool := TRUE;',
'    ELSE',
'        vbool :=  FALSE;',
'    END IF;',
'    ',
'    if NVL(:P140_IND_AVAL_EXPER,''N'') = ''S'' THEN ',
'    vbool :=  FALSE;',
'    END IF;',
'    ',
'end if;',
'return vbool;',
'',
'exception',
'    when others then',
'     return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320731964120011663)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(33297398377920305276)
,p_button_name=>'FICHA_REGISTRO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ficha de Registro'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P140_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-pdf-o'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320722946953011655)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(86989880819763426661)
,p_button_name=>'GO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>'Go'
,p_button_position=>'BODY'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320732370215011664)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(33297398377920305276)
,p_button_name=>'COMITE_CARREIRA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Comit\00EA de Carreira')
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P140_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-pdf-o'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(53709830272264972101)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(33297398057967305273)
,p_button_name=>'RECURSO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pedido de Recurso'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:146:&SESSION.::&DEBUG.:RP,146:P146_ROWID,P146_DATA_AVALIACAO,P146_COD_EMP_AVALIADOR_PRIMEIRO,P146_COD_MAT_AVALIADOR_PRIMEIRO,P146_COD_CICLO,P146_COD_CICLO_AUX:&P140_ROWID_RECURSO.,&P140_DATA_AVALIACAO.,&P140_COD_EMP_AVALIADOR.,&P140_COD_MAT_AVALIADOR.,&P140_COD_CICLO.,&P140_COD_CICLO.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from AV_APLICA_AVALIACOES',
'where cod_avaliacao = :p140_cod_avaliacao',
'and cod_emp_avaliado = :p140_cod_emp_avaliado',
'and cod_mat_avaliado = :p140_cod_mat_avaliado',
'and cod_emp_avaliador = :p140_cod_emp_avaliador',
'and cod_mat_avaliador = :p140_cod_mat_avaliador',
'and data_avaliacao = :p140_data_avaliacao',
'and tipo_avaliacao = :p140_tipo_avaliacao',
'and (:p140_cod_ciclo is null or cod_ciclo = :p140_cod_ciclo)',
'and SOLICITA_RECURSO = ''S'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-alert'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320723344329011656)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(86989880819763426661)
,p_button_name=>'RESET'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>'Reset'
,p_button_position=>'BODY'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320732761086011664)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(33297398377920305276)
,p_button_name=>'AVALIACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Avalia\00E7\00E3o')
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P140_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-pdf-o'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320731605502011663)
,p_button_sequence=>330
,p_button_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_button_name=>'p140_btn_solicitante'
,p_button_static_id=>'p140_btn_solicitante'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P140 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P140_COD_EMP_AVALIADOR.,&P140_COD_MAT_AVALIADOR.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320761980095011690)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(86990572402901522261)
,p_button_name=>'DELETE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_mat_avaliado',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and cod_mat_avaliado = :p140_cod_mat_avaliado',
'   and cod_avaliacao = :p140_cod_avaliacao',
'   and data_avaliacao = :p140_data_avaliacao',
'   and tipo_avaliacao = :p140_tipo_avaliacao',
'   and (:p140_cod_ciclo is null or cod_ciclo = :P140_COD_CICLO)',
'   --and cod_emp_avaliado <> :p_empresa_user',
'   and cod_mat_avaliado <> :p_matricula_user',
'   and :p_painel = ''PO''',
'   and :p140_tipo_avaliacao in (''G'',''C'')'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-times'
,p_security_scheme=>wwv_flow_api.id(51906239342422364462)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320762428319011691)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(86990572402901522261)
,p_button_name=>'BT_REQ1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>unistr('Requisi\00E7\00E3o - Desligamento')
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:59:&SESSION.::&DEBUG.:RP,59:P59_COD_EMPRESA,P59_MAT_SOLICITADO:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320762781667011691)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(86990572402901522261)
,p_button_name=>'BT_REQ2'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>unistr('Requisi\00E7\00E3o - Treinamento')
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:118:&SESSION.::&DEBUG.:RP,118:P118_EMP_SOLICITADO,P118_MAT_SOLICITADO:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320763163669011692)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(86990572402901522261)
,p_button_name=>'BT_REQ3'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>unistr('Requisi\00E7\00E3o - Pessoal')
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:RP,52::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320763566969011692)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(86990572402901522261)
,p_button_name=>'BT_REQ4'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>unistr('Requisi\00E7\00E3o - Alt. Funcional')
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:116:&SESSION.::&DEBUG.:RP,116:P116_COD_EMPRESA_SOLICITADO,P116_MAT_SOLICITADO:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320763948187011692)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(86990572402901522261)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320722289222011655)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(86967095710669551470)
,p_button_name=>'p140_btn_add_sucessor'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:143:&SESSION.::&DEBUG.:RP,143:P143_COD_EMP_AVALIADO,P143_COD_MAT_AVALIADO,P143_COD_EMP_AVALIADOR,P143_COD_MAT_AVALIADOR,P143_DATA_AVALIACAO,P143_COD_AVALIACAO:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.,&P140_COD_EMP_AVALIADOR.,&P140_COD_MAT_AVALIADOR.,&P140_DATA_AVALIACAO.,&P140_COD_AVALIACAO.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320760871768011689)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(86990148862742365349)
,p_button_name=>'P140_BTN_ADD_FEEDBACK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:142:&SESSION.::&DEBUG.:RP,142:P142_COD_EMP_AVALIADO,P142_COD_MAT_AVALIADO,P142_COD_EMP_AVALIADOR,P142_COD_MAT_AVALIADOR,P142_COD_AVALIACAO,P142_DATA_AVALIACAO,P142_TIPO_AVALIACAO:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.,&P140_COD_EMP_AVALIADOR.,&P140_COD_MAT_AVALIADOR.,&P140_COD_AVALIACAO.,&P140_DATA_AVALIACAO.,&P140_TIPO_AVALIACAO_AUX.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320742692269011672)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_button_name=>'p140_escolher_matricula'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_image_alt=>'Alterar Colaborador'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P140_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320743108457011672)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_button_name=>'p140_btn_colab'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P140_COD_EMP_AVALIADO.,&P140_COD_MAT_AVALIADO.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320761565180011690)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(81854435566039133208)
,p_button_name=>'BACK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--simple:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(53709741003335898234)
,p_branch_name=>'Go To Page Page Branch'
,p_branch_action=>'f?p=&P140_APP_BRANCH.:&P140_PAGE_BRANCH.:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'VOLTAR'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(33393403165273806389)
,p_branch_name=>'DELETAR'
,p_branch_action=>'f?p=&P140_APP_BRANCH.:&P140_PAGE_BRANCH.:&SESSION.::&DEBUG.:RP,140::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'DELETAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(23937961982486500622)
,p_name=>'P140_PRIMEIRO_PERIODO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Data Contrato Prazo Determinado (Primeiro Per\00EDodo)')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(23937962053275500623)
,p_name=>'P140_SEGUNDO_PERIODO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Data Contrato Prazo Determinado (Segundo Per\00EDodo)')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24786894109863300110)
,p_name=>'P140_IND_AVAL_EXPER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28887839681989136590)
,p_name=>'P140_ASPECTOS_FACILITADORES_AUX'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28887839946465136593)
,p_name=>'P140_PONTOS_FORTES_AUX'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_source=>'PONTOS_FORTES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28887840030402136594)
,p_name=>'P140_ASPECTOS_DIFICULTADORES_AUX'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_source=>'ASPECTOS_DIFICULTADORES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28887840132513136595)
,p_name=>'P140_PONTOS_FRACOS_AUX'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_source=>'PONTOS_FRACOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28887840220737136596)
,p_name=>'P140_FATORES_EXTERNOS_AUX'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_source=>'FATORES_EXTERNOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28887840369832136597)
,p_name=>'P140_PLANO_ACAO_AUX'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_source=>'PLANO_ACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28895602727425475254)
,p_name=>'P140_PDI'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33284844194525904567)
,p_name=>'P140_RESULTADO_PARCIAL'
,p_item_sequence=>15
,p_item_plug_id=>wwv_flow_api.id(33297398057967305273)
,p_prompt=>'Resultado Parcial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_ROWID IS NOT NULL AND :P140_RESULTADO_PARCIAL IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33284844291224904568)
,p_name=>'P140_COD_EMPRESA_AUX'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33297398200615305275)
,p_name=>'P140_NOTA_FINAL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(33297398057967305273)
,p_prompt=>'Nota Ponderada'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nota_final',
'  from av_resultado_parcial_ciclo pc',
' where pc.cod_avaliacao = :p140_cod_avaliacao',
'   and pc.cod_ciclo = :p140_cod_ciclo',
'   and pc.cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and pc.cod_mat_avaliado = :p140_cod_mat_avaliado',
'   --and pc.cod_emp_avaliador = :p140_cod_emp_avaliador',
'   --and pc.cod_mat_avaliador = :p140_cod_mat_avaliador',
'   and pc.data_avaliacao = :p140_data_avaliacao'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nota_final',
'  from av_resultado_parcial_ciclo pc',
' where pc.cod_avaliacao = :p140_cod_avaliacao',
'   and pc.cod_ciclo = :p140_cod_ciclo',
'   and pc.cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and pc.cod_mat_avaliado = :p140_cod_mat_avaliado',
'   --and pc.cod_emp_avaliador = :p140_cod_emp_avaliador',
'   --and pc.cod_mat_avaliador = :p140_cod_mat_avaliador',
'   and pc.data_avaliacao = :p140_data_avaliacao'))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33509278388072976564)
,p_name=>'P140_FALTAS_PERIODO_COLAB'
,p_item_sequence=>95
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Faltas no Per\00EDodo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33509278717594976567)
,p_name=>'P140_RETORNA_FALTAS'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33965646609878685225)
,p_name=>'P140_COD_CICLO_AUX'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33965647511464685234)
,p_name=>'P140_COD_EMP_AVALIADOR_AUX'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33965647667153685235)
,p_name=>'P140_COD_MAT_AVALIADOR_AUX'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37771763097264520175)
,p_name=>'P140_IND_OMITE_AVALIADO'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37771763159512520176)
,p_name=>'P140_IND_OMITE_AVALIADOR'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37771763520702520180)
,p_name=>'P140_AVISO'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(37771763460649520179)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(39594395831828485850)
,p_name=>'P140_NOTA_PROV_DSP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(33297398057967305273)
,p_prompt=>unistr('Nota do Eleg\00EDvel')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_ROWID IS NOT NULL AND :P140_NOTA_PROV IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(39594396377481485855)
,p_name=>'P140_DESABILITA_QUESTOES_AUX'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(39594396453796485856)
,p_name=>'P140_SOLICITA_RECURSO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'SOLICITA_RECURSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51906267336968269178)
,p_name=>'P140_IND_AUTOAVALIACAO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(53701760007129047138)
,p_name=>'P140_IND_ACEITE'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_ACEITE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(53709741450367898239)
,p_name=>'P140_REAVALIACAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(53709830368329972102)
,p_name=>'P140_ROWID_RECURSO'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(53709833198944972130)
,p_name=>'P140_PERMITE_CONSULTAR'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506745764942125232)
,p_name=>'P140_COD_AVALIACAO_AUX'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506746834093125242)
,p_name=>'P140_COD_EMP_AVALIADO_AUX'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506746930139125243)
,p_name=>'P140_COD_MAT_AVALIADO_AUX'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506747584610125250)
,p_name=>'P140_TIPO_AVALIACAO_AUX'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506749116392125265)
,p_name=>'P140_PAGE_BRANCH'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506749215626125266)
,p_name=>'P140_APP_BRANCH'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55514379672006528529)
,p_name=>'P140_COD_CICLO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Ciclo'
,p_source=>'COD_CICLO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320723786359011656)
,p_name=>'P140_REPORT_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86989880819763426661)
,p_prompt=>'Search'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>2000
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320724130139011656)
,p_name=>'P140_ROWS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86989880819763426661)
,p_item_default=>'15'
,p_prompt=>'Display'
,p_source=>'15'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'P140_Report Row Per Page'
,p_lov=>'.'||wwv_flow_api.id(63320852075279011766)||'.'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320733135137011664)
,p_name=>'P140_TITULO_AVALIACAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320733572115011665)
,p_name=>'P140_FLAG'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320733956897011665)
,p_name=>'P140_MENSAGEM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320734403172011665)
,p_name=>'P140_OK'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320734792016011666)
,p_name=>'P140_OCULTA_ANALISE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320735199725011666)
,p_name=>'P140_SEQ'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320735597497011666)
,p_name=>'P140_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320735966697011666)
,p_name=>'P140_COD_AVALIACAO'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Avalia\00E7\00E3o')
,p_source=>'COD_AVALIACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT a.cod_avaliacao || '' - '' ||initcap(a.descricao) dsc,',
'       a.cod_avaliacao                                          ret',
'  FROM av_avaliacoes           a',
'      ,av_composicao_avaliacao b',
' WHERE a.cod_avaliacao = b.cod_avaliacao',
'  -- AND b.cod_empresa   = :P140_COD_EMP_AVALIADOR',
'   AND ((trunc(SYSDATE) BETWEEN trunc(a.dt_inicio) AND trunc(a.dt_fim)) OR',
'        NVL(a.ind_aval_exper, ''N'') = ''S'' OR NVL(a.ind_desligado, ''N'') = ''S'')',
'   AND ((A.PERMISSOES_PERFIL IS NULL) OR (:P_PERFIL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(A.PERMISSOES_PERFIL, '','')) t))OR (:P_PERFIL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split('
||'A.PERMISSOES_PERFIL, '':'')) t)))',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320736401591011667)
,p_name=>'P140_DATA_AVALIACAO'
,p_is_required=>true
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_ROWID IS NULL THEN',
'RETURN SYSDATE;',
'END IF;'))
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_prompt=>'Data'
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DATA_AVALIACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320736734538011667)
,p_name=>'P140_TIPO_AVALIACAO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo'
,p_source=>'TIPO_AVALIACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Auto-Avalia\00E7\00E3o;A,Gestor;G,Consenso;C,Fornecedor;F,Pares;P')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320737141636011667)
,p_name=>'P140_DATA_INICIAL_COMITE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'DATA_INICIAL_COMITE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320737583475011668)
,p_name=>'P140_DATA_FINAL_COMITE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'DATA_FINAL_COMITE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320737936193011668)
,p_name=>'P140_COD_EMP_AVALIADOR'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_AVALIADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320738393890011668)
,p_name=>'P140_COD_MAT_AVALIADOR'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MAT_AVALIADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320738784705011669)
,p_name=>'P140_COD_EMP_EXAMINADOR'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_EXAMINADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320739218422011669)
,p_name=>'P140_COD_MAT_EXAMINADOR'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MAT_EXAMINADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320739579581011669)
,p_name=>'P140_AVALIADOR'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Avaliador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320740003103011670)
,p_name=>'P140_RESULTADO_AVALIACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(33297398057967305273)
,p_prompt=>unistr('Resultado Avalia\00E7\00E3o')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT sum(nvl(NOTA_ITEM,0)) NOTA',
' FROM  Av_Aplica_Avaliacoes_Itens',
' WHERE COD_EMP_AVALIADO   = :P140_COD_EMP_AVALIADO',
' AND   COD_MAT_AVALIADO   = :P140_COD_MAT_AVALIADO',
' AND   COD_EMP_AVALIADOR  = :P140_COD_EMP_AVALIADOR',
' AND   COD_MAT_AVALIADOR  = :P140_COD_MAT_AVALIADOR',
' AND   COD_AVALIACAO      = :P140_COD_AVALIACAO',
' AND   DATA_AVALIACAO     = :P140_DATA_AVALIACAO',
' AND   TIPO_AVALIACAO     = :P140_TIPO_AVALIACAO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>'P140_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320740371554011670)
,p_name=>'P140_NOTA_PROV'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_use_cache_before_default=>'NO'
,p_source=>'NOTA_PROV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_display_when=>'P140_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320740790373011671)
,p_name=>'P140_REPORT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(33297398377920305276)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320741192694011671)
,p_name=>'P140_ITEM_VALIDACAO'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(86989937016878630365)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320741571825011671)
,p_name=>'P140_ENDERECO_REL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(33297398377920305276)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320742001661011671)
,p_name=>'P140_QUEBRAS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(33297398480816305277)
,p_prompt=>unistr('Op\00E7\00E3o')
,p_source=>'CQ'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Com Quebra;CQ,Sem Quebra;SQ,Compara\00E7\00E3o;CP')
,p_display_when=>'P140_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(88927846986064042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'3'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320743516653011673)
,p_name=>'P140_COD_EMP_AVALIADO'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMP_AVALIADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) descricao, i.cod_empresa codigo',
' from avaliacao_temp i',
'where i.seq = :p140_seq',
'  and :p140_rowid is null',
'UNION',
'select e.cod||'' - ''||nvl(e.nome_abrev,e.nome) descricao, e.cod codigo',
'  from empresas e',
' where :p140_rowid is not null',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P140_SEQ,P140_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_column=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320743916070011673)
,p_name=>'P140_COD_MAT_AVALIADO'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'COD_MAT_AVALIADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula codigo',
' from avaliacao_temp i',
'where cod_empresa = :p140_cod_emp_avaliado',
'and seq = :p140_seq',
'and :p140_rowid is null',
'AND NOT EXISTS(SELECT 1 ',
'                 FROM dual ',
'                WHERE ''S'' <> (SELECT a.ind_consenso FROM av_avaliacoes a WHERE a.cod_avaliacao = :P140_COD_AVALIACAO) ',
'                  AND i.matricula = :P140_COD_MAT_AVALIADOR)',
'UNION',
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula codigo',
'  from informacoes_funcionais i, av_aplica_avaliacoes a',
' where i.cod_empresa = a.cod_emp_avaliado',
'   and i.matricula = a.cod_mat_avaliado',
'   and :p140_rowid is not null',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P140_COD_EMP_AVALIADO,P140_SEQ,P140_COD_MAT_AVALIADOR,P140_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320744291575011674)
,p_name=>'P140_COMITE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_prompt=>'Comite'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Select distinct trim(Nome||'' In\00EDcio: ''||To_Char(Data_Inicial,''DD/MM/RRRR'')||'' Fim: ''||To_Char(Data_Final,''DD/MM/RRRR'')) descricao,'),
'       Nome cod',
'  From Comite_Carreira',
' Where Cod_Empresa = :p140_Cod_Emp_Avaliado',
' Order By 1 Desc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P140_COD_EMP_AVALIADO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_grid_column=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320744692416011674)
,p_name=>'P140_CONFIRMA_CONSENSO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320745102282011674)
,p_name=>'P140_CONSENSO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320745441863011675)
,p_name=>'P140_PAGE_REQUISICAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320745852187011675)
,p_name=>'P140_PAGE_REQ1'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320746323899011675)
,p_name=>'P140_TIPO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(86989975531363555865)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320746932561011676)
,p_name=>'P140_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86989977057313555870)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p140_cod_emp_avaliado',
'                               and matricula   = :p140_cod_mat_avaliado), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :p140_cod_emp_avaliado || ''|'' || :p140_cod_mat_avaliado',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320747711554011678)
,p_name=>'P140_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320748096465011678)
,p_name=>'P140_FILIAL_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320748512705011679)
,p_name=>'P140_MATRICULA_DISPLAY'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320748923999011679)
,p_name=>'P140_SITUACAO_COLAB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320749253994011680)
,p_name=>'P140_DT_ADMISSAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320749722659011680)
,p_name=>'P140_FUNCAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320750090502011680)
,p_name=>'P140_FORMACAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Forma\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320750477846011680)
,p_name=>'P140_INSTRUCAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(86989977894835555872)
,p_prompt=>unistr('Instru\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320751179673011681)
,p_name=>'P140_ASPECTOS_FACILITADORES'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Aspectos Facilitadores'
,p_source=>'ASPECTOS_FACILITADORES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320751619355011681)
,p_name=>'P140_PONTOS_FORTES'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Pontos Fortes'
,p_source=>'PONTOS_FORTES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>1000
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320751977133011682)
,p_name=>'P140_ASPECTOS_DIFICULTADORES'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Aspectos Dificultadores'
,p_source=>'ASPECTOS_DIFICULTADORES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320752343276011682)
,p_name=>'P140_PONTOS_FRACOS'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Pontos a Desenvolver'
,p_source=>'PONTOS_FRACOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>1000
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320752753708011682)
,p_name=>'P140_FATORES_EXTERNOS'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fatores Externos ou Ambientais'
,p_source=>'FATORES_EXTERNOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320753184297011683)
,p_name=>'P140_PLANO_ACAO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Plano de A\00E7\00E3o')
,p_source=>'PLANO_ACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>2000
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320753584250011683)
,p_name=>'P140_OBSERVACOES'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(86990094093204190768)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Encaminhamentos'
,p_source=>'OBSERVACOES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320754328139011684)
,p_name=>'P140_COMENTARIO_AVALIADOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86990094850914190776)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Avaliador'
,p_source=>'COMENTARIO_AVALIADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320754720862011684)
,p_name=>'P140_COMENTARIO_AVALIADO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86990094850914190776)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Avaliado'
,p_source=>'COMENTARIO_AVALIADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320755125592011684)
,p_name=>'P140_COMENTARIO_EXAMINADOR'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(86990094850914190776)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Examinador'
,p_source=>'COMENTARIO_EXAMINADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320755772084011685)
,p_name=>'P140_CONCLUSAO_FINAL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86990095649582190784)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Conclus\00E3o Final')
,p_source=>'CONCLUSAO_FINAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(53709740892542898233)
,p_validation_name=>'Valida Avaliacao'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  CURSOR C1 IS',
'	SELECT A.COD_ITEM_AVALIACAO, A.ESPECIFICACAO, A.ORDEM_ITEM, a.resposta_multipla',
'	FROM   AV_COMPOSICAO_AVALIACAO A',
'	WHERE  A.COD_EMPRESA        = :P140_COD_EMP_AVALIADO',
'	AND    A.COD_AVALIACAO      = :P140_COD_AVALIACAO;',
'',
'	',
'	CURSOR C2(P_ITEM VARCHAR2) IS',
'	SELECT COUNT(*) TOTAL',
'	FROM Av_Aplica_Avaliacoes_Itens',
'	WHERE COD_EMP_AVALIADO   = :P140_COD_EMP_AVALIADO',
'	AND   COD_MAT_AVALIADO   = :P140_COD_MAT_AVALIADO',
'	AND   COD_EMP_AVALIADOR  = :P140_COD_EMP_AVALIADOR',
'	AND   COD_MAT_AVALIADOR  = :P140_COD_MAT_AVALIADOR',
'	AND   COD_AVALIACAO      = :P140_COD_AVALIACAO',
'	AND   DATA_AVALIACAO     = :P140_DATA_AVALIACAO',
'	AND   TIPO_AVALIACAO     = :P140_TIPO_AVALIACAO',
'	AND   COD_ITEM_AVALIACAO = P_ITEM;',
'    ',
'	V_C2 C2%ROWTYPE;',
'    ',
'    saida exception;',
'    ',
'    V_FLAG VARCHAR2(1);',
'    V_MENSAGEM VARCHAR2(4000);',
'    V_OK VARCHAR2(1);',
'',
'begin',
'',
'  FOR L1 IN C1',
'  LOOP',
'  ',
'  	V_C2.TOTAL := 0;',
'  	OPEN  C2(L1.COD_ITEM_AVALIACAO);',
'  	FETCH C2 INTO V_C2;',
'  	CLOSE C2;',
'  	',
'  	IF NVL(V_C2.TOTAL,0) = 0 THEN',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
'         V_MENSAGEM := ''Preencha a resposta do item "''||L1.ORDEM_ITEM||''-''||initcap(L1.ESPECIFICACAO)||''"!'';',
'  		 RAISE saida;  ',
'  	END IF;	',
'',
'   	IF NVL(V_C2.TOTAL,0) > 1 AND l1.resposta_multipla = 0  THEN',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''O item "''||L1.ORDEM_ITEM||''" n\00E3o permite resposta m\00FAltipla. Escolha apenas uma alternativa.'';'),
'  		 RAISE saida;',
'    ELSIF NVL(V_C2.TOTAL,0) > 1 AND l1.resposta_multipla = 0  THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''O item "''||L1.ORDEM_ITEM||''" n\00E3o permite resposta m\00FAltipla. Escolha apenas uma alternativa.'';'),
'  		 RAISE saida;',
'    END IF;	',
'',
'',
'  END LOOP;',
'',
'exception',
'when saida then',
' if trim(v_mensagem) is not null then',
'   return v_mensagem;',
' end if;',
'  ',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(63320763948187011692)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320839204413011756)
,p_name=>unistr('N\00E3o permite consultar')
,p_event_sequence=>5
,p_condition_element=>'P140_COD_AVALIACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P140_PERMITE_CONSULTAR'
,p_display_when_cond2=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320839660426011756)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Per\00EDodo de avalia\00E7\00E3o n\00E3o finalizado! Proibida a consulta!')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709832962246972128)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.submit(''VOLTAR'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320840160134011756)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989937016878630365)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320840690989011757)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094850914190776)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320841217779011757)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990095649582190784)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320841699217011757)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990572402901522261)
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320842200497011758)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320842647072011758)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094093204190768)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320843150403011758)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320843687324011759)
,p_event_id=>wwv_flow_api.id(63320839204413011756)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320844094249011759)
,p_name=>'Popula_Temp'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_AVALIACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320844607581011759)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'prc_avaliacao_temp (:p140_cod_avaliacao, ',
'                    :p140_cod_emp_avaliador, ',
'                    :p140_cod_mat_avaliador, ',
'                    :P_EMPRESA_USER, ',
'                    :P_MATRICULA_USER, ',
'                    :p_usuario, ',
'                    :p140_seq,',
'                    :p_painel);',
'end;'))
,p_attribute_02=>'P140_COD_AVALIACAO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P_USUARIO,P140_SEQ,P_PAINEL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320845065375011760)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(39594396281940485854)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p140_ind_aceite is null and :p140_solicita_recurso is null then',
' :p140_desabilita_questoes_aux := ''N'';',
'else',
'  :p140_desabilita_questoes_aux := ''S'';',
'end if;'))
,p_attribute_02=>'P140_IND_ACEITE,P140_SOLICITA_RECURSO'
,p_attribute_03=>'P140_DESABILITA_QUESTOES_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506746982818125244)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_COD_EMP_AVALIADO_AUX IS NOT NULL THEN',
':P140_COD_EMP_AVALIADO := :P140_COD_EMP_AVALIADO_AUX;',
'END IF;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO_AUX'
,p_attribute_03=>'P140_COD_EMP_AVALIADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506747110446125245)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_COD_MAT_AVALIADO_AUX IS NOT NULL THEN',
':P140_COD_MAT_AVALIADO := :P140_COD_MAT_AVALIADO_AUX;',
'END IF;'))
,p_attribute_02=>'P140_COD_MAT_AVALIADO_AUX'
,p_attribute_03=>'P140_COD_MAT_AVALIADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58833469916847611031)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    if :p_painel = ''PC'' then',
'      :p140_cod_emp_avaliado := :p_empresa_user;',
'      :p140_cod_mat_avaliado := :p_matricula_user;',
'    end if;'))
,p_attribute_02=>'P_PAINEL,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506747488029125249)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p140_rowid is null then',
'',
'    :p140_data_avaliacao := sysdate;',
'',
'end if;'))
,p_attribute_02=>'P140_ROWID'
,p_attribute_03=>'P140_DATA_AVALIACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37771763200291520177)
,p_event_id=>wwv_flow_api.id(63320844094249011759)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  cursor c1 is',
'    SELECT IND_CONSULTA_AVALIADO_CICLO, nvl(IND_AUTOAVALIACAO,''N'') ind_autoavaliacao, IND_OMITE_AVALIADO, IND_OMITE_AVALIADOR, retorna_faltas',
'      FROM AV_AVALIACOES',
'     WHERE COD_AVALIACAO = NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX);',
'',
'   V_C1 C1%ROWTYPE;',
'BEGIN',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  :P140_IND_OMITE_AVALIADO := V_C1.IND_OMITE_AVALIADO;',
'  ',
'  :P140_IND_OMITE_AVALIADOR := V_C1.IND_OMITE_AVALIADOR;',
'  ',
'  :P140_RETORNA_FALTAS := NVL(V_C1.RETORNA_FALTAS,''N'');',
'  ',
'END;'))
,p_attribute_02=>'P140_COD_AVALIACAO,P140_COD_AVALIACAO_AUX'
,p_attribute_03=>'P140_IND_OMITE_AVALIADO,P140_IND_OMITE_AVALIADOR,P140_RETORNA_FALTAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320845448814011760)
,p_name=>'Esconde Colab'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_COD_MAT_AVALIADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320845952525011760)
,p_event_id=>wwv_flow_api.id(63320845448814011760)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989977057313555870)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320846489140011760)
,p_event_id=>wwv_flow_api.id(63320845448814011760)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989977894835555872)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320847795341011761)
,p_name=>'Esconde Regions'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320848238176011762)
,p_event_id=>wwv_flow_api.id(63320847795341011761)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320848744960011762)
,p_event_id=>wwv_flow_api.id(63320847795341011761)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094850914190776)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320849230289011762)
,p_event_id=>wwv_flow_api.id(63320847795341011761)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990095649582190784)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320849763281011762)
,p_event_id=>wwv_flow_api.id(63320847795341011761)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094093204190768)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320850254151011763)
,p_event_id=>wwv_flow_api.id(63320847795341011761)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320850805728011763)
,p_event_id=>wwv_flow_api.id(63320847795341011761)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320851222004011763)
,p_name=>'1 (Mat Avaliado) KEY-NEXT-ITEM'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_condition_element=>'P140_COD_MAT_AVALIADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320851650650011764)
,p_event_id=>wwv_flow_api.id(63320851222004011763)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'V_CNS VARCHAR2(1) := ''N'';',
'V_AV NUMBER;',
'V_AV_B NUMBER;',
'V_FLG VARCHAR2(1);',
'V_OK VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'SAI EXCEPTION;',
'v_itm_vl varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'cursor c1 (v_tipo varchar2) is',
'SELECT DISTINCT 1 existe',
'INTO V_AV_B',
'FROM AV_APLICA_AVALIACOES C,AV_AVALIACOES A0,AV_CICLOS AC',
'WHERE A0.COD_AVALIACAO = C.COD_AVALIACAO',
'AND A0.COD_AVALIACAO = AC.COD_AVALIACAO (+)',
'AND C.COD_EMP_AVALIADO = AC.COD_EMPRESA (+)',
'AND C.COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'AND C.COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'AND C.COD_AVALIACAO = :P140_COD_AVALIACAO',
'AND (v_tipo is null or C.TIPO_AVALIACAO = v_tipo)',
'AND AC.COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO)',
'AND C.DATA_AVALIACAO BETWEEN NVL(NVL(AC.DT_INI_CICLO,A0.DT_INICIO),TO_DATE(''01/01/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR'')) AND NVL(NVL(AC.DT_FIM_CICLO,A0.DT_FIM),TO_DATE(''31/12/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR''));',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'v_itm_vl := null;',
':P140_ITEM_VALIDACAO := null;',
'if nvl(:p140_tipo_avaliacao,:p140_tipo_avaliacao_aux) is null then',
'open c1(null);',
'fetch c1 into v_c1;',
'close c1;',
'',
'v_av := nvl(v_c1.existe,0);',
'',
'v_c1 := null;',
'open c1(''G'');',
'fetch c1 into v_c1;',
'close c1;',
'',
'v_av_b := nvl(v_c1.existe,0);',
'',
'BEGIN',
'SELECT NVL(A0.IND_CONSENSO,''N'')',
'INTO V_CNS',
'FROM AV_AVALIACOES A0',
'WHERE A0.COD_AVALIACAO = :P140_COD_AVALIACAO;',
'EXCEPTION',
'WHEN OTHERS THEN',
'V_CNS := ''N'';',
'END;',
'',
'IF NVL(V_AV,0) = 0 and NVL(V_AV_B,0) = 0 THEN',
'    IF :P140_COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADO THEN',
'    :P140_TIPO_AVALIACAO := ''A'';',
'    ELSE',
'    :P140_TIPO_AVALIACAO := ''G'';',
'    END IF;',
'ELSE',
'    IF :P140_COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADO THEN',
'    V_FLG := ''N'';',
'    V_OK := ''N'';',
unistr('    V_MSG := ''A auto-avalia\00E7\00E3o j\00E1 foi realizada para esse per\00EDodo.'';'),
'    RAISE SAI;',
'    ELSIF :P140_COD_MAT_AVALIADOR <> :P140_COD_MAT_AVALIADO AND :P_PAINEL <> ''PC'' THEN',
'        IF NVL(V_CNS,''N'') = ''S'' THEN',
'            IF :P140_TIPO_AVALIACAO = ''C'' AND :P140_ROWID IS NULL then',
'              :p140_consenso := ''S'';',
'            end if;',
'            if :P140_TIPO_AVALIACAO IS NULL AND :P140_ROWID IS NULL then',
'              :P140_CONFIRMA_CONSENSO := ''S'';',
'            END IF;',
'        END IF;',
'    ELSE',
'        if nvl(V_AV,0) = 1 and nvl(V_AV_B,0) = 1 and nvl(V_CNS,''N'') = ''N'' then--',
'        V_FLG := ''N'';',
'        V_OK := ''N'';',
unistr('        V_MSG := ''Essa avalia\00E7\00E3o j\00E1 existe para esse per\00EDodo.'';'),
'        raise SAI;',
'        ELSE',
'            IF NVL(V_CNS,''N'') = ''S'' THEN',
'                IF :P140_TIPO_AVALIACAO = ''C'' AND :P140_ROWID IS NULL then',
'                  :p140_consenso := ''S'';',
'                end if;',
'                if :P140_TIPO_AVALIACAO IS NULL AND :P140_ROWID IS NULL then',
'                  :P140_CONFIRMA_CONSENSO := ''S'';',
'                END IF;',
'            END IF;',
'        end if;',
'    END IF;',
'END IF;',
'if V_MSG is null then',
':P140_OK := ''S'';',
':P140_FLAG := NULL;',
':P140_MENSAGEM := NULL;',
':P140_ITEM_VALIDACAO := null;',
'end if;',
'if trim(V_MSG) is not null then',
'if V_FLG in (''N'',''Q'') then',
':P140_ok := ''N'';',
':P140_ITEM_VALIDACAO := TRIM(UPPER(''P140_MAT_AVALIADO''));',
'else',
':P140_ok := ''S'';',
'end if;',
':P140_flag := V_FLG;',
':P140_mensagem := V_MSG;',
'else',
':P140_flag := null;',
':P140_mensagem := null;',
'if v_itm_vl = TRIM(UPPER(''P140_MAT_AVALIADO'')) OR v_itm_vl IS NULL then',
':P140_OK := ''S'';',
':P140_ITEM_VALIDACAO := null;',
'else',
':P140_ITEM_VALIDACAO := v_itm_vl;',
'end if;',
'end if;',
'ELSE',
':p140_tipo_avaliacao := nvl(:p140_tipo_avaliacao,:p140_tipo_avaliacao_aux);',
'end if;',
'EXCEPTION',
'WHEN SAI THEN',
'if trim(V_MSG) is not null then',
'if V_FLG = ''N'' then',
':P140_ok := ''N'';',
':P140_ITEM_VALIDACAO := TRIM(UPPER(''P140_MAT_AVALIADO''));',
'else',
':P140_ok := ''S'';',
'end if;',
':P140_flag := V_FLG;',
':P140_mensagem := V_MSG;',
'else',
':P140_flag := null;',
':P140_mensagem := null;',
'if v_itm_vl = ''P140_MAT_AVALIADO'' OR v_itm_vl IS NULL then',
':P140_OK := ''S'';',
':P140_ITEM_VALIDACAO := null;',
'else',
':P140_ITEM_VALIDACAO := v_itm_vl;',
'end if;',
'end if;',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_ITEM_VALIDACAO,P140_COD_CICLO,P140_ROWID,P140_TIPO_AVALIACAO,P140_COD_CICLO_AUX,P140_TIPO_AVALIACAO_AUX'
,p_attribute_03=>'P140_TIPO_AVALIACAO,P140_FLAG,P140_OK,P140_MENSAGEM,P140_CONFIRMA_CONSENSO,P140_ITEM_VALIDACAO,P140_CONSENSO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320766544409011695)
,p_name=>'1 (Mat Avaliado) when-validate-item'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_condition_element=>'P140_COD_MAT_AVALIADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320767128593011696)
,p_event_id=>wwv_flow_api.id(63320766544409011695)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
' V_FLAG VARCHAR2(1);',
' V_OK VARCHAR2(1);',
' V_MENSAGEM VARCHAR2(4000);',
'',
'  SAIDA EXCEPTION;',
'  ',
'  flag number;',
'v_item_validacao varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P140_ITEM_VALIDACAO := null;',
'',
'     Select 1',
'       Into Flag',
'       From Av_Aplica_Avaliacoes',
'      Where Cod_Emp_Avaliado  = :p140_Cod_Emp_Avaliado',
'        And Cod_Mat_Avaliado  = :p140_Cod_Mat_Avaliado',
'        And Cod_Emp_Avaliador = :p140_Cod_Emp_Avaliador',
'        And Cod_Mat_Avaliador = :p140_Cod_Mat_Avaliador',
'        And Cod_Avaliacao     = :p140_Cod_Avaliacao',
'        And Data_Avaliacao    = :p140_Data_Avaliacao',
'        And Tipo_Avaliacao    = :p140_Tipo_Avaliacao',
'        and :p140_rowid is null;',
'        ',
' V_FLAG := ''N'';',
' V_OK := ''N'';',
unistr(' V_MENSAGEM := ''Esta avalia\00E7\00E3o j\00E1 foi aplicada nesta data.'';'),
' ',
' Raise saida;',
'     ',
':P140_OK := ''S'';',
':P140_FLAG := NULL;',
':P140_MENSAGEM := NULL;',
':P140_ITEM_VALIDACAO := null;',
'  ',
'EXCEPTION',
'WHEN SAIDA THEN',
'',
' if trim(v_mensagem) is not null then',
'',
'    if v_flag in (''N'',''Q'') then',
'        :P140_ok       := ''N'';',
'        :P140_ITEM_VALIDACAO := TRIM(UPPER(''P140_MAT_AVALIADO1''));',
'    else',
'        :P140_ok       := ''S'';',
'    end if;',
'    ',
'    :P140_flag     := v_flag;',
'    :P140_mensagem := v_mensagem;',
' else',
'    :P140_flag     := null;',
'    :P140_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P140_MAT_AVALIADO1'')) OR v_item_validacao IS NULL then',
'       :P140_OK := ''S'';',
'       :P140_ITEM_VALIDACAO := null;',
'    else',
'       :P140_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'when others then',
'null;',
'END;',
''))
,p_attribute_02=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_ITEM_VALIDACAO,P140_TIPO_AVALIACAO,P140_ROWID'
,p_attribute_03=>'P140_FLAG,P140_OK,P140_MENSAGEM,P140_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320767621303011696)
,p_event_id=>wwv_flow_api.id(63320766544409011695)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
' V_FLAG VARCHAR2(1);',
' V_OK VARCHAR2(1);',
' V_MENSAGEM VARCHAR2(4000);',
'',
'  SAIDA EXCEPTION;',
'  ',
'  flag number;',
'',
'v_item_validacao varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P140_ITEM_VALIDACAO := null;',
'/*',
'select nvl(a.nota_prov,0) nota_prov',
'  into :p140_nota_prov',
'  from av_elegiveis_regra a',
' where a.cod_empresa = :p140_cod_emp_avaliado',
'   and a.matricula = :p140_cod_mat_avaliado;',
'*/     ',
'',
':P140_OK := ''S'';',
':P140_FLAG := NULL;',
':P140_MENSAGEM := NULL;',
':P140_ITEM_VALIDACAO := null;',
'  ',
'EXCEPTION',
'WHEN SAIDA THEN',
' if trim(v_mensagem) is not null then',
'',
'    if v_flag in (''N'',''Q'') then',
'        :P140_ok       := ''N'';',
'        :P140_ITEM_VALIDACAO := TRIM(UPPER(''P140_MAT_AVALIADO2''));',
'    else',
'        :P140_ok       := ''S'';',
'    end if;',
'    ',
'    :P140_flag     := v_flag;',
'    :P140_mensagem := v_mensagem;',
' else',
'    :P140_flag     := null;',
'    :P140_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P140_MAT_AVALIADO2'')) OR v_item_validacao IS NULL then',
'       :P140_OK := ''S'';',
'       :P140_ITEM_VALIDACAO := null;',
'    else',
'       :P140_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'when others then',
'null;',
'END;',
''))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_ITEM_VALIDACAO,P140_COD_AVALIACAO,P140_COD_AVALIACAO_AUX,P140_RESULTADO_AVALIACAO'
,p_attribute_03=>'P140_FLAG,P140_OK,P140_MENSAGEM,P140_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320767988434011696)
,p_name=>unistr('Refresh Quest\00F5es')
,p_event_sequence=>71
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_condition_element=>'P140_COD_MAT_AVALIADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P140_OK'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320768475223011697)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320769005303011697)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320769522570011697)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094850914190776)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320769997231011698)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094093204190768)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320770510610011698)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990095649582190784)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320770963229011699)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990095649582190784)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320771472877011699)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094093204190768)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320772001323011699)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094850914190776)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320772467503011700)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320772966401011700)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320773486519011700)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320774013664011701)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'FALSE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320774475727011701)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320775005568011702)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320775489069011702)
,p_event_id=>wwv_flow_api.id(63320767988434011696)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_FOTO_COLAB'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320775924093011702)
,p_name=>'Consenso?'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_CONFIRMA_CONSENSO'
,p_condition_element=>'P140_CONFIRMA_CONSENSO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33526974064527816566)
,p_event_id=>wwv_flow_api.id(63320775924093011702)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_CONSENSO := ''N'';'
,p_attribute_03=>'P140_CONSENSO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320776885771011703)
,p_event_id=>wwv_flow_api.id(63320775924093011702)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
':p140_consenso := ''N'';',
'/*',
':P140_FLAG := ''N'';',
':P140_OK := ''N'';',
unistr(':P140_MENSAGEM := ''2 - Essa avalia\00E7\00E3o j\00E1 existe para esse per\00EDodo.'';'),
'*/',
'end;'))
,p_attribute_03=>'P140_CONSENSO,P140_FLAG,P140_OK,P140_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33526972994506816555)
,p_event_id=>wwv_flow_api.id(63320775924093011702)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Esta avalia\00E7\00E3o \00E9 de Consenso?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'CANCEL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320777427144011703)
,p_event_id=>wwv_flow_api.id(63320775924093011702)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p140_consenso := ''S'';',
'',
'  IF :P140_DATA_AVALIACAO IS NULL THEN',
'     :P140_DATA_AVALIACAO := TRUNC(SYSDATE);',
'  END IF;'))
,p_attribute_02=>'P140_DATA_AVALIACAO'
,p_attribute_03=>'P140_DATA_AVALIACAO,P140_CONSENSO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320777846424011704)
,p_event_id=>wwv_flow_api.id(63320775924093011702)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1 = 2 then /**************atencao para o 1 = 2 *********************/',
'FOR X1 IN (SELECT A.NOTA_PROV',
'      FROM AV_APLICA_AVALIACOES A',
'          ,AV_AVALIACOES A0',
'          ,AV_CICLOS AC',
'     WHERE A0.COD_AVALIACAO    = A.COD_AVALIACAO',
'       AND A0.COD_AVALIACAO = AC.COD_AVALIACAO (+)',
'       AND A.COD_CICLO = AC.COD_CICLO (+)',
'       AND AC.COD_EMPRESA (+) = :P140_COD_EMP_AVALIADO',
'       AND A.DATA_AVALIACAO    BETWEEN NVL(NVL(AC.DT_INI_CICLO,A0.DT_INICIO),TO_DATE(''01/01/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR'')) AND NVL(NVL(AC.DT_FIM_CICLO,A0.DT_FIM),TO_DATE(''31/12/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR''))',
'       AND A.COD_EMP_AVALIADO  = :P140_COD_EMP_AVALIADO',
'       AND A.COD_MAT_AVALIADO  = :P140_COD_MAT_AVALIADO',
'       --AND A.COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'       --AND A.COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'       AND A.COD_AVALIACAO     = :P140_COD_AVALIACAO',
'       AND A.COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO)',
'       AND A.TIPO_AVALIACAO    = ''G'') LOOP',
'  --',
'  IF :P140_DATA_AVALIACAO IS NULL THEN',
'  :P140_DATA_AVALIACAO          := TRUNC(SYSDATE);',
'  END IF;',
'  :P140_TIPO_AVALIACAO          := ''C'';',
'  :P140_NOTA_PROV               := X1.NOTA_PROV;',
'',
'begin',
'',
unistr('-- Altera\00E7\00E3o MSS 20200804 - Chamado 21425 - Igor|Adriana'),
'INSERT /*+ ignore_row_on_dupkey_index ( AV_APLICA_AVALIACOES_ITENS (COD_EMP_AVALIADO, COD_MAT_AVALIADO, COD_EMP_AVALIADOR, COD_MAT_AVALIADOR, COD_AVALIACAO, TIPO_AVALIACAO, DATA_AVALIACAO, COD_ITEM_AVALIACAO, COD_SUB_ITEM_AVALIACAO) ) */',
'  INTO AV_APLICA_AVALIACOES_ITENS ',
'      (COD_EMP_AVALIADO, ',
'      COD_MAT_AVALIADO, ',
'      COD_EMP_AVALIADOR, ',
'      COD_MAT_AVALIADOR, ',
'      COD_AVALIACAO, ',
'      DATA_AVALIACAO, ',
'      COD_ITEM_AVALIACAO, ',
'      COD_SUB_ITEM_AVALIACAO, ',
'      RESPOSTA_DISSERTATIVA, ',
'      NOTA_ITEM, ',
'      TIPO_AVALIACAO,',
'      COD_CICLO,',
'      usuario,',
'      dt_atualizacao)',
'SELECT I.COD_EMP_AVALIADO,',
'   I.COD_MAT_AVALIADO,',
'   I.COD_EMP_AVALIADOR,',
'   I.COD_MAT_AVALIADOR,',
'   I.COD_AVALIACAO,',
'   NVL(:p140_DATA_AVALIACAO,TRUNC(SYSDATE)) DATA_AVALIACAO,',
'   I.COD_ITEM_AVALIACAO,',
'   I.COD_SUB_ITEM_AVALIACAO,',
'   I.RESPOSTA_DISSERTATIVA,',
'   I.NOTA_ITEM,',
'   ''C'' TIPO_AVALIACAO,',
'   nvl(I.COD_CICLO,:P140_COD_CICLO) COD_CICLO,',
'   ''X'',',
'   sysdate',
'FROM AV_APLICA_AVALIACOES_ITENS I',
'  ,AV_AVALIACOES A0',
'  ,AV_CICLOS AC',
'WHERE A0.COD_AVALIACAO    = I.COD_AVALIACAO',
'AND A0.COD_AVALIACAO = AC.COD_AVALIACAO (+)',
'AND I.COD_CICLO = AC.COD_CICLO (+)',
'AND AC.COD_EMPRESA (+) = :P140_COD_EMP_AVALIADO',
'AND I.COD_EMP_AVALIADO  = :p140_COD_EMP_AVALIADO',
'AND I.COD_MAT_AVALIADO  = :p140_COD_MAT_AVALIADO',
'--AND I.COD_EMP_AVALIADOR = :p140_COD_EMP_AVALIADOR',
'--AND I.COD_MAT_AVALIADOR = :p140_COD_MAT_AVALIADOR',
'AND I.COD_AVALIACAO     = :p140_COD_AVALIACAO',
'AND I.COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO)',
'AND I.DATA_AVALIACAO    BETWEEN NVL(NVL(AC.DT_INI_CICLO,A0.DT_INICIO),TO_DATE(''01/01/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR'')) AND NVL(NVL(AC.DT_FIM_CICLO,A0.DT_FIM),TO_DATE(''31/12/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR''))',
'AND I.TIPO_AVALIACAO    = ''G'';',
'',
'commit;',
'',
'end;',
'',
'end loop;',
'end if;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_COD_CICLO,P140_COD_AVALIACAO_AUX,P140_RESULTADO_AVALIACAO,P140_COD_CICLO_AUX'
,p_attribute_03=>'P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_NOTA_PROV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320778257090011704)
,p_name=>'Processo Consenso (S)'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_CONSENSO'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(apex.item("P140_CONSENSO").getValue() == "S" || ',
' ((apex.item("P140_TIPO_AVALIACAO").getValue() == "C" || apex.item("P140_TIPO_AVALIACAO_AUX").getValue() == "C" ) && ',
'  apex.item("P140_COD_MAT_AVALIADO").getValue() != apex.item("P140_COD_MAT_AVALIADOR").getValue()))'))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320778790930011705)
,p_event_id=>wwv_flow_api.id(63320778257090011704)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
' V_CONSENSO VARCHAR2(1) := ''N'';',
' V_DUMMY NUMBER := 1;',
'',
' V_FLAG VARCHAR2(1);',
' V_OK VARCHAR2(1);',
' V_MENSAGEM VARCHAR2(4000);',
'',
'SAIDA EXCEPTION;',
'BEGIN',
'',
'IF :P140_ROWID IS NULL THEN',
':P140_TIPO_AVALIACAO := ''C'';',
'FOR X1 IN (SELECT A.NOTA_PROV',
'      FROM AV_APLICA_AVALIACOES A',
'        ,AV_AVALIACOES A0',
'        ,AV_CICLOS AC',
'     WHERE A0.COD_AVALIACAO    = A.COD_AVALIACAO',
'     AND A0.COD_AVALIACAO =  AC.COD_AVALIACAO (+)',
'     AND A.COD_CICLO = AC.COD_CICLO (+)',
'     AND A.DATA_AVALIACAO    BETWEEN NVL(NVL(AC.DT_INI_CICLO,A0.DT_INICIO),TO_DATE(''01/01/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR'')) AND NVL(NVL(AC.DT_FIM_CICLO,A0.DT_FIM),TO_DATE(''31/12/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR''))',
'     AND AC.COD_EMPRESA (+) = :P140_COD_EMP_AVALIADO',
'     AND A.COD_EMP_AVALIADO  = :P140_COD_EMP_AVALIADO',
'       AND A.COD_MAT_AVALIADO  = :P140_COD_MAT_AVALIADO',
'      -- AND A.COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'      -- AND A.COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'       AND A.COD_AVALIACAO     = :P140_COD_AVALIACAO',
'       AND A.COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO)',
'       AND A.TIPO_AVALIACAO    = ''G'') LOOP',
'',
'  :P140_DATA_AVALIACAO := NVL(:P140_DATA_AVALIACAO,TRUNC(SYSDATE));',
'  :P140_TIPO_AVALIACAO := ''C'';',
'  :P140_NOTA_PROV      := X1.NOTA_PROV;',
'',
'  commit;',
'',
'  begin',
'      --',
'    INSERT /*+ ignore_row_on_dupkey_index ( AV_APLICA_AVALIACOES_ITENS (COD_EMP_AVALIADO, COD_MAT_AVALIADO, COD_EMP_AVALIADOR, COD_MAT_AVALIADOR, COD_AVALIACAO, TIPO_AVALIACAO, DATA_AVALIACAO, COD_ITEM_AVALIACAO, COD_SUB_ITEM_AVALIACAO) ) */',
'      INTO AV_APLICA_AVALIACOES_ITENS ',
'            (COD_EMP_AVALIADO, ',
'            COD_MAT_AVALIADO, ',
'            COD_EMP_AVALIADOR, ',
'            COD_MAT_AVALIADOR, ',
'            COD_AVALIACAO, ',
'            DATA_AVALIACAO, ',
'            COD_ITEM_AVALIACAO, ',
'            COD_SUB_ITEM_AVALIACAO, ',
'            RESPOSTA_DISSERTATIVA, ',
'            NOTA_ITEM, ',
'            TIPO_AVALIACAO,',
'            COD_CICLO,',
'            usuario,',
'            dt_atualizacao)',
'      SELECT I.COD_EMP_AVALIADO,',
'             I.COD_MAT_AVALIADO,',
'             NVL(:P140_COD_EMP_AVALIADOR,I.COD_EMP_AVALIADOR),',
'             NVL(:P140_COD_MAT_AVALIADOR,I.COD_MAT_AVALIADOR),',
'             I.COD_AVALIACAO,',
'             NVL(:P140_DATA_AVALIACAO,TRUNC(SYSDATE)) DATA_AVALIACAO,',
'             I.COD_ITEM_AVALIACAO,',
'             I.COD_SUB_ITEM_AVALIACAO,',
'             I.RESPOSTA_DISSERTATIVA,',
'             I.NOTA_ITEM,',
'             ''C'' TIPO_AVALIACAO,',
'             I.COD_CICLO,',
'              :p_usuario,',
'               sysdate',
'        FROM AV_APLICA_AVALIACOES_ITENS I',
'            ,AV_AVALIACOES A0',
'            ,AV_CICLOS AC',
'       WHERE A0.COD_AVALIACAO    = I.COD_AVALIACAO',
'         AND A0.COD_AVALIACAO =  AC.COD_AVALIACAO (+)',
'         AND I.COD_CICLO = AC.COD_CICLO (+)',
'         AND I.COD_EMP_AVALIADO  = :P140_COD_EMP_AVALIADO',
'         AND I.COD_MAT_AVALIADO  = :P140_COD_MAT_AVALIADO',
'         AND I.COD_AVALIACAO     = :P140_COD_AVALIACAO',
'         AND I.DATA_AVALIACAO    BETWEEN NVL(NVL(AC.DT_INI_CICLO,A0.DT_INICIO),TO_DATE(''01/01/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR'')) AND NVL(NVL(AC.DT_FIM_CICLO,A0.DT_FIM),TO_DATE(''31/12/''||LTRIM(TO_CHAR(SYSDATE,''RRRR'')),''DD/MM/RRRR''))',
'         AND AC.COD_EMPRESA (+) = :P140_COD_EMP_AVALIADO',
'         AND I.COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO)',
'         AND I.TIPO_AVALIACAO    = ''G'';',
'    --',
'    COMMIT;',
'    --',
'  exception when others then',
'    V_FLAG := ''N'';',
'    V_OK := ''N'';',
'    V_MENSAGEM := ''Erro: ''||sqlerrm;',
'    RAISE SAIDA;',
'  end;',
'',
'END LOOP;',
'',
':P140_OK := ''S'';',
':P140_FLAG := NULL;',
':P140_MENSAGEM := NULL;',
'  ',
'END IF;  ',
'  ',
'  IF :P140_DATA_AVALIACAO IS NULL THEN',
'     :P140_DATA_AVALIACAO := TRUNC(SYSDATE);',
'  END IF;',
'  ',
'EXCEPTION',
'WHEN SAIDA THEN',
':P140_OK := V_OK;',
':P140_FLAG := V_FLAG;',
':P140_MENSAGEM := V_MENSAGEM;',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_AVALIACAO,P140_ROWID,P140_DATA_AVALIACAO,P140_COD_CICLO,P140_COD_CICLO_AUX'
,p_attribute_03=>'P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_NOTA_PROV,P140_OK,P140_FLAG,P140_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709833906027972137)
,p_event_id=>wwv_flow_api.id(63320778257090011704)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33526973269426816558)
,p_name=>'Processo Consenso (N)'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_CONSENSO'
,p_condition_element=>'P140_CONSENSO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_TIPO_AVALIACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33526973639437816562)
,p_event_id=>wwv_flow_api.id(33526973269426816558)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P140_CONSENSO").getValue() == "N" /*&& apex.item("P140_CONFIRMA_CONSENSO").getValue() == "S"*/ ){',
'    if ((apex.item("P140_TIPO_AVALIACAO").getValue().length == 0 || apex.item("P140_TIPO_AVALIACAO_AUX").getValue().length == 0 ) && apex.item("P140_COD_MAT_AVALIADO").getValue() != apex.item("P140_COD_MAT_AVALIADOR").getValue()){',
'        apex.item("P140_TIPO_AVALIACAO").setValue("G");',
'        //console.log("P140_TIPO_AVALIACAO = G");',
'    }',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33526973610376816561)
,p_event_id=>wwv_flow_api.id(33526973269426816558)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320779206006011705)
,p_name=>'Popula Colab'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_condition_element=>'P140_COD_MAT_AVALIADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P140_OK'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320779700487011705)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989977057313555870)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320780162736011705)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989977057313555870)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320780674028011706)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989977894835555872)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320781206813011706)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989977894835555872)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320781633739011710)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'i.dt_admissao,',
'I.FILIAL||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) filial,',
'funcao||'' - ''||initcap(fnct_nome_funcao(i.cargo,i.funcao)) funcao,',
'initcap(e.descricao) formacao,',
'initcap(r.nome) instrucao,',
'I.data_contrato_prz_determinado PRIMEIRO_PERIODO,',
'I.prorrog_contrato_prz_determ SEGUNDO_PERIODO        ',
'from informacoes_funcionais_cad i, inf_pessoais_cad p, instrucao r, formacao_escolar e',
'where i.cod_empresa = p.cod_empresa',
'and i.matricula = p.matricula',
'and p.instrucao = r.cod (+)',
'and p.cod_formacao_escolar = e.cod_formacao_escolar (+)',
'and i.cod_empresa = :p140_cod_emp_avaliado',
'and i.matricula = :p140_cod_mat_avaliado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select sum(h.num_dias_faltas) qtd_faltas, c.DATA_REF_INI/*-1*/ dt_ini, c.DATA_REF_FIM/*-1*/ dt_fim -- h.*, p.min_dias_efet_exerc, ((c.DATA_REF_INI-1)-p.min_dias_efet_exerc) dt_ini, c.DATA_REF_INI-1 dt_fim, c.DATA_REF_INI--a.*, b.*',
'  from historico_faltas h,',
'       ocorr_pagto_faltas_aval o,',
'       av_ciclos c,',
'       av_parametros p,',
'       av_avaliacoes a',
' where h.cod_empresa = o.cod_empresa',
'   and h.cod_empresa = p.cod_empresa',
'   and h.cod_empresa = c.cod_empresa',
'   and h.cod_ocorr = o.cod_ocorr',
'   and o.cod_avaliacao = c.cod_avaliacao',
'   and o.cod_avaliacao = p.cod_avaliacao',
'   and o.cod_avaliacao = a.cod_avaliacao',
'   and a.retorna_faltas = ''S''',
'   and h.dt_inic_evento between (c.DATA_REF_INI/*-1*/) and (c.DATA_REF_FIM/*-1*/)',
'   and h.dt_fin_evento between (c.DATA_REF_INI/*-1*/) and (c.DATA_REF_FIM/*-1*/)',
'   and h.cod_empresa = :p140_cod_emp_avaliado',
'   and h.matricula = :p140_cod_mat_avaliado',
'   and o.cod_avaliacao = nvl(:p140_cod_avaliacao_aux,:p140_cod_avaliacao)',
'   and c.cod_ciclo = nvl(:p140_cod_ciclo_aux, :p140_cod_ciclo)',
'   group by (c.DATA_REF_INI/*-1*/), c.DATA_REF_FIM/*-1*/;',
'   ',
'v_c2 c2%rowtype;',
'',
'cursor c3 is',
'select c.DATA_REF_INI/*-1*/ dt_ini, c.DATA_REF_FIM/*-1*/ dt_fim',
'  from av_ciclos c,',
'       av_parametros p,',
'       av_avaliacoes a',
' where c.cod_empresa = p.cod_empresa',
'   and c.cod_avaliacao = p.cod_avaliacao',
'   and c.cod_avaliacao = a.cod_avaliacao',
'   and a.retorna_faltas = ''S''',
'   and c.cod_empresa = :p140_cod_emp_avaliado',
'   and c.cod_avaliacao = nvl(:p140_cod_avaliacao_aux,:p140_cod_avaliacao)',
'   and c.cod_ciclo = nvl(:p140_cod_ciclo_aux, :p140_cod_ciclo);',
'   ',
'v_c3 c3%rowtype;',
'',
'begin',
'',
'if nvl(:p140_ind_omite_avaliador,''N'') = ''N'' then',
':p140_avaliador := :p140_COD_EMP_AVALIADOR||'' / ''||:p140_COD_MAT_AVALIADOR||'' - ''||iNITCAP(fnct_nome_func(:p140_COD_EMP_AVALIADOR, :p140_COD_MAT_AVALIADOR));',
'else',
':p140_avaliador := null;',
'end if;',
'',
'if nvl(:p140_ind_omite_avaliado,''N'') = ''N'' then',
'',
'open c1; fetch c1 into v_c1; close c1;',
'',
'open c2; fetch c2 into v_c2; close c2;',
'',
'open c3; fetch c3 into v_c3; close c3;',
'',
':p140_cod_empresa_display := v_c1.empresa;',
':p140_filial_display := v_c1.filial;',
':p140_matricula_display := v_c1.matricula;',
':p140_situacao_colab := v_c1.situacao;',
':p140_dt_admissao := v_c1.dt_admissao;',
':p140_funcao := v_c1.funcao;',
':p140_formacao := v_c1.formacao;',
':p140_instrucao := v_c1.instrucao;',
':p140_faltas_periodo_colab := nvl(v_c2.qtd_faltas,0)||'' falta(s) (''||to_char(v_c3.dt_ini,''dd/mm/rrrr'')||'' - ''||to_char(v_c3.dt_fim,''dd/mm/rrrr'')||'')'';',
':P140_PRIMEIRO_PERIODO := v_c1.PRIMEIRO_PERIODO;',
':P140_SEGUNDO_PERIODO := v_c1.SEGUNDO_PERIODO;',
'else',
':p140_cod_empresa_display := null;',
':p140_filial_display := null;',
':p140_matricula_display := null;',
':p140_situacao_colab := null;',
':p140_dt_admissao := null;',
':p140_funcao := null;',
':p140_formacao := null;',
':p140_instrucao := null;',
':p140_faltas_periodo_colab := null;',
':P140_PRIMEIRO_PERIODO := null;',
':P140_SEGUNDO_PERIODO := null;',
'end if;',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_IND_OMITE_AVALIADO,P140_IND_OMITE_AVALIADOR,P140_COD_AVALIACAO,P140_COD_AVALIACAO_AUX,P140_COD_CICLO,P140_COD_CICLO_AUX'
,p_attribute_03=>'P140_COD_EMPRESA_DISPLAY,P140_MATRICULA_DISPLAY,P140_SITUACAO_COLAB,P140_DT_ADMISSAO,P140_FUNCAO,P140_FORMACAO,P140_INSTRUCAO,P140_FILIAL_DISPLAY,P140_FALTAS_PERIODO_COLAB,P140_AVALIADOR,P140_PRIMEIRO_PERIODO,P140_SEGUNDO_PERIODO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320782131218011711)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(23937962506272500628)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' BEGIN',
'   ',
'   SELECT NVL(IND_AVAL_EXPER,''N'') IND_AVAL_EXPER',
'     INTO :P140_IND_AVAL_EXPER ',
'     FROM AV_AVALIACOES',
'    WHERE COD_AVALIACAO = NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX);',
'    EXCEPTION',
unistr('    -- Caso ocorra qualquer exce\00E7\00E3o, define :P140_IND_AVAL_EXPER como ''N'''),
'    WHEN NO_DATA_FOUND THEN',
'        :P140_IND_AVAL_EXPER := ''N'';',
'    WHEN OTHERS THEN',
unistr('        -- Trata outras exce\00E7\00F5es, caso necess\00E1rio'),
'        :P140_IND_AVAL_EXPER := ''N'';',
'	END;	',
''))
,p_attribute_02=>'P140_COD_AVALIACAO,P140_COD_AVALIACAO_AUX'
,p_attribute_03=>'P140_IND_AVAL_EXPER'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506746169644125236)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320783718419011712)
,p_event_id=>wwv_flow_api.id(63320779206006011705)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMITE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320784101236011712)
,p_name=>'Popula Data Comite'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COMITE'
,p_condition_element=>'P140_COMITE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320784538407011713)
,p_event_id=>wwv_flow_api.id(63320784101236011712)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'Select Data_Inicial,Data_Final',
'  From Comite_Carreira',
' Where Cod_Empresa = :p140_Cod_Emp_Avaliado',
'   and nome = :p140_comite;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p140_data_inicial_comite := v_c1.data_inicial;',
':p140_data_final_comite := v_c1.data_final;',
'',
'end;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COMITE'
,p_attribute_03=>'P140_DATA_INICIAL_COMITE,P140_DATA_FINAL_COMITE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320784937067011713)
,p_name=>unistr('Alterar Matr\00EDcula')
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320742692269011672)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320785444985011713)
,p_event_id=>wwv_flow_api.id(63320784937067011713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320785980330011714)
,p_event_id=>wwv_flow_api.id(63320784937067011713)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p140_cod_emp_avaliado := null;',
':p140_cod_mat_avaliado := null;'))
,p_attribute_03=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320786365612011714)
,p_name=>'Esconde Avaliado'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_AVALIACAO'
,p_condition_element=>'P140_COD_AVALIACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320786856936011714)
,p_event_id=>wwv_flow_api.id(63320786365612011714)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989975531363555865)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320787391581011715)
,p_event_id=>wwv_flow_api.id(63320786365612011714)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989975531363555865)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37771763318664520178)
,p_event_id=>wwv_flow_api.id(63320786365612011714)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item(''P140_IND_OMITE_AVALIADO'').getValue() == ''S'') {',
'    //$(''#COLABORADOR'').hide();',
'    $x_Hide("COLABORADOR");',
'    $(''#AVISO'').show();',
unistr('    apex.item(''P140_AVISO'').setValue(''Os dados do colaborador est\00E3o ocultos para esta avalia\00E7\00E3o, n\00E3o sendo identificavel.'');'),
'}else{',
'    $(''#COLABORADOR'').show(); ',
'    $(''#AVISO'').hide();',
'    apex.item(''P140_AVISO'').setValue('''');',
'}',
'',
'if (apex.item(''P140_IND_OMITE_AVALIADOR'').getValue() == ''S'') {',
'    apex.item(''P140_AVALIADOR'').hide();',
'    $(''#p140_btn_solicitante'').hide();',
'}else{',
'    apex.item(''P140_AVALIADOR'').show();',
'    $(''#p140_btn_solicitante'').show();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320787813013011715)
,p_name=>'Esconde Matricula'
,p_event_sequence=>150
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320788321043011715)
,p_event_id=>wwv_flow_api.id(63320787813013011715)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320788789153011715)
,p_event_id=>wwv_flow_api.id(63320787813013011715)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320789153133011716)
,p_name=>'(Pesquisa) Desabilita Campos'
,p_event_sequence=>160
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320789691302011716)
,p_event_id=>wwv_flow_api.id(63320789153133011716)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_COMITE,P140_COD_CICLO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320790057969011716)
,p_name=>'Dialog Closed'
,p_event_sequence=>170
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(86989884064293426669)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320790607893011717)
,p_event_id=>wwv_flow_api.id(63320790057969011716)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320790957728011717)
,p_name=>'Feedback - Enable Fields'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320760871768011689)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320791511754011718)
,p_event_id=>wwv_flow_api.id(63320790957728011717)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320791841637011718)
,p_name=>'New'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320722289222011655)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320792377028011718)
,p_event_id=>wwv_flow_api.id(63320791841637011718)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_COD_AVALIACAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320792751815011719)
,p_name=>'Hide Feedback'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_OCULTA_ANALISE'
,p_condition_element=>'P140_OCULTA_ANALISE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320793264419011719)
,p_event_id=>wwv_flow_api.id(63320792751815011719)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709833469517972133)
,p_event_id=>wwv_flow_api.id(63320792751815011719)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094093204190768)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320793772546011719)
,p_event_id=>wwv_flow_api.id(63320792751815011719)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709833595340972134)
,p_event_id=>wwv_flow_api.id(63320792751815011719)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094093204190768)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320794305282011720)
,p_event_id=>wwv_flow_api.id(63320792751815011719)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_ASPECTOS_FACILITADORES,P140_ASPECTOS_DIFICULTADORES,P140_FATORES_EXTERNOS,P140_PONTOS_FORTES,P140_PONTOS_FRACOS,P140_PLANO_ACAO,P140_OBSERVACOES,P140_COMENTARIO_EXAMINADOR,P140_CONCLUSAO_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320794783590011720)
,p_event_id=>wwv_flow_api.id(63320792751815011719)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_ASPECTOS_FACILITADORES,P140_ASPECTOS_DIFICULTADORES,P140_FATORES_EXTERNOS,P140_PONTOS_FORTES,P140_PONTOS_FRACOS,P140_PLANO_ACAO,P140_OBSERVACOES,P140_COMENTARIO_EXAMINADOR,P140_CONCLUSAO_FINAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320795141642011720)
,p_name=>'Oculta Analise'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_condition_element=>'P140_COD_MAT_AVALIADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320795673607011721)
,p_event_id=>wwv_flow_api.id(63320795141642011720)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE -- Tratamento feito por Felipe em 10/12/2012 --',
'	CURSOR F2 IS',
'	SELECT OCULTA_ANALISE',
'	  FROM AV_AVALIACOES',
'	 WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'	 V_F2 F2%ROWTYPE;',
'',
'',
'BEGIN',
'',
'	OPEN F2;',
'	FETCH F2 INTO V_F2;',
'	CLOSE F2;',
'',
':p140_OCULTA_ANALISE := v_f2.OCULTA_ANALISE;',
'',
'END; -- Tratamento feito por Felipe em 10/12/2012 --'))
,p_attribute_02=>'P140_COD_AVALIACAO'
,p_attribute_03=>'P140_OCULTA_ANALISE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320796065210011721)
,p_name=>unistr('Desabilita Coment\00E1rio')
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P140_COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADOR and ',
'   :P140_COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADOR then',
'return true;',
'else ',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320796619494011721)
,p_event_id=>wwv_flow_api.id(63320796065210011721)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMENTARIO_AVALIADO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320796999216011722)
,p_name=>unistr('Habilita Coment\00E1rio')
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P140_COD_EMP_AVALIADO = :P_EMPRESA_USER and ',
'   :P140_COD_MAT_AVALIADO = :P_MATRICULA_USER then',
'return true;',
'else ',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320797456464011722)
,p_event_id=>wwv_flow_api.id(63320796999216011722)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMENTARIO_AVALIADO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320797911191011722)
,p_name=>'Esconde Comite'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_AVALIACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'Select COMITE',
'    From Av_Avaliacoes ',
'    Where cod_avaliacao = :p140_cod_avaliacao;',
'    ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if NVL(v_c1.comite,''N'') = ''N'' then',
'return true;',
'else',
'return false;',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320798369499011723)
,p_event_id=>wwv_flow_api.id(63320797911191011722)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMITE'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320798740154011723)
,p_name=>unistr('(Load) Esconde Regi\00F5es (Portal Colab)')
,p_event_sequence=>250
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P_PAINEL = ''PC'' then',
'return true;',
'else ',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320799302237011723)
,p_event_id=>wwv_flow_api.id(63320798740154011723)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320799788718011724)
,p_event_id=>wwv_flow_api.id(63320798740154011723)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990095649582190784)
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320800276206011724)
,p_event_id=>wwv_flow_api.id(63320798740154011723)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094850914190776)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320800809112011724)
,p_event_id=>wwv_flow_api.id(63320798740154011723)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320801130622011725)
,p_name=>unistr('Esconde Regi\00F5es (Portal Colab)')
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_MAT_AVALIADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P_PAINEL = ''PC'' and :p140_rowid is null then',
'return true;',
'else ',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320801640925011725)
,p_event_id=>wwv_flow_api.id(63320801130622011725)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320802216230011725)
,p_event_id=>wwv_flow_api.id(63320801130622011725)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990095649582190784)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320802689834011726)
,p_event_id=>wwv_flow_api.id(63320801130622011725)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990094850914190776)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320803169143011726)
,p_event_id=>wwv_flow_api.id(63320801130622011725)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320803591182011726)
,p_name=>'Dispara Alerta'
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_MENSAGEM'
,p_condition_element=>'P140_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320804055033011727)
,p_event_id=>wwv_flow_api.id(63320803591182011726)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P140_FLAG'').value == "Q") {',
'alertify.confirm($v(''P140_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P140_FLAG'').value = ''S'';',
'        $x(''P140_MENSAGEM'').value = '''';',
'        $x(''P140_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P140_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P140_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P140_FLAG'').value == "N") {',
'            $x(''P140_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P140_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P140_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P140_MENSAGEM''));',
'        ',
'        document.getElementById("alertify-cover").style.position="static";',
'    }else{',
'            if ($x(''P140_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P140_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320804441099011727)
,p_name=>'Valida_Respostas (CREATE)'
,p_event_sequence=>280
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320763948187011692)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320805013143011728)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  CURSOR C1 IS',
'	SELECT A.COD_ITEM_AVALIACAO, A.ESPECIFICACAO, A.ORDEM_ITEM, a.resposta_multipla',
'	FROM   AV_COMPOSICAO_AVALIACAO A',
'	WHERE  A.COD_EMPRESA        = :P140_COD_EMP_AVALIADO',
'	AND    A.COD_AVALIACAO      = :P140_COD_AVALIACAO;',
'',
'	',
'	CURSOR C2(P_ITEM VARCHAR2) IS',
'	SELECT COUNT(*) TOTAL',
'	FROM Av_Aplica_Avaliacoes_Itens',
'	WHERE COD_EMP_AVALIADO   = :P140_COD_EMP_AVALIADO',
'	AND   COD_MAT_AVALIADO   = :P140_COD_MAT_AVALIADO',
'	AND   COD_EMP_AVALIADOR  = :P140_COD_EMP_AVALIADOR',
'	AND   COD_MAT_AVALIADOR  = :P140_COD_MAT_AVALIADOR',
'	AND   COD_AVALIACAO      = :P140_COD_AVALIACAO',
'	AND   DATA_AVALIACAO     = :P140_DATA_AVALIACAO',
'	AND   TIPO_AVALIACAO     = :P140_TIPO_AVALIACAO',
'	AND   COD_ITEM_AVALIACAO = P_ITEM;',
'    ',
'	V_C2 C2%ROWTYPE;',
'    ',
'    saida exception;',
'    ',
'    V_FLAG VARCHAR2(1);',
'    V_MENSAGEM VARCHAR2(4000);',
'    V_OK VARCHAR2(1) := ''S'';',
'    ',
'v_item_validacao varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P140_ITEM_VALIDACAO := null;',
'',
'  FOR L1 IN C1',
'  LOOP',
'  	V_C2.TOTAL := 0;',
'  	OPEN  C2(L1.COD_ITEM_AVALIACAO);',
'  	FETCH C2 INTO V_C2;',
'  	CLOSE C2;',
'  	',
'  	IF NVL(V_C2.TOTAL,0) = 0  THEN',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
'         V_MENSAGEM := ''Preencha a resposta do item  "''||L1.ORDEM_ITEM||''-''||initcap(L1.ESPECIFICACAO)||''"!'';',
'  		 RAISE saida;',
'  	END IF;	',
'',
'   	IF NVL(V_C2.TOTAL,0) > 1 AND l1.resposta_multipla = 0  THEN',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''O item "''||L1.ORDEM_ITEM||''" n\00E3o permite resposta m\00FAltipla. Escolha apenas uma alternativa.'';'),
'  		 RAISE saida;',
'    ELSIF NVL(V_C2.TOTAL,0) > 1 AND l1.resposta_multipla = 0  THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''O item "''||L1.ORDEM_ITEM||''" n\00E3o permite resposta m\00FAltipla. Escolha apenas uma alternativa.'';'),
'  		 RAISE saida;',
'    END IF;	',
'',
'',
'',
'',
'  END LOOP;',
'  ',
':P140_OK := v_ok;',
':P140_FLAG := NULL;',
':P140_MENSAGEM := NULL;',
':P140_ITEM_VALIDACAO := null;',
'',
'exception',
'when saida then',
' if trim(v_mensagem) is not null then',
'',
'    if v_flag in (''N'',''Q'') then',
'        :P140_ok       := ''N'';',
'        :P140_ITEM_VALIDACAO := TRIM(UPPER(''CREATE''));',
'    else',
'        :P140_ok       := ''S'';',
'    end if;',
'    ',
'    :P140_flag     := v_flag;',
'    :P140_mensagem := v_mensagem;',
' else',
'    :P140_flag     := null;',
'    :P140_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''CREATE'')) OR v_item_validacao IS NULL then',
'       :P140_OK := ''S'';',
'       :P140_ITEM_VALIDACAO := null;',
'    else',
'       :P140_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_ITEM_VALIDACAO,P140_PERMITE_CONSULTAR'
,p_attribute_03=>'P140_FLAG,P140_OK,P140_MENSAGEM,P140_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48516489664248199006)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  cursor c1 is',
'    SELECT IND_CONSULTA_AVALIADO_CICLO, nvl(IND_AUTOAVALIACAO,''N'') ind_autoavaliacao',
'      FROM AV_AVALIACOES',
'     WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'',
'   V_C1 C1%ROWTYPE;',
'',
'  V_DUMMY NUMBER := 0;',
'    ',
'    saida exception;',
'    ',
'    V_FLAG VARCHAR2(1);',
'    V_MENSAGEM VARCHAR2(4000);',
'    V_OK VARCHAR2(1) := nvl(:p140_ok,''S'');',
'   ',
'v_item_validacao varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'v_permite_consultar VARCHAR2(1) := ''S'';',
'',
'begin',
'',
'if v_ok is null or v_ok = ''S'' then',
'',
'    v_item_validacao := null;',
'    :P140_ITEM_VALIDACAO := null;',
'',
'      open c1;',
'      fetch c1 into v_c1;',
'      close c1;',
'        --',
'      BEGIN',
'        --',
'           SELECT 1',
'             INTO V_DUMMY',
'             FROM AV_AVALIACOES',
'         WHERE trunc(SYSDATE) BETWEEN trunc(DT_INICIO) AND trunc(DT_FIM)',
'           AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'      --',
'      EXCEPTION',
'        --',
'        WHEN NO_DATA_FOUND THEN',
'          --',
'          V_DUMMY := 0;',
'      --',
'      END;',
'',
'      IF V_DUMMY = 1 AND :P140_COD_MAT_AVALIADO = :P_MATRICULA_USER and :P140_COD_MAT_AVALIADO <> :p140_cod_mat_avaliador THEN',
'          open c1;',
'          fetch c1 into v_c1;',
'          close c1;',
'',
'          if nvl(v_c1.IND_CONSULTA_AVALIADO_CICLO,''N'') = ''N'' then',
'             v_permite_consultar := ''N'';',
'          else',
'            if ((:p140_cod_emp_avaliado = :p140_cod_emp_avaliador and ',
'                 :p140_cod_mat_avaliado = :p140_cod_mat_avaliador))',
'            and v_c1.ind_autoavaliacao = ''N'' then',
'               v_permite_consultar := ''N'';',
'            else',
'               v_permite_consultar := ''S'';',
'            end if;',
'          end if;',
'      else',
'            if ((:p140_cod_emp_avaliado = :p140_cod_emp_avaliador and ',
'                 :p140_cod_mat_avaliado = :p140_cod_mat_avaliador))',
'            and v_c1.ind_autoavaliacao = ''N'' then',
'               v_permite_consultar := ''N'';',
'            else',
'               v_permite_consultar := ''S'';',
'            end if;',
'      END IF;',
'      --',
'    IF NVL(V_PERMITE_CONSULTAR,''S'') = ''N'' THEN',
'      V_FLAG := ''N'';',
'      V_OK := ''N'';',
unistr('      V_MENSAGEM := ''N\00E3o permitido!'';'),
'',
'      RAISE saida;',
'    END IF;',
'  end if;',
'  ',
'    :P140_OK := v_ok;',
'    :P140_FLAG := NULL;',
'    :P140_MENSAGEM := NULL;',
'    :P140_ITEM_VALIDACAO := null;',
'',
'    exception',
'    when saida then',
'     if trim(v_mensagem) is not null then',
'',
'        if v_flag in (''N'',''Q'') then',
'            :P140_ok       := ''N'';',
'            :P140_ITEM_VALIDACAO := TRIM(UPPER(''CREATE2''));',
'        else',
'            :P140_ok       := ''S'';',
'        end if;',
'',
'        :P140_flag     := v_flag;',
'        :P140_mensagem := v_mensagem;',
'     else',
'        :P140_flag     := null;',
'        :P140_mensagem := null;',
'        if v_item_validacao = TRIM(UPPER(''CREATE2'')) OR v_item_validacao IS NULL then',
'           :P140_OK := ''S'';',
'           :P140_ITEM_VALIDACAO := null;',
'        else',
'           :P140_ITEM_VALIDACAO := v_item_validacao;',
'        end if;',
'     end if;',
'',
'END;',
''))
,p_attribute_02=>'P140_COD_AVALIACAO,P140_ITEM_VALIDACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P_MATRICULA_USER,P140_OK'
,p_attribute_03=>'P140_FLAG,P140_OK,P140_MENSAGEM,P140_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320805916791011729)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'V_QTDE_ITENS NUMBER(5) := 0;',
'V_SOMA_NOTA NUMBER(5) := 0;',
'V_RESULTADO NUMBER(15,2) := 0;',
'',
'CURSOR C1 IS',
' SELECT CASE WHEN QTDE_FALTAS > 6 THEN 1               --''ACIMA DE 6'' 0',
'             WHEN QTDE_FALTAS BETWEEN 4 AND 6 THEN 2   --''ATE 6'' 1 ',
'             WHEN QTDE_FALTAS <= 3 THEN 3              --''ATE 3'' 3',
'          ELSE 4',
'        END COD_SUB_ITEM_AVALIACAO',
'        ,CASE WHEN QTDE_FALTAS > 6 THEN 0               ',
'             WHEN QTDE_FALTAS BETWEEN 4 AND 6 THEN 1   ',
'             WHEN QTDE_FALTAS <= 3 THEN 3   ',
'          ELSE 5',
'        END NOTA_ITEM_AVALIACAO',
'   FROM (SELECT SUM(NVL(A.NUM_DIAS_FALTAS,0)) QTDE_FALTAS ',
'           FROM HISTORICO_FALTAS  A',
'        	  , AV_APLICA_AVALIACOES_ITENS C',
'              , AV_CICLOS D',
'          WHERE A.COD_EMPRESA = C.COD_EMP_AVALIADO',
'            AND A.MATRICULA = C.COD_MAT_AVALIADO',
'            AND A.DT_INIC_EVENTO >= D.DATA_REF_INI  ',
'            AND A.DT_FIN_EVENTO <= D.DATA_REF_FIM',
'            AND D.COD_EMPRESA = A.COD_EMPRESA',
'            AND D.COD_AVALIACAO = C.COD_AVALIACAO',
'            AND D.COD_CICLO = C.COD_CICLO',
'            AND C.COD_AVALIACAO = 3',
'            AND A.COD_OCORR     = 513',
'            AND C.COD_ITEM_AVALIACAO = ''098''',
'            AND C.COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO)',
'            AND C.COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'            AND C.COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'            AND C.COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'            AND C.COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'            AND C.TIPO_AVALIACAO = :P140_TIPO_AVALIACAO);',
'',
'V_AVAL C1%ROWTYPE;',
'',
'BEGIN',
'',
'',
' IF :P_BASE = ''SAUDE'' then ',
' ',
'  OPEN  C1;',
'   FETCH C1 INTO V_AVAL;',
'  CLOSE C1;',
'  ',
' ',
'  UPDATE AV_APLICA_AVALIACOES_ITENS SET NOTA_ITEM = V_AVAL.NOTA_ITEM_AVALIACAO',
'                                    ,   COD_SUB_ITEM_AVALIACAO = V_AVAL.COD_SUB_ITEM_AVALIACAO',
'   WHERE COD_EMP_AVALIADO  = :P140_COD_EMP_AVALIADO',
'     AND COD_AVALIACAO     = 3',
'     AND COD_ITEM_AVALIACAO = ''098''',
'     AND COD_MAT_AVALIADO  = :P140_COD_MAT_AVALIADO',
'     AND COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'     AND COD_AVALIACAO     = :P140_COD_AVALIACAO',
'     AND DATA_AVALIACAO    = :P140_DATA_AVALIACAO',
'     AND TIPO_AVALIACAO    = :P140_TIPO_AVALIACAO',
'     AND COD_CICLO 		 = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO);',
'  COMMIT;',
'  ',
' end if;',
' ',
'  EXCEPTION WHEN OTHERS THEN NULL;',
'END;'))
,p_attribute_02=>'P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_CICLO_AUX,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_COD_CICLO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24714208660485533890)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_qtde_itens number(5) := 0;',
'v_soma_nota number(5) := 0;',
'v_resultado number(15,2) := 0;',
'',
'CURSOR C1 IS',
'SELECT nvl(NOTA_ITEM,0) nota_item',
'FROM  Av_Aplica_Avaliacoes_Itens',
'WHERE COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'AND COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'AND COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'AND COD_AVALIACAO = :P140_COD_AVALIACAO',
'AND DATA_AVALIACAO = :P140_DATA_AVALIACAO',
'AND TIPO_AVALIACAO = :P140_TIPO_AVALIACAO;',
'',
'CURSOR C2 IS',
'SELECT form_requisicao, acao',
'FROM medidas_de_acao',
'WHERE cod_avaliacao = :P140_COD_AVALIACAO',
'AND v_resultado BETWEEN resultado_de AND resultado_ate;',
'V_C2 C2%ROWTYPE;',
'',
'CURSOR C3 IS',
'SELECT COUNT(*) TOTAL_ITENS',
'FROM AV_COMPOSICAO_AVALIACAO',
'WHERE COD_EMPRESA = :P140_COD_EMP_AVALIADOR',
'AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'V_C3 C3%ROWTYPE;  ',
'',
'CURSOR C4 IS',
'SELECT REAVALIACAO, DESCRICAO',
'FROM AV_AVALIACOES',
'WHERE COD_EMPRESA = :P140_COD_EMP_AVALIADO',
'AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'V_C4 C4%ROWTYPE;',
'',
'saida exception;',
'',
'V_FLAG VARCHAR2(1);',
'V_MENSAGEM VARCHAR2(4000);',
'V_OK VARCHAR2(1) := nvl(:p140_ok,''S'');',
'v_item_validacao varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'cursor c_nota(v_perc number) is',
'select perc_resultado',
'from medidas_de_acao',
'where cod_avaliacao = :p140_cod_avaliacao',
'and nvl(v_perc,0) between resultado_de and resultado_ate;',
'',
'v_nota c_nota%rowtype;',
'v_result number;',
'',
'begin',
'',
'v_item_validacao := null;',
':P140_ITEM_VALIDACAO := null;',
':P140_PAGE_REQ1 := NULL;',
'',
'for l1 in c1',
'loop',
'  v_soma_nota := v_soma_nota + l1.nota_item;',
'  v_qtde_itens := v_qtde_itens + 1;',
'end loop;',
'',
'v_resultado := v_soma_nota;',
'',
'',
' OPEN  C2;',
'FETCH C2 INTO V_C2;',
'CLOSE C2;',
'',
' OPEN  C3;',
'FETCH C3 INTO V_C3;',
'CLOSE C3;',
'',
' OPEN C4;',
'FETCH C4 INTO V_C4;',
'CLOSE C4;',
'',
'IF V_C2.ACAO IS NOT NULL THEN',
'    V_FLAG := ''S'';',
'    V_OK := ''S'';',
unistr('    :P140_MENSAGEM := INITCAP(V_C4.DESCRICAO)||'' - ''||v_c2.acao||''. Agradecemos a participa\00E7\00E3o!'';'),
'    --raise saida;',
'END IF;',
'',
'IF V_C2.FORM_REQUISICAO IS NOT NULL THEN',
'    :P140_PAGE_REQUISICAO := V_C2.FORM_REQUISICAO;',
'END IF;',
'',
':P140_MENSAGEM := V_MENSAGEM;',
'',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_NOTA_PROV,P140_TIPO,P140_ITEM_VALIDACAO,P140_OK'
,p_attribute_03=>'P140_RESULTADO_AVALIACAO,P140_FLAG,P140_OK,P140_MENSAGEM,P140_PAGE_REQUISICAO,P140_ITEM_VALIDACAO,P140_PAGE_REQ1,P140_NOTA_PROV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10442487468806697905)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_soma_nota  NUMBER(5) := 0;',
'    v_resultado  NUMBER(15,2) := 0;',
unistr('    v_acao       VARCHAR2(4000);  -- Vari\00E1vel para guardar a a\00E7\00E3o'),
'',
'    CURSOR C1 IS',
'    SELECT NVL(NOTA_ITEM, 0) nota_item',
'    FROM Av_Aplica_Avaliacoes_Itens',
'    WHERE COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'    AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'    AND COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'    AND COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'    AND COD_AVALIACAO = :P140_COD_AVALIACAO',
'    AND DATA_AVALIACAO = :P140_DATA_AVALIACAO',
'    AND TIPO_AVALIACAO = :P140_TIPO_AVALIACAO;',
'',
'    CURSOR C2(v_resultado NUMBER) IS',
'    SELECT form_requisicao, acao',
'    FROM medidas_de_acao',
'    WHERE cod_avaliacao = :P140_COD_AVALIACAO',
'    AND v_resultado BETWEEN resultado_de AND resultado_ate;',
'',
'    V_C2 C2%ROWTYPE;',
'',
'BEGIN',
'    -- Soma das notas',
'    FOR l1 IN C1 LOOP',
'        v_soma_nota := v_soma_nota + l1.nota_item;',
'    END LOOP;',
'',
'    v_resultado := v_soma_nota;',
'',
'    -- Abertura do cursor C2',
'    OPEN C2(v_soma_nota);',
'    FETCH C2 INTO V_C2;',
'    CLOSE C2;',
'',
unistr('    -- Verifica se h\00E1 a\00E7\00E3o a ser realizada'),
'    IF V_C2.ACAO IS NOT NULL THEN',
unistr('        v_acao := V_C2.ACAO || ''. Agradecemos a participa\00E7\00E3o!'';'),
'    ELSE',
'        v_acao := NULL;',
'    END IF;',
'',
unistr('    -- Retorna a a\00E7\00E3o (se houver) para o JavaScript'),
'    :P140_Mensagem := v_acao;',
'',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_NOTA_PROV,P140_TIPO,P140_ITEM_VALIDACAO,P140_OK'
,p_attribute_03=>'P140_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33965647758750685236)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_qtde_itens number(5) := 0;',
'v_soma_nota number(5) := 0;',
'v_resultado number(15,2) := 0;',
'',
'CURSOR C1 IS',
'SELECT nvl(NOTA_ITEM,0) nota_item',
'FROM  Av_Aplica_Avaliacoes_Itens',
'WHERE COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'AND COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'AND COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'AND COD_AVALIACAO = :P140_COD_AVALIACAO',
'AND DATA_AVALIACAO = :P140_DATA_AVALIACAO',
'AND TIPO_AVALIACAO = :P140_TIPO_AVALIACAO;',
'',
'CURSOR C3 IS',
'SELECT COUNT(*) TOTAL_ITENS',
'FROM AV_COMPOSICAO_AVALIACAO',
'WHERE COD_EMPRESA = :P140_COD_EMP_AVALIADOR',
'AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'V_C3 C3%ROWTYPE;  ',
'',
'cursor c_nota(v_perc number) is',
'select perc_resultado',
'from medidas_de_acao',
'where cod_avaliacao = :p140_cod_avaliacao',
'and nvl(v_perc,0) between resultado_de and resultado_ate;',
'',
'v_nota c_nota%rowtype;',
'v_result number;',
'',
'begin',
' INSERT INTO TESTEX VALUES(140,''#01 NOTA_PROV''); COMMIT;',
'for l1 in c1',
'loop',
'  v_soma_nota := NVL(v_soma_nota,0) + l1.nota_item;',
'  v_qtde_itens := NVL(v_qtde_itens,0) + 1;',
'end loop;',
' INSERT INTO TESTEX VALUES(140,''#02 NOTA_PROV ''||v_soma_nota||'' ''||v_qtde_itens); COMMIT;',
'',
'IF NVL(V_QTDE_ITENS,0) > 0 THEN',
'  v_qtde_itens := v_qtde_itens * 100;    ',
'  --v_resultado := (v_soma_nota / v_qtde_itens) * 100;',
'  v_resultado := v_soma_nota;',
'END IF;',
'',
' INSERT INTO TESTEX VALUES(140,''#03 NOTA_PROV ''||v_resultado); COMMIT;',
'',
':P140_RESULTADO_AVALIACAO := nvl(:P140_NOTA_PROV, 0) + v_resultado;',
'v_result := nvl(:P140_NOTA_PROV, 0) + v_resultado;',
'',
' INSERT INTO TESTEX VALUES(140,''#04 NOTA_PROV ''||v_result); COMMIT;',
'',
'open c_nota(v_resultado);',
'fetch c_nota into v_nota;',
'close c_nota;',
'',
' INSERT INTO TESTEX VALUES(140,''#05 NOTA_PROV ''||v_nota.perc_resultado); COMMIT;',
'',
':P140_NOTA_PROV := v_nota.perc_resultado;',
'',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_NOTA_PROV,P140_TIPO'
,p_attribute_03=>'P140_RESULTADO_AVALIACAO,P140_NOTA_PROV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320806785204011730)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_TIPO_AVALIACAO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_COD_CICLO,P140_NOTA_PROV'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28887839114247136585)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'----guilherme',
'',
'DECLARE',
'',
' ',
'    ',
'    saida exception;',
'    ',
'    V_FLAG VARCHAR2(1) := :P140_flag ;',
'    V_MENSAGEM VARCHAR2(4000);',
'    V_OK VARCHAR2(1);',
'    ',
'v_item_validacao varchar2(20) := :P140_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P140_ITEM_VALIDACAO := null;',
'',
'  	',
'  	/*IF :P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S'' THEN ',
'    IF :P140_ASPECTOS_FACILITADORES IS NULL ',
'        AND :P140_PONTOS_FORTES IS NULL ',
'        AND :P140_ASPECTOS_DIFICULTADORES IS NULL ',
'        AND :P140_PONTOS_FRACOS IS NULL ',
'        AND :P140_FATORES_EXTERNOS IS NULL ',
'        AND :P140_PLANO_ACAO IS NULL THEN',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento.'';'),
'  		 RAISE saida;',
'         END IF;',
'  	END IF;*/	',
'',
'   ',
'   IF /*:P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S'' AND :P140_ASPECTOS_FACILITADORES IS NULL  THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento.'';'),
'  		 RAISE saida;',
'  ELSIF */:P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S'' AND  :P140_PONTOS_FORTES IS NULL  THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento - Pontos Fortes, Pontos a Desenvolver, Plano de A\00E7\00E3o'';'),
'  		 RAISE saida; ',
' /* ELSIF :P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S'' AND :P140_ASPECTOS_DIFICULTADORES IS NULL   THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento.'';'),
'  		 RAISE saida;*/',
'  ELSIF :P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S'' AND :P140_PONTOS_FRACOS IS NULL    THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento - Pontos Fortes, Pontos a Desenvolver, Plano de A\00E7\00E3o'';'),
'  		 RAISE saida; ',
'  /*ELSIF :P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S''  AND :P140_FATORES_EXTERNOS IS NULL     THEN ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento.'';'),
'  		 RAISE saida;*/ ',
'  ELSIF :P140_TIPO_AVALIACAO_AUX = ''G'' AND :P140_PDI = ''S'' AND :P140_PLANO_ACAO IS NULL THEN   ',
'         V_FLAG := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MENSAGEM := ''Obrigat\00F3rio o preenchimento do Plano de Desenvolvimento - Pontos Fortes, Pontos a Desenvolver, Plano de A\00E7\00E3o'';'),
'  		 RAISE saida;  ',
'  END IF;',
'   ',
'',
'   ',
'  ',
':P140_OK := nvl(v_ok,:P140_OK);',
':P140_FLAG := NULL;',
':P140_MENSAGEM := NULL;',
':P140_ITEM_VALIDACAO := null;',
'             ',
'exception',
'when saida then',
' if trim(v_mensagem) is not null then',
'',
'    if v_flag in (''N'',''Q'') then',
'        :P140_ok       := ''N'';',
'       -- :P140_ITEM_VALIDACAO := TRIM(UPPER(''CREATE''));',
'    else',
'        :P140_ok       := ''S'';',
'    end if;',
'    ',
'    :P140_flag     := v_flag;',
'    :P140_mensagem := v_mensagem;',
' else',
'    :P140_flag     := null;',
'    :P140_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''CREATE'')) OR v_item_validacao IS NULL then',
'       :P140_OK := ''S'';',
'       :P140_ITEM_VALIDACAO := null;',
'    else',
'       :P140_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'END;'))
,p_attribute_02=>'P140_TIPO_AVALIACAO_AUX,P140_PDI,P140_ITEM_VALIDACAO'
,p_attribute_03=>'P140_FLAG,P140_OK,P140_MENSAGEM,P140_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320807234957011730)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'cursor c1 is',
'select cod_mat_avaliado',
'from av_aplica_avaliacoes',
'where cod_emp_avaliado = :p140_cod_emp_avaliado',
'and cod_mat_avaliado = :p140_cod_mat_avaliado',
'and cod_avaliacao = :p140_cod_avaliacao',
'and data_avaliacao = :p140_data_avaliacao',
'and tipo_avaliacao = :p140_tipo_avaliacao;',
'-- and (:p140_cod_ciclo is null or cod_ciclo = :p140_cod_ciclo);',
'v_c1 c1%rowtype;',
'begin',
'',
'',
'',
'IF :P140_OK = ''S'' THEN',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_mat_avaliado is null ',
'and :P_EMPRESA_USER = :P144_COD_EMP_SUP ',
'and :P_MATRICULA_USER = :P144_COD_MAT_SUP then',
'',
'begin',
'',
'insert into AV_APLICA_AVALIACOES',
'(cod_emp_avaliado,',
'cod_mat_avaliado,',
'cod_emp_avaliador,',
'cod_mat_avaliador,',
'cod_avaliacao,',
'data_avaliacao,',
'tipo_avaliacao,',
'aspectos_facilitadores, ',
'aspectos_dificultadores, ',
'fatores_externos, ',
'comentario_avaliado, ',
'comentario_avaliador, ',
'comentario_examinador,',
'pontos_fortes, ',
'pontos_fracos, ',
'plano_acao, ',
'conclusao_final,',
'data_inicial_comite, ',
'data_final_comite,',
'observacoes,',
'nota_prov,',
'cod_ciclo,',
'usuario,',
'dt_atualizacao)',
'values ',
'(:P140_COD_EMP_AVALIADO,',
':P140_COD_MAT_AVALIADO,',
':P_EMPRESA_USER,',
':P_MATRICULA_USER,',
':P140_COD_AVALIACAO,',
':P140_DATA_AVALIACAO,',
':P140_TIPO_AVALIACAO,',
':P140_ASPECTOS_FACILITADORES, ',
':P140_ASPECTOS_DIFICULTADORES, ',
':P140_FATORES_EXTERNOS, ',
':P140_COMENTARIO_AVALIADO, ',
':P140_COMENTARIO_AVALIADOR, ',
':P140_COMENTARIO_EXAMINADOR,',
':P140_PONTOS_FORTES, ',
':P140_PONTOS_FRACOS, ',
':P140_PLANO_ACAO, ',
':P140_CONCLUSAO_FINAL,',
':P140_DATA_INICIAL_COMITE, ',
':P140_DATA_FINAL_COMITE,',
':P140_OBSERVACOES,',
':P140_NOTA_PROV,',
'NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO),',
':P_USUARIO,',
'SYSDATE);',
'commit;',
'end;',
'        ',
'elsif v_c1.cod_mat_avaliado is null then',
'begin',
'insert into AV_APLICA_AVALIACOES',
'(cod_emp_avaliado,',
'cod_mat_avaliado,',
'cod_emp_avaliador,',
'cod_mat_avaliador,',
'cod_avaliacao,',
'data_avaliacao,',
'tipo_avaliacao,',
'aspectos_facilitadores, ',
'aspectos_dificultadores, ',
'fatores_externos, ',
'comentario_avaliado, ',
'comentario_avaliador, ',
'comentario_examinador,',
'pontos_fortes, ',
'pontos_fracos, ',
'plano_acao, ',
'conclusao_final,',
'data_inicial_comite, ',
'data_final_comite,',
'observacoes,',
'nota_prov,',
'cod_ciclo,',
'usuario,',
'dt_atualizacao)',
'values ',
'(:P140_COD_EMP_AVALIADO,',
':P140_COD_MAT_AVALIADO,',
':P_EMPRESA_USER,',
':P_MATRICULA_USER,',
':P140_COD_AVALIACAO,',
':P140_DATA_AVALIACAO,',
':P140_TIPO_AVALIACAO,',
':P140_ASPECTOS_FACILITADORES, ',
':P140_ASPECTOS_DIFICULTADORES, ',
':P140_FATORES_EXTERNOS, ',
':P140_COMENTARIO_AVALIADO, ',
':P140_COMENTARIO_AVALIADOR, ',
':P140_COMENTARIO_EXAMINADOR,',
':P140_PONTOS_FORTES, ',
':P140_PONTOS_FRACOS, ',
':P140_PLANO_ACAO, ',
':P140_CONCLUSAO_FINAL,',
':P140_DATA_INICIAL_COMITE, ',
':P140_DATA_FINAL_COMITE,',
':P140_OBSERVACOES,',
':P140_NOTA_PROV,',
'NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO),',
':P_USUARIO,',
'SYSDATE);',
'commit;',
'end;',
'        ',
'else',
'begin',
'update AV_APLICA_AVALIACOES',
'set aspectos_facilitadores = :P140_ASPECTOS_FACILITADORES,  ',
'aspectos_dificultadores = :P140_ASPECTOS_DIFICULTADORES,  ',
'fatores_externos = :P140_FATORES_EXTERNOS,  ',
'comentario_avaliado = :P140_COMENTARIO_AVALIADO,  ',
'comentario_avaliador = :P140_COMENTARIO_AVALIADOR,  ',
'comentario_examinador = :P140_COMENTARIO_EXAMINADOR, ',
'pontos_fortes = :P140_PONTOS_FORTES,  ',
'pontos_fracos = :P140_PONTOS_FRACOS, ',
'plano_acao  = :P140_PLANO_ACAO,  ',
'conclusao_final	= :P140_CONCLUSAO_FINAL, ',
'data_inicial_comite	= :P140_DATA_INICIAL_COMITE,  ',
'data_final_comite = :P140_DATA_FINAL_COMITE, ',
'observacoes = :P140_OBSERVACOES, ',
'nota_prov = :P140_NOTA_PROV,',
'cod_ciclo = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO),',
'USUARIO = :P_USUARIO,',
'DT_ATUALIZACAO = SYSDATE',
'where cod_emp_avaliado = :P140_COD_EMP_AVALIADO ',
'and cod_mat_avaliado = :P140_COD_MAT_AVALIADO',
'and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'and cod_avaliacao  = :P140_COD_AVALIACAO',
'and data_avaliacao = :P140_DATA_AVALIACAO ',
'and tipo_avaliacao = :P140_TIPO_AVALIACAO;',
'--and (:p140_cod_ciclo is null or cod_ciclo = :p140_cod_ciclo);',
'commit;',
'end; ',
'end if;',
'END IF;',
'end;'))
,p_attribute_02=>'P140_OK,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_ASPECTOS_FACILITADORES,P140_ASPECTOS_DIFICULTADORES,P140_FATORES_EXTERNOS,P140_COMENTARI'
||'O_AVALIADO,P140_COMENTARIO_AVALIADOR,P140_COMENTARIO_EXAMINADOR,P140_PONTOS_FORTES,P140_PONTOS_FRACOS,P140_PLANO_ACAO,P140_CONCLUSAO_FINAL,P140_DATA_INICIAL_COMITE,P140_DATA_FINAL_COMITE,P140_OBSERVACOES,P140_NOTA_PROV,P140_COD_CICLO,P_USUARIO,P140_C'
||'OD_CICLO_AUX'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48509916420481938431)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_TIPO_AVALIACAO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_COD_CICLO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33307740060778384690)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_AVALIADOR informacoes_funcionais.matricula%type;',
'V_EMPRESA  NUMBER(3);',
'',
'BEGIN',
'',
'		BEGIN',
'		SELECT COD_MAT_AVALIADOR ',
'		INTO V_AVALIADOR',
'		FROM AV_APLICA_AVALIACOES',
'		WHERE COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'		AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'		AND COD_AVALIACAO = :P140_COD_AVALIACAO',
'		AND DATA_AVALIACAO = :P140_DATA_AVALIACAO',
'		AND TIPO_AVALIACAO = :P140_TIPO_AVALIACAO;',
'        ',
'        EXCEPTION',
'        --',
'        WHEN NO_DATA_FOUND THEN null;',
'		END;',
'',
'		BEGIN',
'		SELECT COD_EMP_AVALIADOR ',
'		INTO V_EMPRESA',
'		FROM AV_APLICA_AVALIACOES',
'		WHERE COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'		AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'		AND COD_AVALIACAO = :P140_COD_AVALIACAO',
'		AND DATA_AVALIACAO = :P140_DATA_AVALIACAO',
'		AND TIPO_AVALIACAO = :P140_TIPO_AVALIACAO;',
'        EXCEPTION',
'        --',
'        WHEN NO_DATA_FOUND THEN null;',
'		END;',
'',
'		IF V_AVALIADOR IS NOT NULL',
'		AND :P_EMPRESA_USER = V_EMPRESA ',
'		AND :P_MATRICULA_USER = V_AVALIADOR THEN',
'		',
'				UPDATE AV_APLICA_AVALIACOES_ITENS',
'				SET COD_MAT_AVALIADOR = V_AVALIADOR,',
'                    COD_EMP_AVALIADOR = V_EMPRESA',
'						  WHERE COD_EMP_AVALIADO       = :P140_COD_EMP_AVALIADO',
'							AND COD_MAT_AVALIADO       = :P140_COD_MAT_AVALIADO',
'							AND COD_EMP_AVALIADOR      = :P140_COD_EMP_AVALIADOR',
'							AND COD_AVALIACAO          = :P140_COD_AVALIACAO',
'							AND DATA_AVALIACAO         = :P140_DATA_AVALIACAO',
'							AND TIPO_AVALIACAO         = :P140_TIPO_AVALIACAO',
'							AND COD_CICLO 			   = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO);',
'							',
'							COMMIT;',
'		END IF;            ',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_COD_EMP_AVALIADOR,P140_COD_CICLO_AUX,P140_COD_CICLO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33276598220533261717)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'V_RES_PONDERADO VARCHAR2(1);',
'',
'    BEGIN',
'        SELECT RESULTADO_PONDERADO ',
'        INTO V_RES_PONDERADO',
'        FROM AV_AVALIACOES ',
'                WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'        IF V_RES_PONDERADO = ''S'' THEN ',
'                                    PRC_ATUALIZA_RESULTADO_PARCIAL(P_COD_EMP_AVALIADO => :P140_COD_EMP_AVALIADO',
'                                                                  ,P_COD_MAT_AVALIADO => :P140_COD_MAT_AVALIADO',
'                                                                  ,P_COD_AVALIACAO    => :P140_COD_AVALIACAO',
'                                                                  ,P_COD_CICLO        => :P140_COD_CICLO);',
'       END IF;                           ',
'    EXCEPTION',
'        --',
'        WHEN NO_DATA_FOUND THEN NULL;',
'    END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_COD_CICLO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709741056103898235)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>150
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P140_OK").getValue() == ''S''){',
unistr('    toastr.success(''Avalia\00E7\00E3o Salva com Sucesso!'');'),
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10442487403862697904)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>160
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P140_Mensagem").getValue() != null && apex.item("P140_Mensagem").getValue() != '''') {',
'    toastr.success(apex.item("P140_Mensagem").getValue());',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(44877138650767701916)
,p_event_id=>wwv_flow_api.id(63320804441099011727)
,p_event_result=>'TRUE'
,p_action_sequence=>170
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'setTimeout(function() {',
'    ',
'if (apex.item("P140_OK").getValue() == ''S'' || apex.item("P140_OK").getValue().length == 0 ){',
'',
'    apex.submit(''VOLTAR'');',
'}',
'    ',
'}, 10000); // 10.000 milissegundos = 10 segundos',
'',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(53709831653324972115)
,p_name=>'Valida_Respostas (BACK)'
,p_event_sequence=>290
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320761565180011690)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(44877137340056701903)
,p_event_id=>wwv_flow_api.id(53709831653324972115)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'Deseja Sair sem Salvar?'
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'CANCEL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709833726327972136)
,p_event_id=>wwv_flow_api.id(53709831653324972115)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'cursor c1 is',
'select cod_mat_avaliado',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = nvl(:p140_cod_emp_avaliado,:p140_cod_emp_avaliado_aux)',
'   and cod_mat_avaliado = nvl(:p140_cod_mat_avaliado,:p140_cod_mat_avaliado_aux)',
'   and cod_avaliacao = NVL(:p140_cod_avaliacao,:p140_cod_avaliacao_aux)',
'   and to_char(trunc(data_avaliacao),''dd/mm/rrrr'') = :P140_DATA_AVALIACAO',
'   and tipo_avaliacao = nvl(:p140_tipo_avaliacao,:p140_tipo_avaliacao_aux);',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'IF :P140_ROWID IS NULL THEN',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_mat_avaliado is null then',
'',
'begin',
'',
'delete from Av_Aplica_Avaliacoes_Itens',
'where cod_emp_avaliado = nvl(:P140_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux)',
'and cod_mat_avaliado = nvl(:P140_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'and cod_avaliacao = nvl(:P140_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'and to_char(trunc(data_avaliacao),''dd/mm/rrrr'') = :P140_DATA_AVALIACAO',
'and tipo_avaliacao = nvl(:P140_TIPO_AVALIACAO,:p140_tipo_avaliacao_aux);',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'when others then',
'null;',
'end;',
'',
'begin',
'',
'delete from AV_APLICA_AVAL_ACOES_FUNC',
' WHERE COD_EMP_AVALIADO = nvl(:P141_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux)',
'   AND COD_MAT_AVALIADO = nvl(:P141_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'   AND COD_EMP_AVALIADOR = :P141_COD_EMP_AVALIADOR',
'   AND COD_MAT_AVALIADOR = :P141_COD_MAT_AVALIADOR',
'   AND COD_AVALIACAO = nvl(:P141_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'   AND to_char(trunc(data_avaliacao),''dd/mm/rrrr'') = :P140_DATA_AVALIACAO;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'when others then',
'null;',
'end;',
'',
'begin',
'',
'delete from AV_AVALIACOES_MELHORIAS',
'where cod_emp_avaliado = nvl(:P140_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux)',
'and cod_mat_avaliado = nvl(:P140_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'and cod_avaliacao = nvl(:P140_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'and to_char(trunc(data_avaliacao),''dd/mm/rrrr'') = :P140_DATA_AVALIACAO;        ',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'when others then',
'null;',
'end;',
'',
'begin',
'',
'delete from AV_SUBSTITUICOES',
'where cod_emp_avaliado = nvl(:P140_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux)',
'and cod_mat_avaliado = nvl(:P140_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'and cod_avaliacao = nvl(:P140_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'and to_char(trunc(data_avaliacao),''dd/mm/rrrr'') = :P140_DATA_AVALIACAO;      ',
'',
'exception',
'when no_data_found then',
'null;',
'when others then',
'null;',
'end;',
'',
'begin',
'',
'delete from AV_APLICA_AVALIACOES',
'where cod_emp_avaliado = nvl(:P140_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux) ',
'and cod_mat_avaliado = nvl(:P140_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'and cod_avaliacao = nvl(:P140_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'and to_char(trunc(data_avaliacao),''dd/mm/rrrr'') = :P140_DATA_AVALIACAO ',
'and tipo_avaliacao = nvl(:P140_TIPO_AVALIACAO,:p140_tipo_avaliacao_aux);',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'when others then',
'null;',
'end;',
'',
'end if;',
'COMMIT;',
'END IF;',
'',
':P140_OK := ''S'';',
'end;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_ROWID,P140_COD_EMP_AVALIADO_AUX,P140_COD_MAT_AVALIADO_AUX,P140_COD_AVALIACAO_AUX,P140_TIPO_AVALI'
||'ACAO_AUX'
,p_attribute_03=>'P140_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33965647312943685232)
,p_event_id=>wwv_flow_api.id(53709831653324972115)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from Av_Aplica_Avaliacoes_Itens a',
'where a.cod_emp_avaliado = nvl(:P140_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux)',
'and a.cod_mat_avaliado = nvl(:P140_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'and a.cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and a.cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'and a.cod_avaliacao = nvl(:P140_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'and a.data_avaliacao = :P140_DATA_AVALIACAO',
'and a.tipo_avaliacao = nvl(:P140_TIPO_AVALIACAO,:p140_tipo_avaliacao_aux)',
'and a.cod_ciclo = nvl(:p140_cod_ciclo,:p140_cod_ciclo_aux)',
'and not exists (select 1 ',
'                  from av_aplica_avaliacoes x ',
'                 where x.cod_emp_avaliado = a.cod_emp_avaliado',
'                   and x.cod_mat_avaliado = a.cod_mat_avaliado',
'                   and x.cod_avaliacao = a.cod_avaliacao',
'                   and x.data_avaliacao = a.data_avaliacao',
'                   and x.tipo_avaliacao = a.tipo_avaliacao',
'                   and x.cod_ciclo = a.cod_ciclo);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_EMP_AVALIADO_AUX,P140_COD_MAT_AVALIADO,P140_COD_MAT_AVALIADO_AUX,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_AVALIACAO,P140_COD_AVALIACAO_AUX,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO,P140_TIPO_AVALIACAO_AUX,P1'
||'40_COD_CICLO,P140_COD_CICLO_AUX'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709832442284972123)
,p_event_id=>wwv_flow_api.id(53709831653324972115)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P140_OK").getValue() == ''S'' || apex.item("P140_OK").getValue().length == 0 ){',
'',
'    apex.submit(''VOLTAR'');',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(44877137418787701904)
,p_name=>'(BACK)'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320761565180011690)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(44877137651350701906)
,p_event_id=>wwv_flow_api.id(44877137418787701904)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P140_OK").getValue() == ''S'' || apex.item("P140_OK").getValue().length == 0 ){',
'',
'    apex.submit(''VOLTAR'');',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320808129689011731)
,p_name=>'Timer'
,p_event_sequence=>310
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(86989884064293426669)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320808718519011731)
,p_event_id=>wwv_flow_api.id(63320808129689011731)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.TIMER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
,p_attribute_01=>'add'
,p_attribute_02=>'ATUALIZA'
,p_attribute_04=>'5000'
,p_attribute_05=>'infinite'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320809097311011732)
,p_name=>'Timer Expired'
,p_event_sequence=>320
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(86989884064293426669)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.TIMER|DYNAMIC ACTION|timer_expired'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320809607888011732)
,p_event_id=>wwv_flow_api.id(63320809097311011732)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320810107389011732)
,p_event_id=>wwv_flow_api.id(63320809097311011732)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320810583727011733)
,p_event_id=>wwv_flow_api.id(63320809097311011732)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320810942209011733)
,p_name=>'OK: Show Create'
,p_event_sequence=>330
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_ITEM_VALIDACAO'
,p_condition_element=>'P140_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320811495127011734)
,p_event_id=>wwv_flow_api.id(63320810942209011733)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763948187011692)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320812018721011734)
,p_event_id=>wwv_flow_api.id(63320810942209011733)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763948187011692)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320812368757011734)
,p_name=>'Desabilita Tipo_Avaliacao Cod_Ciclo'
,p_event_sequence=>340
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320812909727011735)
,p_event_id=>wwv_flow_api.id(63320812368757011734)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_TIPO_AVALIACAO,P140_COD_CICLO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320813250099011735)
,p_name=>'Deletar'
,p_event_sequence=>350
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320761980095011690)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320813740708011735)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('Deseja Apagar Esta Avalia\00E7\00E3o?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320814273703011736)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_mat_avaliado',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and cod_mat_avaliado = :p140_cod_mat_avaliado',
'   and cod_avaliacao = :p140_cod_avaliacao',
'   and data_avaliacao = :p140_data_avaliacao',
'   and tipo_avaliacao = :p140_tipo_avaliacao;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.cod_mat_avaliado is not null then',
'',
'        begin',
'',
'        delete from AV_APLICA_AVALIACOES',
'        where cod_emp_avaliado = :P140_COD_EMP_AVALIADO ',
'        and cod_mat_avaliado = :P140_COD_MAT_AVALIADO',
'        and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'        and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'        and cod_avaliacao = :P140_COD_AVALIACAO',
'        and data_avaliacao = :P140_DATA_AVALIACAO ',
'        and tipo_avaliacao = :P140_TIPO_AVALIACAO;',
'',
'        commit;',
'        ',
'        exception',
'        when no_data_found then',
'        null;',
'        when others then',
'        null;',
'        end;',
'',
'        begin',
'        ',
'        delete from Av_Aplica_Avaliacoes_Itens',
'        where cod_emp_avaliado = :P140_COD_EMP_AVALIADO ',
'        and cod_mat_avaliado = :P140_COD_MAT_AVALIADO',
'        and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'        and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'        and cod_avaliacao = :P140_COD_AVALIACAO',
'        and data_avaliacao = :P140_DATA_AVALIACAO ',
'        and tipo_avaliacao = :P140_TIPO_AVALIACAO;',
'',
'        commit;',
'        ',
'        exception',
'        when no_data_found then',
'        null;',
'        when others then',
'        null;',
'        end;',
'        ',
'         begin',
'        ',
'        delete from AV_SOLICITACAO_RECURSO',
'         WHERE COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'           AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'           AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'        ',
'        commit;',
'        ',
'        exception',
'        when no_data_found then',
'        null;',
'        when others then',
'        null;',
'        end;',
'       ',
'        ',
'        begin',
'        ',
'        delete from AV_APLICA_AVAL_ACOES_FUNC',
'         WHERE COD_EMP_AVALIADO = :P141_COD_EMP_AVALIADO',
'           AND COD_MAT_AVALIADO = :P141_COD_MAT_AVALIADO',
'           AND COD_EMP_AVALIADOR = :P141_COD_EMP_AVALIADOR',
'           AND COD_MAT_AVALIADOR = :P141_COD_MAT_AVALIADOR',
'           AND COD_AVALIACAO = :P141_COD_AVALIACAO',
'           AND DATA_AVALIACAO = :P141_DATA_AVALIACAO;',
'        ',
'        commit;',
'        ',
'        exception',
'        when no_data_found then',
'        null;',
'        when others then',
'        null;',
'        end;',
'        ',
'        begin',
'        ',
'        delete from AV_AVALIACOES_MELHORIAS',
'        where cod_emp_avaliado = :P140_COD_EMP_AVALIADO ',
'        and cod_mat_avaliado = :P140_COD_MAT_AVALIADO',
'        and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'        and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'        and cod_avaliacao = :P140_COD_AVALIACAO',
'        and data_avaliacao = :P140_DATA_AVALIACAO;        ',
'        ',
'        commit;',
'        ',
'        exception',
'        when no_data_found then',
'        null;',
'        when others then',
'        null;',
'        end;',
'        ',
'        begin',
'        ',
'        delete from AV_SUBSTITUICOES',
'        where cod_emp_avaliado = :P140_COD_EMP_AVALIADO ',
'        and cod_mat_avaliado = :P140_COD_MAT_AVALIADO',
'        and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'        and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR ',
'        and cod_avaliacao = :P140_COD_AVALIACAO',
'        and data_avaliacao = :P140_DATA_AVALIACAO;     ',
'        ',
'        exception',
'        when no_data_found then',
'        null;',
'        when others then',
'        null;',
'        end;',
'        ',
'        ',
'',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320814801736011736)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'success'
,p_attribute_02=>unistr('Avalia\00E7\00E3o Deletada Com Sucesso!')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'true'
,p_attribute_05=>'true'
,p_attribute_06=>'false'
,p_attribute_07=>'true'
,p_attribute_08=>'300'
,p_attribute_09=>'1000'
,p_attribute_10=>'5000'
,p_attribute_11=>'1000'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320815277498011737)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P140_ROWID := null;',
':P140_COD_EMP_AVALIADO := null;',
':P140_COD_MAT_AVALIADO := null;',
':P140_COD_AVALIACAO := null;',
':P140_DATA_AVALIACAO := sysdate;',
':P140_TIPO_AVALIACAO  := null;',
':P140_TIPO := ''V'';',
':P140_RESULTADO_AVALIACAO := null;'))
,p_attribute_03=>'P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_AVALIACAO,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO.P140_ROWID,P140_TIPO,P140_RESULTADO_AVALIACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320815756489011737)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320816288629011738)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320816804488011738)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_RESULTADO_AVALIACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33297398167362305274)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(33297398057967305273)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320817298049011738)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320761980095011690)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33393403054247806388)
,p_event_id=>wwv_flow_api.id(63320813250099011735)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'DELETAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320817703721011739)
,p_name=>'Chama Report'
,p_event_sequence=>360
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320731964120011663)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320818150585011739)
,p_event_id=>wwv_flow_api.id(63320817703721011739)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30);',
'  ',
'  v_parametros varchar2(4000);',
'  ',
'  V_BASE VARCHAR2(100);',
'  ',
'  v_ip varchar2(200);',
'  ',
'begin',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'',
'V_BASE := :P_BASE;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;  ',
'',
'    v_report := ''RP20969'';',
'',
'        V_PARAMETROS := ',
'              ''&P_USUARIO='' ||:p_usuario||',
'              ''&P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||',
'              ''&P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO||',
'              ''&P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO; ',
'    ',
'    :P140_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'    ',
'end;'))
,p_attribute_02=>'P_USUARIO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_COD_AVALIACAO'
,p_attribute_03=>'P140_ENDERECO_REL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320818696199011740)
,p_event_id=>wwv_flow_api.id(63320817703721011739)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP20969'
,p_attribute_02=>'RELATORIO'
,p_attribute_03=>'inline'
,p_attribute_05=>'P140_COD_AVALIACAO,P_USUARIO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'RETURN  ''P_USUARIO='' ||:p_usuario||',
'       ''&P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'       ''&P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'       ''&P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||',
'       ''&P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO||',
'       ''&P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO; '))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320819204824011740)
,p_event_id=>wwv_flow_api.id(63320817703721011739)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//javascript:void(window.open($v(''P140_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320819602186011740)
,p_name=>'Chama Report_1'
,p_event_sequence=>370
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320732370215011664)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320820052950011741)
,p_event_id=>wwv_flow_api.id(63320819602186011740)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30);',
'  ',
'  v_parametros varchar2(4000);',
'  ',
'  V_BASE VARCHAR2(100);',
'  ',
'  v_ip varchar2(200);',
'  ',
'begin',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'',
'V_BASE := :P_BASE;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;  ',
'',
'    v_report := ''RP20968'';',
'    /*',
'            V_PARAMETROS := ',
'               ''PF_P_USUARIO='' ||:p_usuario||',
'              ''&PF_P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&PF_P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&PF_P_EMP_AVALIADOR='' ||:P140_COD_EMP_AVALIADOR||',
'              ''&PF_P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||              ',
'              ''&PF_P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO||',
'              ''&PF_P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO; ',
'*/',
'              ',
'--raise_application_error(-20001,''aq teste 2 >> RP21003'');',
'              ',
'        V_PARAMETROS := ',
'              ''&P_USUARIO='' ||:p_usuario||',
'              ''&P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&P_EMP_AVALIADOR='' ||:P140_COD_EMP_AVALIADOR||              ',
'              ''&P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||',
'              ''&P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO||',
'              ''&P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO; ',
'  ',
'    :P140_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'    ',
'end;'))
,p_attribute_02=>'P_USUARIO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_MAT_AVALIADOR,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_COD_AVALIACAO'
,p_attribute_03=>'P140_ENDERECO_REL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320820584965011741)
,p_event_id=>wwv_flow_api.id(63320819602186011740)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP20968'
,p_attribute_02=>'RELATORIO'
,p_attribute_03=>'inline'
,p_attribute_05=>'P_USUARIO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_COD_AVALIACAO,P140_DATA_AVALIACAO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*RETURN  ''PF_P_USUARIO='' ||:p_usuario||',
'        ''&PF_P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&PF_P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&PF_P_EMP_AVALIADOR='' ||:P140_COD_EMP_AVALIADOR||',
'              ''&PF_P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||              ',
'              ''&PF_P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO||',
'              ''&PF_P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO;',
'         */',
'         ',
'               ',
'  RETURN      ''&P_USUARIO='' ||:p_usuario||',
'              ''&P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&P_EMP_AVALIADOR='' ||:P140_COD_EMP_AVALIADOR||              ',
'              ''&P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||',
'              ''&P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO||',
'              ''&P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO; '))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320821102227011741)
,p_event_id=>wwv_flow_api.id(63320819602186011740)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//javascript:void(window.open($v(''P140_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33297398599151305279)
,p_name=>'Chama Report Avaliacao'
,p_event_sequence=>390
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(33297398486031305278)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33297398706294305280)
,p_event_id=>wwv_flow_api.id(33297398599151305279)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30);',
'  ',
'  v_parametros varchar2(4000);',
'  ',
'  V_BASE VARCHAR2(100);',
'  ',
'  v_ip varchar2(200);',
'  ',
'begin',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'',
'V_BASE := :P_BASE;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
'if :P140_QUEBRAS = ''SQ'' then',
'    v_report := ''RP20514'';',
'elsif :P140_QUEBRAS = ''CQ'' then',
'    v_report := ''RP20938'';',
'ELSE',
'   if :P140_TIPO_AVALIACAO in (''A'',''G'') then',
'   v_report := ''RP21003'';',
'   ELSE',
'   v_report := ''RP21003_C'';',
'   END IF;',
'end if;',
'',
':P140_REPORT := V_REPORT;',
'',
'        V_PARAMETROS := ',
'              ''&P_USUARIO='' ||:p_usuario||',
'              ''&P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&P_EMP_AVALIADOR='' ||:P140_COD_EMP_AVALIADOR||',
'              ''&P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||',
'              ''&P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO||',
'              ''&P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO;',
'    ',
'    :P140_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'    ',
'end;'))
,p_attribute_02=>'P140_TIPO_AVALIACAO,P_USUARIO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_COD_AVALIACAO,P140_COD_EMP_AVALIADOR,P140_QUEBRAS'
,p_attribute_03=>'P140_ENDERECO_REL,P140_REPORT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33297398861282305281)
,p_event_id=>wwv_flow_api.id(33297398599151305279)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'&P140_REPORT.'
,p_attribute_02=>'RELATORIO'
,p_attribute_03=>'inline'
,p_attribute_05=>'P140_COD_AVALIACAO,P_USUARIO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_COD_EMP_AVALIADOR'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'RETURN  ''P_USUARIO='' ||:p_usuario||',
'              ''&P_EMP_AVALIADO='' ||:P140_COD_EMP_AVALIADO||',
'              ''&P_MAT_AVALIADO='' ||:P140_COD_MAT_AVALIADO||',
'              ''&P_EMP_AVALIADOR='' ||:P140_COD_EMP_AVALIADOR||',
'              ''&P_MAT_AVALIADOR='' ||:P140_COD_MAT_AVALIADOR||',
'              ''&P_DATA_AVALIACAO='' ||:P140_DATA_AVALIACAO||',
'              ''&P_COD_AVALIACAO='' ||:P140_COD_AVALIACAO;'))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33297398899313305282)
,p_event_id=>wwv_flow_api.id(33297398599151305279)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//javascript:void(window.open($v(''P140_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33297399223908305285)
,p_event_id=>wwv_flow_api.id(33297398599151305279)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(33297398480816305277)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320823404418011743)
,p_name=>'Inicia Alertify'
,p_event_sequence=>400
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320823906426011744)
,p_event_id=>wwv_flow_api.id(63320823404418011743)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320824306058011744)
,p_name=>'HideBT_REQ1234'
,p_event_sequence=>410
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320824789773011744)
,p_event_id=>wwv_flow_api.id(63320824306058011744)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762428319011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320825289748011745)
,p_event_id=>wwv_flow_api.id(63320824306058011744)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762781667011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320825814493011745)
,p_event_id=>wwv_flow_api.id(63320824306058011744)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763163669011692)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320826250645011745)
,p_event_id=>wwv_flow_api.id(63320824306058011744)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763566969011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320826716034011746)
,p_name=>'ShowBT_REQ1'
,p_event_sequence=>420
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PAGE_REQ1'
,p_condition_element=>'P140_PAGE_REQ1'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'FP10594'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320827213913011746)
,p_event_id=>wwv_flow_api.id(63320826716034011746)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_PAGE_BT_REQ1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320827654082011746)
,p_event_id=>wwv_flow_api.id(63320826716034011746)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762428319011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320828138746011747)
,p_event_id=>wwv_flow_api.id(63320826716034011746)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762781667011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320828712376011747)
,p_event_id=>wwv_flow_api.id(63320826716034011746)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763163669011692)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320829175509011747)
,p_event_id=>wwv_flow_api.id(63320826716034011746)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763566969011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320829577478011748)
,p_name=>'ShowBT_REQ2'
,p_event_sequence=>430
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PAGE_REQ1'
,p_condition_element=>'P140_PAGE_REQ1'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'F011665'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320830103938011748)
,p_event_id=>wwv_flow_api.id(63320829577478011748)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762781667011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320830565088011748)
,p_event_id=>wwv_flow_api.id(63320829577478011748)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762428319011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320831057511011749)
,p_event_id=>wwv_flow_api.id(63320829577478011748)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763163669011692)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320831593584011749)
,p_event_id=>wwv_flow_api.id(63320829577478011748)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763566969011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320831993113011750)
,p_name=>'ShowBT_REQ3'
,p_event_sequence=>440
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PAGE_REQ1'
,p_condition_element=>'P140_PAGE_REQ1'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'FP10573'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320832462689011750)
,p_event_id=>wwv_flow_api.id(63320831993113011750)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763163669011692)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320832956612011750)
,p_event_id=>wwv_flow_api.id(63320831993113011750)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762428319011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320833484434011750)
,p_event_id=>wwv_flow_api.id(63320831993113011750)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762781667011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320833969330011751)
,p_event_id=>wwv_flow_api.id(63320831993113011750)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763566969011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320834421869011751)
,p_name=>'ShowBT_REQ4'
,p_event_sequence=>450
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PAGE_REQ1'
,p_condition_element=>'P140_PAGE_REQ1'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'F012019_2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320834830083011752)
,p_event_id=>wwv_flow_api.id(63320834421869011751)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763566969011692)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320835428024011752)
,p_event_id=>wwv_flow_api.id(63320834421869011751)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762428319011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320835844621011752)
,p_event_id=>wwv_flow_api.id(63320834421869011751)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762781667011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320836381798011753)
,p_event_id=>wwv_flow_api.id(63320834421869011751)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763163669011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320836785426011753)
,p_name=>'HideBT_REQs'
,p_event_sequence=>460
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PAGE_REQ1'
,p_condition_element=>'P140_PAGE_REQ1'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320837233691011753)
,p_event_id=>wwv_flow_api.id(63320836785426011753)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762428319011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320837781328011754)
,p_event_id=>wwv_flow_api.id(63320836785426011753)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320762781667011691)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320838237860011754)
,p_event_id=>wwv_flow_api.id(63320836785426011753)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763163669011692)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320838801587011755)
,p_event_id=>wwv_flow_api.id(63320836785426011753)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763566969011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63318651364515630562)
,p_name=>'Sucessor: Dialog Closed'
,p_event_sequence=>470
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320722289222011655)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63318651436629630563)
,p_event_id=>wwv_flow_api.id(63318651364515630562)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63318651567340630564)
,p_name=>'Feedback: Dialog Closed'
,p_event_sequence=>480
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320760871768011689)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63318651725807630565)
,p_event_id=>wwv_flow_api.id(63318651567340630564)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63318651785349630566)
,p_name=>'Feedback - Report: Dialog Closed'
,p_event_sequence=>490
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(86990148862742365349)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63318651864981630567)
,p_event_id=>wwv_flow_api.id(63318651785349630566)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86990148862742365349)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63318652005843630568)
,p_name=>unistr('Sucess\00E3o - Report: Dialog Closed')
,p_event_sequence=>500
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(86967095710669551470)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63318652049966630569)
,p_event_id=>wwv_flow_api.id(63318652005843630568)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86967095710669551470)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55506746374012125238)
,p_name=>'get_lov_display (popup_lov)'
,p_event_sequence=>510
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.popup_lov'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506746512787125239)
,p_event_id=>wwv_flow_api.id(55506746374012125238)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var $te = $(this.triggeringElement);',
'console.log(''Processando '' + $te.attr(''id'') + ''. Valor: '' + $v($te.attr(''id'')) + ''this.triggeringElement: '' + $v(this.triggeringElement))',
'apex.server.process("get_lov_display", {',
'  x01: $te.attr(''id''),',
'  x02: $v($te.attr(''id''))',
'}, {',
'  dataType: "text",',
'  success: function(pData) {',
'    if (pData) $te.val(pData)',
'  } ',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55506746642674125240)
,p_name=>'get_lov_display (select_list)'
,p_event_sequence=>520
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.select_list'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506746745460125241)
,p_event_id=>wwv_flow_api.id(55506746642674125240)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var $te = $(this.triggeringElement);',
'console.log(''Processando '' + $te.attr(''id'') + ''. Valor: '' + $v($te.attr(''id'')) + ''this.triggeringElement: '' + $v(this.triggeringElement))',
'apex.server.process("get_lov_display", {',
'  x01: $te.attr(''id''),',
'  x02: $v($te.attr(''id''))',
'}, {',
'  dataType: "text",',
'  success: function(pData) {',
'    if (pData) $te.val(pData)',
'  } ',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55506747254901125246)
,p_name=>'(Mouse Move) Popula Campos'
,p_event_sequence=>530
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.t-PageBody'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.item(''P140_COD_MAT_AVALIADO'').getValue().length == 0 && apex.item(''P140_COD_MAT_AVALIADO_AUX'').getValue().length > 0'
,p_bind_type=>'bind'
,p_bind_event_type=>'mousemove'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506747333485125247)
,p_event_id=>wwv_flow_api.id(55506747254901125246)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P140_COD_EMP_AVALIADO := :P140_COD_EMP_AVALIADO_AUX;',
':P140_COD_MAT_AVALIADO := :P140_COD_MAT_AVALIADO_AUX;'))
,p_attribute_02=>'P140_COD_MAT_AVALIADO_AUX,P140_COD_EMP_AVALIADO_AUX'
,p_attribute_03=>'P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506747399526125248)
,p_event_id=>wwv_flow_api.id(55506747254901125246)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'console.log("Mouse Move");'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55506747696119125251)
,p_name=>'(Change) Tipo Avaliacao'
,p_event_sequence=>540
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_TIPO_AVALIACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506747839085125252)
,p_event_id=>wwv_flow_api.id(55506747696119125251)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p140_tipo_avaliacao_aux := :p140_tipo_avaliacao;'
,p_attribute_02=>'P140_TIPO_AVALIACAO'
,p_attribute_03=>'P140_TIPO_AVALIACAO_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506747948665125253)
,p_event_id=>wwv_flow_api.id(55506747696119125251)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(86989884064293426669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55514379842637528530)
,p_name=>unistr('(N\00E3o \00E9 avaliado(r)) Desabilita Campos')
,p_event_sequence=>550
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' ciclo, nvl(ind_autoavaliacao,''N'') ind_autoavaliacao',
'  FROM AV_AVALIACOES',
' WHERE trunc(SYSDATE) BETWEEN trunc(DT_INICIO) AND trunc(DT_FIM)',
'   AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if nvl(v_c1.ciclo,''N'') = ''N'' or nvl(:p140_oculta_analise,''N'') = ''S'' then',
'  return true; -- desabilita',
'else',
'    if :P140_tipo_avaliacao = ''A'' and :P_EMPRESA_USER = :P140_cod_emp_avaliado and :P_MATRICULA_USER = :P140_cod_mat_avaliado then',
'       if v_c1.ind_autoavaliacao = ''S'' then',
'        RETURN TRUE; -- desabilita PDI NUNCA PODE SER HABILITADO PARA AUTO-AVALIACAO',
'       else',
'        return true; -- desabilita',
'       end if;',
'        RETURN TRUE;',
'    elsif :P_MATRICULA_USER = nvl(:P140_cod_mat_avaliado_aux,:P140_cod_mat_avaliado) then',
'        RETURN TRUE; -- desabilita PDI NUNCA PODE SER HABILITADO PARA AUTO-AVALIACAO',
'    elsif :P_MATRICULA_USER <> :P140_cod_mat_avaliado and :p_matricula_user = :p140_cod_mat_avaliador then',
'      return false; -- habilita',
'    end if;',
'/*',
'    if :P140_tipo_avaliacao = ''A'' and :P_EMPRESA_USER = :P140_cod_emp_avaliado and :P_MATRICULA_USER = :P140_cod_mat_avaliado then',
'       if v_c1.ind_autoavaliacao = ''S'' then',
'        --return false; -- habilita',
'        RETURN TRUE; -- desabilita PDI NUNCA PODE SER HABILITADO PARA AUTO-AVALIACAO',
'       else',
'        return true; -- desabilita',
'       end if;',
'    elsif :p140_rowid is not null and :P_EMPRESA_USER = :P140_cod_emp_avaliador and :P_MATRICULA_USER = :P140_cod_mat_avaliador AND :p_matricula_user <> :p140_cod_mat_avaliado then',
'        return false; -- habilita',
'    elsif :P140_tipo_avaliacao = ''G'' and :P_EMPRESA_USER = :P140_cod_emp_avaliador and :P_MATRICULA_USER = :P140_cod_mat_avaliador then',
'        return false; -- habilita',
'    elsif :P140_tipo_avaliacao = ''C'' and ((:P_EMPRESA_USER = :P140_cod_emp_avaliado and :P_MATRICULA_USER = :P140_cod_mat_avaliado) or ',
'                                          (:P_EMPRESA_USER = :P140_cod_emp_avaliador and :P_MATRICULA_USER = :P140_cod_mat_avaliador)) then',
'        return false; -- habilita',
'    elsif :p140_rowid is null and :P_EMPRESA_USER = :P140_cod_emp_avaliado and :P_MATRICULA_USER = :P140_cod_mat_avaliado then',
'        RETURN TRUE; -- desabilita PDI NUNCA PODE SER HABILITADO PARA AUTO-AVALIACAO',
'    else',
'        return true; -- desabilita',
'    end if;',
'*/',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514380154362528533)
,p_event_id=>wwv_flow_api.id(55514379842637528530)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320722289222011655)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514380211500528534)
,p_event_id=>wwv_flow_api.id(55514379842637528530)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320763948187011692)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55514380309537528535)
,p_name=>unistr('Reavalia\00E7\00E3o')
,p_event_sequence=>560
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514380436996528536)
,p_event_id=>wwv_flow_api.id(55514380309537528535)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'',
'  CURSOR C1 IS',
'    SELECT count(*) total',
'    FROM   AV_COMPOSICAO_AVALIACAO A',
'    WHERE  A.COD_EMPRESA        = :P140_COD_EMP_AVALIADO_AUX',
'    AND    A.COD_AVALIACAO      = :P140_COD_AVALIACAO;',
'',
'    v_c1 c1%rowtype;',
'',
'    CURSOR C2 IS',
'    SELECT COUNT(*) TOTAL',
'    FROM Av_Aplica_Avaliacoes_Itens',
'    WHERE COD_EMP_AVALIADO   = :P140_COD_EMP_AVALIADO_AUX',
'    AND   COD_MAT_AVALIADO   = :P140_COD_MAT_AVALIADO_AUX',
'    AND   COD_EMP_AVALIADOR  = :P140_COD_EMP_AVALIADOR',
'    AND   COD_MAT_AVALIADOR  = :P140_COD_MAT_AVALIADOR',
'    AND   COD_AVALIACAO      = :P140_COD_AVALIACAO',
'    AND   DATA_AVALIACAO     = :P140_DATA_AVALIACAO',
'    AND   TIPO_AVALIACAO     = :P140_TIPO_AVALIACAO;',
'    ',
'    V_C2 C2%ROWTYPE;',
'    ',
'begin',
'',
'      OPEN  C1;',
'      FETCH C1 INTO V_C1;',
'      CLOSE C1;',
'',
'      OPEN  C2;',
'      FETCH C2 INTO V_C2;',
'      CLOSE C2;',
'      ',
'      IF NVL(V_C1.TOTAL,0) > 0 THEN',
'     ',
'          IF NVL(V_C1.TOTAL,0) = NVL(V_C2.TOTAL,0) THEN',
'            begin',
'            SELECT REAVALIACAO',
'              into :P140_REAVALIACAO',
'              FROM AV_AVALIACOES',
'             WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'            exception',
'            when no_data_found then',
'            null;',
'            end;',
'          ELSE',
'          :P140_REAVALIACAO := ''S'';',
'            ',
'       ',
'              ',
'          END IF;     ',
'       ',
'       END IF;',
'END;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO_AUX,P140_COD_AVALIACAO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_TIPO_AVALIACAO'
,p_attribute_03=>'P140_REAVALIACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55514380557053528537)
,p_name=>unistr('Reavalia\00E7\00E3o Campos')
,p_event_sequence=>570
,p_condition_element=>'P140_REAVALIACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P140_REAVALIACAO'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514380579062528538)
,p_event_id=>wwv_flow_api.id(55514380557053528537)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320722289222011655)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514381085754528543)
,p_event_id=>wwv_flow_api.id(55514380557053528537)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320760871768011689)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514380667448528539)
,p_event_id=>wwv_flow_api.id(55514380557053528537)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320760871768011689)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55514381019593528542)
,p_event_id=>wwv_flow_api.id(55514380557053528537)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320722289222011655)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(55506748480879125259)
,p_name=>unistr('Aprovar Avalia\00E7\00E3o')
,p_event_sequence=>580
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(55506748342532125257)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506748653317125260)
,p_event_id=>wwv_flow_api.id(55506748480879125259)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Deseja aprovar esta avalia\00E7\00E3o?')
,p_attribute_07=>'Sim'
,p_attribute_08=>'Nao'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55506748697002125261)
,p_event_id=>wwv_flow_api.id(55506748480879125259)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update AV_APLICA_AVALIACOES',
'set SOLICITA_RECURSO = ''N'',',
'DT_SOLICITA_RECURSO = SYSDATE,',
'USUARIO_SOLICITA_RECURSO = :P_USUARIO,',
'ind_aceite = ''S'',',
'DT_IND_ACEITE = SYSDATE,',
'USUARIO_IND_ACEITE = :P_USUARIO',
'where cod_avaliacao = :p140_cod_avaliacao',
'and cod_emp_avaliado = :p140_cod_emp_avaliado',
'and cod_mat_avaliado = :p140_cod_mat_avaliado',
'and cod_emp_avaliador = :p140_cod_emp_avaliador',
'and cod_mat_avaliador = :p140_cod_mat_avaliador',
'and data_avaliacao = :p140_data_avaliacao',
'and tipo_avaliacao = :p140_tipo_avaliacao',
'and (NVL(:P140_COD_CICLO_AUX,:p140_cod_ciclo) is null or cod_ciclo = NVL(:P140_COD_CICLO_AUX,:p140_cod_ciclo));',
'',
'COMMIT;',
'',
'end;'))
,p_attribute_02=>'P140_COD_AVALIACAO,P140_COD_EMP_AVALIADO,P140_COD_MAT_AVALIADO,P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR,P140_DATA_AVALIACAO,P140_COD_CICLO,P140_TIPO_AVALIACAO,P_USUARIO,P140_COD_CICLO_AUX'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709741669820898241)
,p_event_id=>wwv_flow_api.id(55506748480879125259)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('toastr.success(''Avalia\00E7\00E3o Salva com Sucesso!'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709741810614898242)
,p_event_id=>wwv_flow_api.id(55506748480879125259)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53709741578601898240)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48509916554114938432)
,p_name=>unistr('(Dialog Closed) Aprovar Avalia\00E7\00E3o')
,p_event_sequence=>590
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(55506748342532125257)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48509916896253938436)
,p_event_id=>wwv_flow_api.id(48509916554114938432)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53709741578601898240)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(53709741862409898243)
,p_name=>unistr('Reprovar Avalia\00E7\00E3o')
,p_event_sequence=>600
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(55506748380303125258)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709742022101898245)
,p_event_id=>wwv_flow_api.id(53709741862409898243)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('toastr.success(''Avalia\00E7\00E3o Salva com Sucesso!'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709742175429898246)
,p_event_id=>wwv_flow_api.id(53709741862409898243)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53709741578601898240)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48509916981205938437)
,p_name=>unistr('(Dialog Closed) Reprovar Avalia\00E7\00E3o')
,p_event_sequence=>610
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(55506748380303125258)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48509917255546938439)
,p_event_id=>wwv_flow_api.id(48509916981205938437)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53709741578601898240)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37784343873084909067)
,p_event_id=>wwv_flow_api.id(48509916981205938437)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'document.getElementById("RECURSO_AVALIADO").style.display = "none";'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(53709830777214972106)
,p_name=>'Dialog Closed - Recurso'
,p_event_sequence=>620
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(53709830272264972101)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53709830836946972107)
,p_event_id=>wwv_flow_api.id(53709830777214972106)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'toastr.success(''Recurso Salvo com Sucesso!'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51904466286686207600)
,p_name=>'(Hide/Disable) Avaliado'
,p_event_sequence=>630
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if (:P_EMPRESA_USER = :P140_cod_emp_avaliado and ',
'       :P_MATRICULA_USER = :P140_cod_mat_avaliado) or ',
'        (:P_MATRICULA_USER <> :P140_cod_mat_avaliador) then',
'       return true;',
'    else',
'       return false;',
'    end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51904466416702207601)
,p_event_id=>wwv_flow_api.id(51904466286686207600)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320760871768011689)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51904466908069207606)
,p_event_id=>wwv_flow_api.id(51904466286686207600)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMENTARIO_AVALIADOR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51906265485097269160)
,p_event_id=>wwv_flow_api.id(51904466286686207600)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMENTARIO_EXAMINADOR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51906265158208269157)
,p_name=>'(Hide/Disable) Avaliador'
,p_event_sequence=>640
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if (:P_EMPRESA_USER = :P140_cod_emp_avaliador and ',
'       :P_MATRICULA_USER = :P140_cod_mat_avaliador) then',
'       return true;',
'    else',
'       return false;',
'    end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51906265423353269159)
,p_event_id=>wwv_flow_api.id(51906265158208269157)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COMENTARIO_AVALIADO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48509916243380938429)
,p_name=>'Disable P140_COD_AVALIACAO'
,p_event_sequence=>650
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_AVALIACAO_AUX'
,p_condition_element=>'P140_COD_AVALIACAO_AUX'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48509916369504938430)
,p_event_id=>wwv_flow_api.id(48509916243380938429)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_COD_AVALIACAO,P140_DATA_AVALIACAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48509917335284938440)
,p_name=>'(Dialog Closed) Recurso do Avaliado'
,p_event_sequence=>660
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(53709741578601898240)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48509917399737938441)
,p_event_id=>wwv_flow_api.id(48509917335284938440)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53709741578601898240)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37784343783862909066)
,p_event_id=>wwv_flow_api.id(48509917335284938440)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'document.getElementById("RECURSO_AVALIADO").style.display = "none";'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(39594395969043485851)
,p_name=>'Popula P140_NOTA_PROV_DSP'
,p_event_sequence=>670
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_NOTA_PROV'
,p_condition_element=>'P140_NOTA_PROV'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(39594396043294485852)
,p_event_id=>wwv_flow_api.id(39594395969043485851)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_NOTA_PROV_DSP'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>':P140_NOTA_PROV'
,p_attribute_07=>'P140_NOTA_PROV'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37784344109840909070)
,p_name=>'Carrega Ciclo'
,p_event_sequence=>680
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_EMP_AVALIADO'
,p_condition_element=>'P140_COD_EMP_AVALIADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P140_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37784344280146909071)
,p_event_id=>wwv_flow_api.id(37784344109840909070)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select cod_ciclo',
'      from av_ciclos',
'     where cod_empresa = :p140_cod_emp_avaliado',
'       and cod_avaliacao = :p140_cod_avaliacao',
'       and trunc(sysdate) between trunc(dt_ini_ciclo) and trunc(dt_fim_ciclo);',
'',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'   ',
'   IF :P140_COD_CICLO IS NULL OR :P140_COD_CICLO_AUX IS NULL THEN',
'    :p140_cod_ciclo := v_c1.cod_ciclo;',
'   END IF;',
'',
'end;'))
,p_attribute_02=>'P140_COD_EMP_AVALIADO,P140_COD_AVALIACAO,P140_COD_CICLO,P140_COD_CICLO_AUX'
,p_attribute_03=>'P140_COD_CICLO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33965646964261685228)
,p_name=>'(Change) Cod Ciclo'
,p_event_sequence=>690
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_CICLO'
,p_condition_element=>'P140_COD_CICLO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33965647058002685229)
,p_event_id=>wwv_flow_api.id(33965646964261685228)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_COD_CICLO_AUX := :P140_COD_CICLO;'
,p_attribute_02=>'P140_COD_CICLO'
,p_attribute_03=>'P140_COD_CICLO_AUX'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33965647096293685230)
,p_name=>'(Change) Cod Ciclo Aux'
,p_event_sequence=>700
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_CICLO_AUX'
,p_condition_element=>'P140_COD_CICLO_AUX'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33965647243795685231)
,p_event_id=>wwv_flow_api.id(33965647096293685230)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_COD_CICLO := :P140_COD_CICLO_AUX;'
,p_attribute_02=>'P140_COD_CICLO_AUX'
,p_attribute_03=>'P140_COD_CICLO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33509278486263976565)
,p_name=>'Retorna Faltas'
,p_event_sequence=>710
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_RETORNA_FALTAS'
,p_condition_element=>'P140_RETORNA_FALTAS'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33509278597300976566)
,p_event_id=>wwv_flow_api.id(33509278486263976565)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_FALTAS_PERIODO_COLAB'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33509278817569976568)
,p_event_id=>wwv_flow_api.id(33509278486263976565)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_FALTAS_PERIODO_COLAB'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33297398984792305283)
,p_name=>'Open Dialog'
,p_event_sequence=>720
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(63320732761086011664)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33297399161282305284)
,p_event_id=>wwv_flow_api.id(33297398984792305283)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(33297398480816305277)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33308852489600119579)
,p_name=>'HIDE_RECURSO_AVALIADO'
,p_event_sequence=>730
,p_condition_element=>'P140_TIPO_AVALIACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'A'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33308852583416119580)
,p_event_id=>wwv_flow_api.id(33308852489600119579)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53709741578601898240)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33296598365153891520)
,p_name=>'SET_COD_AUX'
,p_event_sequence=>740
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_EMP_AVALIADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33296598420589891521)
,p_event_id=>wwv_flow_api.id(33296598365153891520)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_COD_EMPRESA_AUX := :P140_COD_EMP_AVALIADO;'
,p_attribute_02=>'P140_COD_EMP_AVALIADO'
,p_attribute_03=>'P140_COD_EMPRESA_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(32588039289179082733)
,p_name=>unistr('Verifica tipo avalia\00E7\00E3o')
,p_event_sequence=>750
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_AVALIACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADO THEN ',
'',
'RETURN FALSE;--TRUE;',
'ELSE',
'RETURN TRUE;',
'',
'END IF;',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(32588039366958082734)
,p_event_id=>wwv_flow_api.id(32588039289179082733)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_TIPO_AVALIACAO := ''A'';'
,p_attribute_03=>'P140_TIPO_AVALIACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31411535085409386648)
,p_name=>'SET SUPLENTE_CENTRALIZADOR'
,p_event_sequence=>760
,p_condition_element=>'P140_TIPO_AVALIACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31411535116637386649)
,p_event_id=>wwv_flow_api.id(31411535085409386648)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*Server-side Condition',
'',
'DECLARE',
'V_MAT informacoes_funcionais.matricula%type;',
'V_EMPRESA NUMBER (5);',
'',
'cursor c_SUPLENTE is',
'SELECT  S.COD_CCUSTO',
'    ,   S.COD_EMPRESA ',
'    ,   S.COD_SUB_CCUSTO_SUPERIOR',
'FROM INFORMACOES_FUNCIONAIS_CAD I',
' ,   SUB_CCUSTO S',
'WHERE S.COD_EMPRESA 	= I.COD_EMPRESA',
'  AND S.COD_CCUSTO 		= I.COD_CCUSTO',
'  AND S.COD_SUB_CCUSTO	= I.COD_SUB_CCUSTO',
'  AND I.COD_EMPRESA 	= :P140_COD_EMP_AVALIADO',
'  AND I.MATRICULA 		= :P140_COD_MAT_AVALIADO',
'  AND (EXISTS (SELECT 1 ',
'			    FROM AV_SOLICITACAO_RECURSO SORE',
'               WHERE SORE.COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'                 AND SORE.COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'                 AND COD_AVALIACAO = NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX)',
'                 AND COD_CICLO = NVL(:P140_COD_CICLO,:P140_COD_CICLO_AUX)) or :P140_TIPO_AVALIACAO = ''C'' );   ',
'                 ',
'                 ',
' v_SUPLENTE c_SUPLENTE%rowtype;',
'',
'begin',
'        open c_SUPLENTE;',
'        fetch c_SUPLENTE into v_SUPLENTE;',
'        close c_SUPLENTE;',
'',
'                            SELECT S.MAT_SUBS ',
'                             INTO V_MAT',
'                                FROM SUB_CCUSTO S',
'                                WHERE S.COD_SUB_CCUSTO = v_SUPLENTE.COD_SUB_CCUSTO_SUPERIOR',
'                                 AND S.COD_CCUSTO = v_SUPLENTE.COD_CCUSTO',
'                                 AND S.COD_EMPRESA = v_SUPLENTE.COD_EMPRESA;',
'                                 ',
'                                 ',
'                            SELECT S.COD_EMP_SUBS',
'                             INTO V_EMPRESA',
'                                FROM SUB_CCUSTO S',
'                                WHERE S.COD_SUB_CCUSTO = v_SUPLENTE.COD_SUB_CCUSTO_SUPERIOR',
'                                 AND S.COD_CCUSTO = v_SUPLENTE.COD_CCUSTO',
'                                 AND S.COD_EMPRESA = v_SUPLENTE.COD_EMPRESA;',
'',
'        IF V_MAT = :P_MATRICULA_USER AND V_EMPRESA = :P_EMPRESA_USER   THEN ',
'          RETURN TRUE;',
'        ELSE ',
'          RETURN FALSE;',
'        END IF;',
'',
'     EXCEPTION WHEN ',
'         NO_DATA_FOUND',
'             THEN',
'         RETURN NULL;    ',
'END;*/',
'',
':P140_COD_EMP_AVALIADOR := :P_EMPRESA_USER;',
':P140_COD_MAT_AVALIADOR := :P_MATRICULA_USER;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31357935792939992281)
,p_name=>'SET SUPLENTE'
,p_event_sequence=>770
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31357935974647992282)
,p_event_id=>wwv_flow_api.id(31357935792939992281)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*Server-side Condition',
'',
'',
'DECLARE',
'V_MAT informacoes_funcionais.matricula%type;',
'V_EMPRESA NUMBER (5);',
'',
'cursor c_SUPLENTE is',
'    SELECT S.COD_CCUSTO',
'     ,     S.COD_EMPRESA ',
'     ,     S.COD_SUB_CCUSTO',
'    FROM INFORMACOES_FUNCIONAIS_CAD I',
'       , SUB_CCUSTO S',
'    WHERE S.COD_EMPRESA 	= I.COD_EMPRESA',
'      AND S.COD_CCUSTO 		= I.COD_CCUSTO',
'      AND S.COD_SUB_CCUSTO 	= I.COD_SUB_CCUSTO',
'      and i.cod_empresa 	= :P140_COD_EMP_AVALIADO',
'      and i.matricula 		= :P140_COD_MAT_AVALIADO',
'      AND (EXISTS (SELECT 1 ',
'		    	    FROM AV_SOLICITACAO_RECURSO SORE',
'                   WHERE SORE.COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'                     AND SORE.COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'                     AND COD_AVALIACAO = NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX)',
'                     AND COD_CICLO = NVL(:P140_COD_CICLO,:P140_COD_CICLO_AUX)) or :P140_TIPO_AVALIACAO = ''C'' );  ',
'   ',
' v_SUPLENTE c_SUPLENTE%rowtype;',
'',
'begin',
'        open c_SUPLENTE;',
'        fetch c_SUPLENTE into v_SUPLENTE;',
'        close c_SUPLENTE;',
'',
'                            SELECT S.MAT_SUBS ',
'                             INTO V_MAT',
'                                FROM SUB_CCUSTO S',
'                                WHERE S.COD_SUB_CCUSTO = v_SUPLENTE.COD_SUB_CCUSTO',
'                                 AND S.COD_CCUSTO = v_SUPLENTE.COD_CCUSTO',
'                                 AND S.COD_EMPRESA = v_SUPLENTE.COD_EMPRESA;',
'                                 ',
'                                 ',
'                            SELECT S.COD_EMP_SUBS',
'                             INTO V_EMPRESA',
'                                FROM SUB_CCUSTO S',
'                                WHERE S.COD_SUB_CCUSTO = v_SUPLENTE.COD_SUB_CCUSTO',
'                                 AND S.COD_CCUSTO = v_SUPLENTE.COD_CCUSTO',
'                                 AND S.COD_EMPRESA = v_SUPLENTE.COD_EMPRESA;',
'',
'        IF V_MAT = :P_MATRICULA_USER AND V_EMPRESA = :P_EMPRESA_USER  THEN ',
'          RETURN TRUE;     ',
'        ELSE ',
'          RETURN FALSE;',
'        END IF;',
'     ',
'     EXCEPTION WHEN ',
'         NO_DATA_FOUND',
'             THEN',
'         RETURN NULL;    ',
'     ',
'END;',
'         ',
'         */',
'',
':P140_COD_EMP_AVALIADOR := :P_EMPRESA_USER;',
':P140_COD_MAT_AVALIADOR := :P_MATRICULA_USER;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31357936936561992292)
,p_name=>'SET SUPLENTE_CENTRO'
,p_event_sequence=>780
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31357937091210992293)
,p_event_id=>wwv_flow_api.id(31357936936561992292)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*Server-side Condition',
'',
'DECLARE',
'V_MAT informacoes_funcionais.matricula%type;',
'V_EMPRESA NUMBER (5);',
'',
'cursor c_SUPLENTE is',
'SELECT C.COD',
'  ,    C.COD_EMPRESA ',
'FROM INFORMACOES_FUNCIONAIS_CAD I',
'  ,  CENTRO_DE_CUSTO C',
'WHERE C.COD_EMPRESA = I.COD_EMPRESA',
'  AND C.COD = I.COD_CCUSTO',
'  AND I.COD_EMPRESA = :P140_COD_EMP_AVALIADO',
'  AND I.MATRICULA = :P140_COD_MAT_AVALIADO',
'  AND (NOT EXISTS (SELECT   1',
'                     FROM INFORMACOES_FUNCIONAIS_CAD I',
'                     ,    SUB_CCUSTO S',
'                     WHERE S.COD_EMPRESA 	= I.COD_EMPRESA',
'                     AND S.COD_CCUSTO 		= I.COD_CCUSTO',
'                     AND S.COD_SUB_CCUSTO 	= I.COD_SUB_CCUSTO',
'                     AND I.COD_EMPRESA 		= :P140_COD_EMP_AVALIADO',
'                     AND I.MATRICULA 		= :P140_COD_MAT_AVALIADO)',
'        OR  EXISTS (SELECT 1',
unistr('                      FROM AV_SOLICITACAO_RECURSO --TRATAMENTO FEITO PARA BUSCAR SOMENTE DADOS DO CENTRO DE CUSTO QUANDO FOR CONCENSO OU N\00C3O ESTIVER MATRICULA NO SUB_CCUSTO;'),
'                      WHERE COD_EMP_AVALIADO= :P140_COD_EMP_AVALIADO',
'                      AND COD_MAT_AVALIADO  = :P140_COD_MAT_AVALIADO',
'                      AND COD_AVALIACAO 	= :P140_COD_AVALIACAO',
'                      AND COD_CICLO 		= :P140_COD_CICLO) ',
'       OR :P140_TIPO_AVALIACAO = ''C'');',
'       ',
'       ',
'SELECT   C.COD,C.COD_EMPRESA ',
'  FROM INFORMACOES_FUNCIONAIS_CAD I,',
'       CENTRO_DE_CUSTO C',
' WHERE C.COD_EMPRESA = I.COD_EMPRESA',
'    AND C.COD = I.COD_CCUSTO',
'   and i.cod_empresa = :P140_COD_EMP_AVALIADO',
'   and i.matricula = :P140_COD_MAT_AVALIADO;',
'   ',
' v_SUPLENTE c_SUPLENTE%rowtype;',
'',
'begin',
'        open c_SUPLENTE;',
'        fetch c_SUPLENTE into v_SUPLENTE;',
'        close c_SUPLENTE;',
'',
'                            SELECT C.MATRICULA_SUPLENTE ',
'                             INTO V_MAT',
'                                FROM CENTRO_DE_CUSTO C',
'                                WHERE C.COD = v_SUPLENTE.COD',
'                                 AND C.COD_EMPRESA = v_SUPLENTE.COD_EMPRESA;',
'                                 ',
'                            SELECT C.COD_EMP_SUPLENTE',
'                             INTO V_EMPRESA',
'                                FROM CENTRO_DE_CUSTO C',
'                                WHERE C.COD = v_SUPLENTE.COD',
'                                 AND C.COD_EMPRESA = v_SUPLENTE.COD_EMPRESA;',
'',
'        IF V_MAT = :P_MATRICULA_USER AND V_EMPRESA = :P_EMPRESA_USER AND :P_PAINEL = ''PG''  THEN ',
'          RETURN TRUE;',
'        ELSE ',
'          RETURN FALSE;',
'        END IF;',
'     ',
'     EXCEPTION WHEN ',
'         NO_DATA_FOUND',
'             THEN',
'     RETURN NULL;    ',
'     ',
'END;',
'         */',
'         ',
'         ',
':P140_COD_EMP_AVALIADOR := :P_EMPRESA_USER;',
':P140_COD_MAT_AVALIADOR := :P_MATRICULA_USER;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(24631721462446749925)
,p_name=>'SET MATRICULA PAR'
,p_event_sequence=>790
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
' CURSOR C_MAT_PAR IS',
'    SELECT COD_EMP_AVALIADOR',
'         , MAT_AVALIADOR',
'         , COD_EMP_PAR',
'         , COD_MAT_PAR ',
'     FROM AV_GRUPO_AVALIACAO',
'    WHERE COD_AVALIACAO 	= :P140_COD_AVALIACAO',
'      AND COD_EMP_AVALIADO 	= :P140_COD_EMP_AVALIADO',
'      AND MAT_AVALIADO 		= :P140_COD_MAT_AVALIADO',
'      AND COD_CICLO 		= :P140_COD_CICLO',
'      AND TIPO_AVALIACAO    = ''G''',
'      and :P140_TIPO_AVALIACAO <> ''A''',
'      AND NOT EXISTS (SELECT 1',
unistr('                        FROM AV_APLICA_AVALIACOES --- avalia\00E7\00E3o n\00E3o deve sido gravada'),
'                       WHERE COD_AVALIACAO 	= :P140_COD_AVALIACAO',
'                         AND COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'                         AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'                         AND COD_CICLO = :P140_COD_CICLO);',
'               ',
'V_AVAL_PAR C_MAT_PAR%ROWTYPE;',
'',
' BEGIN',
'',
'    OPEN C_MAT_PAR;',
'     FETCH C_MAT_PAR INTO V_AVAL_PAR;',
'    CLOSE C_MAT_PAR;',
'    ',
'    IF V_AVAL_PAR.COD_EMP_AVALIADOR = :P_EMPRESA_USER AND V_AVAL_PAR.MAT_AVALIADOR = :P_MATRICULA_USER THEN ',
'      RETURN TRUE;',
'    ELSIF V_AVAL_PAR.COD_EMP_PAR = :P_EMPRESA_USER AND V_AVAL_PAR.COD_MAT_PAR = :P_MATRICULA_USER THEN ',
'      RETURN TRUE;',
'    ELSE',
'      RETURN FALSE;',
'    END IF;',
'     ',
' EXCEPTION WHEN NO_DATA_FOUND THEN',
'  RETURN FALSE;    ',
' END;',
'         '))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24631721521336749926)
,p_event_id=>wwv_flow_api.id(24631721462446749925)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P140_COD_EMP_AVALIADOR := :P_EMPRESA_USER;',
':P140_COD_MAT_AVALIADOR := :P_MATRICULA_USER;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P140_COD_EMP_AVALIADOR,P140_COD_MAT_AVALIADOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28895602870825475255)
,p_name=>'SET PDI'
,p_event_sequence=>800
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_COD_AVALIACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28895602891704475256)
,p_event_id=>wwv_flow_api.id(28895602870825475255)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'--V_PDI VARCHAR2(1);',
'',
'BEGIN',
'SELECT PDI ',
'INTO :P140_PDI',
'FROM AV_AVALIACOES',
'WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'',
' --:P140_PDI := V_PDI;',
'END;'))
,p_attribute_02=>'P140_COD_AVALIACAO'
,p_attribute_03=>'P140_PDI'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28825797602962554049)
,p_name=>'SET PDI_CARREGA_TELA'
,p_event_sequence=>810
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P140_COD_AVALIACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28825797740680554050)
,p_event_id=>wwv_flow_api.id(28825797602962554049)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'--V_PDI VARCHAR2(1);',
'',
'BEGIN',
'SELECT PDI ',
'INTO :P140_PDI',
'FROM AV_AVALIACOES',
'WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'',
' --:P140_PDI := V_PDI;',
'END;'))
,p_attribute_02=>'P140_COD_AVALIACAO'
,p_attribute_03=>'P140_PDI'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28887839784623136591)
,p_name=>'FACILITADORES'
,p_event_sequence=>820
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_ASPECTOS_FACILITADORES'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28887839787261136592)
,p_event_id=>wwv_flow_api.id(28887839784623136591)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_ASPECTOS_FACILITADORES_AUX := :P140_ASPECTOS_FACILITADORES;'
,p_attribute_02=>'P140_ASPECTOS_FACILITADORES'
,p_attribute_03=>'P140_ASPECTOS_FACILITADORES_AUX'
,p_attribute_04=>'N'
,p_stop_execution_on_error=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28887840435136136598)
,p_name=>'FORTES'
,p_event_sequence=>830
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PONTOS_FORTES'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28887840536774136599)
,p_event_id=>wwv_flow_api.id(28887840435136136598)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_PONTOS_FORTES_AUX := :P140_PONTOS_FORTES;'
,p_attribute_02=>'P140_PONTOS_FORTES'
,p_attribute_03=>'P140_PONTOS_FORTES_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28887840643272136600)
,p_name=>'DIFICULTADORES'
,p_event_sequence=>840
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_ASPECTOS_DIFICULTADORES'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28887840702912136601)
,p_event_id=>wwv_flow_api.id(28887840643272136600)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_ASPECTOS_DIFICULTADORES_AUX := :P140_ASPECTOS_DIFICULTADORES;'
,p_attribute_02=>'P140_ASPECTOS_DIFICULTADORES'
,p_attribute_03=>'P140_ASPECTOS_DIFICULTADORES_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28887840878851136602)
,p_name=>'FRACOS'
,p_event_sequence=>850
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PONTOS_FRACOS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28887840967142136603)
,p_event_id=>wwv_flow_api.id(28887840878851136602)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_PONTOS_FRACOS_AUX := :P140_PONTOS_FRACOS;'
,p_attribute_02=>'P140_PONTOS_FRACOS'
,p_attribute_03=>'P140_PONTOS_FRACOS_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28897464330253363554)
,p_name=>'EXTERNOS'
,p_event_sequence=>860
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_FATORES_EXTERNOS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28897464391003363555)
,p_event_id=>wwv_flow_api.id(28897464330253363554)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_FATORES_EXTERNOS_AUX := :P140_FATORES_EXTERNOS;'
,p_attribute_02=>'P140_FATORES_EXTERNOS'
,p_attribute_03=>'P140_FATORES_EXTERNOS_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28897464569656363556)
,p_name=>unistr('PLANO DE A\00C7\00C3O')
,p_event_sequence=>870
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_PLANO_ACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28897464622924363557)
,p_event_id=>wwv_flow_api.id(28897464569656363556)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P140_PLANO_ACAO_AUX := :P140_PLANO_ACAO;'
,p_attribute_02=>'P140_PLANO_ACAO'
,p_attribute_03=>'P140_PLANO_ACAO_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(24786894174620300111)
,p_name=>'Oculta Rejeitar'
,p_event_sequence=>880
,p_condition_element=>'P140_IND_AVAL_EXPER'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(24786894342149300112)
,p_event_id=>wwv_flow_api.id(24786894174620300111)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(55506748380303125258)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(23937962195871500625)
,p_name=>'Novo'
,p_event_sequence=>900
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P140_IND_AVAL_EXPER'
,p_condition_element=>'P140_IND_AVAL_EXPER'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(23937962334700500626)
,p_event_id=>wwv_flow_api.id(23937962195871500625)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_PRIMEIRO_PERIODO,P140_SEGUNDO_PERIODO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(23937962403204500627)
,p_event_id=>wwv_flow_api.id(23937962195871500625)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P140_PRIMEIRO_PERIODO,P140_SEGUNDO_PERIODO'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320765800835011694)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
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
'       I.FILIAL||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) filial,',
'       funcao||'' - ''||initcap(fnct_nome_funcao(i.cargo,i.funcao)) funcao,',
'       initcap(e.descricao) formacao,',
'       initcap(r.nome) instrucao,',
'       I.data_contrato_prz_determinado PRIMEIRO_PERIODO,',
'       I.prorrog_contrato_prz_determ SEGUNDO_PERIODO ',
'  from informacoes_funcionais_cad i, inf_pessoais_cad p, instrucao r, formacao_escolar e',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and p.instrucao = r.cod (+)',
'   and p.cod_formacao_escolar = e.cod_formacao_escolar (+)',
'   and i.cod_empresa = :p140_cod_emp_avaliado',
'   and i.matricula = :p140_cod_mat_avaliado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
':P140_OK := ''S'';',
'',
'if nvl(:p140_ind_omite_avaliador,''N'') = ''N'' then',
':p140_avaliador := :p140_COD_EMP_AVALIADOR||'' / ''||:p140_COD_MAT_AVALIADOR||'' - ''||iNITCAP(fnct_nome_func(:p140_COD_EMP_AVALIADOR, :p140_COD_MAT_AVALIADOR));',
'else',
':p140_avaliador := null;',
'end if;',
'',
'if nvl(:p140_ind_omite_avaliado,''N'') = ''N'' then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p140_cod_empresa_display := v_c1.empresa;',
':p140_filial_display := v_c1.filial;',
':p140_matricula_display := v_c1.matricula;',
':p140_situacao_colab := v_c1.situacao;',
':p140_dt_admissao := v_c1.dt_admissao;',
':p140_funcao := v_c1.funcao;',
':p140_formacao := v_c1.formacao;',
':p140_instrucao := v_c1.instrucao;',
':P140_PRIMEIRO_PERIODO := v_c1.PRIMEIRO_PERIODO;',
':P140_SEGUNDO_PERIODO := v_c1.SEGUNDO_PERIODO;',
'',
'',
'else',
'',
':p140_cod_empresa_display := null;',
':p140_filial_display := null;',
':p140_matricula_display := null;',
':p140_situacao_colab := null;',
':p140_dt_admissao := null;',
':p140_funcao := null;',
':p140_formacao := null;',
':p140_instrucao := null;',
':P140_PRIMEIRO_PERIODO :=  null;',
':P140_SEGUNDO_PERIODO :=  null;',
'',
'end if;',
'',
'',
'if :p140_rowid is null then',
':P140_DATA_AVALIACAO := sysdate;',
'end if;',
'',
'',
'IF :P140_COD_AVALIACAO IS NOT NULL THEN',
'',
'   BEGIN',
'   ',
'   SELECT NVL(IND_AVAL_EXPER,''N'') IND_AVAL_EXPER',
'     INTO :P140_IND_AVAL_EXPER ',
'     FROM AV_AVALIACOES',
'    WHERE COD_AVALIACAO = NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX);',
'    EXCEPTION',
unistr('    -- Caso ocorra qualquer exce\00E7\00E3o, define :P140_IND_AVAL_EXPER como ''N'''),
'    WHEN NO_DATA_FOUND THEN',
'        :P140_IND_AVAL_EXPER := ''N'';',
'    WHEN OTHERS THEN',
unistr('        -- Trata outras exce\00E7\00F5es, caso necess\00E1rio'),
'        :P140_IND_AVAL_EXPER := ''N'';',
'	END;	',
'END IF;',
'',
'',
'',
'',
'exception',
'when others then',
'null;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320765007592011693)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sequencia'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    if :p140_seq is null then',
'    :p140_seq := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'    end if;',
'    ',
'',
'    :P140_ROWID := REPLACE(REPLACE(:P140_ROWID,''%2B'',''+''),''%252F'',''/'');',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320765366218011694)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch (s/ ROWID)'
,p_attribute_02=>'AV_APLICA_AVALIACOES'
,p_attribute_03=>'P140_COD_AVALIACAO'
,p_attribute_04=>'COD_AVALIACAO'
,p_attribute_05=>'P140_DATA_AVALIACAO'
,p_attribute_06=>'DATA_AVALIACAO'
,p_attribute_08=>wwv_flow_string.join(wwv_flow_t_varchar2(
'COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'AND COD_MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'AND COD_EMP_AVALIADOR = :P140_COD_EMP_AVALIADOR',
'AND COD_MAT_AVALIADOR = :P140_COD_MAT_AVALIADOR',
'AND TIPO_AVALIACAO = :P140_TIPO_AVALIACAO',
'AND (:P140_COD_CICLO IS NULL OR COD_CICLO = :P140_COD_CICLO)'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_ROWID IS NULL AND :P140_DATA_AVALIACAO IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(55506749469716125269)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch (ROWID)'
,p_attribute_02=>'AV_APLICA_AVALIACOES'
,p_attribute_03=>'P140_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P140_ROWID IS NOT NULL AND :P140_DATA_AVALIACAO IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(55506749338856125267)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ROWID'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select rowid',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and cod_mat_avaliado = :p140_cod_mat_avaliado',
'   and cod_avaliacao = :p140_cod_avaliacao',
'   and data_avaliacao = :p140_data_avaliacao',
'   and tipo_avaliacao = :p140_tipo_avaliacao',
'   and (:p140_cod_ciclo is null or cod_ciclo = :p140_cod_ciclo);',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    if :p140_page_branch is null then',
'       :p140_app_branch := :app_id;',
'       :p140_page_branch := 29;',
'    end if;',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.rowid is not null then',
'        :p140_cod_emp_avaliador := null;',
'        :p140_cod_mat_avaliador := null;',
'        :p140_rowid := v_c1.rowid;',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320766163999011695)
,p_process_sequence=>80
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'    select DISTINCT initcap(a.descricao) descricao',
'      from av_avaliacoes a',
'     where a.cod_avaliacao = :p140_cod_avaliacao;',
'     ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    if :p140_page_branch is null then',
'       :p140_app_branch := :app_id;',
'       :p140_page_branch := 29;',
'    end if;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.descricao is null then',
unistr(':P140_TITULO_AVALIACAO := ''Avalia\00E7\00E3o'';'),
'else',
':P140_TITULO_AVALIACAO := v_c1.descricao;',
'end if;',
'',
'if :p140_rowid is null then',
'',
'    if :p140_cod_mat_avaliador is null then',
'    :p140_cod_emp_avaliador := ''teste'';--:P_EMPRESA_USER;',
'    :p140_cod_mat_avaliador := 1212; --:P_MATRICULA_USER;',
'    end if;',
'    ',
'    :p140_data_avaliacao := sysdate;',
'',
'end if;',
'',
'if :p140_rowid is null and :p140_cod_avaliacao is not null then',
'    IF :P140_COD_MAT_AVALIADO IS NOT NULL THEN',
'    :P140_COD_EMP_AVALIADO_AUX := :P140_COD_EMP_AVALIADO;',
'    :P140_COD_MAT_AVALIADO_AUX := :P140_COD_MAT_AVALIADO;',
'    END IF;',
'begin',
'prc_avaliacao_temp (:p140_cod_avaliacao, ',
'                    :p140_cod_emp_avaliador, ',
'                    :p140_cod_mat_avaliador, ',
'                    :P_EMPRESA_USER, ',
'                    :P_MATRICULA_USER, ',
'                    :p_usuario, ',
'                    :p140_seq,',
'                    :p_painel);',
'end;',
'end if;',
'',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(53709830494657972103)
,p_process_sequence=>90
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ROWID_RECURSO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select a.ROWID',
'  from AV_SOLICITACAO_RECURSO a',
' where a.cod_avaliacao = :p140_cod_avaliacao',
'   and a.cod_emp_avaliado = :p140_cod_emp_avaliado',
'   and a.cod_mat_avaliado = :p140_cod_mat_avaliado',
'  -- and a.cod_emp_avaliador = :p140_cod_emp_avaliador',
'  -- and a.cod_mat_avaliador = :p140_cod_mat_avaliador',
'   and a.cod_ciclo = :p140_cod_ciclo;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p140_rowid_recurso := v_c1.rowid;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(53709833226660972131)
,p_process_sequence=>100
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Permite Consultar'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  cursor c1 is',
'    SELECT IND_CONSULTA_AVALIADO_CICLO, nvl(IND_AUTOAVALIACAO,''N'') ind_autoavaliacao, IND_OMITE_AVALIADO, IND_OMITE_AVALIADOR',
'      FROM AV_AVALIACOES',
'     WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'',
'   V_C1 C1%ROWTYPE;',
'',
'  V_DUMMY NUMBER := 0;',
'  ',
'  cursor c2 is',
'    select ''S'' EXISTE -- Se existe avaliacao Gestor / Consenso a ser realizada',
'      from AV_GRUPO_AVALIACAO x',
'     where x.cod_avaliacao = NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX)',
'      and x.cod_ciclo = NVL(:P140_COD_CICLO,:P140_COD_CICLO_AUX)',
'      and x.cod_emp_avaliado = :P140_COD_EMP_AVALIADO',
'      and x.mat_avaliado = :P140_COD_MAT_AVALIADO',
'      and x.mat_avaliado <> x.mat_avaliador;',
'      ',
'    v_c2 c2%rowtype;',
'  ',
'  CURSOR C3 (V_TIPO VARCHAR2) IS',
'    select ''S'' EXISTE',
'      from AV_APLICA_AVALIACOES a ',
'     where a.cod_avaliacao =  NVL(:P140_COD_AVALIACAO,:P140_COD_AVALIACAO_AUX)',
'       and a.cod_emp_avaliado = :P140_COD_EMP_AVALIADO',
'       and a.cod_mat_avaliado = :P140_COD_MAT_AVALIADO',
'       and a.tipo_avaliacao = V_TIPO',
'       and a.cod_ciclo = NVL(:P140_COD_CICLO,:P140_COD_CICLO_AUX);',
'  ',
'    v_c3 c3%rowtype;',
'    ',
'    ',
'    CURSOR C_MAT_PAR IS',
'        SELECT ''S'' EXISTE',
'        FROM AV_GRUPO_AVALIACAO GA',
'        WHERE COD_AVALIACAO = :P140_COD_AVALIACAO',
'        AND COD_EMP_AVALIADO = :P140_COD_EMP_AVALIADO',
'        AND MAT_AVALIADO = :P140_COD_MAT_AVALIADO',
'        and (COD_EMP_AVALIADOR = :P_EMPRESA_USER and MAT_AVALIADOR = :P_MATRICULA_USER or COD_EMP_PAR = :P_EMPRESA_USER and COD_MAT_PAR = :P_MATRICULA_USER)',
'        AND COD_CICLO = :P140_COD_CICLO;',
'  ',
'      v_c4 C_MAT_PAR%rowtype;',
'  ',
'BEGIN',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  open C_MAT_PAR;',
'  fetch C_MAT_PAR into v_c4;',
'  close C_MAT_PAR;',
'',
'',
'',
'',
'  :P140_IND_AUTOAVALIACAO := V_C1.IND_AUTOAVALIACAO;',
'  ',
'  :P140_IND_OMITE_AVALIADO := V_C1.IND_OMITE_AVALIADO;',
'  ',
'  :P140_IND_OMITE_AVALIADOR := V_C1.IND_OMITE_AVALIADOR;',
'    --',
'    if V_C1.IND_OMITE_AVALIADO = ''S'' then',
unistr('    :P140_AVISO := ''Os dados do colaborador est\00E3o ocultos para esta avalia\00E7\00E3o, n\00E3o sendo identificavel.'';'),
'    end if;',
'    ',
'  BEGIN',
'    --',
'       SELECT 1',
'         INTO V_DUMMY',
'         FROM AV_AVALIACOES',
'     WHERE trunc(SYSDATE) BETWEEN trunc(DT_INICIO) AND trunc(DT_FIM)',
'       AND COD_AVALIACAO = :P140_COD_AVALIACAO;',
'  --',
'  EXCEPTION',
'    --',
'    WHEN NO_DATA_FOUND THEN',
'      --',
'      V_DUMMY := 0;',
'  --',
'  END;',
'',
'  IF V_DUMMY = 1 AND :P140_COD_MAT_AVALIADO = :P_MATRICULA_USER and :P140_COD_MAT_AVALIADO <> :p140_cod_mat_avaliador THEN',
'      open c1;',
'      fetch c1 into v_c1;',
'      close c1;',
'      ',
'      if nvl(v_c1.IND_CONSULTA_AVALIADO_CICLO,''N'') = ''N'' then',
'         :p140_permite_consultar := ''N'';',
'      else',
'        if ((:p140_cod_emp_avaliado = :p140_cod_emp_avaliador and ',
'             :p140_cod_mat_avaliado = :p140_cod_mat_avaliador) or ',
'            (:p140_cod_emp_avaliado_aux = :p140_cod_emp_avaliador and ',
'             :p140_cod_mat_avaliado_aux = :p140_cod_mat_avaliador))',
'        and v_c1.ind_autoavaliacao = ''N'' then',
'           :p140_permite_consultar := ''N'';',
'        else',
'           :p140_permite_consultar := ''S'';',
'        end if;',
'      end if;',
'  else',
'        if ((:p140_cod_emp_avaliado = :p140_cod_emp_avaliador and ',
'             :p140_cod_mat_avaliado = :p140_cod_mat_avaliador) or ',
'            (:p140_cod_emp_avaliado_aux = :p140_cod_emp_avaliador and ',
'             :p140_cod_mat_avaliado_aux = :p140_cod_mat_avaliador))',
'        and v_c1.ind_autoavaliacao = ''N'' then',
'           :p140_permite_consultar := ''N'';',
'        else',
'           :p140_permite_consultar := ''S'';',
'        end if;',
'  END IF;',
'  ',
'  --',
'  if :p_painel = ''PG'' and v_dummy = 1 and ((:p140_tipo_avaliacao = ''A'') or ',
'                          ((:p140_cod_emp_avaliado = :p140_cod_emp_avaliador and ',
'                            :p140_cod_mat_avaliado = :p140_cod_mat_avaliador) or ',
'                           (:p140_cod_emp_avaliado_aux = :p140_cod_emp_avaliador and ',
'                            :p140_cod_mat_avaliado_aux = :p140_cod_mat_avaliador))) then',
'  ',
'    open c2;',
'    fetch c2 into v_c2;',
'    close c2;',
'  ',
'    if nvl(v_c2.existe,''N'') = ''S'' then',
'',
'        open c3(''G'');',
'        fetch c3 into v_c3;',
'        close c3;',
'        ',
'        if NVL(v_c3.EXISTE,''N'') = ''N'' and :p140_rowid is not null then',
'           :p140_permite_consultar := ''N'';',
'        else ',
'           :p140_permite_consultar := ''S'';',
'        end if;',
'',
'    end if;',
'  ',
'  end if;',
'  --',
'  ',
'  if NVL(v_c4.EXISTE,''N'') = ''S'' and :p140_rowid is not null then',
'  :p140_permite_consultar := ''S'';',
'end if;',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(53709833690611972135)
,p_process_sequence=>110
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Oculta Analise'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE -- Tratamento feito por Felipe em 10/12/2012 --',
'	CURSOR F2 IS',
'	SELECT OCULTA_ANALISE',
'	  FROM AV_AVALIACOES',
'	 WHERE COD_AVALIACAO = :P140_COD_AVALIACAO;',
'	 V_F2 F2%ROWTYPE;',
'',
'',
'BEGIN',
'',
'	OPEN F2;',
'	FETCH F2 INTO V_F2;',
'	CLOSE F2;',
'',
':p140_OCULTA_ANALISE := v_f2.OCULTA_ANALISE;',
'',
'END; -- Tratamento feito por Felipe em 10/12/2012 --'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(35746046410830201842)
,p_process_sequence=>120
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Apagar Avalia\00E7\00E3o Incompleta')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_mat_avaliado',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = nvl(:p140_cod_emp_avaliado,:p140_cod_emp_avaliado_aux)',
'   and cod_mat_avaliado = nvl(:p140_cod_mat_avaliado,:p140_cod_mat_avaliado_aux)',
'   and cod_avaliacao = NVL(:p140_cod_avaliacao,:p140_cod_avaliacao_aux)',
'   and cod_ciclo = nvl(:p140_cod_ciclo_aux,:p140_cod_ciclo)',
'   and tipo_avaliacao = nvl(:p140_tipo_avaliacao,:p140_tipo_avaliacao_aux);',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'insert into testex values (140,''#01 ''||nvl(:p140_cod_emp_avaliado,:p140_cod_emp_avaliado_aux)||'',''||',
'                                       nvl(:p140_cod_mat_avaliado,:p140_cod_mat_avaliado_aux)||'',''||',
'                                       NVL(:p140_cod_avaliacao,:p140_cod_avaliacao_aux)||'',''||',
'                                       nvl(:p140_cod_ciclo_aux,:p140_cod_ciclo)||'',''||',
'                                       nvl(:p140_tipo_avaliacao,:p140_tipo_avaliacao_aux)||'',''||',
'                                       :P140_COD_EMP_AVALIADOR||'',''||',
'                                       :P140_COD_MAT_AVALIADOR',
'                                      );',
'IF :P140_ROWID IS NULL and nvl(:p140_cod_ciclo_aux,:p140_cod_ciclo) is not null THEN',
'insert into testex values (140,''#02'');',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_mat_avaliado is null then',
'insert into testex values (140,''#03'');',
'begin',
'',
'delete from Av_Aplica_Avaliacoes_Itens',
'where cod_emp_avaliado = nvl(:P140_COD_EMP_AVALIADO,:p140_cod_emp_avaliado_aux)',
'and cod_mat_avaliado = nvl(:P140_COD_MAT_AVALIADO,:p140_cod_mat_avaliado_aux)',
'and cod_emp_avaliador = :P140_COD_EMP_AVALIADOR',
'and cod_mat_avaliador = :P140_COD_MAT_AVALIADOR',
'and cod_avaliacao = nvl(:P140_COD_AVALIACAO,:p140_cod_avaliacao_aux)',
'and cod_ciclo = nvl(:p140_cod_ciclo_aux,:p140_cod_ciclo)',
'and tipo_avaliacao = nvl(:P140_TIPO_AVALIACAO,:p140_tipo_avaliacao_aux);',
'',
'commit;',
'insert into testex values (140,''#04'');',
'exception',
'when no_data_found then',
'null;',
'when others then',
'null;',
'end;',
'insert into testex values (140,''#05'');',
'end if;',
'COMMIT;',
'END IF;',
'insert into testex values (140,''#06'');',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P140_ROWID'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(33296598854554891525)
,p_process_sequence=>130
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula: Resultado Parcial'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_TPA NUMBER(5,2);',
'V_TPG NUMBER(5,2);',
'V_RA NUMBER(5,2);',
'V_RG NUMBER(5,2);',
'V_NOTA NUMBER(5,2);',
'V_TPC NUMBER(5,2);',
'V_RC NUMBER(5,2);',
'',
'BEGIN',
'           ',
'BEGIN',
'SELECT PERC_PESO_AVAL_TPA ',
'        INTO V_TPA',
'    FROM AV_CICLOS',
'        WHERE COD_EMPRESA  = nvl(:P140_COD_EMP_AVALIADO_AUX,:P140_COD_EMP_AVALIADO)',
'        AND COD_AVALIACAO = NVL(:P140_COD_AVALIACAO_AUX,:P140_COD_AVALIACAO)',
'        AND COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO);',
'',
'EXCEPTION ',
'    WHEN NO_DATA_FOUND THEN NULL;',
'END;',
'',
'BEGIN',
'    SELECT PERC_PESO_AVAL_TPG ',
'            INTO V_TPG',
'        FROM AV_CICLOS',
'        WHERE COD_EMPRESA  = nvl(:P140_COD_EMP_AVALIADO_AUX,:P140_COD_EMP_AVALIADO)',
'        AND COD_AVALIACAO = NVL(:P140_COD_AVALIACAO_AUX,:P140_COD_AVALIACAO)',
'        AND COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO);',
'',
'    EXCEPTION ',
'         WHEN NO_DATA_FOUND THEN NULL;',
'END; ',
'',
'     BEGIN',
'         SELECT sum(nvl(NOTA_ITEM,0)) NOTA',
'                 INTO V_NOTA',
'             FROM  Av_Aplica_Avaliacoes_Itens',
'                 WHERE COD_EMP_AVALIADO   = nvl(:P140_COD_EMP_AVALIADO_AUX,:P140_COD_EMP_AVALIADO)',
'                 AND   COD_MAT_AVALIADO   = :P140_COD_MAT_AVALIADO',
'                 AND   COD_EMP_AVALIADOR  = :P140_COD_EMP_AVALIADOR',
'                 AND   COD_MAT_AVALIADOR  = :P140_COD_MAT_AVALIADOR',
'                 AND   COD_AVALIACAO      = NVL(:P140_COD_AVALIACAO_AUX,:P140_COD_AVALIACAO)',
'                 AND   DATA_AVALIACAO     = :P140_DATA_AVALIACAO',
'                 AND   TIPO_AVALIACAO     = NVL(:P140_TIPO_AVALIACAO_AUX,:P140_TIPO_AVALIACAO);        ',
'',
'        EXCEPTION ',
'             WHEN NO_DATA_FOUND THEN NULL;',
'     END;  ',
'',
'BEGIN',
'SELECT PERC_PESO_AVAL_TPC ',
'        INTO V_TPC',
'    FROM AV_CICLOS',
'        WHERE COD_EMPRESA  = nvl(:P140_COD_EMP_AVALIADO_AUX,:P140_COD_EMP_AVALIADO)',
'        AND COD_AVALIACAO = NVL(:P140_COD_AVALIACAO_AUX,:P140_COD_AVALIACAO)',
'        AND COD_CICLO = NVL(:P140_COD_CICLO_AUX,:P140_COD_CICLO);',
'',
'EXCEPTION ',
'    WHEN NO_DATA_FOUND THEN NULL;',
'END;',
'',
'    IF NVL(:P140_TIPO_AVALIACAO_AUX,:P140_TIPO_AVALIACAO) = ''A'' AND V_TPA IS NOT NULL',
'    THEN ',
'    SELECT (V_NOTA * V_TPA)/100 RESULTADO ',
'            INTO V_RA',
'        FROM DUAL;',
'    ELSIF NVL(:P140_TIPO_AVALIACAO_AUX,:P140_TIPO_AVALIACAO) = ''G'' AND V_TPG IS NOT NULL',
'        THEN',
'        SELECT (V_NOTA * V_TPG)/100 RESULTADO2 ',
'                INTO V_RG',
'            FROM DUAL;',
'	ELSIF NVL(:P140_TIPO_AVALIACAO_AUX,:P140_TIPO_AVALIACAO) = ''C'' AND V_TPC IS NOT NULL',
'        THEN',
'        SELECT (V_NOTA * V_TPC)/100 RESULTADO3 ',
'                INTO V_RC',
'            FROM DUAL;		',
'    END IF;',
'',
'    IF V_RA IS NOT NULL --AND V_RG IS NULL',
'        THEN ',
'        :P140_RESULTADO_PARCIAL := V_RA ;',
'       -- RETURN V_RA;',
'    ELSIF V_RG IS NOT NULL --AND V_RA IS NULL',
'        THEN',
'        :P140_RESULTADO_PARCIAL := V_RG;',
'       -- RETURN V_RG;',
'	ELSIF V_RC IS NOT NULL --AND V_RA IS NULL',
'        THEN',
'        :P140_RESULTADO_PARCIAL := V_RC;   ',
'    ELSE',
'        :P140_RESULTADO_PARCIAL := V_NOTA;',
'       -- RETURN V_NOTA;',
'    END IF;	',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P140_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(33393403245254806390)
,p_process_sequence=>140
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Aux'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p140_cod_ciclo is null and :p140_cod_ciclo_aux is not null then',
':p140_cod_ciclo := :p140_cod_ciclo_aux;',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(55506746270397125237)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_lov_display'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  type t_lov is record (f_display varchar2(4000), f_return varchar2(4000));',
'  l_sql apex_application_page_items.lov_definition%type;',
'  l_cur sys_refcursor;',
'  l_lov t_lov;',
'begin',
'  if apex_application.g_x02 is not null then',
'    select lov_definition',
'      into l_sql',
'      from apex_application_page_items t',
'     where application_id  = :app_id',
'       and page_id         = :app_page_id',
'       and display_as_code in (''NATIVE_POPUP_LOV'',''NATIVE_SELECT_LIST'',''PLUGIN_BE.CTB.SELECT2'')',
'       and item_name       = apex_application.g_x01;',
'',
'    open l_cur for l_sql;',
'    loop',
'      exit when l_cur%notfound or l_lov.f_return = apex_application.g_x02;',
'      fetch l_cur into l_lov;',
'    end loop;',
'    close l_cur;',
'',
'    htp.prn(l_lov.f_display);',
'  else',
'    htp.prn('''');',
'  end if;',
'exception when others then',
'  htp.prn('''');',
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
