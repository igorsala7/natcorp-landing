/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 03  VISOES SOBRE O CADASTRO                                 |
   +========================================================================================+
   ONT_V_CANDIDATO   uma linha por candidato, com os campos que a aderencia usa.
                     MONTADA PELO SCRIPT: cada campo e procurado em INF_PESSOAIS_CANDIDATO (P) e
                     INF_FUNC_CANDIDATO (F), nessa ordem; o que nao existir vira NULL COM TIPO e
                     aparece como AVISO na saida (o criterio correspondente fica sem dado, nao quebra).
   ONT_V_CAND_FONTE  o cadastro em LINHAS: cada formacao, curso, habilidade, emprego, e cada linha
                     dos campos de observacao. E o que vira ONT_CAND_LINHA.
   Rodar de novo este script e seguro (create or replace).
*/
set define off
alter session set nls_length_semantics = char;
set serveroutput on size unlimited

declare
  /* "ALIAS | colunas procuradas, na ordem (P. = INF_PESSOAIS_CANDIDATO, F. = INF_FUNC_CANDIDATO) | tipo"
     tipo: L = texto longo - N = numero (usado em conta) - D = data - vazio = texto curto */
  type t_lista is table of varchar2(300);
  campos t_lista := t_lista(
    'NOME               | P.NOME                                          |',
    'INSTRUCAO          | P.INSTRUCAO,F.INSTRUCAO                         |',
    'CIDADE             | P.CIDADE                                        |',
    'UF                 | P.UF                                            |',
    'CEP                | P.CEP,F.CEP                                     |',
    'COMPLEMENTO_CEP    | P.COMPLEMENTO_CEP,F.COMPLEMENTO_CEP             |',
    'IND_DEF_FIS        | P.IND_DEF_FIS,F.IND_DEF_FIS                     |',
    'DEF_FISICA         | P.RAIS_IND_DEF_FISICO,F.RAIS_IND_DEF_FISICO     |',
    'DEF_AUDITIVA       | P.RAIS_IND_DEF_AUDITIVA,F.RAIS_IND_DEF_AUDITIVA |',
    'DEF_VISUAL         | P.RAIS_IND_DEF_VISUAL,F.RAIS_IND_DEF_VISUAL     |',
    'DEF_MENTAL         | P.RAIS_IND_DEF_MENTAL,F.RAIS_IND_DEF_MENTAL     |',
    'DEF_MULTIPLA       | P.RAIS_IND_DEF_MULTIPLA,F.RAIS_IND_DEF_MULTIPLA |',
    'CARGO_PRETENDIDO   | F.CARGO_PRETENDIDO,P.CARGO_PRETENDIDO           |',
    'LOCAL_PRETENDIDO   | F.LOCAL_PRETENDIDO,P.LOCAL_PRETENDIDO           |',
    'SALARIO_PRETENDIDO | F.SALARIO_PRETENDIDO,P.SALARIO_PRETENDIDO       | N',
    'STATUS_CANDIDATO   | F.STATUS_CANDIDATO,P.STATUS_CANDIDATO           |',
    'QUALIFICACAO       | F.DESC_QUALIFIC_FUNC,P.DESC_QUALIFIC_FUNC       | L',
    'FORMACAO_OBS       | P.FORMACAO_ESCOLAR_OBS,F.FORMACAO_ESCOLAR_OBS   | L',
    'CURSO_OBS          | P.CURSO_OBS,F.CURSO_OBS                         | L',
    'HABILIDADE_OBS     | P.HABILIDADE_OBS,F.HABILIDADE_OBS               | L',
    'DT_ATU_P           | P.DT_ATUALIZACAO                                | D',
    'DT_ATU_F           | F.DT_ATUALIZACAO                                | D',
    'DATA_CADASTRO      | P.DATA_CADASTRO                                 | D'
  );
  v_alias varchar2(30);
  v_cands varchar2(200);
  v_tp    varchar2(1);
  v_sql   varchar2(32767);
  v_expr  varchar2(400);
  v_tipo  varchar2(30);
  v_tab   varchar2(30);
  v_col   varchar2(30);
  v_item  varchar2(70);
  i       pls_integer;

  function tipo_coluna (p_tabela varchar2, p_coluna varchar2) return varchar2 is
    r varchar2(30);
  begin
    select data_type into r
      from (select c.data_type
              from all_tab_columns c
             where c.table_name = p_tabela and c.column_name = p_coluna
               and (c.owner = user or c.owner in (select s.table_owner from all_synonyms s
                                                    where s.synonym_name = p_tabela and s.owner in (user, 'PUBLIC')))
             order by case when c.owner = user then 0 else 1 end)
     where rownum = 1;
    return r;
  exception when no_data_found then return null;
  end tipo_coluna;
begin
  v_sql := 'create or replace view ont_v_candidato as' || chr(10) ||
           'select p.cod_candidato, p.empresa cod_empresa';
  for k in 1 .. campos.count loop
    v_alias := trim(regexp_substr(campos(k), '[^|]+', 1, 1));
    v_cands := replace(trim(regexp_substr(campos(k), '[^|]+', 1, 2)), ' ');
    v_tp    := substr(trim(regexp_substr(campos(k), '[^|]+', 1, 3)), 1, 1);
    v_expr  := null;
    i := 1;
    loop
      v_item := trim(regexp_substr(v_cands, '[^,]+', 1, i));
      exit when v_item is null;
      i := i + 1;
      v_tab := case substr(v_item, 1, 1) when 'P' then 'INF_PESSOAIS_CANDIDATO' else 'INF_FUNC_CANDIDATO' end;
      v_col := substr(v_item, 3);
      v_tipo := tipo_coluna(v_tab, v_col);
      if v_tipo is null then
        continue;
      elsif v_tp = 'N' and v_tipo <> 'NUMBER' then
        dbms_output.put_line('  AVISO ' || rpad(v_alias, 14) || ' ' || v_item || to_char(unistr(' \00E9 ')) || v_tipo || to_char(unistr(', n\00E3o NUMBER \2014 fica vazio')));
        v_expr := 'cast(null as number)';
      elsif v_tp = 'D' and v_tipo not like 'DATE%' and v_tipo not like 'TIMESTAMP%' then
        v_expr := 'ont_texto.data_segura(' || lower(v_item) || ')';
      elsif v_tp = 'L' then
        /* 1500 caracteres: cabe em 4000 BYTES mesmo com acentos (AL32UTF8) */
        v_expr := case when v_tipo in ('CLOB', 'NCLOB') then 'to_char(dbms_lob.substr(' || lower(v_item) || ', 1500, 1))'
                       else 'substr(' || lower(v_item) || ', 1, 1500)' end;
      else
        v_expr := lower(v_item);
      end if;
      dbms_output.put_line('  ' || rpad(v_alias, 20) || to_char(unistr(' \2190 ')) || v_item || ' (' || v_tipo || ')');
      exit;
    end loop;
    if v_expr is null then
      /* vazio COM TIPO: um null sem tipo quebraria comparacoes e unioes adiante */
      v_expr := case v_tp when 'D' then 'cast(null as date)' when 'N' then 'cast(null as number)'
                          else 'cast(null as varchar2(1500))' end;
      dbms_output.put_line('  AVISO ' || rpad(v_alias, 14) || to_char(unistr(' n\00E3o encontrado em ')) || v_cands || to_char(unistr(' \2014 fica vazio')));
    end if;
    v_sql := v_sql || ',' || chr(10) || '       ' || v_expr || ' ' || lower(v_alias);
  end loop;
  v_sql := v_sql || chr(10) ||
           '  from inf_pessoais_candidato p' || chr(10) ||
           '  join inf_func_candidato f on f.cod_candidato = p.cod_candidato';
  execute immediate v_sql;
  dbms_output.put_line('ONT_V_CANDIDATO criada.');
end;
/

/* o cadastro em linhas. Uma origem nova = um "union all" novo + a origem em ONT_CRITERIO_ORIGEM. */
create or replace view ont_v_cand_fonte as
select fe.cod_candidato,
       'FORMACAO' origem,
       substr(fe.descricao || case when fe.entidade is not null then ' - ' || fe.entidade end, 1, 1000) texto,
       substr(fe.descricao, 1, 1000) texto_base,
       case when fe.status = 'N' then 'N' else 'S' end concluido,
       cast(null as number) nivel_ordem,
       cast(null as date) data_ini,
       cast(null as date) data_fim
  from formacao_escolar_candidato fe
  join ont_v_candidato c on c.cod_candidato = fe.cod_candidato and c.cod_empresa = fe.cod_empresa
 where fe.descricao is not null
union all
select cc.cod_candidato, 'CURSO',
       substr(cc.descricao || case when cc.local is not null then ' - ' || cc.local end, 1, 1000),
       substr(cc.descricao, 1, 1000),
       case when cc.conclusao = 'N' then 'N' else 'S' end,
       cast(null as number), cast(null as date), cast(null as date)
  from curso_candidato cc
  join ont_v_candidato c on c.cod_candidato = cc.cod_candidato and c.cod_empresa = cc.cod_empresa
 where cc.descricao is not null
union all
select hc.cod_candidato, 'HABILIDADE',
       substr(hb.descricao || case when nc.descricao is not null then ' (' || nc.descricao || ')' end, 1, 1000),
       substr(hb.descricao, 1, 1000),
       cast(null as varchar2(1)), nvo.ordem, cast(null as date), cast(null as date)
  from habilidade_candidato hc
  join ont_v_candidato c on c.cod_candidato = hc.cod_candidato and c.cod_empresa = hc.cod_empresa
  join habilidade hb on hb.codigo = hc.cod_habilidade
  left join nivel_conhecimento nc on nc.codigo = hc.cod_nivel_conh
  left join ont_nivel_ordem nvo on nvo.codigo = to_char(hc.cod_nivel_conh)
union all
select a.cod_candidato, 'EMPREGO',
       substr(a.cargo || case when a.nome_empresa is not null then ' - ' || a.nome_empresa end, 1, 1000),
       substr(a.cargo, 1, 1000),
       cast(null as varchar2(1)), cast(null as number),
       a.data_adm_emp, a.data_desl_emp      -- se forem TEXTO, o bloco abaixo troca por ont_texto.data_segura
  from empregos_anteriores a
 where a.cargo is not null
union all
select c.cod_candidato, 'QUALIF', substr(c.qualificacao, 1, 1000), substr(c.qualificacao, 1, 1000),
       cast(null as varchar2(1)), cast(null as number), cast(null as date), cast(null as date)
  from ont_v_candidato c
 where c.qualificacao is not null
union all
select c.cod_candidato, 'OBS_FORMACAO', l.column_value, l.column_value,
       cast(null as varchar2(1)), cast(null as number), cast(null as date), cast(null as date)
  from ont_v_candidato c, table(ont_texto.linhas(c.formacao_obs)) l
 where c.formacao_obs is not null
union all
select c.cod_candidato, 'OBS_CURSO', l.column_value, l.column_value,
       cast(null as varchar2(1)), cast(null as number), cast(null as date), cast(null as date)
  from ont_v_candidato c, table(ont_texto.linhas(c.curso_obs)) l
 where c.curso_obs is not null
union all
select c.cod_candidato, 'OBS_HABILIDADE', l.column_value, l.column_value,
       cast(null as varchar2(1)), cast(null as number), cast(null as date), cast(null as date)
  from ont_v_candidato c, table(ont_texto.linhas(c.habilidade_obs)) l
 where c.habilidade_obs is not null;

/* EMPREGOS_ANTERIORES com datas guardadas como TEXTO: a visao passa a converte-las */
declare
  v_tipo varchar2(30);
  v_txt  varchar2(32767);
begin
  select max(data_type) into v_tipo from all_tab_columns
   where table_name = 'EMPREGOS_ANTERIORES' and column_name = 'DATA_ADM_EMP';
  if v_tipo is not null and v_tipo not like 'DATE%' and v_tipo not like 'TIMESTAMP%' then
    select text into v_txt from user_views where view_name = 'ONT_V_CAND_FONTE';
    v_txt := replace(v_txt, 'a.data_adm_emp, a.data_desl_emp',
                     'ont_texto.data_segura(a.data_adm_emp), ont_texto.data_segura(a.data_desl_emp)');
    execute immediate 'create or replace view ont_v_cand_fonte as ' || v_txt;
    dbms_output.put_line(to_char(unistr('ONT_V_CAND_FONTE: datas dos empregos s\00E3o ')) || v_tipo || to_char(unistr(' \2014 convertidas por ont_texto.data_segura')));
  end if;
end;
/

/* conferencia: um candidato nao pode aparecer duas vezes (a chave usada em tudo e COD_CANDIDATO) */
declare
  n number;
begin
  select count(*) into n from (select cod_candidato from ont_v_candidato group by cod_candidato having count(*) > 1);
  if n > 0 then
    raise_application_error(-20103, n || to_char(unistr(' COD_CANDIDATO aparecem mais de uma vez em ONT_V_CANDIDATO \2014 '))
      || to_char(unistr('a chave do candidato inclui a empresa? Ajuste a jun\00E7\00E3o da vis\00E3o antes de seguir.')));
  end if;
  dbms_output.put_line('ONT_V_CANDIDATO: nenhum candidato repetido.');
end;
/

prompt 03_visoes: ONT_V_CANDIDATO e ONT_V_CAND_FONTE criadas.
