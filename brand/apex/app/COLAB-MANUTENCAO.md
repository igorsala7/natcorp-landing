# Colaborador e filtros — a peça global `Natcorp_Colab` (todas as páginas)

Pedido de 04/10, na Linha do Tempo (300:108): "melhora o campo Fato e a região Colaborador; se não
tiver dados nos campos da região colaborador, esconda a região; faça o mesmo em todas as demais
páginas do app". Como a região e o filtro se repetem em dezenas de páginas, virou peça GLOBAL: não
precisa mexer em exportação nenhuma.

Arquivos: `Natcorp_Colab.src.js` / `.src.css` → `../login/Natcorp_Colab.js` e o CSS dentro do
`Natcorp_Style_Min.css`. JS: `python3 gerar-colab.py`. CSS: `gerar-app.mjs` (lista FOLHAS).
Carregado pelo `Natcorp_Temas.js` (lista PECAS) — e está nos GLOBAIS do `Natcorp_Registros.js`.

## 1. A região Colaborador

**Reconhecida pelo formato, não pelo título**: a foto `img#P<n>_FOTO` e o campo de texto
`P<n>_MATRICULA` dentro da mesma região (a foto pode estar numa sub-região "Foto", como na 87).

Só entra a região **só de leitura do colaborador**. Fica como está:
- região com relatório dentro;
- região com qualquer campo de preencher, ou com campo que não é do colaborador. Exemplo: a 40,
  Requisição de Férias, tem o saldo na mesma região. Nada pode sumir junto.

Campos lidos, só os de dentro da região:
- `_MATRICULA`;
- `_COD_EMPRESA1` ou `_COD_EMPRESA`;
- `_SITUACAO`, `_SITUACAO_COLAB` ou `_DESC_SITUACAO`;
- `_DT_ADMISSAO`.

| Situação | Como fica |
|---|---|
| Todos vazios | a região some (`nc-colab-vazio`) |
| Algum preenchido | cartão curto: foto (ou ícone), nome, "Matrícula N · Situação", empresa, "Na empresa desde 3 de junho de 1996" e o botão original da região (Visualizar) |
| Ação da página preenche depois | o `change` do campo refaz o cartão e a região aparece |

O texto que vem em CAIXA ALTA do banco fica "Tony Oliveira" / "Natcorp do Brasil", com a mesma regra
do `Natcorp_Consulta`.

Páginas que já fazem o próprio cartão (`Natcorp_Consulta`, `Natcorp_FeriasConsulta`) ficam com o delas.

Conferido em 04/10:
- **vazia, a região some:** 3, 47, 87, 108;
- **ficou de fora de propósito:** 40, porque tem campos de saldo;
- **não mostram a foto (região condicional):** 31, 33, 55, 162.

## 2. Os filtros de escolha múltipla (Select2)

O plugin `be.ctb.select2` com `select[multiple]`, como o "Fato" da Linha do Tempo, fica assim:
- rótulo em cima;
- campo na largura;
- as escolhas como etiquetas;
- a dica "Escolha um ou mais. Sem escolha, aparecem todos.".

O botão de filtrar da mesma região é o original, reconhecido pelo título/texto Filtrar ou Pesquisar.
Ele vai para o lado do campo com o texto "Filtrar".

CUIDADO: o tema fixa a largura do botão de ícone. A regra com `:not(#nc-cb-x):not(#nc-cb-y)` solta
a largura; sem ela, o texto aparece cortado ("Filtra").

## Para desligar

Tire `Natcorp_Colab.js` da lista PECAS do `Natcorp_Temas.src.js` e `Natcorp_Colab` da lista FOLHAS
do `gerar-app.mjs`. Gere de novo e suba os dois arquivos.
