import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { BrandGradient, Logo } from './Logo'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * Motion da assinatura Natcorp, em dois atos, lentos e deliberados:
 * 1. Os quatro losangos se aproximam de longe, devagar, e se encaixam no centro.
 * 2. Uma pausa curta. Então o símbolo desliza para a esquerda e o wordmark "natcorp"
 *    surge letra a letra ao lado, tudo centralizado.
 * Feita para o fundo claro, com o símbolo no gradiente da marca. Com movimento reduzido,
 * mostra a assinatura pronta.
 *
 * O X ROSA FOI REMOVIDO, DE PROPÓSITO.
 *
 * Havia um terceiro ato entre os dois: um X vazado que disparava do centro para fora,
 * em raio rosa, com onda de choque — e os losangos recuavam com o impacto. Saiu por
 * decisão de marca. Se faltar alguma coisa ao ler este arquivo (as lâminas, o gradiente
 * radial do raio, os filtros de brilho), é isso: não é código perdido, é ausência
 * deliberada. O recuo dos losangos saiu junto, porque sem o disparo ele vira um tique
 * sem causa.
 */

/** Duração total, para quem espera o fim (a abertura do site, por exemplo). */
export const LOGO_MOTION_MS = 3900

const PAD = 4.5
const C = SYMBOL_BOX / 2
/** O símbolo nasce centralizado na caixa do lockup e desliza até a posição final (x = 0). */
const SYMBOL_START_X = H_WIDTH / 2 - C
/** Distância inicial dos losangos ao centro, e o quanto giram no caminho. */
const FAR = 2.4
const TILT = 9

/** A curva da pantera: sai devagar, assenta devagar, sem quique. */
const SLOW = [0.2, 0.8, 0.2, 1] as const

/* Linha do tempo, em segundos.
   Os losangos assentam em ~1,98s (approach + 3 × stagger + approachDur). O deslize começa
   logo depois: sem o disparo no meio, esperar mais que uma batida vira tempo morto. */
const T = {
  approach: 0.05,
  approachDur: 1.75,
  stagger: 0.06,
  slide: 2.35,
  slideDur: 1.15,
  words: 2.45,
  wordsDur: 1.05,
  letters: 2.53,
  letterStagger: 0.07,
  letterDur: 0.85,
}

/* De onde cada losango vem (topo, direita, esquerda, base) e quanto gira no caminho. */
const path = [
  { x: 0, y: -FAR, rotate: -TILT },
  { x: FAR, y: 0, rotate: TILT },
  { x: -FAR, y: 0, rotate: -TILT },
  { x: 0, y: FAR, rotate: TILT },
]

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
        {/* os quatro losangos: aproximam-se devagar de longe e encaixam no centro */}
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
              animate={on ? { opacity: 1, x: 0, y: 0, rotate: 0, scale: 1 } : { opacity: 0, x: p.x, y: p.y, rotate: p.rotate, scale: 0.94 }}
              transition={{
                opacity: { duration: 1.1, ease: 'easeOut', delay },
                default: { duration: T.approachDur, ease: SLOW, delay },
              }}
            />
          )
        })}
      </m.g>
    </svg>
  )
}
