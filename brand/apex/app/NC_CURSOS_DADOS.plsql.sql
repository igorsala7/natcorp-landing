-- Entrega ao Natcorp_Cursos.js, em JSON, o que o cargo pede e o que o colaborador ja fez: as MESMAS consultas
-- das listas "Cursos Exigidos", "Cursos do Colaborador" e "Cursos a Realizar", o nome do cargo e o estudo.
declare
  v_cargo  varchar2(100) := :p90_cargo;
  v_cc     varchar2(100) := :p90_cod_ccusto;
  v_nome   varchar2(400);
  v_ex_cod varchar2(30);
  v_ex     varchar2(400);
  v_at_cod varchar2(30);
  v_at     varchar2(400);
  v_json   clob;
  v_pos    pls_integer := 1;
begin
  -- cargo e centro de custo: os mesmos do processo popula_colab (se a sessao nao os tiver, le de novo)
  if v_cargo is null then
    begin
      select i.cargo, i.cod_ccusto into v_cargo, v_cc
        from informacoes_funcionais i
       where i.cod_empresa = :p90_emp
         and i.matricula = :p90_mat;
    exception
      when others then null;
    end;
  end if;
  begin
    v_nome := v_cargo || ' - ' || initcap(fnct_nome_cargo(v_cargo));
  exception
    when others then v_nome := null;
  end;
  -- o estudo que o cargo pede (como no app 202) e o que a pessoa tem: os dois na tabela instrucao
  begin
    select min(f.cod_instrucao) into v_ex_cod
      from pc_parametro_formacao f
     where f.cod_empresa = :p90_emp
       and f.cod_cargo = v_cargo;
    if v_ex_cod is not null then
      select initcap(g.nome) into v_ex from instrucao g where g.cod = v_ex_cod;
    end if;
  exception
    when others then
      v_ex_cod := null;
      v_ex := null;
  end;
  begin
    select a.instrucao, initcap(b.nome) into v_at_cod, v_at
      from inf_pessoais a, instrucao b
     where b.cod = a.instrucao
       and a.cod_empresa = :p90_emp
       and a.matricula = :p90_mat;
  exception
    when others then
      v_at_cod := null;
      v_at := null;
  end;
  apex_json.free_output;
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('cargo', v_nome);
  apex_json.open_object('escolaridade');
  apex_json.write('exigida_cod', v_ex_cod);
  apex_json.write('exigida', v_ex);
  apex_json.write('atual_cod', v_at_cod);
  apex_json.write('atual', v_at);
  apex_json.close_object;
  apex_json.open_array('exigidos');
  for x in (select distinct c.cod_curso cod, initcap(cv.nome_curso) nome,
                   case when exists (select 1
                                       from curriculum_v a
                                      where a.cod_empresa = :p90_emp
                                        and a.matricula = :p90_mat
                                        and a.ind_conclusao = 'S'
                                        and a.cod_curso = c.cod_curso) then 'S' else 'N' end feito
              from curso_cargo c, curso_v cv
             where c.cod_cargo = v_cargo
               and c.cod_ccusto = v_cc
               and c.cod_curso = cv.cod_curso
             order by 2) loop
    apex_json.open_object;
    apex_json.write('cod', to_char(x.cod));
    apex_json.write('nome', x.nome);
    apex_json.write('feito', x.feito);
    apex_json.close_object;
  end loop;
  apex_json.close_array;
  apex_json.open_array('outros');
  for x in (select distinct c.cod_curso cod, initcap(cv.nome_curso) nome
              from curriculum_v c, curso_v cv
             where c.cod_empresa = :p90_emp
               and c.matricula = :p90_mat
               and c.ind_conclusao = 'S'
               and c.cod_curso = cv.cod_curso
               and not exists (select 1
                                 from curso_cargo k
                                where k.cod_cargo = v_cargo
                                  and k.cod_ccusto = v_cc
                                  and k.cod_curso = c.cod_curso)
             order by 2) loop
    apex_json.open_object;
    apex_json.write('cod', to_char(x.cod));
    apex_json.write('nome', x.nome);
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
