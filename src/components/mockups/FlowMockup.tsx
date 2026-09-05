import { m, useReducedMotion } from 'motion/react'
import { Calculator, ScanFace, Send, Timer } from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const nodes = [
  { icon: ScanFace, title: 'NatPonto', meta: '84 marcações · facial + GPS' },
  { icon: Timer, title: 'Apuração', meta: 'Jornada 12×36 · 0 pendências' },
  { icon: Calculator, title: 'Folha', meta: '2.500 colaboradores/min' },
  { icon: Send, title: 'eSocial', meta: 'S-1200 · aceito' },
]

/** Pipeline ponto → apuração → folha → eSocial, com pulsos percorrendo os conectores. */
export function FlowMockup({ className }: { className?: string }) {
  const reduced = useReducedMotion()
  return (
    <div
      className={cn('rounded-2xl border border-brand-mist bg-white p-5 shadow-lift sm:p-6', className)}
      role="img"
      aria-label="Fluxo integrado: marcação no NatPonto, apuração da jornada, cálculo da folha e envio ao eSocial"
    >
      <div className="flex items-center justify-between">
        <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Fechamento · Setembro</p>
        <span className="rounded-full bg-brand-off-white px-2.5 py-1 text-[11px] font-semibold text-brand-purple">Em dia</span>
      </div>

      <m.ol
        className="mt-6 grid grid-cols-2 gap-x-3 gap-y-6 sm:grid-cols-4 sm:gap-x-0"
        initial="hidden"
        whileInView="visible"
        viewport={viewportOnce}
        variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.16, delayChildren: 0.15 } } }}
      >
        {nodes.map(({ icon: Icon, title, meta }, i) => (
          <m.li
            key={title}
            className="relative flex flex-col items-center text-center"
            variants={{ hidden: { opacity: 0, y: 14 }, visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } } }}
          >
            {i < nodes.length - 1 && (
              <span className="absolute left-[calc(50%+1.75rem)] right-[calc(-50%+1.75rem)] top-6 hidden h-px bg-brand-mist sm:block" aria-hidden>
                {!reduced && (
                  <m.span
                    className="absolute -top-[2px] h-[5px] w-[5px] rounded-full bg-brand-pink"
                    animate={{ left: ['0%', '100%'], opacity: [0, 1, 1, 0] }}
                    transition={{ duration: 1.6, repeat: Infinity, ease: 'easeInOut', delay: i * 0.5 + 1 }}
                  />
                )}
              </span>
            )}
            <span
              className={cn(
                'relative z-10 flex h-12 w-12 items-center justify-center rounded-xl border bg-white',
                i === 2 ? 'border-brand-purple bg-brand-purple text-white' : 'border-brand-mist text-brand-purple',
              )}
            >
              <Icon className="h-5 w-5" strokeWidth={1.6} />
            </span>
            <p className="mt-3 text-sm font-bold text-brand-ink">{title}</p>
            <p className="mt-0.5 text-[11.5px] leading-snug text-brand-graphite">{meta}</p>
          </m.li>
        ))}
      </m.ol>

      <div className="mt-6 grid grid-cols-3 gap-2 text-center">
        {[
          ['Banco de horas', '+1.240 h'],
          ['Abonos aprovados', '37'],
          ['Layouts eSocial', '12/12'],
        ].map(([k, v]) => (
          <div key={k} className="rounded-lg bg-brand-off-white/70 px-2 py-2.5">
            <p className="text-[14px] font-extrabold tabular text-brand-ink">{v}</p>
            <p className="text-[10.5px] text-brand-graphite">{k}</p>
          </div>
        ))}
      </div>
    </div>
  )
}
