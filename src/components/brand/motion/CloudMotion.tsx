import { useEffect, useId } from 'react'
import { m, useReducedMotion, type TargetAndTransition, type Transition } from 'motion/react'
import { BrandGradient } from '../Logo'
import { MODULES, SYMBOL_BOX } from '../logo-paths'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * A nuvem Natcorp, em três atos:
 * 1. Uma nuvem grande se desenha em um traço só, com o rótulo "Oracle Cloud Infrastructure" e o selo "Servidores dedicados".
 * 2. Dentro dela sobem os dois servidores (aplicação e banco de dados); o símbolo Natcorp cai entre eles
 *    e um pulso rosa, na linguagem do raio da assinatura, atravessa os dois cartões: o sistema mora aqui.
 * 3. À esquerda aparecem os dispositivos do usuário e o Web Application Firewall; trilhos tracejados ligam
 *    tudo, ida e volta, com HTTPS e dois fatores no caminho; os servidores acendem e o rodapé fecha a cena.
 * Tudo em SVG (320 × 176 unidades). Com movimento reduzido, mostra a cena pronta.
 */

/** Duração total, para quem espera o fim. */
export const CLOUD_MOTION_MS = 5600

const VB_W = 320
const VB_H = 176

/* Linha do tempo, em segundos. */
const T = {
  cloud: 0.05,
  cloudDur: 1.2,
  fill: 0.75,
  eyebrow: 0.9,
  pill: 1.1,
  cards: 1.45,
  cardGap: 0.18,
  cardDur: 0.6,
  chips: 1.85,
  chipGap: 0.07,
  drop: 2.35,
  dropDur: 0.5,
  impact: 2.8,
  ray: 2.85,
  rayDur: 0.5,
  glow: 2.95,
  glowDur: 0.9,
  rayOut: 3.4,
  rayOutDur: 0.5,
  devices: 3.3,
  deviceGap: 0.15,
  bus: 3.6,
  busDur: 0.35,
  shield: 3.75,
  shieldDur: 0.45,
  check: 3.98,
  checkDur: 0.3,
  waf: 3.95,
  https: 4.05,
  lanes: 4.15,
  laneDur: 0.18,
  laneGap: 0.2,
  tag: 4.45,
  flow: 4.95,
  status: 4.75,
  statusGap: 0.25,
  footer: 5.05,
  footerDur: 0.5,
}

/* ------------------------------------------------------------------------------------------------
 * Geometria
 * ---------------------------------------------------------------------------------------------- */

interface Circle {
  x: number
  y: number
  r: number
}

/** A nuvem: duas pontas arredondadas e três bolhas de coroa, sobre uma base plana em y = CLOUD_BASE. */
const CLOUD_BUMPS: Circle[] = [
  { x: 158, y: 110, r: 32 },
  { x: 170, y: 84, r: 32 },
  { x: 223, y: 78, r: 36 },
  { x: 275, y: 84, r: 32 },
  { x: 284, y: 110, r: 32 },
]
const CLOUD_BASE = 142
const CLOUD_CX = 223

/** Ponto de cima em que dois círculos vizinhos se cruzam: a reentrância entre duas bolhas. */
function upperCrossing(a: Circle, b: Circle) {
  const dx = b.x - a.x
  const dy = b.y - a.y
  const d = Math.hypot(dx, dy)
  const along = (a.r * a.r - b.r * b.r + d * d) / (2 * d)
  const h = Math.sqrt(a.r * a.r - along * along)
  const px = a.x + (along * dx) / d
  const py = a.y + (along * dy) / d
  const p1 = { x: px - (h * dy) / d, y: py + (h * dx) / d }
  const p2 = { x: px + (h * dy) / d, y: py - (h * dx) / d }
  return p1.y < p2.y ? p1 : p2
}

/** O contorno: sobe pela ponta esquerda, percorre a coroa em arcos e desce pela direita; a base fecha o traço. */
function cloudPath(bumps: Circle[], base: number) {
  const f = (n: number) => n.toFixed(2)
  let prev = { x: bumps[0].x, y: base }
  let d = `M${f(prev.x)} ${f(prev.y)}`
  bumps.forEach((b, i) => {
    const next = i < bumps.length - 1 ? upperCrossing(b, bumps[i + 1]) : { x: b.x, y: base }
    const a0 = Math.atan2(prev.y - b.y, prev.x - b.x)
    const a1 = Math.atan2(next.y - b.y, next.x - b.x)
    let sweep = a1 - a0
    while (sweep < 0) sweep += Math.PI * 2
    d += ` A${b.r} ${b.r} 0 ${sweep > Math.PI ? 1 : 0} 1 ${f(next.x)} ${f(next.y)}`
    prev = next
  })
  return `${d} Z`
}

const CLOUD_D = cloudPath(CLOUD_BUMPS, CLOUD_BASE)

/* Cartões dos servidores, dentro da nuvem. */
const CARD_W = 78
const CARD_H = 54
const CARD_Y = 80
const CARDS = [
  {
    x: 143,
    title: ['Servidor de', 'aplicação'],
    chips: ['REST Data Services', 'Oracle WebLogic', 'Aplicações Java'],
    accent: -1,
    glyph: 'server',
  },
  {
    x: 225,
    title: ['Servidor de', 'banco de dados'],
    chips: ['Oracle APEX', 'Camada de permissões', 'Oracle Database'],
    accent: 2,
    glyph: 'database',
  },
] as const
const CHIP_H = 7.5
const CHIP_GAP = 2
/* Largura de cada chip, medida em Manrope 600 a 5,5 unidades, mais o respiro interno. */
const CHIP_W: Record<string, number> = {
  'REST Data Services': 57,
  'Oracle WebLogic': 50.5,
  'Aplicações Java': 48,
  'Oracle APEX': 38.5,
  'Camada de permissões': 67,
  'Oracle Database': 50,
}

/* O símbolo: 14 unidades, no alto da nuvem, entre os dois cartões. */
const SYM_SIZE = 14
const SYM_SCALE = SYM_SIZE / SYMBOL_BOX
const SYM_CX = CLOUD_CX
const SYM_CY = 60

/* Os raios do pulso: dois longos até o centro de cada cartão, dois curtos para cima, fechando o X. */
const RAYS = CARDS.map((c) => [c.x + CARD_W / 2, CARD_Y + CARD_H / 2 - 4] as const).concat([
  [SYM_CX - 15, SYM_CY - 16],
  [SYM_CX + 15, SYM_CY - 16],
])
const RAY_R = 62

/* Trilhos: do barramento dos dispositivos (x = 58) ao cartão de aplicação, com o escudo no meio. */
const LANE_Y = [88.5, 95.5] as const
const LANE_DASH = '3 5'
const LANE_PERIOD = 8
const SHIELD_CX = 98
const SHIELD_CY = 92
const LANES = [
  { x1: 58, x2: 86, y: LANE_Y[0], phase: 0, order: 0 },
  { x1: 108, x2: 141, y: LANE_Y[0], phase: 0, order: 1 },
  { x1: 141, x2: 108, y: LANE_Y[1], phase: 0, order: 2 },
  { x1: 86, x2: 61, y: LANE_Y[1], phase: -(55 % LANE_PERIOD), order: 3 },
]

/* ------------------------------------------------------------------------------------------------
 * Cores
 * ---------------------------------------------------------------------------------------------- */

const PALETTES = {
  white: {
    cloudStroke: 'rgba(255,255,255,0.9)',
    cloudFill: 'rgba(255,255,255,0.045)',
    text: '#FFFFFF',
    muted: 'rgba(255,255,255,0.62)',
    line: 'rgba(255,255,255,0.85)',
    track: 'rgba(255,255,255,0.24)',
    cardFill: 'rgba(255,255,255,0.08)',
    cardStroke: 'rgba(255,255,255,0.16)',
    chipFill: 'rgba(255,255,255,0.06)',
    chipStroke: 'rgba(255,255,255,0.14)',
    chipText: 'rgba(255,255,255,0.9)',
    iconBox: 'rgba(255,255,255,0.1)',
    accent: '#E4A9C4',
    accentFill: 'rgba(228,169,196,0.12)',
    accentStroke: 'rgba(228,169,196,0.55)',
    onAccent: '#2C1A63',
    dotOff: 'rgba(255,255,255,0.2)',
  },
  gradient: {
    cloudStroke: '#511C76',
    cloudFill: 'rgba(81,28,118,0.035)',
    text: '#1B1238',
    muted: '#4A4460',
    line: '#511C76',
    track: 'rgba(27,18,56,0.2)',
    cardFill: '#FFFFFF',
    cardStroke: '#E9E5F1',
    chipFill: '#F4F2F7',
    chipStroke: '#E9E5F1',
    chipText: '#4A4460',
    iconBox: 'rgba(81,28,118,0.08)',
    accent: '#C95788',
    accentFill: 'rgba(201,87,136,0.1)',
    accentStroke: 'rgba(201,87,136,0.5)',
    onAccent: '#FFFFFF',
    dotOff: 'rgba(27,18,56,0.14)',
  },
} as const

const PINK = '#C95788'
const GREEN = '#34D399'

/* ------------------------------------------------------------------------------------------------
 * Componente
 * ---------------------------------------------------------------------------------------------- */

interface CloudMotionProps {
  /** `white` para fundos escuros; `gradient` para fundos claros. */
  tone?: 'white' | 'gradient'
  /** Dispara a sequência. Para repetir, troque a `key` do componente. */
  play?: boolean
  className?: string
  onComplete?: () => void
}

/** Com movimento reduzido, cada elemento nasce já na pose final (último quadro de cada sequência). */
function settled(pose: TargetAndTransition): TargetAndTransition {
  const out: Record<string, unknown> = {}
  for (const [k, v] of Object.entries(pose)) out[k] = Array.isArray(v) ? v[v.length - 1] : v
  return out as TargetAndTransition
}

export function CloudMotion({ tone = 'white', play = true, className, onComplete }: CloudMotionProps) {
  const reduced = useReducedMotion()
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const gradId = `cm-grad-${uid}`
  const rayId = `cm-ray-${uid}`
  const glowId = `cm-glow-${uid}`
  const shadowId = `cm-shadow-${uid}`
  const clipId = `cm-clip-${uid}`
  const washId = `cm-wash-${uid}`

  useEffect(() => {
    if (!play || !onComplete) return
    const t = window.setTimeout(onComplete, reduced ? 0 : CLOUD_MOTION_MS)
    return () => window.clearTimeout(t)
  }, [play, reduced, onComplete])

  const p = PALETTES[tone]
  const dark = tone === 'white'
  const on = play && !reduced
  /* Cada elemento animado: pose inicial e pose final; com movimento reduzido, nasce pronto e parado. */
  const anim = (off: TargetAndTransition, to: TargetAndTransition, transition: Transition) =>
    reduced ? { initial: false as const, animate: settled(to) } : { initial: off, animate: on ? to : off, transition }

  const symbolFill = dark ? '#FFFFFF' : `url(#${gradId})`
  const cardFilter = dark ? undefined : `url(#${shadowId})`
  const laneCount = LANES.length

  return (
    <svg
      viewBox={`0 0 ${VB_W} ${VB_H}`}
      className={cn('block overflow-visible', className)}
      fontFamily="Manrope, system-ui, sans-serif"
      aria-hidden
      focusable="false"
    >
      <defs>
        <BrandGradient id={gradId} />
        {/* o raio: núcleo quente no centro do símbolo, rosa da marca no meio, esmaecendo nas pontas */}
        <radialGradient id={rayId} gradientUnits="userSpaceOnUse" cx={SYM_CX} cy={SYM_CY} r={RAY_R}>
          <stop offset="0" stopColor="#FFF1F6" />
          <stop offset="0.08" stopColor="#F5B4CC" />
          <stop offset="0.3" stopColor={PINK} />
          <stop offset="0.8" stopColor={PINK} stopOpacity="0.7" />
          <stop offset="1" stopColor={PINK} stopOpacity="0" />
        </radialGradient>
        {/* o clarão que se espalha pela nuvem no impacto, preso ao contorno dela */}
        <radialGradient id={washId} cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#F5B4CC" stopOpacity="0.9" />
          <stop offset="0.35" stopColor={PINK} stopOpacity="0.5" />
          <stop offset="1" stopColor={PINK} stopOpacity="0" />
        </radialGradient>
        <clipPath id={clipId}>
          <path d={CLOUD_D} />
        </clipPath>
        <filter id={glowId} x="-40%" y="-40%" width="180%" height="180%">
          <feGaussianBlur stdDeviation="1.4" />
        </filter>
        <filter id={shadowId} x="-10%" y="-10%" width="120%" height="130%">
          <feDropShadow dx="0" dy="1.2" stdDeviation="1.6" floodColor="#2C1A63" floodOpacity="0.12" />
        </filter>
      </defs>

      {/* ---------------------------------------------------------------- Ato 1: a nuvem */}
      <m.path
        d={CLOUD_D}
        fill={p.cloudFill}
        stroke="none"
        {...anim({ opacity: 0 }, { opacity: 1 }, { duration: 0.7, ease: 'easeOut', delay: T.fill })}
      />
      <m.path
        d={CLOUD_D}
        fill="none"
        stroke={p.cloudStroke}
        strokeWidth="1.4"
        strokeLinecap="round"
        strokeLinejoin="round"
        {...anim(
          { pathLength: 0, opacity: 0 },
          { pathLength: 1, opacity: 1 },
          { pathLength: { duration: T.cloudDur, ease: EASE, delay: T.cloud }, opacity: { duration: 0.2, delay: T.cloud } },
        )}
      />

      {/* rótulo da nuvem: eyebrow espaçado e selo rosa */}
      <m.text
        x={CLOUD_CX}
        y={19}
        textAnchor="middle"
        fontSize="5.5"
        fontWeight="700"
        letterSpacing="0.7"
        fill={p.accent}
        {...anim({ opacity: 0, y: 4 }, { opacity: 1, y: 0 }, { duration: 0.5, ease: EASE, delay: T.eyebrow })}
      >
        ORACLE CLOUD INFRASTRUCTURE
      </m.text>
      <m.g
        style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
        {...anim({ opacity: 0, scale: 0.85 }, { opacity: 1, scale: 1 }, { duration: 0.5, ease: EASE, delay: T.pill })}
      >
        <rect x={CLOUD_CX - 42.5} y={24} width={85} height={11} rx={5.5} fill={PINK} />
        {/* servidor: dois módulos empilhados com uma luz cada */}
        <g stroke="#FFFFFF" strokeWidth="0.8" fill="none" strokeLinecap="round">
          <rect x={CLOUD_CX - 36.5} y={26.9} width={5.6} height={2.3} rx={0.7} />
          <rect x={CLOUD_CX - 36.5} y={30.3} width={5.6} height={2.3} rx={0.7} />
        </g>
        <text x={CLOUD_CX - 28.4} y={31.65} fontSize="6" fontWeight="700" fill="#FFFFFF">
          Servidores dedicados
        </text>
      </m.g>

      {/* ---------------------------------------------------------------- Ato 2: os servidores */}
      {CARDS.map((card, ci) => {
        const x0 = card.x
        const y0 = CARD_Y
        const delay = T.cards + ci * T.cardGap
        const statusAt = T.status + ci * T.statusGap
        return (
          <g key={card.x}>
            <m.g {...anim({ opacity: 0, y: 12 }, { opacity: 1, y: 0 }, { duration: T.cardDur, ease: EASE, delay })}>
              <rect x={x0} y={y0} width={CARD_W} height={CARD_H} rx={3.5} fill={p.cardFill} stroke={p.cardStroke} strokeWidth="0.6" filter={cardFilter} />
              {/* ícone do servidor */}
              <rect x={x0 + 5} y={y0 + 4.5} width={8} height={8} rx={2} fill={p.iconBox} />
              {card.glyph === 'server' ? (
                <g stroke={p.text} strokeWidth="0.75" fill="none" strokeLinecap="round">
                  <rect x={x0 + 6.4} y={y0 + 6} width={5.2} height={2.2} rx={0.7} />
                  <rect x={x0 + 6.4} y={y0 + 8.8} width={5.2} height={2.2} rx={0.7} />
                  <path d={`M${x0 + 10.4} ${y0 + 7.1}h0.01M${x0 + 10.4} ${y0 + 9.9}h0.01`} strokeWidth="1" />
                </g>
              ) : (
                <g stroke={p.text} strokeWidth="0.75" fill="none" strokeLinecap="round">
                  <ellipse cx={x0 + 9} cy={y0 + 6.6} rx={2.7} ry={1.1} />
                  <path d={`M${x0 + 6.3} ${y0 + 6.6}v3.9a2.7 1.1 0 0 0 5.4 0v-3.9M${x0 + 6.3} ${y0 + 8.55}a2.7 1.1 0 0 0 5.4 0`} />
                </g>
              )}
              <text x={x0 + 16.5} y={y0 + 10.5} fontSize="7" fontWeight="800" fill={p.text}>
                {card.title[0]}
              </text>
              <text x={x0 + 16.5} y={y0 + 18.5} fontSize="7" fontWeight="800" fill={p.text}>
                {card.title[1]}
              </text>
              {/* chips */}
              {card.chips.map((chip, i) => {
                const cy = y0 + 23.5 + i * (CHIP_H + CHIP_GAP)
                const accent = i === card.accent
                return (
                  <m.g
                    key={chip}
                    {...anim(
                      { opacity: 0, y: 3 },
                      { opacity: 1, y: 0 },
                      { duration: 0.35, ease: EASE, delay: T.chips + (ci * 3 + i) * T.chipGap },
                    )}
                  >
                    <rect
                      x={x0 + 5}
                      y={cy}
                      width={CHIP_W[chip]}
                      height={CHIP_H}
                      rx={2}
                      fill={accent ? p.accentFill : p.chipFill}
                      stroke={accent ? p.accentStroke : p.chipStroke}
                      strokeWidth="0.5"
                    />
                    <text x={x0 + 8} y={cy + 5.55} fontSize="5.5" fontWeight="600" fill={accent ? p.text : p.chipText}>
                      {chip}
                    </text>
                  </m.g>
                )
              })}
              {/* luz de status: apagada até o fim, quando acende em sequência */}
              <m.circle
                cx={x0 + CARD_W - 8}
                cy={y0 + 7.5}
                r="1.7"
                style={{ transformOrigin: `${x0 + CARD_W - 8}px ${y0 + 7.5}px` }}
                {...anim(
                  { fill: p.dotOff, scale: 1 },
                  { fill: GREEN, scale: [1, 1.45, 1] },
                  { duration: 0.45, ease: 'easeOut', delay: statusAt, times: [0, 0.4, 1] },
                )}
              />
              <m.circle
                cx={x0 + CARD_W - 8}
                cy={y0 + 7.5}
                r="1.7"
                fill="none"
                stroke={GREEN}
                strokeWidth="0.8"
                style={{ transformOrigin: `${x0 + CARD_W - 8}px ${y0 + 7.5}px` }}
                {...anim(
                  { opacity: 0, scale: 1 },
                  { opacity: [0, 0.6, 0], scale: [1, 2.6, 3.2] },
                  { duration: 0.8, ease: 'easeOut', delay: statusAt + 0.05, times: [0, 0.35, 1] },
                )}
              />
            </m.g>
            {/* o brilho rosa do pulso na borda do cartão */}
            <m.rect
              x={x0}
              y={y0}
              width={CARD_W}
              height={CARD_H}
              rx={3.5}
              fill="none"
              stroke={PINK}
              strokeWidth="1.1"
              filter={`url(#${glowId})`}
              {...anim(
                { opacity: 0 },
                { opacity: [0, 0.95, 0] },
                { duration: T.glowDur, ease: 'easeInOut', delay: T.glow + ci * 0.08, times: [0, 0.3, 1] },
              )}
            />
          </g>
        )
      })}

      {/* o pulso: clarão no impacto, raios do centro do símbolo até os cartões, brilho difuso por baixo */}
      <g clipPath={`url(#${clipId})`}>
        <m.circle
          cx={SYM_CX}
          cy={SYM_CY}
          r="1"
          fill={`url(#${washId})`}
          style={{ transformOrigin: `${SYM_CX}px ${SYM_CY}px` }}
          {...anim(
            { scale: 0, opacity: 0 },
            { scale: [0, 80, 120], opacity: [0, dark ? 0.5 : 0.35, 0] },
            { duration: 1.1, ease: 'easeOut', delay: T.impact, times: [0, 0.3, 1] },
          )}
        />
      </g>
      <m.g
        {...anim({ opacity: 1 }, { opacity: [1, 1, 0] }, { duration: T.rayOut + T.rayOutDur, ease: 'easeOut', times: [0, T.rayOut / (T.rayOut + T.rayOutDur), 1] })}
      >
        <m.circle
          cx={SYM_CX}
          cy={SYM_CY}
          r="1"
          fill="#F3C9DA"
          style={{ transformOrigin: `${SYM_CX}px ${SYM_CY}px` }}
          {...anim(
            { scale: 0, opacity: 0 },
            { scale: [0, 7, 10], opacity: [0, 0.7, 0] },
            { duration: 0.7, ease: 'easeOut', delay: T.impact, times: [0, 0.4, 1] },
          )}
        />
        <g filter={`url(#${glowId})`} opacity="0.65">
          {RAYS.map(([x, y], i) => (
            <m.path
              key={`w${i}`}
              d={`M${SYM_CX} ${SYM_CY} L${x} ${y}`}
              stroke={PINK}
              strokeWidth="3.4"
              strokeLinecap="round"
              fill="none"
              {...anim(
                { pathLength: 0, opacity: 0 },
                { pathLength: 1, opacity: 1 },
                { duration: T.rayDur + 0.15, ease: 'easeOut', delay: T.ray },
              )}
            />
          ))}
        </g>
        {RAYS.map(([x, y], i) => (
          <m.path
            key={`r${i}`}
            d={`M${SYM_CX} ${SYM_CY} L${x} ${y}`}
            stroke={`url(#${rayId})`}
            strokeWidth="1.3"
            strokeLinecap="round"
            fill="none"
            {...anim({ pathLength: 0, opacity: 0 }, { pathLength: 1, opacity: 1 }, { duration: T.rayDur, ease: 'easeOut', delay: T.ray })}
          />
        ))}
      </m.g>

      {/* o símbolo cai no alto da nuvem e assenta com um leve pulo */}
      <m.g
        style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
        {...anim(
          { opacity: 0, y: -26, scale: 0.6 },
          { opacity: 1, y: 0, scale: [0.6, 1.1, 1] },
          {
            opacity: { duration: 0.25, ease: 'easeOut', delay: T.drop },
            y: { duration: T.dropDur, ease: EASE, delay: T.drop },
            scale: { duration: T.dropDur + 0.2, ease: 'easeOut', delay: T.drop, times: [0, 0.72, 1] },
          },
        )}
      >
        <g transform={`translate(${SYM_CX - SYM_SIZE / 2} ${SYM_CY - SYM_SIZE / 2}) scale(${SYM_SCALE})`}>
          {MODULES.map((d, i) => (
            <path key={i} d={d} fill={symbolFill} />
          ))}
        </g>
      </m.g>

      {/* ---------------------------------------------------------------- Ato 3: quem acessa e o que protege */}
      <m.text
        x={16}
        y={19}
        fontSize="5.5"
        fontWeight="700"
        letterSpacing="0.7"
        fill={p.accent}
        {...anim({ opacity: 0, y: 4 }, { opacity: 1, y: 0 }, { duration: 0.5, ease: EASE, delay: T.devices })}
      >
        DISPOSITIVO DO USUÁRIO
      </m.text>

      {/* desktop */}
      <m.g {...anim({ opacity: 0, x: -6 }, { opacity: 1, x: 0 }, { duration: 0.5, ease: EASE, delay: T.devices + 0.05 })}>
        <g stroke={p.line} strokeWidth="1.2" fill="none" strokeLinecap="round" strokeLinejoin="round">
          <rect x={19.5} y={61} width={25} height={16.5} rx={1.8} />
          <path d="M16 80.5H48" strokeWidth="1.5" />
        </g>
        <text x={32} y={89.5} textAnchor="middle" fontSize="6" fontWeight="700" fill={p.text}>
          Desktop
        </text>
      </m.g>
      {/* celular */}
      <m.g {...anim({ opacity: 0, x: -6 }, { opacity: 1, x: 0 }, { duration: 0.5, ease: EASE, delay: T.devices + T.deviceGap + 0.05 })}>
        <g stroke={p.line} strokeWidth="1.2" fill="none" strokeLinecap="round" strokeLinejoin="round">
          <rect x={26.5} y={100} width={11} height={20} rx={2} />
          <path d="M30 103.2h4" strokeWidth="1" />
        </g>
        <text x={32} y={129.5} textAnchor="middle" fontSize="6" fontWeight="700" fill={p.text}>
          Celular
        </text>
      </m.g>
      {/* barramento: os dois dispositivos entram no mesmo trilho */}
      <m.path
        d="M45 69.5H58V110H38"
        fill="none"
        stroke={p.track}
        strokeWidth="1"
        strokeLinecap="round"
        strokeLinejoin="round"
        {...anim({ pathLength: 0, opacity: 0 }, { pathLength: 1, opacity: 1 }, { duration: T.busDur, ease: EASE, delay: T.bus })}
      />

      {/* o escudo do Web Application Firewall, sobre os trilhos */}
      <m.g
        style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
        {...anim({ opacity: 0, scale: 0.55 }, { opacity: 1, scale: [0.55, 1.08, 1] }, { duration: T.shieldDur, ease: EASE, delay: T.shield, times: [0, 0.7, 1] })}
      >
        <path
          d={`M${SHIELD_CX} ${SHIELD_CY - 12.5} C${SHIELD_CX + 4} ${SHIELD_CY - 10.2} ${SHIELD_CX + 7.6} ${SHIELD_CY - 9} ${SHIELD_CX + 10.5} ${SHIELD_CY - 8.7} V${SHIELD_CY + 1} C${SHIELD_CX + 10.5} ${SHIELD_CY + 7.6} ${SHIELD_CX + 6.2} ${SHIELD_CY + 11.5} ${SHIELD_CX} ${SHIELD_CY + 13.5} C${SHIELD_CX - 6.2} ${SHIELD_CY + 11.5} ${SHIELD_CX - 10.5} ${SHIELD_CY + 7.6} ${SHIELD_CX - 10.5} ${SHIELD_CY + 1} V${SHIELD_CY - 8.7} C${SHIELD_CX - 7.6} ${SHIELD_CY - 9} ${SHIELD_CX - 4} ${SHIELD_CY - 10.2} ${SHIELD_CX} ${SHIELD_CY - 12.5} Z`}
          fill={dark ? p.accent : PINK}
        />
      </m.g>
      <m.path
        d={`M${SHIELD_CX - 5} ${SHIELD_CY + 0.5} L${SHIELD_CX - 1.5} ${SHIELD_CY + 4} L${SHIELD_CX + 5.5} ${SHIELD_CY - 3.5}`}
        fill="none"
        stroke={p.onAccent}
        strokeWidth="1.7"
        strokeLinecap="round"
        strokeLinejoin="round"
        {...anim({ pathLength: 0, opacity: 0 }, { pathLength: 1, opacity: 1 }, { duration: T.checkDur, ease: EASE, delay: T.check })}
      />
      <m.g {...anim({ opacity: 0, y: 3 }, { opacity: 1, y: 0 }, { duration: 0.5, ease: EASE, delay: T.waf })}>
        <text x={SHIELD_CX} y={113.5} textAnchor="middle" fontSize="6" fontWeight="700" fill={p.text}>
          Web Application
        </text>
        <text x={SHIELD_CX} y={121} textAnchor="middle" fontSize="6" fontWeight="700" fill={p.text}>
          Firewall
        </text>
      </m.g>

      {/* HTTPS: cadeado e rótulo sobre o primeiro trecho do trilho */}
      <m.g {...anim({ opacity: 0, y: 3 }, { opacity: 1, y: 0 }, { duration: 0.45, ease: EASE, delay: T.https })}>
        <g stroke={p.accent} strokeWidth="0.9" fill="none" strokeLinecap="round">
          <rect x={60.5} y={78.9} width={5} height={3.9} rx={0.8} />
          <path d="M61.8 78.9V77.8a1.2 1.2 0 0 1 2.4 0v1.1" />
        </g>
        <text x={67.8} y={82.6} fontSize="5.5" fontWeight="700" fill={p.accent}>
          HTTPS
        </text>
      </m.g>

      {/* trilhos: a base de cada trecho se desenha em sequência (ida por cima, volta por baixo) */}
      {LANES.map((l) => (
        <m.line
          key={`t${l.order}`}
          x1={l.x1}
          y1={l.y}
          x2={l.x2}
          y2={l.y}
          stroke={p.track}
          strokeWidth="1.2"
          strokeLinecap="round"
          {...anim(
            { pathLength: 0, opacity: 0 },
            { pathLength: 1, opacity: 1 },
            { duration: T.laneDur, ease: 'easeOut', delay: T.lanes + l.order * T.laneGap },
          )}
        />
      ))}
      {/* pontas de seta: entrando no servidor e voltando aos dispositivos */}
      <m.path
        d={`M138.6 ${LANE_Y[0] - 2.6} L141.4 ${LANE_Y[0]} L138.6 ${LANE_Y[0] + 2.6}`}
        fill="none"
        stroke={p.accent}
        strokeWidth="1.2"
        strokeLinecap="round"
        strokeLinejoin="round"
        {...anim({ opacity: 0 }, { opacity: 1 }, { duration: 0.25, delay: T.lanes + 1 * T.laneGap + T.laneDur })}
      />
      <m.path
        d={`M63.4 ${LANE_Y[1] - 2.6} L60.6 ${LANE_Y[1]} L63.4 ${LANE_Y[1] + 2.6}`}
        fill="none"
        stroke={p.accent}
        strokeWidth="1.2"
        strokeLinecap="round"
        strokeLinejoin="round"
        {...anim({ opacity: 0 }, { opacity: 1 }, { duration: 0.25, delay: T.lanes + (laneCount - 1) * T.laneGap + T.laneDur })}
      />
      {/* o tráfego: tracejado que corre pelos trilhos e segue correndo depois do fim */}
      {LANES.map((l) => (
        <m.line
          key={`f${l.order}`}
          x1={l.x1}
          y1={l.y}
          x2={l.x2}
          y2={l.y}
          stroke={p.accent}
          strokeWidth="1.2"
          strokeLinecap="round"
          strokeDasharray={LANE_DASH}
          {...anim(
            { opacity: 0, strokeDashoffset: l.phase },
            { opacity: 1, strokeDashoffset: [l.phase, l.phase - LANE_PERIOD] },
            {
              opacity: { duration: 0.4, ease: 'easeOut', delay: T.flow },
              strokeDashoffset: { duration: 0.9, ease: 'linear', repeat: Infinity, delay: T.flow },
            },
          )}
        />
      ))}

      {/* 2FA: etiqueta no trecho entre o firewall e a nuvem */}
      <m.g
        style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
        {...anim({ opacity: 0, scale: 0.7 }, { opacity: 1, scale: 1 }, { duration: 0.4, ease: EASE, delay: T.tag })}
      >
        <rect x={117} y={77} width={15} height={7} rx={3.5} fill={p.accentFill} stroke={p.accentStroke} strokeWidth="0.5" />
        <text x={124.5} y={82.15} textAnchor="middle" fontSize="5" fontWeight="800" fill={p.accent}>
          2FA
        </text>
      </m.g>

      {/* rodapé */}
      <m.text
        x={CLOUD_CX}
        y={156}
        textAnchor="middle"
        fontSize="6"
        fontWeight="600"
        fill={p.muted}
        {...anim({ opacity: 0, y: 3 }, { opacity: 1, y: 0 }, { duration: T.footerDur, ease: EASE, delay: T.footer })}
      >
        Backups e contingência na Oracle Cloud
      </m.text>
    </svg>
  )
}
