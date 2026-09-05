import { Check, X } from 'lucide-react'
import { Section } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { comparison, results } from '@/content/recognition'

interface ComparisonSectionProps {
  id?: string
  tone?: 'white' | 'off'
}

/** Natcorp x outros sistemas: o que vem incluído e o que costuma ser limite ou custo extra. */
export function ComparisonSection({ id = 'comparativo', tone = 'white' }: ComparisonSectionProps) {
  return (
    <Section id={id} tone={tone} aria-labelledby={`${id}-title`}>
      <div className="container">
        <div className="grid grid-cols-1 gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Natcorp x outros sistemas</p>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id={`${id}-title`} className="mt-3 text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">Sem cobrar por usuário, por CNPJ nem por histórico.</h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">
                Um comparativo direto para quem leva a gestão de pessoas a sério: o que vem incluído na Natcorp e o que costuma ser limite ou custo extra em outros sistemas.
              </p>
            </Reveal>
            <Stagger className="mt-8 grid gap-4 sm:grid-cols-3 lg:grid-cols-1" stagger={0.1} delay={0.2}>
              {results.map((r) => (
                <StaggerItem key={r.label} className="border-l-2 border-brand-pink pl-4">
                  <p className="text-2xl font-extrabold tracking-brand text-brand-purple">{r.value}</p>
                  <p className="text-[13px] font-bold text-brand-ink">{r.label}</p>
                  <p className="mt-1 text-[13px] leading-snug text-brand-graphite">{r.text}</p>
                </StaggerItem>
              ))}
            </Stagger>
          </div>

          <Reveal delay={0.15} className="min-w-0">
            <div className="relative overflow-x-auto rounded-3xl border border-brand-mist shadow-soft">
              <table className="w-full min-w-[640px] border-collapse text-left text-[14px]">
                <caption className="sr-only">Comparativo entre a Natcorp e outros sistemas de RH</caption>
                <thead>
                  <tr className="bg-brand-gradient text-white">
                    <th scope="col" className="px-5 py-4 text-[12px] font-semibold uppercase tracking-[0.12em]">
                      Característica
                    </th>
                    <th scope="col" className="px-5 py-4 text-[12px] font-semibold uppercase tracking-[0.12em]">
                      <span className="inline-flex items-center gap-2">
                        <Logo variant="symbol" tone="white" decorative className="h-3.5 w-3.5" />
                        Natcorp
                      </span>
                    </th>
                    <th scope="col" className="px-5 py-4 text-[12px] font-semibold uppercase tracking-[0.12em] text-white/80">
                      Outros sistemas
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {comparison.map((row, i) => (
                    <tr key={row.feature} className={i % 2 === 0 ? 'bg-white' : 'bg-brand-off-white/70'}>
                      <th scope="row" className="px-5 py-3.5 align-top font-semibold text-brand-ink">
                        {row.feature}
                      </th>
                      <td className="px-5 py-3.5 align-top text-brand-ink">
                        <span className="flex items-start gap-2">
                          <span className="relative mt-0.5 flex h-4.5 w-4.5 shrink-0 items-center justify-center rounded-full bg-emerald-100 text-emerald-700">
                            <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                            <span className="sr-only">Sim:</span>
                          </span>
                          {row.natcorp}
                        </span>
                      </td>
                      <td className="px-5 py-3.5 align-top text-brand-graphite">
                        <span className="flex items-start gap-2">
                          <span className="relative mt-0.5 flex h-4.5 w-4.5 shrink-0 items-center justify-center rounded-full bg-brand-mist text-brand-graphite">
                            <X className="h-3 w-3" strokeWidth={3} aria-hidden />
                            <span className="sr-only">Não:</span>
                          </span>
                          {row.others}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Reveal>
        </div>

      </div>
    </Section>
  )
}
