/** NatPay: o pedido no WhatsApp, o valor liberado via Pix e o desconto que já entra na folha. */
module.exports = (k) => {
  const { C, stage, card, phone, bubble, avatar, diamond, textLines, checkBadge, label, flow, doc, surface, trail } = k
  const px = 470, py = 110, pw = 270, ph = 560
  // Calendário de dias trabalhados (limite do adiantamento)
  const days = []
  for (let r = 0; r < 3; r++) {
    for (let c = 0; c < 7; c++) {
      const i = r * 7 + c
      const fill = i < 15 ? C.purple : i === 15 ? C.blue : C.mist
      days.push(`<rect x="${186 + c * 28}" y="${330 + r * 28}" width="20" height="20" rx="5" fill="${fill}"/>`)
    }
  }
  // Holerite com a linha do desconto
  const rows = [496, 528, 560]
    .map((y, i) => {
      if (i === 2) {
        return `${surface(814, y - 9, 212, 28, C.mist, 8)}
<rect x="822" y="${y}" width="100" height="10" rx="5" fill="${C.purple}"/>
<rect x="960" y="${y}" width="58" height="10" rx="5" fill="${C.blue}"/>`
      }
      return `<rect x="822" y="${y}" width="${[90, 110][i]}" height="10" rx="5" fill="${C.mist}"/>
<rect x="${1018 - [50, 40][i]}" y="${y}" width="${[50, 40][i]}" height="10" rx="5" fill="${C.gray}"/>`
    })
    .join('\n')
  return `
${stage(600, 420)}
<!-- Conversa no WhatsApp -->
${phone(px, py, pw, ph, { r: 40, bezel: 12 })}
<rect x="${px + 12}" y="${py + 12}" width="${pw - 24}" height="76" rx="28" fill="${C.purple}"/>
<rect x="${px + 12}" y="${py + 50}" width="${pw - 24}" height="38" fill="${C.purple}"/>
${avatar(px + 50, py + 50, 18, { bg: C.white, fg: C.purple })}
<rect x="${px + 78}" y="${py + 40}" width="100" height="10" rx="5" fill="${C.white}" fill-opacity="0.9"/>
<rect x="${px + 78}" y="${py + 56}" width="60" height="8" rx="4" fill="${C.white}" fill-opacity="0.5"/>
${bubble(px + 28, py + 118, 176, 64)}
${textLines(px + 48, py + 136, [120, 80], { h: 10, gap: 10, fill: [C.ink, C.graphite] })}
${bubble(px + 64, py + 214, 178, 92, { right: true, fill: C.purple })}
<rect x="${px + 84}" y="${py + 232}" width="120" height="10" rx="5" fill="${C.white}" fill-opacity="0.9"/>
<rect x="${px + 84}" y="${py + 250}" width="80" height="8" rx="4" fill="${C.white}" fill-opacity="0.55"/>
<rect x="${px + 84}" y="${py + 270}" width="138" height="24" rx="12" fill="${C.white}"/>
<rect x="${px + 120}" y="${py + 278}" width="66" height="8" rx="4" fill="${C.purple}"/>
${bubble(px + 28, py + 340, 150, 56)}
${checkBadge(px + 56, py + 368, 14)}
<rect x="${px + 80}" y="${py + 362}" width="70" height="10" rx="5" fill="${C.ink}"/>
<rect x="${px + 80}" y="${py + 378}" width="46" height="8" rx="4" fill="${C.gray}"/>
<rect x="${px + 28}" y="${py + ph - 70}" width="${pw - 56}" height="40" rx="20" fill="${C.mist}"/>
<rect x="${px + 46}" y="${py + ph - 55}" width="90" height="10" rx="5" fill="${C.gray}" fill-opacity="0.6"/>
<circle cx="${px + pw - 48}" cy="${py + ph - 50}" r="14" fill="${C.purple}"/>
<rect x="${px + 100}" y="${py + ph - 22}" width="70" height="6" rx="3" fill="${C.mist}"/>
<!-- Limite pelos dias trabalhados -->
${card(160, 300, 240, 200, { r: 22 })}
${days.join('\n')}
<rect x="186" y="440" width="188" height="12" rx="6" fill="${C.mist}"/>
<rect x="186" y="440" width="118" height="12" rx="6" fill="${C.purple}"/>
${flow(404, 400, 452, 400, { end: C.purple })}
<!-- Valor liberado via Pix -->
${flow(744, 300, 790, 300, { end: C.purple })}
${card(800, 190, 240, 180, { r: 22 })}
${label(830, 264, 'R$', { size: 40, weight: 800 })}
<rect x="900" y="240" width="60" height="18" rx="9" fill="${C.ink}"/>
${diamond(990, 250, 58, C.pink)}
${diamond(990, 250, 22, C.white)}
${textLines(830, 300, [160, 110], { h: 10, gap: 10, fill: [C.graphite, C.gray] })}
<!-- Desconto automático na folha -->
${flow(920, 374, 920, 402, { end: C.purple })}
${doc(800, 410, 240, 260, { fold: 34 })}
${textLines(822, 438, [110, 70], { h: 9, gap: 8, fill: [C.ink, C.gray] })}
<rect x="822" y="478" width="196" height="3" fill="${C.mist}"/>
${rows}
${surface(822, 606, 196, 40, C.purple, 10)}
<rect x="838" y="620" width="70" height="12" rx="6" fill="${C.white}" fill-opacity="0.8"/>
<rect x="948" y="620" width="54" height="12" rx="6" fill="${C.white}"/>
${trail(160, 700, 14)}`
}
