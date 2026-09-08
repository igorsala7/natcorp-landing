# Figuras dos portais

Cada cartão de portal aceita **duas** pessoas: a principal e a dupla. Hoje só a
principal existe; a dupla entra assim que os arquivos forem gerados.

## O que falta gerar

Três personagens, na mesma família 3D das figuras atuais (ver
`figure-marcos.webp` como referência de estilo):

| Portal | Personagem | Arquivo esperado |
| --- | --- | --- |
| Colaborador | Mulher, 20 anos, pele clara, cabelo castanho com **uma mecha azul** | `figure-colaborador-dupla.webp` |
| Gestor | Mulher, 50 anos, morena clara, **blazer rosa** e camisa roxa, cabelo ondulado na altura do pescoço | `figure-gestor-dupla.webp` |
| Operador | Homem, 35 anos, japonês, **camiseta polo roxa com o símbolo da Natcorp no peito** | `figure-operador-dupla.webp` |

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
