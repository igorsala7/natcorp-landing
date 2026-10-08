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
--   Date and Time:   19:32 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 38
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00038
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>38);
end;
/
prompt --application/pages/page_00038
begin
wwv_flow_api.create_page(
 p_id=>38
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>'Consulta Vaga (Quadro de Vagas)'
,p_page_mode=>'MODAL'
,p_step_title=>'Consulta Vaga (Quadro de Vagas)'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'p {',
'margin: 0 0 0rem !important;',
'}',
'',
'.t-Body-contentInner{',
'  padding: 0px !important;',
'}',
'',
'.t-Region .t-Region-body {',
'    padding: 8px !important;',
'}',
'',
'.publicacao{',
'    margin-left: 20px;',
'    margin-right: 20px;',
'}',
'',
'.titulo {',
'  margin-bottom: 0px;',
'    display: block;',
'    padding-top: 10px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    /*color: #2776ac;*/',
'    font-size: 30px;',
'    text-transform: uppercase;',
'    line-height: normal;',
'}',
'',
'.local{',
'    border-radius: 100px;',
'    display: inline-block;',
'    font-size: 12px;',
'    padding: 5px 0px 5px 0px;',
'    color: #676767;',
'    background: #fff;',
'    text-transform: uppercase;',
'}',
'',
'.t-Form-inputContainer span.display_only{',
'    font-size: 14px;',
'    color: #676767;',
'    padding: 10px;',
'    font-weight: 400;',
'}',
'',
'.descricao {',
'',
'    font-size: 12px;',
'    color: pink;',
'    padding: 10px;',
'    box-shadow: 0 1px 0 0 rgba(0, 0, 0, 0.1);',
'}',
'',
'.processo {',
'',
'    font-size: 12px;',
'    color: #676767;',
'    padding: 10px;',
'    box-shadow: 0 1px 0 0 rgba(0, 0, 0, 0.1);',
'}',
'',
'.sticky {',
'    position: fixed;',
'    top: 0;',
'    width: 100%;',
'    background-color: rgba(255, 255, 255, 0.9);',
'    padding-bottom: 10px;',
'    margin-left: -10px;',
'    padding-left: 10px;',
'    z-index: 99;',
'}',
'.t-Dialog-body {',
'  -webkit-overflow-scrolling: touch !important;',
'}',
'',
'.twitter-share-button{',
'  vertical-align: bottom !important;',
'  /*margin-left: 12px !important;*/',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20250627140912'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(54716282251461853433)
,p_plug_name=>unistr('Descri\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(56924442426276549304)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(64923702709858963296)
,p_plug_name=>'Vaga'
,p_region_name=>'VAGA'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select url_apex',
'  from configuracoes;',
'',
'v_c1 c1%rowtype;',
'',
'v_url_vaga varchar2(500);',
'v_url_encode varchar2(500);',
'',
'begin',
'',
'    htp.prn(''<div class="publicacao" id="publicacao_'' || :p38_cod || ''">'');',
'      ',
'      htp.prn(''<div class="titulo" style="color:''||:p9999_link_color||'';">''||:p38_cargo||''</div>'');',
'      htp.prn(''<div class="local">''||''<span class="fa fa-map-marker" aria-hidden="true"></span>''||'' ''||:p38_local ||''</div>'');      ',
'      htp.prn(''<br><div class="local">''||:p38_tipo_modalidade ||''</div>'');',
'      htp.prn(''<div class="processo"> Processo:''|| :p38_cod ||''</div>'');',
'                       ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.url_apex is not null then',
'/*',
'      v_url_vaga := v_c1.url_apex||apex_page.get_url (',
'            p_application => ''QUADRO_VAGAS_''||:P_BASE,',
'            p_page        => 3,',
'            p_items       => ''P38_COD'',',
'            p_values      => :P38_COD,',
'            p_clear_cache => 3',
'            );',
'*/',
'    htp.prn(''<div class="socialShare" id="SOCIAL">'');',
'      v_url_vaga := ''https://www.natcorp.com.br/jobs?company=''||:P_BASE||''&board=''||:P38_ID||''&id=''||:P38_COD;',
'      ',
'      v_url_encode := ''https%3A%2F%2Fwww.natcorp.com.br%2Fjobs%3Fcompany%3D''||:P_BASE||''%26board%3D''||:P38_ID||''%26id%3D''||:P38_COD;',
'',
'    --  htp.prn(''<script src="https://platform.linkedin.com/in.js" type="text/javascript">lang: pt_BR</script><script type="IN/Share" data-url="''||v_url_vaga||''"></script>'');',
'',
'      htp.prn(''<script src="https://platform.linkedin.com/in.js" type="text/javascript">lang: pt_BR</script><script type="IN/Share" data-url="''||v_url_vaga||''"></script>'');',
'',
'      htp.prn(''<iframe src="https://www.facebook.com/plugins/share_button.php?href=''||v_url_encode||''&layout=button_count&size=small&width=127&height=20&appId" width="127" height="20" style="border:none;overflow:hidden;vertical-align: bottom;margin-l'
||'eft: 12px;" scrolling="no" frameborder="0" allowfullscreen="true" allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share"></iframe>'');              ',
'',
'      htp.prn(''<a class="twitter-share-button"  ',
'        href="https://twitter.com/intent/tweet?text=Encontrei%20uma%20oportunidade%20para%20''||:p38_cargo||''&url=''||v_url_encode||''">',
'      Tweet<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></a>'');',
'    htp.prn(''</div>'');',
'    :p38_url := v_url_vaga;',
'    end if;',
'',
'    htp.prn(''</div>'');',
'',
'exception when others then null;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(50988580293415295898)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(56924442426276549304)
,p_button_name=>'CANDIDATAR_VAGA'
,p_button_static_id=>'CANDIDATAR_VAGA'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Quero me Candidatar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=CV_&P_BASE.:900:&SESSION.::&DEBUG.:RP,900:P_COD_QUADRO_VAGA:&P38_COD.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50845863432320527993)
,p_name=>'P38_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(64923702709858963296)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988579634378295891)
,p_name=>'P38_DESCRICAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(54716282251461853433)
,p_prompt=>unistr('Descri\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988581075991295901)
,p_name=>'P38_COD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(64923702709858963296)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988581384161295902)
,p_name=>'P38_CARGO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(64923702709858963296)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988581820786295902)
,p_name=>'P38_LOCAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(64923702709858963296)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988582275165295902)
,p_name=>'P38_TIPO_MODALIDADE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(64923702709858963296)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988582658527295903)
,p_name=>'P38_URL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(64923702709858963296)
,p_prompt=>'Link para candidatos'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(72951052329719200672)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50988583733250295911)
,p_name=>'Popula URL'
,p_event_sequence=>50
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50988584267834295912)
,p_event_id=>wwv_flow_api.id(50988583733250295911)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_url varchar2(200);',
'',
'v_db varchar2(100);',
'',
'begin',
'',
'    begin',
'     select sys_context(''USERENV'', ''DB_NAME'') into v_db from dual;',
'    exception',
'    when others then',
'     null;',
'    end;',
'',
'    if upper(v_db) <> ''PDBHOME'' then',
'     v_url := ''https://www.natcorp.com.br/jobs?company=''||:P_BASE||''&board=''||:p38_id||''&id=''||:P38_COD;',
'    else',
'     v_url := ''https://www.natcorp.com.br/jobs_dev?company=''||:P_BASE||''&board=''||:p38_id||''&id=''||:P38_COD;',
'    end if;',
'    ',
'    :p38_url := ''<a href="''||v_url||''" target="_blank">''||v_url||''</a>'';',
'',
'end;'))
,p_attribute_02=>'P38_COD,P_BASE,P38_ID'
,p_attribute_03=>'P38_URL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50988583332882295910)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50988582979442295909)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Carregar Dados'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    v_descricao clob;',
'    --',
'    v_template_descricao varchar2(4000);',
'    v_formacao        varchar2(4000);',
'    v_cursos          varchar2(4000);',
'    v_conhecimento    varchar2(4000);',
'    v_experiencias    varchar2(4000);',
'    v_idiomas         varchar2(4000);',
'    v_caracteristicas varchar2(4000);',
'    v_tarefas         varchar2(4000);',
'    ',
'    v_url varchar2(300);',
'',
'cursor c1 is',
'SELECT ps.cod_processo COD',
'        ,INITCAP(CA.NOME) Cargo',
'        ,INITCAP(NVL(E.NOME_ABREV,E.NOME)) NOME_EMPRESA',
'       -- ,case when m.nome_municipio is not null then initcap(M.NOME_MUNICIPIO)||''/''||F.UF end Local',
'        ,case when l.cidade is not null then upper(l.Cidade)||''/''||upper(l.uf) else upper(M.NOME_MUNICIPIO)||''/''||upper(F.UF) end Local',
'       -- ,upper(decode(r.tipo_modalidade,''P'',''Presencial'',''S'',''Semi-Presencial'',''H'',''Home-Office'',''T'',''Teletrabalho'')) tipo_modalidade',
'        ,case ',
'        when r.tipo_modalidade = ''P'' then',
'        ''<span class="fa fa-building-o" aria-hidden="true"></span>''||'' PRESENCIAL''',
'        when r.tipo_modalidade = ''S'' then',
'        ''<span class="fa fa-building-o" aria-hidden="true"></span>''||''<span class="fa fa-home" aria-hidden="true"></span>''||'' SEMI-PRESENCIAL''',
'        when r.tipo_modalidade = ''H'' then',
'        ''<span class="fa fa-home" aria-hidden="true"></span>''||'' HOME-OFFICE''',
'        when r.tipo_modalidade = ''T'' then',
'        ''<span class="fa fa-home" aria-hidden="true"></span>''||'' TELETRABALHO''',
'        end tipo_modalidade',
'        ,r.desc_atividades Atividades',
'        ,r.cod_local_trab',
unistr(' --''Forma\00E7\00E3o: ''||CHR(10)||'),
'                     ,(SELECT INITCAP(I.NOME) FROM INSTRUCAO I WHERE I.COD = R.COD_INSTRUCAO)||CHR(10)||',
unistr('                     (select listagg(''  - (''||initcap(i.nome)||'') ''||f.nome||'' (''||decode(f.exige,''S'',''Exigido'',''N'',''Desej\00E1vel'')||'')'',CHR(10))'),
'                     within group (order by f.exige desc)',
'                      from formacao_req_pessoal f, instrucao i',
'                     where f.cod_instrucao = i.cod',
'                       and f.cod_req = r.cod_req) formacao_array,--||CHR(10)||CHR(10)||',
'                     --''Cursos: ''||CHR(10)||',
unistr('                     (select listagg(''  - ''||c.nome||'' (''||decode(exige,''S'',''Exigido'',''N'',''Desej\00E1vel'')||'')'',CHR(10))'),
'                     within group (order by exige desc)',
'                      from curso_req_pessoal c',
'                     where c.cod_req = r.cod_req) cursos_array,--||CHR(10)||CHR(10)||',
'                     --''Conhecimentos: ''||CHR(10)||',
unistr('                     (select listagg(''  - ''||c.nome||'' | N\00EDvel: ''||decode(c.nivel,1,''B\00E1sico'',2,''Intermedi\00E1rio'',3,''Avan\00E7ado'')||'' (''||decode(exige,''S'',''Exigido'',''N'',''Desej\00E1vel'')||'')'',CHR(10))'),
'                     within group (order by exige desc)',
'                      from conhecimento_req_pessoal c',
'                     where c.cod_req = r.cod_req) conhecimentos_array,--||CHR(10)||CHR(10)||',
unistr('                     --''Experi\00EAncias: ''||CHR(10)||'),
unistr('                     case when r.anos_servico is not null then ''  - Tempo de Experi\00EAncia: ''||nvl(R.ANOS_SERVICO,0)||'' anos e ''||nvl(R.MESES_SERVICO,0)||'' meses.''||CHR(10) end||'),
unistr('                     (select listagg(''  - ''||c.nome||'' (''||decode(exige,''S'',''Exigido'',''N'',''Desej\00E1vel'')||'')'',CHR(10))'),
'                     within group (order by exige desc)',
'                      from experiencia_req_pessoal c',
'                     where c.cod_req = r.cod_req) experiencias_array,--||CHR(10)||CHR(10)||',
'                     --''Idiomas: ''||CHR(10)||',
unistr('                     (select listagg(''  - ''||initcap(B.descricao)||'' | N\00EDvel: ''||initcap(n.descricao),CHR(10))'),
'                      within group (order by B.descricao asc)',
'                        from idioma B, NIVEL_CONHECIMENTO N, IDIOMA_REQ_PESSOAL t',
'                       where b.codigo = t.cod_idioma',
'                        and n.codigo = t.cod_nivel_conh',
'                        and t.cod_req = r.cod_req) idiomas_array, --||CHR(10)||CHR(10)||',
unistr('                     --''Caracter\00EDsticas: ''||CHR(10)||'),
'                     (select listagg(''  - ''||initcap(t.desc_carac_func)||'' (''||initcap(p.desc_peso)||'')'',CHR(10))',
'                      within group (order by t.desc_carac_func asc)',
'                        from CARAC_PESO c, carac_func t, peso p',
'                       where c.cod_carac_func = t.cod_carac_func',
'                         and c.cod_peso = p.cod_peso',
'                         and c.cod_req = r.cod_req) caracteristicas_array, --||CHR(10)||CHR(10)||',
'                     --''Tarefas: ''||CHR(10)||',
'                     (select listagg(''  - ''||t.desc_tarefa_req||'' (''||initcap(p.desc_peso)||'')'',CHR(10))',
'                     within group (order by t.desc_tarefa_req asc)',
'                      from TAR_PESO tr, tarefa_req t, peso p',
'                     where tr.cod_tarefa_req = t.cod_tarefa_req',
'                       and tr.cod_peso = p.cod_peso',
'                       and tr.cod_req = r.cod_req) tarefas_array --||CHR(10)',
'               , T.MENSAGEM template_descricao',
'        FROM   REQUISICAO   R',
'              ,PS_PROCESSO_SELETIVO PS',
'              ,EMPRESAS E',
'              ,FILIAIS  F',
'              ,CARGOS       CA',
'              ,MUNICIPIOS M',
'              ,LOCAL_TRAB L',
'              ,RS_TEMPLATE_DESCRICAO T',
'        WHERE  F.COD_MUNICIPIO_RAIS = M.COD_MUN_IBGE (+)',
'        AND    R.COD_LOCAL_TRAB = L.COD_LOCAL_TRAB (+)',
'        AND    CA.COD = R.COD_CARGO',
'        AND    E.COD  = R.COD_EMPRESA',
'        AND    F.COD_FILIAL = R.COD_FILIAL',
'        AND    F.COD_EMPRESA = R.COD_EMPRESA',
'        AND    PS.COD_REQ = R.COD_REQ',
'        and ps.cod_prest_serv is not null',
'       -- and r.cod_req_pai is null',
'        and r.cod_sit_req = 5',
'        and ps.template_descricao_id = t.cod (+)',
'        and ps.cod_processo = :p38_cod',
'     order by 2;',
'     ',
'v_c1 c1%rowtype;   ',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'     ',
'     v_template_descricao := v_c1.template_descricao;',
'     v_formacao        := v_c1.formacao_array;',
'     v_cursos          := v_c1.cursos_array;',
'     v_conhecimento    := v_c1.conhecimentos_array;',
'     v_experiencias    := v_c1.experiencias_array;',
'     v_idiomas         := v_c1.idiomas_array;',
'     v_caracteristicas := v_c1.caracteristicas_array;',
'     v_tarefas         := v_c1.tarefas_array;',
'     --',
'     v_descricao := trim(v_c1.atividades);',
'     ',
'     if trim(v_formacao) is not null then',
unistr('       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Forma\00E7\00E3o:</b> ''||trim(v_formacao);'),
'     end if;',
'     --',
'     if trim(v_cursos) is not null then',
'       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Cursos:</b> ''||CHR(10)||trim(v_cursos);',
'     end if;',
'     --',
'     if trim(v_idiomas) is not null then',
'       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Idiomas:</b> ''||CHR(10)||trim(v_idiomas);',
'     end if;',
'     --',
'     if trim(v_conhecimento) is not null then',
'       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Conhecimentos:</b> ''||CHR(10)||trim(v_conhecimento);',
'     end if;',
'     --',
'     if length(trim(v_experiencias)) > 0 then',
unistr('       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Experi\00EAncias:</b> ''||CHR(10)||trim(v_experiencias);'),
'     end if;',
'     --',
'     if trim(v_caracteristicas) is not null then',
unistr('       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Caracter\00EDsticas:</b> ''||CHR(10)||trim(v_caracteristicas);'),
'     end if;',
'     --',
'     if trim(v_tarefas) is not null then',
'       v_descricao := v_descricao||chr(10)||chr(10)||''<b>- Tarefas:</b> ''||CHR(10)||trim(v_tarefas);',
'     end if;',
'     ',
'     if trim(v_template_descricao) is not null then',
'       v_descricao := v_descricao||chr(10)||chr(10)||CHR(10)||trim(v_template_descricao);',
'     end if;',
'',
':p38_cargo := v_c1.cargo;',
':p38_local := /*v_c1.nome_empresa||'' - ''||*/v_c1.local;',
':p38_tipo_modalidade := v_c1.tipo_modalidade;',
':p38_descricao := v_descricao;',
'',
'--v_url := ''https://www.natcorp.com.br/jobs?company=''||:P_BASE||''&''||''board''||''=''||:p38_id||''&''||''id''||''=''||:P38_COD;',
'--:p38_url := v_url;',
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
