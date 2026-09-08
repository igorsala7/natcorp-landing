import type { ReactNode } from 'react'
import { ArrowUpRight } from 'lucide-react'
import { getModuleEntry, groups, moduleRegistry, modulesByGroup, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { ModulePage } from '@/content/modulePages/types'
import { categoryMeta } from '@/content/moduleCategories'
import { modulosCatalogo } from '@/content/presentation'
import { cn } from '@/lib/utils'
import { getModulePage, useOpenModule } from '../moduleData'
import { Big, Card, Chip, IconBox, Item, Marked, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta } from '../Slide'

/**
 * A página de um módulo dentro da apresentação: o que ele faz, como funciona o processo,
 * os números e a conformidade. É o conteúdo que a plateia pede quando quer descer ao detalhe
 * ("como funciona a folha?", "e os benefícios?"). Abre por cima da apresentação ao clicar em
 * qualquer módulo e volta para o slide de onde saiu.
 */

function Label({ children, className }: { children: ReactNode; className?: string }) {
  return (
    <p className={cn('text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.16em] text-brand-purple', className)}>{children}</p>
  )
}

interface ModuleBodyProps {
  page: ModulePage
  entry: ModuleEntry
  /** Abre outro módulo (os relacionados). Sem isso, os relacionados viram etiquetas. */
  onOpen?: (slug: string) => void
  /** Cabeçalho compacto: o nome do módulo já está na barra da página aberta. */
  headless?: boolean
}

export function ModuleBody({ page, entry, onOpen, headless = false }: ModuleBodyProps) {
  const group = groups.find((g) => g.id === entry.group)!
  const Icon = moduleIcons[entry.icon]
  const highlights = page.highlights.slice(0, 3)
  const features = page.features.slice(0, 8)
  const compliance = (page.compliance ?? []).slice(0, 3)
  const related = page.related.slice(0, 4)
  const steps = page.flow ? page.flow.steps.slice(0, 6) : page.benefits.slice(0, 4).map((b) => ({ title: b.title, text: b.text }))
  const stepsTitle = page.flow?.title ?? 'O que muda com ele'

  return (
    <div>
      {!headless && (
        <Rise y={8} className="flex flex-wrap items-center gap-2">
          <Chip tone="purple">
            <Icon className="h-[1.1em] w-[1.1em]" strokeWidth={1.9} aria-hidden />
            {group.name}
          </Chip>
          {page.personas?.slice(0, 2).map((p) => <Chip key={p.role}>{p.role}</Chip>)}
        </Rise>
      )}
      <SlideTitle text={page.name} className={cn('text-[length:calc(var(--dk-h2)*0.8)]', headless ? '' : 'mt-3')} />
      <Rise delay={0.2} y={12}>
        <p className="mt-2 max-w-[48rem] text-[length:var(--dk-lead)] leading-relaxed text-brand-graphite">
          <Marked text={page.tagline} />
        </p>
      </Rise>

      <div className="mt-[clamp(0.9rem,2.6vh,1.75rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[1.02fr_0.98fr]">
        <div>
          <Label>{stepsTitle}</Label>
          <Stagger as="ol" className="mt-2.5 space-y-[clamp(0.4rem,1.1vh,0.7rem)]" delay={0.3} stagger={0.06}>
            {steps.map((s, i) => (
              <Item as="li" key={s.title} className="flex gap-3">
                <span className="mt-[0.1em] flex h-[1.8em] w-[1.8em] shrink-0 items-center justify-center rounded-full bg-brand-purple/[0.08] text-[length:var(--dk-small)] font-bold tabular text-brand-purple">
                  {i + 1}
                </span>
                <span className="min-w-0">
                  <span className="block text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">{s.title}</span>
                  <span className="mt-0.5 block text-[length:var(--dk-small)] leading-snug text-brand-graphite">{s.text}</span>
                </span>
              </Item>
            ))}
          </Stagger>
        </div>

        <div>
          {highlights.length > 0 && (
            <Stagger className="grid grid-cols-3 gap-3" delay={0.35}>
              {highlights.map((h, i) => (
                <Item key={h.label}>
                  <Big size="md" value={h.value} label={h.label} accent={i === 0 ? 'pink' : 'purple'} />
                </Item>
              ))}
            </Stagger>
          )}
          <Label className={highlights.length > 0 ? 'mt-[clamp(0.9rem,2.6vh,1.6rem)]' : undefined}>O que faz</Label>
          <Stagger as="ul" className="mt-2.5 grid gap-x-5 gap-y-[clamp(0.3rem,0.9vh,0.55rem)] sm:grid-cols-2" delay={0.4} stagger={0.04}>
            {features.map((f) => {
              const FIcon = moduleIcons[f.icon]
              return (
                <Item as="li" key={f.title} className="flex items-start gap-2">
                  <FIcon className="mt-[0.15em] h-[1.15em] w-[1.15em] shrink-0 text-brand-purple" strokeWidth={1.9} aria-hidden />
                  <span className="text-[length:var(--dk-small)] font-semibold leading-snug text-brand-ink">{f.title}</span>
                </Item>
              )
            })}
          </Stagger>
          {compliance.length > 0 && (
            <Rise delay={0.5} y={10} className="mt-[clamp(0.75rem,2.2vh,1.35rem)]">
              <Label>Conformidade</Label>
              <div className="mt-2 flex flex-wrap gap-1.5">
                {compliance.map((c) => (
                  <Chip key={c}>{c}</Chip>
                ))}
              </div>
            </Rise>
          )}
        </div>
      </div>

      {related.length > 0 && (
        <Rise delay={0.55} y={10} className="mt-[clamp(0.85rem,2.4vh,1.5rem)] flex flex-wrap items-center gap-2 border-t border-brand-mist pt-3">
          <span className="text-[length:var(--dk-small)] font-semibold uppercase tracking-[0.12em] text-brand-gray">Conecta com</span>
          {related.map((slug) => {
            const e = getModuleEntry(slug)
            if (!e) return null
            const RIcon = moduleIcons[e.icon]
            const chip = (
              <Chip tone="purple" className={onOpen ? 'transition-colors group-hover:border-brand-purple/50 group-hover:bg-brand-purple/[0.12]' : undefined}>
                <RIcon className="h-[1.1em] w-[1.1em]" strokeWidth={1.9} aria-hidden />
                {e.name}
              </Chip>
            )
            return onOpen ? (
              <button key={slug} type="button" onClick={() => onOpen(slug)} className="group rounded-full focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple focus-visible:ring-offset-2">
                {chip}
              </button>
            ) : (
              <span key={slug}>{chip}</span>
            )
          })}
        </Rise>
      )}
    </div>
  )
}

/** O módulo como slide, para a exportação e a impressão (a mesma página, na sequência). */
export function ModuleAppendixSlide({ entry, ...meta }: SlideMeta & { entry: ModuleEntry }) {
  const page = getModulePage(entry.slug)
  const tone = moduleRegistry.indexOf(entry) % 2 === 0 ? 'white' : 'off'
  return (
    <Slide {...meta} tone={tone}>
      {page ? <ModuleBody page={page} entry={entry} /> : <p className="text-[length:var(--dk-lead)] text-brand-graphite">{entry.short}</p>}
    </Slide>
  )
}

/** Um módulo clicável: abre a página dele. Sem contexto de navegação, vira apenas a etiqueta. */
export function ModuleChip({ slug, name, tone = 'purple' }: { slug: string; name: string; tone?: 'purple' | 'neutral' }) {
  const open = useOpenModule()
  const entry = getModuleEntry(slug)
  const Icon = entry ? moduleIcons[entry.icon] : moduleIcons.sparkles
  const chip = (
    <Chip tone={tone} className={open ? 'transition-colors group-hover:border-brand-purple/60 group-hover:bg-brand-purple/[0.12] group-hover:text-brand-purple' : undefined}>
      <Icon className="h-[1.1em] w-[1.1em]" strokeWidth={1.9} aria-hidden />
      {name}
    </Chip>
  )
  if (!open || !entry) return chip
  return (
    <button
      type="button"
      onClick={() => open(slug)}
      title={`Ver a página de ${entry.name}`}
      className="group rounded-full focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple focus-visible:ring-offset-2"
    >
      {chip}
    </button>
  )
}

/** Uma linha do catálogo: o nome do módulo e o que ele faz em uma frase. */
function CatalogItem({ entry }: { entry: ModuleEntry }) {
  const open = useOpenModule()
  const Icon = moduleIcons[entry.icon]
  const inner = (
    <>
      <Icon className="mt-[0.15em] h-[1.15em] w-[1.15em] shrink-0 text-brand-purple" strokeWidth={1.9} aria-hidden />
      <span className="min-w-0 text-[length:var(--dk-small)] font-semibold leading-snug text-brand-ink">{entry.name}</span>
      {open && <ArrowUpRight className="ml-auto mt-[0.1em] h-[1.05em] w-[1.05em] shrink-0 text-brand-gray transition-colors group-hover:text-brand-purple" strokeWidth={2} aria-hidden />}
    </>
  )
  if (!open) return <span className="flex items-start gap-2">{inner}</span>
  return (
    <button
      type="button"
      onClick={() => open(entry.slug)}
      title={`Ver a página de ${entry.name}`}
      className="group flex w-full items-start gap-2 rounded-md py-[0.15em] text-left transition-colors hover:text-brand-purple focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
    >
      {inner}
    </button>
  )
}

/** O catálogo: os sete grupos e todos os módulos, cada um com a sua página. */
export function ModulosSlide(meta: SlideMeta) {
  const open = useOpenModule()
  return (
    <Slide {...meta} tone="off">
      <div className="max-w-[52rem]">
        <SlideTitle text={modulosCatalogo.title} />
        <SlideLead className="mt-3">{open ? modulosCatalogo.lead : modulosCatalogo.leadPrint}</SlideLead>
      </div>
      <Stagger className="mt-[clamp(1rem,3vh,2rem)] grid items-start gap-2.5 sm:grid-cols-2 lg:grid-cols-4" delay={0.3} stagger={0.05}>
        {groups.map((group) => {
          const GIcon = moduleIcons[categoryMeta[group.id].icon]
          const list = modulesByGroup(group.id)
          return (
            <Item key={group.id}>
              <Card className="flex h-full flex-col">
                <p className="flex items-center gap-2.5 text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">
                  <IconBox>
                    <GIcon strokeWidth={1.7} />
                  </IconBox>
                  {group.name}
                </p>
                <ul className="mt-2.5 space-y-[0.2em]">
                  {list.map((m) => (
                    <li key={m.slug}>
                      <CatalogItem entry={m} />
                    </li>
                  ))}
                </ul>
              </Card>
            </Item>
          )
        })}
      </Stagger>
    </Slide>
  )
}
