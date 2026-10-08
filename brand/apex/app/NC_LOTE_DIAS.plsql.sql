-- AJUSTAR VARIOS DIAS DE UMA VEZ (Natcorp_Lote.js) - pagina 715 do app 9503 ("Ajustar varios dias"), Ajax Callback.
-- Entrega, em JSON, os dias do periodo do colaborador que veio da pagina 203 (P715_EMP / P715_MAT,
-- de P715_DT_INI a P715_DT_FIM) com as posicoes da jornada de cada dia e o horario previsto, a marcacao
-- que ja existe, o abono e se ja ha pedido aberto para a posicao. Mais a lista de motivos (justificativas) do perfil.
-- As regras sao as da janela de ajuste (pagina 714): a jornada do dia e o horario previsto vem dos
-- processos popula_campos / popula_campos_1; os motivos vem da lista do item P714_COD_JUSTIFICATIVA.
-- So LE: nao grava nada.
declare
  v_emp     number := :P715_EMP;
  v_mat     number := :P715_MAT;
  v_ini     date;
  v_fim     date;
  v_d       date;
  v_jor     varchar2(100);
  v_fer     varchar2(1);
  v_col     varchar2(30);
  v_tipo    varchar2(106);
  v_expr    varchar2(200);
  v_sql     varchar2(2000);
  v_ok      number;
  v_bloq    number;
  v_p       number;
  v_prev    varchar2(20);
  v_real    varchar2(5);
  v_abono   varchar2(5);
  v_pend    number;
  type t_cur is ref cursor;
  c         t_cur;
  v_json    clob;
  v_pos     pls_integer := 1;
begin
  v_ini := to_date(:P715_DT_INI, 'dd/mm/rrrr');
  v_fim := to_date(:P715_DT_FIM, 'dd/mm/rrrr');

  -- o mesmo acesso da lista "Colaborador" da janela de ajuste (P714_MATRICULA), por painel
  select count(*)
    into v_ok
    from informacoes_funcionais_cad i
   where i.cod_empresa = v_emp
     and i.matricula   = v_mat
     and (   (i.cod_ccusto in (select x.cod
                                 from centro_de_custo x
                                where x.matricula_gestor in (select u.cd_matricula
                                                               from usuario_oracle u
                                                              where u.nm_usuario_oracle = :P_USUARIO))
              and :P_PAINEL = 'PG')
          or (f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :P_USUARIO) = 'S' and :P_PAINEL = 'PO')
          or (i.cod_empresa = :P_EMPRESA_USER and i.matricula = :P_MATRICULA_USER and :P_PAINEL = 'PC'));

  -- o botao "Criar" da janela de ajuste some para o perfil bloqueado (pe_perfil_abono_geral.bloqueia)
  select count(*)
    into v_bloq
    from usuario_oracle uo
   where uo.nm_usuario_oracle = :P_USUARIO
     and exists (select 1
                   from pe_perfil_abono_geral pe
                  where uo.cd_perfil  = pe.cd_perfil
                    and uo.cd_empresa = pe.cod_empresa
                    and pe.bloqueia   = 'S');

  -- o tipo da coluna HORARIO (DATE ou texto) decide como ler o horario previsto
  begin
    select data_type
      into v_tipo
      from (select data_type
              from all_tab_columns
             where table_name  = 'PE_JORNADAS_COMPOSICAO'
               and column_name = 'HORARIO'
             order by case when owner = sys_context('userenv', 'current_schema') then 0 else 1 end)
     where rownum = 1;
  exception
    when others then
      v_tipo := 'VARCHAR2';
  end;
  if v_tipo = 'DATE' or v_tipo like 'TIMESTAMP%' then
    v_expr := 'to_char(horario, ''hh24:mi'')';
  else
    v_expr := 'trim(to_char(horario))';
  end if;

  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('acesso', v_ok > 0);
  apex_json.write('bloqueado', v_bloq > 0);
  if v_ok > 0 then
    apex_json.write('nome', initcap(fnct_nome_func(v_emp, v_mat)));
  end if;
  apex_json.write('matricula', v_mat);
  apex_json.write('inicio', to_char(v_ini, 'dd/mm/yyyy'));
  apex_json.write('fim', to_char(v_fim, 'dd/mm/yyyy'));

  apex_json.open_array('dias');
  if v_ok > 0 and v_ini is not null and v_fim is not null and v_fim >= v_ini and v_fim - v_ini <= 62 then
    v_d := v_ini;
    while v_d <= v_fim loop
      v_fer := nvl(f_pe_considera_jornada_feriado(v_emp, v_mat, v_d), 'N');
      v_jor := fnct_pe_retorna_jornada(v_emp, v_mat, v_d);
      -- o dia da semana sem depender do idioma da sessao (segunda = 1 ... domingo = 7)
      v_col := case trunc(v_d) - trunc(v_d, 'IW') + 1
                 when 1 then 'SEGUNDA' when 2 then 'TERCA' when 3 then 'QUARTA' when 4 then 'QUINTA'
                 when 5 then 'SEXTA' when 6 then 'SABADO' else 'DOMINGO' end;
      apex_json.open_object;
      apex_json.write('d', to_char(v_d, 'dd/mm/yyyy'));
      apex_json.write('w', trunc(v_d) - trunc(v_d, 'IW') + 1);
      apex_json.write('feriado', v_fer);
      apex_json.open_array('pos');
      if v_jor is not null then
        v_sql := 'select posicao, ' || v_expr ||
                 '  from pe_jornadas_composicao' ||
                 ' where cod_jornada = :1' ||
                 '   and ((:2 = ''N'' and ' || v_col || ' = ''S'') or (:3 = ''S'' and feriado = ''S''))' ||
                 ' order by posicao';
        open c for v_sql using v_jor, v_fer, v_fer;
        loop
          fetch c into v_p, v_prev;
          exit when c%notfound;
          v_real := null;
          v_abono := null;
          for m in (select to_char(hora_batida, 'hh24:mi') hb, to_char(hora_batida_abono, 'hh24:mi') ha
                      from pe_tratamento_batimentos
                     where cod_empresa = v_emp
                       and matricula   = v_mat
                       and nvl(vira_dia, data_ponto) = v_d
                       and posicao     = v_p) loop
            v_real := m.hb;
            v_abono := m.ha;
            exit;
          end loop;
          select count(*)
            into v_pend
            from pe_req_tratamento_batimentos
           where cod_empresa = v_emp
             and matricula   = v_mat
             and nvl(vira_dia, data_ponto) = v_d
             and posicao     = v_p
             and cod_sit_req = 1;
          apex_json.open_object;
          apex_json.write('p', v_p);
          apex_json.write('prev', substr(v_prev, 1, 5));
          apex_json.write('real', v_real);
          apex_json.write('abono', v_abono);
          apex_json.write('pend', v_pend > 0);
          apex_json.close_object;
        end loop;
        close c;
      end if;
      apex_json.close_array;
      apex_json.close_object;
      v_d := v_d + 1;
    end loop;
  end if;
  apex_json.close_array;

  -- os motivos: a mesma lista da janela de ajuste, com "pede comprovante"
  apex_json.open_array('motivos');
  if v_ok > 0 then
    for r in (select l.i cod, l.n descricao, nvl(t.obriga_comprovante, 'N') comprov
                from table(pkg_list.fnc_list_justificativa(v_emp, :P_PAINEL, :P_PERFIL)) l,
                     pe_tipo_justificativa t
               where t.cod_empresa(+) = v_emp
                 and t.cod_justificativa(+) = l.i
               order by 2) loop
      apex_json.open_object;
      apex_json.write('c', to_char(r.cod));
      apex_json.write('n', r.descricao);
      apex_json.write('comprov', r.comprov);
      apex_json.close_object;
    end loop;
  end if;
  apex_json.close_array;
  apex_json.close_object;

  v_json := apex_json.get_clob_output;
  apex_json.free_output;
  while v_pos <= dbms_lob.getlength(v_json) loop
    htp.prn(dbms_lob.substr(v_json, 8000, v_pos));
    v_pos := v_pos + 8000;
  end loop;
exception
  when others then
    begin
      if c%isopen then close c; end if;
    exception
      when others then null;
    end;
    begin
      apex_json.free_output;
    exception
      when others then null;
    end;
    htp.prn('{"erro":"' || apex_escape.json(sqlerrm) || '"}');
end;
