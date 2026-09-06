/** Gestão de Benefícios: o cartão do colaborador, os benefícios que ele recebe e a elegibilidade conferida. */
module.exports = (k) => {
  const { C, stage, card, surface, diamond, textLines, heart, checkBadge, flow, trail } = k
  // Azulejos: saúde, refeição, transporte
  const tile = (y) => card(200, y, 120, 100, { r: 20 })
  const cutlery = (cx, cy) => `<g fill="none" stroke="${C.purple}" stroke-width="5" stroke-linecap="round" stroke-linejoin="round">
  <path d="M${cx - 14} ${cy - 26} v12 a6 6 0 0 0 12 0 v-12"/>
  <path d="M${cx - 8} ${cy - 26} v12"/>
  <path d="M${cx - 8} ${cy - 8} v34"/>
  <path d="M${cx + 12} ${cy - 26} v52"/>
</g>
<path d="M${cx + 12} ${cy - 26} q16 12 0 32 z" fill="${C.purple}"/>`
  const bus = (cx, cy) => `<rect x="${cx - 32}" y="${cy - 24}" width="64" height="44" rx="10" fill="${C.purple}"/>
<rect x="${cx - 24}" y="${cy - 16}" width="22" height="14" rx="3" fill="${C.white}"/>
<rect x="${cx + 2}" y="${cy - 16}" width="22" height="14" rx="3" fill="${C.white}"/>
<circle cx="${cx - 18}" cy="${cy + 22}" r="6" fill="${C.blue}"/>
<circle cx="${cx + 18}" cy="${cy + 22}" r="6" fill="${C.blue}"/>`
  // Lista de elegibilidade
  const rows = [296, 360, 424, 488]
    .map((y, i) => `${checkBadge(866, y, 16)}
${textLines(894, y - 13, [[110, 70], [96, 60], [116, 54], [90, 70]][i], { h: 9, gap: 9, fill: [C.ink, C.gray] })}`)
    .join('\n')
  return `
${stage(600, 420)}
<!-- Cartão de benefícios -->
${surface(390, 250, 400, 320, C.blue, 24)}
${diamond(456, 322, 46, C.mist)}
${diamond(732, 302, 40, 'none', `stroke="${C.white}" stroke-width="4"`)}
<rect x="430" y="410" width="200" height="14" rx="7" fill="${C.white}" fill-opacity="0.9"/>
<rect x="430" y="440" width="130" height="12" rx="6" fill="${C.white}" fill-opacity="0.55"/>
${[430, 486, 542, 598].map((x) => `<rect x="${x}" y="518" width="44" height="10" rx="5" fill="${C.white}" fill-opacity="0.5"/>`).join('')}
<!-- Azulejos de benefício -->
${tile(250)}
${heart(260, 302, 3.2)}
${tile(370)}
${cutlery(260, 422)}
${tile(490)}
${bus(260, 542)}
${flow(326, 300, 382, 300, { end: C.purple })}
${flow(326, 420, 382, 420, { end: C.purple })}
${flow(326, 540, 382, 540, { end: C.purple })}
<!-- Elegibilidade conferida -->
${flow(796, 410, 822, 410, { end: C.purple })}
${card(830, 250, 220, 320, { r: 20 })}
${rows}
${trail(160, 700, 14)}`
}
