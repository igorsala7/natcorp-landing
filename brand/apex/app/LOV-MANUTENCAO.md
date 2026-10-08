# Lista de escolha (Popup LOV) — sistema todo (APEX 19.2)

A janela "Caixa de Diálogo Pesquisar" do item **Popup LOV** com várias colunas (ex.: Processo
Seletivo na 9110:182, 14 colunas). Antes: 700 px, colunas espremidas ("576…", "Ass…"), nada legível.

| Arquivo | Onde | O quê |
|---|---|---|
| `Natcorp_Lov.src.css` → dentro do `Natcorp_Style_Min.css` | lista FOLHAS do `gerar-app.mjs` | toda janela de Popup LOV: busca grande, "Deixar em branco" discreto, linhas da grade mais legíveis; e os CARTÕES quando o JS marca a janela (`nc-lov`) |
| `Natcorp_Lov.src.js` → `../login/Natcorp_Lov.js` (`python3 gerar-lov.py`) | trazido pelo `Natcorp_Temas.js` (PECAS) e repassado aos iframes | janela com 3+ colunas: cresce (até 1000 px × 86% da altura), título = rótulo do campo, cada resultado vira cartão (título = coluna de exibição; as outras como "rótulo valor", vazias saem), busca marcada, contagem, Cartões \| Tabela (lembrado em `nc-lov-visao`), "- Selecione -" → "Deixar em branco" |

Escolher, buscar, "carregar mais" e devolver o valor continuam **do APEX**: o cartão aciona a linha
original da grade (mousedown/mouseup/click na célula).

## Cuidados (aprendidos nos testes de 03/10)

- **A janela abre na janela PRINCIPAL** (a casca), mesmo com o campo dentro de um iframe — por isso o
  JS vem pelo Temas da casca (e também se espalha para os iframes, para páginas abertas fora dela).
- **A grade não pode ficar `display: none`**: o APEX não desenha linhas (nem aceita a escolha) de
  grade "invisível" — a busca parava de atualizar e o toque não escolhia. Nos Cartões ela fica à
  vista para o navegador, encolhida a 1 px (`clip-path`).
- A grade escreve a própria largura/altura em px (700 × 189): o JS chama o `resize`/`resizeStop` do
  dialog depois de aumentar a janela, e o CSS faz a lista ocupar o espaço nos Cartões.
- **Teclado**: o APEX leva o ↓ da busca para o "Deixar em branco" e a grade escondida; a escuta do ↓
  é na `window`, em captura. A busca é REDESENHADA pelo APEX — comparar pela classe. Teclas nos
  cartões param ali (`stopPropagation`), senão a grade (que contém a lista) andaria junto. Foco que
  cair na grade escondida passa para o cartão.
- A busca do APEX dispara ao SOLTAR a tecla (teste automático com `fill` não busca; use `type`).
- Só age quando a janela passa de escondida a visível (ajustar o tamanho muda o style e reagir a isso
  daria laço).
- Lista com 1 ou 2 colunas não muda (`MIN_COLUNAS`).
- **Nada de `table-layout` ou largura nas tabelas da grade** (corrigido 03/10): o cabeçalho fixo e as
  linhas são DUAS tabelas, alinhadas pelas larguras que o APEX põe nos `<col>`. Com `table-layout:
  auto` cada uma media o próprio conteúdo e os títulos da Tabela saíam do lugar.
- O `resizeStop` do APEX lê `ui.size`: chamar com `{}` dava erro e a grade não recalculava as
  larguras — o JS passa o tamanho da janela.
- **Tabela legível** (03/10): a grade do APEX divide a largura POR IGUAL ("Natco…" em 14 colunas).
  O JS (`[L4b] larguras`) mede título e valores de cada coluna (canvas, com a letra da grade), dá a
  cada uma o que precisa entre `COL_MIN` (70) e `COL_MAX` (360) px, põe as MESMAS larguras nos `<col>`
  das DUAS tabelas e a largura total nelas; a tabela rola de lado e o cabeçalho acompanha. Refeito a
  cada busca/linhas novas, ao trocar para Tabela e depois de redimensionar a janela.

## Regras da página (auditoria 04/10)

Conferido: escolher = clique na linha ORIGINAL da grade (o APEX devolve o valor e dispara o change e
as ações do item); a busca e as cascatas continuam as do APEX (servidor); "Deixar em branco" é o próprio
botão nulo; item desabilitado/só leitura não abre a janela (o botão da lista é do APEX). Nada mudou.
