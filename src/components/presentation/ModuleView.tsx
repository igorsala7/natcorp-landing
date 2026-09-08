import { AnimatePresence, m } from 'motion/react'
import { ArrowLeft, ChevronLeft, ChevronRight, LayoutGrid, X } from 'lucide-react'
import { groups, moduleRegistry, modulesByGroup, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { useIsDesktop } from '@/hooks/useMediaQuery'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { getModulePage } from './moduleData'
import { useFitZoom } from './useFitZoom'
import { ModuleBody } from './slides/module'

/**
 * A página de um módulo aberta por cima da apresentação, e a lista de onde escolher qualquer um.
 * O apresentador desce ao detalhe quando a plateia pergunta ("e a folha, como funciona?") e volta
 * exatamente para o slide de onde saiu.
 */

interface ModuleViewProps {
  entry: ModuleEntry
  /** Título do slide de onde a página foi aberta, para o botão de voltar. */
  from?: string
  onClose: () => void
  onNavigate: (slug: string) => void
  onIndex: () => void
}

export function ModuleView({ entry, from, onClose, onNavigate, onIndex }: ModuleViewProps) {
  const desktop = useIsDesktop()
  const { outer, inner } = useFitZoom(desktop)
  const page = getModulePage(entry.slug)
  const group = groups.find((g) => g.id === entry.group)!
  const pos = moduleRegistry.indexOf(entry)
  const prev = moduleRegistry[(pos - 1 + moduleRegistry.length) % moduleRegistry.length]
  const next = moduleRegistry[(pos + 1) % moduleRegistry.length]

  return (
    <m.div
      className="deck-ui deck-sheet fixed inset-0 z-[75] flex flex-col bg-brand-off-white text-brand-ink"
      initial={{ opacity: 0, y: 28 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: 20 }}
      transition={{ duration: 0.32, ease: EASE }}
      role="dialog"
      aria-modal="true"
      aria-label={`Módulo ${entry.name}`}
    >
      <header className="flex shrink-0 items-center gap-1 border-b border-brand-mist bg-white/90 px-3 py-2 backdrop-blur-md sm:gap-2 sm:px-5">
        <button
          type="button"
          onClick={onClose}
          autoFocus
          className="flex h-9 items-center gap-2 rounded-full px-3 text-[13px] font-semibold text-brand-purple hover:bg-brand-off-white"
        >
          <ArrowLeft className="h-4 w-4" aria-hidden />
          Voltar
          {from && <span className="hidden max-w-[16rem] truncate font-medium text-brand-graphite sm:inline">· {from}</span>}
        </button>
        <p className="mx-auto hidden text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-gray sm:block">
          Módulo {pos + 1} de {moduleRegistry.length} · {group.name}
        </p>
        <div className="ml-auto flex items-center gap-0.5 sm:ml-0">
          <IconButton label="Todos os módulos (M)" onClick={onIndex}>
            <LayoutGrid />
          </IconButton>
          <IconButton label={`Módulo anterior: ${prev.name}`} onClick={() => onNavigate(prev.slug)}>
            <ChevronLeft />
          </IconButton>
          <IconButton label={`Próximo módulo: ${next.name}`} onClick={() => onNavigate(next.slug)}>
            <ChevronRight />
          </IconButton>
          <IconButton label="Fechar (Esc)" onClick={onClose}>
            <X />
          </IconButton>
        </div>
      </header>

      <div
        ref={outer}
        className={cn(
          'flex min-h-0 flex-1 flex-col overflow-y-auto overscroll-contain px-[var(--dk-mx)] py-[clamp(1rem,3.5vh,2.75rem)]',
          desktop && 'justify-center',
        )}
      >
        <div ref={inner}>
          <AnimatePresence mode="wait" initial={false}>
            <m.div key={entry.slug} initial={{ opacity: 0, x: 18 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: -14 }} transition={{ duration: 0.28, ease: EASE }}>
              {page ? (
                <ModuleBody page={page} entry={entry} onOpen={onNavigate} />
              ) : (
                <div>
                  <p className="text-[length:calc(var(--dk-h2)*0.8)] font-extrabold leading-tight tracking-brand">{entry.name}</p>
                  <p className="mt-3 max-w-[42rem] text-[length:var(--dk-lead)] leading-relaxed text-brand-graphite">{entry.short}</p>
                  <p className="mt-4 text-[length:var(--dk-small)] text-brand-gray">Abrindo a página do módulo…</p>
                </div>
              )}
            </m.div>
          </AnimatePresence>
        </div>
      </div>

      <footer className="hidden shrink-0 items-center justify-between border-t border-brand-mist bg-white/80 px-5 py-2 text-[12px] text-brand-gray sm:flex">
        <span>
          <Key>Esc</Key> volta para a apresentação · <Key>←</Key> <Key>→</Key> troca de módulo
        </span>
        <span className="font-semibold text-brand-graphite">{entry.name}</span>
      </footer>
    </m.div>
  )
}

/** A lista de todos os módulos: escolha direta, a qualquer momento (tecla M). */
export function ModulePanel({ current, onPick, onClose }: { current?: string; onPick: (slug: string) => void; onClose: () => void }) {
  return (
    <m.aside
      className="deck-ui fixed inset-y-0 right-0 z-[78] flex w-[min(92vw,400px)] flex-col border-l border-brand-mist bg-white text-brand-ink shadow-lift"
      initial={{ x: '100%' }}
      animate={{ x: 0 }}
      exit={{ x: '100%' }}
      transition={{ duration: 0.4, ease: EASE }}
      aria-label="Módulos do sistema"
    >
      <div className="flex items-center justify-between border-b border-brand-mist px-5 py-4">
        <div>
          <p className="text-[11px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Módulos</p>
          <p className="mt-0.5 text-[14px] font-bold">{moduleRegistry.length} páginas, uma para cada módulo</p>
        </div>
        <button type="button" onClick={onClose} className="flex h-9 w-9 items-center justify-center rounded-full text-brand-graphite hover:bg-brand-off-white" aria-label="Fechar a lista de módulos" autoFocus>
          <X className="h-4.5 w-4.5" />
        </button>
      </div>
      <nav className="min-h-0 flex-1 overflow-y-auto px-3 py-3">
        {groups.map((g) => (
          <div key={g.id} className="mb-3">
            <p className="px-2 pb-1 pt-2 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-gray">{g.name}</p>
            <ul>
              {modulesByGroup(g.id).map((m) => {
                const Icon = moduleIcons[m.icon]
                const active = m.slug === current
                return (
                  <li key={m.slug}>
                    <button
                      type="button"
                      onClick={() => onPick(m.slug)}
                      aria-current={active ? 'true' : undefined}
                      className={cn(
                        'flex w-full items-start gap-2.5 rounded-lg px-2 py-1.5 text-left transition-colors hover:bg-brand-off-white',
                        active && 'bg-brand-purple/[0.08]',
                      )}
                    >
                      <Icon className={cn('mt-[0.15em] h-4 w-4 shrink-0', active ? 'text-brand-purple' : 'text-brand-gray')} strokeWidth={1.9} aria-hidden />
                      <span className="min-w-0">
                        <span className={cn('block text-[13.5px] font-semibold leading-tight', active ? 'text-brand-purple' : 'text-brand-ink')}>{m.name}</span>
                        <span className="mt-0.5 block text-[12px] leading-snug text-brand-graphite">{m.short}</span>
                      </span>
                    </button>
                  </li>
                )
              })}
            </ul>
          </div>
        ))}
      </nav>
    </m.aside>
  )
}

function Key({ children }: { children: React.ReactNode }) {
  return <kbd className="rounded border border-brand-mist bg-brand-off-white px-1.5 py-0.5 font-sans text-[11px] font-semibold text-brand-ink">{children}</kbd>
}

function IconButton({ label, onClick, children }: { label: string; onClick: () => void; children: React.ReactNode }) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label={label}
      title={label}
      className="flex h-9 w-9 items-center justify-center rounded-full text-brand-ink transition-colors hover:bg-brand-off-white [&_svg]:h-[18px] [&_svg]:w-[18px]"
    >
      {children}
    </button>
  )
}
