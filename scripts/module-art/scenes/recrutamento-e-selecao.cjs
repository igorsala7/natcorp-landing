/** Recrutamento e Seleção: a vaga com prazo alimenta o funil; a lupa encontra quem fecha a vaga. */
module.exports = (k) => {
  const { C, stage, card, avatar, diamond, textLines, pill, magnifier, flow, trail } = k
  const fx = 600 // eixo do funil
  const tier = (y, w, h = 110) => card(fx - w / 2, y, w, h, { r: 20 })
  return `
${stage(600, 420)}
<!-- Cartão da vaga com prazo (SLA) -->
${card(150, 270, 230, 280)}
${diamond(190, 312, 32, C.purple)}
${textLines(216, 302, [110, 70], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
<rect x="174" y="352" width="182" height="3" fill="${C.mist}"/>
${textLines(174, 374, [180, 140, 160], { h: 10, gap: 12, fill: C.mist })}
${pill(174, 478, 150, 36, 'SLA 5 dias', { fill: C.blue, size: 15 })}
${flow(392, 345, 458, 345, { end: C.purple })}
<!-- Funil: 5 → 3 → 1 -->
${tier(160, 360)}
${[-130, -65, 0, 65, 130].map((dx) => avatar(fx + dx, 215, 26)).join('\n')}
${tier(290, 260)}
${[-65, 0, 65].map((dx) => avatar(fx + dx, 345, 26)).join('\n')}
${tier(420, 150, 120)}
${diamond(fx, 480, 100, C.pink)}
${avatar(fx, 480, 30, { bg: C.white, fg: C.purple })}
<!-- A busca no banco de talentos -->
${magnifier(724, 470, 34, C.purple, 6)}
${trail(160, 700, 14)}`
}
