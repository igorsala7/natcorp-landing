# Resumo dos afastamentos — página 25 do app 200

Pedido (08/10/2026): indicadores de gestão na consulta "Controle de Funcionários Afastados", fáceis
para quem tem pouca instrução. A página continua igual (filtros e relatório); acima do relatório
entra um **Resumo dos afastamentos**.

## O que o painel mostra

**Hoje** (a situação ATUAL do cadastro: situação ≠ 01 e < 90). Cada número abre a lista de quem são:

| Número | Quem entra | A lista vem em que ordem |
|---|---|---|
| Fora agora | todos afastados hoje | o que pede atenção primeiro (atrasada, sem data, volta logo, depois) |
| Voltam em até 7 dias | data de retorno prevista entre hoje e hoje + 7 | quem volta antes |
| Volta atrasada (vermelho) | data de retorno prevista já passou e continua afastado | o mais atrasado |
| Sem data de volta (âmbar) | sem data de retorno prevista | quem está fora há mais tempo |
| Há mais de 15 dias | afastado desde mais de 15 dias (em doença, o INSS paga do 16º dia) | quem está fora há mais tempo |

**No período** (as datas do filtro; sem data, os últimos 12 meses — o painel diz qual):
- a frase "N pessoas se afastaram N vezes, somando N dias fora" e o índice "de cada 100 dias de
  trabalho, X foram perdidos" = dias fora ÷ (quadro × dias do período) × 100;
- mês a mês (afastamentos que começaram em cada mês, até 24 meses);
- o que mais afasta (motivos), onde mais acontece (centros de custo), quem se afastou 2 vezes ou mais.

**Para analisar (2ª rodada, 08/10):**
- **Ver na tabela:** tocar num motivo, num centro de custo ou numa pessoa (no período ou na lista
  "quem são") usa a PRÓPRIA busca do relatório (`IR_search_field` + "Ir"): a tabela fica só com
  aquilo, com o filtro à vista e o × para tirar. O texto buscado é o que a coluna mostra.
- **Quadros com a mesma altura (360 px) que rolam por dentro**, com sombra em cima/embaixo quando há
  mais. Mostram 6 linhas e revelam as próximas ao chegar perto do fim (e um botão "Mostrar mais ·
  faltam N"). O servidor manda até 30 por quadro. No celular, altura máxima (sem buraco).
- **% do total** em cada motivo e centro de custo ("63 vezes · 58% · 46.494 dias").
- **Quando começaram:** até 24 meses, mês a mês; até 72 meses, por trimestre; acima, por ano. Com
  colunas estreitas, o nome só nos marcos (jan, abr, jul, out) e o número só no pico; o resto na
  dica ao passar o mouse ou tocar na coluna. Embaixo, o período com mais afastamentos.
- **Lista "quem são":** todas as pessoas (até 400) numa caixa que rola e vai revelando de 30 em 30;
  com mais de 12, a caixa "Procurar nome, cargo, setor ou motivo".
- No cabeçalho: **Ir para a tabela**, **Atualizar** (o resumo fica guardado 10 min nesta aba) e
  **Esconder resumo** (lembrado no navegador).

### A tabela continua sendo a página (modo compacto)

O painel abre **fechado**: só a faixa "Hoje" (≈130 px) e o botão **Ver análise completa**; o
relatório aparece logo abaixo, sem rolar. Aberto, o botão vira **Mostrar menos**. A escolha fica no
navegador (`localStorage`; `'0'` = aberto). Mesmo comportamento na 16, 25 e 26 (pedido 08/10).

## Filtrar e cruzar no próprio resumo (12/10)

Pedido do cliente: filtrar direto no painel e escolher o cruzamento do "Onde mais acontece" entre as
colunas do relatório.

- **Filtrar este resumo** (faixa logo abaixo do título): um botão por coluna do relatório —
  Empresa, Filial, Centro de Custo (Célula), Unidade Adm. (Cliente), Atividade (Serviço), Cargo,
  Vínculo e Motivo do afastamento — que abre uma **lista de marcar: VÁRIOS valores por coluna**
  (13/10). Dentro da coluna vale qualquer um dos marcados; entre colunas, todas. A lista traz os
  marcados no alto, o número de afastamentos de cada valor, busca (com mais de 8) e "Desmarcar
  todos" / "Pronto"; marcar vale na hora (o resumo muda atrás da lista). Fecha com Esc ou tocando
  fora. Só lista o que existe nos dados, com os outros filtros valendo; coluna com uma opção só nos
  dados todos não aparece. Coluna filtrada = botão rosa com o 1º valor e "+N".
- **Tocar numa barra** de "O que mais afasta" ou "Onde mais acontece" junta aquele valor ao filtro
  da coluna (tocar de novo tira). A escolhida ganha ✓ e borda rosa; as outras ficam apagadas, mas continuam lá para
  trocar. **Ver na tabela** virou o botão pequeno à direita da linha (ao passar o mouse; no celular,
  sempre à vista). "Mais de uma vez" continua levando para a tabela.
- **Onde mais acontece · por [Centro de custo ▾]**: Centro de custo (padrão), Empresa, Filial,
  Unidade adm., Atividade, Cargo ou Vínculo. A escolha fica lembrada no navegador (`nc-af-por`).
- O filtro vale para o resumo INTEIRO: os 5 números de Hoje e a lista "quem são", a frase, o índice
  (com o quadro das mesmas colunas), mês a mês, motivos, onde e "Mais de uma vez". A **tabela não
  muda** (o painel diz isso) — ela segue os filtros da página.
- Modo compacto: a faixa some; com filtro, fica a linha "Resumo só de: [Filial 3 ×]".
- **Não existe coluna "Unidade de Negócio"** no relatório; as que existem são as acima. Se o cliente
  quiser outra, ela precisa entrar na consulta do relatório e no NC_AFAST_INDICADORES (a lista
  `DIMS` do JS e a posição em `ev`).

**Como funciona:** o NC_AFAST_INDICADORES (v2) manda CADA afastamento do período como números —
`ev = [motivo, empresa, filial, ccusto, unidade, atividade, cargo, vínculo, pessoa, AAAAMM, dias]` —
e os nomes uma vez só em `dims` (iguais aos da tabela); o quadro vem dividido pelas mesmas colunas
(`quadroG`); de cada pessoa de hoje vem `k` com as colunas. As contas são feitas no navegador, então
filtrar e trocar o "por" é instantâneo, sem calcular de novo no banco. Nomes de pessoa só de quem
se afastou 2+ vezes (`nomes`). A lista "quem são" passou de 400 para 3.000 pessoas.

**O JS antigo com o processo novo quebra os quadros** (ele procura `tipos`/`setores`, que o v2 não
manda). O JS novo com o processo antigo funciona como antes (sem filtros). Por isso: **subir o JS e
o CSS primeiro, depois o processo.**

**Ver na tabela procura SÓ NA COLUNA certa (13/10):** procurar o texto em todas as colunas deixava o
relatório lento. Motivo → Situação, centro de custo → C.Custo, filial → Filial, … pessoa →
Colaborador. É o mesmo que escolher a coluna na lupa da busca e digitar: o JS grava o alias no campo
escondido `IR_column_search_current_column` (o que o menu da lupa faz; o menu só monta as opções ao
abrir, com uma ida ao servidor) e o filtro sai "C.Custo contém '…'". Coluna oculta no relatório
(ex.: Vínculo) → busca em todas. Se o título de uma coluna mudar no relatório, ajustar `TITULO_COL`.

## Instalar

1. Subir para o Workspace Images: `login/Natcorp_Afastamentos.js` e `login/Natcorp_Afastamentos.css`.
2. Importar `f200_page_25.sql` no app 200 (a página inteira, como as outras exportações). Ela é a
   exportação da página viva (`f200_page_25.ORIGINAL.sql`, 08/10) com só duas mudanças: os File URLs
   do .js/.css e o processo Ajax Callback `NC_AFAST_INDICADORES`.
3. Abrir a página 25: o painel aparece acima do relatório.

Sem o NC_AFAST_INDICADORES o painel mostra "Falta instalar nesta página o processo NC_AFAST_INDICADORES"
e a tabela continua funcionando. Se a página 25 mudar no APEX, exportar de novo, trocar o
`.ORIGINAL.sql` e rodar o aplicar.

## Arquivos

| O quê | Fonte | Gera |
|---|---|---|
| Os números (servidor) | `NC_AFAST_INDICADORES.plsql.sql` | entra no processo pelo aplicar |
| A página para importar | `f200_page_25.ORIGINAL.sql` | `python3 aplicar-afastamentos-pagina25.py f200_page_25.ORIGINAL.sql f200_page_25.sql` |
| A tela | `Natcorp_Afastamentos.src.js` | `python3 gerar-afastamentos.py` → `../login/Natcorp_Afastamentos.js` |
| A roupa | `Natcorp_Afastamentos.src.css` | `node gerar-app.mjs` → `../login/Natcorp_Afastamentos.css` (avulsa) |

## Cuidados

- Os filtros são os MESMOS do relatório (P25_*), enviados na chamada. Os filtros feitos dentro do
  relatório (menu Ações) NÃO entram nos números.
- O fim de cada afastamento é o da coluna "Data Final" do relatório (fim do histórico, senão o do
  atestado); sem nenhum dos dois, se é a situação atual conta até hoje, senão só o dia de início.
  Desempenho (08/10): LEAD sobre o histórico inteiro levou 82 s e a "próxima situação" por subconsulta
  passou de 260 s — a consulta do período agora é a mesma junção do relatório. O JSON devolve
  `tempos` (centésimos de segundo por parte) para achar o peso se voltar a ficar lento.
- Uma consulta só (GROUPING SETS) faz motivos, centros de custo, pessoas, meses e o total.
- A página passa a ter desenho próprio; o JS marca o relatório (`#IR`) com `nc-reg-sim` para ele
  continuar com Tabela | Cartões.
- **Não testado no banco**: o PL/SQL foi escrito a partir da consulta do relatório (a da exportação
  do 200 de 08/10 é igual à do 207). A tela foi conferida na 200:25 com números aproximados tirados do CSV do
  relatório. Ao instalar, conferir "Fora agora" contra o relatório filtrado pela situação.
- A busca da lista de marcar (`.nc-af-pop-busca`) reaproveita a `.nc-af-procura` da tabela, que tem
  `flex: 1 1 260px`. Dentro da lista (coluna flex) isso vira ALTURA: a caixa crescia ao escrever,
  conforme a lista encolhia (13/10). Por isso o `flex: none` na regra da lista — não tirar.
