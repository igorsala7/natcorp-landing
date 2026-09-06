import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { BrandGradient, Logo } from './Logo'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * Motion da assinatura Natcorp, em três atos, lentos e deliberados:
 * 1. Os quatro losangos se aproximam de longe, devagar, e se encaixam no centro.
 * 2. Um instante parado. Então o X vazado dispara do centro para fora, um raio rosa, com um pulso de choque.
 * 3. O raio esmaece enquanto o símbolo desliza e o wordmark "natcorp" surge ao lado, tudo centralizado.
 * Feita para o fundo claro, com o símbolo no gradiente da marca. Com movimento reduzido, mostra a assinatura pronta.
 */

/** Duração total, para quem espera o fim (a abertura do site, por exemplo). */
export const LOGO_MOTION_MS = 4700

const PAD = 4.5
const C = SYMBOL_BOX / 2
/** O símbolo nasce centralizado na caixa do lockup e desliza até a posição final (x = 0). */
const SYMBOL_START_X = H_WIDTH / 2 - C
/** Alcance do raio a partir do centro (os losangos terminam a ~2,6 unidades no diagonal). */
const ARM = 4.4
/** Distância inicial dos losangos ao centro, e o quanto giram no caminho. */
const FAR = 2.4
const TILT = 9

/** A curva da pantera: sai devagar, assenta devagar, sem quique. */
const SLOW = [0.2, 0.8, 0.2, 1] as const
/** O bote: rápido no início, freia seco. */
const STRIKE = [0.05, 0.9, 0.1, 1] as const

/* Linha do tempo, em segundos. */
const T = {
  approach: 0.05,
  approachDur: 1.75,
  stagger: 0.06,
  strike: 2.05,
  strikeDur: 0.34,
  recoil: 2.05,
  wave: 2.05,
  waveDur: 1.1,
  rayOut: 3.05,
  rayOutDur: 1.35,
  slide: 3.0,
  slideDur: 1.15,
  words: 3.1,
  wordsDur: 1.05,
  letters: 3.18,
  letterStagger: 0.07,
  letterDur: 0.85,
}

/* De onde cada losango vem (topo, direita, esquerda, base), quanto gira e para onde recua no bote. */
const path = [
  { x: 0, y: -FAR, rotate: -TILT, kx: 0, ky: -0.16 },
  { x: FAR, y: 0, rotate: TILT, kx: 0.16, ky: 0 },
  { x: -FAR, y: 0, rotate: -TILT, kx: -0.16, ky: 0 },
  { x: 0, y: FAR, rotate: TILT, kx: 0, ky: 0.16 },
]

/* Os quatro braços do X vazado, do centro para cada canto. */
const arms = [
  [C + ARM, C - ARM],
  [C + ARM, C + ARM],
  [C - ARM, C + ARM],
  [C - ARM, C - ARM],
] as const
/* Os mesmos braços como lâminas: largas no centro, afiadas na ponta (desenhadas no eixo x e giradas). */
const BLADE_W = 0.95
const BLADE_LEN = ARM * Math.SQRT2
const blade = `M${C} ${C - BLADE_W / 2} L${C + BLADE_LEN} ${C} L${C} ${C + BLADE_W / 2} Z`
const bladeAngles = [-45, 45, 135, -135]

interface LogoMotionProps {
  /** `gradient` para fundos claros (padrão); `white` para fundos escuros. */
  tone?: 'gradient' | 'white'
  /** Dispara a sequência. Para repetir, troque a `key` do componente. */
  play?: boolean
  className?: string
  onComplete?: () => void
}

export function LogoMotion({ tone = 'gradient', play = true, className, onComplete }: LogoMotionProps) {
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

  const light = tone === 'gradient'
  const symbolFill = light ? `url(#${gradId})` : '#FFFFFF'
  const wordFill = light ? '#1B1238' : '#FFFFFF'
  /* O raio é o rosa da marca, denso, sem núcleo branco: no claro o centro é um rosa mais fechado. */
  const ray = light
    ? { core: '#A8386A', mid: '#C95788', tip: '#C95788', glow: '#C95788', wave: '#C95788' }
    : { core: '#E4A9C4', mid: '#C95788', tip: '#C95788', glow: '#C95788', wave: '#E4A9C4' }
  const on = play

  return (
    <svg
      viewBox={`${-PAD} ${-PAD} ${H_WIDTH + PAD * 2} ${SYMBOL_BOX + PAD * 2}`}
      className={cn('block overflow-visible', className)}
      aria-hidden
      focusable="false"
    >
      <defs>
        <BrandGradient id={gradId} />
        <radialGradient id={rayId} gradientUnits="userSpaceOnUse" cx={C} cy={C} r={ARM + 0.2}>
          <stop offset="0" stopColor={ray.core} />
          <stop offset="0.28" stopColor={ray.mid} />
          <stop offset="0.85" stopColor={ray.tip} />
          <stop offset="1" stopColor={ray.tip} stopOpacity="0.2" />
        </radialGradient>
        <filter id={glowId} x="-60%" y="-60%" width="220%" height="220%">
          <feGaussianBlur stdDeviation="0.45" />
        </filter>
        <filter id={`${glowId}-wide`} x="-100%" y="-100%" width="300%" height="300%">
          <feGaussianBlur stdDeviation="1.25" />
        </filter>
        {/* a janela do wordmark acompanha o símbolo: abre à direita dele enquanto ele desliza */}
        <clipPath id={clipId}>
          <m.rect
            y={-1}
            height={SYMBOL_BOX + 2}
            initial={{ x: SYMBOL_START_X + SYMBOL_BOX + 0.6, width: 0 }}
            animate={on ? { x: SYMBOL_BOX + 0.6, width: H_WIDTH - SYMBOL_BOX } : { x: SYMBOL_START_X + SYMBOL_BOX + 0.6, width: 0 }}
            transition={{
              x: { duration: T.slideDur, ease: SLOW, delay: T.slide },
              width: { duration: T.wordsDur, ease: SLOW, delay: T.words },
            }}
          />
        </clipPath>
      </defs>

      {/* wordmark: surge letra a letra, de leve, atrás do símbolo que desliza */}
      <g clipPath={`url(#${clipId})`}>
        {WORDMARK_H.map((d, i) => (
          <m.path
            key={i}
            d={d}
            fill={wordFill}
            initial={{ opacity: 0, x: -0.55 }}
            animate={on ? { opacity: 1, x: 0 } : { opacity: 0, x: -0.55 }}
            transition={{ duration: T.letterDur, ease: SLOW, delay: T.letters + i * T.letterStagger }}
          />
        ))}
      </g>

      {/* símbolo: nasce no centro do lockup e desliza para a esquerda quando o wordmark aparece */}
      <m.g initial={{ x: SYMBOL_START_X }} animate={on ? { x: 0 } : { x: SYMBOL_START_X }} transition={{ duration: T.slideDur, ease: SLOW, delay: T.slide }}>
        {/* o raio no X vazado: um brilho largo, um brilho curto e o traço nítido; os losangos cobrem as bordas */}
        <m.g initial={{ opacity: 1 }} animate={on ? { opacity: 0 } : { opacity: 1 }} transition={{ duration: T.rayOutDur, ease: 'easeInOut', delay: T.rayOut }}>
          {/* onda de choque: um anel rosa que se expande e some, sem luz branca */}
          <m.circle
            cx={C}
            cy={C}
            r="1"
            fill="none"
            stroke={ray.wave}
            strokeWidth="0.22"
            style={{ transformOrigin: `${C}px ${C}px` }}
            initial={{ scale: 0.2, opacity: 0 }}
            animate={on ? { scale: [0.2, 4.2, 6.5], opacity: [0, 0.32, 0] } : { scale: 0.2, opacity: 0 }}
            transition={{ duration: T.waveDur, ease: STRIKE, delay: T.wave, times: [0, 0.35, 1] }}
          />
          <g filter={`url(#${glowId}-wide)`} opacity="0.32">
            {arms.map(([x, y], i) => (
              <m.path
                key={`w${i}`}
                d={`M${C} ${C} L${x} ${y}`}
                stroke={ray.glow}
                strokeWidth="1.9"
                strokeLinecap="round"
                fill="none"
                initial={{ pathLength: 0, opacity: 0 }}
                animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
                transition={{ duration: T.strikeDur + 0.25, ease: STRIKE, delay: T.strike + 0.04 }}
              />
            ))}
          </g>
          {/* as lâminas: um brilho curto por baixo e o fio nítido por cima, disparando do centro */}
          {[
            { filter: `url(#${glowId})`, opacity: 0.85, w: 1.9 },
            { filter: undefined, opacity: 1, w: 1 },
          ].map((layer, l) => (
            <g key={l} filter={layer.filter} opacity={layer.opacity}>
              {bladeAngles.map((angle, i) => (
                <g key={i} transform={`rotate(${angle} ${C} ${C})`}>
                  <m.path
                    d={blade}
                    fill={`url(#${rayId})`}
                    style={{ transformOrigin: '0% 50%', transformBox: 'fill-box' }}
                    initial={{ scaleX: 0, scaleY: layer.w, opacity: 0 }}
                    animate={on ? { scaleX: 1, scaleY: layer.w, opacity: 1 } : { scaleX: 0, scaleY: layer.w, opacity: 0 }}
                    transition={{ duration: T.strikeDur, ease: STRIKE, delay: T.strike }}
                  />
                </g>
              ))}
            </g>
          ))}
        </m.g>

        {/* os quatro losangos: aproximam-se devagar de longe, encaixam, e recuam um instante no bote */}
        {MODULES.map((d, i) => {
          const p = path[i]
          const delay = T.approach + i * T.stagger
          return (
            <m.path
              key={i}
              d={d}
              fill={symbolFill}
              style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
              initial={{ opacity: 0, x: p.x, y: p.y, rotate: p.rotate, scale: 0.94 }}
              animate={
                on
                  ? { opacity: 1, x: [p.x, 0, p.kx, 0], y: [p.y, 0, p.ky, 0], rotate: 0, scale: 1 }
                  : { opacity: 0, x: p.x, y: p.y, rotate: p.rotate, scale: 0.94 }
              }
              transition={{
                opacity: { duration: 1.1, ease: 'easeOut', delay },
                rotate: { duration: T.approachDur, ease: SLOW, delay },
                scale: { duration: T.approachDur, ease: SLOW, delay },
                /* aproximação lenta até T.strike; então o recuo curto e a volta */
                x: { duration: T.recoil + 0.55 - delay, delay, ease: [SLOW, STRIKE, SLOW], times: [0, (T.recoil - delay) / (T.recoil + 0.55 - delay), (T.recoil + 0.12 - delay) / (T.recoil + 0.55 - delay), 1] },
                y: { duration: T.recoil + 0.55 - delay, delay, ease: [SLOW, STRIKE, SLOW], times: [0, (T.recoil - delay) / (T.recoil + 0.55 - delay), (T.recoil + 0.12 - delay) / (T.recoil + 0.55 - delay), 1] },
              }}
            />
          )
        })}
      </m.g>
    </svg>
  )
}
