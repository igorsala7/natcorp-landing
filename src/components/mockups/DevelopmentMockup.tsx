import { m } from 'motion/react'
import { Check, TrendingUp } from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const reviews = [
  { label: 'Avaliação de experiência', meta: '45 e 90 dias · gestora', status: 'Concluída', state: 'done' },
  { label: 'Autoavaliação', meta: 'Ciclo anual · Portal do Colaborador', status: 'Concluída', state: 'done' },
  { label: 'Avaliação 180º', meta: 'Gestora · competências e metas', status: 'Concluída', state: 'done' },
  { label: 'Avaliação 360º', meta: 'Pares e clientes internos · 5 de 6 respostas', status: 'Em andamento', state: 'active' },
] as const

/** Mapa de sucessão em nove caixas: desempenho na horizontal, potencial na vertical. A Ana está no alto, à direita. */
const boxes = Array.from({ length: 9 }, (_, i) => ({ i, ana: i === 2 }))

export function DevelopmentMockup({ className }: { className?: string }) {
  return (
    <m.div
      className={cn('rounded-2xl border border-brand-mist bg-white p-5 shadow-lift sm:p-6', className)}
      role="img"
      aria-label="Painel de desenvolvimento: avaliações concluídas, mapa de sucessão em nove caixas e promoção efetivada na folha"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.14, delayChildren: 0.2 } } }}
    >
      <div className="flex items-center justify-between gap-3">
        <div className="min-w-0">
          <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Desenvolvimento · Ciclo 2026</p>
          <p className="mt-0.5 truncate text-[15px] font-bold text-brand-ink">Ana Ribeiro · Analista de Operações</p>
        </div>
        <span className="shrink-0 rounded-full bg-brand-purple/10 px-2.5 py-1 text-[11px] font-semibold text-brand-purple">4 de 5 metas</span>
      </div>

      <ul className="mt-4 divide-y divide-brand-mist">
        {reviews.map((r) => (
          <m.li
            key={r.label}
            className="flex items-center gap-3 py-2.5"
            variants={{ hidden: { opacity: 0, x: -10 }, visible: { opacity: 1, x: 0, transition: { duration: 0.5, ease: EASE } } }}
          >
            <span
              className={cn(
                'flex h-6 w-6 shrink-0 items-center justify-center rounded-full border text-[10px] font-bold',
                r.state === 'done' ? 'border-brand-purple bg-brand-purple text-white' : 'border-brand-pink bg-white text-brand-pink',
              )}
            >
              {r.state === 'done' ? <Check className="h-3 w-3" strokeWidth={3} /> : '4'}
            </span>
            <div className="min-w-0 flex-1">
              <p className="truncate text-sm font-semibold text-brand-ink">{r.label}</p>
              <p className="truncate text-[11.5px] text-brand-graphite">{r.meta}</p>
            </div>
            <span
              className={cn(
                'shrink-0 rounded-full px-2 py-0.5 text-[10.5px] font-semibold',
                r.state === 'done' ? 'bg-emerald-50 text-emerald-700' : 'bg-brand-pink/10 text-brand-pink',
              )}
            >
              {r.status}
            </span>
          </m.li>
        ))}
      </ul>

      <m.div
        className="mt-4 grid grid-cols-[auto_1fr] items-center gap-4 rounded-xl border border-brand-mist bg-brand-off-white/70 p-3.5"
        variants={{ hidden: { opacity: 0, y: 10 }, visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } } }}
      >
        <div className="flex items-end gap-1.5">
          <span className="mb-[3px] w-3 text-center text-[9px] font-semibold leading-none text-brand-graphite [writing-mode:vertical-rl] rotate-180" aria-hidden>
            Potencial
          </span>
          <div>
            <div className="grid grid-cols-3 gap-1">
              {boxes.map((b) => (
                <span
                  key={b.i}
                  className={cn(
                    'flex h-6 w-6 items-center justify-center rounded-[5px] text-[9px] font-extrabold sm:h-7 sm:w-7',
                    b.ana ? 'bg-brand-gradient text-white shadow-soft' : b.i === 1 || b.i === 5 ? 'bg-brand-purple/15' : 'bg-brand-mist/80',
                  )}
                >
                  {b.ana ? 'AR' : ''}
                </span>
              ))}
            </div>
            <p className="mt-1 text-center text-[9px] font-semibold text-brand-graphite" aria-hidden>
              Desempenho
            </p>
          </div>
        </div>
        <div className="min-w-0 text-[12px]">
          <p className="font-semibold text-brand-ink">Mapa de sucessão</p>
          <p className="mt-0.5 leading-snug text-brand-graphite">Alto desempenho, alto potencial. Pronta para a posição de Analista Sênior; trilha de liderança em 70%.</p>
        </div>
      </m.div>

      <m.div
        className="mt-3 flex items-center gap-3 rounded-xl border border-emerald-200 bg-emerald-50/70 p-3.5"
        variants={{ hidden: { opacity: 0, y: 10 }, visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } } }}
      >
        <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white text-emerald-700 shadow-soft">
          <TrendingUp className="h-4.5 w-4.5" strokeWidth={1.8} />
        </span>
        <div className="min-w-0 flex-1 text-[12px]">
          <p className="font-semibold text-brand-ink">Promoção efetivada</p>
          <p className="truncate text-brand-graphite">Analista de Operações → Analista Sênior · efetivada na folha de setembro</p>
        </div>
        <span className="shrink-0 rounded-full bg-emerald-100 px-2 py-0.5 text-[10.5px] font-semibold text-emerald-800">Sem redigitar</span>
      </m.div>
    </m.div>
  )
}
