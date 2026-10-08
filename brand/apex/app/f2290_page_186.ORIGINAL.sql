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
,p_default_application_id=>2290
,p_default_id_offset=>785202589062930148
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2290 - Requisição de Serviço de Terceiros - Natcorp
--
-- Application Export:
--   Application:     2290
--   Name:            Requisição de Serviço de Terceiros - Natcorp
--   Date and Time:   18:27 Wednesday September 30, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 186
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00186
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>186);
end;
/
prompt --application/pages/page_00186
begin
wwv_flow_api.create_page(
 p_id=>186
,p_user_interface_id=>wwv_flow_api.id(34915132647027036600)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Servi\00E7o de Terceiros')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Servi\00E7o de Terceiros')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';',
'',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'apex.message.setThemeHooks({',
'    beforeShow: function( pMsgType, pElement$ ){',
'        if ( pMsgType === apex.message.TYPE.ERROR ) {',
'          ',
'            if (apex.item( "P186_COD_SIT_REQ" ).getValue() == ''2'' || ',
'                apex.item( "P186_COD_SIT_REQ" ).getValue() == ''3'' || ',
'                apex.item( "P186_COD_SIT_REQ" ).getValue() == ''4'')',
'            {',
'',
'            apex.item( "P186_COD_SIT_REQ" ).disable() ;',
'            apex.item( "P186_OBSERVACAO" ).disable() ;',
'            }',
'        }',
'    }',
'});',
'',
'//apex.jQuery("#P186_CNPJ_TERCEIRO").mask("00.000.000/0000-00");',
'',
'//            apex.item("P186_CNPJ_TERCEIRO").disable(); ',
'',
'            if ($x(''P186_COD_REQUISICAO'').value.length > 0 &&',
'                $x(''P186_COD_SIT_REQ'').value.length > 0 &&',
'                $x(''P186_COD_SIT_REQ'').value != ''1'') {',
'                apex.item("P186_COD_SIT_REQ").disable();',
'            };',
'                if ( $x(''P186_COD_REQUISICAO'').value.length > 0 ) {',
'                    apex.item("P186_COD_REQUISICAO_DSP").disable();',
'                    apex.item("P186_DT_REQUISICAO_DSP").disable();',
'                      apex.item("P186_EMAIL_TERCEIRO").disable();',
'                      apex.item("P186_COD_PREST_SERV").disable();',
'/*                  ',
'                      apex.item("P186_COD_REQUISICAO").disable();',
'                      apex.item("P186_DT_REQUISICAO").disable();',
'                      apex.item("P186_SOLICITANTE").disable();',
'                      apex.item("P186_COD_EMPRESA").disable();',
'                      apex.item("P186_COD_FILIAL").disable();',
'                      apex.item("P186_COD_CCUSTO").disable();',
'                      apex.item("P186_COD_LOCAL_TRAB").disable();',
'                      apex.item("P186_TIPO_ATIVIDADE").disable();',
'                      apex.item("P186_DESCRICAO_SERVICO").disable();',
'                      apex.item("P186_OBSERVACAO").disable();',
'                      apex.item("P186_COD_TERCEIRO").disable();',
'                      apex.item("P186_EMAIL_TERCEIRO").disable();',
'                      apex.item("P186_NUM_CONTRATO").disable();',
'                      apex.item("P186_DATA_INICIO_OBRA").disable();',
'                      apex.item("P186_DATA_FIM_OBRA").disable();',
'                      apex.item("P186_COD_PREST_SERV").disable();',
'                      apex.item("P186_NOME_RESP_CONTRATO").disable();',
'                      apex.item("P186_NUM_CPF_RESP").disable();',
'                      apex.item("P186_EMAIL_RESP_CONTRATO").disable();',
'                      apex.item("P186_IND_VINCULO_EMPREG").disable();',
'                      apex.item("P186_ARQ_VINC_EMPREG").disable();',
'                      apex.item("P186_IND_ORDEM_SERVICO").disable();',
'',
'                      apex.item("P186_ARQ_ORDEM_SERVICO").disable();',
'                      apex.item("P186_IND_CAPACITADO_SERVICO").disable();',
'',
'                      apex.item("P186_IND_ASO").disable();',
'                      apex.item("P186_IND_ASO_VIGENTE").disable();',
'                      apex.item("P186_ARQ_ASO").disable();',
'                      apex.item("P186_IND_CERTIFIC_SERVICO").disable();',
'                      apex.item("P186_IND_CERT_SERV_VIGENTE").disable();',
'                      apex.item("P186_ARQ_CERT_SERV_VIGENTE").disable();',
'                      apex.item("P186_IND_TREINAMENTO_EPI").disable();',
'                      apex.item("P186_ARQ_TREINO_EPI").disable();',
'                      apex.item("P186_IND_FICHA_EPI").disable();',
'                      apex.item("P186_IND_FICHA_EPI_ASSINADAS").disable();',
'                      apex.item("P186_IND_FICHA_EPI_CA").disable();',
'',
'                      apex.item("P186_ARQ_FICHA_EPI").disable();',
'                      apex.item("P186_IND_PRODUTO_QUIMICO").disable();',
'                      apex.item("P186_IND_PROD_FISPQ").disable();',
'',
'                      apex.item("P186_IND_ALERTAS_MANUSEIO").disable();',
'                      apex.item("P186_ARQ_FISPQ").disable();',
'                    ',
'                      apex.item("P186_IND_CERTIFIC_NR18").disable();',
'                      apex.item("P186_ARQ_CERTIF_NR18").disable();',
'',
'                    apex.item("P186_IND_VISITA_LOCAL").disable();',
'                    apex.item("P186_IND_ANALISE_RISCO_APR").disable();',
'                    apex.item("P186_IND_VALIDA_RISCO_APR").disable();',
'                    apex.item("P186_ID_ASSINATURA_APR").disable();',
'                    apex.item("P186_ARQ_ASSINATURA_APR").disable();',
'                    apex.item("P186_IND_ART_VIGENTE").disable();',
'                    apex.item("P186_ARQ_ART_VIGENTE").disable();',
'                    apex.item("P186_IND_TRAB_ALTURA_VIGENTE").disable();',
'                    apex.item("P186_ARQ_TRAB_ALTURA_VIGENTE").disable();',
'*/                  ',
'                $(''#SAVE'').show();',
'                  ',
'                }else{',
'                $(''#CREATE'').show();',
'                }',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'img { height: 100px }',
''))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>'ABACAXI'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260928144631'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418281064496259)
,p_plug_name=>'Steppers'
,p_region_css_classes=>'nc-stepper-host'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418510022496261)
,p_plug_name=>'Contratante'
,p_parent_plug_id=>wwv_flow_api.id(3816418281064496259)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418349074496260)
,p_plug_name=>unistr('Servi\00E7os a Executar<span class="nc-native-header__subtitle">Descreva o escopo e registre observa\00E7\00F5es relevantes</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418510022496261)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781118920035500484)
,p_plug_name=>unistr('Empresa Contratante<span class="nc-native-header__subtitle">Empresa, filial, centro de custo e local de execu\00E7\00E3o</span>')
,p_region_name=>'CONTRATANTE'
,p_parent_plug_id=>wwv_flow_api.id(3816418510022496261)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_plug_read_only_when=>'P186_COD_REQUISICAO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418581740496262)
,p_plug_name=>'Prestador'
,p_parent_plug_id=>wwv_flow_api.id(3816418281064496259)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418695532496263)
,p_plug_name=>unistr('Respons\00E1vel T\00E9cnico<span class="nc-native-header__subtitle">Profissional respons\00E1vel pela execu\00E7\00E3o e pela APR</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418581740496262)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7720492214609692864)
,p_plug_name=>unistr('Informa\00E7\00F5es do Prestador de Servi\00E7o Terceirizado<span class="nc-native-header__subtitle">Empresa contratada, contrato e prazos de execu\00E7\00E3o</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418581740496262)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_plug_read_only_when=>'P186_COD_REQUISICAO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418769670496264)
,p_plug_name=>unistr('Seguran\00E7a')
,p_parent_plug_id=>wwv_flow_api.id(3816418281064496259)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816418888547496265)
,p_plug_name=>unistr('V\00EDnculo, Ordem de Servi\00E7o e Sa\00FAde Ocupacional<span class="nc-native-header__subtitle">Regularidade trabalhista e ASO dos funcion\00E1rios da contratada</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418769670496264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816419035276496267)
,p_plug_name=>'Certificados de Atividades Especiais e EPI<span class="nc-native-header__subtitle">NR35, NR33, NR10, soldagem, treinamento e fichas de EPI</span>'
,p_parent_plug_id=>wwv_flow_api.id(3816418769670496264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816419171157496268)
,p_plug_name=>unistr('Produtos Qu\00EDmicos<span class="nc-native-header__subtitle">FISPQ e alertas de risco no manuseio</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418769670496264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816419260402496269)
,p_plug_name=>unistr('An\00E1lise Preliminar de Riscos (APR)<span class="nc-native-header__subtitle">Visita t\00E9cnica, elabora\00E7\00E3o, etapas contempladas e assinaturas</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418769670496264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816419362167496270)
,p_plug_name=>unistr('NR 18 - Ind\00FAstria da Constru\00E7\00E3o<span class="nc-native-header__subtitle">Treinamento inicial/peri\00F3dico exigido para obras e manuten\00E7\00E3o predial</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418769670496264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816419489241496271)
,p_plug_name=>unistr('Equipamentos de Acesso e Trabalho em Altura<span class="nc-native-header__subtitle">ART vigente, pontos de ancoragem e relat\00F3rios t\00E9cnicos</span>')
,p_parent_plug_id=>wwv_flow_api.id(3816418769670496264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3816419594796496272)
,p_plug_name=>unistr('Identifica\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(3816418281064496259)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781109354947500474)
,p_plug_name=>'&P186_TITULO.'
,p_parent_plug_id=>wwv_flow_api.id(3816419594796496272)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781103709843500467)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(24708130038867045605)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(34915127937784036551)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(199781104152954500469)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(34915106650189036506)
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from aprova_servico_terceiros a, usuario_oracle u',
' where a.cod_requisicao = :p186_cod_requisicao ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   --and u.cd_perfil NOT IN (''BUSINESS PARTNER'',''REMUNERACAO'',''CONT DE NEGOCIOS'')',
'   and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil) or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)))',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from aprova_servico_terceiros a, usuario_oracle u',
' where a.cod_requisicao = :p186_cod_requisicao ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'      and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_servico_terceiros',
' where cod_requisicao = :p186_cod_requisicao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P186_COD_REQUISICAO'
,p_query_row_template=>wwv_flow_api.id(34915115461743036522)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999498399117635739)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_lov_show_nulls=>'YES'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999495591651635738)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999496057106635738)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999496446285635738)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV_ESC'
,p_inline_lov=>'STATIC:Pendente;P,Aprovado;A,Reprovado;R'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999496768340635738)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999497247754635739)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999497593472635739)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(8999498002237635739)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781107726207500473)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(34915098655867036493)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781115322375500478)
,p_plug_name=>'Colaborador Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781116096268500481)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(199781115322375500478)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199781116954601500482)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(199781115322375500478)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(34915106650189036506)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(5352073520660211646)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_button_name=>'BTN_CAD_TERCEIRO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34915127441787036550)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cadastrar Empresas Terceirizadas'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:187:&SESSION.::&DEBUG.:187:P187_COD_ENTIDADE:&P186_COD_TERCEIRO.'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999501780130635740)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_button_name=>'p186_btn_solicitante'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(34915127325716036547)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P186 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT:&P186_COD_EMP_SOLICITANTE.,&P186_COD_MAT_SOLICITANTE.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999499178479635739)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(199781104152954500469)
,p_button_name=>'p186_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(34915127615507036550)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P186_COD_REQUISICAO.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_servico_terceiros',
' where cod_requisicao = :p186_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'--* pkg_deslig.Valida_Sequencia(:p186_cod_empresa, :p186_cod_desligamento, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999499899592635739)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(199781107726207500473)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34915127441787036550)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:185:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999500306710635740)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(199781107726207500473)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34915127441787036550)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999500708510635740)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(199781107726207500473)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34915127441787036550)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p186_rowid is not null then',
'',
'    if :p186_cod_sit_req in (1,5,6) then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'else',
'',
'return false;',
'',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999501128656635740)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(199781107726207500473)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34915127441787036550)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P186_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8999498787651635739)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(199781104152954500469)
,p_button_name=>'p186_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(34915127615507036550)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P186_COD_REQUISICAO.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_servico_terceiros',
' where cod_requisicao = :p186_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'  Pkg_Req_Servico_Terceiros.Valida_Sequencia(:p186_cod_requisicao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'      IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'          RETURN TRUE;',
'      ELSE',
'          RETURN FALSE;',
'      END IF;',
'',
'  ELSE',
'',
'  RETURN FALSE;',
'',
'  END IF;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(8999604982162635768)
,p_branch_name=>'Create: Go To Page 185'
,p_branch_action=>'f?p=&APP_ID.:185:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(8999501128656635740)
,p_branch_sequence=>1
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(8999604166347635768)
,p_branch_name=>'Go To Page 24'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>21
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(8999605386046635768)
,p_branch_name=>'Save: Go To Page 185'
,p_branch_action=>'f?p=&APP_ID.:185:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(8999500708510635740)
,p_branch_sequence=>41
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(8999603823393635768)
,p_branch_name=>'Go To Page Page Branch'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>31
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'APROVAR,REPROVAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497249038687550)
,p_name=>'P186_COD_TERCEIRO'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa Contratada'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_TERCEIRO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod_entidade||'' - ''||e.nome_entidade name, e.cod_entidade id',
'from   entidade e',
'where  tipo_entidade = ''12''',
'order  by e.nome_entidade'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497259645687551)
,p_name=>'P186_EMAIL_TERCEIRO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_use_cache_before_default=>'NO'
,p_prompt=>'E-mail'
,p_source=>'EMAIL_TERCEIRO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497416012687552)
,p_name=>'P186_NUM_CONTRATO'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00B0 do Contrato')
,p_source=>'NUM_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>20
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497537865687553)
,p_name=>'P186_NOME_RESP_CONTRATO'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(3816418695532496263)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Respons\00E1vel T\00E9cnico')
,p_source=>'NOME_RESP_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497644166687554)
,p_name=>'P186_NUM_CPF_RESP'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(3816418695532496263)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('CPF do Respons\00E1vel T\00E9cnico')
,p_source=>'NUM_CPF_RESP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>11
,p_cMaxlength=>11
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497736128687555)
,p_name=>'P186_EMAIL_RESP_CONTRATO'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(3816418695532496263)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('E-mail do Respons\00E1vel T\00E9cnico')
,p_source=>'EMAIL_RESP_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497794075687556)
,p_name=>'P186_DT_SIT_REQ'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497853631687557)
,p_name=>'P186_CNPJ_TERCEIRO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_prompt=>'CNPJ'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713497984341687558)
,p_name=>'P186_COD_PREST_SERV'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Representante Administrativo'
,p_source=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>100
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713498142109687559)
,p_name=>'P186_DATA_INICIO_OBRA'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Previs\00E3o de In\00EDcio')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DATA_INICIO_OBRA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713498204756687560)
,p_name=>'P186_DATA_FIM_OBRA'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(7720492214609692864)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Previs\00E3o de T\00E9rmino')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DATA_FIM_OBRA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713500056234687579)
,p_name=>'P186_COD_FILIAL'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_FILIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(sigla) descricao, cod_filial',
'  from filiais ',
'where cod_empresa = :p186_cod_empresa',
'and (((encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')) AND :P186_ROWID IS NULL) or (:P186_ROWID IS not NULL))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P186_COD_EMPRESA'
,p_ajax_items_to_submit=>'P186_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713500214703687580)
,p_name=>'P186_COD_LOCAL_TRAB'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local de Trabalho'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, filial_local f',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       AND l.cod_local_trab = f.cod_local_filial',
'       AND F.COD_EMPRESA = :P186_COD_EMPRESA',
'       AND F.COD_FILIAL = :P186_COD_FILIAL',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P186_COD_EMPRESA,P186_COD_FILIAL'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713501184367687590)
,p_name=>'P186_TIPO_ATIVIDADE'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Atividade'
,p_placeholder=>'- Selecione -'
,p_source=>'TIPO_ATIVIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD||'' - ''||DESCRICAO NAME, COD ID',
'FROM   TIPO_SERVICO_TERCEIROS',
'ORDER  BY DESCRICAO'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713501333509687591)
,p_name=>'P186_DESCRICAO_SERVICO'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(3816418349074496260)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Descri\00E7\00E3o dos Servi\00E7os')
,p_source=>'DESCRICAO_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>4000
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7713501415356687592)
,p_name=>'P186_IND_VINCULO_EMPREG'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('1. Os funcion\00E1rios da empresa contratada possuem vinculos empregat\00EDcios?')
,p_source=>'IND_VINCULO_EMPREG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421438850782143)
,p_name=>'P186_ARQ_VINC_EMPREG'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('A. Anexar o registro de v\00EDnculo empregat\00EDcio de todos os funcion\00E1rios')
,p_source=>'ARQ_VINC_EMPREG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_VINC_EMPREG'
,p_attribute_03=>'NM_ARQ_VINC_EMPREG'
,p_attribute_04=>'CHRST_ARQ_VINC_EMPREG'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421522730782144)
,p_name=>'P186_NM_ARQ_VINC_EMPREG'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_VINC_EMPREG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421579723782145)
,p_name=>'P186_TP_ARQ_VINC_EMPREG'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_VINC_EMPREG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421706619782146)
,p_name=>'P186_CHRST_ARQ_VINC_EMPREG'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_VINC_EMPREG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421792411782147)
,p_name=>'P186_COD_CCUSTO'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Centro de Custo'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_CCUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cc.cod||'' - ''||cc.nome name, cc.cod id',
'from   centro_de_custo cc, filial_ccusto fc',
'where  trunc(sysdate) between nvl(fc.dt_inicio_val,to_date(''01/01/1900'',''dd/mm/rrrr'')) and nvl(fc.dt_fin_val,to_date(''31/12/2099'',''dd/mm/rrrr''))',
'and    fc.cod_ccusto  = cc.cod',
'and    fc.cod_filial  = :p186_cod_filial',
'and    fc.cod_empresa = cc.cod_empresa',
'and    cc.cod_empresa = :p186_cod_empresa',
'order  by cc.nome'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P186_COD_EMPRESA,P186_COD_FILIAL'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421947291782148)
,p_name=>'P186_IND_ORDEM_SERVICO'
,p_is_required=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('2. Os funcion\00E1rios da empresa contratada possuem ordem de servi\00E7o? ')
,p_source=>'IND_ORDEM_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720421949549782149)
,p_name=>'P186_ARQ_ORDEM_SERVICO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('B. Anexar a ordem de servi\00E7o de todos os funcion\00E1rios assinado')
,p_source=>'ARQ_ORDEM_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_ORDEM_SERVICO'
,p_attribute_03=>'NM_ARQ_ORDEM_SERVICO'
,p_attribute_04=>'CHRST_ARQ_ORDEM_SERVICO'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422114310782150)
,p_name=>'P186_NM_ARQ_ORDEM_SERVICO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_ORDEM_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422149329782151)
,p_name=>'P186_TP_ARQ_ORDEM_SERVICO'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_ORDEM_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422329541782152)
,p_name=>'P186_CHRST_ARQ_ORDEM_SERVICO'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_ORDEM_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422368390782153)
,p_name=>'P186_IND_CAPACITADO_SERVICO'
,p_is_required=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('3. Os funcion\00E1rios da empresa contratada est\00E3o capacitados para exercer as atividades constantes do contrato?')
,p_source=>'IND_CAPACITADO_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422453888782154)
,p_name=>'P186_IND_ASO'
,p_is_required=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('4. Os funcion\00E1rios da empresa contratada possuem ASO (Atestado de Sa\00FAde Ocupacional) com data vigente at\00E9 o final do servi\00E7o?')
,p_source=>'IND_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422551394782155)
,p_name=>'P186_IND_ASO_VIGENTE'
,p_is_required=>true
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('6. Os ASO''s destes funcion\00E1rios em atividades especiais est\00E3o de acordo com  a legisla\00E7\00E3o vigente?')
,p_source=>'IND_ASO_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422656172782156)
,p_name=>'P186_ARQ_ASO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(3816418888547496265)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C. Anexar ASO de todos os funcion\00E1rios assinado')
,p_source=>'ARQ_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_ASO'
,p_attribute_03=>'NM_ARQ_ASO'
,p_attribute_04=>'CHRST_ARQ_ASO'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422819254782157)
,p_name=>'P186_NM_ARQ_ASO'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720422941482782158)
,p_name=>'P186_TP_ARQ_ASO'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423036921782159)
,p_name=>'P186_CHRST_ARQ_ASO'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423129049782160)
,p_name=>'P186_IND_CERTIFIC_SERVICO'
,p_is_required=>true
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('7. Os colaboradores que executam atividades especiais possuem certificados? Trabalho em Altura (NR35), Espa\00E7o Confinado (NR33), Eletricidade (NR10), Soldagem e Corte a Quente (Certificado de Fun\00E7\00E3o)')
,p_source=>'IND_CERTIFIC_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423244470782161)
,p_name=>'P186_IND_CERT_SERV_VIGENTE'
,p_is_required=>true
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('8. Os certificados para atividades especiais est\00E3o com a data vigente at\00E9 o  final do servi\00E7o?')
,p_source=>'IND_CERT_SERV_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423296160782162)
,p_name=>'P186_ARQ_CERT_SERV_VIGENTE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('E. Anexar os certificados para atividades especiais de todos os funcion\00E1rios assinados.')
,p_source=>'ARQ_CERT_SERV_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_CERT_SERV_VIGENTE'
,p_attribute_03=>'NM_ARQ_CERT_SERV_VIGENTE'
,p_attribute_04=>'CHRST_ARQ_CERT_SERV_VIGENTE'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423380950782163)
,p_name=>'P186_NM_ARQ_CERT_SERV_VIGENTE'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_CERT_SERV_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423514995782164)
,p_name=>'P186_TP_ARQ_CERT_SERV_VIGENTE'
,p_item_sequence=>570
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_CERT_SERV_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423577846782165)
,p_name=>'P186_CHRST_ARQ_CERT_SERV_VIGENTE'
,p_item_sequence=>590
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_CERT_SERV_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423736229782166)
,p_name=>'P186_IND_TREINAMENTO_EPI'
,p_is_required=>true
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('9. Os colaboradores possuem treinamento de equipamentos de prote\00E7\00E3o  individual (EPI)? ')
,p_source=>'IND_TREINAMENTO_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423771186782167)
,p_name=>'P186_ARQ_TREINO_EPI'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('F. Anexar os certificados do treinamento de EPI de todos os funcion\00E1rios assinados')
,p_source=>'ARQ_TREINO_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_TREINO_EPI'
,p_attribute_03=>'NM_ARQ_TREINO_EPI'
,p_attribute_04=>'CHRST_ARQ_TREINO_EPI'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720423868678782168)
,p_name=>'P186_NM_ARQ_TREINO_EPI'
,p_item_sequence=>640
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_TREINO_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424013885782169)
,p_name=>'P186_TP_ARQ_TREINO_EPI'
,p_item_sequence=>660
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_TREINO_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424133650782170)
,p_name=>'P186_CHRST_ARQ_TREINO_EPI'
,p_item_sequence=>680
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_TREINO_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424232319782171)
,p_name=>'P186_IND_FICHA_EPI'
,p_is_required=>true
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>'10. Os colaboradores possuem ficha de registro de EPI?'
,p_source=>'IND_FICHA_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424258138782172)
,p_name=>'P186_IND_FICHA_EPI_CA'
,p_is_required=>true
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('12. As fichas de controle e entrega de EPI est\00E3o preenchidas corretamente   contemplando n\00FAmero de Certicado de Aprova\00E7\00E3o (C.A.)?')
,p_source=>'IND_FICHA_EPI_CA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424360599782173)
,p_name=>'P186_ARQ_FICHA_EPI'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('G. Anexar as fichas de EPI de todos os funcion\00E1rios assinadas.')
,p_source=>'ARQ_FICHA_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_FICHA_EPI'
,p_attribute_03=>'NM_ARQ_FICHA_EPI'
,p_attribute_04=>'CHRST_ARQ_FICHA_EPI'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424465294782174)
,p_name=>'P186_NM_ARQ_FICHA_EPI'
,p_item_sequence=>780
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_FICHA_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424560746782175)
,p_name=>'P186_TP_ARQ_FICHA_EPI'
,p_item_sequence=>800
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_FICHA_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424730278782176)
,p_name=>'P186_CHRST_ARQ_FICHA_EPI'
,p_item_sequence=>820
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_FICHA_EPI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424805899782177)
,p_name=>'P186_IND_FICHA_EPI_ASSINADAS'
,p_is_required=>true
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(3816419035276496267)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('11. As fichas de EPI''s est\00E3o assinada pelos funcion\00E1rios?')
,p_source=>'IND_FICHA_EPI_ASSINADAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720424874685782178)
,p_name=>'P186_IND_PRODUTO_QUIMICO'
,p_is_required=>true
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(3816419171157496268)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('13. Os colaboradores ir\00E3o trabalhar com produtos qu\00EDmicos?')
,p_source=>'IND_PRODUTO_QUIMICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425009760782179)
,p_name=>'P186_IND_PROD_FISPQ'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(3816419171157496268)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('14. Os produtos qu\00EDmicos utilizados no servi\00E7o possuem Ficha de Informa\00E7\00E3o de Seguran\00E7a de Produtos Qu\00EDmicos (FISPQ)?')
,p_source=>'IND_PROD_FISPQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425112889782180)
,p_name=>'P186_IND_ALERTAS_MANUSEIO'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(3816419171157496268)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('15. Os funcion\00E1rios foram alertados sobre os riscos no manuseio dos produtos?e EPI est\00E3o preenchidas corretamente   contemplando n\00FAmero de Certicado de Aprova\00E7\00E3o (C.A.)?')
,p_source=>'IND_ALERTAS_MANUSEIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425233167782181)
,p_name=>'P186_ARQ_FISPQ'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(3816419171157496268)
,p_use_cache_before_default=>'NO'
,p_prompt=>'H. Anexar todas as FISPQ''s'
,p_source=>'ARQ_FISPQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_FISPQ'
,p_attribute_03=>'NM_ARQ_FISPQ'
,p_attribute_04=>'CHRST_ARQ_FISPQ'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425317097782182)
,p_name=>'P186_NM_ARQ_FISPQ'
,p_item_sequence=>900
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_FISPQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425375649782183)
,p_name=>'P186_TP_ARQ_FISPQ'
,p_item_sequence=>910
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_FISPQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425488600782184)
,p_name=>'P186_CHRST_ARQ_FISPQ'
,p_item_sequence=>920
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_FISPQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425617329782185)
,p_name=>'P186_IND_CERTIFIC_NR18'
,p_is_required=>true
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(3816419362167496270)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('16. Os funcion\00E1rios possuem certificado de NR 18 inicial/peri\00F3dico? NR 18 - 18.2.1 Esta norma se aplica \00E0s atividades da ind\00FAstria da constru\00E7\00E3o constantes da se\00E7\00E3o "F" do C\00F3digo Nacional de Atividades Econ\00F4micas - CNAE e \00E0s atividades e servi\00E7os de ')
||unistr('demoli\00E7\00E3o, reparo, pintura, limpeza e manuten\00E7\00E3o de edif\00EDcios em geral e de manuten\00E7\00E3o de obras de urbaniza\00E7\00E3o')
,p_source=>'IND_CERTIFIC_NR18'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425710384782186)
,p_name=>'P186_ARQ_CERTIF_NR18'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(3816419362167496270)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('J. Anexar o treinamento de NR 18 de todos os funcion\00E1rios')
,p_source=>'ARQ_CERTIF_NR18'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_CERTIF_NR18'
,p_attribute_03=>'NM_ARQ_CERTIF_NR18'
,p_attribute_04=>'CHRST_ARQ_CERTIF_NR18'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425825668782187)
,p_name=>'P186_NM_ARQ_CERTIF_NR18'
,p_item_sequence=>970
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_CERTIF_NR18'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720425936160782188)
,p_name=>'P186_TP_ARQ_CERTIF_NR18'
,p_item_sequence=>990
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_CERTIF_NR18'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720426030653782189)
,p_name=>'P186_CHRST_ARQ_CERTIF_NR18'
,p_item_sequence=>1010
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_CERTIF_NR18'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720426125040782190)
,p_name=>'P186_IND_VISITA_LOCAL'
,p_is_required=>true
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(3816419260402496269)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('17. Foi realizada a visita ao local da execu\00E7\00E3o dos servi\00E7os para a elabora\00E7\00E3o da An\00E1lise Preliminar de Riscos (APR)? ')
,p_source=>'IND_VISITA_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720426169000782191)
,p_name=>'P186_IND_ANALISE_RISCO_APR'
,p_is_required=>true
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(3816419260402496269)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('18. Foi elaborada An\00E1lise Preliminar de Risco (APR) em todas as atividades  no local em que ser\00E1 executado o servi\00E7o?Caso negativo, realizar a corre\00E7\00E3o para prosseguir o andamento dos trabalhos')
,p_source=>'IND_ANALISE_RISCO_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720426341632782192)
,p_name=>'P186_IND_VALIDA_RISCO_APR'
,p_is_required=>true
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(3816419260402496269)
,p_use_cache_before_default=>'NO'
,p_prompt=>'19. Foram contempladas na APR, todas as etapas de trabalho com seus respectivos riscos e medidas de controle? '
,p_source=>'IND_VALIDA_RISCO_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490127333692843)
,p_name=>'P186_ID_ASSINATURA_APR'
,p_is_required=>true
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(3816419260402496269)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('20. A APR foi devidamente assinada pelos colaboradores e respons\00E1veis da empresa contratada?')
,p_source=>'ID_ASSINATURA_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490217844692844)
,p_name=>'P186_ARQ_ASSINATURA_APR'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(3816419260402496269)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('K. Anexar a APR do servi\00E7o que ser\00E1 executado.')
,p_source=>'ARQ_ASSINATURA_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_ASSINATURA_APR'
,p_attribute_03=>'NM_ARQ_ASSINATURA_APR'
,p_attribute_04=>'CHRST_ARQ_ASSINATURA_APR'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490289455692845)
,p_name=>'P186_NM_ARQ_ASSINATURA_APR'
,p_item_sequence=>1130
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_ASSINATURA_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490406470692846)
,p_name=>'P186_TP_ARQ_ASSINATURA_APR'
,p_item_sequence=>1150
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_ASSINATURA_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490449909692847)
,p_name=>'P186_CHRST_ARQ_ASSINATURA_APR'
,p_item_sequence=>1170
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_ASSINATURA_APR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490689138692849)
,p_name=>'P186_IND_ART_VIGENTE'
,p_is_required=>true
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(3816419489241496271)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr(' 21. Os Equipamentos de acesso possui Anota\00E7\00E3o de Responsabilidade  T\00E9cnica (ART) com data vigente (Equipamentos de Acesso: Balancim, Cadeira Suspensa, Andaime, etc). Para Trabalho em Altura ou Espa\00E7o Confinado.')
,p_source=>'IND_ART_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490780567692850)
,p_name=>'P186_IND_TRAB_ALTURA_VIGENTE'
,p_is_required=>true
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(3816419489241496271)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('22. Para trabalho em altura, todos os pontos de ancoragem possuem relat\00F3rio t\00E9cnico de conformidade e ART com data vigente? ')
,p_source=>'IND_TRAB_ALTURA_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N,N\00E3o se aplica;O')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720490987740692852)
,p_name=>'P186_ARQ_ART_VIGENTE'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(3816419489241496271)
,p_use_cache_before_default=>'NO'
,p_prompt=>' L. Anexar ART do Equipamento de Acesso com data vigente'
,p_source=>'ARQ_ART_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_ART_VIGENTE'
,p_attribute_03=>'NM_ARQ_ART_VIGENTE'
,p_attribute_04=>'CHRST_ARQ_ART_VIGENTE'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491141036692853)
,p_name=>'P186_NM_ARQ_ART_VIGENTE'
,p_item_sequence=>1210
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_ART_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491189607692854)
,p_name=>'P186_TP_ARQ_ART_VIGENTE'
,p_item_sequence=>1230
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_ART_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491326141692855)
,p_name=>'P186_CHRST_ARQ_ART_VIGENTE'
,p_item_sequence=>1250
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_ART_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491361321692856)
,p_name=>'P186_ARQ_TRAB_ALTURA_VIGENTE'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(3816419489241496271)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('M. Anexar Relat\00F3rio T\00E9cnico e ART com data vigente')
,p_source=>'ARQ_TRAB_ALTURA_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(34915127260619036544)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TP_ARQ_TRAB_ALTURA_VIGENTE'
,p_attribute_03=>'NM_ARQ_TRAB_ALTURA_VIGENTE'
,p_attribute_04=>'CHRST_ARQ_TRAB_ALTURA_VIGENTE'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491490578692857)
,p_name=>'P186_NM_ARQ_TRAB_ALTURA_VIGENTE'
,p_item_sequence=>1290
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'NM_ARQ_TRAB_ALTURA_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491629440692858)
,p_name=>'P186_TP_ARQ_TRAB_ALTURA_VIGENTE'
,p_item_sequence=>1300
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_ARQ_TRAB_ALTURA_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7720491724859692859)
,p_name=>'P186_CHRST_ARQ_TRAB_ALTURA_VIGENTE'
,p_item_sequence=>1310
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_source=>'CHRST_ARQ_TRAB_ALTURA_VIGENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8362840052616291355)
,p_name=>'P186_CAMPO_AUXILIAR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8362842445007291379)
,p_name=>'P186_COD_REQUISICAO_DSP'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_item_default=>'P186_COD_REQUISICAO'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8362842629392291380)
,p_name=>'P186_DT_REQUISICAO_DSP'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_item_default=>'P186_DT_REQUISICAO'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data de Abertura'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999502160880635740)
,p_name=>'P186_TITULO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999502573789635740)
,p_name=>'P186_ROWID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999503055479635740)
,p_name=>'P186_FLAG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999503435321635740)
,p_name=>'P186_MENSAGEM'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999503795992635740)
,p_name=>'P186_OK'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999504160914635740)
,p_name=>'P186_COD_REQUISICAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999504560085635741)
,p_name=>'P186_COD_SIT_REQ'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select Initcap(desc_sit_REQ) descricao, cod_sit_req',
'   from SIT_REQ',
'   order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999504979428635741)
,p_name=>'P186_DT_REQUISICAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_item_default=>'TO_CHAR(SYSDATE,''DD/MM/YYYY'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DT_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999505384839635741)
,p_name=>'P186_SOLICITANTE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999505768066635741)
,p_name=>'P186_ITEM_VALIDACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999506252384635741)
,p_name=>'P186_USUARIO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999506623386635741)
,p_name=>'P186_DT_ATUALIZACAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999506991817635741)
,p_name=>'P186_COD_EMP_SOLICITANTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999507417136635741)
,p_name=>'P186_COD_MAT_SOLICITANTE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999507780522635741)
,p_name=>'P186_PERFIL_USUARIO_LOGADO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(199781109354947500474)
,p_source=>'P_PERFIL'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999509945849635742)
,p_name=>'P186_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999510280128635742)
,p_name=>'P186_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999510722600635742)
,p_name=>'P186_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999511113793635742)
,p_name=>'P186_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999511531815635743)
,p_name=>'P186_IND_CONTRATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>'Tipo de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999511879923635743)
,p_name=>'P186_DT_CONTRATO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>'Data de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999512312948635743)
,p_name=>'P186_DT_PRORROG'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(199781116954601500482)
,p_prompt=>unistr('Data de Prorroga\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127001183036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999515011751635744)
,p_name=>'P186_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod',
'  from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :p186_cod_requisicao is null) or ',
'        (:p186_cod_requisicao is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P186_COD_REQUISICAO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(34915127183448036544)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999526218936635747)
,p_name=>'P186_OBSERVACAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(3816418349074496260)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(34915127098911036543)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999529016981635748)
,p_name=>'P186_MAT_SOLICITANTE_AUX'
,p_item_sequence=>1360
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8999529385415635748)
,p_name=>'P186_COD_EMPRESA_SOLICITANTE_AUX'
,p_item_sequence=>1370
,p_item_plug_id=>wwv_flow_api.id(199781118920035500484)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8999533724025635750)
,p_validation_name=>'(CREATE) Valida Upload de Documentos'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :P186_ARQ_VINC_EMPREG IS NULL',
'   OR :P186_ARQ_ORDEM_SERVICO IS NULL',
'   OR :P186_ARQ_ASO IS NULL',
'   OR :P186_ARQ_CERT_SERV_VIGENTE IS NULL',
'   OR :P186_ARQ_TREINO_EPI IS NULL',
'   OR :P186_ARQ_FICHA_EPI IS NULL',
'   OR :P186_ARQ_FISPQ IS NULL',
'   OR :P186_ARQ_CERTIF_NR18 IS NULL',
'   OR :P186_ARQ_ASSINATURA_APR IS NULL',
'   OR :P186_ARQ_ART_VIGENTE IS NULL',
'   OR :P186_ARQ_TRAB_ALTURA_VIGENTE IS NULL then',
'  return ''Todos os documentos solicitados precisam ser anexados!'';',
'end if;',
'  ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(8999501128656635740)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>unistr('Altera\00E7\00F5es na tratativa dos arquivos - Patr\00EDcia')
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8999532067037635749)
,p_validation_name=>'(SAVE) Valida Upload de Documentos'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :P186_ARQ_VINC_EMPREG IS NULL',
'   OR :P186_ARQ_ORDEM_SERVICO IS NULL',
'   OR :P186_ARQ_ASO IS NULL',
'   OR :P186_ARQ_CERT_SERV_VIGENTE IS NULL',
'   OR :P186_ARQ_TREINO_EPI IS NULL',
'   OR :P186_ARQ_FICHA_EPI IS NULL',
'   OR :P186_ARQ_FISPQ IS NULL',
'   OR :P186_ARQ_CERTIF_NR18 IS NULL',
'   OR :P186_ARQ_ASSINATURA_APR IS NULL',
'   OR :P186_ARQ_ART_VIGENTE IS NULL',
'   OR :P186_ARQ_TRAB_ALTURA_VIGENTE IS NULL then',
'  return ''Todos os documentos solicitados precisam ser anexados!'';',
'end if;',
'  ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'P186_COD_SIT_REQ'
,p_validation_condition2=>'3'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_when_button_pressed=>wwv_flow_api.id(8999500708510635740)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8999530890710635749)
,p_validation_name=>unistr('Valida Sit Requisi\00E7\00E3o')
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' -- pkg_deslig.valida_sit_requisicao(:p186_cod_desligamento, :p186_cod_sit_desligamento, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'   return v_msg_retorno;',
' end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(8999504560085635741)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8999532495811635750)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P186_COD_SIT_REQ = 2 THEN',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(197867167652166654583)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8367719977297718231)
,p_validation_name=>'Valida Dt_Fim_Obra'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :p186_rowid is null and',
'       :p186_data_inicio_obra is not null and',
'       :p186_data_fim_obra is not null and to_date(:p186_data_inicio_obra,''dd/mm/yyyy'') > to_date(:p186_data_fim_obra,''dd/mm/yyyy'') then',
unistr('        return ''A data de previs\00E3o de t\00E9rmino n\00E3o pode ser menor que a data de previs\00E3o de in\00EDcio!'';'),
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7713498204756687560)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :p186_cod_requisicao is null and',
'     :p186_dt_inicio_obra is not null and',
'     :p186_dt_fim_obra is not null and',
'     :p196_dt_inicio_obra > :p186_dt_fim_obra then',
unistr('    return(''A data dse previs\00E3o de t\00E9rmino n\00E3o pode ser menor que a data de previs\00E3o de in\00EDcio!'');'),
'  end if;',
'end;'))
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8367720111613718232)
,p_validation_name=>'Valida Dt_Inicio_Obra'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :p186_rowid is null and :p186_data_inicio_obra is not null then',
'    if to_date(:p186_data_inicio_obra,''dd/mm/yyyy'') < trunc(sysdate) then',
unistr('      return ''A data de previs\00E3o de in\00EDcio n\00E3o pode ser menor que a data atual!'';'),
'    elsif :p186_data_fim_obra is not null and to_date(:p186_data_inicio_obra,''dd/mm/yyyy'') > to_date(:p186_data_fim_obra,''dd/mm/yyyy'') then',
unistr('        return ''A data de previs\00E3o de in\00EDcio n\00E3o pode ser maior que a data de previs\00E3o de t\00E9rmino!'';'),
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7713498142109687559)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370018906492647983)
,p_validation_name=>'Valida P186_ARQ_VINC_EMPREG'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P186_ARQ_VINC_EMPREG IS NULL THEN',
'  RETURN ''O arquivo (item A) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720421438850782143)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370018986042647984)
,p_validation_name=>'Valida P186_ARQ_ORDEM_SERVICO'
,p_validation_sequence=>150
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P186_ARQ_ORDEM_SERVICO IS NULL THEN',
'  RETURN ''O arquivo (item B) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720421949549782149)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019110955647985)
,p_validation_name=>'Valida P186_ARQ_ASO'
,p_validation_sequence=>160
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_ASO_VIGENTE,''X'') <> ''O'' AND :P186_ARQ_ASO IS NULL THEN',
'  RETURN ''O arquivo (item C) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720422656172782156)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019193675647986)
,p_validation_name=>'Valida P186_ARQ_CERT_SERV_VIGENTE'
,p_validation_sequence=>170
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_CERTIFIC_SERVICO,''X'') <> ''O'' AND :P186_ARQ_CERT_SERV_VIGENTE IS NULL THEN',
'  RETURN ''O arquivo (item E) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720423296160782162)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019319914647987)
,p_validation_name=>'Valida P186_ARQ_TREINO_EPI'
,p_validation_sequence=>180
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P186_ARQ_TREINO_EPI IS NULL THEN',
'  RETURN ''O arquivo (item F) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720423771186782167)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019446226647988)
,p_validation_name=>'Valida P186_ARQ_FICHA_EPI'
,p_validation_sequence=>190
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P186_ARQ_FICHA_EPI IS NULL THEN',
'  RETURN ''O arquivo (item G) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720424360599782173)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019566516647989)
,p_validation_name=>'Valida P186_ARQ_FISPQ'
,p_validation_sequence=>200
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_PRODUTO_QUIMICO,''X'') <> ''N'' AND :P186_ARQ_FISPQ IS NULL THEN',
'  RETURN ''O arquivo (item H) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720425233167782181)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019608302647990)
,p_validation_name=>'Valida P186_ARQ_CERTIF_NR18'
,p_validation_sequence=>210
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_CERTIFIC_NR18,''X'') <> ''O'' AND :P186_ARQ_CERTIF_NR18 IS NULL THEN',
'  RETURN ''O arquivo (item J) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720425710384782186)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019683137647991)
,p_validation_name=>'Valida P186_ARQ_ASSINATURA_APR'
,p_validation_sequence=>220
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P186_ARQ_ASSINATURA_APR IS NULL THEN',
'  RETURN ''O arquivo (item K) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720490217844692844)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019862981647992)
,p_validation_name=>'Valida P186_ARQ_ART_VIGENTE'
,p_validation_sequence=>230
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_ART_VIGENTE,''X'') <> ''O'' AND :P186_ARQ_ART_VIGENTE IS NULL THEN',
'  RETURN ''O arquivo (item L) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720490987740692852)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370020129360647995)
,p_validation_name=>'Valida P186_ARQ_TRAB_ALTURA_VIGENTE'
,p_validation_sequence=>240
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_TRAB_ALTURA_VIGENTE,''X'') <> ''O'' AND :P186_ARQ_TRAB_ALTURA_VIGENTE IS NULL THEN',
'  RETURN ''O arquivo (item M) deve ser anexado'';',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720491361321692856)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370019934046647993)
,p_validation_name=>'Valida P186_IND_PROD_FISPQ'
,p_validation_sequence=>250
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_PRODUTO_QUIMICO,''X'') <> ''N'' AND :P186_IND_PROD_FISPQ IS NULL THEN',
unistr('  RETURN ''14. Os produtos qu\00EDmicos utilizados no servi\00E7o possuem Ficha de Informa\00E7\00E3o de Seguran\00E7a de Produtos Qu\00EDmicos (FISPQ)? deve ter algum valor.'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720425009760782179)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6370020015822647994)
,p_validation_name=>'Valida P186_IND_ALERTAS_MANUSEIO'
,p_validation_sequence=>260
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_PRODUTO_QUIMICO,''X'') <> ''N'' AND :P186_IND_ALERTAS_MANUSEIO IS NULL THEN',
unistr('  RETURN ''15. Os funcion\00E1rios foram alertados sobre os riscos no manuseio dos produtos?e EPI est\00E3o preenchidas corretamente   contemplando n\00FAmero de Certicado de Aprova\00E7\00E3o (C.A.)? deve ter algum valor.'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(7720425112889782180)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3334459782245258144)
,p_validation_name=>'Valida P186_IND_PROD_FISPQ '
,p_validation_sequence=>270
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_PRODUTO_QUIMICO,''N'') = ''S'' AND :P186_IND_PROD_FISPQ <> ''S'' THEN',
unistr('  RETURN ''A Quest\00E3o n\00FAmero 13 foi marcada como SIM ent\00E3o a respectiva Quest\00E3o 14 deve ser marcada da mesma forma!'';'),
'  ELSIF NVL(:P186_IND_PRODUTO_QUIMICO,''N'') = ''N'' AND :P186_IND_PROD_FISPQ = ''S'' THEN',
unistr('  RETURN ''A Quest\00E3o n\00FAmero 13 foi marcada como N\00C3O ent\00E3o a respectiva Quest\00E3o 14 deve ser marcada da mesma forma ou N\00C3O SE APLICA!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(7720425009760782179)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3334459923883258145)
,p_validation_name=>'Valida P186_IND_ALERTAS_MANUSEIOS'
,p_validation_sequence=>280
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P186_IND_PRODUTO_QUIMICO,''N'') = ''S'' AND :P186_IND_ALERTAS_MANUSEIO <> ''S'' THEN',
unistr('  RETURN ''A Quest\00E3o n\00FAmero 13 foi marcada como SIM ent\00E3o a respectiva Quest\00E3o 15 deve ser marcada da mesma forma!'';'),
'  ELSIF NVL(:P186_IND_PRODUTO_QUIMICO,''N'') = ''N'' AND :P186_IND_ALERTAS_MANUSEIO <> ''N''THEN',
unistr('  RETURN ''A Quest\00E3o n\00FAmero 13 foi marcada como N\00C3O ent\00E3o a respectiva Quest\00E3o 15 deve ser marcada da mesma forma!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(7720425112889782180)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999575871010635761)
,p_name=>'Hide Region'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P186_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999576438378635761)
,p_event_id=>wwv_flow_api.id(8999575871010635761)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(199781109354947500474)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999580600972635762)
,p_name=>unistr('Valida Sit Requisi\00E7\00E3o')
,p_event_sequence=>1081
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999581103594635762)
,p_event_id=>wwv_flow_api.id(8999580600972635762)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P186_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P186_ITEM_VALIDACAO := null;',
'',
'--* pkg_deslig.valida_sit_requisicao(:p186_cod_requisicao, :p186_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :P186_ITEM_VALIDACAO := TRIM(UPPER(''P186_COD_SIT_REQ''));',
'    :P186_ok       := ''N'';',
'    :P186_flag     := v_flg_retorno;',
'    :P186_mensagem := v_msg_retorno;',
' elsif nvl(v_flg_retorno,''S'') = ''S'' then',
'    :P186_flag     := v_flg_retorno;',
'    :P186_mensagem := trim(v_msg_retorno);',
'    if v_item_validacao = TRIM(UPPER(''P186_COD_SIT_REQ'')) OR v_item_validacao IS NULL then',
'       :P186_OK := ''S'';',
'       :P186_ITEM_VALIDACAO := null;',
'    else',
'       :P186_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P186_ITEM_VALIDACAO,P186_COD_REQUISICAO,P186_COD_SIT_REQ'
,p_attribute_03=>'P186_FLAG,P186_MENSAGEM,P186_OK,P186_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('--* Implementar valida\00E7\00E3o')
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999581542644635762)
,p_name=>'Dispara Alerta'
,p_event_sequence=>1091
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999582041983635762)
,p_event_id=>wwv_flow_api.id(8999581542644635762)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P186_FLAG'').value == "Q") {',
'alertify.confirm($v(''P186_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P186_FLAG'').value = ''S'';',
'        $x(''P186_MENSAGEM'').value = '''';',
'        $x(''P186_OK'').value = ''S'';',
'       // $(''#P186_CREATE'').show();',
'    } else {',
'        $x(''P186_OK'').value = ''N'';',
'      //  $(''#P186_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P186_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P186_FLAG'').value == "N") {',
'           // $(''#P186_CREATE'').hide();',
'        } else {',
'          //  $(''#P186_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P186_MENSAGEM''));',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999582372777635763)
,p_name=>'Inicia Alertify'
,p_event_sequence=>1101
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999582945694635763)
,p_event_id=>wwv_flow_api.id(8999582372777635763)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999586962950635764)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>1141
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P186_COD_SIT_REQ'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999540804668635752)
,p_name=>unistr('Desabilita Campos (Em Aprova\00E7\00E3o)')
,p_event_sequence=>1201
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF 1 = 2 THEN',
'if :P186_COD_SIT_REQ not in (1) then',
'  return true;',
'  else',
'  return false;',
'  end if;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999541259075635753)
,p_event_id=>wwv_flow_api.id(8999540804668635752)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P186_COD_EMPRESA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999543095225635753)
,p_name=>'Desabilita Campos (Aprovado)'
,p_event_sequence=>1221
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF 1 = 2 THEN',
'if :P186_COD_SIT_REQ in (3,4,6) then',
'  return true;',
'else',
'  return false;',
'end if;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999543573815635753)
,p_event_id=>wwv_flow_api.id(8999543095225635753)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P186_COD_EMPRESA,P186_OBSERVACAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999557514855635757)
,p_name=>'(Save) Habilitar Campos'
,p_event_sequence=>1331
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8999500708510635740)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999558004952635757)
,p_event_id=>wwv_flow_api.id(8999557514855635757)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P186_COD_EMPRESA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7925245198838944449)
,p_event_id=>wwv_flow_api.id(8999557514855635757)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999560337495635757)
,p_name=>unistr('Show/Hide Aprova\00E7\00F5es')
,p_event_sequence=>1471
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_COD_SIT_REQ'
,p_condition_element=>'P186_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P186_ROWID'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999563866561635758)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1511
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(186444747801368139518)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999564432570635758)
,p_event_id=>wwv_flow_api.id(8999563866561635758)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REPROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999564783341635758)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1521
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(186444747962573139519)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999565303484635758)
,p_event_id=>wwv_flow_api.id(8999564783341635758)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999565725282635758)
,p_name=>'Habilita/Desabilita Campos'
,p_event_sequence=>1531
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999566224789635758)
,p_event_id=>wwv_flow_api.id(8999565725282635758)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P186_COD_SIT_REQ" ).getValue() == ''2'' || ',
'    apex.item( "P186_COD_SIT_REQ" ).getValue() == ''3'' || ',
'    apex.item( "P186_COD_SIT_REQ" ).getValue() == ''4'')',
'{',
'  ',
'apex.item( "P186_COD_SIT_REQ" ).disable() ;',
'//apex.item( "P186_COD_EMPRESA" ).disable() ;',
'$(''#P186_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'$(''#P186_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P186_OBSERVACAO" ).disable() ;',
'}',
''))
,p_da_action_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if apex.item( "P186_COD_SIT_REQ" ).getValue() == ''5''',
'{',
'apex.item( "P186_COD_EMPRESA" ).disable() ;',
'apex.item( "P186_COD_LOCAL_TRAB" ).disable() ;',
'apex.item( "P186_COD_FILIAL" ).disable() ;',
'apex.item( "P186_COD_CCUSTO" ).disable() ;',
'apex.item( "P186_COD_TERCEIRO" ).disable() ;',
'$(''#P186_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'$(''#P186_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P186_COD_ATIVIDADE" ).disable() ;',
'apex.item( "P186_NUM_CONTRATO" ).disable() ; ',
'}',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999566677930635759)
,p_event_id=>wwv_flow_api.id(8999565725282635758)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P186_COD_SIT_REQ" ).getValue() == ''6'')',
'{',
'apex.item( "P186_COD_SIT_REQ" ).enable() ;',
'$(''#P186_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'$(''#P186_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'}',
'// apex.item( "P186_CNPJ_TERCEIRO" ).disable() ;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999574069928635761)
,p_name=>'SET SOLICITANTE AUX'
,p_event_sequence=>1591
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_da_event_comment=>'--* verificar se vai precisar desse campo/processo'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999574610754635761)
,p_event_id=>wwv_flow_api.id(8999574069928635761)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P186_MAT_SOLICITANTE_AUX := :P_MATRICULA_USER;'
,p_attribute_02=>'P_MATRICULA_USER'
,p_attribute_03=>'P186_MAT_SOLICITANTE_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8999574983910635761)
,p_name=>'SET EMPRESA SOLICITANTE AUX_1'
,p_event_sequence=>1601
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_da_event_comment=>'--* verificar se vai precisar desse campo/processo'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8999575470005635761)
,p_event_id=>wwv_flow_api.id(8999574983910635761)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P186_COD_EMPRESA_SOLICITANTE_AUX := :P_EMPRESA_USER;'
,p_attribute_02=>'P_EMPRESA_USER'
,p_attribute_03=>'P186_COD_EMPRESA_SOLICITANTE_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7903651417403831690)
,p_name=>'Popula Dados Empresa Terceirizada'
,p_event_sequence=>1611
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P186_COD_TERCEIRO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7903651461278831691)
,p_event_id=>wwv_flow_api.id(7903651417403831690)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select -- 123456789000199 cnpj',
'replace(to_char(cgc)||to_char(dc_cgc,''00''),'' '','''') cnpj',
'--,cgc||ltrim(to_char(dc_cgc.''00'')) cnpj',
',contato',
',e_mail',
'/*',
'REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(replace(cgc||to_char(dc_cgc,''00''),'' '',''''),'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(replace(cgc||to_char(dc_cgc,''00''),'' '',''''),14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(replace(cgc||to_char(dc_cgc,''00''),'' '',''''),14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'') cnpj',
'*/',
'into :p186_cnpj_terceiro, :p186_cod_prest_serv, :p186_email_terceiro',
'from   entidade e',
'where  tipo_entidade = ''12''',
'and    e.cod_entidade = :p186_cod_terceiro;',
'exception',
'  when others then',
'    :p186_cnpj_terceiro := null;',
'    :p186_email_terceiro := null;',
'    :p186_cod_prest_serv := null;',
'end;'))
,p_attribute_02=>'P186_COD_TERCEIRO'
,p_attribute_03=>'P186_CNPJ_TERCEIRO,P186_EMAIL_TERCEIRO,P186_COD_PREST_SERV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8362840363850291358)
,p_name=>'Aprovar Dialog Closed'
,p_event_sequence=>1621
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8999498787651635739)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8362841589137291370)
,p_event_id=>wwv_flow_api.id(8362840363850291358)
,p_event_result=>'TRUE'
,p_action_sequence=>20
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
' :p186_mensagem := null;',
'',
'  pkg_req_servico_terceiros.post_update(:p186_cod_requisicao, v_flg_retorno, v_msg_retorno); ',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    :p186_ok       := ''N'';',
'    :p186_flag     := v_flg_retorno;',
'    :p186_mensagem := v_msg_retorno;',
'    raise_application_error(-20001,v_msg_retorno);',
' else',
'    commit;',
'    :p186_flag     := null;',
'    :p186_mensagem := null;',
'    :p186_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P186_COD_REQUISICAO'
,p_attribute_03=>'P186_MENSAGEM,P186_OK,P186_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8362841726922291371)
,p_event_id=>wwv_flow_api.id(8362840363850291358)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8362841956447291374)
,p_name=>'Reprovar Dialog Closed'
,p_event_sequence=>1631
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8999499178479635739)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8362842044676291375)
,p_event_id=>wwv_flow_api.id(8362841956447291374)
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
' :p186_mensagem := null;',
'',
'  pkg_req_servico_terceiros.post_update(:p186_cod_requisicao, v_flg_retorno, v_msg_retorno); ',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    :p186_ok       := ''N'';',
'    :p186_flag     := v_flg_retorno;',
'    :p186_mensagem := v_msg_retorno;',
'    raise_application_error(-20001,v_msg_retorno);',
' else',
'    commit;',
'    :p186_flag     := null;',
'    :p186_mensagem := null;',
'    :p186_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P186_COD_REQUISICAO'
,p_attribute_03=>'P186_MENSAGEM,P186_OK,P186_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8362842235805291376)
,p_event_id=>wwv_flow_api.id(8362841956447291374)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8362840581930291360)
,p_name=>'New_1'
,p_event_sequence=>1641
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8999498787651635739)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8362840656232291361)
,p_event_id=>wwv_flow_api.id(8362840581930291360)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(199781104152954500469)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999537241428635751)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Solicitante'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select cod_empresa||'' - ''||initcap(fnct_nome_empresa(cod_empresa))||'' / ''||',
'        matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula))||'' / ''||',
'        cargo||'' - ''||initcap(fnct_nome_cargo(cargo)) colaborador',
'   from informacoes_funcionais_cad',
'  where cod_empresa = :p186_COD_EMP_SOLICITANTE',
'    and matricula   = :p186_COD_MAT_SOLICITANTE;',
'',
' v_c1 c1%rowtype;',
' ',
' vcnpj_terceiro varchar2(30);',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p186_solicitante := v_c1.colaborador;',
' end if;',
'',
'begin',
'select -- 123456789000199 cnpj',
'replace(to_char(cgc)||to_char(dc_cgc,''00''),'' '','''') cnpj',
'/*',
'REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(replace(cgc||to_char(dc_cgc,''00''),'' '',''''),'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(replace(cgc||to_char(dc_cgc,''00''),'' '',''''),14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(replace(cgc||to_char(dc_cgc,''00''),'' '',''''),14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'') cnpj',
'*/',
'into vcnpj_terceiro',
'from   entidade e',
'where  tipo_entidade = ''12''',
'and    e.cod_entidade = :p186_cod_terceiro;',
':p186_cnpj_terceiro := vcnpj_terceiro;',
'exception',
'  when others then',
'    :p186_cnpj_terceiro := null;',
'end;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999537655523635751)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'cursor c1 is',
' select Initcap(desc_sit_REQ) sit',
'   from SIT_REQ',
'  where cod_sit_req = nvl(:p186_cod_sit_req,1);',
'  ',
'  v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p186_rowid is not null then',
unistr('   :p186_titulo := ''Requisi\00E7\00E3o de Servi\00E7o de Terceiros: N\00BA ''||:p186_cod_requisicao||'' - ''||:p186_dt_requisicao||'' (''||v_c1.sit||'')'';'),
'else',
unistr('   :p186_titulo := ''Requisi\00E7\00E3o de Servi\00E7o de Terceiros'';'),
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999538768157635751)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_seq number;',
'',
'begin',
'',
'    BEGIN',
'  	SELECT seq_requisicao.NEXTVAL INTO v_seq FROM dual;',
'    END;',
'        ',
'    :p186_cod_requisicao := v_seq;',
'',
'    :p186_cod_sit_req := 1;',
'',
'  :p186_usuario         := :p_usuario;',
'  :p186_dt_atualizacao  := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');',
'  :p186_dt_sit_req      := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');',
'  :p186_cod_emp_SOLICITANTE := NVL(:P_EMPRESA_USER,:P186_COD_EMPRESA_SOLICITANTE_AUX);',
'  :p186_cod_mat_SOLICITANTE     := NVL(:P_MATRICULA_USER,:P186_MAT_SOLICITANTE_AUX);',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(8999501128656635740)
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999539248392635752)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  :p186_usuario        := :p_usuario;',
'  :p186_dt_atualizacao := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');',
'  :p186_dt_sit_req     := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');',
'  :p186_campo_auxiliar := nvl(:p186_cod_sit_req,6);'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(8999500708510635740)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999536767702635751)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of REQ_SERVICO_TERCEIROS'
,p_attribute_02=>'REQ_SERVICO_TERCEIROS'
,p_attribute_03=>'P186_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>unistr('Requisi\00E7\00E3o Efetuada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999538408166635751)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p186_mensagem := null;',
'',
'  pkg_req_servico_terceiros.post_insert(:p186_cod_requisicao, v_flg_retorno, v_msg_retorno); ',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    :p186_ok       := ''N'';',
'    :p186_flag     := v_flg_retorno;',
'    :p186_mensagem := v_msg_retorno;',
'    raise_application_error(-20001,v_msg_retorno);',
' else',
'    :p186_flag     := null;',
'    :p186_mensagem := null;',
'    :p186_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(8999501128656635740)
,p_process_success_message=>unistr('Requisi\00E7\00E3o criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8362840142547291356)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p186_mensagem := null;',
'',
'  pkg_req_servico_terceiros.post_update(:p186_cod_requisicao, v_flg_retorno, v_msg_retorno); ',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    :p186_ok       := ''N'';',
'    :p186_flag     := v_flg_retorno;',
'    :p186_mensagem := v_msg_retorno;',
'    raise_application_error(-20001,v_msg_retorno);',
' else',
'    :p186_flag     := null;',
'    :p186_mensagem := null;',
'    :p186_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(8999500708510635740)
,p_process_success_message=>unistr('Requisi\00E7\00E3o alterada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999536434696635751)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'REQ_SERVICO_TERCEIROS'
,p_attribute_03=>'P186_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P186_COD_REQUISICAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8999536052533635751)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
':p186_campo_auxiliar := :p186_cod_requisicao||'', ''||:p186_cod_sit_req;',
'if :p186_cod_requisicao is null then',
'  :p186_cod_sit_req := 1;',
'end if;',
'end;',
'',
'if :p186_OK is null then',
':p186_OK := ''S'';',
':p186_mensagem := null;',
':p186_flag := null;',
'end if;',
''))
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
