# Editor de texto rico — sistema todo (CKEditor 4.11 do APEX 19.2)

O item "Rich Text Editor" (ex.: Mensagem do e-mail ao candidato, 9113:35) em QUALQUER aplicação.
Antes: barra cinza em degradê, 44 botões em três linhas forçadas, caixinhas com relevo, Arial 13 px
ao escrever e — o motivo de "não ser responsivo" — `style="width: 1140px"` escrito pelo APEX no
editor ao abrir a página (largura fixa em pixels).

| Arquivo | Onde | O quê |
|---|---|---|
| `Natcorp_Editor.src.css` → dentro do `Natcorp_Style_Min.css` | lista FOLHAS do `gerar-app.mjs` | moldura de 100% (vence a largura fixa), barra branca e plana, botões de 32 px, grupos que quebram sozinhos (as quebras forçadas saem), ícones monocromáticos que acendem, foco com o anel da marca, listas (Formatação…) com borda leve, pé discreto, janelinhas Link/Imagem/Tabela |
| `Natcorp_Editor.src.js` → `../login/Natcorp_Editor.js` (`python3 gerar-editor.py`) | trazido pelo `Natcorp_Temas.js` (lista PECAS) e repassado aos iframes (como o Registros) | letra confortável AO ESCREVER (15 px, entrelinha 1,6, margens) — só aparência, o HTML gravado não muda; "⋯ Mais" esconde/mostra os botões raros (lista RAROS) e lembra a escolha (`nc-ed-tudo`); tira a largura fixa |

Sem o JS o CSS já vale sozinho (só não há "Mais" nem a letra nova dentro do texto).

## Cuidados

- **Nada é removido**: os raros (recortar/colar, imprimir, modelos do editor, emoji, caracteres,
  quebra de página, fonte, tamanho, estilos, sub/sobrescrito, citação, justificar…) ficam atrás do
  "Mais". Para um voltar a aparecer sempre, tire o nome da lista RAROS.
- Separadores que sobrariam (começo, fim ou dois seguidos) também ficam atrás do "Mais".
- A letra de dentro está num `<style id="nc-ed-letra">` no iframe do CKEditor, reposto a cada
  `contentDom` (volta do Código-Fonte, troca de conteúdo). O `contents.css` do CKEditor usa
  `.cke_editable` (13 px) — por isso `body.cke_editable … !important`.
- A altura continua a do item (e o canto de arrastar). A janela de e-mail (9113:35) ajusta a altura
  dela pela janela (`ed.resize`) — isso é só dela, no Natcorp_ProcessoJanelas.

## Regras da página (auditoria 04/10)

Conferido: o arquivo não troca configuração nem valor — a cópia do texto para o item antes do envio
continua a do APEX (CKEditor `updateElement`); a letra entra só no `<head>` do iframe de escrever (fora
do HTML gravado); o "Mais" só mostra/esconde botões da barra. Editor só leitura: o APEX desenha texto
ou trava a barra (`setReadOnly`), e nada aqui destrava. Nada mudou.
- Observação: `.cke_toolbox` com `display:flex` vence o "recolher barra" do CKEditor (`toolbarCanCollapse`),
  se alguma página o usar — é aparência, não regra de negócio.
