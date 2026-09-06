/** Administração de Pessoal: quem ocupa cada posição, a vaga aberta e o previsto x realizado. */
module.exports = (k) => {
  const { C, stage, card, avatar, diamond, textLines, checkBadge, flow, surface, pill, trail } = k
  // Quadro de posições: grade de pessoas, uma vaga aberta
  const cols = [440, 520, 600, 680, 760]
  const rows = [282, 346, 410]
  const open = { c: 4, r: 2 }
  const grid = rows
    .map((cy, ri) =>
      cols
        .map((cx, ci) => {
          if (ri === open.r && ci === open.c) {
            return `<circle cx="${cx}" cy="${cy}" r="24" fill="${C.white}" stroke="${C.gray}" stroke-width="3" stroke-dasharray="6 7"/>${diamond(cx, cy, 24, C.pink)}`
          }
          return avatar(cx, cy, 24, { fg: (ri + ci) % 3 === 1 ? C.blue : C.purple })
        })
        .join('\n'),
    )
    .join('\n')
  // Previsto (roxo) x realizado (cinza)
  const prev = [112, 132, 122, 150]
  const real = [104, 138, 116, 142]
  const base = 636
  const h = 140
  const max = 150
  const pairs = prev
    .map((p, i) => {
      const x = 424 + i * 96
      const ph = (p / max) * h
      const rh = (real[i] / max) * h
      return `<rect x="${x}" y="${base - ph}" width="30" height="${ph}" rx="6" fill="${C.purple}"/><rect x="${x + 36}" y="${base - rh}" width="30" height="${rh}" rx="6" fill="${C.gray}"/>`
    })
    .join('\n')
  return `
${stage(600, 420)}
<!-- Quadro de pessoal -->
${card(390, 150, 420, 520, { r: 22 })}
${textLines(420, 180, [170, 110], { h: 12, gap: 12, fill: [C.ink, C.gray] })}
${pill(704, 178, 76, 28, '42 / 45', { size: 14 })}
<rect x="420" y="246" width="360" height="3" fill="${C.mist}"/>
${grid}
<rect x="420" y="452" width="360" height="3" fill="${C.mist}"/>
<!-- Orçamento: previsto x realizado -->
${diamond(428, 476, 12, C.purple)}
<rect x="442" y="471" width="48" height="10" rx="5" fill="${C.ink}"/>
${diamond(520, 476, 12, C.gray)}
<rect x="534" y="471" width="48" height="10" rx="5" fill="${C.gray}"/>
${pairs}
<rect x="420" y="636" width="360" height="3" fill="${C.mist}"/>
<!-- O gestor pede -->
${card(150, 300, 190, 170)}
${avatar(200, 352, 24)}
${textLines(236, 342, [80, 56], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${surface(178, 400, 134, 40, C.purple, 12)}
<rect x="198" y="414" width="70" height="12" rx="6" fill="${C.white}" fill-opacity="0.85"/>
${diamond(290, 420, 12, C.white)}
${flow(346, 385, 384, 385, { end: C.purple })}
<!-- A alçada valida e a estrutura recebe -->
${card(880, 250, 190, 130)}
${checkBadge(925, 315, 20)}
${textLines(960, 307, [80, 60], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${card(880, 410, 190, 150)}
<path d="M975 460 V478 M935 478 H1015 M935 478 V492 M975 478 V492 M1015 478 V492" fill="none" stroke="${C.gray}" stroke-width="3" stroke-linecap="round"/>
${diamond(975, 448, 26, C.purple)}
${diamond(935, 508, 22, C.blue)}
${diamond(975, 508, 22, C.blue)}
${diamond(1015, 508, 22, C.blue)}
${trail(160, 700, 14)}`
}
