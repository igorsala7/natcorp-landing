import { Suspense, lazy, useEffect, useState } from 'react'
import { Link, useParams } from 'react-router'
import { m } from 'motion/react'
import { ArrowRight, Check, Sparkles } from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { FaqAccordion } from '@/components/sections/FaqAccordion'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Parallax } from '@/components/motion/Parallax'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { Logo, LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { BenefitsGrid, FeaturesGrid, FlowSteps, PersonasGrid, PrevNext, RelatedModules } from '@/components/modules/blocks'
import { ResponsiveSection } from '@/components/sections/ResponsiveSection'
import { useSeo } from '@/hooks/useSeo'
import { getGroup, getModuleEntry, loadModulePage, moduleRegistry, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { ModulePage as ModulePageData } from '@/content/modulePages/types'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'
import NotFoundPage from './NotFoundPage'

const NatiModulePage = lazy(() => import('./NatiModulePage'))

interface Loaded {
  slug: string
  page: ModulePageData | null
}

export default function ModulePage() {
  const { slug = '' } = useParams()
  const entry = getModuleEntry(slug)
  const [loaded, setLoaded] = useState<Loaded | null>(null)

  useEffect(() => {
    let alive = true
    loadModulePage(slug).then((page) => {
      if (alive) setLoaded({ slug, page })
    })
    return () => {
      alive = false
    }
  }, [slug])

  const page = loaded?.slug === slug ? loaded.page : undefined
  const missing = !entry || page === null
  useSeo({
    title: missing ? 'Página não encontrada | Natcorp' : (page?.seo.title ?? `${entry.name} | Natcorp`),
    description: missing ? 'O módulo que você procura não existe.' : (page?.seo.description ?? entry.short),
    path: missing ? '/404' : `/modulos/${slug}`,
    noindex: missing,
  })

  if (!entry || page === null) return <NotFoundPage />
  if (page === undefined) return <ModuleSkeleton />
  if (entry.slug === 'nati') {
    return (
      <Suspense fallback={<ModuleSkeleton />}>
        <NatiModulePage entry={entry} page={page} />
      </Suspense>
    )
  }

  return <ModuleContent key={slug} entry={entry} page={page} />
}

export function moduleNeighbors(slug: string) {
  const idx = moduleRegistry.findIndex((mod) => mod.slug === slug)
  return {
    prev: moduleRegistry[(idx - 1 + moduleRegistry.length) % moduleRegistry.length],
    next: moduleRegistry[(idx + 1) % moduleRegistry.length],
  }
}

function ModuleContent({ entry, page }: { entry: ModuleEntry; page: ModulePageData }) {
  const group = getGroup(entry.group)
  const { prev, next } = moduleNeighbors(entry.slug)
  const related = page.related.map(getModuleEntry).filter((r): r is ModuleEntry => Boolean(r))

  return (
    <PageTransition>
      <Section
        tone="off"
        className="overflow-hidden pb-16 pt-[calc(var(--nav-h)+2.5rem)] sm:pt-[calc(var(--nav-h)+3.5rem)] lg:pb-24"
        aria-labelledby="module-title"
      >
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[36%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb
            items={[
              { label: 'Início', to: '/' },
              { label: 'Módulos', to: '/modulos' },
              { label: group.name, to: `/modulos#${group.id}` },
              { label: page.name },
            ]}
          />
          <div className="mt-8 grid items-center gap-12 lg:grid-cols-[1.1fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>{group.name} · Módulo</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="module-title"
                text={page.tagline}
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.5rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-xl text-lg leading-relaxed text-brand-graphite sm:text-xl">{page.summary}</p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to="#funcionalidades">Ver funcionalidades</Link>
                </Button>
              </Reveal>
              {page.highlights.length > 0 && (
                <Stagger className="mt-10 grid grid-cols-2 gap-x-6 gap-y-6 sm:grid-cols-3" delay={0.4}>
                  {page.highlights.slice(0, 3).map((h) => (
                    <StaggerItem key={h.label}>
                      <p className="text-3xl font-extrabold tracking-brand text-brand-purple sm:text-4xl">{h.value}</p>
                      <p className="mt-1 max-w-[14rem] text-sm leading-snug text-brand-graphite">{h.label}</p>
                    </StaggerItem>
                  ))}
                </Stagger>
              )}
            </div>

            <Parallax distance={22}>
              <HeroCard entry={entry} page={page} groupName={group.name} />
            </Parallax>
          </div>
        </div>
      </Section>

      <Section id="beneficios" tone="white" aria-labelledby="beneficios-title">
        <div className="container">
          <SectionHeader id="beneficios-title" eyebrow="O que muda" title="O que muda para a [[sua empresa]]." />
          <BenefitsGrid items={page.benefits} />
        </div>
      </Section>

      {entry.slug === 'infraestrutura-e-seguranca' && <ResponsiveSection id="multiplataforma" tone="off" eyebrow="Multiplataforma" />}

      <Section id="funcionalidades" tone={entry.slug === 'infraestrutura-e-seguranca' ? 'white' : 'off'} aria-labelledby="funcionalidades-title">
        <div className="container">
          <SectionHeader
            id="funcionalidades-title"
            eyebrow="Funcionalidades"
            title={`O que ${page.name} [[faz]].`}
            lead="Funcionalidades que existem hoje no sistema, descritas na linguagem de quem usa."
          />
          <FeaturesGrid items={page.features} />
        </div>
      </Section>

      {page.flow && page.flow.steps.length >= 3 && (
        <Section id="como-funciona" tone="white" aria-labelledby="fluxo-title">
          <div className="container">
            <SectionHeader id="fluxo-title" eyebrow="Como funciona" title={page.flow.title} />
            <FlowSteps steps={page.flow.steps} />
          </div>
        </Section>
      )}

      <Section id="conformidade" tone="dark" className="overflow-hidden" aria-labelledby="conexoes-title">
        <LogoOutline className="pointer-events-none absolute -bottom-[45%] -left-[14%] h-[130%] w-auto text-white/[0.1]" />
        <div className={cn('container relative grid gap-12', page.compliance?.length ? 'lg:grid-cols-2 lg:gap-16' : '')}>
          {page.compliance && page.compliance.length > 0 && (
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow tone="white">Conformidade</Eyebrow>
              </Reveal>
              <Reveal delay={0.08}>
                <h2 className="mt-4 text-3xl font-extrabold leading-tight sm:text-4xl">Feito para a regra brasileira.</h2>
              </Reveal>
              <Reveal delay={0.16}>
                <p className="mt-4 max-w-md text-[17px] leading-relaxed text-white/75">
                  Obrigações e normas que este módulo já atende, sem configuração extra.
                </p>
              </Reveal>
              <Stagger className="mt-7 flex flex-wrap gap-2" delay={0.2} stagger={0.05}>
                {page.compliance.map((c) => (
                  <StaggerItem key={c} className="rounded-full border border-white/20 bg-white/[0.07] px-3.5 py-1.5 text-[13.5px] font-semibold backdrop-blur-sm">
                    {c}
                  </StaggerItem>
                ))}
              </Stagger>
            </div>
          )}

          <div className={cn(!page.compliance?.length && 'mx-auto max-w-3xl text-center')}>
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white" className={cn(!page.compliance?.length && 'justify-center')}>
                Conecta com
              </Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="conexoes-title" className="mt-4 text-3xl font-extrabold leading-tight sm:text-4xl">
                A mesma base de todos os outros módulos.
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className={cn('mt-4 text-[17px] leading-relaxed text-white/75', page.compliance?.length ? 'max-w-md' : 'mx-auto max-w-2xl')}>
                Os dados de {page.name} alimentam e são alimentados por:
              </p>
            </Reveal>
            <RelatedModules items={related} />
          </div>
        </div>
      </Section>

      {page.personas && page.personas.length > 0 && (
        <Section id="para-quem" tone="off" aria-labelledby="personas-title">
          <div className="container">
            <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha com [[este módulo]]." />
            <PersonasGrid items={page.personas} />
          </div>
        </Section>
      )}

      <Section id="perguntas" tone="white" aria-labelledby="perguntas-title">
        <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div className="lg:sticky lg:top-32 lg:self-start">
            <SectionHeader id="perguntas-title" eyebrow="Perguntas frequentes" title={`Dúvidas sobre [[${page.name}]].`} />
            <Reveal delay={0.3} className="mt-8">
              <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Quer ver na prática? Agende uma demonstração
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
            </Reveal>
          </div>
          <Reveal delay={0.15}>
            <FaqAccordion items={page.faq} />
          </Reveal>
        </div>
      </Section>

      <nav aria-label="Outros módulos" className="border-t border-brand-mist bg-white">
        <div className="container grid gap-3 py-8 sm:grid-cols-2">
          <PrevNext entry={prev} direction="prev" />
          <PrevNext entry={next} direction="next" />
        </div>
      </nav>

      <CTASection title={`Veja ${page.name} funcionando com os dados da sua empresa.`} />
    </PageTransition>
  )
}

function HeroCard({ entry, page, groupName }: { entry: ModuleEntry; page: ModulePageData; groupName: string }) {
  const Icon = moduleIcons[entry.icon]
  const feats = page.features.slice(0, 4)
  const hl = page.highlights.slice(0, 2)
  return (
    <div className="relative mx-auto max-w-md lg:max-w-none">
      <div aria-hidden className="pointer-events-none absolute -inset-6 rounded-[2rem] bg-[radial-gradient(60%_60%_at_50%_50%,rgba(154,64,138,0.18),transparent_70%)]" />
      <m.div
        className="relative overflow-hidden rounded-2xl border border-brand-mist bg-white shadow-lift"
        initial={{ opacity: 0, y: 28, scale: 0.98 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        transition={{ duration: 0.9, ease: EASE, delay: 0.25 }}
        role="img"
        aria-label={`${entry.name}: ${feats.map((f) => f.title).join(', ')}`}
      >
        <div className="flex items-center justify-between bg-brand-blue px-4 py-2.5 text-white">
          <span className="flex items-center gap-2 text-[11px] font-semibold uppercase tracking-[0.14em] text-white/70">
            <Logo variant="symbol" tone="white" className="h-3.5 w-3.5" decorative />
            Módulo · {groupName}
          </span>
          <span className="flex items-center gap-1.5 text-[11px] font-semibold text-emerald-300">
            <span className="h-1.5 w-1.5 rounded-full bg-emerald-400 animate-pulse-soft" aria-hidden />
            Ativo
          </span>
        </div>
        <div className="p-5 sm:p-6">
          <div className="flex items-start gap-4">
            <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-brand-gradient text-white">
              <Icon className="h-6 w-6" strokeWidth={1.6} />
            </span>
            <div className="min-w-0">
              <p className="text-lg font-extrabold leading-tight text-brand-ink">{entry.name}</p>
              <p className="mt-1 text-[13px] leading-snug text-brand-graphite">{entry.short}</p>
            </div>
          </div>

          <m.ul
            className="mt-5 divide-y divide-brand-mist border-y border-brand-mist"
            initial="hidden"
            animate="visible"
            variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.14, delayChildren: 0.7 } } }}
          >
            {feats.map((f) => (
              <m.li
                key={f.title}
                className="flex items-center gap-3 py-2.5 text-[13.5px] font-medium text-brand-ink"
                variants={{ hidden: { opacity: 0, x: -10 }, visible: { opacity: 1, x: 0, transition: { duration: 0.5, ease: EASE } } }}
              >
                <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple text-white">
                  <Check className="h-3 w-3" strokeWidth={3} />
                </span>
                {f.title}
              </m.li>
            ))}
          </m.ul>

          {hl.length > 0 ? (
            <div className={cn('mt-4 grid gap-2', hl.length > 1 ? 'grid-cols-2' : 'grid-cols-1')}>
              {hl.map((h) => (
                <div key={h.label} className="rounded-lg bg-brand-off-white/70 p-3">
                  <p className="text-[16px] font-extrabold tabular tracking-brand text-brand-purple">{h.value}</p>
                  <p className="mt-0.5 text-[11px] leading-snug text-brand-graphite">{h.label}</p>
                </div>
              ))}
            </div>
          ) : (
            <div className="mt-4 flex items-start gap-2 rounded-lg border border-brand-purple/20 bg-brand-off-white/70 p-3 text-[12px] leading-snug text-brand-graphite">
              <Sparkles className="mt-0.5 h-3.5 w-3.5 shrink-0 text-brand-purple" strokeWidth={1.8} />
              A NATI acompanha este módulo com análise, diagnóstico, pontos de atenção e sugestão.
            </div>
          )}
        </div>
      </m.div>
    </div>
  )
}

export function ModuleSkeleton() {
  return (
    <div className="bg-brand-off-white pb-16 pt-[calc(var(--nav-h)+3.5rem)]" aria-busy="true" aria-live="polite">
      <div className="container animate-pulse-soft">
        <div className="h-3 w-56 rounded bg-brand-mist" />
        <div className="mt-10 grid gap-12 lg:grid-cols-[1.1fr_1fr]">
          <div className="space-y-4">
            <div className="h-3 w-40 rounded bg-brand-mist" />
            <div className="h-12 w-3/4 rounded bg-brand-mist" />
            <div className="h-12 w-1/2 rounded bg-brand-mist" />
            <div className="mt-6 h-4 w-full rounded bg-brand-mist" />
            <div className="h-4 w-5/6 rounded bg-brand-mist" />
          </div>
          <div className="h-80 rounded-2xl bg-white" />
        </div>
      </div>
    </div>
  )
}
