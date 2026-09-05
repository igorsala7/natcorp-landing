import { BarChart3 } from 'lucide-react'
import { cn } from '@/lib/utils'

export interface LedgerRow {
  comp: string
  tipo: 'Provento' | 'Desconto'
  rubrica: string
  valor: string
}

/** Tabela "Histórico de Lançamentos" como a NATI devolve na conversa. */
export function NatiTable({ rows, title = 'Histórico de Lançamentos', className }: { rows: LedgerRow[]; title?: string; className?: string }) {
  return (
    <div className={cn('', className)}>
      <p className="flex items-center gap-1.5 text-[13.5px] font-bold text-brand-ink">
        <BarChart3 className="h-4 w-4 text-brand-purple" strokeWidth={2} aria-hidden />
        {title}
      </p>
      <div className="mt-2 overflow-x-auto rounded-lg border border-brand-mist">
        <table className="w-full min-w-[360px] text-left text-[12.5px]">
          <thead>
            <tr className="bg-brand-off-white text-[12px] font-semibold text-brand-purple">
              <th className="px-3 py-2">Competência</th>
              <th className="px-3 py-2">Tipo</th>
              <th className="px-3 py-2">Ocorrência / Rubrica</th>
              <th className="px-3 py-2 text-right">Valor</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r, i) => (
              <tr key={i} className="border-t border-brand-mist/70">
                <td className="px-3 py-1.5 font-semibold tabular text-brand-ink">{r.comp}</td>
                <td className={cn('px-3 py-1.5', r.tipo === 'Desconto' ? 'font-semibold text-[#A63A6A]' : 'text-brand-graphite')}>{r.tipo}</td>
                <td className="px-3 py-1.5 text-brand-ink">{r.rubrica}</td>
                <td className="px-3 py-1.5 text-right tabular text-brand-ink">{r.valor}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
