/** Metas e Resultados: o alvo no centro, as metas acompanhadas e o PLR calculado. */
module.exports = (k) => {
  const { C, stage, card, diamond, textLines, pill, trail } = k
  const tx = 380, ty = 420
  const goal = (y, p) => `
${textLines(632, y, [120], { h: 10, fill: [C.ink] })}
<rect x="632" y="${y + 22}" width="276" height="12" rx="6" fill="${C.mist}"/>
<rect x="632" y="${y + 22}" width="${Math.round(276 * p)}" height="12" rx="6" fill="${C.purple}"/>`
  return `
${stage(600, 420)}
<!-- O alvo: módulos concêntricos -->
${diamond(tx, ty, 320, C.white, `stroke="${C.mist}" stroke-width="3"`)}
${diamond(tx, ty, 236, C.purple)}
${diamond(tx, ty, 152, C.white)}
${diamond(tx, ty, 68, C.pink)}
<!-- Metas acompanhadas -->
${card(600, 190, 340, 310)}
${goal(236, 0.85)}
${goal(302, 0.6)}
${goal(368, 0.95)}
${goal(434, 0.4)}
<!-- Bônus / PLR calculado e enviado à folha -->
${card(600, 530, 340, 90)}
${pill(624, 555, 100, 40, 'PLR', { fill: C.blue, size: 16 })}
${textLines(744, 560, [110, 70], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${trail(160, 700, 14)}`
}
