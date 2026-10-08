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
,p_default_application_id=>9503
,p_default_id_offset=>805284078712235562
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9503 - Frequência - Lançamentos
--
-- Application Export:
--   Application:     9503
--   Name:            Frequência - Lançamentos
--   Date and Time:   00:03 Thursday October 8, 2026
--   Exported By:     gerar-pagina715.py (Natcorp)
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 715
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00715
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>715);
end;
/
prompt --application/pages/page_00715
begin
wwv_flow_api.create_page(
 p_id=>715
,p_user_interface_id=>wwv_flow_api.id(204653706463111219891)
,p_name=>unistr('Ajustar v\00E1rios dias')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Ajustar v\00E1rios dias')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Lote.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Lote.css'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'640'
,p_dialog_width=>'1100'
,p_dialog_max_width=>'100%'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Natcorp 08/10 - Ajustar varios dias de uma vez (aberta pelo botao da 203).',
'A pessoa muda os horarios dos dias do periodo e toca em Salvar uma vez: NC_LOTE_CRIAR cria um',
'pedido de ajuste por horario mudado, com as validacoes e os processos da janela 714 (nao alterada).',
'Tela desenhada pelo Natcorp_Lote.js; sem ele aparece so o aviso da regiao. Guia: brand/apex/app/LOTE-MANUTENCAO.md.'))
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'NATCORP'
,p_last_upd_yyyymmddhh24miss=>'20261008000000'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28299950307150000001)
,p_plug_name=>unistr('Ajustar v\00E1rios dias')
,p_region_name=>'nc_lote'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(204653680466273219797)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="nc-lote" class="nc-lote" aria-live="polite">',
'  <p class="nc-lote-espera">Carregando os dias do per&iacute;odo&hellip;</p>',
'  <noscript>Esta tela precisa do arquivo Natcorp_Lote.js (JavaScript da p&aacute;gina).</noscript>',
'</div>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28299950307150000011)
,p_name=>'P715_EMP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(28299950307150000001)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28299950307150000012)
,p_name=>'P715_MAT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(28299950307150000001)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28299950307150000013)
,p_name=>'P715_DT_INI'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(28299950307150000001)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28299950307150000014)
,p_name=>'P715_DT_FIM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(28299950307150000001)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28299950307150000015)
,p_name=>'P715_OPCAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(28299950307150000001)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28299950307150000021)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_LOTE_DIAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- AJUSTAR VARIOS DIAS DE UMA VEZ (Natcorp_Lote.js) - pagina 715 do app 9503 ("Ajustar varios dias"), Ajax Callback.',
'-- Entrega, em JSON, os dias do periodo do colaborador que veio da pagina 203 (P715_EMP / P715_MAT,',
'-- de P715_DT_INI a P715_DT_FIM) com as posicoes da jornada de cada dia e o horario previsto, a marcacao',
'-- que ja existe, o abono e se ja ha pedido aberto para a posicao. Mais a lista de motivos (justificativas) do perfil.',
'-- As regras sao as da janela de ajuste (pagina 714): a jornada do dia e o horario previsto vem dos',
'-- processos popula_campos / popula_campos_1; os motivos vem da lista do item P714_COD_JUSTIFICATIVA.',
'-- So LE: nao grava nada.',
'declare',
'  v_emp     number := :P715_EMP;',
'  v_mat     number := :P715_MAT;',
'  v_ini     date;',
'  v_fim     date;',
'  v_d       date;',
'  v_jor     varchar2(100);',
'  v_fer     varchar2(1);',
'  v_col     varchar2(30);',
'  v_tipo    varchar2(106);',
'  v_expr    varchar2(200);',
'  v_sql     varchar2(2000);',
'  v_ok      number;',
'  v_bloq    number;',
'  v_p       number;',
'  v_prev    varchar2(20);',
'  v_real    varchar2(5);',
'  v_abono   varchar2(5);',
'  v_pend    number;',
'  type t_cur is ref cursor;',
'  c         t_cur;',
'  v_json    clob;',
'  v_pos     pls_integer := 1;',
'begin',
'  v_ini := to_date(:P715_DT_INI, ''dd/mm/rrrr'');',
'  v_fim := to_date(:P715_DT_FIM, ''dd/mm/rrrr'');',
'',
'  -- o mesmo acesso da lista "Colaborador" da janela de ajuste (P714_MATRICULA), por painel',
'  select count(*)',
'    into v_ok',
'    from informacoes_funcionais_cad i',
'   where i.cod_empresa = v_emp',
'     and i.matricula   = v_mat',
'     and (   (i.cod_ccusto in (select x.cod',
'                                 from centro_de_custo x',
'                                where x.matricula_gestor in (select u.cd_matricula',
'                                                               from usuario_oracle u',
'                                                              where u.nm_usuario_oracle = :P_USUARIO))',
'              and :P_PAINEL = ''PG'')',
'          or (f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :P_USUARIO) = ''S'' and :P_PAINEL = ''PO'')',
'          or (i.cod_empresa = :P_EMPRESA_USER and i.matricula = :P_MATRICULA_USER and :P_PAINEL = ''PC''));',
'',
'  -- o botao "Criar" da janela de ajuste some para o perfil bloqueado (pe_perfil_abono_geral.bloqueia)',
'  select count(*)',
'    into v_bloq',
'    from usuario_oracle uo',
'   where uo.nm_usuario_oracle = :P_USUARIO',
'     and exists (select 1',
'                   from pe_perfil_abono_geral pe',
'                  where uo.cd_perfil  = pe.cd_perfil',
'                    and uo.cd_empresa = pe.cod_empresa',
'                    and pe.bloqueia   = ''S'');',
'',
'  -- o tipo da coluna HORARIO (DATE ou texto) decide como ler o horario previsto',
'  begin',
'    select data_type',
'      into v_tipo',
'      from (select data_type',
'              from all_tab_columns',
'             where table_name  = ''PE_JORNADAS_COMPOSICAO''',
'               and column_name = ''HORARIO''',
'             order by case when owner = sys_context(''userenv'', ''current_schema'') then 0 else 1 end)',
'     where rownum = 1;',
'  exception',
'    when others then',
'      v_tipo := ''VARCHAR2'';',
'  end;',
'  if v_tipo = ''DATE'' or v_tipo like ''TIMESTAMP%'' then',
'    v_expr := ''to_char(horario, ''''hh24:mi'''')'';',
'  else',
'    v_expr := ''trim(to_char(horario))'';',
'  end if;',
'',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''acesso'', v_ok > 0);',
'  apex_json.write(''bloqueado'', v_bloq > 0);',
'  if v_ok > 0 then',
'    apex_json.write(''nome'', initcap(fnct_nome_func(v_emp, v_mat)));',
'  end if;',
'  apex_json.write(''matricula'', v_mat);',
'  apex_json.write(''inicio'', to_char(v_ini, ''dd/mm/yyyy''));',
'  apex_json.write(''fim'', to_char(v_fim, ''dd/mm/yyyy''));',
'',
'  apex_json.open_array(''dias'');',
'  if v_ok > 0 and v_ini is not null and v_fim is not null and v_fim >= v_ini and v_fim - v_ini <= 62 then',
'    v_d := v_ini;',
'    while v_d <= v_fim loop',
'      v_fer := nvl(f_pe_considera_jornada_feriado(v_emp, v_mat, v_d), ''N'');',
'      v_jor := fnct_pe_retorna_jornada(v_emp, v_mat, v_d);',
'      -- o dia da semana sem depender do idioma da sessao (segunda = 1 ... domingo = 7)',
'      v_col := case trunc(v_d) - trunc(v_d, ''IW'') + 1',
'                 when 1 then ''SEGUNDA'' when 2 then ''TERCA'' when 3 then ''QUARTA'' when 4 then ''QUINTA''',
'                 when 5 then ''SEXTA'' when 6 then ''SABADO'' else ''DOMINGO'' end;',
'      apex_json.open_object;',
'      apex_json.write(''d'', to_char(v_d, ''dd/mm/yyyy''));',
'      apex_json.write(''w'', trunc(v_d) - trunc(v_d, ''IW'') + 1);',
'      apex_json.write(''feriado'', v_fer);',
'      apex_json.open_array(''pos'');',
'      if v_jor is not null then',
'        v_sql := ''select posicao, '' || v_expr ||',
'                 ''  from pe_jornadas_composicao'' ||',
'                 '' where cod_jornada = :1'' ||',
'                 ''   and ((:2 = ''''N'''' and '' || v_col || '' = ''''S'''') or (:3 = ''''S'''' and feriado = ''''S''''))'' ||',
'                 '' order by posicao'';',
'        open c for v_sql using v_jor, v_fer, v_fer;',
'        loop',
'          fetch c into v_p, v_prev;',
'          exit when c%notfound;',
'          v_real := null;',
'          v_abono := null;',
'          for m in (select to_char(hora_batida, ''hh24:mi'') hb, to_char(hora_batida_abono, ''hh24:mi'') ha',
'                      from pe_tratamento_batimentos',
'                     where cod_empresa = v_emp',
'                       and matricula   = v_mat',
'                       and nvl(vira_dia, data_ponto) = v_d',
'                       and posicao     = v_p) loop',
'            v_real := m.hb;',
'            v_abono := m.ha;',
'            exit;',
'          end loop;',
'          select count(*)',
'            into v_pend',
'            from pe_req_tratamento_batimentos',
'           where cod_empresa = v_emp',
'             and matricula   = v_mat',
'             and nvl(vira_dia, data_ponto) = v_d',
'             and posicao     = v_p',
'             and cod_sit_req = 1;',
'          apex_json.open_object;',
'          apex_json.write(''p'', v_p);',
'          apex_json.write(''prev'', substr(v_prev, 1, 5));',
'          apex_json.write(''real'', v_real);',
'          apex_json.write(''abono'', v_abono);',
'          apex_json.write(''pend'', v_pend > 0);',
'          apex_json.close_object;',
'        end loop;',
'        close c;',
'      end if;',
'      apex_json.close_array;',
'      apex_json.close_object;',
'      v_d := v_d + 1;',
'    end loop;',
'  end if;',
'  apex_json.close_array;',
'',
'  -- os motivos: a mesma lista da janela de ajuste, com "pede comprovante"',
'  apex_json.open_array(''motivos'');',
'  if v_ok > 0 then',
'    for r in (select l.i cod, l.n descricao, nvl(t.obriga_comprovante, ''N'') comprov',
'                from table(pkg_list.fnc_list_justificativa(v_emp, :P_PAINEL, :P_PERFIL)) l,',
'                     pe_tipo_justificativa t',
'               where t.cod_empresa(+) = v_emp',
'                 and t.cod_justificativa(+) = l.i',
'               order by 2) loop',
'      apex_json.open_object;',
'      apex_json.write(''c'', to_char(r.cod));',
'      apex_json.write(''n'', r.descricao);',
'      apex_json.write(''comprov'', r.comprov);',
'      apex_json.close_object;',
'    end loop;',
'  end if;',
'  apex_json.close_array;',
'  apex_json.close_object;',
'',
'  v_json := apex_json.get_clob_output;',
'  apex_json.free_output;',
'  while v_pos <= dbms_lob.getlength(v_json) loop',
'    htp.prn(dbms_lob.substr(v_json, 8000, v_pos));',
'    v_pos := v_pos + 8000;',
'  end loop;',
'exception',
'  when others then',
'    begin',
'      if c%isopen then close c; end if;',
'    exception',
'      when others then null;',
'    end;',
'    begin',
'      apex_json.free_output;',
'    exception',
'      when others then null;',
'    end;',
'    htp.prn(''{"erro":"'' || apex_escape.json(sqlerrm) || ''"}'');',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>'Le os dias do periodo (posicoes da jornada, horario previsto, marcacao, abono, pedido aberto) e os motivos. So le.'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28299950307150000022)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_LOTE_CRIAR'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- AJUSTAR VARIOS DIAS DE UMA VEZ (Natcorp_Lote.js) - pagina 715 do app 9503 ("Ajustar varios dias"), Ajax Callback.',
'-- Cria os pedidos de ajuste (pe_req_tratamento_batimentos) que a pessoa marcou, UM PEDIDO POR HORARIO,',
'-- exatamente como se tivesse aberto a janela de ajuste (pagina 714) para cada um e tocado em "Criar":',
'--   validacoes da 714 (Data Limite, Valida Posicao, Periodo, Diferente Batida, Valida Limite, motivo,',
'--   comprovante), depois PRE-INSERT + Popula Horas + insercao + POST-INSERT (pkg_pe_abono.post_insert)',
'--   + Apuracao req_abono (pkg_pe_abono.prc_apuracaoreqabono) + Atualiza batida plantao.',
'-- O que a 714 faz e o lote NAO faz: apagar marcacao, enviar para outra posicao, anexar comprovante e',
'-- replicar por N dias (esses continuam na janela, um por vez).',
'-- Entrada:  f01 = um horario por linha: ''dd/mm/yyyy|posicao|hh24:mi|plantao|motivo''',
'--                 plantao = P, Q, N ou - (o - usa P715_OPCAO, a visao de Marcacoes da 203: e o',
'--                 mesmo valor que o link da grade manda a 714 em P714_OPCAO_PLANTAO);',
'--                 motivo  = codigo da justificativa DAQUELE horario (cada um pode ter o seu)',
'--           x01 = motivo para as linhas que vierem sem motivo (opcional)',
'--           x02 = observacao, a mesma para todos (opcional)',
'-- Saida:    {"itens":[{"d":..,"p":..,"ok":true,"req":57740,"aviso":".."} | {"d":..,"p":..,"ok":false,"erro":".."}]}',
'--           ou {"erro":"acesso"|"bloqueado"|<mensagem>} quando nada pode ser criado. Motivo que falta ou que',
'--           pede comprovante volta como erro DAQUELE horario.',
'-- Cada horario e independente: o que falha volta ao estado de antes (savepoint) e os outros seguem.',
'declare',
'  v_emp     number := :P715_EMP;',
'  v_mat     number := :P715_MAT;',
'  v_just0   varchar2(30) := trim(apex_application.g_x01);',
'  v_just    varchar2(30);',
'  v_coment  varchar2(4000) := substr(apex_application.g_x02, 1, 4000);',
'  v_ok      number;',
'  v_bloq    number;',
'  v_comprov varchar2(1);',
'  v_ref     date;',
'  v_trava   varchar2(1);',
'  v_item    varchar2(200);',
'  v_d       date;',
'  v_p       number;',
'  v_h       varchar2(20);',
'  v_pl      varchar2(10);',
'  v_flg     varchar2(3);',
'  v_msg     varchar2(4000);',
'  v_flag    varchar2(1);',
'  v_erro    varchar2(4000);',
'  v_aviso   varchar2(4000);',
'  v_req     number;',
'  v_ex      number;',
'  v_fil     varchar2(100);',
'  v_dp      date;',
'  v_vd      date;',
'  v_hb      varchar2(5);',
'  v_json    clob;',
'  v_pos     pls_integer := 1;',
'  v_parar   varchar2(30);',
'',
'  function limpo(t varchar2) return varchar2 is',
'  begin',
'    -- as mensagens das funcoes de periodo vem com | e [ ] para virar HTML na 714',
'    return trim(replace(replace(replace(replace(t, ''|'', '' ''), ''['', ''''), '']'', ''''), ''- '', ''''));',
'  end;',
'begin',
'  -- ---------- o que vale para o lote inteiro ----------',
'  select count(*)',
'    into v_ok',
'    from informacoes_funcionais_cad i',
'   where i.cod_empresa = v_emp',
'     and i.matricula   = v_mat',
'     and (   (i.cod_ccusto in (select x.cod',
'                                 from centro_de_custo x',
'                                where x.matricula_gestor in (select u.cd_matricula',
'                                                               from usuario_oracle u',
'                                                              where u.nm_usuario_oracle = :P_USUARIO))',
'              and :P_PAINEL = ''PG'')',
'          or (f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :P_USUARIO) = ''S'' and :P_PAINEL = ''PO'')',
'          or (i.cod_empresa = :P_EMPRESA_USER and i.matricula = :P_MATRICULA_USER and :P_PAINEL = ''PC''));',
'  select count(*)',
'    into v_bloq',
'    from usuario_oracle uo',
'   where uo.nm_usuario_oracle = :P_USUARIO',
'     and exists (select 1',
'                   from pe_perfil_abono_geral pe',
'                  where uo.cd_perfil  = pe.cd_perfil',
'                    and uo.cd_empresa = pe.cod_empresa',
'                    and pe.bloqueia   = ''S'');',
'  if v_ok = 0 then',
'    v_parar := ''acesso'';',
'  elsif v_bloq > 0 then',
'    v_parar := ''bloqueado'';',
'  end if;',
'  if v_parar is not null then',
'    htp.prn(''{"erro":"'' || v_parar || ''"}'');',
'    return;',
'  end if;',
'',
'  begin                                           -- Data Limite',
'    select nvl(data_ref_ponto, trunc(sysdate)), ind_trava_req_po',
'      into v_ref, v_trava',
'      from parametros_recursos_humanos',
'     where cod_empresa = v_emp;',
'  exception',
'    when others then',
'      v_ref := trunc(sysdate);',
'      v_trava := null;',
'  end;',
'  select max(filial)',
'    into v_fil',
'    from informacoes_funcionais_cad',
'   where cod_empresa = :P_EMPRESA_USER',
'     and matricula   = :P_MATRICULA_USER;',
'',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.open_array(''itens'');',
'  for i in 1 .. apex_application.g_f01.count loop',
'    v_item  := apex_application.g_f01(i);',
'    v_erro  := null;',
'    v_aviso := null;',
'    v_req   := null;',
'    v_d     := null;',
'    v_p     := null;',
'    begin',
'      savepoint nc_lote_item;',
'      v_d  := to_date(regexp_substr(v_item, ''[^|]+'', 1, 1), ''dd/mm/yyyy'');',
'      v_p  := to_number(regexp_substr(v_item, ''[^|]+'', 1, 2));',
'      v_h  := regexp_substr(v_item, ''[^|]+'', 1, 3);',
'      v_pl := nvl(nullif(regexp_substr(v_item, ''[^|]+'', 1, 4), ''-''), nvl(:P715_OPCAO, ''N''));   -- P714_OPCAO_PLANTAO = P203_OPCAO',
'      v_just := nvl(trim(regexp_substr(v_item, ''[^|]+'', 1, 5)), v_just0);',
'      if v_d is null or v_p is null or not regexp_like(nvl(v_h, ''-''), ''^([01][0-9]|2[0-3]):[0-5][0-9]$'') then',
'        v_erro := ''horario invalido'';',
'      end if;',
'',
'      if v_erro is null and v_just is null then                            -- valid_P714_COD_JUSTIFICATIVA',
'        v_erro := ''Escolha o motivo deste horario'';',
'      end if;',
'      if v_erro is null then                                               -- Valida Anexo: o lote nao leva arquivo',
'        select nvl(max(obriga_comprovante), ''N'')',
'          into v_comprov',
'          from pe_tipo_justificativa',
'         where cod_empresa = v_emp',
'           and cod_justificativa = v_just;',
'        if v_comprov = ''S'' then',
'          v_erro := ''Este motivo pede comprovante: faca este ajuste pela janela do horario, que aceita o anexo'';',
'        end if;',
'      end if;',
'',
'      -- a marcacao que ja existe na posicao (popula_campos_1 da 714)',
'      v_dp := null;',
'      v_vd := null;',
'      v_hb := null;',
'      if v_erro is null then',
'        for m in (select data_ponto, vira_dia, to_char(hora_batida, ''hh24:mi'') hb',
'                    from pe_tratamento_batimentos',
'                   where cod_empresa = v_emp',
'                     and matricula   = v_mat',
'                     and nvl(vira_dia, data_ponto) = v_d',
'                     and posicao     = v_p) loop',
'          v_dp := m.data_ponto;',
'          v_vd := m.vira_dia;',
'          v_hb := m.hb;',
'          exit;',
'        end loop;',
'      end if;',
'',
'      -- ---------- as validacoes da 714, na mesma ordem ----------',
'      if v_erro is null and v_hb is not null and v_hb = v_h then          -- Diferente Batida',
'        v_erro := ''O horario do ajuste e igual ao da marcacao ('' || v_hb || '')'';',
'      end if;',
'      if v_erro is null and v_trava = ''S'' and v_d < v_ref then             -- Data Limite',
'        v_erro := ''Data fora do limite permitido: '' || to_char(v_ref, ''dd/mm/yyyy'');',
'      end if;',
'      if v_erro is null then                                               -- Valida Posicao',
'        v_flg := null;',
'        v_msg := null;',
'        pkg_pe_abono.valida_posicao(v_emp, v_mat, v_d, v_p, v_flg, v_msg, :P_PAINEL);',
'        if trim(v_msg) is not null and v_flg = ''N'' then',
'          v_erro := v_msg;',
'        end if;',
'      end if;',
'      if v_erro is null then                                               -- Valida Periodo | Limite Abono',
'        v_msg := pkg_pe_abono.fnc_valperiodoabonopainel(pempresa   => v_emp,',
'                                                        puser      => :P_USUARIO,',
'                                                        ppainel    => :P_PAINEL,',
'                                                        pdata      => trunc(sysdate),',
'                                                        pperinipto => v_d);',
'        if v_msg is not null then',
'          v_erro := ''Edicao nao permitida: '' || limpo(v_msg);',
'        end if;',
'        -- a segunda parte (fnc_vallimiteabono) so roda na 714 com P714_COD_EMPRESA e P714_MATRICULA',
'        -- preenchidos, o que nao acontece quando a janela abre pela grade: o lote faz o mesmo.',
'      end if;',
'      if v_erro is null then                                               -- Valida Limite',
'        v_flag := null;',
'        v_msg := null;',
'        prc_valida_qtd_abono(p_cod_empresa   => v_emp,',
'                             p_matricula     => v_mat,',
'                             p_painel        => :P_PAINEL,',
'                             p_perfil        => :P_PERFIL,',
'                             p_data_ponto    => v_d,',
'                             p_cod_req       => null,',
'                             p_cod_justifica => v_just,',
'                             p_flag          => v_flag,',
'                             p_messagem      => v_msg);',
'        if v_msg is not null and v_flag = ''N'' then',
'          v_erro := v_msg;',
'        end if;',
'      end if;',
'',
'      -- ---------- a criacao, como os processos da 714 ----------',
'      if v_erro is null then',
'        loop                                                               -- PRE-INSERT',
'          select seq_requisicao.nextval into v_req from dual;',
'          select count(*) into v_ex from pe_req_tratamento_batimentos where cod_req = v_req;',
'          exit when v_ex = 0;',
'        end loop;',
'        insert into pe_req_tratamento_batimentos',
'          (cod_req, dt_req, cod_sit_req, dt_sit_req, cod_emp_req, mat_req, fil_req, usuario,',
'           cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao,',
'           cod_justificativa, comentarios, plantao)',
'        values',
'          (v_req, trunc(sysdate), 1, trunc(sysdate), :P_EMPRESA_USER, :P_MATRICULA_USER, v_fil, :P_USUARIO,',
'           v_emp, v_mat, nvl(v_dp, v_d), v_vd,',
'           case when v_hb is not null then to_date(to_char(v_d, ''dd/mm/yyyy'') || '' '' || v_hb, ''dd/mm/yyyy hh24:mi'') end,',
'           to_date(to_char(v_d, ''dd/mm/yyyy'') || '' '' || v_h, ''dd/mm/yyyy hh24:mi''),',
'           v_p, v_just, v_coment,',
'           case when v_pl in (''P'', ''Q'') then ''S'' else ''N'' end);',
'',
'        v_flg := null;                                                     -- POST-INSERT',
'        v_msg := null;',
'        pkg_pe_abono.post_insert(v_emp, v_req, v_flg, v_msg);',
'        if v_msg is not null then',
'          v_aviso := v_msg;',
'        end if;',
'        v_msg := null;                                                     -- Apuracao req_abono',
'        pkg_pe_abono.prc_apuracaoreqabono(v_req, :P_USUARIO, v_msg);',
'        if v_msg is not null then',
'          v_aviso := ltrim(v_aviso || '' | '' || v_msg, '' |'');',
'        end if;',
'        if v_pl in (''P'', ''Q'') then                                         -- Atualiza batida plantao',
'          update pe_tratamento_batimentos',
'             set plantao        = ''S'',',
'                 vira_dia       = v_vd,',
'                 usuario        = substr(:P_USUARIO || ''Tela_714'', 1, 30),',
'                 dt_atualizacao = sysdate',
'           where cod_empresa = v_emp',
'             and matricula   = v_mat',
'             and data_ponto  = nvl(v_dp, v_d)',
'             and posicao     = v_p;',
'        end if;',
'      end if;',
'    exception',
'      when others then',
'        v_erro := sqlerrm;',
'        v_req := null;',
'        begin',
'          rollback to savepoint nc_lote_item;',
'        exception',
'          when others then null;',
'        end;',
'    end;',
'    apex_json.open_object;',
'    apex_json.write(''d'', to_char(v_d, ''dd/mm/yyyy''));',
'    apex_json.write(''p'', v_p);',
'    apex_json.write(''ok'', v_erro is null);',
'    if v_erro is null then',
'      apex_json.write(''req'', v_req);',
'      apex_json.write(''aviso'', v_aviso);',
'    else',
'      apex_json.write(''erro'', v_erro);',
'    end if;',
'    apex_json.close_object;',
'  end loop;',
'  apex_json.close_array;',
'  apex_json.close_object;',
'',
'  v_json := apex_json.get_clob_output;',
'  apex_json.free_output;',
'  while v_pos <= dbms_lob.getlength(v_json) loop',
'    htp.prn(dbms_lob.substr(v_json, 8000, v_pos));',
'    v_pos := v_pos + 8000;',
'  end loop;',
'exception',
'  when others then',
'    begin',
'      apex_json.free_output;',
'    exception',
'      when others then null;',
'    end;',
'    htp.prn(''{"erro":"'' || apex_escape.json(sqlerrm) || ''"}'');',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>'Cria um pedido de ajuste por horario mudado, com as validacoes e os processos da janela 714.'
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
