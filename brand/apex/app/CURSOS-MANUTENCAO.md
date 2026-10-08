# Cursos do cargo — app 300, página 90 (Cursos Realizados)

**Para que serve a página:** o colaborador confere se tem o que o cargo dele pede (cursos e estudo).
Público de baixa escolaridade, ~70% no celular. Arquivos: `Natcorp_Cursos.src.js` / `.src.css`
(gerados em `brand/apex/login/` por `python3 gerar-cursos.py` e `node gerar-app.mjs`).

## O que a tela mostra
- **A resposta, no alto:** "Faltam N cursos" / "Falta o estudo que o seu cargo pede" / "Você tem tudo o que o seu
  cargo pede" / "O seu cargo não pede cursos". Trilha com um passo por curso (cheio = feito, da esquerda), Ouvir,
  e "Para fazer o que falta, fale com o seu líder ou com o RH." quando falta algo (texto em [K2], PODE MEXER).
- **Cursos que o seu cargo pede:** uma lista só, "Falta fazer" primeiro, "Feito" depois. Some quando o cargo não
  pede curso (só repetiria a resposta).
- **O seu estudo:** o cargo pede × você tem, com "Atende" / "Abaixo do pedido".
- **Outros cursos que você já fez:** concluídos que não são do cargo, recolhidos (abertos se o cargo não pede curso).
- **Ver tabela completa:** as três listas originais.

## De onde vêm os dados
Ajax Callback **NC_CURSOS_DADOS** (código em `NC_CURSOS_DADOS.plsql.sql`, posto pelo `aplicar-cursos-app300.py`,
passo 9 do `montar-f300.sh`):
- cursos do cargo = `curso_cargo` pelo cargo + centro de custo (as mesmas da lista "Cursos Exigidos");
  feito = existe em `curriculum_v` com `ind_conclusao = 'S'`;
- outros = concluídos que não estão em `curso_cargo` do cargo;
- estudo pedido = `pc_parametro_formacao.cod_instrucao` do cargo (como no app 202), nome em `instrucao`;
  estudo da pessoa = `inf_pessoais.instrucao`. "Atende" compara os CÓDIGOS (tabela instrucao no padrão eSocial:
  07 médio completo < 09 superior completo…). Se a base usar outra ordem, ajustar `situacaoEstudo` em [K5].

Sem o processo, o desenho lê as três listas da própria página (até 15 linhas cada, o tamanho da página delas — passou
disso, aparece o aviso para ver a tabela completa).

## Defeito da página original (não corrigido nela)
O item "Escolaridade Exigida" (`P90_VA_INSTR1_DISPLAY`) compara `b.cod_cargo = :p90_mat` — a MATRÍCULA no lugar do
cargo — e por isso vem sempre vazio. O desenho usa o processo, que lê pelo cargo. O item fica como está (só sai da
vista); corrigir no APEX trocando `:p90_mat` por `:p90_cargo` nos dois itens VA_INSTR1.

## Conferir depois de importar
- Um colaborador com curso obrigatório faltando: a contagem bate com a lista original "Cursos à Realizar"?
- O estudo pedido aparece para um cargo cadastrado em `pc_parametro_formacao`?
