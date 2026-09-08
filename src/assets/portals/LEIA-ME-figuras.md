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

## Como calcular `larg` e `esq` ao trocar uma figura

As duas pessoas de um cartão precisam sair na MESMA escala e lado a lado. Como
cada arquivo foi gerado com um enquadramento diferente, largura igual em CSS
não significa tamanho igual na tela — foi o que deixou a moça com a cabeça
maior que a do rapaz na primeira versão.

A conta, a partir do alfa do `.webp`:

1. **Escala.** Meça três invariantes: altura da cabeça (topo até o ponto mais
   estreito depois do pico — o pescoço), largura do ombro (maior largura logo
   abaixo do pescoço) e altura do corpo (a imagem já vem cortada na silhueta).
   Calcule a largura que igualaria cada um deles à figura de referência e fique
   com a **mediana**. Nenhum dos três serve sozinho: cabelo volumoso infla a
   cabeça, ombro largo de homem infla o ombro. A mediana descarta o
   contaminado. Confere se deu certo: a altura exibida das duas tem de bater
   dentro de poucos pixels.

2. **Posição.** Meça os extremos opacos dentro da faixa que aparece no cartão
   (≈200px de altura), lembrando que espelhar TROCA as bordas de lado. Some as
   duas silhuetas mais 16px de folga, e distribua a partir do centro do palco.
   `esq` é o canto esquerdo da imagem em px a contar do centro — assim a dupla
   fica centrada em qualquer largura de cartão.

3. Se a soma não couber no cartão mais estreito (3 colunas, palco ~372px),
   encolha as DUAS juntas até caber.
