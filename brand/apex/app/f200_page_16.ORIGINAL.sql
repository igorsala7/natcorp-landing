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
--   Date and Time:   20:37 Thursday October 8, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 16
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00016
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>16);
end;
/
prompt --application/pages/page_00016
begin
wwv_flow_api.create_page(
 p_id=>16
,p_user_interface_id=>wwv_flow_api.id(283867044223119591244)
,p_name=>unistr('Informa\00E7\00F5es Funcionais')
,p_step_title=>unistr('Informa\00E7\00F5es Funcionais')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_group_id=>wwv_flow_api.id(283825732202157775951)
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
,p_last_updated_by=>'tmoliveira1'
,p_last_upd_yyyymmddhh24miss=>'20260911112304'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(275490876941923033662)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(271112852010953353541)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(275490876941923033662)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283825738337578800285)
,p_plug_name=>unistr('Informa\00E7\00F5es Pessoais: Colaboradores')
,p_region_name=>'INF_FUNC_PESS'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct  ''Visualizar'' Visualizar, ',
'COD_EMPRESA,            ',
'NOME_EMPRESA            ,',
'MATRICULA            ,',
'NOME                ,',
'sexo                ,',
'initcap(desc_est_civ) Estado_civil           ,',
'dt_nasc                ,',
'initcap(descr_pais_nascimento) descr_pais_nascimento        ,',
'initcap(descr_pais_nacionalidade) descr_pais_nacionalidade    ,',
'initcap(fnct_nome_nacionalidade (nacionalidade)) nacionalidade,',
'uf_nacto            ,',
'Initcap(descr_grp_etnico) descr_grp_etnico       ,',
'Initcap(desc_instr) desc_instr            ,',
'Initcap(nome_formacao) nome_formacao            ,',
'Initcap(nome_logradouro) nome_logradouro            ,',
'Initcap(endereco) endereco            ,',
'numero                ,',
'Initcap(complem) complem                ,',
'Initcap(bairro) bairro                ,',
'Initcap(cidade) cidade                ,',
'uf                ,',
'cep  numero_cep              ,',
'complemento_cep            ,',
'initcap(nome_mae) nome_mae            ,',
' SUBSTR(LPAD(NUM_CPF_MAE,9,0),1,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF_MAE,9,0),4,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF_MAE,9,0),7,3)||''-''||',
' LPAD(DC_CPF_MAE,2,0) NUM_CPF_MAE,',
'initcap(nome_PAI) nome_pai            ,',
' SUBSTR(LPAD(NUM_CPF_PAI,9,0),1,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF_PAI,9,0),4,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF_PAI,9,0),7,3)||''-''||',
' LPAD(DC_CPF_PAI,2,0) NUM_CPF_PAI,',
'initcap(nome_conjuge) nome_conjuge            ,',
' SUBSTR(LPAD(NUM_CPF_CONJUGE,9,0),1,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF_CONJUGE,9,0),4,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF_CONJUGE,9,0),7,3)||''-''||',
' LPAD(DC_CPF_CONJUGE,2,0) NUM_CPF_CONJUGE,',
'ddd                ,',
'telefone            ,',
'ddd_celular            ,',
'celular                ,',
'e_mail_funcional        ,',
'e_mail_pessoal            ,',
'IND_DEF_FIS            ,',
'IND_DEF_FIS_BR            ,',
'RAIS_IND_DEF_AUDITIVA        ,',
'RAIS_IND_DEF_FISICO        ,',
'RAIS_IND_DEF_MENTAL        ,',
'RAIS_IND_DEF_MULTIPLA        ,',
'RAIS_IND_DEF_VISUAL        ,',
'RAIS_IND_DEF_INTELECTUAL,',
'BANCO                ,',
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
'num_cart_prof            ,',
'ser_cart_prof            ,',
'DECODE(mod_cart_prof, ''U'',''Urbano'', ''R'',''Rural'') modelo_CTPS,',
'num_tit_eleitor            ,',
'zon_tit_eleitor            ,',
'sec_tit_eleitor            ,',
'num_pis_pasep            ,',
' SUBSTR(LPAD(NUM_CPF,9,0),1,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF,9,0),4,3)||''.''||',
' SUBSTR(LPAD(NUM_CPF,9,0),7,3)||''-''||',
' LPAD(DC_CPF,2,0) CPF_FUNC,',
'RESIDE_BRASIL            ,',
'CLASS_TRAB_ESTRANG        ,',
'NR_RIC                ,',
'ORGAO_EMIS_RIC            ,',
'DT_EMIS_RIC            ,',
'DT_EMIS_CONS_REG        ,',
'DT_VAL_CONS_REG            ,',
'dt_admissao            ,',
'dt_admissao_basica,',
'situacao,',
'Initcap(nome_situacao) desc_situacao            ,',
'dt_situacao            ,',
'filial                ,',
'Initcap(nome_filial) nome_filial            ,',
'dt_filial            ,',
'cod_ccusto           ,',
'Initcap(nome_ccusto) nome_ccusto            ,',
'dt_ccusto            ,',
'custo_contab ccusto_contab          ,',
'Initcap(nome_ccusto_contab) nome_ccusto_contab        ,',
'CLASS_CCUSTO            ,',
'Initcap(DESCR_CLASS_CCUSTO) descr_class_ccusto        ,',
'COD_UN_NEGOCIO,',
'Initcap(NOME_UN_NEGOCIO) NOME_UN_NEGOCIO,',
'UNIDADE_ADM UNIDADE,',
'Initcap(descr_unid_adm) descr_unid_adm            ,',
'cod_atividade  ,',
'Initcap(desc_atividade) desc_atividade            ,',
'cod_localizacao local_trab            ,',
'descr_local nome_local_trab            ,',
'endereco_local,',
'numero_end_local,',
'compl_end_local,',
'bairro_end_local,',
'cidade_end_local,',
'uf_end_local,',
'cep_end_local,',
'Tipo_ats, descr_ats, dt_base_ats, perc_ats,',
'--ramal1                ,',
'--ramal2                ,',
'--predio                ,',
'--andar                ,',
'--sala                ,',
'cargo                ,',
'Initcap(nome_cargos) nome_cargo            ,',
'dt_cargo            ,',
'funcao   ,',
'Initcap(nome_funcao) nome_funcao            ,',
'dt_cargo dt_funcao            ,',
'cod_cbo                 ,',
'dc_cbo                ,',
'id_cbo,',
'class_cargo            ,',
'cod_grupo_trabalho        ,',
'Initcap(descr_grupo_trab) descr_grupo_trab        ,',
'DECODE (F_Acesso_Salario_Apex (COD_EMPRESA, MATRICULA, FILIAL, :P_USUARIO),''S'', SALARIO,0) SALARIO,',
'DT_SALARIO            ,',
'MOT_ALT_SAL            ,',
'Initcap(DESCR_MOT_SAL) descr_mot_sal            ,',
'PERC_INSALUB            ,',
'PERC_PERIC            ,',
'decode(COD_TIPO_MAO_OBRA,''D'', ''Direta'',''I'',''Indireta'',cod_tipo_mao_obra) cod_tipo_mao_obra        ,',
'Initcap(FNCT_NOME_TIPO_SALARIO(TIPO_SALARIO)) tipo_salario            ,',
'--desc_tipo_salario        ,',
'COD_CATEGORIA            ,',
'COD_CAT_GRUPOS_SALARIAIS    ,',
'GRUPO_SALARIAL            ,',
'PONTO_DE_FX            ,',
'NUM_REGISTRO            ,',
'REGIAO                ,',
'SIGLA_CONS_REG            ,',
'COD_CARGO_CIPA   ,',
'DESCR_CARGO_CIPA        ,',
'vinculo     ,',
'Initcap(nome_vinculo) desc_vinculo         ,',
'SINDICALIZADO            ,',
'NUM_SIND_DISS   ,',
'Initcap(NOME_SINDICATO) nome_sindicato            ,',
'NUM_SIND_CAT            ,',
'Initcap(NOME_SIND_CAT) nome_sind_cat            ,',
'ADTO_SALARIAL            ,',
'PERC_ADIANT            ,',
'CAT_P_SEFIP            ,',
'reg_trab            ,',
'jornada_mensal_h        ,',
'jornada_mensal_m        ,',
'dt_reg_trab            ,',
'COD_HORARIO ,',
'Initcap(DESC_HORARIO) desc_horario,',
'remuneracao_variavel,',
'perc_beneficio_variavel,       ',
'total_remuneracao,',
'marca_ponto,',
'tp_registro_ponto,',
'cod_escala_ponto,',
'desc_escala_ponto,',
unistr('decode(escala_excecao,''S'',''Sim'',''N'',''N\00E3o'') escala_excecao,'),
'dt_ini_escala,',
'dt_fim_escala,',
'cod_jorn_ponto,',
'desc_jorn_ponto,',
'cod_local_ponto,',
'desc_local_ponto,',
'endereco_ponto,',
'numero_end_ponto,',
'compl_end_ponto,',
'bairro_end_ponto,',
'cidade_end_ponto,',
'uf_end_ponto,',
'cep_end_ponto,',
'cod_param_bh,',
'descricao_bh,',
'nr_cracha,',
'cad_vaga,',
'ind_contrato,',
'dt_contrato,',
'dt_prorrog,',
'qtd_dias_prorrog,',
'qtd_dias_vencidos,',
'matricula_esocial,',
'tipo_adesao,',
'dt_acordo,',
'percent_reducao_carga_horaria,',
'dias_duracao,',
'outros_vencimentos,',
'case when :p_base <> ''STEFANINI'' then FNCT_EMP_ANT(NUM_CPF, DT_SITUACAO) else null end Cod_Empresa_Anterior,',
'case when :p_base <> ''STEFANINI'' then FNCT_MAT_ANT(NUM_CPF, DT_SITUACAO) else null end Matricula_Anterior,',
'cod_aposentadoria tipo_adesao_prev, ',
'IND_APOSENTADO,',
'ind_avprev_indeniz tipo_aviso_previo,',
'dt_aviso data_aviso_previo,',
'decode(tipo_modalidade,''P'',''Presencial'',''H'',''Home-Office'',''S'',''Semi-Presencial'',''T'',''Teletrabalho'') tipo_modalidade,',
'dt_tipo_modalidade,',
'mot_alt_tipo_modalidade,',
'vlr_aux_tipo_modalidade,',
'dt_vlr_aux_tipo_modalidade,',
'mot_alt_vlr_aux_tp_modalidade,',
'cod_categoria_contab,',
'descricao_ccc desc_categoria_contab, ',
'descricao_class desc_class_cargo,',
'identidade,',
'digito_identidade,',
'orgao_emiss_identidade,',
'naturalidade,',
'uf_nascimento,',
'CNPJ_EMPRESA,',
'CNPJ_FILIAL,',
'trab_intermitente, ',
'tipo_vinculo_empreg, ',
'desc_tipo_vinculo_empreg, ',
'cat_vinculo, ',
'desc_cat_vinculo,',
'CNH,',
'N_REGISTRO_CNH,',
'CATEGORIA_CNH,',
'DT_VALID_CNH,',
'COD_CANDIDATO,',
'MOT_ALT_SITUACAO,',
'DESCR_MOT_SIT,',
unistr('decode(IND_CONTR_SINDICAL, ''S'', ''Sim'', ''N'', ''N\00E3o'') IND_CONTR_SINDICAL,'),
unistr('decode(DESC_CONTRIB_ASSIST, ''S'', ''Sim'', ''N'', ''N\00E3o'') DESC_CONTRIB_ASSIST,'),
'NOME_SOCIAL NOME_SOCIAL,',
'CERTIF_RESERV,',
unistr('decode(class_trab_estrang,1,''Refugiado'',2, ''Solicitante de ref\00FAgio'',3,''Perman\00EAncia no Brasil em raz\00E3o de reuni\00E3o familiar'',4,''Beneficiado pelo acordo entre pa\00EDses do Mercosul'',5,''Dependente de agente diplom\00E1tico e/ou consular de'',6,''Beneficiado pelo ')
||unistr('Tratado de Amizade, Coopera\00E7\00E3o e'',7,''Outra condi\00E7\00E3o'') classif_estrangeiro,'),
'decode(tmpresid,1,''Prazo indeterminado'',2,''Prazo determinado'') tempo_residencia,',
unistr('decode(infocota,''S'',''Sim'',''N'',''N\00E3o'') infocota,'),
'(select b.codigo_tip||''-''||b.descricao_tip',
'   from tipo_de_vinculo_func a,',
'        tipo_de_vinculo b',
'  where a.cod_empresa = i.cod_empresa',
'    and a.matricula = i.matricula',
'    and a.cod_filial = i.filial',
'    and b.cod_empresa = a.cod_empresa',
unistr('    and b.codigo_tip = a.codigo_tip) tipo_vinculo /*ch44585, atualmente na INCOR n\00E3o h\00E1 mais de um tipo de vinculo por filial por isso foi add esta coluna*/'),
'   ',
'FROM VW_CONSULTA_PESS_FUNC_V1 I',
'WHERE (:P16_MAT IS NULL OR (COD_EMPRESA = :P16_EMP AND MATRICULA = :P16_MAT))',
'  and ((situacao < ''90'' and :p16_situacao = ''A'') or (situacao >= ''90'' and :p16_situacao = ''D'') or (:p16_situacao = ''T''))',
'   and (:P16_EMPRESA     is null or cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_EMPRESA, '','')) t))',
'   and (:P16_FILIAL      is null or filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_FILIAL, '','')) t))',
'   and (:P16_CCUSTO      is null or cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_CCUSTO, '','')) t))',
'   and (:P16_UNIDADE_ADM is null or unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_UNIDADE_ADM, '','')) t))',
'   and (:P16_ATIVIDADE   is null or cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_ATIVIDADE, '','')) t))',
'   and (:P16_CARGO       is null or cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_CARGO, '','')) t))',
'   and (:P16_MATRICULA   is null or matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_MATRICULA, '','')) t))',
'   and :P16_PESQUISA = ''S''',
'  --and F_Acesso_PG_Apex(cod_empresa, matricula, filial, cd_nivel, :p_usuario, :p_painel) = ''S''',
'AND ((I.COD_EMPRESA = :P_EMPRESA_USER AND I.MATRICULA = :P_MATRICULA_USER)',
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
'           ))',
'-- Chamado 30620 - Inclusao de filtro para nao duplicar o colaborador em funcao do ccusto - 31-07-2023 - Andre',
'and not exists (select 1',
'            from distribuicao_custo',
'            where cod_empresa = i.cod_empresa',
'            and matricula = i.matricula',
'            --and cod_ccusto_contab =  I.cod_ccusto',
'                and cod_ccusto_contab =  I.custo_contab',
'            and origem = 3)',
'           ',
' order by cod_empresa, situacao, matricula'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P16_SITUACAO,P16_EMP,P16_MAT,P16_PESQUISA,P16_CARGO'
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
,p_plug_caching=>'SESSION'
,p_plug_caching_max_age_in_sec=>60
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(283825738756662800289)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'Para mais resultados, filtre sua consulta.'
,p_allow_save_rpt_public=>'Y'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_fixed_header=>'NONE'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.:RP,17:P17_EMP,P17_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>52256991102113939
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825780717623800362)
,p_db_column_name=>'VISUALIZAR'
,p_display_order=>10
,p_column_identifier=>'DX'
,p_column_label=>'Visualizar'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825738766134800294)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825749512041800313)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Nome Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825760338195800335)
,p_db_column_name=>'FILIAL'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825771081888800347)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Nome Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825781107009800362)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'C. Custo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825781522843800362)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Nome C.Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825781913787800363)
,p_db_column_name=>'MATRICULA'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#MATRICULA#'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825783894494800365)
,p_db_column_name=>'NOME'
,p_display_order=>90
,p_column_identifier=>'O'
,p_column_label=>'Nome'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#NOME#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825782314008800363)
,p_db_column_name=>'CARGO'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825782691384800363)
,p_db_column_name=>'NOME_CARGO'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'Nome Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825783117619800364)
,p_db_column_name=>'SITUACAO'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825783489000800364)
,p_db_column_name=>'VINCULO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825784343597800365)
,p_db_column_name=>'SEXO'
,p_display_order=>140
,p_column_identifier=>'P'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825784676490800365)
,p_db_column_name=>'ESTADO_CIVIL'
,p_display_order=>150
,p_column_identifier=>'Q'
,p_column_label=>'Estado Civil'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825785068302800366)
,p_db_column_name=>'DT_NASC'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Data de Nascimento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825785540516800366)
,p_db_column_name=>'DESCR_PAIS_NASCIMENTO'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>unistr('Pa\00EDs Nascimento')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825785929125800366)
,p_db_column_name=>'DESCR_PAIS_NACIONALIDADE'
,p_display_order=>180
,p_column_identifier=>'T'
,p_column_label=>unistr('Pa\00EDs Nacionalidade')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825786344675800367)
,p_db_column_name=>'NACIONALIDADE'
,p_display_order=>190
,p_column_identifier=>'U'
,p_column_label=>'Nacionalidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825786680800800367)
,p_db_column_name=>'UF_NACTO'
,p_display_order=>200
,p_column_identifier=>'V'
,p_column_label=>'UF Nacto.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825787075827800368)
,p_db_column_name=>'DESCR_GRP_ETNICO'
,p_display_order=>210
,p_column_identifier=>'W'
,p_column_label=>unistr('Grupo \00C9tnico')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825787498435800369)
,p_db_column_name=>'DESC_INSTR'
,p_display_order=>220
,p_column_identifier=>'X'
,p_column_label=>unistr('Instru\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825787883126800369)
,p_db_column_name=>'NOME_FORMACAO'
,p_display_order=>230
,p_column_identifier=>'Y'
,p_column_label=>unistr('Nome Forma\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825788329166800370)
,p_db_column_name=>'NOME_LOGRADOURO'
,p_display_order=>240
,p_column_identifier=>'Z'
,p_column_label=>'Logradouro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825739259359800300)
,p_db_column_name=>'ENDERECO'
,p_display_order=>250
,p_column_identifier=>'AA'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825740061719800301)
,p_db_column_name=>'COMPLEM'
,p_display_order=>270
,p_column_identifier=>'AC'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825740410280800301)
,p_db_column_name=>'BAIRRO'
,p_display_order=>280
,p_column_identifier=>'AD'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825740802205800301)
,p_db_column_name=>'CIDADE'
,p_display_order=>290
,p_column_identifier=>'AE'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825741209748800302)
,p_db_column_name=>'UF'
,p_display_order=>300
,p_column_identifier=>'AF'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825742375451800303)
,p_db_column_name=>'NOME_MAE'
,p_display_order=>330
,p_column_identifier=>'AI'
,p_column_label=>unistr('Nome M\00E3e')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283736509644184502412)
,p_db_column_name=>'NOME_PAI'
,p_display_order=>360
,p_column_identifier=>'EA'
,p_column_label=>'Nome pai'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283736509991205502415)
,p_db_column_name=>'NOME_CONJUGE'
,p_display_order=>390
,p_column_identifier=>'ED'
,p_column_label=>'Nome conjuge'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825742781904800303)
,p_db_column_name=>'DDD'
,p_display_order=>420
,p_column_identifier=>'AJ'
,p_column_label=>'DDD'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825743178201800304)
,p_db_column_name=>'TELEFONE'
,p_display_order=>430
,p_column_identifier=>'AK'
,p_column_label=>'Telefone'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825743635520800304)
,p_db_column_name=>'DDD_CELULAR'
,p_display_order=>440
,p_column_identifier=>'AL'
,p_column_label=>'DDD Celular'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825744013456800305)
,p_db_column_name=>'CELULAR'
,p_display_order=>450
,p_column_identifier=>'AM'
,p_column_label=>'Celular'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825744456046800306)
,p_db_column_name=>'E_MAIL_FUNCIONAL'
,p_display_order=>460
,p_column_identifier=>'AN'
,p_column_label=>'E-mail Funcional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825744700630800306)
,p_db_column_name=>'E_MAIL_PESSOAL'
,p_display_order=>470
,p_column_identifier=>'AO'
,p_column_label=>'E-mail Pessoal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825745076829800306)
,p_db_column_name=>'IND_DEF_FIS'
,p_display_order=>480
,p_column_identifier=>'AP'
,p_column_label=>'Deficiente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825745501251800308)
,p_db_column_name=>'IND_DEF_FIS_BR'
,p_display_order=>490
,p_column_identifier=>'AQ'
,p_column_label=>'Deficiente Reabilitado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825745955973800309)
,p_db_column_name=>'RAIS_IND_DEF_AUDITIVA'
,p_display_order=>500
,p_column_identifier=>'AR'
,p_column_label=>'Deficiente Auditivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825746292134800309)
,p_db_column_name=>'RAIS_IND_DEF_FISICO'
,p_display_order=>510
,p_column_identifier=>'AS'
,p_column_label=>unistr('Deficiente F\00EDsico')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825746682106800309)
,p_db_column_name=>'RAIS_IND_DEF_MENTAL'
,p_display_order=>520
,p_column_identifier=>'AT'
,p_column_label=>'Deficiente Mental'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825747108851800310)
,p_db_column_name=>'RAIS_IND_DEF_MULTIPLA'
,p_display_order=>530
,p_column_identifier=>'AU'
,p_column_label=>unistr('Deficiente M\00FAltiplo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825747509642800310)
,p_db_column_name=>'RAIS_IND_DEF_VISUAL'
,p_display_order=>540
,p_column_identifier=>'AV'
,p_column_label=>'Deficiente Visual'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(104309997370402340646)
,p_db_column_name=>'RAIS_IND_DEF_INTELECTUAL'
,p_display_order=>550
,p_column_identifier=>'IG'
,p_column_label=>'Deficiente Intelectual'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825747963775800310)
,p_db_column_name=>'BANCO'
,p_display_order=>560
,p_column_identifier=>'AW'
,p_column_label=>'Banco'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825748266332800311)
,p_db_column_name=>'AGENCIA'
,p_display_order=>570
,p_column_identifier=>'AX'
,p_column_label=>unistr('Ag\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825748690327800311)
,p_db_column_name=>'NUM_CONTA'
,p_display_order=>580
,p_column_identifier=>'AY'
,p_column_label=>unistr('N\00BA Conta')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825749092048800311)
,p_db_column_name=>'DC_CONTA'
,p_display_order=>590
,p_column_identifier=>'AZ'
,p_column_label=>unistr('D\00EDgito Conta')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825749946306800313)
,p_db_column_name=>'MODALIDADE'
,p_display_order=>600
,p_column_identifier=>'BA'
,p_column_label=>'Modalidade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825750329262800313)
,p_db_column_name=>'TIPO_CONTA'
,p_display_order=>610
,p_column_identifier=>'BB'
,p_column_label=>'Tipo Conta'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825750749251800314)
,p_db_column_name=>'DESCR_TP_BANC'
,p_display_order=>620
,p_column_identifier=>'BC'
,p_column_label=>'Desc. Tipo de Conta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825751117385800314)
,p_db_column_name=>'NUM_IDENTIDADE'
,p_display_order=>630
,p_column_identifier=>'BD'
,p_column_label=>unistr('N\00BA Identidade')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825751479864800314)
,p_db_column_name=>'TIPO_IDENT'
,p_display_order=>640
,p_column_identifier=>'BE'
,p_column_label=>'Tipo Identidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825751964047800315)
,p_db_column_name=>'EMISSAO_IDENT'
,p_display_order=>650
,p_column_identifier=>'BF'
,p_column_label=>unistr('Data de Emiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825752291609800316)
,p_db_column_name=>'EST_EMIS_IDENT'
,p_display_order=>660
,p_column_identifier=>'BG'
,p_column_label=>unistr('Estado de Emiss\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825752673491800321)
,p_db_column_name=>'NUM_CART_PROF'
,p_display_order=>670
,p_column_identifier=>'BH'
,p_column_label=>unistr('N\00FAmero de Carteira Profissional')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825753108586800322)
,p_db_column_name=>'SER_CART_PROF'
,p_display_order=>680
,p_column_identifier=>'BI'
,p_column_label=>unistr('S\00E9rie de Carteira Profissional')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(18619064405899670580)
,p_db_column_name=>'MODELO_CTPS'
,p_display_order=>690
,p_column_identifier=>'IP'
,p_column_label=>'Modelo de Carteira Profissional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825753508380800322)
,p_db_column_name=>'NUM_TIT_ELEITOR'
,p_display_order=>700
,p_column_identifier=>'BJ'
,p_column_label=>unistr('N\00FAmero de T\00EDtulo de Eleitor')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825753865821800326)
,p_db_column_name=>'ZON_TIT_ELEITOR'
,p_display_order=>710
,p_column_identifier=>'BK'
,p_column_label=>unistr('Zona de T\00EDtulo de Eleitor')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825754322384800327)
,p_db_column_name=>'SEC_TIT_ELEITOR'
,p_display_order=>720
,p_column_identifier=>'BL'
,p_column_label=>unistr('Se\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825754726647800327)
,p_db_column_name=>'NUM_PIS_PASEP'
,p_display_order=>730
,p_column_identifier=>'BM'
,p_column_label=>'PIS/PASEP'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825755111655800327)
,p_db_column_name=>'CPF_FUNC'
,p_display_order=>740
,p_column_identifier=>'BN'
,p_column_label=>unistr('N\00FAmero de CPF')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825755503713800328)
,p_db_column_name=>'RESIDE_BRASIL'
,p_display_order=>750
,p_column_identifier=>'BO'
,p_column_label=>'Reside Brasil'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825755879869800328)
,p_db_column_name=>'CLASS_TRAB_ESTRANG'
,p_display_order=>760
,p_column_identifier=>'BP'
,p_column_label=>unistr('Classifica\00E7\00E3o Estrangeiro')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825756350419800328)
,p_db_column_name=>'NR_RIC'
,p_display_order=>770
,p_column_identifier=>'BQ'
,p_column_label=>unistr('Registro de Identifica\00E7\00E3o Civil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825756722425800329)
,p_db_column_name=>'ORGAO_EMIS_RIC'
,p_display_order=>780
,p_column_identifier=>'BR'
,p_column_label=>unistr('\00D3rg\00E3o Emissor RIC')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825757111632800329)
,p_db_column_name=>'DT_EMIS_RIC'
,p_display_order=>790
,p_column_identifier=>'BS'
,p_column_label=>unistr('Data de Emiss\00E3o de RIC')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825757487199800330)
,p_db_column_name=>'DT_EMIS_CONS_REG'
,p_display_order=>800
,p_column_identifier=>'BT'
,p_column_label=>unistr('Data de Emiss\00E3o de Conselho Regional')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825757944531800330)
,p_db_column_name=>'DT_VAL_CONS_REG'
,p_display_order=>810
,p_column_identifier=>'BU'
,p_column_label=>'Data de Validade de Conselho Regional'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825758321859800331)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>820
,p_column_identifier=>'BV'
,p_column_label=>unistr('Data de Admiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825758738797800332)
,p_db_column_name=>'DESC_SITUACAO'
,p_display_order=>830
,p_column_identifier=>'BW'
,p_column_label=>unistr('Desc. Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825759079319800334)
,p_db_column_name=>'DT_SITUACAO'
,p_display_order=>840
,p_column_identifier=>'BX'
,p_column_label=>unistr('Data de Situa\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825759553897800335)
,p_db_column_name=>'DT_FILIAL'
,p_display_order=>850
,p_column_identifier=>'BY'
,p_column_label=>'Data Filial'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825759888896800335)
,p_db_column_name=>'DT_CCUSTO'
,p_display_order=>860
,p_column_identifier=>'BZ'
,p_column_label=>'Data C.Custo'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825760763253800336)
,p_db_column_name=>'CCUSTO_CONTAB'
,p_display_order=>870
,p_column_identifier=>'CA'
,p_column_label=>'C.Custo Contab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825761092008800337)
,p_db_column_name=>'NOME_CCUSTO_CONTAB'
,p_display_order=>880
,p_column_identifier=>'CB'
,p_column_label=>'Nome C.custo Contab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825761560412800337)
,p_db_column_name=>'CLASS_CCUSTO'
,p_display_order=>890
,p_column_identifier=>'CC'
,p_column_label=>'Classe C.Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825761873932800338)
,p_db_column_name=>'DESCR_CLASS_CCUSTO'
,p_display_order=>900
,p_column_identifier=>'CD'
,p_column_label=>'Desc. Classe C.Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96003218794804492632)
,p_db_column_name=>'COD_UN_NEGOCIO'
,p_display_order=>910
,p_column_identifier=>'II'
,p_column_label=>'Cod Un Negocio'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96003218836913492633)
,p_db_column_name=>'NOME_UN_NEGOCIO'
,p_display_order=>920
,p_column_identifier=>'IJ'
,p_column_label=>'Nome Un Negocio'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96003218934244492634)
,p_db_column_name=>'UNIDADE'
,p_display_order=>930
,p_column_identifier=>'IK'
,p_column_label=>unistr('C\00F3d.Unidade Adm')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825762736413800338)
,p_db_column_name=>'DESCR_UNID_ADM'
,p_display_order=>940
,p_column_identifier=>'CF'
,p_column_label=>'Desc. Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825763081692800339)
,p_db_column_name=>'DT_CARGO'
,p_display_order=>950
,p_column_identifier=>'CG'
,p_column_label=>'Data Cargo'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825763546084800339)
,p_db_column_name=>'FUNCAO'
,p_display_order=>960
,p_column_identifier=>'CH'
,p_column_label=>unistr('Fun\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825763922653800340)
,p_db_column_name=>'NOME_FUNCAO'
,p_display_order=>970
,p_column_identifier=>'CI'
,p_column_label=>unistr('Nome Fun\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825764341717800341)
,p_db_column_name=>'DT_FUNCAO'
,p_display_order=>980
,p_column_identifier=>'CJ'
,p_column_label=>unistr('Data Fun\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825764715552800341)
,p_db_column_name=>'COD_CBO'
,p_display_order=>990
,p_column_identifier=>'CK'
,p_column_label=>unistr('C\00F3d. CBO')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825765474545800342)
,p_db_column_name=>'CLASS_CARGO'
,p_display_order=>1000
,p_column_identifier=>'CM'
,p_column_label=>'Class. Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825766301753800343)
,p_db_column_name=>'DESCR_GRUPO_TRAB'
,p_display_order=>1010
,p_column_identifier=>'CO'
,p_column_label=>'Desc. Grupo Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825766702899800343)
,p_db_column_name=>'SALARIO'
,p_display_order=>1020
,p_column_identifier=>'CP'
,p_column_label=>unistr('Sal\00E1rio')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825767066163800343)
,p_db_column_name=>'DT_SALARIO'
,p_display_order=>1030
,p_column_identifier=>'CQ'
,p_column_label=>unistr('Data Sal\00E1rio')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825767555435800344)
,p_db_column_name=>'MOT_ALT_SAL'
,p_display_order=>1040
,p_column_identifier=>'CR'
,p_column_label=>unistr('Motivo Altera\00E7\00E3o Sal\00E1rial')
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825767962881800344)
,p_db_column_name=>'DESCR_MOT_SAL'
,p_display_order=>1050
,p_column_identifier=>'CS'
,p_column_label=>unistr('Desc. Motivo Altera\00E7\00E3o Sal\00E1rial')
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825768285603800344)
,p_db_column_name=>'PERC_INSALUB'
,p_display_order=>1060
,p_column_identifier=>'CT'
,p_column_label=>'% Insalubridade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825768742158800345)
,p_db_column_name=>'PERC_PERIC'
,p_display_order=>1070
,p_column_identifier=>'CU'
,p_column_label=>'% Periculosidade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825769076754800345)
,p_db_column_name=>'COD_TIPO_MAO_OBRA'
,p_display_order=>1080
,p_column_identifier=>'CV'
,p_column_label=>unistr('C\00F3d. Tipo M\00E3o de Obra')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825769505936800345)
,p_db_column_name=>'TIPO_SALARIO'
,p_display_order=>1090
,p_column_identifier=>'CW'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825769931881800346)
,p_db_column_name=>'COD_CATEGORIA'
,p_display_order=>1100
,p_column_identifier=>'CX'
,p_column_label=>unistr('C\00F3d. Categoria')
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825770302118800347)
,p_db_column_name=>'COD_CAT_GRUPOS_SALARIAIS'
,p_display_order=>1110
,p_column_identifier=>'CY'
,p_column_label=>unistr('C\00F3d. Categoria Grupos Salariais')
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825770681247800347)
,p_db_column_name=>'GRUPO_SALARIAL'
,p_display_order=>1120
,p_column_identifier=>'CZ'
,p_column_label=>'Grupo Salarial'
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825771498117800349)
,p_db_column_name=>'PONTO_DE_FX'
,p_display_order=>1130
,p_column_identifier=>'DA'
,p_column_label=>'Ponto de Faixa'
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825772317347800349)
,p_db_column_name=>'REGIAO'
,p_display_order=>1140
,p_column_identifier=>'DC'
,p_column_label=>unistr('Regi\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825772757293800350)
,p_db_column_name=>'SIGLA_CONS_REG'
,p_display_order=>1150
,p_column_identifier=>'DD'
,p_column_label=>'Sigla Conselho Regional'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825773129955800350)
,p_db_column_name=>'COD_CARGO_CIPA'
,p_display_order=>1160
,p_column_identifier=>'DE'
,p_column_label=>unistr('C\00F3d. Cargo CIPA')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825773524857800350)
,p_db_column_name=>'DESCR_CARGO_CIPA'
,p_display_order=>1170
,p_column_identifier=>'DF'
,p_column_label=>'Desc. Cargo CIPA'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825773933553800351)
,p_db_column_name=>'DESC_VINCULO'
,p_display_order=>1180
,p_column_identifier=>'DG'
,p_column_label=>unistr('Desc. V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825774344097800351)
,p_db_column_name=>'SINDICALIZADO'
,p_display_order=>1190
,p_column_identifier=>'DH'
,p_column_label=>'Sindicalizado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825774739333800351)
,p_db_column_name=>'NUM_SIND_DISS'
,p_display_order=>1200
,p_column_identifier=>'DI'
,p_column_label=>unistr('N\00BA Sind. Diss.')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825775065622800352)
,p_db_column_name=>'NOME_SINDICATO'
,p_display_order=>1210
,p_column_identifier=>'DJ'
,p_column_label=>'Nome Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825775472428800353)
,p_db_column_name=>'NUM_SIND_CAT'
,p_display_order=>1220
,p_column_identifier=>'DK'
,p_column_label=>unistr('N\00BA Sind. Cat.')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825775895876800353)
,p_db_column_name=>'NOME_SIND_CAT'
,p_display_order=>1230
,p_column_identifier=>'DL'
,p_column_label=>'Nome Sindicato Cat.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825776333295800353)
,p_db_column_name=>'ADTO_SALARIAL'
,p_display_order=>1240
,p_column_identifier=>'DM'
,p_column_label=>'Adto. Salarial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825776707617800354)
,p_db_column_name=>'PERC_ADIANT'
,p_display_order=>1250
,p_column_identifier=>'DN'
,p_column_label=>'% Adiantamento'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825777111273800355)
,p_db_column_name=>'CAT_P_SEFIP'
,p_display_order=>1260
,p_column_identifier=>'DO'
,p_column_label=>'Categoria Sefip'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825777505319800355)
,p_db_column_name=>'REG_TRAB'
,p_display_order=>1270
,p_column_identifier=>'DP'
,p_column_label=>'Regime de Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825777905210800356)
,p_db_column_name=>'JORNADA_MENSAL_H'
,p_display_order=>1280
,p_column_identifier=>'DQ'
,p_column_label=>'Jornada Mensal Horas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825778364084800357)
,p_db_column_name=>'JORNADA_MENSAL_M'
,p_display_order=>1290
,p_column_identifier=>'DR'
,p_column_label=>'Jornada Mensal Minutos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825778727641800358)
,p_db_column_name=>'DT_REG_TRAB'
,p_display_order=>1300
,p_column_identifier=>'DS'
,p_column_label=>'Data Regime Trabalho'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825779078770800359)
,p_db_column_name=>'COD_HORARIO'
,p_display_order=>1310
,p_column_identifier=>'DT'
,p_column_label=>unistr('C\00F3d. Hor\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825779535819800359)
,p_db_column_name=>'DESC_HORARIO'
,p_display_order=>1320
,p_column_identifier=>'DU'
,p_column_label=>unistr('Desc. Hor\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825779891349800359)
,p_db_column_name=>'LOCAL_TRAB'
,p_display_order=>1330
,p_column_identifier=>'DV'
,p_column_label=>unistr('C\00F3d. Local Trab.')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283825780317897800360)
,p_db_column_name=>'NOME_LOCAL_TRAB'
,p_display_order=>1340
,p_column_identifier=>'DW'
,p_column_label=>'Nome Local Trab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274748283316737549545)
,p_db_column_name=>'ENDERECO_LOCAL'
,p_display_order=>1350
,p_column_identifier=>'FE'
,p_column_label=>unistr('Endere\00E7o Local Trab.')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274748283435026549546)
,p_db_column_name=>'NUMERO_END_LOCAL'
,p_display_order=>1360
,p_column_identifier=>'FF'
,p_column_label=>unistr('N\00FAmero Local Trab.')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274748283565237549547)
,p_db_column_name=>'COMPL_END_LOCAL'
,p_display_order=>1370
,p_column_identifier=>'FG'
,p_column_label=>'Complemento Local Trab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274748283578632549548)
,p_db_column_name=>'BAIRRO_END_LOCAL'
,p_display_order=>1380
,p_column_identifier=>'FH'
,p_column_label=>'Bairro Local Trab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274767948699608663699)
,p_db_column_name=>'CIDADE_END_LOCAL'
,p_display_order=>1390
,p_column_identifier=>'FI'
,p_column_label=>'Cidade Local Trab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274767948854212663700)
,p_db_column_name=>'UF_END_LOCAL'
,p_display_order=>1400
,p_column_identifier=>'FJ'
,p_column_label=>'UF Local Trab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274767948953507663701)
,p_db_column_name=>'CEP_END_LOCAL'
,p_display_order=>1410
,p_column_identifier=>'FK'
,p_column_label=>'CEP Local Trab.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283024167249695754989)
,p_db_column_name=>'NUMERO_CEP'
,p_display_order=>1420
,p_column_identifier=>'EG'
,p_column_label=>unistr('N\00FAmero CEP')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283024167318049754990)
,p_db_column_name=>'COMPLEMENTO_CEP'
,p_display_order=>1430
,p_column_identifier=>'EH'
,p_column_label=>'Complemento CEP'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283024167428710754991)
,p_db_column_name=>'NUM_REGISTRO'
,p_display_order=>1440
,p_column_identifier=>'EI'
,p_column_label=>'Num registro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283024167582104754992)
,p_db_column_name=>'REMUNERACAO_VARIAVEL'
,p_display_order=>1450
,p_column_identifier=>'EJ'
,p_column_label=>unistr('Remunera\00E7\00E3o Vari\00E1vel (Benef\00EDcios)')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283024167667067754993)
,p_db_column_name=>'PERC_BENEFICIO_VARIAVEL'
,p_display_order=>1460
,p_column_identifier=>'EK'
,p_column_label=>unistr('% Beneficio Vari\00E1vel')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283024167742763754994)
,p_db_column_name=>'TOTAL_REMUNERACAO'
,p_display_order=>1470
,p_column_identifier=>'EL'
,p_column_label=>unistr('Total Remunera\00E7\00E3o (Sal. + Rem. Var + Outr. Venc.)')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739511693915832836)
,p_db_column_name=>'COD_JORN_PONTO'
,p_display_order=>1480
,p_column_identifier=>'EM'
,p_column_label=>unistr('C\00F3d. Jornada Ponto')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739511831085832837)
,p_db_column_name=>'DESC_JORN_PONTO'
,p_display_order=>1490
,p_column_identifier=>'EN'
,p_column_label=>'Desc. Jornada Ponto'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739511925652832838)
,p_db_column_name=>'COD_LOCAL_PONTO'
,p_display_order=>1500
,p_column_identifier=>'EO'
,p_column_label=>unistr('C\00F3d. Local Ponto')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512033017832839)
,p_db_column_name=>'DESC_LOCAL_PONTO'
,p_display_order=>1510
,p_column_identifier=>'EP'
,p_column_label=>'Desc. Local Ponto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512135113832840)
,p_db_column_name=>'ENDERECO_PONTO'
,p_display_order=>1520
,p_column_identifier=>'EQ'
,p_column_label=>unistr('Endere\00E7o Local Ponto')
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512177917832841)
,p_db_column_name=>'NUMERO_END_PONTO'
,p_display_order=>1530
,p_column_identifier=>'ER'
,p_column_label=>unistr('N\00FAmero Local Ponto')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512348221832842)
,p_db_column_name=>'COMPL_END_PONTO'
,p_display_order=>1540
,p_column_identifier=>'ES'
,p_column_label=>'Complemento Local Ponto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512372197832843)
,p_db_column_name=>'BAIRRO_END_PONTO'
,p_display_order=>1550
,p_column_identifier=>'ET'
,p_column_label=>'Bairro Local Ponto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512499374832844)
,p_db_column_name=>'CIDADE_END_PONTO'
,p_display_order=>1560
,p_column_identifier=>'EU'
,p_column_label=>'Cidade Local Ponto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512627770832845)
,p_db_column_name=>'UF_END_PONTO'
,p_display_order=>1570
,p_column_identifier=>'EV'
,p_column_label=>'UF Local Ponto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512745413832846)
,p_db_column_name=>'CEP_END_PONTO'
,p_display_order=>1580
,p_column_identifier=>'EW'
,p_column_label=>'CEP Local Ponto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512791971832847)
,p_db_column_name=>'COD_PARAM_BH'
,p_display_order=>1590
,p_column_identifier=>'EX'
,p_column_label=>unistr('C\00F3d. Param. BH')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274739512891476832848)
,p_db_column_name=>'DESCRICAO_BH'
,p_display_order=>1600
,p_column_identifier=>'EY'
,p_column_label=>unistr('Descri\00E7\00E3o Param. BH')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274742983974643248999)
,p_db_column_name=>'COD_ESCALA_PONTO'
,p_display_order=>1610
,p_column_identifier=>'EZ'
,p_column_label=>unistr('C\00F3d. Escala Ponto')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274742984138766249000)
,p_db_column_name=>'DESC_ESCALA_PONTO'
,p_display_order=>1620
,p_column_identifier=>'FA'
,p_column_label=>'Desc. Escala Ponto'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274742984214594249001)
,p_db_column_name=>'ESCALA_EXCECAO'
,p_display_order=>1630
,p_column_identifier=>'FB'
,p_column_label=>unistr('Escala Exce\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274742984276646249002)
,p_db_column_name=>'DT_INI_ESCALA'
,p_display_order=>1640
,p_column_identifier=>'FC'
,p_column_label=>'Data Escala Inicial'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274742984402813249003)
,p_db_column_name=>'DT_FIM_ESCALA'
,p_display_order=>1650
,p_column_identifier=>'FD'
,p_column_label=>'Data Escala Final'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(274767949005931663702)
,p_db_column_name=>'NR_CRACHA'
,p_display_order=>1660
,p_column_identifier=>'FL'
,p_column_label=>unistr('Crach\00E1')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596589165075089323)
,p_db_column_name=>'NUM_CPF_MAE'
,p_display_order=>1670
,p_column_identifier=>'FM'
,p_column_label=>'Num cpf mae'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596589230063089324)
,p_db_column_name=>'NUM_CPF_PAI'
,p_display_order=>1680
,p_column_identifier=>'FN'
,p_column_label=>'Num cpf pai'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596589401805089325)
,p_db_column_name=>'NUM_CPF_CONJUGE'
,p_display_order=>1690
,p_column_identifier=>'FO'
,p_column_label=>'Num cpf conjuge'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596592256689089354)
,p_db_column_name=>'CAD_VAGA'
,p_display_order=>1700
,p_column_identifier=>'FP'
,p_column_label=>unistr('C\00F3d. Vaga')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596592325841089355)
,p_db_column_name=>'IND_CONTRATO'
,p_display_order=>1710
,p_column_identifier=>'FQ'
,p_column_label=>'Tipo de Contrato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596592457125089356)
,p_db_column_name=>'DT_CONTRATO'
,p_display_order=>1720
,p_column_identifier=>'FR'
,p_column_label=>'Data de Contrato'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596592591844089357)
,p_db_column_name=>'DT_PRORROG'
,p_display_order=>1730
,p_column_identifier=>'FS'
,p_column_label=>unistr('Data de Prorroga\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273596592688352089358)
,p_db_column_name=>'QTD_DIAS_PRORROG'
,p_display_order=>1740
,p_column_identifier=>'FT'
,p_column_label=>unistr('Dias de Prorroga\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273624521371911546630)
,p_db_column_name=>'QTD_DIAS_VENCIDOS'
,p_display_order=>1750
,p_column_identifier=>'FU'
,p_column_label=>'Dias Vencidos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273666705864731615151)
,p_db_column_name=>'MATRICULA_ESOCIAL'
,p_display_order=>1760
,p_column_identifier=>'FV'
,p_column_label=>'Matricula esocial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272411020019476502436)
,p_db_column_name=>'DC_CBO'
,p_display_order=>1770
,p_column_identifier=>'FW'
,p_column_label=>unistr('D\00EDgito CBO')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272411020121558502437)
,p_db_column_name=>'TIPO_ADESAO'
,p_display_order=>1780
,p_column_identifier=>'FX'
,p_column_label=>unistr('Tipo de Ades\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272411020130519502438)
,p_db_column_name=>'DT_ACORDO'
,p_display_order=>1790
,p_column_identifier=>'FY'
,p_column_label=>'Data de Acordo'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272411020251878502439)
,p_db_column_name=>'PERCENT_REDUCAO_CARGA_HORARIA'
,p_display_order=>1800
,p_column_identifier=>'FZ'
,p_column_label=>unistr('% Redu\00E7\00E3o de Carga Hor\00E1ria')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271585141893680732080)
,p_db_column_name=>'DIAS_DURACAO'
,p_display_order=>1810
,p_column_identifier=>'GB'
,p_column_label=>unistr('Dias de Dura\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272658747962077110669)
,p_db_column_name=>'ID_CBO'
,p_display_order=>1820
,p_column_identifier=>'GC'
,p_column_label=>'Id. CBO'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272887259841831257687)
,p_db_column_name=>'OUTROS_VENCIMENTOS'
,p_display_order=>1830
,p_column_identifier=>'GD'
,p_column_label=>'Outros Vencimentos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P16_EMP, :P16_MAT);',
'',
'return v_return;',
'end;'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272887260132542257689)
,p_db_column_name=>'COD_EMPRESA_ANTERIOR'
,p_display_order=>1840
,p_column_identifier=>'GE'
,p_column_label=>unistr('C\00F3d. Empresa Anterior (Transferido)')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_condition=>'P_BASE'
,p_display_condition2=>'STEFANINI'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(272887260137450257690)
,p_db_column_name=>'MATRICULA_ANTERIOR'
,p_display_order=>1850
,p_column_identifier=>'GF'
,p_column_label=>unistr('Matr\00EDcula Anterior (Transferido)')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_condition=>'P_BASE'
,p_display_condition2=>'STEFANINI'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273188671927520285600)
,p_db_column_name=>'TIPO_ADESAO_PREV'
,p_display_order=>1860
,p_column_identifier=>'GG'
,p_column_label=>unistr('Tipo de Ades\00E3o \00E0 Previd\00EAncia')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(273188671999262285601)
,p_db_column_name=>'IND_APOSENTADO'
,p_display_order=>1870
,p_column_identifier=>'GH'
,p_column_label=>'Aposentado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271124977889806351430)
,p_db_column_name=>'TIPO_AVISO_PREVIO'
,p_display_order=>1880
,p_column_identifier=>'GI'
,p_column_label=>unistr('Tipo de Aviso Pr\00E9vio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271124977972048351431)
,p_db_column_name=>'DATA_AVISO_PREVIO'
,p_display_order=>1890
,p_column_identifier=>'GJ'
,p_column_label=>unistr('Data de Aviso Pr\00E9vio')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271232077316469856167)
,p_db_column_name=>'TIPO_MODALIDADE'
,p_display_order=>1900
,p_column_identifier=>'GK'
,p_column_label=>'Tipo de Modalidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271232077464179856168)
,p_db_column_name=>'DT_TIPO_MODALIDADE'
,p_display_order=>1910
,p_column_identifier=>'GL'
,p_column_label=>'Data Tipo de Modalidade'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271232077520822856169)
,p_db_column_name=>'MOT_ALT_TIPO_MODALIDADE'
,p_display_order=>1920
,p_column_identifier=>'GM'
,p_column_label=>'Mot. Alt. Tipo Modalidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271232077684537856170)
,p_db_column_name=>'VLR_AUX_TIPO_MODALIDADE'
,p_display_order=>1930
,p_column_identifier=>'GN'
,p_column_label=>unistr('Valor de Aux\00EDlio (Tipo de Modalidade)')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271232077765985856171)
,p_db_column_name=>'DT_VLR_AUX_TIPO_MODALIDADE'
,p_display_order=>1940
,p_column_identifier=>'GO'
,p_column_label=>unistr('Data Valor Aux\00EDlio (Tipo Modalidade)')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271232077846759856172)
,p_db_column_name=>'MOT_ALT_VLR_AUX_TP_MODALIDADE'
,p_display_order=>1950
,p_column_identifier=>'GP'
,p_column_label=>unistr('Mot. Alt. Valor Aux\00EDlio (Tipo Modalidade)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271430450619864971233)
,p_db_column_name=>'DT_ADMISSAO_BASICA'
,p_display_order=>1960
,p_column_identifier=>'GQ'
,p_column_label=>unistr('Dt. Admiss\00E3o B\00E1sica')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271061231379256831300)
,p_db_column_name=>'COD_ATIVIDADE'
,p_display_order=>1970
,p_column_identifier=>'GR'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271061231522532831301)
,p_db_column_name=>'DESC_ATIVIDADE'
,p_display_order=>1980
,p_column_identifier=>'GS'
,p_column_label=>unistr('Desc. Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270649386019110075412)
,p_db_column_name=>'COD_CATEGORIA_CONTAB'
,p_display_order=>1990
,p_column_identifier=>'GT'
,p_column_label=>unistr('C\00F3d. Categoria Cont\00E1bil')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270649386123346075413)
,p_db_column_name=>'DESC_CLASS_CARGO'
,p_display_order=>2000
,p_column_identifier=>'GU'
,p_column_label=>'Descr. Class. Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270649386199109075414)
,p_db_column_name=>'DESC_CATEGORIA_CONTAB'
,p_display_order=>2010
,p_column_identifier=>'GV'
,p_column_label=>unistr('Desc. Categoria Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270037561284729247383)
,p_db_column_name=>'IDENTIDADE'
,p_display_order=>2020
,p_column_identifier=>'GW'
,p_column_label=>'Identidade'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270037561376575247384)
,p_db_column_name=>'DIGITO_IDENTIDADE'
,p_display_order=>2030
,p_column_identifier=>'GX'
,p_column_label=>'Digito Identidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270037561458882247385)
,p_db_column_name=>'ORGAO_EMISS_IDENTIDADE'
,p_display_order=>2040
,p_column_identifier=>'GY'
,p_column_label=>'Orgao Emiss Identidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270037561552397247386)
,p_db_column_name=>'NATURALIDADE'
,p_display_order=>2050
,p_column_identifier=>'GZ'
,p_column_label=>'Naturalidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(270037561621875247387)
,p_db_column_name=>'UF_NASCIMENTO'
,p_display_order=>2060
,p_column_identifier=>'HA'
,p_column_label=>'Uf Nascimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(265990065580580731145)
,p_db_column_name=>'MARCA_PONTO'
,p_display_order=>2070
,p_column_identifier=>'HB'
,p_column_label=>'Marca Ponto'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(265990065636947731146)
,p_db_column_name=>'TP_REGISTRO_PONTO'
,p_display_order=>2080
,p_column_identifier=>'HC'
,p_column_label=>'Tipo Registro Ponto'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261067500241160646054)
,p_db_column_name=>'TRAB_INTERMITENTE'
,p_display_order=>2090
,p_column_identifier=>'HD'
,p_column_label=>'Trabalho Intermitente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261067500339720646055)
,p_db_column_name=>'TIPO_VINCULO_EMPREG'
,p_display_order=>2100
,p_column_identifier=>'HE'
,p_column_label=>unistr('Tipo de V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261067500451576646056)
,p_db_column_name=>'DESC_TIPO_VINCULO_EMPREG'
,p_display_order=>2110
,p_column_identifier=>'HF'
,p_column_label=>unistr('Desc. Tipo de V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261067500527969646057)
,p_db_column_name=>'CAT_VINCULO'
,p_display_order=>2120
,p_column_identifier=>'HG'
,p_column_label=>unistr('Categoria do V\00EDnculo')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261067500696127646058)
,p_db_column_name=>'DESC_CAT_VINCULO'
,p_display_order=>2130
,p_column_identifier=>'HH'
,p_column_label=>unistr('Desc. Categoria do V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261094568091908776230)
,p_db_column_name=>'CNPJ_EMPRESA'
,p_display_order=>2140
,p_column_identifier=>'HJ'
,p_column_label=>'CNPJ Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(261094568145543776231)
,p_db_column_name=>'CNPJ_FILIAL'
,p_display_order=>2150
,p_column_identifier=>'HK'
,p_column_label=>'CNPJ Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256241521755044510803)
,p_db_column_name=>'TIPO_ATS'
,p_display_order=>2160
,p_column_identifier=>'HL'
,p_column_label=>'Tipo ATS'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256241521875572510804)
,p_db_column_name=>'DESCR_ATS'
,p_display_order=>2170
,p_column_identifier=>'HM'
,p_column_label=>unistr('Descri\00E7\00E3o ATS')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256241522002424510805)
,p_db_column_name=>'DT_BASE_ATS'
,p_display_order=>2180
,p_column_identifier=>'HN'
,p_column_label=>'Dt. Base ATS'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(256241522048411510806)
,p_db_column_name=>'PERC_ATS'
,p_display_order=>2190
,p_column_identifier=>'HO'
,p_column_label=>'% ATS'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(238791040709558992503)
,p_db_column_name=>'CNH'
,p_display_order=>2200
,p_column_identifier=>'HQ'
,p_column_label=>'CNH'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(238791040853167992504)
,p_db_column_name=>'N_REGISTRO_CNH'
,p_display_order=>2210
,p_column_identifier=>'HR'
,p_column_label=>unistr('N\00BA Registro CNH')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(238791040992177992505)
,p_db_column_name=>'CATEGORIA_CNH'
,p_display_order=>2220
,p_column_identifier=>'HS'
,p_column_label=>'Categoria CNH'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(238791041007194992506)
,p_db_column_name=>'DT_VALID_CNH'
,p_display_order=>2230
,p_column_identifier=>'HT'
,p_column_label=>'Dt. Validade CNH'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(223984358848742605833)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>2240
,p_column_identifier=>'HV'
,p_column_label=>unistr('C\00F3d. Candidato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149595462978153787686)
,p_db_column_name=>'COD_GRUPO_TRABALHO'
,p_display_order=>2250
,p_column_identifier=>'HX'
,p_column_label=>'Cod Grupo Trabalho'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148960509382068375865)
,p_db_column_name=>'MOT_ALT_SITUACAO'
,p_display_order=>2260
,p_column_identifier=>'HZ'
,p_column_label=>'Mot Alt Situacao'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(148960509485916375866)
,p_db_column_name=>'DESCR_MOT_SIT'
,p_display_order=>2270
,p_column_identifier=>'IA'
,p_column_label=>'Descr Mot Sit'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(139839005134369742063)
,p_db_column_name=>'IND_CONTR_SINDICAL'
,p_display_order=>2280
,p_column_identifier=>'IB'
,p_column_label=>'Pagou Sindicato no Ano ?'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(139839005161978742064)
,p_db_column_name=>'DESC_CONTRIB_ASSIST'
,p_display_order=>2290
,p_column_identifier=>'IC'
,p_column_label=>unistr('Paga Contribui\00E7\00E3o Sindicato ?')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(109784992992682024543)
,p_db_column_name=>'NOME_SOCIAL'
,p_display_order=>2310
,p_column_identifier=>'IF'
,p_column_label=>'Nome Social'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(103488895372437749860)
,p_db_column_name=>'CERTIF_RESERV'
,p_display_order=>2320
,p_column_identifier=>'IH'
,p_column_label=>'Certif Reserv'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(82184941611375929547)
,p_db_column_name=>'CLASSIF_ESTRANGEIRO'
,p_display_order=>2330
,p_column_identifier=>'IL'
,p_column_label=>'Classif Estrangeiro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(82184941718262929548)
,p_db_column_name=>'TEMPO_RESIDENCIA'
,p_display_order=>2340
,p_column_identifier=>'IM'
,p_column_label=>'Tempo Residencia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(82184942665053929557)
,p_db_column_name=>'INFOCOTA'
,p_display_order=>2350
,p_column_identifier=>'IO'
,p_column_label=>'Infocota'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(15825960402987549166)
,p_db_column_name=>'NUMERO'
,p_display_order=>2360
,p_column_identifier=>'IQ'
,p_column_label=>'Numero'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(15825960572694549167)
,p_db_column_name=>'TIPO_VINCULO'
,p_display_order=>2370
,p_column_identifier=>'IR'
,p_column_label=>unistr('Tipo V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' v_ind_duplo_vinculo varchar2(1);',
'begin',
'',
'  begin ',
'   select a.ind_duplo_vinculo',
'     into v_ind_duplo_vinculo',
'     from empresas_cad a',
'    where a.cod_empresa = :P_EMPRESA_USER;',
'  exception',
'     when others then',
'        v_ind_duplo_vinculo := ''N'';',
'  end;  ',
'  ',
'  if v_ind_duplo_vinculo = ''S'' then',
'     return true;',
'  else',
'     return false;',
'  end if;   ',
'    ',
'end; '))
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(271126988763988392147)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>'Colaboradores por Centro de Custo'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'794502'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>20
,p_report_columns=>'NOME_EMPRESA:COD_CCUSTO:NOME_CCUSTO:MATRICULA'
,p_count_columns_on_break=>'MATRICULA'
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(271126989110806392153)
,p_report_id=>wwv_flow_api.id(271126988763988392147)
,p_group_by_columns=>'NOME_EMPRESA:COD_CCUSTO:NOME_CCUSTO'
,p_function_01=>'COUNT'
,p_function_column_01=>'MATRICULA'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>unistr('Contagem de Matr\00EDculas')
,p_function_format_mask_01=>'999G999G999G999G990'
,p_function_sum_01=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(271126989917313401137)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Estagi\00E1rios por Centro de Custo')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'794514'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>20
,p_report_columns=>'NOME_EMPRESA:COD_CCUSTO:NOME_CCUSTO:MATRICULA'
,p_count_columns_on_break=>'MATRICULA'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(271126990336240401139)
,p_report_id=>wwv_flow_api.id(271126989917313401137)
,p_condition_type=>'FILTER'
,p_allow_delete=>'Y'
,p_column_name=>'VINCULO'
,p_operator=>'='
,p_expr=>'E'
,p_condition_sql=>'"VINCULO" = #APXWS_EXPR#'
,p_condition_display=>'#APXWS_COL_NAME# = ''E''  '
,p_enabled=>'Y'
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(271126990715527401139)
,p_report_id=>wwv_flow_api.id(271126989917313401137)
,p_group_by_columns=>'NOME_EMPRESA:COD_CCUSTO:NOME_CCUSTO'
,p_function_01=>'COUNT'
,p_function_column_01=>'MATRICULA'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>unistr('Contagem de Matr\00EDculas')
,p_function_format_mask_01=>'999G999G999G999G990'
,p_function_sum_01=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(283825788713410800370)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'523070'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>20
,p_view_mode=>'REPORT'
,p_report_columns=>'COD_EMPRESA:NOME_EMPRESA:CNPJ_EMPRESA:FILIAL:NOME_FILIAL:CNPJ_FILIAL:COD_CCUSTO:COD_ATIVIDADE:DESC_ATIVIDADE:MATRICULA:NOME:NR_CRACHA:NOME_SOCIAL:MATRICULA_ESOCIAL:COD_CANDIDATO:CARGO:NOME_CARGO:DT_ADMISSAO:CAD_VAGA:TIPO_MODALIDADE:DT_TIPO_MODALIDADE'
||':MOT_ALT_TIPO_MODALIDADE:IND_CONTRATO:DT_CONTRATO:QTD_DIAS_VENCIDOS:DT_PRORROG:QTD_DIAS_PRORROG:SITUACAO:DESC_SITUACAO:DT_SITUACAO:VINCULO:DESC_VINCULO_EMPREG:DESC_TIPO_VINCULO_EMPREG:CAT_VINCULO:DESC_CAT_VINCULO:TRAB_INTERMITENTE:LOCAL_TRAB:NOME_LOC'
||'AL_TRAB:COMPL_END_LOCAL:BAIRRO_END_LOCAL:CIDADE_END_LOCAL:UF_END_LOCAL:CEP_END_LOCAL:TIPO_ATS:DESCR_ATS:DT_BASE_ATS:PERC_ATS:NACIONALIDADE:SEXO:ESTADO_CIVIL:DT_NASC:UF_NACTO:DESCR_PAIS_NASCIMENTO:DESCR_PAIS_NACIONALIDADE:DESCR_GRP_ETNICO:DESC_INSTR:N'
||'OME_FORMACAO:NOME_LOGRADOURO:ENDERECO:COMPLEM:BAIRRO:CIDADE:COMPLEMENTO_CEP:NOME_MAE:DDD:TELEFONE:DDD_CELULAR:CELULAR:E_MAIL_FUNCIONAL:E_MAIL_PESSOAL:IND_DEF_FIS:IND_DEF_FIS_BR:RAIS_IND_DEF_AUDITIVA:RAIS_IND_DEF_FISICO:RAIS_IND_DEF_MENTAL:RAIS_IND_DE'
||'F_MULTIPLA:RAIS_IND_DEF_VISUAL:BANCO:AGENCIA:NUM_CONTA:DC_CONTA:MODALIDADE:TIPO_CONTA:DESCR_TP_BANC:EMISSAO_IDENT:EST_EMIS_IDENT:NUM_CART_PROF:SER_CART_PROF:MODELO_CTPS:NUM_TIT_ELEITOR:ZON_TIT_ELEITOR:SEC_TIT_ELEITOR:NUM_PIS_PASEP:CPF_FUNC:RESIDE_BRA'
||'SIL:CLASS_TRAB_ESTRANG:NR_RIC:ORGAO_EMIS_RIC:DT_EMIS_RIC:DT_EMIS_CONS_REG:DT_VAL_CONS_REG:DT_FILIAL:DT_CCUSTO:CCUSTO_CONTAB:NOME_CCUSTO_CONTAB:COD_CATEGORIA_CONTAB:DESC_CATEGORIA_CONTAB:CLASS_CCUSTO:DESCR_CLASS_CCUSTO:COD_UN_NEGOCIO:NOME_UN_NEGOCIO:U'
||'NIDADE:DESCR_UNID_ADM:DT_CARGO:FUNCAO:NOME_FUNCAO:DT_FUNCAO:COD_CBO:DC_CBO:ID_CBO:CLASS_CARGO:DESC_CLASS_CARGO:DESCR_GRUPO_TRAB:TIPO_SALARIO:DT_SALARIO:SALARIO:REMUNERACAO_VARIAVEL:PERC_BENEFICIO_VARIAVEL:VLR_AUX_TIPO_MODALIDADE:OUTROS_VENCIMENTOS:TO'
||'TAL_REMUNERACAO:MOT_ALT_SAL:DESCR_MOT_SAL:DT_VLR_AUX_TIPO_MODALIDADE:MOT_ALT_VLR_AUX_TP_MODALIDADE:PERC_INSALUB:PERC_PERIC:COD_TIPO_MAO_OBRA:COD_CATEGORIA:COD_CAT_GRUPOS_SALARIAIS:GRUPO_SALARIAL:PONTO_DE_FX:REGIAO:SIGLA_CONS_REG:COD_CARGO_CIPA:DESCR_'
||'CARGO_CIPA:SINDICALIZADO:IND_CONTR_SINDICAL:DESC_CONTRIB_ASSIST:NUM_SIND_DISS:NOME_SINDICATO:NUM_SIND_CAT:NOME_SIND_CAT:ADTO_SALARIAL:PERC_ADIANT:CAT_P_SEFIP:REG_TRAB:JORNADA_MENSAL_H:JORNADA_MENSAL_M:DT_REG_TRAB:COD_HORARIO:DESC_HORARIO:MARCA_PONTO:'
||'TP_REGISTRO_PONTO:COD_ESCALA_PONTO:DESC_ESCALA_PONTO:ESCALA_EXCECAO:DT_INI_ESCALA:DT_FIM_ESCALA:COD_JORN_PONTO:DESC_JORN_PONTO:COD_PARAM_BH:DESCRICAO_BH:NOME_PAI:NOME_CONJUGE:TIPO_ADESAO:DT_ACORDO:PERCENT_REDUCAO_CARGA_HORARIA:DIAS_DURACAO:DT_ADMISSA'
||'O_BASICA:TIPO_ADESAO_PREV:IND_APOSENTADO:TIPO_AVISO_PREVIO:DATA_AVISO_PREVIO:DIGITO_IDENTIDADE:ORGAO_EMISS_IDENTIDADE:NATURALIDADE:UF_NASCIMENTO:CNH:N_REGISTRO_CNH:CATEGORIA_CNH:DT_VALID_CNH:MOT_ALT_SITUACAO:DESCR_MOT_SIT:RAIS_IND_DEF_INTELECTUAL:CER'
||'TIF_RESERV:CLASSIF_ESTRANGEIRO:TEMPO_RESIDENCIA:INFOCOTA::TIPO_VINCULO'
,p_count_columns_on_break=>'MATRICULA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283827057805969460566)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867021517944591152)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(283780677543880158203)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(283867039513876591195)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271113074479786732690)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(275490876941923033662)
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
 p_id=>wwv_flow_api.id(271113074827160734090)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(275490876941923033662)
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
 p_id=>wwv_flow_api.id(272290482885350530480)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(275490876941923033662)
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
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(272287832366768267460)
,p_name=>'P16_PESQUISA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(272287832543734267462)
,p_name=>'P16_MATRICULA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(ip.nome)||'' - CPF: ''||ip.num_cpf||ltrim(to_char(ip.dc_cpf,''00'')) d, i.matricula',
'  from informacoes_funcionais i, inf_pessoais_cad ip',
' where ip.matricula = i.matricula',
'   and ip.cod_empresa = i.cod_empresa',
'   and ((i.situacao < ''90'' and :p16_situacao = ''A'') or (i.situacao >= ''90'' and :p16_situacao = ''D'') or (:p16_situacao = ''T'') or (:p16_situacao is null))',
'   and (:P16_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_EMPRESA, '','')) t))',
'   and (:P16_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_FILIAL, '','')) t))',
'   and (:P16_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_CCUSTO, '','')) t))',
'   and (:P16_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_UNIDADE_ADM, '','')) t))',
'   and (:P16_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P16_ATIVIDADE, '','')) t))',
'   AND ((:P_PAINEL = ''PO'') or (',
'           EXISTS (SELECT 1',
'                     FROM centro_de_custo cx',
'                    WHERE cx.cod_empresa = i.cod_empresa',
'                      AND cx.cod = i.cod_ccusto',
'                      AND cx.cod_emp_gestor = :P_EMPRESA_USER',
'                      AND cx.matricula_gestor = :P_MATRICULA_USER',
'                   UNION',
'                   SELECT 1',
'                     FROM centro_de_custo cy',
'                    WHERE cy.cod_emp_gestor = i.cod_empresa ',
'                      AND cy.matricula_gestor = i.matricula',
'                      AND cy.cod_ccusto_superior = :P_CCUSTO_USER',
'                    union',
'                   SELECT 1',
'                   FROM SUB_CCUSTO S',
'                  WHERE S.COD_EMPRESA = I.COD_EMPRESA',
'                    AND S.COD_CCUSTO = I.COD_CCUSTO',
'                    AND S.COD_SUB_CCUSTO = I.COD_SUB_CCUSTO',
'                    AND s.cod_emp_gestor = :P_EMPRESA_USER',
'                    and s.mat_gestor = :P_MATRICULA_USER',
'                   )))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P16_CCUSTO,P16_UNIDADE_ADM,P16_UTILIZA_SECAO,P16_ATIVIDADE,P16_SITUACAO,P16_EMPRESA,P16_CARGO'
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
 p_id=>wwv_flow_api.id(272290484500387530496)
,p_name=>'P16_UTILIZA_SECAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(275490876941923033662)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(272290484907310530496)
,p_name=>'P16_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(275490876941923033662)
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
 p_id=>wwv_flow_api.id(272290485229970530496)
,p_name=>'P16_FILIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(nvl(sigla,nome_filial)) descricao, cod_filial',
'  from filiais ',
'where ((instr('',''||:p16_empresa||'','','',''||cod_empresa||'','') > 0) or (:p16_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P16_EMPRESA'
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
 p_id=>wwv_flow_api.id(272290485651187530496)
,p_name=>'P16_CCUSTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p16_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p16_empresa, '','')) t))',
'and (:p16_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p16_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P16_EMPRESA,P16_FILIAL'
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
 p_id=>wwv_flow_api.id(272290486096098530497)
,p_name=>'P16_UNIDADE_ADM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p16_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p16_empresa is null))',
'       and ((instr('',''||:p16_filial||'','','',''||a.cod_filial||'','') > 0) or (:p16_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p16_ccusto',
'       and ((instr('',''||:p16_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p16_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p16_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p16_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p16_empresa is null))',
'       and ((instr('',''||:p16_filial||'','','',''||a.cod_filial||'','') > 0) or (:p16_filial is null))',
'       and :p16_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P16_EMPRESA,P16_FILIAL,P16_CCUSTO,P16_UTILIZA_SECAO'
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
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(272290486487271530497)
,p_name=>'P16_ATIVIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p16_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p16_empresa is null))',
'   and ((instr('',''||:p16_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p16_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p16_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p16_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P16_CCUSTO,P16_UNIDADE_ADM,P16_UTILIZA_SECAO'
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
 p_id=>wwv_flow_api.id(272388828748245810551)
,p_name=>'P16_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(271112852010953353541)
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
 p_id=>wwv_flow_api.id(280892136270324895818)
,p_name=>'P16_SITUACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(275490876941923033662)
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
 p_id=>wwv_flow_api.id(283827056792671460556)
,p_name=>'P16_EMP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283825738337578800285)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283827056918187460557)
,p_name=>'P16_MAT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(283825738337578800285)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280892136435696895819)
,p_name=>'Refresh'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P16_SITUACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280892136535729895820)
,p_event_id=>wwv_flow_api.id(280892136435696895819)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(283825738337578800285)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(272290511937175634354)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P16_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(272290512401941634360)
,p_event_id=>wwv_flow_api.id(272290511937175634354)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p16_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p16_empresa||'','','',''||cod_empresa||'','') > 0) or (:p16_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P16_EMPRESA'
,p_attribute_03=>'P16_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(272290516278586656007)
,p_name=>'Pesquisa'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(272290482885350530480)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(272290516694872656014)
,p_event_id=>wwv_flow_api.id(272290516278586656007)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p16_pesquisa := ''S'';'
,p_attribute_03=>'P16_PESQUISA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(272290517158545656018)
,p_event_id=>wwv_flow_api.id(272290516278586656007)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271113075023247735370)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113074479786732690)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113075336741735375)
,p_event_id=>wwv_flow_api.id(271113075023247735370)
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
 p_id=>wwv_flow_api.id(271113075753170736596)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113074827160734090)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113076146562736598)
,p_event_id=>wwv_flow_api.id(271113075753170736596)
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
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(272287832517289267461)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Itens'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P16_PESQUISA is null then',
':P16_PESQUISA := ''N'';',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(64533952587846399371)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'IA - Gerar Json'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_log_id NUMBER;',
'BEGIN',
'/*',
'',
'    l_log_id := pkg_ai_ir_json.gerar_json_ir(',
'                    p_app_id           => :APP_ID,',
'                    p_page_id          => :APP_PAGE_ID,',
'                    p_region_static_id => ''IR_PRINCIPAL''',
'                );',
'',
unistr('    -- Guarda o ID em item da p\00E1gina, se quiser usar depois'),
'    :PXX_AI_LOG_ID := l_log_id;',
'',
unistr('    -- Mensagem amig\00E1vel para o usu\00E1rio'),
'    apex_util.add_message(',
unistr('        ''Os dados do relat\00F3rio foram enviados para an\00E1lise pela IA. Protocolo: '' || l_log_id'),
'    );',
'',
'*/',
'',
'NULL;',
'END;',
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
