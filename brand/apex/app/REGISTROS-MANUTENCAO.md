# Registros em cartões (Tabela · Cartões) — guia de manutenção

Vale para o **sistema todo**: todo Interactive Report e todo Classic Report de tabela ganham, no
alto, o seletor **Tabela · Cartões**. No **celular sempre abre em Cartões** (quem passa para
Tabela, vale até fechar o navegador); no computador abre em Tabela e a escolha fica guardada.
As duas escolhas não se misturam. "Celular" = a largura da página até 768px — o "Smartphone"
do menu do usuário conta; uma janela modal de 720px no computador não (vale a da página de trás).

## Arrastar para rolar

Em todo Interactive Report, Classic Report, **Interactive Grid** e no **Gantt da Linha do Tempo**
(108 e 121): com barra de rolagem, clicar e arrastar com o mouse move o conteúdo (cursor de
mãozinha). Só com mouse (no celular o dedo já rola); começa depois de 6px, então o clique normal
continua abrindo links e tocando barras; soltar depois de arrastar não clica; não começa em campo
nem em botão (no Gantt, sim). Vale em todas as páginas, até nas de desenho próprio. `[R9]` do
`.src.js` (listas `ONDE`, `NAO_COMECA`, `LIMIAR`, `EMBALO`); visual em `[C5]` do `.src.css`.

## A rolagem não trava ao passar de uma região para outra (13/10)

Relato: "o scroll para de funcionar quando sai de uma região e vai para outra enquanto continua
o scroll; precisa clicar onde parou" — no **sistema inteiro**. Três correções, todas neste arquivo
(que roda na casca, em cada iframe e em cada janela, então valem em toda página de todo app):

1. **Arrasto preso** (`[R9]`): se o botão era solto sobre outra moldura ou fora da janela, o
   arrasto ficava ligado e cada movimento do mouse puxava a página de volta, até um clique.
   Agora mexer sem o botão apertado encerra o arrasto.
2. **Trackpad sobre tabela larga** (`[R9]`): gesto mais vertical que lateral rola a página, não
   fica preso na tabela que só anda para os lados (nem no cabeçalho fixo do relatório).
3. **A rolagem segue o mouse** (`[R10]`): o navegador prende o gesto (trackpad, embalo da
   rodinha) em quem começou a rolar — o menu lateral, uma lista, a página da moldura. Se o mouse
   passa para outra região e o primeiro já está no fim (ou nem rola, como a faixa do alto), a
   rolagem passa para quem está debaixo do mouse, inclusive em outra moldura. Quando o navegador
   consegue rolar, ele rola (o ouvinte é passivo e não faz nada); gaveta e janela com
   `overscroll-behavior: contain` continuam segurando.

Teste: na casca, role o menu lateral até o fim e, sem tirar os dedos do trackpad, leve o mouse
para a página — ela deve rolar. A simulação automática não reproduz o "gesto preso" do trackpad
(o Playwright manda cada rodinha como um gesto novo); a lógica foi testada com eventos montados.

## Tela cheia nos resumos (13/10)

Todo painel de resumo (`section.nc-af`: Quadro 16, Folha 21, Afastamentos 25, Férias 26, Benefícios
164, Acidentes 150 — e qualquer painel novo com a mesma roupa) ganha no título o botão **Tela cheia**
(`[R11]` do `.src.js`). Ele abre a análise completa, leva o painel para a tela inteira e vira **Sair
da tela cheia**; Esc também sai, e o painel volta para o lugar e para o estado de antes (fechado, se
estava). É dentro da página, como o "maximizar" do Interactive Report (cobre o body; na casca, a
área da moldura) — não usa a tela cheia do navegador. Aparência: `[A12]` do
`Natcorp_Afastamentos.src.css`. Painel novo: manter `.nc-af > .nc-af-cab` e o botão de abrir/fechar
com `aria-controls="…-corpo"`.

Painel DENTRO de um Interactive Report maximizado (9181:50): o maximizar deixa o body com
`visibility: hidden`, então o envelope `.nc-af-tela` declara `visibility: visible` (senão herdava e só a
tabela aparecia); e o Esc é tratado no próprio envelope, antes do documento, onde o IR também escuta o
Esc para restaurar a tabela (corrigido 13/10).

## A barra do título encolhe ao rolar (13/10)

Depois de 72 px de rolagem o body ganha `nc-bc-compacto` (`[R12]` do `.src.js`; CSS no
`Natcorp_Paginas.src.css`, "A BARRA ENCOLHE DE VERDADE"). Com a Trilha no alto, o breadcrumb some
(o nome da página já está na Trilha): a barra vai de 126 para 54 px. Sem a Trilha ou com botões na
barra, a faixa fica em uma linha (40–44 px). A coluna da esquerda e os cabeçalhos grudados das tabelas
sobem junto (o `apexwindowresized` do tema), e o espaço do conteúdo (`#t_Body_content_offset`) fica
sempre na medida da barra CHEIA: nada pula, e a página recarregada já rolada não fica com a barra
cobrindo o 1º cartão. Conferido na 200:150: rolado = barra 54, filtros e cabeçalho da tabela a 102/101,
espaço 174; de volta ao topo = 126/174.
CUIDADO: a marca da janela é `window.__ncBarraTitulo` — `__ncBarra` já é usada pelo iframe_handling.js da equipe.

## Como chega a todas as páginas (sem URL em página nenhuma)

| Peça | Onde está | Como chega |
|---|---|---|
| o CSS | dentro do `Natcorp_Style_Min.css` | o `gerar-app.mjs` junta o `Natcorp_Registros.src.css` (lista `FOLHAS`) |
| `Natcorp_Registros.js` | Workspace Images | o `Natcorp_Temas.js` (aplicação casca, 200) o traz da mesma pasta — `[J0]`, lista `PECAS` |
| nas outras aplicações | iframes e janelas modais | o próprio `Natcorp_Registros.js` se põe em cada iframe do mesmo endereço (`[R7]`) |

**Aplicação aberta fora da casca** (endereço direto, outra aba): ponha uma vez na aplicação
› Componentes Compartilhados › Atributos da Interface do Usuário › JavaScript › URLs de Arquivo:
`#WORKSPACE_IMAGES#Natcorp_Registros.js`. Ele não carrega duas vezes.

## Quem fica de fora (de propósito)

- **Páginas de desenho próprio** — as que carregam um `Natcorp_<Página>.js` (Férias, Ponto,
  Linha do Tempo…): o relatório delas já foi pensado. Para incluir uma região: classe `nc-reg-sim`.
- **Relatório com campo** (digitar ou escolher nas linhas): ficaria com valor em dobro ao enviar.
- **Relatório pequeno** — até 3 colunas de dados e cabendo na largura.
- **Classic Report que não é tabela** (modelos Cards, Badge List, Value Attribute Pairs…).
- Qualquer região com a classe `nc-reg-nao`.

## O que o cartão mostra — a ordem das colunas do relatório (02/10)

O que o relatório mostra primeiro, o cartão mostra primeiro; mudou a ordem das colunas (Ações ›
Colunas), o cartão muda junto (`[R2]` do `.src.js`):

- **título** = a primeira coluna de dados; valor curto com número vira "Requisição 4512";
- **selo** = a coluna Situação/Status, onde estiver, colorida pelo texto (ativo/aprovado/concluído
  verde; afastado/pendente âmbar; reprovado vermelho; desligado/cancelado cinza);
- **à vista** = as 4 colunas seguintes, na ordem; o resto em "Mais N dados · M em branco";
- **lista de pessoas** (coluna Colaborador/Nome/Funcionário/Candidato): a pessoa é o título, com
  a foto, e o Cargo embaixo. **Solicitante, Requisitante, Aprovador e Gestor não contam**: numa
  requisição, o assunto é a requisição (pedido do usuário, 02/10);
- tocar no cartão = o link da linha (a lupa), que cobre o cartão.

## Situações comuns

- **Um relatório devia ter cartões e não tem:** a página carrega um `Natcorp_X.js` próprio
  (classe `nc-reg-sim` na região), ou tem campo nas linhas, ou só 3 colunas.
- **Criei um `Natcorp_X.js` que vale para o sistema todo:** ponha o nome em `GLOBAIS` (`[R1]`),
  senão toda página com ele vira "de desenho próprio".
- **Mudar a cor de uma situação:** `[R2]`, lista `TONS`.

## Gerar e subir

```sh
python3 brand/apex/app/gerar-registros.py     # → brand/apex/login/Natcorp_Registros.js
python3 brand/apex/app/gerar-temas.py         # → brand/apex/login/Natcorp_Temas.js (com o [J0])
node brand/apex/app/gerar-app.mjs             # → Natcorp_Style_Min.css (com o CSS dos cartões)
```

Sobem: `Natcorp_Registros.js`, `Natcorp_Temas.js` e `Natcorp_Style_Min.css`.

## Escolher os campos do cartão: o relatório salvo "Cartões" (02/10)

Em qualquer **Interactive Report**, quem monta a página escolhe exatamente o que vai no cartão, sem
código:

1. Na página, no relatório: **Ações › Colunas** — marque só os campos do cartão, na ordem em que
   devem aparecer (a 1ª coluna é o título; a coluna Situação vira o selo colorido).
2. **Ações › Relatório › Salvar Relatório** com o nome **Cartões** (o mesmo nome do botão) — como **alternativo** (salvando
   como desenvolvedor) ou **público**, para valer para todos. Privado só vale para quem salvou.

Daí em diante: **Cartões** abre o relatório "Cartões" (o APEX redesenha com aquelas colunas) e todos
os campos ficam à vista (até 12; o resto em "Mais dados"); **Tabela** volta para o relatório que
estava aberto — ou para o padrão (o Primário), se a página já abriu no "Cartões", que o APEX lembra
da sessão. Sem relatório "Cartões", tudo como antes. O nome vale sem acento, maiúscula ou número
("3. Cartões", "Cartoes"; o singular "Cartão" também é aceito). `[R6b]` do `.src.js`.

Interactive Grid ainda não tem o seletor Tabela · Cartões (só o arrastar para rolar).

## 04/10 — o toque no cartão aciona o link ORIGINAL

- O título do cartão é uma cópia do link da linha (endereço, para Ctrl/Cmd+clique abrir em nova
  aba), ligada ao original por `data-nc-reg-para` ↔ `data-nc-reg-id`. O toque (cartão ou título)
  chama `original.click()` na tabela escondida: vem junto o que a página prendeu no link (ação
  dinâmica, jQuery, onclick), que a cópia sozinha não trazia — era por isso que alguns cartões
  "não faziam nada".
- A coluna da ação (a lupa) é procurada nas 12 primeiras linhas e aceita link só com ícone
  (img, svg, fonte de ícone, texto só para leitor de tela) — `soIcone`.
- **GLOBAIS** passou a ter Trilha, Editor e Lov. Sem eles, desde 03/10 toda página que os
  carrega era tratada como "de desenho próprio" e ficava SEM Cartões. Regra: script novo na
  lista PECAS do Natcorp_Temas.js = nome novo em GLOBAIS.
- Testado na 200:2: 25 cartões, toque no corpo e no título acionam o link da coluna LINK;
  Ctrl+clique não aciona o original.

## Regras da página (auditoria 04/10)

Conferido contra o comportamento do IR/CR do APEX 19.2: o toque no cartão clica o link ORIGINAL da
linha (traz a ação dinâmica/jQuery dele); paginação, filtros e Ações continuam os do APEX; relatório com
campo nas linhas fica de fora; o CSS só mostra/esconde os nossos elementos.
- **Mudou**: link/botão de DENTRO de uma célula (ex.: o nome que abre a ficha) também aciona o original
  da tabela (antes era a cópia, sem o que a página prendeu nele por jQuery/ação dinâmica de escopo
  estático); a cópia fica sem `onclick` para não rodar duas vezes. Botões de célula ficam por cima do
  link esticado do cartão.
- **Para decisão**: (1) relatório cuja ação é o CLIQUE NA LINHA (ação dinâmica em `tr`/`td`, sem link)
  não tem equivalente no cartão; (2) com coluna Link, o link da célula do TÍTULO vira texto no cartão
  (continua na Tabela).
