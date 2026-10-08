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
,p_default_application_id=>2936
,p_default_id_offset=>17567935217100610
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2936 - Medicina Ocupacional - Chamada de Pacientes
--
-- Application Export:
--   Application:     2936
--   Name:            Medicina Ocupacional - Chamada de Pacientes
--   Date and Time:   02:42 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 1
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00001
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(19532732576462722786)
,p_name=>'Chamada de Pacientes: Painel'
,p_step_title=>'Chamada de Pacientes: Painel'
,p_autocomplete_on_off=>'OFF'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Chamada.css / Natcorp_Chamada.js)',
'',
unistr('O painel da TV da sala de espera: as duas filas (Cadastro / guich\00EA e Atendimento m\00E9dico / local), a senha'),
unistr('chamada agora em tamanho de placa, as anteriores e o rel\00F3gio. Senha nova toma a tela por alguns segundos, com'),
unistr('um sino moderno (sintetizado) e a senha falada pela voz do computador. L\00EA a cada 4 s pelo processo'),
unistr('NC_CHAMADA_ESTADO, SEM recarregar a p\00E1gina (o c\00F3digo antigo de recarregar e as a\00E7\00F5es do bipe s\00F3 rodam sem o'),
'Natcorp_Chamada.js). Ajustes da TV (som, voz, volume, testar, tela cheia) ao mexer o mouse.',
'Para desligar: tire as duas URLs de arquivo (tudo volta como era). Guia: brand/apex/app/CHAMADA-MANUTENCAO.md.'))
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Chamada.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Chamada.css'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function setTimer() {',
'  var seconds = 10,',
'      refresh = ''S'';',
'',
'  apex.natcorp = apex.natcorp || {};',
'  apex.natcorp.timer && clearTimeout(apex.natcorp.timer);',
'  if (refresh)',
'    apex.natcorp.timer = setTimeout(function() {',
'      //apex.region(''sessoes'').refresh()',
'      apex.submit();',
'      setTimer()',
'    }, seconds * 1000);',
'};',
'',
'Play = (function() {',
'  ',
'  var ctx = new(AudioContext || webkitAudioContext);',
'  ',
'  return function(duration, freq, finishedCallback) {',
'    duration = +duration;',
'    if (typeof finishedCallback != "function") {',
'      finishedCallback = function() {};',
'    }',
'    var osc = ctx.createOscillator();',
'    osc.type = 0;',
'    osc.connect(ctx.destination);',
'    osc.frequency.value = freq;',
'    ',
'    if (osc.start) osc.start();',
'    else osc.noteOn(0);',
'    ',
'    setTimeout(',
'      function() {',
'        if (osc.stop) osc.stop(0);',
'        else osc.noteOff(0);',
'        finishedCallback();',
'      }, duration',
'    );',
'  };',
'})();'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('if (!window.__ncChamada) {  // com o Natcorp_Chamada.js a TV l\00EA sozinha, sem recarregar'),
'Play = (function() {',
'  ',
'  var ctx = new(AudioContext || webkitAudioContext);',
'  ',
'  return function(duration, freq, finishedCallback) {',
'    duration = +duration;',
'    if (typeof finishedCallback != "function") {',
'      finishedCallback = function() {};',
'    }',
'    var osc = ctx.createOscillator();',
'    osc.type = 0;',
'    osc.connect(ctx.destination);',
'    osc.frequency.value = freq;',
'    ',
'    if (osc.start) osc.start();',
'    else osc.noteOn(0);',
'    ',
'    setTimeout(',
'      function() {',
'        if (osc.stop) osc.stop(0);',
'        else osc.noteOff(0);',
'        finishedCallback();',
'      }, duration',
'    );',
'  };',
'})();',
'',
'// Refresh a cada 5 min',
'setTimeout(function(){',
'  var url = [window.location.protocol,',
'             ''//'',',
'             window.location.host,',
'             window.location.pathname,',
'             window.location.search.split("&")[0] || ""',
'            ].join('''');',
'  window.location = url;',
'},300000);',
'',
'setTimer();',
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Region-headerItems--title{',
'  height: 0px;',
'  padding: 0rem 0rem !important; ',
'}',
'',
'@-webkit-keyframes pulsate-fwd {',
'  0% {',
'    -webkit-transform: scale(0.9);',
'            transform: scale(0.9);',
'  }',
'  50% {',
'    -webkit-transform: scale(1.0);',
'            transform: scale(1.0);',
'  }',
'  100% {',
'    -webkit-transform: scale(0.9);',
'            transform: scale(0.9);',
'  }',
'}',
'@keyframes pulsate-fwd {',
'  0% {',
'    -webkit-transform: scale(0.9);',
'            transform: scale(0.9);',
'  }',
'  50% {',
'    -webkit-transform: scale(1.0);',
'            transform: scale(1.0);',
'  }',
'  100% {',
'    -webkit-transform: scale(0.9);',
'            transform: scale(0.9);',
'  }',
'}',
'',
'',
'#CADASTRO {',
'          /*height: 800px;*/',
'          width: 100%;',
'}',
'',
'#MEDICO {',
'         /*height: 800px;*/',
'          width: 100%;',
'}',
'',
'.bloco {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 0px;',
'    padding-bottom: 0px;',
'    height: 420px;',
'   /* height: 500px;*/',
'}',
'',
'.titulo {',
'/* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 30px;',
'    padding-bottom: 0px;',
'    text-decoration: none;',
'    color: #f1f1f1;',
'    font-size: 70px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 80px;',
'    background-color: #34495e;',
'}',
'',
'.bloco_senha {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 0px;',
'    padding-bottom: 0px;',
'    height: 500px;',
'    float: left;',
'    height: auto;',
'    width: 70%;',
'}',
'',
'.titulo_senha {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 20px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #4e4e4e;',
'    font-size: 50px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 60px;',
'    background-color: #eaeaea;',
'    /*background-color: green;*/',
'    /* background-color: #34495e; */',
'}',
'',
'.senha {',
'    /* margin-top: 100px; */',
'    /* margin-bottom: 0px; */',
'    display: block;',
'    padding-top: 100px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #000000;',
'    font-size: 150px;',
'    font-weight: 530;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 240px;',
' /* background-color: yellow;*/',
'}',
'',
'.senha_chamando {',
'    /* margin-top: 100px; */',
'    /* margin-bottom: 0px; */',
'    display: block;',
'    padding-top: 100px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: green;',
'    font-size: 150px;',
'    font-weight: 530;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 240px;',
' /* background-color: yellow;*/',
'	-webkit-animation: pulsate-fwd 1s ease-in-out infinite both;',
'	        animation: pulsate-fwd 1s ease-in-out infinite both;',
'}',
'',
'',
'',
'.paciente {',
'',
'    font-size: 70px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    color: #000000;',
'    padding: 10px;',
'    height: 100px;',
'    text-align: center;',
'}',
'',
'.bloco_local {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 0px;',
'    padding-bottom: 0px;',
'    height: 500px;',
'    float: right;',
'    width: 30%;',
'    height: auto;',
'   /* background-color: blue;*/',
'}',
'',
'.titulo_local {',
'    /* margin-top: 20px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 20px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #4e4e4e;',
'    font-size: 50px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 60px;',
'    background-color: #eaeaea;',
'  /*  background-color: gray;*/',
'    /*background-color: #34495e;*/',
'}',
'',
'.local {',
'   /* border-radius: 100px;*/',
'    font-size: 80px;',
'    font-weight: 480;',
'    padding: 100px 0px 5px 0px;',
'    color: #4e4e4e;',
'    background: #fff;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 120px;',
' /* background-color: pink;*/',
'}',
'',
'.local_chamando {',
'   /* border-radius: 100px;*/',
'    font-size: 70px;',
'    font-weight: 480;',
'    padding: 100px 0px 5px 0px;',
'    color: green;',
'    background: #fff;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 120px;',
'    	-webkit-animation: pulsate-fwd 1s ease-in-out infinite both;',
'	    animation: pulsate-fwd 1s ease-in-out infinite both;',
' /* background-color: pink;*/',
'}',
'',
'',
'',
'.hist_bloco {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 0px;',
'    padding-bottom: 0px;',
'    height: auto;',
'    box-shadow: 0px 1px 0px 0px lightgray;',
'   /* height: 500px;*/',
'}',
'',
'.hist_titulo {',
'/* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 30px;',
'    padding-bottom: 0px;',
'    text-decoration: none;',
'    color: #f1f1f1;',
'    font-size: 38px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 80px;',
'    background-color: #34495e;',
'}',
'',
'.hist_bloco_senha {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 0px;',
'    padding-bottom: 0px;',
'    height: 500px;',
'    float: left;',
'    height: auto;',
'    width: 70%;',
'}',
'',
'.hist_titulo_senha {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 20px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #4e4e4e;',
'    font-size: 30px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 60px;',
'    background-color: #eaeaea;',
'    /*background-color: green;*/',
'    /* background-color: #34495e; */',
'}',
'',
'.hist_senha {',
'    /* margin-top: 100px; */',
'    /* margin-bottom: 0px; */',
'    display: block;',
'    padding-top: 30px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #000000;',
'    font-size: 50px;',
'    font-weight: 530;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 70px;',
' /* background-color: yellow;*/',
'}',
'',
'.hist_paciente {',
'',
'    font-size: 70px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    color: #000000;',
'    padding: 10px;',
'    height: 100px;',
'    text-align: center;',
'}',
'',
'.hist_bloco_local {',
'    /* margin-top: 50px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 0px;',
'    padding-bottom: 0px;',
'    height: 500px;',
'    float: right;',
'    width: 30%;',
'    height: auto;',
'   /* background-color: blue;*/',
'}',
'',
'.hist_titulo_local {',
'    /* margin-top: 20px; */',
'    margin-bottom: 0px;',
'    display: block;',
'    padding-top: 20px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #4e4e4e;',
'    font-size: 30px;',
'    font-weight: 500;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 60px;',
'    background-color: #eaeaea;',
'  /*  background-color: gray;*/',
'    /*background-color: #34495e;*/',
'}',
'',
'.hist_local {',
'   /* border-radius: 100px;*/',
'    display: block;',
'    padding-top: 30px;',
'    padding-bottom: 10px;',
'    text-decoration: none;',
'    color: #000000;',
'    font-size: 50px;',
'    font-weight: 530;',
'    text-transform: uppercase;',
'    text-align: center;',
'    height: 70px;',
' /* background-color: pink;*/',
'}'))
,p_step_template=>wwv_flow_api.id(19532693655056722646)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20211020195346'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7117730117567363567)
,p_plug_name=>'Chamada - Medico'
,p_region_name=>'MEDICO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19532706579624722692)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'CURSOR C_PACIENTE IS',
'select -- s.NOME_PACIENTE paciente,',
'       s.SENHA,',
'       s.data_status,',
'       s.local,',
'       s.observacao obs_status,',
'       s.flag',
'  from MT_CHAMADA_PACIENTE_STATUS s',
' where trunc(s.data_status) = trunc(sysdate)',
'   and s.status = ''M''',
'   and s.data_status = (select max(x.data_status)',
'                         from MT_CHAMADA_PACIENTE_STATUS x',
'                        where x.senha = s.senha',
'                          and x.seq = s.seq',
'                          and x.data = s.data)',
'   order by s.data_status desc;',
'',
'p c_paciente%rowtype;',
'',
'begin',
'',
'  open c_paciente;',
'  fetch c_paciente into p;',
'  close c_paciente;',
'',
'  begin',
'    ',
'   htp.prn(''<div class="bloco" id="bloco_cadastro">'');',
'        ',
unistr('     htp.prn(''<div class="titulo" id="titulo_cadastro">''||''Atendimento M\00E9dico''||''</div>'');'),
'    ',
'     if p.senha is not null and p.data_status between (sysdate-0.0035) and sysdate then',
'',
'          ',
'          htp.prn(''<div class="bloco_senha" id="bloco_senha">'');',
'            htp.prn(''<div class="titulo_senha" id="titulo_senha">''||''Senha''||''</div>'');',
'            if p.flag = 0 then',
'            htp.prn(''<div class="senha">''||p.senha||''</div>'');',
'            else',
'            htp.prn(''<div class="senha_chamando">''||p.senha||''</div>'');',
'            end if;',
'          htp.prn(''</div>'');',
'          ',
'        /*',
'        if p.paciente is not null then',
'          htp.prn(''<div class="paciente">''|| p.paciente ||''</div>'');',
'        end if;',
'        */',
'',
'        if p.local is not null then',
'          htp.prn(''<div class="bloco_local" id="bloco_local">'');',
'            htp.prn(''<div class="titulo_local" id="titulo_local">''||''Local''||''</div>'');',
'            if p.flag = 0 then',
'            htp.prn(''<div class="local">''||p.local ||''</div>'');      ',
'            else',
'            htp.prn(''<div class="local_chamando">''||p.local ||''</div>'');    ',
'            end if;',
'          htp.prn(''</div>'');',
'        end if;',
'',
'     end if;',
'     ',
'    htp.prn(''</div>'');',
'      ',
'  exception when others then null;',
'  end;',
'',
'exception when others then null;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7117730221973363568)
,p_plug_name=>'HISTORICO'
,p_region_name=>'HISTORICO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19532706579624722692)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'CURSOR C_PACIENTE IS',
'select --s.NOME_PACIENTE paciente,',
'       s.SENHA,',
'       s.data_status,',
'       s.local,',
'       s.observacao obs_status',
'  from MT_CHAMADA_PACIENTE_STATUS s',
' where trunc(s.data_status) = trunc(sysdate)',
'   and s.status = ''M''',
'   and s.flag = 0',
'   and s.data_status = (select max(x.data_status)',
'                         from MT_CHAMADA_PACIENTE_STATUS x',
'                        where x.senha = s.senha',
'                          and x.seq = s.seq',
'                          and x.data = s.data)',
'   order by s.data_status desc;',
'',
'v_count number(1);',
'',
'begin',
'  ',
'      htp.prn(''<div class="hist_bloco" id="hist_bloco_cadastro">'');',
'        ',
unistr('        htp.prn(''<div class="hist_titulo" id="hist_titulo_cadastro">''||''\00DAltimas Chamadas''||''</div>'');'),
'        ',
'        htp.prn(''<div class="hist_bloco_senha" id="hist_bloco_senha">'');',
'            htp.prn(''<div class="hist_titulo_senha" id="hist_titulo_senha">''||''Senha''||''</div>'');',
'        htp.prn(''</div>'');',
'        ',
'        htp.prn(''<div class="hist_bloco_local" id="hist_bloco_local">'');',
'          htp.prn(''<div class="hist_titulo_local" id="hist_titulo_local">''||''Local''||''</div>'');',
'        htp.prn(''</div>'');',
'  for p in c_paciente',
'  loop',
'        ',
'     if p.senha is not null and p.data_status between (sysdate-0.042) and sysdate then',
'',
'          v_count := nvl(v_count,0) + 1;',
'          htp.prn(''<div class="hist_bloco_senha" id="hist_bloco_senha">'');',
'          /*  htp.prn(''<div class="hist_titulo_senha" id="hist_titulo_senha">''||''Senha''||''</div>''); */',
'            htp.prn(''<div class="hist_senha">''||p.senha||''</div>'');',
'          htp.prn(''</div>'');',
'          ',
'        /*',
'        if p.paciente is not null then',
'          htp.prn(''<div class="paciente">''|| p.paciente ||''</div>'');',
'        end if;',
'        */',
'',
'        if p.local is not null then',
'          htp.prn(''<div class="hist_bloco_local" id="hist_bloco_local">'');',
unistr('           /* htp.prn(''<div class="hist_titulo_local" id="hist_titulo_local">''||''Guich\00EA''||''</div>'');*/'),
'            htp.prn(''<div class="hist_local">''||p.local ||''</div>'');       ',
'          htp.prn(''</div>'');',
'        end if;',
'',
'     end if;',
'     ',
'   exit when v_count = 4;',
'     ',
'  end loop;',
'  ',
'  htp.prn(''</div>'');',
'        ',
'exception when others then null;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7912521467251729769)
,p_plug_name=>'Chamada - Cadastro'
,p_region_name=>'CADASTRO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19532706579624722692)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'CURSOR C_PACIENTE IS',
'select --s.NOME_PACIENTE paciente,',
'       s.SENHA,',
'       s.data_status,',
'       s.local,',
'       s.observacao obs_status,',
'       s.flag',
'  from MT_CHAMADA_PACIENTE_STATUS s',
' where trunc(s.data_status) = trunc(sysdate)',
'   and s.status = ''C''',
'   and s.data_status = (select max(x.data_status)',
'                         from MT_CHAMADA_PACIENTE_STATUS x',
'                        where x.senha = s.senha',
'                          and x.seq = s.seq',
'                          and x.data = s.data)',
'   order by s.data_status desc;',
'',
'p c_paciente%rowtype;',
'',
'begin',
'',
'  open c_paciente;',
'  fetch c_paciente into p;',
'  close c_paciente;',
'',
'    begin',
'    ',
'   htp.prn(''<div class="bloco" id="bloco_cadastro">'');',
'        ',
'    htp.prn(''<div class="titulo" id="titulo_cadastro">''||''Cadastro''||''</div>'');',
'        ',
'     if p.senha is not null and p.data_status between (sysdate-0.0035) and sysdate then',
'',
'          ',
'          htp.prn(''<div class="bloco_senha" id="bloco_senha">'');',
'            htp.prn(''<div class="titulo_senha" id="titulo_senha">''||''Senha''||''</div>'');',
'            if p.flag = 0 then',
'            htp.prn(''<div class="senha">''||p.senha||''</div>'');',
'            else',
'            htp.prn(''<div class="senha_chamando">''||p.senha||''</div>'');',
'            end if;',
'          htp.prn(''</div>'');',
'          ',
'        /*',
'        if p.paciente is not null then',
'          htp.prn(''<div class="paciente">''|| p.paciente ||''</div>'');',
'        end if;',
'        */',
'',
'        if p.local is not null then',
'          htp.prn(''<div class="bloco_local" id="bloco_local">'');',
unistr('            htp.prn(''<div class="titulo_local" id="titulo_local">''||''Guich\00EA''||''</div>'');'),
'            if p.flag = 0 then',
'            htp.prn(''<div class="local">''||p.local ||''</div>'');      ',
'            else',
'            htp.prn(''<div class="local_chamando">''||p.local ||''</div>'');    ',
'            end if;',
'          htp.prn(''</div>'');',
'        end if;',
'      ',
'      ',
'      ',
'     end if;',
'     ',
'     htp.prn(''</div>'');',
'     ',
'    exception when others then null;',
'    end;',
'',
'exception when others then null;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7912521534698729770)
,p_plug_name=>'HISTORICO'
,p_region_name=>'HISTORICO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19532706579624722692)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'CURSOR C_PACIENTE IS',
'select --s.NOME_PACIENTE paciente,',
'       s.SENHA,',
'       s.data_status,',
'       s.local,',
'       s.observacao obs_status',
'  from MT_CHAMADA_PACIENTE_STATUS s',
' where trunc(s.data_status) = trunc(sysdate)',
'   and s.status = ''C''',
'   and s.flag = 0',
'   and s.data_status = (select max(x.data_status)',
'                         from MT_CHAMADA_PACIENTE_STATUS x',
'                        where x.senha = s.senha',
'                          and x.seq = s.seq',
'                          and x.data = s.data)',
'   order by s.data_status desc;',
'',
'v_count number(1);',
'',
'begin',
'  ',
'      htp.prn(''<div class="hist_bloco" id="hist_bloco_cadastro">'');',
'        ',
unistr('        htp.prn(''<div class="hist_titulo" id="hist_titulo_cadastro">''||''\00DAltimas Chamadas''||''</div>'');'),
'        ',
'        htp.prn(''<div class="hist_bloco_senha" id="hist_bloco_senha">'');',
'            htp.prn(''<div class="hist_titulo_senha" id="hist_titulo_senha">''||''Senha''||''</div>'');',
'        htp.prn(''</div>'');',
'        ',
'        htp.prn(''<div class="hist_bloco_local" id="hist_bloco_local">'');',
unistr('          htp.prn(''<div class="hist_titulo_local" id="hist_titulo_local">''||''Guich\00EA''||''</div>'');'),
'        htp.prn(''</div>'');',
'  for p in c_paciente',
'  loop',
'        ',
'     if p.senha is not null and p.data_status between (sysdate-0.042) and sysdate then',
'',
'          v_count := nvl(v_count,0) + 1;',
'          htp.prn(''<div class="hist_bloco_senha" id="hist_bloco_senha">'');',
'          /*  htp.prn(''<div class="hist_titulo_senha" id="hist_titulo_senha">''||''Senha''||''</div>''); */',
'            htp.prn(''<div class="hist_senha">''||p.senha||''</div>'');',
'          htp.prn(''</div>'');',
'          ',
'        /*',
'        if p.paciente is not null then',
'          htp.prn(''<div class="paciente">''|| p.paciente ||''</div>'');',
'        end if;',
'        */',
'',
'        if p.local is not null then',
'          htp.prn(''<div class="hist_bloco_local" id="hist_bloco_local">'');',
unistr('           /* htp.prn(''<div class="hist_titulo_local" id="hist_titulo_local">''||''Guich\00EA''||''</div>'');*/'),
'            htp.prn(''<div class="hist_local">''||p.local ||''</div>'');       ',
'          htp.prn(''</div>'');',
'        end if;',
'',
'     end if;',
'     ',
'   exit when v_count = 4;',
'     ',
'  end loop;',
'  ',
'  htp.prn(''</div>'');',
'        ',
'exception when others then null;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(7912521632883729771)
,p_plug_name=>unistr('Par\00E2metros')
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--textContent:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19532706579624722692)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6320670067935275067)
,p_name=>'P1_SENHA_CAD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(7912521632883729771)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6320670517120275069)
,p_name=>'P1_SENHA_MED'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(7912521632883729771)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6320673611129275074)
,p_name=>'SENHA_CAD - get_lock_time'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1_SENHA_CAD'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v(''P1_SENHA_CAD'') !== '''' && !window.__ncChamada'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6320674143890275074)
,p_event_id=>wwv_flow_api.id(6320673611129275074)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update mt_chamada_paciente_status',
'   set flag = 0',
' where senha = :p1_senha_cad',
'   and status = ''C'';',
'   ',
'commit;',
'',
'end;'))
,p_attribute_02=>'P1_SENHA_CAD'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6320674632611275075)
,p_event_id=>wwv_flow_api.id(6320673611129275074)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (+apex.item(''P1_SENHA_CAD'').getValue().length > 0) {',
' // alert(''Chamando senha '' + apex.item(''P1_SENHA_CAD'').getValue());',
'  Play(200, 600, function () {',
'    setTimeout(function(){',
'      Play(300, 500);',
'    }, 100);',
'  });',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6320672184218275073)
,p_name=>'SENHA_MED - get_lock_time'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P1_SENHA_MED'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v(''P1_SENHA_MED'') !== '''' && !window.__ncChamada'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6320673178993275074)
,p_event_id=>wwv_flow_api.id(6320672184218275073)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'update mt_chamada_paciente_status',
'   set flag = 0',
' where senha = :p1_senha_med',
'   and status = ''M'';',
'   ',
'commit;',
'',
'end;'))
,p_attribute_02=>'P1_SENHA_MED'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6320672661727275073)
,p_event_id=>wwv_flow_api.id(6320672184218275073)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (+apex.item(''P1_SENHA_MED'').getValue().length > 0) {',
' // alert(''Chamando senha '' + apex.item(''P1_SENHA_MED'').getValue());',
'  Play(200, 600, function () {',
'    setTimeout(function(){',
'      Play(300, 500);',
'    }, 100);',
'  });',
'}'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6320671811438275072)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Senha'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'CURSOR C_SENHA_CAD IS',
'select --s.NOME_PACIENTE paciente,',
'       s.SENHA,',
'       s.data_status,',
'       s.local,',
'       s.observacao obs_status',
'  from MT_CHAMADA_PACIENTE_STATUS s',
' where trunc(s.data_status) = trunc(sysdate)',
'   and s.status = ''C''',
'   and s.flag = 1',
'   and s.data_status = (select max(x.data_status)',
'                         from MT_CHAMADA_PACIENTE_STATUS x',
'                        where x.senha = s.senha',
'                          and x.seq = s.seq',
'                          and x.data = s.data)',
'   order by s.data_status desc;',
'',
'v_senha_cad c_senha_cad%rowtype;',
'',
'CURSOR C_SENHA_MED IS',
'select --s.NOME_PACIENTE paciente,',
'       s.SENHA,',
'       s.data_status,',
'       s.local,',
'       s.observacao obs_status',
'  from MT_CHAMADA_PACIENTE_STATUS s',
' where trunc(s.data_status) = trunc(sysdate)',
'   and s.status = ''M''',
'   and s.flag = 1',
'   and s.data_status = (select max(x.data_status)',
'                         from MT_CHAMADA_PACIENTE_STATUS x',
'                        where x.senha = s.senha',
'                          and x.seq = s.seq',
'                          and x.data = s.data)',
'   order by s.data_status desc;',
'',
'v_senha_med c_senha_med%rowtype;',
'',
'begin',
'',
'  open c_senha_cad;',
'  fetch c_senha_cad into v_senha_cad;',
'  close c_senha_cad;',
'',
'  :p1_senha_cad := v_senha_cad.senha;',
'',
'  open c_senha_med;',
'  fetch c_senha_med into v_senha_med;',
'  close c_senha_med;',
'',
'  :p1_senha_med := v_senha_med.senha;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28299293600010000001)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_CHAMADA_ESTADO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Natcorp_Chamada.js: o estado das duas filas, a cada 4 s (o painel n\00E3o recarrega mais a p\00E1gina).'),
unistr('-- Mesma regra das regi\00F5es e das a\00E7\00F5es antigas: a chamada vale pelo registro mais recente da senha'),
unistr('-- (max(data_status) por senha/seq/data); "novas" = flag 1 (ainda n\00E3o anunciadas): devolve e marca flag 0,'),
unistr('-- como fazia a a\00E7\00E3o "get_lock_time". "ultimas" = as da \00FAltima hora (0,042 dia), da mais recente.'),
'-- Guia: CHAMADA-MANUTENCAO.md.',
'declare',
'  procedure fila(p_status varchar2, p_nome varchar2) is',
'    n number := 0;',
'  begin',
'    apex_json.open_object(p_nome);',
'    apex_json.open_array(''novas'');',
'    for r in (select s.senha, s.local, to_char(s.data_status, ''HH24:MI'') hora,',
'                     round((sysdate - s.data_status) * 86400) seg',
'                from mt_chamada_paciente_status s',
'               where trunc(s.data_status) = trunc(sysdate)',
'                 and s.status = p_status',
'                 and s.flag = 1',
'                 and s.data_status = (select max(x.data_status)',
'                                        from mt_chamada_paciente_status x',
'                                       where x.senha = s.senha',
'                                         and x.seq = s.seq',
'                                         and x.data = s.data)',
'               order by s.data_status) loop',
'      apex_json.open_object;',
'      apex_json.write(''senha'', r.senha);',
'      apex_json.write(''local'', r.local);',
'      apex_json.write(''hora'', r.hora);',
'      apex_json.write(''seg'', r.seg);',
'      apex_json.close_object;',
'      update mt_chamada_paciente_status',
'         set flag = 0',
'       where senha = r.senha',
'         and status = p_status;',
'    end loop;',
'    apex_json.close_array;',
'    apex_json.open_array(''ultimas'');',
'    for r in (select s.senha, s.local, to_char(s.data_status, ''HH24:MI'') hora,',
'                     round((sysdate - s.data_status) * 86400) seg',
'                from mt_chamada_paciente_status s',
'               where trunc(s.data_status) = trunc(sysdate)',
'                 and s.status = p_status',
'                 and s.data_status between sysdate - 0.042 and sysdate',
'                 and s.data_status = (select max(x.data_status)',
'                                        from mt_chamada_paciente_status x',
'                                       where x.senha = s.senha',
'                                         and x.seq = s.seq',
'                                         and x.data = s.data)',
'               order by s.data_status desc) loop',
'      n := n + 1;',
'      exit when n > 6;',
'      apex_json.open_object;',
'      apex_json.write(''senha'', r.senha);',
'      apex_json.write(''local'', r.local);',
'      apex_json.write(''hora'', r.hora);',
'      apex_json.write(''seg'', r.seg);',
'      apex_json.close_object;',
'    end loop;',
'    apex_json.close_array;',
'    apex_json.close_object;',
'  end;',
'begin',
'  apex_json.open_object;',
'  fila(''C'', ''cadastro'');',
'  fila(''M'', ''medico'');',
'  apex_json.write(''agora'', to_char(sysdate, ''HH24:MI:SS''));',
'  apex_json.close_object;',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>unistr('Natcorp_Chamada.js l\00EA aqui as duas filas a cada 4 s e as chamadas novas (que este processo marca como anunciadas). Guia: CHAMADA-MANUTENCAO.md.')
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
