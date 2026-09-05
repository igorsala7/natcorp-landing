import { useCallback, useEffect, useState } from 'react'
import { Link } from 'react-router'
import { ArrowDown, ArrowRight, Check, Clock } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { scrollToElement } from '@/components/motion/ScrollManager'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { EmployeeAvatar } from '@/components/brand/EmployeeAvatar'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { cn } from '@/lib/utils'
import { getModuleEntry, groups, modulePath, moduleRegistry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { cast, company, journeyModuleSlugs, journeyPath, outcomes, phases, steps, type JourneyStep } from '@/content/hiringJourney'
import { EFFECTIVATION_ID, JourneyBar, JourneyMap, useMapRows } from '@/components/journey/JourneyMap'
import { EffectivationHub } from '@/components/journey/EffectivationHub'
import { StepVisual } from '@/components/journey/visuals'

const pad = (n: number) => String(n).padStart(2, '0')

export default function HiringJourneyPage() {
  useSeo({
    title: 'Da vaga à promoção: a jornada do colaborador, etapa por etapa | Natcorp',
    description:
      'As 21 etapas da jornada do colaborador na Natcorp, contadas como um exemplo do dia a dia: da requisição da vaga à admissão digital, do primeiro dia com NatPonto, EPIs e treinamento até a promoção. Cada etapa com os módulos que entram em ação.',
    path: journeyPath,
  })

  const rows = useMapRows()
  const [activeId, setActiveId] = useState<string | null>(null)
  const activeIndex = activeId ? rows.findIndex((r) => r.id === activeId) : -1

  useEffect(() => {
    const els = Array.from(document.querySelectorAll<HTMLElement>('[data-step]'))
    if (els.length === 0) return
    const visible = new Set<Element>()
    const io = new IntersectionObserver(
      (entries) => {
        for (const e of entries) {
          if (e.isIntersecting) visible.add(e.target)
          else visible.delete(e.target)
        }
        // Entre as etapas na faixa de leitura, a mais alta na tela é a atual.
        let best: Element | null = null
        let bestTop = Infinity
        for (const el of visible) {
          const top = el.getBoundingClientRect().top
          if (top < bestTop) {
            bestTop = top
            best = el
          }
        }
        if (best) setActiveId(best.getAttribute('data-step'))
      },
      { rootMargin: '-25% 0px -55% 0px', threshold: 0 },
    )
    els.forEach((el) => io.observe(el))
    return () => io.disconnect()
  }, [])

  const go = useCallback((id: string) => {
    const el = document.getElementById(id)
    if (el) scrollToElement(el)
  }, [])

  const storyModules = journeyModuleSlugs()

  return (
    <PageTransition>
      {/* Abertura */}
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="jornada-page-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Jornada do colaborador' }]} />
          <div className="mt-8 grid grid-cols-1 items-start gap-12 lg:grid-cols-[1.35fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Jornada do colaborador · um exemplo do dia a dia</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="jornada-page-title"
                text="Uma vaga nasce numa segunda-feira. [[Três semanas depois]], a Ana bate o ponto."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.6rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Do recrutamento à promoção, são 21 etapas em 4 fases, cada uma conectando os módulos certos da Natcorp. Aqui elas são contadas
                  como acontecem numa empresa de verdade: o que as pessoas fazem, o que o sistema faz sozinho e onde cada módulo entra.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <button type="button" onClick={() => go('fase-1')}>
                    Começar pela vaga
                    <ArrowDown className="transition-transform duration-300 group-hover/btn:translate-y-0.5" />
                  </button>
                </Button>
                <Button asChild size="lg" variant="outline">
                  <button type="button" onClick={() => go(EFFECTIVATION_ID)}>
                    Ir direto à efetivação
                  </button>
                </Button>
              </Reveal>
              <Stagger className="mt-10 grid grid-cols-2 gap-x-6 gap-y-6 sm:grid-cols-4" delay={0.4}>
                {outcomes.map((o) => (
                  <StaggerItem key={o.label}>
                    <p className="text-3xl font-extrabold tracking-brand text-brand-purple">{o.value}</p>
                    <p className="mt-1 text-[13px] leading-snug text-brand-graphite">{o.label}</p>
                  </StaggerItem>
                ))}
              </Stagger>
            </div>

            <Reveal delay={0.3} className="rounded-3xl border border-brand-mist bg-white p-6 shadow-soft">
              <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">A empresa do exemplo</p>
              <p className="mt-1 text-lg font-extrabold text-brand-ink">{company.name}</p>
              <p className="text-[13.5px] text-brand-graphite">
                {company.descriptor}. A história se passa na {company.unit}.
              </p>
              <p className="mt-5 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Quem aparece</p>
              <ul className="mt-2 divide-y divide-brand-mist">
                {cast.map((c) => (
                  <li key={c.name} className="flex items-center gap-3 py-2">
                    {c.hero ? (
                      <EmployeeAvatar ring className="h-9 w-9 shrink-0" />
                    ) : (
                      <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-brand-off-white text-[11px] font-extrabold text-brand-purple">{c.initials}</span>
                    )}
                    <span className="min-w-0">
                      <span className="block text-[13.5px] font-bold text-brand-ink">{c.name}</span>
                      <span className="block text-[12px] text-brand-graphite">{c.role}</span>
                    </span>
                  </li>
                ))}
              </ul>
              <p className="mt-4 text-[11.5px] leading-snug text-brand-graphite">Empresa, pessoas, datas e valores são fictícios. As etapas, os módulos e o que o sistema faz em cada uma são reais.</p>
            </Reveal>
          </div>

          {/* As quatro fases */}
          <Stagger className="mt-14 grid gap-3 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4" stagger={0.08}>
            {phases.map((p, i) => (
              <StaggerItem key={p.n} className="relative">
                <button
                  type="button"
                  onClick={() => go(`fase-${p.n}`)}
                  className="group flex h-full w-full flex-col rounded-2xl border border-brand-mist bg-white p-5 text-left transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
                >
                  <span className="flex items-center justify-between">
                    <span className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-purple">Fase {p.n}</span>
                    <span className="text-[11px] font-semibold text-brand-graphite">
                      Etapas {pad(p.steps[0])} a {pad(p.steps[1])}
                    </span>
                  </span>
                  <span className="mt-2 text-lg font-extrabold leading-tight text-brand-ink">{p.title}</span>
                  <span className="mt-1.5 text-[13px] leading-snug text-brand-graphite">{p.subtitle}</span>
                  <span className="mt-4 inline-flex items-center gap-1.5 text-[12px] font-semibold text-brand-purple">
                    {p.range}
                    <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                  </span>
                </button>
                {i < phases.length - 1 && (
                  <span aria-hidden className="absolute -right-3 top-1/2 z-10 hidden h-6 w-6 -translate-y-1/2 items-center justify-center rounded-full border border-brand-mist bg-white text-brand-purple lg:flex">
                    <ArrowRight className="h-3 w-3" strokeWidth={2.5} />
                  </span>
                )}
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* A história */}
      <Section tone="white" flush className="py-6 lg:py-12" aria-label="A história, etapa por etapa">
        <div className="container">
          <JourneyBar rows={rows} activeIndex={activeIndex} onSelect={go} />
          <div className="lg:grid lg:grid-cols-[240px_minmax(0,1fr)] lg:gap-12 xl:grid-cols-[260px_minmax(0,1fr)] xl:gap-16">
            <aside className="hidden lg:block">
              <div className="sticky top-[calc(var(--nav-h)+1.5rem)] max-h-[calc(100vh-var(--nav-h)-3rem)] overflow-y-auto pr-2 [scrollbar-width:thin]">
                <JourneyMap rows={rows} activeIndex={activeIndex} onSelect={go} />
              </div>
            </aside>

            <div className="min-w-0">
              {phases.map((p) => (
                <div key={p.n}>
                  <header id={`fase-${p.n}`} className="scroll-mt-28 pb-2 pt-12 lg:pt-16">
                    <Eyebrow>
                      Fase {p.n} · {p.range}
                    </Eyebrow>
                    <h2 className="mt-3 text-3xl font-extrabold leading-tight text-brand-ink sm:text-4xl">{p.title}</h2>
                    <p className="mt-2 max-w-2xl text-[16px] leading-relaxed text-brand-graphite">{p.subtitle}</p>
                  </header>
                  {steps
                    .filter((s) => s.phase === p.n)
                    .map((s) => (
                      <div key={s.id}>
                        <StepArticle step={s} />
                        {s.n === 12 && (
                          <div className="py-10">
                            <EffectivationHub id={EFFECTIVATION_ID} />
                          </div>
                        )}
                      </div>
                    ))}
                </div>
              ))}
            </div>
          </div>
        </div>
      </Section>

      {/* Fechamento */}
      <Section tone="dark" className="overflow-hidden" aria-labelledby="jornada-fim-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative">
          <SectionHeader
            id="jornada-fim-title"
            tone="dark"
            eyebrow="O que a história mostra"
            title="Uma ação inicial, [[dezenas de atualizações]]. Nenhuma redigitação."
            lead="Marcos pediu uma vaga. Tudo o que veio depois, do processo seletivo ao holerite de Ana, nasceu daquele pedido e dos dados que cada pessoa informou uma única vez."
          />
          <Stagger className="mt-12 grid grid-cols-2 gap-6 lg:grid-cols-4" stagger={0.08}>
            {outcomes.map((o) => (
              <StaggerItem key={o.label} className="rounded-2xl border border-white/10 bg-white/[0.05] p-5">
                <p className="text-3xl font-extrabold tracking-brand text-white sm:text-4xl">{o.value}</p>
                <p className="mt-2 text-[13px] leading-snug text-white/70">{o.label}</p>
              </StaggerItem>
            ))}
          </Stagger>

          <Reveal delay={0.15} className="mt-14">
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Os {storyModules.length} módulos que apareceram nesta história</p>
            <div className="mt-6 grid gap-6 md:grid-cols-2 xl:grid-cols-3">
              {groups.map((g) => {
                const mods = moduleRegistry.filter((mod) => mod.group === g.id && storyModules.includes(mod.slug))
                if (mods.length === 0) return null
                return (
                  <div key={g.id}>
                    <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">{g.name}</p>
                    <ul className="mt-2 flex flex-wrap gap-1.5">
                      {mods.map((mod) => {
                        const Icon = moduleIcons[mod.icon]
                        return (
                          <li key={mod.slug}>
                            <Link
                              to={modulePath(mod.slug)}
                              className="inline-flex items-center gap-1.5 rounded-lg border border-white/15 bg-white/[0.06] px-2.5 py-1.5 text-[12.5px] font-semibold text-white transition-colors duration-300 hover:border-white/40 hover:bg-white/10"
                            >
                              <Icon className="h-3.5 w-3.5 text-[#E4A9C4]" strokeWidth={1.8} aria-hidden />
                              {mod.name}
                            </Link>
                          </li>
                        )
                      })}
                    </ul>
                  </div>
                )
              })}
            </div>
          </Reveal>

          <Reveal delay={0.2} className="mt-12 flex flex-wrap gap-3">
            <Button asChild size="lg" variant="inverse">
              <Link to="#contato">
                Ver essa jornada com os seus dados
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
              </Link>
            </Button>
            <Button asChild size="lg" variant="outline-inverse">
              <Link to="/modulos">Conhecer todos os módulos</Link>
            </Button>
          </Reveal>
        </div>
      </Section>

      <CTASection />
    </PageTransition>
  )
}

function StepArticle({ step }: { step: JourneyStep }) {
  const mods = step.modules.map((mref) => ({ ...mref, entry: getModuleEntry(mref.slug) })).filter((mref) => mref.entry)
  const when = [step.when.day, step.when.date, step.when.time].filter(Boolean).join(' · ')
  return (
    <article id={step.id} data-step={step.id} aria-labelledby={`${step.id}-title`} className="scroll-mt-28 border-t border-brand-mist py-10 first-of-type:border-t-0 lg:py-12">
      <div className="grid grid-cols-1 gap-8 xl:grid-cols-[minmax(0,1fr)_340px] xl:gap-12">
        <div className="min-w-0">
          <Reveal y={10} duration={0.5} className="flex flex-wrap items-center gap-x-2 gap-y-1.5 text-[12px]">
            <span className="rounded-full bg-brand-purple px-2.5 py-0.5 font-bold text-white">Etapa {pad(step.n)}</span>
            <span className="font-semibold uppercase tracking-[0.14em] text-brand-purple">{step.name}</span>
            <span className="text-brand-graphite">{step.official}</span>
          </Reveal>
          <Reveal delay={0.06} className="mt-4 inline-flex items-center gap-1.5 rounded-lg bg-brand-off-white px-2.5 py-1 text-[12.5px] font-semibold tabular text-brand-graphite">
            <Clock className="h-3.5 w-3.5 text-brand-pink" aria-hidden />
            {when}
          </Reveal>
          <Reveal delay={0.1}>
            <h3 id={`${step.id}-title`} className="mt-3 text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">
              {step.title}
            </h3>
          </Reveal>
          {step.story.map((par, i) => (
            <Reveal key={i} delay={0.14 + i * 0.05}>
              <p className="mt-4 text-[16.5px] leading-relaxed text-brand-graphite">{par}</p>
            </Reveal>
          ))}
          <Reveal delay={0.22} className="mt-6 rounded-2xl bg-brand-off-white p-5">
            <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-purple">No sistema</p>
            <ul className="mt-3 space-y-2">
              {step.system.map((b) => (
                <li key={b} className="flex items-start gap-2.5 text-[14.5px] leading-snug text-brand-ink">
                  <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                    <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                  </span>
                  {b}
                </li>
              ))}
            </ul>
          </Reveal>
          <Reveal delay={0.28} className="mt-5">
            <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Módulos nesta etapa</p>
            <ul className="mt-2.5 flex flex-wrap gap-2">
              {mods.map((mref) => {
                const Icon = moduleIcons[mref.entry!.icon]
                return (
                  <li key={mref.slug}>
                    <Link
                      to={modulePath(mref.slug)}
                      className={cn(
                        'group inline-flex items-center gap-2 rounded-xl border border-brand-mist bg-white py-1.5 pl-2 pr-3 text-[13px] transition-[border-color,box-shadow,transform] duration-300 ease-brand hover:-translate-y-0.5 hover:border-brand-purple/40 hover:shadow-soft',
                      )}
                    >
                      <span className="flex h-7 w-7 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
                        <Icon className="h-3.5 w-3.5" strokeWidth={1.8} aria-hidden />
                      </span>
                      <span className="font-bold text-brand-ink">{mref.entry!.name}</span>
                      <span className="hidden text-brand-graphite sm:inline">· {mref.note}</span>
                    </Link>
                  </li>
                )
              })}
            </ul>
          </Reveal>
        </div>
        <div className="min-w-0 xl:pt-12">
          <StepVisual visual={step.visual} />
        </div>
      </div>
    </article>
  )
}
