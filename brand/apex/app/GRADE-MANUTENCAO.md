# Grade padrão — todo Interactive Grid em linhas + gaveta (Natcorp_Grade)

Pedido 08/10: padronizar os Interactive Grids no jeito das páginas da Medicina (2937: 6, 10, 12) —
o registro vira uma linha e tocar nela abre uma gaveta lateral para preencher os campos.
Decidido: **global, com exceções** (página com desenho próprio e grid com `nc-grade-nao` ficam de fora).

## Como funciona
- **Lista**: um registro por linha; título = 1ª coluna de dados; ao lado, as 4 seguintes com o nome
  delas, na ordem das colunas do grid. Contagem, busca nos registros carregados, "Adicionar" (se o
  grid deixa), "Ver como tabela" (o grid original; a escolha fica guardada por página e região).
- **Gaveta** = a "vista de um registro" (Single Row View) DO PRÓPRIO GRID, movida para a gaveta.
  Ações dinâmicas, validações e o salvar da página continuam valendo. ‹ › anda entre registros
  (travado com alteração pendente); grid só de leitura abre para consulta; Esc fecha; Ctrl+S salva.
- Lições embutidas: linha nova cancelada sai com `deleteRecords`; `interactivegridsave` também vem
  na falha (sucesso = status ok e nada pendente); espera o Ajax das ações dinâmicas antes de salvar;
  grid SEM chave: `getRecordId` dá null — o id vem do 3º argumento do `forEach`.

## 2ª versão (08/10): tabela com cabeçalho, para 400+ registros
- **Cabeçalho** com o título das colunas, preso no alto ao rolar (abaixo do que é fixo na página).
  Quantas colunas couberem, na proporção de largura do grid; nunca menores que o nome ou uma data;
  as outras ficam na ficha ("+N"). Recalcula quando a largura muda (aba que abre, gaveta, janela).
- **Ordenar no servidor**: tocar no título = a ordenação do próprio grid
  (`grid('instance')._sortChange(evento, célula do cabeçalho, direção)`; a mesma direção de novo
  = limpar). Ciclo crescente → decrescente → sem ordem.
- **Buscar no servidor**: a busca do próprio grid. CUIDADO: ela vira um FILTRO guardado no relatório
  ("Procurar 'X'") e buscar vazio não o tira — a lista tira o filtro da busca anterior pelo botão
  "Remover Filtro" do próprio grid.
- **Carrega aos poucos**: chegando ao fim, `model.fetch(carregados)` (bloco = tamanho de página do
  grid); "Mostrando 100 de 437". Com o grid fora da tela, ele NÃO busca sozinho depois de ordenar ou
  buscar: a lista pede `clearData()` + `fetch(0)` quando a chamada do grid termina.
- Valor "código - descrição" com o código leve; Apto/Normal/Inapto… em selo colorido; Sim/Não neutro.
- Testado 08/10 (Exames, 14): ordem crescente/decrescente/sem ordem, busca "HEMO" (3) e limpar (14),
  grid terminou sem ordem e sem filtro. NÃO testado ainda: grid com mais de 100 registros (o
  "carregar mais" de verdade) e o celular.

## 3ª rodada (08/10): largura das colunas, respiro, modo Tabela
- **Largura das colunas**: arrastar a borda do título (alça `.nc-gr-arrasta`), dois cliques = ajustar ao
  conteúdo (mede o scrollWidth das células), ← → no teclado (±16 px). Guardada por página+região no
  navegador (`nc-gr-larg-…`); "Larguras originais" no rodapé desfaz. Coluna alargada que não cabe
  empurra as últimas para "+N na ficha" (sem rolagem lateral: o cabeçalho grudado depende disso).
- **Respiro**: região sem padding lateral (modelo "sem padding") → a lista ganha 16 px (o JS mede).
- **Modo Tabela**: a chave Lista | Tabela fica na linha da barra do grid, à direita (nada é posto dentro
  da barra do grid). Fora da tela o grid fica com a largura da REGIÃO (`--gr-ig-w`), e ao voltar a
  rolagem lateral volta a 0 e o grid recalcula colunas e a barra presa (antes: 1100 px, rolado 224 px,
  a 1ª coluna sumia).

## 4ª rodada (08/10): todas as colunas, largura que não mexe nas outras, "Expandir colunas"
- **Lista com TODAS as colunas** (como o grid), cada uma com largura fixa em px (a do grid, ou a que a
  pessoa escolheu). Mudar uma NÃO mexe nas outras: a tabela fica mais larga e rola para o lado.
  A tabela é uma janela que rola nos dois sentidos (cabeçalho grudado no alto, 1ª coluna grudada à
  esquerda, sombra quando rolada); "carregar mais" observa essa janela.
- **Tabela (o grid)**: as colunas deixam de "esticar" (`column.noStretch = true` ao entrar no modo) —
  era isso que fazia mudar uma coluna mexer nas outras.
- **"Expandir colunas"** (ao lado de Lista | Tabela, mesmo lugar nos dois modos; de novo = "Larguras
  padrão"): Lista mede o conteúdo carregado; Tabela mede NA TELA o texto de cada célula (Range — vale
  mesmo cortado) + padding, liga célula→coluna pelo `<col data-idx>` da tabela e a lista INTERNA do
  grid (`grid('instance').columns`), e aplica com `grid('setColumnWidth', prop, px)` (o grid guarda no
  relatório). Voltar devolve as larguras de antes. Medido: Lista 11→0 cortados, Tabela 26→0.
- Soltar o mouse no título depois de arrastar a borda NÃO ordena (clique ignorado por 400 ms).
- Montagem limpa (tira controles que sobraram de montagem anterior na região).

## 5ª rodada (08/10): congelar, filtrar pela coluna, mudar a posição
Cada título tem o botão de opções (aparece ao passar o mouse; fica à vista com filtro ou congelada).
O menu ([G4b] `abrirMenuCol`):
- **Ordenar** Crescente | Decrescente | Sem ordem — só em coluna que o grid ordena (`canSort`).
- **Filtrar por …** os valores que a coluna tem nos registros carregados, com a contagem, em ordem
  natural (data por data, número por número); "Procurar valor" com mais de 6. Vira filtro do próprio
  grid (`addFilter` operador `IN`) e um chip acima da lista (× tira; "Tirar todos" com 2+).
- **Congelar até esta coluna** / Descongelar — as N primeiras presas ao rolar para o lado (guardado
  no navegador, `cong-`). Padrão: a 1ª.
- **Mover para a esquerda/direita**; ou **arrastar o título** (a linha roxa mostra onde entra). Usa o
  `moveColumn` do grid: a ordem fica no relatório e o modo Tabela mostra a mesma.
- **Ajustar largura ao conteúdo**.

CUIDADO (aprendido no teste):
- O `IN` do grid separa valores por `\u0001`. Com `;` ou `,` volta VAZIO.
- Coluna com `columnMap[…].filter === false` (Médico, na 2937:6 — sem fonte na consulta): o servidor
  IGNORA o filtro e devolve tudo, sem erro. Essa coluna filtra aqui, nos registros carregados
  (`G.filtroLocal`, chip `local:PROP`; não fica no relatório; com mais páginas o menu avisa).
- A célula de título do grid acha-se pelo `data-idx` = posição em `grid('instance').columns`. Pelo
  texto, "Médico" pegava outra coluna que começa igual.
- `__ncGradeDesligar` tem de cancelar a inscrição no modelo (`unSubscribe`) e os eventos `.ncgr`:
  senão a instância antiga recoloca a chave Lista|Tabela no cabeçalho (botões em dobro).
- Largura mínima da coluna conta o botão de opções (34 px).

## Arquivos
| O quê | Fonte | Gera |
|---|---|---|
| Tela | `Natcorp_Grade.src.js` | `python3 gerar-grade.py` → `../login/Natcorp_Grade.js` |
| Roupa | `Natcorp_Grade.src.css` | `node gerar-app.mjs` → `../login/Natcorp_Grade.css` (avulsa por enquanto) |

## Teste (08/10, 2937:6 em "Tabelas", injetado na aba, Salvar interceptado)
Exames (só leitura, sem chave, 14), Doenças (editável, vazia), Atestados (editável, 2, 14 colunas):
lista, gaveta de consulta com ‹ ›, novo + Cancelar (sai do modelo), editar + Cancelar (volta o
valor), Esc. **Não testado**: gravação real, celular de verdade.

## Global (ligado 08/10)
- CSS: `Natcorp_Grade` está nas FOLHAS do `gerar-app.mjs` → vai dentro do `Natcorp_Style_Min.css`
  (login/ e limpo/). Não existe mais `Natcorp_Grade.css` avulso.
- JS: `Natcorp_Grade.js` está na lista PECAS do `Natcorp_Temas.js` (casca) e se repassa sozinho aos
  iframes das outras aplicações e às janelas modais ([G7], como o Registros).
- `Grade` entrou na lista GLOBAIS do `Natcorp_Registros.js` — sem isso, toda página com a grade
  viraria "de desenho próprio" para o Registros e perderia Tabela/Cartões.
- Fica de fora: página com um `Natcorp_<X>.js` próprio (ex.: 2937:6, Histórico do colaborador, que
  já tem a gaveta dela), região com a classe `nc-grade-nao`. Forçar numa região: `nc-grade-sim`.
- Aplicação que carrega o Style_Min mas não o Natcorp_Temas.js (ex.: 9180) não recebe a grade.

Subir para o Workspace Images: `Natcorp_Style_Min.css`, `Natcorp_Temas.js`, `Natcorp_Registros.js`,
`Natcorp_Grade.js` (todos de `brand/apex/login/`, ou o Style_Min/Temas de `brand/apex/limpo/`).

Achado da 2937:6: em Doenças, as colunas Doença e Data Início são só leitura no APEX — nem no grid
original dá para preencher uma doença nova.
