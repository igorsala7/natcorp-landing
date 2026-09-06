/** Carreira e Sucessão: os degraus da carreira e o mapa de quem está pronto para a próxima posição. */
module.exports = (k) => {
  const { C, stage, card, avatar, diamond, trail } = k
  const steps = [[300, 570], [420, 490], [540, 410]]
  const next = [660, 330]
  const readiness = (x, y, p) => `
<rect x="${x - 34}" y="${y}" width="68" height="8" rx="4" fill="${C.mist}"/>
<rect x="${x - 34}" y="${y}" width="${Math.round(68 * p)}" height="8" rx="4" fill="${C.purple}"/>`
  return `
${stage(600, 420)}
<!-- A escada da carreira: cada pessoa no seu degrau; o próximo à espera -->
${steps.map(([x, y]) => diamond(x, y, 116, C.purple)).join('\n')}
${steps.map(([x, y]) => avatar(x, y, 30, { bg: C.white, fg: C.purple })).join('\n')}
${diamond(next[0], next[1], 116, C.pink)}
<!-- Mapa de sucessão: a posição-chave e os sucessores com prontidão -->
${card(740, 190, 280, 320)}
<path d="M880 300 V340 H810 V386 M880 340 H950 V386" fill="none" stroke="${C.purple}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
${diamond(880, 250, 96, C.blue)}
${avatar(880, 250, 30, { bg: C.white, fg: C.blue })}
${avatar(810, 418, 30)}
${avatar(950, 418, 30)}
${readiness(810, 464, 0.8)}
${readiness(950, 464, 0.45)}
${trail(160, 700, 14)}`
}
