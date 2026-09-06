import { ArrowRight, ChevronRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { StructureChooser } from '@/components/structure/StructureChooser'
import { structureIcons, structurePath, structureRegistry, structuresPath } from '@/content/structures'

/**
 * "Como é a sua estrutura?" na home: o seletor compacto de um lado e, do outro, as cinco estruturas
 * levando direto às suas páginas. Substitui a antiga seção de estruturas.
 */
export function StructureChooserSection() {
  return (
    <Section id="estrutura" tone="white" className="overflow-x-clip" aria-labelledby="estrutura-title">
      <div className="container">
        <SectionHeader
          id="estrutura-title"
          eyebrow="Como é a sua estrutura?"
          title="Empresa única, grupo ou filiais. [[Um único time]] pode operar tudo."
          lead="Por mais empresas e unidades que existam, um só time de RH consegue fazer toda a gestão e operação, alimentado por requisições eletrônicas que nascem nos portais. Responda a três perguntas e veja como o sistema se encaixa na sua estrutura."
        />

        <div className="mt-12 grid grid-cols-1 gap-8 lg:grid-cols-[1.25fr_1fr] lg:gap-12">
          <Reveal delay={0.1} className="rounded-4xl border border-brand-mist bg-brand-off-white p-5 sm:p-7">
            <StructureChooser compact />
          </Reveal>

          <div className="flex flex-col">
            <Reveal y={12} duration={0.5}>
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Ou vá direto à sua</p>
            </Reveal>
            <Stagger className="mt-4 flex flex-col gap-3" stagger={0.06} delay={0.1}>
              {structureRegistry.map((s) => {
                const Icon = structureIcons[s.icon]
                return (
                  <StaggerItem key={s.slug}>
                    <Link
                      to={structurePath(s.slug)}
                      className="group flex items-start gap-4 rounded-2xl border border-brand-mist bg-white p-4 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-0.5 hover:border-brand-purple/30 hover:shadow-lift focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
                    >
                      <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                        <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                      </span>
                      <span className="min-w-0 flex-1">
                        <span className="flex items-center gap-1.5 text-[15.5px] font-bold text-brand-ink group-hover:text-brand-purple">
                          {s.name}
                          <ChevronRight className="h-4 w-4 shrink-0 text-brand-graphite transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                        </span>
                        <span className="mt-1 block text-[13.5px] leading-snug text-brand-graphite">{s.short}</span>
                      </span>
                    </Link>
                  </StaggerItem>
                )
              })}
            </Stagger>
            <Reveal delay={0.3} className="mt-5">
              <Link to={structuresPath} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Ver as cinco estruturas e o centro de serviços
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </Reveal>
          </div>
        </div>
      </div>
    </Section>
  )
}
