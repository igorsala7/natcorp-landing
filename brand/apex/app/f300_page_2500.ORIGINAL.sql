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
,p_default_application_id=>300
,p_default_id_offset=>785128738853783604
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 300 - Painel do Colaborador - Natcorp
--
-- Application Export:
--   Application:     300
--   Name:            Painel do Colaborador - Natcorp
--   Date and Time:   15:41 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2500
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_02500
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2500);
end;
/
prompt --application/pages/page_02500
begin
wwv_flow_api.create_page(
 p_id=>2500
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>'OnBoarding'
,p_step_title=>'OnBoarding'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
'function stickHeaders() {',
'  let scroll   = $(".t-Dialog-body").scrollTop(),',
'      cssClass = ''sticky'';',
'',
'  $(''.titulo'').each(function() {',
'    let $titulo      = $(this),',
'        $publicacao  = $titulo.parent(),',
'        height       = $publicacao.outerHeight(),',
'        position     = $publicacao.position().top,',
'        tituloHeight = $titulo.outerHeight() + 10',
'    ',
'    tituloHeight -= +(($titulo.css("paddingBottom") || "0").replace("px", ""));',
'    ',
'    if (scroll > position + 0 && scroll < position + height - (tituloHeight - 20 - 20)) {',
'      $titulo.addClass(cssClass);',
'      $publicacao.find(''.fix_titulo'').css(''display'', ''block'').css(''height'', tituloHeight + 1);',
'    } else',
'      if ($titulo.hasClass(cssClass)) {',
'        $titulo.removeClass(cssClass);',
'        $publicacao.find(''.fix_titulo'').css(''display'', ''none'').css(''height'', 0);',
'      }',
'  });',
'}',
'*/'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//$(".t-Dialog-body").on("scroll", stickHeaders);',
'/*',
'let parent_jQuery = apex.util.getTopApex().jQuery;',
'',
'parent_jQuery(''html,body'').css(''margin'', ''0'')',
'                          .css(''overflow'', ''hidden'')',
'                          .css(''height'', ''100%'');',
'',
'$(window).on(''unload'', function() {',
'  parent_jQuery(''html,body'').css(''overflow'', ''auto'');',
'});',
'',
'setTimeout(function() {',
'  // Set modal height',
'  parent_jQuery(''body .ui-dialog, body .ui-dialog .ui-dialog-content'').css(''height'', ''90%'');',
'  parent_jQuery(''body .ui-dialog .ui-dialog-content iframe'').css(''height'', ''100% !important'');',
'  // Centralize modal again',
'  parent_jQuery(''.ui-dialog-content'').dialog(''option'', ''position'', ''center'');',
'}, 200);',
'*/',
'// Prevent right click on videos',
'$(''video'').bind(''contextmenu'', function() { return false });',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#CATEGORIAS .t-Region-header {',
'    background-color: #ffffff00 !important;',
'    color: black !important;',
'    font-size: 2rem !important;',
'}',
'',
'#PUBLICACOES {',
'  width: 100%;',
'  display: block;',
'  margin-left: auto;',
'  margin-right: auto;',
'}',
'',
'.t-Region .t-Region-body {',
'    padding: 8px !important;',
'}',
'',
'.imagem {',
'  text-align: center;',
'}',
'.imagem img {',
'  min-width: 80%;',
'  margin-bottom: 15px;',
'}',
'',
'.descricao {',
'  padding: 8px !important;',
' /* padding-right: 8px !important;*/',
'}',
'',
'.descricao iframe {',
'  width: 100%;',
'}',
'.video {',
'  text-align: center;',
'}',
'.download {',
'  text-align: left;',
'  font-size: 12pt;',
'}',
'.download a span.text_link {',
'  text-decoration: underline;',
'}',
'',
'hr {',
' /*margin-top: 20px;*/',
' margin-top: 0px;',
'}',
'',
'.imagem img {',
'  max-width: 100% !important;',
'}',
'',
'span.data_vali {',
'  font-style: italic;',
'  margin-left: 20px;',
'}',
'',
'.titulo {',
' /*margin-top: 20px;*/',
'  padding-left: 8px !important;',
'  padding-right: 8px !important;',
'  margin-top: 0px;',
'  margin-bottom: 0px;',
'  ',
'    font-weight: 500 !important;',
'    font-size: large !important;',
'    color: #262626 !important;',
'  ',
'border-bottom: 3px solid #c95788;',
'  ',
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
'/**************************************************************',
'**************************************************************',
'**************************************************************/',
'$baseColor: #398B93;',
'$borderRadius: 10px;',
'$imageBig: 70px;',
'$imageSmall: 40px;',
'$padding: 10px;',
'/*',
'body {',
'   background-color: lighten($baseColor, 30%);',
'   * { box-sizing: border-box; }',
'}',
'*/',
'',
'.header-users {',
'   background-color: darken($baseColor, 5%);',
'   color: white;',
'   font-size: 1.5em;',
'   padding: 1rem;',
'   text-align: center;',
'   text-transform: uppercase;',
'}',
'',
'.table-users img {',
'   border-radius: 50%;',
'   height: 40px;',
'   width: 40px;',
'}',
'',
'.table-users {',
'   border: 1px solid darken($baseColor, 5%);',
'   border-radius: $borderRadius;',
'   box-shadow: 3px 3px 0 rgba(0,0,0,0.1);',
'   max-width: calc(100% - 2em);',
'   margin: 1em auto;',
'   overflow: hidden;',
'   width: 800px;',
'}',
'',
'.table-users table {',
'   width: 100%;',
'   ',
'   td, th { ',
'      color: darken($baseColor, 10%);',
'      padding: $padding; ',
'   }',
'   ',
'   td {',
'      text-align: center;',
'      vertical-align: middle;',
'      ',
'      &:last-child {',
'         font-size: 0.95em;',
'         line-height: 1.4;',
'         text-align: left;',
'      }',
'   }',
'   ',
'   th { ',
'      background-color: lighten($baseColor, 50%);',
'      font-weight: 300;',
'   }',
'   ',
'   tr {     ',
'      &:nth-child(2n) { background-color: white; }',
'      &:nth-child(2n+1) { background-color: lighten($baseColor, 55%) }',
'   }',
'}',
'',
'}',
'/***************************************************************/',
'',
'.time-publicacao{',
'    margin-left: 20px;',
'    margin-right: 20px;',
'}',
'',
'',
'.time-titulo {',
'  margin-bottom: 0px;',
'    display: block;',
'    padding-top: 10px;',
'    text-decoration: none;',
'    color: #02629f; /*gray;*/',
'    font-size: 12px;',
'    text-transform: uppercase;',
'}',
'',
'.time-cargo{',
'    border-radius: 100px;',
'    display: inline-block;',
'    margin-left: 10px;',
'    font-size: 10px;',
'    padding: 2px 10px 2px 10px;',
'    color: #fff;',
'    /*background: #ababab;*/',
'    background: #02629f;',
'    float: right;',
'}',
'',
'.time-descricao {',
'',
'    font-size: 10px;',
'    color: #676767;',
'    padding: 5px;',
'    /*box-shadow: 0 1px 0 0 rgba(0, 0, 0, 0.1);*/',
'}',
'',
'p {',
'margin: 0 0 0rem !important;',
'}',
'',
'hr.style {',
'    margin-top: 0px !important;',
'    border: 0;',
'    height: 0;',
'    border-top: 1px solid rgba(0, 0, 0, 0.1);',
'    border-bottom: 1px solid rgba(255, 255, 255, 0.3);',
'}'))
,p_step_template=>wwv_flow_api.id(145492001125385058503)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_upd_yyyymmddhh24miss=>'20241112163104'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(137300267898776853898)
,p_name=>'Time'
,p_template=>wwv_flow_api.id(145492017240415058580)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--horizontalBorders'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ordem,',
'nvl(p.nome_social,p.nome) nome,',
'case when nvl((select dbms_lob.getlength(f.foto)',
'         from fotos f',
'        where cod_empresa = i.cod_empresa',
'          and matricula   = i.matricula',
'          ), 0) > 0 then',
'       ''<img src="'' ||',
'       ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'       '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'       ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'       ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'       case when i.cod_empresa = cs.cod_emp_gestor and i.matricula = cs.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'            else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'     else',
'       ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'       case when i.cod_empresa = cs.cod_emp_gestor and i.matricula = cs.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'            else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'     end Foto,',
'''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = cs.cod_emp_gestor and i.matricula = cs.matricula_gestor then ''<small> | SUPERIOR </small><span aria-hidden="true" class="fa'
||' fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'case when length(i.celular) = 8 then',
' trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'when length(i.celular) = 9 then',
' trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'else',
'null',
'end ||',
'case when cs.fone is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(cs.ddd)||'') ''||case when length(cs.fone) > 8 then substr(cs.fone,0,5)||''-''||substr(cs.fone,6,4) else substr(cs.fone,0,4'
||unistr(')||''-''||substr(cs.fone,5,4) end ||case when cs.ramal1 is not null then '' Ramal: ''||cs.ramal1 end || case when cs.ramal2 is not null then '' ou ''||cs.ramal2 end ||'' - \00C1rea''||''<br>'' end ||'),
'case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) else sub'
||'str(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) else sub'
||'str(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'nome_cargo',
'from centro_de_custo cs',
', informacoes_funcionais_cad i',
', inf_pessoais_cad p',
', filiais_cad f',
'where  i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.matricula = p.matricula   ',
'   and i.filial = f.cod_filial',
'   and i.situacao < ''90''',
'   and cs.matricula_gestor = i.matricula',
'   and cs.COD_EMP_GESTOR = i.cod_empresa',
'   AND cs.cod_empresa = :P_EMPRESA_USER',
'   and cs.cod = :p_ccusto_user   ',
'AND NOT EXISTS (SELECT 1 FROM centro_de_custo cs3 WHERE CS3.matricula_gestor = :P_MATRICULA_USER AND CS3.COD_EMP_GESTOR = :P_EMPRESA_USER AND cs3.cod = :p_ccusto_user AND cs3.cod_empresa = :P_EMPRESA_USER)  ',
'union all',
'select 2 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = cs.cod_emp_gestor and i.matricula = cs.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = cs.cod_emp_gestor and i.matricula = cs.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
'       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = cs.cod_emp_gestor and i.matricula = cs.matricula_gestor then ''<small> | SUPERIOR </small><span aria-hidden="true" cl'
||'ass="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'       case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when cs.fone is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(cs.ddd)||'') ''||case when length(cs.fone) > 8 then substr(cs.fone,0,5)||''-''||substr(cs.fone,6,4) else substr(cs.f'
||unistr('one,0,4)||''-''||substr(cs.fone,5,4) end ||case when cs.ramal1 is not null then '' Ramal: ''||cs.ramal1 end || case when cs.ramal2 is not null then '' ou ''||cs.ramal2 end ||'' - \00C1rea''||''<br>'' end ||'),
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
'from centro_de_custo cs',
', informacoes_funcionais_cad i',
', inf_pessoais_cad p',
', filiais_cad f',
'where  i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.matricula = p.matricula   ',
'   and i.filial = f.cod_filial',
'   and i.situacao < ''90''',
'   and cs.matricula_gestor = i.matricula',
'   and cs.COD_EMP_GESTOR = i.cod_empresa',
'   AND cs.cod_empresa = :P_EMPRESA_USER',
'   and cs.cod = (select cs2.COD_CCUSTO_SUPERIOR',
'                from centro_de_custo cs2',
'                where cs2.cod = :p_ccusto_user',
'                AND cs2.cod_empresa = :P_EMPRESA_USER)',
'AND EXISTS (SELECT 1 FROM centro_de_custo cs3 WHERE CS3.matricula_gestor = :P_MATRICULA_USER AND CS3.COD_EMP_GESTOR = :P_EMPRESA_USER AND cs3.cod = :p_ccusto_user AND cs3.cod_empresa = :P_EMPRESA_USER) ',
'UNION',
'select 3 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = cs.COD_EMP_SUPLENTE and i.matricula = cs.MATRICULA_SUPLENTE then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = cs.COD_EMP_SUPLENTE and i.matricula = cs.MATRICULA_SUPLENTE then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
'       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = cs.COD_EMP_SUPLENTE and i.matricula = cs.MATRICULA_SUPLENTE then ''<small> | SUPLENTE </small><span aria-hidden="true'
||'" class="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'       case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when cs.fone is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(cs.ddd)||'') ''||case when length(cs.fone) > 8 then substr(cs.fone,0,5)||''-''||substr(cs.fone,6,4) else substr(cs.f'
||unistr('one,0,4)||''-''||substr(cs.fone,5,4) end ||case when cs.ramal1 is not null then '' Ramal: ''||cs.ramal1 end || case when cs.ramal2 is not null then '' ou ''||cs.ramal2 end ||'' - \00C1rea''||''<br>'' end ||'),
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
'from centro_de_custo cs',
', informacoes_funcionais_cad i',
', inf_pessoais_cad p',
', filiais_cad f',
'where  i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.matricula = p.matricula   ',
'   and i.filial = f.cod_filial',
'--   and i.situacao < ''90''',
'   and cs.MATRICULA_SUPLENTE = i.matricula',
'   and cs.COD_EMP_SUPLENTE = i.cod_empresa',
'   AND cs.cod_empresa = :P_EMPRESA_USER',
'   and cs.cod = :p_ccusto_user   ',
'AND NOT EXISTS (SELECT 1 FROM centro_de_custo cs3 WHERE CS3.matricula_gestor = :P_MATRICULA_USER AND CS3.COD_EMP_GESTOR = :P_EMPRESA_USER AND cs3.cod = :p_ccusto_user AND cs3.cod_empresa = :P_EMPRESA_USER)  ',
'union all',
'select 4 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = cs.COD_EMP_SUPLENTE and i.matricula = cs.MATRICULA_SUPLENTE then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = cs.COD_EMP_SUPLENTE and i.matricula = cs.MATRICULA_SUPLENTE then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
'       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = cs.COD_EMP_SUPLENTE and i.matricula = cs.MATRICULA_SUPLENTE then ''<small> | SUPLENTE </small><span aria-hidden="true'
||'" class="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'       case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when cs.fone is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(cs.ddd)||'') ''||case when length(cs.fone) > 8 then substr(cs.fone,0,5)||''-''||substr(cs.fone,6,4) else substr(cs.f'
||unistr('one,0,4)||''-''||substr(cs.fone,5,4) end ||case when cs.ramal1 is not null then '' Ramal: ''||cs.ramal1 end || case when cs.ramal2 is not null then '' ou ''||cs.ramal2 end ||'' - \00C1rea''||''<br>'' end ||'),
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
'from centro_de_custo cs',
', informacoes_funcionais_cad i',
', inf_pessoais_cad p',
', filiais_cad f',
'where  i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.matricula = p.matricula   ',
'   and i.filial = f.cod_filial',
'   and i.situacao < ''90''',
'   and cs.MATRICULA_SUPLENTE = i.matricula',
'   and cs.COD_EMP_SUPLENTE = i.cod_empresa',
'   AND cs.cod_empresa = :P_EMPRESA_USER',
'   and cs.cod = (select cs2.COD_CCUSTO_SUPERIOR',
'                from centro_de_custo cs2',
'                where cs2.cod = :p_ccusto_user',
'                AND cs2.cod_empresa = :P_EMPRESA_USER)',
'AND EXISTS (SELECT 1 FROM centro_de_custo cs3 WHERE CS3.matricula_gestor = :P_MATRICULA_USER AND CS3.COD_EMP_GESTOR = :P_EMPRESA_USER AND cs3.cod = :p_ccusto_user AND cs3.cod_empresa = :P_EMPRESA_USER) ',
'union',
'select 5 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = sb.cod_emp_gestor and i.matricula = sb.MAT_GESTOR then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = sb.cod_emp_gestor and i.matricula = sb.MAT_GESTOR then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
'       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = sb.cod_emp_gestor and i.matricula = sb.MAT_GESTOR then ''<small> | GESTOR SUB CENTRO DE CUSTO </small><span aria-hidd'
||'en="true" class="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'       case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
' FROM sub_ccusto sb',
'   ,  informacoes_funcionais_cad i',
'   ,  filiais_cad f',
'   ,  inf_pessoais_cad p',
'where sb.cod_empresa = :p_empresa_user',
'and sb.cod_ccusto = :p_ccusto_user',
'and i.cod_empresa = p.cod_empresa',
'and i.matricula = p.matricula  ',
'and i.cod_empresa = f.cod_empresa',
'and i.filial = f.cod_filial',
'and i.situacao < ''90''',
'and i.matricula = sb.MAT_GESTOR',
'and i.cod_empresa = sb.COD_EMP_GESTOR  ',
'AND exists (SELECT 1',
'              FROM informacoes_funcionais_cad P',
'             WHERE P.MATRICULA   = :P_MATRICULA_USER ',
'               AND p.cod_empresa = :p_empresa_user ',
'               AND p.cod_sub_ccusto = sb.COD_SUB_CCUSTO',
'               and p.cod_ccusto = sb.cod_ccusto)',
'union',
'select 6 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = sb.COD_EMP_SUBS and i.matricula = sb.MAT_SUBS then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = sb.COD_EMP_SUBS and i.matricula = sb.MAT_SUBS then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
'       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = sb.COD_EMP_SUBS and i.matricula = sb.MAT_SUBS then ''<small> | SUPLENTE DO SUB CENTRO DE CUSTO </small><span aria-hid'
||'den="true" class="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'       case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
' FROM sub_ccusto sb',
'   ,  informacoes_funcionais_cad i',
'   ,  filiais_cad f',
'   ,  inf_pessoais_cad p',
'where sb.cod_empresa = :p_empresa_user',
'and sb.cod_ccusto = :p_ccusto_user',
'and i.cod_empresa = p.cod_empresa',
'and i.matricula = p.matricula  ',
'and i.cod_empresa = f.cod_empresa',
'and i.filial = f.cod_filial',
'and i.situacao < ''90''',
'and i.matricula = sb.MAT_SUBS',
'and i.cod_empresa = sb.COD_EMP_SUBS  ',
'AND exists (SELECT 1',
'              FROM informacoes_funcionais_cad P',
'             WHERE P.MATRICULA   = :P_MATRICULA_USER ',
'               AND p.cod_empresa = :p_empresa_user ',
'               AND p.cod_sub_ccusto = sb.COD_SUB_CCUSTO',
'               and p.cod_ccusto = sb.cod_ccusto) ',
'union',
'select  7 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
unistr('       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor then ''<small> | RESPONS\00C1VEL </small><span aria-hidden="true" c')
||'lass="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'       case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when c.fone is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(c.ddd)||'') ''||case when length(c.fone) > 8 then substr(c.fone,0,5)||''-''||substr(c.fone,6,4) else substr(c.fone,0,'
||unistr('4)||''-''||substr(c.fone,5,4) end ||case when c.ramal1 is not null then '' Ramal: ''||c.ramal1 end || case when c.ramal2 is not null then '' ou ''||c.ramal2 end ||'' - \00C1rea''||''<br>'' end ||'),
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
'  from informacoes_funcionais_cad i,',
'       filiais_cad f,',
'       inf_pessoais_cad p,',
'       centro_de_custo c',
' where i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.cod_empresa = c.cod_empresa',
'   and i.filial = f.cod_filial',
'   and i.cod_ccusto = c.cod',
'   and i.matricula = p.matricula',
'   and i.situacao < ''90''',
'   and c.cod_empresa = :p_empresa_user',
'   and c.cod = :p_ccusto_user',
'   and i.cod_empresa = c.cod_emp_gestor',
'   and i.matricula = c.matricula_gestor',
'union',
'select 8 ordem,',
'        nvl(p.nome_social,p.nome) nome,',
'        case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = i.cod_empresa',
'                  and matricula   = i.matricula',
'                  ), 0) > 0 then',
'               ''<img src="'' ||',
'               ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || i.cod_empresa || ''|'' || i.matricula ||',
'               ''" title="'' || initcap(fnct_nome_func(i.cod_empresa, i.matricula))  || ''" class="fotoColabSmall" '' ||',
'               case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             else',
'               ''<img src="#WORKSPACE_IMAGES#PROFILE.jpg" class="fotoColabSmall"'' ||',
'               case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor then ''style="margin: auto;background-color: white; box-shadow: 0 0 0 3px #c95788 !important;"'' ',
'                    else ''style="margin: auto;background-color: white;"'' end ||''/>''',
'             end Foto,',
unistr('       ''<p><h4><strong style="color:#511b76;">''||Initcap(initcap(nvl(p.nome_social,p.nome)))||''</strong>''|| case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor then ''<small> | RESPONS\00C1VEL </small><span aria-hidden="true" c')
||'lass="fa fa-star" style="color: #c95788;"></span>'' end|| ''</h4></p><b>''||upper(fnct_nome_cargo(i.cargo))||''</b>''||''<br><br>''|| ',
'      ',
'	  case when i.e_mail is not null then ''<span class="fa fa-envelope-o" aria-hidden="true" style="color: #c95788;"></span> ''||lower(i.e_mail)||''<br><br>'' end ||',
'       case when length(i.celular) = 8 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4))||'' - Celular''||''<br>'' ',
'       when length(i.celular) = 9 then',
'         trim(''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(i.ddd)||'') ''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4))||'' - Celular''||''<br>'' ',
'       else',
'       null',
'       end ||',
'       case when c.fone is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(c.ddd)||'') ''||case when length(c.fone) > 8 then substr(c.fone,0,5)||''-''||substr(c.fone,6,4) else substr(c.fone,0,'
||unistr('4)||''-''||substr(c.fone,5,4) end ||case when c.ramal1 is not null then '' Ramal: ''||c.ramal1 end || case when c.ramal2 is not null then '' ou ''||c.ramal2 end ||'' - \00C1rea''||''<br>'' end ||'),
'       case when f.telefone1 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone1) > 8 then substr(f.telefone1,0,5)||''-''||substr(f.telefone1,6,4) e'
||'lse substr(f.telefone1,0,4)||''-''||substr(f.telefone1,5,4) end ||'' - Filial''||''<br>'' end ||',
'       case when f.telefone2 is not null then ''<span aria-hidden="true" class="fa fa-phone" style="color: #c95788;"></span> ''||''(''||to_number(f.ddd)||'') ''||case when length(f.telefone2) > 8 then substr(f.telefone2,0,5)||''-''||substr(f.telefone2,6,4) e'
||'lse substr(f.telefone2,0,4)||''-''||substr(f.telefone2,5,4) end ||'' - Filial''||''<br>'' end ',
'       nome_cargo',
'  from informacoes_funcionais_cad i,',
'       filiais_cad f,',
'       inf_pessoais_cad p,',
'       centro_de_custo c',
' where i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.cod_empresa = c.cod_empresa',
'   and i.filial = f.cod_filial',
'   and i.cod_ccusto = c.cod',
'   and i.matricula = p.matricula',
'   and i.situacao < ''90''',
'   and c.cod_empresa = :p_empresa_user',
'   and c.cod = :p_ccusto_user',
'   and i.matricula <> c.matricula_gestor   ',
'order by 1,2;'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from onboarding o, informacoes_funcionais_cad i',
' where i.cod_empresa = :p_empresa_user',
'   and i.matricula = :p_matricula_user',
'   and ((:p2500_SEQ is null ',
'    and (',
'         (o.empresas      is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.empresas, '','')) t))',
'     and (o.filiais      is null or i.filial  in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.filiais, '','')) t))',
'     and (o.centros_custos      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.centros_custos, '','')) t))',
'     and (o.unidade_adm is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.unidade_adm, '','')) t))',
'     and (o.cargos       is null or i.cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.cargos, '','')) t))',
'     and (o.painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.painel, '','')) t))',
'     and (:p2500_cod_categoria is null or o.categoria = :p2500_cod_categoria)',
'   and o.postar = ''S''',
'   and o.mostrar_time = ''S''',
'   and trunc(sysdate) between nvl(o.dt_validade_ini,trunc(sysdate)) and nvl(o.dt_validade_fim,trunc(sysdate)))) ',
'  or o.seq = :P2500_SEQ)'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(145492026051969058596)
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>999
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(137300550118275746467)
,p_query_column_id=>1
,p_column_alias=>'ORDEM'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(137300550230300746468)
,p_query_column_id=>2
,p_column_alias=>'NOME'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(137300268044480853899)
,p_query_column_id=>3
,p_column_alias=>'FOTO'
,p_column_display_sequence=>1
,p_column_heading=>'Foto'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(137300268837494853907)
,p_query_column_id=>4
,p_column_alias=>'NOME_CARGO'
,p_column_display_sequence=>2
,p_column_heading=>'Nome Cargo'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(144380539867112872304)
,p_name=>'Categorias'
,p_template=>wwv_flow_api.id(145492017240415058580)
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Cards--basic:t-Cards--float:t-Cards--hideBody:t-Cards--animColorFill'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       c.nome card_title,',
'       c.cod,',
'       o.seq,',
'       o.ordem,',
'apex_page.get_url (',
'            p_page        => 2500,',
'            p_items       => ''P2500_COD_CATEGORIA'',',
'            p_values      => c.cod,',
'            p_clear_cache => 2500',
'            ) card_link,',
'    case when c.cod = :p2500_cod_categoria then ''u-info'' else ''u-normal'' end card_color',
'  from onboarding o, onboarding_categoria c',
' where o.categoria = c.cod',
'   and (o.empresas      is null or :p2500_cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.empresas, '','')) t))',
'   and (o.filiais      is null or :p2500_filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.filiais, '','')) t))',
'   and (o.centros_custos      is null or :p2500_cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.centros_custos, '','')) t))',
'   and (o.unidade_adm is null or :p2500_unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.unidade_adm, '','')) t))',
'   and (o.cargos       is null or :p2500_cod_cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.cargos, '','')) t))',
'   and (o.painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.painel, '','')) t))',
'   and (:p2500_cod_categoria is null or c.cod = :p2500_cod_categoria)',
'   and o.postar = ''S''',
'   and trunc(sysdate) between nvl(o.dt_validade_ini,trunc(sysdate)) and nvl(o.dt_validade_fim,trunc(sysdate))',
' order by o.ordem, o.seq desc'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(145492023480377058594)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(144380540413027872309)
,p_query_column_id=>1
,p_column_alias=>'CARD_TITLE'
,p_column_display_sequence=>4
,p_column_heading=>'Card Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(144380540062527872306)
,p_query_column_id=>2
,p_column_alias=>'COD'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(144380540208973872307)
,p_query_column_id=>3
,p_column_alias=>'SEQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(144380540251099872308)
,p_query_column_id=>4
,p_column_alias=>'ORDEM'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(144380540699056872312)
,p_query_column_id=>5
,p_column_alias=>'CARD_LINK'
,p_column_display_sequence=>5
,p_column_heading=>'Card Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(144380540827374872313)
,p_query_column_id=>6
,p_column_alias=>'CARD_COLOR'
,p_column_display_sequence=>6
,p_column_heading=>'Card Color'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(144380540887671872314)
,p_plug_name=>'Categorias'
,p_region_name=>'CATEGORIAS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_02'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       c.nome categoria,',
'       c.cod,',
'       o.seq,',
'       o.ordem,',
'apex_page.get_url (',
'            p_page        => 2500,',
'            p_items       => ''P2500_COD_CATEGORIA'',',
'            p_values      => c.cod,',
'            p_clear_cache => 2500',
'            ) link',
'  from onboarding o, onboarding_categoria c',
' where o.categoria = c.cod',
'   and (o.empresas      is null or :p2500_cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.empresas, '','')) t))',
'   and (o.filiais      is null or :p2500_filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.filiais, '','')) t))',
'   and (o.centros_custos      is null or :p2500_cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.centros_custos, '','')) t))',
'   and (o.unidade_adm is null or :p2500_unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.unidade_adm, '','')) t))',
'   and (o.cargos       is null or :p2500_cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.cargos, '','')) t))',
'   and (o.painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.painel, '','')) t))',
'   and o.postar = ''S''',
'   and trunc(sysdate) between nvl(o.dt_validade_ini,trunc(sysdate)) and nvl(o.dt_validade_fim,trunc(sysdate))',
' order by o.ordem, o.seq desc'))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select count(c.cod) qtd',
'  from onboarding o, onboarding_categoria c',
' where o.categoria = c.cod',
'   and (o.empresas      is null or :p2500_cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.empresas, '','')) t))',
'   and (o.filiais      is null or :p2500_filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.filiais, '','')) t))',
'   and (o.centros_custos      is null or :p2500_cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.centros_custos, '','')) t))',
'   and (o.unidade_adm is null or :p2500_unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.unidade_adm, '','')) t))',
'   and (o.cargos       is null or :p2500_cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.cargos, '','')) t))',
'   and (o.painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.painel, '','')) t))',
'   and o.postar = ''S''',
'   and trunc(sysdate) between nvl(o.dt_validade_ini,trunc(sysdate)) and nvl(o.dt_validade_fim,trunc(sysdate));',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if nvl(v_c1.qtd,0) > 1 then',
'return true;',
'else',
'return true;--false;',
'end if;',
'',
'end;'))
,p_attribute_02=>'CATEGORIA'
,p_attribute_16=>'f?p=&APP_ID.:2500:&SESSION.::&DEBUG.:RP,2500:P2500_COD_CATEGORIA:&COD.'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(144380541016151872315)
,p_plug_name=>'OnBoarding | &P2500_TITULO.'
,p_icon_css_classes=>'fa-user-play'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492015665327058577)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('Veja as instru\00E7\00F5es para sua nova etapa.')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(152377639728737061922)
,p_plug_name=>unistr('Publica\00E7\00F5es')
,p_region_name=>'PUBLICACOES'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_usuario is',
'select i.cod_empresa, ',
'       fnct_nome_empresa(i.cod_empresa, ''S'') empresa,',
'       i.filial cod_filial, ',
'       fnct_nome_filial(i.cod_empresa, i.filial, ''S'') filial,',
'       i.cod_ccusto, ',
'       fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto) ccusto,',
'       i.unidade_adm cod_unidade_adm, ',
'       Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade,',
'       INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       i.cargo cod_cargo,',
'       fnct_nome_cargo(i.cargo) cargo,',
'       i.matricula,',
'       initcap(substr(nvl(p.nome_social,p.nome),0,instr(nvl(p.nome_social,p.nome),'' '')-1)) primeiro_nome,',
'       initcap(nvl(p.nome_social,p.nome)) nome,',
'       initcap(i.nome_de_guerra) apelido,',
'       i.e_mail email,',
'       case when length(i.celular) = 8 then',
'         trim(''(''||i.ddd||'')''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4)) ',
'       when length(i.celular) = 9 then',
'         trim(''(''||i.ddd||'')''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4)) ',
'       end telefone/*,',
'       initcap(fnct_retorna_gestor(i.cod_empresa, i.matricula)) nome_gestor*/',
'  from informacoes_funcionais i, ',
'       inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = :p_empresa_user',
'   and i.matricula = :p_matricula_user;',
'       ',
'v_usuario c_usuario%rowtype;',
' ',
'v_emp_gestor number(3);',
'v_mat_gestor informacoes_funcionais.matricula%type;',
' ',
'cursor c_gestor(v_emp number, v_mat number) is',
'select i.cod_empresa, ',
'       fnct_nome_empresa(i.cod_empresa, ''S'') empresa,',
'       i.filial cod_filial, ',
'       fnct_nome_filial(i.cod_empresa, i.filial, ''S'') filial,',
'       i.cod_ccusto, ',
'       fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto) ccusto,',
'       i.unidade_adm cod_unidade_adm, ',
'       Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade,',
'       INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       i.cargo cod_cargo,',
'       fnct_nome_cargo(i.cargo) cargo,',
'       i.matricula,',
'       initcap(substr(nvl(p.nome_social,p.nome),0,instr(nvl(p.nome_social,p.nome),'' '')-1)) primeiro_nome,',
'       initcap(nvl(p.nome_social,p.nome)) nome,',
'       initcap(i.nome_de_guerra) apelido,',
'       i.e_mail email,',
'       case when length(i.celular) = 8 then',
'         trim(''(''||i.ddd||'')''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4)) ',
'       when length(i.celular) = 9 then',
'         trim(''(''||i.ddd||'')''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4)) ',
'       end telefone,',
'       initcap(fnct_retorna_gestor(i.cod_empresa, i.matricula)) nome_gestor',
'  from informacoes_funcionais i, ',
'       inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = v_emp',
'   and i.matricula = v_mat;',
'       ',
'v_gestor c_gestor%rowtype;',
'',
'cursor c_time (v_emp number, v_fil number, v_cc number) is',
'select i.cod_empresa,',
'       i.cargo cod_cargo,',
'       fnct_nome_cargo(i.cargo) cargo,',
'       i.matricula,',
'       initcap(substr(nvl(p.nome_social,p.nome),0,instr(nvl(p.nome_social,p.nome),'' '')-1)) primeiro_nome,',
'       initcap(nvl(p.nome_social,p.nome)) nome,',
'       initcap(i.nome_de_guerra) apelido,',
'       i.e_mail email,',
'       case when length(i.celular) = 8 then',
'         trim(''(''||i.ddd||'')''||substr(i.celular,0,4)||''-''||substr(i.celular,5,4)) ',
'       when length(i.celular) = 9 then',
'         trim(''(''||i.ddd||'')''||substr(i.celular,0,5)||''-''||substr(i.celular,6,4)) ',
'       end telefone',
'  from informacoes_funcionais i, ',
'       inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = v_emp',
'   and i.filial = v_fil',
'   and i.cod_ccusto = v_cc',
'   and i.situacao < ''90''',
' order by nvl(p.nome_social,p.nome);',
'',
'  cursor c_publicacoes (v_emp number, v_fil number, v_cc number, v_unid_adm number, v_cargo varchar2) is',
'    select seq,',
'           titulo,',
'           sub_titulo, ',
'           dt_validade_ini,',
'           (select nome || '' '' || descricao',
'              from onboarding_categoria',
'             where cod = categoria) categoria,',
'           descricao,',
'           texto_html,',
'           nvl(dbms_lob.getlength(imagem), 0)  imagem1,',
'           nvl(dbms_lob.getlength(imagem2), 0) imagem2,',
'           nvl(dbms_lob.getlength(imagem3), 0) imagem3,',
'           nvl(dbms_lob.getlength(imagem4), 0) imagem4,',
'           tipo_imagem, tipo_imagem2, tipo_imagem3, tipo_imagem4,',
'           nome_arquivo, nome_arquivo2, nome_arquivo3, nome_arquivo4,',
'           mostrar_time',
'      from onboarding',
'     where ((:p2500_SEQ is null ',
'       and (',
'      (empresas      is null or v_emp   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(empresas, '','')) t))',
'  and (filiais      is null or v_fil        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(filiais, '','')) t))',
'  and (centros_custos      is null or v_cc    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(centros_custos, '','')) t))',
'  and (unidade_adm is null or v_unid_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(unidade_adm, '','')) t))',
'  and (cargos       is null or v_cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(cargos, '','')) t))',
'  and (painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(painel, '','')) t))',
'  and (:p2500_cod_categoria is null or categoria = :p2500_cod_categoria)',
'  and postar = ''S''',
'  and trunc(sysdate) between nvl(dt_validade_ini,trunc(sysdate)) and nvl(dt_validade_fim,trunc(sysdate)))) ',
'   or seq = :P2500_SEQ)',
'  order by ordem, seq desc;',
'',
'  function getUrl(p_seq in number,',
'                  p_n   in number,',
'                  p_tipo in varchar2) return varchar2 is',
'  begin',
'  ',
'  if p_tipo <> ''application/pdf'' then',
'    return ''apex_application.show?'' ||',
'           ''p_flow_id='' || :APP_ID || chr(38) ||',
'           ''p_flow_step_id='' || :APP_PAGE_ID || chr(38) ||',
'           ''p_instance='' || :APP_SESSION || chr(38) ||',
'           ''p_request='' || ''APPLICATION_PROCESS=getBlogImg'' || chr(38) ||',
'           ''x01='' || p_seq || chr(38) ||',
'           ''x02='' || p_n;',
'   else',
'    return ''apex_application.show?'' ||',
'           ''p_flow_id='' || :APP_ID || chr(38) ||',
'           ''p_flow_step_id='' || :APP_PAGE_ID || chr(38) ||',
'           ''p_instance='' || :APP_SESSION || chr(38) ||',
'           ''p_request='' || ''APPLICATION_PROCESS=RENDER_PDF'' || chr(38) ||',
'           ''x01='' || p_seq || chr(38) ||',
'           ''x02='' || p_n;',
'   end if;',
'  end getUrl;',
'  ',
'  function getFotoUrl(p_emp in number,',
'                      p_mat   in number) return varchar2 is',
'  begin',
'    return ''apex_application.show?'' ||',
'           ''p_flow_id='' || :APP_ID || chr(38) ||',
'           ''p_flow_step_id='' || :APP_PAGE_ID || chr(38) ||',
'           ''p_instance='' || :APP_SESSION || chr(38) ||',
'           ''p_request='' || ''APPLICATION_PROCESS=getBlogFoto'' || chr(38) ||',
'           ''x01='' || p_emp|| chr(38) ||',
'           ''x02='' || p_mat;',
'  end getFotoUrl;',
'',
'  procedure print_media(p_seq  in number,',
'                        p_n    in number,',
'                        p_tipo in varchar2,',
'                        p_nome in varchar2) is',
'  begin',
'      if instr(p_tipo, ''video'') > 0 then',
'        htp.prn(''<div class="video">'');',
'          htp.prn(''<video width="100%" height="425" controls controlsList="nodownload">'');',
'            htp.prn(''<source src="'' || getUrl(p_seq, p_n, p_tipo) || ''" type="'' || p_tipo || ''"></source>'');',
'          htp.prn(''</video>'');',
'        htp.prn(''</div>'');',
'      elsif instr(p_tipo, ''image'') > 0 then',
'        htp.prn(''<div class="imagem">'');',
'          htp.prn(''<img src="'' || getUrl(p_seq, p_n, p_tipo) || ''">'');',
'        htp.prn(''</div>'');',
'      elsif instr(p_tipo, ''pdf'') > 0 then',
'        htp.prn(''<div class="imagem">'');',
'          htp.prn(''<iframe src="''|| getUrl(p_seq, p_n, p_tipo) ||''" type="application/pdf" style="width: 100%; height: 517px; border: 0px"></iframe>'');',
'        htp.prn(''</div>'');',
'      else',
'      htp.prn(''<h8>Anexos:</h8>'');',
'        htp.prn(''<div class="download">'');',
'          htp.prn(''<a href="'' || getUrl(p_seq, p_n, p_tipo) || ''" target="_blank"><span class="fa fa-download" aria-hidden="true"></span>&nbsp;<span class="text_link">'' || p_nome || ''</span></a>'');',
'        htp.prn(''</div>'');',
'      end if;',
'  end print_media;',
'begin',
'',
'open c_usuario;',
'fetch c_usuario into v_usuario;',
'close c_usuario;',
'',
' v_emp_gestor := trim(substr (fnct_retorna_cod_gestor(:p_empresa_user, :p_matricula_user),0,',
'        (instr(fnct_retorna_cod_gestor(:p_empresa_user, :p_matricula_user),''_'')-1)',
'        ));',
' v_mat_gestor := trim(replace(fnct_retorna_cod_gestor(:p_empresa_user, :p_matricula_user),v_emp_gestor||''_''));',
'',
'open c_gestor(v_emp_gestor, v_mat_gestor);',
'fetch c_gestor into v_gestor;',
'close c_gestor;',
'',
'  for p in c_publicacoes(v_usuario.cod_empresa, v_usuario.cod_filial, v_usuario.cod_ccusto, v_usuario.cod_unidade_adm, v_usuario.cod_cargo) loop',
'    htp.prn(''<div class="publicacao" id="publicacao_'' || p.seq || ''">'');',
'      htp.prn(''<div class="fix_titulo" style="display: none"></div>'');',
'      htp.prn(''<div class="titulo">'');',
'        htp.prn(''<h2 style="font-weight: 500 !important; color: #262626 !important; margin-top: 4px; margin-bottom: 4px;">'' || ',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'                  p.titulo',
'            ,''#NOME_COLAB'',V_USUARIO.NOME)',
'            ,''#PRIMEIRO_NOME_COLAB'',V_USUARIO.PRIMEIRO_NOME)',
'            ,''#APELIDO_COLAB'',V_USUARIO.APELIDO)',
'            ,''#EMAIL_COLAB'',V_USUARIO.EMAIL)',
'            ,''#TELEFONE_COLAB'',V_USUARIO.TELEFONE)',
'            ,''#EMPRESA_COLAB'',V_USUARIO.EMPRESA)',
'            ,''#FILIAL_COLAB'',V_USUARIO.FILIAL)',
'            ,''#CCUSTO_COLAB'',V_USUARIO.CCUSTO)',
'            ,''#CARGO_COLAB'',V_USUARIO.CARGO)',
'            ,''#MATRICULA_COLAB'',V_USUARIO.MATRICULA)',
'            ,''#NOME_GESTOR'',V_GESTOR.NOME)',
'            ,''#PRIMEIRO_NOME_GESTOR'',V_GESTOR.PRIMEIRO_NOME)',
'            ,''#APELIDO_GESTOR'',V_GESTOR.APELIDO)',
'            ,''#EMAIL_GESTOR'',V_GESTOR.EMAIL)',
'            ,''#TELEFONE_GESTOR'',V_GESTOR.TELEFONE)',
'            ,''#EMPRESA_GESTOR'',V_GESTOR.EMPRESA)',
'            ,''#FILIAL_GESTOR'',V_GESTOR.FILIAL)',
'            ,''#CCUSTO_GESTOR'',V_GESTOR.CCUSTO)',
'            ,''#CARGO_GESTOR'',V_GESTOR.CARGO)',
'            ,''#MATRICULA_GESTOR'',V_GESTOR.MATRICULA)',
'               ',
'               ',
'               );',
'        if trim(p.sub_titulo) is not null then',
'        htp.prn(''<i> - <font size="5">'' || ',
'                ',
'                ',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'                  p.sub_titulo',
'            ,''#NOME_COLAB'',V_USUARIO.NOME)',
'            ,''#PRIMEIRO_NOME_COLAB'',V_USUARIO.PRIMEIRO_NOME)',
'            ,''#APELIDO_COLAB'',V_USUARIO.APELIDO)',
'            ,''#EMAIL_COLAB'',V_USUARIO.EMAIL)',
'            ,''#TELEFONE_COLAB'',V_USUARIO.TELEFONE)',
'            ,''#EMPRESA_COLAB'',V_USUARIO.EMPRESA)',
'            ,''#FILIAL_COLAB'',V_USUARIO.FILIAL)',
'            ,''#CCUSTO_COLAB'',V_USUARIO.CCUSTO)',
'            ,''#CARGO_COLAB'',V_USUARIO.CARGO)',
'            ,''#MATRICULA_COLAB'',V_USUARIO.MATRICULA)',
'            ,''#NOME_GESTOR'',V_GESTOR.NOME)',
'            ,''#PRIMEIRO_NOME_GESTOR'',V_GESTOR.PRIMEIRO_NOME)',
'            ,''#APELIDO_GESTOR'',V_GESTOR.APELIDO)',
'            ,''#EMAIL_GESTOR'',V_GESTOR.EMAIL)',
'            ,''#TELEFONE_GESTOR'',V_GESTOR.TELEFONE)',
'            ,''#EMPRESA_GESTOR'',V_GESTOR.EMPRESA)',
'            ,''#FILIAL_GESTOR'',V_GESTOR.FILIAL)',
'            ,''#CCUSTO_GESTOR'',V_GESTOR.CCUSTO)',
'            ,''#CARGO_GESTOR'',V_GESTOR.CARGO)',
'            ,''#MATRICULA_GESTOR'',V_GESTOR.MATRICULA)',
'                || ''</font></i>'');',
'        end if;',
'        htp.prn(''</strong></h2>'');',
'       -- htp.prn(''<span class="categoria">'' || p.categoria || ''</span>'' );',
'      htp.prn(''</div>'');',
'      --',
'      -- htp.prn(''<hr class="style">'');',
'      --',
'      if p.imagem1 > 0 then',
'        print_media(p.seq, 1, p.tipo_imagem, p.nome_arquivo);',
'      end if;',
'      --',
'      if p.imagem2 > 0 then',
'        print_media(p.seq, 2, p.tipo_imagem2, p.nome_arquivo2);',
'      end if;',
'      --',
'      if p.imagem3 > 0 then',
'        print_media(p.seq, 3, p.tipo_imagem3, p.nome_arquivo3);',
'      end if;',
'      --',
'      if p.imagem4 > 0 then',
'        print_media(p.seq, 4, p.tipo_imagem4, p.nome_arquivo4);',
'      end if;',
'      --',
'      if trim(p.texto_html) is not null then',
'      htp.prn(''<div class="descricao">'');',
'        htp.prn(p.texto_html);',
'      htp.prn(''</div>'');',
'      end if;',
'      ',
'      if trim(p.descricao) is not null then',
'      htp.prn(''<div class="descricao">'');',
'        htp.prn(',
'          ',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'          replace(',
'                  p.descricao',
'            ,''#NOME_COLAB'',V_USUARIO.NOME)',
'            ,''#PRIMEIRO_NOME_COLAB'',V_USUARIO.PRIMEIRO_NOME)',
'            ,''#APELIDO_COLAB'',V_USUARIO.APELIDO)',
'            ,''#EMAIL_COLAB'',V_USUARIO.EMAIL)',
'            ,''#TELEFONE_COLAB'',V_USUARIO.TELEFONE)',
'            ,''#EMPRESA_COLAB'',V_USUARIO.EMPRESA)',
'            ,''#FILIAL_COLAB'',V_USUARIO.FILIAL)',
'            ,''#CCUSTO_COLAB'',V_USUARIO.CCUSTO)',
'            ,''#CARGO_COLAB'',V_USUARIO.CARGO)',
'            ,''#MATRICULA_COLAB'',V_USUARIO.MATRICULA)',
'            ,''#NOME_GESTOR'',V_GESTOR.NOME)',
'            ,''#PRIMEIRO_NOME_GESTOR'',V_GESTOR.PRIMEIRO_NOME)',
'            ,''#APELIDO_GESTOR'',V_GESTOR.APELIDO)',
'            ,''#EMAIL_GESTOR'',V_GESTOR.EMAIL)',
'            ,''#TELEFONE_GESTOR'',V_GESTOR.TELEFONE)',
'            ,''#EMPRESA_GESTOR'',V_GESTOR.EMPRESA)',
'            ,''#FILIAL_GESTOR'',V_GESTOR.FILIAL)',
'            ,''#CCUSTO_GESTOR'',V_GESTOR.CCUSTO)',
'            ,''#CARGO_GESTOR'',V_GESTOR.CARGO)',
'            ,''#MATRICULA_GESTOR'',V_GESTOR.MATRICULA)',
'        );',
'      htp.prn(''</div>'');',
'     ',
'     end if;',
'/*   ',
'    if p.mostrar_time = ''S'' then -- time',
'   ',
'    htp.prn(''<div class="time-publicacao" style="width: 100%;margin: auto;">'');',
'      htp.prn(''<div class="time-fix_titulo" style="display: none"></div>'');',
'      htp.prn(''<div class="time-titulo">'');',
'      ',
'        for l_gestor in c_gestor (v_emp_gestor, v_mat_gestor)',
'        loop',
'          htp.prn(''<div style="box-shadow: 0px 1px 0px 0px rgba(0, 0, 0, 0.1); padding: 5px;">''||',
'                          ''&nbsp;''||',
'                  ''<span class="time-text_link">'' || l_gestor.nome || case when l_gestor.apelido is not null then '' ''||''"''||l_gestor.apelido||''"'' end ||'' <span aria-hidden="true" class="fa fa-star"></span>'' ||',
'                      ''<div class="time-cargo">''||initcap(l_gestor.cargo) ||''</div>''||          ',
'                      case when l_gestor.email is not null then ''<div class="time-descricao">''||''<span class="fa fa-envelope-o" aria-hidden="true"></span>''||'' ''|| l_gestor.email||''</div>'' end||',
'                      case when l_gestor.telefone is not null then ''<div class="time-descricao">''||''<span aria-hidden="true" class="fa fa-phone"></span>''||'' ''|| l_gestor.telefone||''</div>'' end||',
'                       ',
'                  ''</span>''||',
'                  ''</div>'');',
'        end loop;',
'',
'        for l_time in c_time (v_usuario.cod_empresa, v_usuario.cod_filial, v_usuario.cod_ccusto)',
'        loop',
'        ',
'           if l_time.cod_empresa = v_emp_gestor and l_time.matricula = v_mat_gestor then',
'              null;',
'           else',
'          htp.prn(''<div style="box-shadow: 0px 1px 0px 0px rgba(0, 0, 0, 0.1); padding: 5px;">''||',
'                          ''&nbsp;''||',
'                    ''<span class="time-text_link">'' || l_time.nome || case when l_time.apelido is not null then '' ''||''"''||l_time.apelido||''" '' end||',
'                        ''<div class="time-cargo">''||initcap(l_time.cargo) ||''</div>''||          ',
'                      case when l_time.email is not null then ''<div class="time-descricao">''||''<span class="fa fa-envelope-o" aria-hidden="true"></span>''||'' ''|| l_time.email||''</div>'' end||',
'                      case when l_time.telefone is not null then ''<div class="time-descricao">''||''<span aria-hidden="true" class="fa fa-phone"></span>''||'' ''|| l_time.telefone||''</div>'' end||',
'',
'                    ''</span>''||',
'                    ''</div>'');',
'           end if;',
'        end loop;',
'',
'      htp.prn(''</div>'');',
'    htp.prn(''</div>'');   ',
'   ',
'    end if; -- time',
'*/',
'    htp.prn(''</div>'');',
'    --',
'    if nvl(p.mostrar_time,''N'') = ''N'' then',
'      htp.prn(''<hr class="style">'');',
'    end if;',
'    ',
'  end loop;',
'exception when others then null;',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(142702520880439285174)
,p_name=>'P2500_SEQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(142702521197083285170)
,p_name=>'P2500_OPENED'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144315056084245375447)
,p_name=>'P2500_COD_EMPRESA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144315056220824375448)
,p_name=>'P2500_FILIAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144315056311934375449)
,p_name=>'P2500_COD_CCUSTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144315056443163375450)
,p_name=>'P2500_UNIDADE_ADM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144315056483110375451)
,p_name=>'P2500_CARGO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144380540470168872310)
,p_name=>'P2500_COD_CATEGORIA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144380541108643872316)
,p_name=>'P2500_TITULO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(152377639728737061922)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(144315056613461375452)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Dados Colab'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select distinct',
'       c.cod',
'  from onboarding o, onboarding_categoria c',
' where o.categoria = c.cod',
'   and (o.empresas      is null or :p2500_cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.empresas, '','')) t))',
'   and (o.filiais      is null or :p2500_filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.filiais, '','')) t))',
'   and (o.centros_custos      is null or :p2500_cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.centros_custos, '','')) t))',
'   and (o.unidade_adm is null or :p2500_unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.unidade_adm, '','')) t))',
'   and (o.cargos       is null or :p2500_cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.cargos, '','')) t))',
'   and (o.painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.painel, '','')) t))',
'   and o.postar = ''S''',
'   and trunc(sysdate) between nvl(o.dt_validade_ini,trunc(sysdate)) and nvl(o.dt_validade_fim,trunc(sysdate))',
' order by o.ordem, o.seq desc;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'select cod_empresa,',
'       filial,',
'       cod_ccusto,',
'       unidade_adm,',
'       cargo',
'  into :p2500_cod_empresa,',
'       :p2500_filial,',
'       :p2500_cod_ccusto,',
'       :p2500_unidade_adm,',
'       :p2500_cargo',
'  from informacoes_funcionais',
' where cod_empresa = :p_empresa_user',
'   and matricula = :p_matricula_user',
'   and situacao < ''90'';',
'',
'/*if :p2500_cod_categoria is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p2500_cod_categoria := v_c1.cod;',
'',
'end if;',
'*/',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(144380541217808872317)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Categoria'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1(v_cod number) is',
'select distinct',
'       c.cod,',
'       c.nome nome_categoria,',
'       o.ordem,',
'       o.seq',
'  from onboarding o, onboarding_categoria c',
' where o.categoria = c.cod',
'   and (o.empresas      is null or :p2500_cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.empresas, '','')) t))',
'   and (o.filiais      is null or :p2500_filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.filiais, '','')) t))',
'   and (o.centros_custos      is null or :p2500_cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.centros_custos, '','')) t))',
'   and (o.unidade_adm is null or :p2500_unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.unidade_adm, '','')) t))',
'   and (o.cargos       is null or :p2500_cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.cargos, '','')) t))',
'   and (o.painel       is null or :p_painel     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(o.painel, '','')) t))',
'   and o.postar = ''S''',
'   and trunc(sysdate) between nvl(o.dt_validade_ini,trunc(sysdate)) and nvl(o.dt_validade_fim,trunc(sysdate))',
'   and (v_cod is null or c.cod = v_cod)',
' order by o.ordem, o.seq desc;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1(:p2500_cod_categoria);',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p2500_cod_categoria is null then',
'',
':p2500_cod_categoria := v_c1.cod;',
':p2500_titulo := v_c1.nome_categoria;',
'',
'else',
':p2500_titulo := v_c1.nome_categoria;',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(142702522286303284812)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'getBlogImg'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_blob blob;',
'  l_mime varchar2(255);',
'  l_name varchar2(255);',
'  --',
'  cursor c_imagem_1(p_seq in number) is',
'    select imagem,',
'           tipo_imagem,',
'           nome_arquivo',
'      from onboarding',
'     where seq = p_seq;',
'  --',
'  cursor c_imagem_2(p_seq in number) is',
'    select imagem2,',
'           tipo_imagem2,',
'           nome_arquivo2',
'      from onboarding',
'     where seq = p_seq;',
'  --',
'  cursor c_imagem_3(p_seq in number) is',
'    select imagem3,',
'           tipo_imagem3,',
'           nome_arquivo3',
'      from onboarding',
'     where seq = p_seq;',
'  --',
'  cursor c_imagem_4(p_seq in number) is',
'    select imagem4,',
'           tipo_imagem4,',
'           nome_arquivo4',
'      from onboarding',
'     where seq = p_seq;',
'begin',
'  case apex_application.g_x02',
'    when ''1'' then',
'      open c_imagem_1(apex_application.g_x01);',
'      fetch c_imagem_1 into l_blob, l_mime, l_name;',
'      close c_imagem_1;',
'    when ''2'' then',
'      open c_imagem_2(apex_application.g_x01);',
'      fetch c_imagem_2 into l_blob, l_mime, l_name;',
'      close c_imagem_2;',
'    when ''3'' then',
'      open c_imagem_3(apex_application.g_x01);',
'      fetch c_imagem_3 into l_blob, l_mime, l_name;',
'      close c_imagem_3;',
'    when ''4'' then',
'      open c_imagem_4(apex_application.g_x01);',
'      fetch c_imagem_4 into l_blob, l_mime, l_name;',
'      close c_imagem_4;',
'    else',
'      null;',
'  end case;',
'',
'  if nvl(dbms_lob.getlength(l_blob), 0) > 0 then',
unistr('    -- seta header de sess\00E3o'),
'    htp.init;',
'    owa_util.mime_header(l_mime, false);',
'    htp.p(''Content-Disposition: inline; filename="'' || l_name || ''"'');',
'    owa_util.http_header_close;',
'',
'    -- faz download',
'    sys.wpg_docload.download_file(l_blob);',
'    apex_application.stop_apex_engine;',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(142702521856520284815)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'getBlogFoto'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_blob blob;',
'  l_mime varchar2(255);',
'  l_name varchar2(255);',
'  --',
'  cursor c_imagem_1(p_emp in number, p_mat in number) is',
'  select foto, tipo, nome_foto',
'    from fotos',
'   where cod_empresa = p_emp',
'     and matricula = p_mat;',
'begin',
'',
'      open c_imagem_1(apex_application.g_x01, apex_application.g_x02);',
'      fetch c_imagem_1 into l_blob, l_mime, l_name;',
'      close c_imagem_1;',
'',
'  if nvl(dbms_lob.getlength(l_blob), 0) > 0 then',
unistr('    -- seta header de sess\00E3o'),
'    htp.init;',
'    owa_util.mime_header(l_mime, false);',
'    htp.p(''Content-Disposition: inline; filename="'' || l_name || ''"'');',
'    owa_util.http_header_close;',
'',
'    -- faz download',
'    sys.wpg_docload.download_file(l_blob);',
'    apex_application.stop_apex_engine;',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(137434111516124837088)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'RENDER_PDF'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_blob blob;',
'  l_len  number;',
'  --',
'  l_mime varchar2(255);',
'  l_name varchar2(255);',
'  --',
'',
'  cursor c_imagem_1(p_seq in number) is',
'    select imagem,',
'           tipo_imagem,',
'           nome_arquivo,',
'           dbms_lob.getlength(imagem) tamanho',
'      from onboarding',
'     where seq = p_seq;',
'  --',
'  cursor c_imagem_2(p_seq in number) is',
'    select imagem2,',
'           tipo_imagem2,',
'           nome_arquivo2,',
'           dbms_lob.getlength(imagem2) tamanho',
'      from onboarding',
'     where seq = p_seq;',
'  --',
'  cursor c_imagem_3(p_seq in number) is',
'    select imagem3,',
'           tipo_imagem3,',
'           nome_arquivo3,',
'           dbms_lob.getlength(imagem3) tamanho',
'      from onboarding',
'     where seq = p_seq;',
'  --',
'  cursor c_imagem_4(p_seq in number) is',
'    select imagem4,',
'           tipo_imagem4,',
'           nome_arquivo4,',
'           dbms_lob.getlength(imagem4) tamanho',
'      from onboarding',
'     where seq = p_seq;',
'     ',
'begin',
'',
'  --l_client_id := regexp_substr(apex_application.g_x01, ''[0-9]+'', 1, 1);',
'  --l_doc_code  := regexp_substr(apex_application.g_x01, ''[0-9]+'', 1, 2);',
'',
'  case apex_application.g_x02',
'    when ''1'' then',
'      open c_imagem_1(apex_application.g_x01);',
'      fetch c_imagem_1 into l_blob, l_mime, l_name, l_len;',
'      close c_imagem_1;',
'    when ''2'' then',
'      open c_imagem_2(apex_application.g_x01);',
'      fetch c_imagem_2 into l_blob, l_mime, l_name, l_len;',
'      close c_imagem_2;',
'    when ''3'' then',
'      open c_imagem_3(apex_application.g_x01);',
'      fetch c_imagem_3 into l_blob, l_mime, l_name, l_len;',
'      close c_imagem_3;',
'    when ''4'' then',
'      open c_imagem_4(apex_application.g_x01);',
'      fetch c_imagem_4 into l_blob, l_mime, l_name, l_len;',
'      close c_imagem_4;',
'    else',
'      null;',
'  end case;',
'',
'/*',
'  select doc_file_orig, dbms_lob.getlength(doc_file_orig), doc_mimetype_orig, doc_filename_orig --|| ''.jpg''',
'    into l_blob, l_len, l_mime, l_name',
'    from docs_document_codes',
'   where client_id = l_client_id',
'     and doc_code  = l_doc_code;',
'*/',
'  if l_len > 0 and l_mime = ''application/pdf'' then',
unistr('    -- seta header de sess\00E3o'),
'    owa_util.mime_header(l_mime, false);',
'    htp.p(''Content-length: '' || l_len);',
'    --htp.p(''Content-Disposition: '' || ''attachment'' || ''; filename="'' || l_name || ''"'');',
'    htp.p(''Content-Disposition: inline; filename="'' || l_name || ''"'');',
'    owa_util.http_header_close;',
'',
'    -- faz download',
'    sys.wpg_docload.download_file(l_blob);',
'    apex_application.stop_apex_engine;',
'  end if;',
'exception when others then',
'  htp.p(''param:'' || apex_application.g_x01 || '' / erro:'' || sqlerrm);',
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
