/** Segurança do Trabalho: o capacete, os EPIs conferidos, o alerta de prazo e os laudos gerados. */
module.exports = (k) => {
  const { C, stage, card, textLines, diamond, checkBadge, flow, trail } = k
  const paper = (x, y, w, h, o = {}) => {
    const r = o.r ?? 10
    const f = o.fold ?? 20
    return `<path d="M${x + r} ${y} H${x + w - f} L${x + w} ${y + f} V${y + h - r} a${r} ${r} 0 0 1 -${r} ${r} H${x + r} a${r} ${r} 0 0 1 -${r} -${r} V${y + r} a${r} ${r} 0 0 1 ${r} -${r} Z" fill="${C.white}" stroke="${C.mist}" stroke-width="3" stroke-linejoin="round"/><path d="M${x + w - f} ${y} V${y + f} H${x + w}" fill="none" stroke="${C.mist}" stroke-width="3" stroke-linejoin="round"/>`
  }
  // Lista de EPIs conferidos
  const rows = [478, 528, 578, 628]
    .map((y, i) => `${checkBadge(440, y, 15)}
<rect x="468" y="${y - 5}" width="${[150, 120, 170, 130][i]}" height="10" rx="5" fill="${C.mist}"/>
<rect x="736" y="${y - 7}" width="40" height="14" rx="7" fill="${C.purple}"/>`)
    .join('\n')
  return `
${stage(600, 420)}
<!-- Capacete -->
<path d="M480 302 A120 120 0 0 1 720 302 Z" fill="${C.purple}"/>
<rect x="586" y="196" width="28" height="60" rx="14" fill="${C.white}" fill-opacity="0.85"/>
<rect x="446" y="296" width="308" height="28" rx="14" fill="${C.blue}"/>
<!-- Ficha de EPI -->
${card(390, 372, 420, 288, { r: 22 })}
${textLines(424, 402, [140, 90], { h: 11, gap: 10, fill: [C.ink, C.gray] })}
<rect x="424" y="448" width="352" height="3" fill="${C.mist}"/>
${rows}
<!-- Alerta de prazo -->
${card(160, 400, 190, 160, { r: 20 })}
${diamond(255, 480, 88, C.pink)}
<rect x="249" y="452" width="12" height="32" rx="6" fill="${C.white}"/>
<circle cx="255" cy="500" r="7" fill="${C.white}"/>
${flow(354, 480, 384, 480, { end: C.purple })}
<!-- Laudos e documentos gerados -->
${flow(816, 480, 842, 480, { end: C.purple })}
${card(850, 400, 190, 160, { r: 20 })}
${paper(900, 428, 90, 108, { r: 10, fold: 22 })}
${textLines(916, 452, [44, 56, 40, 52], { h: 6, gap: 10, fill: [C.ink, C.mist, C.mist, C.mist] })}
${checkBadge(968, 518, 12)}
${trail(160, 700, 14)}`
}
