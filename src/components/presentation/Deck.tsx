import { useCallback, useEffect, useLayoutEffect, useRef, useState, type ComponentType } from 'react'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { Link } from 'react-router'
import { Check, ChevronLeft, ChevronRight, Copy, Download, List, Maximize2, MessageSquareText, Minimize2, X } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { deckMeta } from '@/content/presentation'
import { paths } from '@/content/site'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import type { SlideMeta } from './Slide'

/** Um slide registrado no deck: identidade, capítulo (para o índice), notas e o componente. */
export interface DeckSlideDef {
  id: string
  chapter: string
  title: string
  notes?: string[]
  Component: ComponentType<SlideMeta>
}

interface DeckProps {
  slides: DeckSlideDef[]
}

/** Slide inicial a partir de `?s=N` (1-based) na URL. */
function initialSlide(total: number) {
  if (typeof window === 'undefined') return 0
  const n = Number(new URLSearchParams(window.location.search).get('s'))
  return Number.isFinite(n) && n >= 1 && n <= total ? n - 1 : 0
}

const shortcuts = [
  ['← →', 'navegar'],
  ['F', 'tela cheia'],
  ['N', 'notas'],
  ['G', 'índice'],
  ['Esc', 'fechar'],
]

/** O PDF pré-gerado (npm run export:deck), servido junto com o site. */
const PDF_PATH = '/natcorp-apresentacao.pdf'

/**
 * A apresentação: os slides encaixam na rolagem (um por tela), com navegação por teclado,
 * barra de progresso, índice, notas do apresentador, tela cheia e o PDF para baixar.
 * A posição fica na URL (`?s=N`) para compartilhar um slide específico.
 */
export function Deck({ slides }: DeckProps) {
  const total = slides.length
  const rootRef = useRef<HTMLDivElement>(null)
  const reduced = useReducedMotion()
  const [active, setActive] = useState(() => initialSlide(total))
  const activeRef = useRef(active)
  const [indexOpen, setIndexOpen] = useState(false)
  const [notesOpen, setNotesOpen] = useState(false)
  const [fullscreen, setFullscreen] = useState(false)
  const [canFullscreen, setCanFullscreen] = useState(false)
  const [idle, setIdle] = useState(false)
  const [copied, setCopied] = useState(false)

  const slideEl = useCallback((i: number) => rootRef.current?.querySelector<HTMLElement>(`[data-slide="${i}"]`) ?? null, [])

  const go = useCallback(
    (i: number, behavior?: ScrollBehavior) => {
      const target = Math.max(0, Math.min(total - 1, i))
      slideEl(target)?.scrollIntoView({ behavior: behavior ?? (reduced ? 'auto' : 'smooth'), block: 'start' })
    },
    [total, reduced, slideEl],
  )

  /* Abre já no slide pedido pela URL. */
  useLayoutEffect(() => {
    if (activeRef.current > 0) go(activeRef.current, 'auto')
    setCanFullscreen(Boolean(document.fullscreenEnabled))
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  /* Slide ativo: o que cruza o meio da tela. */
  useEffect(() => {
    const root = rootRef.current
    if (!root) return
    const els = Array.from(root.querySelectorAll<HTMLElement>('[data-slide]'))
    const io = new IntersectionObserver(
      (entries) => {
        for (const e of entries) {
          if (e.isIntersecting) setActive(Number((e.target as HTMLElement).dataset.slide))
        }
      },
      { root, rootMargin: '-50% 0px -50% 0px', threshold: 0 },
    )
    els.forEach((el) => io.observe(el))
    return () => io.disconnect()
  }, [total])

  /* A posição na URL, sem passar pelo roteador (não deve rolar a página nem criar histórico). */
  useEffect(() => {
    activeRef.current = active
    const url = new URL(window.location.href)
    url.searchParams.set('s', String(active + 1))
    window.history.replaceState(window.history.state, '', url)
  }, [active])

  useEffect(() => {
    const onChange = () => setFullscreen(Boolean(document.fullscreenElement))
    document.addEventListener('fullscreenchange', onChange)
    return () => document.removeEventListener('fullscreenchange', onChange)
  }, [])

  const toggleFullscreen = useCallback(() => {
    if (document.fullscreenElement) void document.exitFullscreen()
    else void document.documentElement.requestFullscreen?.()
  }, [])

  /* Teclado: setas, espaço, Page Up/Down, Home/End, F, N, G, Esc. */
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      const t = e.target as HTMLElement | null
      if (t && (t.tagName === 'INPUT' || t.tagName === 'TEXTAREA' || t.isContentEditable)) return
      if (e.ctrlKey || e.metaKey || e.altKey) return
      switch (e.key) {
        case 'ArrowRight':
        case 'ArrowDown':
        case 'PageDown':
          e.preventDefault()
          go(activeRef.current + 1)
          break
        case ' ':
          e.preventDefault()
          go(activeRef.current + (e.shiftKey ? -1 : 1))
          break
        case 'ArrowLeft':
        case 'ArrowUp':
        case 'PageUp':
          e.preventDefault()
          go(activeRef.current - 1)
          break
        case 'Home':
          e.preventDefault()
          go(0)
          break
        case 'End':
          e.preventDefault()
          go(total - 1)
          break
        case 'f':
        case 'F':
          toggleFullscreen()
          break
        case 'n':
        case 'N':
          setNotesOpen((v) => !v)
          break
        case 'g':
        case 'G':
        case 'i':
        case 'I':
          setIndexOpen((v) => !v)
          break
        case 'Escape':
          setNotesOpen(false)
          setIndexOpen(false)
          break
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [go, total, toggleFullscreen])

  /* Em tela cheia, a barra some depois de alguns segundos sem mexer o mouse. */
  useEffect(() => {
    if (!fullscreen) {
      setIdle(false)
      return
    }
    let timer = 0
    const wake = () => {
      setIdle(false)
      window.clearTimeout(timer)
      timer = window.setTimeout(() => setIdle(true), 3000)
    }
    wake()
    window.addEventListener('pointermove', wake)
    window.addEventListener('pointerdown', wake)
    return () => {
      window.clearTimeout(timer)
      window.removeEventListener('pointermove', wake)
      window.removeEventListener('pointerdown', wake)
    }
  }, [fullscreen])

  const copyLink = async () => {
    try {
      await navigator.clipboard.writeText(window.location.href)
      setCopied(true)
      window.setTimeout(() => setCopied(false), 1800)
    } catch {
      /* sem área de transferência: a URL já está na barra do navegador */
    }
  }

  const current = slides[active]
  const hideUi = fullscreen && idle && !indexOpen && !notesOpen
  const chapters = slides.reduce<{ chapter: string; items: { i: number; title: string }[] }[]>((acc, s, i) => {
    const last = acc[acc.length - 1]
    if (last && last.chapter === s.chapter) last.items.push({ i, title: s.title })
    else acc.push({ chapter: s.chapter, items: [{ i, title: s.title }] })
    return acc
  }, [])

  return (
    <div className="deck">
      {/* Progresso */}
      <div className="deck-ui pointer-events-none fixed inset-x-0 top-0 z-[60] h-[3px] bg-brand-ink/10" aria-hidden>
        <div className="h-full origin-left bg-brand-gradient transition-transform duration-500 ease-brand" style={{ transform: `scaleX(${(active + 1) / total})` }} />
      </div>

      {/* Os slides */}
      <div
        ref={rootRef}
        className="deck-root h-dvh w-full snap-y snap-proximity overflow-y-auto overflow-x-hidden overscroll-contain bg-white lg:snap-mandatory"
        role="region"
        aria-roledescription="apresentação"
        aria-label={`${deckMeta.title} · ${deckMeta.edition}`}
      >
        {slides.map((s, i) => (
          <s.Component key={s.id} id={s.id} index={i} total={total} label={s.title} />
        ))}
      </div>

      <p className="sr-only" aria-live="polite">
        Slide {active + 1} de {total}: {current?.title}
      </p>

      {/* Barra de controle */}
      <div
        className={cn(
          'deck-ui pointer-events-none fixed inset-x-0 bottom-0 z-[60] flex justify-center px-3 pb-[max(0.75rem,env(safe-area-inset-bottom))] transition-opacity duration-500',
          hideUi && 'opacity-0',
        )}
      >
        <div className="pointer-events-auto flex items-center gap-0.5 rounded-full border border-brand-mist bg-white/95 p-1 text-brand-ink shadow-lift backdrop-blur-md sm:gap-1 sm:px-1.5">
          <Link to={paths.home} className="flex h-9 items-center gap-2 rounded-full pl-2 pr-2 text-[12px] font-semibold text-brand-purple hover:bg-brand-off-white sm:pr-3" title="Voltar ao site">
            <Logo variant="symbol" decorative className="h-4 w-4" />
            <span className="hidden sm:inline">Sair</span>
          </Link>
          <span className="mx-0.5 h-5 w-px bg-brand-mist" aria-hidden />
          <ToolButton label="Slide anterior" onClick={() => go(active - 1)} disabled={active === 0}>
            <ChevronLeft />
          </ToolButton>
          <span className="min-w-[4.2rem] text-center text-[13px] font-semibold tabular text-brand-ink" aria-hidden>
            {active + 1} / {total}
          </span>
          <ToolButton label="Próximo slide" onClick={() => go(active + 1)} disabled={active === total - 1}>
            <ChevronRight />
          </ToolButton>
          <span className="mx-0.5 h-5 w-px bg-brand-mist" aria-hidden />
          <ToolButton label="Índice (G)" onClick={() => setIndexOpen((v) => !v)} pressed={indexOpen}>
            <List />
          </ToolButton>
          <ToolButton label="Notas do apresentador (N)" onClick={() => setNotesOpen((v) => !v)} pressed={notesOpen} className="hidden sm:flex">
            <MessageSquareText />
          </ToolButton>
          {canFullscreen && (
            <ToolButton label={fullscreen ? 'Sair da tela cheia (F)' : 'Tela cheia (F)'} onClick={toggleFullscreen} pressed={fullscreen}>
              {fullscreen ? <Minimize2 /> : <Maximize2 />}
            </ToolButton>
          )}
          <a
            href={PDF_PATH}
            download="natcorp-apresentacao.pdf"
            aria-label="Baixar em PDF"
            title="Baixar em PDF"
            className="hidden h-9 w-9 items-center justify-center rounded-full text-brand-ink transition-colors hover:bg-brand-off-white sm:flex [&_svg]:h-[18px] [&_svg]:w-[18px]"
          >
            <Download />
          </a>
        </div>
      </div>

      {/* Índice */}
      <AnimatePresence>
        {indexOpen && (
          <m.aside
            key="index"
            className="deck-ui fixed inset-y-0 right-0 z-[70] flex w-[min(92vw,400px)] flex-col border-l border-brand-mist bg-white text-brand-ink shadow-lift"
            initial={{ x: '100%' }}
            animate={{ x: 0 }}
            exit={{ x: '100%' }}
            transition={{ duration: 0.4, ease: EASE }}
            aria-label="Índice da apresentação"
          >
            <div className="flex items-center justify-between border-b border-brand-mist px-5 py-4">
              <div>
                <p className="text-[11px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Índice</p>
                <p className="mt-0.5 text-[14px] font-bold">{deckMeta.title}</p>
              </div>
              <button type="button" onClick={() => setIndexOpen(false)} className="flex h-9 w-9 items-center justify-center rounded-full text-brand-graphite hover:bg-brand-off-white" aria-label="Fechar índice" autoFocus>
                <X className="h-4.5 w-4.5" />
              </button>
            </div>
            <nav className="min-h-0 flex-1 overflow-y-auto px-3 py-3">
              {chapters.map((c) => (
                <div key={c.chapter} className="mb-3">
                  <p className="px-2 pb-1 pt-2 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-gray">{c.chapter}</p>
                  <ul>
                    {c.items.map((it) => (
                      <li key={it.i}>
                        <button
                          type="button"
                          onClick={() => {
                            go(it.i)
                            setIndexOpen(false)
                          }}
                          aria-current={it.i === active ? 'true' : undefined}
                          className={cn(
                            'flex w-full items-baseline gap-3 rounded-lg px-2 py-1.5 text-left text-[13.5px] font-medium transition-colors hover:bg-brand-off-white',
                            it.i === active ? 'bg-brand-purple/[0.08] text-brand-purple' : 'text-brand-ink',
                          )}
                        >
                          <span className="w-6 shrink-0 text-[11px] font-semibold tabular text-brand-gray">{String(it.i + 1).padStart(2, '0')}</span>
                          <span>{it.title}</span>
                        </button>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </nav>
            <div className="border-t border-brand-mist px-5 py-4">
              <button type="button" onClick={() => void copyLink()} className="inline-flex items-center gap-2 text-[13px] font-semibold text-brand-purple hover:underline">
                {copied ? <Check className="h-4 w-4" /> : <Copy className="h-4 w-4" />}
                {copied ? 'Link copiado' : 'Copiar o link deste slide'}
              </button>
              <p className="mt-2 text-[12px] leading-snug text-brand-graphite">O link abre a apresentação direto no slide {active + 1}.</p>
            </div>
          </m.aside>
        )}
      </AnimatePresence>

      {/* Notas do apresentador */}
      <AnimatePresence>
        {notesOpen && (
          <m.aside
            key="notes"
            className="deck-ui fixed bottom-[4.25rem] left-1/2 z-[65] w-[min(92vw,720px)] -translate-x-1/2 rounded-2xl border border-brand-mist bg-white/95 p-5 text-brand-ink shadow-lift backdrop-blur-md"
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: 12 }}
            transition={{ duration: 0.3, ease: EASE }}
            aria-label="Notas do apresentador"
          >
            <div className="flex items-start justify-between gap-4">
              <div>
                <p className="text-[11px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Notas · slide {active + 1}</p>
                <p className="mt-0.5 text-[15px] font-bold">{current?.title}</p>
              </div>
              <button type="button" onClick={() => setNotesOpen(false)} className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-brand-graphite hover:bg-brand-off-white" aria-label="Fechar notas">
                <X className="h-4 w-4" />
              </button>
            </div>
            <ul className="mt-3 space-y-1.5 text-[14px] leading-relaxed text-brand-graphite">
              {(current?.notes ?? ['Sem notas para este slide.']).map((n) => (
                <li key={n} className="flex gap-2">
                  <span className="mt-[0.6em] h-1.5 w-1.5 shrink-0 rounded-full bg-brand-pink" aria-hidden />
                  {n}
                </li>
              ))}
            </ul>
            <p className="mt-4 flex flex-wrap gap-x-4 gap-y-1 border-t border-brand-mist pt-3 text-[12px] text-brand-gray">
              {shortcuts.map(([k, v]) => (
                <span key={k}>
                  <kbd className="rounded border border-brand-mist bg-brand-off-white px-1.5 py-0.5 font-sans text-[11px] font-semibold text-brand-ink">{k}</kbd> {v}
                </span>
              ))}
            </p>
          </m.aside>
        )}
      </AnimatePresence>
    </div>
  )
}

interface ToolButtonProps {
  label: string
  onClick: () => void
  disabled?: boolean
  pressed?: boolean
  className?: string
  children: React.ReactNode
}

function ToolButton({ label, onClick, disabled, pressed, className, children }: ToolButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      disabled={disabled}
      aria-label={label}
      title={label}
      aria-pressed={pressed}
      className={cn(
        'flex h-9 w-9 items-center justify-center rounded-full text-brand-ink transition-colors hover:bg-brand-off-white disabled:opacity-35 disabled:hover:bg-transparent [&_svg]:h-[18px] [&_svg]:w-[18px]',
        pressed && 'bg-brand-purple text-white hover:bg-brand-purple-hover',
        className,
      )}
    >
      {children}
    </button>
  )
}
