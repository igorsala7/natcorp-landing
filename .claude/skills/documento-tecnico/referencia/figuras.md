# Figuras (infográficos SVG)

Cada figura é um módulo em `figuras/fig_nome.mjs` que exporta `default () => string` (o SVG) e importa
os utilitários de `./lib.mjs` (o gerador copia a lib ao lado). O SVG entra inline no HTML e herda as
fontes do documento. Modelos prontos para copiar: `material-interno/documentos-tecnicos/*/figuras/`
(arquitetura em camadas, defesa em profundidade, fluxo de API, passos em cartões, jornada, mapa de dados,
telas do app com foto, matriz de papéis etc.).

## Gramática visual (manter)
- Largura 680 de viewBox. Altura só o necessário: caixa vazia é defeito (já aconteceu).
- Camadas empilhadas de cima para baixo, com `selo(n)` numerado, `icoCirculo` à esquerda, título
  `ig-h` 15 a 17, subtítulo `ig-s`, chips na linha de baixo.
- Grupo de infraestrutura: retângulo tracejado `C.m050` com rótulo `ig-m` em maiúsculas e chip de região.
- Setas: `line` + `seta(x, y, 'down')`; ligação fechada/sensível: linha pontilhada `dash: '2 5'` + chip com cadeado.
- Painel lateral de terceiros: fundo `C.r050`, títulos de seção em rosa.
- Faixa final de destaque: fundo `C.marca`, texto branco; o `selo` sobre fundo roxo usa `{ fill: '#fff', cor: C.marca }`.
- Estado nunca só por cor: ícone + rótulo.
- `setPiso(px)` no início, conforme a largura impressa (84% → 10,3; 90% → 10,2; 96% → 9,6), para nenhum
  rótulo ficar abaixo de ~6,5 pt.
- `desc` do `svg()` descreve a figura inteira em texto corrido (acessibilidade). Sem travessão.

## Utilitários de lib.mjs
`C` (cores da marca), `svg({w,h,titulo,desc,corpo,id})`, `t(x,y,linhas,{cls,size,fill,weight,lh,anchor})`,
`r(x,y,w,h,{rx,fill,stroke,dash})`, `line`, `path`, `seta(x,y,dir)`, `chip(x,y,texto,{icone,size,h,fill,stroke,cor})`
(retorna `{svg,w}`), `ico(nome,x,y,size,cor)`, `icoCirculo(nome,cx,cy,raio,{fill,cor})`, `selo(cx,cy,n)`,
`wrap(texto,maxW,size)` (quebra em linhas), `aConfirmar(...)` (selo âmbar), `setPiso`, `pis`, `esc`.

Cores (`C`): marca `#511C76`, marca2 `#2C1A63`, rosa `#C95788`, tinta `#1B1238`, tinta2 `#4A4460`,
ok `#2E7D32`, atencao `#A15C00`, erro `#C62828`, info `#1F5FAD`; fundos m050/m100/m200/m300, r050/r100/r200.

Ícones: celular tablet cadeado tomada banco painel rosto chave sino ok alerta cofre relogio local qr camera
pin wifi toque escudo servidor ampulheta pessoa sincronia envelope doc lista grafico ajuste lupa predio
globo pacote mapa balanca dedo (nos cartões também: lampada, semrede).

## Imagens
Fotos e marcas ficam em `assets/` do documento; o gerador as copia para `build/marca/`. Numa figura,
leia com `join(dirname(fileURLToPath(import.meta.url)), '..', 'marca', 'arquivo')` e embuta como
data URI (ver `natponto-por-dentro/figuras/fig_telas_app.mjs`).

## Revisão
Depois de gerar, abra `build/png/folha-1.png` (visão geral) e o PNG da página da figura em tamanho
real. Procure: caixa com sobra, texto cortado, sobreposição de rótulo com borda, selo invisível.
