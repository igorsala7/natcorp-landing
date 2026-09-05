import { useEffect, useState, type ReactNode } from 'react'
import { Link, useParams } from 'react-router'
import { m } from 'motion/react'
import { ArrowRight, Check, ChevronRight, ShieldCheck, Star } from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { FaqAccordion } from '@/components/sections/FaqAccordion'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { PersonasGrid } from '@/components/modules/blocks'
import { OperatorPanel, PANEL_SIZE } from '@/components/mockups/nati/OperatorPanel'
import { WhatsAppMockup } from '@/components/mockups/nati/WhatsAppMockup'
import { DevicesShowcase } from '@/components/mockups/DevicesShowcase'
import { ANALYTICS_SIZE } from '@/components/mockups/analytics/shell'
import { MedicineIndicators } from '@/components/mockups/analytics/MedicineIndicators'
import { FinancialComparison } from '@/components/mockups/analytics/FinancialComparison'
import { RecruitmentModal } from '@/components/mockups/analytics/RecruitmentModal'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { getModuleEntry, groups, modulePath, moduleRegistry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { getSegmentEntry, loadSegmentPage, segmentIcons, segmentPath, segmentRegistry, segmentsPath, type SegmentEntry } from '@/content/segments'
import type { SegmentPage as SegmentPageData, SegmentVisual } from '@/content/segments/types'
import { useSeo } from '@/hooks/useSeo'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { ModuleSkeleton } from './ModulePage'
import NotFoundPage from './NotFoundPage'

const visualLabels: Record<SegmentVisual, string> = {
  natponto: 'Telas do NatPonto: reconhecimento facial e comprovante da marcação com geolocalização',
  operator: 'Painel do Operador com os indicadores demográficos por empresa, filial, centro de custo, local, unidade e cargo',
  medicine: 'Painel do Operador com os indicadores de Medicina Ocupacional',
  financial: 'Comparativo de históricos financeiros entre dois períodos, em gráfico de barras',
  devices: 'O sistema no notebook, no tablet e no celular',
  whatsapp: 'Conversa com a NATI no WhatsApp: holerite em PDF e dados de férias',
  recruitment: 'Gráfico de candidatos por cargo gerado a partir da listagem de Recrutamento e Seleção',
}

function Visual({ kind }: { kind: SegmentVisual }) {
  const frame = 'rounded-2xl border border-brand-mist bg-white p-2 shadow-lift sm:p-3'
  switch (kind) {
    case 'natponto':
      return (
        <div className="mx-auto grid max-w-[520px] grid-cols-2 gap-4">
          <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height}>
            <NatPontoPhone screen="face" />
          </ScaledFrame>
          <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height}>
            <NatPontoPhone screen="receipt" />
          </ScaledFrame>
        </div>
      )
    case 'operator':
      return (
        <div className={frame}>
          <ScaledFrame width={PANEL_SIZE.desktop.width} height={PANEL_SIZE.desktop.height}>
            <OperatorPanel layout="desktop" />
          </ScaledFrame>
        </div>
      )
    case 'medicine':
      return (
        <div className={frame}>
          <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
            <MedicineIndicators />
          </ScaledFrame>
        </div>
      )
    case 'financial':
      return (
        <div className={frame}>
          <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
            <FinancialComparison mode="chart" />
          </ScaledFrame>
        </div>
      )
    case 'recruitment':
      return (
        <div className={frame}>
          <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
            <RecruitmentModal />
          </ScaledFrame>
        </div>
      )
    case 'whatsapp':
      return (
        <div className="mx-auto w-full max-w-[300px]">
          <WhatsAppMockup className="w-full" />
        </div>
      )
    case 'devices':
      return <DevicesShowcase />
  }
}

function ModuleChip({ slug }: { slug: string }) {
  const entry = getModuleEntry(slug)
  if (!entry) return null
  const Icon = moduleIcons[entry.icon]
  return (
    <Link
      to={modulePath(slug)}
      className="group inline-flex items-center gap-2 rounded-xl border border-brand-mist bg-white py-1.5 pl-2 pr-3 text-[13px] font-bold text-brand-ink transition-[border-color,box-shadow,transform] duration-300 ease-brand hover:-translate-y-0.5 hover:border-brand-purple/40 hover:shadow-soft"
    >
      <span className="flex h-7 w-7 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
        <Icon className="h-3.5 w-3.5" strokeWidth={1.8} aria-hidden />
      </span>
      {entry.name}
    </Link>
  )
}

function SegmentCard({ entry }: { entry: SegmentEntry }) {
  const Icon = segmentIcons[entry.icon]
  return (
    <Link
      to={segmentPath(entry.slug)}
      className="group flex items-start gap-4 rounded-2xl border border-brand-mist bg-white p-5 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
    >
      <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
        <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
      </span>
      <span className="min-w-0">
        <span className="flex items-center gap-1.5 text-[15px] font-bold text-brand-ink group-hover:text-brand-purple">
          {entry.label}
          <ChevronRight className="h-4 w-4 text-brand-gray transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
        </span>
        <span className="mt-1 block text-[13.5px] leading-snug text-brand-graphite">{entry.short}</span>
      </span>
    </Link>
  )
}

export default function SegmentPage() {
  const { slug = '' } = useParams()
  const entry = getSegmentEntry(slug)
  const [loaded, setLoaded] = useState<{ slug: string; page: SegmentPageData | null } | null>(null)
  // Conteúdo do segmento atual; `undefined` enquanto carrega (ou quando o slug mudou).
  const page = loaded && loaded.slug === slug ? loaded.page : undefined

  useEffect(() => {
    let alive = true
    loadSegmentPage(slug).then((p) => alive && setLoaded({ slug, page: p }))
    return () => {
      alive = false
    }
  }, [slug])

  const missing = !entry || page === null
  useSeo({
    title: missing ? 'Segmento não encontrado | Natcorp' : page ? page.seo.title : `${entry.label} | Natcorp`,
    description: missing ? 'Este segmento não existe.' : page ? page.seo.description : entry.short,
    path: segmentPath(slug),
    noindex: missing,
  })

  if (missing) return <NotFoundPage />
  if (page === undefined) return <ModuleSkeleton />
  return <SegmentContent key={slug} entry={entry} page={page} />
}

function SegmentContent({ entry, page }: { entry: SegmentEntry; page: SegmentPageData }) {
  const Icon = segmentIcons[entry.icon]
  const related = page.related.map(getSegmentEntry).filter((r): r is SegmentEntry => Boolean(r))
  const spotlight = new Set(page.spotlight)

  return (
    <PageTransition>
      {/* Abertura */}
      <Section tone="off" className="overflow-hidden pb-16 pt-[calc(var(--nav-h)+2.5rem)] sm:pt-[calc(var(--nav-h)+3.5rem)] lg:pb-24" aria-labelledby="segment-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[36%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Segmentos', to: segmentsPath }, { label: entry.label }]} />
          <div className="mt-8 grid grid-cols-1 items-center gap-12 lg:grid-cols-[1.1fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Segmentos · {entry.label}</Eyebrow>
              </Reveal>
              <div className="mt-5 flex items-start gap-4">
                <m.span initial={{ opacity: 0, scale: 0.8 }} animate={{ opacity: 1, scale: 1 }} transition={{ duration: 0.6, ease: EASE }} className="mt-1 hidden h-16 w-16 shrink-0 items-center justify-center rounded-2xl bg-brand-gradient text-white shadow-lift sm:flex">
                  <Icon className="h-8 w-8" strokeWidth={1.6} aria-hidden />
                </m.span>
                <SplitText
                  as="h1"
                  id="segment-title"
                  text={page.tagline}
                  className="text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.3rem]"
                  highlightClassName="text-brand-purple"
                />
              </div>
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
                  <Link to="#modulos">Ver o paralelo com os módulos</Link>
                </Button>
              </Reveal>
              <Stagger className="mt-10 grid grid-cols-1 gap-3 sm:grid-cols-3" delay={0.4}>
                {page.facts.map((f) => (
                  <StaggerItem key={f.value} className="rounded-2xl border border-brand-mist bg-white p-4">
                    <p className="text-lg font-extrabold leading-tight tracking-brand text-brand-purple">{f.value}</p>
                    <p className="mt-1 text-[13px] leading-snug text-brand-graphite">{f.label}</p>
                  </StaggerItem>
                ))}
              </Stagger>
            </div>
            <m.div initial={{ opacity: 0, y: 28 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.9, ease: EASE, delay: 0.25 }} className="relative min-w-0">
              <div aria-hidden className="pointer-events-none absolute -inset-6 rounded-[2rem] bg-[radial-gradient(60%_60%_at_50%_40%,rgba(154,64,138,0.18),transparent_70%)]" />
              <div role="img" aria-label={visualLabels[page.visual]} className="relative">
                <Visual kind={page.visual} />
              </div>
            </m.div>
          </div>
        </div>
      </Section>

      {/* A realidade */}
      <Section id="realidade" tone="white" aria-labelledby="realidade-title">
        <div className="container grid grid-cols-1 gap-10 lg:grid-cols-[1.4fr_1fr] lg:gap-16">
          <div>
            <SectionHeader id="realidade-title" eyebrow="A realidade do segmento" title="Como é o RH [[neste segmento]]." />
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
              <ShieldCheck className="h-4 w-4" aria-hidden />
              Normas e obrigações típicas
            </p>
            <ul className="mt-4 space-y-3">
              {page.compliance.map((c) => (
                <li key={c} className="flex items-start gap-3 text-[15px] leading-snug text-brand-ink">
                  <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                    <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                  </span>
                  {c}
                </li>
              ))}
            </ul>
          </Reveal>
        </div>
      </Section>

      {/* Dores */}
      <Section id="dores" tone="off" aria-labelledby="dores-title">
        <div className="container">
          <SectionHeader id="dores-title" eyebrow="As maiores dores" title="O que tira o sono do RH [[neste segmento]]." />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.08}>
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
          <SectionHeader id="respostas-title" eyebrow="Como a Natcorp responde" title="Para cada dor, [[os módulos certos]] trabalhando juntos." lead="Uma resposta por dor, na mesma ordem, com os módulos que entram em ação. O dado entra uma vez e vale para todos." />
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

      {/* Paralelo com todos os módulos */}
      <Section id="modulos" tone="dark" className="overflow-hidden" aria-labelledby="modulos-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative">
          <SectionHeader
            id="modulos-title"
            tone="dark"
            eyebrow="O paralelo com todos os módulos"
            title={`Os ${moduleRegistry.length} módulos, [[aplicados a este segmento]].`}
            lead="Como cada módulo se aplica à realidade deste segmento. Os marcados com estrela são os que mais pesam aqui."
          />
          <div className="mt-12 grid gap-5 md:grid-cols-2 xl:grid-cols-3">
            {groups.map((g) => {
              const mods = moduleRegistry.filter((mod) => mod.group === g.id)
              return (
                <Reveal key={g.id} delay={0.05} className="rounded-3xl border border-white/10 bg-white/[0.05] p-5">
                  <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">{g.name}</p>
                  <ul className="mt-3 divide-y divide-white/10">
                    {mods.map((mod) => {
                      const MIcon = moduleIcons[mod.icon]
                      const hot = spotlight.has(mod.slug)
                      return (
                        <li key={mod.slug} className="py-3">
                          <Link to={modulePath(mod.slug)} className={cn('group flex items-start gap-3', hot && 'relative')}>
                            <span className={cn('mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded-lg', hot ? 'bg-[#E4A9C4] text-brand-blue' : 'bg-white/10 text-white')}>
                              <MIcon className="h-4 w-4" strokeWidth={1.8} aria-hidden />
                            </span>
                            <span className="min-w-0">
                              <span className="flex items-center gap-1.5 text-[14px] font-bold text-white group-hover:underline group-hover:underline-offset-4">
                                {mod.name}
                                {hot && <Star className="h-3.5 w-3.5 fill-[#E4A9C4] text-[#E4A9C4]" aria-label="Peso maior neste segmento" />}
                              </span>
                              <span className="block text-[13px] leading-snug text-white/75">{page.moduleNotes[mod.slug]}</span>
                            </span>
                          </Link>
                        </li>
                      )
                    })}
                  </ul>
                </Reveal>
              )
            })}
          </div>
        </div>
      </Section>

      <Section id="para-quem" tone="off" aria-labelledby="personas-title">
        <div className="container">
          <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha [[neste segmento]]." />
          <PersonasGrid items={page.personas} />
        </div>
      </Section>

      <Section id="perguntas" tone="white" aria-labelledby="perguntas-title">
        <div className="container grid grid-cols-1 gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div className="lg:sticky lg:top-32 lg:self-start">
            <SectionHeader id="perguntas-title" eyebrow="Perguntas frequentes" title="Dúvidas sobre a Natcorp [[neste segmento]]." />
            <Reveal delay={0.3} className="mt-8">
              <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Quer ver com a sua operação? Agende uma demonstração
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
            </Reveal>
          </div>
          <Reveal delay={0.15}>
            <FaqAccordion items={page.faq} />
          </Reveal>
        </div>
      </Section>

      {related.length > 0 && (
        <section aria-labelledby="related-title" className="border-t border-brand-mist bg-brand-off-white">
          <div className="container py-12">
            <h2 id="related-title" className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-graphite">
              Segmentos parecidos
            </h2>
            <div className="mt-5 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {related.map((r) => (
                <SegmentCard key={r.slug} entry={r} />
              ))}
              <Link to={segmentsPath} className="group flex items-center justify-center gap-2 rounded-2xl border border-dashed border-brand-purple/40 p-5 text-[15px] font-semibold text-brand-purple transition-colors hover:bg-white">
                Ver todos os {segmentRegistry.length} segmentos
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </div>
          </div>
        </section>
      )}

      <CTASection title={`Veja a Natcorp com a realidade da sua operação em ${entry.name}.`} />
    </PageTransition>
  )
}

export function SegmentCards({ className, children }: { className?: string; children?: ReactNode }) {
  return (
    <div className={cn('grid gap-4 sm:grid-cols-2 lg:grid-cols-3', className)}>
      {segmentRegistry.map((s) => (
        <SegmentCard key={s.slug} entry={s} />
      ))}
      {children}
    </div>
  )
}
