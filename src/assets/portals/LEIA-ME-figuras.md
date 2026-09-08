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
