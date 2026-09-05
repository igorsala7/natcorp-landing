import { useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { MODULES, SYMBOL_BOX } from './logo-paths'
import { cn } from '@/lib/utils'

/**
 * O símbolo Natcorp como luz, para envolver uma fotografia: os quatro módulos em vidro
 * translúcido, contornos luminosos e trilhos de luz a 45° (as arestas do símbolo prolongadas),
 * com um brilho que percorre as linhas. Desenhado em `screen` para se fundir à foto.
 */

/* Trilhos: prolongamento das arestas externas do símbolo (x+y = c e x-y = c). */
const rails = [
  { x1: -3, y1: 7, x2: 7, y2: -3 }, // aresta superior esquerda (x + y = 4)
  { x1: 1, y1: 13, x2: 13, y2: 1 }, // aresta inferior direita (x + y = 14)
  { x1: -1, y1: -4.9, x2: 11, y2: 7.1 }, // aresta superior direita (x - y = 3.9)
]

export function HeroSymbol({ className }: { className?: string }) {
  const uid = useId().replace(/:/g, '')
  const id = (k: string) => `hs-${k}-${uid}`
  const reduced = useReducedMotion()

  return (
    <svg
      viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`}
      className={cn('block overflow-visible', className)}
      style={{ mixBlendMode: 'screen' }}
      aria-hidden
      focusable="false"
    >
      <defs>
        <linearGradient id={id('glass')} gradientUnits="userSpaceOnUse" x1="0" y1="0" x2={SYMBOL_BOX} y2={SYMBOL_BOX}>
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.16" />
          <stop offset="0.55" stopColor="#E4A9C4" stopOpacity="0.06" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0.02" />
        </linearGradient>
        <linearGradient id={id('rail')} gradientUnits="objectBoundingBox" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0" />
          <stop offset="0.5" stopColor="#FFFFFF" stopOpacity="0.85" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0" />
        </linearGradient>
        <linearGradient id={id('railGlow')} gradientUnits="objectBoundingBox" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#C95788" stopOpacity="0" />
          <stop offset="0.5" stopColor="#E4A9C4" stopOpacity="0.9" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0" />
        </linearGradient>
        <filter id={id('blur')} x="-30%" y="-30%" width="160%" height="160%">
          <feGaussianBlur stdDeviation="0.12" />
        </filter>
        <filter id={id('blurWide')} x="-30%" y="-30%" width="160%" height="160%">
          <feGaussianBlur stdDeviation="0.35" />
        </filter>
      </defs>

      {/* névoa rosa atrás do símbolo */}
      <circle cx={SYMBOL_BOX * 0.55} cy={SYMBOL_BOX * 0.5} r={SYMBOL_BOX * 0.42} fill="#9A408A" opacity="0.35" filter={`url(#${id('blurWide')})`} />

      {/* trilhos de luz */}
      <g strokeLinecap="round">
        {rails.map((r, i) => (
          <line key={`g${i}`} {...r} stroke={`url(#${id('railGlow')})`} strokeWidth={0.16} opacity={0.55} filter={`url(#${id('blur')})`} />
        ))}
        {rails.map((r, i) => (
          <line key={`l${i}`} {...r} stroke={`url(#${id('rail')})`} strokeWidth={0.028} opacity={0.75} />
        ))}
        {rails.map((r, i) =>
          reduced ? null : (
            <m.line
              key={`a${i}`}
              {...r}
              stroke="#FFFFFF"
              strokeWidth={0.05}
              opacity={0.9}
              pathLength={1}
              strokeDasharray="0.12 0.88"
              initial={{ strokeDashoffset: 1 }}
              animate={{ strokeDashoffset: -1 }}
              transition={{ duration: 11 + i * 2.5, repeat: Infinity, ease: 'linear', delay: i * 2.2 }}
            />
          ),
        )}
      </g>

      {/* módulos em vidro */}
      <g>
        {MODULES.map((d, i) => (
          <path key={`f${i}`} d={d} fill={`url(#${id('glass')})`} />
        ))}
        {MODULES.map((d, i) => (
          <path key={`h${i}`} d={d} fill="none" stroke="#E4A9C4" strokeWidth={0.09} opacity={0.5} filter={`url(#${id('blur')})`} />
        ))}
        {MODULES.map((d, i) => (
          <path key={`s${i}`} d={d} fill="none" stroke="#FFFFFF" strokeWidth={0.02} opacity={0.55} strokeLinejoin="round" />
        ))}
        {MODULES.map((d, i) =>
          reduced ? null : (
            <m.path
              key={`p${i}`}
              d={d}
              fill="none"
              stroke="#FFFFFF"
              strokeWidth={0.034}
              opacity={0.95}
              strokeLinejoin="round"
              pathLength={1}
              strokeDasharray="0.18 0.82"
              initial={{ strokeDashoffset: 0 }}
              animate={{ strokeDashoffset: -1 }}
              transition={{ duration: 9 + i * 1.7, repeat: Infinity, ease: 'linear', delay: i * 1.1 }}
            />
          ),
        )}
      </g>

      {/* dois módulos pequenos e sólidos, como acentos */}
      <g fill="#C95788" opacity="0.55">
        <path d={MODULES[0]} transform="translate(8.55 -1.1) scale(0.22)" />
        <path d={MODULES[0]} transform="translate(-0.9 6.9) scale(0.16)" />
      </g>
    </svg>
  )
}
