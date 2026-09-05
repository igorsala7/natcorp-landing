import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router'
import { m } from 'motion/react'
import { ArrowLeft, ArrowRight, ArrowUpRight, Check, Sparkles } from 'lucide-react'
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
import { useSeo } from '@/hooks/useSeo'
import { getGroup, getModuleEntry, loadModulePage, moduleRegistry, modulePath, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { ModulePage as ModulePageData } from '@/content/modulePages/types'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'
import NotFoundPage from './NotFoundPage'

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

  return <ModuleContent key={slug} entry={entry} page={page} />
}

function ModuleContent({ entry, page }: { entry: ModuleEntry; page: ModulePageData }) {
  const group = getGroup(entry.group)
  const Icon = moduleIcons[entry.icon]
  const idx = moduleRegistry.findIndex((mod) => mod.slug === entry.slug)
  const prev = moduleRegistry[(idx - 1 + moduleRegistry.length) % moduleRegistry.length]
  const next = moduleRegistry[(idx + 1) % moduleRegistry.length]
  const related = page.related.map(getModuleEntry).filter((r): r is ModuleEntry => Boolean(r))
  const benefitCols = page.benefits.length >= 4 ? 'lg:grid-cols-4' : 'lg:grid-cols-3'

  return (
    <PageTransition>
      {/* Hero */}
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
                <Eyebrow>
                  {group.name} · Módulo
                </Eyebrow>
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

      {/* Benefícios */}
      <Section id="beneficios" tone="white" aria-labelledby="beneficios-title">
        <div className="container">
          <SectionHeader id="beneficios-title" eyebrow="O que muda" title="O que muda para a [[sua empresa]]." />
          <Stagger className={cn('mt-12 grid gap-4 sm:grid-cols-2', benefitCols)}>
            {page.benefits.map((b) => (
              <StaggerItem
                key={b.title}
                className="group rounded-2xl border border-brand-mist p-6 transition-[border-color,box-shadow,transform] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <span className="block h-2 w-2 rotate-45 rounded-[1px] bg-brand-pink" aria-hidden />
                <h3 className="mt-5 text-lg font-bold leading-snug text-brand-ink">{b.title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{b.text}</p>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* Funcionalidades */}
      <Section id="funcionalidades" tone="off" aria-labelledby="funcionalidades-title">
        <div className="container">
          <SectionHeader
            id="funcionalidades-title"
            eyebrow="Funcionalidades"
            title={`O que ${page.name} [[faz]].`}
            lead="Funcionalidades que existem hoje no sistema, descritas na linguagem de quem usa."
          />
          <Stagger className="mt-12 grid gap-4 md:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {page.features.map((f) => {
              const FIcon = moduleIcons[f.icon] ?? Icon
              return (
                <StaggerItem
                  key={f.title}
                  className="group rounded-2xl border border-brand-mist bg-white p-6 transition-[border-color,box-shadow,transform] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
                >
                  <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                    <FIcon className="h-5 w-5" strokeWidth={1.6} />
                  </span>
                  <h3 className="mt-4 text-lg font-bold leading-snug text-brand-ink">{f.title}</h3>
                  <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{f.text}</p>
                </StaggerItem>
              )
            })}
          </Stagger>
        </div>
      </Section>

      {/* Como funciona */}
      {page.flow && page.flow.steps.length >= 3 && (
        <Section id="como-funciona" tone="white" aria-labelledby="fluxo-title">
          <div className="container">
            <SectionHeader id="fluxo-title" eyebrow="Como funciona" title={page.flow.title} />
            <FlowSteps steps={page.flow.steps} />
          </div>
        </Section>
      )}

      {/* Conformidade + conexões */}
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
            <Stagger className={cn('mt-7 grid gap-3 sm:grid-cols-2', !page.compliance?.length && 'text-left')} delay={0.2}>
              {related.map((r) => {
                const RIcon = moduleIcons[r.icon]
                return (
                  <StaggerItem key={r.slug}>
                    <Link
                      to={modulePath(r.slug)}
                      className="group flex h-full items-start gap-3 rounded-xl border border-white/15 bg-white/[0.06] p-4 transition-[background-color,border-color] duration-300 hover:border-white/40 hover:bg-white/[0.12]"
                    >
                      <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white/10 text-[#E4A9C4]">
                        <RIcon className="h-4.5 w-4.5" strokeWidth={1.6} />
                      </span>
                      <span className="min-w-0 flex-1">
                        <span className="flex items-center gap-2 font-bold">
                          {r.name}
                          <ArrowUpRight className="h-4 w-4 text-white/50 transition-transform duration-300 group-hover:translate-x-0.5 group-hover:text-white" aria-hidden />
                        </span>
                        <span className="mt-0.5 block text-[13px] leading-snug text-white/65">{r.short}</span>
                      </span>
                    </Link>
                  </StaggerItem>
                )
              })}
            </Stagger>
          </div>
        </div>
      </Section>

      {/* Para quem */}
      {page.personas && page.personas.length > 0 && (
        <Section id="para-quem" tone="off" aria-labelledby="personas-title">
          <div className="container">
            <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha com [[este módulo]]." />
            <Stagger className="mt-12 grid gap-4 md:grid-cols-3">
              {page.personas.map((p) => (
                <StaggerItem key={p.role} className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
                  <p className="text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{p.role}</p>
                  <p className="mt-3 text-[15px] leading-relaxed text-brand-graphite">{p.text}</p>
                </StaggerItem>
              ))}
            </Stagger>
          </div>
        </Section>
      )}

      {/* Perguntas */}
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

      {/* Anterior / próximo */}
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

const stepCols: Record<number, string> = {
  3: 'lg:grid-cols-3',
  4: 'lg:grid-cols-4',
  5: 'lg:grid-cols-5',
  6: 'lg:grid-cols-6',
}

function FlowSteps({ steps }: { steps: { title: string; text: string }[] }) {
  const n = Math.min(Math.max(steps.length, 3), 6)
  return (
    <ol className={cn('relative mt-12 grid gap-8 md:grid-cols-3', stepCols[n])}>
      <m.span
        aria-hidden
        className="absolute left-5 right-5 top-5 hidden h-px bg-brand-mist lg:block"
        style={{ transformOrigin: 'left' }}
        initial={{ scaleX: 0 }}
        whileInView={{ scaleX: 1 }}
        viewport={viewportOnce}
        transition={{ duration: 1.2, ease: EASE, delay: 0.2 }}
      />
      {steps.map((s, i) => (
        <m.li
          key={s.title}
          className="relative"
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={viewportOnce}
          transition={{ duration: 0.6, ease: EASE, delay: 0.15 + i * 0.12 }}
        >
          <span className="relative z-10 flex h-10 w-10 items-center justify-center rounded-full bg-brand-purple text-sm font-extrabold tabular text-white shadow-[0_0_0_6px_#fff]">
            {i + 1}
          </span>
          <h3 className="mt-4 text-lg font-bold leading-snug text-brand-ink">{s.title}</h3>
          <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{s.text}</p>
        </m.li>
      ))}
    </ol>
  )
}

function PrevNext({ entry, direction }: { entry: ModuleEntry; direction: 'prev' | 'next' }) {
  const Icon = moduleIcons[entry.icon]
  const isNext = direction === 'next'
  return (
    <Link
      to={modulePath(entry.slug)}
      className={cn(
        'group flex items-center gap-4 rounded-2xl border border-brand-mist p-4 transition-[border-color,background-color] duration-300 hover:border-brand-purple/30 hover:bg-brand-off-white',
        isNext && 'sm:flex-row-reverse sm:text-right',
      )}
    >
      <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple transition-colors group-hover:bg-white">
        {isNext ? <ArrowRight className="h-5 w-5" /> : <ArrowLeft className="h-5 w-5" />}
      </span>
      <span className="min-w-0 flex-1">
        <span className="block text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">{isNext ? 'Próximo módulo' : 'Módulo anterior'}</span>
        <span className="mt-0.5 flex items-center gap-2 font-bold text-brand-ink" style={{ justifyContent: isNext ? 'flex-end' : 'flex-start' }}>
          <Icon className="h-4 w-4 text-brand-purple" strokeWidth={1.6} aria-hidden />
          {entry.name}
        </span>
      </span>
    </Link>
  )
}

function ModuleSkeleton() {
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
