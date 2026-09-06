/** NatPonto: o rosto reconhecido no celular, com a localização confirmada. */
module.exports = (k) => {
  const { C, stage, card, phone, avatar, diamond, surface, checkBadge, textLines, pill, trail, clockFace, modulePath } = k
  const px = 470, py = 110, pw = 270, ph = 560
  return `
${stage(600, 420)}
<!-- Celular com a leitura do rosto -->
${phone(px, py, pw, ph, { r: 40, bezel: 12 })}
<rect x="${px + 12}" y="${py + 12}" width="${pw - 24}" height="70" rx="28" fill="${C.purple}"/>
<rect x="${px + 12}" y="${py + 54}" width="${pw - 24}" height="28" fill="${C.purple}"/>
<rect x="${px + 40}" y="${py + 40}" width="110" height="12" rx="6" fill="${C.white}" fill-opacity="0.85"/>
<!-- Moldura de leitura com o rosto -->
<g fill="none" stroke="${C.purple}" stroke-width="6" stroke-linecap="round">
  <path d="M${px + 60} ${py + 150} v-18 a10 10 0 0 1 10 -10 h18"/>
  <path d="M${px + pw - 60} ${py + 150} v-18 a10 10 0 0 0 -10 -10 h-18"/>
  <path d="M${px + 60} ${py + 300} v18 a10 10 0 0 0 10 10 h18"/>
  <path d="M${px + pw - 60} ${py + 300} v18 a10 10 0 0 1 -10 10 h-18"/>
</g>
${avatar(px + pw / 2, py + 225, 62, { bg: C.mist, fg: C.blue })}
<rect x="${px + 70}" y="${py + 222}" width="${pw - 140}" height="6" rx="3" fill="${C.pink}"/>
<!-- Resultado: batida confirmada -->
${surface(px + 40, py + 360, pw - 80, 110, C.mist, 20)}
${checkBadge(px + 78, py + 395, 18)}
${textLines(px + 106, py + 387, [80, 56], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${pill(px + 60, py + 428, pw - 120, 30, '08:02', { size: 15 })}
<rect x="${px + 100}" y="${py + ph - 36}" width="70" height="8" rx="4" fill="${C.mist}"/>
<!-- Localização -->
${card(160, 250, 250, 210)}
${[0, 1, 2, 3, 4].map((i) => `<line x1="180" y1="${290 + i * 36}" x2="390" y2="${290 + i * 36}" stroke="${C.mist}" stroke-width="3"/>`).join('')}
${[0, 1, 2, 3, 4].map((i) => `<line x1="${200 + i * 42}" y1="270" x2="${200 + i * 42}" y2="440" stroke="${C.mist}" stroke-width="3"/>`).join('')}
<path d="M285 320 c-30 0 -46 22 -46 46 c0 34 46 76 46 76 s46 -42 46 -76 c0 -24 -16 -46 -46 -46z" fill="${C.purple}"/>
${diamond(285, 366, 22, C.white)}
<!-- Horário apurado -->
${card(800, 300, 240, 170)}
${clockFace(860, 385, 46, { hour: 8, min: 2, hand: 5, tick: 4, core: 12 })}
${textLines(925, 360, [90, 64, 76], { h: 10, gap: 12, fill: [C.ink, C.gray, C.gray] })}
${trail(160, 700, 14)}`
}
