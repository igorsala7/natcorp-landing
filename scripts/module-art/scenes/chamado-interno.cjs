/** Chamado Interno: a dúvida vira chamado com SLA, é atendida e fecha com status concluído. */
module.exports = (k) => {
  const { C, stage, card, avatar, textLines, diamond, pill, check, trail } = k
  /** Relógio pequeno de SLA (traço, sem núcleo). */
  const clock = (cx, cy, r) => `<circle cx="${cx}" cy="${cy}" r="${r}" fill="${C.white}" stroke="${C.purple}" stroke-width="5"/>
<path d="M${cx} ${cy - r * 0.55} V${cy} H${cx + r * 0.45}" fill="none" stroke="${C.purple}" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>`
  /** Balão em um só caminho (cauda integrada), com halo branco para se destacar do palco. */
  const speech = (x, y, w, h, o = {}) => {
    const r = 22
    const tail = o.right
      ? `H${x + w - 14} L${x + w - 12} ${y + h + 18} L${x + w - 26} ${y + h}`
      : `H${x + 26} L${x + 12} ${y + h + 18} L${x + 14} ${y + h}`
    const d = `M${x + r} ${y} H${x + w - r} a${r} ${r} 0 0 1 ${r} ${r} V${y + h - r} a${r} ${r} 0 0 1 -${r} ${r} ${tail} H${x + r} a${r} ${r} 0 0 1 -${r} -${r} V${y + r} a${r} ${r} 0 0 1 ${r} -${r} Z`
    return `<path d="${d}" fill="${o.fill || C.mist}" stroke="${C.white}" stroke-width="6" stroke-linejoin="round"/>`
  }
  /** Pílula de status sem texto: fundo em Névoa com halo, módulo pequeno e barra. */
  const chip = (x, y, w, h, dot, bar) => `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${h / 2}" fill="${C.mist}" stroke="${C.white}" stroke-width="6"/>
${diamond(x + 24, y + h / 2, 16, dot)}
<rect x="${x + 42}" y="${y + h / 2 - 5}" width="${w - 66}" height="10" rx="5" fill="${bar}"/>`
  return `
${stage(600, 420)}
<!-- Cabeçalho do chamado: número, fila e SLA -->
${card(330, 150, 540, 84, { r: 22 })}
${diamond(372, 192, 30, C.purple)}
${textLines(402, 176, [170, 110], { h: 10, gap: 12, fill: [C.ink, C.gray] })}
${clock(736, 192, 22)}
${pill(772, 176, 70, 32, '4h', { size: 15 })}
<!-- Conversa: quem pede e quem atende -->
${avatar(270, 300, 30)}
${speech(320, 262, 360, 80)}
${textLines(350, 284, [250, 170], { h: 10, gap: 12, fill: [C.ink, C.graphite] })}
${avatar(930, 430, 30, { bg: C.purple, fg: C.white })}
${speech(520, 392, 360, 80, { fill: C.purple, right: true })}
${textLines(550, 414, [260, 150], { h: 10, gap: 12, fill: [C.white, C.mist] })}
${speech(320, 512, 260, 64)}
${textLines(350, 539, [170], { h: 10, fill: [C.ink] })}
<!-- Status: aberto, em atendimento e concluído -->
${chip(330, 610, 160, 40, C.gray, C.gray)}
${chip(510, 610, 160, 40, C.purple, C.purple)}
<rect x="690" y="610" width="160" height="40" rx="20" fill="${C.pink}"/>
${check(714, 630, 0.8, C.white, 4)}
<rect x="736" y="625" width="90" height="10" rx="5" fill="${C.white}"/>
${trail(160, 700, 14)}`
}
