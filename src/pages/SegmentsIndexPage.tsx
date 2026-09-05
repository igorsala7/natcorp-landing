import { Link } from 'react-router'
import { ArrowRight, ChevronRight } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { moduleRegistry } from '@/content/modulePages'
import { segmentIcons, segmentPath, segmentRegistry, segmentsPath } from '@/content/segments'

const promises = [
  { t: 'As dores do segmento primeiro', d: 'Cada página começa pelo que tira o sono do RH daquele mercado: escalas, normas, sazonalidade, dispersão, turnover.' },
  { t: 'Uma resposta por dor', d: 'Para cada dificuldade, os módulos que trabalham juntos para resolvê-la, com o dado entrando uma vez só.' },
  { t: 'O paralelo com os 31 módulos', d: 'Todos os módulos, aplicados à realidade do segmento, com destaque para os que mais pesam ali.' },
]

export default function SegmentsIndexPage() {
  useSeo({
    title: 'Segmentos atendidos pelo sistema de RH Natcorp | Natcorp',
    description:
      'Indústria, bens de consumo, serviços, saúde, recursos naturais, setor público, serviços financeiros, varejo e telecom: como o sistema de RH da Natcorp atende cada segmento.',
    path: segmentsPath,
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="segmentos-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Segmentos' }]} />
          <div className="mt-8 grid grid-cols-1 items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Segmentos</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="segmentos-title"
                text="Cada segmento tem a sua realidade. [[O sistema se adapta a ela.]]"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  A escala 12x36 do hospital, o domingo do shopping, a safra do agro, a jornada de seis horas do banco. Um único sistema, com mais de{' '}
                  {moduleRegistry.length - 1} módulos, parametrizado para a operação de pessoas de cada mercado. Escolha o seu.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="grid gap-3">
              {promises.map((p) => (
                <div key={p.t} className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <p className="text-[15px] font-bold text-brand-ink">{p.t}</p>
                  <p className="mt-1 text-[13.5px] leading-snug text-brand-graphite">{p.d}</p>
                </div>
              ))}
            </Reveal>
          </div>
        </div>
      </Section>

      <Section id="lista" tone="white" aria-labelledby="lista-title">
        <div className="container">
          <SectionHeader id="lista-title" eyebrow={`${segmentRegistry.length} segmentos`} title="Escolha o [[seu mercado]]." />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {segmentRegistry.map((s) => {
              const Icon = segmentIcons[s.icon]
              return (
                <StaggerItem key={s.slug}>
                  <Link
                    to={segmentPath(s.slug)}
                    className="group flex h-full flex-col rounded-3xl border border-brand-mist bg-white p-6 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
                  >
                    <span className="flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                      <Icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                    </span>
                    <span className="mt-5 flex items-center gap-1.5 text-xl font-bold text-brand-ink group-hover:text-brand-purple">
                      {s.label}
                      <ChevronRight className="h-4 w-4 text-brand-gray transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                    </span>
                    <span className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{s.short}</span>
                  </Link>
                </StaggerItem>
              )
            })}
          </Stagger>
        </div>
      </Section>

      <CTASection />
    </PageTransition>
  )
}
