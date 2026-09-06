/** Business Intelligence: painéis em camadas, um para cada nível, com a barra principal em destaque. */
module.exports = (k) => {
  const { C, stage, card, avatar, textLines, diamond, bars, surface, trail, r2 } = k
  const W = 520
  const H = 380
  /** Linha de tendência sem ponto final em rosa (o rosa fica na barra principal). */
  const trend = (pts) => `<path d="${pts.map((p, i) => (i ? 'L' : 'M') + p.join(' ')).join(' ')}" fill="none" stroke="${C.blue}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
${pts.map(([x, y]) => diamond(x, y, 12, C.white, `stroke="${C.blue}" stroke-width="3"`)).join('\n')}`
  const bx = 410
  const bw = 300
  const gap = 14
  const n = 6
  const cw = (bw - gap * (n - 1)) / n
  const cx = (i) => r2(bx + i * (cw + gap) + cw / 2)
  const line = [470, 446, 436, 404, 388, 356].map((y, i) => [cx(i), y])
  return `
${stage(600, 420)}
<!-- Painéis por nível: os de trás -->
${card(300, 170, W, H, { r: 22 })}
${diamond(326, 191, 18, C.gray)}
<rect x="344" y="186" width="130" height="10" rx="5" fill="${C.mist}"/>
${card(340, 210, W, H, { r: 22 })}
${diamond(366, 231, 18, C.blue)}
<rect x="384" y="226" width="130" height="10" rx="5" fill="${C.mist}"/>
<!-- Painel da frente -->
${card(380, 250, W, H, { r: 22 })}
${avatar(420, 292, 22)}
${textLines(452, 282, [160, 100], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${bars(bx, 360, bw, 220, [40, 58, 50, 72, 64, 96], { highlight: 5, gap })}
<rect x="${bx}" y="586" width="${bw}" height="3" fill="${C.mist}"/>
${trend(line)}
<!-- Indicadores -->
${[340, 420, 500].map((y, i) => `${surface(740, y, 130, 64, C.mist, 14)}
<rect x="758" y="${y + 18}" width="${[70, 54, 62][i]}" height="12" rx="6" fill="${C.ink}"/>
<rect x="758" y="${y + 38}" width="40" height="8" rx="4" fill="${C.gray}"/>`).join('\n')}
${trail(160, 700, 14)}`
}
