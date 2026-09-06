/** eSocial: o evento sai da folha, entra no sistema, volta com retorno e cada layout fica acompanhado. */
module.exports = (k) => {
  const { C, stage, card, doc, diamond, textLines, check, avatar, surface, r2, trail } = k
  const arrow = (x1, y1, x2, y2, o = {}) => {
    const s = o.stroke || C.purple
    const w = o.width || 4
    const hl = o.head || 14
    const a = Math.atan2(y2 - y1, x2 - x1)
    const p = (d) => `${r2(x2 - Math.cos(a + d) * hl)} ${r2(y2 - Math.sin(a + d) * hl)}`
    return `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="${s}" stroke-width="${w}" stroke-linecap="round"/><path d="M${p(-0.55)} L${x2} ${y2} L${p(0.55)}" fill="none" stroke="${s}" stroke-width="${w}" stroke-linecap="round" stroke-linejoin="round"/>`
  }
  // Fileira de layouts: quatro aceitos e o atual
  const layouts = [440, 520, 600, 680, 760]
    .map((x, i) => `${diamond(x, 600, 46, i === 4 ? C.pink : C.purple)}${check(x, 601, 1.1, C.white, 4)}`)
    .join('\n')
  // Acompanhamento de cada evento
  const rows = [290, 340, 390, 440, 490]
    .map((y, i) => `${diamond(862, y, 16, C.purple)}
<rect x="884" y="${y - 9}" width="${[84, 70, 90, 64, 78][i]}" height="10" rx="5" fill="${C.ink}"/>
<rect x="884" y="${y + 5}" width="${[56, 48, 60, 40, 52][i]}" height="8" rx="4" fill="${C.gray}"/>
<rect x="996" y="${y - 7}" width="36" height="14" rx="7" fill="${i < 3 ? C.purple : C.mist}"/>`)
    .join('\n')
  return `
${stage(600, 420)}
<!-- Evento gerado na folha -->
${doc(170, 230, 210, 280, { fold: 40 })}
${avatar(222, 282, 22)}
${textLines(256, 272, [90, 60], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
<rect x="196" y="320" width="160" height="3" fill="${C.mist}"/>
${textLines(196, 340, [150, 120, 140, 100], { h: 10, gap: 14, fill: C.mist })}
${surface(196, 456, 160, 30, C.purple, 10)}
<rect x="214" y="467" width="80" height="8" rx="4" fill="${C.white}" fill-opacity="0.85"/>
<!-- Envio e retorno -->
${arrow(396, 340, 492, 340)}
${arrow(492, 400, 396, 400, { stroke: C.blue })}
${arrow(736, 370, 822, 370)}
<!-- O sistema: eSocial -->
${diamond(600, 370, 270, C.purple)}
${diamond(600, 370, 120, C.white)}
${check(600, 372, 2.4, C.purple, 9)}
<!-- Layouts aceitos e o atual -->
<rect x="440" y="598" width="320" height="4" rx="2" fill="${C.mist}"/>
${layouts}
<!-- Acompanhamento por evento -->
${card(830, 250, 220, 280, { r: 20 })}
${rows}
${trail(160, 700, 14)}`
}
