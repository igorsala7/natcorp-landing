/** Infraestrutura e Segurança: nuvem com escudo, servidores dedicados, backup em ciclo e acesso protegido. */
module.exports = (k) => {
  const { C, stage, card, surface, diamond, trail, r2 } = k
  /** Nuvem geométrica: união de discos e uma base; desenhada duas vezes (halo branco e Névoa). */
  const cloud = (fill, pad) => `<g fill="${fill}">
<circle cx="470" cy="360" r="${72 + pad}"/><circle cx="590" cy="300" r="${108 + pad}"/><circle cx="725" cy="360" r="${72 + pad}"/>
<rect x="${398 - pad}" y="${352 - pad}" width="${400 + pad * 2}" height="${96 + pad * 2}" rx="${48 + pad}"/>
</g>`
  const rad = (d) => (d * Math.PI) / 180
  /** Setas em círculo (backup): dois arcos com ponta. */
  const cycle = (cx, cy, r) => {
    const p = (a) => [cx + Math.cos(a) * r, cy + Math.sin(a) * r]
    const seg = (d0, d1) => {
      const [x0, y0] = p(rad(d0)).map(r2)
      const [x1, y1] = p(rad(d1)).map(r2)
      return `<path d="M${x0} ${y0} A${r} ${r} 0 0 1 ${x1} ${y1}" fill="none" stroke="${C.purple}" stroke-width="6" stroke-linecap="round"/>`
    }
    const head = (d) => {
      const a = rad(d)
      const [x, y] = p(a)
      const tx = -Math.sin(a)
      const ty = Math.cos(a)
      const nx = Math.cos(a)
      const ny = Math.sin(a)
      return `<path d="M${r2(x + tx * 16)} ${r2(y + ty * 16)} L${r2(x + nx * 10)} ${r2(y + ny * 10)} L${r2(x - nx * 10)} ${r2(y - ny * 10)} Z" fill="${C.purple}"/>`
    }
    return seg(-150, -30) + head(-30) + seg(30, 150) + head(150)
  }
  /** Azulejo de servidor: cartão com barras empilhadas. */
  const server = (x, y) => `${card(x, y, 130, 120, { r: 16 })}
${[0, 1, 2].map((i) => `<rect x="${x + 18}" y="${y + 20 + i * 30}" width="94" height="20" rx="6" fill="${i === 2 ? C.gray : C.blue}"/><circle cx="${x + 100}" cy="${y + 30 + i * 30}" r="3.5" fill="${C.white}"/>`).join('')}`
  return `
${stage(600, 420)}
<!-- Nuvem -->
${cloud(C.white, 8)}
${cloud(C.mist, 0)}
<!-- Escudo com o dado protegido -->
<path d="M600 244 L666 268 V322 C666 376 630 412 600 424 C570 412 534 376 534 322 V268 Z" fill="${C.purple}"/>
${diamond(600, 334, 44, C.pink)}
<!-- Cadeado: acesso por perfil e dois fatores -->
<path d="M262 318 V294 a28 28 0 0 1 56 0 V318" fill="none" stroke="${C.blue}" stroke-width="8" stroke-linecap="round"/>
${surface(250, 318, 80, 64, C.purple, 14)}
${diamond(290, 350, 16, C.white)}
<!-- Backup: cópias em ciclo -->
${cycle(920, 330, 42)}
<!-- Servidores dedicados: produção, homologação e contingência -->
${server(410, 490)}
${server(545, 490)}
${server(680, 490)}
${trail(160, 700, 14)}`
}
