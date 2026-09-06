/** Assinatura Eletrônica: o documento assinado no celular ganha o selo de validade. */
module.exports = (k) => {
  const { C, stage, card, doc, textLines, diamond, checkBadge, phone, pill, flow, trail } = k
  const rows = [335, 415, 495]
  return `
${stage(600, 420)}
<!-- Acompanhamento por status -->
${card(160, 290, 150, 250)}
${rows.map((y, i) => `${i < 2 ? checkBadge(200, y, 16) : `<circle cx="200" cy="${y}" r="14" fill="${C.white}" stroke="${C.gray}" stroke-width="4"/>`}
<rect x="226" y="${y - 5}" width="60" height="10" rx="5" fill="${i < 2 ? C.ink : C.gray}"/>`).join('\n')}
<!-- Documento -->
${doc(340, 140, 400, 520, { fold: 48 })}
${textLines(380, 190, [200], { h: 14, fill: [C.ink] })}
${textLines(380, 232, [320, 300, 260, 320, 240], { h: 10, gap: 14, fill: C.mist })}
${textLines(380, 372, [300, 320, 200], { h: 10, gap: 14, fill: C.mist })}
<!-- Traço da assinatura -->
<rect x="380" y="600" width="210" height="3" fill="${C.mist}"/>
<path d="M384 594 C392 556 404 538 416 546 C430 556 418 596 404 600 C392 604 396 580 420 574 C446 568 466 562 480 578 C490 590 500 574 516 566 C534 556 552 572 586 562" fill="none" stroke="${C.purple}" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>
<!-- Selo de validade -->
${diamond(660, 580, 112, 'none', `stroke="${C.purple}" stroke-width="4"`)}
${diamond(660, 580, 52, C.pink)}
<!-- Assinar no celular -->
${phone(820, 300, 190, 340, { r: 32, bezel: 10 })}
${doc(846, 330, 138, 170, { fold: 28 })}
${textLines(864, 356, [80, 100, 70, 90, 60], { h: 8, gap: 10, fill: C.mist })}
${pill(846, 560, 138, 40, 'Assinar', { size: 16 })}
${flow(810, 470, 758, 470, { end: C.purple })}
${trail(160, 700, 14)}`
}
