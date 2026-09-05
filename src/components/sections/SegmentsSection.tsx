import { Link } from 'react-router'
import { ArrowRight, ChevronRight } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { segmentIcons, segmentPath, segmentRegistry, segmentsPath } from '@/content/segments'

/** Os segmentos atendidos, com link para a página de cada um. */
export function SegmentsSection() {
  return (
    <Section id="segmentos" tone="white" aria-labelledby="segmentos-home-title">
      <div className="container">
        <SectionHeader
          id="segmentos-home-title"
          align="center"
          eyebrow="Segmentos"
          title="Cada segmento tem a sua realidade. [[O sistema se adapta a ela.]]"
          lead="Escalas de hospital, domingo de shopping, safra, campo, jornada bancária, transparência pública. Veja como o sistema responde às dores do seu mercado, módulo por módulo."
        />
        <Stagger className="mt-12 grid gap-3 sm:grid-cols-2 lg:mt-16 lg:grid-cols-3" stagger={0.05}>
          {segmentRegistry.map((s) => {
            const Icon = segmentIcons[s.icon]
            return (
              <StaggerItem key={s.slug}>
                <Link
                  to={segmentPath(s.slug)}
                  className="group flex h-full items-start gap-4 rounded-2xl border border-brand-mist bg-white p-5 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
                >
                  <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                    <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <span className="min-w-0">
                    <span className="flex items-center gap-1.5 text-[15px] font-bold text-brand-ink group-hover:text-brand-purple">
                      {s.label}
                      <ChevronRight className="h-4 w-4 text-brand-gray transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                    </span>
                    <span className="mt-1 block text-[13.5px] leading-snug text-brand-graphite">{s.short}</span>
                  </span>
                </Link>
              </StaggerItem>
            )
          })}
        </Stagger>
        <Reveal delay={0.15} className="mt-8 text-center">
          <Link to={segmentsPath} className="group inline-flex items-center gap-2 text-sm font-semibold text-brand-purple">
            Ver todos os segmentos
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
        </Reveal>
      </div>
    </Section>
  )
}
