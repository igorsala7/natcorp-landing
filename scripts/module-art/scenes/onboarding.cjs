/** Onboarding: a porta aberta para quem chega, o checklist do primeiro dia e o lugar já reservado. */
module.exports = (k) => {
  const { C, stage, card, door, avatar, diamond, textLines, checkBadge, flow, trail } = k
  const dx = 230, dy = 200, dw = 180, dh = 340
  const row = (y, done) => `
${done ? checkBadge(640, y + 6, 16) : `<circle cx="640" cy="${y + 6}" r="14" fill="${C.white}" stroke="${C.mist}" stroke-width="4"/>`}
${textLines(670, y, [150, 90], { h: 10, gap: 10, fill: [C.ink, C.gray] })}`
  return `
${stage(600, 420)}
<!-- A porta aberta e quem chega -->
${door(dx, dy, dw, dh)}
<rect x="${dx + 17}" y="${dy + 17}" width="${dw - 34}" height="${dh - 17}" rx="6" fill="${C.white}"/>
${avatar(dx + dw / 2, dy + 236, 46, { bg: C.mist, fg: C.purple })}
${flow(478, 370, 586, 370, { end: C.purple })}
<!-- Checklist do primeiro dia -->
${card(600, 210, 300, 280)}
${textLines(640, 246, [160], { h: 12, fill: [C.ink] })}
<rect x="624" y="276" width="252" height="3" fill="${C.mist}"/>
${row(296, true)}
${row(352, true)}
${row(408, false)}
<!-- Boas-vindas: o lugar já reservado -->
${card(600, 530, 300, 100)}
${diamond(646, 580, 40, C.pink)}
${textLines(684, 566, [130, 80], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${trail(160, 700, 14)}`
}
