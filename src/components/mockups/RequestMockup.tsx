import { m } from 'motion/react'
import { CalendarDays, Check } from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const timeline = [
  { label: 'Solicitação', who: 'Carlos Mendes · Portal do Colaborador', when: '02/09 09:14' },
  { label: 'Aprovação do gestor', who: 'Juliana Costa · Portal do Gestor', when: '02/09 11:02' },
  { label: 'Validação do RH', who: 'Regras da convenção conferidas', when: '02/09 15:40' },
  { label: 'Efetivado na folha', who: 'Aviso de férias assinado eletronicamente', when: '02/09 15:41' },
]

export function RequestMockup({ className }: { className?: string }) {
  return (
    <m.div
      className={cn('rounded-2xl border border-brand-mist bg-white p-5 shadow-lift sm:p-6', className)}
      role="img"
      aria-label="Requisição de férias com fluxo de aprovação: solicitação, aprovação do gestor, validação do RH e efetivação na folha"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.22, delayChildren: 0.3 } } }}
    >
      <div className="flex items-start gap-3">
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
          <CalendarDays className="h-5 w-5" strokeWidth={1.6} />
        </span>
        <div className="min-w-0 flex-1">
          <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Requisição #48.211</p>
          <p className="text-[15px] font-bold text-brand-ink">Férias · 20 dias · 12/10 a 31/10</p>
        </div>
        <span className="rounded-full bg-emerald-50 px-2.5 py-1 text-[11px] font-semibold text-emerald-700">Concluída</span>
      </div>

      <ol className="mt-6 space-y-0">
        {timeline.map((t, i) => (
          <m.li
            key={t.label}
            className="relative flex gap-4 pb-5 last:pb-0"
            variants={{ hidden: { opacity: 0, y: 8 }, visible: { opacity: 1, y: 0, transition: { duration: 0.55, ease: EASE } } }}
          >
            {i < timeline.length - 1 && (
              <m.span
                aria-hidden
                className="absolute left-[11px] top-6 w-px bg-brand-purple/30"
                style={{ height: 'calc(100% - 0.75rem)', transformOrigin: 'top' }}
                variants={{ hidden: { scaleY: 0 }, visible: { scaleY: 1, transition: { duration: 0.5, ease: EASE, delay: 0.15 } } }}
              />
            )}
            <span className="relative z-10 mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-brand-purple text-white">
              <Check className="h-3.5 w-3.5" strokeWidth={2.5} />
            </span>
            <div className="min-w-0 flex-1">
              <div className="flex items-baseline justify-between gap-3">
                <p className="text-sm font-semibold text-brand-ink">{t.label}</p>
                <p className="shrink-0 text-[11px] tabular text-brand-graphite">{t.when}</p>
              </div>
              <p className="text-[12px] text-brand-graphite">{t.who}</p>
            </div>
          </m.li>
        ))}
      </ol>
    </m.div>
  )
}
