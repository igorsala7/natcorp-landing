/** Admissão Digital: o candidato envia documentos e assina pelo celular; o cadastro nasce pronto na folha. */
module.exports = (k) => {
  const { C, stage, doc, phone, avatar, textLines, surface, checkBadge, flow, trail } = k
  const px = 440, py = 160, pw = 250, ph = 510
  const sx = px + 12, sw = pw - 24
  const row = (y) => `
<rect x="${sx + 18}" y="${y}" width="26" height="34" rx="6" fill="${C.mist}"/>
${textLines(sx + 58, y + 8, [96, 64], { h: 8, gap: 9, fill: [C.ink, C.gray] })}
${checkBadge(sx + sw - 30, y + 17, 12)}`
  return `
${stage(600, 420)}
<!-- Candidato e seus documentos -->
${avatar(250, 300, 42)}
${doc(160, 370, 120, 150)}
${doc(190, 396, 120, 150)}
${textLines(212, 432, [70, 56, 62], { h: 8, gap: 10, fill: [C.ink, C.gray, C.mist] })}
${flow(322, 470, 428, 470, { end: C.purple })}
<!-- Celular: documentos conferidos e contrato assinado -->
${phone(px, py, pw, ph, { r: 40, bezel: 12 })}
<rect x="${sx}" y="${py + 12}" width="${sw}" height="66" rx="28" fill="${C.purple}"/>
<rect x="${sx}" y="${py + 50}" width="${sw}" height="28" fill="${C.purple}"/>
<rect x="${sx + 24}" y="${py + 38}" width="100" height="12" rx="6" fill="${C.white}" fill-opacity="0.85"/>
${row(py + 110)}
${row(py + 164)}
${row(py + 218)}
${surface(sx + 18, py + 288, sw - 36, 110, C.mist, 16)}
<path d="M${sx + 40} ${py + 356} c 18 -40 30 -44 26 -18 c -4 22 10 20 24 -8 c 10 -22 16 -8 22 4 c 6 12 20 8 44 -14" fill="none" stroke="${C.purple}" stroke-width="4" stroke-linecap="round"/>
<rect x="${sx + 40}" y="${py + 372}" width="${sw - 80}" height="3" fill="${C.purple}"/>
${surface(sx + 36, py + 424, sw - 72, 36, C.purple, 18)}
<rect x="${px + pw / 2 - 30}" y="${py + 436}" width="60" height="12" rx="6" fill="${C.white}" fill-opacity="0.85"/>
${flow(702, 430, 768, 430, { end: C.purple })}
<!-- Folha: cadastro criado, admissão fechada -->
${doc(780, 200, 240, 400, { fold: 44 })}
${avatar(822, 262, 22)}
${textLines(856, 252, [110, 70], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
<rect x="806" y="306" width="188" height="3" fill="${C.mist}"/>
${[0, 1, 2, 3].map((i) => `
  <rect x="806" y="${330 + i * 42}" width="${[100, 80, 110, 90][i]}" height="10" rx="5" fill="${C.mist}"/>
  <rect x="${994 - [50, 40, 60, 44][i]}" y="${330 + i * 42}" width="${[50, 40, 60, 44][i]}" height="10" rx="5" fill="${C.purple}"/>`).join('')}
${surface(806, 500, 188, 56, C.purple, 12)}
<rect x="822" y="522" width="70" height="12" rx="6" fill="${C.white}" fill-opacity="0.8"/>
<rect x="920" y="522" width="58" height="12" rx="6" fill="${C.white}"/>
${checkBadge(1006, 588, 28, C.pink)}
${trail(160, 700, 14)}`
}
