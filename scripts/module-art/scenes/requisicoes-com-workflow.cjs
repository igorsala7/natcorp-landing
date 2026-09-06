/** Requisições com Workflow: o pedido passa pelas alçadas e, aprovado, vira módulo efetivado. */
module.exports = (k) => {
  const { C, stage, card, avatar, textLines, diamond, checkBadge, surface, check, trail } = k
  const Y = 390
  const approvers = [480, 620, 760]
  return `
${stage(600, 420)}
<!-- Pedido: o formulário enviado -->
${card(160, 280, 220, 220)}
${avatar(200, 320, 20)}
${textLines(230, 312, [100, 70], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${textLines(185, 362, [170, 130, 150], { h: 10, gap: 12, fill: C.mist })}
${surface(185, 438, 170, 36, C.purple, 18)}
${diamond(210, 456, 14, C.white)}
<rect x="228" y="451" width="90" height="10" rx="5" fill="${C.white}" fill-opacity="0.85"/>
<!-- Trilho de aprovação: alçadas em sequência -->
<line x1="380" y1="${Y}" x2="875" y2="${Y}" stroke="${C.purple}" stroke-width="3" stroke-linecap="round"/>
<!-- Ramo lateral: suplência -->
<path d="M620 ${Y + 36} V${Y + 104} M638 ${Y + 122} L734 ${Y + 26}" fill="none" stroke="${C.purple}" stroke-width="3" stroke-linecap="round" stroke-dasharray="2 10"/>
${avatar(620, Y + 130, 26, { bg: C.white, fg: C.gray })}
${approvers.map((x) => `${avatar(x, Y, 36, { bg: C.white })}${checkBadge(x + 26, Y + 26, 15)}`).join('\n')}
<!-- Efetivado: o pedido vira módulo -->
${diamond(930, Y, 110, C.pink)}
${check(930, Y, 2.2, C.white, 7)}
${trail(160, 700, 14)}`
}
