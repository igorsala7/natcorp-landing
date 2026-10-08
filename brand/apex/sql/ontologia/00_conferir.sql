/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 00  CONFERIR ANTES DE INSTALAR (so leitura)                 |
   +========================================================================================+
   Rodar no esquema onde a ontologia vai ser instalada. NAO cria nem altera nada.
   Mostra:
     1. cada tabela/coluna da base que os scripts usam: OK ou FALTA (com o tipo de dado)
     2. as colunas do candidato procuradas em duas tabelas: em qual delas esta
     3. privilegios e pacotes necessarios
     4. uma amostra das tabelas de escala (instrucao, nivel, modalidade) para conferir os codigos
   So siga para o 01 se nao houver FALTA na parte 1 e 3. AVISO na parte 2 e aceitavel (o criterio
   correspondente fica sem dado).
*/
set define off
set serveroutput on size unlimited
set linesize 200
set pagesize 200

declare
  type t_lista is table of varchar2(80);
  /* tabela.coluna que os scripts usam diretamente */
  obrig t_lista := t_lista(
    'INF_PESSOAIS_CANDIDATO.COD_CANDIDATO', 'INF_PESSOAIS_CANDIDATO.EMPRESA', 'INF_PESSOAIS_CANDIDATO.NOME',
    'INF_PESSOAIS_CANDIDATO.CIDADE', 'INF_PESSOAIS_CANDIDATO.UF', 'INF_PESSOAIS_CANDIDATO.INSTRUCAO',
    'INF_FUNC_CANDIDATO.COD_CANDIDATO',
    'FORMACAO_ESCOLAR_CANDIDATO.COD_CANDIDATO', 'FORMACAO_ESCOLAR_CANDIDATO.COD_EMPRESA', 'FORMACAO_ESCOLAR_CANDIDATO.DESCRICAO',
    'FORMACAO_ESCOLAR_CANDIDATO.ENTIDADE', 'FORMACAO_ESCOLAR_CANDIDATO.STATUS',
    'CURSO_CANDIDATO.COD_CANDIDATO', 'CURSO_CANDIDATO.COD_EMPRESA', 'CURSO_CANDIDATO.DESCRICAO', 'CURSO_CANDIDATO.LOCAL',
    'CURSO_CANDIDATO.CONCLUSAO',
    'HABILIDADE_CANDIDATO.COD_CANDIDATO', 'HABILIDADE_CANDIDATO.COD_EMPRESA', 'HABILIDADE_CANDIDATO.COD_HABILIDADE',
    'HABILIDADE_CANDIDATO.COD_NIVEL_CONH', 'HABILIDADE.CODIGO', 'HABILIDADE.DESCRICAO',
    'IDIOMA_CANDIDATO.COD_CANDIDATO', 'IDIOMA_CANDIDATO.COD_EMPRESA', 'IDIOMA_CANDIDATO.COD_IDIOMA', 'IDIOMA_CANDIDATO.COD_NIVEL_CONH',
    'IDIOMA.CODIGO', 'IDIOMA.DESCRICAO', 'NIVEL_CONHECIMENTO.CODIGO', 'NIVEL_CONHECIMENTO.DESCRICAO',
    'EMPREGOS_ANTERIORES.COD_CANDIDATO', 'EMPREGOS_ANTERIORES.CARGO', 'EMPREGOS_ANTERIORES.NOME_EMPRESA',
    'EMPREGOS_ANTERIORES.DATA_ADM_EMP', 'EMPREGOS_ANTERIORES.DATA_DESL_EMP',
    'INSTRUCAO.COD', 'INSTRUCAO.NOME',
    'REQUISICAO.COD_REQ', 'REQUISICAO.COD_INSTRUCAO', 'REQUISICAO.ANOS_SERVICO', 'REQUISICAO.MESES_SERVICO',
    'REQUISICAO.EXP_NEC', 'REQUISICAO.IND_DEF_FIS', 'REQUISICAO.RAIS_IND_DEF_FISICO', 'REQUISICAO.RAIS_IND_DEF_AUDITIVA',
    'REQUISICAO.RAIS_IND_DEF_VISUAL', 'REQUISICAO.RAIS_IND_DEF_MENTAL', 'REQUISICAO.RAIS_IND_DEF_MULTIPLA',
    'REQUISICAO.TIPO_MODALIDADE', 'REQUISICAO.COD_CARGO', 'REQUISICAO.COD_LOCAL_TRAB', 'REQUISICAO.COD_EMPRESA',
    'REQUISICAO.COD_FILIAL', 'REQUISICAO.SALARIO', 'REQUISICAO.SALARIO_MAX', 'REQUISICAO.COD_SIT_REQ',
    'FORMACAO_REQ_PESSOAL.COD_REQ', 'FORMACAO_REQ_PESSOAL.NOME', 'FORMACAO_REQ_PESSOAL.EXIGE',
    'CURSO_REQ_PESSOAL.COD_REQ', 'CURSO_REQ_PESSOAL.NOME', 'CURSO_REQ_PESSOAL.EXIGE',
    'CONHECIMENTO_REQ_PESSOAL.COD_REQ', 'CONHECIMENTO_REQ_PESSOAL.NOME', 'CONHECIMENTO_REQ_PESSOAL.NIVEL', 'CONHECIMENTO_REQ_PESSOAL.EXIGE',
    'EXPERIENCIA_REQ_PESSOAL.COD_REQ', 'EXPERIENCIA_REQ_PESSOAL.NOME', 'EXPERIENCIA_REQ_PESSOAL.EXIGE',
    'IDIOMA_REQ_PESSOAL.COD_REQ', 'IDIOMA_REQ_PESSOAL.COD_IDIOMA', 'IDIOMA_REQ_PESSOAL.COD_NIVEL_CONH',
    'PS_PROCESSO_SELETIVO.COD_PROCESSO', 'PS_PROCESSO_SELETIVO.COD_REQ',
    'LOCAL_TRAB.COD_LOCAL_TRAB', 'LOCAL_TRAB.CEP', 'LOCAL_TRAB.COMPLEMENTO_CEP', 'LOCAL_TRAB.CIDADE', 'LOCAL_TRAB.UF',
    'FILIAIS.COD_EMPRESA', 'FILIAIS.COD_FILIAL', 'FILIAIS.COD_MUNICIPIO_RAIS',
    'TABELA_CEP.CEP', 'TABELA_CEP.COMPLEMENTO_CEP', 'TABELA_CEP.COD_MUN_IBGE'
  );
  /* procuradas em INF_PESSOAIS_CANDIDATO (P) e INF_FUNC_CANDIDATO (F) */
  opc t_lista := t_lista('CEP', 'COMPLEMENTO_CEP', 'IND_DEF_FIS', 'RAIS_IND_DEF_FISICO', 'RAIS_IND_DEF_AUDITIVA',
    'RAIS_IND_DEF_VISUAL', 'RAIS_IND_DEF_MENTAL', 'RAIS_IND_DEF_MULTIPLA', 'CARGO_PRETENDIDO', 'LOCAL_PRETENDIDO',
    'SALARIO_PRETENDIDO', 'STATUS_CANDIDATO', 'DESC_QUALIFIC_FUNC', 'FORMACAO_ESCOLAR_OBS', 'CURSO_OBS',
    'HABILIDADE_OBS', 'DT_ATUALIZACAO', 'DATA_CADASTRO');
  v_tab varchar2(60); v_col varchar2(60); v_tipo varchar2(60);
  n_falta pls_integer := 0;
  n number;

  function tipo (p_tab varchar2, p_col varchar2) return varchar2 is
    r varchar2(60);
  begin
    select data_type || case when data_type in ('VARCHAR2', 'CHAR') then '(' || char_length || ')'
                             when data_type = 'NUMBER' and data_precision is not null then '(' || data_precision || ',' || data_scale || ')' end
      into r
      from (select c.* from all_tab_columns c
             where c.table_name = p_tab and c.column_name = p_col
               and (c.owner = user or c.owner in (select s.table_owner from all_synonyms s
                                                   where s.synonym_name = p_tab and s.owner in (user, 'PUBLIC')))
             order by case when c.owner = user then 0 else 1 end)
     where rownum = 1;
    return r;
  exception when no_data_found then return null;
  end tipo;
begin
  dbms_output.put_line('=== 1. Tabelas e colunas usadas ===');
  for k in 1 .. obrig.count loop
    v_tab := regexp_substr(obrig(k), '[^.]+', 1, 1);
    v_col := regexp_substr(obrig(k), '[^.]+', 1, 2);
    v_tipo := tipo(v_tab, v_col);
    if v_tipo is null then
      n_falta := n_falta + 1;
      dbms_output.put_line('  FALTA  ' || obrig(k));
    else
      dbms_output.put_line('  OK     ' || rpad(obrig(k), 48) || v_tipo);
    end if;
  end loop;

  dbms_output.put_line(chr(10) || '=== 2. Colunas do candidato (P = INF_PESSOAIS_CANDIDATO, F = INF_FUNC_CANDIDATO) ===');
  for k in 1 .. opc.count loop
    dbms_output.put_line('  ' || rpad(opc(k), 24)
      || 'P: ' || rpad(nvl(tipo('INF_PESSOAIS_CANDIDATO', opc(k)), '-'), 18)
      || 'F: ' || rpad(nvl(tipo('INF_FUNC_CANDIDATO', opc(k)), '-'), 18)
      || case when tipo('INF_PESSOAIS_CANDIDATO', opc(k)) is null and tipo('INF_FUNC_CANDIDATO', opc(k)) is null
              then 'AVISO: em nenhuma das duas' end);
  end loop;

  dbms_output.put_line(chr(10) || to_char(unistr('=== 3. Privil\00E9gios e pacotes ===')));
  for p in (select column_value priv from table(sys.odcivarchar2list('CREATE TABLE', 'CREATE VIEW', 'CREATE PROCEDURE',
                                                                    'CREATE TYPE', 'CREATE JOB'))) loop
    select count(*) into n from session_privs where privilege = p.priv;
    if n = 0 then n_falta := n_falta + 1; end if;
    dbms_output.put_line('  ' || case when n > 0 then 'OK     ' else 'FALTA  ' end || p.priv
                         || case when p.priv = 'CREATE JOB' and n = 0 then to_char(unistr(' (s\00F3 para a rotina noturna \2014 08_rotina.sql)')) end);
  end loop;
  for p in (select column_value pkg from table(sys.odcivarchar2list('UTL_MATCH', 'APEX_JSON', 'DBMS_SCHEDULER'))) loop
    select count(*) into n from all_objects where object_name = p.pkg and object_type in ('PACKAGE', 'SYNONYM');
    if n = 0 then n_falta := n_falta + 1; end if;
    dbms_output.put_line('  ' || case when n > 0 then 'OK     ' else 'FALTA  ' end || 'pacote ' || p.pkg);
  end loop;
  select count(*) into n from all_tables where table_name like 'ONT\_%' escape '\' and owner = user;
  if n > 0 then
    dbms_output.put_line(to_char(unistr('  AVISO  j\00E1 existem ')) || n || to_char(unistr(' tabelas ONT_* neste esquema (instala\00E7\00E3o anterior?) \2014 veja 99_remover.sql')));
  end if;

  dbms_output.put_line(chr(10) || case when n_falta = 0 then 'RESULTADO: pode instalar.'
                                       else 'RESULTADO: ' || n_falta || to_char(unistr(' FALTA(S) \2014 corrigir antes de instalar.')) end);
end;
/

prompt
prompt === 4a. INSTRUCAO (a ordem sera deduzida destes nomes) ===
select cod, nome from instrucao order by cod;
prompt === 4b. NIVEL_CONHECIMENTO ===
select codigo, descricao from nivel_conhecimento order by codigo;
prompt === 4c. Modalidades em uso nas requisicoes (H e T nao contam distancia; S conta pela metade) ===
select r.tipo_modalidade, count(*) requisicoes from requisicao r group by r.tipo_modalidade order by 2 desc;
prompt === 4d. Valores de EXIGE nas tabelas de requisitos (esperado S/N) ===
select 'FORMACAO' tabela, exige, count(*) n from formacao_req_pessoal group by exige
union all select 'CURSO', exige, count(*) from curso_req_pessoal group by exige
union all select 'CONHECIMENTO', exige, count(*) from conhecimento_req_pessoal group by exige
union all select 'EXPERIENCIA', exige, count(*) from experiencia_req_pessoal group by exige;
prompt === 4e. Candidatos com CEP que a TABELA_CEP reconhece (base para a distancia) ===
select count(*) candidatos,
       count(case when exists (select 1 from tabela_cep t where t.cep = p.cep and t.complemento_cep = p.complemento_cep) then 1 end) cep_reconhecido
  from inf_pessoais_candidato p;
