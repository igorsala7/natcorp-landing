# Figuras dos portais

Cada cartão de portal aceita **duas** pessoas: a principal e a dupla. Os seis
cartões têm as duas — nada falta gerar.

## Requisitos da arte

- Corpo inteiro, de pé, vista frontal levemente de três quartos
- **Fundo transparente** (WebP), sem chão, sem sombra projetada
- Mesmo tratamento das atuais: 3D estilizado de estúdio, cabeça levemente
  maior que o natural, sombreado suave, luz difusa de cima e da frente
- ~700 px de altura, para render nítido em 168 px

## Como ligar

Em `src/pages/PortalHubPage.tsx`, no mapa `figures`, acrescente `dupla` ao
portal correspondente:

```ts
colaborador: {
  principal: { src: figureColaborador, alt: '…' },
  dupla: { src: figureColaboradorDupla, alt: 'Colaboradora de camiseta lilás, com o celular na mão' },
},
```

O cartão passa sozinho de uma figura centralizada para duas lado a lado: a
principal desloca para `left-[62%]` e a dupla entra em `left-[38%]`, menor e um
pouco mais abaixo, para dar profundidade.

## Feito em 08/09/2026 — as três duplas

Geradas no ElevenLabs (`gemini-3-pro-image`), usando `figure-marcos.webp` como
referência de ESTILO (não de personagem), com `aspect_ratio: 9:16` e
`resolution: 2K`:

| arquivo | personagem |
| --- | --- |
| `figure-colaborador-dupla.webp` | moça de 20 anos, cabelo castanho com mecha azul, camiseta lilás, celular na mão |
| `figure-gestor-dupla.webp` | mulher de 50 anos, morena clara, blazer rosa e camisa roxa, cabelo ondulado na altura do pescoço |
| `figure-operador-dupla.webp` | homem japonês de 35 anos, polo roxa com o losango da Natcorp no peito |

**O `aspect_ratio` do modelo é 16:9 por padrão.** Sem passar `9:16` o
personagem sai deitado e minúsculo dentro do quadro — foi o que aconteceu na
primeira tentativa. E o modelo não entrega alfa de verdade: se o prompt pedir
"fundo transparente" ele DESENHA o xadrez. Peça fundo branco liso e recorte
depois com `recorta.py` (preenchimento a partir das bordas, para não comer
tênis branco), exportando em 360px de largura como as figuras antigas.

## Como calcular `larg` e `esq` ao trocar uma figura

Não calcule à mão:

```
python3 scripts/medir-figuras.py figure-chamado.webp figure-chamado-dupla.webp
```

Ele imprime as duas linhas prontas para colar no mapa `figures` de
`src/pages/PortalHubPage.tsx`.

### A regra é a ALTURA EXIBIDA, não a mediana

Uma versão anterior deste arquivo mandava medir três invariantes — altura da
cabeça, largura do ombro, altura do corpo — e ficar com a **mediana**. Medido:
não é o que os pares no ar fazem, e a mediana reprova.

O que os três pares fazem é bater a altura exibida ao pixel: 507/508, 457/457,
504/504. A mediana erra porque a `colaborador-dupla` é a moça de cabelo comprido
e mede "cabeça" **56px** contra 214px da parceira — sem pescoço estreito
visível, o mínimo cai no lugar errado e contamina a conta. Ela daria `larg: 185`
onde o arquivo usa 135.

O script, medindo só a silhueta, reproduz o par do operador **exato** e o do
colaborador com 1px. O do gestor sai com `--altura 457`, que é a altura dele.

### A folga lateral faz parte da composição

A dupla não pode ocupar mais que ~86% do palco. Os três pares antigos ficam em
78%, 86% e 90% de um palco de **395px** (medido no navegador — não os 372 que
este arquivo estimava). Encher os 100% cola as figuras na borda: foi o que
aconteceu na primeira tentativa de candidato/natdocs/chamado, e o notebook do
analista saía raspando a lateral do cartão.

Quando a soma não cabe, as DUAS encolhem juntas — encolher uma só quebra a
igualdade de altura, que é o ponto do cálculo. É por isso que natdocs e chamado
ficam a 398px e 384px de altura, e não nos 484px do candidato: o contrato
estendido e o gesto da atendente ocupam mais largura.

## Feito em 12/09/2026 — Candidato, NatDocs e Chamado

Seis figuras, mesmo pipeline da leva anterior (`gemini-3-pro-image`,
`figure-marcos.webp` como referência de ESTILO, `aspect_ratio: 9:16`,
`resolution: 2K`, duas variações por personagem para escolher).

| arquivo | personagem |
| --- | --- |
| `figure-candidato.webp` | rapaz de 24 anos, camisa azul-petróleo, mochila no ombro, celular com as vagas |
| `figure-candidato-dupla.webp` | moça de 23 anos, blusa lilás, pasta do currículo nas mãos |
| `figure-natdocs.webp` | analista de 32 anos, blazer roxo, assinando no tablet com a caneta |
| `figure-natdocs-dupla.webp` | homem de 40 anos, camisa lilás, mostrando o contrato assinado |
| `figure-chamado.webp` | atendente do suporte, polo roxa com o losango, headset com microfone |
| `figure-chamado-dupla.webp` | analista de RH do cliente, óculos, notebook no antebraço |

Os dois candidatos **não** usam nada da marca, de propósito: ainda não são da
empresa. A atendente do Chamado usa; o analista de RH que abre o chamado, não.

O recorte do fundo é o `scripts/recorta.py`. Ele preenche a partir das bordas,
então branco CERCADO pela figura sobrevive — os tênis, a camisa sob o blazer e,
o caso mais visível, a folha do contrato na mão do NatDocs. Limiar simples
comeria os três.
