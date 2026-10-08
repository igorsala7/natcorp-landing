# Requisição de Indicação de Movimentação (app 2280, página 184) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A página aberta pela aba **Requisição de Indicação de Movimentação** do Painel do Operador (200:803
embute 2280:184; a lista é a 2280:183). O gestor indica que um colaborador mude de filial, cargo,
função ou local de trabalho; quem aprova autoriza. (Não confundir com a **Alteração Funcional**,
200:116, que é o `Natcorp_Movimentacao`.)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_IndMovimentacao.css` | o desenho (gerado de `Natcorp_IndMovimentacao.src.css` por `gerar-app.mjs`) |
| `Natcorp_IndMovimentacao.js` | o comportamento (gerado por `gerar-indmovimentacao.py`) |

App 2280 › Página 184 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_IndMovimentacao.js` (no
fim da lista); CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_IndMovimentacao.css`. Reconhece a página
pelos itens `…_COD_FILIAL_PROP`, `…_COD_CARGO_PROP` e `…_COD_FILIAL_ATUAL` (sem teste de app/página).
Já aplicado em `f2280_page_184.sql` por `aplicar-indmovimentacao.py` (original em
`f2280_page_184.ORIGINAL.sql`); numa exportação nova já aplicada, o script só troca o nosso trecho do
comentário (e preserva URLs e comentário que a página já tenha).
O stepper "Página única / Etapas" é do time (`Natcorp_Allow_Unload_Iframes.js`) e **não é alterado**.

## O que muda

- **Abertura** "Indicar a mudança de um colaborador" com o caminho: você indica → quem aprova
  autoriza → a mudança é feita no cadastro.
- **Passos numerados, como nas outras requisições**: 1 Quem vai mudar? · 2 O que muda? · 3 Por que
  mudar? (o título da região some; o passo diz o que é). Regiões do stepper sem nada à vista (a
  Identificação, que a página esconde no pedido novo) se recolhem e voltam se algo aparecer dentro.
- **"Matrícula" → "Colaborador"**; tocar na caixa de uma lista abre a lista.
- **O quadro Hoje → Vai para**: cada aspecto (Filial, Cargo, Função, Local de trabalho) vira um
  cartão com o nome e o ícone, "Hoje" (só leitura, calmo), a seta e "Vai para" (a lista). O selo diz
  **Muda** (cartão em roxo), **Continua igual** ou **Falta escolher**.
- **"Continua igual"** em cada cartão e **"Deixar igual o que não muda"** para todas as vazias: copia
  o código de hoje (que a própria página traz em `…_COD_*_ATUAL` quando se escolhe o colaborador) com
  `apex.item().setValue(código, texto)`. Quando o cartão muda, o botão vira **"Voltar ao de hoje"**.
- **Listas em cascata** (Função depende do Cargo; Local de trabalho depende da Filial — mudar o pai
  LIMPA o filho): o pai é posto antes do filho, esperando a página terminar; o filho só é copiado se o
  pai continua o mesmo ("Como o cargo muda, escolha a função do novo cargo."). "Voltar ao de hoje" num
  pai também repõe o filho. A lista da Função mostra "Nome (código)"; o texto copiado segue esse formato.
- **"Por que mudar?"** (a Observação) com começos de motivo que escrevem na caixa.
- **Barra no pé**: "Tony muda de cargo", o que falta (o toque abre a lista certa, também no modo
  Etapas) e **Enviar pedido** (clica o "Criar"). Se nada muda: "Nada muda: tudo está igual a hoje."
- **Pedido gravado (padrão das outras requisições)**: cabeçalho com nº, situação, o colaborador e cada
  mudança **de → para** (o de hoje riscado), o que continua igual, o motivo e quem pediu; **logo abaixo, a
  aprovação na largura toda** — a região Aprovadores sai da coluna estreita da direita (a coluna vazia
  some e a do cabeçalho vira largura toda), com o mesmo caminho do PPP/Hora Extra (passos ligados por
  fio, "Ver o caminho" no celular, Aprovar/Reprovar dentro só com etapa pendente). Em leitura, o stepper
  (Identificação, Colaborador, quadro) sai de vista: o cabeçalho já diz tudo o que ele dizia.

## Cores (pedido do usuário, 30/09)

Menos roxo na informação principal: o cabeçalho do pedido e a abertura do pedido novo são cartões
claros (borda leve, texto escuro). As mudanças de → para ficam em linhas de fundo suave, com o valor de
hoje riscado em cinza, a seta em roxo e o valor novo em escuro e negrito; a situação em etiqueta
colorida. O roxo fica nos detalhes (ícones, seta, selo "Muda" do quadro). Regras no fim do
`Natcorp_IndMovimentacao.src.css` ("tom claro"), no mesmo padrão da Requisição de Exames.

## Defeitos da página (não mexidos — são do APEX)

1. O link da lista 183 abre a 184 com `#COD_EMPRESA#,#REQUISICAO#,#MAT_SOLICITADO#,183` no fim do
   endereço (depois do `#`: textos de substituição não trocados). O tema do APEX tenta ler isso como
   seletor e dá erro no console ("Syntax error, unrecognized expression"). A página funciona, mas o
   link deveria ser revisto.
2. Os quatro "Proposto" são obrigatórios mesmo quando não mudam (o desenho resolve com "Continua igual").
3. Textos sem acento no banco ("Gerencia De Rh", "Supervisao", "Concluida") — o cabeçalho acentua.

## Não visto funcionando

- O **Enviar pedido** de verdade e as validações do servidor (nada foi enviado nos testes).
- A tela de quem aprova com etapa pendente.

## Desligar

Tire as duas URLs de arquivo da página 184 do app 2280.

## Regras da página (auditoria 04/10)

Conferido contra `f2280_page_184.ORIGINAL.sql`: 17 ações dinâmicas (22 ações), 3 validações, 10
processos, condições de itens/botões. Nenhum processo Ajax nosso (`NC_…`); "Enviar pedido" clica o
Criar original; "Continua igual" e os motivos gravam por `apex.item().setValue` (as cascatas rodam)
e respeitam lista travada/campo só leitura.

Corrigido:
- Em leitura (pedido gravado), o CSS escondia o stepper inteiro. Ele guarda a **Situação**
  (`P184_COD_SIT_REQ`, lista editável: "Cancelada" mostra o Salvar pela ação "Exibe botão SAVE", e o
  Salvar passa pela validação `valida_sit_requisicao`) e os botões de consulta do solicitante e do
  colaborador. Agora o stepper fica à vista (o cabeçalho continua em cima).

Para decisão: nada pendente desta página.
