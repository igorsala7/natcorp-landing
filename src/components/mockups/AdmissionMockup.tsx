import { m } from 'motion/react'
import { Check, FileSignature, ShieldCheck } from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const steps = [
  { label: 'Dados do candidato', meta: 'Portal do Candidato · 6 min', state: 'done' },
  { label: 'Documentos no GED', meta: 'RG, CPF, comprovante, dependentes', state: 'done' },
  { label: 'Assinatura eletrônica', meta: 'Contrato de trabalho · validade jurídica', state: 'active' },
  { label: 'Admissão na folha', meta: 'Cadastro, ponto e benefícios criados', state: 'next' },
] as const

export function AdmissionMockup({ className }: { className?: string }) {
  return (
    <m.div
      className={cn('rounded-2xl border border-brand-mist bg-white p-5 shadow-lift sm:p-6', className)}
      role="img"
      aria-label="Fluxo de admissão digital: dados do candidato, documentos, assinatura eletrônica e admissão na folha"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.18, delayChildren: 0.2 } } }}
    >
      <div className="flex items-center justify-between">
        <div>
          <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Admissão Digital</p>
          <p className="mt-0.5 text-[15px] font-bold text-brand-ink">Ana Ribeiro · Analista de Operações</p>
        </div>
        <span className="rounded-full bg-emerald-50 px-2.5 py-1 text-[11px] font-semibold text-emerald-700">3 de 4 etapas</span>
      </div>

      <ol className="mt-5 space-y-3">
        {steps.map((s, i) => (
          <m.li
            key={s.label}
            className="flex items-center gap-3"
            variants={{ hidden: { opacity: 0, x: -12 }, visible: { opacity: 1, x: 0, transition: { duration: 0.6, ease: EASE } } }}
          >
            <span
              className={cn(
                'flex h-7 w-7 shrink-0 items-center justify-center rounded-full border text-[11px] font-bold',
                s.state === 'done' && 'border-brand-purple bg-brand-purple text-white',
                s.state === 'active' && 'border-brand-pink bg-white text-brand-pink',
                s.state === 'next' && 'border-brand-mist bg-white text-brand-graphite',
              )}
            >
              {s.state === 'done' ? <Check className="h-3.5 w-3.5" strokeWidth={2.5} /> : i + 1}
            </span>
            <div className="min-w-0 flex-1">
              <p className={cn('text-sm font-semibold', s.state === 'next' ? 'text-brand-graphite' : 'text-brand-ink')}>{s.label}</p>
              <p className="truncate text-[11.5px] text-brand-graphite">{s.meta}</p>
            </div>
            {s.state === 'active' && (
              <m.span
                className="h-1.5 w-16 overflow-hidden rounded-full bg-brand-mist"
                aria-hidden
              >
                <m.span
                  className="block h-full rounded-full bg-brand-pink"
                  initial={{ width: '20%' }}
                  whileInView={{ width: '85%' }}
                  viewport={viewportOnce}
                  transition={{ duration: 1.6, ease: EASE, delay: 0.9 }}
                />
              </m.span>
            )}
          </m.li>
        ))}
      </ol>

      <m.div
        className="mt-5 flex items-center gap-3 rounded-xl border border-brand-purple/20 bg-brand-off-white/70 p-3.5"
        variants={{ hidden: { opacity: 0, y: 10 }, visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } } }}
      >
        <span className="flex h-9 w-9 items-center justify-center rounded-lg bg-white text-brand-purple shadow-soft">
          <FileSignature className="h-4.5 w-4.5" strokeWidth={1.6} />
        </span>
        <div className="min-w-0 flex-1 text-[12px]">
          <p className="font-semibold text-brand-ink">Contrato de trabalho.pdf</p>
          <p className="text-brand-graphite">Assinado por Ana Ribeiro · 04/09/2026 14:32</p>
        </div>
        <span className="flex items-center gap-1 text-[11px] font-semibold text-emerald-700">
          <ShieldCheck className="h-3.5 w-3.5" strokeWidth={2} />
          ICP-Brasil
        </span>
      </m.div>
    </m.div>
  )
}
