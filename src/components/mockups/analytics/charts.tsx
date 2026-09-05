import { m } from 'motion/react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

/** Paleta das séries do Painel do Operador, na ordem em que aparece nas telas. */
export const SERIES = ['#C4507F', '#2E9E6B', '#F5C242', '#EF5A4A', '#8E5AAE', '#511C76', '#F0872C', '#F26D86', '#2C1A63', '#4A4460', '#C85BA1', '#C9D63B', '#2FB5A8', '#3B82F6'] as const

export interface BarItem {
  label: string
  value: number
  color?: string
}

interface VBarsProps {
  items: BarItem[]
  max: number
  ticks: string[]
  /** Como desenhar os rótulos do eixo X. */
  labels?: 'wrap' | 'diagonal' | 'vertical'
  barClassName?: string
  className?: string
  /** Altura reservada aos rótulos (px). */
  labelHeight?: number
  gap?: string
}

/** Gráfico de barras verticais com grade, eixo Y e rótulos (envolvidos, diagonais ou verticais). */
export function VBars({ items, max, ticks, labels = 'wrap', barClassName, className, labelHeight, gap = '12%' }: VBarsProps) {
  const lh = labelHeight ?? (labels === 'vertical' ? 190 : labels === 'diagonal' ? 110 : 40)
  const step = 100 / (ticks.length - 1)
  return (
    <div className={cn('flex h-full min-h-0 flex-col', className)}>
      <div className="flex min-h-0 flex-1">
        <div className="flex h-full shrink-0 flex-col justify-between pr-3 text-right text-[12px] tabular text-brand-graphite">
          {ticks.map((t) => (
            <span key={t} className="leading-none">
              {t}
            </span>
          ))}
        </div>
        <div
          className="relative flex flex-1 items-end border-b border-brand-mist"
          style={{ backgroundImage: `repeating-linear-gradient(180deg, transparent 0, transparent calc(${step}% - 1px), #E9E5F1 calc(${step}% - 1px), #E9E5F1 ${step}%)`, paddingInline: gap }}
        >
          <div className="flex h-full w-full items-end justify-between">
            {items.map((it, i) => (
              <m.span
                key={it.label}
                className={cn('block rounded-t-[2px]', barClassName)}
                style={{ height: `${Math.max(0.6, (it.value / max) * 100)}%`, width: `${Math.min(64, 100 / items.length - 4)}%`, background: it.color ?? SERIES[i % SERIES.length], transformOrigin: 'bottom' }}
                initial={{ scaleY: 0 }}
                whileInView={{ scaleY: 1 }}
                viewport={viewportOnce}
                transition={{ duration: 0.8, ease: EASE, delay: 0.2 + i * 0.05 }}
              />
            ))}
          </div>
        </div>
      </div>
      <div className="relative ml-[3.2rem] shrink-0" style={{ height: lh }}>
        {items.map((it, i) => {
          const x = (100 / items.length) * (i + 0.5)
          if (labels === 'vertical') {
            return (
              <span key={it.label} className="absolute top-2 whitespace-pre-line text-center text-[11px] uppercase leading-tight text-brand-graphite" style={{ left: `${x}%`, transform: 'translateX(-50%) rotate(180deg)', writingMode: 'vertical-rl', height: lh - 12 }}>
                {it.label}
              </span>
            )
          }
          if (labels === 'diagonal') {
            return (
              <span key={it.label} className="absolute top-2 origin-top-right -rotate-45 whitespace-nowrap text-right text-[12px] text-brand-graphite" style={{ right: `${100 - x}%` }}>
                {it.label}
              </span>
            )
          }
          return (
            <span key={it.label} className="absolute top-2 -translate-x-1/2 text-center text-[11.5px] uppercase leading-tight text-brand-graphite" style={{ left: `${x}%`, width: `${100 / items.length - 1}%` }}>
              {it.label}
            </span>
          )
        })}
      </div>
    </div>
  )
}

export interface Slice {
  label: string
  value: number
  color: string
}

/** Pizza em SVG com legenda opcional (rótulos truncados como na tela real). */
export function Pie({ slices, size = 200, legend = true, className }: { slices: Slice[]; size?: number; legend?: boolean; className?: string }) {
  const total = slices.reduce((s, x) => s + x.value, 0)
  let acc = 0
  const r = 50
  const pt = (a: number) => `${60 + r * Math.cos(a)},${60 + r * Math.sin(a)}`
  const paths = slices.map((sl) => {
    const a0 = (acc / total) * 2 * Math.PI - Math.PI / 2
    acc += sl.value
    const a1 = (acc / total) * 2 * Math.PI - Math.PI / 2
    return `M60,60 L${pt(a0)} A${r},${r} 0 ${sl.value / total > 0.5 ? 1 : 0} 1 ${pt(a1)} Z`
  })
  return (
    <div className={cn('flex h-full items-center gap-4 overflow-hidden', className)}>
      <m.svg
        viewBox="0 0 120 120"
        style={{ width: size, height: size }}
        className="shrink-0"
        initial={{ opacity: 0, rotate: -20, scale: 0.9 }}
        whileInView={{ opacity: 1, rotate: 0, scale: 1 }}
        viewport={viewportOnce}
        transition={{ duration: 0.9, ease: EASE }}
      >
        {paths.map((d, i) => (
          <path key={i} d={d} fill={slices[i].color} stroke="#fff" strokeWidth={0.8} />
        ))}
      </m.svg>
      {legend && (
        <ul className="max-h-full min-w-0 space-y-[4px] overflow-hidden text-[12.5px] text-brand-ink">
          {slices.map((sl) => (
            <li key={sl.label} className="flex items-center gap-2 truncate">
              <span className="h-3 w-3 shrink-0 rounded-[2px]" style={{ background: sl.color }} />
              <span className="truncate">{sl.label}</span>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}

export interface PctRow {
  label: string
  pct: number
  color: string
}

/** Lista com barra proporcional e percentual, como nos cards de "Unidade de Atendimento". */
export function PercentRows({ rows, className, dense = false }: { rows: PctRow[]; className?: string; dense?: boolean }) {
  const max = Math.max(...rows.map((r) => r.pct))
  return (
    <ul className={cn('divide-y divide-brand-mist', className)}>
      {rows.map((r, i) => (
        <li key={`${r.label}-${i}`} className={cn('grid grid-cols-[1fr_130px_64px] items-center gap-4', dense ? 'py-2' : 'py-3.5')}>
          <span className="truncate text-[13.5px] text-brand-ink">{r.label}</span>
          <span className="h-2.5 overflow-hidden rounded-sm bg-brand-mist">
            <m.span
              className="block h-full rounded-sm"
              style={{ width: `${(r.pct / max) * 100}%`, background: r.color, transformOrigin: 'left' }}
              initial={{ scaleX: 0 }}
              whileInView={{ scaleX: 1 }}
              viewport={viewportOnce}
              transition={{ duration: 0.7, ease: EASE, delay: 0.2 + i * 0.05 }}
            />
          </span>
          <span className="text-right text-[13px] tabular text-brand-graphite">{r.pct.toFixed(2).replace('.', ',')}%</span>
        </li>
      ))}
    </ul>
  )
}
