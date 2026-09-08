# Sonda 01 — validação da alavanca (06/09/2026, ambiente dev ao vivo)

Injetada via DevTools em `f?p=100:2` (Colaboradores, Interactive Report de 24 colunas).
Não é entrega: serve para medir o teto e descobrir onde a implementação vai doer.

## Medido

| | Antes | Depois |
| --- | --- | --- |
| Altura da linha do IR | 81 px | 43 px |
| Registros visíveis na viewport 1440x900 | 8 | 14 |
| Linhas de texto por célula | 3 a 4 | 1 (com reticências) |

## O que funcionou

- Uma única declaração de `font-family` em `body.t-PageBody` propagou Manrope para o tema inteiro.
- `.t-Region` como cartão matou a barra roxa vertical de todas as regiões de uma vez.
- Menu lateral no gradiente da marca, item ativo em pílula translúcida.
- `white-space:nowrap` + `text-overflow:ellipsis` nas células resolveu a densidade sem tocar em larguras.

## As três armadilhas que a sonda revelou

1. **Cabeçalho fixo do IR desalinha do corpo.** O relatório é montado em DUAS tabelas
   (`.t-fht-thead` e `.t-fht-tbody`), com larguras calculadas independentemente pelo widget de
   cabeçalho fixo. Qualquer `max-width` ou `width` aplicado às células desalinha as duas.
   Saída provável: agir só sobre altura, quebra de linha e tipografia — nunca sobre largura —
   ou forçar `table-layout` idêntico nas duas com a mesma base de cálculo.

2. **`.t-Button` genérico captura os botões do cabeçalho.** Manual, Blog, Notificações e o menu do
   usuário viraram pílulas brancas sobre fundo branco, sem contraste. Toda regra de botão precisa
   excluir `.t-Button--header` e os botões de ícone do topo.

3. **Hierarquia invertida nos filtros.** "Ver mais", que era um link discreto, virou botão em
   gradiente e passou a competir com "Pesquisar". Regras de botão por classe genérica não bastam:
   é preciso distinguir ação primária de ação de apoio pelo contexto (`:has()`, posição no
   contêiner, ou a variante real do tema).

## Pendências observadas

- A foto do colaborador não vem de `PROFILE.jpg`: é servida por
  `APPLICATION_PROCESS=GET_IMG_FUNC`. O seletor por `src` não pega; usar o contexto da célula.
- A primeira linha do corpo aparece cortada sob o cabeçalho fixo depois da mudança de altura.

---

# Decisões medidas na sonda (06/09/2026, ao vivo)

## 1. Divergência consciente do modelo de referência: contraste dos micro-rótulos

O `natcorp-app.html` usa `--muted: #8E88A3` nos cabeçalhos de tabela (`th`, 11px).
Medido sobre branco: **3,39:1**. WCAG AA exige 4,5:1 para texto pequeno.
**O modelo vinculante reprova neste ponto.**

| Cor | Contraste sobre #FFF | AA |
| --- | --- | --- |
| `#8E88A3` (modelo) | 3,39:1 | reprova |
| `#7B7593` | 4,37:1 | reprova |
| **`#6B6484`** (adotada) | **5,55:1** | passa |
| `#4A4460` | 9,18:1 | passa |

Adotado `--nc-rotulo: #6B6484` para todo micro-rótulo em caixa alta. O caráter discreto
vem do tamanho (11px), da caixa alta e da entreletras (+0.10em) — não de clarear a cor.
O operador varre esses rótulos a jornada inteira; é o lugar errado para economizar contraste.

## 2. O desalinhamento das colunas era artefato, não defeito

Medido antes de remedir: desvio de até **−110px** entre o clone do cabeçalho
(`.t-fht-thead`) e o corpo. Após forçar `resize`: **0px**.

Causa: o widget de cabeçalho fixo mede as colunas uma vez; a injeção de CSS pela
ferramenta acontece depois. Num carregamento real a folha entra antes da medição.

**Mas isso revela um risco de produção real:** a Manrope carrega assíncrona. Se a fonte
chegar depois da medição, as larguras mudam e o cabeçalho desalinha — e aí não há
`resize` para consertar. Mitigação na folha nova: `@font-face` com fallback de métrica
casada (`size-adjust`, `ascent-override`, `descent-override`) para que a troca de fonte
quase não altere largura de coluna.

## 3. Rótulo centralizado sobre dado à esquerda

Mesmo alinhados em pixel, o olho não liga rótulo à coluna quando um está centralizado e
o outro à esquerda. `th { text-align: left }` — regra do modelo, adotada.
Exceção: colunas de número e ação seguem à direita, junto com a célula correspondente.

## 4. Correção de um diagnóstico meu

Afirmei que o gradiente do menu criava regressão de contraste no rodapé.
Medido: branco sobre a ameixa `#9A408A` = **6,04:1** — passa em AA.
A queixa é estética, não de acessibilidade. A rampa foi mesmo ajustada
(`150deg`, terminando em `#6B2A7C`, 9,34:1), mas por densidade visual, não por norma.
