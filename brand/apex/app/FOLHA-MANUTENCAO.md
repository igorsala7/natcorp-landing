# Folha de Pagamento do Mês — 300:74 (Natcorp_Folha)

O holerite do mês para quem lê com dificuldade (~70% no celular). Fontes: `Natcorp_Folha.src.js` / `.src.css`
(gerar: `python3 gerar-folha.py`, `python3 escala-desktop.py Natcorp_Folha.src.css`, `node gerar-app.mjs`).
Aplicação no app: `aplicar-folha-app300.py` (passo 8 do `montar-f300.sh`). A página SAIU do motor de consultas
(`aplicar-consultas-app300.py` e a receita `P74_` do Natcorp_Consulta).

## O que a tela mostra
- **O mês** no alto: setas e lista nativa. Só escolhem uma opção em `P74_DATA_REF`; a ação "Valida Dt Ref" roda como sempre.
  A lista original sai da região Colaborador (para o cartão global `Natcorp_Colab` se montar) e fica numa guarda fora da vista.
- **O recibo**: Você ganhou − Foi descontado = Você recebe; barra "Fica com você / Descontos"; "De cada R$ 100…"; **Ouvir**.
- **O que você ganhou / O que foi descontado**: a maior verba primeiro; "O que é isso?" nas verbas conhecidas ([F3] do JS).
- **Bases de cálculo e informações**: recolhidas, em cinza.
- **Ver tabela completa**: o relatório original.

## De onde vêm os números
Processo Ajax Callback **NC_FOLHA_DADOS** (criado pelo script): a MESMA consulta do relatório e a MESMA validação da
ação "Valida Dt Ref" (`pkg_executa_f011544.valida_parametros`): mês não liberado → aviso "Este mês ainda não pode ser
consultado" + a mensagem do servidor. Se a própria validação der ERRO (exceção), vale o que a página faz hoje: as verbas
aparecem.

**Tipo da verba = faixa do código** (`P74_QUATRO_DIGITOS`, lido de `configuracoes.quatro_digitos_ocorr` pelo processo
de abertura; se a sessão não o tiver, o callback lê direto):

| P74_QUATRO_DIGITOS | Proventos | Descontos | Bases | Total de Proventos / Descontos / Líquido |
|---|---|---|---|---|
| N | 1 a 499 | 500 a 899 | 900 em diante | 997 / 998 / 999 |
| S | 1 a 4999 | 5000 a 8999 | 9000 em diante | 9997 / 9998 / 9999 |

**Incide no líquido**: dentro da faixa de provento/desconto, só conta a verba com `incid_liq = 'S'` (lido de
`vw_historicos`, a mesma regra da página 21). Com `'N'` ela vai para as bases — é assim que o holerite impresso faz
(conferido em 05/10 com o PDF do Tony, jun/2026: sem isso, 807 Capital Segurado R$ 120.000 aparecia como desconto).
Se a view não responder, vale só a faixa.

O callback manda `tipo` (1 provento, 2 desconto, 3 base) e, nas três linhas de total, `total` = g / d / l. O recibo usa
os TOTAIS quando eles vêm (a soma das linhas poderia contar encargos da empresa, como INSS Empresa) e eles saem das
listas. Sem as linhas de total: soma por tipo. (`ocorr_pagto.tipo_rubrica` não é mais usado.)

## Conferir depois de importar
- A soma de "O que você ganhou" bate com o Total de Proventos (997/9997)? E a de "O que foi descontado" com o 998/9998?
- Um cliente com `quatro_digitos_ocorr = 'S'` mostra as verbas 5000+ como desconto (e não como ganho)?

## Tropeço visto em 05/10 (da página, não do desenho)
Ao abrir, a ação "Valida Dt Ref" responde `{"error":"Ocorreu um erro ao tentar processar as informações."}` (aviso na tela),
com ou sem o desenho. É a validação do servidor (`valida_parametros`) — para o time conferir.

## Prévia antes de importar
`scratchpad/previa-folha.js` responde no lugar do NC_FOLHA_DADOS lendo o relatório, com a mesma regra de faixas (lê P74_QUATRO_DIGITOS da página).

## Página 104 — Ocorrência de Pagamento (modo "ocorrências", 05/10)
O mesmo Natcorp_Folha.js/.css. Ligado pela página: JavaScript › Function and Global Variable Declaration =
`var ncFolha = { modo: 'ocorrencias', processo: 'NC_OCORR_DADOS' };` (o aplicar-folha-app300.py põe; o motor das
consultas sai da 104). Dados: Ajax Callback **NC_OCORR_DADOS** (código em `NC_OCORR_DADOS.plsql.sql`): a consulta do
relatório (ocorrencia_calculo) + tipo pela mesma regra da 74 (faixa por `configuracoes.quatro_digitos_ocorr` e
`incid_liq` de `vw_historicos`, de qualquer mês do colaborador).
- Ocorrência NÃO é o pagamento: o resumo mostra Ganhos e Descontos lançados, sem "Você recebe", e aponta para a Folha
  do Mês (o link do próprio menu).
- "Todos os meses" (o vazio da lista): uma faixa por mês com os totais; a mais nova aberta, as outras montam ao abrir.
- A troca de mês é SEM recarregar (a lista original recarrega a página no onchange): o valor vai para a lista, o
  relatório escondido se atualiza e os lançamentos são buscados de novo.
- Sem o processo (página não importada), o APEX responde vazio: o desenho sai e volta o relatório de sempre.
