import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { BrandGradient, Logo } from './Logo'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * Motion da assinatura Natcorp, sóbrio: o símbolo se materializa, desliza para
 * a esquerda e "natcorp" surge letra a letra.
 *
 * Sem luz de fundo. A versão anterior tinha um eclipse com bruma em losango
 * atrás do símbolo; foi retirada a pedido. Está no histórico (commit 999b658)
 * caso valha retomar — o que dava trabalho ali era a calibragem das camadas,
 * não o código.
 *
 * Com `prefers-reduced-motion`, mostra a assinatura pronta e parada.
 */

/** Duração total, para quem espera o fim (a abertura do site, por exemplo). */
export const LOGO_MOTION_MS = 2600

const PAD = 4.5
const C = SYMBOL_BOX / 2
/** O símbolo nasce centralizado na caixa do lockup e desliza até a posição final (x = 0). */
const SYMBOL_START_X = H_WIDTH / 2 - C

/** A curva da pantera: sai devagar, assenta devagar, sem quique. */
const SLOW = [0.2, 0.8, 0.2, 1] as const

/* Linha do tempo, em segundos. */
const T = {
  simbolo: 0.15,
  simboloDur: 0.8,
  /* símbolo desliza e o wordmark entra */
  slide: 1.0,
  slideDur: 1.05,
  words: 1.1,
  wordsDur: 0.95,
  letters: 1.18,
  letterStagger: 0.07,
  letterDur: 0.8,
}

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

  const claro = tone === 'gradient'
  const symbolFill = claro ? `url(#${gradId})` : '#FFFFFF'
  const wordFill = claro ? '#1B1238' : '#FFFFFF'
  /* No fundo claro o núcleo é um rosa alto (não branco): branco sobre branco
     não acende nada. No escuro, o núcleo pode ir ao branco e o rosa fica no meio. */
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

      {/* wordmark: surge letra a letra, atrás do símbolo que desliza */}
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

      <m.g initial={{ x: SYMBOL_START_X }} animate={on ? { x: 0 } : { x: SYMBOL_START_X }} transition={{ duration: T.slideDur, ease: SLOW, delay: T.slide }}>
        {/* o símbolo: materializa em bloco, sem entrada por peça */}
        {MODULES.map((d, i) => (
          <m.path
            key={i}
            d={d}
            fill={symbolFill}
            style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
            initial={{ opacity: 0, scale: 0.97 }}
            animate={on ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 0.97 }}
            transition={{ duration: T.simboloDur, ease: SLOW, delay: T.simbolo + i * 0.05 }}
          />
        ))}
      </m.g>
    </svg>
  )
}
