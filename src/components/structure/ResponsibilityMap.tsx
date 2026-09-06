import { operatorMeta, type Operator } from '@/content/structures'
import type { Responsibility } from '@/content/structures/types'
import { cn } from '@/lib/utils'
import { ModuleChip } from './ModuleChip'
import { operatorTint, operatorsIn } from './operators'

/** Pílula "quem faz": ponto na cor do operador e o rótulo, sobre um fundo levemente tingido. */
export function OperatorPill({ by, short = false, className }: { by: Operator; short?: boolean; className?: string }) {
  const meta = operatorMeta[by]
  return (
    <span
      className={cn('inline-flex items-center gap-1.5 whitespace-nowrap rounded-full px-2.5 py-1 text-[12.5px] font-bold text-brand-ink', className)}
      style={{ backgroundColor: operatorTint(meta.color) }}
    >
      <span aria-hidden className="h-2 w-2 shrink-0 rounded-full" style={{ backgroundColor: meta.color }} />
      {short ? meta.short : meta.label}
    </span>
  )
}

export function OperatorLegend({ operators, tone = 'light', className }: { operators: Operator[]; tone?: 'light' | 'dark'; className?: string }) {
  const dark = tone === 'dark'
  return (
    <ul className={cn('flex flex-wrap items-center gap-x-5 gap-y-2', className)} aria-label="Legenda: quem faz">
      {operators.map((op) => (
        <li key={op} className={cn('flex items-center gap-2 text-[13px] font-semibold', dark ? 'text-white/85' : 'text-brand-ink')}>
          <span aria-hidden className={cn('h-2.5 w-2.5 shrink-0 rounded-full', dark && 'ring-2 ring-white/60')} style={{ backgroundColor: operatorMeta[op].color }} />
          {operatorMeta[op].label}
        </li>
      ))}
    </ul>
  )
}

interface ResponsibilityMapProps {
  items: Responsibility[]
  className?: string
}

/**
 * "Quem faz o quê": a rotina de RH distribuída entre gestores, RH da unidade, RH central e NATI.
 * Tabela em telas largas; cartões empilhados no celular.
 */
export function ResponsibilityMap({ items, className }: ResponsibilityMapProps) {
  const operators = operatorsIn(items)
  const th = 'bg-brand-off-white px-5 py-3.5 text-[11px] font-bold uppercase tracking-[0.14em] text-brand-graphite first:rounded-tl-3xl last:rounded-tr-3xl'

  return (
    <div className={className}>
      <OperatorLegend operators={operators} />

      {/* Telas largas: tabela */}
      <div className="mt-5 hidden overflow-x-auto rounded-3xl border border-brand-mist bg-white shadow-soft md:block">
        <table className="w-full min-w-[720px] border-separate border-spacing-0 text-left">
          <caption className="sr-only">Quem faz o quê nessa estrutura: rotina, quem faz, como e os módulos envolvidos</caption>
          <thead>
            <tr>
              <th scope="col" className={cn(th, 'w-[24%]')}>
                Rotina
              </th>
              <th scope="col" className={cn(th, 'w-[18%]')}>
                Quem faz
              </th>
              <th scope="col" className={th}>
                Como
              </th>
              <th scope="col" className={cn(th, 'w-[26%]')}>
                Módulos
              </th>
            </tr>
          </thead>
          <tbody>
            {items.map((r, i) => (
              <tr key={r.task} className="group/row align-top">
                <th scope="row" className={cn('px-5 py-4 text-[15px] font-bold leading-snug text-brand-ink', i > 0 && 'border-t border-brand-mist')}>
                  {r.task}
                </th>
                <td className={cn('px-5 py-4', i > 0 && 'border-t border-brand-mist')}>
                  <OperatorPill by={r.by} short />
                </td>
                <td className={cn('px-5 py-4 text-[14px] leading-relaxed text-brand-graphite', i > 0 && 'border-t border-brand-mist')}>{r.note}</td>
                <td className={cn('px-5 py-4', i > 0 && 'border-t border-brand-mist')}>
                  <ul className="flex flex-wrap gap-1.5">
                    {r.modules.map((s) => (
                      <li key={s}>
                        <ModuleChip slug={s} size="sm" />
                      </li>
                    ))}
                  </ul>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Celular: cartões */}
      <ol className="mt-5 grid gap-3 md:hidden" aria-label="Quem faz o quê nessa estrutura">
        {items.map((r) => (
          <li key={r.task} className="rounded-2xl border border-brand-mist bg-white p-4 shadow-soft">
            <div className="flex flex-wrap items-start justify-between gap-2">
              <h3 className="text-[15px] font-bold leading-snug text-brand-ink">{r.task}</h3>
              <OperatorPill by={r.by} short />
            </div>
            <p className="mt-2 text-[14px] leading-relaxed text-brand-graphite">{r.note}</p>
            <ul className="mt-3 flex flex-wrap gap-1.5">
              {r.modules.map((s) => (
                <li key={s}>
                  <ModuleChip slug={s} size="sm" />
                </li>
              ))}
            </ul>
          </li>
        ))}
      </ol>
    </div>
  )
}
