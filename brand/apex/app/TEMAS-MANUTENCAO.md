# Cores do sistema (o ícone de paleta do menu superior) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela que troca as cores do sistema. Pedido de 01/10/2026: a antiga (14 temas do time, que
mudavam variáveis que o desenho atual quase não usa) não funcionava; em vez de consertar, fazer
nova: **Padrão Natcorp** primeiro e 13 combinações que conversam com a marca — "um vermelho no
mesmo tom do círculo cromático do roxo".

| Arquivo | O quê |
| --- | --- |
| `gerar-temas.py` | a fonte: a lista de temas e o cálculo das cores; gera os dois abaixo |
| `Natcorp_Temas.src.css` | gerado — entra no `Natcorp_Style_Min.css` (folha geral, pelo `gerar-app.mjs`) |
| `Natcorp_Temas.janela.css` | o desenho da janela (o gerador junta ao .src.css) |
| `Natcorp_Temas.src.js` → `../login/Natcorp_Temas.js` | a janela e a aplicação do tema |

**Instalar:** subir `Natcorp_Style_Min.css` e `Natcorp_Temas.js`; na aplicação **casca** (a do menu
superior, 200) › Interface do Usuário › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Temas.js`.
As aplicações de conteúdo (9503 etc.) NÃO precisam do .js: o `Natcorp_Allow_Unload_Iframes.js` do
time (que elas já carregam) aplica o tema salvo e o repassa a todo iframe e janela.

## Como funciona (sem alterar o arquivo do time)

O ícone e a propagação são do `Natcorp_Allow_Unload_Iframes.js` — **não alterar**. Ele guarda a
escolha em `localStorage["nc_theme_choice"]`, põe `nc-theme-<id>` no `<html>` e repassa a classe a
todo iframe, a cada navegação. O `Natcorp_Temas.js`:
- pega o clique no ícone na **fase de captura** e abre a janela nova (a antiga nem abre);
- usa a **mesma chave e o mesmo formato de classe** — a propagação do time continua valendo;
- aplica na hora (sistema + iframes abertos), sem recarregar;
- zera escolhas dos temas antigos (lavanda, oceano…) para o Padrão. Os novos têm o prefixo
  `nc2-` porque as regras antigas (`html.nc-theme-oceano`…) continuam na parte da Skin.
- Padrão Natcorp = `purple` = sem classe (o que o sistema sempre foi).

## As cores

As quatro cores da marca formam um arco no círculo cromático, do escuro ao claro: Azul #2C1A63
(288°), Roxo #511C76 (307°), Ameixa #9A408A (335°), Rosa #C95788 (356°). Em **OKLCH** (claridade
como o olho percebe), cada tema gira o arco inteiro para outro lugar do círculo mantendo a
claridade e a saturação de cada cor; fora da faixa de cores da tela, só a saturação cede.
Resultado: o Rubi tem o peso do roxo, e o papel do rosa (a linha das regiões) vira um dourado
na mesma claridade do rosa. Texto branco sobre os botões e menus: 10,5 a 17:1 (o gerador recusa
abaixo de 4,5). Combinações da própria marca: Ameixa Natcorp, Noite Natcorp; neutro: Grafite & Rosa.

| Tema | Azul (fundo) | Roxo (botão) | Ameixa | Rosa (linha) |
| --- | --- | --- | --- | --- |
| Padrão Natcorp | #2C1A63 | #511C76 | #9A408A | #C95788 |
| Ameixa Natcorp | #511C76 | #742B7F | #9A408A | #C95788 |
| Noite Natcorp | #1E1049 | #2C1A63 | #511C76 | #C95788 |
| Fúcsia | #480A4B | #6C064D | #AD3950 | #D05B43 |
| Rubi | #55002E | #750023 | #AC4208 | #BE6F00 |
| Vermelho | #59000E | #770007 | #C11911 | **#FF0000** (pedido 01/10: tema a partir de #FF0000 — a cor exata no destaque; menus e botões no mesmo vermelho com a claridade da marca) |
| Terracota | #59000C | #692200 | #915A00 | #A18000 |
| Âmbar | #481E00 | #553400 | #776900 | #799000 |
| Oliva | #372A00 | #3E4000 | #307C19 | #009D68 |
| Esmeralda | #1D3300 | #004A1D | #007A68 | #00979C |
| Turquesa | #003522 | #00473F | #007684 | #0091C0 |
| Petróleo | #003431 | #00454D | #00719F | #4084DF |
| Oceano | #00323D | #00425F | #3963BE | #7C74DC |
| Anil | #002E50 | #183287 | #6F52B5 | #A664C4 |
| Grafite & Rosa | #2B2B34 | #3F3946 | #74626F | #C95788 |

## O painel animado do menu lateral nos temas

O SVG do painel (gerado pelo `../painel-natcorp.mjs`, o mesmo do Padrão) tem cinco cores
desenhadas dentro: #C95788, #E4A9C4, #F3C9DA, rgba(228,169,196,.75) e #511C76. O
`gerar-temas.py` põe o SVG UMA vez no `Natcorp_Temas.js` (animado + parado), com a troca dessas
cores para cada tema (a #F3C9DA gira pela mesma regra); o .js recolore e entrega ao CSS em
`--nc-t-painel` / `--nc-t-painel-parado` (no `<html>`). Por que no .js e não no CSS: o
`Natcorp_Style_Min.css` é servido sem compressão e sem cache (~970 KB por página) — 13 cópias
somariam ~250 KB; no .js é ~20 KB, uma vez. Sem o .js (uma tela que não o carrega), a camada
fica vazia e o resto do tema vale.

## O que muda com um tema

Menu superior e menu lateral (degradê Azul → Roxo, brilhos, o logo no pé e o **painel animado**
de pontos e losangos — o mesmo SVG do Padrão, recolorido para o tema), botões
principais (e texto/contorno dos secundários, que já usavam `--nc-roxo`), o ícone do topo das
regiões (`--nc-icone-fundo`) e a linha sob o título (`--nc-rosa`). Tudo o que usa as variáveis
`--nc-roxo/azul/rosa` (links, abas, chips das páginas) acompanha. Sombras e detalhes que têm o
roxo escrito por extenso (rgba(81, 28, 118…)) continuam roxos — são sutis.

Para mudar um tema: edite a lista em `gerar-temas.py` e rode `python3 gerar-temas.py` e depois
`node gerar-app.mjs` (ou deixe o `--watch` rodando).

## Cores e dispositivos no menu do usuário (01/10)

O ícone de cores e os três botões de visualização (celular, tablet, computador) que o código do
time põe na barra de cima saíram de lá e entraram no **menu do usuário** (o "365785"), entre
"Meus Contatos" e "Sair": ― **Cores** ― **Desktop · Tablet · Smartphone** (grupo de escolha única:
a bolinha mostra o modo atual) ―. O menu é o widget de menu do APEX — o do usuário é reconhecido por ter "Sair" (a barra pode ter outros, como o de Notificações): o `Natcorp_Temas.js`
acrescenta os itens pela API dele (`menu('option', 'items')`), uma vez, marcados com `ncTemas`.
Desktop/Tablet/Smartphone são o clique nos botões do time (que continuam na página, escondidos —
o time guarda e aplica a escolha como sempre); Cores abre a janela. A barra só esconde os botões
(classe `nc-tm-no-menu` no body) depois que o menu recebeu os itens: sem o .js, tudo fica como era.

## As páginas desenhadas também seguem o tema (01/10, `tematizar.py`)

Faixas, aberturas, ícones, bordas e sombras das páginas desenhadas (Ficha, Ponto, Movimentação…)
tinham as cores da marca escritas por extenso e ficavam roxas em qualquer tema ("o cabeçalho
está roxo, deveria estar respeitando o tema"). O `tematizar.py` trocou 375 delas, em 32 arquivos:
- as 4 da marca → `var(--nc-azul|roxo|ameixa|rosa, #cor)`; as transparências delas →
  `rgba(var(--nc-t-…-rgb, r, g, b), a)`;
- os OUTROS roxos e rosas saturados (#7A2E82, #A63F6E, os lavandas de borda…) → **cor relativa
  do CSS**: `oklch(from #7A2E82 l calc(c * var(--nc-t-croma, 1)) calc(h + var(--nc-t-giro, 0)))` —
  girados no círculo pelo mesmo ângulo do tema (`--nc-t-giro`, definido em cada tema pelo
  gerar-temas.py; o Grafite tira a saturação com `--nc-t-croma`). A declaração original fica
  antes, marcada `/*reserva*/`, para navegador sem cor relativa.
No Padrão nada muda (reserva = a mesma cor; giro 0). Ficam de fora comentários, url(…), definições
de variável, o texto quase preto (#1B1238) e as cores muito claras de fundo.

**Página nova desenhada: rode `python3 tematizar.py Natcorp_X.src.css`** (ou escreva já com as
variáveis). Rodar de novo não muda nada.

## Smartphone e Tablet: a página dentro de um aparelho de verdade (01/10)

A visualização do time encolhia a página com classes (`html.nc-preview-mobile`), mas o tema
APEX e as páginas desenhadas respondem à LARGURA REAL da tela (`@media (max-width: …)`), que
continuava 1440 px: a página ficava estreita com o desenho de computador ("a tela não está
responsiva de forma correta"). Agora, no menu do usuário, **Smartphone/Tablet abrem uma moldura
com a página num iframe de 390 × 844 / 820 × 1180** (reduzida com transform para caber — a largura
de dentro não muda): lá dentro tudo responde como no aparelho (medido: innerWidth 390,
max-width 640 verdadeiro, menu do APEX recolhido). Navegar funciona; a página de trás não
recarrega; **Voltar ao Desktop** (ou Esc) fecha. A visualização do time fica sempre em "desktop"
(o botão dele é clicado) — inclusive para quem tinha escolhido celular antes. Os aparelhos só
aparecem no menu da página de cima (não dentro da moldura) e em telas ≥ 900 px.

## Regras da página (auditoria 04/10)

Conferido: só troca classes de tema, abre a janela de cores e põe itens no menu do usuário; não intercepta
envio, diálogos do APEX nem o aviso de alterações não salvas. Nada mudou.
- **Para decisão**: o simulador Smartphone/Tablet carrega a MESMA página de novo (iframe com
  `location.href`), na mesma sessão: os processos de carregamento rodam outra vez (ex.: a Chamada de
  pacientes 2936:1 marca chamadas ao abrir) e o estado de sessão da página pode mudar.
