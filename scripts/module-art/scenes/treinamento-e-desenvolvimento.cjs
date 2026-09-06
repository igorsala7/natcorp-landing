/** Treinamento e Desenvolvimento: a turma assiste à aula e sai com o certificado registrado. */
module.exports = (k) => {
  const { C, stage, card, doc, avatar, diamond, textLines, surface, check, flow, trail } = k
  const sx = 300, sy = 170, sw = 400, sh = 290
  return `
${stage(600, 420)}
<!-- Tela da aula -->
${card(sx, sy, sw, sh, { r: 22 })}
${surface(sx + 20, sy + 20, sw - 40, 200, C.blue, 16)}
<circle cx="${sx + sw / 2}" cy="${sy + 120}" r="40" fill="${C.white}"/>
<path d="M${sx + sw / 2 - 12} ${sy + 98} l 34 22 l -34 22 Z" fill="${C.blue}"/>
<rect x="${sx + 20}" y="${sy + 240}" width="${sw - 40}" height="10" rx="5" fill="${C.mist}"/>
<rect x="${sx + 20}" y="${sy + 240}" width="${Math.round((sw - 40) * 0.62)}" height="10" rx="5" fill="${C.purple}"/>
${textLines(sx + 20, sy + 262, [120], { h: 8, fill: [C.gray] })}
<!-- A turma -->
${[0, 1, 2, 3, 4].map((i) => avatar(sx + 60 + i * 70, 560, 30, { bg: C.white, fg: C.purple })).join('\n')}
${flow(sx + sw + 12, 330, 778, 330, { end: C.purple })}
<!-- Certificado com o selo -->
${doc(790, 220, 230, 300, { fold: 44 })}
${textLines(824, 262, [140], { h: 12, fill: [C.ink] })}
${textLines(824, 292, [160, 120, 140], { h: 8, gap: 12, fill: [C.gray, C.mist, C.mist] })}
<rect x="824" y="372" width="120" height="3" fill="${C.mist}"/>
${diamond(950, 460, 64, C.pink)}
${check(950, 460, 1.3, C.white, 5)}
${trail(160, 700, 14)}`
}
