/** Cargos e Salários: as faixas de cada cargo, o salário atual dentro da faixa e a escada de cargos. */
module.exports = (k) => {
  const { C, stage, card, diamond, textLines, pill, flow, doc, trail } = k
  // Faixas salariais: mínimo-máximo como barras verticais
  const bands = [
    [470, 470, 610],
    [556, 400, 540],
    [642, 330, 470],
    [728, 262, 402],
  ]
  const gridLines = [0, 1, 2, 3, 4, 5].map((i) => `<line x1="420" y1="${262 + i * 70}" x2="780" y2="${262 + i * 70}" stroke="${C.mist}" stroke-width="3"/>`).join('\n')
  const bandShapes = bands
    .map(([cx, top, bottom]) => {
      const mid = (top + bottom) / 2
      return `<rect x="${cx - 22}" y="${top}" width="44" height="${bottom - top}" rx="22" fill="${C.purple}"/><rect x="${cx - 12}" y="${mid - 3}" width="24" height="6" rx="3" fill="${C.white}" fill-opacity="0.85"/>`
    })
    .join('\n')
  // Escada de cargos: degraus com um módulo em cada
  const steps = [
    [917, 553],
    [955, 498],
    [995, 443],
    [1032, 388],
  ]
  return `
${stage(600, 420)}
<!-- Tabela salarial -->
${card(390, 150, 420, 520, { r: 22 })}
${textLines(420, 180, [150, 100], { h: 12, gap: 12, fill: [C.ink, C.gray] })}
${pill(716, 176, 64, 28, 'R$', { size: 15 })}
<rect x="420" y="236" width="360" height="3" fill="${C.mist}"/>
${gridLines}
${bandShapes}
<!-- Salário atual dentro da faixa -->
${diamond(556, 502, 32, C.pink)}
<!-- Ficha do cargo -->
${card(150, 300, 190, 170)}
${doc(178, 322, 134, 126, { fold: 26 })}
${textLines(198, 348, [72, 92, 62, 84], { h: 8, gap: 12, fill: [C.ink, C.mist, C.mist, C.mist] })}
${flow(346, 385, 384, 385, { end: C.purple })}
<!-- Escada de cargos -->
${card(880, 250, 190, 350)}
<path d="M900 570 H935 V515 H975 V460 H1015 V405 H1050" fill="none" stroke="${C.blue}" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
${steps.map(([x, y]) => diamond(x, y, 28, C.purple)).join('\n')}
${trail(160, 700, 14)}`
}
