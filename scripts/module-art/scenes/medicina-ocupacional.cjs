/** Medicina Ocupacional: o exame agendado, o ASO na prancheta e a clínica que atende. */
module.exports = (k) => {
  const { C, stage, card, surface, diamond, textLines, avatar, checkBadge, flow, trail } = k
  // Calendário de exames: grade de pontos com os agendados
  const dots = []
  for (let r = 0; r < 4; r++) {
    for (let c = 0; c < 7; c++) {
      const cx = 178 + c * 26
      const cy = 330 + r * 34
      if (r === 3 && c === 1) {
        dots.push(`<circle cx="${cx}" cy="${cy}" r="10" fill="${C.white}" stroke="${C.purple}" stroke-width="3"/><circle cx="${cx}" cy="${cy}" r="4" fill="${C.purple}"/>`)
      } else {
        const on = (r === 1 && c === 2) || (r === 2 && c === 4)
        dots.push(`<circle cx="${cx}" cy="${cy}" r="6" fill="${on ? C.purple : C.mist}"/>`)
      }
    }
  }
  // Exames do ASO
  const exams = [452, 494, 536]
    .map((y, i) => `${checkBadge(478, y, 14)}
<rect x="504" y="${y - 5}" width="${[140, 110, 160][i]}" height="10" rx="5" fill="${C.mist}"/>
<rect x="700" y="${y - 5}" width="40" height="10" rx="5" fill="${C.gray}"/>`)
    .join('\n')
  return `
${stage(600, 420)}
<!-- Prancheta com o ASO -->
${surface(410, 160, 380, 510, C.purple, 24)}
${card(432, 196, 336, 452, { r: 14, stroke: null })}
<rect x="556" y="138" width="88" height="46" rx="16" fill="${C.blue}"/>
<rect x="586" y="150" width="28" height="8" rx="4" fill="${C.white}" fill-opacity="0.7"/>
${diamond(556, 270, 40, C.purple)}
${diamond(644, 270, 40, C.purple)}
${diamond(600, 226, 40, C.purple)}
${diamond(600, 314, 40, C.purple)}
${diamond(600, 270, 40, C.pink)}
${avatar(492, 380, 22)}
${textLines(526, 370, [110, 70], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
<rect x="460" y="420" width="280" height="3" fill="${C.mist}"/>
${exams}
${surface(460, 580, 280, 44, C.purple, 12)}
<rect x="480" y="596" width="120" height="12" rx="6" fill="${C.white}" fill-opacity="0.85"/>
${diamond(710, 602, 16, C.white)}
<!-- Calendário de exames -->
${card(150, 260, 210, 220, { r: 20 })}
<rect x="150" y="260" width="210" height="44" rx="20" fill="${C.blue}"/>
<rect x="150" y="282" width="210" height="22" fill="${C.blue}"/>
<rect x="172" y="276" width="60" height="10" rx="5" fill="${C.white}" fill-opacity="0.85"/>
${dots.join('\n')}
${flow(366, 370, 402, 370, { end: C.purple })}
<!-- Clínica -->
${flow(798, 380, 842, 380, { end: C.purple })}
${card(850, 280, 200, 200, { r: 20 })}
<rect x="876" y="452" width="148" height="6" rx="3" fill="${C.mist}"/>
<rect x="890" y="340" width="120" height="110" rx="10" fill="${C.purple}"/>
<rect x="944" y="356" width="12" height="38" rx="3" fill="${C.white}"/>
<rect x="931" y="369" width="38" height="12" rx="3" fill="${C.white}"/>
<rect x="902" y="420" width="20" height="16" rx="4" fill="${C.white}" fill-opacity="0.9"/>
<rect x="978" y="420" width="20" height="16" rx="4" fill="${C.white}" fill-opacity="0.9"/>
<rect x="937" y="416" width="26" height="34" rx="6" fill="${C.blue}"/>
${trail(160, 700, 14)}`
}
