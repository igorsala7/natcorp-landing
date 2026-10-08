/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 07  CARGA INICIAL                                            |
   +========================================================================================+
   GERADO por gerar_carga.py - nao edite aqui; edite o .py e gere de novo.
   179 conceitos, 570 termos, 43 relacoes + o catalogo HABILIDADE da base.
   Rodar de novo e seguro: ajustes e pesos sao mesclados (nao sobrescreve valor ja mudado),
   conceitos/termos existentes sao mantidos.
*/
set define off
set serveroutput on size unlimited

/* -- ajustes (so insere o que nao existe: valor ja ajustado fica) -- */
merge into ont_config c using (select 'RAIO_IDEAL_KM' chave, '10' valor, to_char(unistr('At\00E9 esta dist\00E2ncia (km, j\00E1 com o fator de rota) a nota de dist\00E2ncia \00E9 cheia')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'RAIO_MAXIMO_KM' chave, '60' valor, to_char(unistr('A partir desta dist\00E2ncia (km) a nota de dist\00E2ncia \00E9 zero; entre os dois, cai em linha reta')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'FATOR_ROTA' chave, '1.25' valor, to_char(unistr('Linha reta \00D7 fator = estimativa do caminho por ruas')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'MODALIDADES_SEM_DISTANCIA' chave, 'H,T' valor, to_char(unistr('C\00F3digos de TIPO_MODALIDADE em que a dist\00E2ncia N\00C3O conta (H home office, T teletrabalho)')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'MODALIDADES_PARCIAIS' chave, 'S' valor, to_char(unistr('Modalidades em que a dist\00E2ncia conta com peso reduzido (S semipresencial)')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'FATOR_PARCIAL' chave, '0.5' valor, to_char(unistr('Multiplica o peso da dist\00E2ncia nas modalidades parciais')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'DISTANCIA_SEM_DADO' chave, 'NEUTRO' valor, to_char(unistr('Candidato sem endere\00E7o reconhecido: NEUTRO (n\00E3o conta) ou ZERO (nota zero)')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'PCD_MODO' chave, 'ELIMINATORIO' valor, to_char(unistr('Vaga PCD: ELIMINATORIO (quem n\00E3o \00E9 PCD vai para o fim, marcado) ou PESO (s\00F3 perde pontos)')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'PCD_TIPO_DIFERENTE' chave, '0.5' valor, to_char(unistr('Nota do candidato PCD cujo tipo de defici\00EAncia n\00E3o \00E9 um dos marcados na vaga')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'FATOR_AMPLO' chave, '0.5' valor, 'Candidato tem o conceito MAIS AMPLO que o pedido (Engenharia para Engenharia Civil)' descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'FATOR_NAO_CONCLUIDO' chave, '0.5' valor, to_char(unistr('Forma\00E7\00E3o ou curso n\00E3o conclu\00EDdo vale esta fra\00E7\00E3o')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'FATOR_NIVEL_ABAIXO' chave, '0.6' valor, to_char(unistr('Habilidade com n\00EDvel abaixo do pedido vale esta fra\00E7\00E3o')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'INSTRUCAO_UM_ABAIXO' chave, '0.5' valor, to_char(unistr('Instru\00E7\00E3o um degrau abaixo da pedida vale esta fra\00E7\00E3o')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'IDIOMA_NIVEL_ABAIXO' chave, '0.5' valor, to_char(unistr('Idioma com n\00EDvel abaixo do pedido vale esta fra\00E7\00E3o')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'SALARIO_TOLERANCIA' chave, '0.2' valor, to_char(unistr('Pretens\00E3o at\00E9 este percentual acima do teto da vaga ainda pontua (cai at\00E9 zero)')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'STATUS_EXCLUIDOS' chave, 'R' valor, to_char(unistr('STATUS_CANDIDATO que n\00E3o entram no c\00E1lculo (R reprovado), separados por v\00EDrgula')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'EXP_NEC_USAR' chave, 'N' valor, to_char(unistr('S: as linhas do campo "Experi\00EAncia necess\00E1ria" reconhecidas como conceito viram requisitos desej\00E1veis')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);
merge into ont_config c using (select 'PENDENTE_MIN_CARACTERES' chave, '4' valor, to_char(unistr('Textos menores que isso n\00E3o v\00E3o para a fila de curadoria')) descricao from dual) x on (c.chave = x.chave)
 when matched then update set c.descricao = x.descricao
 when not matched then insert (chave, valor, descricao) values (x.chave, x.valor, x.descricao);

/* -- pesos (idem) -- */
merge into ont_peso p using (select 'INSTRUCAO' criterio, 3 pe, 3 pd, to_char(unistr('Grau de instru\00E7\00E3o da requisi\00E7\00E3o (sempre exigido)')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'FORMACAO' criterio, 3 pe, 1 pd, to_char(unistr('Forma\00E7\00F5es da requisi\00E7\00E3o')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'CURSO' criterio, 2 pe, 1 pd, to_char(unistr('Cursos da requisi\00E7\00E3o')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'CONHECIMENTO' criterio, 3 pe, 1 pd, to_char(unistr('Conhecimentos da requisi\00E7\00E3o (com n\00EDvel)')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'EXPERIENCIA' criterio, 3 pe, 1 pd, to_char(unistr('Experi\00EAncias da requisi\00E7\00E3o')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'TEMPO' criterio, 2 pe, 2 pd, to_char(unistr('Tempo de servi\00E7o pedido (anos e meses)')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'IDIOMA' criterio, 3 pe, 1 pd, to_char(unistr('Idiomas da requisi\00E7\00E3o (com n\00EDvel)')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'DISTANCIA' criterio, 2 pe, 2 pd, to_char(unistr('Dist\00E2ncia casa-trabalho (n\00E3o conta em home office)')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'PCD' criterio, 5 pe, 5 pd, 'Vaga PCD' descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'CARGO_PRETENDIDO' criterio, 1 pe, 1 pd, 'O candidato indicou este cargo' descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'LOCAL_PRETENDIDO' criterio, 1 pe, 1 pd, 'O candidato indicou este local de trabalho' descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);
merge into ont_peso p using (select 'SALARIO' criterio, 1 pe, 1 pd, to_char(unistr('Pretens\00E3o salarial dentro da faixa')) descricao from dual) x on (p.criterio = x.criterio)
 when matched then update set p.descricao = x.descricao
 when not matched then insert (criterio, peso_exigido, peso_desejavel, descricao) values (x.criterio, x.pe, x.pd, x.descricao);

/* -- onde cada criterio procura -- */
insert into ont_criterio_origem (criterio, origem) select 'FORMACAO', 'FORMACAO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'FORMACAO' and origem = 'FORMACAO');
insert into ont_criterio_origem (criterio, origem) select 'FORMACAO', 'OBS_FORMACAO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'FORMACAO' and origem = 'OBS_FORMACAO');
insert into ont_criterio_origem (criterio, origem) select 'CURSO', 'CURSO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CURSO' and origem = 'CURSO');
insert into ont_criterio_origem (criterio, origem) select 'CURSO', 'OBS_CURSO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CURSO' and origem = 'OBS_CURSO');
insert into ont_criterio_origem (criterio, origem) select 'CURSO', 'FORMACAO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CURSO' and origem = 'FORMACAO');
insert into ont_criterio_origem (criterio, origem) select 'CURSO', 'OBS_FORMACAO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CURSO' and origem = 'OBS_FORMACAO');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'HABILIDADE' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'HABILIDADE');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'OBS_HABILIDADE' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'OBS_HABILIDADE');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'CURSO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'CURSO');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'OBS_CURSO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'OBS_CURSO');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'FORMACAO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'FORMACAO');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'OBS_FORMACAO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'OBS_FORMACAO');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'EMPREGO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'EMPREGO');
insert into ont_criterio_origem (criterio, origem) select 'CONHECIMENTO', 'QUALIF' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'CONHECIMENTO' and origem = 'QUALIF');
insert into ont_criterio_origem (criterio, origem) select 'EXPERIENCIA', 'EMPREGO' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'EXPERIENCIA' and origem = 'EMPREGO');
insert into ont_criterio_origem (criterio, origem) select 'EXPERIENCIA', 'QUALIF' from dual where not exists (select 1 from ont_criterio_origem where criterio = 'EXPERIENCIA' and origem = 'QUALIF');

/* -- palavras fracas e abreviacoes -- */
insert into ont_palavra_fraca (palavra) select 'de' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'de');
insert into ont_palavra_fraca (palavra) select 'da' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'da');
insert into ont_palavra_fraca (palavra) select 'do' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'do');
insert into ont_palavra_fraca (palavra) select 'das' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'das');
insert into ont_palavra_fraca (palavra) select 'dos' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'dos');
insert into ont_palavra_fraca (palavra) select 'e' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'e');
insert into ont_palavra_fraca (palavra) select 'em' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'em');
insert into ont_palavra_fraca (palavra) select 'para' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'para');
insert into ont_palavra_fraca (palavra) select 'com' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'com');
insert into ont_palavra_fraca (palavra) select 'a' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'a');
insert into ont_palavra_fraca (palavra) select 'o' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'o');
insert into ont_palavra_fraca (palavra) select 'as' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'as');
insert into ont_palavra_fraca (palavra) select 'os' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'os');
insert into ont_palavra_fraca (palavra) select 'na' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'na');
insert into ont_palavra_fraca (palavra) select 'no' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'no');
insert into ont_palavra_fraca (palavra) select 'nas' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'nas');
insert into ont_palavra_fraca (palavra) select 'nos' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'nos');
insert into ont_palavra_fraca (palavra) select 'ao' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'ao');
insert into ont_palavra_fraca (palavra) select 'aos' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'aos');
insert into ont_palavra_fraca (palavra) select 'um' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'um');
insert into ont_palavra_fraca (palavra) select 'uma' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'uma');
insert into ont_palavra_fraca (palavra) select 'por' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'por');
insert into ont_palavra_fraca (palavra) select 'pela' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'pela');
insert into ont_palavra_fraca (palavra) select 'pelo' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'pelo');
insert into ont_palavra_fraca (palavra) select 'pelas' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'pelas');
insert into ont_palavra_fraca (palavra) select 'pelos' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'pelos');
insert into ont_palavra_fraca (palavra) select 'que' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'que');
insert into ont_palavra_fraca (palavra) select 'ou' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'ou');
insert into ont_palavra_fraca (palavra) select 'sobre' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'sobre');
insert into ont_palavra_fraca (palavra) select 'ate' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'ate');
insert into ont_palavra_fraca (palavra) select 'entre' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'entre');
insert into ont_palavra_fraca (palavra) select 'sem' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'sem');
insert into ont_palavra_fraca (palavra) select 'area' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'area');
insert into ont_palavra_fraca (palavra) select 'curso' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'curso');
insert into ont_palavra_fraca (palavra) select 'conhecimento' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'conhecimento');
insert into ont_palavra_fraca (palavra) select 'experiencia' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'experiencia');
insert into ont_palavra_fraca (palavra) select 'nivel' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'nivel');
insert into ont_palavra_fraca (palavra) select 'basico' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'basico');
insert into ont_palavra_fraca (palavra) select 'intermediario' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'intermediario');
insert into ont_palavra_fraca (palavra) select 'avancado' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'avancado');
insert into ont_palavra_fraca (palavra) select 'completo' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'completo');
insert into ont_palavra_fraca (palavra) select 'completa' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'completa');
insert into ont_palavra_fraca (palavra) select 'incompleto' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'incompleto');
insert into ont_palavra_fraca (palavra) select 'incompleta' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'incompleta');
insert into ont_palavra_fraca (palavra) select 'concluido' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'concluido');
insert into ont_palavra_fraca (palavra) select 'concluida' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'concluida');
insert into ont_palavra_fraca (palavra) select 'cursando' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'cursando');
insert into ont_palavra_fraca (palavra) select 'ensino' from dual where not exists (select 1 from ont_palavra_fraca where palavra = 'ensino');
merge into ont_abreviacao x using (select 'an' token, 'analista' expansao from dual) y on (x.token = y.token)
 when not matched then insert (token, expansao) values (y.token, y.expansao);
merge into ont_abreviacao x using (select 'op' token, 'operador' expansao from dual) y on (x.token = y.token)
 when not matched then insert (token, expansao) values (y.token, y.expansao);
merge into ont_abreviacao x using (select 'ass' token, 'assistente' expansao from dual) y on (x.token = y.token)
 when not matched then insert (token, expansao) values (y.token, y.expansao);
merge into ont_abreviacao x using (select 'jr' token, 'junior' expansao from dual) y on (x.token = y.token)
 when not matched then insert (token, expansao) values (y.token, y.expansao);
merge into ont_abreviacao x using (select 'sr' token, 'senior' expansao from dual) y on (x.token = y.token)
 when not matched then insert (token, expansao) values (y.token, y.expansao);
merge into ont_abreviacao x using (select 'pl' token, 'pleno' expansao from dual) y on (x.token = y.token)
 when not matched then insert (token, expansao) values (y.token, y.expansao);
commit;

/* -- escalas: instrucao e nivel de conhecimento, lidas das tabelas da base --
   A ordem sai do NOME (padrao eSocial). Confira o resultado impresso abaixo e corrija a mao o que
   vier vazio ou errado (update ont_instrucao_ordem set ordem = ..., conferido = 'S' where cod = ...). */
merge into ont_instrucao_ordem o
using (select to_char(cod) cod, nome,
              case
                when n like '%doutor%' then 12
                when n like '%mestr%' then 11
                when n like '%pos gradua%' or n like '%posgradua%' or n like '%especializ%' or n like '% mba%' or n like 'mba%' then 10
                when n like '%analfabet%' then 1
                when regexp_like(n, 'ate (o |a )?(4|5)[oa]?( |$)') then 2
                when regexp_like(n, '(4|5)[oa]? (ano|serie)') and n not like '%incomplet%' then 3
                when regexp_like(n, '(5|6)[oa]? (ao|a) (8|9)[oa]?( |$)') then 4
                when (n like '%superior%' or n like '%gradua%' or n like '%bacharel%' or n like '%licenciat%' or n like '%tecnologo%')
                     and n like '%incomplet%' then 8
                when n like '%superior%' or n like '%gradua%' or n like '%bacharel%' or n like '%licenciat%' or n like '%tecnologo%' then 9
                when (n like '%medio%' or n like '%2 grau%' or n like '%segundo grau%' or n like '%colegial%' or n like '%tecnico%')
                     and n like '%incomplet%' then 6
                when n like '%tecnico%' then 7.5
                when n like '%medio%' or n like '%2 grau%' or n like '%segundo grau%' or n like '%colegial%' then 7
                when (n like '%fundamental%' or n like '%1 grau%' or n like '%primeiro grau%' or n like '%ginasi%') and n like '%incomplet%' then 4
                when n like '%fundamental%' or n like '%1 grau%' or n like '%primeiro grau%' or n like '%ginasi%' then 5
              end ordem
         from (select cod, nome, trim(regexp_replace(ont_texto.sem_acento(nome), '[^a-z0-9]+', ' ')) n from instrucao)) x
   on (o.cod = x.cod)
 when matched then update set o.nome = x.nome, o.ordem = case when o.conferido = 'S' then o.ordem else x.ordem end
 when not matched then insert (cod, nome, ordem) values (x.cod, x.nome, x.ordem);

merge into ont_nivel_ordem o
using (select to_char(codigo) codigo, descricao,
              case when n like '%nativ%' then 5 when n like '%fluen%' then 4 when n like '%avanc%' then 3
                   when n like '%intermed%' then 2 when n like '%basic%' then 1 end ordem
         from (select codigo, descricao, ont_texto.sem_acento(descricao) n from nivel_conhecimento)) x
   on (o.codigo = x.codigo)
 when matched then update set o.descricao = x.descricao, o.ordem = case when o.conferido = 'S' then o.ordem else x.ordem end
 when not matched then insert (codigo, descricao, ordem) values (x.codigo, x.descricao, x.ordem);
commit;

/* -- conceitos (os mais amplos primeiro) -- */
declare v number; begin
  v := ont_ontologia.novo_conceito('AREA', 'Engenharia', null, null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), to_char(unistr('TI; T.I.; Inform\00E1tica')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Sa\00FAde')), to_char(unistr('\00C1rea da sa\00FAde')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Educa\00E7\00E3o')), to_char(unistr('Doc\00EAncia; Ensino e educa\00E7\00E3o')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', 'Rotinas Administrativas', to_char(unistr('Administrativo; Servi\00E7os administrativos; Apoio administrativo')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', 'Departamento Pessoal', to_char(unistr('DP; Depto Pessoal; Dep Pessoal; Rotinas de departamento pessoal; Rotinas de DP; Administra\00E7\00E3o de pessoal')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', 'Atendimento ao Cliente', to_char(unistr('Atendimento ao p\00FAblico; SAC; Customer service; Relacionamento com o cliente; Atendimento')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', 'Vendas', to_char(unistr('Comercial; T\00E9cnicas de vendas; \00C1rea comercial')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', 'Compras', 'Suprimentos; Procurement', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Produ\00E7\00E3o Industrial')), to_char(unistr('Produ\00E7\00E3o; Linha de produ\00E7\00E3o; Ch\00E3o de f\00E1brica; Ind\00FAstria')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Manuten\00E7\00E3o')), to_char(unistr('Manuten\00E7\00E3o industrial; Manuten\00E7\00E3o predial')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Limpeza e Conserva\00E7\00E3o')), to_char(unistr('Servi\00E7os gerais; Conserva\00E7\00E3o; Limpeza')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Seguran\00E7a Patrimonial')), to_char(unistr('Vigil\00E2ncia; Portaria')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Cozinha e Alimenta\00E7\00E3o')), to_char(unistr('Alimenta\00E7\00E3o; Cozinha; Food service')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Gest\00E3o de Equipes')), to_char(unistr('Lideran\00E7a; Lideran\00E7a de equipe; Gest\00E3o de pessoas e equipes')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('AREA', to_char(unistr('Seguran\00E7a do Trabalho')), to_char(unistr('SST; Sa\00FAde e seguran\00E7a do trabalho')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Administra\00E7\00E3o')), to_char(unistr('Administra\00E7\00E3o de Empresas; Administra\00E7\00E3o Empresarial; Gest\00E3o Empresarial; Administrador; Administrador de Empresas')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o de Recursos Humanos')), to_char(unistr('Recursos Humanos; RH; Gest\00E3o de Pessoas; Gest\00E3o de RH; Administra\00E7\00E3o de Recursos Humanos; Gest\00E3o Estrat\00E9gica de Pessoas; Desenvolvimento Humano')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Ci\00EAncias Cont\00E1beis')), to_char(unistr('Contabilidade; Cont\00E1beis; Contador')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Economia', to_char(unistr('Ci\00EAncias Econ\00F4micas; Economista')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Direito', to_char(unistr('Ci\00EAncias Jur\00EDdicas; Advogado; Bacharel em Direito')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Psicologia', to_char(unistr('Psic\00F3logo; Psic\00F3loga')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o Financeira')), to_char(unistr('Finan\00E7as; Financeiro; Gest\00E3o de Finan\00E7as')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o Comercial')), to_char(unistr('Gest\00E3o de Vendas')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Processos Gerenciais', to_char(unistr('Gest\00E3o de Processos Gerenciais')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Log\00EDstica')), to_char(unistr('Gest\00E3o Log\00EDstica; Supply Chain; Cadeia de Suprimentos')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Marketing', to_char(unistr('Gest\00E3o de Marketing; Marketing Digital')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Publicidade e Propaganda', 'Publicidade; Propaganda', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Comunica\00E7\00E3o Social')), to_char(unistr('Jornalismo; Rela\00E7\00F5es P\00FAblicas')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Com\00E9rcio Exterior')), to_char(unistr('Comex; Rela\00E7\00F5es Internacionais')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Secretariado Executivo', to_char(unistr('Secretariado; Secret\00E1ria Executiva')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o da Qualidade')), 'Qualidade; Controle de Qualidade; Garantia da Qualidade', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o P\00FAblica')), to_char(unistr('Administra\00E7\00E3o P\00FAblica')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o Hospitalar')), to_char(unistr('Administra\00E7\00E3o Hospitalar')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Servi\00E7o Social')), 'Assistente Social', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Estat\00EDstica')), to_char(unistr('Estat\00EDstico')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Qu\00EDmica')), to_char(unistr('Qu\00EDmico; Qu\00EDmica Industrial')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Ci\00EAncias Biol\00F3gicas')), to_char(unistr('Biologia; Bi\00F3logo')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Arquitetura e Urbanismo', 'Arquitetura; Arquiteto', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Design', to_char(unistr('Design Gr\00E1fico; Desenho Industrial; Designer; Designer Gr\00E1fico')), null, null, 'CARGA_INICIAL');
  commit;
end;
/
declare v number; begin
  v := ont_ontologia.novo_conceito('FORMACAO', 'Turismo e Hotelaria', 'Turismo; Hotelaria', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Administra\00E7\00E3o')), to_char(unistr('T\00E9cnica em Administra\00E7\00E3o')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Contabilidade')), to_char(unistr('T\00E9cnico Cont\00E1bil')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Log\00EDstica')), to_char(unistr('T\00E9cnica em Log\00EDstica')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Recursos Humanos')), to_char(unistr('T\00E9cnico em RH')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Eletrot\00E9cnica')), to_char(unistr('T\00E9cnico em Eletrot\00E9cnica; T\00E9cnico Eletrot\00E9cnico')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Eletr\00F4nica')), to_char(unistr('T\00E9cnico em Eletr\00F4nica')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Mec\00E2nica')), to_char(unistr('T\00E9cnico em Mec\00E2nica; Mec\00E2nica Industrial')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Mecatr\00F4nica')), to_char(unistr('T\00E9cnico em Mecatr\00F4nica; Engenharia Mecatr\00F4nica')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Edifica\00E7\00F5es')), to_char(unistr('T\00E9cnico em Edifica\00E7\00F5es')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Analista de Neg\00F3cios')), to_char(unistr('Business Analyst; Analista de Neg\00F3cio; Business Partner')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Motorista', 'Condutor', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Pedreiro', 'Ajudante de Pedreiro; Servente de Obras', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Jovem Aprendiz', 'Aprendiz; Menor Aprendiz', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Estagi\00E1rio')), to_char(unistr('Estagi\00E1ria; Est\00E1gio')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Trainee', 'Programa de Trainee', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Pacote Office', 'MS Office; Microsoft Office; Office 365', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Excel', 'Microsoft Excel; MS Excel; Planilhas Excel', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Word', 'Microsoft Word; MS Word', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'PowerPoint', 'Power Point; Microsoft PowerPoint', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'SAP', 'ERP SAP', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'TOTVS', 'Protheus; Datasul; TOTVS RM', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Salesforce', 'CRM Salesforce', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'AutoCAD', 'Auto CAD; CAD', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Photoshop', 'Adobe Photoshop', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Illustrator', 'Adobe Illustrator', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Figma', null, null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Legisla\00E7\00E3o Trabalhista')), 'CLT; Direito do Trabalho', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Negocia\00E7\00E3o')), to_char(unistr('T\00E9cnicas de Negocia\00E7\00E3o')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Gest\00E3o de Projetos')), 'PMP; PMBOK; Gerenciamento de Projetos', null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Metodologias \00C1geis')), to_char(unistr('Scrum; Kanban; Agile; \00C1gil')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'LGPD', to_char(unistr('Lei Geral de Prote\00E7\00E3o de Dados; Prote\00E7\00E3o de Dados')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Primeiros Socorros', null, null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Brigada de Inc\00EAndio')), to_char(unistr('Brigadista; Combate a Inc\00EAndio')), null, null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Pedagogia', 'Pedagogo; Pedagoga', to_char(unistr('Educa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Letras', 'Licenciatura em Letras', to_char(unistr('Educa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Matem\00E1tica')), to_char(unistr('Licenciatura em Matem\00E1tica')), to_char(unistr('Educa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Educa\00E7\00E3o F\00EDsica')), to_char(unistr('Profissional de Educa\00E7\00E3o F\00EDsica')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Gastronomia', 'Chef de cozinha', to_char(unistr('Cozinha e Alimenta\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Enfermagem', 'Enfermeiro; Enfermeira', to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  commit;
end;
/
declare v number; begin
  v := ont_ontologia.novo_conceito('FORMACAO', 'Medicina', to_char(unistr('M\00E9dico; M\00E9dica')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Nutri\00E7\00E3o')), 'Nutricionista', to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Fisioterapia', 'Fisioterapeuta', to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Farm\00E1cia')), to_char(unistr('Farmac\00EAutico; Farmac\00EAutica')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Biomedicina', to_char(unistr('Biom\00E9dico; Biom\00E9dica')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Odontologia', to_char(unistr('Dentista; Cirurgi\00E3o-dentista')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Fonoaudiologia', to_char(unistr('Fonoaudi\00F3logo')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Radiologia', to_char(unistr('Tecn\00F3logo em Radiologia; T\00E9cnico em Radiologia')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Engenharia Civil', 'Engenheiro Civil; Engenheira Civil', 'Engenharia', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Engenharia de Produ\00E7\00E3o')), to_char(unistr('Engenheiro de Produ\00E7\00E3o')), 'Engenharia', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Engenharia Mec\00E2nica')), to_char(unistr('Engenheiro Mec\00E2nico')), 'Engenharia', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Engenharia El\00E9trica')), to_char(unistr('Engenheiro Eletricista; Engenheiro El\00E9trico')), 'Engenharia', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Engenharia Qu\00EDmica')), to_char(unistr('Engenheiro Qu\00EDmico')), 'Engenharia', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Engenharia Ambiental', to_char(unistr('Engenheiro Ambiental; Gest\00E3o Ambiental')), 'Engenharia', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Engenharia de Seguran\00E7a do Trabalho')), to_char(unistr('Engenheiro de Seguran\00E7a do Trabalho')), to_char(unistr('Seguran\00E7a do Trabalho')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Engenharia de Computa\00E7\00E3o')), to_char(unistr('Engenheiro de Computa\00E7\00E3o')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Engenharia de Software', 'Engenheiro de Software', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Ci\00EAncia da Computa\00E7\00E3o')), to_char(unistr('Ci\00EAncias da Computa\00E7\00E3o; Computa\00E7\00E3o')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Sistemas de Informa\00E7\00E3o')), to_char(unistr('Sistema de Informa\00E7\00E3o')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('An\00E1lise e Desenvolvimento de Sistemas')), to_char(unistr('ADS; Tecn\00F3logo em An\00E1lise e Desenvolvimento de Sistemas; Desenvolvimento de Sistemas')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Redes de Computadores', to_char(unistr('Infraestrutura de Redes; Redes e Telecomunica\00E7\00F5es')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Gest\00E3o da Tecnologia da Informa\00E7\00E3o')), to_char(unistr('Gest\00E3o de TI')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', 'Banco de Dados', to_char(unistr('Bancos de Dados; Administra\00E7\00E3o de Banco de Dados; DBA')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('Seguran\00E7a da Informa\00E7\00E3o')), to_char(unistr('Ciberseguran\00E7a; Seguran\00E7a Cibern\00E9tica')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Enfermagem')), to_char(unistr('T\00E9cnico de Enfermagem; T\00E9cnica de Enfermagem; T\00E9cnica em Enfermagem')), to_char(unistr('Sa\00FAde')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Seguran\00E7a do Trabalho')), to_char(unistr('T\00E9cnico de Seguran\00E7a do Trabalho; T\00E9cnica em Seguran\00E7a do Trabalho; TST')), to_char(unistr('Seguran\00E7a do Trabalho')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('FORMACAO', to_char(unistr('T\00E9cnico em Inform\00E1tica')), to_char(unistr('T\00E9cnico de Inform\00E1tica; T\00E9cnico em TI')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Sistemas', 'Analista de Desenvolvimento de Sistemas', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Desenvolvedor de Software', 'Desenvolvedor; Programador; Developer; Desenvolvedora; Programadora', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Suporte', to_char(unistr('Suporte T\00E9cnico; Help Desk; Service Desk; T\00E9cnico de Suporte; Suporte de TI')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Dados', 'Data Analyst; Analista de BI; Business Intelligence; Analista de Business Intelligence', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Cientista de Dados', to_char(unistr('Data Scientist; Ci\00EAncia de Dados')), to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Recursos Humanos', 'Analista de RH', to_char(unistr('Gest\00E3o de Recursos Humanos')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Assistente de Recursos Humanos', 'Assistente de RH; Auxiliar de RH; Auxiliar de Recursos Humanos', to_char(unistr('Gest\00E3o de Recursos Humanos')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Analista de Recrutamento e Sele\00E7\00E3o')), to_char(unistr('Recrutamento e Sele\00E7\00E3o; Recrutador; Recrutadora; Tech Recruiter; Analista de Recrutamento')), to_char(unistr('Gest\00E3o de Recursos Humanos')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Departamento Pessoal', 'Analista de DP', 'Departamento Pessoal', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Assistente de Departamento Pessoal', 'Assistente de DP; Auxiliar de Departamento Pessoal; Auxiliar de DP', 'Departamento Pessoal', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Assistente Administrativo', 'Assistente Administrativa; Agente Administrativo', 'Rotinas Administrativas', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Auxiliar Administrativo', to_char(unistr('Auxiliar Administrativa; Auxiliar de Escrit\00F3rio')), 'Rotinas Administrativas', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Recepcionista', to_char(unistr('Recep\00E7\00E3o')), 'Atendimento ao Cliente', null, 'CARGA_INICIAL');
  commit;
end;
/
declare v number; begin
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Atendente', to_char(unistr('Atendente de SAC; Atendente de Loja; Atendente de Balc\00E3o')), 'Atendimento ao Cliente', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Operador de Telemarketing', 'Telemarketing; Teleatendimento; Call Center; Operador de Teleatendimento; Central de Atendimento', 'Atendimento ao Cliente', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Operador de Caixa', 'Caixa de Loja; Operadora de Caixa', 'Atendimento ao Cliente', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Vendedor', 'Vendedora; Consultor de Vendas; Consultora de Vendas; Vendedor Externo; Vendedor Interno', 'Vendas', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Representante Comercial', 'Representante de Vendas; Executivo de Vendas; Executivo de Contas; Key Account', 'Vendas', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Promotor de Vendas', 'Promotora de Vendas; Promotor de Merchandising; Repositor', 'Vendas', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Comprador', 'Analista de Compras; Assistente de Compras; Compradora', 'Compras', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Almoxarife', 'Auxiliar de Almoxarifado; Almoxarifado', to_char(unistr('Log\00EDstica')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Estoquista', to_char(unistr('Auxiliar de Estoque; Controle de Estoque; Gest\00E3o de Estoque; Invent\00E1rio')), to_char(unistr('Log\00EDstica')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Conferente', 'Conferente de Mercadorias; Conferente de Carga', to_char(unistr('Log\00EDstica')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Operador de Empilhadeira', to_char(unistr('Empilhadeira; Empilhadeirista; NR11; Movimenta\00E7\00E3o de Cargas')), to_char(unistr('Log\00EDstica')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Auxiliar de Log\00EDstica')), to_char(unistr('Assistente de Log\00EDstica; Analista de Log\00EDstica')), to_char(unistr('Log\00EDstica')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Motorista de Caminh\00E3o')), 'Caminhoneiro; Carreteiro; Motorista Carreteiro', 'Motorista', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Motorista Entregador', 'Entregador; Motoboy; Motofretista', 'Motorista', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Auxiliar de Limpeza', to_char(unistr('Faxineiro; Faxineira; Auxiliar de Servi\00E7os Gerais; Zelador; Zeladora; Copeiro; Copeira')), to_char(unistr('Limpeza e Conserva\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Porteiro', 'Porteira; Controlador de Acesso; Recepcionista de Portaria', to_char(unistr('Seguran\00E7a Patrimonial')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Vigilante', to_char(unistr('Vigia; Agente de Seguran\00E7a')), to_char(unistr('Seguran\00E7a Patrimonial')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Analista Cont\00E1bil')), to_char(unistr('Assistente Cont\00E1bil; Auxiliar Cont\00E1bil; Auxiliar de Contabilidade')), to_char(unistr('Ci\00EAncias Cont\00E1beis')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista Fiscal', to_char(unistr('Assistente Fiscal; Escrita Fiscal; Rotinas Fiscais; Apura\00E7\00E3o de Impostos')), to_char(unistr('Ci\00EAncias Cont\00E1beis')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista Financeiro', 'Assistente Financeiro; Auxiliar Financeiro; Contas a Pagar; Contas a Receber; Tesouraria; Tesoureiro; Faturamento', to_char(unistr('Gest\00E3o Financeira')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Auxiliar de Produ\00E7\00E3o')), to_char(unistr('Operador de Produ\00E7\00E3o; Ajudante de Produ\00E7\00E3o; Auxiliar de Linha de Produ\00E7\00E3o; Ajudante Geral')), to_char(unistr('Produ\00E7\00E3o Industrial')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Operador de M\00E1quinas')), to_char(unistr('Operador de M\00E1quina; Operador de Injetora; Operador de Prensa')), to_char(unistr('Produ\00E7\00E3o Industrial')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Montador', to_char(unistr('Montador de Produ\00E7\00E3o; Montadora')), to_char(unistr('Produ\00E7\00E3o Industrial')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Eletricista', to_char(unistr('Eletricista de Manuten\00E7\00E3o; Eletricista Predial; Eletricista Industrial')), to_char(unistr('Manuten\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Mec\00E2nico')), to_char(unistr('Mec\00E2nico de Manuten\00E7\00E3o; Mec\00E2nico Industrial')), to_char(unistr('Manuten\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('T\00E9cnico de Manuten\00E7\00E3o')), to_char(unistr('T\00E9cnico em Manuten\00E7\00E3o; Auxiliar de Manuten\00E7\00E3o')), to_char(unistr('Manuten\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Soldador', 'Solda; Soldagem', to_char(unistr('Produ\00E7\00E3o Industrial')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Cozinheiro', 'Cozinheira; Auxiliar de Cozinha; Ajudante de Cozinha; Chefe de Cozinha', to_char(unistr('Cozinha e Alimenta\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Gar\00E7om')), to_char(unistr('Gar\00E7onete')), to_char(unistr('Cozinha e Alimenta\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Padeiro', 'Confeiteiro; Confeiteira', to_char(unistr('Cozinha e Alimenta\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Professor', 'Professora; Docente; Instrutor; Instrutora', to_char(unistr('Educa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Analista de Marketing', to_char(unistr('Assistente de Marketing; Social Media; Analista de M\00EDdias Sociais; M\00EDdias Sociais')), 'Marketing', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Designer de UX', 'UX Designer; UI Designer; UX/UI; Designer de Interfaces; Product Designer', 'Design', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', to_char(unistr('Assistente Jur\00EDdico')), to_char(unistr('Auxiliar Jur\00EDdico; Paralegal')), 'Direito', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Supervisor', 'Supervisora', to_char(unistr('Gest\00E3o de Equipes')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Coordenador', 'Coordenadora', to_char(unistr('Gest\00E3o de Equipes')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('OCUPACAO', 'Gerente', to_char(unistr('Gerente de \00C1rea; Gestor; Gestora')), to_char(unistr('Gest\00E3o de Equipes')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Power BI', 'PowerBI', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'SQL', 'Linguagem SQL; PL/SQL; T-SQL; SQL Server', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Oracle', 'Banco de Dados Oracle; Oracle Database', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  commit;
end;
/
declare v number; begin
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Oracle APEX', 'APEX; Application Express', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Python', null, to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Java', 'Linguagem Java', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'JavaScript', 'JS; Node; NodeJS; TypeScript', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'C#', '.NET; Dotnet; ASP.NET', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'PHP', null, to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Computa\00E7\00E3o em Nuvem')), 'Cloud; AWS; Azure; Google Cloud', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Linux', null, to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Git', 'GitHub; GitLab', to_char(unistr('Tecnologia da Informa\00E7\00E3o')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Folha de Pagamento', to_char(unistr('Folha; C\00E1lculo de Folha; Processamento de Folha')), 'Departamento Pessoal', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'eSocial', 'e-Social', 'Departamento Pessoal', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Admiss\00E3o e Demiss\00E3o')), to_char(unistr('Admiss\00F5es e Desligamentos; Rotinas de Admiss\00E3o; Rescis\00E3o')), 'Departamento Pessoal', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', to_char(unistr('Benef\00EDcios')), to_char(unistr('Gest\00E3o de Benef\00EDcios; Administra\00E7\00E3o de Benef\00EDcios')), 'Departamento Pessoal', null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'Lean Six Sigma', 'Lean; Six Sigma; Seis Sigma; Green Belt; Yellow Belt; Black Belt', to_char(unistr('Gest\00E3o da Qualidade')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'ISO 9001', 'Norma ISO 9001', to_char(unistr('Gest\00E3o da Qualidade')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'NR-10', to_char(unistr('NR10; Seguran\00E7a em Instala\00E7\00F5es El\00E9tricas')), to_char(unistr('Seguran\00E7a do Trabalho')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'NR-12', to_char(unistr('NR12; Seguran\00E7a em M\00E1quinas e Equipamentos')), to_char(unistr('Seguran\00E7a do Trabalho')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'NR-33', to_char(unistr('NR33; Espa\00E7o Confinado')), to_char(unistr('Seguran\00E7a do Trabalho')), null, 'CARGA_INICIAL');
  v := ont_ontologia.novo_conceito('CONHECIMENTO', 'NR-35', 'NR35; Trabalho em Altura', to_char(unistr('Seguran\00E7a do Trabalho')), null, 'CARGA_INICIAL');
  commit;
end;
/

/* -- relacionados -- */
declare
  function id (p varchar2) return number is r number;
  begin select min(id) into r from ont_conceito where upper(nome) = upper(p); return r; end;
begin
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o de Recursos Humanos'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o de Recursos Humanos'))), 'RELACIONADO', id('Psicologia'), 0.3);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o de Recursos Humanos'))), 'RELACIONADO', id('Departamento Pessoal'), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o Financeira'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o Financeira'))), 'RELACIONADO', id('Economia'), 0.4);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o Financeira'))), 'RELACIONADO', id(to_char(unistr('Ci\00EAncias Cont\00E1beis'))), 0.4);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o Comercial'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o Comercial'))), 'RELACIONADO', id('Marketing'), 0.3);
  ont_ontologia.relacionar(id('Processos Gerenciais'), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.6);
  ont_ontologia.relacionar(id(to_char(unistr('Log\00EDstica'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.3);
  ont_ontologia.relacionar(id('Marketing'), 'RELACIONADO', id('Publicidade e Propaganda'), 0.5);
  ont_ontologia.relacionar(id('Marketing'), 'RELACIONADO', id(to_char(unistr('Comunica\00E7\00E3o Social'))), 0.4);
  ont_ontologia.relacionar(id('Publicidade e Propaganda'), 'RELACIONADO', id(to_char(unistr('Comunica\00E7\00E3o Social'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o P\00FAblica'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('Gest\00E3o Hospitalar'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.4);
  ont_ontologia.relacionar(id(to_char(unistr('T\00E9cnico em Administra\00E7\00E3o'))), 'RELACIONADO', id(to_char(unistr('Administra\00E7\00E3o'))), 0.4);
  ont_ontologia.relacionar(id(to_char(unistr('T\00E9cnico em Contabilidade'))), 'RELACIONADO', id(to_char(unistr('Ci\00EAncias Cont\00E1beis'))), 0.4);
  ont_ontologia.relacionar(id(to_char(unistr('T\00E9cnico em Log\00EDstica'))), 'RELACIONADO', id(to_char(unistr('Log\00EDstica'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('T\00E9cnico em Recursos Humanos'))), 'RELACIONADO', id(to_char(unistr('Gest\00E3o de Recursos Humanos'))), 0.5);
  ont_ontologia.relacionar(id(to_char(unistr('T\00E9cnico em Enfermagem'))), 'RELACIONADO', id('Enfermagem'), 0.3);
  ont_ontologia.relacionar(id(to_char(unistr('Eletrot\00E9cnica'))), 'RELACIONADO', id(to_char(unistr('Engenharia El\00E9trica'))), 0.3);
  ont_ontologia.relacionar(id(to_char(unistr('Mec\00E2nica'))), 'RELACIONADO', id(to_char(unistr('Engenharia Mec\00E2nica'))), 0.3);
  ont_ontologia.relacionar(id(to_char(unistr('Edifica\00E7\00F5es'))), 'RELACIONADO', id('Engenharia Civil'), 0.3);
  ont_ontologia.relacionar(id(to_char(unistr('Sistemas de Informa\00E7\00E3o'))), 'RELACIONADO', id(to_char(unistr('Ci\00EAncia da Computa\00E7\00E3o'))), 0.7);
  ont_ontologia.relacionar(id(to_char(unistr('An\00E1lise e Desenvolvimento de Sistemas'))), 'RELACIONADO', id(to_char(unistr('Sistemas de Informa\00E7\00E3o'))), 0.7);
  ont_ontologia.relacionar(id(to_char(unistr('An\00E1lise e Desenvolvimento de Sistemas'))), 'RELACIONADO', id(to_char(unistr('Ci\00EAncia da Computa\00E7\00E3o'))), 0.6);
  ont_ontologia.relacionar(id(to_char(unistr('Engenharia de Computa\00E7\00E3o'))), 'RELACIONADO', id(to_char(unistr('Ci\00EAncia da Computa\00E7\00E3o'))), 0.7);
  ont_ontologia.relacionar(id('Engenharia de Software'), 'RELACIONADO', id(to_char(unistr('Ci\00EAncia da Computa\00E7\00E3o'))), 0.7);
  ont_ontologia.relacionar(id('Analista de Sistemas'), 'RELACIONADO', id('Desenvolvedor de Software'), 0.6);
  ont_ontologia.relacionar(id(to_char(unistr('Analista de Neg\00F3cios'))), 'RELACIONADO', id('Analista de Sistemas'), 0.4);
  ont_ontologia.relacionar(id('Analista de Dados'), 'RELACIONADO', id('Cientista de Dados'), 0.6);
  ont_ontologia.relacionar(id('Assistente Administrativo'), 'RELACIONADO', id('Auxiliar Administrativo'), 0.7);
  ont_ontologia.relacionar(id('Recepcionista'), 'RELACIONADO', id('Atendente'), 0.6);
  ont_ontologia.relacionar(id('Operador de Caixa'), 'RELACIONADO', id('Atendente'), 0.5);
  ont_ontologia.relacionar(id('Vendedor'), 'RELACIONADO', id('Representante Comercial'), 0.6);
  ont_ontologia.relacionar(id(to_char(unistr('Gar\00E7om'))), 'RELACIONADO', id('Atendimento ao Cliente'), 0.5);
  ont_ontologia.relacionar(id('Pacote Office'), 'RELACIONADO', id('Excel'), 0.7);
  ont_ontologia.relacionar(id('Pacote Office'), 'RELACIONADO', id('Word'), 0.7);
  ont_ontologia.relacionar(id('Pacote Office'), 'RELACIONADO', id('PowerPoint'), 0.7);
  ont_ontologia.relacionar(id('Folha de Pagamento'), 'RELACIONADO', id('eSocial'), 0.4);
  ont_ontologia.relacionar(id(to_char(unistr('Legisla\00E7\00E3o Trabalhista'))), 'RELACIONADO', id('Departamento Pessoal'), 0.5);
  ont_ontologia.relacionar(id('Analista Financeiro'), 'RELACIONADO', id(to_char(unistr('Analista Cont\00E1bil'))), 0.4);
  ont_ontologia.relacionar(id('Motorista'), 'RELACIONADO', id('Operador de Empilhadeira'), 0.2);
  ont_ontologia.recalcular_fecho;
  commit;
end;
/

/* -- o catalogo HABILIDADE da base vira conceito CONHECIMENTO (ou termo de um que ja existe) -- */
declare
  v_id   number;
  v_norm varchar2(1000);
  n_novo number := 0;
  n_term number := 0;
  function exists_termo_exato (p_conceito number, p_norm varchar2) return number is
    r number;
  begin
    select count(*) into r from ont_termo where conceito_id = p_conceito and texto_norm = p_norm;
    return case when r > 0 then 1 else 0 end;
  end;
begin
  for h in (select codigo, descricao from habilidade where descricao is not null) loop
    v_norm := ont_texto.normalizar(h.descricao);
    v_id := case when v_norm is not null then ont_ontologia.classificar_texto(v_norm) end;
    if v_id is not null and exists_termo_exato(v_id, v_norm) = 1 then
      update ont_conceito set cod_externo = nvl(cod_externo, 'HAB:' || h.codigo) where id = v_id;
      n_term := n_term + 1;
    elsif v_norm is not null then
      v_id := ont_ontologia.novo_conceito('CONHECIMENTO', initcap(h.descricao), null, null, 'HAB:' || h.codigo, 'HABILIDADE');
      n_novo := n_novo + 1;
    end if;
  end loop;
  ont_ontologia.recalcular_fecho;
  commit;
  dbms_output.put_line('HABILIDADE: ' || n_novo || ' conceitos novos, ' || n_term || ' ja existiam');
end;
/

prompt
prompt === Confira a ordem da INSTRUCAO (vazio = corrigir a mao) ===
select cod, ordem, nome from ont_instrucao_ordem order by ordem nulls first, cod;
prompt === Confira a ordem dos NIVEIS de conhecimento ===
select codigo, ordem, descricao from ont_nivel_ordem order by ordem nulls first, codigo;
select tipo, count(*) conceitos from ont_conceito group by tipo order by tipo;
prompt 07_carga: carga inicial feita.
