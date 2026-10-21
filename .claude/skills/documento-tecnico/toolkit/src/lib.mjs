// Utilitários compartilhados pelos infográficos do "NatPonto por dentro".
// Cada SVG sai autossuficiente (estilo embutido), mas usa as mesmas classes
// e as mesmas variáveis do estilo.css quando inserido no HTML.

export const C = {
  marca: '#511C76', marca2: '#2C1A63', rosa: '#C95788', rosaTexto: '#9A408A',
  tinta: '#1B1238', tinta2: '#4A4460', papel: '#F4F2F7', card: '#ffffff',
  ok: '#2E7D32', atencao: '#A15C00', erro: '#C62828', info: '#1F5FAD',
  m050: '#F4F2F7', m100: '#E9E5F1', m200: '#D4C6DD', m300: '#A88EBA',
  r050: '#FBF2F6', r100: '#F5E1EA', r200: '#ECC4D6',
  ok050: '#E9F4EA', at050: '#FFF4E2', at100: '#FCE3BC', er050: '#FDECEC', inf050: '#E8F0FA',
  linha: '#E9E5F1',
};

const STYLE = `
.ig-h{font-family:var(--f-titulo,'Manrope Variable','Manrope',Arial,sans-serif);font-weight:800;letter-spacing:-.01em;fill:${C.marca}}
.ig-t{font-family:var(--f-texto,'Manrope Variable','Manrope',Arial,sans-serif);font-size:12px;fill:${C.tinta}}
.ig-s{font-family:var(--f-texto,'Manrope Variable','Manrope',Arial,sans-serif);font-size:11px;fill:${C.tinta2}}
.ig-b{font-weight:600}
.ig-m{font-family:var(--f-mono,'Manrope Variable','Manrope',Arial,sans-serif);font-size:9.5px;letter-spacing:.1em;font-weight:700;fill:${C.tinta2}}
`.trim();

// Piso de tamanho de fonte (em unidades do viewBox), definido por figura conforme a
// largura em que ela é impressa, para que nenhum rótulo fique abaixo de ~6,5 pt.
let PISO = 0;
export const setPiso = (px) => { PISO = px || 0; };
export const pis = (size) => Math.max(size, PISO);
const PADRAO_CLASSE = { 'ig-t': 12, 'ig-s': 11, 'ig-m': 9.5, 'ig-h': 12 };

export const esc = (s) => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

export function svg({ w, h, titulo, desc, corpo, id }) {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${w} ${h}" width="${w}" height="${h}" role="img" aria-labelledby="${id}-t ${id}-d" class="infografico" data-infografico="${id}">
<title id="${id}-t">${esc(titulo)}</title>
<desc id="${id}-d">${esc(desc)}</desc>
<style>${STYLE}</style>
${corpo}
</svg>
`;
}

// Texto em várias linhas. lines: string | string[]
export function t(x, y, lines, { cls = 'ig-t', lh = 15, anchor = 'start', size, fill, weight, extra = '' } = {}) {
  const arr = Array.isArray(lines) ? lines : [lines];
  const base = size || PADRAO_CLASSE[cls.split(' ')[0]] || 12;
  if (PISO && base < PISO) size = PISO;
  const st = [size ? `font-size:${size}px` : '', fill ? `fill:${fill}` : '', weight ? `font-weight:${weight}` : ''].filter(Boolean).join(';');
  const spans = arr.map((l, i) => `<tspan x="${x}" ${i ? `dy="${lh}"` : ''}>${esc(l)}</tspan>`).join('');
  return `<text class="${cls}" x="${x}" y="${y}" text-anchor="${anchor}"${st ? ` style="${st}"` : ''} ${extra}>${spans}</text>`;
}

export function r(x, y, w, h, { rx = 10, fill = C.card, stroke = 'none', sw = 1, dash, op } = {}) {
  return `<rect x="${x}" y="${y}" width="${w}" height="${h}" rx="${rx}" fill="${fill}" stroke="${stroke}" stroke-width="${sw}"${dash ? ` stroke-dasharray="${dash}"` : ''}${op != null ? ` opacity="${op}"` : ''}/>`;
}

export const line = (x1, y1, x2, y2, { stroke = C.m200, sw = 2, dash, cap = 'round', extra = '' } = {}) =>
  `<line x1="${x1}" y1="${y1}" x2="${x2}" y2="${y2}" stroke="${stroke}" stroke-width="${sw}" stroke-linecap="${cap}"${dash ? ` stroke-dasharray="${dash}"` : ''} ${extra}/>`;

export const path = (d, { stroke = C.marca, sw = 2, fill = 'none', dash, extra = '' } = {}) =>
  `<path d="${d}" fill="${fill}" stroke="${stroke}" stroke-width="${sw}" stroke-linecap="round" stroke-linejoin="round"${dash ? ` stroke-dasharray="${dash}"` : ''} ${extra}/>`;

// Ponta de seta desenhada como triângulo (sem <marker>, para não colidir ids entre SVGs).
export function seta(x, y, dir = 'down', { size = 7, fill = C.marca } = {}) {
  const s = size;
  const pts = {
    down: `${x - s},${y - s * 1.3} ${x + s},${y - s * 1.3} ${x},${y}`,
    up: `${x - s},${y + s * 1.3} ${x + s},${y + s * 1.3} ${x},${y}`,
    right: `${x - s * 1.3},${y - s} ${x - s * 1.3},${y + s} ${x},${y}`,
    left: `${x + s * 1.3},${y - s} ${x + s * 1.3},${y + s} ${x},${y}`,
  }[dir];
  return `<polygon points="${pts}" fill="${fill}"/>`;
}

// Largura aproximada de um texto (para pílulas e chips). Fator calibrado para Manrope.
export const largura = (s, size = 12, f = 0.54) => s.length * pis(size) * f;

// Pílula / chip com ícone opcional
export function chip(x, y, texto, { size = 11, fill = C.m050, stroke = C.m200, cor = C.marca, icone, h = 22, padX = 9, weight = 600, mono = false } = {}) {
  const iw = icone ? h * 0.62 + 5 : 0;
  const tw = mono ? texto.length * pis(size) * 0.66 : largura(texto, size, 0.55);
  const w = Math.round(padX * 2 + iw + tw);
  let s = r(x, y, w, h, { rx: h / 2, fill, stroke, sw: 1 });
  if (icone) s += ico(icone, x + padX - 1, y + (h - h * 0.62) / 2, h * 0.62, cor, 2.2);
  s += t(x + padX + iw, y + h / 2 + pis(size) * 0.36, texto, { cls: mono ? 'ig-m' : 'ig-t', size, fill: cor, weight });
  return { svg: s, w };
}

// Selo "A confirmar pela Natcorp" (âmbar, com ícone de ampulheta)
export function aConfirmar(x, y, texto = 'A confirmar pela Natcorp', { size = 10.5, h = 22 } = {}) {
  return chip(x, y, texto, { size, h, fill: C.at050, stroke: C.atencao, cor: C.atencao, icone: 'ampulheta' });
}

// ---------- Ícones (grade 24x24, traço) ----------
const I = {
  celular: '<rect x="6" y="2" width="12" height="20" rx="2.5"/><path d="M10.5 18.5h3"/>',
  tablet: '<rect x="3" y="4" width="18" height="13" rx="2"/><path d="M12 17v3M8.5 21h7"/>',
  cadeado: '<rect x="5" y="10" width="14" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/><path d="M12 14.5v2.5"/>',
  tomada: '<path d="M9 2v5M15 2v5"/><path d="M6 7h12v4a6 6 0 0 1-12 0z"/><path d="M12 17v5"/>',
  banco: '<ellipse cx="12" cy="5" rx="8" ry="3"/><path d="M4 5v14c0 1.7 3.6 3 8 3s8-1.3 8-3V5"/><path d="M4 12c0 1.7 3.6 3 8 3s8-1.3 8-3"/>',
  painel: '<rect x="3" y="4" width="18" height="13" rx="2"/><path d="M7.5 13.5v-3M11.5 13.5V8M15.5 13.5v-4.5M8 21h8M12 17v4"/>',
  rosto: '<path d="M3 8V5a2 2 0 0 1 2-2h3M16 3h3a2 2 0 0 1 2 2v3M21 16v3a2 2 0 0 1-2 2h-3M8 21H5a2 2 0 0 1-2-2v-3"/><path d="M9 9.5v1.5M15 9.5v1.5M9 15c1.6 1.4 4.4 1.4 6 0"/>',
  chave: '<circle cx="8" cy="15" r="4.5"/><path d="M11.2 11.8L20 3M16.5 6.5l3 3M14 9l2 2"/>',
  sino: '<path d="M6 16v-5a6 6 0 0 1 12 0v5l2 2H4z"/><path d="M10 21h4"/>',
  nuvemSobe: '<path d="M7 19h10a4 4 0 0 0 .6-7.95A6 6 0 0 0 6.1 10.2 4.4 4.4 0 0 0 7 19z"/><path d="M12 17v-5.5M9.6 13.8L12 11.4l2.4 2.4"/>',
  nuvemOk: '<path d="M7 19h10a4 4 0 0 0 .6-7.95A6 6 0 0 0 6.1 10.2 4.4 4.4 0 0 0 7 19z"/><path d="M9.3 14.6l2 2 3.6-3.9"/>',
  ok: '<circle cx="12" cy="12" r="9"/><path d="M8 12.4l2.7 2.7L16.2 9.6"/>',
  alerta: '<path d="M12 3.2l9.3 16.6H2.7z"/><path d="M12 9.8v4.6M12 17.1v.2"/>',
  cofre: '<rect x="3" y="4" width="18" height="15" rx="2"/><circle cx="12" cy="11.5" r="3.4"/><path d="M12 8.1v1M12 14v1M6 19v2M18 19v2"/>',
  relogio: '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.2 2"/>',
  local: '<path d="M12 21s-7-6.2-7-11a7 7 0 0 1 14 0c0 4.8-7 11-7 11z"/><circle cx="12" cy="10" r="2.5"/>',
  qr: '<rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><path d="M14 14h3v3M21 14v.1M14 21h.1M17 21h4v-4"/>',
  camera: '<path d="M4 8h3l2-3h6l2 3h3v11H4z"/><circle cx="12" cy="13" r="3.4"/>',
  pin: '<rect x="2.5" y="7" width="19" height="10" rx="2.5"/><path d="M7.5 12h.1M12 12h.1M16.5 12h.1"/>',
  semRede: '<path d="M2 8.5a15 15 0 0 1 20 0M5.5 12a10 10 0 0 1 13 0M9 15.5a5 5 0 0 1 6 0M12 19h.1M3 3l18 18"/>',
  wifi: '<path d="M2 8.5a15 15 0 0 1 20 0M5.5 12a10 10 0 0 1 13 0M9 15.5a5 5 0 0 1 6 0M12 19h.1"/>',
  toque: '<circle cx="12" cy="9" r="2.6"/><path d="M12 2.5a6.5 6.5 0 0 1 6.2 8.4M5.8 10.9A6.5 6.5 0 0 1 12 2.5"/><path d="M12 11.6V21"/>',
  escudo: '<path d="M12 3l8 3v6c0 4.5-3.4 8.3-8 9-4.6-.7-8-4.5-8-9V6z"/><path d="M8.6 12.2l2.4 2.4 4.4-4.6"/>',
  servidor: '<rect x="3" y="3.5" width="18" height="7" rx="1.6"/><rect x="3" y="13.5" width="18" height="7" rx="1.6"/><path d="M7 7h.1M7 17h.1M11 7h6M11 17h6"/>',
  ampulheta: '<path d="M7 3h10M7 21h10"/><path d="M8 3c0 5 8 4.5 8 9s-8 4-8 9M16 3c0 5-8 4.5-8 9s8 4 8 9"/>',
  pessoa: '<circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/>',
  sincronia: '<path d="M20 11a8 8 0 0 0-14.3-4.6L4 8.5M4 4v4.5h4.5M4 13a8 8 0 0 0 14.3 4.6L20 15.5M20 20v-4.5h-4.5"/>',
  envelope: '<rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3.5 6l8.5 7 8.5-7"/>',
  doc: '<path d="M6 2.5h8l4 4V21.5H6z"/><path d="M14 2.5v4h4M9 12h6M9 16h6"/>',
  lista: '<path d="M9 6h11M9 12h11M9 18h11M4.5 6h.1M4.5 12h.1M4.5 18h.1"/>',
  grafico: '<path d="M4 20V4M4 20h16"/><path d="M8 16v-4M12 16V8M16 16v-6"/>',
  ajuste: '<path d="M4 7h10M18 7h2M4 17h4M12 17h8"/><circle cx="16" cy="7" r="2"/><circle cx="10" cy="17" r="2"/>',
  lupa: '<circle cx="10.5" cy="10.5" r="6.5"/><path d="M15.5 15.5L21 21"/>',
  predio: '<path d="M4 21V5.5L12 3v18M12 8.5l8 2.5v10M2.5 21h19"/><path d="M7.5 8h1.5M7.5 12h1.5M7.5 16h1.5M15 13.5h1.5M15 17h1.5"/>',
  globo: '<circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.6 2.6 3.8 5.6 3.8 9s-1.2 6.4-3.8 9c-2.6-2.6-3.8-5.6-3.8-9S9.4 5.6 12 3z"/>',
  pacote: '<path d="M12 2.8l8.5 4.6v9.2L12 21.2l-8.5-4.6V7.4z"/><path d="M3.5 7.4L12 12l8.5-4.6M12 12v9.2"/>',
  mapa: '<path d="M3 6.5l6-2.5 6 2.5 6-2.5v13.5l-6 2.5-6-2.5-6 2.5z"/><path d="M9 4v13.5M15 6.5V20"/>',
  balanca: '<path d="M12 3v18M7 21h10M5 6.5h14M12 5l-.1 0"/><path d="M5 6.5L2.5 13a3 3 0 0 0 5 0zM19 6.5L16.5 13a3 3 0 0 0 5 0z"/>',
  dedo: '<path d="M7 11a5 5 0 0 1 10 0v2M12 11v4.5M9.5 14.5c0 2.5.6 4.6 1.6 6.5M14.6 15.5c0 2-.4 3.8-1.1 5.5M5 14a7 7 0 0 1 .3-5M18.8 9a7 7 0 0 1 .2 4.5M8 4.5a8 8 0 0 1 8 0"/>',
};

export function ico(nome, x, y, size = 24, cor = C.marca, sw = 1.9) {
  const k = size / 24;
  return `<g transform="translate(${x} ${y}) scale(${k})" fill="none" stroke="${cor}" stroke-width="${sw}" stroke-linecap="round" stroke-linejoin="round">${I[nome]}</g>`;
}

// Ícone dentro de um círculo
export function icoCirculo(nome, cx, cy, raio, { fill = C.m050, cor = C.marca, stroke = 'none', sw = 1.5, icoSize } = {}) {
  const s = icoSize || raio * 1.15;
  return `<circle cx="${cx}" cy="${cy}" r="${raio}" fill="${fill}" stroke="${stroke}" stroke-width="${sw}"/>` + ico(nome, cx - s / 2, cy - s / 2, s, cor);
}

// Selo numerado (badge de camada)
export function selo(cx, cy, n, { raio = 12, fill = C.marca, cor = '#fff', size = 12 } = {}) {
  return `<circle cx="${cx}" cy="${cy}" r="${raio}" fill="${fill}"/>` + t(cx, cy + size * 0.36, String(n), { cls: 'ig-m', size, fill: cor, anchor: 'middle', weight: 600 });
}

// Quebra um texto em linhas de no máximo ~maxW px (estimativa pela largura média da fonte).
export function wrap(texto, maxW, size = 11.5, f = 0.53) {
  const max = Math.max(6, Math.floor(maxW / (pis(size) * f)));
  const out = []; let cur = '';
  for (const w of String(texto).split(/\s+/)) {
    if (!cur) cur = w;
    else if ((cur + ' ' + w).length <= max) cur += ' ' + w;
    else { out.push(cur); cur = w; }
  }
  if (cur) out.push(cur);
  return out;
}
