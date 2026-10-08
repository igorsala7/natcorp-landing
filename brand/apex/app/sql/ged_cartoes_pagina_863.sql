/* GED — cartões de documentos (app 600, página 863, região de cartões)

   Correções em relação à versão anterior:
   1. faltava o SELECT logo depois do "from (" — era o erro de parêntese;
   2. o nome do documento é comparado SEM acento (x.d), senão "Título", "Certidão",
      "Endereço", "Bancários", "Currículo", "Formação"... caíam no ícone genérico;
   3. as colunas da QUEBRA vêm primeiro: 1ª = situação (card_subtext), 2ª = tipo
      (card_subtitle) — em Break Formatting › Break Columns use "First Two Columns";
   4. o subtítulo é sempre o TIPO do documento (vinha "Pendente" nos obrigatórios e
      vazio nos opcionais) e sai da mesma tabela em todos os blocos, para o texto ser
      idêntico — a quebra compara o texto exato;
   5. ORDER BY por nome de coluna (situação → tipo → documento), sem depender da posição;
   6. card_modifiers ganha "nc-inicio-tipo" no 1.º documento de cada tipo dentro da
      situação — é essa marca que agrupa na tela. A quebra do APEX (Break Formatting)
      pode ficar DESLIGADA: no modelo de cartões ela não estava atuando. */
SELECT x.card_subtext,
       x.card_subtitle,
       x.card_title,
       x.card_text,
       /* marca o 1.º documento de cada TIPO dentro da SITUAÇÃO: o CSS mostra o tipo só
          nele, como título do subgrupo (não depende da quebra do APEX). A ordem aqui é a
          mesma do ORDER BY lá embaixo. */
       trim(x.card_modifiers ||
            case when lag(x.card_subtitle) over (partition by upper(x.card_subtext)
                                                 order by x.card_subtitle, x.card_title) = x.card_subtitle
                 then null
                 else ' nc-inicio-tipo'
            end) as card_modifiers,
       x.card_link,
       x.card_color,
       case
         when regexp_like(x.d, '(^|\W)CPF(\W|$)')                                 then 'nc-doc-cpf'
         when regexp_like(x.d, '(^|\W)CNH(\W|$)')                                 then 'nc-doc-cnh'
         when regexp_like(x.d, 'IDENTIDADE|(^|\W)RG(\W|$)')                       then 'nc-doc-rg'
         when regexp_like(x.d, 'CTPS|CARTEIRA DE TRABALHO')                       then 'nc-doc-ctps'
         when x.d like '%TITULO DE ELEITOR%'                                      then 'nc-doc-titulo'
         when regexp_like(x.d, '(^|\W)PIS(\W|$)')                                 then 'nc-doc-pis'
         when x.d like '%RESERVISTA%'                                             then 'nc-doc-reservista'
         when x.d like '%CERTIDAO%'                                               then 'nc-doc-certidao'
         when regexp_like(x.d, 'ENDERECO|RESIDENCIA')                             then 'nc-doc-endereco'
         when regexp_like(x.d, 'BANCARI|CONTA CORRENTE')                          then 'nc-doc-banco'
         when x.d like '%VACINA%'                                                 then 'nc-doc-vacina'
         when regexp_like(x.d, '(^|\W)(ASO|SUS)(\W|$)|ATESTADO|SAUDE')            then 'nc-doc-saude'
         when regexp_like(x.d, '(^|\W)FOTO(\W|$)')                                then 'nc-doc-foto'
         when x.d like '%CURRICULO%'                                              then 'nc-doc-curriculo'
         when regexp_like(x.d, 'INSTRUCAO|FORMACAO|ESCOLAR|DIPLOMA')              then 'nc-doc-formacao'
         when regexp_like(x.d, 'CURSO|CERTIFICADO|HABILITACAO PROFISSIONAL')      then 'nc-doc-certificado'
         when x.d like '%IDIOMA%'                                                 then 'nc-doc-idioma'
         when x.d like '%CONSELHO%'                                               then 'nc-doc-conselho'
         when x.d like '%PASSAPORTE%'                                             then 'nc-doc-passaporte'
         when regexp_like(x.d, 'CONTRATO|ADITIVO|TERMO')                          then 'nc-doc-contrato'
         when regexp_like(x.d, 'LAUDO|LTCAT|(^|\W)(PGR|PPRA|PPP)(\W|$)')          then 'nc-doc-laudo'
         else 'nc-doc'
       end as card_icon,
       x.card_initials,
       x.ordem,
       x.cod_tipo_sub_item
  from (
    select y.*,
           upper(translate(y.card_title,
                 'ÁÀÂÃÉÊÍÓÔÕÚÇáàâãéêíóôõúç',
                 'AAAAEEIOOOUCaaaaeeiooouc')) d
      from (
SELECT
INITCAP(t.descricao)  card_title,
INITCAP(s.descricao) card_subtitle,
U.DESCRICAO||' '||U.DATA_ARQUIVO card_text,
'Anexado' card_subtext,
-- ui and other attributes
'classe_ok' card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||U.TIPO_ARQUIVO||','||U.SEQ_ITEM||','||U.TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-success' card_color,
'fa-cloud-file'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
2 ordem,
cod_tipo_sub_item
  FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
 WHERE u.tipo_arquivo = t.cod
AND u.tipo_sub_item = s.cod
AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
AND u.cod_empresa= :p_cod_emp_up
AND u.cod_item= :p_cod_item_up
AND u.tipo_cod_item = :p_tipo_cod_item_up
and s.cod in (0,1,5)
and f_permissao_docs (u.tipo_cod_item, u.tipo_sub_item, t.cod) = 'S'
AND NVL(U.SEQ_ITEM,0) = (select nvl(max(seq_item),0)
                   from upload_files ux
                  where ux.tipo_cod_item = U.tipo_cod_item
                    and ux.cod_empresa = U.COD_EMPRESA
                    and ux.cod_item = U.COD_ITEM
                    and ux.tipo_arquivo = U.TIPO_ARQUIVO
                    and nvl(ux.tipo_sub_item,0) = nvl(UX.tipo_sub_item,0)
                    and nvl(ux.cod_sub_item,0) = nvl(UX.cod_sub_item,0)
                    and ux.cod_req is null)
UNION
SELECT
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
 case when ((:p_tipo_cod_item_up = 'CANDIDATO' and t.obrig_candidato = 'S') or
(:p_tipo_cod_item_up = 'CANDIDATO' and :p_ps is not null and t.obrig_ps = 'S') or
(:p_tipo_cod_item_up = 'COLABORADOR' and t.obrig_colaborador = 'S') or
(:p_tipo_cod_item_up IN ('CANDIDATO_PJ','COLABORADOR_PJ') and t.obrig_pj = 'S'))
 then
 'Obrigatório'
 else
 'Opcional'
 end card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
 case when ((:p_tipo_cod_item_up = 'CANDIDATO' and t.obrig_candidato = 'S') or
(:p_tipo_cod_item_up = 'CANDIDATO' and :p_ps is not null and t.obrig_ps = 'S') or
(:p_tipo_cod_item_up = 'COLABORADOR' and t.obrig_colaborador = 'S') or
(:p_tipo_cod_item_up IN ('CANDIDATO_PJ','COLABORADOR_PJ') and t.obrig_pj = 'S'))
 then
 'u-danger'
 else
 'u-normal'
 end  card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
 case when ((:p_tipo_cod_item_up = 'CANDIDATO' and t.obrig_candidato = 'S') or
(:p_tipo_cod_item_up = 'CANDIDATO' and :p_ps is not null and t.obrig_ps = 'S') or
(:p_tipo_cod_item_up = 'COLABORADOR' and t.obrig_colaborador = 'S') or
(:p_tipo_cod_item_up IN ('CANDIDATO_PJ','COLABORADOR_PJ') and t.obrig_pj = 'S'))
 then
 1
 else
 3
 end ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t
 WHERE t.cod_tipo_sub_item in (0,1,5)
   and f_permissao_docs (:p_tipo_cod_item_up, t.cod_tipo_sub_item, t.cod) = 'S'
 and ((t.candidato= 'S' /*AND t.obrig_candidato = 'S'*/ and :p_tipo_cod_item_up = 'CANDIDATO') or
(t.ps = 'S' /*AND t.obrig_ps = 'S'*/ and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' /*AND t.obrig_colaborador = 'S'*/ and :p_tipo_cod_item_up = 'COLABORADOR') or
  (t.pj = 'S' /*AND t.obrig_pj = 'S'*/ and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
  )
  --AND t.obrig_candidato = 'S' -- APAGAR SE NAO DER CERTO IGOR 23/02/19
  and (t.cod,t.cod_tipo_sub_item) not in (select 7,0 from dual union
select 10,0 from dual union
select 11,0 from dual union
select 13,0 from dual union
select 20,0 from dual union
select 32,0 from dual union
select 6,1 from dual union
select 32,1 from dual)
and not exists (select 1
  from upload_files u
 where t.cod_tipo_sub_item = 0
and t.cod = 33
and u.cod_empresa= :p_cod_emp_up
AND u.cod_item= :p_cod_item_up
AND u.tipo_cod_item = :p_tipo_cod_item_up
and u.cod_sub_item = 0
and u.tipo_arquivo = 1
 union
 select 1
  from upload_files u
 where t.cod_tipo_sub_item = 0
and t.cod in (34,35)
and u.cod_empresa= :p_cod_emp_up
AND u.cod_item= :p_cod_item_up
AND u.tipo_cod_item = :p_tipo_cod_item_up
and u.cod_sub_item = 0
and u.tipo_arquivo = 5)
AND (t.cod,t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, instrucao i, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 10
  and t.cod_tipo_sub_item = 0
  AND i.cod = p.instrucao
  AND i.ind_certificado = 'S'
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 11
  and t.cod_tipo_sub_item = 0
  AND p.sexo = 'M'
  AND p.NACIONALIDADE = 10
  AND p.ind_eximido = 'N'
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 13
  and t.cod_tipo_sub_item = 0
  AND ((p.NACIONALIDADE <> 10) or (p.ind_eximido = 'N'))
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 20
  and t.cod_tipo_sub_item = 0
  AND p.nacionalidade <> 10
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 7
  and t.cod_tipo_sub_item = 0
  AND nvl(p.primeiro_emprego,'N') = 'N'
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod_TIPO_SUB_ITEM = 1
 -- AND p.POSSUI_DEPENDENTE = 'S'
 AND ((P.ESTADO_CIVIL =  'C') OR
(P.ESTADO_CIVIL <> 'C' AND UPPER(T.DESCRICAO) NOT LIKE '%CASAMENTO%'))
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
  AND t.cod <> 32
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO' ) or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 32
  AND t.cod_tipo_sub_item = 0
  AND p.ind_def_fis = 'S'
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
       (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO'))
  AND t.cod = 32
  AND t.cod_tipo_sub_item = 1
  AND d.CONDICAO_DEPEND = 'I'
  AND p.cod_candidato = d.cod_candidato
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d
WHERE t.colaborador = 'S'
  and :p_tipo_cod_item_up = 'COLABORADOR'
  AND t.cod = 32
  AND t.cod_tipo_sub_item = 1
  AND d.CONDICAO_DEPEND = 'I'
  AND p.cod_empresa = d.cod_empresa
  AND p.matricula = d.matricula
  AND p.cod_empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
  UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 6
  AND t.cod_tipo_sub_item = 1
  AND d.grau_parentesco in ('EA','EO')
  AND p.empresa = d.cod_empresa
  AND p.cod_candidato = d.cod_candidato
  AND p.empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO
  UNION
  SELECT t.cod, t.cod_tipo_sub_item
 FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d
WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
 (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
 (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
  AND t.cod = 6
  AND t.cod_tipo_sub_item = 1
  AND d.grau_parentesco in ('EA','EO')
  AND p.cod_empresa = d.cod_empresa
  AND p.matricula = d.matricula
  AND p.cod_empresa = :p_cod_emp_up
  AND p.cod_candidato = :P_CANDIDATO )
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, instrucao i, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
  (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
AND t.cod = 10
and t.cod_tipo_sub_item = 0
AND i.cod = p.instrucao
AND i.ind_certificado = 'S'
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
  (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
AND t.cod = 11
and t.cod_tipo_sub_item = 0
AND p.sexo = 'M'
AND p.NACIONALIDADE = 10
AND (p.ind_eximido = 'N')
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
  UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
  (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
AND t.cod = 13
and t.cod_tipo_sub_item = 0
AND p.NACIONALIDADE = 10
AND (p.ind_eximido = 'N')
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
  (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
AND t.cod = 20
and t.cod_tipo_sub_item = 0
AND p.NACIONALIDADE <> 10
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
 UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR') or
  (t.pj = 'S' and :p_tipo_cod_item_up in ('CANDIDATO_PJ','COLABORADOR_PJ'))
 )
AND t.cod = 7
and t.cod_tipo_sub_item = 0
AND nvl(p.primeiro_emprego,'N') = 'N'
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
 UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
CASE WHEN  T.COD <> 17
  THEN 'Obrigatório'
  WHEN ((T.COD = 17 AND :P_TIPO_COD_ITEM_UP = 'CANDIDATO' AND T.OBRIG_CANDIDATO = 'S') OR
        (T.COD = 17 AND:P_TIPO_COD_ITEM_UP = 'COLABORADOR' AND :P_TIPO_COD_ITEM_UP = 'COLABORADOR' AND T.OBRIG_COLABORADOR = 'S'))
  THEN 'Obrigatório'
  ELSE
 'Opcional'  END card_subtext, --'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
CASE WHEN  T.COD <> 17
  THEN 'u-danger'
  WHEN ((T.COD = 17 AND :P_TIPO_COD_ITEM_UP = 'CANDIDATO' AND T.OBRIG_CANDIDATO = 'S') OR
        (T.COD = 17 AND :P_TIPO_COD_ITEM_UP = 'COLABORADOR' AND :P_TIPO_COD_ITEM_UP = 'COLABORADOR' AND T.OBRIG_COLABORADOR = 'S'))
  THEN 'u-danger'
  ELSE
 'u-normal'  END card_color, --'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
        (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR'))
AND t.cod_TIPO_SUB_ITEM = 1
AND p.POSSUI_DEPENDENTE = 'S'
AND ((P.ESTADO_CIVIL =  'C') OR
  (P.ESTADO_CIVIL <> 'C' AND UPPER(T.DESCRICAO) NOT LIKE '%CASAMENTO%'))
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND t.cod <> 32
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
case when ((:p_tipo_cod_item_up = 'CANDIDATO' and t.obrig_candidato = 'S') or
  (:p_tipo_cod_item_up = 'CANDIDATO' and :p_ps is not null and t.ps = 'S') or
  (:p_tipo_cod_item_up = 'COLABORADOR' and t.obrig_colaborador = 'S')
 ) then 'Obrigatório'
 else
 'Opcional'
 end card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
case when ((:p_tipo_cod_item_up = 'CANDIDATO' and t.obrig_candidato = 'S') or
  (:p_tipo_cod_item_up = 'COLABORADOR' and t.obrig_colaborador = 'S')
 ) then 'u-danger'
 else
 'u-normal' end
 card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t
 WHERE ((t.colaborador = 'S' AND :p_tipo_cod_item_up = 'COLABORADOR') or (t.pj = 'S' AND :p_tipo_cod_item_up = 'COLABORADOR_PJ'))
  and fnct_verif_upload_colab (:p_cod_emp_up, :p_cod_item_up, cod_tipo_sub_item, cod) = 'S'
 UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO') or
  (t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR'))
and t.cod = 32
AND t.cod_TIPO_SUB_ITEM = 0
AND p.ind_def_fis = 'S'
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
        (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO'))
and t.cod = 32
AND t.cod_TIPO_SUB_ITEM = 1
AND d.CONDICAO_DEPEND = 'I'
and p.cod_candidato = d.cod_candidato
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d
 WHERE t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR'
and t.cod = 32
AND t.cod_TIPO_SUB_ITEM = 1
AND d.CONDICAO_DEPEND = 'I'
and p.cod_empresa = d.cod_empresa
and p.matricula = d.matricula
AND p.cod_empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais_candidato p, dependentes_cand d
 WHERE ((t.candidato = 'S' and :p_tipo_cod_item_up = 'CANDIDATO') or
        (t.ps = 'S' and :p_ps is not null and :p_tipo_cod_item_up = 'CANDIDATO'))
and t.cod = 6
AND t.cod_TIPO_SUB_ITEM = 1
and d.grau_parentesco in ('EA','EO')
and p.cod_candidato = d.cod_candidato
AND p.empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
UNION
select
INITCAP(t.descricao)  card_title,
(select initcap(s2.descricao) from tipo_sub_item_upload s2 where s2.cod = t.cod_tipo_sub_item) card_subtitle,
null card_text,
'Obrigatório' card_subtext,
-- ui and other attributes
null card_modifiers,
apex_page.get_url (
 p_page  => 864,
 p_items => 'P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_ARQUIVO,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM',
 p_values=> :P_COD_EMP_UP||','||:P_COD_ITEM_UP||','||T.COD||','||NULL||','||COD_TIPO_SUB_ITEM||','||863||','||:P_TIPO_COD_ITEM_UP,
 p_clear_cache => 864
 ) card_link,
'u-danger' card_color,
'fa-file-x'  card_icon,
apex_string.get_initials(t.descricao)  card_initials,
1 ordem,
cod_tipo_sub_item
  FROM tipo_arquivo_upload t, inf_pessoais p, dependentes d
 WHERE t.colaborador = 'S' and :p_tipo_cod_item_up = 'COLABORADOR'
and t.cod = 6
AND t.cod_TIPO_SUB_ITEM = 1
and d.grau_parentesco in ('EA','EO')
and p.cod_empresa = d.cod_empresa
and p.matricula = d.matricula
AND p.cod_empresa = :p_cod_emp_up
AND p.cod_candidato = :P_CANDIDATO
AND (t.cod, t.cod_tipo_sub_item) NOT IN (SELECT t.cod, t.cod_tipo_sub_item
 FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s
WHERE u.tipo_arquivo = t.cod
  AND u.tipo_sub_item = s.cod
  AND u.tipo_sub_item = t.cod_tipo_sub_item (+)
  AND u.cod_empresa= :p_cod_emp_up
  AND u.cod_item= :p_cod_item_up
  AND u.tipo_cod_item = :p_tipo_cod_item_up)
      ) y
  ) x
 ORDER BY case upper(x.card_subtext) when 'OBRIGATÓRIO' then 1 when 'ANEXADO' then 2 else 3 end,
          x.card_subtitle,
          x.card_title
