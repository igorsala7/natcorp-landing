import { Fragment, useMemo } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { Link } from 'react-router'
import { ArrowRight } from 'lucide-react'
import { Eyebrow } from '@/components/sections/Section'
import { EffectivationHub } from '@/components/journey/EffectivationHub'
import { VolumeAside } from '@/components/journey/VolumeAside'
import { useNodeRects, type NodeRect } from '@/components/journey/useNodeRects'
import { moduleIcons } from '@/content/modulePages/icons'
import { getModuleEntry, modulePath } from '@/content/modulePages'
import { EFFECTIVATION_AFTER, actorMeta, actors, phases, steps, stepsByPhase, type JourneyPhase, type JourneyStep } from '@/content/hiringJourney'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'

const pad = (n: number) => String(n).padStart(2, '0')

const PURPLE = '#511C76'
const PINK = '#C95788'

/** Nós do diagrama na ordem do fluxo: as 24 etapas, com o bloco da efetivação logo depois da etapa 13. */
type DiagramNode = { kind: 'step'; step: JourneyStep } | { kind: 'hub' }

function useDiagramNodes() {
  return useMemo(() => {
    const nodes: DiagramNode[] = []
    const indexOf = new Map<string, number>()
    let hubIndex = -1
    for (const s of steps) {
      indexOf.set(s.id, nodes.length)
      nodes.push({ kind: 'step', step: s })
      if (s.n === EFFECTIVATION_AFTER) {
        hubIndex = nodes.length
        nodes.push({ kind: 'hub' })
      }
    }
    return { nodes, indexOf, hubIndex }
  }, [])
}

export interface JourneyDiagramProps {
  /** Abre a etapa na versão contada. Quando ausente, o botão "Ler na história" não aparece. */
  onOpenStory?: (stepId: string) => void
  className?: string
}

/**
 * Visão prática da jornada: raias por quem executa (desktop) ou lista vertical (mobile),
 * com os módulos que entram em ação em cada etapa e o bloco da efetivação depois da etapa 13.
 */
export function JourneyDiagram({ onOpenStory, className }: JourneyDiagramProps) {
  return (
    <div role="group" aria-label="Visão prática da jornada, por raias de quem executa" className={cn('relative', className)}>
      <div className="hidden lg:block">
        <SwimlaneDiagram onOpenStory={onOpenStory} />
      </div>
      <div className="lg:hidden">
        <StackedList onOpenStory={onOpenStory} />
      </div>
    </div>
  )
}

/* ------------------------------------------------------------------ */
/* Desktop: raias                                                      */
/* ------------------------------------------------------------------ */

const LANE_GRID = 'grid grid-cols-6 gap-x-3'

function SwimlaneDiagram({ onOpenStory }: { onOpenStory?: (stepId: string) => void }) {
  const { nodes, indexOf, hubIndex } = useDiagramNodes()
  const { containerRef, setNodeRef, rects } = useNodeRects<HTMLLIElement>(nodes.length)
  const reduced = useReducedMotion()
  const laneOf = (step: JourneyStep) => actors.findIndex((a) => a.key === step.actor)

  return (
    <div>
      {/* Cabeçalho das raias, fixo enquanto o diagrama rola */}
      <div className="sticky top-[calc(var(--nav-h)+0.5rem)] z-30 rounded-2xl border border-brand-mist bg-white/90 py-2.5 shadow-soft backdrop-blur-xl">
        <ul className={LANE_GRID} aria-label="Raias, por quem executa">
          {actors.map((a) => (
            <li key={a.key} className="flex items-center justify-center gap-2 px-2 text-center text-[10.5px] font-bold uppercase leading-tight tracking-[0.12em] text-brand-ink xl:text-[11px]">
              <span aria-hidden className="h-2.5 w-2.5 shrink-0 rounded-full" style={{ backgroundColor: a.color }} />
              {a.label}
            </li>
          ))}
        </ul>
      </div>
      <p className="mt-3 text-[12.5px] leading-snug text-brand-graphite">
        Cada cartão fica na raia de quem executa. A linha liga a etapa seguinte. Etapas na raia Sistema e NATI acontecem sozinhas.
      </p>

      {/* Corpo do diagrama: fases, etapas e a linha que as liga */}
      <div ref={containerRef} className="relative isolate mt-6">
        <Connectors rects={rects} pulse={!reduced} />

        {phases.map((p) => (
          <div key={p.n}>
            <PhaseHeader phase={p} compact />
            <div className="relative">
              {/* Guias das raias, atrás dos cartões */}
              <div aria-hidden className={cn('pointer-events-none absolute inset-0 z-0', LANE_GRID)}>
                {actors.map((a) => (
                  <div key={a.key} className="mx-auto h-full w-0 border-l border-dashed border-brand-mist" />
                ))}
              </div>

              <ol start={p.steps[0]} className={cn(LANE_GRID, 'gap-y-6')}>
                {stepsByPhase(p.n).map((s) => {
                  const idx = indexOf.get(s.id)!
                  return (
                    <Fragment key={s.id}>
                      <m.li
                        ref={setNodeRef(idx)}
                        className="relative z-20 min-w-0"
                        style={{ gridColumn: laneOf(s) + 1 }}
                        initial={{ opacity: 0, y: 12 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={viewportOnce}
                        transition={{ duration: 0.5, ease: EASE }}
                      >
                        <StepCard step={s} onOpenStory={onOpenStory} idSuffix="" />
                      </m.li>
                      {s.n === EFFECTIVATION_AFTER && (
                        <li ref={setNodeRef(hubIndex)} className="relative z-20 col-span-6 my-2" aria-label="Efetivação automática">
                          <EffectivationHub id="efetivacao-pratico" />
                          <VolumeAside compact idSuffix="-pratico" className="mt-3" />
                        </li>
                      )}
                    </Fragment>
                  )
                })}
              </ol>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

const fmt = (n: number) => n.toFixed(1)

/** Curva de saída vertical de um nó até a entrada vertical do próximo. */
function segment(a: NodeRect, b: NodeRect) {
  const x1 = a.x + a.w / 2
  const y1 = a.y + a.h
  const x2 = b.x + b.w / 2
  const y2 = b.y
  if (Math.abs(x1 - x2) < 0.5) return `L${fmt(x2)},${fmt(y2)}`
  const k = Math.max(8, (y2 - y1) / 2)
  return `C${fmt(x1)},${fmt(y1 + k)} ${fmt(x2)},${fmt(y2 - k)} ${fmt(x2)},${fmt(y2)}`
}

/** Linha entre os nós, com um ponto na chegada de cada trecho e um pulso que percorre o caminho. */
function Connectors({ rects, pulse }: { rects: (NodeRect | null)[]; pulse: boolean }) {
  const ready = rects.length > 1 && rects.every((r) => r && r.w > 0 && r.h > 0)
  if (!ready) return null
  const boxes = rects as NodeRect[]

  const segments: { d: string; end: [number, number] }[] = []
  let full = `M${fmt(boxes[0].x + boxes[0].w / 2)},${fmt(boxes[0].y + boxes[0].h)}`
  for (let i = 0; i < boxes.length - 1; i++) {
    const a = boxes[i]
    const b = boxes[i + 1]
    const start = `M${fmt(a.x + a.w / 2)},${fmt(a.y + a.h)}`
    const seg = segment(a, b)
    segments.push({ d: start + seg, end: [b.x + b.w / 2, b.y] })
    // Caminho contínuo para o pulso: atravessa cada cartão intermediário em linha reta (fica escondido atrás dele).
    full += seg
    if (i + 1 < boxes.length - 1) full += `L${fmt(b.x + b.w / 2)},${fmt(b.y + b.h)}`
  }

  return (
    <svg aria-hidden className="pointer-events-none absolute inset-0 z-10 h-full w-full overflow-visible">
      {segments.map((s, i) => (
        <Fragment key={i}>
          <path d={s.d} fill="none" stroke={PURPLE} strokeOpacity={0.45} strokeWidth={1.5} strokeLinecap="round" />
          <circle cx={s.end[0]} cy={s.end[1]} r={2.5} fill={PURPLE} fillOpacity={0.6} />
        </Fragment>
      ))}
      {pulse && (
        <g>
          <circle r={8} fill={PINK} fillOpacity={0.18} />
          <circle r={3.5} fill={PINK} />
          <animateMotion dur="14s" repeatCount="indefinite" path={full} />
        </g>
      )}
    </svg>
  )
}

/* ------------------------------------------------------------------ */
/* Mobile e tablet: lista vertical                                     */
/* ------------------------------------------------------------------ */

function StackedList({ onOpenStory }: { onOpenStory?: (stepId: string) => void }) {
  const last = steps[steps.length - 1]
  return (
    <div>
      <p className="text-[13px] leading-snug text-brand-graphite">Cada cartão mostra quem executa a etapa e os módulos que entram em ação. Etapas de Sistema e NATI acontecem sozinhas.</p>
      {phases.map((p) => (
        <div key={p.n}>
          <PhaseHeader phase={p} />
          <ol start={p.steps[0]}>
            {stepsByPhase(p.n).map((s) => (
              <Fragment key={s.id}>
                <m.li
                  initial={{ opacity: 0, y: 12 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={viewportOnce}
                  transition={{ duration: 0.5, ease: EASE }}
                >
                  <StepCard step={s} onOpenStory={onOpenStory} showActor idSuffix="-m" />
                  {s.id !== last.id && <span aria-hidden className="mx-auto block h-6 w-px border-l border-brand-mist" />}
                </m.li>
                {s.n === EFFECTIVATION_AFTER && (
                  <li aria-label="Efetivação automática">
                    <EffectivationHub id="efetivacao-pratico-m" />
                    <VolumeAside compact idSuffix="-pratico-m" className="mt-3" />
                    <span aria-hidden className="mx-auto block h-6 w-px border-l border-brand-mist" />
                  </li>
                )}
              </Fragment>
            ))}
          </ol>
        </div>
      ))}
    </div>
  )
}

/* ------------------------------------------------------------------ */
/* Peças compartilhadas                                                */
/* ------------------------------------------------------------------ */

function PhaseHeader({ phase, compact = false }: { phase: JourneyPhase; compact?: boolean }) {
  if (compact) {
    return (
      <div className="relative z-20 flex flex-wrap items-baseline gap-x-3 gap-y-1 pb-4 pt-8">
        <Eyebrow trail={false} className="text-[11px] tracking-[0.14em]">
          Fase {phase.n} · {phase.range}
        </Eyebrow>
        <h3 className="text-[17px] font-extrabold leading-tight text-brand-ink">{phase.title}</h3>
        <p className="text-[13px] leading-snug text-brand-graphite">{phase.subtitle}</p>
      </div>
    )
  }
  return (
    <div className="pb-5 pt-10">
      <Eyebrow>
        Fase {phase.n} · {phase.range}
      </Eyebrow>
      <h3 className="mt-3 text-2xl font-extrabold leading-tight text-brand-ink">{phase.title}</h3>
      <p className="mt-1.5 text-[14px] leading-snug text-brand-graphite">{phase.subtitle}</p>
    </div>
  )
}

interface StepCardProps {
  step: JourneyStep
  onOpenStory?: (stepId: string) => void
  /** Mostra a etiqueta de quem executa (ponto + nome), usada fora das raias. */
  showActor?: boolean
  /** Diferencia os ids entre as árvores desktop e mobile, que coexistem no DOM. */
  idSuffix: string
}

function StepCard({ step, onOpenStory, showActor = false, idSuffix }: StepCardProps) {
  const actor = actorMeta(step.actor)
  const titleId = `${step.id}-pratico${idSuffix}-title`
  const modules = step.modules.map((ref) => ({ ...ref, entry: getModuleEntry(ref.slug) })).filter((ref) => ref.entry)

  return (
    <article
      aria-labelledby={titleId}
      className="rounded-2xl border border-brand-mist border-l-[3px] bg-white p-3.5 shadow-soft xl:p-4"
      style={{ borderLeftColor: actor.color }}
    >
      <div className="flex flex-wrap items-center gap-x-2 gap-y-1">
        <span className="inline-flex items-center rounded-full bg-brand-purple px-2 py-0.5 text-[10.5px] font-bold uppercase tracking-[0.08em] text-white tabular">
          Etapa {pad(step.n)}
        </span>
        <span className="inline-flex items-center gap-1.5 text-[10.5px] font-bold uppercase tracking-[0.12em] text-brand-graphite">
          {showActor && <span aria-hidden className="h-2 w-2 rounded-full" style={{ backgroundColor: actor.color }} />}
          {showActor ? actor.label : actor.short}
        </span>
      </div>

      <h4 id={titleId} className="mt-2 text-[15px] font-extrabold leading-tight text-brand-ink">
        {step.name}
      </h4>
      <p className="mt-1.5 line-clamp-3 text-[13px] leading-snug text-brand-graphite">{step.brief}</p>

      {modules.length > 0 && (
        <ul className="mt-3 flex flex-wrap gap-1.5" aria-label="Módulos desta etapa">
          {modules.map((ref) => {
            const Icon = moduleIcons[ref.entry!.icon]
            return (
              <li key={ref.slug} className="min-w-0 max-w-full">
                <Link
                  to={modulePath(ref.slug)}
                  title={ref.note}
                  className="inline-flex max-w-full items-center gap-1 rounded-lg border border-brand-mist bg-brand-off-white px-1.5 py-[3px] text-[11.5px] font-semibold leading-none text-brand-ink transition-colors duration-300 hover:border-brand-purple/40 hover:text-brand-purple"
                >
                  <Icon className="h-3 w-3 shrink-0 text-brand-purple" strokeWidth={2} aria-hidden />
                  <span className="truncate">{ref.entry!.name}</span>
                </Link>
              </li>
            )
          })}
        </ul>
      )}

      {onOpenStory && (
        <button
          type="button"
          onClick={() => onOpenStory(step.id)}
          aria-label={`Ler na história: etapa ${pad(step.n)}, ${step.name}`}
          className="group mt-3 inline-flex items-center gap-1 rounded text-[12px] font-semibold text-brand-purple underline-offset-4 hover:underline"
        >
          Ler na história
          <ArrowRight className="h-3 w-3 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
        </button>
      )}
    </article>
  )
}
