/** Conexão com Outros Sistemas: o Natcorp no centro, ligado aos demais sistemas; o dado corre pela linha. */
module.exports = (k) => {
  const { C, stage, textLines, diamond, bars, heart, door, doc, label, trail } = k
  const cx = 600
  const cy = 420
  const sats = [[390, 210], [810, 210], [300, 420], [900, 420], [390, 630], [810, 630]]
  /** Azulejo satélite em Névoa, com halo branco para se destacar do palco. */
  const tile = (x, y) => `<rect x="${x - 65}" y="${y - 50}" width="130" height="100" rx="18" fill="${C.mist}" stroke="${C.white}" stroke-width="6"/>`
  /** Relógio de ponto (traço, sem núcleo). */
  const clock = (x, y, r) => `<circle cx="${x}" cy="${y}" r="${r}" fill="${C.white}" stroke="${C.graphite}" stroke-width="5"/>
<path d="M${x} ${y - r * 0.55} V${y} H${x + r * 0.45}" fill="none" stroke="${C.graphite}" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>`
  return `
${stage(600, 420)}
<!-- Linhas de integração -->
<g stroke="${C.purple}" stroke-width="3" stroke-linecap="round">
${sats.map(([x, y]) => `<line x1="${cx}" y1="${cy}" x2="${x}" y2="${y}"/>`).join('\n')}
</g>
<!-- Sistemas satélites: ERP, financeiro, ponto, benefícios, acesso e arquivos -->
${sats.map(([x, y]) => tile(x, y)).join('\n')}
${bars(358, 182, 64, 56, [30, 52, 40, 60], { gap: 6, fills: [C.gray, C.gray, C.gray, C.gray] })}
${label(810, 222, 'R$', { size: 30, weight: 800, fill: C.graphite, anchor: 'middle' })}
${clock(300, 420, 28)}
${heart(900, 420, 2.8, C.gray)}
${door(360, 600, 40, 60, { frame: C.graphite, leaf: C.gray })}
${doc(786, 598, 48, 64, { fold: 16, stroke: C.gray })}
${textLines(797, 616, [24, 28, 20], { h: 5, gap: 6, fill: C.gray })}
<!-- O sistema Natcorp -->
${diamond(cx, cy, 200, C.purple)}
<g fill="none" stroke="${C.white}" stroke-width="6" stroke-linecap="round" stroke-linejoin="round">
<path d="M574 396 L550 420 L574 444"/>
<path d="M626 396 L650 420 L626 444"/>
</g>
<!-- Pacote de dados a caminho -->
${diamond(686, 334, 12, C.pink, 'fill-opacity="0.25"')}
${diamond(702, 318, 18, C.pink, 'fill-opacity="0.5"')}
${diamond(722, 298, 28, C.pink)}
${trail(160, 700, 14)}`
}
