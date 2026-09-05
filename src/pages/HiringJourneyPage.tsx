import { useCallback, useEffect, useRef, useState } from 'react'
import { Link, useSearchParams } from 'react-router'
import { ArrowDown, ArrowRight, BookOpen, Building2, Check, Clock, GitBranch, LayoutGrid } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { StructureSection } from '@/components/sections/StructureSection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { scrollToElement } from '@/components/motion/ScrollManager'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { cn } from '@/lib/utils'
import { paths } from '@/content/site'
import { getModuleEntry, groups, modulePath, moduleRegistry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { actorMeta, castMember, company, EFFECTIVATION_AFTER, journeyModuleSlugs, journeyPath, outcomes, phases, steps, type JourneyStep } from '@/content/hiringJourney'
import { hasFigure, scenes, sceneCaptions } from '@/content/journeyArt'
import { EFFECTIVATION_ID, JourneyBar, JourneyMap, useMapRows } from '@/components/journey/JourneyMap'
import { EffectivationHub } from '@/components/journey/EffectivationHub'
import { VolumeAside } from '@/components/journey/VolumeAside'
import { StepVisual } from '@/components/journey/visuals'
import { CastAvatar, CastFigure, CastList } from '@/components/journey/Cast'
import { JourneyDiagram } from '@/components/journey/JourneyDiagram'
import { IntegrationDiagram } from '@/components/journey/IntegrationDiagram'

const pad = (n: number) => String(n).padStart(2, '0')

type Mode = 'historia' | 'pratico'

const modeOptions: { key: Mode; label: string; short: string; hint: string; icon: typeof BookOpen }[] = [
  { key: 'historia', label: 'História completa', short: 'História', hint: 'a rotina, etapa por etapa', icon: BookOpen },
  { key: 'pratico', label: 'Visão prática', short: 'Diagrama', hint: 'diagrama com resumo', icon: GitBranch },
]

export default function HiringJourneyPage() {
  useSeo({
    title: 'Da vaga à promoção: a jornada do colaborador, etapa por etapa | Natcorp',
    description:
      'As 24 etapas da jornada do colaborador na Natcorp, em uma indústria: da requisição da vaga à admissão digital, do primeiro dia com NatPonto, EPIs e treinamento até a promoção, com o RH operando em paralelo. Em história ou em diagrama, com os módulos que entram em cada etapa.',
    path: journeyPath,
  })

  const [params, setParams] = useSearchParams()
  const mode: Mode = params.get('modo') === 'pratico' ? 'pratico' : 'historia'
  const pendingScroll = useRef<string | null>(null)

  const setMode = useCallback(
    (next: Mode) => {
      setParams(
        (prev) => {
          const p = new URLSearchParams(prev)
          if (next === 'pratico') p.set('modo', 'pratico')
          else p.delete('modo')
          return p
        },
        { replace: true, preventScrollReset: true },
      )
    },
    [setParams],
  )

  const go = useCallback((id: string) => {
    const el = document.getElementById(id)
    if (el) scrollToElement(el)
  }, [])

  /** Da visão prática para a etapa correspondente na história. */
  const openStory = useCallback(
    (stepId: string) => {
      pendingScroll.current = stepId
      setMode('historia')
    },
    [setMode],
  )

  useEffect(() => {
    if (mode === 'historia' && pendingScroll.current) {
      const id = pendingScroll.current
      pendingScroll.current = null
      const t = window.setTimeout(() => go(id), 80)
      return () => window.clearTimeout(t)
    }
  }, [mode, go])

  const storyModules = journeyModuleSlugs()
  const heroFigure = hasFigure('ana')

  return (
    <PageTransition>
      {/* Abertura */}
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="jornada-page-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Jornada do colaborador' }]} />
          <div className={cn('mt-8 grid grid-cols-1 items-start gap-12 lg:gap-16', heroFigure ? 'lg:grid-cols-[1.25fr_1fr]' : 'lg:grid-cols-[1.35fr_1fr]')}>
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Jornada do colaborador · um exemplo do dia a dia em uma indústria</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="jornada-page-title"
                text="Uma vaga nasce e, em poucos cliques, [[a Ana já está contratada]]."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.6rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Da requisição da vaga à promoção, são 24 etapas em 4 fases, cada uma conectando os módulos certos da Natcorp. Sem papel, sem
                  redigitação, com o RH operando em paralelo. Escolha como quer ver: a história completa, com as pessoas e a rotina, ou a visão
                  prática, em diagrama.
                </p>
              </Reveal>
              <Reveal delay={0.32} className="mt-8">
                <ModeSwitch mode={mode} onChange={setMode} />
              </Reveal>
              <Reveal delay={0.38} className="mt-6 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <button type="button" onClick={() => go(mode === 'historia' ? 'fase-1' : 'visao-pratica')}>
                    {mode === 'historia' ? 'Começar pela vaga' : 'Ver o diagrama'}
                    <ArrowDown className="transition-transform duration-300 group-hover/btn:translate-y-0.5" />
                  </button>
                </Button>
                <Button asChild size="lg" variant="outline">
                  <button type="button" onClick={() => go('integracao')}>
                    Ver os módulos se integrando
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

            {heroFigure ? (
              <Reveal delay={0.3} className="relative mx-auto w-full max-w-[440px] lg:mx-0 lg:ml-auto">
                <div aria-hidden className="absolute inset-x-4 bottom-0 top-[14%] rounded-[3rem] bg-brand-gradient shadow-lift" />
                <div aria-hidden className="absolute -left-2 top-[26%] z-20 rounded-2xl border border-brand-mist bg-white px-3.5 py-2.5 text-[12.5px] font-semibold text-brand-ink shadow-lift">
                  <span className="block text-[10px] font-bold uppercase tracking-[0.14em] text-brand-purple">Portal do Candidato</span>
                  Inscrição enviada · 21:27
                </div>
                <div aria-hidden className="absolute -right-2 top-[48%] z-20 rounded-2xl border border-brand-mist bg-white px-3.5 py-2.5 text-[12.5px] font-semibold text-brand-ink shadow-lift">
                  <span className="block text-[10px] font-bold uppercase tracking-[0.14em] text-brand-purple">NatDocs</span>
                  Contrato assinado
                </div>
                <div aria-hidden className="absolute -left-1 top-[68%] z-20 rounded-2xl bg-emerald-700 px-3.5 py-2.5 text-[12.5px] font-semibold text-white shadow-lift">
                  <span className="block text-[10px] font-bold uppercase tracking-[0.14em] text-white">Admissão</span>
                  Confirmada · 09:40
                </div>
                <CastFigure who="ana" alt="Ana Ribeiro, a colaboradora da história, de pé, olhando o celular" className="relative z-10 mx-auto flex h-[460px] justify-center sm:h-[540px]" />
              </Reveal>
            ) : (
              <Reveal delay={0.3} className="rounded-3xl border border-brand-mist bg-white p-6 shadow-soft">
                <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">A empresa do exemplo</p>
                <p className="mt-1 text-lg font-extrabold text-brand-ink">{company.name}</p>
                <p className="text-[13.5px] text-brand-graphite">
                  {company.descriptor}, {company.volume}. A história se passa na {company.unit}.
                </p>
                <p className="mt-5 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Quem aparece</p>
                <CastList className="mt-2" />
                <p className="mt-4 text-[11.5px] leading-snug text-brand-graphite">Empresa, pessoas, datas e valores são fictícios. As etapas, os módulos e o que o sistema faz em cada uma são reais.</p>
              </Reveal>
            )}
          </div>

          {heroFigure && (
            <Reveal delay={0.2} className="mt-12 rounded-3xl border border-brand-mist bg-white p-6 shadow-soft lg:mt-16">
              <div className="grid gap-6 lg:grid-cols-[minmax(0,1fr)_2fr] lg:gap-10">
                <div>
                  <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">A empresa do exemplo</p>
                  <p className="mt-1 text-lg font-extrabold text-brand-ink">{company.name}</p>
                  <p className="text-[13.5px] leading-snug text-brand-graphite">
                    {company.descriptor}, {company.volume}. A história se passa na {company.unit}.
                  </p>
                  <p className="mt-4 text-[11.5px] leading-snug text-brand-graphite">Empresa, pessoas, datas e valores são fictícios. As etapas, os módulos e o que o sistema faz em cada uma são reais.</p>
                </div>
                <div>
                  <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Quem aparece</p>
                  <CastList compact className="mt-3 sm:grid sm:grid-cols-2 xl:grid-cols-3" />
                </div>
              </div>
            </Reveal>
          )}

          {/* As quatro fases */}
          <Stagger className="mt-14 grid gap-3 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4" stagger={0.08}>
            {phases.map((p, i) => (
              <StaggerItem key={p.n} className="relative">
                <button
                  type="button"
                  onClick={() => go(mode === 'historia' ? `fase-${p.n}` : 'visao-pratica')}
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

      {mode === 'historia' ? <StorySection go={go} mode={mode} onModeChange={setMode} /> : <PracticalSection onOpenStory={openStory} mode={mode} onModeChange={setMode} />}

      <StructureSection
        tone="off"
        eyebrow="Para a sua estrutura"
        title="A mesma jornada [[para o grupo inteiro]], com RH central ou em cada filial."
        lead="A Vale Verde tem um RH central. Se o seu grupo tem RH em cada filial, o que muda é o perfil de quem lança e a alçada de quem aprova. As 24 etapas são as mesmas, e a matriz fecha a folha por empresa."
        more
      />

      {/* Fechamento: os módulos se integrando */}
      <Section id="integracao" tone="dark" className="overflow-hidden scroll-mt-20" aria-labelledby="jornada-fim-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative">
          <SectionHeader
            id="jornada-fim-title"
            tone="dark"
            eyebrow="O que a história mostra"
            title="Um pedido de vaga, [[dezenas de atualizações]]. Nenhuma redigitação."
            lead="Marcos pediu uma vaga. Tudo o que veio depois, do processo seletivo ao holerite de Ana, nasceu daquele pedido e dos dados que cada pessoa informou uma única vez. É assim que os módulos se integram em um único fluxo, inteligente e automatizado."
          />
          <Stagger className="mt-12 grid grid-cols-2 gap-6 lg:grid-cols-4" stagger={0.08}>
            {outcomes.map((o) => (
              <StaggerItem key={o.label} className="rounded-2xl border border-white/10 bg-white/[0.05] p-5">
                <p className="text-3xl font-extrabold tracking-brand text-white sm:text-4xl">{o.value}</p>
                <p className="mt-2 text-[13px] leading-snug text-white/70">{o.label}</p>
              </StaggerItem>
            ))}
          </Stagger>

          <Reveal delay={0.1} className="mt-16">
            <Eyebrow tone="white">Diagrama · os módulos se integrando</Eyebrow>
            <h3 className="mt-3 max-w-3xl text-2xl font-extrabold leading-tight sm:text-3xl">Da vaga à promoção, cada módulo entrega o dado pronto para o próximo. E uma camada sustenta todos.</h3>
            <IntegrationDiagram className="mt-8" />
            <p className="mt-3 text-[12px] text-white/60 lg:hidden">Arraste para o lado para ver as quatro fases e a camada que sustenta todas.</p>
          </Reveal>

          <Reveal delay={0.15} className="mt-14">
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Os {storyModules.length} módulos que apareceram nesta jornada</p>
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

          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2" stagger={0.1} aria-label="Continue por aqui">
            {[
              {
                to: paths.segments,
                icon: LayoutGrid,
                title: 'Ver o seu segmento',
                text: 'Nove mercados, da indústria ao setor público: as dores de cada um e os módulos que respondem a elas.',
              },
              {
                to: paths.groups,
                icon: Building2,
                title: 'Grupos com várias empresas e filiais',
                text: 'Perfis por filial, alçadas por unidade e a folha fechando na matriz, por empresa e por CNPJ.',
              },
            ].map((c) => (
              <StaggerItem key={c.to}>
                <Link
                  to={c.to}
                  className="group flex h-full items-start gap-4 rounded-2xl border border-white/15 bg-white/[0.06] p-5 transition-colors duration-300 hover:border-white/40 hover:bg-white/10"
                >
                  <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-white/10 text-[#E4A9C4]">
                    <c.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <span className="min-w-0">
                    <span className="flex items-center gap-1.5 text-[16px] font-extrabold">
                      {c.title}
                      <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                    </span>
                    <span className="mt-1 block text-[13.5px] leading-snug text-white/75">{c.text}</span>
                  </span>
                </Link>
              </StaggerItem>
            ))}
          </Stagger>

          <Reveal delay={0.2} className="mt-8 flex flex-wrap gap-3">
            <Button asChild size="lg" variant="inverse">
              <Link to="#contato">
                Ver essa jornada com os seus dados
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
              </Link>
            </Button>
            <Button asChild size="lg" variant="outline-inverse">
              <Link to={paths.modules}>Conhecer todos os módulos</Link>
            </Button>
          </Reveal>
        </div>
      </Section>

      <CTASection />
    </PageTransition>
  )
}

/* ---------- alternância ---------- */

function ModeSwitch({ mode, onChange, className, compact = false }: { mode: Mode; onChange: (m: Mode) => void; className?: string; compact?: boolean }) {
  return (
    <div role="group" aria-label="Como você quer ver a jornada" className={cn('inline-flex max-w-full rounded-full border border-brand-mist bg-white p-1 shadow-soft', className)}>
      {modeOptions.map((o) => {
        const Icon = o.icon
        const active = o.key === mode
        return (
          <button
            key={o.key}
            type="button"
            aria-pressed={active}
            aria-label={compact ? o.label : undefined}
            onClick={() => onChange(o.key)}
            className={cn(
              'inline-flex items-center gap-2 rounded-full py-2 text-[13.5px] font-semibold transition-colors duration-300',
              compact ? 'px-3.5' : 'px-4 sm:px-5',
              active ? 'bg-brand-purple text-white' : 'text-brand-graphite hover:text-brand-purple',
            )}
          >
            <Icon className="h-4 w-4" strokeWidth={2} aria-hidden />
            <span>{compact ? o.short : o.label}</span>
            {!compact && <span className={cn('hidden text-[12px] font-medium md:inline', active ? 'text-white/80' : 'text-brand-graphite/80')}>· {o.hint}</span>}
          </button>
        )
      })}
    </div>
  )
}

/* ---------- visão prática ---------- */

function PracticalSection({ onOpenStory, mode, onModeChange }: { onOpenStory: (id: string) => void; mode: Mode; onModeChange: (m: Mode) => void }) {
  return (
    <Section id="visao-pratica" tone="white" className="scroll-mt-20" aria-labelledby="visao-pratica-title">
      <div className="container">
        <div className="flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between">
          <div className="max-w-3xl">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Visão prática · quem faz o quê, em que ordem</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="visao-pratica-title" className="mt-4 text-3xl font-extrabold leading-tight text-brand-ink sm:text-4xl">
                As 24 etapas em um diagrama: <span className="text-brand-purple">cada raia é quem executa</span>, cada cartão diz o que acontece e quais módulos entram.
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-4 max-w-2xl text-[16px] leading-relaxed text-brand-graphite">
                Gestor, candidato, colaborador, RH e SESMT fazem a parte deles pelo portal ou pelo celular. O que está na raia Sistema e NATI acontece
                sozinho. Para ler a rotina completa de uma etapa, abra a história.
              </p>
            </Reveal>
          </div>
          <Reveal delay={0.1} className="shrink-0">
            <ModeSwitch mode={mode} onChange={onModeChange} compact />
          </Reveal>
        </div>
        <div className="mt-10 lg:mt-14">
          <JourneyDiagram onOpenStory={onOpenStory} />
        </div>
      </div>
    </Section>
  )
}

/* ---------- história ---------- */

function StorySection({ go, mode, onModeChange }: { go: (id: string) => void; mode: Mode; onModeChange: (m: Mode) => void }) {
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

  return (
    <Section tone="white" flush className="py-6 lg:py-12" aria-label="A história, etapa por etapa">
      <div className="container">
        <JourneyBar rows={rows} activeIndex={activeIndex} onSelect={go} />
        <div className="lg:grid lg:grid-cols-[240px_minmax(0,1fr)] lg:gap-12 xl:grid-cols-[260px_minmax(0,1fr)] xl:gap-16">
          <aside className="hidden lg:block">
            <div className="sticky top-[calc(var(--nav-h)+1.5rem)] max-h-[calc(100vh-var(--nav-h)-3rem)] overflow-y-auto pr-2 [scrollbar-width:thin]">
              <div className="mb-5">
                <ModeSwitch mode={mode} onChange={onModeChange} compact />
              </div>
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
                      {s.n === EFFECTIVATION_AFTER && (
                        <div className="py-10">
                          <EffectivationHub id={EFFECTIVATION_ID} />
                          <VolumeAside className="mt-6" />
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
  )
}

function StepArticle({ step }: { step: JourneyStep }) {
  const mods = step.modules.map((mref) => ({ ...mref, entry: getModuleEntry(mref.slug) })).filter((mref) => mref.entry)
  const when = [step.when.day, step.when.date, step.when.time].filter(Boolean).join(' · ')
  const person = castMember(step.character)
  const actor = actorMeta(step.actor)
  const scene = scenes[step.id]
  return (
    <article id={step.id} data-step={step.id} aria-labelledby={`${step.id}-title`} className="scroll-mt-28 border-t border-brand-mist py-10 first-of-type:border-t-0 lg:py-12">
      <div className="grid grid-cols-1 gap-8 xl:grid-cols-[minmax(0,1fr)_340px] xl:gap-12">
        <div className="min-w-0">
          <Reveal y={10} duration={0.5} className="flex flex-wrap items-center gap-x-2 gap-y-1.5 text-[12px]">
            <span className="rounded-full bg-brand-purple px-2.5 py-0.5 font-bold text-white">Etapa {pad(step.n)}</span>
            <span className="font-semibold uppercase tracking-[0.14em] text-brand-purple">{step.name}</span>
            <span className="text-brand-graphite">{step.official}</span>
          </Reveal>
          <Reveal delay={0.06} className="mt-4 flex flex-wrap items-center gap-x-4 gap-y-2">
            <span className="inline-flex items-center gap-1.5 rounded-lg bg-brand-off-white px-2.5 py-1 text-[12.5px] font-semibold tabular text-brand-graphite">
              <Clock className="h-3.5 w-3.5 text-brand-pink" aria-hidden />
              {when}
            </span>
            <span className="inline-flex items-center gap-2 text-[12.5px] text-brand-graphite">
              <CastAvatar who={step.character} ring className="h-7 w-7 shrink-0" initialsClassName="text-[9px]" />
              <span>
                <span className="font-bold text-brand-ink">{person.name}</span>
                <span className="hidden sm:inline"> · {person.role}</span>
              </span>
              <span className="inline-flex items-center gap-1.5 rounded-full border border-brand-mist px-2 py-0.5 text-[11px] font-semibold uppercase tracking-[0.12em] text-brand-graphite">
                <span aria-hidden className="h-2 w-2 rounded-full" style={{ backgroundColor: actor.color }} />
                {actor.short}
              </span>
            </span>
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
          {scene && (
            <Reveal delay={0.1} className="mb-5">
              <figure className="overflow-hidden rounded-2xl border border-brand-mist bg-brand-off-white shadow-soft">
                <img src={scene} alt={sceneCaptions[step.id] ?? ''} loading="lazy" className="aspect-[4/3] w-full object-cover" />
              </figure>
            </Reveal>
          )}
          <StepVisual visual={step.visual} />
        </div>
      </div>
    </article>
  )
}
