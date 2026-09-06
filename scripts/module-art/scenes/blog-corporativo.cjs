/** Blog Corporativo: a linha do tempo de comunicados, lida no portal e no celular. */
module.exports = (k) => {
  const { C, stage, card, surface, avatar, textLines, diamond, phone, flow, trail } = k
  const X = 250 // eixo da linha do tempo
  const posts = [235, 420, 595]
  return `
${stage(600, 420)}
<!-- Linha do tempo -->
<line x1="${X}" y1="165" x2="${X}" y2="670" stroke="${C.purple}" stroke-width="4" stroke-linecap="round"/>
${posts.map((y) => `<line x1="${X}" y1="${y}" x2="300" y2="${y}" stroke="${C.purple}" stroke-width="3"/>${diamond(X, y, 26, C.purple)}`).join('\n')}
<!-- Post com vídeo -->
${card(300, 150, 440, 170)}
${surface(320, 170, 180, 130, C.mist, 14)}
<circle cx="410" cy="235" r="28" fill="${C.purple}"/>
<path d="M401 221 L425 235 L401 249 Z" fill="${C.white}"/>
${textLines(520, 192, [190, 130, 160], { h: 12, gap: 14, fill: [C.ink, C.gray, C.mist] })}
<!-- Post de texto -->
${card(300, 350, 440, 140)}
${avatar(345, 393, 24)}
${textLines(385, 383, [190, 120], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${textLines(320, 436, [390, 300], { h: 10, gap: 12, fill: C.mist })}
<!-- Comunicado em destaque -->
${card(300, 520, 440, 150)}
${diamond(362, 595, 60, C.pink)}
${textLines(414, 565, [220, 160, 200], { h: 12, gap: 14, fill: [C.ink, C.gray, C.mist] })}
<!-- Leitura no celular -->
${flow(748, 420, 786, 420, { end: C.purple })}
${phone(800, 250, 170, 340, { r: 30, bezel: 10 })}
${surface(822, 290, 126, 64, C.mist, 12)}
<circle cx="846" cy="322" r="12" fill="${C.purple}"/>
<path d="M842 316 L852 322 L842 328 Z" fill="${C.white}"/>
${textLines(866, 312, [60, 40], { h: 7, gap: 7, fill: [C.ink, C.gray] })}
${surface(822, 366, 126, 64, C.mist, 12)}
${avatar(846, 398, 12, { bg: C.white })}
${textLines(866, 388, [60, 40], { h: 7, gap: 7, fill: [C.ink, C.gray] })}
${surface(822, 442, 126, 64, C.mist, 12)}
${diamond(846, 474, 22, C.purple)}
${textLines(866, 464, [60, 40], { h: 7, gap: 7, fill: [C.ink, C.gray] })}
<rect x="860" y="562" width="50" height="6" rx="3" fill="${C.mist}"/>
${trail(160, 700, 14)}`
}
