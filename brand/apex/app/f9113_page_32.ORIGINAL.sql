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
--   Date and Time:   19:31 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 32
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00032
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>32);
end;
/
prompt --application/pages/page_00032
begin
wwv_flow_api.create_page(
 p_id=>32
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>'Dados do Candidato'
,p_step_title=>'Dados do Candidato'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.ESCONDE {',
'  DISPLAY: NONE;',
'}',
'',
'',
'.u-normal{',
'  background: #fff !important;',
'}',
'',
'.u-sucess{',
'  background: #769a4c !important;',
'}',
'',
'.u-danger{',
'  background: #d25c53 !important;',
'}',
'',
'@media (max-width: 750px){',
'	.t-Body-side ',
'    {',
'      display: none !important;',
'    }',
'} ',
'',
'.a-StarRating-stars-fg {',
'    color: #c95788 !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CIBELE.CRISTINA'
,p_last_upd_yyyymmddhh24miss=>'20260622210028'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52237932853178224111)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'htp.p(''<div class="t-Region-body">',
'     <h2 class="u-VisuallyHidden">Andamento Atual</h2>',
'         <ul class="t-WizardSteps js-wizardProgressLinks t-WizardSteps--displayLabels">'');',
'          for l_fases in (',
'            SELECT DISTINCT faca.cod_fase,',
'                  INITCAP(FACA.DESC_FASE) nome_fase,',
'                  case when c.cod_candidato is not null then ',
unistr('            ''<li class="t-WizardSteps-step is-complete"><a class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">''||INITCAP(FACA.DESC_FASE)||'' <span class="t-WizardSteps-labelState">(Conclu\00EDdo)</span><')
||'/span></a></li>''',
'            else',
'            ''<li class="t-WizardSteps-step"><a class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">''||INITCAP(FACA.DESC_FASE)||'' <span class="t-WizardSteps-labelState"></span></span></a></li>''',
'            end steps',
'            FROM fase_candidato FACA',
'            , PS_PROCESSO_FASE PRFA',
'            , ps_processo_seletivo PRSE',
'            , candidato c',
'            WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'            AND faca.cod_fase = c.cod_fase (+)',
'            AND PRSE.cod_processo = PRFA.cod_processo',
'            AND PRSE.cod_req = c.cod_req (+)',
'            and PRSE.cod_req = :P29_REQUISICAO',
'            order by 1',
'           )',
'            loop',
'            /* EXEMPLO',
unistr('            <li class="t-WizardSteps-step is-complete"><a class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">Fase 1 <span class="t-WizardSteps-labelState">(Conclu\00EDdo)</span></span></a></li>'),
'            <li class="t-WizardSteps-step is-active"><a class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">Fase 2 <span class="t-WizardSteps-labelState">(Ativo)</span></span></a></li>',
'            <li class="t-WizardSteps-step"><a class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">Fase 3 <span class="t-WizardSteps-labelState"></span></span></a></li>',
'            */',
'            htp.p(l_fases.steps);',
'            end loop;',
'      htp.p(''</ul>   ',
'</div>'');',
'',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52258321842667352516)
,p_plug_name=>'&P32_NOME_CANDIDATO.'
,p_icon_css_classes=>'fa-user-circle-o'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951030305909200632)
,p_plug_display_sequence=>22
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>'&P32_DESC_PROCESSO.'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52258322598023352524)
,p_plug_name=>unistr('Avalia\00E7\00E3o da Fase')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(72951030450318200632)
,p_plug_display_sequence=>9
,p_plug_display_point=>'REGION_POSITION_04'
,p_query_type=>'TABLE'
,p_query_table=>'CANDIDATO'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case when NVL(IND_AVAL_FASE,10) < (SELECT x.nota_de_corte',
'                                          FROM ps_processo_fase x ',
'                                         WHERE x.cod_processo = CAND.COD_REQ',
'										 AND x.cod_fase = cand.cod_fase',
'                                         FETCH FIRST 1 ROWS ONLY) then null',
'										 else 1 END VALIDA',
' FROM CANDIDATO CAND',
'    , INF_FUNC_CANDIDATO FUNC',
'    , INF_PESSOAIS_CANDIDATO PESS',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND COD_REQ       = :P32_COD_REQUISICAO',
'  and CAND.COD_CANDIDATO = :P32_COD_CANDIDATO',
'  and cand.COD_EMPRESA = :P32_COD_EMPRESA',
'  AND COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);'))
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52404970486637151722)
,p_plug_name=>unistr('Confirmar Indica\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>49
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'FROM requisicao',
'where COD_REQ = :P32_COD_REQUISICAO',
'and CANDIDATO_INDICADO = :P32_COD_CANDIDATO;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52503693090143164099)
,p_plug_name=>'Tabs Container'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--pill:t-TabsRegion-mod--small:t-Form--noPadding:t-Form--leftLabels:margin-top-none'
,p_plug_template=>wwv_flow_api.id(72951034030045200636)
,p_plug_display_sequence=>39
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50988560764855049548)
,p_plug_name=>unistr('AVALIA\00C7\00D5ES')
,p_region_name=>'AVALIACOES'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_fase||'' - ''||initcap(f.desc_fase) fase,',
'       to_date(c.date_fase,''dd/mm/rrrr'') dt_fase,',
'       initcap(a.desc_aval_fase) Avaliacao,',
'       c.mot_aval_fase,',
'       c.data_aval_fase,',
'       c.cod_prest_serv_avaliador||'' - ''||initcap(ip.nome) avaliador,',
'       c.ind_aval_fase nota,',
'       c.resultado_fase,',
unistr('       decode(c.check_aprov,''S'',''Sim'',''N'',''N\00E3o'') Aprovado,'),
'       c.cod_candidato ,',
'        f.cod_fase,',
'        c.cod_req,',
'        c.cod_prest_serv_avaliador',
'        ,c.COD_AVAL_FASE',
'  from candidato c, inf_pessoais_candidato p, fase_candidato f, prestador_servico ip, avaliacao_fase a',
' where c.cod_candidato = p.cod_candidato',
'   and c.cod_fase = f.cod_fase',
'   and c.cod_prest_serv_avaliador = ip.cod_prest_serv (+)',
'   and c.cod_aval_fase = a.cod_aval_fase (+)',
'   and c.cod_req  = :p32_cod_requisicao',
'   and c.cod_candidato = :p32_cod_candidato',
' order by f.cod_fase;',
' '))
,p_plug_source_type=>'NATIVE_IR'
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(50988560860852049549)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:41:&SESSION.:AJUSTE_AVALIACAO:&DEBUG.:RP,41:P41_CANDIDATO,P41_COD_FASE,P41_COD_REQ:#COD_CANDIDATO#,#COD_FASE#,#COD_REQ#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>70087982109310805
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988560961361049550)
,p_db_column_name=>'FASE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561035920049551)
,p_db_column_name=>'DT_FASE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Data da Fase'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561164996049552)
,p_db_column_name=>'AVALIACAO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Avalia\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561276644049553)
,p_db_column_name=>'MOT_AVAL_FASE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Motivo de Avalia\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561333060049554)
,p_db_column_name=>'DATA_AVAL_FASE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Data de Avalia\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561477151049555)
,p_db_column_name=>'AVALIADOR'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Avaliador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561534706049556)
,p_db_column_name=>'NOTA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Nota'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561594776049557)
,p_db_column_name=>'RESULTADO_FASE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Resultado Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988561703897049558)
,p_db_column_name=>'APROVADO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Aprovado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(47018960365598049460)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Cod Candidato'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(47018960504858049461)
,p_db_column_name=>'COD_FASE'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Cod Fase'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(47018960616043049462)
,p_db_column_name=>'COD_REQ'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Cod Req'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(47018961652607049473)
,p_db_column_name=>'COD_PREST_SERV_AVALIADOR'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Cod Prest Serv Avaliador'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(47018961729846049474)
,p_db_column_name=>'COD_AVAL_FASE'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Cod Aval Fase'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(50988568940648118410)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'700961'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FASE:DT_FASE:AVALIACAO:MOT_AVAL_FASE:DATA_AVAL_FASE:AVALIADOR:NOTA:RESULTADO_FASE:APROVADO:COD_CANDIDATO:COD_FASE:COD_REQ:COD_PREST_SERV_AVALIADOR:COD_AVAL_FASE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50988561807552049559)
,p_plug_name=>'FASES'
,p_region_name=>'FASES'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_fase||'' - ''||initcap(f.desc_fase) fase,',
'       to_date(c.date_fase,''dd/mm/rrrr'') dt_fase,',
unistr('       decode(c.check_aprov,''S'',''Sim'',''N'',''N\00E3o'') Aprovado'),
'  from candidato c, inf_pessoais_candidato p, fase_candidato f, prestador_servico ip, avaliacao_fase a',
' where c.cod_candidato = p.cod_candidato',
'   and c.cod_fase = f.cod_fase',
'   and c.cod_prest_serv_avaliador = ip.cod_prest_serv (+)',
'   and c.cod_aval_fase = a.cod_aval_fase (+)',
'   and c.cod_req  = :p32_cod_requisicao',
'   and c.cod_candidato = :p32_cod_candidato',
' order by c.date_fase desc'))
,p_plug_source_type=>'NATIVE_IR'
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(50988561902233049560)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>70089023490310816
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50988562055085049561)
,p_db_column_name=>'FASE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50918381377464414674)
,p_db_column_name=>'DT_FASE'
,p_display_order=>20
,p_column_identifier=>'R'
,p_column_label=>'Dt Fase'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50918382077247414681)
,p_db_column_name=>'APROVADO'
,p_display_order=>90
,p_column_identifier=>'Y'
,p_column_label=>'Aprovado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(50988574174274149177)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'701013'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FASE:QUESTIONARIO_MAX:PESO_RESPOSTA_RESPOSTA:DT_FASE:APROVADO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50989309106064858345)
,p_plug_name=>unistr('QUESTION\00C1RIO')
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select --c.cod_candidato, c.cod_processo,',
'       qu.cod_fase||'' - ''||f.desc_fase fase, ',
'       q.descricao questionario, ',
'       q.nota_max,',
'       --q.cod, ',
'       y.descricao pergunta,',
'       y.peso_nota,',
'        case ',
'          when x.descricao_resposta is not null then ',
'             x.descricao_resposta ',
'          else ',
'            (select z.descricao ',
'               from rs_questionarios_respostas z',
'              where z.cod_questionario = x.cod_questionario',
'                and z.cod_pergunta = x.cod_pergunta',
'                and z.cod = x.cod_resposta) ',
'          end resposta,',
'       x.nota nota_resposta--,',
'      -- qu.nota nota_final',
'  from ps_processo_fase p,',
'       fase_candidato f,',
'       ps_fase_padrao_cargo r,',
'       candidato c,',
'       rs_questionarios q,',
'       rs_questionarios_perguntas y,',
'       rs_questionario_usuario qu,',
'       rs_questionario_usuario_resp x',
' where p.cod_processo = c.cod_processo',
'   and p.cod_processo = qu.cod_ps',
'   and p.cod_processo = x.cod_ps (+) --',
'   and p.cod_fase = f.cod_fase',
'   and p.cod_fase = r.cod_fase',
'   and p.cod_fase = c.cod_fase',
'   and p.cod_fase = qu.cod_fase',
'   and p.cod_fase = x.cod_fase (+) --',
'   and r.cod_questionario = q.cod',
'   and r.cod_questionario = y.cod_questionario',
'   and r.cod_questionario = x.cod_questionario (+) --',
'   and p.tipo_entidade = ''5''',
'   and c.cod_candidato = qu.cod_candidato',
'   and c.cod_candidato = x.cod_candidato (+) --',
'   and y.cod = x.cod_pergunta (+) --',
'   and c.cod_candidato = :p32_cod_candidato',
'   and c.cod_processo = :p32_cod_requisicao',
' order by qu.cod_fase, q.descricao, y.ordem '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>'select 1 from rs_questionario_usuario where cod_ps = :p32_cod_requisicao and cod_candidato = :p32_cod_candidato'
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(50989309254636858346)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>70836375894119602
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310004880858354)
,p_db_column_name=>'FASE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Fase'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310120492858355)
,p_db_column_name=>'QUESTIONARIO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('Question\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310247038858356)
,p_db_column_name=>'NOTA_MAX'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Nota M\00E1xima')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310408063858358)
,p_db_column_name=>'PERGUNTA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Pergunta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310548236858359)
,p_db_column_name=>'PESO_NOTA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Peso da Nota'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310633458858360)
,p_db_column_name=>'RESPOSTA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Resposta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989310735770858361)
,p_db_column_name=>'NOTA_RESPOSTA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Nota da Resposta'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(50989443313286151397)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'709705'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FASE:QUESTIONARIO:NOTA_MAX:PERGUNTA:PESO_NOTA:RESPOSTA:NOTA_RESPOSTA'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(50989310929830858363)
,p_name=>'DOCUMENTOS ANEXOS'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_template=>wwv_flow_api.id(72951031880997200635)
,p_display_sequence=>100
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Cards--displaySubtitle:t-Cards--basic:t-Cards--displayIcons:t-Cards--4cols:t-Cards--animColorFill:t-Report--hideNoPagination'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'INITCAP(t.descricao)  card_title, ',
'INITCAP(s.descricao) card_subtitle, ',
'U.DESCRICAO||'' ''||U.DATA_ARQUIVO card_text, ',
'''Anexado'' card_subtext, ',
'-- ui and other attributes',
'''classe_ok'' card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> u.cod_empresa||'',''||u.COD_ITEM||'',''||U.TIPO_ARQUIVO||'',''||U.SEQ_ITEM||'',''||U.TIPO_SUB_ITEM||'',''||863||'',''||U.TIPO_COD_ITEM,',
' p_clear_cache => 864',
' ) card_link,',
'''u-success'' card_color,',
'''fa-cloud-file''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'2 ordem',
'  FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
' WHERE u.tipo_arquivo = t.cod',
'AND u.tipo_sub_item = s.cod',
'AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'--AND u.cod_empresa= :P32_COD_EMPRESA',
'AND u.cod_item= :P32_COD_CANDIDATO',
'AND u.tipo_cod_item = ''CANDIDATO''',
'and s.cod in (0,1)',
'and f_permissao_docs (u.tipo_cod_item, u.tipo_sub_item, t.cod) = ''S''',
'AND NVL(U.SEQ_ITEM,0) = (select nvl(max(seq_item),0)',
'                   from upload_files ux',
'                  where ux.tipo_cod_item = U.tipo_cod_item',
'                    and ux.cod_empresa = U.COD_EMPRESA',
'                    and ux.cod_item = U.COD_ITEM',
'                    and ux.tipo_arquivo = U.TIPO_ARQUIVO',
'                    and nvl(ux.tipo_sub_item,0) = nvl(UX.tipo_sub_item,0)',
'                    and nvl(ux.cod_sub_item,0) = nvl(UX.cod_sub_item,0)',
'                    and ux.cod_req is null)',
'UNION',
'SELECT ',
'INITCAP(t.descricao)  card_title, ',
' case when ((t.obrig_candidato = ''S'') or (t.obrig_ps = ''S''))',
' then',
' ''Pendente''',
unistr(' end  card_subtitle,--DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_text,'),
' case when ((t.obrig_candidato = ''S'') or (t.obrig_ps = ''S''))',
' then',
unistr(' ''Obrigat\00F3rio'''),
' else',
' ''Opcional''',
' end card_subtext, ',
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
' case when ((t.obrig_candidato = ''S'') or (t.obrig_ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
' then',
' ''u-danger''',
' else',
' ''u-normal''',
' end  card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
' case when ((t.obrig_candidato = ''S'') or (t.obrig_ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
' then',
' 1',
' else',
' 3',
' end ordem',
'  FROM tipo_arquivo_upload t',
' WHERE t.cod_tipo_sub_item in (0,1)',
'   and f_permissao_docs (''CANDIDATO'', t.cod_tipo_sub_item, t.cod) = ''S''',
' and ((t.candidato= ''S'') or (t.ps = ''S''))',
'  --AND t.obrig_candidato = ''S'' -- APAGAR SE NAO DER CERTO IGOR 23/02/19',
'  and (t.cod,t.cod_tipo_sub_item) not in (select 7,0 from dual union',
'select 10,0 from dual union',
'select 11,0 from dual union',
'select 13,0 from dual union',
'select 20,0 from dual union',
'select 32,0 from dual union',
'select 6,1 from dual union',
'select 32,1 from dual)',
'and not exists (select 1 ',
'  from upload_files u ',
' where t.cod_tipo_sub_item = 0',
'and t.cod = 33',
'and u.cod_empresa= :P32_COD_EMPRESA',
'AND u.cod_item= :P32_COD_CANDIDATO',
'AND u.tipo_cod_item = ''CANDIDATO''',
'and u.cod_sub_item = 0',
'and u.tipo_arquivo = 1',
' union',
' select 1 ',
'  from upload_files u ',
' where t.cod_tipo_sub_item = 0',
'and t.cod in (34,35)',
'and u.cod_empresa= :P32_COD_EMPRESA',
'AND u.cod_item= :P32_COD_CANDIDATO',
'AND u.tipo_cod_item = ''CANDIDATO''',
'and u.cod_sub_item = 0',
'and u.tipo_arquivo = 5)',
'AND (t.cod,t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO''',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, instrucao i, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 10',
'  and t.cod_tipo_sub_item = 0',
'  AND i.cod = p.instrucao',
'  AND i.ind_certificado = ''S''',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 11',
'  and t.cod_tipo_sub_item = 0',
'  AND p.sexo = ''M''',
'  AND p.NACIONALIDADE = 10',
'  AND p.ind_eximido = ''N''',
'  --AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 13',
'  and t.cod_tipo_sub_item = 0',
'  AND ((p.NACIONALIDADE <> 10) or (p.ind_eximido = ''N''))',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 20',
'  and t.cod_tipo_sub_item = 0',
'  AND p.nacionalidade <> 10',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 7',
'  and t.cod_tipo_sub_item = 0',
'  AND nvl(p.primeiro_emprego,''N'') = ''N'' ',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod_TIPO_SUB_ITEM = 1',
' -- AND p.POSSUI_DEPENDENTE = ''S''',
' AND ((P.ESTADO_CIVIL =  ''C'') OR ',
'(P.ESTADO_CIVIL <> ''C'' AND UPPER(T.DESCRICAO) NOT LIKE ''%CASAMENTO%'')) ',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'  AND t.cod <> 32',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 32',
'  AND t.cod_tipo_sub_item = 0',
'  AND p.ind_def_fis = ''S''',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S''))',
'  AND t.cod = 32',
'  AND t.cod_tipo_sub_item = 1',
'  AND d.CONDICAO_DEPEND = ''I'' ',
'  AND p.cod_candidato = d.cod_candidato',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO  ',
'/*',
'UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d',
'WHERE t.colaborador = ''S'' ',
'  and ''CANDIDATO'' = ''COLABORADOR''',
'  AND t.cod = 32',
'  AND t.cod_tipo_sub_item = 1',
'  AND d.CONDICAO_DEPEND = ''I'' ',
'  AND p.cod_empresa = d.cod_empresa',
'  AND p.matricula = d.matricula',
'  AND p.cod_empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO  ',
'*/',
'  UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'  AND t.cod = 6',
'  AND t.cod_tipo_sub_item = 1',
'  AND d.grau_parentesco in (''EA'',''EO'')',
'  AND p.empresa = d.cod_empresa',
'  AND p.cod_candidato = d.cod_candidato',
'  AND p.empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO',
'  UNION',
'  SELECT t.cod, t.cod_tipo_sub_item',
' FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d',
'WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'  AND t.cod = 6',
'  AND t.cod_tipo_sub_item = 1',
'  AND d.grau_parentesco in (''EA'',''EO'')',
'  AND p.cod_empresa = d.cod_empresa',
'  AND p.matricula = d.matricula',
'  AND p.cod_empresa = :P32_COD_EMPRESA',
'  AND p.cod_candidato = :P32_COD_CANDIDATO )',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, instrucao i, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'AND t.cod = 10',
'and t.cod_tipo_sub_item = 0',
'AND i.cod = p.instrucao',
'AND i.ind_certificado = ''S''',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'AND t.cod = 11',
'and t.cod_tipo_sub_item = 0',
'AND p.sexo = ''M''',
'AND p.NACIONALIDADE = 10',
'AND (p.ind_eximido = ''N'')',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')',
'  UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'AND t.cod = 13',
'and t.cod_tipo_sub_item = 0',
'AND p.NACIONALIDADE = 10',
'AND (p.ind_eximido = ''N'')',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'AND t.cod = 20',
'and t.cod_tipo_sub_item = 0',
'AND p.NACIONALIDADE <> 10',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')  ',
' UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'AND t.cod = 7',
'and t.cod_tipo_sub_item = 0',
'AND nvl(p.primeiro_emprego,''N'') = ''N''',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'') ',
' UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'AND t.cod_TIPO_SUB_ITEM = 1',
'AND p.POSSUI_DEPENDENTE = ''S'' ',
'AND ((P.ESTADO_CIVIL =  ''C'') OR ',
'  (P.ESTADO_CIVIL <> ''C'' AND UPPER(T.DESCRICAO) NOT LIKE ''%CASAMENTO%'')) ',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND t.cod <> 32',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('case when ((t.obrig_candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S'')) then ''Obrigat\00F3rio'' '),
' else',
' ''Opcional''',
' end card_subtext, ',
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'case when ((t.obrig_candidato = ''S'') or (t.obrig_colaborador = ''S'' and :P32_CANDIDATO_APROVADO = ''S'')) then ''u-danger''',
' else',
' ''u-normal'' end ',
' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t',
' WHERE ((t.colaborador = ''S'') or (t.pj = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'  and fnct_verif_upload_colab (:P32_COD_EMPRESA, :P32_COD_CANDIDATO, cod_tipo_sub_item, cod) = ''S''  ',
' UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem  ',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'and t.cod = 32',
'AND t.cod_TIPO_SUB_ITEM = 0',
'AND p.ind_def_fis = ''S'' ',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')  ',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem  ',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'and t.cod = 32',
'AND t.cod_TIPO_SUB_ITEM = 1',
'AND d.CONDICAO_DEPEND = ''I'' ',
'and p.cod_candidato = d.cod_candidato',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')  ',
'/*UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem  ',
'  FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d',
' WHERE t.colaborador = ''S'' and ''CANDIDATO'' = ''COLABORADOR''',
'and t.cod = 32',
'AND t.cod_TIPO_SUB_ITEM = 1',
'AND d.CONDICAO_DEPEND = ''I'' ',
'and p.cod_empresa = d.cod_empresa',
'and p.matricula = d.matricula',
'AND p.cod_empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')  ',
'  */',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d',
' WHERE ((t.candidato = ''S'') or (t.ps = ''S'' and :P32_CANDIDATO_APROVADO = ''S''))',
'and t.cod = 6',
'AND t.cod_TIPO_SUB_ITEM = 1',
'and d.grau_parentesco in (''EA'',''EO'')',
'and p.cod_candidato = d.cod_candidato',
'AND p.empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')  ',
'/*',
'UNION',
'select',
'INITCAP(t.descricao)  card_title, ',
unistr('DECODE(TO_CHAR(cod_tipo_sub_item), ''0'',''Documento Pr\00F3prio'',''1'',''Dependente'') card_subtitle, '),
'null card_text,',
unistr('''Obrigat\00F3rio'' card_subtext, '),
'-- ui and other attributes',
'null card_modifiers,  ',
'apex_page.get_url (',
' p_application => ''CV_''||:P_BASE,',
' p_page  => 864,',
' p_items => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM'',',
' p_values=> :P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||T.COD||'',''||NULL||'',''||COD_TIPO_SUB_ITEM||'',''||863||'',''||''CANDIDATO'',',
' p_clear_cache => 864',
' ) card_link,',
'''u-danger'' card_color,',
'''fa-file-x''  card_icon,',
'apex_string.get_initials(t.descricao)  card_initials,',
'1 ordem',
'  FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d',
' WHERE t.colaborador = ''S'' and ''CANDIDATO'' = ''COLABORADOR''',
'and t.cod = 6',
'AND t.cod_TIPO_SUB_ITEM = 1',
'and d.grau_parentesco in (''EA'',''EO'')',
'and p.cod_empresa = d.cod_empresa',
'and p.matricula = d.matricula',
'AND p.cod_empresa = :P32_COD_EMPRESA',
'AND p.cod_candidato = :P32_COD_CANDIDATO',
'AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item',
' FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
'WHERE u.tipo_arquivo = t.cod',
'  AND u.tipo_sub_item = s.cod',
'  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'  AND u.cod_empresa= :P32_COD_EMPRESA',
'  AND u.cod_item= :P32_COD_CANDIDATO',
'  AND u.tipo_cod_item = ''CANDIDATO'')',
'  */',
' ORDER BY 10, 7 DESC, 4, 3 DESC'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(72951038120959200649)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311002713858364)
,p_query_column_id=>1
,p_column_alias=>'CARD_TITLE'
,p_column_display_sequence=>1
,p_column_heading=>'Card Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311134055858365)
,p_query_column_id=>2
,p_column_alias=>'CARD_SUBTITLE'
,p_column_display_sequence=>2
,p_column_heading=>'Card Subtitle'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311242638858366)
,p_query_column_id=>3
,p_column_alias=>'CARD_TEXT'
,p_column_display_sequence=>3
,p_column_heading=>'Card Text'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311283524858367)
,p_query_column_id=>4
,p_column_alias=>'CARD_SUBTEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Card Subtext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311438839858368)
,p_query_column_id=>5
,p_column_alias=>'CARD_MODIFIERS'
,p_column_display_sequence=>5
,p_column_heading=>'Card Modifiers'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311491511858369)
,p_query_column_id=>6
,p_column_alias=>'CARD_LINK'
,p_column_display_sequence=>6
,p_column_heading=>'Card Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311663564858370)
,p_query_column_id=>7
,p_column_alias=>'CARD_COLOR'
,p_column_display_sequence=>7
,p_column_heading=>'Card Color'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311770449858371)
,p_query_column_id=>8
,p_column_alias=>'CARD_ICON'
,p_column_display_sequence=>8
,p_column_heading=>'Card Icon'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311785760858372)
,p_query_column_id=>9
,p_column_alias=>'CARD_INITIALS'
,p_column_display_sequence=>9
,p_column_heading=>'Card Initials'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50989311962004858373)
,p_query_column_id=>10
,p_column_alias=>'ORDEM'
,p_column_display_sequence=>10
,p_column_heading=>'Ordem'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(51058377187820973473)
,p_plug_name=>'DADOS FUNCIONAIS'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'       i.cod_empresa||'' - ''||Initcap(fnct_nome_empresa(i.cod_empresa,''S'')) NOME_EMPRESA, ',
'       i.FILIAL||'' - ''||Initcap(fnct_nome_filial(i.cod_empresa, i.filial,''S'')) NOME_FILIAL, ',
'       i.cod_ccusto||'' - ''||Initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) NOME_CCUSTO,',
'       i.unidade_adm||'' - ''||Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       i.cargo||'' - ''||Initcap(fnct_nome_cargo(i.cargo)) CARGO, ',
'       I.MATRICULA||'' - ''||INITCAP(P.NOME) colaborador, ',
'       i.num_sind_diss||'' - ''||initcap(fnct_nome_sindicato(i.cod_empresa, i.num_sind_diss,''S'')) sindicato,',
'       case when i.situacao = ''01'' then ''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||Initcap(fnct_nome_situacao(i.situacao))',
'            when i.situacao between ''02'' and ''89'' then ''<span aria-hidden="true" class="fa fa-pause-circle colorAlert"></span> ''||Initcap(fnct_nome_situacao(i.situacao))',
'            when i.situacao >= ''90'' then ''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||Initcap(fnct_nome_situacao(i.situacao)) ',
'       end SITUACAO, ',
'       I.DT_SITUACAO, ',
'       I.DT_ADMISSAO, ',
'       Initcap(fnct_nome_vinculo(i.vinculo)) vinculo,',
'       apex_page.get_url (',
'            p_application => :P_PAINEL||''_''||:P_BASE,',
'            p_page        => 13,',
'            p_items       => ''P13_EMP,P13_MAT'',',
'            p_values      => I."COD_EMPRESA"||'',''||I."MATRICULA",',
'            p_clear_cache => 13',
'            ) Link,',
'           CASE',
'              WHEN i.cod_empresa = c.cod_emp_gestor',
'              AND i.matricula = c.matricula_gestor',
'                 THEN (SELECT cx.matricula_gestor||'' - ''||initcap(fnct_nome_func (cx.cod_emp_gestor,',
'                                              cx.matricula_gestor',
'                                             ))',
'                         FROM centro_de_custo cx',
'                        WHERE cx.cod_empresa = c.cod_empresa',
'                          AND cx.cod = c.cod_ccusto_superior',
'                          AND ROWNUM = 1)',
'              WHEN i.matricula <> c.matricula_gestor',
'                 THEN c.matricula_gestor||'' - ''||initcap(fnct_nome_func (c.cod_emp_gestor, c.matricula_gestor))',
'           END gestor,',
'       c.cod_ccusto_superior||'' - ''||initcap(cs.nome) ccusto_superior,',
'       lower(i.e_mail) email_funcional',
'  FROM INFORMACOES_FUNCIONAIS_CAD I,',
'       INF_PESSOAIS_CAD P,',
'       CENTRO_DE_CUSTO C,',
'       CENTRO_DE_CUSTO CS,',
'       inf_pessoais_candidato pess',
' WHERE i.cod_empresa = c.cod_empresa',
'   and i.cod_empresa = p.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and c.cod_empresa = cs.cod_empresa (+)',
'   and c.cod_ccusto_superior = cs.cod (+)',
'   and i.matricula = p.matricula',
'   and p.num_cpf = pess.num_cpf',
'   and p.dc_cpf = pess.dc_cpf',
'   and pess.cod_candidato = :P32_COD_CANDIDATO',
'   order by i.dt_situacao desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P32_COD_CANDIDATO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>'select 1 from inf_pessoais_cad p, inf_pessoais_candidato pess where pess.cod_candidato = :p32_cod_candidato and p.num_cpf = pess.num_cpf and p.dc_cpf = pess.dc_cpf'
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(51058377287357973474)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'#LINK#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>69888061497657825
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058397949901981953)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'AC'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398044815981954)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>20
,p_column_identifier=>'AD'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398213554981955)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>30
,p_column_identifier=>'AE'
,p_column_label=>'Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398237804981956)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>40
,p_column_identifier=>'AF'
,p_column_label=>'Unidade Adm.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398422450981957)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>50
,p_column_identifier=>'AG'
,p_column_label=>'Atividade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398513178981958)
,p_db_column_name=>'CARGO'
,p_display_order=>60
,p_column_identifier=>'AH'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398612338981959)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>70
,p_column_identifier=>'AI'
,p_column_label=>'Colaborador'
,p_column_link=>'#LINK#'
,p_column_linktext=>'#COLABORADOR#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398723168981960)
,p_db_column_name=>'SINDICATO'
,p_display_order=>80
,p_column_identifier=>'AJ'
,p_column_label=>'Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398754226981961)
,p_db_column_name=>'SITUACAO'
,p_display_order=>90
,p_column_identifier=>'AK'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398845952981962)
,p_db_column_name=>'DT_SITUACAO'
,p_display_order=>100
,p_column_identifier=>'AL'
,p_column_label=>unistr('Data de Situa\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058398984485981963)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>110
,p_column_identifier=>'AM'
,p_column_label=>unistr('Data de Admiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058399114969981964)
,p_db_column_name=>'VINCULO'
,p_display_order=>120
,p_column_identifier=>'AN'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058399148818981965)
,p_db_column_name=>'LINK'
,p_display_order=>130
,p_column_identifier=>'AO'
,p_column_label=>'Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058399307349981966)
,p_db_column_name=>'GESTOR'
,p_display_order=>140
,p_column_identifier=>'AP'
,p_column_label=>'Gestor'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058399360545981967)
,p_db_column_name=>'CCUSTO_SUPERIOR'
,p_display_order=>150
,p_column_identifier=>'AQ'
,p_column_label=>'Centro de Custo Superior'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058399457161981968)
,p_db_column_name=>'EMAIL_FUNCIONAL'
,p_display_order=>160
,p_column_identifier=>'AR'
,p_column_label=>'Email Funcional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(51058426055607017484)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'699369'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_EMPRESA:NOME_FILIAL:NOME_CCUSTO:UNIDADE_ADM:ATIVIDADE:CARGO:COLABORADOR:SINDICATO:SITUACAO:DT_SITUACAO:DT_ADMISSAO:VINCULO:LINK:GESTOR:CCUSTO_SUPERIOR:EMAIL_FUNCIONAL'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52252290543288543293)
,p_plug_name=>'DADOS DO CANDIDATO'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C_DADOS IS',
'SELECT CAND.COD_EMPRESA',
'   , FUNC.STATUS_CANDIDATO',
'   , INITCAP(NVL(PESS.NOME_SOCIAL,PESS.NOME)) NOME',
'   , PESS.TIPO_LOGRADOURO_ES||'' ''||INITCAP(PESS.ENDERECO) ENDERECO',
'   , INITCAP(PESS.BAIRRO) BAIRRO',
'   , INITCAP(PESS.CIDADE) CIDADE',
'   , CAND.cod_fase||'' - ''||INITCAP((SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = CAND.cod_fase)) COD_FASE',
'   , upper(PESS.UF) UF',
'   , LPAD(CEP,5,0)||''-''||LPAD(COMPLEMENTO_CEP,3,0) CEP',
'   , REGEXP_REPLACE(PESS.DDD,''[^[:digit:]]'')||REGEXP_REPLACE(PESS.TELEFONE,''[^[:digit:]]'') TELEFONE',
'   , REGEXP_REPLACE(PESS.DDD_CELULAR,''[^[:digit:]]'')||REGEXP_REPLACE(PESS.TELEFONE_CELULAR,''[^[:digit:]]'') TELEFONE_CELULAR',
'   , case when PESS.TELEFONE_CELULAR is not null then ''https://api.whatsapp.com/send?phone=+55''||NVL(REGEXP_REPLACE(PESS.DDD_CELULAR,''[^[:digit:]]''),11)||REGEXP_REPLACE(PESS.TELEFONE_CELULAR,''[^[:digit:]]'') end web_whats',
'   , LOWER(PESS.E_MAIL) E_MAIL',
'   , trunc((months_between(sysdate,to_date(PESS.DT_NAC,''dd/mm/rrrr'')))/12) IDADE',
'   , PESS.DT_NAC DATA_NASCIMENTO',
'   ,   CASE WHEN SEXO = ''F'' THEN ''Feminino''',
'            WHEN SEXO = ''M'' THEN ''Masculino''',
'        else SEXO end SEXO',
'   , PESS.NUM_IDENTIDADE',
'   , CASE WHEN POSSUI_DEPENDENTE = ''S'' THEN ''Sim''',
unistr('            WHEN POSSUI_DEPENDENTE = ''N'' THEN ''N\00E3o'''),
'        else POSSUI_DEPENDENTE end POSSUI_DEPENDENTE',
'   , FUNC.DATA_APRESENTACAO',
'   , FUNC.DATA_CONVOCACAO',
'   , TO_CHAR(FUNC.DT_ATUALIZACAO,''DD/MM/RRRR'') DATA_CADASTRO',
'   , INITCAP(NVL((SELECT EMP.CARGO FROM empregos_anteriores EMP',
'                   WHERE EMP.COD_CANDIDATO = FUNC.COD_CANDIDATO',
unistr('                     AND DATA_DESL_EMP = (SELECT MAX(DATA_DESL_EMP) FROM empregos_anteriores EMP2 WHERE EMP2.COD_CANDIDATO = EMP.COD_CANDIDATO)),''N\00C3O INFORMADO'')) ULTIMO_CARGO  '),
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
unistr('                   FETCH FIRST ROW ONLY),''N\00C3O INFORMADO'')) GRAU_INSTRUCAO'),
'   , NVL((SELECT COUNT(1) FROM RP_CAND_INSCRITOS CAIN WHERE CAIN.COD_CANDIDATO = CAND.COD_CANDIDATO),0)||'' Candidatura(s)'' HIST_REQUISICOES',
'   , NOME_FOTO',
'   , FOTO',
'   , TIPO   ',
'   , CASE WHEN IND_DEF_FIS = ''S'' THEN --fas fa-wheelchair',
unistr('         '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' ELSE ''N\00E3o'' end PCD'),
unistr('   --, CASE WHEN IND_DEF_FIS = ''S'' THEN ''Sim'' else ''N\00E3o'' end PCD'),
' FROM CANDIDATO CAND',
'    , INF_FUNC_CANDIDATO_CAD FUNC',
'    , INF_PESSOAIS_CANDIDATO_CAD PESS',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND CAND.COD_REQ       = :P32_COD_REQUISICAO',
'  AND CAND.COD_CANDIDATO = :P32_COD_CANDIDATO',
'  AND CAND.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_PROCESSO = CAND.COD_PROCESSO);',
'',
'R_DADOS C_DADOS%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C_DADOS;',
'FETCH C_DADOS INTO R_DADOS;',
'CLOSE C_DADOS;',
'',
'htp.p(''<style>''); ',
'htp.p(''.tabela,  td{',
'      border-collapse: collapse;',
'      padding: 10px;',
'      text-align: left;',
'      }''); ',
'',
'htp.p(''.label {color:#4238ca; font-weight:bold;}''); ',
'htp.p(''</style>''); ',
'',
'',
'     htp.p(/*''<b><p style="font-size:30px">''||R_DADOS.NOME||''</p></b></br>''||*/ case when R_DADOS.IDADE is not null and R_DADOS.CIDADE is not null then ',
'     ''<p style="font-size:20px">''||R_DADOS.IDADE||'' Anos   -  ''||R_DADOS.CIDADE||'' - ''||nvl(R_DADOS.UF,''SP'')||''<br/>''',
'     end||''</p>'');',
'     ',
'     htp.p(''<table  class="tabela">'');',
'     htp.p(''<tbody>'');',
'     ',
'     htp.p(''<td>'');',
unistr('     htp.p(''<label class="label">\00DAltimo Cargo </label><br/>'' ||R_DADOS.ULTIMO_CARGO||''<br/><br/>'');'),
'     htp.p(''<label class="label">Etapa </label><br/>'' ||R_DADOS.COD_FASE||''<br/><br/>'');',
'     htp.p(''<label class="label">Cadastro </label><br/>'' ||R_DADOS.DATA_CADASTRO||''<br/><br/>'');',
unistr('     htp.p(''<label class="label">Grau de Instru\00E7\00E3o </label><br/>'' ||R_DADOS.GRAU_INSTRUCAO||''<br/><br/>'');'),
'     htp.p(''</td>'');',
'     htp.p(''<td>'');        ',
'     htp.p(''<label class="label">E-mail </label><br/>'' ||R_DADOS.E_MAIL||''<br/><br/>'');',
unistr('     htp.p(''<label class="label">Endere\00E7o  </label><br/>'' ||R_DADOS.ENDERECO||''<br/><br/>'');'),
'     htp.p(''<label class="label">Bairro </label><br/>'' ||R_DADOS.BAIRRO||''<br/><br/>'');',
'     htp.p(''<label class="label">Cidade </label><br/>'' ||R_DADOS.CIDADE||''<br/><br/>'');',
'     htp.p(''</td>'');',
'     htp.p(''<td>'');        ',
'     htp.p(''<label class="label">UF </label><br/>'' ||R_DADOS.UF||''<br/><br/>'');',
'     htp.p(''<label class="label">CEP </label><br/>'' ||R_DADOS.CEP||''<br/><br/>'');',
'     htp.p(''<label class="label">Hist. de Candidatura </label><br/>'' ||R_DADOS.HIST_REQUISICOES ||''<br/><br/>'');',
'     htp.p(''<label class="label">PCD </label><br/>'' ||R_DADOS.PCD||''<br/><br/>'');',
'     htp.p(''</td>'');',
'     htp.p(''<td>'');        ',
'     htp.p(''<label class="label">Possui Dependente(s) </label><br/>'' ||R_DADOS.POSSUI_DEPENDENTE||''<br/><br/>'');',
'     htp.p(''<label class="label">Telefone </label><br/>'' ||R_DADOS.TELEFONE||''<br/><br/>'');',
'     htp.p(''<label class="label">Celular </label><br/>'' ||R_DADOS.TELEFONE_CELULAR||''<a href="''||r_dados.web_whats||''"</a>''||''<i class="fa fa-whatsapp" style="font-size:35px" ></i><br/><br/>'');',
'    --htp.p(''<i class="fa fa-whatsapp" style="font-size:24px" ></i>'');',
'     htp.p(''</td>'');',
'     htp.p(''<td>'');        ',
'     htp.p(''<label class="label">Data de Nascimento </label><br/>'' ||R_DADOS.DATA_NASCIMENTO||''<br/><br/>'');',
unistr('     htp.p(''<label class="label">N\00BA Identidade </label><br/>'' ||R_DADOS.NUM_IDENTIDADE||''<br/><br/>'');'),
unistr('     htp.p(''<label class="label">Data Apresenta\00E7\00E3o </label><br/>'' ||R_DADOS.DATA_APRESENTACAO||''<br/><br/>'');'),
unistr('     htp.p(''<label class="label">Data Convoca\00E7\00E3o </label><br/>'' ||R_DADOS.DATA_CONVOCACAO||''<br/><br/>'');     '),
'     htp.p(''</td>'');',
'     htp.p(''</td>'');',
'     htp.p(''</tbody>'');',
'     htp.p(''</table>'');',
'     ',
'     ',
'htp.p(''<br />''); ',
'',
':P32_cod_fase := R_DADOS.COD_FASE;',
'',
'BEGIN',
'  SELECT x.nota_de_corte ',
'  INTO :P32_NOTA_MINIMA',
'  FROM ps_processo_fase x ',
'  WHERE x.cod_processo = :P32_COD_REQUISICAO ',
'  AND x.cod_fase = R_DADOS.COD_FASE',
'  AND ROWNUM = 1;',
'EXCEPTION ',
'WHEN OTHERS THEN',
'NULL;',
'END;',
'',
'END;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(52404969319539151710)
,p_name=>'TIMELINE CANDIDATO'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_template=>wwv_flow_api.id(72951031880997200635)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Comments--basic'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.cod_cand_log ID,',
'       l.data as COMMENT_DATE,',
'       l.usuario as USER_NAME,',
'       --t.CREATED as TASK_CREATED,',
'       ''<h4><b>''||l.observacao||''</b></h4>''|| case when l.mensagem is not null then chr(10)||l.mensagem end COMMENT_TEXT,',
'       null as ACTIONS,',
'       null as ATTRIBUTE_1,',
'       null as ATTRIBUTE_2,',
'       null as ATTRIBUTE_3,',
'       null as ATTRIBUTE_4,',
unistr('      ''<span aria-hidden="true" class="fa fa-clock-o fa-2x"></span>''/*apex_string.get_initials(p.nome)*/ user_icon, -- \00EDcone do coment\00E1rio'),
unistr('      ''colorBlue'' icon_modifier -- cor do coment\00E1rio'),
'  from CANDIDATO_LOG L',
' where COD_CANDIDATO = :P32_COD_CANDIDATO',
'  and COD_REQUISICAO = :P32_COD_REQUISICAO',
'',
'order by 1 desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P32_COD_CANDIDATO'
,p_query_row_template=>wwv_flow_api.id(72951040160196200650)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Registro Cadastrado'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595332291279975025)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595332370944975026)
,p_query_column_id=>2
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>2
,p_column_heading=>'Comment Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595332521966975027)
,p_query_column_id=>3
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>3
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595332601104975028)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Comment Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595332783643975030)
,p_query_column_id=>5
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>5
,p_column_heading=>'Actions'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595332912095975031)
,p_query_column_id=>6
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>6
,p_column_heading=>'Attribute 1'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333003978975032)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>7
,p_column_heading=>'Attribute 2'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333070199975033)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>8
,p_column_heading=>'Attribute 3'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333141876975034)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>9
,p_column_heading=>'Attribute 4'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333244440975035)
,p_query_column_id=>10
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>10
,p_column_heading=>'User Icon'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333333178975036)
,p_query_column_id=>11
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>11
,p_column_heading=>'Icon Modifier'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52462584011557814461)
,p_plug_name=>unistr('HIST\00D3RICO DE PROCESSOS')
,p_region_name=>'VAGAS'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'        sele.COD_PROCESSO COD_REQUERIMENTO',
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
'      ,decode(r.cod_sit_req,1,''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Prevista'',',
'                            2,''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||''Fechada'',',
'                            3,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Cancelada'',',
'                            4,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Reprovada'',',
'                            5,''<span aria-hidden="true" class="fa fa-check-circle colorAlert"></span> ''||''Aberta'',',
unistr('                            6,''<span aria-hidden="true" class="fa fa-pause-circle colorAlert"></span> ''||''Suspens\00E3o'') Status_Req'),
'     ,CASE WHEN r.cod_sit_req <> 1 THEN apex_page.get_url (p_page => 29,',
'                          p_items       => ''P29_REQUISICAO,P29_EMP_ID'',',
'                          p_values      => SELE.COD_PROCESSO||'',''||SELE.COD_EMPRESA,',
'                          p_clear_cache => 29) END link',
'                          ,CASE WHEN r.cod_sit_req = 1 THEN ''ESCONDE'' END ESCONDE',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'    , candidato c',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'  and r.cod_req = c.cod_processo',
'  and c.cod_candidato = :p32_cod_candidato',
'ORDER BY 1 DESC'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'    , candidato c',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'  and r.cod_req = c.cod_processo',
'  and c.cod_candidato = :p32_cod_candidato'))
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(52462584676097814468)
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
,p_internal_uid=>1544111797355075724
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989448480058237100)
,p_db_column_name=>'LINK'
,p_display_order=>60
,p_column_identifier=>'A'
,p_column_label=>'Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989448878923237101)
,p_db_column_name=>'COD_REQUERIMENTO'
,p_display_order=>70
,p_column_identifier=>'B'
,p_column_label=>unistr('Cod. Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989449290822237102)
,p_db_column_name=>'CARGO'
,p_display_order=>80
,p_column_identifier=>'C'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989449742505237103)
,p_db_column_name=>'EMPRESA'
,p_display_order=>90
,p_column_identifier=>'D'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989450135956237103)
,p_db_column_name=>'FILIAL'
,p_display_order=>100
,p_column_identifier=>'E'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989450570306237104)
,p_db_column_name=>'CENTRO_CUSTO'
,p_display_order=>110
,p_column_identifier=>'F'
,p_column_label=>'Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989450946832237105)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>120
,p_column_identifier=>'G'
,p_column_label=>'Unidade Administrativa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989451319211237105)
,p_db_column_name=>'SELECIONADOR'
,p_display_order=>130
,p_column_identifier=>'H'
,p_column_label=>'Selecionador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989451743782237106)
,p_db_column_name=>'FASE_PROCESSO'
,p_display_order=>140
,p_column_identifier=>'I'
,p_column_label=>'Fase Processo Requerimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989452167694237107)
,p_db_column_name=>'QUANTIDADE_CANDIDATOS'
,p_display_order=>150
,p_column_identifier=>'J'
,p_column_label=>'Quantidade Candidatos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989452553427237108)
,p_db_column_name=>'PRAZO_INICIAL'
,p_display_order=>160
,p_column_identifier=>'K'
,p_column_label=>'Prazo Inicial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989452786638237110)
,p_db_column_name=>unistr('PRAZO_CONTRATA\00C7\00C3O')
,p_display_order=>170
,p_column_identifier=>'L'
,p_column_label=>unistr('Prazo Contrata\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989453227581237111)
,p_db_column_name=>'STATUS_REQ'
,p_display_order=>180
,p_column_identifier=>'M'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989453621658237111)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>190
,p_column_identifier=>'N'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989454071537237112)
,p_db_column_name=>'VINCULO'
,p_display_order=>200
,p_column_identifier=>'O'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989454422305237113)
,p_db_column_name=>'ESCONDE'
,p_display_order=>210
,p_column_identifier=>'P'
,p_column_label=>'Esconde'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989454819084237113)
,p_db_column_name=>'COD_LOCAL_TRAB'
,p_display_order=>220
,p_column_identifier=>'Q'
,p_column_label=>'Local Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989447310607237098)
,p_db_column_name=>'TIPO_PUBLICACAO'
,p_display_order=>230
,p_column_identifier=>'R'
,p_column_label=>unistr('Tipo Publica\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989447720003237099)
,p_db_column_name=>'TIPO_MODALIDADE'
,p_display_order=>240
,p_column_identifier=>'S'
,p_column_label=>'Modalidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50989448165235237100)
,p_db_column_name=>'VINCULO_REQ'
,p_display_order=>250
,p_column_identifier=>'T'
,p_column_label=>'Vinculo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52475955777883773912)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'709823'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('STATUS_REQ:COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:COD_LOCAL_TRAB:TIPO_PUBLICACAO:TIPO_MODALIDADE:VINCULO_REQ:')
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529306687141218672)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Relat\00F3rio com Quebras')
,p_report_seq=>10
,p_report_alias=>'709827'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
,p_break_on=>'EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:VINCULO:SELECIONADOR'
,p_break_enabled_on=>'SELECIONADOR'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529308753036266131)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Filial')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709831'
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
 p_id=>wwv_flow_api.id(52529309235967269347)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Empresa')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709835'
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
 p_id=>wwv_flow_api.id(52529309717157273046)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Centro de Custo')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709839'
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
 p_id=>wwv_flow_api.id(52529310960010304086)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Distribui\00E7\00E3o de Requisi\00E7\00F5es')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'709843'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(50989457638278237131)
,p_report_id=>wwv_flow_api.id(52529310960010304086)
,p_group_by_columns=>'EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:VINCULO:SELECIONADOR'
,p_function_01=>'COUNT'
,p_function_column_01=>'COD_REQUERIMENTO'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_format_mask_01=>'999G999G999G999G999G999G990'
,p_function_sum_01=>'Y'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529313184339362248)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade de Requisi\00E7\00F5es por EMP/FIL/CC')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'709851'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52529313654913362251)
,p_report_id=>wwv_flow_api.id(52529313184339362248)
,p_pivot_columns=>'FILIAL'
,p_row_columns=>'EMPRESA'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989458696098237136)
,p_pivot_id=>wwv_flow_api.id(52529313654913362251)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'CENTRO_CUSTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989459164108237138)
,p_pivot_id=>wwv_flow_api.id(52529313654913362251)
,p_display_seq=>2
,p_function_name=>'COUNT'
,p_column_name=>'VINCULO'
,p_db_column_name=>'PFC2'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529321222539529579)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Distribui\00E7\00E3o de Requisi\00E7\00F5es Filial e Cargo')
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'709866'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_group_by(
 p_id=>wwv_flow_api.id(50989459924357237140)
,p_report_id=>wwv_flow_api.id(52529321222539529579)
,p_group_by_columns=>'FILIAL:CARGO'
,p_function_01=>'COUNT'
,p_function_column_01=>'COD_REQUERIMENTO'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_format_mask_01=>'999G999G999G999G999G999G990'
,p_function_sum_01=>'Y'
,p_sort_column_01=>'FILIAL'
,p_sort_direction_01=>'ASC'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529322422622553978)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Filial e Cargo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'709874'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52529322798852553980)
,p_report_id=>wwv_flow_api.id(52529322422622553978)
,p_pivot_columns=>'FILIAL'
,p_row_columns=>'CARGO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989461035295237143)
,p_pivot_id=>wwv_flow_api.id(52529322798852553980)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529324081434560757)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Vinculo e Cargo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'709885'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52529324552897560759)
,p_report_id=>wwv_flow_api.id(52529324081434560757)
,p_pivot_columns=>'VINCULO'
,p_row_columns=>'CARGO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989462160227237146)
,p_pivot_id=>wwv_flow_api.id(52529324552897560759)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529325670495565536)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Selecionador e Cargo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'709896'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52529326116881565539)
,p_report_id=>wwv_flow_api.id(52529325670495565536)
,p_pivot_columns=>'SELECIONADOR'
,p_row_columns=>'CARGO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989463274499237150)
,p_pivot_id=>wwv_flow_api.id(52529326116881565539)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529327360887569948)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade Requisi\00E7\00F5es por Selecionador e Vinculo')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'709907'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O:')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52529327723247569948)
,p_report_id=>wwv_flow_api.id(52529327360887569948)
,p_pivot_columns=>'SELECIONADOR'
,p_row_columns=>'VINCULO'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989464325834237154)
,p_pivot_id=>wwv_flow_api.id(52529327723247569948)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52529329122198581231)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Selecionador')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709918'
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
 p_id=>wwv_flow_api.id(52529329587109586767)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Cargo')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709922'
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
 p_id=>wwv_flow_api.id(52529330068881597058)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico por Situa\00E7\00E3o da Vaga')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709926'
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
 p_id=>wwv_flow_api.id(52564047778747246600)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Gr\00E1fico Local de Trabalho')
,p_report_seq=>10
,p_report_type=>'CHART'
,p_report_alias=>'709930'
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
 p_id=>wwv_flow_api.id(52564049331591276196)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Quantidade de Requisi\00E7\00F5es Empresa/Filial/Local de Trabalho')
,p_report_seq=>10
,p_report_type=>'PIVOT'
,p_report_alias=>'709934'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_REQUERIMENTO:EMPRESA:FILIAL:CENTRO_CUSTO:CARGO:UNIDADE_ADM:VINCULO:SELECIONADOR:FASE_PROCESSO:QUANTIDADE_CANDIDATOS:STATUS_REQ:PRAZO_INICIAL:PRAZO_CONTRATA\00C7\00C3O::ESCONDE:COD_LOCAL_TRAB')
);
wwv_flow_api.create_worksheet_pivot(
 p_id=>wwv_flow_api.id(52564049745644276199)
,p_report_id=>wwv_flow_api.id(52564049331591276196)
,p_pivot_columns=>'COD_LOCAL_TRAB'
,p_row_columns=>'EMPRESA:FILIAL'
);
wwv_flow_api.create_worksheet_pivot_agg(
 p_id=>wwv_flow_api.id(50989466994923237160)
,p_pivot_id=>wwv_flow_api.id(52564049745644276199)
,p_display_seq=>1
,p_function_name=>'COUNT'
,p_column_name=>'COD_REQUERIMENTO'
,p_db_column_name=>'PFC1'
,p_format_mask=>'999G999G999G999G990'
,p_display_sum=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52503693247852164100)
,p_plug_name=>'DADOS PESSOAIS'
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951031360956200633)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PESS.rowid,',
'       Initcap(PESS.NOME) nome,',
'       Initcap(PESS.NOME_SOCIAL) nome_social,',
'       PESS.COD_CANDIDATO,',
'       cand.COD_FASE||'' - ''||(SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = cand.cod_fase) COD_FASE,',
'       CAND.DATE_FASE,',
'      ( SELECT P.cod_prest_serv||'' - ''||P.nome||'' [''||NVL(TO_CHAR(P.mat_prestador),''-'')||'']'' det',
'          FROM prestador_servico p ',
'         WHERE P.cod_prest_serv = COD_PREST_SERV_AVALIADOR FETCH FIRST 1 ROWS ONLY) COD_PREST_SERV_AVALIADOR,',
'       CAND.USUARIO,',
'       CAND.DT_ATUALIZACAO,',
'       (SELECT af.cod_aval_fase||'' - ''||af.desc_aval_fase det',
'          FROM avaliacao_fase af where af.cod_aval_fase = cand.cod_aval_fase)   COD_AVAL_FASE,',
'       CAND.DATA_AVAL_FASE,',
'       IND_AVAL_FASE,',
'       MOT_AVAL_FASE,',
'       RESULTADO_FASE,',
'       CAND.COD_REQ,',
'       CAND.COD_PROCESSO,',
'       CAND.COD_VAGA,',
'       CAND.COD_EMPRESA COD_EMP_CAND,',
'       CASE WHEN PESS.IND_DEF_FIS = ''S'' THEN --fas fa-wheelchair',
'         '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' end PCD,       ',
unistr('       case when CHECK_APROV =''S'' THEN ''Sim'' else ''N\00E3o'' end CHECK_APROV,'),
'       CASE WHEN :P_BASE in (''STEFANINI'') THEN ',
'        apex_page.get_url (',
'         p_application => ''CONHECENDO_VOCE_''||:P_BASE,',
'         p_page        => 1,',
'         p_items       => ''P_USUARIO,P_EMPRESA,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_EMP,P_MAT,P_VAGA,P_FILIAL_VAGA,P_EMPRESA_VAGA,P_DT_CONTRATACAO'',',
'         p_values      => :P_USUARIO||'',''||cand.COD_EMPRESA||'',''||cand.COD_CANDIDATO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||NULL||'',''||NULL||'',''||NULL||'',''||NULL||'',''||NULL||'',''||NULL',
'		 )',
'       else ',
'        apex_page.get_url (',
'         p_application => ''CV_''||:P_BASE,',
'         p_page        => 1,',
'         p_items       => ''P_USUARIO,P_EMPRESA,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_EMP,P_MAT,P_VAGA,P_FILIAL_VAGA,P_EMPRESA_VAGA,P_DT_CONTRATACAO'',',
'         p_values      => :P_USUARIO||'',''||cand.COD_EMPRESA||'',''||cand.COD_CANDIDATO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||NULL||'',''||NULL||'',''||NULL||'',''||NULL||'',''||NULL||'',''||NULL',
'		 )',
'        end  link_CV,',
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
'   , INITCAP(NVL((SELECT EMP.CARGO FROM empregos_anteriores EMP',
'                   WHERE EMP.COD_CANDIDATO = FUNC.COD_CANDIDATO',
unistr('                     AND DATA_DESL_EMP = (SELECT MAX(DATA_DESL_EMP) FROM empregos_anteriores EMP2 WHERE EMP2.COD_CANDIDATO = EMP.COD_CANDIDATO)),''N\00C3O INFORMADO'')) ULTIMO_CARGO  '),
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
'       SUBSTR(LPAD(pess.NUM_CPF,9,0),1,3)||''.''||',
'       SUBSTR(LPAD(pess.NUM_CPF,9,0),4,3)||''.''||',
'       SUBSTR(LPAD(pess.NUM_CPF,9,0),7,3)||''-''||',
'       LPAD(pess.DC_CPF,2,0) ',
'       CPF',
' FROM CANDIDATO CAND',
'    , INF_FUNC_CANDIDATO FUNC',
'    , INF_PESSOAIS_CANDIDATO PESS',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND CAND.COD_REQ       = :P32_COD_REQUISICAO',
'  and CAND.COD_CANDIDATO = :P32_COD_CANDIDATO',
'  AND COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'    --                 AND CAND2.COD_EMPRESA = CAND.COD_EMPRESA',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P32_COD_CANDIDATO,P32_COD_REQUISICAO'
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
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(52503693342970164101)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'DANIEL.TASSO'
,p_internal_uid=>1191634688533660710
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503693645689164104)
,p_db_column_name=>'NOME'
,p_display_order=>30
,p_column_identifier=>'A'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503693753398164105)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>40
,p_column_identifier=>'B'
,p_column_label=>unistr('C\00F3d. Candidato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503693777094164106)
,p_db_column_name=>'COD_FASE'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>'Cod Fase'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503693902831164107)
,p_db_column_name=>'DATE_FASE'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Date Fase'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503693986556164108)
,p_db_column_name=>'COD_PREST_SERV_AVALIADOR'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'Cod Prest Serv Avaliador'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694086245164109)
,p_db_column_name=>'USUARIO'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694188319164110)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'Dt Atualizacao'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694322225164111)
,p_db_column_name=>'COD_AVAL_FASE'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Cod Aval Fase'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694438570164112)
,p_db_column_name=>'DATA_AVAL_FASE'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Data Aval Fase'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694549575164113)
,p_db_column_name=>'IND_AVAL_FASE'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Ind Aval Fase'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694634487164114)
,p_db_column_name=>'MOT_AVAL_FASE'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Mot Aval Fase'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694745559164115)
,p_db_column_name=>'RESULTADO_FASE'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Resultado Fase'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694788652164116)
,p_db_column_name=>'COD_REQ'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>'Cod Req'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694938762164117)
,p_db_column_name=>'COD_PROCESSO'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>'Cod Processo'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503694956257164118)
,p_db_column_name=>'COD_VAGA'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>'Cod Vaga'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695105125164119)
,p_db_column_name=>'COD_EMP_CAND'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>'Cod Emp Cand'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695227228164120)
,p_db_column_name=>'PCD'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Pcd'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695255918164121)
,p_db_column_name=>'CHECK_APROV'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>'Check Aprov'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695444819164122)
,p_db_column_name=>'LINK_CV'
,p_display_order=>210
,p_column_identifier=>'S'
,p_column_label=>'Link Cv'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695498759164123)
,p_db_column_name=>'EMAIL'
,p_display_order=>220
,p_column_identifier=>'T'
,p_column_label=>'Email'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695623862164124)
,p_db_column_name=>'DATA_NASCIMENTO'
,p_display_order=>230
,p_column_identifier=>'U'
,p_column_label=>'Data Nascimento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695683953164125)
,p_db_column_name=>'IDADE'
,p_display_order=>240
,p_column_identifier=>'V'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695817810164126)
,p_db_column_name=>'E_MAIL'
,p_display_order=>250
,p_column_identifier=>'W'
,p_column_label=>'E-Mail'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503695905901164127)
,p_db_column_name=>'SEXO'
,p_display_order=>260
,p_column_identifier=>'X'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503696020383164128)
,p_db_column_name=>'POSSUI_DEPENDENTE'
,p_display_order=>270
,p_column_identifier=>'Y'
,p_column_label=>'Possui Dependente'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503696088751164129)
,p_db_column_name=>'ULTIMO_CARGO'
,p_display_order=>280
,p_column_identifier=>'Z'
,p_column_label=>unistr('\00DAltimo Cargo')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(52503696156800164130)
,p_db_column_name=>'GRAU_INSTRUCAO'
,p_display_order=>290
,p_column_identifier=>'AA'
,p_column_label=>unistr('Grau Instru\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058340987729539464)
,p_db_column_name=>'ROWID'
,p_display_order=>300
,p_column_identifier=>'AB'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(51058399609965981969)
,p_db_column_name=>'CPF'
,p_display_order=>310
,p_column_identifier=>'AC'
,p_column_label=>'CPF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(53595331964368975022)
,p_db_column_name=>'NOME_SOCIAL'
,p_display_order=>320
,p_column_identifier=>'AD'
,p_column_label=>'Nome Social'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(50770439061973498546)
,p_db_column_name=>'GENERO'
,p_display_order=>330
,p_column_identifier=>'AE'
,p_column_label=>unistr('G\00EAnero')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(52503718612487444338)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'REPORT'
,p_report_alias=>'11916600'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'COD_CANDIDATO:NOME:NOME_SOCIAL:DATA_NASCIMENTO:IDADE:CPF:E_MAIL:SEXO:GENERO:POSSUI_DEPENDENTE:ULTIMO_CARGO:GRAU_INSTRUCAO:'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(53595333440976975037)
,p_name=>unistr('ANOTA\00C7\00D5ES')
,p_parent_plug_id=>wwv_flow_api.id(52503693090143164099)
,p_template=>wwv_flow_api.id(72951031880997200635)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Comments--basic'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.id_anotacao ID,',
'       l.dt_anotacao as COMMENT_DATE,',
'       l.usuario as USER_NAME,',
'       --t.CREATED as TASK_CREATED,',
'       ''<h4><b>''||l.titulo||''</b></h4>''||chr(10)||l.observacao COMMENT_TEXT,',
'       l.titulo as ACTIONS,',
'       null as ATTRIBUTE_1,',
'       null as ATTRIBUTE_2,',
'       null as ATTRIBUTE_3,',
'       null as ATTRIBUTE_4,',
unistr('      ''<span aria-hidden="true" class="fa fa-headset fa-2x"></span>''/*apex_string.get_initials(p.nome)*/ user_icon, -- \00EDcone do coment\00E1rio'),
unistr('      ''colorBlue'' icon_modifier -- cor do coment\00E1rio'),
'  from CANDIDATO_ANOTACOES L',
' where COD_CANDIDATO = :P32_COD_CANDIDATO',
'   and COD_PS = :P32_COD_REQUISICAO',
'order by 1 desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P32_COD_CANDIDATO,P32_COD_REQUISICAO'
,p_query_row_template=>wwv_flow_api.id(72951040160196200650)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>unistr('Nenhuma Anota\00E7\00E3o Cadastrada')
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988517185054691795)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>8
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988517238359691796)
,p_query_column_id=>2
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>9
,p_column_heading=>'Comment Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988517403127691797)
,p_query_column_id=>3
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988517452894691798)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>11
,p_column_heading=>'Comment Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988517082037691794)
,p_query_column_id=>5
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>7
,p_column_heading=>'Actions'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333615786975038)
,p_query_column_id=>6
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>1
,p_column_heading=>'Attribute 1'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333700218975039)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>2
,p_column_heading=>'Attribute 2'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333796550975040)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>3
,p_column_heading=>'Attribute 3'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(53595333893161975041)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>4
,p_column_heading=>'Attribute 4'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988516905997691792)
,p_query_column_id=>10
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>5
,p_column_heading=>'User Icon'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(50988517000777691793)
,p_query_column_id=>11
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>6
,p_column_heading=>'Icon Modifier'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52404971960844151737)
,p_button_sequence=>15
,p_button_plug_id=>wwv_flow_api.id(52404970486637151722)
,p_button_name=>'BTN_REPROVAR_INDICACAO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>unistr('Reprovar Indica\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'FROM requisicao',
'where COD_REQ = :P32_COD_REQUISICAO',
'and CONFIRMA_INDICACAO_CAND is null;'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-thumbs-o-up'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52404971630992151733)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(52404970486637151722)
,p_button_name=>'BTN_APROVACAO_INDICACAO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>unistr('Aprovar Indica\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'FROM requisicao',
'where COD_REQ = :P32_COD_REQUISICAO',
'and CONFIRMA_INDICACAO_CAND is null;'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-thumbs-o-up'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52258322699406352525)
,p_button_sequence=>230
,p_button_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_button_name=>'BTN_MUDA_FASE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BODY'
,p_button_condition=>'P32_SIT_REQUISICAO'
,p_button_condition2=>'2'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
,p_grid_column_span=>4
,p_grid_column=>5
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50988517620842691799)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(53595333440976975037)
,p_button_name=>'ADD_ANOTACAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:37:&SESSION.::&DEBUG.:RP,37:P37_COD_CANDIDATO,P37_COD_PS:&P32_COD_CANDIDATO.,&P32_COD_REQUISICAO.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50623940548804250348)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_button_name=>'BTN_EXCLUIR_APROVACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--gapLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>unistr('Remover Aprova\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 ',
'  FROM CANDIDATO_APROVADO CA ',
' WHERE CA.COD_CANDIDATO = :P32_COD_CANDIDATO ',
'   AND CA.COD_SOLICITACAO = :P32_COD_REQUISICAO',
'   AND NOT EXISTS (SELECT 1',
'                     FROM INF_PESSOAIS_CAD P, INFORMACOES_FUNCIONAIS I',
'                    WHERE P.COD_EMPRESA = I.COD_EMPRESA',
'                      AND P.MATRICULA = I.MATRICULA',
'                      AND P.COD_CANDIDATO = CA.COD_CANDIDATO',
'                      AND I.SITUACAO < ''90'')'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50623940772798250350)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_button_name=>'BTN_APROVACAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>'Aprovar Candidato'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_COD_CANDIDATO,P3_COD_EMPRESA,P3_COD_VAGA,P3_COD_SOLICITACAO,P3_COD_FILIAL,P3_COD_REQ,P3_COD_SIT_REQ,P3_TIPO_PARTICIPANTE:&P32_COD_CANDIDATO.,&P32_COD_EMPRESA.,&P32_COD_REQUISICAO.,&P32_COD_REQUISICAO.,&P32_FILIAL.,&P32_COD_REQUISICAO.,&P32_SIT_REQUISICAO.,&P32_TIPO_PARTICIPANTE.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-check'
,p_button_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Comentado server-side condition para substituir por NEVER',
'declare',
'',
'cursor c1 is',
'SELECT ''S'' existe FROM CANDIDATO_APROVADO WHERE COD_SOLICITACAO = :P32_COD_REQUISICAO;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'SELECT DISTINCT faca.cod_fase',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO',
'and faca.cod_fase >= (SELECT MAX(COD_FASE)',
'        FROM CANDIDATO cand2 ',
'       WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO',
'         AND CAND2.COD_REQ = :P32_COD_REQUISICAO);',
'',
'V_C2 C2%ROWTYPE;',
'',
'',
'cursor c3 is ',
'select ''S'' final',
'from  CANDIDATO cand2 ',
'WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO ',
'AND CAND2.COD_REQ = :P32_COD_REQUISICAO',
'and cand2.COD_FASE = (SELECT max(faca.cod_fase)',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO)',
'and IND_AVAL_FASE is not null;',
'',
'V_C3 C3%ROWTYPE;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'open c3;',
'fetch c3 into v_c3;',
'close c3;',
'',
'    if nvl(v_c1.existe,''N'') = ''S'' then ',
'        return false;',
'    elsif nvl(v_c3.final,''N'') = ''S'' then ',
'        return true;		',
'    elsif v_c2.cod_fase is not null and nvl(v_c1.existe,''N'') = ''N'' then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'',
'end;'))
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(15442481007269641320)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_button_name=>'BTN_APROVACAO_NEW'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>'Aprovar Candidato'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'SELECT ''S'' existe FROM CANDIDATO_APROVADO WHERE COD_SOLICITACAO = :P32_COD_REQUISICAO;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'SELECT DISTINCT faca.cod_fase',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO',
'and faca.cod_fase >= (SELECT MAX(COD_FASE)',
'        FROM CANDIDATO cand2 ',
'       WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO',
'         AND CAND2.COD_REQ = :P32_COD_REQUISICAO);',
'',
'V_C2 C2%ROWTYPE;',
'',
'',
'cursor c3 is ',
'select ''S'' final',
'from  CANDIDATO cand2 ',
'WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO ',
'AND CAND2.COD_REQ = :P32_COD_REQUISICAO',
'and cand2.COD_FASE = (SELECT max(faca.cod_fase)',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO)',
'and IND_AVAL_FASE is not null;',
'',
'V_C3 C3%ROWTYPE;',
'',
'begin',
'if :P32_RESTRICAO_ADMISSAO = ''S'' then',
'  return false;',
'else',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'open c3;',
'fetch c3 into v_c3;',
'close c3;',
'',
'    if nvl(v_c1.existe,''N'') = ''S'' then ',
'        return false;',
'    elsif nvl(v_c3.final,''N'') = ''S'' then ',
'        return true;		',
'    elsif v_c2.cod_fase is not null and nvl(v_c1.existe,''N'') = ''N'' then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'end if;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50988468133809493257)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_button_name=>'EXCLUIR_CANDIDATO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--gapLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>'Excluir Candidato'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_QTD_FASE NUMBER := 0;',
'begin',
'SELECT count(1)',
'INTO V_QTD_FASE',
'FROM CANDIDATO',
'WHERE COD_CANDIDATO = :P32_COD_CANDIDATO ',
'AND COD_REQ = :P32_COD_REQUISICAO',
'and COD_EMPRESA = :P32_COD_EMPRESA;',
'',
'IF V_QTD_FASE = 1 THEN ',
'RETURN TRUE;',
'END IF;',
'',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(51058339650439539451)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_button_name=>'BTN_FASE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Avaliar Fase'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'SELECT ''S'' existe FROM CANDIDATO_APROVADO WHERE COD_SOLICITACAO = :P32_COD_REQUISICAO;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'SELECT DISTINCT faca.cod_fase',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO',
'and faca.cod_fase >= (SELECT MAX(COD_FASE)',
'        FROM CANDIDATO cand2 ',
'       WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO',
'         AND CAND2.COD_REQ = :P32_COD_REQUISICAO);',
'',
'V_C2 C2%ROWTYPE;',
'',
'',
'cursor c3 is ',
'select ''S'' final',
'from  CANDIDATO cand2 ',
'WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO ',
'AND CAND2.COD_REQ = :P32_COD_REQUISICAO',
'and cand2.COD_FASE = (SELECT max(faca.cod_fase)',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO)',
'and IND_AVAL_FASE is not null;',
'',
'V_C3 C3%ROWTYPE;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'open c3;',
'fetch c3 into v_c3;',
'close c3;',
'',
'    if nvl(v_c1.existe,''N'') = ''S'' then ',
'        return false;',
'    elsif nvl(v_c3.final,''N'') = ''S'' then ',
'        return false;		',
'    elsif v_c2.cod_fase is not null and nvl(v_c1.existe,''N'') = ''N'' then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-arrow-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52302811482155936014)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_button_name=>'BTN_CV'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar CV'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:39:&SESSION.::&DEBUG.:RP,39:P39_COD_EMPRESA,P39_COD_CANDIDATO:&P32_COD_EMPRESA.,&P32_COD_CANDIDATO.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52258322404478352522)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52237932853178224111)
,p_button_name=>'BTN_NEXT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--link:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Pr\00F3xima Pessoa')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:RP:P32_COD_EMPRESA,P32_COD_REQUISICAO,P32_COD_CANDIDATO:&P32_COD_EMPRESA.,&P32_COD_REQUISICAO.,&P32_NEXT.'
,p_button_condition=>'P32_NEXT'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52364564644722580302)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52258321842667352516)
,p_button_name=>'BTN_VOLTAR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:RP:P29_EMP_ID,P29_REQUISICAO:&P32_COD_EMPRESA.,&P32_COD_REQUISICAO.'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52258322473064352523)
,p_button_sequence=>5
,p_button_plug_id=>wwv_flow_api.id(52237932853178224111)
,p_button_name=>'BTN_PREVIOUS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pessoa Anterior'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:RP:P32_COD_EMPRESA,P32_COD_REQUISICAO,P32_COD_CANDIDATO:&P32_COD_EMPRESA.,&P32_COD_REQUISICAO.,&P32_PREV.'
,p_button_condition=>'P32_PREV'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(15440094999101179228)
,p_branch_name=>'Goto 3'
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_COD_EMPRESA,P3_COD_CANDIDATO,P3_COD_VAGA,P3_COD_SOLICITACAO,P3_COD_FILIAL,P3_COD_REQ,P3_COD_SIT_REQ:&P32_COD_EMPRESA.,&P32_COD_CANDIDATO.,&P32_COD_REQUISICAO.,&P32_COD_REQUISICAO.,&P32_FILIAL.,&P32_COD_REQUISICAO.,&P32_SIT_REQUISICAO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'APROVADO'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(50396162066395188912)
,p_branch_name=>'EXCLUIR_CANDIDATO'
,p_branch_action=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:RP,29:P29_EMP_ID,P29_REQUISICAO:&P32_COD_EMPRESA.,&P32_COD_REQ.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'EXCLUIR_CANDIDATO'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(50396162202669188913)
,p_branch_name=>'PROCESSO'
,p_branch_action=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:RP,32:P32_COD_EMPRESA,P32_COD_CANDIDATO,P32_COD_REQUISICAO:&P32_COD_EMPRESA.,&P32_COD_CANDIDATO.,&P32_COD_REQUISICAO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>30
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6415312523921367780)
,p_name=>'P32_RESTRICAO_ADMISSAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52258321842667352516)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(47032942910737612735)
,p_name=>'P32_ATUALIZA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50449582597800990112)
,p_name=>'P32_COD_FASE_HIDDEN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623941629349250359)
,p_name=>'P32_COD_EMPRESA_1'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_EMPRESA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623941733555250360)
,p_name=>'P32_COD_CANDIDATO_1'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_CANDIDATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623941867739250361)
,p_name=>'P32_COD_FASE'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_prompt=>'Fase Atual'
,p_source=>'COD_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT f.cod_fase||'' - ''||f.desc_fase d, f.cod_fase FROM fase_candidato f'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623941922314250362)
,p_name=>'P32_DATE_FASE'
,p_source_data_type=>'DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'DATE_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623941987815250363)
,p_name=>'P32_COD_PREST_SERV_AVALIADOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_prompt=>'Avaliador'
,p_source=>'COD_PREST_SERV_AVALIADOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
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
,p_cSize=>30
,p_cMaxlength=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942142572250364)
,p_name=>'P32_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942234339250365)
,p_name=>'P32_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942294565250366)
,p_name=>'P32_COD_AVAL_FASE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_prompt=>unistr('Avalia\00E7\00E3o da Fase')
,p_source=>'COD_AVAL_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>unistr('LOV_MOTIVO_AVALIA\00C7\00C3O')
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT af.cod_aval_fase||'' - ''||af.desc_aval_fase det',
'      ,af.cod_aval_fase                           ret',
'  FROM avaliacao_fase af'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_cMaxlength=>3
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942432247250367)
,p_name=>'P32_DATA_AVAL_FASE'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'DATA_AVAL_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942578938250368)
,p_name=>'P32_IND_AVAL_FASE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_prompt=>'Nota da Fase'
,p_source=>'IND_AVAL_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(72951052414256200673)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942613042250369)
,p_name=>'P32_MOT_AVAL_FASE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'MOT_AVAL_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50623942733971250370)
,p_name=>'P32_RESULTADO_FASE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'RESULTADO_FASE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50625187115427440621)
,p_name=>'P32_COD_REQ'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50625187255131440622)
,p_name=>'P32_COD_PROCESSO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_PROCESSO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50625187373584440623)
,p_name=>'P32_COD_VAGA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_VAGA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50625187397806440624)
,p_name=>'P32_COD_EMP_CAND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'COD_EMP_CAND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50625187556819440625)
,p_name=>'P32_CHECK_APROV'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_item_source_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_source=>'CHECK_APROV'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50919996152367156755)
,p_name=>'P32_NOTA_MINIMA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_prompt=>unistr('Nota M\00EDnima')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_tag_attributes=>'readonly'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988469113961493267)
,p_name=>'P32_COD_EMP_MATRICULA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988469265810493268)
,p_name=>'P32_MATRICULA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988469469828493270)
,p_name=>'P32_TIPO_PARTICIPANTE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988563874007049579)
,p_name=>'P32_PONTUACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_prompt=>unistr('Pontua\00E7\00E3o')
,p_display_as=>'NATIVE_STAR_RATING'
,p_read_only_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--xlarge:margin-bottom-lg'
,p_attribute_01=>'5'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50989312056843858374)
,p_name=>'P32_CANDIDATO_APROVADO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52258321842667352516)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52237932555366224109)
,p_name=>'P32_NOME_CANDIDATO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52258321842667352516)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258321373528352512)
,p_name=>'P32_COD_EMPRESA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258321514907352513)
,p_name=>'P32_COD_REQUISICAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258321630183352514)
,p_name=>'P32_COD_CANDIDATO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258321678393352515)
,p_name=>'P32_FOTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_prompt=>'Imagem'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(f.foto)',
'                 from inf_pessoais_candidato f, permissao_pess_cand u',
'                where cod_candidato = :P32_COD_CANDIDATO',
'                  and u.id_usuario = :P_USUARIO',
'                  and u.foto = ''S''), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_CAND:'' || :DEBUG ||',
'               ''&x01='' || :P32_COD_CANDIDATO',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_css_classes=>'fotoColabMed'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258322875472352527)
,p_name=>'P32_FASE_NEW'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nova Fase'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT faca.cod_fase||'' - ''||faca.desc_fase det',
'                ,faca.cod_fase                     ret',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO',
'and faca.cod_fase > (SELECT MAX(COD_FASE)',
'        FROM CANDIDATO cand2 ',
'       WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO',
'         AND CAND2.COD_REQ = :P32_COD_REQUISICAO)',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT 1',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO',
'and faca.cod_fase > (SELECT MAX(COD_FASE)',
'        FROM CANDIDATO cand2 ',
'       WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO',
'         AND CAND2.COD_REQ = :P32_COD_REQUISICAO)'))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258323523420352533)
,p_name=>'P32_PREV'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52258323630950352534)
,p_name=>'P32_NEXT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52282533271438829495)
,p_name=>'P32_ERR_MSG'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52302811757679936017)
,p_name=>'P32_URL_PAG_CV'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52302812125661936020)
,p_name=>'P32_TEMPLATE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(52258322598023352524)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Template E-mail'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DESCRICAO,',
'       cod',
'  from RS_TEMPLATE_EMAIL',
'  where ATIVO = ''S''',
'order by cod'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52404970582034151723)
,p_name=>'P32_INDICADO_POR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52404970486637151722)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Indicado por:'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.cod_prest_serv||'' - ''||p.nome||'' [''||NVL(TO_CHAR(p.mat_prestador),''-'')||'']'' det',
'      ,p.cod_prest_serv                                                              ret',
'  FROM prestador_servico p ',
' WHERE p.tipo_prest_serv = ''5'' ',
'UNION',
'SELECT p.cod_prest_serv||'' - ''||p.nome||'' [''||NVL(TO_CHAR(p.mat_prestador),''-'')||'']'' det',
'      ,p.cod_prest_serv                                                ',
'  FROM prestador_servico p ',
' WHERE p.tipo_prest_serv = ''5'' ',
'   AND p.USUARIO   = :P_USUARIO',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>105
,p_begin_on_new_line=>'N'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52404971449489151731)
,p_name=>'P32_OBSERVACAO_INDICACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(52404970486637151722)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o Indica\00E7\00E3o')
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
 p_id=>wwv_flow_api.id(52404971762170151735)
,p_name=>'P32_DESC_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52258321842667352516)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439139794388755334)
,p_name=>'P32_FILIAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439140094075755337)
,p_name=>'P32_SIT_REQUISICAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52252290543288543293)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(42491935338117147810)
,p_validation_name=>'Novo'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_fase is ',
'SELECT count(1) qtd',
'FROM fase_candidato FACA',
', PS_PROCESSO_FASE PRFA',
', ps_processo_seletivo PRSE',
', candidato c',
'WHERE PRFA.cod_fase = FACA.cod_fase (+)',
'AND faca.cod_fase = c.cod_fase (+)',
'AND PRSE.cod_processo = PRFA.cod_processo',
'AND PRSE.cod_req = c.cod_req (+)',
'and PRSE.cod_req = :P32_COD_REQUISICAO',
'and faca.cod_fase > (SELECT MAX(COD_FASE)',
'        FROM CANDIDATO cand2 ',
'       WHERE CAND2.COD_CANDIDATO = :P32_COD_CANDIDATO',
'         AND CAND2.COD_REQ = :P32_COD_REQUISICAO);',
'',
'v_fase c_fase%rowtype;',
'',
'begin',
'',
'open c_fase;',
'fetch c_fase into v_fase;',
'close c_fase;',
'',
'  if v_fase.qtd > 0 then ',
'        IF :P32_CHECK_APROV = ''S'' AND :P32_FASE_NEW IS NULL THEN ',
unistr('          return ''Favor informar a pr\00F3xima fase do Candidato.'';'),
'        end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52282533089031829493)
,p_name=>'VALIDA_NOTA'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_NOTA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52282533231540829494)
,p_event_id=>wwv_flow_api.id(52282533089031829493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_NOTA NUMBER := :P32_NOTA;',
'V_NOTA_MIN NUMBER := :P32_NOTA_MINIMA;',
'',
'BEGIN',
'  :P32_ERR_MSG := NULL;',
'  --',
'  /*',
'  IF pkg_Selecao.fnc_VerifNotNtCortExclProxFase(pCodProcesso  => :P32_COD_REQUISICAO',
'                                               ,pCodEmpresa   => :P32_COD_EMPRESA',
'                                               ,pCodFase      => :P32_FASE_NEW',
'                                               ,pCodCandidato => :P32_COD_REQUISICAO',
'                                               ,pNota         => :P32_NOTA) = 1 THEN',
'     ',
'     :P32_CHECK_APROV := ''N'';',
unistr('     :P32_ERR_MSG := ''Nota informada \00E9 menor que NOTA DE CORTE!<br>Se confirmar, as avalia\00E7\00F5es das fases posteriores ser\00E3o <strong>EXCLU\00CDDAS</strong>.'';'),
'  ELSE',
'     :P32_CHECK_APROV := ''S'';',
'  END IF;     ',
'  */',
'  if nvl(v_nota,0) < nvl(v_nota_min,0) then',
'  :P32_CHECK_APROV := ''N'';',
'  :P32_ERR_MSG := ''CANDIDATO REPROVADO NA FASE ATUAL!'';',
'  :P32_FASE_NEW := NULL;',
'  else',
'  :P32_CHECK_APROV := ''S'';',
'  :P32_ERR_MSG := NULL;',
'  :P32_FASE_NEW := NULL;',
'  end if;',
'  EXCEPTION WHEN OTHERS THEN NULL;',
'END;'))
,p_attribute_02=>'P32_COD_EMPRESA,P32_COD_REQUISICAO,P32_NOTA'
,p_attribute_03=>'P32_CHECK_APROV,P32_ERR_MSG,P32_FASE_NEW'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52302809858745935998)
,p_name=>'CONFIRMA MUDANCA DE FASE'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52258322699406352525)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52302810019660935999)
,p_event_id=>wwv_flow_api.id(52302809858745935998)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Deseja Salvar as Informa\00E7\00F5es?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52302810060878936000)
,p_event_id=>wwv_flow_api.id(52302809858745935998)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'MUDA_FASE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52302811560574936015)
,p_name=>'Visualiza_CV'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52302811482155936014)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52302811684405936016)
,p_event_id=>wwv_flow_api.id(52302811560574936015)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P32_URL_PAG_CV").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058339741276539452)
,p_name=>'Open Dialog Mudar Fase'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(51058339650439539451)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058339860088539453)
,p_event_id=>wwv_flow_api.id(51058339741276539452)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52258322598023352524)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(47018959207452049448)
,p_name=>'Open Dialog Mudar Fase_1'
,p_event_sequence=>60
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'AJUSTE_AVALIACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(47018959273323049449)
,p_event_id=>wwv_flow_api.id(47018959207452049448)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52258322598023352524)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988517655428691800)
,p_name=>'Dialog Closed - Anotacoes'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(50988517620842691799)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988517817717691801)
,p_event_id=>wwv_flow_api.id(50988517655428691800)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53595333440976975037)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988517837162691802)
,p_name=>'Dialog Closed - Anotacoes (Report)'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(53595333440976975037)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988518017695691803)
,p_event_id=>wwv_flow_api.id(50988517837162691802)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(53595333440976975037)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988468252640493258)
,p_name=>'EXCLUIR CANDIDATO'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(50988468133809493257)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988468351846493259)
,p_event_id=>wwv_flow_api.id(50988468252640493258)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'Deseja excluir o candidato deste processo seletivo?'
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988468445758493260)
,p_event_id=>wwv_flow_api.id(50988468252640493258)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'EXCLUIR_CANDIDATO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988468786838493264)
,p_name=>'EXCLUIR APROVACAO'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(50623940548804250348)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988468922372493265)
,p_event_id=>wwv_flow_api.id(50988468786838493264)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'Deseja remover o candidato como aprovado?'
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988469017753493266)
,p_event_id=>wwv_flow_api.id(50988468786838493264)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'EXCLUIR_APROVACAO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988469653254493272)
,p_name=>'Sit. Concluida'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_SIT_REQUISICAO'
,p_condition_element=>'P32_SIT_REQUISICAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988469761129493273)
,p_event_id=>wwv_flow_api.id(50988469653254493272)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52258322699406352525)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988469858630493274)
,p_event_id=>wwv_flow_api.id(50988469653254493272)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(50988468133809493257)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988470152090493277)
,p_event_id=>wwv_flow_api.id(50988469653254493272)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(50988468133809493257)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988470066519493276)
,p_event_id=>wwv_flow_api.id(50988469653254493272)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52258322699406352525)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988563879640049580)
,p_name=>'Update Pontuacao'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_PONTUACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988564066855049581)
,p_event_id=>wwv_flow_api.id(50988563879640049580)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'update candidato ',
'   set pontuacao = :p32_pontuacao',
' where cod_candidato = :p32_cod_candidato',
'   AND COD_PROCESSO  = :P32_COD_REQUISICAO;',
'',
'COMMIT;',
'',
'END;'))
,p_attribute_02=>'P32_COD_CANDIDATO,P32_COD_REQUISICAO,P32_PONTUACAO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50918384481368414705)
,p_name=>'Display Alert'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50920001351147251556)
,p_event_id=>wwv_flow_api.id(50918384481368414705)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P32_ERR_MSG").getValue().length > 0){',
'  alertify.alert(apex.item("P32_ERR_MSG").getValue());',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50920001483434251557)
,p_name=>'Check Aprov'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_CHECK_APROV'
,p_condition_element=>'P32_CHECK_APROV'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(42491935227054147809)
,p_event_id=>wwv_flow_api.id(50920001483434251557)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P32_FASE_NEW'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50920001582996251558)
,p_event_id=>wwv_flow_api.id(50920001483434251557)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P32_FASE_NEW'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50625188268970440632)
,p_name=>'Set Check Aprov_1'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P32_IND_AVAL_FASE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50625188482398440634)
,p_event_id=>wwv_flow_api.id(50625188268970440632)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_nota_min number := :p32_nota_minima;',
'  v_nota number := :p32_ind_aval_fase;',
'',
'begin',
'',
'  if nvl(v_nota,0) >= nvl(v_nota_min,0) then',
'  :p32_check_aprov := ''S'';',
' -- :p32_err_msg := ''Aprovado nesta fase!'';',
'  else',
'  :p32_check_aprov := ''N'';',
'--  :p32_err_msg := ''Reprovado nesta fase!'';',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P32_IND_AVAL_FASE,P32_NOTA_MINIMA'
,p_attribute_03=>'P32_CHECK_APROV,P32_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50625188813865440638)
,p_name=>'Close Dialog (Aprovacao)'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(50623940772798250350)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50625188896141440639)
,p_event_id=>wwv_flow_api.id(50625188813865440638)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(15442482027175641330)
,p_name=>'TESTE BOTAO APROVACAO'
,p_event_sequence=>168
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(15442481007269641320)
,p_condition_element=>'P32_SIT_REQUISICAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442482206515641332)
,p_event_id=>wwv_flow_api.id(15442482027175641330)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Essa requisi\00E7\00E3o encontra-se em processo de Revis\00E3o. Opera\00E7\00E3o n\00E3o permitida!')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442482086130641331)
,p_event_id=>wwv_flow_api.id(15442482027175641330)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//window.open(apex.item(''P32_URL_APROVAR_CANDIDATO'').getValue(),''_blank'');',
'//javascript:window.open(apex.item("P32_URL_APROVAR_CANDIDATO").getValue());',
'apex.submit(''APROVADO'');'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(15442481327293641323)
,p_name=>unistr('Chama tela de Aprova\00E7\00E3o Candidato')
,p_event_sequence=>169
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(15442481007269641320)
,p_condition_element=>'P32_SIT_REQUISICAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442481433519641324)
,p_event_id=>wwv_flow_api.id(15442481327293641323)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var url = ''f?p='' + ''&APP_ID.'' + '':'' + 3 + '':'' + ''&APP_SESSION.'' + ''::NO::'' +',
'          ''P3_COD_CANDIDATO,P3_COD_EMPRESA,P3_COD_VAGA,P3_TIPO_PARTICIPANTE'' + '':'' +',
'          $v(''P32_COD_CANDIDATO'') + '','' + $v(''P32_COD_EMPRESA'') + '','' + $v(''P32_COD_REQUISICAO'') + '','' + $v(''P32_TIPO_PARTICIPANTE'');',
'',
'apex.navigation.redirect(url);',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442481750588641328)
,p_event_id=>wwv_flow_api.id(15442481327293641323)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.alert("Teste envio mensagem.")'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442481905173641329)
,p_event_id=>wwv_flow_api.id(15442481327293641323)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(47032942959707612736)
,p_name=>unistr('Atualiza_Regi\00E3o')
,p_event_sequence=>180
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(50988560764855049548)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(47032943934361612746)
,p_event_id=>wwv_flow_api.id(47032942959707612736)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(50988560764855049548)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16430896303253107113)
,p_name=>'Refresh Close Dialog'
,p_event_sequence=>190
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16430896423408107114)
,p_event_id=>wwv_flow_api.id(16430896303253107113)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(15442480079067641311)
,p_name=>unistr('Desabilitar bot\00E3o Aprovar Candidato')
,p_event_sequence=>200
,p_condition_element=>'P32_SIT_REQUISICAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442480158415641312)
,p_event_id=>wwv_flow_api.id(15442480079067641311)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(50623940772798250350)
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15442480285974641313)
,p_event_id=>wwv_flow_api.id(15442480079067641311)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(50623940772798250350)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50625188551946440635)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT/UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P32_USUARIO := :P_USUARIO;',
':P32_DT_ATUALIZACAO := SYSDATE;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'APROVADO'
,p_process_when_type=>'REQUEST_NOT_EQUAL_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52258324158322352540)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'MUDA_FASE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'',
'UPDATE CANDIDATO',
'   SET CHECK_APROV = :p32_check_aprov,',
'       cod_prest_serv_avaliador = :p32_cod_prest_serv_avaliador,',
'       usuario = :p_usuario,',
'       dt_atualizacao = sysdate,',
'       resultado_fase = :p32_resultado_fase,',
'       ind_aval_fase = :p32_ind_aval_fase,',
'       cod_aval_fase = :p32_cod_aval_fase',
' WHERE COD_CANDIDATO = :P32_COD_CANDIDATO',
'   AND COD_REQ = :P32_COD_REQUISICAO',
'   AND COD_FASE = :p32_cod_fase_hidden;',
'   ',
'COMMIT;',
'',
'',
'if :P32_FASE_NEW is not null then',
'Insert into CANDIDATO (COD_EMPRESA',
'                   ,   COD_CANDIDATO',
'                   ,   COD_FASE',
'                   ,   DATE_FASE',
'                   ,   COD_PREST_SERV_AVALIADOR',
'                   ,   USUARIO',
'                   ,   DT_ATUALIZACAO',
'                   ,   COD_AVAL_FASE',
'                   ,   DATA_AVAL_FASE',
'                   ,   IND_AVAL_FASE',
'                   ,   MOT_AVAL_FASE',
'                   ,   RESULTADO_FASE',
'                   ,   COD_REQ',
'                   ,   COD_PROCESSO',
'                   ,   COD_VAGA',
'                   ,   COD_EMP_CAND',
'                   ,   CHECK_APROV',
'                   ,   PONTUACAO)',
'      values (:P32_COD_EMPRESA --COD_EMPRESA',
'           ,  :P32_COD_CANDIDATO  --COD_CANDIDATO',
'           ,  :P32_FASE_NEW   --COD_FASE',
'           ,  TRUNC(SYSDATE)  --DATE_FASE',
'           ,  null--:P32_SELECIONADOR--COD_PREST_SERV_AVALIADOR',
'           ,  :P_USUARIO --USUARIO',
'           ,  TRUNC(SYSDATE)  --DT_ATUALIZACAO',
'           ,  null--:P32_AVALIACAO  --COD_AVAL_FASE',
'           ,  TRUNC(SYSDATE)--DATA_AVAL_FASE',
'           ,  null--:P32_NOTA--IND_AVAL_FASE',
'           ,  null --MOT_AVAL_FASE',
'           ,  null--:P32_OBSERVACAO--RESULTADO_FASE',
'           ,  :P32_COD_REQUISICAO--COD_REQ',
'           ,  :P32_COD_REQUISICAO--COD_PROCESSO',
'           ,  NULL--COD_VAGA',
'           ,  :P32_COD_EMPRESA--COD_EMP_CAND',
'           ,  null--:P32_CHECK_APROV',
'           ,  :P32_PONTUACAO);',
'		   ',
'  COMMIt;',
' end if;',
'end;',
''))
,p_process_error_message=>'Erro - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52258322699406352525)
,p_process_success_message=>'Dados alterados com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52302809777958935997)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'APROVAR_CANDIDATO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_dados is',
'select MAX(F.COD_FASE_PADRAO) COD_FASE',
',MAX(NOTA_DE_CORTE)',
'from PS_FASE_PADRAO_CARGO f;',
'',
'',
'cursor c_valida is',
'SELECT CAND.COD_FASE',
' FROM CANDIDATO CAND',
'WHERE CAND.COD_REQ       = :P32_COD_REQUISICAO',
'  AND CAND.COD_CANDIDATO = :P32_COD_CANDIDATO',
'  AND CAND.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_EMPRESA = CAND.COD_EMPRESA',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);',
'',
'V_NOTA NUMBER;',
'V_FASE VARCHAR2(50);',
'V_FASE_ATUAL  VARCHAR2(50);',
'',
'begin',
'',
'OPEN c_dados;',
'FETCH c_dados INTO V_NOTA,V_FASE;',
'CLOSE c_dados;',
'',
'OPEN c_valida;',
'FETCH c_valida INTO V_FASE_ATUAL;',
'CLOSE c_valida;',
'',
'IF V_FASE > V_FASE_ATUAL THEN',
'Insert into CANDIDATO (COD_EMPRESA',
'                   ,   COD_CANDIDATO',
'                   ,   COD_FASE',
'                   ,   DATE_FASE',
'                   ,   COD_PREST_SERV_AVALIADOR',
'                   ,   USUARIO',
'                   ,   DT_ATUALIZACAO',
'                   ,   COD_AVAL_FASE',
'                   ,   DATA_AVAL_FASE',
'                   ,   IND_AVAL_FASE',
'                   ,   MOT_AVAL_FASE',
'                   ,   RESULTADO_FASE',
'                   ,   COD_REQ',
'                   ,   COD_PROCESSO',
'                   ,   COD_VAGA',
'                   ,   COD_EMP_CAND',
'                   ,   CHECK_APROV)',
'      values (:P32_COD_EMPRESA --COD_EMPRESA',
'           ,  :P32_COD_CANDIDATO  --COD_CANDIDATO',
'           ,  V_FASE',
'           ,  TRUNC(SYSDATE)  --DATE_FASE',
'           ,  :P32_SELECIONADOR--COD_PREST_SERV_AVALIADOR',
'           ,  :P_USUARIO --USUARIO',
'           ,  TRUNC(SYSDATE)  --DT_ATUALIZACAO',
'           ,  5  --COD_AVAL_FASE',
'           ,  TRUNC(SYSDATE)--DATA_AVAL_FASE',
'           ,  V_NOTA--IND_AVAL_FASE',
'           ,  null --MOT_AVAL_FASE',
'           ,  :P32_OBSERVACAO--RESULTADO_FASE',
'           ,  :P32_COD_REQUISICAO--COD_REQ',
'           ,  :P32_COD_REQUISICAO--COD_PROCESSO',
'           ,  NULL--COD_VAGA',
'           ,  :P32_COD_EMPRESA--COD_EMP_CAND',
'           ,  ''S'');',
'END IF;',
'	COMMIT;',
'    EXCEPTION WHEN OTHERS THEN ',
'  NULL;',
'END;',
'',
''))
,p_process_error_message=>'Erro para mudar de Fase - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
,p_process_success_message=>'Candidato Aprovado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52439139527990755331)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INDICACAO_APROVA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update requisicao set CONFIRMA_INDICACAO_CAND = ''S''',
unistr(', OBS_INDICACAO_CAND = ''Confirmado a indica\00E7\00E3o do(a) Candidato(a) ''||:P32_COD_CANDIDATO||''-''||upper(:P32_NOME_CANDIDATO)||'' - Observa\00E7\00E3o: ''||:P32_OBSERVACAO_INDICACAO'),
unistr('||'' - Usu\00E1rio: ''||:P_USUARIO||'' - Data: ''||to_date(sysdate,''dd/mm/rrrr'')'),
'where cod_req = :P32_COD_REQUISICAO;',
'commit;',
'end;',
''))
,p_process_error_message=>unistr('Erro ao Confirmar a Indica\00E7\00E3o do Candidato - #SQLERRM#')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52404971630992151733)
,p_process_success_message=>unistr('Indica\00E7\00E3o do(a) candidato(a) Aprovada!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52439139573066755332)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INDICACAO_REPROVA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update requisicao set CONFIRMA_INDICACAO_CAND = ''N''',
unistr(', OBS_INDICACAO_CAND = ''Reprovado a Indica\00E7\00E3o do(a) Candidato(a) ''||:P32_COD_CANDIDATO||''-''||upper(:P32_NOME_CANDIDATO)||'' - Observa\00E7\00E3o: ''||:P32_OBSERVACAO_INDICACAO'),
unistr('||'' - Usu\00E1rio: ''||:P_USUARIO||'' - Data: ''||to_date(sysdate,''dd/mm/rrrr'')'),
'where cod_req = :P32_COD_REQUISICAO;',
'commit;',
'end;',
''))
,p_process_error_message=>unistr('Erro ao Reprovar a Indica\00E7\00E3o do Candidato - #SQLERRM#')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52404971960844151737)
,p_process_success_message=>unistr('Indica\00E7\00E3o do(a) candidato(a) Reprovada!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50988468509893493261)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'EXCLUIR_CANDIDATO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete from candidato where cod_candidato = :p32_cod_candidato and cod_req = :p32_COD_requisicao;',
'',
'commit;',
'',
'delete from RP_CAND_INSCRITOS where cod_candidato = :p32_cod_candidato and cod_req = :p32_COD_requisicao;',
'',
'commit;',
'',
'delete from RP_FUNC_INSCRITOS where cod_empresa = :p32_cod_emp_matricula and matricula = :p32_matricula and cod_req = :p32_COD_requisicao;',
'',
'commit;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'EXCLUIR_CANDIDATO'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Processo Executado com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50988468671208493262)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'EXCLUIR_APROVACAO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DELETE FROM CANDIDATO_APROVADO',
' WHERE COD_CANDIDATO = :P32_COD_CANDIDATO',
'   AND COD_SOLICITACAO = :P32_COD_REQUISICAO;',
'',
'commit;',
'',
'UPDATE REQUISICAO',
'   SET COD_SIT_REQ = 5',
'   , DT_SIT_REQ = SYSDATE',
'   , USUARIO = :P_USUARIO',
'   , DT_ATUALIZACAO = SYSDATE',
'   , cod_cand_aprovado = null',
' WHERE COD_REQ = :P32_COD_REQUISICAO;',
' ',
'COMMIT;',
'',
'update inf_pessoais_candidato  set PS = null',
'WHERE COD_CANDIDATO   = :P32_COD_CANDIDATO',
'and PS = :P32_COD_REQUISICAO;',
'',
'',
'UPDATE CANDIDATO CAND SET CHECK_APROV = ''N''',
'WHERE CAND.COD_REQ       = :P32_COD_REQUISICAO',
'  AND CAND.COD_CANDIDATO = :P32_COD_CANDIDATO;',
'  ',
'UPDATE ps_processo_seletivo PS SET STATUS = ''A''',
'WHERE  ps.cod_processo = :P32_COD_REQ;',
'  ',
'COMMIT;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'EXCLUIR_APROVACAO'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Processo Executado com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52258323443160352532)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Carrega Proximo_Anterior'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_prev is',
'select max(cand.COD_CANDIDATO) ordem_prev',
'  from candidato cand',
' where cand.COD_REQ     = :P32_COD_REQUISICAO',
' and cand.COD_CANDIDATO < :P32_COD_CANDIDATO',
' AND cand.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_EMPRESA = CAND.COD_EMPRESA',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);',
'',
'v_prev c_prev%rowtype;',
'',
'cursor c_next is',
'select min(cand.COD_CANDIDATO) ordem_prev',
'  from candidato cand',
' where cand.COD_REQ     = :P32_COD_REQUISICAO',
' and cand.COD_CANDIDATO > :P32_COD_CANDIDATO',
' AND cand.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_EMPRESA = CAND.COD_EMPRESA',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);',
'',
'v_cand_prev varchar2(255);',
'v_cand_next varchar2(255);',
'',
'begin',
'',
'  open c_prev;',
'  fetch c_prev into :P32_PREV;',
'  close c_prev;',
'  ',
'  open c_next;',
'  fetch c_next into :P32_NEXT;',
'  close c_next;',
'',
'  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52237932729055224110)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Carregar Dados'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C_DADOS IS',
'SELECT CAND.COD_EMPRESA',
'   , FUNC.STATUS_CANDIDATO',
'   , REQ.COD_FILIAL',
'   , INITCAP(NVL(PESS.NOME_SOCIAL,PESS.NOME)) NOME',
'   , PESS.TIPO_LOGRADOURO_ES||'' ''||INITCAP(PESS.ENDERECO) ENDERECO',
'   , INITCAP(PESS.BAIRRO) BAIRRO',
'   , INITCAP(PESS.CIDADE) CIDADE',
'   , INITCAP((SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = CAND.cod_fase)) DESC_FASE',
'   , upper(PESS.UF) UF',
'   , LPAD(PESS.CEP,5,0)||''-''||LPAD(PESS.COMPLEMENTO_CEP,3,0) CEP',
'   , REGEXP_REPLACE(PESS.DDD,''[^[:digit:]]'')||REGEXP_REPLACE(PESS.TELEFONE,''[^[:digit:]]'') TELEFONE',
'   , REGEXP_REPLACE(PESS.DDD_CELULAR,''[^[:digit:]]'')||REGEXP_REPLACE(PESS.TELEFONE_CELULAR,''[^[:digit:]]'') TELEFONE_CELULAR',
'   , case when PESS.TELEFONE_CELULAR is not null then ''http://api.whatsapp.com/send?phone=+55''||NVL(REGEXP_REPLACE(PESS.DDD_CELULAR,''[^[:digit:]]''),11)||REGEXP_REPLACE(PESS.TELEFONE_CELULAR,''[^[:digit:]]'') end web_whats',
'   , LOWER(PESS.E_MAIL) E_MAIL',
'   , trunc((months_between(sysdate,to_date(PESS.DT_NAC,''dd/mm/rrrr'')))/12) IDADE',
'   , PESS.DT_NAC DATA_NASCIMENTO',
'   ,   CASE WHEN PESS.SEXO = ''F'' THEN ''Feminino''',
'            WHEN PESS.SEXO = ''M'' THEN ''Masculino''',
'        else PESS.SEXO end SEXO',
'   , PESS.NUM_IDENTIDADE',
'   , CASE WHEN PESS.POSSUI_DEPENDENTE = ''S'' THEN ''Sim''',
unistr('            WHEN PESS.POSSUI_DEPENDENTE = ''N'' THEN ''N\00E3o'''),
'        else PESS.POSSUI_DEPENDENTE end POSSUI_DEPENDENTE',
'   , FUNC.DATA_APRESENTACAO',
'   , FUNC.DATA_CONVOCACAO',
'   , TO_CHAR(FUNC.DT_ATUALIZACAO,''DD/MM/RRRR'') DATA_CADASTRO',
'   , INITCAP(NVL((SELECT EMP.CARGO FROM empregos_anteriores EMP',
'                   WHERE EMP.COD_CANDIDATO = FUNC.COD_CANDIDATO',
unistr('                     AND DATA_DESL_EMP = (SELECT MAX(DATA_DESL_EMP) FROM empregos_anteriores EMP2 WHERE EMP2.COD_CANDIDATO = EMP.COD_CANDIDATO)),''N\00C3O INFORMADO'')) ULTIMO_CARGO  '),
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
unistr('                   FETCH FIRST ROW ONLY),''N\00C3O INFORMADO'')) GRAU_INSTRUCAO'),
'   , NVL((SELECT COUNT(1) FROM RP_CAND_INSCRITOS CAIN WHERE CAIN.COD_CANDIDATO = CAND.COD_CANDIDATO),0)||'' Candidatura(s)'' HIST_REQUISICOES',
'   ,rEQ.cod_sit_req ',
'   , TIPO   ',
unistr('   , CASE WHEN PESS.IND_DEF_FIS = ''S'' THEN ''Sim'' else ''N\00E3o'' end PCD'),
'   , CAND.PONTUACAO',
'   , CAND.COD_FASE',
'   , CAND.CHECK_APROV',
'   , CAND.cod_prest_serv_avaliador',
'   , CAND.resultado_fase',
'   , CAND.ind_aval_fase',
'   , CAND.cod_aval_fase',
'   , UPPER(FNCT_NOME_CARGO(REQ.COD_CARGO)) CARGO',
' FROM CANDIDATO CAND',
'    , REQUISICAO REQ',
'    , INF_FUNC_CANDIDATO FUNC',
'    , INF_PESSOAIS_CANDIDATO PESS',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND REQ.COD_REQ        = CAND.COD_REQ',
'  AND CAND.COD_REQ       = :P32_COD_REQUISICAO',
'  AND CAND.COD_CANDIDATO = :P32_COD_CANDIDATO',
'  AND CAND.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_EMPRESA = CAND.COD_EMPRESA',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);',
'',
'R_DADOS C_DADOS%ROWTYPE;',
'',
'cursor c_mat is',
'select i.cod_empresa, i.matricula',
'  from inf_pessoais_cad p,',
'       informacoes_funcionais i',
' where p.cod_empresa = i.cod_empresa',
'   and p.matricula = i.matricula',
'   and i.situacao < ''90''',
'   and p.cod_candidato = :P32_COD_CANDIDATO;',
'   ',
'v_mat c_mat%rowtype;',
'',
'cursor c_ps is',
'select cod_prest_serv',
'  from PS_PROCESSO_SELETIVO',
' where cod_processo = :p32_COD_req;',
' ',
'v_ps c_ps%rowtype;',
'',
'BEGIN',
'',
'  OPEN C_DADOS;',
'  FETCH C_DADOS INTO R_DADOS;',
'  CLOSE C_DADOS;',
'',
'  BEGIN',
'  SELECT ''S'' ',
'    INTO :P32_CANDIDATO_APROVADO ',
'    FROM CANDIDATO_APROVADO ',
'   WHERE COD_SOLICITACAO = :P32_COD_REQUISICAO ',
'     AND COD_CANDIDATO = :P32_COD_CANDIDATO;',
'  EXCEPTION WHEN OTHERS THEN',
'  :P32_CANDIDATO_APROVADO := ''N'';',
'  END;',
'',
'  :P32_DESC_PROCESSO := R_DADOS.CARGO||'' - ''||:P32_COD_REQUISICAO;',
'',
'  :P32_NOME_CANDIDATO := R_DADOS.NOME; --|| case when :P32_CANDIDATO_APROVADO = ''S'' then '' <i>Aprovado</i>'' end;',
'  :P32_SIT_REQUISICAO := R_DADOS.cod_sit_req;',
'  :p32_filial := R_DADOS.COD_FILIAL;',
'  :p32_pontuacao := r_dados.pontuacao;',
'',
'  if :p32_cod_empresa_1 is null then :p32_cod_empresa_1 := :p32_cod_empresa; end if;',
'  if :p32_cod_candidato_1 is null then :p32_cod_candidato_1 := :p32_cod_candidato; end if;',
'  if :p32_cod_req is null then :p32_cod_req := :p32_cod_requisicao; end if;',
'  if :p32_cod_processo is null then :P32_COD_PROCESSO := :p32_cod_requisicao; end if;',
'  if :p32_cod_fase is null then :p32_cod_fase := r_dados.cod_fase; end if;',
'  :P32_FASE_NEW := NULL;',
'  /*',
'  :p32_check_aprov := R_DADOS.CHECK_APROV;',
'  :p32_cod_prest_serv_avaliador := R_DADOS.COD_PREST_SERV_AVALIADOR;',
'  :p32_resultado_fase := R_DADOS.RESULTADO_FASE;',
'  :p32_ind_aval_fase := R_DADOS.ind_aval_fase;',
'  :p32_cod_aval_fase := R_DADOS.cod_aval_fase;',
'  */',
'',
'  open c_mat;',
'  fetch c_mat into v_mat;',
'  close c_mat;',
'',
'  :p32_cod_emp_matricula := v_mat.cod_empresa;',
'  :p32_matricula := v_mat.matricula;',
'',
'  IF V_MAT.MATRICULA IS NOT NULL THEN',
'  :P32_TIPO_PARTICIPANTE := ''F'';',
'  ELSE',
'  :P32_TIPO_PARTICIPANTE := ''C'';',
'  END IF;',
'',
'  open c_ps;',
'  fetch c_ps into v_ps;',
'  close c_ps;',
'',
'    if :p32_cod_prest_serv_avaliador is null then',
'    :p32_cod_prest_serv_avaliador := v_ps.cod_prest_serv;',
'    end if;',
'',
'  BEGIN',
'    SELECT x.nota_de_corte ',
'    INTO :P32_NOTA_MINIMA',
'    FROM ps_processo_fase x ',
'    WHERE x.cod_processo = :P32_COD_REQUISICAO ',
'    AND x.cod_fase = R_DADOS.COD_FASE',
'    AND ROWNUM = 1;',
'  EXCEPTION ',
'  WHEN OTHERS THEN',
'  NULL;',
'  END;',
'  ',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52302811882494936018)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Carrega URL CV'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vURL_P   VARCHAR2(4000) DEFAULT NULL;',
'BEGIN',
'NULL;',
'/*',
'  IF :P_BASE IN(''STEFANINI'') THEN',
'    vURL_P := apex_page.get_url(p_application => ''CONHECENDO_VOCE_''||:P_BASE',
'                               ,p_page        => 1',
'                               ,p_clear_cache => 1',
'                               ,p_items       => ''P1_USUARIO,P1_EMPRESA,P1_CANDIDATO,P1_EMPRESA_USER,P1_MATRICULA_USER,P_EMP,P_MAT,P_VAGA''',
'                               ,p_values      => :P_USUARIO||'',''||:P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||NULL||'',''||NULL||'',''||NULL',
'                               );',
'  ELSE                             ',
'    vURL_P := apex_page.get_url(p_application => ''CV_''||:P_BASE',
'                               ,p_page        => 1',
'                               ,p_clear_cache => 1',
'                               ,p_items       => ''P_USUARIO,P_PAINEL,P_EMPRESA,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_EMP,P_MAT,P_VAGA''',
'                               ,p_values      => :P_USUARIO||'',''||:P_PAINEL||'',''||:P32_COD_EMPRESA||'',''||:P32_COD_CANDIDATO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||NULL||'',''||NULL||'',''||NULL',
'                               );',
'  END IF;  ',
'  --',
'  :P32_URL_PAG_CV := REPLACE(REPLACE(vURL_P,''javascript:apex.navigation.dialog.close(true,''''''),'''''');'');',
'  --',
'*/',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50623941562787250358)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(52258322598023352524)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Dados do Candidato'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
' FROM CANDIDATO CAND',
'WHERE CAND.COD_PROCESSO = :P32_COD_REQUISICAO',
'  and CAND.COD_CANDIDATO = :P32_COD_CANDIDATO',
'  and cand.COD_EMPRESA = :P32_COD_EMPRESA',
'  AND COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_REQ = CAND.COD_REQ)'))
,p_process_when_type=>'EXISTS'
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
