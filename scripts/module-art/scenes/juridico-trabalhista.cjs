/** Jurídico Trabalhista: a defesa pesada com o dado do sistema, a lista de processos e a provisão. */
module.exports = (k) => {
  const { C, stage, card, diamond, textLines, surface, bars, trail } = k
  const paper = (x, y, w, h, o = {}) => {
    const r = o.r ?? 10
    const f = o.fold ?? 20
    const fill = o.fill || C.white
    const st = o.stroke || C.mist
    return `<path d="M${x + r} ${y} H${x + w - f} L${x + w} ${y + f} V${y + h - r} a${r} ${r} 0 0 1 -${r} ${r} H${x + r} a${r} ${r} 0 0 1 -${r} -${r} V${y + r} a${r} ${r} 0 0 1 ${r} -${r} Z" fill="${fill}" stroke="${st}" stroke-width="3" stroke-linejoin="round"/><path d="M${x + w - f} ${y} V${y + f} H${x + w}" fill="none" stroke="${st}" stroke-width="3" stroke-linejoin="round"/>`
  }
  // Lista de processos com status
  const status = [C.purple, C.gray, C.pink, C.purple, C.mist]
  const rows = [262, 322, 382, 442, 502]
    .map((y, i) => `<rect x="852" y="${y - 9}" width="${[90, 76, 96, 70, 84][i]}" height="10" rx="5" fill="${C.ink}"/>
<rect x="852" y="${y + 5}" width="${[60, 50, 64, 46, 56][i]}" height="8" rx="4" fill="${C.gray}"/>
<rect x="990" y="${y - 8}" width="44" height="16" rx="8" fill="${status[i]}"/>`)
    .join('\n')
  return `
${stage(600, 420)}
<!-- Balança -->
${surface(544, 562, 112, 20, C.blue, 10)}
<line x1="600" y1="236" x2="600" y2="566" stroke="${C.blue}" stroke-width="10" stroke-linecap="round"/>
<line x1="430" y1="236" x2="770" y2="236" stroke="${C.blue}" stroke-width="10" stroke-linecap="round"/>
<path d="M450 240 L410 338 M450 240 L490 338 M750 240 L710 338 M750 240 L790 338" fill="none" stroke="${C.purple}" stroke-width="4" stroke-linecap="round"/>
${diamond(600, 236, 36, C.purple)}
<circle cx="450" cy="404" r="68" fill="${C.white}"/>
<circle cx="750" cy="404" r="68" fill="${C.white}"/>
<!-- No prato: a peça de defesa e o dado do sistema -->
${paper(418, 364, 64, 80, { r: 8, fold: 16 })}
${textLines(430, 386, [36, 40, 30], { h: 5, gap: 7, fill: [C.ink, C.gray, C.gray] })}
${diamond(750, 404, 60, C.purple)}
<!-- Processos e status -->
${card(830, 220, 220, 340, { r: 20 })}
${rows}
<!-- Provisão por grau de risco -->
${card(150, 300, 190, 170)}
<rect x="178" y="322" width="60" height="8" rx="4" fill="${C.ink}"/>
${bars(178, 344, 134, 92, [50, 72, 100], { gap: 16, fills: [C.gray, C.gray, C.purple] })}
<rect x="178" y="440" width="134" height="3" fill="${C.mist}"/>
${trail(160, 700, 14)}`
}
