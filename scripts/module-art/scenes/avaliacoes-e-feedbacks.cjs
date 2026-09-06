/** Avaliações e Feedbacks: o ciclo 360° em volta de quem é avaliado e o feedback que chega. */
module.exports = (k) => {
  const { C, stage, card, avatar, diamond, bubble, textLines, trail, r2 } = k
  const cx = 600, cy = 415, R = 175
  const at = (deg, r = R) => {
    const a = (deg * Math.PI) / 180
    return [r2(cx + Math.cos(a) * r), r2(cy + Math.sin(a) * r)]
  }
  /** Ponta de seta tangente ao anel (sentido horário) no ângulo dado. */
  const chevron = (deg) => {
    const [x, y] = at(deg)
    const t = ((deg + 90) * Math.PI) / 180 // direção tangente
    const pt = (ang, len) => `${r2(x - Math.cos(t + ang) * len)} ${r2(y - Math.sin(t + ang) * len)}`
    return `<path d="M${pt(0.55, 18)} L${x} ${y} L${pt(-0.55, 18)}" fill="none" stroke="${C.purple}" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>`
  }
  const ring = [-90, -30, 30, 90, 150, 210].map((d) => at(d))
  return `
${stage(600, 420)}
<!-- O anel: quem avalia em volta de quem é avaliado -->
<circle cx="${cx}" cy="${cy}" r="${R}" fill="none" stroke="${C.purple}" stroke-width="4"/>
${chevron(-60)}
${chevron(120)}
${ring.map(([x, y]) => avatar(x, y, 30, { bg: C.white, fg: C.purple })).join('\n')}
${avatar(cx, cy, 52, { bg: C.purple, fg: C.white })}
<!-- Balões de feedback -->
${bubble(780, 236, 116, 52, { fill: C.mist })}
${textLines(804, 252, [68, 46], { h: 8, gap: 8, fill: [C.ink, C.gray] })}
${bubble(304, 236, 116, 52, { fill: C.mist, right: true })}
${textLines(328, 252, [68, 46], { h: 8, gap: 8, fill: [C.ink, C.gray] })}
${bubble(800, 420, 116, 52, { fill: C.pink })}
${textLines(824, 436, [68, 46], { h: 8, gap: 8, fill: [C.white, C.white] })}
<!-- A escala da avaliação -->
${card(160, 440, 160, 110)}
${[0, 1, 2, 3, 4].map((i) => diamond(190 + i * 25, 480, 20, i < 4 ? C.purple : C.mist)).join('\n')}
${textLines(180, 512, [100], { h: 8, fill: [C.gray] })}
${trail(160, 700, 14)}`
}
