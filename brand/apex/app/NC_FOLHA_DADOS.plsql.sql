-- Entrega as verbas do mes ao Natcorp_Folha.js, em JSON. A MESMA consulta do relatorio "Folha do Mes",
-- mais o tipo da verba pela FAIXA do codigo, e a MESMA validacao da acao "Valida Dt Ref".
-- Faixas (P74_QUATRO_DIGITOS, de configuracoes.quatro_digitos_ocorr):
--   N: 1-499 provento, 500-899 desconto, 900 em diante base; 997/998/999 = Total de Proventos/Descontos/Liquido
--   S: 1-4999 provento, 5000-8999 desconto, 9000 em diante base; 9997/9998/9999 = os mesmos totais
declare
  v_flg    varchar2(1);
  v_msg    varchar2(4000);
  v_4dig   varchar2(1) := :p74_quatro_digitos;
  v_fim_pr number;
  v_fim_ds number;
  v_total  number;
  v_tipo   number;
  v_tot    varchar2(1);
  v_json   clob;
  type t_inc is table of varchar2(1) index by pls_integer;
  v_inc    t_inc;
  v_pos    pls_integer := 1;
begin
  -- o JSON e montado num CLOB e escrito no fim: se algo antes (a validacao do mes, por exemplo) deixar
  -- o apex_json desviado ou pela metade, a resposta nao sai vazia (05/10: saia, e a tela dava erro).
  -- o item vem do processo de abertura; se a sessao nao o tiver, le direto da configuracao
  if v_4dig is null then
    begin
      select quatro_digitos_ocorr into v_4dig from configuracoes;
    exception
      when others then
        v_4dig := 'N';
    end;
  end if;
  if v_4dig = 'S' then
    v_fim_pr := 4999; v_fim_ds := 8999; v_total := 9997;
  else
    v_fim_pr := 499;  v_fim_ds := 899;  v_total := 997;
  end if;
  -- incide no liquido? (a mesma coluna da pagina 21 e do recibo): na faixa de provento/desconto, so conta
  -- como ganho/desconto a verba com incid_liq = 'S'; com 'N' ela e base (ex.: 807 Capital Segurado).
  -- Se a view nao responder, vale so a faixa.
  begin
    for x in (select v.cod_ocorr, max(v.incid_liq) incid
                from vw_historicos v
               where v.cod_empresa = :p74_emp
                 and v.matricula = :p74_mat
                 and v.data_ref = :p74_data_ref
               group by v.cod_ocorr) loop
      v_inc(x.cod_ocorr) := x.incid;
    end loop;
  exception
    when others then
      v_inc.delete;
  end;
  -- a mesma validacao da acao "Valida Dt Ref". Se ELA falhar (excecao), vale o que a pagina faz hoje:
  -- a acao so mostra o aviso de erro, P74_MSG fica vazio e o relatorio aparece. Aqui: as verbas vao.
  begin
  pkg_executa_f011544.valida_parametros(:p74_emp,
                                        :p74_mat,
                                        'HF',
                                        :p74_data_ref,
                                        :p_usuario,
                                        :p_empresa_user,
                                        :p_matricula_user,
                                        v_flg,
                                        v_msg);
  exception
    when others then
      v_flg := null;
      v_msg := null;
  end;
  apex_json.free_output;
  apex_json.initialize_clob_output;
  apex_json.open_object;
  if v_flg = 'N' and trim(v_msg) is not null then
    apex_json.write('bloqueado', true);
    apex_json.write('msg', v_msg);
  else
    apex_json.write('quatro_digitos', v_4dig);
    apex_json.open_array('itens');
    for r in (select h.cod_ocorr||' - '||h.dc_ocorr codigo, h.cod_ocorr cod, initcap(o.nome) descricao,
                     h.unidade1 qtde, h.unidade2 dias, h.valor, h.faixa, h.dt_inic_val, h.dt_fin_val
                from hist_financeiro h, ocorr_pagto o
               where h.cod_empresa = o.cod_empresa
                 and h.cod_ocorr = o.cod
                 and h.dc_ocorr = o.dc_cod
                 and h.cod_empresa = :p74_emp
                 and h.matricula = :p74_mat
                 and h.data_ref = :p74_data_ref
               order by 1) loop
      -- 1 provento, 2 desconto, 3 base; os 3 ultimos codigos sao os totais da folha
      v_tot := case r.cod
                 when v_total     then 'g'
                 when v_total + 1 then 'd'
                 when v_total + 2 then 'l'
               end;
      v_tipo := case
                  when v_inc.exists(r.cod) and v_inc(r.cod) = 'N' then 3
                  when r.cod <= v_fim_pr then 1
                  when r.cod <= v_fim_ds then 2
                  else 3
                end;
      apex_json.open_object;
      apex_json.write('codigo', r.codigo);
      apex_json.write('descricao', r.descricao);
      apex_json.write('tipo', v_tipo);
      apex_json.write('total', v_tot);
      apex_json.write('qtde', r.qtde);
      apex_json.write('dias', r.dias);
      apex_json.write('valor', r.valor);
      apex_json.write('faixa', r.faixa);
      apex_json.write('inicio', to_char(r.dt_inic_val, 'dd/mm/yyyy'));
      apex_json.write('fim', to_char(r.dt_fin_val, 'dd/mm/yyyy'));
      apex_json.close_object;
    end loop;
    apex_json.close_array;
  end if;
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
