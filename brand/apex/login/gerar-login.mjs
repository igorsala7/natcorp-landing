// Gera Natcorp_Login.css (o arquivo que sobe para o APEX) a partir de Natcorp_Login.src.css,
// embutindo a fonte e três imagens:
//   @@FONTE@@           Manrope latina (brand/apex/fonts/manrope-latin.woff2), em base64
//   @@PAINEL_ANIMADO@@  o painel lateral com os efeitos do hero dos portais, animado por CSS dentro do SVG
//   @@PAINEL_PARADO@@   o mesmo painel no estado final, para prefers-reduced-motion
//   @@LOGO@@            a assinatura Natcorp horizontal em branco
//
// O APEX só aceita uma folha (sem JS, sem template), por isso tudo vai como data URI.
// A geometria dos losangos é a de src/components/portals/ModuleLights.tsx e o logo sai de
// src/components/brand/logo-paths.ts — mudou lá, rode de novo:
//
//   node brand/apex/login/gerar-login.mjs

import { readFileSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'

const here = new URL('.', import.meta.url).pathname
const REPO = join(here, '../../..')

/* ---------- logo (logo-paths.ts) ---------- */

const logoSrc = readFileSync(join(REPO, 'src/components/brand/logo-paths.ts'), 'utf8')
const arr = (name) => {
  const m = logoSrc.match(new RegExp(`export const ${name} = \\[([\\s\\S]*?)\\]`))
  return [...m[1].matchAll(/"([^"]+)"/g)].map((x) => x[1])
}
const num = (name) => Number(logoSrc.match(new RegExp(`export const ${name} = ([\\d.]+)`))[1])
const H_WIDTH = num('H_WIDTH')
const SYMBOL_BOX = num('SYMBOL_BOX')
const logo = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${H_WIDTH} ${SYMBOL_BOX}" fill="#fff">${[
  ...arr('MODULES'),
  ...arr('WORDMARK_H'),
]
  .map((d) => `<path d="${d}"/>`)
  .join('')}</svg>`

/* ---------- painel (ModuleLights + malha + rede + brilho) ---------- */

const W = 1000
const H = 1250
const EASE = 'cubic-bezier(.22,1,.36,1)'

// ModuleLights.tsx, sem tirar nem pôr
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
const P = { edge: ['#F3C9DA', '#E4A9C4', '#C95788'], glow: '#E4A9C4', back: '#C95788', light: '#F3C9DA' } // rosePalette

// onde o conjunto entra no painel: embaixo à direita, sangrando pela borda, longe do título
const LIGHTS = { x: 850, y: 1075, s: 0.52 }

/* Rede de pontos (NetworkField): semente fixa, ligações calculadas num toro de W x H para o
   mosaico repetir sem emenda enquanto desliza para a esquerda. */
function rede() {
  let seed = 7
  const rnd = () => ((seed = (seed * 16807) % 2147483647) - 1) / 2147483646
  const nodes = Array.from({ length: 46 }, () => ({ x: rnd() * W, y: rnd() * H, r: 1.3 + rnd() * 1.9 }))
  const LINK = 150
  const lines = []
  for (let i = 0; i < nodes.length; i++)
    for (let j = i + 1; j < nodes.length; j++) {
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
    }
  const dots = nodes.map((n) => `<circle cx="${n.x.toFixed(1)}" cy="${n.y.toFixed(1)}" r="${n.r.toFixed(2)}"/>`).join('')
  return `<g stroke="#E4A9C4" stroke-width="1">${lines.join('')}</g><g fill="rgba(228,169,196,.75)">${dots}</g>`
}

function painel(animado) {
  const tile = rede()
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
@keyframes drift{0%,100%{transform:translate(0,0);opacity:.5}50%{transform:translate(180px,125px);opacity:.9}}
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

  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" preserveAspectRatio="xMidYMid slice">
<style>${css}</style>
<defs>
<radialGradient id="g" cx=".5" cy=".5" r=".5"><stop offset="0" stop-color="#C95788" stop-opacity=".3"/><stop offset=".45" stop-color="#C95788" stop-opacity=".1"/><stop offset="1" stop-color="#C95788" stop-opacity="0"/></radialGradient>
<pattern id="grid" width="56" height="56" patternUnits="userSpaceOnUse"><path d="M56 0H0V56" fill="none" stroke="#fff" stroke-opacity=".06"/></pattern>
<radialGradient id="gm" cx="${LIGHTS.x / W}" cy="${LIGHTS.y / H}" r=".62"><stop offset="0" stop-color="#fff"/><stop offset=".75" stop-color="#fff" stop-opacity="0"/></radialGradient>
<mask id="mg"><rect width="${W}" height="${H}" fill="url(#gm)"/></mask>
<linearGradient id="nm" x1="0" x2="1"><stop offset=".05" stop-color="#fff" stop-opacity=".15"/><stop offset=".6" stop-color="#fff" stop-opacity=".7"/></linearGradient>
<mask id="mn"><rect width="${W}" height="${H}" fill="url(#nm)"/></mask>
<linearGradient id="edge" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${P.edge[0]}" stop-opacity=".95"/><stop offset=".5" stop-color="${P.edge[1]}" stop-opacity=".75"/><stop offset="1" stop-color="${P.edge[2]}" stop-opacity=".4"/></linearGradient>
<linearGradient id="edge2" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${P.edge[1]}" stop-opacity=".9"/><stop offset=".5" stop-color="${P.edge[2]}" stop-opacity=".75"/><stop offset="1" stop-color="${P.edge[2]}" stop-opacity=".45"/></linearGradient>
<linearGradient id="glass" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="${P.edge[0]}" stop-opacity=".3"/><stop offset=".55" stop-color="${P.edge[2]}" stop-opacity=".16"/><stop offset="1" stop-color="#511C76" stop-opacity=".1"/></linearGradient>
</defs>
<rect width="${W}" height="${H}" fill="url(#grid)" mask="url(#mg)"/>
<g mask="url(#mn)"><g class="net"><g id="t">${tile}</g><use href="#t" x="${W}"/></g></g>
<ellipse class="glow" cx="330" cy="260" rx="300" ry="720" fill="url(#g)"/>
<g transform="translate(${LIGHTS.x} ${LIGHTS.y}) scale(${LIGHTS.s}) translate(${-CX} ${-CY})" fill="none" stroke-linecap="round">
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

// só o que quebra um url("…") ou um data URI é escapado; o resto vai legível e bem menor
const uri = (svg) => `url("data:image/svg+xml,${svg.replace(/%/g, '%25').replace(/#/g, '%23').replace(/"/g, "'").replace(/</g, '%3C').replace(/>/g, '%3E')}")`

const src = readFileSync(join(here, 'Natcorp_Login.src.css'), 'utf8')
const fonte = readFileSync(join(REPO, 'brand/apex/fonts/manrope-latin.woff2')).toString('base64')
const out = src
  .replace('@@PAINEL_ANIMADO@@', uri(painel(true)))
  .replace('@@PAINEL_PARADO@@', uri(painel(false)))
  .replace('@@LOGO@@', uri(logo))
  .replace('@@FONTE@@', `url("data:font/woff2;base64,${fonte}")`)
writeFileSync(join(here, 'Natcorp_Login.css'), out)
console.log(`Natcorp_Login.css: ${(out.length / 1024).toFixed(1)} KB (fonte ${(src.length / 1024).toFixed(1)} KB)`)
