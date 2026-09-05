import { Check, X } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { comparison, results } from '@/content/recognition'

/* Os quatro pilares da marca (Manual de Identidade, seção 01). */
const pillars = [
  { big: '30+', title: 'Abrangência', text: 'Mais de 30 módulos. Tudo o que o RH faz, em um só lugar, com um único cadastro e uma única base.' },
  { big: '35+', title: 'Solidez', text: 'Mais de 35 anos de especialização exclusiva em RH, plataforma premiada, parceira Oracle e nuvem com contingência.' },
  { big: 'NATI', title: 'Inteligência', text: 'A NATI e o People Analytics transformando dado em decisão, dentro do sistema e sem depender de TI.' },
  { big: '1:1', title: 'Proximidade', text: 'Acompanhamento próximo, atenção e agilidade de resposta. Um time que conhece a sua operação pelo nome.' },
]

export function WhySection() {
  return (
    <Section id="por-que-natcorp" tone="white" aria-labelledby="porque-title">
      <div className="container">
        <SectionHeader
          id="porque-title"
          align="center"
          eyebrow="Por que Natcorp"
          title="Por que as grandes empresas [[escolhem a Natcorp]]."
          lead="Não é só a quantidade de funcionalidades. É a combinação de abrangência, solidez, inteligência e um time que responde rápido."
        />

        <Stagger className="mt-14 grid gap-4 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4" stagger={0.1}>
          {pillars.map((p) => (
            <StaggerItem
              key={p.title}
              className="group relative overflow-hidden rounded-3xl border border-brand-mist bg-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
            >
              <span className="pointer-events-none absolute -right-8 -top-8 h-32 w-32 rounded-full bg-brand-off-white transition-transform duration-700 ease-brand group-hover:scale-[1.6]" aria-hidden />
              <p className="relative text-4xl font-extrabold tracking-brand text-brand-purple">{p.big}</p>
              <h3 className="relative mt-5 text-xl font-bold text-brand-ink">{p.title}</h3>
              <p className="relative mt-2 text-[15px] leading-relaxed text-brand-graphite">{p.text}</p>
            </StaggerItem>
          ))}
        </Stagger>

        {/* Natcorp x outros sistemas */}
        <div className="mt-20 grid grid-cols-1 gap-10 lg:mt-28 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Natcorp x outros sistemas</p>
            </Reveal>
            <Reveal delay={0.08}>
              <h3 className="mt-3 text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">Sem cobrar por usuário, por CNPJ nem por histórico.</h3>
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

        <Reveal delay={0.2} className="relative mt-16 overflow-hidden rounded-3xl bg-brand-gradient px-6 py-12 text-center text-white sm:px-12 sm:py-16 lg:mt-24">
          <Logo variant="symbol" tone="white" decorative className="absolute -right-10 -top-10 h-48 w-48 opacity-[0.08]" />
          <p className="mx-auto max-w-3xl text-2xl font-extrabold leading-snug sm:text-3xl lg:text-4xl">
            Foque no que importa: o negócio e a gestão. Deixe a parte mecânica e operacional com o sistema.
          </p>
          <p className="mt-4 text-sm font-medium text-white/70">Soluções inteligentes para organizações que levam a gestão de pessoas a sério. Do C-Level ao estagiário.</p>
        </Reveal>
      </div>
    </Section>
  )
}
