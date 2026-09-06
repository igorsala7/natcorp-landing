import { useEffect, useRef, useState } from 'react'
import { AnimatePresence, m } from 'motion/react'
import {
  ArrowRight,
  Banknote,
  Building2,
  CircleHelp,
  Network,
  Receipt,
  ChevronDown,
  ChevronRight,
  Handshake,
  LayoutGrid,
  Mail,
  Menu,
  PieChart,
  PlayCircle,
  Route,
  ScanFace,
  ShieldCheck,
  Sparkles,
  SquareStack,
  Trophy,
  Users,
  X,
} from 'lucide-react'
import type { LucideIcon } from 'lucide-react'
import { Link, useLocation } from 'react-router'
import { Button } from '@/components/ui/button'
import { Logo } from '@/components/brand/Logo'
import { useScrolled } from '@/hooks/useScrolled'
import { companyLinks, paths, systemLinks, type NavLink } from '@/content/site'
import { getGroup, groups, modulePath, modulesByGroup } from '@/content/modulePages'
import { segmentIcons, segmentPath, segmentRegistry, segmentsPath } from '@/content/segments'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

/** Colunas do mega-menu de módulos: grupos pequenos compartilham coluna. */
const menuColumns: GroupId[][] = [
  ['pessoal-e-folha'],
  ['ponto-e-jornada', 'saude-e-seguranca'],
  ['talentos', 'desenvolvimento'],
  ['autoatendimento'],
  ['dados-ia-plataforma'],
]

/** Ícones das entradas gerais dos menus, por destino. */
const linkIcons: Record<string, LucideIcon> = {
  [paths.system]: LayoutGrid,
  [paths.structures]: Network,
  [paths.faq]: CircleHelp,
  [paths.commercial]: Receipt,
  [paths.modules]: SquareStack,
  [paths.security]: ShieldCheck,
  [paths.portals]: Users,
  [paths.journey]: Route,
  [paths.nati]: Sparkles,
  '/modulos/natponto': ScanFace,
  '/modulos/natpay': Banknote,
  '/modulos/people-analytics': PieChart,
  [paths.about]: Building2,
  [`${paths.about}#reconhecimento`]: Trophy,
  [`${paths.about}#servicos`]: Handshake,
  [`${paths.about}#videos`]: PlayCircle,
  [paths.contact]: Mail,
}

const prefetchModulePage = () => {
  void import('@/pages/ModulePage')
}
const prefetchSegmentPage = () => {
  void import('@/pages/SegmentPage')
}

type MegaMenu = 'sistema' | 'segmentos' | 'empresa' | null
type MobileGroup = Exclude<MegaMenu, null>

const megaLabels: Record<MobileGroup, string> = { sistema: 'Sistema', segmentos: 'Segmentos', empresa: 'Empresa' }

function MenuLinkCard({ link, onClick, className, compact = false }: { link: NavLink; onClick: () => void; className?: string; compact?: boolean }) {
  const Icon = linkIcons[link.to] ?? ChevronRight
  return (
    <Link
      to={link.to}
      onClick={onClick}
      title={compact ? link.short : undefined}
      className={cn('group/card flex items-start gap-3 rounded-xl px-3 transition-colors duration-300 hover:bg-brand-off-white', compact ? 'items-center py-1.5' : 'py-2.5', className)}
    >
      <span className={cn('flex shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple transition-colors duration-300 group-hover/card:bg-brand-purple group-hover/card:text-white', compact ? 'h-7 w-7' : 'h-9 w-9')}>
        <Icon className={compact ? 'h-3.5 w-3.5' : 'h-4.5 w-4.5'} strokeWidth={1.7} aria-hidden />
      </span>
      <span className="min-w-0">
        <span className="block text-[14px] font-bold leading-snug text-brand-ink transition-colors group-hover/card:text-brand-purple">{link.label}</span>
        {!compact && link.short && <span className="mt-0.5 block text-[12.5px] leading-snug text-brand-graphite">{link.short}</span>}
      </span>
    </Link>
  )
}

export function Navbar() {
  const scrolled = useScrolled(32)
  const { pathname } = useLocation()
  const isHome = pathname === '/'
  const [open, setOpen] = useState(false)
  const [mega, setMega] = useState<MegaMenu>(null)
  const [mobileGroup, setMobileGroup] = useState<MobileGroup | null>(null)
  const headerRef = useRef<HTMLElement>(null)
  const closeTimer = useRef(0)

  const solid = !isHome || scrolled || open || mega !== null
  const onDark = !solid

  useEffect(() => {
    if (!open && !mega) return
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setOpen(false)
        setMega(null)
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [open, mega])

  useEffect(() => {
    if (!mega) return
    const onDown = (e: PointerEvent) => {
      if (!headerRef.current?.contains(e.target as Node)) setMega(null)
    }
    document.addEventListener('pointerdown', onDown)
    return () => document.removeEventListener('pointerdown', onDown)
  }, [mega])

  useEffect(() => {
    const mql = window.matchMedia('(min-width: 1024px)')
    const close = () => mql.matches && setOpen(false)
    mql.addEventListener('change', close)
    return () => mql.removeEventListener('change', close)
  }, [])

  const closeAll = () => {
    setOpen(false)
    setMega(null)
  }

  const openMega = (which: MobileGroup) => {
    window.clearTimeout(closeTimer.current)
    if (which === 'sistema') prefetchModulePage()
    if (which === 'segmentos') prefetchSegmentPage()
    setMega(which)
  }
  const scheduleClose = () => {
    window.clearTimeout(closeTimer.current)
    closeTimer.current = window.setTimeout(() => setMega(null), 180)
  }

  const linkClass = cn(
    'rounded-lg px-3.5 py-2 text-[14px] font-semibold transition-colors duration-300',
    onDark ? 'text-white/85 hover:bg-white/10 hover:text-white' : 'text-brand-ink/80 hover:bg-brand-off-white hover:text-brand-purple',
  )

  const megaButton = (which: MobileGroup) => (
    <button
      type="button"
      className={cn(linkClass, 'inline-flex items-center gap-1', mega === which && !onDark && 'bg-brand-off-white text-brand-purple')}
      aria-expanded={mega === which}
      aria-controls={`menu-${which}`}
      onPointerEnter={(e) => e.pointerType === 'mouse' && openMega(which)}
      onPointerLeave={(e) => e.pointerType === 'mouse' && scheduleClose()}
      onClick={() => (mega === which ? setMega(null) : openMega(which))}
    >
      {megaLabels[which]}
      <ChevronDown className={cn('h-4 w-4 transition-transform duration-300', mega === which && 'rotate-180')} aria-hidden />
    </button>
  )

  const panelProps = (which: MobileGroup) => ({
    id: `menu-${which}`,
    className: 'absolute inset-x-0 top-full hidden border-t border-brand-mist bg-white shadow-lift lg:block',
    initial: { opacity: 0, y: -6 },
    animate: { opacity: 1, y: 0 },
    exit: { opacity: 0, y: -6 },
    transition: { duration: 0.25, ease: EASE },
    onPointerEnter: (e: React.PointerEvent) => e.pointerType === 'mouse' && openMega(which),
    onPointerLeave: (e: React.PointerEvent) => e.pointerType === 'mouse' && scheduleClose(),
  })

  const mobileItem = 'block rounded-lg px-3 py-3 text-base font-semibold text-brand-ink hover:bg-brand-off-white hover:text-brand-purple'
  const mobileSub = 'block rounded-md py-1.5 text-[15px] font-medium text-brand-ink/85 hover:text-brand-purple'

  const mobileToggle = (which: MobileGroup) => (
    <button
      type="button"
      className="flex w-full items-center justify-between rounded-lg px-3 py-3 text-base font-semibold text-brand-ink hover:bg-brand-off-white hover:text-brand-purple"
      aria-expanded={mobileGroup === which}
      aria-controls={`menu-mobile-${which}`}
      onClick={() => setMobileGroup((v) => (v === which ? null : which))}
    >
      {megaLabels[which]}
      <ChevronDown className={cn('h-5 w-5 transition-transform duration-300', mobileGroup === which && 'rotate-180')} aria-hidden />
    </button>
  )

  const mobilePanel = (which: MobileGroup, children: React.ReactNode) => (
    <AnimatePresence initial={false}>
      {mobileGroup === which && (
        <m.div
          id={`menu-mobile-${which}`}
          initial={{ height: 0, opacity: 0 }}
          animate={{ height: 'auto', opacity: 1 }}
          exit={{ height: 0, opacity: 0 }}
          transition={{ duration: 0.3, ease: EASE }}
          className="overflow-hidden"
        >
          <div className="space-y-4 px-3 pb-3 pt-1">{children}</div>
        </m.div>
      )}
    </AnimatePresence>
  )

  return (
    <header
      ref={headerRef}
      className={cn(
        'fixed inset-x-0 top-0 z-50 transition-[background-color,box-shadow] duration-500 ease-brand',
        solid ? 'bg-white/85 shadow-[0_1px_0_0_#E9E5F1] backdrop-blur-xl supports-[backdrop-filter]:bg-white/80' : 'bg-transparent',
      )}
    >
      <div className="container flex h-[var(--nav-h)] items-center justify-between gap-6">
        <Link to="/" onClick={closeAll} className="flex shrink-0 items-center rounded-md" aria-label="Natcorp — página inicial">
          <Logo tone={onDark ? 'white' : 'gradient'} className="h-9 w-auto transition-opacity duration-300 lg:h-10" />
        </Link>

        <nav className="hidden items-center gap-1 lg:flex" aria-label="Navegação principal">
          {megaButton('sistema')}
          <Link to={paths.nati} onClick={closeAll} className={linkClass}>
            NATI
          </Link>
          {megaButton('segmentos')}
          {megaButton('empresa')}
          <Link to={paths.contact} onClick={closeAll} className={linkClass}>
            Contato
          </Link>
        </nav>

        <div className="hidden items-center gap-3 lg:flex">
          <Button asChild variant={onDark ? 'inverse' : 'default'} className="px-5">
            <Link to="#contato" onClick={closeAll}>
              Agendar demonstração
              <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
            </Link>
          </Button>
        </div>

        <button
          type="button"
          className={cn(
            'inline-flex h-11 w-11 items-center justify-center rounded-lg transition-colors lg:hidden',
            onDark ? 'text-white hover:bg-white/10' : 'text-brand-ink hover:bg-brand-off-white',
          )}
          aria-expanded={open}
          aria-controls="menu-mobile"
          aria-label={open ? 'Fechar menu' : 'Abrir menu'}
          onClick={() => setOpen((v) => !v)}
        >
          {open ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
        </button>
      </div>

      {/* Mega-menu "Sistema" (desktop): entradas gerais, produtos e os módulos por grupo */}
      <AnimatePresence>
        {mega === 'sistema' && (
          <m.div key="mega-sistema" {...panelProps('sistema')}>
            <div className="container py-7">
              <div className="grid grid-cols-[15.5rem_1fr] gap-x-8">
                <div className="border-r border-brand-mist pr-6">
                  <div>
                    <p className="mb-2 px-3 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple">O sistema</p>
                    <div className="space-y-0.5">
                      {systemLinks.map((l) => (
                        <MenuLinkCard key={l.to} link={l} onClick={closeAll} />
                      ))}
                    </div>
                  </div>
                </div>
                <div className="grid grid-cols-3 gap-x-6 gap-y-7 xl:grid-cols-5">
                  {menuColumns.map((col, ci) => (
                    <div key={ci} className="space-y-6">
                      {col.map((gid) => {
                        const g = getGroup(gid)
                        return (
                          <div key={gid}>
                            <Link
                              to={`${paths.modules}#${gid}`}
                              onClick={closeAll}
                              className="mb-2 block text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple hover:underline"
                            >
                              {g.name}
                            </Link>
                            <ul className="space-y-0.5">
                              {modulesByGroup(gid).map((mod) => {
                                const Icon = moduleIcons[mod.icon]
                                return (
                                  <li key={mod.slug}>
                                    <Link
                                      to={modulePath(mod.slug)}
                                      onClick={closeAll}
                                      className="group/item flex items-center gap-2 rounded-md px-2 py-1 text-[13px] font-medium text-brand-ink transition-colors hover:bg-brand-off-white hover:text-brand-purple"
                                      title={mod.short}
                                    >
                                      <Icon className="h-4 w-4 shrink-0 text-brand-gray transition-colors group-hover/item:text-brand-purple" strokeWidth={1.6} aria-hidden />
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
                  ))}
                </div>
              </div>
              <div className="mt-6 flex items-center justify-between border-t border-brand-mist pt-4">
                <p className="text-sm text-brand-graphite">31 módulos. Um único sistema, uma única base de dados.</p>
                <Link to={paths.modules} onClick={closeAll} className="group inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple">
                  Ver todos os módulos
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
              </div>
            </div>
          </m.div>
        )}
      </AnimatePresence>

      {/* Mega-menu de segmentos (desktop) */}
      <AnimatePresence>
        {mega === 'segmentos' && (
          <m.div key="mega-segmentos" {...panelProps('segmentos')}>
            <div className="container py-7">
              <div className="grid grid-cols-2 gap-x-8 gap-y-1 xl:grid-cols-3">
                {segmentRegistry.map((s) => {
                  const Icon = segmentIcons[s.icon]
                  return (
                    <Link
                      key={s.slug}
                      to={segmentPath(s.slug)}
                      onClick={closeAll}
                      className="group/seg flex items-center gap-3 rounded-xl px-3 py-3 transition-colors duration-300 hover:bg-brand-off-white"
                    >
                      <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple transition-colors duration-300 group-hover/seg:bg-brand-purple group-hover/seg:text-white">
                        <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                      </span>
                      <span className="min-w-0 flex-1">
                        <span className="flex items-center gap-1.5 text-[15px] font-bold text-brand-ink transition-colors group-hover/seg:text-brand-purple">
                          {s.label}
                          <ChevronRight className="h-4 w-4 text-brand-gray transition-transform duration-300 group-hover/seg:translate-x-0.5" aria-hidden />
                        </span>
                        <span className="block truncate text-[12.5px] text-brand-graphite">{s.short}</span>
                      </span>
                    </Link>
                  )
                })}
              </div>
              <div className="mt-6 flex items-center justify-between border-t border-brand-mist pt-4">
                <p className="text-sm text-brand-graphite">Cada segmento tem a sua realidade de RH. O sistema se adapta a ela.</p>
                <Link to={segmentsPath} onClick={closeAll} className="group inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple">
                  Ver todos os segmentos
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
              </div>
            </div>
          </m.div>
        )}
      </AnimatePresence>

      {/* Menu "Empresa" (desktop) */}
      <AnimatePresence>
        {mega === 'empresa' && (
          <m.div key="mega-empresa" {...panelProps('empresa')}>
            <div className="container py-6">
              <div className="grid grid-cols-3 gap-2 xl:grid-cols-5">
                {companyLinks.map((l) => (
                  <MenuLinkCard key={l.to} link={l} onClick={closeAll} />
                ))}
              </div>
            </div>
          </m.div>
        )}
      </AnimatePresence>

      {/* Menu (celular) */}
      <AnimatePresence>
        {open && (
          <m.nav
            id="menu-mobile"
            key="menu"
            aria-label="Navegação principal (celular)"
            className="max-h-[calc(100dvh-var(--nav-h))] overflow-y-auto border-t border-brand-mist bg-white px-5 pb-6 pt-3 lg:hidden"
            initial={{ opacity: 0, y: -8 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -8 }}
            transition={{ duration: 0.28, ease: EASE }}
          >
            <ul className="space-y-1">
              <li>
                {mobileToggle('sistema')}
                {mobilePanel(
                  'sistema',
                  <>
                    <ul>
                      {systemLinks.map((l) => (
                        <li key={l.to}>
                          <Link to={l.to} onClick={closeAll} className={mobileSub}>
                            {l.label}
                          </Link>
                        </li>
                      ))}
                    </ul>
                    {groups.map((g) => (
                      <div key={g.id}>
                        <p className="mb-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{g.name}</p>
                        <ul>
                          {modulesByGroup(g.id).map((mod) => (
                            <li key={mod.slug}>
                              <Link to={modulePath(mod.slug)} onClick={closeAll} className={mobileSub}>
                                {mod.name}
                              </Link>
                            </li>
                          ))}
                        </ul>
                      </div>
                    ))}
                    <Link to={paths.modules} onClick={closeAll} className="inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple">
                      Ver todos os módulos
                      <ArrowRight className="h-4 w-4" aria-hidden />
                    </Link>
                  </>,
                )}
              </li>
              <li>
                <Link to={paths.nati} onClick={closeAll} className={mobileItem}>
                  NATI
                </Link>
              </li>
              <li>
                {mobileToggle('segmentos')}
                {mobilePanel(
                  'segmentos',
                  <ul>
                    {segmentRegistry.map((s) => (
                      <li key={s.slug}>
                        <Link to={segmentPath(s.slug)} onClick={closeAll} className={mobileSub}>
                          {s.label}
                        </Link>
                      </li>
                    ))}
                    <li className="pt-2">
                      <Link to={segmentsPath} onClick={closeAll} className="inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple">
                        Ver todos os segmentos
                        <ArrowRight className="h-4 w-4" aria-hidden />
                      </Link>
                    </li>
                  </ul>,
                )}
              </li>
              <li>
                {mobileToggle('empresa')}
                {mobilePanel(
                  'empresa',
                  <ul>
                    {companyLinks.map((l) => (
                      <li key={l.to}>
                        <Link to={l.to} onClick={closeAll} className={mobileSub}>
                          {l.label}
                        </Link>
                      </li>
                    ))}
                  </ul>,
                )}
              </li>
              <li>
                <Link to={paths.contact} onClick={closeAll} className={mobileItem}>
                  Contato
                </Link>
              </li>
            </ul>
            <Button asChild size="lg" className="mt-4 w-full">
              <Link to="#contato" onClick={closeAll}>
                Agendar demonstração
                <ArrowRight />
              </Link>
            </Button>
          </m.nav>
        )}
      </AnimatePresence>
    </header>
  )
}
