# Tratativa de Abono — ponto eletrônico (app 9503, página 203) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Onde o gestor trata o ponto do colaborador (Administração de Pessoal › Frequência): confere os
dias do período, corrige/inclui marcações (a janela "Marcação - Abono", p714 do app
FREQ_LANC_NATCORP, abre no toque do horário e vira uma Requisição de Abono), vê a apuração do dia
(Diário) e do período, e trava. Reclamação: "confuso e difícil de usar". O desenho não grava nada.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Ponto.css` | o desenho (gerado de `Natcorp_Ponto.src.css` por `gerar-app.mjs`) |
| `Natcorp_Ponto.js` | o comportamento (gerado por `gerar-ponto.py`) |

Página 203 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Ponto.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Ponto.css`. Na exportação, `aplicar-ponto-pagina203.py`
põe as duas URLs e o comentário da página (01/10: a 203 tinha chegado com os arquivos do
`Natcorp_Abono` — que são da janela 714 — no lugar dos dela; o script tira os de janela).
Reconhece a página por `…_DIVERGENTE` + `…_DT_INI_A` e a região de id estático `marcacao`.

## O que muda (a região "marcacao")

- **A grade de 13 colunas vira um cartão por dia**: a data grande (11 · Ter · mar), a situação em
  palavra e cor e as marcações com nome — **Entrada / Saída / Entrada / Saída** — e "ajustada"
  quando o horário veio de uma requisição de abono (nº no link, `P714_COD_REQ`). Vaga vazia = "+".
  Só as vagas que importam aparecem (até a última usada + a próxima); o resto fica em "+ mais".
- **O toque no horário é o clique no botão da grade** (`a.click()` no link original): abre a mesma
  janela de ajuste, com a data e a posição certas (conferido: 11/03, posição 1). Ao fechar, a
  página atualiza a grade (apexafterclosedialog) e os cartões se refazem.
- **Filtros com contagem**: Com problema · Conferir · Certos · Folgas · Sem marcação · Todos
  (guardado por sessão) e **"Próximo problema"**, que rola até o próximo dia vermelho/amarelo e o
  acende. No computador os filtros grudam no alto da caixa da grade (que tem altura própria).
- **"Horas do dia"** (no celular, "Horas"): põe a data na lista "Data" do Diário — a página
  recarrega, como sempre fez com essa lista — e volta ao cartão daquele dia.
- **"Ver como tabela"**: a grade original de volta (e o cabeçalho fixo dela).
- Consultas e Relatórios (17 botões) ficam discretos (contorno), sem competir com a lista.

### As cores (lidas da própria grade)

| Na grade | No cartão |
| --- | --- |
| `t-Button--hot` (roxo) | marcação certa (com nº de requisição = "ajustada") |
| `t-Button--danger` (vermelho) | **Com problema** — divergência (ex.: 2 marcações numa jornada de 4, ou nenhuma) |
| `t-Button--warning` (amarelo) | **Conferir** — o sistema não diz o motivo (04/03: 09:00 / 18:01, sem requisição) |
| `t-Button--primary` "+" | vaga vazia |
| Dia com "Folga" | **Folga** |

## A página inteira — o painel do fechamento do mês

Além da grade, o .js reorganiza a página em volta de UM caminho (tudo por procuração: o botão do
desenho chama `.click()` no botão da página, que continua no DOM, escondido, com as suas ações
dinâmicas; o do desenho some/apaga junto com o original — `style` inline e `disabled`):

- **Faixa do colaborador** (no lugar das regiões "Consultas", "Colaborador" e "Relatórios"):
  foto, nome, matrícula, situação ("Ativo desde 02/03/2026"), admissão; **Trocar colaborador**
  (Selecionar Colaborador), **Ver colaborador** (o botão só de ícone), **Regras do sindicato**.
- **Período** com "‹ mês anterior / próximo mês ›": a data inicial entra sem disparar nada e a
  final dispara a ação da página (PL/SQL + envio) — as duas vão ao servidor, como quem digita.
  Tocar nas datas abre os campos `…_DT_INI`/`…_DT_FIM` da página (movidos para a faixa).
- **Consultas e relatórios**: um menu com os 11 botões das duas faixas (apagados quando a página
  os desliga — ex.: Escala de Trabalho e Reprocessar com a apuração travada).
- **Fechar o mês em 4 passos**: 1 Corrigir os dias ("13 dias precisam de correção" — vermelhos
  + amarelos — com "Ver os dias com problema", que filtra e rola; vira ✓ quando zera) · 2 Apurar
  (**Realizar apuração**) · 3 Conferir o resumo · 4 Travar (**Trava Apuração Período**).
- **Coluna da direita que acompanha a rolagem** (`rgnSticky`, agora "Apuração"):
  - **Horas do dia**: a data da lista `…_DATA` entre "‹ dia anterior / próximo dia ›" (mudar a
    data recarrega, como sempre); "Trava Apuracao Diario" vira **Travar este dia** (secundário).
  - **Resumo do período**: a tabela vira duas listas — **Somou** (horas trabalhadas, hora extra
    100%, adicional noturno 20%, banco de horas 50%) e **Descontou** (faltas, atrasos e saídas
    antes da hora, DSR descontado). Tocar num item é a lupa da linha ("Datas do Evento").
- **Pedidos do período em abas**: Abono · Hora extra · Apuração com a contagem de cada (as três
  regiões "Requisições de …" empilhadas viram uma de cada vez; aba lembrada na sessão).
- Barra da grade: **Incluir data** (Adic. Data), **Pedir hora extra** (Req. HE), **Lançar
  atestado** (Req. Atestado), em botões discretos; filtros "Marcações" e "Dias".

Os filtros da grade grudam logo abaixo do cabeçalho fixo do APEX (altura medida pelo .js em
`--nc-po-topo`); a coluna da direita estica até a linha (a `.row` vira flex) para ter onde grudar.

## 3ª rodada (01/10) — "extremamente confusa"

O que ainda confundia depois do painel: a barra da lista (2 listas + 7 botões soltos), 27 cartões
altos (3.400 px), o Diário em tabela técnica e os pedidos em grades de 15–17 colunas.

- **A barra da lista em duas linhas**: em cima os filtros com contagem e "Próximo problema";
  embaixo **Marcações** (a lista `…_OPCAO` da página, movida para lá, com as ações dela), **Lançar**
  (Incluir um dia · Pedir hora extra · Lançar atestado) e **Mais opções** (Calendário · Inversão ·
  Ver como tabela · Atualizar a lista) — menus com descrição, os itens são os botões da grade por
  procuração. A lista **Dias** (`…_DIVERGENTE`) sai: repetia os filtros; se ficou em "Apenas
  divergentes", aparece um aviso com "Mostrar todos os dias" (põe `N`). A barra da grade e a
  pesquisa da IRR somem na lista e voltam na vista de tabela.
- **Uma linha por dia** (era um cartão): data · situação · marcações · "Ver horas"; separada por
  **semana** ("Semana de 02/03 a 08/03"). À vista só as marcações feitas e as vagas que a grade pinta
  (vermelho/amarelo); as outras vagas vazias ficam atrás de **+ Incluir**. O dia aberto nas "Horas do
  dia" fica com contorno roxo e o botão **Horas ao lado** (no celular "Ver horas", que rola até o
  painel). Sem a faixa colorida lateral: a situação está no fundo da linha e na palavra.
- **Horas do dia**: o dia da semana embaixo da data; **Escala e jornada** numa frase quando a lista
  tem uma opção só (com mais de uma, a lista continua); a tabela do Diário vira **"O que o dia
  gerou"** — "3 - Falta · Desconta · Ponto · Aberto · 06:00" com **Pedir ajuste** (a lupa da linha:
  janela 181, Requisição de Apuração — trocar o evento) e **Justificar** (o balão: janela 10,
  Apuração - Justificativa — justificar sem trocar). Corrigido em 01/10: antes estavam trocados. "Travar este dia" no fim.
- **Pedidos do período**: cada pedido num cartão que diz o que foi pedido, lido pelos TÍTULOS das
  colunas (não pelos ids): Abono = "Trocar a 1ª entrada: ~~08:00~~ → 09:00" / "Incluir a 1ª saída:
  12:30" / "Apagar a 1ª entrada (20:56)" / "Mover … da 1ª entrada para a 2ª saída" (Posição n →
  ⌈n/2⌉ª entrada/saída); Apuração = "Trocar ~~3 - Falta (07:20)~~ por 11 - Banco de Débito 11
  (01:23)"; Hora extra = as horas. Situação em cor e palavra, "Pedido 57729 · aberto em … por …",
  comentário, cancelamento; **Abrir** = o lápis da linha. Filtro por situação (Todos · Em andamento ·
  Concluídos · Cancelados); as datas de cada região atrás de **Mudar datas**; **Ver tabela
  completa** devolve a IRR (filtros, Ações, baixar) e fica lembrada na sessão. Empresa, Matrícula
  e Empresa Solicitante (iguais em todas as linhas) não aparecem.

## Cuidados

- A região `marcacao` tem `height:650px; overflow:auto` inline: na vista de cartões a altura sai
  e a grade rola com a página. O tema e a IRR põem overflow hidden no corpo (.t-Body…,
  .container, .a-IRR…), o que impede o "grudar": viram `overflow: clip`.
- O `Natcorp_Allow_Unload_Iframes.js` pendura um clone do cabeçalho da tabela no `body`
  (`.nc-sticky-header-clone`, guardado em `$(região).data('ncStickyClone')`): o .js o marca e ele
  some na vista de cartões.
- Datas que não viram linha (26, 27, 29, 30/03 no exemplo) não aparecem — é o relatório.

## Não visto funcionando

Salvar um ajuste pela janela (não foi preenchido nada) e os tipos de marcação além de "Final"
(Original, Abonado, Todos… — o cartão mostra o tipo quando não é "Final").

## Desligar

Tire as duas URLs de arquivo da página.

## Região nova "Saldo de Banco de Horas" (exportação de 02/10)

A exportação de 02/10 (por BRUNO.SOUSA) trouxe uma região nova, seq. 72, numa linha própria abaixo
da lista de marcações e acima dos pedidos. Ela tem:
- o período: `P203_DT_INI_TOT` e `P203_DT_FIM_TOT`;
- os saldos: `P203_SALDO_BH_REMANESCENTE`, `_ANTERIOR`, `_PERIODO` e `P203_SALDO_ATUAL`;
- o botão `REFRESH_TOTAIS`;
- 4 ações dinâmicas. Mudar uma data ou clicar no botão executa um PL/SQL de `pkg_espelho_ponto`.
  A região aparece só com `P203_EXIBE_TOTAIS` = S.

O `Natcorp_Ponto.js` **ainda não integra** essa região. Ela não é escondida nem quebrada: aparece
com o visual geral do sistema, com os rótulos e o botão como estão no APEX ("Refresh Totais").
Integrá-la ao desenho (num cartão "Banco de horas", em palavras simples) é um passo à parte, que
depende de confirmar com o negócio o que cada saldo significa.

## A mesa de trabalho (02/10): a lista e o dia lado a lado

O pedido foi que a página fosse reorganizada: a esquerda (o dia que se trata) e a direita (o resultado)
são correlacionadas, mas a rolagem não era intuitiva. Medido antes:
- **Rolagem:** a página tinha 4.758 px e rolava inteira. A lista rolava com ela, e a direita tinha
  rolagem própria (1.289 px dentro de 616), com o fim abaixo da tela.
- **Recarregamento:** cada "Ver horas" é um **Submit Page** (ação "Data - Refresh") e a página pulava.
- **Pedidos:** os de cada dia ficavam 2.000 px abaixo do dia.

O que mudou (`Natcorp_Ponto.src.js › [J12]`, `.src.css › [C12]`):
- **A mesa (tela ≥ 1101 × 600 px):**
  - `#marcacao` e `#rgnSticky` ficam com a altura da tela, cada um com rolagem própria.
  - A roda do mouse sobre a mesa primeiro encaixa a mesa no alto, depois rola a coluna. No fim da
    coluna, a página continua.
- **Volta do "Ver horas" e das setas ‹ ›:** a mesa encaixa, a lista volta exatamente onde estava
  (`sessionStorage nc-po-lista-topo`) e a direita abre na aba do dia.
- **Direita em abas:** "Sáb, 01/03" (horas do dia + **pedidos deste dia**) | "Resumo do período"
  (resumo + **banco de horas**). Não há mais moldura dentro de moldura.
- **Linha do dia:** diz "N pedidos".
- **Banco de horas:** a região nova vai para a aba do resumo, como conta: anterior + período = atual
  (os sinais só aparecem quando a conta fecha). O remanescente vem embaixo.
- **Respiro e título:**
  - a lista e a barra dos pedidos ganharam espaço interno;
  - a barra do título ficou sólida (era vidro, e o conteúdo aparecia borrado por trás);
  - a escala passou a ser escrita "às" e "e" em minúsculas.
- **Telas médias (641 a 1100 px):** a lista e o painel ficam um embaixo do outro. No celular, nada
  muda além disso.

Testado em 02/10 numa aba nova, com os arquivos locais:
- encaixe da mesa em 137 px (alvo 136);
- lista em 900 px antes e depois do "Ver horas";
- dia 12/03 aberto, com 2 pedidos;
- 820 px empilhado, sem rolagem horizontal em 820 nem em 390.

**O que só o APEX resolve:** escolher um dia recarrega a página inteira. Trocar o "Submit Page" da
ação "Data - Refresh" por um refresh das regiões "Diário" e "Período" (com `P203_DATA` em "Items to
Submit") tornaria a troca de dia instantânea. Antes, é preciso conferir que nenhum cálculo da página
depende do recarregamento.

## A linha compacta do gestor (02/10)

Pedido: "caber na mesma linha 4 posições + 1 (Incluir)… ver o máximo de linhas sem scroll: o gestor
faz cerca de 300 ajustes em 2 dias". Medido no quadro de 1272 × 683 px:
- **Antes:** as marcações tinham 227 px de largura (cabiam 2 por linha). Cada dia ocupava de 111 a
  212 px, e cabiam 2 a 3 dias na tela.
- **Depois (`[C13]`, a partir de 901 px de largura):** cada dia ocupa de 48 a 54 px, e cabem 6 dias
  e meio na tela.
  - **Linha do dia:** grade 44 px (data) · 96 px (situação + selo "N pedidos") · marcações numa
    linha só · relógio.
  - **Marcações:** 36 px de altura, com "Posição N" em 10,5 px e o horário em 15 px.
  - **"Ver horas":** só o ícone, com a dica em `title`.
  - **Legenda:** sai no computador.
  - **Barra de filtros:** 34 px de altura.
  - **Mesa:** a lista fica com 55% e o painel com 45%.
  - **Dia com 6 ou mais marcações** (raro): quebra em duas linhas, para não cobrir o relógio.
- **Celular e tablet:** sem mudança.

## Ajustar em sequência (02/10) — `[J14]` no .js, `[C14]` no .css

Para o gestor que faz centenas de ajustes: o botão roxo **Ajustar em sequência N**, ao lado
de "Próximo problema", abre a janela da Marcação - Abono no 1º horário com problema e, a cada
pedido criado, já abre o próximo (todos os dias *com problema* ou *conferir*, em ordem, só as
posições em vermelho/amarelo).

- **Nada novo no servidor.** Cada passo é um pedido normal, com motivo, observação e anexo;
  a janela abre pelo mesmo clique que o gestor daria na posição.
- **Onde fica a fila:** `sessionStorage['nc-po-fila']` (da aba; a janela, que é outro frame,
  lê a mesma). Campos: `ativo`, `atual` (`dd/mm/aaaa#k`), `n`, `total`, `feitos`, `pulados`,
  `motivo`, `comentario`, `acao`, `pausada`, `fim`.
- **Como a tela sabe o que aconteceu** quando a janela fecha (`dialogclose`), pelo `acao` que a
  janela deixou: `enviando` → conta como enviado e abre o próximo (depois de a grade
  recarregar); `pular` → pula; `parar` → encerra; nada → fechou no X: a fila **pausa**
  (faixa amarela com Continuar / Parar).
- **Se o envio deu erro**, a janela recarrega com a mensagem do APEX e apaga o `enviando`:
  o gestor corrige ali mesmo, e a fila não avança por engano.
- Recarregar a página no meio da fila deixa a fila **pausada** (não reabre sozinha).
- **Desligar só a sequência:** apague a linha `desenharFila();` dentro de `desenhar()` — o
  botão some e o resto continua igual.

Testado (02/10, aba de teste, nada enviado): começa em "1 de 44"; Pular → "2 de 44"; envio
simulado → "3 de 44", 1 enviado; erro simulado apaga o recado; X → pausada; Continuar reabre
no mesmo item; Parar limpa tudo.

## Regras da página (auditoria 04/10)

**Conferido** contra `f9503_page_203.ORIGINAL.sql` (01/10): 44 ações dinâmicas (75 passos), 0 validações,
8 processos, 32 botões, 49 itens, condições de região/botão/coluna. Também a exportação aplicada (02/10,
outra base): mais 4 ações (Saldo de Banco de Horas, "Exibe totais" mostra/esconde a região na abertura).
Não há processo `NC_…`: o desenho não grava nada. Ações de abertura ("Trava Apuração" apaga Escala de
Trabalho / Escala de Folga / Reprocessar; "Exibe totais"): os botões por procuração seguem o `disabled`
e o `style` (observador), e a caixa do saldo fica dentro da região que a ação esconde.

**Mudou:**
- **"Dias" (`…_DIVERGENTE`) volta à vista**, na barra ao lado de "Marcações". Era item da página
  (envia a página ao mudar; a ação "Seta Divergente" o reescreve) e estava escondido.
- **Mês anterior / próximo** agora também põe `…_DT_INI_PERIODO` = `…_DT_INI`, que é o que a ação
  "Valida Datas" faz. O desenho não dispara essa ação (evita enviar a página duas vezes), e o resumo
  do período ficava com o início antigo.
- **"Pedir ajuste" nas Horas do dia** usa a lupa que a página mostrar: `DERIVED$02` (janela 181,
  com `P203_USE_REQ` = S) ou `DERIVED$01` (janela 214, com N). Antes, quem não usa requisição ficava sem a lupa.
- **A empresa** (`…_COD_EMPRESA`, do cartão "Colaborador", que o desenho esconde) aparece na faixa.
- CSS: a regra que põe `display:flex` nos campos da barra não vence mais o `display:none` da página.

**Para decidir:**
- **Atualizar:** o botão do Diário (`REFRESH_DIARIO`) fica escondido sempre, e o do Período
  (`REFRESH_PERIODOD`, envia a página) fica escondido na mesa. Só atualizam; a página recarrega ao trocar o dia.
- **Campos escondidos, com o valor mostrado de outro jeito:** Escala/Jornada (só com uma opção, viram
  frase) e os 4 saldos do banco de horas. Os saldos são campos de texto editáveis na página. Confirmar
  se alguém digita neles.
- "Pedir ajuste" diz "Requisição de Apuração" mesmo quando abre a 214.

**Decidido depois (04/10):** o resumo do período mostra TODAS as lupas da linha. O toque no evento
abre a janela 11 (os dias em que ele aconteceu); as janelas 215 e 183, quando a página as mostra
(`P203_USE_REQ` / `P203_USE_REQ_PERIODO`), viram botões ao lado com o título que a própria página dá
à janela (`rotuloJanela`). Os dois quadros, Horas do dia e Resumo do período, são preenchidos pela
página ao abrir; nenhum depende de clicar numa linha.
