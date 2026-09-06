/** Portais: três janelas em escada — gestor, candidato e colaborador — cada perfil vê o que é seu. */
module.exports = (k) => {
  const { C, stage, card, avatar, textLines, diamond, checkBadge, doc, trail } = k
  const W = 420
  const H = 280
  /** Janela de navegador: cartão com barra superior em Névoa e três pontos. */
  const win = (x, y) => `
${card(x, y, W, H, { r: 20 })}
<path d="M${x} ${y + 44} V${y + 20} a20 20 0 0 1 20 -20 H${x + W - 20} a20 20 0 0 1 20 20 V${y + 44} Z" fill="${C.mist}"/>
${[0, 1, 2].map((i) => `<circle cx="${x + 24 + i * 16}" cy="${y + 22}" r="4.5" fill="${C.gray}"/>`).join('')}`
  return `
${stage(600, 420)}
<!-- Portal do Gestor (ao fundo): a equipe e as aprovações -->
${win(200, 140)}
${avatar(244, 222, 22)}
${textLines(280, 212, [130, 90], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${[0, 1, 2].map((i) => `
${avatar(240, 300 + i * 45, 14, { fg: C.blue })}
<rect x="264" y="${295 + i * 45}" width="72" height="10" rx="5" fill="${C.mist}"/>
${checkBadge(360, 300 + i * 45, 12)}`).join('')}
<!-- Portal do Candidato (meio): o currículo e a seleção -->
${win(390, 265)}
${avatar(434, 347, 22)}
${textLines(470, 337, [130, 90], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${doc(414, 402, 96, 120, { fold: 26 })}
${textLines(432, 428, [50, 60, 40, 56], { h: 8, gap: 9, fill: C.mist })}
<!-- Portal do Colaborador (frente): os módulos, com o ponto de entrada em destaque -->
${win(580, 390)}
${avatar(624, 472, 22)}
${textLines(660, 462, [150, 100], { h: 10, gap: 10, fill: [C.ink, C.gray] })}
${[C.pink, C.purple, C.blue, C.purple].map((fill, i) => `
${diamond(650 + i * 90, 575, 56, fill)}
<rect x="${630 + i * 90}" y="618" width="40" height="8" rx="4" fill="${C.mist}"/>`).join('')}
${trail(160, 700, 14)}`
}
