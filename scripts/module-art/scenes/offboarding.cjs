/** Offboarding: o workflow aprovado, a rescisão calculada em uma tela e a saída encerrada. */
module.exports = (k) => {
  const { C, stage, card, door, avatar, textLines, surface, checkBadge, flow, trail } = k
  const step = (y) => `
${card(170, y, 200, 90)}
${checkBadge(212, y + 45, 18)}
${textLines(244, y + 32, [96, 60], { h: 10, gap: 10, fill: [C.ink, C.gray] })}`
  const doorX = 850, doorY = 250, doorW = 140, doorH = 320
  return `
${stage(600, 420)}
<!-- Três passos do workflow de desligamento -->
${step(200)}
<line x1="270" y1="290" x2="270" y2="320" stroke="${C.purple}" stroke-width="3" stroke-linecap="round"/>
${step(320)}
<line x1="270" y1="410" x2="270" y2="440" stroke="${C.purple}" stroke-width="3" stroke-linecap="round"/>
${step(440)}
${flow(382, 485, 448, 485, { end: C.purple })}
<!-- Cálculo da rescisão em uma tela -->
${card(460, 220, 300, 360)}
${avatar(502, 272, 24)}
${textLines(538, 262, [130, 80], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
<rect x="484" y="316" width="252" height="3" fill="${C.mist}"/>
${[0, 1, 2, 3].map((i) => `
  <rect x="484" y="${340 + i * 38}" width="${[120, 90, 140, 100][i]}" height="10" rx="5" fill="${C.mist}"/>
  <rect x="${736 - [56, 44, 70, 48][i]}" y="${340 + i * 38}" width="${[56, 44, 70, 48][i]}" height="10" rx="5" fill="${C.purple}"/>`).join('')}
${surface(484, 500, 252, 60, C.purple, 12)}
<rect x="504" y="524" width="90" height="12" rx="6" fill="${C.white}" fill-opacity="0.8"/>
<rect x="640" y="524" width="76" height="12" rx="6" fill="${C.white}"/>
<!-- A porta de saída -->
${door(doorX, doorY, doorW, doorH)}
<rect x="${doorX + 17}" y="${doorY + 17}" width="${doorW - 34}" height="${doorH - 17}" rx="6" fill="${C.white}"/>
${flow(776, 410, 918, 410, { end: C.pink })}
${trail(160, 700, 14)}`
}
