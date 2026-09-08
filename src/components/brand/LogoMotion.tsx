import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { BrandGradient, Logo } from './Logo'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * Motion da assinatura Natcorp: um ECLIPSE atrás do símbolo.
 *
 * O princípio é físico, e é o que faz a peça funcionar sem truque: o símbolo é
 * OPACO e fica na frente; a luz é uma só, atrás dele. Por isso ela aparece
 * exatamente onde o símbolo não está — no X vazado do meio, nas frestas entre
 * os quatro losangos e transbordando pelas bordas externas. Não há nada
 * desenhado "vazando": o vazamento é o que sobra da luz depois do símbolo.
 *
 * Duas decisões que separam isto de um brilho genérico:
 *
 * - **A luz é LOSANGO, não círculo.** Um `radialGradient` faria a queda de
 *   intensidade em anéis redondos, e o halo denunciaria uma forma que não é a
 *   da marca. Aqui a queda vem de losangos empilhados, do menor e mais quente
 *   ao maior e mais apagado: a silhueta da luz é a silhueta do símbolo.
 * - **Gelo seco, não gradiente liso.** Uma névoa real tem grumo e borda
 *   irregular. `feTurbulence` + `feDisplacementMap` deformam as camadas
 *   externas com ruído fractal, e o conjunto gira devagar — é o que dá o
 *   aspecto de fumaça iluminada em vez de um borrão.
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

/** Um losango centrado, de ponta a ponta `r`. É a forma de tudo que emite luz aqui. */
const losango = (r: number) => `M${C} ${C - r} L${C + r} ${C} L${C} ${C + r} L${C - r} ${C} Z`

/** A silhueta do símbolo vai até ~3,68 do centro: a coroa do eclipse nasce logo depois. */
const RAIO_SIMBOLO = 3.68

/**
 * As camadas da luz, do miolo para fora.
 *
 * A queda de intensidade é feita por empilhamento, não por gradiente: cada
 * losango é maior, mais apagado e mais desfocado que o anterior. `bruma` marca
 * quem recebe a deformação de ruído — o miolo fica limpo, porque luz forte não
 * tem grumo; a névoa é que tem.
 */
const CAMADAS = [
  /* A calibragem é um equilíbrio entre dois erros opostos, e os dois já
     aconteceram aqui:
       desfoque MENOR que o vão  → as camadas viram degraus contáveis a olho;
       desfoque MAIOR que o vão  → o losango arredonda e a luz vira círculo.
     Então: passos curtos e desfoque da ORDEM do passo, nunca acima. Mais
     camadas custam pouco (são paths simples) e é o que mantém a silhueta.

     `bruma` fica só nas QUATRO externas: é onde o grumo aparece. Nas internas
     a turbulência custaria o mesmo e ficaria escondida atrás do símbolo. */
  { r: 9.4, cor: 'meio', op: 0.07, desfoque: 1.5, bruma: true },
  { r: 8.2, cor: 'meio', op: 0.1, desfoque: 1.25, bruma: true },
  { r: 7.1, cor: 'meio', op: 0.14, desfoque: 1.05, bruma: true },
  { r: 6.1, cor: 'meio', op: 0.19, desfoque: 0.9, bruma: false },
  { r: 5.2, cor: 'meio', op: 0.25, desfoque: 0.75, bruma: false },
  { r: 4.5, cor: 'quente', op: 0.32, desfoque: 0.6, bruma: false },
  { r: 3.9, cor: 'quente', op: 0.42, desfoque: 0.5, bruma: false },
  { r: 3.3, cor: 'quente', op: 0.55, desfoque: 0.4, bruma: false },
  { r: 2.7, cor: 'quente', op: 0.7, desfoque: 0.32, bruma: false },
  { r: 2.1, cor: 'quente', op: 0.85, desfoque: 0.24, bruma: false },
  { r: 1.5, cor: 'nucleo', op: 1, desfoque: 0.16, bruma: false },
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
  /* Três tons, do miolo para fora. O `quente` é mais alto que o rosa da marca
     de propósito: sobre fundo claro o #C95788 sozinho lê como malva apagado, e
     luz precisa parecer luz. */
  const cores = {
    nucleo: claro ? '#FFEAF3' : '#FFFFFF',
    quente: '#FF4E96',
    meio: '#C95788',
  } as const
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

        {/* UM FILTRO POR CAMADA, com as duas etapas na ordem certa:
            primeiro o ruído fractal deforma a borda (o grumo do gelo seco),
            DEPOIS o desfoque funde a camada na vizinha.
            A primeira versão separou as coisas em dois filtros e as camadas de
            névoa ficaram só com o deslocamento — resultado: losangos nítidos
            empilhados, contáveis a olho. O desfoque é o que apaga o degrau. */}
        {CAMADAS.map((c) => (
          <filter key={c.r} id={blurId(String(c.r))} x="-120%" y="-120%" width="340%" height="340%">
            {c.bruma && (
              <>
                <feTurbulence type="fractalNoise" baseFrequency="1.35" numOctaves={3} seed={7} result="ruido" />
                <feDisplacementMap in="SourceGraphic" in2="ruido" scale="0.5" xChannelSelector="R" yChannelSelector="G" result="deformado" />
              </>
            )}
            <feGaussianBlur in={c.bruma ? 'deformado' : 'SourceGraphic'} stdDeviation={c.desfoque} />
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
        {/* A LUZ, ATRÁS — em losango, do mais apagado e largo ao mais quente e
            estreito. O símbolo opaco vem depois e decide onde ela aparece. */}
        <m.g
          style={{ transformOrigin: `${C}px ${C}px` }}
          initial={{ scale: 0.15, opacity: 0 }}
          animate={on ? { scale: [0.15, 1, 1.06, 0.2], opacity: [0, 1, 1, 0] } : { scale: 0.15, opacity: 0 }}
          transition={{
            duration: T.luzDur + T.apagaDur,
            delay: T.luz,
            ease: [ACENDE, 'easeInOut', 'easeIn'],
            times: [0, T.luzDur / (T.luzDur + T.apagaDur), (T.luzDur + 0.22) / (T.luzDur + T.apagaDur), 1],
          }}
        >
          {/* O losango da luz fica ALINHADO ao do símbolo — girá-lo, ainda que
              pouco, denuncia duas formas em vez de uma. A deriva de gelo seco
              vem de uma respiração de escala, não de rotação. */}
          <m.g
            style={{ transformOrigin: `${C}px ${C}px` }}
            animate={on ? { scale: [1, 1.045, 1] } : { scale: 1 }}
            transition={{ duration: 3.2, ease: 'easeInOut', repeat: Infinity, delay: T.luz }}
          >
            {CAMADAS.map((c) => (
              <path
                key={c.r}
                d={losango(c.r)}
                fill={cores[c.cor]}
                opacity={c.op}
                filter={`url(#${blurId(String(c.r))})`}
              />
            ))}
          </m.g>

          {/* A COROA DO ECLIPSE: o fio de luz que escapa rente à borda do
              símbolo. É ele que faz ler como eclipse, e não como lâmpada
              atrás de um recorte. */}
          <path
            d={losango(RAIO_SIMBOLO + 0.1)}
            fill="none"
            stroke={cores.nucleo}
            strokeWidth="0.26"
            filter={`url(#${blurId('2.2')})`}
            opacity="0.9"
          />
        </m.g>

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
