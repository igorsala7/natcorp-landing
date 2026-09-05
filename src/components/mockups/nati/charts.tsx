import { m } from 'motion/react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

export interface Series {
  labels: string[]
  values: number[]
}

/** 21500 → "21,5k"; 800 → "800" */
export const fmtK = (v: number) => (v >= 1000 ? `${(v / 1000).toFixed(1).replace('.', ',')}k` : `${Math.round(v)}`)

export const fmtBRL = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL', maximumFractionDigits: 0 })

const trunc = (s: string, n: number) => (s.length > n ? `${s.slice(0, n - 1).trimEnd()}…` : s)

const PURPLE = '#511C76'
const PINK = '#C95788'
const GRID = '#E9E5F1'
const TEXT = '#4A4460'

function ticks(max: number, n = 4) {
  return Array.from({ length: n + 1 }, (_, i) => (max * i) / n)
}

/** Linha com tendência tracejada (ex.: evolução salarial). */
export function LineChart({ data, trend = true, className }: { data: Series; trend?: boolean; className?: string }) {
  const W = 560
  const H = 250
  const PL = 54
  const PR = 20
  const PT = 16
  const PB = 36
  const max = Math.max(...data.values)
  const n = data.values.length
  const x = (i: number) => PL + (i * (W - PL - PR)) / (n - 1)
  const y = (v: number) => PT + (H - PT - PB) * (1 - v / max)
  const d = data.values.map((v, i) => `${i === 0 ? 'M' : 'L'}${x(i).toFixed(1)} ${y(v).toFixed(1)}`).join(' ')
  return (
    <svg viewBox={`0 0 ${W} ${H}`} className={cn('h-auto w-full', className)} style={{ minWidth: 0 }} aria-hidden>
      {ticks(max).map((t) => (
        <g key={t}>
          <line x1={PL} x2={W - PR} y1={y(t)} y2={y(t)} stroke={GRID} strokeWidth={1} />
          <text x={PL - 8} y={y(t) + 4} textAnchor="end" fontSize={11} fill={TEXT} className="tabular">
            {fmtK(t)}
          </text>
        </g>
      ))}
      {data.labels.map((l, i) => (
        <text key={l} x={x(i)} y={H - 12} textAnchor="middle" fontSize={11} fill={TEXT} className="tabular">
          {l}
        </text>
      ))}
      {trend && (
        <>
          <m.line
            x1={x(0)}
            y1={y(data.values[0])}
            x2={x(n - 1)}
            y2={y(data.values[n - 1])}
            stroke={PINK}
            strokeWidth={2}
            strokeDasharray="6 5"
            initial={{ pathLength: 0, opacity: 0 }}
            whileInView={{ pathLength: 1, opacity: 1 }}
            viewport={viewportOnce}
            transition={{ duration: 1.2, ease: EASE, delay: 0.6 }}
          />
          <text x={x(n - 1) - 6} y={y(data.values[n - 1]) - 10} textAnchor="end" fontSize={10.5} fill={PINK} fontWeight={600}>
            Tendência
          </text>
        </>
      )}
      <m.path
        d={d}
        fill="none"
        stroke={PURPLE}
        strokeWidth={2.5}
        strokeLinejoin="round"
        strokeLinecap="round"
        initial={{ pathLength: 0 }}
        whileInView={{ pathLength: 1 }}
        viewport={viewportOnce}
        transition={{ duration: 1.4, ease: EASE, delay: 0.2 }}
      />
      {data.values.map((v, i) => (
        <m.circle
          key={i}
          cx={x(i)}
          cy={y(v)}
          r={3.6}
          fill={PURPLE}
          initial={{ scale: 0, opacity: 0 }}
          whileInView={{ scale: 1, opacity: 1 }}
          viewport={viewportOnce}
          transition={{ duration: 0.4, ease: EASE, delay: 0.3 + i * 0.12 }}
          style={{ transformOrigin: `${x(i)}px ${y(v)}px` }}
        />
      ))}
    </svg>
  )
}

/** Barras horizontais (ex.: média salarial por cargo). */
export function BarChartH({ data, className }: { data: Series; className?: string }) {
  const W = 560
  const PL = 196
  const PR = 24
  const PT = 8
  const PB = 30
  const rowH = 34
  const barH = 18
  const H = PT + PB + data.values.length * rowH
  const max = Math.max(...data.values)
  const x = (v: number) => PL + ((W - PL - PR) * v) / max
  return (
    <svg viewBox={`0 0 ${W} ${H}`} className={cn('h-auto w-full', className)} aria-hidden>
      {ticks(max).map((t) => (
        <g key={t}>
          <line x1={x(t)} x2={x(t)} y1={PT} y2={H - PB + 4} stroke={GRID} strokeWidth={1} />
          <text x={x(t)} y={H - 10} textAnchor="middle" fontSize={11} fill={TEXT} className="tabular">
            {fmtK(t)}
          </text>
        </g>
      ))}
      {data.values.map((v, i) => {
        const cy = PT + i * rowH + rowH / 2
        return (
          <g key={data.labels[i]}>
            <text x={PL - 12} y={cy + 4} textAnchor="end" fontSize={12} fill={TEXT}>
              {trunc(data.labels[i], 26)}
            </text>
            <m.rect
              x={PL}
              y={cy - barH / 2}
              width={x(v) - PL}
              height={barH}
              rx={2}
              fill={PURPLE}
              initial={{ scaleX: 0 }}
              whileInView={{ scaleX: 1 }}
              viewport={viewportOnce}
              transition={{ duration: 0.9, ease: EASE, delay: 0.15 + i * 0.08 }}
              style={{ transformOrigin: `${PL}px ${cy}px` }}
            />
          </g>
        )
      })}
    </svg>
  )
}

/** Radar / teia. */
export function RadarChart({ data, className }: { data: Series; className?: string }) {
  const S = 320
  const cx = S / 2
  const cy = S / 2 + 4
  const R = 104
  const n = data.values.length
  const max = Math.max(...data.values)
  const angle = (i: number) => -Math.PI / 2 + (i * 2 * Math.PI) / n
  const pt = (i: number, r: number) => [cx + r * Math.cos(angle(i)), cy + r * Math.sin(angle(i))] as const
  const poly = (r: (i: number) => number) =>
    data.values.map((_, i) => pt(i, r(i)).map((v) => v.toFixed(1)).join(',')).join(' ')
  return (
    <svg viewBox={`0 0 ${S} ${S}`} className={cn('mx-auto h-auto w-full max-w-[340px]', className)} aria-hidden>
      {[1 / 3, 2 / 3, 1].map((f) => (
        <polygon key={f} points={poly(() => R * f)} fill="none" stroke={GRID} strokeWidth={1} />
      ))}
      {data.values.map((_, i) => {
        const [x2, y2] = pt(i, R)
        return <line key={i} x1={cx} y1={cy} x2={x2} y2={y2} stroke={GRID} strokeWidth={1} />
      })}
      <m.polygon
        points={poly((i) => (R * data.values[i]) / max)}
        fill={PURPLE}
        fillOpacity={0.18}
        stroke={PURPLE}
        strokeWidth={2.5}
        strokeLinejoin="round"
        initial={{ scale: 0, opacity: 0 }}
        whileInView={{ scale: 1, opacity: 1 }}
        viewport={viewportOnce}
        transition={{ duration: 0.9, ease: EASE, delay: 0.2 }}
        style={{ transformOrigin: `${cx}px ${cy}px` }}
      />
      {data.values.map((v, i) => {
        const [x, y] = pt(i, (R * v) / max)
        return <circle key={i} cx={x} cy={y} r={3.5} fill={PURPLE} />
      })}
      {data.labels.map((l, i) => {
        const [x, y] = pt(i, R + 22)
        const anchor = Math.abs(Math.cos(angle(i))) < 0.2 ? 'middle' : Math.cos(angle(i)) > 0 ? 'start' : 'end'
        return (
          <text key={l} x={x} y={y + 4} textAnchor={anchor} fontSize={11} fill={TEXT}>
            {trunc(l, 14)}
          </text>
        )
      })}
    </svg>
  )
}

/** Tabela simples com números tabulares. */
export function DataTable({ data, valueLabel = 'Valor', labelHeader = 'Cargo', className }: { data: Series; valueLabel?: string; labelHeader?: string; className?: string }) {
  return (
    <div className={cn('overflow-x-auto', className)}>
      <table className="w-full text-left text-[13px]">
        <thead>
          <tr className="border-b border-brand-mist text-[12px] font-semibold text-brand-purple">
            <th className="py-2 pr-3">{labelHeader}</th>
            <th className="py-2 text-right">{valueLabel}</th>
          </tr>
        </thead>
        <tbody>
          {data.labels.map((l, i) => (
            <tr key={l} className="border-b border-brand-mist/70 last:border-0">
              <td className="py-2 pr-3 text-brand-ink">{l}</td>
              <td className="py-2 text-right tabular text-brand-ink">{fmtBRL(data.values[i])}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
