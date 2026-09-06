# Ícones e ilustrações dos módulos

Arte de marca dos 31 módulos do sistema Natcorp, gerada por código a partir do manual de identidade v1.2.
Nada aqui vem de banco de ícones: cada glifo e cada cena foram desenhados na geometria do símbolo.

## O que tem em cada pasta

| Pasta | Conteúdo | Formatos |
| --- | --- | --- |
| `icones/svg/` | Ícone de app do módulo: um módulo do símbolo (losango de cantos arredondados) em gradiente da marca, com o glifo branco em traço e um módulo pequeno em Rosa como acento | SVG 1024 x 1024, fundo transparente |
| `icones/png/` | O mesmo ícone rasterizado | PNG 1024 (`slug.png`) e 256 (`slug@256.png`), fundo transparente |
| `ilustracoes/svg/` | Ilustração plana e geométrica que resume o módulo, com o contorno do símbolo no canto superior direito | SVG 1200 x 800, fundo branco |
| `ilustracoes/png/` | A mesma ilustração rasterizada | PNG 1200 x 800 (`slug.png`) e 2400 x 1600 (`slug@2x.png`) |
| `previa-icones.png`, `previa-ilustracoes.png` | Folhas de contato com tudo lado a lado | PNG |

Os nomes de arquivo usam o slug de cada módulo, o mesmo das páginas do site (por exemplo `folha-de-pagamento`, `natponto`, `nati`).

## Regras aplicadas

- Módulo: quadrado de lado x, cantos com raio 0,17x, girado 45°. O conjunto nunca gira.
- Ícone: gradiente 135° (Ameixa → Roxo → Azul Profundo) só no fundo; glifo em traço branco de 1,8 na grade de 24, pontas e junções redondas; um único acento em Rosa por ícone.
- Ilustração: plana, na grade a 45°, sem 3D, sem sombras, sem gradiente. Superfícies em Roxo, Azul Profundo e Névoa; Cinza para o comparativo; Rosa em um único ponto de destaque. Pessoas como avatares abstratos, nunca caricatura, nunca robô.
- Tipografia, quando aparece um rótulo curto: Manrope. Os SVGs declaram `Manrope, Arial, sans-serif`; os PNGs já foram rasterizados com a Manrope embutida.

## Como regenerar

```
node scripts/module-art/build.cjs                      # tudo, em brand/modulos
node scripts/module-art/build.cjs --only natpay,nati   # só alguns
node scripts/module-art/build.cjs --no-png             # só os SVGs
```

Os glifos ficam em `scripts/module-art/icons.cjs`, as cenas em `scripts/module-art/scenes/<slug>.cjs` e as primitivas (paleta, módulo, cartões, avatares, gráficos) em `scripts/module-art/kit.cjs`. O PNG é rasterizado pelo Chromium do Playwright.
