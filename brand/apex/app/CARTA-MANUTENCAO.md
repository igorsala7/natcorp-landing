# Carta de Apresentação — portal Conhecendo Você (app 600, página 14) — manutenção

> **Nunca mexeu em CSS ou JS?** Comece pelo [manual do desenho Natcorp no APEX](../MANUAL-APEX.md): ele explica tudo do zero e traz as receitas das mudanças mais comuns.

Uma caixa só (`…_DESC_QUALIFIC_FUNC`, até 2000 letras) que o colaborador ou o candidato escreve,
quase sempre no celular. O "Prosseguir" (request SAVE) é quem grava; a caixa não tem ação de
gravar ao mudar. Para quem só consulta, o "ready" trava a caixa.

| Arquivo | O quê |
| --- | --- |
| `Natcorp_Carta.css` | o desenho (gerado de `Natcorp_Carta.src.css` por `gerar-app.mjs`) |
| `Natcorp_Carta.js` | o comportamento (gerado por `gerar-carta.py`) |

Página 14 › JavaScript › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Carta.js`;
CSS › URLs de arquivo: `#WORKSPACE_IMAGES#Natcorp_Carta.css` (à mão — não veio exportação).
Reconhece a página pela caixa `…_DESC_QUALIFIC_FUNC` (sem teste de app/página).

## O que muda

- **"Conte um pouco sobre você"**: o que é a carta em uma frase ("quem você é, o que já fez e
  por que quer trabalhar aqui") e "não precisa ser perfeito".
- **Começos de frase** (pílulas): Quem eu sou · Onde já trabalhei · O que sei fazer · Como eu
  sou · Por que quero trabalhar aqui. O toque põe "Meu nome é …" no fim do texto (com ponto
  antes, se faltar) e deixa o cursor pronto; o começo já usado fica verde. É o único momento em
  que o desenho escreve na caixa (setValue — nada é gravado até o Continuar).
- **A caixa**: letra de 17 px, 8 linhas que crescem até 560 px, rótulo "Sua carta".
- **Quanto já tem**: uma linha que enche até ~180 letras e a frase "É um bom começo. Escreva
  mais umas frases" → "Está ótimo. Toque em Continuar para salvar"; "N de 2000 letras" (em
  vermelho perto do limite).
- **Embaixo da caixa**: a dica do **microfone do teclado** (falar em vez de digitar) e "Ver um
  exemplo de carta" (recolhido; o exemplo é só para ler, nunca entra na caixa).
- Travada: a carta aparece como leitura (ou "Ainda não tem carta de apresentação"), sem ajudas.
- "Prosseguir" vira **Continuar**; o "maximizar" da região sai.

## Não visto funcionando

O Continuar de verdade (gravar) — a sessão do RH traz a caixa travada; o teste foi com a caixa
liberada à mão numa aba de teste, fechada sem enviar.

## Desligar

Tire as duas URLs de arquivo da página.

## Regras da página (auditoria 04/10)

Conferido contra `f600.ORIGINAL.sql` (página 14): 2 ações dinâmicas ("Permite Alterar = 'N'"
desabilita `P14_DESC_QUALIFIC_FUNC` na abertura; "Hide Benefícios (SAVE8)" sem ação), 1 validação
("Valida DESC_QUALIFIC_FUNC", obrigatória quando a regra do currículo pede e `P_PERMITE_ALTERAR = 'S'`),
3 processos (Pintar Campos põe `is-required`; Fetch/Process Row de INF_FUNC_CANDIDATO), 6 botões
(foto/currículo com condição de servidor, Prosseguir e Voltar que submetem).

- Sem problemas. A caixa travada pela página vira leitura (o MutationObserver segue o `disabled`);
  os começos de frase gravam por `apex.item().setValue` e respeitam o limite; quem grava é o
  Prosseguir original (só o texto vira "Continuar"); a validação e o `is-required` não são tocados.
- Nada mudou no código.
