-- AJUSTAR VARIOS DIAS DE UMA VEZ (Natcorp_Lote.js) - pagina 715 do app 9503 ("Ajustar varios dias"), Ajax Callback.
-- Cria os pedidos de ajuste (pe_req_tratamento_batimentos) que a pessoa marcou, UM PEDIDO POR HORARIO,
-- exatamente como se tivesse aberto a janela de ajuste (pagina 714) para cada um e tocado em "Criar":
--   validacoes da 714 (Data Limite, Valida Posicao, Periodo, Diferente Batida, Valida Limite, motivo,
--   comprovante), depois PRE-INSERT + Popula Horas + insercao + POST-INSERT (pkg_pe_abono.post_insert)
--   + Apuracao req_abono (pkg_pe_abono.prc_apuracaoreqabono) + Atualiza batida plantao.
-- O que a 714 faz e o lote NAO faz: apagar marcacao, enviar para outra posicao, anexar comprovante e
-- replicar por N dias (esses continuam na janela, um por vez).
-- Entrada:  f01 = um horario por linha: 'dd/mm/yyyy|posicao|hh24:mi|plantao|motivo'
--                 plantao = P, Q, N ou - (o - usa P715_OPCAO, a visao de Marcacoes da 203: e o
--                 mesmo valor que o link da grade manda a 714 em P714_OPCAO_PLANTAO);
--                 motivo  = codigo da justificativa DAQUELE horario (cada um pode ter o seu)
--           x01 = motivo para as linhas que vierem sem motivo (opcional)
--           x02 = observacao, a mesma para todos (opcional)
-- Saida:    {"itens":[{"d":..,"p":..,"ok":true,"req":57740,"aviso":".."} | {"d":..,"p":..,"ok":false,"erro":".."}]}
--           ou {"erro":"acesso"|"bloqueado"|<mensagem>} quando nada pode ser criado. Motivo que falta ou que
--           pede comprovante volta como erro DAQUELE horario.
-- Cada horario e independente: o que falha volta ao estado de antes (savepoint) e os outros seguem.
declare
  v_emp     number := :P715_EMP;
  v_mat     number := :P715_MAT;
  v_just0   varchar2(30) := trim(apex_application.g_x01);
  v_just    varchar2(30);
  v_coment  varchar2(4000) := substr(apex_application.g_x02, 1, 4000);
  v_ok      number;
  v_bloq    number;
  v_comprov varchar2(1);
  v_ref     date;
  v_trava   varchar2(1);
  v_item    varchar2(200);
  v_d       date;
  v_p       number;
  v_h       varchar2(20);
  v_pl      varchar2(10);
  v_flg     varchar2(3);
  v_msg     varchar2(4000);
  v_flag    varchar2(1);
  v_erro    varchar2(4000);
  v_aviso   varchar2(4000);
  v_req     number;
  v_ex      number;
  v_fil     varchar2(100);
  v_dp      date;
  v_vd      date;
  v_hb      varchar2(5);
  v_json    clob;
  v_pos     pls_integer := 1;
  v_parar   varchar2(30);

  function limpo(t varchar2) return varchar2 is
  begin
    -- as mensagens das funcoes de periodo vem com | e [ ] para virar HTML na 714
    return trim(replace(replace(replace(replace(t, '|', ' '), '[', ''), ']', ''), '- ', ''));
  end;
begin
  -- ---------- o que vale para o lote inteiro ----------
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
  select count(*)
    into v_bloq
    from usuario_oracle uo
   where uo.nm_usuario_oracle = :P_USUARIO
     and exists (select 1
                   from pe_perfil_abono_geral pe
                  where uo.cd_perfil  = pe.cd_perfil
                    and uo.cd_empresa = pe.cod_empresa
                    and pe.bloqueia   = 'S');
  if v_ok = 0 then
    v_parar := 'acesso';
  elsif v_bloq > 0 then
    v_parar := 'bloqueado';
  end if;
  if v_parar is not null then
    htp.prn('{"erro":"' || v_parar || '"}');
    return;
  end if;

  begin                                           -- Data Limite
    select nvl(data_ref_ponto, trunc(sysdate)), ind_trava_req_po
      into v_ref, v_trava
      from parametros_recursos_humanos
     where cod_empresa = v_emp;
  exception
    when others then
      v_ref := trunc(sysdate);
      v_trava := null;
  end;
  select max(filial)
    into v_fil
    from informacoes_funcionais_cad
   where cod_empresa = :P_EMPRESA_USER
     and matricula   = :P_MATRICULA_USER;

  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.open_array('itens');
  for i in 1 .. apex_application.g_f01.count loop
    v_item  := apex_application.g_f01(i);
    v_erro  := null;
    v_aviso := null;
    v_req   := null;
    v_d     := null;
    v_p     := null;
    begin
      savepoint nc_lote_item;
      v_d  := to_date(regexp_substr(v_item, '[^|]+', 1, 1), 'dd/mm/yyyy');
      v_p  := to_number(regexp_substr(v_item, '[^|]+', 1, 2));
      v_h  := regexp_substr(v_item, '[^|]+', 1, 3);
      v_pl := nvl(nullif(regexp_substr(v_item, '[^|]+', 1, 4), '-'), nvl(:P715_OPCAO, 'N'));   -- P714_OPCAO_PLANTAO = P203_OPCAO
      v_just := nvl(trim(regexp_substr(v_item, '[^|]+', 1, 5)), v_just0);
      if v_d is null or v_p is null or not regexp_like(nvl(v_h, '-'), '^([01][0-9]|2[0-3]):[0-5][0-9]$') then
        v_erro := 'horario invalido';
      end if;

      if v_erro is null and v_just is null then                            -- valid_P714_COD_JUSTIFICATIVA
        v_erro := 'Escolha o motivo deste horario';
      end if;
      if v_erro is null then                                               -- Valida Anexo: o lote nao leva arquivo
        select nvl(max(obriga_comprovante), 'N')
          into v_comprov
          from pe_tipo_justificativa
         where cod_empresa = v_emp
           and cod_justificativa = v_just;
        if v_comprov = 'S' then
          v_erro := 'Este motivo pede comprovante: faca este ajuste pela janela do horario, que aceita o anexo';
        end if;
      end if;

      -- a marcacao que ja existe na posicao (popula_campos_1 da 714)
      v_dp := null;
      v_vd := null;
      v_hb := null;
      if v_erro is null then
        for m in (select data_ponto, vira_dia, to_char(hora_batida, 'hh24:mi') hb
                    from pe_tratamento_batimentos
                   where cod_empresa = v_emp
                     and matricula   = v_mat
                     and nvl(vira_dia, data_ponto) = v_d
                     and posicao     = v_p) loop
          v_dp := m.data_ponto;
          v_vd := m.vira_dia;
          v_hb := m.hb;
          exit;
        end loop;
      end if;

      -- ---------- as validacoes da 714, na mesma ordem ----------
      if v_erro is null and v_hb is not null and v_hb = v_h then          -- Diferente Batida
        v_erro := 'O horario do ajuste e igual ao da marcacao (' || v_hb || ')';
      end if;
      if v_erro is null and v_trava = 'S' and v_d < v_ref then             -- Data Limite
        v_erro := 'Data fora do limite permitido: ' || to_char(v_ref, 'dd/mm/yyyy');
      end if;
      if v_erro is null then                                               -- Valida Posicao
        v_flg := null;
        v_msg := null;
        pkg_pe_abono.valida_posicao(v_emp, v_mat, v_d, v_p, v_flg, v_msg, :P_PAINEL);
        if trim(v_msg) is not null and v_flg = 'N' then
          v_erro := v_msg;
        end if;
      end if;
      if v_erro is null then                                               -- Valida Periodo | Limite Abono
        v_msg := pkg_pe_abono.fnc_valperiodoabonopainel(pempresa   => v_emp,
                                                        puser      => :P_USUARIO,
                                                        ppainel    => :P_PAINEL,
                                                        pdata      => trunc(sysdate),
                                                        pperinipto => v_d);
        if v_msg is not null then
          v_erro := 'Edicao nao permitida: ' || limpo(v_msg);
        end if;
        -- a segunda parte (fnc_vallimiteabono) so roda na 714 com P714_COD_EMPRESA e P714_MATRICULA
        -- preenchidos, o que nao acontece quando a janela abre pela grade: o lote faz o mesmo.
      end if;
      if v_erro is null then                                               -- Valida Limite
        v_flag := null;
        v_msg := null;
        prc_valida_qtd_abono(p_cod_empresa   => v_emp,
                             p_matricula     => v_mat,
                             p_painel        => :P_PAINEL,
                             p_perfil        => :P_PERFIL,
                             p_data_ponto    => v_d,
                             p_cod_req       => null,
                             p_cod_justifica => v_just,
                             p_flag          => v_flag,
                             p_messagem      => v_msg);
        if v_msg is not null and v_flag = 'N' then
          v_erro := v_msg;
        end if;
      end if;

      -- ---------- a criacao, como os processos da 714 ----------
      if v_erro is null then
        loop                                                               -- PRE-INSERT
          select seq_requisicao.nextval into v_req from dual;
          select count(*) into v_ex from pe_req_tratamento_batimentos where cod_req = v_req;
          exit when v_ex = 0;
        end loop;
        insert into pe_req_tratamento_batimentos
          (cod_req, dt_req, cod_sit_req, dt_sit_req, cod_emp_req, mat_req, fil_req, usuario,
           cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao,
           cod_justificativa, comentarios, plantao)
        values
          (v_req, trunc(sysdate), 1, trunc(sysdate), :P_EMPRESA_USER, :P_MATRICULA_USER, v_fil, :P_USUARIO,
           v_emp, v_mat, nvl(v_dp, v_d), v_vd,
           case when v_hb is not null then to_date(to_char(v_d, 'dd/mm/yyyy') || ' ' || v_hb, 'dd/mm/yyyy hh24:mi') end,
           to_date(to_char(v_d, 'dd/mm/yyyy') || ' ' || v_h, 'dd/mm/yyyy hh24:mi'),
           v_p, v_just, v_coment,
           case when v_pl in ('P', 'Q') then 'S' else 'N' end);

        v_flg := null;                                                     -- POST-INSERT
        v_msg := null;
        pkg_pe_abono.post_insert(v_emp, v_req, v_flg, v_msg);
        if v_msg is not null then
          v_aviso := v_msg;
        end if;
        v_msg := null;                                                     -- Apuracao req_abono
        pkg_pe_abono.prc_apuracaoreqabono(v_req, :P_USUARIO, v_msg);
        if v_msg is not null then
          v_aviso := ltrim(v_aviso || ' | ' || v_msg, ' |');
        end if;
        if v_pl in ('P', 'Q') then                                         -- Atualiza batida plantao
          update pe_tratamento_batimentos
             set plantao        = 'S',
                 vira_dia       = v_vd,
                 usuario        = substr(:P_USUARIO || 'Tela_714', 1, 30),
                 dt_atualizacao = sysdate
           where cod_empresa = v_emp
             and matricula   = v_mat
             and data_ponto  = nvl(v_dp, v_d)
             and posicao     = v_p;
        end if;
      end if;
    exception
      when others then
        v_erro := sqlerrm;
        v_req := null;
        begin
          rollback to savepoint nc_lote_item;
        exception
          when others then null;
        end;
    end;
    apex_json.open_object;
    apex_json.write('d', to_char(v_d, 'dd/mm/yyyy'));
    apex_json.write('p', v_p);
    apex_json.write('ok', v_erro is null);
    if v_erro is null then
      apex_json.write('req', v_req);
      apex_json.write('aviso', v_aviso);
    else
      apex_json.write('erro', v_erro);
    end if;
    apex_json.close_object;
  end loop;
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
      apex_json.free_output;
    exception
      when others then null;
    end;
    htp.prn('{"erro":"' || apex_escape.json(sqlerrm) || '"}');
end;
