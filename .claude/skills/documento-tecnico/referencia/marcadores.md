# Marcadores do conteudo.md

O `conteudo.md` é Markdown comum (GFM) mais os blocos abaixo. Blocos abrem com `::: nome` numa linha e
fecham com `:::` numa linha sozinha. Comentários `<!-- -->` são removidos antes de montar.

## Capítulos

```
::: capitulo N | Título | Subtítulo
```
- Linha única, abre página nova com a abertura grande (número, título, subtítulo e chips com os `##`).
- `0` é especial: gera a **capa** (o subtítulo vira o texto da capa) e a abertura **"Como ler este
  documento"**. O texto antes de `## Como ler...` vira o subtítulo dessa abertura.
- O **último** capítulo é marcado como "consulta" (questionário, glossário, contatos). O total de
  capítulos é calculado sozinho.
- O primeiro parágrafo de cada capítulo vira o *lead* (texto maior).
- Os cinco primeiros `##` aparecem como chips "nesta seção" na abertura.

## Cartões

```
::: cards
### Título do cartão
Texto do cartão (Markdown inline).

### 1. Título numerado
Vira "CAMADA 01" acima do título.
:::
```
- 3 ou 6 cartões: grade de 3 colunas. Outros: 2 colunas; ímpar deixa o último largo.
- O ícone vem da palavra do título: regras do motor + `icones` do `documento.config.mjs` (que têm prioridade).
- No capítulo 0, os títulos "Você sabia?" e "...âmbar..." ganham amostra do componente.

## Caixas

```
::: voce-sabia
Texto. Um detalhe prático ou uma configuração que o cliente controla.
:::

::: passos
1. **Rótulo.** Texto do passo.
2. **Rótulo.** Texto do passo.
:::

::: destaque
#### Título do painel roxo
Subtítulo em uma linha.
### Coluna 1
Texto.
### Coluna 2
Texto.
> Rodapé que amarra as colunas.
:::
```
O ícone de cada coluna do destaque sai do título: "sem internet", "lenta/instável", "delay",
"GET/consulta", "POST/importação", "contingência"; o resto usa cofre.

```
::: confirmar
**Título da caixa âmbar**
- Pergunta que a Natcorp precisa responder: [preencher: dica do que escrever]
:::
```
Caixa âmbar "A confirmar pela Natcorp". Só para rascunho: o dono costuma pedir para tirar todas antes
do envio (decisão de 21/10/2026). Se tirar, o tema vai para o relatório INTERNO.

## Figuras

```
::: figura nome | Legenda sem ponto final
```
`nome` é o SVG sem extensão, mapeado em `figuras` no config. Numeração automática "Figura C.N".
Largura e página nova em `ajustes.figuras`.

## Tabelas

- Tabela GFM comum. Larguras por cabeçalho exato em `larguras` do config (`'A|B|C': [30, 40, 30]`).
- Parágrafo só com `**negrito**` logo antes da tabela vira o título dela.
- Cabeçalho `Termo | O que significa` vira glossário em duas colunas.
- Primeira coluna `#` vira tabela de requisitos.
- Selos dentro da tabela: `✓ Atende`, `ℹ Informado pela Natcorp`, `⚠ A confirmar pela Natcorp`.
- `[preencher: dica]` vira campo para preencher.

## Proibido no texto
Travessão (—) e meia-risca usada como travessão. O gerador avisa e a figura com travessão falha.
