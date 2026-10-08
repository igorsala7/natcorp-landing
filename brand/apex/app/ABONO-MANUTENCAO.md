# Marcação - Abono (app 9503 / FREQ_LANC_NATCORP, página 714) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela que abre no toque de um horário da **Tratativa de Abono** (9503:203, dentro da 200:799,
aba Administração de Pessoal). O gestor pede o ajuste de UMA marcação de ponto do colaborador —
vira uma Requisição de Abono. Reclamação: "confuso e difícil de utilizar".

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Abono.css` | o desenho (gerado de `Natcorp_Abono.src.css` por `gerar-app.mjs`) |
| `Natcorp_Abono.js` | o comportamento (gerado por `gerar-abono.py`) |

**Instalar:** importe `f9503_page_714.sql`, já ajustado por `aplicar-abono-pagina714.py` (02/10). O script põe as URLs `#WORKSPACE_IMAGES#Natcorp_Abono.js` / `.css` e o comentário da página, acha a página pelos itens e roda de novo sem duplicar. Uma exportação nova da 714 se ajusta com `python3 aplicar-abono-pagina714.py f9503_page_714.sql`. O original fica em `f9503_page_714.ORIGINAL.sql`.

## O que muda — pedido novo

Uma coluna só (eram duas caixas lado a lado com 13 campos):

- **A marcação**: o dia por extenso ("terça-feira, 4 de março de 2025") com "Mudar o dia" (abre o
  campo Data da página); **Qual marcação?** em botões com nome — Posição 1/2/3/4… vira
  1ª entrada / 1ª saída / 2ª entrada… (ímpar = entrada, par = saída; ⌈n/2⌉ª); e o que o relógio
  registrou: "Previsto 09:00", "Bateu 09:00" ou "Não bateu nesta marcação".
- **O que aconteceu?** (só quando bateu) — três cartões:
  - *O horário está errado* → corrigir: `APAGAR_MARCACAO` e `ENVIAR_MARCACAO` vazios + horário;
  - *Essa marcação não devia existir* → `APAGAR_MARCACAO = S`;
  - *Bateu no lugar errado* → `APAGAR_MARCACAO = S` e DEPOIS `ENVIAR_MARCACAO = S` (a ação da
    página só habilita o Enviar com o Apagar marcado) + destino em botões (`POSICAO_ENV`).
  Sem marcação, não há pergunta: é **incluir**.
- **Qual o horário certo?** — `HORA_BATIDA_ABONO` com o **seletor de hora do aparelho**
  (`type="time"`, o relógio de ponteiros clockpicker sai — mesmo caminho da Hora Extra p716); tocar
  no campo ainda traz o previsto (ação da página no focusin); atalho **Usar o previsto (09:00)**;
  aviso quando o horário é igual ao que bateu.
- **Por quê?** — as justificativas em botões "código - descrição" (o "| Evento Apurado: 3 (Ponto) |
  Evento Abonado: 12 (Ponto)" fica só no title), numa caixa com altura e **busca** (31 na base de
  teste); escolhido, recolhe para o motivo + "Trocar o motivo". Dias de validade com rótulos
  claros ("Por quantos dias vale", "Vale a partir de", "Vale até"). Comentário "Quer explicar
  melhor? (se quiser)" com começos de frase; "Comprovante (se tiver)".
- **Pé**: a frase do pedido ("Corrigir a 1ª entrada: ~~09:00~~ → 08:12 · terça-feira, 04/03/2025 ·
  28 - Esquecimento De Marcação"), **Falta: …** (cada item leva à pergunta) ou "Tudo pronto", e
  **Enviar pedido** (é o botão Criar, com a ação de sempre). "Mapa" ganha a palavra "Ver no mapa".

## Pedido já feito (P714_COD_REQ preenchido)

Resumo em frase no alto: "Pedido 57658 · Concluída", "Corrigir a 1ª entrada: ~~09:01~~ → 08:00",
o dia, o motivo, o comentário e quem pediu. Os campos só de leitura (que repetem o resumo) ficam
atrás de **Ver todos os campos do pedido**; a caixa "O motivo" só aparece com eles abertos ou com
comprovante. Abas Dados/Aprovadores e "Cancelar Requisição" ficam como estão.

## Visto funcionando (01/10, abas de teste, nada enviado)

Incluir (01/03, 2ª entrada, "Não bateu"); corrigir (04/03, 1ª entrada, previsto 09:00 → 08:12,
motivo 28); mover (Apagar S → Enviar S → destino com 9 botões); consulta (pedido 57658).
Não visto: enviar de verdade, período fechado (regiões desabilitadas), marcação com "Vira Dia" e
plantão, e as justificativas que pedem abono obrigatório (alerta da página).

## Desligar

Tire as duas URLs de arquivo da página 714.

## 02/10: para o colaborador no celular (90%) e o gestor no computador (70%)

**Antes de tudo: o desenho não estava instalado.** Em 02/10 a janela aberta pela 203 ainda era a
original do APEX: as URLs desta página são postas à mão (não há exportação) e isso não tinha sido
feito.

O que mudou nesta rodada:
- **Celular: um passo por vez (`[J12]` / `[C12]`).** São 4 passos: 1 Qual batida? · 2 O que
  aconteceu? (ou "Que horas foi?") · 3 Por quê? · 4 Confira e envie.
  - Barra de progresso, título do passo e o resumo da batida escolhida ("terça, 04/03 · 1ª saída ·
    bateu 18:01 · Trocar").
  - Voltar e Continuar ficam presos embaixo da tela. "Continuar" diz o que falta em vez de
    ficar travado.
  - Aberta pela grade (com a batida já escolhida), a janela começa no passo 2.
  - Com erro do APEX na tela, os passos se desligam e tudo aparece de uma vez.
- **Computador: duas colunas** ("A marcação" | "Por quê?"). A rolagem caiu de 1.746 para 994 px.
- **Linha do tempo do dia (`[J11]`):**
  - a janela pergunta à Tratativa de Abono (`window.ncPontoDia`, em `Natcorp_Ponto.js`) como foi
    o dia, e "Qual batida?" mostra o horário de cada uma (09:00 · 18:01 · — · —);
  - aberta de outro lugar, mostra só os nomes, como antes.
- **Sugestão:**
  - **quando aparece:** o registrado fica 2 h ou mais longe do previsto e há, mais adiante (ou
    antes), uma batida do mesmo tipo vazia **dentro da jornada**;
  - **o que diz:** "Levar 18:01 para a 2ª saída";
  - **o que faz:** escolhe "mover" e o destino.
- **Destino do "mover":** primeiro as batidas da jornada. As outras (5ª, 6ª…) ficam atrás de
  "Outra batida".
- **Motivos:** os mais usados no ajuste do ponto primeiro (`COMUNS`, achados pelo nome:
  esquecimento, atestado, saída antecipada do almoço, saída antecipada, compensação, outros) e
  "Ver todos os 31 motivos".
- **Aviso da página em palavras simples (`AVISOS`):** "As posições subsequentes serão avançadas!"
  vira "As batidas seguintes vão ser empurradas para a frente." [Entendi]. Mesmo sentido.
- **Sem moldura sobrando:** MARCACAO › MNU › DAD somavam 70 px no alto. A grade da janela também
  passava 4 px de cada lado.
- **No CSS geral (`Natcorp_Paginas.src.css › [C20]`):** no celular, **toda janela do APEX ocupa a
  tela inteira**. Antes ela nascia com 70% da largura, e esta ficava com 303 px numa tela de 433.

Testado em 02/10 (abas de teste, nada enviado), com o dia 04/03:
- 1ª saída 18:01 (previsto 13:00): a sugestão foi "Levar 18:01 para a 2ª saída";
- motivo "28 - Esquecimento De Marcação", e a frase final "Levar 18:01 da 1ª saída para a 2ª
  saída · terça-feira, 04/03/2025 · 28 - Esquecimento De Marcação · Tudo pronto";
- nada passa da largura da tela; a barra fica na base (938/938);
- janela 433 × 938 no celular; duas colunas a 1060 px.

## 02/10 (2ª rodada): posição, não entrada/saída, e "Por quê?" enxuto

Pedido do usuário: "Não tratamos como entrada e saída, tratamos como posição 1, 2, 3, 4".
- **Posição em toda a janela:** `ordinal()` passou a dar "posição N" e `posicao()` dá "Posição N" nos
  botões. O mesmo vale na Tratativa de Abono (`Natcorp_Ponto.js`): o rótulo de cada marcação na lista
  e a frase dos pedidos ("Trocar a posição 1: 08:00 → 09:00", "Incluir na posição 3: 14:40").
- **"Bateu no lugar errado" virou "Bateu na posição errada"** (pedido do usuário), com "Levar para
  outra posição do dia".
- **"Por quê?":**
  - "Qual o motivo?" numa lista de uma coluna, com a bolinha de escolha;
  - os nomes com as preposições em minúscula ("28 - Esquecimento de Marcação");
  - "Outro motivo (procurar entre os 31)" no fim;
  - a validade, no caso comum, vira "Vale só para este dia (05/03/2025) · Mudar";
  - observação e comprovante ficam atrás de "Escrever uma observação" e "Anexar comprovante".
    Abrem sozinhos com conteúdo, quando a página exige ou quando há erro.

## 02/10 (3ª rodada): o pedido já feito, de relance, e a aba Aprovadores

- **Pedido já feito (`[J9]` / `[C14]`), de cima para baixo:**
  - **a situação** grande e colorida (✓ Concluída verde · ⏱ Em andamento âmbar · ✕ Cancelada/Reprovada
    vermelho; nomes em `NOME_SIT`), com "Pedido nº 57546 · aberto em 08/08/2025";
  - **o dia** por extenso;
  - **a mudança em "antes → depois"** com os horários grandes. Corrigir: ~~13:00~~ → 12:30. Incluir:
    "sem marcação" → 12:30. Apagar: ~~13:00~~ → "apagada". Mover: Posição 2 → Posição 4;
  - **os fatos em duas colunas:** Motivo, Pedido por e Empresa (código - descrição, do
    `P714_SOLICITANTE` "700 - Natcorp Do Brasil / 365785 - …") e "Concluída em";
  - **a faixa da aprovação:** "Aprovado por todos · 2 de 2 · Ver quem aprovou", que abre a aba.
- **Aba Aprovadores (`[J13]`):**
  - o relatório (APROVADOR, DATA, STATUS, JUSTIFICATIVA) vira um caminho vertical: sinal ✓ ✕ ⏱,
    nome, "Empresa 700 · matrícula 365785", situação, data e justificativa;
  - a aba ganha "2/2";
  - o relatório continua na página, escondido.
- **"Cancelar Requisição"** fica contornado em vermelho, sem o peso de botão principal. É o mesmo
  botão da página, com a mesma ação.

## 02/10 (4ª rodada): sem abas; motivo em destaque; os campos como ficha de leitura

A equipe tirou as abas: os aprovadores aparecem na mesma página, embaixo.
- **Faixa da aprovação:** "Ver quem aprovou" só aparece se a aba `#APRV` existir e estiver à vista.
  O caminho embaixo ganhou o título "Aprovação".
- **Motivo em destaque (`.nc-ab-motivo-dest`):** um bloco próprio logo depois da mudança, com o
  motivo grande e o comentário junto. Pedido por, Empresa e "Concluída em" ficam numa linha de três.
- **"Campos do pedido" (`.nc-ab-ficha` + `#JUST`), uma ficha de leitura:**
  - rótulo à esquerda, valor em texto forte à direita, linhas finas entre eles;
  - sem caixas, sem asterisco e sem "(Valor Necessário)";
  - caixa de marcar vira "Sim/Não", e campo vazio (o comprovante sem arquivo) não aparece;
  - no celular, o rótulo fica em cima do valor;
  - "Ver no mapa" fica na mesma linha de "Ver todos os campos do pedido".

## 02/10 (5ª rodada): "O que aconteceu?" sem instruções

A caixa de explicação da sugestão ("O relógio registrou… Se 18:01 é de outra hora do dia…") saiu:
confundia mais do que ajudava.
- **A linha de baixo de cada cartão mostra o EFEITO**, com o horário de verdade: "Trocar **18:01**
  pelo horário certo", "Apagar **18:01**", "Levar **18:01** para outra posição".
- **A sugestão fica dentro do cartão "Bateu na posição errada"**, com o selo "Sugestão" e
  "Levar 18:01 para a posição 4, que está vazia". O toque já escolhe mover e o destino
  (`B.sugAlvo` → `levarPara`). Em `desenharDica`.
- **No celular**, o resumo do alto do passo mostra também o previsto ("· previsto 13:00"), quando é
  diferente do que bateu.

## 02/10 (6ª rodada): aberta pela lista, a posição só é mostrada

Pedido: "quando é selecionada uma marcação, já é marcada qual é a posição; não deixe selecionar
outra, apenas demonstrar. Aberta sem esses parâmetros, permitir selecionar a data e a posição."
- **Como a janela sabe:** `B.fixo` é verdadeiro quando ela abre com `…_DATA` e `…_POSICAO` já
  preenchidos (os parâmetros do link da grade). É medido uma vez, ao abrir. Marca `body.nc-ab-fixo`.
- **Aberta pela lista (fixo):**
  - a linha do tempo só mostra: a posição escolhida em destaque, as outras esmaecidas e sem toque
    (`.nc-ab-pos--fixo`, `[C15]`);
  - o título vira "A posição";
  - somem "Mudar o dia" e o "Trocar" do celular;
  - no celular, o passo "Qual posição?" não existe: são 3 passos ("Passo 1 de 3 · O que
    aconteceu?"), com a barra de 3 partes.
- **Aberta sem eles:** escolhe-se o dia e a posição, com 4 passos, como antes.

## 02/10 (7ª rodada): a janela dentro do "Ajustar em sequência" — `[J15]` / `[C16]`

Quando a Tratativa de Abono (203) abre esta janela pela sequência (fila em
`sessionStorage['nc-po-fila']`, ver PONTO-MANUTENCAO.md), aparece no alto a faixa
**Ajuste em sequência · n de total** com **Pular este** e **Parar**.

- **Enviar pedido** (o botão Criar de sempre) marca `acao='enviando'` e guarda o motivo e a
  observação escolhidos; quem decide se deu certo é o fechamento da janela (sucesso) ou a
  volta com erro (o `enviando` é apagado ao montar).
- **No pedido seguinte**, o motivo do anterior vem **primeiro e marcado "Usado no
  anterior"**, mas **não selecionado**: precisa de um toque para confirmar (decisão do
  cliente). A observação é opcional: o link "Repetir a observação anterior “…”" a preenche.
- Fora da sequência (ou num pedido já feito), nada disso aparece.

## Regras da página (auditoria 04/10)

**Conferido** contra `f9503_page_714.ORIGINAL.sql`: 76 ações dinâmicas (130 ações), 14 validações,
27 processos, 10 botões, condições de exibição e só leitura dos itens. Não há processo `NC_…` nosso
(a exportação ajustada só acrescenta as URLs e o comentário). O desenho monta depois do "ready" do
APEX (as ações de abertura já rodaram) e as ações que travam por seletor (`#MARC`, `#JUST`, `#APRV`,
`#MARCACAO *`) continuam achando tudo: os campos movidos ficam dentro das mesmas regiões.

**Mudou:**
- `[C14]` a região Aprovadores escondia TUDO que não fosse o caminho — inclusive o item
  `P714_OBS_APROVADOR`, que o aprovador pendente edita. Agora só o relatório sai.
- `[C14]` a ficha "Campos do pedido" forçava `display: grid` e reacendia campos que a página esconde
  (Hide Fields, Hide Fields_1, Oculta horas abono): ganhou `:not([style*="none"])`.
- `[J8]` o cartão "Bateu na posição errada" some quando a página não desenha `ENVIAR_MARCACAO`
  (condição de servidor: perfil com `pe_perfil_abono_geral.bloqueia = 'S'` não pode mover).
- `[J7]`/`[J8]` "Usar o previsto" e o cartão "O horário está errado" respeitam o campo do horário
  desabilitado (Disable Page / `#MARCACAO *`): não escrevem em campo travado.

**Para decisão:**
- No celular, "Continuar" exige o horário em corrigir/incluir; a página não exige (há justificativa
  que vai sem horário — ver "Valida se precisa abono"). Mais rígido que a página.
- Aberta pela lista (`B.fixo`), dia e posição não podem ser trocados (pedido do cliente, 02/10); a
  página permite.
- Pedido já feito: os campos (inclusive os `_DSP`) ficam atrás de "Ver todos os campos do pedido" e
  a região "O motivo" só abre com eles. Nada ali grava (sem Criar/Salvar na consulta), mas é
  esconder item da página.
- Observação, comprovante e validade recolhidos atrás de um toque (abrem sozinhos com conteúdo,
  obrigatório ou erro na tela).

**Decidido (04/10, cliente):** o horário NÃO é obrigatório no celular — "Continuar" nunca bloqueia
(`seguir()`), quem valida é a página. A data da situação (`DT_SIT_REQ`) continua com a ação da página
"Set Dt_Sit_Req", que só muda quando a situação (`COD_SIT_REQ`) muda.
