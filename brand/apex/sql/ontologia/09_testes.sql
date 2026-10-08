/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 09  TESTES (depois do 07; nao altera dados)                  |
   +========================================================================================+
   GERADO por gerar_carga.py. Imprime OK/FALHA por caso e termina com ERRO se houver falha.
   Os mesmos casos foram conferidos fora do banco (espelho em Python) antes da entrega.
*/
set define off
set serveroutput on size unlimited
declare
  n_ok number := 0; n_falha number := 0;
  v varchar2(200);
  d number;
  a number;
  b number;
  procedure conferir (p_ok boolean, p_desc varchar2) is
  begin
    if p_ok then n_ok := n_ok + 1; else n_falha := n_falha + 1; dbms_output.put_line('  FALHA  ' || p_desc); end if;
  end;
  function nome_de (p_id number) return varchar2 is r varchar2(200);
  begin select nome into r from ont_conceito where id = p_id; return r; exception when no_data_found then return null; end;
  function id_de (p varchar2) return number is r number;
  begin select min(id) into r from ont_conceito where upper(nome) = upper(p); return r; end;
  function tem_conceito (p_texto varchar2, p_conceito varchar2) return boolean is
    v_norm varchar2(1000) := ont_texto.normalizar(p_texto);
    v_cid  number := id_de(p_conceito);
    n number;
  begin
    /* a mesma regra de ont_ontologia.classificar_linhas, para TODOS os conceitos do texto */
    select count(*) into n
      from (select tt.termo_id, count(distinct tt.posicao) achou
              from table(ont_texto.tokens(v_norm)) lt
              join ont_termo_token tt on tt.p3 = lt.p3
               and (tt.token = lt.token
                    or (length(lt.token) >= 3 and tt.token like lt.token || '%' and ont_texto.conhecida(lt.token) = 0)
                    or (length(lt.token) >= 6 and length(tt.token) >= 6 and utl_match.edit_distance(lt.token, tt.token) <= 1
                        and ont_texto.conhecida(lt.token) = 0))
             group by tt.termo_id) m
      join ont_termo t on t.id = m.termo_id and m.achou = t.n_tokens
     where t.conceito_id = v_cid;
    return n > 0;
  end;
begin
  ont_ontologia.limpar_cache;
  dbms_output.put_line('== comparar texto (requisito x linha do candidato) ==');
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Administra\00E7\00E3o de Empresas'))), ont_texto.normalizar('Adm. Empresa')) = 1, to_char(unistr('contem: Adm. Empresa | Administra\00E7\00E3o de Empresas -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar('Adm. de Empresas'), ont_texto.normalizar(to_char(unistr('Administra\00E7\00E3o de Empresas')))) = 1, to_char(unistr('contem: Administra\00E7\00E3o de Empresas | Adm. de Empresas -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Analista de Neg\00F3cios'))), ont_texto.normalizar(to_char(unistr('An. de neg\00F3cio')))) = 1, to_char(unistr('contem: An. de neg\00F3cio | Analista de Neg\00F3cios -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('An. de neg\00F3cio'))), ont_texto.normalizar(to_char(unistr('Analista de Neg\00F3cios')))) = 1, to_char(unistr('contem: Analista de Neg\00F3cios | An. de neg\00F3cio -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Analista de Neg\00F3cios'))), ont_texto.normalizar(to_char(unistr('Analista de neg\00F3cio')))) = 1, to_char(unistr('contem: Analista de neg\00F3cio | Analista de Neg\00F3cios -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Analista de Neg\00F3cio'))), ont_texto.normalizar(to_char(unistr('Analista de neg\00F3cios')))) = 1, to_char(unistr('contem: Analista de neg\00F3cios | Analista de Neg\00F3cio -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar('Eng. Civil'), ont_texto.normalizar('Engenharia Civil')) = 1, 'contem: Engenharia Civil | Eng. Civil -> esperado 1');
  conferir(ont_texto.contem(ont_texto.normalizar('Auxiliar administrativo'), ont_texto.normalizar('Aux. Administrativo')) = 1, 'contem: Aux. Administrativo | Auxiliar administrativo -> esperado 1');
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('T\00E9cnico em an\00E1lises cl\00EDnicas'))), ont_texto.normalizar(to_char(unistr('An. de neg\00F3cio')))) = 0, to_char(unistr('contem: An. de neg\00F3cio | T\00E9cnico em an\00E1lises cl\00EDnicas -> esperado 0')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Excel avan\00E7ado'))), ont_texto.normalizar('Excel')) = 1, to_char(unistr('contem: Excel | Excel avan\00E7ado -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar('Eng. Civil'), ont_texto.normalizar('Engenheiro Civil')) = 1, 'contem: Engenheiro Civil | Eng. Civil -> esperado 1');
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Adminstra\00E7\00E3o'))), ont_texto.normalizar(to_char(unistr('Administra\00E7\00E3o')))) = 1, to_char(unistr('contem: Administra\00E7\00E3o | Adminstra\00E7\00E3o -> esperado 1')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Administra\00E7\00E3o de Empresas'))), ont_texto.normalizar('Direito')) = 0, to_char(unistr('contem: Direito | Administra\00E7\00E3o de Empresas -> esperado 0')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Tecnologia em Log\00EDstica'))), ont_texto.normalizar(to_char(unistr('T\00E9cnico em Enfermagem')))) = 0, to_char(unistr('contem: T\00E9cnico em Enfermagem | Tecnologia em Log\00EDstica -> esperado 0')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Administra\00E7\00E3o de Empresas'))), ont_texto.normalizar('Auxiliar Administrativo')) = 0, to_char(unistr('contem: Auxiliar Administrativo | Administra\00E7\00E3o de Empresas -> esperado 0')));
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('Excelente comunica\00E7\00E3o'))), ont_texto.normalizar('Excel')) = 0, to_char(unistr('contem: Excel | Excelente comunica\00E7\00E3o -> esperado 0')));
  conferir(ont_texto.contem(ont_texto.normalizar('JavaScript'), ont_texto.normalizar('Java')) = 0, 'contem: Java | JavaScript -> esperado 0');
  conferir(ont_texto.contem(ont_texto.normalizar('Curso NR 35 trabalho em altura'), ont_texto.normalizar('NR-35')) = 1, 'contem: NR-35 | Curso NR 35 trabalho em altura -> esperado 1');
  conferir(ont_texto.contem(ont_texto.normalizar(to_char(unistr('pl sql avan\00E7ado'))), ont_texto.normalizar('PL/SQL')) = 1, to_char(unistr('contem: PL/SQL | pl sql avan\00E7ado -> esperado 1')));
  dbms_output.put_line('== classificar (conceito mais especifico) ==');
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Adm. de Empresas')));
  conferir(v = to_char(unistr('Administra\00E7\00E3o')), to_char(unistr('classificar: Adm. de Empresas -> esperado Administra\00E7\00E3o, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('Gest\00E3o de RH')))));
  conferir(v = to_char(unistr('Gest\00E3o de Recursos Humanos')), to_char(unistr('classificar: Gest\00E3o de RH -> esperado Gest\00E3o de Recursos Humanos, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('Analista de neg\00F3cios')))));
  conferir(v = to_char(unistr('Analista de Neg\00F3cios')), to_char(unistr('classificar: Analista de neg\00F3cios -> esperado Analista de Neg\00F3cios, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('An. de Neg\00F3cios')))));
  conferir(v = to_char(unistr('Analista de Neg\00F3cios')), to_char(unistr('classificar: An. de Neg\00F3cios -> esperado Analista de Neg\00F3cios, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Eng. Civil')));
  conferir(v = 'Engenharia Civil', 'classificar: Eng. Civil -> esperado Engenharia Civil, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('T\00E9cnica de Enfermagem')))));
  conferir(v = to_char(unistr('T\00E9cnico em Enfermagem')), to_char(unistr('classificar: T\00E9cnica de Enfermagem -> esperado T\00E9cnico em Enfermagem, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('MBA em Gest\00E3o de Pessoas')))));
  conferir(v = to_char(unistr('Gest\00E3o de Recursos Humanos')), to_char(unistr('classificar: MBA em Gest\00E3o de Pessoas -> esperado Gest\00E3o de Recursos Humanos, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('NR-35')));
  conferir(v = 'NR-35', 'classificar: NR-35 -> esperado NR-35, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Curso de NR 35 - Trabalho em altura')));
  conferir(v = 'NR-35', 'classificar: Curso de NR 35 - Trabalho em altura -> esperado NR-35, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('PL/SQL')));
  conferir(v = 'SQL', 'classificar: PL/SQL -> esperado SQL, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Vendedor externo')));
  conferir(v = 'Vendedor', 'classificar: Vendedor externo -> esperado Vendedor, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Auxiliar adm.')));
  conferir(v = 'Auxiliar Administrativo', 'classificar: Auxiliar adm. -> esperado Auxiliar Administrativo, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Assistente de DP')));
  conferir(v = 'Assistente de Departamento Pessoal', 'classificar: Assistente de DP -> esperado Assistente de Departamento Pessoal, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Rotinas de DP e folha')));
  conferir(v = 'Departamento Pessoal', 'classificar: Rotinas de DP e folha -> esperado Departamento Pessoal, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('T.I.')));
  conferir(v = to_char(unistr('Tecnologia da Informa\00E7\00E3o')), to_char(unistr('classificar: T.I. -> esperado Tecnologia da Informa\00E7\00E3o, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('Engenharia Mec\00E2nica')))));
  conferir(v = to_char(unistr('Engenharia Mec\00E2nica')), to_char(unistr('classificar: Engenharia Mec\00E2nica -> esperado Engenharia Mec\00E2nica, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Java e Spring')));
  conferir(v = 'Java', 'classificar: Java e Spring -> esperado Java, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Node.js')));
  conferir(v = 'JavaScript', 'classificar: Node.js -> esperado JavaScript, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Operadora de caixa')));
  conferir(v = 'Operador de Caixa', 'classificar: Operadora de caixa -> esperado Operador de Caixa, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('Enfermeira')));
  conferir(v = 'Enfermagem', 'classificar: Enfermeira -> esperado Enfermagem, veio ' || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('Tecnologia em Log\00EDstica')))));
  conferir(v = to_char(unistr('Log\00EDstica')), to_char(unistr('classificar: Tecnologia em Log\00EDstica -> esperado Log\00EDstica, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar(to_char(unistr('Analista Cont\00E1bil Pleno')))));
  conferir(v = to_char(unistr('Analista Cont\00E1bil')), to_char(unistr('classificar: Analista Cont\00E1bil Pleno -> esperado Analista Cont\00E1bil, veio ')) || nvl(v, '(nenhum)'));
  v := nome_de(ont_ontologia.classificar_texto(ont_texto.normalizar('R.H.')));
  conferir(v = to_char(unistr('Gest\00E3o de Recursos Humanos')), to_char(unistr('classificar: R.H. -> esperado Gest\00E3o de Recursos Humanos, veio ')) || nvl(v, '(nenhum)'));
  dbms_output.put_line('== nao pode reconhecer ==');
  conferir(not tem_conceito(to_char(unistr('Excelente comunica\00E7\00E3o e lideran\00E7a')), 'Excel'), to_char(unistr('nao classificar: Excelente comunica\00E7\00E3o e lideran\00E7a como Excel')));
  conferir(not tem_conceito('Trabalho em home office', 'Pacote Office'), 'nao classificar: Trabalho em home office como Pacote Office');
  conferir(not tem_conceito(to_char(unistr('Gest\00E3o de redes sociais')), 'Redes de Computadores'), to_char(unistr('nao classificar: Gest\00E3o de redes sociais como Redes de Computadores')));
  conferir(not tem_conceito(to_char(unistr('Tecnologia em Log\00EDstica')), to_char(unistr('Tecnologia da Informa\00E7\00E3o'))), to_char(unistr('nao classificar: Tecnologia em Log\00EDstica como Tecnologia da Informa\00E7\00E3o')));
  conferir(not tem_conceito('Analista de sistemas', to_char(unistr('Analista de Neg\00F3cios'))), to_char(unistr('nao classificar: Analista de sistemas como Analista de Neg\00F3cios')));
  dbms_output.put_line('== hierarquia (mais amplo) ==');
  a := id_de('Engenharia Civil'); b := id_de('Engenharia');
  select count(*) into d from ont_conceito_fecho where conceito_id = a and ancestral_id = b;
  conferir(d = 1, 'fecho: Engenharia Civil e um tipo de Engenharia');
  a := id_de('Vendedor'); b := id_de('Vendas');
  select count(*) into d from ont_conceito_fecho where conceito_id = a and ancestral_id = b;
  conferir(d = 1, 'fecho: Vendedor e um tipo de Vendas');
  a := id_de('Analista de Departamento Pessoal'); b := id_de('Departamento Pessoal');
  select count(*) into d from ont_conceito_fecho where conceito_id = a and ancestral_id = b;
  conferir(d = 1, 'fecho: Analista de Departamento Pessoal e um tipo de Departamento Pessoal');
  a := id_de(to_char(unistr('T\00E9cnico em Seguran\00E7a do Trabalho'))); b := id_de(to_char(unistr('Seguran\00E7a do Trabalho')));
  select count(*) into d from ont_conceito_fecho where conceito_id = a and ancestral_id = b;
  conferir(d = 1, to_char(unistr('fecho: T\00E9cnico em Seguran\00E7a do Trabalho e um tipo de Seguran\00E7a do Trabalho')));
  dbms_output.put_line('== distancia ==');
  select ont_aderencia.km(s.latitude, s.longitude, o.latitude, o.longitude) into d
    from ont_municipio_geo s, ont_municipio_geo o where s.cod_ibge7 = 3550308 and o.cod_ibge7 = 3552205;
  conferir(d between 75 and 90, 'km Sao Paulo - Sorocaba em linha reta entre 75 e 90 (veio ' || round(d, 1) || ')');
  select ont_aderencia.km(s.latitude, s.longitude, o.latitude, o.longitude) into d
    from ont_municipio_geo s, ont_municipio_geo o where s.cod_ibge7 = 3550308 and o.cod_ibge7 = 3304557;
  conferir(d between 340 and 370, 'km Sao Paulo - Rio de Janeiro em linha reta entre 340 e 370 (veio ' || round(d, 1) || ')');
  select count(*) into d from ont_municipio_geo where nome_norm = 'sao paulo' and uf = 'SP';
  conferir(d = 1, 'municipio Sao Paulo/SP achado pelo nome normalizado');
  dbms_output.put_line('== escalas ==');
  select count(*) into d from ont_instrucao_ordem where ordem is null;
  conferir(d = 0, d || ' grau(s) de instrucao sem ordem - corrigir em ONT_INSTRUCAO_ORDEM');
  select count(*) into d from ont_nivel_ordem where ordem is null;
  conferir(d = 0, d || ' nivel(is) de conhecimento sem ordem - corrigir em ONT_NIVEL_ORDEM');
  dbms_output.put_line(chr(10) || 'RESULTADO: ' || n_ok || ' ok, ' || n_falha || ' falha(s)');
  if n_falha > 0 then raise_application_error(-20199, n_falha || ' teste(s) falharam - veja acima'); end if;
end;
/
