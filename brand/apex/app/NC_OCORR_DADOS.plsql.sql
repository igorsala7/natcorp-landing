-- Entrega os lancamentos (ocorrencia_calculo) ao Natcorp_Folha.js (modo ocorrencias), em JSON. A MESMA
-- consulta do relatorio "Ocorrencia de Pagamento", mais o tipo de cada verba, com a regra da Folha do Mes:
--   quatro_digitos_ocorr N: 1-499 provento, 500-899 desconto, 900 em diante base
--   quatro_digitos_ocorr S: 1-4999 provento, 5000-8999 desconto, 9000 em diante base
--   e, na faixa de provento/desconto, incid_liq = 'N' (nao incide no liquido) e base.
-- P104_DATA_REF vazio ("Todas") = todos os meses, o mais novo primeiro.
declare
  v_4dig   varchar2(1) := 'N';
  v_fim_pr number;
  v_fim_ds number;
  v_tipo   number;
  v_json   clob;
  v_pos    pls_integer := 1;
  type t_inc is table of varchar2(1) index by pls_integer;
  v_inc    t_inc;
begin
  begin
    select quatro_digitos_ocorr into v_4dig from configuracoes;
  exception
    when others then
      v_4dig := 'N';
  end;
  if v_4dig = 'S' then
    v_fim_pr := 4999; v_fim_ds := 8999;
  else
    v_fim_pr := 499;  v_fim_ds := 899;
  end if;
  -- incide no liquido? lido do que o sistema ja calculou para este colaborador (qualquer mes);
  -- verba nunca calculada para ele: vale so a faixa
  begin
    for x in (select v.cod_ocorr, max(v.incid_liq) incid
                from vw_historicos v
               where v.cod_empresa = :p104_emp
                 and v.matricula = :p104_mat
               group by v.cod_ocorr) loop
      v_inc(x.cod_ocorr) := x.incid;
    end loop;
  exception
    when others then
      v_inc.delete;
  end;
  apex_json.free_output;
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('quatro_digitos', v_4dig);
  apex_json.open_array('itens');
  for r in (select h.cod_ocorr||' - '||h.dc_ocorr codigo, h.cod_ocorr cod, initcap(o.nome) descricao,
                   h.unidade1 qtde, h.unidade2 dias, h.valor, h.faixa, h.dt_inic_val, h.dt_fin_val, h.data_ref
              from ocorrencia_calculo h, ocorr_pagto o
             where h.cod_empresa = o.cod_empresa
               and h.cod_ocorr = o.cod
               and h.dc_ocorr = o.dc_cod
               and h.cod_empresa = :p104_emp
               and h.matricula = :p104_mat
               and h.data_ref = nvl(:p104_data_ref, h.data_ref)
             order by h.data_ref desc, h.cod_ocorr) loop
    v_tipo := case
                when v_inc.exists(r.cod) and v_inc(r.cod) = 'N' then 3
                when r.cod <= v_fim_pr then 1
                when r.cod <= v_fim_ds then 2
                else 3
              end;
    apex_json.open_object;
    apex_json.write('ref', to_char(r.data_ref, 'dd/mm/yyyy'));
    apex_json.write('codigo', r.codigo);
    apex_json.write('descricao', r.descricao);
    apex_json.write('tipo', v_tipo);
    apex_json.write('qtde', r.qtde);
    apex_json.write('dias', r.dias);
    apex_json.write('valor', r.valor);
    apex_json.write('faixa', r.faixa);
    apex_json.write('inicio', to_char(r.dt_inic_val, 'dd/mm/yyyy'));
    apex_json.write('fim', to_char(r.dt_fin_val, 'dd/mm/yyyy'));
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
