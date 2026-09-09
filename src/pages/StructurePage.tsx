import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router'
import { m } from 'motion/react'
import { ArrowRight, ChevronDown, ChevronRight, Star, Users } from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { FaqAccordion } from '@/components/sections/FaqAccordion'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { PersonasGrid } from '@/components/modules/blocks'
import { ModuleChip } from '@/components/structure/ModuleChip'
import { operatorsIn } from '@/components/structure/operators'
import { OperatorPill, ResponsibilityMap } from '@/components/structure/ResponsibilityMap'
import { ServiceCenterDiagram } from '@/components/structure/ServiceCenterDiagram'
import { getModuleEntry, groups, modulePath, moduleRegistry, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import {
  getStructureEntry,
  loadStructurePage,
  structureIcons,
  structurePath,
  structureRegistry,
  structuresPath,
  type StructureEntry,
  type StructurePage as StructurePageData,
} from '@/content/structures'
import { paths } from '@/content/site'
import { useSeo } from '@/hooks/useSeo'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { ModuleSkeleton } from './ModulePage'
import NotFoundPage from './NotFoundPage'

const CSC_SLUG = 'grupo-rh-central'
const CSC_SENTENCE = 'Por mais empresas e filiais que existam, um único time de RH pode fazer toda a gestão e operação.'

function StructureCard({ entry }: { entry: StructureEntry }) {
  const Icon = structureIcons[entry.icon]
  return (
    <Link
      to={structurePath(entry.slug)}
      className="group flex items-start gap-4 rounded-2xl border border-brand-mist bg-white p-5 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
    >
      <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
        <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
      </span>
      <span className="min-w-0">
        <span className="flex items-center gap-1.5 text-[15px] font-bold text-brand-ink group-hover:text-brand-purple">
          {entry.name}
          <ChevronRight className="h-4 w-4 shrink-0 text-brand-graphite transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
        </span>
        <span className="mt-1 block text-[13.5px] leading-snug text-brand-graphite">{entry.short}</span>
      </span>
    </Link>
  )
}

export default function StructurePage() {
  const { slug = '' } = useParams()
  const entry = getStructureEntry(slug)
  const [loaded, setLoaded] = useState<{ slug: string; page: StructurePageData | null } | null>(null)
  // Conteúdo da estrutura atual; `undefined` enquanto carrega (ou quando o slug mudou).
  const page = loaded && loaded.slug === slug ? loaded.page : undefined

  useEffect(() => {
    let alive = true
    loadStructurePage(slug).then((p) => alive && setLoaded({ slug, page: p }))
    return () => {
      alive = false
    }
  }, [slug])

  const missing = !entry || page === null
  useSeo({
    title: missing ? 'Estrutura não encontrada | Natcorp' : page ? page.seo.title : `${entry.name} | Natcorp`,
    description: missing ? 'Esta estrutura não existe.' : page ? page.seo.description : entry.short,
    path: structurePath(slug),
    noindex: missing,
  })

  if (missing) return <NotFoundPage />
  if (page === undefined) return <ModuleSkeleton />
  return <StructureContent key={slug} entry={entry} page={page} />
}

function StructureContent({ entry, page }: { entry: StructureEntry; page: StructurePageData }) {
  const Icon = structureIcons[entry.icon]
  const related = page.related.map(getStructureEntry).filter((r): r is StructureEntry => Boolean(r))
  const spotlightMods = page.spotlight.map(getModuleEntry).filter((mod): mod is ModuleEntry => Boolean(mod))
  const operators = operatorsIn(page.responsibilities)
  const isCsc = page.slug === CSC_SLUG
  const painCols = page.pains.length === 4 ? 'lg:grid-cols-4' : 'lg:grid-cols-3'
  const stepCols = page.csc.steps.length === 3 ? 'md:grid-cols-3' : 'md:grid-cols-2 lg:grid-cols-4'

  return (
    <PageTransition>
      {/* Abertura */}
      <Section tone="off" className="overflow-hidden pb-16 pt-[calc(var(--nav-h)+2.5rem)] sm:pt-[calc(var(--nav-h)+3.5rem)] lg:pb-24" aria-labelledby="structure-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[36%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Como é a sua estrutura?', to: structuresPath }, { label: entry.label }]} />
          <div className="mt-8 grid grid-cols-1 items-center gap-12 lg:grid-cols-[1.3fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Como é a sua estrutura · {entry.label}</Eyebrow>
              </Reveal>
              <div className="mt-5 flex items-start gap-4">
                <m.span initial={{ opacity: 0, scale: 0.8 }} animate={{ opacity: 1, scale: 1 }} transition={{ duration: 0.6, ease: EASE }} className="mt-1 hidden h-16 w-16 shrink-0 items-center justify-center rounded-2xl bg-brand-gradient text-white shadow-lift sm:flex">
                  <Icon className="h-8 w-8" strokeWidth={1.6} aria-hidden />
                </m.span>
                <SplitText
                  as="h1"
                  id="structure-title"
                  text={page.tagline}
                  className="text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.3rem]"
                  highlightClassName="text-brand-purple"
                />
              </div>
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">{page.summary}</p>
              </Reveal>
              <Reveal delay={0.3}>
                <ul className="mt-6 flex flex-wrap gap-2" aria-label="Como essa estrutura se define">
                  {entry.tags.map((t) => (
                    <li key={t} className="rounded-full border border-brand-mist bg-white px-3 py-1 text-[13px] font-semibold text-brand-ink">
                      {t}
                    </li>
                  ))}
                </ul>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Ver com a estrutura da sua empresa
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to="#fluxo">Ver o fluxo do centro de serviços</Link>
                </Button>
              </Reveal>
            </div>
            <div>
              <Reveal delay={0.35}>
                <p id="facts-title" className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-graphite">
                  Marcas da estrutura
                </p>
              </Reveal>
              <Stagger role="list" aria-labelledby="facts-title" className="mt-3 grid grid-cols-1 gap-3" delay={0.4}>
                {page.facts.map((f) => (
                  <StaggerItem key={f.value} role="listitem" className="flex flex-col gap-1.5 rounded-2xl border border-brand-mist bg-white p-5 shadow-soft sm:flex-row sm:items-center sm:gap-5">
                    <p className="min-w-0 shrink-0 text-2xl font-extrabold leading-tight tracking-brand text-brand-purple sm:text-[1.75rem]">{f.value}</p>
                    <p className="text-[14px] leading-snug text-brand-graphite">{f.label}</p>
                  </StaggerItem>
                ))}
              </Stagger>
            </div>
          </div>
        </div>
      </Section>

      {/* Como o RH costuma funcionar */}
      <Section id="realidade" tone="white" aria-labelledby="realidade-title">
        <div className="container grid grid-cols-1 gap-10 lg:grid-cols-[1.4fr_1fr] lg:gap-16">
          <div>
            <SectionHeader id="realidade-title" eyebrow="Como o RH costuma funcionar" title="O dia a dia do RH [[nessa estrutura]]." />
            <div className="mt-8 space-y-5">
              {page.context.map((par, i) => (
                <Reveal key={i} delay={0.1 + i * 0.06}>
                  <p className="text-[17px] leading-relaxed text-brand-graphite">{par}</p>
                </Reveal>
              ))}
            </div>
          </div>
          <Reveal delay={0.2} className="rounded-3xl border border-brand-mist bg-brand-off-white p-6 sm:p-7">
            <p className="flex items-center gap-2 text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">
              <Users className="h-4 w-4" aria-hidden />
              Quem opera nessa estrutura
            </p>
            <ul className="mt-4 divide-y divide-brand-mist">
              {operators.map((op) => {
                const count = page.responsibilities.filter((r) => r.by === op).length
                return (
                  <li key={op} className="flex items-center justify-between gap-4 py-3">
                    <OperatorPill by={op} />
                    <span className="text-[13.5px] font-semibold text-brand-graphite">
                      {count} {count === 1 ? 'rotina' : 'rotinas'}
                    </span>
                  </li>
                )
              })}
            </ul>
            <Link to="#quem-faz" className="group mt-4 inline-flex items-center gap-1.5 text-[14px] font-semibold text-brand-purple">
              Ver quem faz o quê
              <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>
      </Section>

      {/* Dores */}
      <Section id="dores" tone="off" aria-labelledby="dores-title">
        <div className="container">
          <SectionHeader id="dores-title" eyebrow="As maiores dores" title="O que pesa no RH [[nessa estrutura]]." />
          <Stagger className={cn('mt-12 grid gap-4 sm:grid-cols-2', painCols)} stagger={0.08}>
            {page.pains.map((p) => {
              const PIcon = moduleIcons[p.icon]
              return (
                <StaggerItem key={p.title} className="rounded-2xl border border-brand-mist bg-white p-6">
                  <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-[#FDE4E1] text-[#A63A6A]">
                    <PIcon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <h3 className="mt-4 text-[17px] font-bold leading-snug text-brand-ink">{p.title}</h3>
                  <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{p.text}</p>
                </StaggerItem>
              )
            })}
          </Stagger>
        </div>
      </Section>

      {/* Respostas */}
      <Section id="respostas" tone="white" aria-labelledby="respostas-title">
        <div className="container">
          <SectionHeader id="respostas-title" eyebrow="Como a Natcorp responde" title="Para cada dor, [[os módulos certos]] trabalhando juntos." lead="Uma resposta por dor, na mesma ordem, com os módulos que entram em ação. O dado entra uma vez e vale para todas as empresas e unidades." />
          <ol className="mt-12 space-y-4">
            {page.answers.map((a, i) => (
              <li key={a.title}>
                <Reveal delay={0.05 + i * 0.04} className="grid grid-cols-1 gap-5 rounded-3xl border border-brand-mist bg-white p-6 sm:p-7 lg:grid-cols-[220px_minmax(0,1fr)] lg:gap-10">
                  <div>
                    <span className="inline-flex items-center gap-2 rounded-full bg-[#FDE4E1] px-3 py-1 text-[11px] font-bold uppercase tracking-[0.12em] text-[#A63A6A]">
                      Dor {String(i + 1).padStart(2, '0')}
                    </span>
                    <p className="mt-3 text-[15px] font-bold leading-snug text-brand-ink">{a.pain}</p>
                  </div>
                  <div className="min-w-0">
                    <h3 className="text-xl font-extrabold leading-snug text-brand-ink sm:text-2xl">{a.title}</h3>
                    <p className="mt-3 text-[15.5px] leading-relaxed text-brand-graphite">{a.text}</p>
                    <ul className="mt-4 flex flex-wrap gap-2">
                      {a.modules.map((s) => (
                        <li key={s}>
                          <ModuleChip slug={s} />
                        </li>
                      ))}
                    </ul>
                  </div>
                </Reveal>
              </li>
            ))}
          </ol>
        </div>
      </Section>

      {/* Quem faz o quê */}
      <Section id="quem-faz" tone="off" className="scroll-mt-20" aria-labelledby="quem-faz-title">
        <div className="container">
          <SectionHeader
            id="quem-faz-title"
            eyebrow="Quem faz o quê"
            title="A rotina distribuída entre [[quem opera]]."
            lead="Cada linha diz quem executa, por onde acontece e quais módulos entram. Gestores e colaboradores pedem pelos portais; o RH opera na mesma base; a NATI confere e atende."
          />
          <Reveal delay={0.15} className="mt-12">
            <ResponsibilityMap items={page.responsibilities} />
          </Reveal>
        </div>
      </Section>

      {/* O fluxo do centro de serviços */}
      <Section id="fluxo" tone="dark" className="overflow-hidden scroll-mt-20" aria-labelledby="fluxo-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative">
          <SectionHeader
            id="fluxo-title"
            tone="dark"
            eyebrow="O fluxo do centro de serviços"
            title="O que entra pelos portais [[sai pronto do centro]]."
            lead="À esquerda, o que gestores, colaboradores e candidatos pedem, por origem. No meio, o time que opera tudo na mesma base. À direita, o que sai pronto, por empresa."
          />
          <Reveal delay={0.15} className="mt-12">
            <ServiceCenterDiagram flow={page.flow} />
          </Reveal>
        </div>
      </Section>

      {/* Os módulos nessa estrutura */}
      <Section id="modulos" tone="off" aria-labelledby="modulos-title">
        <div className="container">
          <SectionHeader
            id="modulos-title"
            eyebrow="Os módulos nessa estrutura"
            title="Todos os módulos, [[aplicados à sua estrutura]]."
            lead="Os que mais pesam ficam abertos, com a estrela. Os outros estão a um clique, na ordem dos grupos do sistema, cada um com uma frase sobre como se aplica aqui."
          />
          <ul className="mt-12 grid gap-4 sm:grid-cols-2 xl:grid-cols-3" aria-label="Os módulos que mais pesam nessa estrutura">
            {spotlightMods.map((mod, i) => {
              const MIcon = moduleIcons[mod.icon]
              return (
                <li key={mod.slug}>
                  <Reveal delay={0.05 + i * 0.05} className="h-full">
                    <Link
                      to={modulePath(mod.slug)}
                      className="group flex h-full items-start gap-4 rounded-3xl border border-brand-mist bg-white p-5 shadow-soft transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
                    >
                      <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-gradient text-white">
                        <MIcon className="h-5 w-5" strokeWidth={1.8} aria-hidden />
                      </span>
                      <span className="min-w-0">
                        <span className="flex items-center gap-1.5 text-[16px] font-extrabold text-brand-ink group-hover:text-brand-purple">
                          {mod.name}
                          <Star className="h-3.5 w-3.5 fill-brand-pink text-brand-pink" role="img" aria-label="Peso maior nessa estrutura" />
                        </span>
                        <span className="mt-1.5 block text-[14px] leading-snug text-brand-graphite">{page.moduleNotes[mod.slug]}</span>
                      </span>
                    </Link>
                  </Reveal>
                </li>
              )
            })}
          </ul>

          <details className="group mt-8 rounded-3xl border border-brand-mist bg-white shadow-soft">
            <summary className="flex cursor-pointer list-none items-center justify-between gap-4 rounded-3xl px-6 py-5 text-[16px] font-bold text-brand-ink transition-colors duration-300 hover:bg-brand-off-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple [&::-webkit-details-marker]:hidden">
              <span className="group-open:hidden">Todos os módulos nessa estrutura</span>
              <span className="hidden group-open:inline">Ocultar os módulos</span>
              <ChevronDown className="h-5 w-5 shrink-0 text-brand-purple transition-transform duration-300 group-open:rotate-180" aria-hidden />
            </summary>
            <div className="grid gap-6 border-t border-brand-mist px-6 pb-6 pt-6 md:grid-cols-2 xl:grid-cols-3">
              {groups.map((g) => {
                const mods = moduleRegistry.filter((mod) => mod.group === g.id)
                if (mods.length === 0) return null
                return (
                  <div key={g.id}>
                    <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-purple">{g.name}</p>
                    <ul className="mt-3 divide-y divide-brand-mist">
                      {mods.map((mod) => {
                        const MIcon = moduleIcons[mod.icon]
                        return (
                          <li key={mod.slug} className="py-3">
                            <Link to={modulePath(mod.slug)} className="group/mod flex items-start gap-3">
                              <span className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
                                <MIcon className="h-4 w-4" strokeWidth={1.8} aria-hidden />
                              </span>
                              <span className="min-w-0">
                                <span className="flex items-center gap-1.5 text-[14px] font-bold text-brand-ink group-hover/mod:text-brand-purple">
                                  {mod.name}
                                  {page.spotlight.includes(mod.slug) && <Star className="h-3 w-3 fill-brand-pink text-brand-pink" aria-hidden />}
                                </span>
                                <span className="block text-[13px] leading-snug text-brand-graphite">{page.moduleNotes[mod.slug]}</span>
                              </span>
                            </Link>
                          </li>
                        )
                      })}
                    </ul>
                  </div>
                )
              })}
            </div>
          </details>
        </div>
      </Section>

      {/* Onde isso leva */}
      <Section id="csc" tone="white" aria-labelledby="csc-title">
        <div className="container">
          <SectionHeader id="csc-title" eyebrow="Onde isso leva" title={page.csc.title} lead={page.csc.text} />
          <ol className={cn('mt-12 grid gap-8 md:gap-6', stepCols)}>
            {page.csc.steps.map((s, i) => (
              <li key={s.title} className="relative">
                <Reveal delay={0.1 + i * 0.08}>
                  <div className="flex items-center gap-4">
                    <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-brand-purple text-[15px] font-extrabold text-white shadow-soft">{i + 1}</span>
                    {i < page.csc.steps.length - 1 && <span aria-hidden className="hidden h-px flex-1 bg-brand-mist md:block" />}
                  </div>
                  <h3 className="mt-5 text-[17px] font-extrabold leading-snug text-brand-ink">{s.title}</h3>
                  <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite md:pr-6">{s.text}</p>
                </Reveal>
              </li>
            ))}
          </ol>
          <Reveal delay={0.2} className="on-dark relative mt-12 overflow-hidden rounded-4xl bg-brand-gradient p-8 text-white shadow-lift sm:p-10 lg:p-12">
            <LogoOutline className="pointer-events-none absolute -right-[8%] -top-[60%] h-[220%] w-auto text-white/[0.16]" />
            <div className="relative grid grid-cols-1 gap-8 lg:grid-cols-[1.4fr_auto] lg:items-center">
              <p className="max-w-3xl text-2xl font-extrabold leading-tight tracking-brand sm:text-3xl lg:text-[2.25rem]">{CSC_SENTENCE}</p>
              {isCsc ? (
                <Button asChild size="lg" variant="inverse" className="justify-self-start lg:justify-self-end">
                  <Link to="#contato">
                    Ver com a estrutura da sua empresa
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
              ) : (
                <Button asChild size="lg" variant="inverse" className="justify-self-start lg:justify-self-end">
                  <Link to={structurePath(CSC_SLUG)}>
                    Ver o grupo com RH central
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
              )}
            </div>
          </Reveal>
        </div>
      </Section>

      {/* Para quem */}
      <Section id="para-quem" tone="off" aria-labelledby="personas-title">
        <div className="container">
          <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha [[nessa estrutura]]." />
          <PersonasGrid items={page.personas} />
        </div>
      </Section>

      {/* Perguntas */}
      <Section id="perguntas" tone="white" aria-labelledby="perguntas-title">
        <div className="container grid grid-cols-1 gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div className="lg:sticky lg:top-32 lg:self-start">
            <SectionHeader id="perguntas-title" eyebrow="Perguntas frequentes" title="Dúvidas de quem tem [[essa estrutura]]." />
            <Reveal delay={0.3} className="mt-8 flex flex-col gap-3">
              <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Quer ver com a sua operação? Agende uma demonstração
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
              <Link to={paths.faq} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Ver todas as perguntas frequentes
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
            </Reveal>
          </div>
          <Reveal delay={0.15}>
            <FaqAccordion items={page.faq} />
            <p className="mt-4 px-1 text-[14px] leading-snug text-brand-graphite">
              Implantação, migração, treinamento e suporte, em detalhe:{' '}
              <Link to={paths.implantation} className="group inline-flex items-center gap-1.5 font-semibold text-brand-purple">
                Ver implantação, suporte e serviços
                <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </p>
          </Reveal>
        </div>
      </Section>

      {/* Outras estruturas */}
      <section aria-labelledby="related-title" className="border-t border-brand-mist bg-brand-off-white">
        <div className="container py-12">
          <h2 id="related-title" className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-graphite">
            Outras estruturas
          </h2>
          <div className="mt-5 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {related.map((r) => (
              <StructureCard key={r.slug} entry={r} />
            ))}
            <div className="flex flex-col justify-center gap-3 rounded-2xl border border-dashed border-brand-purple/40 p-5">
              <Link to={structuresPath} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Ver as {structureRegistry.length} estruturas
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
              <Link to={paths.segments} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Ver pelo seu segmento
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </div>
          </div>
        </div>
      </section>

      <CTASection title="Veja a Natcorp com a estrutura da sua empresa." text="Conte como o RH está organizado hoje, com quantas empresas e unidades, e agende uma conversa com quem entende de folha, ponto, eSocial e SESMT de grandes empresas." />
    </PageTransition>
  )
}
