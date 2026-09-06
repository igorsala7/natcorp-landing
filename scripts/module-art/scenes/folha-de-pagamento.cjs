/** Folha de Pagamento: o ponto já apurado entra no holerite e o total fecha. */
module.exports = (k) => {
  const { C, stage, card, doc, textLines, avatar, diamond, surface, checkBadge, flow, clockFace, label, trail } = k
  return `
${stage(600, 420)}
<!-- Holerite -->
${doc(390, 150, 420, 520, { fold: 46 })}
${avatar(450, 220, 26)}
${textLines(492, 206, [150, 96], { h: 12, gap: 12, fill: [C.ink, C.gray] })}
<rect x="420" y="276" width="360" height="3" fill="${C.mist}"/>
${[0, 1, 2, 3, 4].map((i) => `
  <rect x="420" y="${300 + i * 48}" width="${[150, 120, 170, 110, 140][i]}" height="12" rx="6" fill="${C.mist}"/>
  <rect x="${700 - [70, 56, 84, 48, 62][i]}" y="${300 + i * 48}" width="${[70, 56, 84, 48, 62][i]}" height="12" rx="6" fill="${C.purple}"/>
  <rect x="740" y="${300 + i * 48}" width="40" height="12" rx="6" fill="${C.gray}"/>`).join('')}
${surface(420, 560, 360, 64, C.purple, 14)}
<rect x="440" y="586" width="120" height="12" rx="6" fill="${C.white}" fill-opacity="0.8"/>
<rect x="640" y="580" width="120" height="24" rx="12" fill="${C.white}"/>
${diamond(662, 592, 14, C.pink)}
<rect x="680" y="586" width="60" height="12" rx="6" fill="${C.purple}"/>
<!-- Ponto apurado entrando na folha -->
${card(150, 300, 190, 170)}
${clockFace(245, 372, 44, { hour: 8, min: 12, hand: 5, tick: 4, core: 12 })}
<rect x="195" y="432" width="100" height="10" rx="5" fill="${C.mist}"/>
${flow(345, 385, 386, 385)}
<!-- Fechamento com tudo conferido -->
${card(880, 190, 190, 130)}
${checkBadge(925, 240, 20)}
${textLines(960, 232, [80, 60], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${card(880, 340, 190, 130)}
${checkBadge(925, 390, 20)}
${textLines(960, 382, [90, 50], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${card(880, 490, 190, 130)}
${diamond(925, 540, 40, C.purple)}
${textLines(960, 532, [70, 90], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${trail(160, 700, 14)}`
}
