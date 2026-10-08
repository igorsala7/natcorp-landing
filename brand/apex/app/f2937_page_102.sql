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
,p_default_application_id=>2937
,p_default_id_offset=>795299883281732340
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   03:24 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 102
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00102
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>102);
end;
/
prompt --application/pages/page_00102
begin
wwv_flow_api.create_page(
 p_id=>102
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Avalia\00E7\00E3o Medica - Respostas')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Avalia\00E7\00E3o Medica - Respostas')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.css'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_AvaliacaoMedica.css / Natcorp_AvaliacaoMedica.js)',
'',
unistr('A pergunta grande e as alternativas em bot\00F5es (escrevem na lista original: a a\00E7\00E3o "SALVAR ALTERNATIVA"'),
unistr('grava) e, gravado, vai sozinho para a pr\00F3xima. Anterior / Pr\00F3ximo / Finalizar no rodap\00E9 (teclas <- ->,'),
unistr('1 a 9); antes de mudar de pergunta, espera a grava\00E7\00E3o (o texto grava ao sair do campo).'),
unistr('A caixa de texto tamb\00E9m existe nas perguntas com a alternativa "Descreva" (aparece ao escolh\00EA-la).'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/AVALIACAOMEDICA-MANUTENCAO.md.'))
,p_last_updated_by=>'BRUNO.SOUSA'
,p_last_upd_yyyymmddhh24miss=>'20251107142803'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(136445760025053316991)
,p_plug_name=>'Perguntas'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834497856886858)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' l_count number := 0;',
' V_RESPOSTA VARCHAR2(1) := ''N'';',
' V_RESP_MARCADA NUMBER(5) := 0;',
'  V_TEXTO VARCHAR2(2500);',
'',
' ',
' ',
'begin',
' for i in (select ques.cod_questionario',
'                 ,ques.nome_questionario',
'                 ,form.cod_formacao',
'                 ,perg.cod_questao',
'                 ,perg.nome_questao',
'				 ,perg.ind_livre',
'                 ,qupe.numero_ordem',
'             from questionario_1           ques',
'                 ,formacao                 form',
'                 ,questionario_questoes2_1 qupe',
'                 ,questoes_1               perg ',
'            where ques.cod_formacao = form.cod_formacao',
'              and qupe.cod_formacao = ques.cod_formacao',
'              and qupe.cod_questionario = ques.cod_questionario',
'              and perg.cod_formacao = qupe.cod_formacao',
'              and perg.cod_questao = qupe.cod_questao',
'              and qupe.ROWID = :P102_ROWID_QUESTQ2',
'            order by qupe.numero_ordem)',
'',
'    loop',
'						BEGIN',
'						SELECT R.COD_RESPOSTA',
'						INTO V_RESP_MARCADA',
'						FROM RESPOSTA_1 R, AVALIACAO_MEDICA_RESPOSTAS A',
'						WHERE A.COD_RESPOSTA = R.COD_RESPOSTA',
'						AND A.COD_QUESTIONARIO = i.cod_questionario',
'						AND A.COD_QUESTAO = i.cod_questao',
'						AND A.COD_FORMACAO = i.cod_formacao',
'						AND A.MATRICULA = :P102_MATRICULA',
'						AND A.DATA_AVALIACAO = :P102_DATA_AVALIACAO;',
'',
'						EXCEPTION WHEN ',
'						NO_DATA_FOUND',
'						THEN',
'						V_RESP_MARCADA := null;',
'						END;',
'                        ',
'                        ',
'                        BEGIN                                                                                        ',
'								SELECT A.RESP_TEXTO_LIVRE',
'								INTO V_TEXTO',
'								FROM AVALIACAO_MEDICA_RESPOSTAS A',
'								WHERE A.COD_QUESTIONARIO = i.cod_questionario',
'								AND A.COD_QUESTAO = i.cod_questao',
'								AND A.COD_FORMACAO = i.cod_formacao',
'								AND A.MATRICULA = :P102_MATRICULA',
'								AND A.DATA_AVALIACAO = :P102_DATA_AVALIACAO;',
'',
'								EXCEPTION WHEN ',
'								NO_DATA_FOUND',
'								THEN',
'								V_TEXTO := null;',
'								END;',
'            l_count := l_count + 1;                    ',
'                                ',
'            IF nvl(I.ind_livre,''N'') = ''N''   THEN            ',
'                               ',
'     htp.p(APEX_ITEM.HIDDEN(1, i.cod_questao));',
'	 ',
'   --  htp.p(''<b>''||APEX_ITEM.DISPLAY_AND_SAVE(2, l_count||'' - ''||i.nome_questao)||''</b>'');',
'',
'     htp.p(''<br />'');  ',
'',
'    ',
'   ',
'            htp.p(''<div class="t-Form-labelContainer">'');',
'            htp.p(''    <label class="t-Form-label">Resposta Alternativa</label>'');',
'            htp.p(''</div>'');',
'            htp.p(''<br />''); ',
'            htp.p(''<div class="t-Form-inputContainer">',
'                      <div class="t-Form-itemWrapper">'');',
'            htp.p(APEX_ITEM.SELECT_LIST_FROM_QUERY(3',
'                                                  ,V_RESP_MARCADA',
'                                                  ,''select resp.nome_resposta d',
'                                                          ,resp.cod_resposta r',
'                                                      from resposta_1              resp',
'                                                          ,questionario_questoes_1 qure',
'                                                     where resp.cod_resposta = qure.cod_resposta',
'                                                       and resp.cod_formacao = qure.cod_formacao',
'                                                       and qure.cod_questionario = ''||i.cod_questionario||',
'                                                      ''and qure.cod_questao = ''||i.cod_questao||',
'                                                      ''and qure.cod_formacao = ''||i.cod_formacao||',
'                                                    ''order by qure.numero_ordem''',
'                                                  ,''class="selectlist apex-item-select"''',
'                                                  ,''YES''',
'                                                  ,''''',
'                                                  ,''-''',
'                                                  ,null',
'                                                  ,null',
'                                                  ,''YES'')',
'                );      ',
'             htp.p(''    </div>',
'                   </div>'');',
'',
'    ELSIF I.ind_livre = ''S'' THEN ',
'',
'htp.p(APEX_ITEM.HIDDEN(10, i.cod_questao));',
'	 ',
'    -- htp.p(''<b>''||APEX_ITEM.DISPLAY_AND_SAVE(20, l_count ||'' - ''||i.nome_questao)||''</b>'');',
'',
'     htp.p(''<br />'');  ',
'       ',
'            htp.p(''<div class="t-Form-labelContainer">'');',
'            htp.p(''<label class="t-Form-label">Resposta Dissertativa</label>'');',
'            htp.p(''</div>'');            ',
'            htp.p(''<br />'');   ',
'            htp.p(''<div class="t-Form-inputContainer">',
'                      <div class="t-Form-itemWrapper">',
'                           <fieldset class="textarea apex-item-textarea" tabindex="-1">'');',
'            htp.p(APEX_ITEM.TEXTAREA(40, V_TEXTO, 3, 80, ''class="textarea apex-item-textarea"'', null)); ',
'            htp.p(''        </fieldset>',
'                       </div>',
'                   </div>'');',
'',
'           ',
'   ',
'   END IF;',
'   end loop;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(136561728104042244765)
,p_plug_name=>'Buttons2'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_plug_template=>wwv_flow_api.id(177921834581028886859)
,p_plug_display_sequence=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(139825302143165608523)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834581028886859)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(149659436776035547080)
,p_plug_name=>'Parametros'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--stacked:t-Region--hiddenOverflow:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136512132585326806106)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(139825302143165608523)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136611981784155354759)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(139825302143165608523)
,p_button_name=>'Finalizar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(177921863250877886913)
,p_button_image_alt=>'Finalizar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P102_ROWID_NEXT'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136561727015954244754)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(136561728104042244765)
,p_button_name=>'PROXIMO'
,p_button_static_id=>'PROXIMO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863250877886913)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Pr\00F3ximo')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:RP,102:P102_ROWID_QUESTQ2,P102_COD_QUESTIONARIO,P102_COD_QUESTAO,P102_NUMERO_ORDEM,P102_TIPO_QUESTAO,P102_COD_FORMACAO,P102_MATRICULA,P102_DATA_AVALIACAO,P102_TIPO_AVALIADO,P102_COD_EMPRESA,P102_ROWID_PAG_105:&P102_ROWID_NEXT.,&P102_COD_QUESTIONARIO.,&P102_COD_QUESTAO_NEXT.,&P102_NUMERO_ORDEM_NEXT.,&P102_TIPO_QUESTAO.,&P102_COD_FORMACAO.,&P102_MATRICULA.,&P102_DATA_AVALIACAO.,&P102_TIPO_AVALIADO.,&P102_COD_EMPRESA.,&P102_ROWID_PAG_105.'
,p_button_condition=>'P102_NUMERO_ORDEM_NEXT'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136561727832925244762)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(136561728104042244765)
,p_button_name=>'ANTERIOR'
,p_button_static_id=>'ANTERIOR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863250877886913)
,p_button_image_alt=>'Anterior'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:102:&SESSION.:SAVE_ANT:&DEBUG.:RP,102:P102_ROWID_QUESTQ2,P102_COD_QUESTIONARIO,P102_COD_QUESTAO,P102_NUMERO_ORDEM,P102_TIPO_QUESTAO,P102_COD_FORMACAO,P102_MATRICULA,P102_DATA_AVALIACAO,P102_TIPO_AVALIADO,P102_COD_EMPRESA,P102_NUMERO_ORDEM,P102_ROWID_PAG_105:&P102_ROWID_PREV.,&P102_COD_QUESTIONARIO.,&P102_COD_QUESTAO_PREV.,&P102_NUMERO_ORDEM.,&P102_TIPO_QUESTAO.,&P102_COD_FORMACAO.,&P102_MATRICULA.,&P102_DATA_AVALIACAO.,&P102_TIPO_AVALIADO.,&P102_COD_EMPRESA.,&P102_NUMERO_ORDEM_PREV.,&P102_ROWID_PAG_105.'
,p_button_condition=>'P102_NUMERO_ORDEM_PREV'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(132469321408547503106)
,p_name=>'P102_ROWID_PAG_105'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760092894316992)
,p_name=>'P102_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760238803316993)
,p_name=>'P102_COD_QUESTIONARIO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760354795316994)
,p_name=>'P102_NUMERO_ORDEM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760447003316995)
,p_name=>'P102_COD_QUESTAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760550069316996)
,p_name=>'P102_COD_FORMACAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760882541317000)
,p_name=>'P102_MATRICULA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445760969606317001)
,p_name=>'P102_DATA_AVALIACAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445761132360317002)
,p_name=>'P102_COD_EMPRESA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136445761162686317003)
,p_name=>'P102_TIPO_AVALIADO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136512134539939806112)
,p_name=>'P102_ROWID_PROG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(149659436776035547080)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136512134882045806113)
,p_name=>'P102_ROWID_QUESTQ2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(149659436776035547080)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136512135311067806113)
,p_name=>'P102_TIPO_QUESTAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(149659436776035547080)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (SELECT q.ind_livre FROM questoes_1 q WHERE q.cod_questao = x.cod_questao and q.COD_FORMACAO = x.COD_FORMACAO) ',
'  FROM questionario_questoes2_1 x ',
' WHERE x.ROWID = :P102_ROWID_QUESTQ2'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136512135702257806114)
,p_name=>'P102_TXT_QUESTAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(149659436776035547080)
,p_prompt=>unistr('QUEST\00C3O')
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(x.numero_ordem,2,''0'')||'' - ''||(SELECT q.nome_questao FROM questoes_1 q WHERE q.cod_questao = x.cod_questao and q.COD_FORMACAO = x.COD_FORMACAO) ',
'  FROM questionario_questoes2_1 x ',
' WHERE x.ROWID = :P102_ROWID_QUESTQ2'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(161575733107523240657)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561727633859244760)
,p_name=>'P102_ROWID_NEXT'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561727753442244761)
,p_name=>'P102_ROWID_PREV'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561727906353244763)
,p_name=>'P102_NUMERO_ORDEM_NEXT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561728045483244764)
,p_name=>'P102_NUMERO_ORDEM_PREV'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561728714080244771)
,p_name=>'P102_COD_QUESTAO_NEXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561728786752244772)
,p_name=>'P102_COD_QUESTAO_PREV'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(136445760025053316991)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136561731873183244803)
,p_name=>'P102_RESP_ALTERNATIVA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(149659436776035547080)
,p_prompt=>'Resposta Alternativa'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_RESPOSTA FROM AVALIACAO_MEDICA_RESPOSTAS',
'                where COD_EMPRESA = :P102_COD_EMPRESA',
'                    AND MATRICULA = :P102_MATRICULA',
'                    AND DATA_AVALIACAO = :P102_DATA_AVALIACAO',
'                    AND COD_FORMACAO = :P102_COD_FORMACAO',
'                    AND COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'                    AND COD_QUESTAO = :P102_COD_QUESTAO;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select resp.nome_resposta d',
'                                                          ,resp.cod_resposta r',
'                                                      from resposta_1              resp',
'                                                          ,questionario_questoes_1 qure',
'                                                     where resp.cod_resposta = qure.cod_resposta',
'                                                       and resp.cod_formacao = qure.cod_formacao',
'                                                       and qure.cod_questionario = :P102_COD_QUESTIONARIO--''||i.cod_questionario||',
'                                                      and qure.cod_questao = :P102_COD_QUESTAO--''||i.cod_questao||',
'                                                      and qure.cod_formacao = :P102_COD_FORMACAO--''||i.cod_formacao||',
'                                                    order by qure.numero_ordem'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'             from questionario_1           ques',
'                 ,formacao                 form',
'                 ,questionario_questoes2_1 qupe',
'                 ,questoes_1               perg ',
'            where ques.cod_formacao = form.cod_formacao',
'              and qupe.cod_formacao = ques.cod_formacao',
'              and qupe.cod_questionario = ques.cod_questionario',
'              and perg.cod_formacao = qupe.cod_formacao',
'              and perg.cod_questao = qupe.cod_questao',
'              and qupe.ROWID = :P102_ROWID_QUESTQ2',
'              AND NVL(perg.ind_livre,''N'') = ''N'';'))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136611981354141354754)
,p_name=>'P102_RESP_DISSERTATIVA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(149659436776035547080)
,p_prompt=>'Resposta Dissertativa'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT RESP_TEXTO_LIVRE FROM AVALIACAO_MEDICA_RESPOSTAS',
'                where COD_EMPRESA = :P102_COD_EMPRESA',
'                    AND MATRICULA = :P102_MATRICULA',
'                    AND DATA_AVALIACAO = :P102_DATA_AVALIACAO',
'                    AND COD_FORMACAO = :P102_COD_FORMACAO',
'                    AND COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'                    AND COD_QUESTAO = :P102_COD_QUESTAO;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'             from questionario_1           ques',
'                 ,formacao                 form',
'                 ,questionario_questoes2_1 qupe',
'                 ,questoes_1               perg ',
'            where ques.cod_formacao = form.cod_formacao',
'              and qupe.cod_formacao = ques.cod_formacao',
'              and qupe.cod_questionario = ques.cod_questionario',
'              and perg.cod_formacao = qupe.cod_formacao',
'              and perg.cod_questao = qupe.cod_questao',
'              and qupe.ROWID = :P102_ROWID_QUESTQ2',
'              AND (NVL(perg.ind_livre,''N'') = ''S''',
'                   OR EXISTS (SELECT 1 FROM resposta_1 resp, questionario_questoes_1 qure',
'                               WHERE resp.cod_resposta = qure.cod_resposta',
'                                 AND resp.cod_formacao = qure.cod_formacao',
'                                 AND qure.cod_questionario = qupe.cod_questionario',
'                                 AND qure.cod_questao = qupe.cod_questao',
'                                 AND qure.cod_formacao = qupe.cod_formacao',
'                                 AND (UPPER(resp.nome_resposta) LIKE ''%DESCREV%'' OR UPPER(resp.nome_resposta) LIKE ''%ESPECIFI%'')));'))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(136512141306913806120)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(136512132585326806106)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136512141836342806120)
,p_event_id=>wwv_flow_api.id(136512141306913806120)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(136611981426350354755)
,p_name=>'SALVAR ALTERNATIVA'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P102_RESP_ALTERNATIVA'
,p_condition_element=>'P102_RESP_ALTERNATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136611981517792354756)
,p_event_id=>wwv_flow_api.id(136611981426350354755)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_COD NUMBER(15);',
'',
'CURSOR T IS 	',
'			SELECT COD_QUESTAO FROM AVALIACAO_MEDICA_RESPOSTAS',
'                where COD_EMPRESA = :P102_COD_EMPRESA',
'                    AND MATRICULA = :P102_MATRICULA',
'                    AND DATA_AVALIACAO = :P102_DATA_AVALIACAO',
'                    AND COD_FORMACAO = :P102_COD_FORMACAO',
'                    AND COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'                    AND COD_QUESTAO = :P102_COD_QUESTAO;',
'',
'begin',
'',
'OPEN T; ',
' FETCH T INTO V_COD;',
'CLOSE T;',
'',
'',
'if V_COD is null then',
'',
' ',
'',
' ',
'    for i in (select ques.cod_questionario',
'                    ,perg.cod_questao',
'                    ,qupe.numero_ordem  ',
'                from questionario_1           ques',
'                    ,formacao                 form',
'                    ,questionario_questoes2_1 qupe',
'                    ,questoes_1               perg ',
'               where ques.cod_formacao = form.cod_formacao',
'                 and qupe.cod_formacao = ques.cod_formacao',
'                 and qupe.cod_questionario = ques.cod_questionario',
'                 and perg.cod_formacao = qupe.cod_formacao',
'                 and perg.cod_questao = qupe.cod_questao',
'                 and qupe.ROWID = :P102_ROWID_QUESTQ2',
'               order by qupe.numero_ordem)',
'        loop',
'       ',
'            insert into avaliacao_medica_respostas',
'                    (cod_empresa',
'                    ,matricula',
'                    ,data_avaliacao',
'                    ,cod_formacao',
'                    ,cod_questionario',
'                    ,cod_questao',
'                    ,cod_resposta',
'                    ,resp_texto_livre',
'                    ,requer_atencao',
'                    ,observacao',
'                    ,ordem_pergunta',
'                    ,tipo_avaliado)',
'            values(:P102_COD_EMPRESA',
'                  ,:P102_MATRICULA',
'                  ,to_date(:P102_DATA_AVALIACAO,''dd/mm/yyyy'')',
'                  ,:P102_COD_FORMACAO',
'                  ,i.cod_questionario',
'                  ,i.cod_questao',
'                  ,NULL',
'                  ,NULL',
'                  ,''N''',
'                  ,null',
'                  ,i.numero_ordem',
'                  ,:P102_TIPO_AVALIADO);',
'',
'        ',
'        end loop;',
'        ',
'        commit;',
'   ',
'',
'else',
'',
'',
'   ',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(:P102_RESP_ALTERNATIVA,null)',
'			   ,resp_texto_livre = nvl(:P102_RESP_DISSERTATIVA,null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = :P102_COD_QUESTAO ;',
'               ',
'      ',
'',
'     ',
'      commit;',
'     ',
'',
'',
'   ',
'',
'end if;',
'',
'',
'end;',
''))
,p_attribute_02=>'P102_COD_EMPRESA,P102_MATRICULA,P102_DATA_AVALIACAO,P102_COD_FORMACAO,P102_COD_QUESTIONARIO,P102_COD_QUESTAO,P102_ROWID_QUESTQ2,P102_TIPO_AVALIADO,P102_RESP_ALTERNATIVA,P102_RESP_DISSERTATIVA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136611982297039354764)
,p_event_id=>wwv_flow_api.id(136611981426350354755)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_COD NUMBER(15);',
'',
'CURSOR T IS 	',
'			SELECT COD_QUESTAO FROM AVALIACAO_MEDICA_RESPOSTAS',
'                where COD_EMPRESA = :P102_COD_EMPRESA',
'                    AND MATRICULA = :P102_MATRICULA',
'                    AND DATA_AVALIACAO = :P102_DATA_AVALIACAO',
'                    AND COD_FORMACAO = :P102_COD_FORMACAO',
'                    AND COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'                    AND COD_QUESTAO = :P102_COD_QUESTAO;',
'',
'begin',
'',
'OPEN T; ',
' FETCH T INTO V_COD;',
'CLOSE T;',
'',
'',
'if V_COD is not null then',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(:P102_RESP_ALTERNATIVA,null)',
'			   ,resp_texto_livre = nvl(:P102_RESP_DISSERTATIVA,null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = :P102_COD_QUESTAO ;',
'               ',
'      ',
'',
'     ',
'      commit;',
'     ',
'',
'',
'   ',
'',
'end if;',
'',
'',
'end;',
''))
,p_attribute_02=>'P102_COD_EMPRESA,P102_MATRICULA,P102_DATA_AVALIACAO,P102_COD_FORMACAO,P102_COD_QUESTIONARIO,P102_COD_QUESTAO,P102_ROWID_QUESTQ2,P102_TIPO_AVALIADO,P102_RESP_ALTERNATIVA,P102_RESP_DISSERTATIVA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(136611981591624354757)
,p_name=>'Salvar Dissertativa'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P102_RESP_DISSERTATIVA'
,p_condition_element=>'P102_RESP_DISSERTATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136611981667314354758)
,p_event_id=>wwv_flow_api.id(136611981591624354757)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_COD NUMBER(15);',
'',
'CURSOR T IS 	',
'			SELECT COD_QUESTAO FROM AVALIACAO_MEDICA_RESPOSTAS',
'                where COD_EMPRESA = :P102_COD_EMPRESA',
'                    AND MATRICULA = :P102_MATRICULA',
'                    AND DATA_AVALIACAO = :P102_DATA_AVALIACAO',
'                    AND COD_FORMACAO = :P102_COD_FORMACAO',
'                    AND COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'                    AND COD_QUESTAO = :P102_COD_QUESTAO;',
'',
'begin',
'',
'OPEN T; ',
' FETCH T INTO V_COD;',
'CLOSE T;',
'',
'',
'if V_COD is null then',
'',
' ',
'',
' ',
'    for i in (select ques.cod_questionario',
'                    ,perg.cod_questao',
'                    ,qupe.numero_ordem  ',
'                from questionario_1           ques',
'                    ,formacao                 form',
'                    ,questionario_questoes2_1 qupe',
'                    ,questoes_1               perg ',
'               where ques.cod_formacao = form.cod_formacao',
'                 and qupe.cod_formacao = ques.cod_formacao',
'                 and qupe.cod_questionario = ques.cod_questionario',
'                 and perg.cod_formacao = qupe.cod_formacao',
'                 and perg.cod_questao = qupe.cod_questao',
'                 and qupe.ROWID = :P102_ROWID_QUESTQ2',
'               order by qupe.numero_ordem)',
'        loop',
'       ',
'            insert into avaliacao_medica_respostas',
'                    (cod_empresa',
'                    ,matricula',
'                    ,data_avaliacao',
'                    ,cod_formacao',
'                    ,cod_questionario',
'                    ,cod_questao',
'                    ,cod_resposta',
'                    ,resp_texto_livre',
'                    ,requer_atencao',
'                    ,observacao',
'                    ,ordem_pergunta',
'                    ,tipo_avaliado)',
'            values(:P102_COD_EMPRESA',
'                  ,:P102_MATRICULA',
'                  ,to_date(:P102_DATA_AVALIACAO,''dd/mm/yyyy'')',
'                  ,:P102_COD_FORMACAO',
'                  ,i.cod_questionario',
'                  ,i.cod_questao',
'                  ,NULL',
'                  ,NULL',
'                  ,''N''',
'                  ,null',
'                  ,i.numero_ordem',
'                  ,:P102_TIPO_AVALIADO);',
'',
'        ',
'        end loop;',
'        ',
'        commit;',
'   ',
'',
'else',
'',
'',
'   ',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(:P102_RESP_ALTERNATIVA,null)',
'			   ,resp_texto_livre = nvl(:P102_RESP_DISSERTATIVA,null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = :P102_COD_QUESTAO ;',
'               ',
'      ',
'',
'     ',
'      commit;',
'     ',
'',
'',
'   ',
'',
'end if;',
'',
'',
'end;',
''))
,p_attribute_02=>'P102_COD_EMPRESA,P102_MATRICULA,P102_DATA_AVALIACAO,P102_COD_FORMACAO,P102_COD_QUESTIONARIO,P102_COD_QUESTAO,P102_ROWID_QUESTQ2,P102_TIPO_AVALIADO,P102_RESP_ALTERNATIVA,P102_RESP_DISSERTATIVA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136611982432201354765)
,p_event_id=>wwv_flow_api.id(136611981591624354757)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_COD NUMBER(15);',
'',
'CURSOR T IS 	',
'			SELECT COD_QUESTAO FROM AVALIACAO_MEDICA_RESPOSTAS',
'                where COD_EMPRESA = :P102_COD_EMPRESA',
'                    AND MATRICULA = :P102_MATRICULA',
'                    AND DATA_AVALIACAO = :P102_DATA_AVALIACAO',
'                    AND COD_FORMACAO = :P102_COD_FORMACAO',
'                    AND COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'                    AND COD_QUESTAO = :P102_COD_QUESTAO;',
'',
'begin',
'',
'OPEN T; ',
' FETCH T INTO V_COD;',
'CLOSE T;',
'',
'',
'if V_COD is not null then',
'',
' ',
'',
' ',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(:P102_RESP_ALTERNATIVA,null)',
'			   ,resp_texto_livre = nvl(:P102_RESP_DISSERTATIVA,null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = :P102_COD_QUESTAO ;',
'               ',
'      ',
'',
'     ',
'      commit;',
'     ',
'',
'',
'   ',
'',
'end if;',
'',
'',
'end;',
''))
,p_attribute_02=>'P102_COD_EMPRESA,P102_MATRICULA,P102_DATA_AVALIACAO,P102_COD_FORMACAO,P102_COD_QUESTIONARIO,P102_COD_QUESTAO,P102_ROWID_QUESTQ2,P102_TIPO_AVALIADO,P102_RESP_ALTERNATIVA,P102_RESP_DISSERTATIVA'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(136611981933599354760)
,p_name=>'Finalizar'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(136611981784155354759)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136611981970737354761)
,p_event_id=>wwv_flow_api.id(136611981933599354760)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136445760710717316998)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert AVALIACAO_MEDICA_RESPOSTAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    for i in (select ques.cod_questionario',
'                    ,perg.cod_questao',
'                    ,qupe.numero_ordem  ',
'                from questionario_1           ques',
'                    ,formacao                 form',
'                    ,questionario_questoes2_1 qupe',
'                    ,questoes_1               perg ',
'               where ques.cod_formacao = form.cod_formacao',
'                 and qupe.cod_formacao = ques.cod_formacao',
'                 and qupe.cod_questionario = ques.cod_questionario',
'                 and perg.cod_formacao = qupe.cod_formacao',
'                 and perg.cod_questao = qupe.cod_questao',
'                 and qupe.ROWID = :P102_ROWID_QUESTQ2',
'               order by qupe.numero_ordem)',
'        loop',
'       ',
'            insert into avaliacao_medica_respostas',
'                    (cod_empresa',
'                    ,matricula',
'                    ,data_avaliacao',
'                    ,cod_formacao',
'                    ,cod_questionario',
'                    ,cod_questao',
'                    ,cod_resposta',
'                    ,resp_texto_livre',
'                    ,requer_atencao',
'                    ,observacao',
'                    ,ordem_pergunta',
'                    ,tipo_avaliado)',
'            values(:P102_COD_EMPRESA',
'                  ,:P102_MATRICULA',
'                  ,to_date(:P102_DATA_AVALIACAO,''dd/mm/yyyy'')',
'                  ,:P102_COD_FORMACAO',
'                  ,i.cod_questionario',
'                  ,i.cod_questao',
'                  ,NULL',
'                  ,NULL',
'                  ,''N''',
'                  ,null',
'                  ,i.numero_ordem',
'                  ,:P102_TIPO_AVALIADO);',
'',
'        ',
'        end loop;',
'        ',
'        commit;',
'        ',
'      END;',
'',
'begin',
'',
'    for i in 1..apex_application.g_f01.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(apex_application.g_f03(i),null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f01(i);',
'               ',
'      ',
'	',
'',
'     end loop;',
'     ',
'      commit;',
'end;     ',
'',
'',
'',
'begin',
'',
'    for i in 1..apex_application.g_f10.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set ',
'                  resp_texto_livre = nvl(apex_application.g_f40(i),null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f10(i);',
'               ',
'    ',
'	',
'          end loop;',
'          commit;',
'end;      ',
'',
''))
,p_process_error_message=>'#SQLERRM#-ERRO'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Question\00E1rio Salvo')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136445760839646316999)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update AVALIACAO_MEDICA_RESPOSTAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    for i in 1..apex_application.g_f01.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(apex_application.g_f03(i),null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f01(i);',
'               ',
'      ',
'	',
'',
'     end loop;',
'     ',
'      commit;',
'end;     ',
'',
'',
'',
'begin',
'',
'    for i in 1..apex_application.g_f10.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set ',
'                  resp_texto_livre = nvl(apex_application.g_f40(i),null)',
'             where cod_empresa      = :P102_COD_EMPRESA',
'               and matricula        = :P102_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P102_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P102_COD_FORMACAO',
'               and cod_questionario = :P102_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f10(i);',
'               ',
'    ',
'	',
'          end loop;',
'          commit;',
'end;      ',
'',
''))
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Question\00E1rio Atualizado!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136512140862188806119)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'PROXIMO,ANTERIOR'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_comment=>'CREATE,SAVE,DELETE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136561727516536244759)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Pagina\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_prev is',
'select max(r.NUMERO_ORDEM) ordem_prev',
'  from questionario_questoes2_1 r',
' where r.COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'   and r.COD_FORMACAO = :P102_COD_FORMACAO',
'   and r.NUMERO_ORDEM < :P102_NUMERO_ORDEM;',
'',
'v_prev c_prev%rowtype;',
'',
'cursor q_prev (v_ordem varchar2) is',
'select max(r.COD_QUESTAO) quest_prev',
'  from questionario_questoes2_1 r',
' where r.COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'   and r.COD_FORMACAO = :P102_COD_FORMACAO',
'   --and r.cod_questao < :P102_cod_questao',
'   and r.NUMERO_ORDEM = v_ordem;',
'',
'vq_prev q_prev%rowtype;',
'',
'cursor c_next is',
'select min(r.NUMERO_ORDEM) ordem_next',
'  from questionario_questoes2_1 r',
' where r.COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'   and r.COD_FORMACAO = :P102_COD_FORMACAO',
'   and r.NUMERO_ORDEM > :P102_NUMERO_ORDEM;',
'',
'v_next c_next%rowtype;',
'',
'cursor q_next (v_ordem varchar2) is',
'select min(r.COD_QUESTAO) quest_next',
'  from questionario_questoes2_1 r',
' where r.COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'   and r.COD_FORMACAO = :P102_COD_FORMACAO',
'   --and r.cod_questao > :P102_cod_questao',
'    and r.NUMERO_ORDEM = v_ordem;',
'',
'vq_next q_next%rowtype;',
'',
'cursor c_row (v_ordem varchar2) is',
'select r.rowid',
'  from questionario_questoes2_1 r',
' where r.COD_QUESTIONARIO = :P102_COD_QUESTIONARIO',
'   and r.COD_FORMACAO = :P102_COD_FORMACAO',
'   and r.NUMERO_ORDEM = v_ordem;',
'',
'v_row c_row%rowtype;',
'',
'v_rowid_prev varchar2(255);',
'v_rowid_next varchar2(255);',
'',
'begin',
'',
'  open c_prev;',
'  fetch c_prev into v_prev;',
'  close c_prev;',
'  ',
'  open c_row (v_prev.ordem_prev);',
'  fetch c_row into v_row;',
'  close c_row;',
'  ',
'  v_rowid_prev := v_row.rowid;',
'  v_row.rowid := null;',
'  open c_next;',
'  fetch c_next into v_next;',
'  close c_next;',
'  ',
'  open c_row (v_next.ordem_next);',
'  fetch c_row into v_row;',
'  close c_row;',
'  ',
'  open q_next (v_next.ordem_next);',
'  fetch q_next into vq_next;',
'  close q_next;',
'  ',
'  open q_prev (v_prev.ordem_prev);',
'  fetch q_prev into vq_prev;',
'  close q_prev;',
'  ',
'  v_rowid_next := v_row.rowid;',
'  ',
'  :P102_ROWID_PREV := v_rowid_prev;--v_prev.rowid_prev;',
'  :P102_ROWID_NEXT := v_rowid_next;--v_next.rowid_next;',
'  :P102_NUMERO_ORDEM_NEXT  := v_next.ordem_next;',
'  :P102_NUMERO_ORDEM_PREV  := v_prev.ordem_prev;',
'  :P102_COD_QUESTAO_NEXT   := vq_next.quest_next;',
'  :P102_COD_QUESTAO_PREV   := vq_prev.quest_prev;',
'  ',
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
