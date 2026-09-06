/** NATI: a pergunta feita no sistema e a resposta que já vem com o resultado e a ação feita. */
module.exports = (k) => {
  const { C, stage, card, bubble, spark, textLines, bars, avatar, diamond, pill, trail, checkBadge } = k
  return `
${stage(600, 420)}
<!-- Pergunta de quem usa -->
${avatar(250, 215, 30)}
${bubble(300, 180, 360, 70, { fill: C.mist })}
${textLines(330, 206, [250, 170], { h: 10, gap: 10, fill: [C.ink, C.graphite] })}
<!-- NATI responde: o selo em gradiente é a única exceção de gradiente nas ilustrações -->
<defs><linearGradient id="nati-g" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${C.plum}"/><stop offset="0.5" stop-color="${C.purple}"/><stop offset="1" stop-color="${C.blue}"/></linearGradient></defs>
<circle cx="330" cy="345" r="36" fill="url(#nati-g)"/>
${spark(330, 345, 22, C.white)}
${card(390, 290, 520, 330, { r: 26 })}
${textLines(430, 326, [230], { h: 12, fill: [C.ink] })}
${textLines(430, 352, [330, 260], { h: 10, gap: 10, fill: [C.graphite, C.gray] })}
${bars(430, 410, 290, 140, [46, 60, 52, 78, 88, 100], { highlight: 5, gap: 12 })}
<rect x="430" y="558" width="290" height="3" fill="${C.mist}"/>
${card(750, 410, 130, 100, { fill: C.off, stroke: null, r: 16 })}
${diamond(815, 446, 24, C.purple)}
${textLines(770, 470, [90, 60], { h: 8, gap: 8, fill: [C.ink, C.gray] })}
<!-- Ação executada dentro do sistema -->
${checkBadge(452, 588, 14)}
${textLines(476, 583, [150], { h: 10, fill: [C.graphite] })}
${pill(750, 570, 130, 30, 'Feito', { size: 14 })}
<!-- Faíscas ambiente -->
${spark(200, 520, 26, C.purple)}
${spark(980, 250, 16, C.purple)}
${trail(160, 700, 14)}`
}
