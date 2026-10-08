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
,p_default_application_id=>9113
,p_default_id_offset=>696776033023734483
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9113 - Recrutamento e Seleção - Processos
--
-- Application Export:
--   Application:     9113
--   Name:            Recrutamento e Seleção - Processos
--   Date and Time:   17:50 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 28
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00028
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>28);
end;
/
prompt --application/pages/page_00028
begin
wwv_flow_api.create_page(
 p_id=>28
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>unistr('Rela\00E7\00E3o de Vagas')
,p_step_title=>unistr('Rela\00E7\00E3o de Vagas')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.colorStatusGreen {',
'  background: #4cd84c;',
'}',
'',
'.colorStatusRed {',
'  background: red;',
'}',
'',
'.colorStatusYellow {',
'  background: #FFDE00;',
'}',
'',
'.colorStatusBlue {',
'  background: #2893F0;',
'}',
'',
'.colorStatusGray {',
'  background: #2893F0;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'',
'#VAGAS h3{margin-bottom: 0px;}',
'',
'',
'.t-MediaList-badge h4{',
'  margin-bottom: 2px;',
'}',
'',
'.tabela td{',
'  width: 50% !important;',
'  padding-right: 8px !important;',
'  padding-left: 8px !important;',
'}',
'',
'.ESCONDE {',
'  DISPLAY: NONE;',
'}',
'',
'/*#P28_RELATORIO_CONTAINER .t-Form-labelContainer {display: none !important}*/',
'',
'.t-Form-fieldContainer {margin-top: 0px !important};'))
,p_step_template=>wwv_flow_api.id(72951015765967200558)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260818154705'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52391609903458316120)
,p_plug_name=>unistr('Relat\00F3rio de Vagas 2')
,p_region_name=>'VAGAS'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sele.COD_PROCESSO COD_REQUERIMENTO',
'      , INITCAP(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME'')) CARGO',
'      ,SELE.COD_EMPRESA',
'      ,(SELECT l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end descricao',
'      FROM local_trab l',
'      , filial_local f',
'     WHERE l.cod_local_trab = f.cod_local_filial',
'       and l.cod_local_trab = r.COD_LOCAL_TRAB',
'       and f.COD_EMPRESA = sele.COD_EMPRESA',
'       fetch first 1 rows only) COD_LOCAL_TRAB',
'      ,INITCAP(FNCT_NOME_EMPRESA(SELE.COD_EMPRESA,''S'')) Empresa',
'      ,INITCAP(FNCT_NOME_FILIAL(SELE.COD_EMPRESA,SELE.COD_FILIAL,''S'')) Filial',
'      ,SELE.COD_CCUSTO||''-''||initcap(fnct_nome_ccusto(sele.cod_empresa, SELE.COD_CCUSTO)) Centro_Custo',
'      ,R.COD_UNIDADE_ADM||'' - ''||initcap(fnct_nome_unidade_adm(r.cod_empresa, r.cod_filial, R.COD_UNIDADE_ADM)) Unidade_Adm',
'      ,case when sele.cod_prest_serv is not null then sele.cod_prest_serv||'' - ''|| (SELECT p2.nome FROM prestador_servico p2 WHERE p2.tipo_prest_serv = sele.tipo_prest_serv AND p2.cod_prest_serv = sele.cod_prest_serv) end selecionador',
'      ,INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual)) Fase_Processo',
'      ,((SELECT COUNT(COD_CANDIDATO) COD_CANDIDATO FROM (SELECT MAX(COD_FASE) COD_FASE ,COD_CANDIDATO FROM candidato cand where cand.cod_processo = SELE.COD_PROCESSO GROUP BY COD_CANDIDATO) cand)) Quantidade_Candidatos',
'	  , case when R.TIPO_PUBLICACAO = ''I'' THEN ''Interna''',
'             when R.TIPO_PUBLICACAO = ''E'' THEN ''Externa'' else ''Todas'' end TIPO_PUBLICACAO',
', (SELECT INITCAP(MOTR.DESCRICAO) DESCRICAO FROM TIPO_MODALIDADE_TRAB  MOTR WHERE ATIVO = ''S'' AND r.TIPO_MODALIDADE = motr.TIPO_MODALIDADE fetch first 1 rows only)  TIPO_MODALIDADE',
'      ,(select a.cod||'' - ''||Initcap(a.nome) descricao from vinculo_empreg a WHERE a.cod = R.vinculo fetch first 1 rows only) VINCULO_REQ',
'      ,to_char(SELE.DT_APROVACAO,''dd/mm/rrrr'') Prazo_Inicial',
'      ,case when r.VINCULO is not null then (select distinct a.cod||'' - ''||Initcap(a.nome) descricao',
'                                                from vinculo_empreg a',
'                                                where A.COD = r.VINCULO) end vinculo',
unistr('      ,to_char(SELE.DT_FECHAMENTO,''dd/mm/rrrr'') Prazo_Contrata\00E7\00E3o'),
'      ,to_char(SELE.DT_APROVACAO,''dd/mm/rrrr'') data_aprovacao',
'      ,to_char(r.DT_SIT_REQ,''dd/mm/rrrr'') Data_Situcao',
'     , CASE WHEN r.cod_sit_req = 1 THEN ''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Prevista''',
'                    WHEN r.cod_sit_req = 2 THEN ''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||''Fechada''',
'                    WHEN r.cod_sit_req = 3 THEN ''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Cancelada''',
'                    WHEN r.cod_sit_req = 4 THEN ''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Reprovada''',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is null THEN ''<span aria-hidden="true" class="fa fa-play-circle colorAlert"></span> ''||''Aberta''',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is not null THEN ''<span aria-hidden="true" class="fa fa-play-circle" style="color: #0572ce"></span> ''||''Publicada''',
'       END  status_req  ',
'     ,CASE WHEN r.cod_sit_req <> 1 THEN apex_page.get_url (p_page => 29,',
'                          p_items       => ''P29_REQUISICAO,P29_EMP_ID'',',
'                          p_values      => SELE.COD_PROCESSO||'',''||SELE.COD_EMPRESA,',
'                          p_clear_cache => 29) END link',
'                          ,CASE WHEN r.cod_sit_req = 1 THEN ''ESCONDE'' END ESCONDE',
'                          ,Q.NOME PUBLICACAO',
',r.COD_REQ',
',r.cod_sit_req',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'    , QUADRO_VAGAS_LAYOUT Q ',
'      ,usuario_oracle_filiais uof',
'      ,usuario_oracle_ccusto   uoc',
'where uoc.cod_ccusto = r.cod_ccusto',
'  and uoc.cod_empresa = r.cod_empresa',
'  and uoc.nm_usuario_oracle = :app_user',
'  and uof.cd_filial = r.cod_filial',
'  and uof.cd_empresa = r.cod_empresa',
'  and uof.nm_usuario_oracle = :app_user',
'  and NOT EXISTS (SELECT 1 ',
'                    FROM USUARIO_ORACLE UO',
'                   WHERE UO.CD_EMPRESA = SELE.COD_EMPRESA',
'                     AND UO.CD_MATRICULA = SELE.MAT_SUBS',
'                     AND UO.CD_EMPRESA = :P_EMPRESA_USER',
'                     AND UO.CD_MATRICULA = :P_MATRICULA_USER)',
'  and R.COD_REQ = SELE.COD_PROCESSO',
'  and SELE.QUADRO_VAGA_ID = Q.ID (+)',
'  and :P28_PESQUISAR_SN = ''S''',
'  and (:P28_DT_INI is null or NVL(SELE.DT_APROVACAO,R.DT_REQ) BETWEEN :P28_DT_INI AND :P28_DT_FIM)',
'  and (:P28_EMP_ID     is null or SELE.COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_EMP_ID , '','')) t))',
'  and (:P28_STATUS     is null or r.cod_sit_req in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_STATUS , '','')) t))',
'  and (:P28_REQUISICAO is null or SELE.COD_PROCESSO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_REQUISICAO , '','')) t))',
'  and (:P28_CARGO      is null or SELE.COD_CARGO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_CARGO , '','')) t))',
'  and (:P28_FILIAL     is null or SELE.COD_FILIAL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_FILIAL , '','')) t))',
'  and (:P28_TIPO_PUBLICACAO = ''T'' OR R.TIPO_PUBLICACAO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_PUBLICACAO , '','')) t))',
'  and (:P28_VINCULO_CARGO is null or R.vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_VINCULO_CARGO , '','')) t))',
'  and (:P28_ETAPA      is null or INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual)) in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_ETAPA , '','')) t))',
'  and (:P28_TIPO_MODALIDADE     is null or r.TIPO_MODALIDADE in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_MODALIDADE , '','')) t))',
'  and (:P28_SELECIONADOR = 00 and SELE.cod_prest_serv is null or :P28_SELECIONADOR is null or SELE.cod_prest_serv > 0 and SELE.cod_prest_serv in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_SELECIONADOR , '','')) t))',
'  and (:P28_UNIDADE_ADM     is null or R.COD_UNIDADE_ADM in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_UNIDADE_ADM , '','')) t))',
'  and (:P28_CENTRO_CUSTO is null or SELE.COD_CCUSTO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_CENTRO_CUSTO , '','')) t))',
'  and (:P28_LOCAL_TRAB is null or r.COD_LOCAL_TRAB in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_LOCAL_TRAB , '','')) t))',
'    and (:P28_ENVOLVIDO = ''T'' and  :P_PERFIL not in (''SELECAO'',''SELECIONADOR'') or :P28_ENVOLVIDO = ''T'' and :P_PERFIL in (''SELECAO'',''SELECIONADOR'') and SELE.COD_PREST_SERV IS NULL or ',
'  (:P28_ENVOLVIDO = ''S'' and (R.MAT_REQ = :P_MATRICULA_USER) OR (R.MAT_AVALIADOR_IND = :P_MATRICULA_USER)',
'OR (R.MAT_GESTOR_IND = :P_MATRICULA_USER) or (SELE.COD_PREST_SERV = :P28_COD_PREST_SERV AND :P28_COD_PREST_SERV IS NOT NULL))) ',
'  and (:P28_PESQUISAR_1 IS NULL OR ((SELE.COD_EMPRESA LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                        (UPPER(r.cod_sit_req) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(SELE.COD_PROCESSO) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(R.vinculo) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(FNCT_NOME_FILIAL(SELE.COD_EMPRESA,SELE.COD_FILIAL,''S'')) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual)) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER( r.TIPO_MODALIDADE) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME'')) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(FNCT_NOME_EMPRESA(SELE.COD_EMPRESA,''S'')) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(SELE.COD_FILIAL) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'') OR',
'                                   (UPPER(R.TIPO_PUBLICACAO) LIKE ''%''||replace(UPPER(:P28_PESQUISAR_1),'' '',''%'')||''%'')))',
'',
'union',
'select r.COD_REQ COD_REQUERIMENTO',
'      ,INITCAP(FNC_RETORNA_DADOS_CARGO(r.COD_CARGO,''NOME'')) CARGO',
'      ,r.COD_EMPRESA',
'      ,(SELECT l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end descricao',
'      FROM local_trab l',
'      , filial_local f',
'     WHERE l.cod_local_trab = f.cod_local_filial',
'       and l.cod_local_trab = r.COD_LOCAL_TRAB',
'       and f.COD_EMPRESA = r.COD_EMPRESA',
'       fetch first 1 rows only) COD_LOCAL_TRAB',
'      ,INITCAP(FNCT_NOME_EMPRESA(r.COD_EMPRESA,''S'')) Empresa',
'      ,INITCAP(FNCT_NOME_FILIAL(r.COD_EMPRESA,r.COD_FILIAL,''S'')) Filial',
'	  ',
'      ,null Centro_Custo',
'      ,R.COD_UNIDADE_ADM||'' - ''||initcap(fnct_nome_unidade_adm(r.cod_empresa, r.cod_filial, R.COD_UNIDADE_ADM)) Unidade_Adm',
'      ,null selecionador',
'      ,null Fase_Processo',
'      ,0 Quantidade_Candidatos',
'	  , case when R.TIPO_PUBLICACAO = ''I'' THEN ''Interna''',
'             when R.TIPO_PUBLICACAO = ''E'' THEN ''Externa'' else ''Todas'' end TIPO_PUBLICACAO',
'      , (SELECT INITCAP(MOTR.DESCRICAO) DESCRICAO FROM TIPO_MODALIDADE_TRAB  MOTR WHERE ATIVO = ''S'' AND r.TIPO_MODALIDADE = motr.TIPO_MODALIDADE fetch first 1 rows only)  TIPO_MODALIDADE',
'      ,(select a.cod||'' - ''||Initcap(a.nome) descricao from vinculo_empreg a WHERE a.cod = R.vinculo fetch first 1 rows only) VINCULO_REQ',
'      ,null Prazo_Inicial',
'      ,case when r.VINCULO is not null then (select distinct a.cod||'' - ''||Initcap(a.nome) descricao',
'                                                from vinculo_empreg a',
'                                                where A.COD = r.VINCULO) end vinculo',
unistr('      ,null Prazo_Contrata\00E7\00E3o'),
'      ,null data_aprovacao',
'      ,to_char(r.DT_SIT_REQ,''dd/mm/rrrr'') Data_Situcao',
'     , CASE WHEN r.cod_sit_req = 1 THEN ''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Prevista''',
'        END  status_req  ',
'    ,null link',
'    ,CASE WHEN r.cod_sit_req = 1 THEN ''ESCONDE'' END ESCONDE',
'    ,null PUBLICACAO',
'    ,r.COD_REQ',
'    ,r.cod_sit_req',
' from requisicao R ',
'      ,usuario_oracle_filiais uof',
'      ,usuario_oracle_ccusto   uoc',
'where uoc.cod_ccusto = r.cod_ccusto',
'  and uoc.cod_empresa = r.cod_empresa',
'  and uoc.nm_usuario_oracle = :app_user',
'  and uof.cd_filial = r.cod_filial',
'  and uof.cd_empresa = r.cod_empresa',
'  and uof.nm_usuario_oracle = :app_user',
'  and NOT EXISTS (SELECT 1 ',
'                  FROM USUARIO_ORACLE UO',
'                 WHERE UO.CD_EMPRESA = R.COD_EMPRESA',
'                   AND UO.CD_MATRICULA = R.MAT_SUBS',
'                   AND UO.CD_EMPRESA = :P_EMPRESA_USER',
'                   AND UO.CD_MATRICULA = :P_MATRICULA_USER)',
'  and :P28_PESQUISAR_SN = ''S''',
'  AND r.cod_sit_req = 1',
'  and (:P28_ENVOLVIDO = ''T'')  ',
'  and (:P28_REQUISICAO is null or r.COD_REQ in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_REQUISICAO , '','')) t))',
'  and (:P28_STATUS     is null or r.cod_sit_req in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_STATUS , '','')) t))',
'  and (:P28_DT_INI is null or R.DT_REQ BETWEEN :P28_DT_INI AND :P28_DT_FIM)',
'  and (:P28_EMP_ID     is null or r.COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_EMP_ID , '','')) t))',
'  and (:P28_CARGO      is null or r.COD_CARGO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_CARGO , '','')) t))',
'  and (:P28_FILIAL     is null or r.COD_FILIAL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_FILIAL , '','')) t))',
'  and (:P28_TIPO_PUBLICACAO = ''T'' OR R.TIPO_PUBLICACAO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_PUBLICACAO , '','')) t))  ',
'  and (:P28_VINCULO_CARGO is null or R.vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_VINCULO_CARGO , '','')) t))',
'  and (:P28_TIPO_MODALIDADE     is null or r.TIPO_MODALIDADE in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_MODALIDADE , '','')) t))',
'  and (:P28_UNIDADE_ADM     is null or R.COD_UNIDADE_ADM in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_UNIDADE_ADM , '','')) t))',
'  and (:P28_LOCAL_TRAB is null or r.COD_LOCAL_TRAB in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_LOCAL_TRAB , '','')) t))',
'  and (:P28_PESQUISAR_1 IS NULL OR ((r.COD_EMPRESA LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(r.cod_sit_req)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(R.vinculo)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(r.COD_CARGO)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNCT_NOME_FILIAL(r.COD_EMPRESA,r.COD_FILIAL,''S''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER( r.TIPO_MODALIDADE)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNC_RETORNA_DADOS_CARGO(r.COD_CARGO,''NOME''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNCT_NOME_EMPRESA(r.COD_EMPRESA,''S''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(r.COD_FILIAL)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(R.TIPO_PUBLICACAO)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR_1)),'' '',''%'')||''%'')))',
'ORDER BY COD_REQ DESC,cod_sit_req asc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P28_RELATORIO'
,p_plug_display_when_cond2=>'I'
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
,p_plug_header=>unistr('<h4>Veja abaixo as vagas dispon\00EDveis.</h4>')
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(52391610567998316127)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Realize o filtro e clique em Pesquisar'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:RP:P29_REQUISICAO,P29_EMP_ID:#COD_REQUERIMENTO#,#COD_EMPRESA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_detail_link_attr=>'CLASS="#ESCONDE#"'
,p_owner=>'DANIEL.TASSO'
,p_internal_uid=>1079551913561812736
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611231453316133)
,p_db_column_name=>'LINK'
,p_display_order=>60
,p_column_identifier=>'A'
,p_column_label=>'Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611303071316134)
,p_db_column_name=>'COD_REQUERIMENTO'
,p_display_order=>70
,p_column_identifier=>'B'
,p_column_label=>unistr('Cod. Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611422291316135)
,p_db_column_name=>'CARGO'
,p_display_order=>80
,p_column_identifier=>'C'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611461006316136)
,p_db_column_name=>'EMPRESA'
,p_display_order=>90
,p_column_identifier=>'D'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611609965316137)
,p_db_column_name=>'FILIAL'
,p_display_order=>100
,p_column_identifier=>'E'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611670789316138)
,p_db_column_name=>'CENTRO_CUSTO'
,p_display_order=>110
,p_column_identifier=>'F'
,p_column_label=>'Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611778363316139)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>'Unidade Administrativa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611933151316140)
,p_db_column_name=>'SELECIONADOR'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'Selecionador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391611962359316141)
,p_db_column_name=>'FASE_PROCESSO'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Fase Processo Requerimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404967467391151692)
,p_db_column_name=>'QUANTIDADE_CANDIDATOS'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>'Quantidade Candidatos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404967636880151693)
,p_db_column_name=>'PRAZO_INICIAL'
,p_display_order=>160
,p_column_identifier=>'K'
,p_column_label=>'Prazo Inicial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404967738563151694)
,p_db_column_name=>unistr('PRAZO_CONTRATA\00C7\00C3O')
,p_display_order=>170
,p_column_identifier=>'L'
,p_column_label=>unistr('Prazo Contrata\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404967754641151695)
,p_db_column_name=>'STATUS_REQ'
,p_display_order=>180
,p_column_identifier=>'M'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404968890692151706)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>190
,p_column_identifier=>'N'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404969024401151707)
,p_db_column_name=>'VINCULO'
,p_display_order=>200
,p_column_identifier=>'O'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52439139747216755333)
,p_db_column_name=>'ESCONDE'
,p_display_order=>210
,p_column_identifier=>'P'
,p_column_label=>'Esconde'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52439140200058755338)
,p_db_column_name=>'COD_LOCAL_TRAB'
,p_display_order=>220
,p_column_identifier=>'Q'
,p_column_label=>'Local Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51313012639136679421)
,p_db_column_name=>'TIPO_PUBLICACAO'
,p_display_order=>230
,p_column_identifier=>'R'
,p_column_label=>unistr('Tipo Publica\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51313012695332679422)
,p_db_column_name=>'TIPO_MODALIDADE'
,p_display_order=>240
,p_column_identifier=>'S'
,p_column_label=>'Modalidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51313012845985679423)
,p_db_column_name=>'VINCULO_REQ'
,p_display_order=>250
,p_column_identifier=>'T'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50845864163937528000)
,p_db_column_name=>'PUBLICACAO'
,p_display_order=>260
,p_column_identifier=>'U'
,p_column_label=>unistr('Publica\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(46773617342790603998)
,p_db_column_name=>'DATA_APROVACAO'
,p_display_order=>270
,p_column_identifier=>'V'
,p_column_label=>'Data Aprovacao'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(46773617469798603999)
,p_db_column_name=>'DATA_SITUCAO'
,p_display_order=>280
,p_column_identifier=>'W'
,p_column_label=>'Data Situcao'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(42491934225332147799)
,p_db_column_name=>'COD_REQ'
,p_display_order=>290
,p_column_identifier=>'X'
,p_column_label=>'Cod Req'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(42491934365284147800)
,p_db_column_name=>'COD_SIT_REQ'
,p_display_order=>300
,p_column_identifier=>'Y'
,p_column_label=>'Cod Sit Req'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52404981669784275571)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'10929231'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('STATUS_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:COD_LOCAL_TRAB:TIPO_TIPO_MODALIDADE:VINCULO_REQ::PUBLICACAO:DATA_APROVACAO:DATA_SITUCAO:COD_REQ')
||':COD_SIT_REQ'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458332579041720331)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Relat\00F3rio com Quebras')
,p_report_seq=>10
,p_report_alias=>'11462740'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_break_on=>'EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:VINCULO:SELECIONADOR'
,p_break_enabled_on=>'SELECIONADOR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458334644936767790)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Filial')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11462760'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_chart_type=>'pie'
,p_chart_label_column=>'FILIAL'
,p_chart_value_column=>'QUANTIDADE_CANDIDATOS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458335127867771006)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Empresa')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11462765'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_chart_type=>'pie'
,p_chart_label_column=>'EMPRESA'
,p_chart_value_column=>'QUANTIDADE_CANDIDATOS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458335609057774705)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Centro de Custo')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11462770'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_chart_type=>'pie'
,p_chart_label_column=>'CENTRO_CUSTO'
,p_chart_value_column=>'QUANTIDADE_CANDIDATOS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458336851910805745)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Distribui\00E7\00E3o de Requisi\00E7\00F5es')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'11462782'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(52458337207608805751)
,p_report_id=>wwv_flow_api.id(52458336851910805745)
,p_group_by_columns=>'EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:VINCULO:SELECIONADOR'
,p_function_01=>'COUNT'
,p_function_column_01=>'COD_REQUERIMENTO'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_format_mask_01=>'999G999G999G999G999G999G990'
,p_function_sum_01=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458339076239863907)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade de Requisi\00E7\00F5es por EMP/FIL/CC')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'11462805'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52458339546813863910)
,p_report_id=>wwv_flow_api.id(52458339076239863907)
,p_pivot_columns=>'FILIAL'
,p_row_columns=>'EMPRESA'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52458339919857863911)
,p_pivot_id=>wwv_flow_api.id(52458339546813863910)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'CENTRO_CUSTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52458340335136863911)
,p_pivot_id=>wwv_flow_api.id(52458339546813863910)
,p_display_seq=>2
,p_function_name=>'COUNT'
,p_column_name=>'VINCULO'
,p_db_column_name=>'PFC2'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458347114440031238)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Distribui\00E7\00E3o de Requisi\00E7\00F5es Filial e Cargo')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'11462885'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(52458347520189031239)
,p_report_id=>wwv_flow_api.id(52458347114440031238)
,p_group_by_columns=>'FILIAL:CARGO'
,p_function_01=>'COUNT'
,p_function_column_01=>'COD_REQUERIMENTO'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_format_mask_01=>'999G999G999G999G999G999G990'
,p_function_sum_01=>'Y'
,p_sort_column_01=>'FILIAL'
,p_sort_direction_01=>'ASC'
);
end;
/
begin
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458348314523055637)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Filial e Cargo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'11462897'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52458348690753055639)
,p_report_id=>wwv_flow_api.id(52458348314523055637)
,p_pivot_columns=>'FILIAL'
,p_row_columns=>'CARGO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52458349090317055640)
,p_pivot_id=>wwv_flow_api.id(52458348690753055639)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458349973335062416)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Vinculo e Cargo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'11462914'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52458350444798062418)
,p_report_id=>wwv_flow_api.id(52458349973335062416)
,p_pivot_columns=>'VINCULO'
,p_row_columns=>'CARGO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52458350836313062421)
,p_pivot_id=>wwv_flow_api.id(52458350444798062418)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458351562396067195)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Selecionador e Cargo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'11462930'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52458352008782067198)
,p_report_id=>wwv_flow_api.id(52458351562396067195)
,p_pivot_columns=>'SELECIONADOR'
,p_row_columns=>'CARGO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52458352417526067200)
,p_pivot_id=>wwv_flow_api.id(52458352008782067198)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458353252788071607)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Selecionador e Vinculo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'11462946'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52458353615148071607)
,p_report_id=>wwv_flow_api.id(52458353252788071607)
,p_pivot_columns=>'SELECIONADOR'
,p_row_columns=>'VINCULO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52458354025630071608)
,p_pivot_id=>wwv_flow_api.id(52458353615148071607)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458355014099082890)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Selecionador')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11462964'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_chart_type=>'bar'
,p_chart_label_column=>'SELECIONADOR'
,p_chart_value_column=>'QUANTIDADE_CANDIDATOS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458355479010088426)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Cargo')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11462969'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_chart_type=>'bar'
,p_chart_label_column=>'CARGO'
,p_chart_value_column=>'QUANTIDADE_CANDIDATOS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52458355960782098717)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Situa\00E7\00E3o da Vaga')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11462974'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_chart_type=>'pie'
,p_chart_label_column=>'STATUS_REQ'
,p_chart_value_column=>'QUANTIDADE_CANDIDATOS'
,p_chart_aggregate=>'COUNT'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52493073670647748259)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico Local de Trabalho')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'11810151'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O::ESCONDE:COD_LOCAL_TRAB')
,p_chart_type=>'pie'
,p_chart_label_column=>'COD_LOCAL_TRAB'
,p_chart_value_column=>'COD_REQUERIMENTO'
,p_chart_sorting=>'DEFAULT'
,p_chart_orientation=>'vertical'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52493075223491777855)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade de Requisi\00E7\00F5es Empresa/Filial/Local de Trabalho')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'11810166'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O::ESCONDE:COD_LOCAL_TRAB')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52493075637544777858)
,p_report_id=>wwv_flow_api.id(52493075223491777855)
,p_pivot_columns=>'COD_LOCAL_TRAB'
,p_row_columns=>'EMPRESA:FILIAL'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(52493076047337777863)
,p_pivot_id=>wwv_flow_api.id(52493075637544777858)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(70976159724038084679)
,p_plug_name=>unistr('Par\00E2metros')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove:margin-bottom-none:margin-left-none'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52282537372857829536)
,p_plug_name=>'PARAMETROS_ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52237932109604224104)
,p_plug_name=>'Envolvidos'
,p_parent_plug_id=>wwv_flow_api.id(52282537372857829536)
,p_region_template_options=>'#DEFAULT#:t-Region--hideShowIconsMath:is-collapsed:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52237932296783224106)
,p_plug_name=>'Estrutura'
,p_parent_plug_id=>wwv_flow_api.id(52282537372857829536)
,p_region_template_options=>'#DEFAULT#:t-Region--hideShowIconsMath:is-collapsed:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(71401748907910240282)
,p_name=>unistr('Relat\00F3rio de Vagas 1')
,p_region_name=>'VAGAS'
,p_template=>wwv_flow_api.id(72951031880997200635)
,p_display_sequence=>10
,p_icon_css_classes=>'fa-pencil-square-o'
,p_region_template_options=>'#DEFAULT#:t-Region--showIcon:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-MediaList--showBadges:t-MediaList--stack:t-Report--hideNoPagination'
,p_grid_column_span=>10
,p_display_column=>2
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''<h3><b>''|| case when SELE.COD_CARGO is not null then INITCAP(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME'')) end ||''</b></h3><p>''||sele.COD_PROCESSO list_title',
'      ,''<table  class="tabela" style="width: 100% !important;"><tbody><td>''',
'	    ||case when SELE.COD_EMPRESA is not null then ''<b>Empresa: </b>''||INITCAP(FNCT_NOME_EMPRESA(SELE.COD_EMPRESA,''S'')) end ||''</br>''',
'        ||case when SELE.COD_FILIAL  is not null then ''<b>Filial: </b>''||INITCAP(FNCT_NOME_FILIAL(SELE.COD_EMPRESA,SELE.COD_FILIAL,''S'')) end||''</br>''',
'        ||case when SELE.COD_CCUSTO  is not null then ''<b>Centro de Custo: </b>''||SELE.COD_CCUSTO||'' - ''||initcap(fnct_nome_ccusto(sele.cod_empresa, SELE.COD_CCUSTO)) end||''</br>''',
'        ||case when R.COD_UNIDADE_ADM  is not null then ''<b>Unidade Adm.: </b>''||R.COD_UNIDADE_ADM||'' - ''||initcap(fnct_nome_unidade_adm(r.cod_empresa, r.cod_filial, R.COD_UNIDADE_ADM)) end||''</br>''',
'        ||case when SELE.cod_prest_serv  is not null then ''<b>Selecionador: </b>''||sele.cod_prest_serv||'' - ''|| (SELECT p2.nome',
'                                                                                                               FROM prestador_servico p2',
'                                                                                                              WHERE p2.tipo_prest_serv = sele.tipo_prest_serv',
'                                                                                                                AND p2.cod_prest_serv = sele.cod_prest_serv) end||''</br>''',
'        ||''<b>Fase do Processo: </b>''||INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual))||''</td></br>''',
'        ||''<td><b>Quantidade de Candidatos: </b>''||(SELECT COUNT(COD_CANDIDATO) COD_CANDIDATO FROM (SELECT MAX(COD_FASE) COD_FASE ,COD_CANDIDATO FROM candidato cand where cand.cod_processo = SELE.COD_PROCESSO GROUP BY COD_CANDIDATO) cand)||''</br>''',
unistr('        ||''<b>Data de Solicita\00E7\00E3o: </b>''||to_char(SELE.DT_SOLICITACAO,''dd/mm/rrrr'')||''</br>'''),
unistr('        ||''<b>Data de Aprova\00E7\00E3o: </b>''||to_char(SELE.DT_APROVACAO,''dd/mm/rrrr'')||''</br>'''),
unistr('        ||''<b>Data da Situa\00E7\00E3o: </b>''||to_char(r.DT_SIT_REQ,''dd/mm/rrrr'')||''</br>'''),
'        ||case when SELE.DT_APROVACAO is not null then ''<b>Prazo Inicial: </b>''||to_char(SELE.DT_APROVACAO,''dd/mm/rrrr'') end ||''</br>''',
unistr('        ||''<b>Prazo de Contrata\00E7\00E3o: </b>''||to_char(SELE.DT_FECHAMENTO,''dd/mm/rrrr'')||''</br></td></tbody></table>'' list_text'),
'     , CASE WHEN r.cod_sit_req = 1 THEN ''<h4>Prevista</h4>''',
'                    WHEN r.cod_sit_req = 2 THEN ''<h4>Fechada</h4>''',
'                    WHEN r.cod_sit_req = 3 THEN ''<h4>Cancelada</h4>''',
'                    WHEN r.cod_sit_req = 4 THEN ''<h4>Reprovada</h4>''',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is null THEN ''<h4>Aberta</h4>''',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is not null THEN ''<h4>Publicada</h4>''',
'       END  list_badge',
', CASE WHEN r.cod_sit_req = 1 THEN ''colorStatusBlue''',
'                    WHEN r.cod_sit_req = 2 THEN ''colorStatusGreen''',
'                    WHEN r.cod_sit_req = 3 THEN ''colorStatusRed''',
'                    WHEN r.cod_sit_req = 4 THEN ''colorStatusRed''',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is null THEN ''colorStatusYellow'' ',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is not null THEN ''colorStatusBlue''',
'       END icon_color_class',
', CASE WHEN r.cod_sit_req = 1 THEN ''fa fa-address-book''',
'                    WHEN r.cod_sit_req = 2 THEN  ''fa fa-check'' ',
'                    WHEN r.cod_sit_req = 3 THEN  ''fa fa-close'' ',
'                    WHEN r.cod_sit_req = 4 THEN  ''fa fa-close'' ',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is null THEN ''fa fa-play''',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is not null THEN ''fa fa-play''',
'       END  icon_class',
'     , CASE WHEN r.cod_sit_req <> 1 THEN apex_page.get_url (p_page        => 29,',
'                          p_items       => ''P29_REQUISICAO,P29_EMP_ID'',',
'                          p_values      => SELE.COD_PROCESSO||'',''||SELE.COD_EMPRESA,',
'                          p_clear_cache => 29) END link',
',r.COD_REQ',
',r.cod_sit_req',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'      ,usuario_oracle_filiais uof',
'      ,usuario_oracle_ccusto   uoc',
'where uoc.cod_ccusto = r.cod_ccusto',
'  and uoc.cod_empresa = r.cod_empresa',
'  and uoc.nm_usuario_oracle = :app_user',
'  and uof.cd_filial = r.cod_filial',
'  and uof.cd_empresa = r.cod_empresa',
'  and uof.nm_usuario_oracle = :app_user',
'  and R.COD_REQ = SELE.COD_PROCESSO',
'  and NOT EXISTS (SELECT 1 ',
'                    FROM USUARIO_ORACLE UO',
'                   WHERE UO.CD_EMPRESA = SELE.COD_EMPRESA',
'                     AND UO.CD_MATRICULA = SELE.MAT_SUBS',
'                     AND UO.CD_EMPRESA = :P_EMPRESA_USER',
'                     AND UO.CD_MATRICULA = :P_MATRICULA_USER) ',
'  and :P28_PESQUISAR_SN = ''S''',
'  and (:P28_DT_INI is null or NVL(SELE.DT_APROVACAO,R.DT_REQ) BETWEEN :P28_DT_INI AND :P28_DT_FIM)',
'  and (:P28_EMP_ID     is null or SELE.COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_EMP_ID , '','')) t))',
'  and (:P28_STATUS     is null or r.cod_sit_req in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_STATUS , '','')) t))',
'  and (:P28_REQUISICAO is null or SELE.COD_PROCESSO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_REQUISICAO , '','')) t))',
'  and (:P28_CARGO      is null or SELE.COD_CARGO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_CARGO , '','')) t))',
'  and (:P28_FILIAL     is null or SELE.COD_FILIAL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_FILIAL , '','')) t))',
'  and (:P28_TIPO_PUBLICACAO = ''T'' OR R.TIPO_PUBLICACAO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_PUBLICACAO , '','')) t))  ',
'  and (:P28_VINCULO_CARGO is null or R.vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_VINCULO_CARGO , '','')) t))',
'  and (:P28_ETAPA      is null or INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual)) in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_ETAPA , '','')) t))',
'  and (:P28_TIPO_MODALIDADE     is null or r.TIPO_MODALIDADE in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_MODALIDADE , '','')) t))',
'  and (:P28_UNIDADE_ADM     is null or R.COD_UNIDADE_ADM in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_UNIDADE_ADM , '','')) t))',
'  and (:P28_SELECIONADOR = 00 and SELE.cod_prest_serv is null or :P28_SELECIONADOR is null or SELE.cod_prest_serv > 0 and SELE.cod_prest_serv in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_SELECIONADOR , '','')) t))',
'  and (:P28_CENTRO_CUSTO is null or SELE.COD_CCUSTO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_CENTRO_CUSTO , '','')) t))',
'  and (:P28_LOCAL_TRAB is null or r.COD_LOCAL_TRAB in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_LOCAL_TRAB , '','')) t))',
'  and (:P28_ENVOLVIDO = ''T'' and :P_PERFIL not in (''SELECAO'',''SELECIONADOR'') or :P28_ENVOLVIDO = ''T'' and :P_PERFIL  in (''SELECAO'',''SELECIONADOR'') and SELE.COD_PREST_SERV IS NULL or ',
'  (:P28_ENVOLVIDO = ''S'' and (R.MAT_REQ = :P_MATRICULA_USER) OR (R.MAT_AVALIADOR_IND = :P_MATRICULA_USER)',
'   OR (R.MAT_GESTOR_IND = :P_MATRICULA_USER) or (SELE.COD_PREST_SERV = :P28_COD_PREST_SERV AND :P28_COD_PREST_SERV IS NOT NULL))) ',
'   and (:P28_PESQUISAR IS NULL OR ((SELE.COD_EMPRESA LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(r.cod_sit_req)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(SELE.COD_PROCESSO)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(R.vinculo)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNCT_NOME_FILIAL(SELE.COD_EMPRESA,SELE.COD_FILIAL,''S''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual))) LIKE ''%''||replace(UPPER(:P28_PESQUISAR),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER( r.TIPO_MODALIDADE)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNCT_NOME_EMPRESA(SELE.COD_EMPRESA,''S''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(SELE.COD_FILIAL)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(R.TIPO_PUBLICACAO)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'')))                               ',
'',
'union',
'select  ''<h3><b>''|| case when r.COD_CARGO is not null then INITCAP(FNC_RETORNA_DADOS_CARGO(r.COD_CARGO,''NOME'')) end ||''</b></h3><p>''||r.COD_REQ list_title',
'      ,''<table  class="tabela" style="width: 100% !important;"><tbody><td>''',
'	    ||case when r.COD_EMPRESA is not null then ''<b>Empresa: </b>''||INITCAP(FNCT_NOME_EMPRESA(R.COD_EMPRESA,''S'')) end ||''</br>''',
'        ||case when R.COD_FILIAL  is not null then ''<b>Filial: </b>''||INITCAP(FNCT_NOME_FILIAL(R.COD_EMPRESA,R.COD_FILIAL,''S'')) end||''</br>''',
'        ||case when R.COD_CCUSTO  is not null then ''<b>Centro de Custo: </b>''||R.COD_CCUSTO||'' - ''||initcap(fnct_nome_ccusto(R.cod_empresa, R.COD_CCUSTO)) end||''</br>''',
'        ||case when R.COD_UNIDADE_ADM  is not null then ''<b>Unidade Adm.: </b>''||R.COD_UNIDADE_ADM||'' - ''||initcap(fnct_nome_unidade_adm(r.cod_empresa, r.cod_filial, R.COD_UNIDADE_ADM)) end||''</br>''',
unistr('        ||''<b>Data de Solicita\00E7\00E3o: </b>''||to_char(R.DT_REQ,''dd/mm/rrrr'')||''</br>'''),
unistr('        ||''<b>Data da Situa\00E7\00E3o: </b>''||to_char(r.DT_SIT_REQ,''dd/mm/rrrr'')||''</br>'''),
'        ||''</td></tbody></table>'' list_text',
'     , CASE WHEN r.cod_sit_req = 1 THEN ''<h4>Prevista</h4>''',
'       END  list_badge',
', CASE WHEN r.cod_sit_req = 1 THEN ''colorStatusBlue''',
'       END icon_color_class',
', CASE WHEN r.cod_sit_req = 1 THEN ''fa fa-address-book''',
'       END  icon_class',
'     , CASE WHEN r.cod_sit_req <> 1 THEN apex_page.get_url (p_page        => 29,',
'                          p_items       => ''P29_REQUISICAO,P29_EMP_ID'',',
'                          p_values      => R.COD_REQ||'',''||R.COD_EMP_REQ,',
'                          p_clear_cache => 29) END link',
',r.COD_REQ',
',r.cod_sit_req',
' from requisicao R ',
'      ,usuario_oracle_filiais uof',
'      ,usuario_oracle_ccusto   uoc',
'where uoc.cod_ccusto = r.cod_ccusto',
'  and uoc.cod_empresa = r.cod_empresa',
'  and uoc.nm_usuario_oracle = :app_user',
'  and uof.cd_filial = r.cod_filial',
'  and uof.cd_empresa = r.cod_empresa',
'  and uof.nm_usuario_oracle = :app_user',
'  and NOT EXISTS (SELECT 1 ',
'                    FROM USUARIO_ORACLE UO',
'                   WHERE UO.CD_EMPRESA = R.COD_EMPRESA',
'                     AND UO.CD_MATRICULA = R.MAT_SUBS',
'                     AND UO.CD_EMPRESA = :P_EMPRESA_USER',
'                     AND UO.CD_MATRICULA = :P_MATRICULA_USER)',
'  and :P28_PESQUISAR_SN = ''S''',
'  AND r.cod_sit_req = 1',
'  and (:P28_ENVOLVIDO = ''T'')',
'  and (:P28_REQUISICAO is null or r.COD_REQ in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_REQUISICAO , '','')) t))',
'  and (:P28_STATUS     is null or r.cod_sit_req in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_STATUS , '','')) t))',
'  and (:P28_DT_INI is null or R.DT_REQ BETWEEN :P28_DT_INI AND :P28_DT_FIM)',
'  and (:P28_EMP_ID     is null or r.COD_EMPRESA in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_EMP_ID , '','')) t))',
'  and (:P28_CARGO      is null or r.COD_CARGO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_CARGO , '','')) t))',
'  and (:P28_FILIAL     is null or r.COD_FILIAL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_FILIAL , '','')) t))',
'  and (:P28_TIPO_PUBLICACAO = ''T'' OR R.TIPO_PUBLICACAO in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_PUBLICACAO , '','')) t))  ',
'  and (:P28_VINCULO_CARGO is null or R.vinculo in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_VINCULO_CARGO , '','')) t))',
'  and (:P28_TIPO_MODALIDADE     is null or r.TIPO_MODALIDADE in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_TIPO_MODALIDADE , '','')) t))',
'  and (:P28_UNIDADE_ADM     is null or R.COD_UNIDADE_ADM in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_UNIDADE_ADM , '','')) t))',
'  and (:P28_LOCAL_TRAB is null or r.COD_LOCAL_TRAB in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P28_LOCAL_TRAB , '','')) t))',
'  and (:P28_PESQUISAR IS NULL OR ((r.COD_EMPRESA LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(r.cod_sit_req)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(R.vinculo)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNCT_NOME_FILIAL(r.COD_EMPRESA,r.COD_FILIAL,''S''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER( r.TIPO_MODALIDADE)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNC_RETORNA_DADOS_CARGO(r.COD_CARGO,''NOME''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(FNCT_NOME_EMPRESA(r.COD_EMPRESA,''S''))) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(r.COD_FILIAL)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'') OR',
'                                   (trim(UPPER(R.TIPO_PUBLICACAO)) LIKE ''%''||replace(trim(UPPER(:P28_PESQUISAR)),'' '',''%'')||''%'')))  ',
'ORDER BY COD_REQ DESC,cod_sit_req asc'))
,p_display_when_condition=>'P28_RELATORIO'
,p_display_when_cond2=>'C'
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_header=>unistr('<h4>Veja abaixo as vagas dispon\00EDveis.</h4>')
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(56619034940255256313)
,p_query_num_rows=>25
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Realize o filtro e clique em Pesquisar'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52058628553684142332)
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
 p_id=>wwv_flow_api.id(52058628562348142333)
,p_query_column_id=>2
,p_column_alias=>'LIST_TEXT'
,p_column_display_sequence=>6
,p_column_heading=>'List Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52202269780688389517)
,p_query_column_id=>3
,p_column_alias=>'LIST_BADGE'
,p_column_display_sequence=>1
,p_column_heading=>'List Badge'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52202270226132389517)
,p_query_column_id=>4
,p_column_alias=>'ICON_COLOR_CLASS'
,p_column_display_sequence=>3
,p_column_heading=>'Icon Color Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52202270630212389517)
,p_query_column_id=>5
,p_column_alias=>'ICON_CLASS'
,p_column_display_sequence=>2
,p_column_heading=>'Icon Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52202270987457389517)
,p_query_column_id=>6
,p_column_alias=>'LINK'
,p_column_display_sequence=>4
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(42491934061417147797)
,p_query_column_id=>7
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>7
,p_column_heading=>'Cod Req'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(42491934125019147798)
,p_query_column_id=>8
,p_column_alias=>'COD_SIT_REQ'
,p_column_display_sequence=>8
,p_column_heading=>'Cod Sit Req'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(72407628982583151739)
,p_plug_name=>'Processos Seletivos'
,p_icon_css_classes=>'fa-table-play'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951030305909200632)
,p_plug_display_sequence=>1
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>'&P28_SUB_TITLE.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52282536665436829529)
,p_button_sequence=>2
,p_button_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-minus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52282536755089829530)
,p_button_sequence=>12
,p_button_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52202248452447389468)
,p_button_sequence=>22
,p_button_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_button_name=>'Search'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2168422640960878562)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(72407628982583151739)
,p_button_name=>'VOLTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--simple:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52202273528461389520)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(72407628982583151739)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=REQ_PESSOAL_&P_BASE.:52:&SESSION.::&DEBUG.:RP,52::'
,p_icon_css_classes=>'fa-plus'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50465192673034100331)
,p_name=>'P28_COD_PREST_SERV'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52237932109604224104)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51224507362371511089)
,p_name=>'P28_PESQUISAR_SN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51224508115878511096)
,p_name=>'P28_DT_INI'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_prompt=>'Data Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51224508202837511097)
,p_name=>'P28_DT_FIM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_prompt=>'Data Final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52202248850025389475)
,p_name=>'P28_REQUISICAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select COD_PROCESSO ||'' - ''||INITCAP(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME'')) display',
',COD_PROCESSO value',
' from PS_PROCESSO_SELETIVO SELE',
'union',
'select COD_REQ ||'' - ''||INITCAP(FNC_RETORNA_DADOS_CARGO(r.COD_CARGO,''NOME'')) display',
',COD_REQ value',
'  from requisicao R ',
'where r.cod_sit_req = 1',
' order by value desc;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--Selecione--'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52202249245998389490)
,p_name=>'P28_STATUS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_prompt=>'Status'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select distinct(CASE WHEN r.cod_sit_req = 1 THEN ''Prevista''',
'             WHEN r.cod_sit_req = 2 THEN ''Fechada''',
'             WHEN r.cod_sit_req = 3 THEN ''Cancelada''',
'             WHEN r.cod_sit_req = 4 THEN ''Reprovada''',
'             WHEN r.cod_sit_req = 5 THEN ''Aberta'' END) list_badge',
'             ,r.cod_sit_req',
'   from requisicao R ',
'    order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52202250050399389490)
,p_name=>'P28_EMP_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Empresas'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT(COD_EMPRESA)||''-''||INITCAP(FNCT_NOME_EMPRESA(SELE.COD_EMPRESA,''S'')) display',
',COD_EMPRESA value',
' from PS_PROCESSO_SELETIVO SELE',
' order by COD_EMPRESA desc;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52202273938928389521)
,p_name=>'P28_TITLE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(72407628982583151739)
,p_source=>'null;'
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52202274331262389521)
,p_name=>'P28_SUB_TITLE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(72407628982583151739)
,p_item_default=>'Acompanhe/Gerencie o status das vagas disponiveis e o Processo Seletivo.'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52282535975058829522)
,p_name=>'P28_CARGO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct(case when SELE.COD_CARGO is not null ',
'     then SELE.COD_CARGO||'' - ''||trim(INITCAP(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME''))) end) cargo ',
'     ,SELE.COD_CARGO',
'FROM PS_PROCESSO_SELETIVO sele',
'order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52282536117919829523)
,p_name=>'P28_ETAPA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_prompt=>'Etapa do Processo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'  SELECT DISTINCT(INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual)))',
' ,INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual))',
' FROM PS_PROCESSO_SELETIVO SELE',
' ORDER BY 1;',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52282536238821829524)
,p_name=>'P28_FILIAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(COD_FILIAL)||'' - ''||INITCAP(FNCT_NOME_FILIAL(sele.COD_EMPRESA,sele.COD_FILIAL,''S'')) display',
',COD_FILIAL value',
' from PS_PROCESSO_SELETIVO SELE',
' order by COD_FILIAL desc;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52282536285562829525)
,p_name=>'P28_CENTRO_CUSTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Centro de Custo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct(COD_CCUSTO)||'' - ''||ccust.NOME display',
',COD_CCUSTO value',
'FROM PS_PROCESSO_SELETIVO prse',
',centro_de_custo ccust',
'where ccust.cod = prse.COD_CCUSTO',
'order by COD_CCUSTO;',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52282536399506829526)
,p_name=>'P28_UNIDADE_ADM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Unidade Administrativa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod_unidade_adm||'' - ''||initcap(a.DESCRICAO) descricao',
'   , a.cod_unidade_adm cod',
'  from unidade_administrativa a',
'order by to_number(a.cod_unidade_adm);'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52282536599013829528)
,p_name=>'P28_SELECIONADOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52237932109604224104)
,p_prompt=>'Selecionador'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(sele.cod_prest_serv)||'' - ''||(SELECT p2.nome FROM prestador_servico p2 WHERE p2.tipo_prest_serv = sele.tipo_prest_serv AND p2.cod_prest_serv = sele.cod_prest_serv)  nome',
' ,sele.cod_prest_serv',
'from PS_PROCESSO_SELETIVO  sele',
'where sele.cod_prest_serv is not null ',
'union',
'select ''SEM SELECIONADOR''  nome',
' ,''00'' cod_prest_serv',
'from dual',
'order by 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'TODOS'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52391607943619316100)
,p_name=>'P28_VINCULO_CARGO'
,p_item_sequence=>105
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>unistr('Vinculo de Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod||'' - ''||Initcap(a.nome) descricao, a.cod codigo',
'      from vinculo_empreg a',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52391608044329316101)
,p_name=>'P28_TIPO_MODALIDADE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Tipo de Modalidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct(INITCAP(DESCRICAO)) DESCRICAO, TIPO_MODALIDADE',
'  FROM TIPO_MODALIDADE_TRAB',
' WHERE ATIVO = ''S''',
' ORDER BY CASE WHEN TIPO_MODALIDADE = ''P'' THEN ''A'' WHEN TIPO_MODALIDADE = ''S'' THEN ''B'' ELSE TIPO_MODALIDADE END',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52391608081430316102)
,p_name=>'P28_LOCAL_TRAB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_prompt=>'Local de Trabalho'
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
'      FROM local_trab l',
'      , filial_local f',
'     WHERE l.cod_local_trab = f.cod_local_filial',
'order by TO_NUMBER(cod);',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
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
 p_id=>wwv_flow_api.id(52391609785436316119)
,p_name=>'P28_ENVOLVIDO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_item_default=>'S'
,p_prompt=>'Tipo de Consulta'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Todas as Vagas;T,Minhas Vagas;S'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52404967887507151696)
,p_name=>'P28_RELATORIO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(70976159724038084679)
,p_item_default=>'C'
,p_prompt=>unistr('Tipo de Relat\00F3rio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Lista;C,Interativo Detalhado;I'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52404969236087151709)
,p_name=>'P28_TIPO_PUBLICACAO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(52237932296783224106)
,p_item_default=>'T'
,p_prompt=>unistr('Tipo Publica\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:Todas;T,Externa;E,Interna;I'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52404969370898151711)
,p_name=>'P28_PESQUISAR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(71401748907910240282)
,p_prompt=>'Pesquisar Vagas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52404969520257151712)
,p_name=>'P28_PESQUISAR_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52391609903458316120)
,p_prompt=>'Pesquisar Vagas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439137174823755308)
,p_name=>'P28_AVALIADOR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52237932109604224104)
,p_prompt=>'Avaliador'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(NOME) ||'' (''||(R.MAT_REQ)||'')''   nome ',
'  ,    R.MAT_REQ matricula',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'    , inf_pessoais pess',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'and pess.MATRICULA = R.MAT_REQ',
'order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'TODOS'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439137262649755309)
,p_name=>'P28_GESTOR'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52237932109604224104)
,p_prompt=>'Gestor'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(NOME) ||'' (''||(R.MAT_REQ)||'')''   nome ',
'  ,    R.MAT_REQ matricula',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'    , inf_pessoais pess',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'and pess.MATRICULA = R.MAT_REQ',
'order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'TODOS'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439137391645755310)
,p_name=>'P28_APROVADOR'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52237932109604224104)
,p_prompt=>'Aprovador'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(NOME) ||'' (''||(R.MAT_REQ)||'')''   nome ',
'  ,    R.MAT_REQ matricula',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'    , inf_pessoais pess',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'and pess.MATRICULA = R.MAT_REQ',
'order by 1;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'TODOS'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52202275032161389555)
,p_name=>'OPER'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :IS_MASTER = ''Y'' OR :IS_ADMIN = ''Y'' THEN',
'RETURN FALSE;',
'ELSE',
'RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52202275480426389565)
,p_event_id=>wwv_flow_api.id(52202275032161389555)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P28_MY_PROCESS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52202276008539389571)
,p_event_id=>wwv_flow_api.id(52202275032161389555)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P28_MY_PROCESS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52282536940459829531)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52282536755089829530)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52282537021767829532)
,p_event_id=>wwv_flow_api.id(52282536940459829531)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
 p_id=>wwv_flow_api.id(52282537118497829533)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52282537247840829534)
,p_event_id=>wwv_flow_api.id(52282537118497829533)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
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
 p_id=>wwv_flow_api.id(52302809534610935994)
,p_name=>'Close Parametros_Itens_1'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52282536665436829529)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52302809610291935995)
,p_event_id=>wwv_flow_api.id(52302809534610935994)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
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
 p_id=>wwv_flow_api.id(52404967971595151697)
,p_name=>'Ajusta_relatorio'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P28_RELATORIO'
,p_condition_element=>'P28_RELATORIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'I'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52404968055702151698)
,p_event_id=>wwv_flow_api.id(52404967971595151697)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52391609903458316120)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52404968769553151705)
,p_event_id=>wwv_flow_api.id(52404967971595151697)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(71401748907910240282)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52404968255452151700)
,p_event_id=>wwv_flow_api.id(52404967971595151697)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(71401748907910240282)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52404968699485151704)
,p_event_id=>wwv_flow_api.id(52404967971595151697)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52391609903458316120)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51224507506884511090)
,p_name=>'Search'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52202248452447389468)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51224507685556511092)
,p_event_id=>wwv_flow_api.id(51224507506884511090)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P28_PESQUISAR_SN'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51224507629203511091)
,p_event_id=>wwv_flow_api.id(51224507506884511090)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'Search'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2152123260251628825)
,p_name=>'Voltar'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2168422640960878562)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2152123379126628826)
,p_event_id=>wwv_flow_api.id(2152123260251628825)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.navigation.dialog.close(true);'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52202274668679389549)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Perfil'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT PS.COD_PREST_SERV',
'  from PRESTADOR_SERVICO PS, USUARIO_ORACLE U',
' WHERE PS.COD_EMPRESA_ENDERECO = U.CD_EMPRESA',
'   AND PS.MAT_PRESTADOR = U.CD_MATRICULA',
'   AND U.NM_USUARIO_ORACLE = :P_USUARIO;',
' ',
'V_C1 C1%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
':P28_COD_PREST_SERV := V_C1.COD_PREST_SERV;',
'',
'IF :IS_OPER = ''Y'' THEN',
':P28_MY_PROCESS := ''Y'';',
'END IF;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51224507962445511095)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pesquisa (S/N)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p28_pesquisar is not null or :p28_pesquisar_1 is not null then',
':p28_pesquisar_sn := ''S'';',
'end if;',
'',
'if :p28_envolvido = ''S'' then',
':p28_pesquisar_sn := ''S'';',
'end if;',
'',
'if :p28_dt_ini is null and nvl(:p28_pesquisar_sn,''N'') = ''N'' then',
':p28_dt_fim := sysdate;',
':p28_dt_ini := add_months(sysdate,-1);',
'end if;'))
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
