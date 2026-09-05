import { useMemo } from 'react'
import { m } from 'motion/react'
import { Check, Sparkles } from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'
import { EFFECTIVATION_AFTER, phases, steps, type PhaseNumber } from '@/content/hiringJourney'

export const EFFECTIVATION_ID = 'efetivacao'

export interface MapRow {
  id: string
  label: string
  phase: PhaseNumber
  n?: number
  special?: boolean
}

/** Linhas do mapa: 24 etapas mais o momento da efetivação, na ordem da história. */
export function useMapRows(): MapRow[] {
  return useMemo(() => {
    const rows: MapRow[] = []
    for (const s of steps) {
      rows.push({ id: s.id, label: s.name, phase: s.phase, n: s.n })
      if (s.n === EFFECTIVATION_AFTER) rows.push({ id: EFFECTIVATION_ID, label: 'Efetivação automática', phase: 2, special: true })
    }
    return rows
  }, [])
}

interface JourneyMapProps {
  rows: MapRow[]
  activeIndex: number
  onSelect: (id: string) => void
}

/** Mapa lateral (desktop): fases e etapas com a trilha que se preenche conforme a rolagem. */
export function JourneyMap({ rows, activeIndex, onSelect }: JourneyMapProps) {
  const progress = rows.length > 1 ? Math.max(0, activeIndex) / (rows.length - 1) : 0
  return (
    <nav aria-label="Mapa da jornada" className="relative">
      <span aria-hidden className="absolute bottom-3 left-[13px] top-3 w-px bg-brand-mist" />
      <m.span
        aria-hidden
        className="absolute left-[13px] top-3 w-px origin-top bg-[linear-gradient(180deg,#9A408A,#511C76)]"
        style={{ height: 'calc(100% - 1.5rem)' }}
        animate={{ scaleY: progress }}
        transition={{ duration: 0.6, ease: EASE }}
      />
      <ol className="relative space-y-4">
        {phases.map((p) => (
          <li key={p.n}>
            <p className="flex items-center gap-3 pl-9 text-[11px] font-bold uppercase tracking-[0.14em] text-brand-purple">
              Fase {p.n} · {p.title}
            </p>
            <ol className="mt-1.5 space-y-0.5">
              {rows
                .filter((r) => r.phase === p.n)
                .map((r) => {
                  const idx = rows.indexOf(r)
                  const state = idx < activeIndex ? 'done' : idx === activeIndex ? 'active' : 'next'
                  return (
                    <li key={r.id}>
                      <button
                        type="button"
                        onClick={() => onSelect(r.id)}
                        aria-current={state === 'active' ? 'step' : undefined}
                        className={cn(
                          'group flex w-full items-center gap-3 rounded-lg py-1 pr-2 text-left text-[13px] transition-colors duration-300',
                          state === 'active' ? 'font-bold text-brand-ink' : state === 'done' ? 'font-medium text-brand-graphite' : 'font-medium text-brand-graphite/80',
                          'hover:text-brand-purple',
                        )}
                      >
                        <span
                          className={cn(
                            'relative z-10 flex h-[27px] w-[27px] shrink-0 items-center justify-center rounded-full border text-[10.5px] font-bold tabular transition-[background-color,border-color,color,transform] duration-300',
                            state === 'active' && 'scale-110 border-brand-purple bg-brand-purple text-white shadow-[0_0_0_4px_rgba(81,28,118,0.15)]',
                            state === 'done' && 'border-brand-purple/40 bg-white text-brand-purple',
                            state === 'next' && 'border-brand-mist bg-white text-brand-graphite',
                            r.special && state !== 'active' && 'border-brand-pink/60 text-brand-pink',
                          )}
                        >
                          {r.special ? <Sparkles className="h-3 w-3" strokeWidth={2.4} aria-hidden /> : state === 'done' ? <Check className="h-3 w-3" strokeWidth={3} aria-hidden /> : String(r.n).padStart(2, '0')}
                        </span>
                        <span className="truncate">{r.label}</span>
                      </button>
                    </li>
                  )
                })}
            </ol>
          </li>
        ))}
      </ol>
    </nav>
  )
}

/** Barra fixa (mobile): fases como segmentos e a etapa atual. */
export function JourneyBar({ rows, activeIndex, onSelect }: JourneyMapProps) {
  const current = rows[Math.max(0, activeIndex)]
  const phase = current ? phases.find((p) => p.n === current.phase) : phases[0]
  return (
    <div className="sticky top-[var(--nav-h)] z-30 -mx-4 border-b border-brand-mist bg-white/90 px-4 py-2.5 backdrop-blur-xl sm:-mx-6 sm:px-6 lg:hidden" aria-label="Progresso da jornada">
      <div className="flex gap-1.5" role="list">
        {phases.map((p) => {
          const rowsInPhase = rows.filter((r) => r.phase === p.n)
          const first = rows.indexOf(rowsInPhase[0])
          const done = rowsInPhase.filter((r) => rows.indexOf(r) < activeIndex).length
          const fill = p.n < (phase?.n ?? 1) ? 1 : p.n > (phase?.n ?? 1) ? 0 : (done + 0.5) / rowsInPhase.length
          return (
            <div key={p.n} role="listitem" className="flex-1">
              <button
                type="button"
                onClick={() => onSelect(rows[first].id)}
                aria-label={`Fase ${p.n}: ${p.title}`}
                aria-current={p.n === phase?.n ? 'step' : undefined}
                className="block h-2 w-full overflow-hidden rounded-full bg-brand-mist"
              >
                <m.span className="block h-full rounded-full bg-[linear-gradient(90deg,#9A408A,#511C76)]" animate={{ width: `${Math.round(fill * 100)}%` }} transition={{ duration: 0.5, ease: EASE }} />
              </button>
            </div>
          )
        })}
      </div>
      <p className="mt-1.5 flex items-center justify-between gap-3 text-[12px]">
        <span className="truncate font-bold text-brand-ink">
          {current?.special ? current.label : current ? `Etapa ${String(current.n).padStart(2, '0')} · ${current.label}` : 'Início'}
        </span>
        <span className="shrink-0 font-semibold uppercase tracking-[0.12em] text-brand-purple">Fase {phase?.n}</span>
      </p>
    </div>
  )
}
