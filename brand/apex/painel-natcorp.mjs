// O painel da marca, compartilhado pelo login (painel da direita) e pelo menu lateral das
// páginas internas: malha técnica, rede de pontos à deriva, brilho rosa que respira e os
// losangos do ModuleLights desenhando-se, com a luz correndo na borda — as camadas do hero
// dos portais do site (PortalHubPage › Opening), num SVG só, animado por CSS interno.
//
// Cores: só as três da marca — Roxo #511C76, Rosa #C95788, Azul #2C1A63 — e o Rosa clareado
// (#F3C9DA, #E4A9C4) nas bordas luminosas. O fundo em si (degradê Azul → Roxo) fica no CSS
// de quem usa o painel; o SVG é transparente e vai por cima.

import { readFileSync } from 'node:fs'
import { join } from 'node:path'

const REPO = join(new URL('.', import.meta.url).pathname, '../..')
const EASE = 'cubic-bezier(.22,1,.36,1)'

/* ---------- a assinatura (src/components/brand/logo-paths.ts) ---------- */

const logoSrc = readFileSync(join(REPO, 'src/components/brand/logo-paths.ts'), 'utf8')
const arr = (name) => {
  const m = logoSrc.match(new RegExp(`export const ${name} = \\[([\\s\\S]*?)\\]`))
  return [...m[1].matchAll(/"([^"]+)"/g)].map((x) => x[1])
}
const num = (name) => Number(logoSrc.match(new RegExp(`export const ${name} = ([\\d.]+)`))[1])
const H_WIDTH = num('H_WIDTH')
const SYMBOL_BOX = num('SYMBOL_BOX')
const caminhos = (lista) => lista.map((d) => `<path d="${d}"/>`).join('')

/** Símbolo + "natcorp", em branco. */
export const logoBranco = () =>
  `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${H_WIDTH} ${SYMBOL_BOX}" fill="#fff">${caminhos([...arr('MODULES'), ...arr('WORDMARK_H')])}</svg>`

/** Só o símbolo (quatro módulos), em branco. */
export const simboloBranco = () =>
  `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}" fill="#fff">${caminhos(arr('MODULES'))}</svg>`

/** SVG em data URI: só o que quebra um url("…") é escapado — o resto vai legível e menor. */
export const uri = (svg) =>
  `url("data:image/svg+xml,${svg.replace(/%/g, '%25').replace(/#/g, '%23').replace(/"/g, "'").replace(/</g, '%3C').replace(/>/g, '%3E')}")`

/* ---------- os losangos (src/components/portals/ModuleLights.tsx, sem tirar nem pôr) ---------- */

const MODULE =
  'M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z'
const CX = 1412
const CY = 425
const VIEW = { x: CX - 1500, w: 2400 }
const MODULE2 = { cx: CX - 112, cy: CY + 75, rotate: 12, s: 1.12 }
const SMALL = { cx: CX - 470, cy: CY + 430, s: 0.26 }
const flows = Array.from({ length: 5 }, (_, i) => {
  const y0 = CY + 520 + i * 44
  const y1 = CY + 300 + i * 26
  const y2 = CY - 60 + i * 30
  return {
    d: `M${VIEW.x - 40} ${y0} C ${CX - 1000} ${y0 - 40}, ${CX - 700} ${y1}, ${CX - 420} ${y1 - 80} S ${CX + 80} ${y2 + 60}, ${VIEW.x + VIEW.w + 40} ${y2}`,
    dur: 7 + i * 0.8,
    delay: i * 0.6,
  }
})
const P = { edge: ['#F3C9DA', '#E4A9C4', '#C95788'], glow: '#E4A9C4', back: '#C95788', light: '#F3C9DA' }

/* Rede de pontos (NetworkField): semente fixa, ligações calculadas num toro de W x H para o
   mosaico repetir sem emenda enquanto desliza para a esquerda. */
function rede(W, H, nos) {
  let seed = 7
  const rnd = () => ((seed = (seed * 16807) % 2147483647) - 1) / 2147483646
  const nodes = Array.from({ length: nos }, () => ({ x: rnd() * W, y: rnd() * H, r: 1.3 + rnd() * 1.9 }))
  const LINK = 150
  const lines = []
  for (let i = 0; i < nodes.length; i++)
    for (let j = i + 1; j < nodes.length; j++)
      for (const ox of [-W, 0, W])
        for (const oy of [-H, 0, H]) {
          const bx = nodes[j].x + ox
          const by = nodes[j].y + oy
          const d = Math.hypot(nodes[i].x - bx, nodes[i].y - by)
          if (d < LINK)
            lines.push(
              `<line x1="${nodes[i].x.toFixed(1)}" y1="${nodes[i].y.toFixed(1)}" x2="${bx.toFixed(1)}" y2="${by.toFixed(1)}" stroke-opacity="${((1 - d / LINK) * 0.28).toFixed(3)}"/>`,
            )
        }
  const dots = nodes.map((n) => `<circle cx="${n.x.toFixed(1)}" cy="${n.y.toFixed(1)}" r="${n.r.toFixed(2)}"/>`).join('')
  return `<g stroke="#E4A9C4" stroke-width="1">${lines.join('')}</g><g fill="rgba(228,169,196,.75)">${dots}</g>`
}

/**
 * O painel. Medidas no espaço do viewBox (W x H), sempre com preserveAspectRatio "slice".
 * @param {object} o
 * @param {number} o.W, o.H         quadro
 * @param {{x,y,s}} o.luzes         centro e escala do conjunto de losangos
 * @param {{cx,cy,rx,ry,dx,dy}} o.brilho   elipse rosa e quanto ela deriva
 * @param {number} o.nos            pontos da rede
 * @param {number} o.opacidadeRede  0–1: a rede mais discreta onde há texto por cima (menu)
 * @param {boolean} o.redeHorizontal  máscara da rede da esquerda para a direita (login) ou uniforme
 * @param {boolean} animado         false = estado final parado (prefers-reduced-motion)
 */
export function painel(o, animado) {
  const { W, H, luzes, brilho, nos, opacidadeRede = 1, redeHorizontal = true } = o
  const tile = rede(W, H, nos)
  const css = animado
    ? `
.draw{stroke-dasharray:1 1;stroke-dashoffset:1;opacity:0;animation:draw 2.2s ${EASE} .2s forwards}
.d2{animation-duration:2.6s;animation-delay:.7s}
.fl{animation-duration:1.8s}
@keyframes draw{to{stroke-dashoffset:0;opacity:1}}
.run{stroke-dasharray:.07 1;opacity:0;animation:run 14s linear infinite,in 1.2s ease 2.4s forwards}
.run.w{stroke-dasharray:.055 1}
@keyframes run{from{stroke-dashoffset:0}to{stroke-dashoffset:-2}}
.pk{stroke-dasharray:.08 1;stroke-dashoffset:1;opacity:0;animation:pk linear infinite,in 1s ease forwards}
@keyframes pk{from{stroke-dashoffset:1}to{stroke-dashoffset:-1}}
@keyframes in{to{opacity:var(--o,1)}}
.small{opacity:0;transform-box:fill-box;transform-origin:center;animation:in 1.2s ${EASE} 1.2s forwards,breathe 6s ease-in-out 2.4s infinite}
@keyframes breathe{50%{transform:scale(1.05)}}
.glow{animation:drift 12s ease-in-out infinite}
@keyframes drift{0%,100%{transform:translate(0,0);opacity:.5}50%{transform:translate(${brilho.dx}px,${brilho.dy}px);opacity:.9}}
.net{animation:slide 150s linear infinite}
@keyframes slide{to{transform:translateX(-${W}px)}}`
    : `.pk,.run{display:none}.glow{opacity:.6}`

  const flowPaths = flows
    .map((f) => `<path class="draw fl" d="${f.d}" pathLength="1" stroke="${P.light}" stroke-width="1.6" stroke-opacity=".3"/>`)
    .join('')
  const packets = flows
    .map(
      (f) =>
        `<path class="pk" d="${f.d}" pathLength="1" stroke="#fff" stroke-width="2.2" stroke-opacity=".9" style="animation-duration:${f.dur}s,1s;animation-delay:${f.delay}s,${f.delay}s"/>`,
    )
    .join('')
  const mascaraRede = redeHorizontal
    ? `<linearGradient id="nm" x1="0" x2="1"><stop offset=".05" stop-color="#fff" stop-opacity=".15"/><stop offset=".6" stop-color="#fff" stop-opacity=".7"/></linearGradient>`
    : `<linearGradient id="nm" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="#fff" stop-opacity=".5"/><stop offset="1" stop-color="#fff" stop-opacity=".8"/></linearGradient>`

  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" preserveAspectRatio="xMidYMid slice">
<style>${css}</style>
<defs>
<radialGradient id="g" cx=".5" cy=".5" r=".5"><stop offset="0" stop-color="#C95788" stop-opacity=".3"/><stop offset=".45" stop-color="#C95788" stop-opacity=".1"/><stop offset="1" stop-color="#C95788" stop-opacity="0"/></radialGradient>
<pattern id="grid" width="56" height="56" patternUnits="userSpaceOnUse"><path d="M56 0H0V56" fill="none" stroke="#fff" stroke-opacity=".06"/></pattern>
<radialGradient id="gm" cx="${luzes.x / W}" cy="${luzes.y / H}" r=".62"><stop offset="0" stop-color="#fff"/><stop offset=".75" stop-color="#fff" stop-opacity="0"/></radialGradient>
<mask id="mg"><rect width="${W}" height="${H}" fill="url(#gm)"/></mask>
${mascaraRede}
<mask id="mn"><rect width="${W}" height="${H}" fill="url(#nm)"/></mask>
<linearGradient id="edge" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${P.edge[0]}" stop-opacity=".95"/><stop offset=".5" stop-color="${P.edge[1]}" stop-opacity=".75"/><stop offset="1" stop-color="${P.edge[2]}" stop-opacity=".4"/></linearGradient>
<linearGradient id="edge2" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${P.edge[1]}" stop-opacity=".9"/><stop offset=".5" stop-color="${P.edge[2]}" stop-opacity=".75"/><stop offset="1" stop-color="${P.edge[2]}" stop-opacity=".45"/></linearGradient>
<linearGradient id="glass" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${P.edge[0]}" stop-opacity=".3"/><stop offset=".55" stop-color="${P.edge[2]}" stop-opacity=".16"/><stop offset="1" stop-color="#511C76" stop-opacity=".1"/></linearGradient>
</defs>
<rect width="${W}" height="${H}" fill="url(#grid)" mask="url(#mg)"/>
<g mask="url(#mn)" opacity="${opacidadeRede}"><g class="net"><g id="t">${tile}</g><use href="#t" x="${W}"/></g></g>
<ellipse class="glow" cx="${brilho.cx}" cy="${brilho.cy}" rx="${brilho.rx}" ry="${brilho.ry}" fill="url(#g)"/>
<g transform="translate(${luzes.x} ${luzes.y}) scale(${luzes.s}) translate(${-CX} ${-CY})" fill="none" stroke-linecap="round">
${flowPaths}
<g transform="translate(${MODULE2.cx} ${MODULE2.cy}) rotate(${MODULE2.rotate}) scale(${MODULE2.s}) translate(${-CX} ${-CY})">
<path class="draw d2" d="${MODULE}" pathLength="1" stroke="${P.back}" stroke-width="8" stroke-opacity=".16"/>
<path class="draw d2" d="${MODULE}" pathLength="1" stroke="url(#edge2)" stroke-width="2.4"/>
</g>
<path class="draw" d="${MODULE}" pathLength="1" stroke="${P.glow}" stroke-width="30" stroke-opacity=".1"/>
<path class="draw" d="${MODULE}" pathLength="1" stroke="${P.glow}" stroke-width="12" stroke-opacity=".2"/>
<path class="draw" d="${MODULE}" pathLength="1" stroke="url(#edge)" stroke-width="3.5"/>
${packets}
<path class="run" d="${MODULE}" pathLength="1" stroke="${P.light}" stroke-width="14" style="--o:.45"/>
<path class="run w" d="${MODULE}" pathLength="1" stroke="#fff" stroke-width="5"/>
<g class="small"><g transform="translate(${SMALL.cx} ${SMALL.cy}) scale(${SMALL.s}) translate(${-CX} ${-CY})">
<path d="${MODULE}" fill="url(#glass)" stroke="${P.light}" stroke-width="5" stroke-opacity=".8"/>
<path d="${MODULE}" stroke="#fff" stroke-width="2.5" stroke-opacity=".5" transform="translate(-16 -16)"/>
</g></g>
</g>
</svg>`
    .replace(/\n/g, '')
    .replace(animado ? /^$/ : /class="draw[^"]*"/g, '') // parado: traços já desenhados
    .replace(animado ? /^$/ : /class="small"/g, '')
}

/** O painel da direita do login (quadro original, medidas conferidas em 1024–1920 px). */
export const PAINEL_LOGIN = {
  W: 1000, H: 1250, nos: 46,
  luzes: { x: 850, y: 1075, s: 0.52 },
  brilho: { cx: 330, cy: 260, rx: 300, ry: 720, dx: 180, dy: 125 },
}

/** O menu lateral: coluna estreita e alta (240 × ~850 px). Losangos embaixo, sangrando pela
    direita; rede mais rala e mais discreta, porque o texto do menu passa por cima. */
export const PAINEL_MENU = {
  W: 300, H: 1000, nos: 14, opacidadeRede: 0.55, redeHorizontal: false,
  luzes: { x: 215, y: 905, s: 0.21 },
  brilho: { cx: 60, cy: 170, rx: 170, ry: 380, dx: 60, dy: 90 },
}
