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
,p_default_application_id=>2942
,p_default_id_offset=>722933175033509773
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2942 - Segurança do Trabalho - CIPA
--
-- Application Export:
--   Application:     2942
--   Name:            Segurança do Trabalho - CIPA
--   Date and Time:   15:16 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 34
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00034
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>34);
end;
/
prompt --application/pages/page_00034
begin
wwv_flow_api.create_page(
 p_id=>34
,p_user_interface_id=>wwv_flow_api.id(34486131585327022107)
,p_name=>unistr('Lista de Candidatos: Vota\00E7\00E3o')
,p_step_title=>unistr('Lista de Candidatos: Vota\00E7\00E3o')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Cipa.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Cipa.css'
,p_javascript_code=>'var appItemPainelVal = ''&P_PAINEL.'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (appItemPainelVal == ''PC''){',
'    $(''#t_Header'').addClass(''hide'');',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Cipa.css / Natcorp_Cipa.js) - o mesmo nas paginas 34 e 35',
'',
'Para o colaborador no celular: na 34, o que e a eleicao e como votar em 3 passos, o cartao "Quer ser candidato?"',
'com o botao Inscrever-se original (so quando ele aparece), e cada candidato como um cartao grande (iniciais, nome,',
'apelido, cargo, setor, unidade e "Votar"); o toque e o clique no link original. Na 35, o cartao de quem recebe o',
'voto, a pergunta e os botoes originais; "Voto ja realizado" e o periodo de votacao viram telas proprias.',
'Nada e gravado pelo desenho: link, botoes, processos, condicoes e acoes dinamicas continuam. Para desligar: tire as',
'duas URLs de arquivo. Guia: brand/apex/app/CIPA-MANUTENCAO.md.'))
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260806125719'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(14114294634663340237)
,p_name=>unistr('Candidatos Inscritos: Clique no nome do candidato escolhido para efetuar sua vota\00E7\00E3o.')
,p_template=>wwv_flow_api.id(34486105588489022013)
,p_display_sequence=>20
,p_icon_css_classes=>'fa-users'
,p_region_template_options=>'#DEFAULT#:t-Region--showIcon:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--stack'
,p_grid_column_span=>8
,p_display_column=>3
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       UPPER(P.NOME)||decode(I.NOME_DE_GUERRA, NULL, '''', '' (APELIDO: ''||I.NOME_DE_GUERRA||'')'')||decode(P.NOME_SOCIAL, NULL, '''', '' (NOME SOCIAL: ''||P.NOME_SOCIAL||'')'') list_title,',
'       ''<br><br>Empresa <b>''||UPPER(FNCT_NOME_EMPRESA(CC.COD_EMPRESA,''S''))||''</b><br>''||',
'       ''<br>Filial <b>''||UPPER(FNCT_NOME_FILIAL(CC.COD_EMPRESA,CC.COD_FILIAL,''S''))||''</b><br>''||',
'       ''<br>Centro de Custo <b>''||UPPER(FNCT_NOME_CCUSTO(I.COD_EMPRESA, I.COD_CCUSTO))||''</b><br>''||',
'       ''<br>Cargo <b>''||UPPER(CR.NOME)||''</b><br>'' list_text,',
'       ''colorStatusBlue'' icon_color_class,',
'       ''fa fa-user'' icon_class,',
'        apex_page.get_url (',
'            p_page        => 35,',
'            p_items       => ''P35_COD_EMPRESA,P35_COD_FILIAL,P35_COD_CIPA,P35_CAND_COD_EMPRESA,P35_CAND_MATRICULA'',',
'            p_values      => cc.cod_empresa||'',''||cc.cod_filial||'',''||cc.cod_cipa||'',''||i.cod_empresa||'',''||i.matricula,',
'            p_clear_cache => 35',
'            ) link',
'--CC.ROWID,',
'      -- CC.COD_EMPRESA||'' - ''||UPPER(FNCT_NOME_EMPRESA(CC.COD_EMPRESA,''S'')) EMPRESA,',
'      -- CC.COD_FILIAL||'' - ''||UPPER(FNCT_NOME_FILIAL(CC.COD_EMPRESA,CC.COD_FILIAL,''S'')) FILIAL,',
'     --  CC.COD_CIPA||'' - ''||UPPER(C.DESCR_CIPA) CIPA,',
'     --  C.DT_INI_CIPA,',
'     --  C.DT_FIN_CIPA,',
'     --  CC.CAND_COD_EMPRESA||'' - ''||UPPER(FNCT_NOME_EMPRESA(CC.CAND_COD_EMPRESA,''S'')) EMPRESA_CANIDATO,',
'     --  CC.CAND_MATRICULA||'' - ''||UPPER(FNCT_NOME_FUNC(CC.CAND_COD_EMPRESA,CC.CAND_MATRICULA)) CANDIDATO,',
'      -- I.COD_CCUSTO||'' - ''||UPPER(FNCT_NOME_CCUSTO(I.COD_EMPRESA, I.COD_CCUSTO)) CENTRO_DE_CUSTO,',
'       --CC.DT_CANDIDATURA,',
'      -- case when CC.ELEITO in (''P'',''N'') then null else ''SIM'' END eleito,',
unistr('      -- decode(CC.DESISTENTE,''S'',''SIM'',''N'',''N\00C3O'') desistente,'),
'      /*',
'       (select nvl(count(1),0)',
'          from cipa_candidatos_votos cx',
'         where cx.cod_cipa = cc.cod_cipa',
'           and cx.cod_empresa = cc.cod_empresa',
'           and cx.cod_filial = cc.cod_filial',
'           and cx.cand_cod_empresa = cc.cand_cod_empresa',
'           and cx.cand_matricula = cc.cand_matricula) qtd_votos*/',
'  from CIPA_CANDIDATOS CC,',
'       CIPA C,',
'       INFORMACOES_FUNCIONAIS_CAD I,',
'       INF_PESSOAIS_CAD P,',
'       CARGOS CR,',
'       CONSTITUICAO_CIPA CP',
' where CC.COD_CIPA = C.COD_CIPA',
'   and CC.CAND_COD_EMPRESA = I.COD_EMPRESA',
'   and CC.CAND_COD_EMPRESA = P.COD_EMPRESA',
'   and CC.CAND_MATRICULA = I.MATRICULA',
'   AND CC.CAND_MATRICULA = P.MATRICULA',
'   AND I.CARGO = CR.COD',
'   AND CP.COD_CIPA = C.COD_CIPA',
'   AND (:P_PAINEL = ''PC'' AND CP.COD_FILIAL IN (SELECT X.FILIAL',
'                                                 FROM INFORMACOES_FUNCIONAIS_CAD X',
'                                                WHERE X.COD_EMPRESA = :P_EMPRESA_USER',
'                                                  AND X.MATRICULA = :P_MATRICULA_USER))',
'   and (:P34_COD_CIPA     is null or CC.COD_CIPA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_COD_CIPA, '':'')) t))',
'   and (:P34_COD_EMPRESA     is null or CC.COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_COD_EMPRESA, '':'')) t))',
'   and (:P34_FILIAL     is null or CC.COD_FILIAL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_FILIAL, '':'')) t))',
'   and (:P34_CAND_COD_EMPRESA     is null or I.COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_CAND_COD_EMPRESA, '':'')) t))',
'   and (:P34_CAND_MATRICULA     is null or I.MATRICULA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_CAND_MATRICULA, '':'')) t))',
'   and nvl(cc.desistente,''N'') <> ''S''',
'   and exists (select 1',
'                 from vw_elegiveis_cipa VW',
'                where VW.cod_empresa = :P_EMPRESA_USER',
'                  and VW.matricula = :P_MATRICULA_USER)',
' order by 1'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(18078338554756987897)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Candidato Inscrito'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(14122258430681044370)
,p_query_column_id=>1
,p_column_alias=>'LIST_TITLE'
,p_column_display_sequence=>5
,p_column_heading=>'List Title'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(14122258300166044369)
,p_query_column_id=>2
,p_column_alias=>'LIST_TEXT'
,p_column_display_sequence=>4
,p_column_heading=>'List Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(14122257964077044366)
,p_query_column_id=>3
,p_column_alias=>'ICON_COLOR_CLASS'
,p_column_display_sequence=>1
,p_column_heading=>'Icon Color Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(14122258079056044367)
,p_query_column_id=>4
,p_column_alias=>'ICON_CLASS'
,p_column_display_sequence=>2
,p_column_heading=>'Icon Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(14122258235791044368)
,p_query_column_id=>5
,p_column_alias=>'LINK'
,p_column_display_sequence=>3
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14408632218458450679)
,p_plug_name=>'Filtros'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(34486105588489022013)
,p_plug_display_sequence=>12
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14510517832990947092)
,p_plug_name=>'CIPA'
,p_icon_css_classes=>'fa-plus-circle-o'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34486104013401022010)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_source=>unistr('Confira os candidatos \00E0 elei\00E7\00E3o da CIPA. <br> Para realizar a sua inscri\00E7\00E3o clique no bot\00E3o ''Inscrever - se''.')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14114433686171383999)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(14408632218458450679)
,p_button_name=>'PESQUISAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(34486126553807022057)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14114432964525383996)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(14114294634663340237)
,p_button_name=>'INSCREVER'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34486126380087022057)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Inscrever-se'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:31:&SESSION.::&DEBUG.:31:P31_COD_CIPA,P31_COD_EMPRESA,P31_COD_FILIAL,P31_CAND_COD_EMPRESA,P31_CAND_MATRICULA:&P34_COD_CIPA.,&P_EMPRESA_USER.,&P34_FILIAL.,&P_EMPRESA_USER.,&P_MATRICULA_USER.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select *',
'      from vw_elegiveis_cipa',
'     where cod_cipa = :p34_cod_cipa',
'       and cod_filial = :p34_filial',
'       and cod_empresa = :P_EMPRESA_USER',
'       and matricula = :P_MATRICULA_USER;',
'',
'    v_c1 c1%rowtype;',
' ',
' cursor c2 is',
'    select cod_cipa',
'      from cipa_candidatos cp',
'      where cp.cod_cipa = :p34_cod_cipa',
'      and cp.cand_cod_empresa = :P_EMPRESA_USER',
'      and cp.cand_matricula = :P_MATRICULA_USER;',
'',
'    v_c2 c2%rowtype;',
'',
'begin',
'',
'if :p_painel = ''PC'' then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    open c2;',
'    fetch c2 into v_c2;',
'    close c2;',
'',
'    if trunc(sysdate) not between trunc(v_c1.dt_inscr_eleicao_cipa) and trunc(v_c1.fim_inscricao_cipa)  then',
'       return false;',
'    else   ',
'      if v_c1.tipo = ''INSCRICAO''  and v_c2.cod_cipa is null then ',
'       return true;   ',
'      else',
'       return false;',
'      end if;',
'    end if;',
'else',
'    return false;    ',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14114434059304383999)
,p_name=>'P34_COD_CIPA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(14408632218458450679)
,p_prompt=>'CIPA'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_cipa||'' - ''||upper(descr_cipa)||'' [''||to_char(dt_ini_cipa,''DD/MM/RRRR'')||'' - ''||to_char(dt_fin_cipa,''DD/MM/RRRR'')||'']'' d, cod_cipa c',
'  from cipa',
' order by 2 desc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(34486126037211022050)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14114434513927384000)
,p_name=>'P34_COD_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(14408632218458450679)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||upper(nvl(nome_abrev,nome)) d, cod',
'  from empresas',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34486126037211022050)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14114434929350384000)
,p_name=>'P34_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(14408632218458450679)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||upper(nvl(sigla,nome_filial)) d, cod_filial c',
'  from filiais',
' where (:P34_COD_EMPRESA     is null or COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_COD_EMPRESA, '':'')) t))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P34_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34486126037211022050)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14114435259928384000)
,p_name=>'P34_CAND_COD_EMPRESA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(14408632218458450679)
,p_prompt=>'Empresa (Candidato)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||upper(nvl(nome_abrev,nome)) d, cod c',
'  from empresas',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(34486126037211022050)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14114435674134384001)
,p_name=>'P34_CAND_MATRICULA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(14408632218458450679)
,p_prompt=>'Candidato'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||fnct_nome_func(i.cod_empresa, i.matricula) d, i.matricula c',
'  from informacoes_funcionais i',
' where (:P34_CAND_COD_EMPRESA     is null or COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P34_CAND_COD_EMPRESA, '':'')) t))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P34_CAND_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(34486126037211022050)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14122258824323044374)
,p_name=>'Show/Hide Regions'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P_PAINEL'
,p_display_when_cond2=>'PC'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14122258956841044375)
,p_event_id=>wwv_flow_api.id(14122258824323044374)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(14408632218458450679)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14122259012269044376)
,p_name=>'Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(14114432964525383996)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14122259150408044377)
,p_event_id=>wwv_flow_api.id(14122259012269044376)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14122258689802044373)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Colaborador'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is       ',
'    select distinct cod_empresa, cod_cipa, cod_filial',
'      from vw_elegiveis_cipa',
'     where cod_empresa = :P_EMPRESA_USER',
'       and matricula = :P_MATRICULA_USER',
'       and trunc(sysdate) between trunc(dt_inscr_eleicao_cipa) and trunc(fim_inscricao_cipa);',
'    v_c1 c1%rowtype;',
'   ',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.cod_cipa is not null then',
'       :p34_cod_cipa := v_c1.cod_cipa;',
'       :p34_filial := v_c1.cod_filial;',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P_PAINEL'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'PC'
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
