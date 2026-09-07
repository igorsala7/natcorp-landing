import { m } from 'motion/react'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * Os losangos do hero da home, em luz, para a abertura dos portais: o módulo grande desenhando-se, um segundo
 * atrás, inclinado, o brilho percorrendo a borda sem parar, o módulo pequeno em vidro respirando e as linhas de
 * fluxo com pacotes de luz correndo para dentro. Mesmo traçado e mesmas curvas do HeroScene, num quadro próprio.
 */

/* O módulo do hero (quadrado arredondado girado 45°), centrado em (1412, 425) no quadro original de 2000 x 843. */
const MODULE =
  'M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z'
const CX = 1412
const CY = 425
/* O quadro: 2400 de largura, para as linhas de fluxo entrarem pela esquerda; 1600 de altura, centrado no módulo. */
const VIEW = { x: CX - 1500, y: CY - 800, w: 2400, h: 1600 }
const MODULE2 = { cx: CX - 112, cy: CY + 75, rotate: 12, s: 1.12 }
const SMALL = { cx: CX - 470, cy: CY + 430, s: 0.26 }

/* Linhas de fluxo: chegam pela esquerda, embaixo, e sobem em curva até o módulo. */
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

export interface ModuleLightsPalette {
  /** Três paradas do degradê da borda, do claro ao escuro. */
  edge: [string, string, string]
  /** Brilho difuso por baixo da borda. */
  glow: string
  /** O segundo módulo, atrás. */
  back: string
  /** Luz que percorre a borda e os pacotes das linhas. */
  light: string
}

export const rosePalette: ModuleLightsPalette = { edge: ['#F3C9DA', '#E4A9C4', '#C95788'], glow: '#E4A9C4', back: '#C95788', light: '#F3C9DA' }
export const amberPalette: ModuleLightsPalette = { edge: ['#FBE3A6', '#F2B84B', '#D9962A'], glow: '#F2B84B', back: '#F2B84B', light: '#FBE3A6' }

interface ModuleLightsProps {
  /** Entrada concluída: desenha as bordas. */
  on: boolean
  /** Laços contínuos (luz na borda, pacotes, respiração) rodando: só com a seção na tela e sem movimento reduzido. */
  loop: boolean
  palette?: ModuleLightsPalette
  className?: string
  /** Prefixo dos ids dos degradês (um por instância na página). */
  id?: string
}

export function ModuleLights({ on, loop, palette = rosePalette, className, id = 'ml' }: ModuleLightsProps) {
  const edge = `${id}-edge`
  const edge2 = `${id}-edge2`
  const glass = `${id}-glass`
  const draw = (delay: number, duration = 2.2) => ({
    initial: { pathLength: 0, opacity: 0 },
    animate: on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 },
    transition: { duration, ease: EASE, delay },
  })
  return (
    <svg
      viewBox={`${VIEW.x} ${VIEW.y} ${VIEW.w} ${VIEW.h}`}
      preserveAspectRatio="xMidYMid meet"
      className={cn('block overflow-visible', className)}
      aria-hidden
      focusable="false"
    >
      <defs>
        <linearGradient id={edge} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor={palette.edge[0]} stopOpacity="0.95" />
          <stop offset="0.5" stopColor={palette.edge[1]} stopOpacity="0.75" />
          <stop offset="1" stopColor={palette.edge[2]} stopOpacity="0.4" />
        </linearGradient>
        <linearGradient id={edge2} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor={palette.edge[1]} stopOpacity="0.9" />
          <stop offset="0.5" stopColor={palette.edge[2]} stopOpacity="0.75" />
          <stop offset="1" stopColor={palette.edge[2]} stopOpacity="0.45" />
        </linearGradient>
        <linearGradient id={glass} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor={palette.edge[0]} stopOpacity="0.3" />
          <stop offset="0.55" stopColor={palette.edge[2]} stopOpacity="0.16" />
          <stop offset="1" stopColor="#511C76" stopOpacity="0.1" />
        </linearGradient>
      </defs>

      {/* linhas de fluxo: traço contínuo fraco */}
      <g strokeLinecap="round" fill="none">
        {flows.map((f, i) => (
          <m.path key={`f${i}`} d={f.d} stroke={palette.light} strokeWidth="1.6" strokeOpacity="0.3" {...draw(0.3 + i * 0.08, 1.8)} />
        ))}
      </g>

      {/* o segundo módulo, atrás: deslocado, inclinado, traço mais fino e mais escuro */}
      <g transform={`translate(${MODULE2.cx} ${MODULE2.cy}) rotate(${MODULE2.rotate}) scale(${MODULE2.s}) translate(${-CX} ${-CY})`}>
        <m.path d={MODULE} fill="none" stroke={palette.back} strokeWidth="8" strokeOpacity="0.16" {...draw(0.7, 2.6)} />
        <m.path d={MODULE} fill="none" stroke={`url(#${edge2})`} strokeWidth="2.4" {...draw(0.7, 2.6)} />
      </g>

      {/* o módulo grande: brilho difuso por baixo, contorno nítido por cima */}
      <m.path d={MODULE} fill="none" stroke={palette.glow} strokeWidth="30" strokeOpacity="0.1" {...draw(0.2)} />
      <m.path d={MODULE} fill="none" stroke={palette.glow} strokeWidth="12" strokeOpacity="0.2" {...draw(0.2)} />
      <m.path d={MODULE} fill="none" stroke={`url(#${edge})`} strokeWidth="3.5" {...draw(0.2)} />

      {/* camada em movimento: o que anima a cada quadro fica separado dos traços parados */}
      <g className="will-change-transform">
        <g strokeLinecap="round" fill="none">
          {loop &&
            flows.map((f, i) => (
              <m.path
                key={`p${i}`}
                d={f.d}
                pathLength={1}
                stroke="#FFFFFF"
                strokeWidth="2.2"
                strokeOpacity="0.9"
                strokeDasharray="0.08 1"
                initial={{ strokeDashoffset: 1, opacity: 0 }}
                animate={{ strokeDashoffset: -1, opacity: 1 }}
                transition={{ strokeDashoffset: { duration: f.dur, ease: 'linear', repeat: Infinity, delay: f.delay }, opacity: { duration: 1, delay: f.delay } }}
              />
            ))}
        </g>
        {loop && (
          <>
            <m.path
              d={MODULE}
              pathLength={1}
              fill="none"
              stroke={palette.light}
              strokeWidth="14"
              strokeLinecap="round"
              strokeDasharray="0.07 1"
              initial={{ strokeDashoffset: 0, opacity: 0 }}
              animate={{ strokeDashoffset: -2, opacity: 0.45 }}
              transition={{ strokeDashoffset: { duration: 14, ease: 'linear', repeat: Infinity }, opacity: { duration: 1.2 } }}
            />
            <m.path
              d={MODULE}
              pathLength={1}
              fill="none"
              stroke="#FFFFFF"
              strokeWidth="5"
              strokeLinecap="round"
              strokeDasharray="0.055 1"
              initial={{ strokeDashoffset: 0, opacity: 0 }}
              animate={{ strokeDashoffset: -2, opacity: 1 }}
              transition={{ strokeDashoffset: { duration: 14, ease: 'linear', repeat: Infinity }, opacity: { duration: 1.2 } }}
            />
          </>
        )}
        {/* o módulo pequeno, em vidro, respirando */}
        <m.g
          style={{ transformOrigin: `${SMALL.cx}px ${SMALL.cy}px`, transformBox: 'view-box' }}
          initial={{ opacity: 0, scale: 0.9 }}
          animate={on ? { opacity: 1, scale: loop ? [1, 1.05, 1] : 1 } : { opacity: 0, scale: 0.9 }}
          transition={{ opacity: { duration: 1.2, ease: EASE, delay: 1.2 }, scale: loop ? { duration: 6, ease: 'easeInOut', repeat: Infinity } : { duration: 1.2 } }}
        >
          <g transform={`translate(${SMALL.cx} ${SMALL.cy}) scale(${SMALL.s}) translate(${-CX} ${-CY})`}>
            <path d={MODULE} fill={`url(#${glass})`} stroke={palette.light} strokeWidth="5" strokeOpacity="0.8" />
            <path d={MODULE} fill="none" stroke="#FFFFFF" strokeWidth="2.5" strokeOpacity="0.5" transform="translate(-16 -16)" />
          </g>
        </m.g>
      </g>
    </svg>
  )
}
