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
--   Date and Time:   18:24 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 29
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00029
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>29);
end;
/
prompt --application/pages/page_00029
begin
wwv_flow_api.create_page(
 p_id=>29
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>unistr('Descri\00E7\00E3o da Vaga')
,p_step_title=>unistr('Descri\00E7\00E3o da Vaga')
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoDetalhe.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoDetalhe.css'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function save_checkbox_state() {',
'  var params = $(''.checkbox_item'').map(function() {',
'                 let $chk = $(this)',
'                 return {"id": $chk.val(), "checked": $chk.prop(''checked'').toString()}',
'               }).get();',
'',
'  if (params && params.length) {',
'    //var pWait = apex.widget.waitPopup()',
'    apex.server.process(''salvar_ids'', {',
'      x01: JSON.stringify(params)',
'    }, {',
'      dataType: "text"',
'    }).done(function(text) {',
'      //console.log(''foi:'' + text);',
'    }).fail(function() {',
'      alert(''Erro ao checar item!'');',
'    }).always(function() {',
'      //pWait.remove();',
'      $(''#partnersIRR'').trigger(''apexafterrefresh'')',
'    });',
'  }',
'}',
'',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(document).on(''change'', ''.checkbox_item'', apex.util.debounce(save_checkbox_state, 800))',
'',
'',
'$("#partnersIRR td[headers=APROVADO]").each(function(){',
'    celldata= $(this).text();',
'    if (celldata == ''Sim''){',
'    $(this).parent().children().css(''background-color'',''#B5F5D0 !important'');',
'    }});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.a-StarRating-stars-fg {',
'    color: #c95788 !important;',
'}',
'',
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
'  background: #8c8c8c;',
'}',
'',
'.bloco {',
'  background: lightblue;',
'  font-size: 10px;',
'  color: white;',
'  padding: 10px;',
'  border-radius: 50%;',
'  text-align: center;',
'  display: inline-block;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'img { height: 100px }',
'',
'.t-Card-wrap {',
'  width: 118px !important;',
'}',
'',
'#partnersIRR td.linha-vermelha {',
'    background-color: #ffe6e6 !important;',
'    color: #cc0000 !important;',
'}'))
,p_step_template=>wwv_flow_api.id(72951015765967200558)
,p_page_template_options=>'#DEFAULT#'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_ProcessoDetalhe.css / Natcorp_ProcessoDetalhe.js)',
'',
unistr('No alto, a FICHA DA VAGA (lida da regi\00E3o "Descri\00E7\00E3o da Vaga", que sai da coluna lateral): situa\00E7\00E3o,'),
unistr('empresa, filial, centro de custo, selecionador, prazo com a contagem e os bot\00F5es de sempre (Detalhes'),
unistr('da Vaga, Requisi\00E7\00E3o, Anota\00E7\00F5es, Processo Seletivo, Finalizar Processo). Depois, CANDIDATOS: o funil das'),
unistr('etapas (lido dos cart\00F5es "por etapa"; tocar filtra a lista), a busca do relat\00F3rio e uma LINHA por'),
'candidato (nome, idade, local, sinais, etapa, nota e atalhos CV/e-mail/WhatsApp/LinkedIn). A caixa',
unistr('de sele\00E7\00E3o APERTA a original (.checkbox_item): a p\00E1gina grava a sele\00E7\00E3o e "Mudar fase" vai para a'),
unistr('barra que aparece com os selecionados. Lista | Tabela devolve o relat\00F3rio original.'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSODETALHE-MANUTENCAO.md.',
unistr('---- (fim do bloco Natcorp; abaixo, o coment\00E1rio que a p\00E1gina j\00E1 tinha) ----'),
'.a-StarRating-stars-fg {',
'    color: #c95788 !important;',
'}',
'',
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
'.bloco {background: lightblue;',
'      font-size: 10px;',
'      color: white;',
'      padding: 10px;',
'      border-radius: 50%;',
'      text-align: center;',
'      display: inline;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'img { height: 100px }',
'',
'/*',
'.t-Cards--float .t-Cards-item {',
'    max-width: 150px !important;',
'    min-width: 150px !important;',
'}',
'*/',
'',
'.t-Card-wrap {width: 118px !important};'))
,p_last_updated_by=>'SUPORTE_NATCORP'
,p_last_upd_yyyymmddhh24miss=>'20260622213313'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51327802118597045436)
,p_plug_name=>'Incluir Candidato'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(72951030450318200632)
,p_plug_display_sequence=>42
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52208804415960891112)
,p_plug_name=>unistr('Descri\00E7\00E3o da Vaga')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>12
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C_DADOS IS',
'  SELECT sele.rowid ROWID_PS',
',      FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME'') CARGO',
',      SELE.COD_PROCESSO',
',      DECODE(sele.status,''A'',''Ativo'',''F'',''Finalizada'',''C'',''Cancelada'') status',
',      DT_SOLICITACAO',
',      DT_APROVACAO ATIVO_EM',
',      DT_FECHAMENTO PRAZO_CONTRATACAO',
',      pkg_Selecao.fnc_RetFaseProcessoAtual(SELE.COD_REQ, ''D'') fase_atual_REQUISICAO',
',      R.COD_EMPRESA||'' - ''||INITCAP(FNCT_NOME_EMPRESA(R.COD_EMPRESA,''S'')) EMPRESA',
',      R.COD_FILIAL||'' - ''||INITCAP(FNCT_NOME_FILIAL(R.COD_EMPRESA,R.COD_FILIAL,''S'')) FILIAL',
',      R.COD_CCUSTO||'' - ''||INITCAP(FNCT_NOME_CCUSTO(R.COD_EMPRESA,R.COD_CCUSTO)) CCUSTO',
',      DECODE(NVL(R.TIPO_PUBLICACAO,''T''),''I'',''Interno'',''E'',''Externo'',''T'',''Externo/Interno'') TIPO_PUBLICACAO',
',      SELE.cod_prest_serv ||'' - ''||(SELECT p2.nome FROM prestador_servico p2 WHERE p2.tipo_prest_serv = sele.tipo_prest_serv',
'                                        AND p2.cod_prest_serv = sele.cod_prest_serv) selecionador',
', CASE WHEN SELE.QUADRO_VAGA_ID IS NOT NULL THEN upper(Q.NOME) else ''-'' end publicacao',
',CASE WHEN r.cod_sit_req = 1 THEN ''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||upper(''Prevista'')',
'                    WHEN r.cod_sit_req = 2 THEN ''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||upper(''Fechada'')',
'                    WHEN r.cod_sit_req = 3 THEN ''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||upper(''Cancelada'')',
'                    WHEN r.cod_sit_req = 4 THEN ''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||upper(''Reprovada'')',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is null THEN ''<span aria-hidden="true" class="fa fa-play-circle colorAlert"></span> ''||upper(''Aberta'')',
'                    WHEN r.cod_sit_req = 5 AND sele.quadro_vaga_id is not null THEN ''<span aria-hidden="true" class="fa fa-play-circle" style="color: #0572ce"></span> ''||upper(''Publicada'')',
'       END  status_req  ',
' FROM PS_PROCESSO_SELETIVO SELE,',
'      QUADRO_VAGAS_LAYOUT Q,',
'      REQUISICAO R',
'WHERE SELE.COD_REQ = R.COD_REQ',
'AND SELE.COD_REQ = :P29_REQUISICAO',
'AND SELE.COD_EMPRESA = :P29_EMP_ID',
'AND SELE.QUADRO_VAGA_ID = Q.ID (+);',
'',
'',
'R_DADOS C_DADOS%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C_DADOS;',
'FETCH C_DADOS INTO R_DADOS;',
'CLOSE C_DADOS;',
'',
':P29_ROWID := R_DADOS.ROWID_PS;',
'',
'htp.p(''<style>''); ',
'htp.p(''.label {color:#4238ca; font-weight:bold;}''); ',
'htp.p(''</style>''); ',
'',
'     --htp.p(''<label class="label">Cargo:  </label><br /><b>'' ||R_DADOS.COD_PROCESSO||''-''||R_DADOS.CARGO||''</b><br/><br/>'');',
'     ',
'     htp.p(''<br/><strong>'' ||R_DADOS.STATUS_REQ||''</strong><br/><br/>'');',
'     htp.p(''<label class="label">Empresa:  </label><br />'' ||R_DADOS.EMPRESA||''<br/><br/>'');',
'     htp.p(''<label class="label">Filial:   </label><br />'' ||R_DADOS.FILIAL||''<br/><br/>'');',
'     htp.p(''<label class="label">Centro de Custo:   </label><br />'' ||R_DADOS.CCUSTO||''<br/><br/>'');',
'     if r_dados.selecionador is not null then ',
'     htp.p(''<label class="label">Selecionador:   </label><br />'' ||R_DADOS.selecionador||''<br/><br/>'');',
'     end if;',
'     htp.p(''<label class="label">Ativo em:  </label><br />'' ||R_DADOS.ATIVO_EM||''<br/><br/>'');',
'     if r_dados.prazo_contratacao is not null then',
unistr('     htp.p(''<label class="label">Prazo de Contrata\00E7\00E3o:  </label>'' ||R_DADOS.PRAZO_CONTRATACAO||''<br/><br/>'');'),
'     end if;',
unistr('     htp.p(''<label class="label">Tipo de Publica\00E7\00E3o:  </label><br />'' ||R_DADOS.TIPO_PUBLICACAO||''<br/><br/>'');'),
unistr('     htp.p(''<label class="label">Publica\00E7\00E3o:  </label><br />'' ||nvl(R_DADOS.PUBLICACAO,''N\00E3o Publicado'')||''<br/><br/>'');'),
'',
'',
'',
'htp.p(''<br />''); ',
'',
'END;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(52208805036279891118)
,p_name=>'Visualizar candidato(s) por etapa'
,p_template=>wwv_flow_api.id(72951031880997200635)
,p_display_sequence=>12
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Cards--displaySubtitle:t-Cards--featured force-fa-lg:t-Cards--float:t-Cards--hideBody:t-Cards--iconsSquare:t-Cards--animRaiseCard:t-Report--hideNoPagination'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT INITCAP(FACA.DESC_FASE) CARD_TITLE',
',NVL((SELECT COUNT(COD_CANDIDATO) COD_CANDIDATO',
'    FROM (SELECT MAX(COD_FASE) COD_FASE ,COD_CANDIDATO FROM candidato cand where cand.cod_processo = PRSE.cod_req GROUP BY COD_CANDIDATO) cand',
'   WHERE FACA.cod_fase = CAND.COD_FASE',
'   GROUP BY COD_FASE),0) CARD_SUBTITLE',
',  PRFA.FASE_SUPERIOR CARD_SUBTEXT',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'and PRSE.cod_req = :P29_REQUISICAO',
'union',
'SELECT ''Todos'' CARD_TITLE ',
',(SELECT COUNT(COD_CANDIDATO) COD_CANDIDATO',
'   FROM (SELECT MAX(COD_FASE) COD_FASE ',
'               ,COD_CANDIDATO ',
'           FROM candidato cand ',
'          where cand.cod_processo = :P29_REQUISICAO ',
'          GROUP BY COD_CANDIDATO) cand) CARD_SUBTITLE',
', 000 CARD_SUBTEXT',
'FROM fase_candidato FACA',
'ORDER BY CARD_SUBTEXT ASC;'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(72951038120959200649)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52258322092186352519)
,p_query_column_id=>1
,p_column_alias=>'CARD_TITLE'
,p_column_display_sequence=>1
,p_column_heading=>'Card Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52258322214486352520)
,p_query_column_id=>2
,p_column_alias=>'CARD_SUBTITLE'
,p_column_display_sequence=>2
,p_column_heading=>'Card Subtitle'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(52258322286515352521)
,p_query_column_id=>3
,p_column_alias=>'CARD_SUBTEXT'
,p_column_display_sequence=>3
,p_column_heading=>'Card Subtext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52237932367909224107)
,p_plug_name=>unistr('Rela\00E7\00E3o de Candidatos ')
,p_icon_css_classes=>'fa-users'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--showIcon:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>22
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52252290618601543294)
,p_plug_name=>unistr('Rela\00E7\00E3o de Candidatos - IR')
,p_region_name=>'partnersIRR'
,p_parent_plug_id=>wwv_flow_api.id(52237932367909224107)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case when (select IND_AVAL_FASE',
'   from CANDIDATO cand1 ',
'  where CAND.COD_CANDIDATO = CAND1.COD_CANDIDATO ',
'    AND COD_FASE = (SELECT MAX(COD_FASE)',
'                      FROM CANDIDATO cand2 ',
'                     WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                       AND CAND2.COD_REQ = CAND.COD_REQ)',
'    and CAND1.COD_REQ =CAND.COD_REQ',
'     FETCH FIRST 1 ROWS ONLY) < (SELECT x.nota_de_corte',
'                                          FROM ps_processo_fase x ',
'                                         WHERE x.cod_processo = CAND.COD_REQ',
'										 AND x.cod_fase = cand.cod_fase',
'                                         FETCH FIRST 1 ROWS ONLY) then null',
'										 else apex_item.checkbox(1,CAND.COD_CANDIDATO) end ckeck1 ,',
'       INITCAP(fnct_nome_cand(PESS.EMPRESA,PESS.COD_CANDIDATO)) nome,',
'       PESS.COD_CANDIDATO,',
'       ''Externo'' tipo_candidato,',
'       cand.COD_FASE||'' - ''||(SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = cand.cod_fase FETCH FIRST 1 ROWS ONLY) COD_FASE,',
'       CAND.DATE_FASE,',
'      ( SELECT P.cod_prest_serv||'' - ''||P.nome||'' [''||NVL(TO_CHAR(P.mat_prestador),''-'')||'']'' det',
'          FROM prestador_servico p ',
'         WHERE P.cod_prest_serv = COD_PREST_SERV_AVALIADOR ',
'        FETCH FIRST 1 ROWS ONLY) COD_PREST_SERV_AVALIADOR,',
'       CAND.USUARIO,',
'       CAND.DT_ATUALIZACAO,',
'       case when (select IND_AVAL_FASE',
'   from CANDIDATO cand1',
'  where CAND.COD_CANDIDATO = CAND1.COD_CANDIDATO ',
'    AND COD_FASE = (SELECT MAX(COD_FASE)',
'                      FROM CANDIDATO cand2 ',
'                     WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                       AND CAND2.COD_REQ = CAND.COD_REQ)',
'    and CAND1.COD_REQ =CAND.COD_REQ',
'    FETCH FIRST 1 ROWS ONLY) < (SELECT x.nota_de_corte',
'                                          FROM ps_processo_fase x ',
'                                         WHERE x.cod_processo = CAND.COD_REQ',
'										                       AND x.cod_fase = cand.cod_fase',
'                                         FETCH FIRST 1 ROWS ONLY) then ''Candidato Abaixo da Nota de Corte''',
'										 else (SELECT af.cod_aval_fase||'' - ''||af.desc_aval_fase det',
'                             FROM avaliacao_fase af ',
'                            where af.cod_aval_fase = cand.cod_aval_fase',
'                            FETCH FIRST 1 ROWS ONLY) end  COD_AVAL_FASE,',
'       CAND.DATA_AVAL_FASE,',
'       CAND.IND_AVAL_FASE,',
'       CAND.MOT_AVAL_FASE,',
'       CAND.RESULTADO_FASE,',
'       CAND.COD_REQ,',
'       CAND.COD_PROCESSO,',
'       CAND.COD_VAGA,',
'       CAND.COD_EMPRESA COD_EMP_CAND,',
'       CASE WHEN PESS.IND_DEF_FIS = ''S'' THEN --fas fa-wheelchair',
'         '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' end PCD,       ',
unistr('       case when CHECK_APROV =''S'' THEN ''Sim'' else ''N\00E3o'' end CHECK_APROV,'),
'       CASE WHEN CA.COD_CANDIDATO IS NULL THEN',
'         apex_page.get_url (',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO'',',
'         p_values      => PESS."EMPRESA"||'',''||PESS."COD_CANDIDATO"',
'         ) ',
'         ELSE',
'        apex_page.get_url (',
'         p_application => ''RS_PRC_''||:P_BASE,',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO,P39_VAGA,P39_FILIAL_VAGA,P39_EMPRESA_VAGA,P39_DT_CONTRATACAO,P39_SELECIONADO'',',
'         p_values      => PESS."EMPRESA"||'',''||PESS."COD_CANDIDATO"||'',''||CA.COD_VAGA||'',''||CA.COD_FILIAL||'',''||CA.COD_EMPRESA||'',''||CA.DT_CONTRATACAO||'',''||''S''',
'         )',
'         END link_CV,',
'        ''EMAIL'' EMAIL',
'   , PESS.DT_NAC DATA_NASCIMENTO',
'   , trunc((months_between(sysdate,to_date(PESS.DT_NAC,''dd/mm/rrrr'')))/12) IDADE',
'   , LOWER(PESS.E_MAIL) E_MAIL',
'   ,   CASE WHEN PESS.SEXO = ''F'' THEN ''Feminino''',
'            WHEN PESS.SEXO = ''M'' THEN ''Masculino''',
'        else PESS.SEXO end SEXO',
'   , (select g.nome from genero_sexual g where g.cod = pess.genero) genero',
'   , CASE WHEN POSSUI_DEPENDENTE = ''S'' THEN ''Sim''',
unistr('            WHEN POSSUI_DEPENDENTE = ''N'' THEN ''N\00E3o'''),
'        else POSSUI_DEPENDENTE end POSSUI_DEPENDENTE',
'   , INITCAP(NVL((SELECT EMP.CARGO ',
'                    FROM empregos_anteriores EMP',
'                   WHERE EMP.COD_CANDIDATO = FUNC.COD_CANDIDATO',
unistr('                     AND DATA_DESL_EMP = (SELECT MAX(DATA_DESL_EMP) FROM empregos_anteriores EMP2 WHERE EMP2.COD_CANDIDATO = EMP.COD_CANDIDATO) FETCH FIRST 1 ROWS ONLY),''N\00C3O INFORMADO'')) ULTIMO_CARGO  '),
'   , INITCAP(NVL((SELECT COD_TITULACAO',
'                    FROM (SELECT COD_TITULACAO',
unistr('                             ,   case when COD_TITULACAO = ''Tecn\00F3logo'' then 2'),
'                                      when COD_TITULACAO = ''Bacharelado'' then 3',
'                                      when COD_TITULACAO = ''Licenciatura'' then 4',
unistr('                                      when COD_TITULACAO = ''P\00F3s-Gradua\00E7\00E3o'' then 5'),
'                                      when COD_TITULACAO = ''MBA'' then 6   ',
'                                      when COD_TITULACAO = ''Mestrado'' then 7',
'                                      when COD_TITULACAO = ''Doutorado'' then 8 END COD_TITULO',
'                            FROM FORMACAO_ESCOLAR_CANDIDATO FORM',
'                           WHERE FORM.COD_CANDIDATO = FUNC.COD_CANDIDATO) TITU',
'                   ORDER BY COD_TITULO DESC',
unistr('                   FETCH FIRST ROW ONLY),''N\00C3O INFORMADO'')) GRAU_INSTRUCAO,'),
'CASE WHEN PESS.TELEFONE_CELULAR IS NOT NULL THEN ''https://api.whatsapp.com/send?phone=55''||PESS.DDD_CELULAR||PESS.TELEFONE_CELULAR ',
'        ELSE ''https://api.whatsapp.com/send?phone=55''||PESS.DDD||PESS.TELEFONE',
'        END WHATSAPP,',
unistr('        nvl((select ''Sim'' from candidato_aprovado z where z.cod_candidato = cand.cod_candidato and z.cod_solicitacao = cand.cod_req),''N\00E3o'') Aprovado,'),
'       fnct_sit_candidato (pess.cod_candidato) status_candidato,',
'       fnct_valida_doc_cand (pess.empresa, pess.cod_candidato) Documentos,',
'       case when pess.url_linkedin is not null then',
'         ''<a href="'' || pess.url_linkedin || ''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'width="20" height="20">',
'  <path data-name="layer1"',
'  fill="#0077b7" d="M1.15 21.7h13V61h-13zm46.55-1.3c-5.7 0-9.1 2.1-12.7 6.7v-5.4H22V61h13.1V39.7c0-4.5 2.3-8.9 7.5-8.9s8.3 4.4 8.3 8.8V61H64V38.7c0-15.5-10.5-18.3-16.3-18.3zM7.7 2.6C3.4 2.6 0 5.7 0 9.5s3.4 6.9 7.7 6.9 7.7-3.1 7.7-6.9S12 2.6 7.7 2.6z"'
||'></path>',
'</svg></a>''',
'       end as url_linkedin,',
'''<div class="a-StarRating">',
'	<input type="text" name="PONTUACAO" value="''||cand.pontuacao||''" class="u-vh is-focusable" role="spinbutton" aria-valuenow="''||cand.pontuacao||''" aria-valuemax="5" aria-valuetext="''||cand.pontuacao||''"> ',
'		<div class="a-StarRating-stars"> ',
'			<div class="a-StarRating-starsInner">',
'				<div class="a-StarRating-stars-bg">',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (1,2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao = 5 then ''style="color: #c95788"'' end||''></span>',
'				</div>',
'			</div>',
'		</div>',
'</div>'' pontuacao,',
'       case when pess.cidade is not null then upper(pess.cidade)||''/''||upper(pess.uf) end Localidade,',
'       CAND.COD_FASE FASE,',
'apex_item.checkbox2 (',
'         p_idx                      => 1,',
'         p_value                    => CAND.cod_candidato,',
'         p_attributes               => ''class="checkbox_item"'',',
'         p_checked_values           => (select listagg (n001, '':'') within group (order by n001)',
'                                          from apex_collections',
'                                         where collection_name = :P29_COLLECTION_NAME),',
'         p_checked_values_delimiter => '':''',
'       ) as "Select"',
'       ,(SELECT DISTINCT ''S'' RESTRICAO_ADMISSAO FROM RESTRICAO_ADMISSAO RA WHERE RA.DC_CPF = PESS.DC_CPF AND RA.NUM_CPF = PESS.NUM_CPF) RESTRICAO_ADMISSAO',
'       ,CASE WHEN (SELECT DISTINCT ''S'' FROM RESTRICAO_ADMISSAO RA WHERE RA.DC_CPF = PESS.DC_CPF AND RA.NUM_CPF = PESS.NUM_CPF) = ''S'' THEN ''linha-vermelha'' ELSE '''' END as CLASSE_LINHA',
' FROM CANDIDATO CAND',
'    , INF_FUNC_CANDIDATO FUNC',
'    , INF_PESSOAIS_CANDIDATO PESS',
'    , RP_CAND_INSCRITOS inscr',
'    , CANDIDATO_APROVADO CA',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = INSCR.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = CA.COD_CANDIDATO (+)',
'  AND CAND.COD_REQ = CA.COD_SOLICITACAO (+)',
'  AND CAND.COD_REQ       = :P29_REQUISICAO',
'  AND CAND.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_REQ = CAND.COD_REQ)',
'union',
'select case when (select IND_AVAL_FASE',
'   from CANDIDATO cand1 ',
'  where CAND.COD_CANDIDATO = CAND1.COD_CANDIDATO ',
'    AND COD_FASE = (SELECT MAX(COD_FASE)',
'                      FROM CANDIDATO cand2 ',
'                     WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                       AND CAND2.COD_REQ = CAND.COD_REQ)',
'    and CAND1.COD_REQ = CAND.COD_REQ',
'    FETCH FIRST 1 ROWS ONLY) < (SELECT x.nota_de_corte',
'                                          FROM ps_processo_fase x ',
'                                         WHERE x.cod_processo = CAND.COD_REQ',
'										 AND x.cod_fase = cand.cod_fase',
'                                         FETCH FIRST 1 ROWS ONLY) then null',
'										 else apex_item.checkbox(1,CAND.COD_CANDIDATO) end ckeck1 ,',
'       INITCAP(fnct_nome_cand(PESS.EMPRESA,PESS.COD_CANDIDATO)) nome,',
'       PESS.COD_CANDIDATO,',
'       ''Interno'' tipo_candidato,',
'       cand.COD_FASE||'' - ''||(SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = cand.cod_fase) COD_FASE,',
'       CAND.DATE_FASE,',
'      ( SELECT P.cod_prest_serv||'' - ''||P.nome||'' [''||NVL(TO_CHAR(P.mat_prestador),''-'')||'']'' det',
'          FROM prestador_servico p ',
'         WHERE P.cod_prest_serv = COD_PREST_SERV_AVALIADOR FETCH FIRST 1 ROWS ONLY) COD_PREST_SERV_AVALIADOR,',
'       CAND.USUARIO,',
'       CAND.DT_ATUALIZACAO,',
'       case when (select IND_AVAL_FASE',
'   from CANDIDATO cand1',
'  where CAND.COD_CANDIDATO = CAND1.COD_CANDIDATO ',
'    AND COD_FASE = (SELECT MAX(COD_FASE)',
'                      FROM CANDIDATO cand2 ',
'                     WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                       AND CAND2.COD_REQ = CAND.COD_REQ)',
'    and CAND1.COD_REQ =CAND.COD_REQ',
'     FETCH FIRST 1 ROWS ONLY) < (SELECT x.nota_de_corte',
'                                          FROM ps_processo_fase x ',
'                                         WHERE x.cod_processo = CAND.COD_REQ',
'										 AND x.cod_fase = cand.cod_fase',
'                                         FETCH FIRST 1 ROWS ONLY) then ''Candidato Abaixo da Nota de Corte''',
'										 else (SELECT af.cod_aval_fase||'' - ''||af.desc_aval_fase det',
'          FROM avaliacao_fase af where af.cod_aval_fase = cand.cod_aval_fase FETCH FIRST 1 ROWS ONLY) end  COD_AVAL_FASE,',
'       CAND.DATA_AVAL_FASE,',
'       CAND.IND_AVAL_FASE,',
'       CAND.MOT_AVAL_FASE,',
'       CAND.RESULTADO_FASE,',
'       CAND.COD_REQ,',
'       CAND.COD_PROCESSO,',
'       CAND.COD_VAGA,',
'       CAND.COD_EMPRESA COD_EMP_CAND,',
'       CASE WHEN PESS.IND_DEF_FIS = ''S'' THEN --fas fa-wheelchair',
'         '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' end PCD,       ',
unistr('       case when CHECK_APROV =''S'' THEN ''Sim'' else ''N\00E3o'' end CHECK_APROV,'),
'         apex_page.get_url (',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO'',',
'         p_values      => PESS."EMPRESA"||'',''||PESS."COD_CANDIDATO"',
'         ) link_CV,',
'        ''EMAIL'' EMAIL',
'   , PESS.DT_NAC DATA_NASCIMENTO',
'   , trunc((months_between(sysdate,to_date(PESS.DT_NAC,''dd/mm/rrrr'')))/12) IDADE',
'   , LOWER(PESS.E_MAIL) E_MAIL',
'   ,   CASE WHEN PESS.SEXO = ''F'' THEN ''Feminino''',
'            WHEN PESS.SEXO = ''M'' THEN ''Masculino''',
'        else PESS.SEXO end SEXO',
'   , (select g.nome from genero_sexual g where g.cod = pess.genero  FETCH FIRST 1 ROWS ONLY) genero',
'   , CASE WHEN PESS.POSSUI_DEPENDENTE = ''S'' THEN ''Sim''',
unistr('            WHEN PESS.POSSUI_DEPENDENTE = ''N'' THEN ''N\00E3o'''),
'        else PESS.POSSUI_DEPENDENTE end POSSUI_DEPENDENTE',
'   , INITCAP(NVL((SELECT EMP.CARGO FROM empregos_anteriores EMP',
'                   WHERE EMP.COD_CANDIDATO = FUNC.COD_CANDIDATO',
unistr('                     AND DATA_DESL_EMP = (SELECT MAX(DATA_DESL_EMP) FROM empregos_anteriores EMP2 WHERE EMP2.COD_CANDIDATO = EMP.COD_CANDIDATO) FETCH FIRST 1 ROWS ONLY),''N\00C3O INFORMADO'')) ULTIMO_CARGO  '),
'   , INITCAP(NVL((SELECT TITU.COD_TITULACAO',
'                    FROM (SELECT COD_TITULACAO',
unistr('                             ,   case when COD_TITULACAO = ''Tecn\00F3logo'' then 2'),
'                                      when COD_TITULACAO = ''Bacharelado'' then 3',
'                                      when COD_TITULACAO = ''Licenciatura'' then 4',
unistr('                                      when COD_TITULACAO = ''P\00F3s-Gradua\00E7\00E3o'' then 5'),
'                                      when COD_TITULACAO = ''MBA'' then 6   ',
'                                      when COD_TITULACAO = ''Mestrado'' then 7',
'                                      when COD_TITULACAO = ''Doutorado'' then 8 END COD_TITULO',
'                            FROM FORMACAO_ESCOLAR_CANDIDATO FORM',
'                           WHERE FORM.COD_CANDIDATO = FUNC.COD_CANDIDATO) TITU',
'                   ORDER BY TITU.COD_TITULO DESC',
unistr('                   FETCH FIRST ROW ONLY),''N\00C3O INFORMADO'')) GRAU_INSTRUCAO,'),
'CASE WHEN PESS.TELEFONE_CELULAR IS NOT NULL THEN ''https://api.whatsapp.com/send?phone=55''||PESS.DDD_CELULAR||PESS.TELEFONE_CELULAR ',
'        ELSE ''https://api.whatsapp.com/send?phone=55''||PESS.DDD||PESS.TELEFONE',
'        END WHATSAPP,',
unistr('        nvl((select ''Sim'' from candidato_aprovado z where z.cod_candidato = cand.cod_candidato and z.cod_solicitacao = cand.cod_req),''N\00E3o'') Aprovado,'),
'       fnct_sit_candidato (pess.cod_candidato) status_candidato,',
'       fnct_valida_doc_cand (pess.empresa, pess.cod_candidato) Documentos,',
'       case when pess.url_linkedin is not null then',
'         ''<a href="'' || pess.url_linkedin || ''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'width="20" height="20">',
'  <path data-name="layer1"',
'  fill="#0077b7" d="M1.15 21.7h13V61h-13zm46.55-1.3c-5.7 0-9.1 2.1-12.7 6.7v-5.4H22V61h13.1V39.7c0-4.5 2.3-8.9 7.5-8.9s8.3 4.4 8.3 8.8V61H64V38.7c0-15.5-10.5-18.3-16.3-18.3zM7.7 2.6C3.4 2.6 0 5.7 0 9.5s3.4 6.9 7.7 6.9 7.7-3.1 7.7-6.9S12 2.6 7.7 2.6z"'
||'></path>',
'</svg></a>''',
'       end as url_linkedin,',
'''<div class="a-StarRating">',
'	<input type="text" name="PONTUACAO"  value="''||cand.pontuacao||''" class="u-vh is-focusable" role="spinbutton" aria-valuenow="''||cand.pontuacao||''" aria-valuemax="5" aria-valuetext="''||cand.pontuacao||''"> ',
'		<div class="a-StarRating-stars"> ',
'			<div class="a-StarRating-starsInner">',
'				<div class="a-StarRating-stars-bg">',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (1,2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao in (4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when cand.pontuacao = 5 then ''style="color: #c95788"'' end||''></span>',
'				</div>',
'			</div>',
'		</div>',
'</div>'' pontuacao,',
'case when pess.cidade is not null then upper(pess.cidade)||''/''||upper(pess.uf) end Localidade,',
'CAND.COD_FASE FASE,',
'apex_item.checkbox2 (',
'         p_idx                      => 1,',
'         p_value                    => CAND.cod_candidato,',
'         p_attributes               => ''class="checkbox_item"'',',
'         p_checked_values           => (select listagg (n001, '':'') within group (order by n001)',
'                                          from apex_collections',
'                                         where collection_name = :P29_COLLECTION_NAME),',
'         p_checked_values_delimiter => '':''',
'       ) as "Select"',
'       ,(SELECT DISTINCT ''S'' RESTRICAO_ADMISSAO FROM RESTRICAO_ADMISSAO RA WHERE RA.DC_CPF = PESS.DC_CPF AND RA.NUM_CPF = PESS.NUM_CPF) RESTRICAO_ADMISSAO       ',
'       ,CASE WHEN (SELECT DISTINCT ''S'' FROM RESTRICAO_ADMISSAO RA WHERE RA.DC_CPF = PESS.DC_CPF AND RA.NUM_CPF = PESS.NUM_CPF) = ''S'' THEN ''linha-vermelha'' ELSE '''' END as CLASSE_LINHA',
' FROM CANDIDATO CAND',
'    , INF_FUNC_CANDIDATO FUNC',
'    , INF_PESSOAIS_CANDIDATO PESS',
'    , INF_PESSOAIS_CAD P',
'    , RP_FUNC_INSCRITOS inscr',
'    , CANDIDATO_APROVADO CA',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = P.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = CA.COD_CANDIDATO (+)',
'  AND P.COD_EMPRESA = INSCR.COD_EMPRESA',
'  AND P.MATRICULA = INSCR.MATRICULA',
'  AND CAND.COD_REQ = CA.COD_SOLICITACAO (+)',
'  AND CAND.COD_REQ       = :P29_REQUISICAO',
'  AND CAND.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_REQ = CAND.COD_REQ)',
'order by 5 desc, 10 desc, 2'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P29_EMP_ID,P29_REQUISICAO'
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
);
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(52364567056549580327)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Nenhum candidato inscrito'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:RP,32:P32_COD_CANDIDATO,P32_COD_REQUISICAO,P32_COD_EMPRESA,P32_DESC_PROCESSO,P32_COD_CANDIDATO_1,P32_COD_FASE,P32_COD_EMPRESA_1,P32_COD_PROCESSO,P32_RESTRICAO_ADMISSAO:#COD_CANDIDATO#,#COD_REQ#,#COD_EMP_CAND#,&P29_T'
||'ITULO.,#COD_CANDIDATO#,#FASE#,#COD_EMP_CAND#,#COD_PROCESSO#,#RESTRICAO_ADMISSAO#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'DANIEL.TASSO'
,p_internal_uid=>1052508402113076936
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058400690082981980)
,p_db_column_name=>'Select'
,p_display_order=>10
,p_column_identifier=>'AI'
,p_column_label=>'Selecione<div style="text-align:center;margin-top: 7px"><input type="checkbox" id="SELECT_ALL"></div>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_format_mask=>'PCT_GRAPH:::'
,p_static_id=>'SELECT'
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_condition=>'P29_STATUS'
,p_display_condition2=>'2'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51327800703301045422)
,p_db_column_name=>'CKECK1'
,p_display_order=>20
,p_column_identifier=>'AF'
,p_column_label=>'Sel.'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_format_mask=>'PCT_GRAPH:::'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391608544031316106)
,p_db_column_name=>'LINK_CV'
,p_display_order=>30
,p_column_identifier=>'T'
,p_column_label=>'CV'
,p_column_link=>'#LINK_CV#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-file-user fa-2x"></span>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'STRING'
,p_column_comment=>unistr('target="_blank" title="Curr\00EDculo"')
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364567789052580334)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Cod. Candidato'
,p_column_html_expression=>'<span class="marcador-linha #CLASSE_LINHA#">#COD_CANDIDATO#</span>'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364567656539580333)
,p_db_column_name=>'NOME'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364567917457580335)
,p_db_column_name=>'COD_FASE'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364568009996580336)
,p_db_column_name=>'DATE_FASE'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Data da Fase'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364568124665580337)
,p_db_column_name=>'COD_PREST_SERV_AVALIADOR'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Selecionador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364568244992580338)
,p_db_column_name=>'USUARIO'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364568329498580339)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>unistr('Data Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364568399094580340)
,p_db_column_name=>'COD_AVAL_FASE'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>unistr('Avalia\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52364568524790580341)
,p_db_column_name=>'DATA_AVAL_FASE'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>unistr('Data Avalia\00E7\00E3o')
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607069388316092)
,p_db_column_name=>'IND_AVAL_FASE'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>unistr('Indice Avalia\00E7\00E3o')
,p_column_type=>'NUMBER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607155326316093)
,p_db_column_name=>'MOT_AVAL_FASE'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>unistr('Motivo Avalia\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607314335316094)
,p_db_column_name=>'RESULTADO_FASE'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Resultado Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607402652316095)
,p_db_column_name=>'COD_REQ'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>'Cod. Req'
,p_column_type=>'NUMBER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607492249316096)
,p_db_column_name=>'COD_PROCESSO'
,p_display_order=>170
,p_column_identifier=>'P'
,p_column_label=>'Cod Processo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607563433316097)
,p_db_column_name=>'COD_VAGA'
,p_display_order=>180
,p_column_identifier=>'Q'
,p_column_label=>'Cod. da Vaga'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607748606316098)
,p_db_column_name=>'COD_EMP_CAND'
,p_display_order=>190
,p_column_identifier=>'R'
,p_column_label=>'Cod. Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52391607823134316099)
,p_db_column_name=>'CHECK_APROV'
,p_display_order=>200
,p_column_identifier=>'S'
,p_column_label=>'Aprovado na Fase'
,p_column_type=>'STRING'
,p_static_id=>'CHECK_APROV'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52404971927902151736)
,p_db_column_name=>'PCD'
,p_display_order=>210
,p_column_identifier=>'V'
,p_column_label=>'PCD'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_format_mask=>'PCT_GRAPH:::'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52439135573941755292)
,p_db_column_name=>'EMAIL'
,p_display_order=>220
,p_column_identifier=>'W'
,p_column_label=>'Enviar E-Mail'
,p_column_link=>'f?p=&APP_ID.:35:&SESSION.::&DEBUG.:RP,35:P35_EMP,P35_COD_CANDIDATO,P35_DESC_PROCESSO,P35_COD_REQUIMENTO:#COD_EMP_CAND#,#COD_CANDIDATO#,&P29_TITULO.,#COD_REQ#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-envelope-o fa-2x fam-warning fam-is-info"></span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692354967164092)
,p_db_column_name=>'DATA_NASCIMENTO'
,p_display_order=>230
,p_column_identifier=>'Y'
,p_column_label=>'Data Nascimento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692455720164093)
,p_db_column_name=>'IDADE'
,p_display_order=>240
,p_column_identifier=>'Z'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692628392164094)
,p_db_column_name=>'E_MAIL'
,p_display_order=>250
,p_column_identifier=>'AA'
,p_column_label=>'E-Mail'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692704179164095)
,p_db_column_name=>'SEXO'
,p_display_order=>260
,p_column_identifier=>'AB'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692835694164096)
,p_db_column_name=>'POSSUI_DEPENDENTE'
,p_display_order=>270
,p_column_identifier=>'AC'
,p_column_label=>'Possui Dependente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692941922164097)
,p_db_column_name=>'ULTIMO_CARGO'
,p_display_order=>280
,p_column_identifier=>'AD'
,p_column_label=>unistr('\00DAltimo Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503692955742164098)
,p_db_column_name=>'GRAU_INSTRUCAO'
,p_display_order=>290
,p_column_identifier=>'AE'
,p_column_label=>unistr('Grau Instru\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058339613522539450)
,p_db_column_name=>'WHATSAPP'
,p_display_order=>300
,p_column_identifier=>'AG'
,p_column_label=>'Whatsapp'
,p_column_link=>'#WHATSAPP#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-alert fa-2x"></span>'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058339988025539454)
,p_db_column_name=>'TIPO_CANDIDATO'
,p_display_order=>310
,p_column_identifier=>'AH'
,p_column_label=>'Tipo Candidato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310834277858362)
,p_db_column_name=>'APROVADO'
,p_display_order=>320
,p_column_identifier=>'AJ'
,p_column_label=>'Aprovado'
,p_column_type=>'STRING'
,p_static_id=>'APROVADO'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989312093871858375)
,p_db_column_name=>'STATUS_CANDIDATO'
,p_display_order=>330
,p_column_identifier=>'AK'
,p_column_label=>'Status Candidato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989312190997858376)
,p_db_column_name=>'DOCUMENTOS'
,p_display_order=>340
,p_column_identifier=>'AL'
,p_column_label=>'Documentos'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988563601124049577)
,p_db_column_name=>'URL_LINKEDIN'
,p_display_order=>350
,p_column_identifier=>'AM'
,p_column_label=>'LinkedIn'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988564189841049583)
,p_db_column_name=>'PONTUACAO'
,p_display_order=>360
,p_column_identifier=>'AO'
,p_column_label=>unistr('Pontua\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50845864331517528002)
,p_db_column_name=>'LOCALIDADE'
,p_display_order=>370
,p_column_identifier=>'AP'
,p_column_label=>'Localidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50845864405957528003)
,p_db_column_name=>'GENERO'
,p_display_order=>380
,p_column_identifier=>'AQ'
,p_column_label=>'Genero'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50625189094377440641)
,p_db_column_name=>'FASE'
,p_display_order=>390
,p_column_identifier=>'AR'
,p_column_label=>'Cod Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6415312176774367776)
,p_db_column_name=>'RESTRICAO_ADMISSAO'
,p_display_order=>400
,p_column_identifier=>'AS'
,p_column_label=>unistr('Restri\00E7\00E3o Admiss\00E3o')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(6415312252429367777)
,p_db_column_name=>'CLASSE_LINHA'
,p_display_order=>410
,p_column_identifier=>'AT'
,p_column_label=>'Classe Linha'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52391630448054328875)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'10795718'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'Select:LINK_CV:URL_LINKEDIN:EMAIL:WHATSAPP:RESTRICAO_ADMISSAO:NOME:COD_CANDIDATO:TIPO_CANDIDATO:PONTUACAO:COD_FASE:DT_ATUALIZACAO:DATA_NASCIMENTO:IDADE:E_MAIL:SEXO:PCD:LOCALIDADE:POSSUI_DEPENDENTE:ULTIMO_CARGO:GRAU_INSTRUCAO:APROVADO:STATUS_CANDIDATO'
||':DOCUMENTOS:GENERO:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52237932491410224108)
,p_plug_name=>unistr('Mudan\00E7a de Fase')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_plug_template=>wwv_flow_api.id(72951030450318200632)
,p_plug_display_sequence=>32
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51058400167865981975)
,p_plug_name=>'fase botoes'
,p_parent_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noBorder'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51058400285543981976)
,p_plug_name=>'aprovar botoes'
,p_parent_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noBorder:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>4
,p_plug_display_column=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(73297938999459910811)
,p_plug_name=>'&P29_TITULO.'
,p_icon_css_classes=>'fa-users'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951030305909200632)
,p_plug_display_sequence=>1
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('Rela\00E7\00E3o dos Candidatos')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>'&P28_SUB_TITLE.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51327802453703045439)
,p_button_sequence=>5
,p_button_plug_id=>wwv_flow_api.id(51327802118597045436)
,p_button_name=>'BTN_CONFIRMA_CAND'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Confirmar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51327802324847045438)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(51327802118597045436)
,p_button_name=>'BTN_VOLTAR_CAND'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50988563006774049571)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_button_name=>'BTN_QUADRO_VAGA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Detalhes da Vaga'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:38:&SESSION.::&DEBUG.:RP,38:P38_COD,P38_ID:&P29_REQUISICAO.,&P29_QUADRO_VAGA_ID.'
,p_button_condition=>'P29_QUADRO_VAGA_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-file-text-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51058450157302733656)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(51058400285543981976)
,p_button_name=>'BTN_APROVACAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>'Aprovar Candidato'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_COD_CANDIDATO,P3_COD_EMPRESA,P3_COD_VAGA,P3_COD_SOLICITACAO,P3_COD_FILIAL,P3_COD_REQ,P3_COD_SIT_REQ:&P32_COD_CANDIDATO.,&P32_COD_EMPRESA.,&P32_COD_REQUISICAO.,&P32_COD_REQUISICAO.,&P32_FILIAL.,&P32_COD_REQUISICAO.,&P32_SIT_REQUISICAO.'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52243882970528069421)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_button_name=>'BTN_DETALHE_VAGA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Requisi\00E7\00E3o')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_APP_CALLED,P36_PAGE_CALLED,P36_COD_REQ:REQ_PESSOAL,52,&P29_REQUISICAO.'
,p_icon_css_classes=>'fa-bullhorn'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50623940668698250349)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52208805036279891118)
,p_button_name=>'BTN_FASE_ANOTACAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Anota\00E7\00F5es das Fases')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10:P10_PROCESSO:&P29_REQUISICAO.'
,p_icon_css_classes=>'fa-sticky-note-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52282533551929829497)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52208805036279891118)
,p_button_name=>'BTN_ENCERRAR_VAGA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>'Finalizar Processo'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,33:P33_EMP_ID,P33_REQUISICAO:&P29_EMP_ID.,&P29_REQUISICAO.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P29_STATUS != 2 or :p29_cod_prest_serv is null then',
'return false; --true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51327801216263045427)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(51058400167865981975)
,p_button_name=>'BTN_CONFIRMA_FASE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar Fase'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52208805766972891126)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(73297938999459910811)
,p_button_name=>'VOLTAR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--simple:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:28:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52391609739792316118)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(73297938999459910811)
,p_button_name=>'BTN_CONS_CAND'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--simple:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Consultar Candidatos'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=9110:182:&SESSION.::&DEBUG.:RP,182::'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-users'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51327801596428045431)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(51058400167865981975)
,p_button_name=>'BTN_VOLTAR_FASE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52391608994398316111)
,p_button_sequence=>5
,p_button_plug_id=>wwv_flow_api.id(52252290618601543294)
,p_button_name=>'BTN_MUDAR_FASE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Mudar Fase'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P29_STATUS'
,p_button_condition2=>'2'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_icon_css_classes=>'fa-arrow-circle-o-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52282533594420829498)
,p_button_sequence=>25
,p_button_plug_id=>wwv_flow_api.id(52252290618601543294)
,p_button_name=>'BTN_INCLUIR_CAND'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Incluir Candidato'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (:P29_STATUS <> 2 and :p29_cod_prest_serv is not null) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-users'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52439138748871755323)
,p_button_sequence=>35
,p_button_plug_id=>wwv_flow_api.id(52252290618601543294)
,p_button_name=>'BTN_DETALHE_PS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Processo Seletivo'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_ROWID:&P29_ROWID.'
,p_icon_css_classes=>'fa-file-text-o'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50845863505722527994)
,p_name=>'P29_QUADRO_VAGA_ID'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SELE.QUADRO_VAGA_ID',
' from PS_PROCESSO_SELETIVO SELE',
'where SELE.COD_REQ = :P29_REQUISICAO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50920017337024660428)
,p_name=>'P29_SELECIONADOR'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_prest_serv',
'  from PS_PROCESSO_SELETIVO',
' where cod_processo = :p32_COD_requisicao'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Selecionador'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ps.cod_prest_serv||'' - ''|| Initcap(ps.nome)||DECODE(gs.descricao,NULL,NULL,'' - ''||gs.descricao) det',
'      ,ps.cod_prest_serv                                                                      ret',
'  FROM prestador_servico      ps',
'      ,ps_dados_grupo_selecao dgs',
'      ,ps_grupo_selecao       gs',
' WHERE gs.cod_ps_grupo    (+) = dgs.cod_ps_grupo',
'   AND dgs.cod_prest_serv (+) = ps.cod_prest_serv',
'   AND dgs.tipo_prest_serv(+) = ps.tipo_prest_serv',
'   AND ps.tipo_prest_serv     = ''5'' ',
'   AND trunc(sysdate) between trunc(ps.dt_vigencia_inic) and trunc(ps.dt_vigencia_fin)',
'ORDER BY ps.nome, ps.cod_prest_serv'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>105
,p_begin_on_new_line=>'N'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
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
 p_id=>wwv_flow_api.id(50920017576587663405)
,p_name=>'P29_AVALIACAO'
,p_item_sequence=>15
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Avalia\00E7\00E3o da Fase')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>unistr('LOV_MOTIVO_AVALIA\00C7\00C3O')
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT af.cod_aval_fase||'' - ''||af.desc_aval_fase det',
'      ,af.cod_aval_fase                           ret',
'  FROM avaliacao_fase af'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--Selecione--'
,p_cSize=>30
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50920017915593666641)
,p_name=>'P29_CHECK_APROV'
,p_item_sequence=>65
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_display_when_type=>'NEVER'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50920018220255671114)
,p_name=>'P29_OBSERVACAO'
,p_item_sequence=>75
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>110
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988469549498493271)
,p_name=>'P29_STATUS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988470328204493279)
,p_name=>'P29_COD_PREST_SERV'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51052447408323858499)
,p_name=>'P29_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51058340031982539455)
,p_name=>'P29_NEW_CAND_INT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(51327802118597045436)
,p_prompt=>'Novo Candidato Interno'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CANDIDATOS_INTERNOS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.cod_candidato, p.cod_candidato codigo, p.nome, p.nome_social, SUBSTR(LPAD(P.NUM_CPF,9,0),1,3)||''.''||',
'                    SUBSTR(LPAD(P.NUM_CPF,9,0),4,3)||''.''||',
'                    SUBSTR(LPAD(P.NUM_CPF,9,0),7,3)||''-''||',
'                    LPAD(P.DC_CPF,2,0) cpf, trim(lower(P.E_MAIL)) email',
' FROM  INF_PESSOAIS_CANDIDATO PESS,',
'       INF_PESSOAIS_CAD P,',
'       INFORMACOES_FUNCIONAIS_CAD I',
'WHERE P.COD_EMPRESA = I.COD_EMPRESA ',
'  AND P.MATRICULA = I.MATRICULA ',
'  AND P.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND I.SITUACAO < ''90''',
'ORDER BY P.NOME'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>25
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:t-Form-fieldContainer--preTextBlock:t-Form-fieldContainer--postTextBlock'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51058340165048539456)
,p_name=>'P29_NEW_TIPO_CAND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(51327802118597045436)
,p_item_default=>'E'
,p_prompt=>'Tipo de Candidato'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:Externo;E,Interno;I'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51058400601902981979)
,p_name=>'P29_SELECTED_N'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52237932367909224107)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51327800906268045424)
,p_name=>'P29_NEW_FASE'
,p_item_sequence=>55
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_prompt=>'Nova Fase'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT INITCAP(FACA.DESC_FASE) d, faca.cod_fase c',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'and PRSE.cod_req = :P29_REQUISICAO',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>25
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51327802255158045437)
,p_name=>'P29_NEW_CAND'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(51327802118597045436)
,p_prompt=>'Novo Candidato Externo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_CANDIDATOS_EXTERNOS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT pess.cod_candidato, pess.cod_candidato codigo, pess.nome, pess.nome_social, SUBSTR(LPAD(PESS.NUM_CPF,9,0),1,3)||''.''||',
'                    SUBSTR(LPAD(PESS.NUM_CPF,9,0),4,3)||''.''||',
'                    SUBSTR(LPAD(PESS.NUM_CPF,9,0),7,3)||''-''||',
'                    LPAD(PESS.DC_CPF,2,0) cpf, trim(lower(PESS.E_MAIL)) email',
' FROM  INF_PESSOAIS_CANDIDATO PESS',
'WHERE TRIM(PESS.NOME) IS NOT NULL',
' AND NOT EXISTS(SELECT 1 ',
'                  FROM INF_PESSOAIS_CAD P, INFORMACOES_FUNCIONAIS_CAD I ',
'                 WHERE P.COD_EMPRESA = I.COD_EMPRESA ',
'                  AND P.MATRICULA = I.MATRICULA ',
'                  AND P.NUM_CPF = PESS.NUM_CPF',
'                  AND P.DC_CPF = PESS.DC_CPF',
'                  AND I.SITUACAO < ''90'')',
'ORDER BY PESS.NOME'))
,p_cSize=>25
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:t-Form-fieldContainer--preTextBlock:t-Form-fieldContainer--postTextBlock'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51327803557422045450)
,p_name=>'P29_NEW_NOTA'
,p_item_sequence=>45
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_prompt=>'Nota'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>25
,p_cMaxlength=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51327803601796045451)
,p_name=>'P29_NOTA_MINIMA'
,p_item_sequence=>35
,p_item_plug_id=>wwv_flow_api.id(52237932491410224108)
,p_prompt=>'Nota Minima'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>25
,p_tag_attributes=>'readonly'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52208804756595891116)
,p_name=>'P29_REQUISICAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52208804932478891117)
,p_name=>'P29_EMP_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52237931903533224102)
,p_name=>'P29_TITULO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(73297938999459910811)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52238055604100655497)
,p_name=>'P29_SELECAO_CANDIDATO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439137850765755314)
,p_name=>'P29_COLLECTION_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52237932367909224107)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439138840574755324)
,p_name=>'P29_ROWID'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52208804415960891112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(52439138351456755319)
,p_computation_sequence=>10
,p_computation_item=>'P29_COLLECTION_NAME'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'CHECKBOX_29'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(47009584630193668469)
,p_validation_name=>'VALIDA_CAND_EXISTENTE'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'CURSOR c1 IS',
'SELECT ''S'' EXISTE',
'FROM RP_CAND_INSCRITOS',
'WHERE COD_CANDIDATO = :P29_NEW_CAND',
'AND COD_REQ  = :P29_REQUISICAO;',
'',
'V_C1 c1%ROWTYPE;',
'',
'BEGIN',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF NVL(v_c1.EXISTE,''N'') = ''S'' THEN',
unistr(' RETURN ''O Candidato j\00E1 esta vinculado a essa Requisi\00E7\00E3o, favor verificar!'';'),
'',
'END IF;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(51327802453703045439)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52202376108877262506)
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
 p_id=>wwv_flow_api.id(52202376590355262509)
,p_event_id=>wwv_flow_api.id(52202376108877262506)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_MY_PROCESS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52202377085570262511)
,p_event_id=>wwv_flow_api.id(52202376108877262506)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_MY_PROCESS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52404969846911151715)
,p_name=>'REFRESH'
,p_event_sequence=>40
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52404969905241151716)
,p_event_id=>wwv_flow_api.id(52404969846911151715)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52404972202245151739)
,p_name=>unistr('Abrir Mudan\00E7a de Fase em Massa')
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52391608994398316111)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327801930187045434)
,p_event_id=>wwv_flow_api.id(52404972202245151739)
,p_event_result=>'TRUE'
,p_action_sequence=>4
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_FASE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327803890955045454)
,p_event_id=>wwv_flow_api.id(52404972202245151739)
,p_event_result=>'TRUE'
,p_action_sequence=>14
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_NOTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52404972317666151740)
,p_event_id=>wwv_flow_api.id(52404972202245151739)
,p_event_result=>'TRUE'
,p_action_sequence=>24
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52237932491410224108)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51327802535087045440)
,p_name=>unistr('Abrir Inclus\00E3o de Candidato')
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52282533594420829498)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327802656311045441)
,p_event_id=>wwv_flow_api.id(51327802535087045440)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(51327802118597045436)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327802697981045442)
,p_event_id=>wwv_flow_api.id(51327802535087045440)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51327801352527045428)
,p_name=>unistr('Confirma mudan\00E7a de Fase')
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51327801216263045427)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327801411382045429)
,p_event_id=>wwv_flow_api.id(51327801352527045428)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('<strong>Confirma a altera\00E7\00E3o de fase dos candidatos selecionados?</strong>')
,p_attribute_07=>'Confirmar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327801574773045430)
,p_event_id=>wwv_flow_api.id(51327801352527045428)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'MUDAR_FASE_CANDIDATO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51327802977655045444)
,p_name=>unistr('Confirma Inclus\00E3o Candidato')
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51327802453703045439)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327803027825045445)
,p_event_id=>wwv_flow_api.id(51327802977655045444)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('<strong>Confirma a inclus\00E3o do Candidato selecionado?</strong>')
,p_attribute_07=>'Confirmar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327803116835045446)
,p_event_id=>wwv_flow_api.id(51327802977655045444)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'INCLUIR_CANDIDATO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51327801706260045432)
,p_name=>unistr('Fecha Regi\00E3o Mudan\00E7a de Fase')
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51327801596428045431)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327801859283045433)
,p_event_id=>wwv_flow_api.id(51327801706260045432)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52237932491410224108)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51327803257310045447)
,p_name=>unistr('Fecha Regi\00E3o Inclus\00E3o Candidato')
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51327802324847045438)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327803325966045448)
,p_event_id=>wwv_flow_api.id(51327803257310045447)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(51327802118597045436)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51327803774534045452)
,p_name=>'Atualiza_Nota_Minima (Multiplos Cands)'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_NEW_FASE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.item("P29_NEW_FASE").getValue().length > 0 && apex.item("P29_SELECTED_N").getValue() > 1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51327803803916045453)
,p_event_id=>wwv_flow_api.id(51327803774534045452)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'SELECT x.nota_de_corte ',
'INTO :P29_NOTA_MINIMA',
'FROM ps_processo_fase x ',
'WHERE x.cod_processo = :P29_REQUISICAO ',
'AND x.cod_fase = NVL(:P29_NEW_FASE,x.cod_fase)',
'FETCH FIRST 1 ROWS ONLY;',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P29_REQUISICAO,P29_NEW_FASE'
,p_attribute_03=>'P29_NOTA_MINIMA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058402487773981998)
,p_event_id=>wwv_flow_api.id(51327803774534045452)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NOTA_MINIMA,P29_NEW_NOTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058483455411070152)
,p_event_id=>wwv_flow_api.id(51327803774534045452)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51327801216263045427)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058483543417070153)
,p_event_id=>wwv_flow_api.id(51327803774534045452)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51327801216263045427)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058402582287981999)
,p_event_id=>wwv_flow_api.id(51327803774534045452)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NOTA_MINIMA,P29_NEW_NOTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058483232792070150)
,p_event_id=>wwv_flow_api.id(51327803774534045452)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51058450157302733656)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058483715992070154)
,p_name=>'Atualiza_Nota_Minima (Apenas 1 Cand)'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_NEW_FASE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.item("P29_NEW_FASE").getValue().length > 0 && apex.item("P29_SELECTED_N").getValue() == 1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058483804674070155)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'SELECT x.nota_de_corte ',
'INTO :P29_NOTA_MINIMA',
'FROM ps_processo_fase x ',
'WHERE x.cod_processo = :P29_REQUISICAO ',
'AND x.cod_fase = NVL(:P29_NEW_FASE,x.cod_fase)',
'FETCH FIRST 1 ROWS ONLY;',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P29_REQUISICAO,P29_NEW_FASE'
,p_attribute_03=>'P29_NOTA_MINIMA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058484331701070161)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51058450157302733656)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058483834482070156)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NOTA_MINIMA,P29_NEW_NOTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058484020778070157)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NOTA_MINIMA,P29_NEW_NOTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058484025977070158)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51058450157302733656)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058484247369070160)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51327801216263045427)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058484224129070159)
,p_event_id=>wwv_flow_api.id(51058483715992070154)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51327801216263045427)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058340293989539457)
,p_name=>'Tipo de Candidato'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_NEW_TIPO_CAND'
,p_condition_element=>'P29_NEW_TIPO_CAND'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'E'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058340335604539458)
,p_event_id=>wwv_flow_api.id(51058340293989539457)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058340683800539461)
,p_event_id=>wwv_flow_api.id(51058340293989539457)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND_INT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058340469124539459)
,p_event_id=>wwv_flow_api.id(51058340293989539457)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058340579064539460)
,p_event_id=>wwv_flow_api.id(51058340293989539457)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND_INT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058340741656539462)
,p_event_id=>wwv_flow_api.id(51058340293989539457)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND_INT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058340891448539463)
,p_event_id=>wwv_flow_api.id(51058340293989539457)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_NEW_CAND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058399653471981970)
,p_name=>'Check_Aprov Row Color'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(52252290618601543294)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058399798139981971)
,p_event_id=>wwv_flow_api.id(51058399653471981970)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#partnersIRR td[headers=APROVADO]").each(function(){',
'    celldata= $(this).text();',
'    if (celldata == ''Sim''){',
'    $(this).parent().children().css(''background-color'',''#B5F5D0 !important'');',
'    }});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058400767706981981)
,p_name=>'Total de Selecionados'
,p_event_sequence=>150
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(52252290618601543294)
,p_bind_type=>'live'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058400880662981982)
,p_event_id=>wwv_flow_api.id(51058400767706981981)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_SELECTED_N'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from apex_collections',
' where collection_name = :P29_COLLECTION_NAME'))
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058400969653981983)
,p_name=>'(Show/Hide) Selected Buttons'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_SELECTED_N'
,p_condition_element=>'P29_SELECTED_N'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058401059557981984)
,p_event_id=>wwv_flow_api.id(51058400969653981983)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52391608994398316111)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058401136025981985)
,p_event_id=>wwv_flow_api.id(51058400969653981983)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52391608994398316111)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058401280398981986)
,p_name=>'(Show/Hide) Selected Buttons_1'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_SELECTED_N'
,p_condition_element=>'P29_SELECTED_N'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058401419255981987)
,p_event_id=>wwv_flow_api.id(51058401280398981986)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51058450157302733656)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058401524054981988)
,p_event_id=>wwv_flow_api.id(51058401280398981986)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(51058450157302733656)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058401614758981989)
,p_name=>'SELECT_ALL Javascript'
,p_event_sequence=>180
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#SELECT_ALL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058401682982981990)
,p_event_id=>wwv_flow_api.id(51058401614758981989)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'cb_array = document.getElementsByName(''f01'');',
'for (i=0; i<cb_array.length; i++){',
'  if ( cb_array[i].disabled == false ){',
'    cb_array[i].checked = document.getElementById("SELECT_ALL").checked;',
'  }',
'}',
'$(''.checkbox_item:first'').trigger(''change'')'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6415312388170367778)
,p_name=>'Pintar a linha de vermelho'
,p_event_sequence=>190
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(52252290618601543294)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6415312506395367779)
,p_event_id=>wwv_flow_api.id(6415312388170367778)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Procura todos os spans marcadores que possuem a classe ''linha-vermelha'' dentro do partnersIRR',
'$(''#partnersIRR .marcador-linha.linha-vermelha'').each(function() {',
unistr('    // Sobe at\00E9 a linha da tabela e pinta todas as c\00E9lulas (td) dela'),
'    $(this).closest(''tr'').find(''td'').addClass(''linha-vermelha'');',
'});'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52439137937127755315)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Clear Collection'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'apex_collection.create_or_truncate_collection(p_collection_name => :P29_COLLECTION_NAME);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52238056109140655502)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ATUALIZA_FASE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_COD_CANDIDATO VARCHAR2(2000);',
'V_ROWID_CAND    VARCHAR2(4000);',
'V_ULT_COD_FASE  VARCHAR2(2000);',
'V_CAND_ERROR    VARCHAR2(4000) := NULL;',
'V_NOME_CANDIDATO   VARCHAR2(4000) := NULL;',
'V_PONTUACAO     NUMBER;',
'BEGIN',
'',
'',
'     /*',
'     FOR I IN 1..APEX_APPLICATION.G_F01.COUNT  LOOP',
'     ',
'     v_rowid_cand := null;',
'     v_rowid_cand := APEX_APPLICATION.G_F01(i);',
'     */',
'   for i in (',
'    select n001 as cod_candidato',
'      from apex_collections',
'     where collection_name = :P29_COLLECTION_NAME',
'  ) loop',
'  ',
'     v_rowid_cand := null;',
'     v_rowid_cand := i.cod_candidato;',
'  ',
'     SELECT UPPER(FNCT_NOME_CAND(CAND.COD_EMPRESA,CAND.COD_CANDIDATO)) ',
'     ,      MAX(COD_FASE)',
'     ,      PONTUACAO',
'     INTO V_NOME_CANDIDATO',
'     ,    V_ULT_COD_FASE',
'     ,    V_PONTUACAO',
'      FROM CANDIDATO CAND',
'     WHERE COD_CANDIDATO = V_ROWID_CAND',
'     AND COD_EMPRESA = :P29_EMP_ID',
'     AND COD_REQ = :P29_REQUISICAO',
'     GROUP BY CAND.COD_EMPRESA',
'         ,    CAND.COD_CANDIDATO',
'         ,    CAND.PONTUACAO;',
'     ',
'     IF V_ULT_COD_FASE < :P29_NEW_FASE  THEN  ',
'     ',
'     BEGIN',
'     UPDATE CANDIDATO',
'        SET CHECK_APROV = ''S''',
'      WHERE COD_CANDIDATO = V_ROWID_CAND',
'        AND COD_REQ = :P29_REQUISICAO',
'        AND COD_FASE = V_ULT_COD_FASE;',
'        ',
'        COMMIT;',
'      EXCEPTION',
'      WHEN OTHERS THEN ',
'      NULL;',
'      END;',
'     ',
'     ',
'		INSERT INTO CANDIDATO (COD_EMPRESA, COD_CANDIDATO, COD_FASE, DATE_FASE,USUARIO, DT_ATUALIZACAO,IND_AVAL_FASE, DATA_AVAL_FASE, COD_REQ, COD_PROCESSO, CHECK_APROV, PONTUACAO)',
'		VALUES (:P29_EMP_ID,V_ROWID_CAND,:P29_NEW_FASE,TRUNC(SYSDATE),:P_USUARIO,TRUNC(SYSDATE),NULL/*:P29_NEW_NOTA*/,TRUNC(SYSDATE),:P29_REQUISICAO,:P29_REQUISICAO,NULL,V_PONTUACAO);',
'',
'      COMMIT;',
'      ',
'     ELSIF V_ULT_COD_FASE > :P29_NEW_FASE  THEN  ',
'     ',
'     v_cand_error := case when v_cand_error is not null then v_cand_error||'' / '' end || v_nome_candidato||'' Fase Atual: ''||v_ult_cod_fase;',
'     end if;',
'	 ',
'	 end loop;',
'      ',
'      if v_cand_error is not null then ',
unistr('      raise_application_error(-20001,''Fase ''||:P29_NEW_FASE|| '' \00E9 menor que a fase do(s) Candidato(s): ''||v_cand_error||'', favor verificar.'');'),
'      end if;',
'',
'END;',
''))
,p_process_error_message=>unistr('ERRO AO PROCESSAR SOLICITA\00C7\00C3O - ATUALIZA_FASE - #SQLERRM#')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'MUDAR_FASE_CANDIDATO'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Fase alterada com sucesso.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(51327802878863045443)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INCLUI_CANDIDATO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'V_ERRO VARCHAR2(4000);',
'',
'cursor c1 is',
'select p.cod_empresa, p.matricula',
'  from inf_pessoais_cad p',
' where p.cod_candidato = :p29_new_cand_int;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :P29_NEW_CAND is not null then',
'',
'    UPDATE INF_FUNC_CANDIDATO',
'       SET COD_EMPRESA = :P29_EMP_ID',
'     WHERE COD_CANDIDATO = :P29_NEW_CAND;',
'',
'    COMMIT;',
'',
'    UPDATE INF_PESSOAIS_CANDIDATO',
'       SET EMPRESA = :P29_EMP_ID',
'     WHERE COD_CANDIDATO = :P29_NEW_CAND;',
'',
'    COMMIT;',
'',
'    insert into RP_CAND_INSCRITOS (cod_req, cod_empresa, cod_candidato, cod_cargo, usuario, dt_atualizacao)',
'    values',
'    (:P29_REQUISICAO, :P29_EMP_ID, :P29_NEW_CAND, :p29_CARGO, :p_usuario, sysdate);',
'',
'    commit;',
'',
'    BEGIN',
'         Insert into CANDIDATO (COD_EMPRESA',
'                           ,    COD_CANDIDATO',
'                           ,    COD_FASE',
'                           ,    DATE_FASE',
'                           ,    COD_PREST_SERV_AVALIADOR',
'                           ,    USUARIO',
'                           ,    DT_ATUALIZACAO',
'                           ,    COD_AVAL_FASE',
'                           ,    DATA_AVAL_FASE',
'                           ,    IND_AVAL_FASE',
'                           ,    MOT_AVAL_FASE',
'                           ,    RESULTADO_FASE',
'                           ,    COD_REQ',
'                           ,    COD_PROCESSO',
'                           ,    COD_VAGA',
'                           ,    COD_EMP_CAND',
'                           ,    CHECK_APROV) ',
'         values (:P29_EMP_ID--COD_EMPRESA',
'          ,      :P29_NEW_CAND				--COD_CANDIDATO',
'          ,      ''1''						--COD_FASE',
'          ,      to_date(SYSDATE,''DD/MM/RR'') --DATE_FASE',
'          ,      :P29_COD_PREST_SERV		 --COD_PREST_SERV_AVALIADOR',
'          ,      :P_USUARIO		             --USUARIO',
'          ,      to_date(SYSDATE,''DD/MM/RR'')--DT_ATUALIZACAO',
'          ,      null						--COD_AVAL_FASE',
'          ,      to_date(SYSDATE,''DD/MM/RR'')--DATA_AVAL_FASE',
'          ,      null						--IND_AVAL_FASE',
'          ,      null						--MOT_AVAL_FASE',
'          ,      null						--RESULTADO_FASE',
'          ,      :P29_REQUISICAO			--COD_REQ',
'          ,      :P29_REQUISICAO			--COD_PROCESSO',
'          ,      null						--COD_VAGA',
'          ,      :P29_EMP_ID				--COD_EMP_CAND',
'          ,      ''N'');						--CHECK_APROV',
'      COMMIT;',
'',
'    END;',
'',
'end if;',
'',
'',
'if :P29_NEW_CAND_INT is not null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    UPDATE INF_FUNC_CANDIDATO',
'       SET COD_EMPRESA = :P29_EMP_ID',
'     WHERE COD_CANDIDATO = :P29_NEW_CAND_INT;',
'',
'    COMMIT;',
'',
'    UPDATE INF_PESSOAIS_CANDIDATO',
'       SET EMPRESA = :P29_EMP_ID',
'     WHERE COD_CANDIDATO = :P29_NEW_CAND_INT;',
'',
'    COMMIT;',
'',
'    ',
'    insert into RP_FUNC_INSCRITOS (cod_req, cod_empresa, matricula, dt_inscricao, cod_cargo, usuario, dt_atualizacao)',
'    values',
'    (:P29_REQUISICAO, v_c1.cod_empresa, v_c1.matricula, sysdate, :p29_cargo, :p_usuario, sysdate);',
'',
'    commit;',
'    ',
'',
'    BEGIN',
'         Insert into CANDIDATO (COD_EMPRESA',
'                           ,    COD_CANDIDATO',
'                           ,    COD_FASE',
'                           ,    DATE_FASE',
'                           ,    COD_PREST_SERV_AVALIADOR',
'                           ,    USUARIO',
'                           ,    DT_ATUALIZACAO',
'                           ,    COD_AVAL_FASE',
'                           ,    DATA_AVAL_FASE',
'                           ,    IND_AVAL_FASE',
'                           ,    MOT_AVAL_FASE',
'                           ,    RESULTADO_FASE',
'                           ,    COD_REQ',
'                           ,    COD_PROCESSO',
'                           ,    COD_VAGA',
'                           ,    COD_EMP_CAND',
'                           ,    CHECK_APROV) ',
'         values (:P29_EMP_ID--COD_EMPRESA',
'          ,      :P29_NEW_CAND_INT				--COD_CANDIDATO',
'          ,      ''1''						--COD_FASE',
'          ,      to_date(SYSDATE,''DD/MM/RR'') --DATE_FASE',
'          ,      :P29_COD_PREST_SERV		 --COD_PREST_SERV_AVALIADOR',
'          ,      :P_USUARIO		             --USUARIO',
'          ,      to_date(SYSDATE,''DD/MM/RR'')--DT_ATUALIZACAO',
'          ,      null						--COD_AVAL_FASE',
'          ,      to_date(SYSDATE,''DD/MM/RR'')--DATA_AVAL_FASE',
'          ,      null						--IND_AVAL_FASE',
'          ,      null						--MOT_AVAL_FASE',
'          ,      null						--RESULTADO_FASE',
'          ,      :P29_REQUISICAO			--COD_REQ',
'          ,      :P29_REQUISICAO			--COD_PROCESSO',
'          ,      null						--COD_VAGA',
'          ,      :P29_EMP_ID				--COD_EMP_CAND',
'          ,      ''N'');						--CHECK_APROV',
'      COMMIT;',
'',
'    END;',
'',
'end if;',
'',
'    pkg_Selecao.prc_InsCandidatosEscolhidos_PS(pCodProcesso     => :P29_REQUISICAO',
'                                              ,pCodSelecionador => :P29_COD_PREST_SERV',
'                                              ,pUser            => :P_USUARIO',
'                                              ,pMsg             => V_ERRO);',
'',
'end;'))
,p_process_error_message=>unistr('O Candidato j\00E1 esta vinculado a essa Requisi\00E7\00E3o, favor verificar!')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'INCLUIR_CANDIDATO'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>unistr('Candidato inclu\00EDdo com sucesso.')
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52202375739413262505)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Perfil'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :IS_OPER = ''Y'' THEN',
':P29_MY_PROCESS := ''Y'';',
'END IF;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52237932017585224103)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Titulo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C_DADOS IS',
'  SELECT upper(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME'')) CARGO',
'  ,      SELE.COD_PROCESSO',
'  ,    CASE WHEN r.cod_sit_req = 1 THEN ''Prevista''',
'            WHEN r.cod_sit_req = 2 THEN ''Fechada''',
'            WHEN r.cod_sit_req = 3 THEN ''Cancelada''',
'            WHEN r.cod_sit_req = 4 THEN ''Reprovada''',
'            WHEN r.cod_sit_req = 5 THEN ''Aberta''',
'        END  Status_Req',
'  ,R.COD_CARGO',
'  ,r.cod_sit_req',
'  ,SELE.COD_PREST_SERV',
'  ,SELE.QUADRO_VAGA_ID',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'AND SELE.COD_REQ = :P29_REQUISICAO',
'AND SELE.COD_EMPRESA = :P29_EMP_ID;',
'',
'',
'R_DADOS C_DADOS%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C_DADOS;',
'FETCH C_DADOS INTO R_DADOS;',
'CLOSE C_DADOS;',
'',
':P29_TITULO := R_DADOS.CARGO||'' (''||R_DADOS.COD_PROCESSO||'')'';',
':P29_CARGO := R_DADOS.COD_CARGO;',
':P29_STATUS := R_DADOS.COD_SIT_REQ;',
':P29_COD_PREST_SERV := R_DADOS.COD_PREST_SERV;',
':P29_QUADRO_VAGA_ID := R_DADOS.QUADRO_VAGA_ID;',
'',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52439139292458755329)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'salvar_ids'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_json    varchar2(32767) := apex_application.g_x01;',
'  l_id      varchar2(255);',
'  l_checked varchar2(255);',
'  --',
'  l_seq_id     apex_collections.seq_id%type;',
'  l_collection apex_collections.collection_name%type := :P29_COLLECTION_NAME;',
'begin',
'  if l_json is not null then',
'    apex_json.parse(l_json);',
'    for i in 1 .. apex_json.get_count(p_path => ''.'') loop',
'      l_id      := apex_json.get_varchar2(p_path => ''[%d].id'', p0 => i);',
'      l_checked := apex_json.get_varchar2(p_path => ''[%d].checked'', p0 => i);',
'',
'      begin',
'        select seq_id',
'          into l_seq_id',
'          from apex_collections',
'         where collection_name = l_collection',
'           and n001            = l_id;',
'',
'        -- existe',
'        if l_checked = ''false'' then',
'          apex_collection.delete_member (',
'            p_collection_name => l_collection,',
'            p_seq             => l_seq_id',
'          );',
'        end if;',
'      exception when no_data_found then',
'        if l_checked = ''true'' then',
'          apex_collection.add_member (',
'            p_collection_name => l_collection,',
'            p_n001            => l_id',
'          );',
'        end if;',
'      end;',
'    end loop;',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52391608994398316111)
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
