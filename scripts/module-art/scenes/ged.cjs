/** GED: o documento enviado pelo celular entra na pasta da pessoa, indexado e pronto para a busca. */
module.exports = (k) => {
  const { C, stage, surface, doc, textLines, diamond, avatar, phone, magnifier, flow, trail } = k
  /** Etiqueta de indexação sem texto: fundo, módulo pequeno e barra. */
  const chip = (x, y, w, h, bg, dot, bar) => `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${h / 2}" fill="${bg}"/>
${diamond(x + 24, y + h / 2, 16, dot)}
<rect x="${x + 42}" y="${y + h / 2 - 5}" width="${w - 66}" height="10" rx="5" fill="${bar}"/>`
  return `
${stage(600, 420)}
<!-- Envio pelo celular -->
${phone(170, 290, 150, 270, { r: 28, bezel: 9 })}
${doc(198, 326, 94, 120, { fold: 24 })}
${textLines(214, 352, [50, 62, 40, 56], { h: 8, gap: 9, fill: C.mist })}
${surface(198, 470, 94, 30, C.purple, 15)}
${diamond(245, 485, 12, C.white)}
${flow(332, 425, 388, 425, { end: C.purple })}
<!-- Pasta da pessoa, com os documentos entrando -->
${surface(400, 236, 120, 60, C.blue, 16)}
${surface(400, 262, 380, 290, C.blue, 18)}
${doc(530, 200, 120, 170, { fold: 30 })}
${textLines(550, 228, [60, 76, 50, 66], { h: 8, gap: 10, fill: C.mist })}
${doc(650, 226, 118, 170, { fold: 30 })}
${textLines(670, 254, [60, 74, 50], { h: 8, gap: 10, fill: C.mist })}
${surface(400, 336, 380, 216, C.purple, 18)}
${avatar(462, 400, 30, { bg: C.white, fg: C.purple })}
${textLines(508, 388, [150, 100], { h: 10, gap: 10, fill: [C.white, C.mist] })}
<g opacity="0.45">${textLines(430, 462, [300, 240, 270], { h: 10, gap: 14, fill: C.white })}</g>
<!-- Busca e etiquetas de indexação -->
${magnifier(900, 300, 46, C.purple, 8)}
${chip(830, 440, 190, 40, C.mist, C.purple, C.purple)}
${chip(830, 496, 190, 40, C.mist, C.blue, C.gray)}
${chip(830, 552, 190, 40, C.pink, C.white, C.white)}
${trail(160, 700, 14)}`
}
