/**
 * Kit vetorial dos módulos Natcorp: paleta, geometria do módulo (manual v1.2) e primitivas
 * para os ícones (glifo branco em losango com gradiente) e para as ilustrações (planas, grade a 45°).
 * Tudo gera strings SVG; sem dependências.
 */

const C = {
  purple: '#511C76',
  blue: '#2C1A63',
  pink: '#C95788',
  plum: '#9A408A',
  mix80: '#692878',
  mix60: '#81347D',
  ink: '#1B1238',
  graphite: '#4A4460',
  gray: '#8E88A3',
  mist: '#E9E5F1',
  off: '#F4F2F7',
  white: '#FFFFFF',
  highlight: '#E4A9C4',
  rose: '#F3C9DA',
}

const FONT = 'Manrope, Arial, sans-serif'
const r2 = (n) => Math.round(n * 100) / 100

/** Caminho de um módulo (quadrado de lado x, cantos 0,17x) centrado em (cx, cy), girado 45°. */
function modulePath(cx, cy, x, radiusRatio = 0.17) {
  const h = x / 2
  const r = x * radiusRatio
  const k = 0.5523 * r
  const a = h - r
  // quadrado arredondado em coordenadas locais (centro 0,0), depois rotação de 45°
  const pts = [
    ['M', [-a, -h]], ['L', [a, -h]], ['C', [a + k, -h], [h, -a - k], [h, -a]],
    ['L', [h, a]], ['C', [h, a + k], [a + k, h], [a, h]],
    ['L', [-a, h]], ['C', [-a - k, h], [-h, a + k], [-h, a]],
    ['L', [-h, -a]], ['C', [-h, -a - k], [-a - k, -h], [-a, -h]],
  ]
  const s = Math.SQRT1_2
  const tf = ([px, py]) => [r2(cx + (px - py) * s), r2(cy + (px + py) * s)]
  return pts.map(([cmd, ...cs]) => cmd + cs.map(tf).map((p) => p.join(' ')).join(' ')).join(' ') + ' Z'
}

/* ------------------------------------------------------------------------------------------------
 * Ícone: 1024 x 1024, um módulo em gradiente 135° com o glifo branco (grade de 24) e um acento rosa.
 * ---------------------------------------------------------------------------------------------- */
const ICON = { size: 1024, moduleSide: 620, grid: 24, glyphBox: 440, stroke: 1.8 }

function iconSvg(glyph, opts = {}) {
  const { size, moduleSide, grid, glyphBox } = ICON
  const c = size / 2
  const half = (moduleSide * Math.SQRT2) / 2 // meia diagonal do losango
  const scale = glyphBox / grid
  const offset = c - glyphBox / 2
  const id = opts.id || 'g'
  const stroke = ICON.stroke
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${size}" height="${size}" viewBox="0 0 ${size} ${size}" role="img" aria-label="${escapeAttr(opts.label || '')}">
  <defs>
    <linearGradient id="${id}-grad" gradientUnits="userSpaceOnUse" x1="${r2(c - half)}" y1="${r2(c - half)}" x2="${r2(c + half)}" y2="${r2(c + half)}">
      <stop offset="0" stop-color="${C.plum}"/>
      <stop offset="0.5" stop-color="${C.purple}"/>
      <stop offset="1" stop-color="${C.blue}"/>
    </linearGradient>
    <clipPath id="${id}-tile"><path d="${modulePath(c, c, moduleSide)}"/></clipPath>
  </defs>
  <path d="${modulePath(c, c, moduleSide)}" fill="url(#${id}-grad)"/>
  <g clip-path="url(#${id}-tile)" fill="none" stroke="${C.white}" stroke-opacity="0.1" stroke-width="30">
    <path d="${modulePath(c + 250, c - 250, 560)}"/>
  </g>
  <g transform="translate(${offset} ${offset}) scale(${scale})" fill="none" stroke="${C.white}" stroke-width="${stroke}" stroke-linecap="round" stroke-linejoin="round">
${indent(glyph, 4)}
  </g>
</svg>
`
}

/** Acento do glifo: um módulo pequeno preenchido em Rosa (na grade de 24). */
function accent(cx, cy, size = 3.2) {
  return `<path d="${modulePath(cx, cy, size / Math.SQRT2)}" fill="${C.pink}" stroke="none"/>`
}
/** Módulo pequeno em traço (grade de 24). */
function moduleOutline(cx, cy, size = 3.2, extra = '') {
  return `<path d="${modulePath(cx, cy, size / Math.SQRT2)}" ${extra}/>`
}
/** Pessoa mínima na grade de 24: cabeça + ombros. */
function person(cx, cy, s = 1) {
  return `<circle cx="${cx}" cy="${r2(cy - 2.2 * s)}" r="${r2(1.9 * s)}"/><path d="M${r2(cx - 3.4 * s)} ${r2(cy + 3.2 * s)} a3.4 3.4 0 0 1 6.8 0" transform="scale(1)"/>`.replace('a3.4 3.4 0 0 1 6.8 0', `a${r2(3.4 * s)} ${r2(3.4 * s)} 0 0 1 ${r2(6.8 * s)} 0`)
}
function rr(x, y, w, h, r = 2) {
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${r}"/>`
}

/* ------------------------------------------------------------------------------------------------
 * Ilustração: 1200 x 800, fundo branco, contorno da marca no canto superior direito, cena plana.
 * ---------------------------------------------------------------------------------------------- */
const ILL = { w: 1200, h: 800, stroke: 3 }

function illustrationSvg(scene, opts = {}) {
  const { w, h } = ILL
  const id = opts.id || 'i'
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${w}" height="${h}" viewBox="0 0 ${w} ${h}" role="img" aria-label="${escapeAttr(opts.label || '')}" font-family="${FONT}">
  <defs>
    <linearGradient id="${id}-grad" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="${C.plum}"/>
      <stop offset="0.5" stop-color="${C.purple}"/>
      <stop offset="1" stop-color="${C.blue}"/>
    </linearGradient>
    <clipPath id="${id}-clip"><rect width="${w}" height="${h}"/></clipPath>
  </defs>
  <rect width="${w}" height="${h}" fill="${C.white}"/>
  <g clip-path="url(#${id}-clip)">
${indent(contorno(), 4)}
${indent(scene, 4)}
  </g>
</svg>
`
}

/** O contorno do manual: o símbolo em um traço, grande, sangrando pelo canto superior direito, roxo a 22%. */
function contorno() {
  const cx = ILL.w + 60
  const cy = -40
  const x = 520 // lado de cada módulo
  const gap = 0.11 * x
  const d = (x + gap) / Math.SQRT2 // deslocamento do centro de cada módulo
  const parts = [
    [cx, cy - d],
    [cx + d, cy],
    [cx - d, cy],
    [cx, cy + d],
  ]
  return `<g fill="none" stroke="${C.purple}" stroke-opacity="0.22" stroke-width="${ILL.stroke}">
${parts.map(([px, py]) => `  <path d="${modulePath(px, py, x)}"/>`).join('\n')}
</g>`
}

/** Palco padrão da ilustração: um módulo grande em Névoa atrás da cena (grade a 45°). */
function stage(cx = 560, cy = 420, side = 430, fill = C.mist) {
  return `<path d="${modulePath(cx, cy, side)}" fill="${fill}"/>`
}
/** Coração (plano). */
function heart(cx, cy, s = 1, fill = C.pink) {
  return `<path transform="translate(${cx} ${cy}) scale(${s})" d="M0 9 C-2 7 -10 2.5 -10 -3.5 C-10 -7.5 -7 -10 -4 -10 C-2 -10 -0.7 -9 0 -7.5 C0.7 -9 2 -10 4 -10 C7 -10 10 -7.5 10 -3.5 C10 2.5 2 7 0 9 Z" fill="${fill}"/>`
}
/** Lupa (traço). */
function magnifier(cx, cy, r = 40, stroke = C.purple, width = 6) {
  const d = r * 0.7071
  return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="none" stroke="${stroke}" stroke-width="${width}"/><line x1="${r2(cx + d)}" y1="${r2(cy + d)}" x2="${r2(cx + d + r * 0.9)}" y2="${r2(cy + d + r * 0.9)}" stroke="${stroke}" stroke-width="${width * 1.4}" stroke-linecap="round"/>`
}
/** Mostrador de relógio: disco, marcas nos quatro pontos e ponteiros. */
function clockFace(cx, cy, r = 90, o = {}) {
  const hour = o.hour ?? 8
  const min = o.min ?? 0
  const ah = ((hour % 12) / 12 + min / 720) * Math.PI * 2 - Math.PI / 2
  const am = (min / 60) * Math.PI * 2 - Math.PI / 2
  const hx = r2(cx + Math.cos(ah) * r * 0.5)
  const hy = r2(cy + Math.sin(ah) * r * 0.5)
  const mx = r2(cx + Math.cos(am) * r * 0.72)
  const my = r2(cy + Math.sin(am) * r * 0.72)
  const stroke = o.stroke || C.purple
  const ticks = [0, 90, 180, 270]
    .map((deg) => {
      const a = (deg * Math.PI) / 180
      return `<line x1="${r2(cx + Math.cos(a) * r * 0.82)}" y1="${r2(cy + Math.sin(a) * r * 0.82)}" x2="${r2(cx + Math.cos(a) * r * 0.92)}" y2="${r2(cy + Math.sin(a) * r * 0.92)}" stroke="${stroke}" stroke-width="${o.tick || 5}" stroke-linecap="round"/>`
    })
    .join('')
  return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="${o.fill || C.white}" stroke="${o.ring || C.mist}" stroke-width="${o.ringWidth ?? 6}"/>${ticks}<line x1="${cx}" y1="${cy}" x2="${hx}" y2="${hy}" stroke="${stroke}" stroke-width="${o.hand || 7}" stroke-linecap="round"/><line x1="${cx}" y1="${cy}" x2="${mx}" y2="${my}" stroke="${stroke}" stroke-width="${o.hand || 7}" stroke-linecap="round"/>${diamond(cx, cy, o.core || 20, o.coreFill || C.purple)}`
}
/** Faísca de quatro pontas (a marca da NATI nas ilustrações). */
function spark(cx, cy, r = 40, fill = C.purple) {
  const k = r * 0.22
  return `<path d="M${cx} ${r2(cy - r)} L${r2(cx + k)} ${r2(cy - k)} L${r2(cx + r)} ${cy} L${r2(cx + k)} ${r2(cy + k)} L${cx} ${r2(cy + r)} L${r2(cx - k)} ${r2(cy + k)} L${r2(cx - r)} ${cy} L${r2(cx - k)} ${r2(cy - k)} Z" fill="${fill}"/>`
}
/** Balão de conversa (cauda embaixo à esquerda ou à direita). */
function bubble(x, y, w, h, o = {}) {
  const r = o.r ?? 22
  const right = !!o.right
  const tail = right
    ? `M${x + w - 26} ${y + h} l14 18 l-2 -18`
    : `M${x + 26} ${y + h} l-14 18 l2 -18`
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${r}" fill="${o.fill || C.mist}"/><path d="${tail}" fill="${o.fill || C.mist}"/>`
}
/** Porta (batente + folha aberta). */
function door(x, y, w, h, o = {}) {
  const frame = o.frame || C.blue
  const leaf = o.leaf || C.purple
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="10" fill="${C.mist}"/><path d="M${x + 14} ${y + h} V${y + 14} a8 8 0 0 1 8 -8 H${x + w - 22} a8 8 0 0 1 8 8 V${y + h}" fill="none" stroke="${frame}" stroke-width="${ILL.stroke * 2}"/><path d="M${x + w - 14} ${y + h} V${y + 12} L${x + w + 52} ${y - 8} V${y + h + 8} Z" fill="${leaf}"/><circle cx="${x + w + 32}" cy="${y + h / 2}" r="6" fill="${C.white}"/>`
}
/** Cartão branco com borda Névoa. */
function card(x, y, w, h, o = {}) {
  const fill = o.fill || C.white
  const stroke = o.stroke === null ? 'none' : o.stroke || C.mist
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${o.r ?? 18}" fill="${fill}" stroke="${stroke}" stroke-width="${ILL.stroke}"/>`
}
/** Superfície chapada (roxo, azul, névoa). */
function surface(x, y, w, h, fill = C.purple, r = 18) {
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${r}" fill="${fill}"/>`
}
/** Linhas de "texto": barras arredondadas. */
function textLines(x, y, widths, o = {}) {
  const h = o.h || 12
  const gap = o.gap || 14
  const fill = o.fill || C.mist
  return widths.map((wd, i) => `<rect x="${x}" y="${y + i * (h + gap)}" width="${wd}" height="${h}" rx="${h / 2}" fill="${Array.isArray(fill) ? fill[i] || C.mist : fill}"/>`).join('\n')
}
/** Pessoa abstrata: disco com cabeça e ombros. */
function avatar(cx, cy, r = 28, o = {}) {
  const bg = o.bg || C.mist
  const fg = o.fg || C.purple
  const s = r / 28
  return `<g>
  <circle cx="${cx}" cy="${cy}" r="${r}" fill="${bg}"/>
  <clipPath id="av-${cx}-${cy}"><circle cx="${cx}" cy="${cy}" r="${r}"/></clipPath>
  <g clip-path="url(#av-${cx}-${cy})" fill="${fg}">
    <circle cx="${cx}" cy="${r2(cy - 6 * s)}" r="${r2(10 * s)}"/>
    <path d="M${r2(cx - 19 * s)} ${r2(cy + 30 * s)} a19 19 0 0 1 38 0 Z" transform="translate(0 0)"/>
  </g>
</g>`.replace('a19 19 0 0 1 38 0', `a${r2(19 * s)} ${r2(19 * s)} 0 0 1 ${r2(38 * s)} 0`)
}
/** Módulo (losango arredondado) preenchido. */
function diamond(cx, cy, size, fill = C.purple, extra = '') {
  return `<path d="${modulePath(cx, cy, size / Math.SQRT2)}" fill="${fill}" ${extra}/>`
}
/** Barras verticais: roxo na série principal, rosa no destaque, cinza no comparativo. */
function bars(x, y, w, h, values, o = {}) {
  const n = values.length
  const gap = o.gap ?? 14
  const bw = (w - gap * (n - 1)) / n
  const max = Math.max(...values)
  return values
    .map((v, i) => {
      const bh = (v / max) * h
      const fill = i === o.highlight ? C.pink : o.fills?.[i] || C.purple
      return `<rect x="${r2(x + i * (bw + gap))}" y="${r2(y + h - bh)}" width="${r2(bw)}" height="${r2(bh)}" rx="${Math.min(8, bw / 2)}" fill="${fill}"/>`
    })
    .join('\n')
}
/** Linha de tendência com pontos em módulo. */
function lineChart(x, y, w, h, values, o = {}) {
  const max = Math.max(...values)
  const min = Math.min(...values)
  const pts = values.map((v, i) => [r2(x + (i / (values.length - 1)) * w), r2(y + h - ((v - min) / (max - min || 1)) * h)])
  const d = pts.map((p, i) => (i ? 'L' : 'M') + p.join(' ')).join(' ')
  const stroke = o.stroke || C.purple
  const last = pts[pts.length - 1]
  return `<path d="${d}" fill="none" stroke="${stroke}" stroke-width="${o.width || 4}" stroke-linecap="round" stroke-linejoin="round"/>
${o.dots === false ? '' : pts.map((p) => diamond(p[0], p[1], 12, C.white, `stroke="${stroke}" stroke-width="3"`)).join('\n')}
${diamond(last[0], last[1], 16, o.end || C.pink)}`
}
/** Marca de check. */
function check(cx, cy, s = 1, stroke = C.white, width = 4) {
  return `<path d="M${r2(cx - 9 * s)} ${r2(cy + 1 * s)} l${r2(6 * s)} ${r2(6 * s)} l${r2(12 * s)} ${r2(-13 * s)}" fill="none" stroke="${stroke}" stroke-width="${width}" stroke-linecap="round" stroke-linejoin="round"/>`
}
/** Selo redondo com check (verde só para variação positiva; aqui roxo/rosa). */
function checkBadge(cx, cy, r = 22, fill = C.purple) {
  return `<circle cx="${cx}" cy="${cy}" r="${r}" fill="${fill}"/>${check(cx, cy, r / 22)}`
}
/** Pílula com texto curto. */
function pill(x, y, w, h, text, o = {}) {
  const fill = o.fill || C.purple
  const color = o.color || C.white
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${h / 2}" fill="${fill}"/>
<text x="${x + w / 2}" y="${y + h / 2 + (o.size || 16) * 0.36}" text-anchor="middle" font-size="${o.size || 16}" font-weight="700" fill="${color}">${escapeText(text)}</text>`
}
function label(x, y, text, o = {}) {
  return `<text x="${x}" y="${y}" font-size="${o.size || 20}" font-weight="${o.weight || 700}" fill="${o.fill || C.ink}" text-anchor="${o.anchor || 'start'}"${o.spacing ? ` letter-spacing="${o.spacing}"` : ''}>${escapeText(text)}</text>`
}
/** Celular (frente): moldura Azul Profundo com tela branca. */
function phone(x, y, w, h, o = {}) {
  const b = o.bezel ?? 10
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${o.r ?? 34}" fill="${o.frame || C.blue}"/>
<rect x="${x + b}" y="${y + b}" width="${w - 2 * b}" height="${h - 2 * b}" rx="${(o.r ?? 34) - b}" fill="${o.screen || C.white}"/>`
}
/** Documento: cartão com canto dobrado. */
function doc(x, y, w, h, o = {}) {
  const f = o.fold ?? 34
  return `<path d="M${x + 18} ${y} H${x + w - f} L${x + w} ${y + f} V${y + h - 18} a18 18 0 0 1 -18 18 H${x + 18} a18 18 0 0 1 -18 -18 V${y + 18} a18 18 0 0 1 18 -18 Z" fill="${o.fill || C.white}" stroke="${o.stroke || C.mist}" stroke-width="${ILL.stroke}" stroke-linejoin="round"/>
<path d="M${x + w - f} ${y} V${y + f} H${x + w}" fill="none" stroke="${o.stroke || C.mist}" stroke-width="${ILL.stroke}" stroke-linejoin="round"/>`
}
/** Seta de fluxo com módulo na ponta. */
function flow(x1, y1, x2, y2, o = {}) {
  const stroke = o.stroke || C.purple
  return `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="${stroke}" stroke-width="${ILL.stroke}" stroke-linecap="round"${o.dashed ? ' stroke-dasharray="2 12"' : ''}/>
${diamond(x2, y2, 14, o.end || C.purple)}`
}
/** Trilha de módulos (divisor do manual): cinco passos esmaecendo. */
function trail(x, y, size = 14, fill = C.purple) {
  return [1, 0.7, 0.45, 0.25, 0.12].map((op, i) => diamond(x + i * size * 1.35, y, size, fill, `fill-opacity="${op}"`)).join('\n')
}
/** Grade a 45° sutil (pontos) para superfícies. */
function dotGrid(x, y, w, h, o = {}) {
  const step = o.step || 28
  const fill = o.fill || C.purple
  const out = []
  for (let yy = y + step / 2; yy < y + h; yy += step) {
    for (let xx = x + step / 2; xx < x + w; xx += step) {
      out.push(`<circle cx="${xx}" cy="${yy}" r="1.6" fill="${fill}" fill-opacity="${o.opacity ?? 0.18}"/>`)
    }
  }
  return out.join('')
}

function indent(s, n) {
  const pad = ' '.repeat(n)
  return s
    .split('\n')
    .filter((l) => l.trim().length)
    .map((l) => pad + l)
    .join('\n')
}
function escapeAttr(s) {
  return String(s).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;')
}
function escapeText(s) {
  return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;')
}

module.exports = { C, FONT, ICON, ILL, modulePath, iconSvg, accent, moduleOutline, person, rr, illustrationSvg, contorno, stage, heart, magnifier, clockFace, spark, bubble, door, card, surface, textLines, avatar, diamond, bars, lineChart, check, checkBadge, pill, label, phone, doc, flow, trail, dotGrid, r2 }
