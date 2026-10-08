# Requisição de Apuração (app 9503, página 181) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

A janela que abre em **Pedir ajuste** (a lupa da linha), na lista "O que o dia gerou" do painel
Horas do dia da **Tratativa de Abono** (9503:203). O gestor pede para TROCAR um evento que a apuração
gerou num dia (ex.: 05:30 de "28 - HE 100%") por outro (ex.: banco de horas). Reclamação: "confuso
e difícil de utilizar". (O balão da mesma linha abre a página 10, "Apuração - Justificativa":
justificar sem trocar — é o botão "Só justificar, sem trocar" desta janela.)

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Apuracao.css` | o desenho (gerado de `Natcorp_Apuracao.src.css` por `gerar-app.mjs`) |
| `Natcorp_Apuracao.js` | o comportamento (gerado por `gerar-apuracao.py`) |

**Instalar (à mão — não veio exportação da página):** página 181 › JavaScript › URLs de arquivo:
`#WORKSPACE_IMAGES#Natcorp_Apuracao.js`; CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Apuracao.css`.
Reconhece a janela por `…_COD_EVENTO_NOVO` + `…_QTD_HORAS_NOVO` + `…_TIPO_EVENTO_NOVO` (sem teste de
app/página). Nada é gravado: o desenho só usa `apex.item().setValue` (dispara as ações dinâmicas
como a digitação); as listas substituídas ficam na página, escondidas nas mesmas regiões.

## O que muda

Uma coluna, uma conversa (eram duas colunas: 8 campos só de leitura à esquerda, listas à direita):

- **Quem**: "205818 - Tony Oliveira · 700 - Natcorp do Brasil" numa linha (eram dois campos).
- **O evento deste dia** (cartão no lugar dos 8 campos): "28 - HE 100%", as horas grandes em verde
  (soma, Crédito) ou vermelho (desconta, Débito), "Ponto", o dia por extenso, "Apuração fechada";
  "Convertido em …" quando há Evento Conversão; aviso "01:00 deste evento já estão em outro pedido"
  quando Horas em Requisição > 0.
- **Vai para onde?** — cartões **Banco de horas** / **Ponto (folha)** (`TIPO_EVENTO_NOVO`).
- **De onde vêm as horas?** — "Deste dia" (Atual) / "Do saldo que sobrou" (Remanescente) (`ORIGEM`);
  o "Saldo que sobrou" aparece quando a página o mostra.
- **Qual evento?** — `COD_EVENTO_NOVO` em botões com busca (pelo nome ou número). A lista é em
  cascata do tipo (Banco = 4 eventos; Ponto = 43 na base de teste). Os que a empresa marcou
  "(não utilizar)" e os de teste ficam atrás de **Mais eventos**; o evento atual aparece apagado
  ("atual"). Escolhido, recolhe: o evento + "soma/desconta" + "Trocar o evento".
- **Quantas horas?** — `QTD_HORAS_NOVO` grande; digitar "0530" vira "05:30"; atalhos **Todas as
  horas (05:30)** e **Metade (02:45)**; aviso quando passa das horas do evento.
- **Observação** com começos de frase.
- **Pé**: "Trocar 05:30 de 28 - HE 100% por 6 - Banco Horas Crédito Plantão · Vai para o banco de
  horas · deste dia", **Falta: …** (leva à pergunta) ou "Tudo pronto"; **Enviar pedido** (é o
  "Criar Requisição"); "Apuração Justificativa" vira **Só justificar, sem trocar**. No celular,
  Enviar em cima, largura toda (os botões moram numa tabela antiga do tema).
- A aba única "Eventos" sai (`ul.t-Tabs` com um item; o `ul.apex-rds` envolve as regiões — não
  esconder o contêiner).

## A ordem das ações da página (respeitada)

Tipo → devolve Origem e saldo; Evento → devolve o tipo (C/D) e confere se é igual ao atual (alerta
e limpa); Horas → conferidas com o evento escolhido (formato, limite, maior que o atual: alertas e
algumas FECHAM a janela — comportamento da página).

## Visto funcionando (01/10, aba de teste, nada enviado)

13/03, "28 - HE 100%" 05:30: Banco → Deste dia → "6 - Banco Horas Crédito Plantão" (tipo C) →
Todas as horas 05:30 → "Tudo pronto". Ponto → 38 eventos + 5 "pouco usados ou de teste".
Não visto: enviar, Origem "Do saldo que sobrou" com saldo, período fechado.

## Desligar

Tire as duas URLs de arquivo da página 181.

## Regras da página (auditoria 04/10)

**Conferido** contra `f9503_page_181.ORIGINAL.sql`: 62 ações dinâmicas (107 ações), 11 validações,
21 processos, 11 botões, condições de exibição e só leitura. Não há processo `NC_…` nosso. O desenho
monta depois do "ready" do APEX; os campos movidos (horas, saldo) ficam dentro da mesma região
(`#MARCACAO *` continua travando tudo); nenhum botão da página some (só mudam rótulo e cor); o
"Saldo que sobrou" segue o mostrar/esconder da página (alt_P181_ORIGEM).

**Mudou:**
- `[J7]` o evento atual só fica apagado na lista quando o TIPO também é o mesmo — a página só recusa
  mesmo evento + mesmo tipo ("Valida se evento novo igual evento original"); antes recusava em
  qualquer tipo.
- `[J7]`/`[J5]` os atalhos "Todas as horas"/"Metade" não aparecem nem escrevem quando a página trava
  o campo das horas (Disable Page / `#MARCACAO *`).

**Para decisão:**
- As perguntas aparecem em sequência: Origem e Evento só depois do Tipo (a lista de eventos é em
  cascata do tipo), e **Quantas horas?** só depois do evento — a página mostra o campo das horas
  desde o início.
- Pedido existente: os campos do pedido (`_DSP`, Situação…) ficam atrás de "Ver todos os campos do
  pedido" (só leitura; o resumo mostra o mesmo).
