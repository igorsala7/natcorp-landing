import { useRef } from 'react'
import { Link } from 'react-router'
import { ArrowRight, ChevronLeft, ChevronRight } from 'lucide-react'
import { Section, Eyebrow } from './Section'
import { Reveal } from '@/components/motion/Reveal'
import { segmentIcons, segmentPath, segmentRegistry, segmentsPath } from '@/content/segments'
import { segmentCovers } from '@/content/segmentCovers'

/**
 * Segmentos com personalidade de faixa: fotos das pessoas de cada segmento em cartões
 * que rolam para o lado, cada um com a dor do segmento em uma frase.
 */
export function SegmentsSection() {
  const scroller = useRef<HTMLDivElement>(null)

  const scrollBy = (dir: 1 | -1) => {
    const el = scroller.current
    if (!el) return
    const card = el.querySelector<HTMLElement>('[data-card]')
    const step = card ? card.offsetWidth + 16 : 320
    el.scrollBy({ left: dir * step * 2, behavior: 'smooth' })
  }

  return (
    <Section id="segmentos" tone="white" className="overflow-hidden" aria-labelledby="segmentos-home-title">
      <div className="container flex flex-col gap-6 sm:flex-row sm:items-end sm:justify-between">
        <div className="max-w-2xl">
          <Reveal y={12} duration={0.5}>
            <Eyebrow>Segmentos</Eyebrow>
          </Reveal>
          <Reveal delay={0.08}>
            <h2 id="segmentos-home-title" className="mt-4 text-3xl font-extrabold leading-[1.08] text-brand-ink sm:text-4xl lg:text-[2.75rem]">
              A dor muda de segmento para segmento. <span className="text-brand-purple">O sistema acompanha.</span>
            </h2>
          </Reveal>
        </div>
        <Reveal delay={0.2} className="hidden shrink-0 gap-2 sm:flex">
          <button
            type="button"
            onClick={() => scrollBy(-1)}
            className="flex h-11 w-11 items-center justify-center rounded-full border border-brand-mist text-brand-ink transition-colors hover:border-brand-purple hover:text-brand-purple"
            aria-label="Segmentos anteriores"
          >
            <ChevronLeft className="h-5 w-5" aria-hidden />
          </button>
          <button
            type="button"
            onClick={() => scrollBy(1)}
            className="flex h-11 w-11 items-center justify-center rounded-full border border-brand-mist text-brand-ink transition-colors hover:border-brand-purple hover:text-brand-purple"
            aria-label="Próximos segmentos"
          >
            <ChevronRight className="h-5 w-5" aria-hidden />
          </button>
        </Reveal>
      </div>

      <Reveal delay={0.15}>
        <div
          ref={scroller}
          className="no-scrollbar mt-10 flex snap-x snap-mandatory gap-4 overflow-x-auto px-5 pb-4 scroll-pl-5 sm:px-6 sm:scroll-pl-6 lg:mt-12 lg:px-[max(2rem,calc((100vw-1280px)/2+2rem))] lg:scroll-pl-[max(2rem,calc((100vw-1280px)/2+2rem))]"
          aria-label="Segmentos atendidos"
        >
          {segmentRegistry.map((s) => {
            const cover = segmentCovers[s.slug]
            const Icon = segmentIcons[s.icon]
            return (
              <Link
                key={s.slug}
                to={segmentPath(s.slug)}
                data-card
                className="group relative aspect-[3/4] w-[240px] shrink-0 snap-start overflow-hidden rounded-3xl bg-brand-blue text-white shadow-soft transition-shadow duration-500 hover:shadow-lift sm:w-[280px] focus-visible:outline-none focus-visible:ring-4 focus-visible:ring-brand-purple/40"
              >
                {cover && (
                  <img
                    src={cover.photo}
                    alt={cover.alt}
                    loading="lazy"
                    decoding="async"
                    style={{ objectPosition: cover.position }}
                    className="absolute inset-0 h-full w-full object-cover transition-transform duration-700 ease-brand group-hover:scale-[1.05]"
                  />
                )}
                <span className="absolute inset-0 bg-brand-purple/35 mix-blend-multiply" aria-hidden />
                <span className="absolute inset-0 bg-gradient-to-t from-brand-blue via-brand-blue/35 to-transparent" aria-hidden />
                <span className="absolute left-4 top-4 flex h-9 w-9 items-center justify-center rounded-lg bg-white/15 backdrop-blur-sm" aria-hidden>
                  <Icon className="h-4.5 w-4.5" strokeWidth={1.7} />
                </span>
                {/* O SETOR é o que a pessoa procura no cartão: ela varre a
                    fileira atrás do próprio ramo, não da dor. Por isso ele vem
                    primeiro na hierarquia — antes ele era a legenda apagada de
                    11px sobre a dor em 17px, e a ordem de leitura ficava
                    invertida. Um fio rosa ancora o bloco. */}
                <span className="absolute inset-x-0 bottom-0 p-5">
                  <span className="block h-0.5 w-8 rounded-full bg-[#E4A9C4]" aria-hidden />
                  <span className="mt-3 block text-[19px] font-extrabold uppercase leading-[1.15] tracking-[0.06em] text-white [text-shadow:0_1px_12px_rgba(27,18,56,.45)]">
                    {s.label}
                  </span>
                  <span className="mt-2 block text-[14px] font-medium leading-snug text-white/85">{cover ? cover.pain : s.short}</span>
                  <span className="mt-3 inline-flex items-center gap-1.5 text-[13px] font-semibold text-[#E4A9C4]">
                    Ver como atendemos
                    <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                  </span>
                </span>
              </Link>
            )
          })}
          <Link
            to={segmentsPath}
            className="group flex aspect-[3/4] w-[200px] shrink-0 snap-start flex-col items-start justify-end rounded-3xl border border-brand-mist bg-brand-off-white p-5 text-brand-ink transition-colors hover:border-brand-purple/40"
          >
            <span className="text-[20px] font-extrabold leading-tight">Todos os segmentos</span>
            <span className="mt-2 text-[13.5px] text-brand-graphite">Nove realidades, um sistema.</span>
            <span className="mt-4 flex h-10 w-10 items-center justify-center rounded-full bg-brand-purple text-white transition-transform duration-300 group-hover:translate-x-0.5">
              <ArrowRight className="h-4.5 w-4.5" aria-hidden />
            </span>
          </Link>
        </div>
      </Reveal>
      <p className="container mt-2 text-[13px] text-brand-graphite sm:hidden">Arraste para o lado para ver os outros segmentos.</p>
    </Section>
  )
}
