/** Quadro de Vagas: o job board com a marca da empresa e a vaga nova em destaque. */
module.exports = (k) => {
  const { C, stage, card, diamond, textLines, pill, trail } = k
  const wx = 270, wy = 150, ww = 660, wh = 500
  const cols = [300, 508, 716]
  const rows = [318, 478]
  const cw = 184, ch = 136
  const job = (x, y, hot) => `
${card(x, y, cw, ch, { fill: hot ? C.white : C.off, stroke: hot ? C.purple : null, r: 16 })}
${diamond(x + 32, y + 34, 28, C.purple)}
${textLines(x + 54, y + 26, [84, 56], { h: 9, gap: 8, fill: [C.ink, C.gray] })}
${textLines(x + 22, y + 72, [140, 104], { h: 7, gap: 9, fill: [C.gray, C.gray] })}
${hot ? pill(x + cw - 82, y + ch - 38, 60, 22, 'Nova', { fill: C.pink, size: 12 }) : `<rect x="${x + 22}" y="${y + ch - 36}" width="58" height="18" rx="9" fill="${C.mist}"/>`}`
  return `
${stage(600, 420)}
<defs><clipPath id="qdv-win"><rect x="${wx}" y="${wy}" width="${ww}" height="${wh}" rx="22"/></clipPath></defs>
<!-- Janela do navegador -->
${card(wx, wy, ww, wh, { r: 22, stroke: null })}
<g clip-path="url(#qdv-win)">
  <rect x="${wx}" y="${wy}" width="${ww}" height="50" fill="${C.off}"/>
  <rect x="${wx}" y="${wy + 50}" width="${ww}" height="96" fill="${C.purple}"/>
</g>
${[0, 1, 2].map((i) => `<circle cx="${wx + 30 + i * 22}" cy="${wy + 25}" r="6" fill="${C.gray}"/>`).join('')}
<rect x="${wx + 110}" y="${wy + 12}" width="${ww - 150}" height="26" rx="13" fill="${C.white}" stroke="${C.mist}" stroke-width="3"/>
<!-- Cabeçalho com a marca da empresa -->
${diamond(wx + 60, wy + 98, 44, C.white)}
<rect x="${wx + 96}" y="${wy + 84}" width="130" height="12" rx="6" fill="${C.white}"/>
<rect x="${wx + 96}" y="${wy + 104}" width="86" height="10" rx="5" fill="${C.white}" fill-opacity="0.6"/>
${[0, 1, 2].map((i) => `<rect x="${wx + ww - 200 + i * 60}" y="${wy + 93}" width="40" height="10" rx="5" fill="${C.white}" fill-opacity="0.75"/>`).join('')}
<!-- Grade de vagas -->
${rows.map((y, ri) => cols.map((x, ci) => job(x, y, ri === 0 && ci === 0)).join('\n')).join('\n')}
<rect x="${wx}" y="${wy}" width="${ww}" height="${wh}" rx="22" fill="none" stroke="${C.mist}" stroke-width="3"/>
${trail(160, 700, 14)}`
}
