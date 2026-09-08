import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { BrandGradient, Logo } from './Logo'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * Motion da assinatura Natcorp: uma luz rosa acende ATRÁS do símbolo.
 *
 * O princípio é físico, e é o que faz a peça funcionar sem truque: o símbolo é
 * OPACO e fica na frente; a luz é uma só, atrás dele. Por isso ela aparece
 * exatamente onde o símbolo não está — no X vazado do meio, nas frestas entre
 * os quatro losangos e transbordando pelas bordas externas. Não há nada
 * desenhado "vazando": o vazamento é o que sobra da luz depois do símbolo.
 *
 * Três atos:
 * 1. A luz nasce no centro, pequena, e cresce até preencher o X e escapar pelas
 *    frestas e pela borda. O núcleo é quase branco: é ele que ressalta o X.
 * 2. Um pulso curto no auge, e a luz recua até sumir. O símbolo fica sozinho.
 * 3. O símbolo desliza para a esquerda e "natcorp" surge letra a letra.
 *
 * Com `prefers-reduced-motion`, mostra a assinatura pronta e parada.
 */

/** Duração total, para quem espera o fim (a abertura do site, por exemplo). */
export const LOGO_MOTION_MS = 4200

const PAD = 4.5
const C = SYMBOL_BOX / 2
/** O símbolo nasce centralizado na caixa do lockup e desliza até a posição final (x = 0). */
const SYMBOL_START_X = H_WIDTH / 2 - C

/** A curva da pantera: sai devagar, assenta devagar, sem quique. */
const SLOW = [0.2, 0.8, 0.2, 1] as const
/** Acender: sobe rápido e desacelera — luz não tem inércia para vencer. */
const ACENDE = [0.16, 1, 0.3, 1] as const

/* Linha do tempo, em segundos. */
const T = {
  /** o símbolo já está lá, só materializa */
  simbolo: 0.1,
  simboloDur: 0.7,
  /** a luz nasce e cresce */
  luz: 0.35,
  luzDur: 1.5,
  /** recuo até apagar */
  apaga: 2.05,
  apagaDur: 1.0,
  /** símbolo desliza e o wordmark entra */
  slide: 2.5,
  slideDur: 1.1,
  words: 2.6,
  wordsDur: 1.0,
  letters: 2.68,
  letterStagger: 0.07,
  letterDur: 0.8,
}

/**
 * Os três tamanhos da luz, do menor ao maior.
 *
 * `nucleo` cabe dentro do X do meio — é o que dá o ponto quente.
 * `corpo` cobre o símbolo inteiro, então escapa pelas frestas dos losangos.
 * `halo` é maior que o símbolo: é o que transborda pela borda externa.
 */
const LUZ = [
  /* O X do meio é uma fresta estreita: só acende se o núcleo for PEQUENO e
     pouco desfocado. Núcleo grande e macio espalha e não marca o X. */
  { id: 'nucleo', r: 1.15, desfoque: 0.1, opacidadeAuge: 1, escala: [0, 1, 1.05, 0] },
  { id: 'corpo', r: 3.1, desfoque: 0.32, opacidadeAuge: 1, escala: [0, 1, 1.08, 0] },
  { id: 'halo', r: 6.8, desfoque: 1.6, opacidadeAuge: 0.8, escala: [0, 1, 1.14, 0] },
] as const

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
  const luzId = (n: string) => `lm-luz-${n}-${uid}`
  const blurId = (n: string) => `lm-blur-${n}-${uid}`

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
  const nucleo = claro ? '#FFF2F7' : '#FFFFFF'
  /* Um rosa mais alto que o da marca no miolo: sobre fundo claro o #C95788
     sozinho lê como malva apagado, e a luz precisa parecer luz. */
  const quente = '#FF5C9D'
  const meio = '#C95788'
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

        {LUZ.map((l) => (
          <radialGradient key={l.id} id={luzId(l.id)} gradientUnits="userSpaceOnUse" cx={C} cy={C} r={l.r}>
            <stop offset="0" stopColor={nucleo} stopOpacity="1" />
            <stop offset="0.18" stopColor={quente} stopOpacity="1" />
            <stop offset="0.45" stopColor={meio} stopOpacity="0.92" />
            <stop offset="0.75" stopColor={meio} stopOpacity="0.4" />
            <stop offset="1" stopColor={meio} stopOpacity="0" />
          </radialGradient>
        ))}

        {LUZ.map((l) => (
          /* Região generosa: sem isto o filtro corta o halo justamente onde ele
             precisa transbordar. */
          <filter key={l.id} id={blurId(l.id)} x="-150%" y="-150%" width="400%" height="400%">
            <feGaussianBlur stdDeviation={l.desfoque} />
          </filter>
        ))}

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
        {/* A LUZ, ATRÁS. Três camadas concêntricas crescendo juntas; o símbolo
            opaco vem depois e decide onde ela aparece. */}
        {LUZ.map((l) => (
          <m.circle
            key={l.id}
            cx={C}
            cy={C}
            r={l.r}
            fill={`url(#${luzId(l.id)})`}
            filter={`url(#${blurId(l.id)})`}
            style={{ transformOrigin: `${C}px ${C}px` }}
            initial={{ scale: 0, opacity: 0 }}
            animate={
              on
                ? { scale: [...l.escala], opacity: [0, l.opacidadeAuge, l.opacidadeAuge, 0] }
                : { scale: 0, opacity: 0 }
            }
            transition={{
              duration: T.luzDur + T.apagaDur,
              delay: T.luz,
              ease: [ACENDE, 'easeInOut', 'easeIn'],
              /* cresce até o auge, segura o pulso, e recua */
              times: [0, T.luzDur / (T.luzDur + T.apagaDur), (T.luzDur + 0.22) / (T.luzDur + T.apagaDur), 1],
            }}
          />
        ))}

        {/* O SÍMBOLO, OPACO, POR CIMA. É ele que recorta a luz. */}
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
