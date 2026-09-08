# Contrato visual — o alvo, traduzido para o que a máscara do APEX pode fazer

Extraído de `brand/app-referencia/natcorp-app.html`. Aqui ficam só os valores que uma folha de
estilo global sobre o Universal Theme consegue aplicar. O que o modelo tem e o APEX não
(bolha de chat, celular, passos de admissão) fica de fora.

## Tokens

```css
:root{
  /* rampa da marca — gradiente e acentos, nunca fundo de conteúdo */
  --nc-azul:#2C1A63; --nc-roxo:#511C76; --nc-ameixa:#9A408A; --nc-rosa:#C95788;
  --nc-realce:#E4A9C4;
  --nc-grad:linear-gradient(135deg,#2C1A63 0%,#511C76 55%,#9A408A 100%);

  /* texto — três níveis, nenhum preto */
  --nc-tinta:#1B1238; --nc-grafite:#4A4460; --nc-cinza:#8E88A3;

  /* superfícies */
  --nc-tela:#F6F2FA;      /* fundo da aplicação: LAVANDA, não cinza */
  --nc-branco:#FFFFFF;    /* cartão */
  --nc-quase:#FBF9FD;     /* hover de linha, blocos tonais */
  --nc-off:#F4F2F7;       /* fundo de controle (busca, segmentado, tile de ícone) */
  --nc-linha:#E9E5F1;     /* borda estrutural e borda do cabeçalho de tabela */
  --nc-linha2:#F1EDF6;    /* borda de repetição: célula de tabela */

  /* dados — validadas para daltonismo, não substituir */
  --nc-serie1:#6E3796; --nc-serie2:#C95788;

  /* semânticos — quatro famílias fechadas, sempre par cor+fundo */
  --nc-bom:#2E8B6B;  --nc-bom-bg:#E6F4EE;
  --nc-aviso:#B8791F;--nc-aviso-bg:#FBF0DC;
  --nc-ruim:#B8323F; --nc-ruim-bg:#FBE6E9;
  --nc-info:#511C76; --nc-info-bg:#EFE6F5;

  /* sombra: roxa, spread negativo. NUNCA preta */
  --nc-sombra:0 14px 34px -22px rgba(81,28,118,.35), 0 1px 0 0 rgba(81,28,118,.04);
  --nc-sombra-alta:0 24px 50px -28px rgba(44,26,99,.45);
}
```

## Tipografia

Manrope 400/500/600/700/800. Base 14px/1.5, `-webkit-font-smoothing:antialiased`.
`font-variant-numeric: tabular-nums` em toda coluna numérica, data, hora e valor.

| Papel no APEX | Tam. | Peso | Entreletras | Cor | Caixa |
| --- | --- | --- | --- | --- | --- |
| Título de região (`.t-Region-title`) | 15.5px | 800 | −0.005em | tinta | — |
| Subtítulo de região | 12.5px | 400 | — | cinza | — |
| Cabeçalho de coluna (`th`) | 11px | 700 | **+0.10em** | cinza | ALTA |
| Célula (`td`) | 13px | 400 | — | tinta | — |
| Nome dentro da célula | 13px | 700 | — | tinta | — |
| Sublinha na célula (matrícula) | 11.5px | 400 | — | cinza | — |
| Rótulo de campo | 12px | 700 | — | grafite | — |
| Entrada de campo | 13.5px | 400 | — | tinta | — |
| Botão | 13.5px | 700 | — | conforme | — |
| Item de menu lateral | 13.5px | 600 | — | rgba(255,255,255,.82) | — |
| Grupo de menu | 10.5px | 700 | +0.16em | rgba(255,255,255,.5) | ALTA |
| Etiqueta de estado | 11.5px | 700 | — | semântica | — |
| Número de destaque | 30px | 800 | **−0.02em** | tinta | — |

Regra fechada: **entreletras negativa só em título e número grande; positiva só em maiúscula
pequena.** Nunca as duas no mesmo tamanho. A escala usa meios-pontos (15.5 · 13.5 · 12.5 · 11.5 ·
10.5) — é ajuste óptico, reproduzir exato.

## Forma diz função

- **Pílula 999px** = ação ou filtro: botão, busca, select de filtro, segmentado, chip, paginação não.
- **Retângulo raio 12px** = entrada de dado: input, select de formulário, textarea.
- **Raio 20px** = cartão/região. **16px** = bloco tonal interno. **10px** = botão de paginação.

O usuário aprende a diferença sem ler. Não misturar.

## Medidas

| Valor | Onde |
| --- | --- |
| 40px | altura de botão, botão de ícone, busca do topo |
| 34px | botão pequeno |
| 42px | campo de formulário |
| 38px | select de filtro, busca de barra de ferramentas |
| 11px 12px | padding de `td` → linha de ~42px (~52px com avatar) |
| 8px 12px | padding de `th` |
| 20px 22px | padding interno do cartão (vertical menor que horizontal) |
| **18px** | distância entre blocos — ritmo único, não varia |
| 14px | do cabeçalho do cartão ao corpo |

## Componentes — especificação para o APEX

**Região / cartão.** `background:#fff; border:1px solid var(--nc-linha); border-radius:20px;
box-shadow:var(--nc-sombra); padding:20px 22px`. Cabeçalho: título 15.5/800 à esquerda,
**uma só** ação no canto direito — nunca duas.

**Botões.** Todos pílula, `font:700 13.5px`, ícone interno 16px, gap 8px.
- primário: `var(--nc-grad)`, branco, `box-shadow:0 10px 24px -14px rgba(81,28,118,.7)`
- contorno: branco, borda `--nc-linha`, texto roxo, hover fundo `--nc-off`
- fantasma: transparente, texto roxo
- ícone: 40×40, branco, borda `--nc-linha`

**Tabela.** Zero borda vertical. Zero zebra. Só a linha inferior — a do `th` mais escura
(`--nc-linha`) que a das células (`--nc-linha2`). Hover pinta a linha inteira de `--nc-quase`.
Identidade e texto à esquerda; quantidade, data, hora e ação à direita.

**Campo.** 42px, raio 12, borda `--nc-linha`. Foco: `border-color:var(--nc-roxo)` +
`box-shadow:0 0 0 3px rgba(81,28,118,.12)`.

**Foco global.** `:focus-visible{outline:2px solid var(--nc-rosa); outline-offset:2px;
border-radius:6px}` — em tudo que é interativo.

**Estado.** Pílula tonal com ícone, quatro famílias fechadas (bom/aviso/ruim/info), sempre par
cor + fundo claro. Nenhum estado em cor sólida saturada, nenhum estado só por cor de texto.

## As decisões que separam moderno de datado

Estas são as que a máscara precisa acertar — cada uma é reproduzível em CSS:

1. **O fundo é lavanda `#F6F2FA`, não branco nem cinza.** É o que faz o cartão branco acender sem
   sombra forte. Trocar por `#F5F5F5` mata o sistema inteiro.
2. **Sombra roxa com spread negativo** (`-22px`): halo difuso abaixo do cartão, não caixa ao redor.
   Nenhuma sombra preta.
3. **Borda quase invisível + sombra juntas.** A separação vem do contraste de superfície.
4. **O gradiente é territorial e raro:** menu, botão primário, avatar, medidor. **Nunca** em fundo
   de conteúdo, região, tabela ou cabeçalho de coluna. É o que separa identidade de papel de parede.
5. **Tabela sem grade** — hierarquia por peso de linha, não por caixas.
6. **Cabeçalho de coluna em micro-caps 11px/700/0.1em cinza** — deixa de parecer planilha.
7. **`tabular-nums` em toda coluna numérica** — alinha sem fonte monoespaçada.
8. **Alinhamento pela natureza do dado**, sem exceção.
9. **Densidade calibrada:** `padding:11px 12px` = linha de ~42px que ainda comporta avatar de 30px.
10. **Ritmo único de 18px** entre blocos. Não há 16 aqui e 24 ali.
11. **Um só desenho de ícone:** 24×24, traço 2, cap/join redondos, `currentColor`, renderizado a 18px.
12. **Foco visível da marca**, global — o produto passa a parecer feito por quem testa com teclado.
13. **Barra superior translúcida** (`rgba(255,255,255,.92)` + `backdrop-filter:blur(10px)`), sem sombra.
14. **Gráfico sem moldura:** sem eixo desenhado, sem grade vertical, sem borda de área. Só linhas
    horizontais de 1px em `#EFEBF4` e rótulos de 11px em cinza.
15. **Hover que levanta, não que pinta:** `translateY(-2px)` + sombra + borda em `--nc-realce`.
16. **Três níveis de texto e nada mais.** Cinza de sistema é o que envelhece uma interface mais rápido.
17. **A parada do meio do gradiente em 55%, não 50%** — faz o roxo dominar a área útil.

## O que o modelo NÃO tem (e o APEX tem)

Modal, abas sublinhadas, checkbox/radio nativos, estado de erro de campo, alerta em faixa,
zebra em tabela. Onde o APEX precisa desses, derivar dos padrões acima em vez de importar de
outro sistema:

- **Modal:** raio 20–24, `--nc-sombra-alta`, scrim `rgba(27,18,56,.4)` — o APEX hoje não escurece
  o fundo, e esse é um defeito real observado ao vivo.
- **Erro de campo:** espelhar o padrão de sucesso com `--nc-ruim`: borda `--nc-ruim`, halo
  `rgba(184,50,63,.12)`, dica em `--nc-ruim`.
- **Abas (Region Display Selector):** usar o segmentado — `inline-flex`, fundo `--nc-off`, borda
  `--nc-linha`, raio 999, padding 3px; ativa em branco com `box-shadow:0 1px 2px rgba(27,18,56,.08)`.
