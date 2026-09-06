import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { BrandGradient, Logo } from './Logo'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from './logo-paths'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * Motion da assinatura Natcorp, em três atos:
 * 1. Os quatro losangos chegam de fora, girando, e se encaixam no centro, formando o símbolo.
 * 2. No encaixe, o X vazado do meio acende do centro para fora, como um raio rosa que atravessa o símbolo.
 * 3. O símbolo desliza para a esquerda e o wordmark "natcorp" se revela ao lado.
 * Tudo em SVG, nas proporções do manual. Com movimento reduzido, mostra a assinatura pronta.
 */

/** Duração total, para quem espera o fim (a abertura do site, por exemplo). */
export const LOGO_MOTION_MS = 3300

const PAD = 4
const C = SYMBOL_BOX / 2
/** O símbolo começa centralizado na caixa do lockup e desliza até a posição final (x = 0). */
const SYMBOL_START_X = H_WIDTH / 2 - C
const ARM = 2.75

/* Linha do tempo, em segundos. */
const T = {
  fly: 0.1,
  flyDur: 0.95,
  stagger: 0.07,
  impact: 1.12,
  ray: 1.18,
  rayDur: 0.55,
  slide: 1.95,
  slideDur: 0.65,
  words: 2.1,
  wordsDur: 0.6,
  rayOut: 2.45,
  rayOutDur: 0.7,
}

/* De onde cada losango vem (topo, direita, esquerda, base) e quanto gira até encaixar. */
const flyFrom = [
  { x: 0, y: -3.4, rotate: -90 },
  { x: 3.4, y: 0, rotate: 90 },
  { x: -3.4, y: 0, rotate: -90 },
  { x: 0, y: 3.4, rotate: 90 },
]

/* Os quatro braços do X vazado, do centro para cada canto. */
const arms = [
  [C + ARM, C - ARM],
  [C + ARM, C + ARM],
  [C - ARM, C + ARM],
  [C - ARM, C - ARM],
] as const

interface LogoMotionProps {
  /** `white` para fundos escuros; `gradient` para fundos claros. */
  tone?: 'white' | 'gradient'
  /** Dispara a sequência. Para repetir, troque a `key` do componente. */
  play?: boolean
  className?: string
  onComplete?: () => void
}

export function LogoMotion({ tone = 'white', play = true, className, onComplete }: LogoMotionProps) {
  const reduced = useReducedMotion()
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const gradId = `lm-grad-${uid}`
  const rayId = `lm-ray-${uid}`
  const glowId = `lm-glow-${uid}`
  const clipId = `lm-clip-${uid}`

  useEffect(() => {
    if (!play || !onComplete) return
    const t = window.setTimeout(onComplete, reduced ? 0 : LOGO_MOTION_MS)
    return () => window.clearTimeout(t)
  }, [play, reduced, onComplete])

  if (reduced) {
    return <Logo variant="horizontal" tone={tone} decorative className={className} />
  }

  const symbolFill = tone === 'white' ? '#FFFFFF' : `url(#${gradId})`
  const wordFill = tone === 'white' ? '#FFFFFF' : '#1B1238'
  const state = play ? 'on' : 'off'

  return (
    <svg
      viewBox={`${-PAD} ${-PAD} ${H_WIDTH + PAD * 2} ${SYMBOL_BOX + PAD * 2}`}
      className={cn('block overflow-visible', className)}
      aria-hidden
      focusable="false"
    >
      <defs>
        <BrandGradient id={gradId} />
        {/* o raio: núcleo quente no centro, rosa da marca no meio, esmaecendo nas pontas */}
        <radialGradient id={rayId} gradientUnits="userSpaceOnUse" cx={C} cy={C} r={ARM + 0.9}>
          <stop offset="0" stopColor="#FFF1F6" />
          <stop offset="0.1" stopColor="#F5B4CC" />
          <stop offset="0.32" stopColor="#C95788" />
          <stop offset="0.8" stopColor="#C95788" stopOpacity="0.7" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0" />
        </radialGradient>
        <filter id={glowId} x="-60%" y="-60%" width="220%" height="220%">
          <feGaussianBlur stdDeviation="0.5" />
        </filter>
        <filter id={`${glowId}-wide`} x="-100%" y="-100%" width="300%" height="300%">
          <feGaussianBlur stdDeviation="1.1" />
        </filter>
        {/* a janela do wordmark acompanha o símbolo: abre logo à direita dele enquanto ele desliza */}
        <clipPath id={clipId}>
          <m.rect
            y={-1}
            height={SYMBOL_BOX + 2}
            initial={{ x: SYMBOL_START_X + SYMBOL_BOX + 0.6, width: 0 }}
            animate={
              state === 'on'
                ? { x: SYMBOL_BOX + 0.6, width: H_WIDTH - SYMBOL_BOX }
                : { x: SYMBOL_START_X + SYMBOL_BOX + 0.6, width: 0 }
            }
            transition={{
              x: { duration: T.slideDur, ease: EASE, delay: T.slide },
              width: { duration: T.wordsDur, ease: EASE, delay: T.words },
            }}
          />
        </clipPath>
      </defs>

      {/* wordmark: revelado da esquerda para a direita, logo atrás do símbolo que desliza */}
      <g clipPath={`url(#${clipId})`}>
        {WORDMARK_H.map((d, i) => (
          <m.path
            key={i}
            d={d}
            fill={wordFill}
            initial={{ opacity: 0, x: -1.2 }}
            animate={state === 'on' ? { opacity: 1, x: 0 } : { opacity: 0, x: -1.2 }}
            transition={{ duration: 0.5, ease: EASE, delay: T.words + 0.04 + i * 0.035 }}
          />
        ))}
      </g>

      {/* símbolo: nasce no centro do lockup e desliza para a esquerda quando o wordmark aparece */}
      <m.g initial={{ x: SYMBOL_START_X }} animate={state === 'on' ? { x: 0 } : { x: SYMBOL_START_X }} transition={{ duration: T.slideDur, ease: EASE, delay: T.slide }}>
        {/* o raio no X vazado: brilho desfocado por baixo, traço nítido por cima; os losangos cobrem as bordas */}
        <m.g initial={{ opacity: 1 }} animate={state === 'on' ? { opacity: 0 } : { opacity: 1 }} transition={{ duration: T.rayOutDur, ease: 'easeOut', delay: T.rayOut }}>
          {/* clarão largo e difuso, como luz vazando pelas frestas */}
          <g filter={`url(#${glowId}-wide)`} opacity="0.55">
            {arms.map(([x, y], i) => (
              <m.path
                key={`w${i}`}
                d={`M${C} ${C} L${x} ${y}`}
                stroke="#C95788"
                strokeWidth="1.7"
                strokeLinecap="round"
                fill="none"
                initial={{ pathLength: 0, opacity: 0 }}
                animate={state === 'on' ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
                transition={{ duration: T.rayDur + 0.15, ease: 'easeOut', delay: T.ray }}
              />
            ))}
          </g>
          <g filter={`url(#${glowId})`}>
            {arms.map(([x, y], i) => (
              <m.path
                key={`g${i}`}
                d={`M${C} ${C} L${x} ${y}`}
                stroke={`url(#${rayId})`}
                strokeWidth="0.95"
                strokeLinecap="round"
                fill="none"
                initial={{ pathLength: 0, opacity: 0 }}
                animate={state === 'on' ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
                transition={{ duration: T.rayDur, ease: 'easeOut', delay: T.ray }}
              />
            ))}
          </g>
          {arms.map(([x, y], i) => (
            <m.path
              key={`r${i}`}
              d={`M${C} ${C} L${x} ${y}`}
              stroke={`url(#${rayId})`}
              strokeWidth="0.36"
              strokeLinecap="round"
              fill="none"
              initial={{ pathLength: 0, opacity: 0 }}
              animate={state === 'on' ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
              transition={{ duration: T.rayDur, ease: 'easeOut', delay: T.ray }}
            />
          ))}
          {/* o clarão do encaixe, no centro */}
          <m.circle
            cx={C}
            cy={C}
            r="0.5"
            fill="#F3C9DA"
            style={{ transformOrigin: `${C}px ${C}px` }}
            initial={{ scale: 0, opacity: 0 }}
            animate={state === 'on' ? { scale: [0, 5.5, 7], opacity: [0, 0.75, 0] } : { scale: 0, opacity: 0 }}
            transition={{ duration: 0.7, ease: 'easeOut', delay: T.impact, times: [0, 0.4, 1] }}
          />
        </m.g>

        {/* os quatro losangos: chegam de fora girando, encaixam e dão um leve pulso no impacto */}
        {MODULES.map((d, i) => (
          <m.path
            key={i}
            d={d}
            fill={symbolFill}
            style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
            initial={{ opacity: 0, x: flyFrom[i].x, y: flyFrom[i].y, rotate: flyFrom[i].rotate, scale: 0.6 }}
            animate={
              state === 'on'
                ? { opacity: 1, x: 0, y: 0, rotate: 0, scale: [0.6, 1, 1.07, 1] }
                : { opacity: 0, x: flyFrom[i].x, y: flyFrom[i].y, rotate: flyFrom[i].rotate, scale: 0.6 }
            }
            transition={{
              opacity: { duration: 0.35, ease: 'easeOut', delay: T.fly + i * T.stagger },
              x: { duration: T.flyDur, ease: EASE, delay: T.fly + i * T.stagger },
              y: { duration: T.flyDur, ease: EASE, delay: T.fly + i * T.stagger },
              rotate: { duration: T.flyDur, ease: EASE, delay: T.fly + i * T.stagger },
              scale: { duration: T.impact + 0.3 - T.fly, ease: 'easeOut', delay: T.fly, times: [0, 0.78, 0.9, 1] },
            }}
          />
        ))}
      </m.g>
    </svg>
  )
}
