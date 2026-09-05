import { m } from 'motion/react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const exams = [
  { name: 'Marcos Lima', type: 'Periódico · NR-7', days: 3, tone: 'pink' },
  { name: 'Beatriz Souza', type: 'Retorno ao trabalho', days: 8, tone: 'purple' },
  { name: 'Rafael Nunes', type: 'Mudança de risco', days: 12, tone: 'purple' },
]

const events = [
  { code: 'S-2210', label: 'CAT', status: 'Enviado em 6h' },
  { code: 'S-2220', label: 'ASO', status: 'Aceito' },
  { code: 'S-2240', label: 'Riscos', status: 'Validado' },
]

const chain = ['PGR', 'GHE', 'PCMSO', 'ASO']

export function SesmtMockup({ className }: { className?: string }) {
  return (
    <m.div
      className={cn('rounded-2xl border border-brand-mist bg-white p-5 shadow-lift sm:p-6', className)}
      role="img"
      aria-label="Painel de saúde e segurança: exames a vencer, eventos de SST do eSocial e a cadeia PGR, GHE, PCMSO e ASO"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.12, delayChildren: 0.2 } } }}
    >
      <div className="flex items-center justify-between">
        <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">SESMT · próximos 15 dias</p>
        <span className="rounded-full bg-brand-purple/10 px-2.5 py-1 text-[11px] font-semibold text-brand-purple">12 exames</span>
      </div>

      <ul className="mt-4 divide-y divide-brand-mist">
        {exams.map((e) => (
          <m.li
            key={e.name}
            className="flex items-center gap-3 py-2.5"
            variants={{ hidden: { opacity: 0, x: -10 }, visible: { opacity: 1, x: 0, transition: { duration: 0.5, ease: EASE } } }}
          >
            <span className={cn('h-2 w-2 rotate-45 rounded-[1px]', e.tone === 'pink' ? 'bg-brand-pink' : 'bg-brand-purple')} aria-hidden />
            <div className="min-w-0 flex-1">
              <p className="text-sm font-semibold text-brand-ink">{e.name}</p>
              <p className="text-[11.5px] text-brand-graphite">{e.type}</p>
            </div>
            <span className="text-[12px] font-semibold tabular text-brand-graphite">{e.days} dias</span>
          </m.li>
        ))}
      </ul>

      <m.div
        className="mt-4 flex items-center justify-between rounded-xl bg-brand-blue p-3.5 text-white"
        variants={{ hidden: { opacity: 0, y: 10 }, visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } } }}
      >
        {chain.map((c, i) => (
          <span key={c} className="flex items-center gap-2 text-[12px] font-semibold">
            <span className="rounded-md bg-white/10 px-2 py-1">{c}</span>
            {i < chain.length - 1 && <span className="text-white/40" aria-hidden>→</span>}
          </span>
        ))}
      </m.div>

      <div className="mt-4 grid grid-cols-3 gap-2">
        {events.map((ev) => (
          <m.div
            key={ev.code}
            className="rounded-lg border border-brand-mist p-2.5"
            variants={{ hidden: { opacity: 0, y: 8 }, visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } } }}
          >
            <p className="text-[12px] font-extrabold tabular text-brand-purple">{ev.code}</p>
            <p className="text-[11px] text-brand-graphite">{ev.label}</p>
            <p className="mt-1 text-[11px] font-semibold text-emerald-700">{ev.status}</p>
          </m.div>
        ))}
      </div>
    </m.div>
  )
}
