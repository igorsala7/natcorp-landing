/** Ponto Eletrônico: o relógio, a jornada de cada dia da semana, a hora extra e o banco de horas. */
module.exports = (k) => {
  const { C, stage, card, clockFace, diamond, textLines, pill, checkBadge, flow, trail } = k
  // Semana: uma barra de jornada por dia; a quinta-feira com hora extra
  const lens = [300, 290, 300, 300, 280]
  const week = [0, 1, 2, 3, 4]
    .map((i) => {
      const y = 306 + i * 48
      return `${diamond(612, y, 14, C.purple)}
<rect x="636" y="${y - 10}" width="364" height="20" rx="10" fill="${C.mist}"/>
<rect x="636" y="${y - 10}" width="${lens[i]}" height="20" rx="10" fill="${C.purple}"/>${i === 3 ? `
<rect x="930" y="${y - 10}" width="66" height="20" rx="10" fill="${C.pink}"/>` : ''}`
    })
    .join('\n')
  return `
${stage(600, 420)}
<!-- Relógio -->
${clockFace(360, 410, 130, { hour: 8, min: 0, hand: 10, tick: 8, core: 28, ring: C.blue, ringWidth: 12 })}
${flow(506, 410, 546, 410, { end: C.purple })}
<!-- Semana apurada -->
${card(560, 190, 480, 420, { r: 22 })}
${textLines(600, 222, [140, 90], { h: 12, gap: 12, fill: [C.ink, C.gray] })}
<rect x="600" y="276" width="400" height="3" fill="${C.mist}"/>
${week}
<rect x="600" y="536" width="400" height="3" fill="${C.mist}"/>
<!-- Aprovado pelo gestor e banco de horas -->
${checkBadge(618, 572, 18)}
${textLines(646, 564, [90, 60], { h: 9, gap: 8, fill: [C.ink, C.gray] })}
${pill(870, 554, 130, 36, '+02:15', { size: 16 })}
${trail(160, 700, 14)}`
}
