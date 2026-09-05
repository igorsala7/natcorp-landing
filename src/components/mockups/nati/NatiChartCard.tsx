import { useState } from 'react'
import { Download, Expand, Save } from 'lucide-react'
import { BarChartH, DataTable, LineChart, RadarChart, type Series } from './charts'
import { cn } from '@/lib/utils'

export type ChartType = 'bar' | 'line' | 'radar'

const typeLabels: Record<ChartType, string> = { bar: 'Barras', line: 'Linha', radar: 'Radar / Teia' }

interface NatiChartCardProps {
  title: string
  data: Series
  types?: ChartType[]
  defaultType?: ChartType
  labelHeader?: string
  valueLabel?: string
  trend?: boolean
  /** Quando true, os controles de tipo e de gráfico/tabela funcionam de verdade. */
  interactive?: boolean
  className?: string
}

/** Cartão de gráfico gerado pela NATI dentro da conversa, com troca de tipo e visão em tabela. */
export function NatiChartCard({
  title,
  data,
  types = ['bar', 'line', 'radar'],
  defaultType = types[0],
  labelHeader,
  valueLabel,
  trend = false,
  interactive = false,
  className,
}: NatiChartCardProps) {
  const [view, setView] = useState<'chart' | 'table'>('chart')
  const [type, setType] = useState<ChartType>(defaultType)

  const chart =
    type === 'line' ? <LineChart data={data} trend={trend} /> : type === 'radar' ? <RadarChart data={data} /> : <BarChartH data={data} />

  return (
    <div className={cn('rounded-xl border border-brand-mist bg-white p-4 shadow-soft', className)}>
      <div className="flex items-start justify-between gap-3">
        <p className="text-[14px] font-bold leading-snug text-brand-ink">{title}</p>
        <div className="flex shrink-0 rounded-lg bg-brand-off-white p-0.5 text-[12px] font-semibold" role={interactive ? 'tablist' : undefined}>
          {(['chart', 'table'] as const).map((v) => (
            <button
              key={v}
              type="button"
              role={interactive ? 'tab' : undefined}
              aria-selected={interactive ? view === v : undefined}
              tabIndex={interactive ? 0 : -1}
              onClick={() => interactive && setView(v)}
              className={cn(
                'rounded-md px-2.5 py-1 transition-colors',
                view === v ? 'bg-white text-brand-purple shadow-soft' : 'text-brand-graphite',
                !interactive && 'pointer-events-none',
              )}
            >
              {v === 'chart' ? 'Gráfico' : 'Tabela'}
            </button>
          ))}
        </div>
      </div>

      <div className="mt-3">{view === 'chart' ? chart : <DataTable data={data} labelHeader={labelHeader} valueLabel={valueLabel} />}</div>

      <div className="mt-3 flex flex-wrap items-center gap-2">
        {interactive ? (
          <label className="relative">
            <span className="sr-only">Tipo de gráfico</span>
            <select
              value={type}
              onChange={(e) => setType(e.target.value as ChartType)}
              className="h-8 rounded-md border border-brand-mist bg-white pl-2.5 pr-8 text-[12px] font-semibold text-brand-ink focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
            >
              {types.map((t) => (
                <option key={t} value={t}>
                  {typeLabels[t]}
                </option>
              ))}
            </select>
          </label>
        ) : (
          <span className="inline-flex h-8 items-center rounded-md border border-brand-mist bg-white px-2.5 text-[12px] font-semibold text-brand-ink">
            {typeLabels[type]}
          </span>
        )}
        <span className="ml-auto flex flex-wrap gap-1.5" aria-hidden>
          {[
            { icon: Expand, label: 'Ampliar' },
            { icon: Download, label: 'CSV' },
            { icon: Download, label: 'PNG' },
            { icon: Save, label: 'Salvar' },
          ].map(({ icon: Icon, label }) => (
            <span key={label} className="inline-flex h-8 items-center gap-1 rounded-md border border-brand-purple/30 bg-brand-off-white px-2.5 text-[12px] font-semibold text-brand-purple">
              <Icon className="h-3.5 w-3.5" strokeWidth={2} />
              {label}
            </span>
          ))}
        </span>
      </div>
    </div>
  )
}
