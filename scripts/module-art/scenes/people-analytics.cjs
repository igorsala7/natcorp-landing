/** People Analytics: filtros, a rosca e a dispersão — o dado vira gráfico com o botão Ações. */
module.exports = (k) => {
  const { C, stage, card, textLines, diamond, pill, trail, r2 } = k
  const polar = (cx, cy, r, a) => [r2(cx + Math.cos(a) * r), r2(cy + Math.sin(a) * r)]
  /** Arco de rosca (traço grosso). */
  const arc = (cx, cy, r, a0, a1, stroke, w) => {
    const [x0, y0] = polar(cx, cy, r, a0)
    const [x1, y1] = polar(cx, cy, r, a1)
    return `<path d="M${x0} ${y0} A${r} ${r} 0 ${a1 - a0 > Math.PI ? 1 : 0} 1 ${x1} ${y1}" fill="none" stroke="${stroke}" stroke-width="${w}"/>`
  }
  const donut = (cx, cy, r, w, slices) => {
    let a = -Math.PI / 2
    const gap = 0.05
    return slices
      .map(([p, fill]) => {
        const s = arc(cx, cy, r, a + gap / 2, a + p * Math.PI * 2 - gap / 2, fill, w)
        a += p * Math.PI * 2
        return s
      })
      .join('\n')
  }
  /** Filtro: pílula em Névoa (halo branco para se destacar do palco) com módulo pequeno e barra. */
  const filter = (x, y, w) => `<rect x="${x}" y="${y}" width="${w}" height="40" rx="20" fill="${C.mist}" stroke="${C.white}" stroke-width="6"/>
${diamond(x + 22, y + 20, 14, C.purple)}
<rect x="${x + 38}" y="${y + 15}" width="${w - 58}" height="10" rx="5" fill="${C.graphite}"/>`
  const pts = [[672, 548], [694, 528], [716, 552], [738, 508], [760, 522], [782, 484], [804, 498], [826, 458], [848, 470], [870, 430], [892, 446], [908, 402]]
  const fills = [C.gray, C.purple, C.gray, C.purple, C.plum, C.purple, C.gray, C.purple, C.plum, C.purple, C.plum, C.purple]
  return `
${stage(600, 420)}
<!-- Filtros e o botão Ações -->
${filter(250, 170, 130)}
${filter(396, 170, 110)}
${filter(522, 170, 150)}
${pill(830, 170, 120, 40, 'Ações', { size: 16 })}
<!-- Rosca -->
${card(250, 240, 320, 380, { r: 24 })}
${textLines(280, 268, [150], { h: 12, fill: [C.ink] })}
${donut(410, 400, 92, 34, [[0.42, C.purple], [0.26, C.plum], [0.2, C.gray], [0.12, C.pink]])}
${[[C.purple, 290], [C.plum, 380], [C.gray, 470]].map(([f, x]) => `${diamond(x, 560, 14, f)}<rect x="${x + 14}" y="555" width="50" height="10" rx="5" fill="${C.mist}"/>`).join('')}
<!-- Dispersão -->
${card(610, 240, 340, 380, { r: 24 })}
${textLines(640, 268, [160], { h: 12, fill: [C.ink] })}
<path d="M650 300 V580 H920" fill="none" stroke="${C.mist}" stroke-width="3"/>
<line x1="664" y1="556" x2="912" y2="412" stroke="${C.purple}" stroke-width="3" stroke-linecap="round" stroke-dasharray="2 10"/>
${pts.map(([x, y], i) => diamond(x, y, 16, fills[i])).join('\n')}
${trail(160, 700, 14)}`
}
