import { useId, useRef } from 'react'
import type { ReactNode } from 'react'
import { m, useInView, useReducedMotion } from 'motion/react'
import type { LucideIcon } from 'lucide-react'
import { MODULES, SYMBOL_BOX } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * Fotografia envolvida pelo símbolo Natcorp.
 *
 * A foto é recortada pela geometria dos módulos (os quatro do símbolo, ou um único módulo
 * ampliado), recebe o gradiente da marca por cima e os contornos dos módulos viram linhas
 * de luz que percorrem as arestas. A pessoa fica dentro do sistema, e o sistema em volta dela.
 */

export type HumanShape = 'symbol' | 'module'
export type HumanTone = 'dark' | 'light'

export interface HumanChip {
  icon: LucideIcon
  label: string
  value: string
  /** Posição do chip em volta da composição. */
  at: 'tl' | 'tr' | 'l' | 'r' | 'bl' | 'br'
  /** Esconde o chip em telas pequenas. */
  desktopOnly?: boolean
}

export interface HumanFrame {
  /** Deslocamento da foto em unidades da caixa 8×8 (positivo desloca para a direita/baixo). */
  x?: number
  y?: number
  /** Ampliação da foto (1 = cobre a caixa). */
  scale?: number
}

interface HumanModuleProps {
  src: string
  alt: string
  shape?: HumanShape
  tone?: HumanTone
  frame?: HumanFrame
  /** Esmaece a base da foto (ombros se dissolvem no fundo). */
  fade?: boolean
  /** Intensidade do gradiente da marca sobre a foto (0 a 1). */
  tint?: number
  /** Saturação da foto (1 = original). Fotos de banco ficam mais coesas com a marca abaixo de 1. */
  saturate?: number
  /** Linhas de luz percorrendo as arestas dos módulos. */
  animated?: boolean
  chips?: HumanChip[]
  loading?: 'eager' | 'lazy'
  className?: string
  children?: ReactNode
}

/* Um único módulo (o de cima) centralizado e ampliado até quase preencher a caixa. */
const TOP_CENTER = { x: 4, y: 1.8955 }
const SINGLE_SCALE = 2.42
const SINGLE_TRANSFORM = `translate(${SYMBOL_BOX / 2} ${SYMBOL_BOX / 2}) scale(${SINGLE_SCALE}) translate(${-TOP_CENTER.x} ${-TOP_CENTER.y})`

const chipPos: Record<HumanChip['at'], string> = {
  tl: 'left-0 top-[27%] -translate-x-[42%] -translate-y-1/2',
  tr: 'right-0 top-[27%] translate-x-[42%] -translate-y-1/2',
  l: 'left-0 top-[58%] -translate-x-1/3 -translate-y-1/2',
  r: 'right-0 top-[58%] translate-x-1/3 -translate-y-1/2',
  bl: 'bottom-[12%] left-[4%] -translate-x-1/4',
  br: 'bottom-[12%] right-[4%] translate-x-1/4',
}

export function HumanModule({
  src,
  alt,
  shape = 'symbol',
  tone = 'dark',
  frame,
  fade = shape === 'symbol',
  tint = 0.5,
  saturate = tone === 'dark' ? 0.62 : 0.85,
  animated = true,
  chips,
  loading = 'lazy',
  className,
  children,
}: HumanModuleProps) {
  const uid = useId().replace(/:/g, '')
  const reduced = useReducedMotion()
  const id = (k: string) => `hm-${k}-${uid}`
  const paths = shape === 'symbol' ? MODULES : [MODULES[0]]
  const pathTransform = shape === 'symbol' ? undefined : SINGLE_TRANSFORM
  const dark = tone === 'dark'
  const glow = dark ? '#E4A9C4' : '#C95788'
  const line = dark ? '#FFFFFF' : '#511C76'
  const { x = 0, y = 0, scale = 1 } = frame ?? {}
  const root = useRef<HTMLDivElement>(null)
  /** As linhas de luz e os chips só se mexem com a composição na tela. */
  const inView = useInView(root, { margin: '160px 0px' })
  const dashAnim = animated && !reduced && inView

  return (
    <div ref={root} className={cn('relative', className)}>
      <svg
        viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`}
        className="block h-auto w-full overflow-visible"
        role="img"
        aria-label={alt}
        focusable="false"
      >
        <defs>
          <clipPath id={id('clip')}>
            {paths.map((d, i) => (
              <path key={i} d={d} transform={pathTransform} />
            ))}
          </clipPath>
          <linearGradient id={id('tint')} gradientUnits="userSpaceOnUse" x1="0" y1="0" x2={SYMBOL_BOX} y2={SYMBOL_BOX}>
            <stop offset="0" stopColor="#9A408A" />
            <stop offset="0.5" stopColor="#511C76" />
            <stop offset="1" stopColor="#2C1A63" />
          </linearGradient>
          <linearGradient id={id('fade')} gradientUnits="userSpaceOnUse" x1="0" y1="0" x2="0" y2={SYMBOL_BOX}>
            <stop offset="0" stopColor="#fff" />
            <stop offset="0.66" stopColor="#fff" />
            <stop offset="0.97" stopColor="#000" />
          </linearGradient>
          <mask id={id('mask')}>
            <rect width={SYMBOL_BOX} height={SYMBOL_BOX} fill={`url(#${id('fade')})`} />
          </mask>
          <radialGradient id={id('halo')} cx="0.5" cy="0.45" r="0.55">
            <stop offset="0" stopColor="#C95788" stopOpacity={dark ? 0.55 : 0.22} />
            <stop offset="1" stopColor="#C95788" stopOpacity="0" />
          </radialGradient>
          <filter id={id('sat')}>
            <feColorMatrix type="saturate" values={String(saturate)} />
          </filter>
        </defs>

        {/* halo atrás da composição */}
        <circle cx={SYMBOL_BOX / 2} cy={SYMBOL_BOX / 2} r={SYMBOL_BOX * 0.62} fill={`url(#${id('halo')})`} />

        {/* foto recortada pelos módulos e tingida com o gradiente da marca */}
        <g mask={fade ? `url(#${id('mask')})` : undefined}>
          <g clipPath={`url(#${id('clip')})`}>
            <rect width={SYMBOL_BOX} height={SYMBOL_BOX} fill="#3A1F6B" />
            <g transform={`translate(${x} ${y}) scale(${scale})`} filter={saturate < 1 ? `url(#${id('sat')})` : undefined}>
              <image
                href={src}
                width={SYMBOL_BOX}
                height={SYMBOL_BOX}
                preserveAspectRatio="xMidYMin slice"
                {...(loading === 'eager' ? {} : { loading: 'lazy' as const })}
              />
            </g>
            {tint > 0 && (
              <rect width={SYMBOL_BOX} height={SYMBOL_BOX} fill={`url(#${id('tint')})`} opacity={tint} style={{ mixBlendMode: 'multiply' }} />
            )}
            {tint > 0 && (
              <rect width={SYMBOL_BOX} height={SYMBOL_BOX} fill={`url(#${id('tint')})`} opacity={tint * 0.28} style={{ mixBlendMode: 'screen' }} />
            )}
          </g>
        </g>

        {/* contornos dos módulos como linhas de luz */}
        <g fill="none" strokeLinejoin="round" strokeLinecap="round">
          {paths.map((d, i) => (
            <path key={`g${i}`} d={d} transform={pathTransform} stroke={glow} strokeWidth={0.16} opacity={dark ? 0.16 : 0.1} />
          ))}
          {paths.map((d, i) => (
            <path key={`g2${i}`} d={d} transform={pathTransform} stroke={glow} strokeWidth={0.07} opacity={dark ? 0.35 : 0.22} />
          ))}
          {paths.map((d, i) => (
            <path key={`b${i}`} d={d} transform={pathTransform} stroke={line} strokeWidth={0.014} opacity={dark ? 0.42 : 0.5} />
          ))}
          {paths.map((d, i) =>
            dashAnim ? (
              <m.path
                key={`a${i}`}
                d={d}
                transform={pathTransform}
                stroke={line}
                strokeWidth={0.026}
                opacity={dark ? 0.9 : 0.7}
                pathLength={1}
                strokeDasharray="0.22 0.78"
                initial={{ strokeDashoffset: 0 }}
                animate={{ strokeDashoffset: -1 }}
                transition={{ duration: 8 + i * 1.5, repeat: Infinity, ease: 'linear', delay: i * 0.9 }}
              />
            ) : (
              <path key={`a${i}`} d={d} transform={pathTransform} stroke={line} strokeWidth={0.026} opacity={dark ? 0.55 : 0.5} pathLength={1} strokeDasharray="0.22 0.78" strokeDashoffset={-0.35 * i} />
            ),
          )}
        </g>
      </svg>

      {chips?.map((c, i) => (
        <m.div
          key={c.label}
          className={cn('absolute z-10', chipPos[c.at], c.desktopOnly && 'hidden sm:block')}
          aria-hidden
          animate={reduced || !inView ? { y: 0 } : { y: [0, -7, 0] }}
          transition={reduced || !inView ? { duration: 0.6, ease: 'easeOut' } : { duration: 5 + i * 0.8, repeat: Infinity, ease: 'easeInOut', delay: i * 0.7 }}
        >
          <span
            className={cn(
              'flex items-center gap-2.5 rounded-xl border px-3 py-2 shadow-lift',
              dark ? 'border-white/20 bg-white/[0.16] text-white' : 'border-brand-mist bg-white/95 text-brand-ink',
            )}
          >
            <span className={cn('flex h-7 w-7 shrink-0 items-center justify-center rounded-lg', dark ? 'bg-white text-brand-purple' : 'bg-brand-gradient text-white')}>
              <c.icon className="h-3.5 w-3.5" strokeWidth={2} />
            </span>
            <span className="leading-tight">
              <span className={cn('block text-[10px] font-semibold uppercase tracking-[0.14em]', dark ? 'text-white/65' : 'text-brand-graphite')}>{c.label}</span>
              <span className="block text-[12.5px] font-bold">{c.value}</span>
            </span>
          </span>
        </m.div>
      ))}
      {children}
    </div>
  )
}
