import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import type { Easing, TargetAndTransition, Transition } from 'motion/react'
import { BrandGradient } from '../Logo'
import { MODULES, SYMBOL_BOX } from '../logo-paths'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * "Um sistema. Uma experiência.", em três atos:
 * 1. Doze módulos espalhados pela tela, apagados e soltos, cada um por si.
 * 2. Eles deslizam em curvas até formar um anel, e cada um estende uma linha até o centro.
 * 3. No centro, o símbolo Natcorp se encaixa, acende e manda um pulso rosa por todas as linhas de uma vez.
 * Tudo em SVG, em uma caixa 16:9. Com movimento reduzido, mostra o quadro final parado.
 */

/** Duração total, para quem espera o fim. */
export const SYSTEM_MOTION_MS = 5000

const W = 320
const H = 184
const CX = 160
const CY = 88
/** Anel onde os módulos se assentam: uma elipse, para caber no 16:9 com o centro livre. */
const RING_RX = 114
const RING_RY = 66
const CHIP_H = 12
const FONT = 7
const GLYPH = 3.6
const PAD_L = 4.5
const GAP = 3
const PAD_R = 5
/** Símbolo com 26 unidades de largura; ao redor dele, o anel tracejado e o começo das ligações. */
const SYMBOL_SCALE = 3.25
const CORE_R = 21.5
const LINK_START = 27
const PULSE_START = 12
const CAPTION_Y = 176

/* Linha do tempo, em segundos. */
const T = {
  appear: 0.05,
  appearStagger: 0.07,
  appearDur: 0.45,
  travel: 1.2,
  travelStagger: 0.06,
  travelDur: 1.0,
  linkDur: 0.35,
  core: 3.0,
  coreDur: 0.55,
  coreStagger: 0.05,
  impact: 3.5,
  pulse: 3.6,
  pulseDur: 0.55,
  glow: 4.1,
  glowDur: 0.6,
  caption: 3.9,
  captionDur: 0.7,
}

/* Quantos graus antes do lugar cada módulo começa. Todos giram no mesmo sentido, então os caminhos não se cruzam. */
const SWIRL = 22

/* Os módulos: ângulo no anel (0° à direita, sentido anti-horário) e como começam: a que distância do centro
 * (1 = o anel) e com que inclinação. Quem fica no alto ou embaixo do anel começa por fora; os vizinhos, por dentro,
 * para ninguém se cruzar na chegada. */
const CHIPS = [
  { name: 'Folha de Pagamento', angle: 15, from: [0.7, 3] },
  { name: 'Recrutamento e Seleção', angle: 45, from: [0.8, -3] },
  { name: 'eSocial', angle: 75, from: [1.15, 8] },
  { name: 'Portais', angle: 105, from: [1.15, -7] },
  { name: 'Segurança do Trabalho', angle: 135, from: [0.62, 6] },
  { name: 'Admissão Digital', angle: 165, from: [0.6, 4] },
  { name: 'People Analytics', angle: 195, from: [0.62, 3] },
  { name: 'Medicina Ocupacional', angle: 225, from: [0.72, 4] },
  { name: 'Onboarding', angle: 255, from: [1.15, -8] },
  { name: 'NATI', angle: 285, from: [1.12, 10] },
  { name: 'Gestão de Benefícios', angle: 315, from: [0.75, 4] },
  { name: 'Ponto Eletrônico', angle: 345, from: [1.05, -5] },
] as const

/* De onde cada losango do símbolo vem (topo, direita, esquerda, base), em unidades do símbolo. */
const flyFrom = [
  { x: 0, y: -1.6, rotate: -45 },
  { x: 1.6, y: 0, rotate: 45 },
  { x: -1.6, y: 0, rotate: -45 },
  { x: 0, y: 1.6, rotate: 45 },
]

/* ---------- Geometria ---------- */

interface Point {
  x: number
  y: number
}

/** Largura estimada do texto em Manrope 600 (por classe de caractere), para dimensionar o chip. */
function textWidth(label: string, size: number) {
  let w = 0
  for (const ch of label) {
    if (ch === ' ') w += 0.27
    else if ('iljI.'.includes(ch)) w += 0.28
    else if ('ftr'.includes(ch)) w += 0.38
    else if ('mwMW'.includes(ch)) w += 0.92
    else if ('bdghnpqu'.includes(ch)) w += 0.61
    else if (ch !== ch.toLowerCase()) w += 0.64
    else w += 0.55
  }
  return w * size
}

const SAMPLES = 16
const easeOutQuart = (t: number) => 1 - (1 - t) ** 4

const rad = (deg: number) => (deg * Math.PI) / 180
/** Um ponto do anel (ou de uma versão dele mais perto ou mais longe do centro). */
const onRing = (angle: number, factor: number): Point => ({
  x: CX + RING_RX * factor * Math.cos(rad(angle)),
  y: CY - RING_RY * factor * Math.sin(rad(angle)),
})

/** A curva até o anel: uma espiral curta em torno do centro, já com a desaceleração da marca. Como todos giram
 * no mesmo sentido e cada um fica na sua faixa de ângulos, os caminhos não se cruzam. */
function spiral(angle: number, fromAngle: number, fromFactor: number) {
  return Array.from({ length: SAMPLES + 1 }, (_, k) => {
    const s = easeOutQuart(k / SAMPLES)
    return onRing(fromAngle + (angle - fromAngle) * s, fromFactor + (1 - fromFactor) * s)
  })
}

/* ---------- Trilhas de keyframes ---------- */

type Key = readonly [t: number, v: number]
interface Track {
  from: number
  to: number[]
  transition: Transition
}

/** Keyframes em tempo absoluto (s), convertidos em `times` normalizados. A trilha começa em t = 0.
 * A curva é sempre por trecho: com uma curva só para a trilha inteira, a opacidade (animada pelo navegador
 * via WAAPI) aplicaria a curva ao tempo todo e os `times` sairiam do lugar. */
function track(keys: Key[], ease: Easing | Easing[] = 'easeOut'): Track {
  const end = keys[keys.length - 1][0]
  const perSegment = Array.isArray(ease) && typeof ease[0] !== 'number' ? (ease as Easing[]) : keys.slice(1).map(() => ease as Easing)
  return {
    from: keys[0][1],
    to: keys.map(([, v]) => v),
    transition: { duration: end, times: keys.map(([t]) => t / end), ease: perSegment },
  }
}

interface Pose {
  off: TargetAndTransition
  on: TargetAndTransition
  transition: Transition
}

function pose(tracks: Record<string, Track>): Pose {
  const off: Record<string, number> = {}
  const on: Record<string, number[]> = {}
  const transition: Record<string, Transition> = {}
  for (const key in tracks) {
    off[key] = tracks[key].from
    on[key] = tracks[key].to
    transition[key] = tracks[key].transition
  }
  return { off: off as TargetAndTransition, on: on as TargetAndTransition, transition }
}

/** O último keyframe de cada propriedade: o quadro final, para o modo sem movimento. */
function settle(on: TargetAndTransition): TargetAndTransition {
  const out: Record<string, unknown> = {}
  for (const [key, value] of Object.entries(on)) out[key] = Array.isArray(value) ? value[value.length - 1] : value
  return out as TargetAndTransition
}

type Mode = 'on' | 'off' | 'still'

function motionProps(mode: Mode, p: Pose) {
  if (mode === 'still') {
    const end = settle(p.on)
    return { initial: end, animate: end, transition: p.transition }
  }
  return { initial: p.off, animate: mode === 'on' ? p.on : p.off, transition: p.transition }
}

/* ---------- Os chips e suas ligações, calculados uma vez ---------- */

const LINE_O = { white: [0.32, 0.6, 0.24], gradient: [0.26, 0.55, 0.2] } as const

function buildChips(tone: 'white' | 'gradient') {
  const [lineO, lineHi, lineEnd] = LINE_O[tone]
  return CHIPS.map((spec, i) => {
    const w = PAD_L + GLYPH * Math.SQRT2 + GAP + textWidth(spec.name, FONT) + PAD_R
    const hw = w / 2
    const glyphX = -hw + PAD_L + (GLYPH * Math.SQRT2) / 2
    const textX = glyphX + (GLYPH * Math.SQRT2) / 2 + GAP
    const ring = onRing(spec.angle, 1)
    const from = onRing(spec.angle + SWIRL, spec.from[0])
    const tilt = spec.from[1]

    /* ordem de chegada no anel: sentido horário a partir do alto, à direita */
    const order = (((75 - spec.angle) % 360) + 360) % 360 / 30
    const appear = T.appear + ((i * 5) % CHIPS.length) * T.appearStagger
    const travel = T.travel + order * T.travelStagger
    const land = travel + T.travelDur

    /* deriva solta antes de partir, depois a curva até o anel */
    const drift = { x: 2 * Math.cos(i * 2.1), y: 1.2 * Math.sin(i * 1.7 + 0.4) }
    const path = spiral(spec.angle, spec.angle + SWIRL, spec.from[0])
    const posKeys: Array<[number, Point]> = [
      [0, from],
      [travel / 2, { x: from.x + drift.x, y: from.y + drift.y }],
      ...path.map((p, k): [number, Point] => [travel + (T.travelDur * k) / SAMPLES, p]),
    ]
    const posEase: Easing[] = ['easeInOut', 'easeInOut', ...Array.from({ length: SAMPLES }, (): Easing => 'linear')]

    const chip = pose({
      x: track(posKeys.map(([t, p]): Key => [t, p.x]), posEase),
      y: track(posKeys.map(([t, p]): Key => [t, p.y]), posEase),
      rotate: track([[0, tilt], [travel, tilt], [land, 0]], ['linear', EASE]),
      opacity: track([[0, 0], [appear, 0], [appear + T.appearDur, 0.55], [land, 0.55], [land + 0.3, 1]]),
      scale: track(
        [[0, 0.9], [appear + T.appearDur, 1], [land, 1], [land + 0.12, 1.06], [land + 0.32, 1], [T.glow, 1], [T.glow + 0.15, 1.05], [T.glow + 0.5, 1]],
        'easeOut',
      ),
    })
    const glow = pose({ opacity: track([[0, 0], [T.glow, 0], [T.glow + 0.15, 0.75], [T.glow + T.glowDur, 0]], 'easeInOut') })
    const accent = pose({ opacity: track([[0, 0], [T.glow, 0], [T.glow + 0.12, 1], [T.glow + T.glowDur + 0.2, 0]], 'easeInOut') })
    const lit = pose({ opacity: track([[0, 0], [T.glow, 0], [T.glow + 0.15, 1]]) })

    /* a ligação vai da borda do chip até perto do centro; o pulso faz o caminho inverso */
    const dx = ring.x - CX
    const dy = ring.y - CY
    const dist = Math.hypot(dx, dy)
    const ux = dx / dist
    const uy = dy / dist
    const toEdge = Math.min(Math.abs(ux) > 1e-6 ? hw / Math.abs(ux) : Infinity, Math.abs(uy) > 1e-6 ? CHIP_H / 2 / Math.abs(uy) : Infinity) + 1.5
    const edge = { x: ring.x - ux * toEdge, y: ring.y - uy * toEdge }
    const inner = { x: CX + ux * LINK_START, y: CY + uy * LINK_START }
    const pulseFrom = { x: CX + ux * PULSE_START, y: CY + uy * PULSE_START }

    const link = pose({
      pathLength: track([[0, 0], [land, 0], [land + T.linkDur, 1]], ['linear', 'easeOut']),
      opacity: track([[0, 0], [land, 0], [land + 0.1, lineO], [T.pulse, lineO], [T.pulse + 0.25, lineHi], [T.pulse + 0.9, lineEnd]]),
    })
    const pulse = pose({
      pathLength: track([[0, 0.22], [1, 0.22]], 'linear'),
      pathOffset: track([[0, -0.22], [T.pulse, -0.22], [T.pulse + T.pulseDur, 1]], ['linear', 'easeInOut']),
      opacity: track([[0, 0], [T.pulse, 0], [T.pulse + 0.08, 1], [T.pulse + T.pulseDur - 0.1, 1], [T.pulse + T.pulseDur + 0.05, 0]], 'linear'),
    })

    return {
      name: spec.name,
      w,
      hw,
      glyphX,
      textX,
      chip,
      glow,
      accent,
      lit,
      link,
      pulse,
      linkD: `M${edge.x.toFixed(2)} ${edge.y.toFixed(2)} L${inner.x.toFixed(2)} ${inner.y.toFixed(2)}`,
      pulseD: `M${pulseFrom.x.toFixed(2)} ${pulseFrom.y.toFixed(2)} L${edge.x.toFixed(2)} ${edge.y.toFixed(2)}`,
    }
  })
}

const CHIP_SETS = { white: buildChips('white'), gradient: buildChips('gradient') }

/* ---------- O centro e a legenda ---------- */

const symbolPoses = flyFrom.map((f, i) => {
  const start = T.core + i * T.coreStagger
  return pose({
    opacity: track([[0, 0], [start, 0], [start + 0.3, 1]]),
    x: track([[0, f.x], [start, f.x], [start + T.coreDur, 0]], ['linear', EASE]),
    y: track([[0, f.y], [start, f.y], [start + T.coreDur, 0]], ['linear', EASE]),
    rotate: track([[0, f.rotate], [start, f.rotate], [start + T.coreDur, 0]], ['linear', EASE]),
    scale: track([[0, 0.6], [start, 0.6], [T.impact, 1], [T.impact + 0.12, 1.07], [T.impact + 0.32, 1]], ['linear', 'easeOut', 'easeOut', 'easeOut']),
  })
})

const haloPose = pose({ opacity: track([[0, 0], [T.core, 0], [T.core + 0.8, 1]]) })
const ringPose = pose({
  opacity: track([[0, 0], [T.core + 0.2, 0], [T.core + 0.8, 1]]),
  scale: track([[0, 0.85], [T.core + 0.2, 0.85], [T.core + 0.9, 1]], ['linear', EASE]),
})
const flashPose = pose({
  scale: track([[0, 0], [T.impact, 0], [T.impact + 0.26, 4.5], [T.impact + 0.65, 6.5]], ['linear', 'easeOut', 'easeOut']),
  opacity: track([[0, 0], [T.impact, 0], [T.impact + 0.22, 0.85], [T.impact + 0.65, 0]], ['linear', 'easeOut', 'easeOut']),
})
const wavePose = pose({
  scale: track([[0, 1], [T.impact, 1], [T.impact + 0.9, 4.6]], ['linear', 'easeOut']),
  opacity: track([[0, 0], [T.impact, 0], [T.impact + 0.06, 0.55], [T.impact + 0.9, 0]], ['linear', 'linear', 'easeOut']),
})
const captionPose = pose({
  opacity: track([[0, 0], [T.caption, 0], [T.caption + T.captionDur, 1]]),
  y: track([[0, 5], [T.caption, 5], [T.caption + T.captionDur, 0]], ['linear', EASE]),
})

/* ---------- Cores por fundo ---------- */

const PALETTE = {
  white: {
    chipFill: 'rgba(255,255,255,0.10)',
    chipStroke: 'rgba(255,255,255,0.28)',
    text: '#FFFFFF',
    glyph: '#FFFFFF',
    line: '#FFFFFF',
    pulse: '#E4A9C4',
    pulseGlow: '#C95788',
    accent: '#E4A9C4',
    glow: '#C95788',
    ring: '#FFFFFF',
    ringOpacity: 0.4,
    caption: '#FFFFFF',
    captionAccent: '#E4A9C4',
    haloOpacity: 0.32,
  },
  gradient: {
    chipFill: '#F4F2F7',
    chipStroke: '#E9E5F1',
    text: '#1B1238',
    glyph: '#511C76',
    line: '#511C76',
    pulse: '#C95788',
    pulseGlow: '#C95788',
    accent: '#C95788',
    glow: '#E4A9C4',
    ring: '#511C76',
    ringOpacity: 0.32,
    caption: '#1B1238',
    captionAccent: '#C95788',
    haloOpacity: 0.22,
  },
} as const

const FONT_FAMILY = 'Manrope, system-ui, sans-serif'

interface SystemMotionProps {
  /** `white` para fundos escuros; `gradient` para fundos claros. */
  tone?: 'white' | 'gradient'
  /** Dispara a sequência. Para repetir, troque a `key` do componente. */
  play?: boolean
  className?: string
  onComplete?: () => void
}

export function SystemMotion({ tone = 'white', play = true, className, onComplete }: SystemMotionProps) {
  const reduced = useReducedMotion()
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const gradId = `sm-grad-${uid}`
  const haloId = `sm-halo-${uid}`
  const flashId = `sm-flash-${uid}`
  const blurId = `sm-blur-${uid}`

  useEffect(() => {
    if (!play || !onComplete) return
    const t = window.setTimeout(onComplete, reduced ? 0 : SYSTEM_MOTION_MS)
    return () => window.clearTimeout(t)
  }, [play, reduced, onComplete])

  const mode: Mode = reduced ? 'still' : play ? 'on' : 'off'
  const col = PALETTE[tone]
  const chips = CHIP_SETS[tone]
  const symbolFill = tone === 'white' ? '#FFFFFF' : `url(#${gradId})`

  return (
    <svg viewBox={`0 0 ${W} ${H}`} className={cn('block overflow-visible', className)} aria-hidden focusable="false">
      <defs>
        {tone === 'gradient' && <BrandGradient id={gradId} />}
        <radialGradient id={haloId} cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#C95788" stopOpacity={col.haloOpacity} />
          <stop offset="0.5" stopColor="#9A408A" stopOpacity={col.haloOpacity * 0.45} />
          <stop offset="1" stopColor="#9A408A" stopOpacity="0" />
        </radialGradient>
        {/* o clarão do encaixe: núcleo quente, rosa da marca no meio, esmaecendo na borda */}
        <radialGradient id={flashId} cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#FFF1F6" />
          <stop offset="0.18" stopColor="#F5B4CC" />
          <stop offset="0.5" stopColor="#C95788" stopOpacity="0.6" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0" />
        </radialGradient>
        <filter id={blurId} x="-30%" y="-60%" width="160%" height="220%">
          <feGaussianBlur stdDeviation="2.4" />
        </filter>
        <filter id={`${blurId}-line`} x="-10%" y="-10%" width="120%" height="120%">
          <feGaussianBlur stdDeviation="1" />
        </filter>
      </defs>

      {/* névoa atrás do símbolo */}
      <m.circle cx={CX} cy={CY} r="44" fill={`url(#${haloId})`} {...motionProps(mode, haloPose)} />

      {/* as ligações: cada chip estende uma linha até o centro assim que se assenta */}
      <g stroke={col.line} strokeWidth="0.6" strokeLinecap="round" fill="none">
        {chips.map((c) => (
          <m.path key={c.name} d={c.linkD} {...motionProps(mode, c.link)} />
        ))}
      </g>

      {/* o pulso: um traço rosa que corre do centro a todos os chips ao mesmo tempo (brilho difuso por baixo, traço nítido por cima) */}
      <g stroke={col.pulseGlow} strokeWidth="2.6" strokeLinecap="round" fill="none" opacity="0.6" filter={`url(#${blurId}-line)`}>
        {chips.map((c) => (
          <m.path key={c.name} d={c.pulseD} {...motionProps(mode, c.pulse)} />
        ))}
      </g>
      <g stroke={col.pulse} strokeWidth="1.1" strokeLinecap="round" fill="none">
        {chips.map((c) => (
          <m.path key={c.name} d={c.pulseD} {...motionProps(mode, c.pulse)} />
        ))}
      </g>

      {/* anel tracejado, girando devagar (parado sem movimento) */}
      <m.g style={{ transformOrigin: 'center', transformBox: 'fill-box' }} {...motionProps(mode, ringPose)}>
        <circle cx={CX} cy={CY} r={CORE_R} fill="none" stroke={col.ring} strokeOpacity={col.ringOpacity} strokeWidth="0.6" strokeDasharray="1.3 4.8" strokeLinecap="round">
          {mode !== 'still' && <animateTransform attributeName="transform" type="rotate" from={`0 ${CX} ${CY}`} to={`360 ${CX} ${CY}`} dur="80s" repeatCount="indefinite" />}
        </circle>
      </m.g>

      {/* a onda e o clarão do encaixe */}
      <m.circle cx={CX} cy={CY} r="14" fill="none" stroke="#C95788" strokeWidth="0.5" style={{ transformOrigin: 'center', transformBox: 'fill-box' }} {...motionProps(mode, wavePose)} />
      <m.circle cx={CX} cy={CY} r="6" fill={`url(#${flashId})`} style={{ transformOrigin: 'center', transformBox: 'fill-box' }} {...motionProps(mode, flashPose)} />

      {/* o símbolo: os quatro losangos chegam de perto, encaixam e pulsam no impacto */}
      <g transform={`translate(${CX - (SYMBOL_BOX / 2) * SYMBOL_SCALE} ${CY - (SYMBOL_BOX / 2) * SYMBOL_SCALE}) scale(${SYMBOL_SCALE})`}>
        {MODULES.map((d, i) => (
          <m.path key={i} d={d} fill={symbolFill} style={{ transformOrigin: 'center', transformBox: 'fill-box' }} {...motionProps(mode, symbolPoses[i])} />
        ))}
      </g>

      {/* os chips: soltos e apagados no começo, no anel e acesos no fim */}
      {chips.map((c) => (
        <m.g key={c.name} style={{ transformOrigin: 'center', transformBox: 'fill-box' }} {...motionProps(mode, c.chip)}>
          {/* brilho rosa quando o pulso chega */}
          <m.rect x={-c.hw - 4} y={-CHIP_H / 2 - 4} width={c.w + 8} height={CHIP_H + 8} rx={CHIP_H / 2 + 4} fill={col.glow} filter={`url(#${blurId})`} {...motionProps(mode, c.glow)} />
          <rect x={-c.hw} y={-CHIP_H / 2} width={c.w} height={CHIP_H} rx={CHIP_H / 2} fill={col.chipFill} stroke={col.chipStroke} strokeWidth="0.5" />
          <m.rect x={-c.hw} y={-CHIP_H / 2} width={c.w} height={CHIP_H} rx={CHIP_H / 2} fill="none" stroke={col.accent} strokeWidth="0.8" {...motionProps(mode, c.accent)} />
          {/* o losango do módulo: branco (ou roxo) até o pulso chegar, rosa depois */}
          <g transform={`translate(${c.glyphX} 0) rotate(45)`}>
            <rect x={-GLYPH / 2} y={-GLYPH / 2} width={GLYPH} height={GLYPH} rx="0.8" fill={col.glyph} />
            <m.rect x={-GLYPH / 2} y={-GLYPH / 2} width={GLYPH} height={GLYPH} rx="0.8" fill={col.accent} {...motionProps(mode, c.lit)} />
          </g>
          <text x={c.textX} y="0" fontFamily={FONT_FAMILY} fontSize={FONT} fontWeight="600" letterSpacing="-0.01em" fill={col.text} dominantBaseline="central">
            {c.name}
          </text>
        </m.g>
      ))}

      {/* a legenda */}
      <m.text x={CX} y={CAPTION_Y} textAnchor="middle" fontFamily={FONT_FAMILY} fontSize="8.5" fontWeight="700" letterSpacing="-0.01em" fill={col.caption} {...motionProps(mode, captionPose)}>
        Um sistema. <tspan fill={col.captionAccent}>Uma experiência.</tspan>
      </m.text>
    </svg>
  )
}
