import { useEffect, useRef, useState } from 'react'
import { AnimatePresence, m } from 'motion/react'
import { ArrowRight, ChevronDown, Menu, X } from 'lucide-react'
import { Link, useLocation } from 'react-router'
import { Button } from '@/components/ui/button'
import { Logo } from '@/components/brand/Logo'
import { useScrolled } from '@/hooks/useScrolled'
import { navLinks } from '@/content/site'
import { getGroup, groups, modulePath, modulesByGroup } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

/** Colunas do mega-menu: grupos pequenos compartilham coluna. */
const menuColumns: GroupId[][] = [
  ['pessoal-e-folha'],
  ['ponto-e-jornada', 'saude-e-seguranca'],
  ['talentos'],
  ['desenvolvimento'],
  ['autoatendimento'],
  ['dados-ia-plataforma'],
]

const prefetchModulePage = () => {
  void import('@/pages/ModulePage')
}

export function Navbar() {
  const scrolled = useScrolled(32)
  const { pathname } = useLocation()
  const isHome = pathname === '/'
  const [open, setOpen] = useState(false)
  const [mega, setMega] = useState(false)
  const [mobileModules, setMobileModules] = useState(false)
  const headerRef = useRef<HTMLElement>(null)
  const closeTimer = useRef(0)

  const solid = !isHome || scrolled || open || mega
  const onDark = !solid

  useEffect(() => {
    if (!open && !mega) return
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setOpen(false)
        setMega(false)
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [open, mega])

  useEffect(() => {
    if (!mega) return
    const onDown = (e: PointerEvent) => {
      if (!headerRef.current?.contains(e.target as Node)) setMega(false)
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
    setMega(false)
  }

  const openMega = () => {
    window.clearTimeout(closeTimer.current)
    prefetchModulePage()
    setMega(true)
  }
  const scheduleClose = () => {
    window.clearTimeout(closeTimer.current)
    closeTimer.current = window.setTimeout(() => setMega(false), 180)
  }

  const linkClass = cn(
    'rounded-lg px-3.5 py-2 text-[14px] font-semibold transition-colors duration-300',
    onDark ? 'text-white/85 hover:bg-white/10 hover:text-white' : 'text-brand-ink/80 hover:bg-brand-off-white hover:text-brand-purple',
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
          <Link to={{ pathname: '/', hash: '#plataforma' }} onClick={closeAll} className={linkClass}>
            Plataforma
          </Link>
          <button
            type="button"
            className={cn(linkClass, 'inline-flex items-center gap-1', mega && !onDark && 'bg-brand-off-white text-brand-purple')}
            aria-expanded={mega}
            aria-controls="menu-modulos"
            onPointerEnter={(e) => e.pointerType === 'mouse' && openMega()}
            onPointerLeave={(e) => e.pointerType === 'mouse' && scheduleClose()}
            onClick={() => (mega ? setMega(false) : openMega())}
          >
            Módulos
            <ChevronDown className={cn('h-4 w-4 transition-transform duration-300', mega && 'rotate-180')} aria-hidden />
          </button>
          {navLinks
            .filter((l) => l.hash !== '#plataforma')
            .map((l) => (
              <Link key={l.hash} to={{ pathname: '/', hash: l.hash }} onClick={closeAll} className={linkClass}>
                {l.label}
              </Link>
            ))}
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

      {/* Mega-menu de módulos (desktop) */}
      <AnimatePresence>
        {mega && (
          <m.div
            id="menu-modulos"
            key="mega"
            className="absolute inset-x-0 top-full hidden border-t border-brand-mist bg-white shadow-lift lg:block"
            initial={{ opacity: 0, y: -6 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -6 }}
            transition={{ duration: 0.25, ease: EASE }}
            onPointerEnter={(e) => e.pointerType === 'mouse' && openMega()}
            onPointerLeave={(e) => e.pointerType === 'mouse' && scheduleClose()}
          >
            <div className="container py-7">
              <div className="grid grid-cols-3 gap-x-6 gap-y-8 xl:grid-cols-6">
                {menuColumns.map((col, ci) => (
                  <div key={ci} className="space-y-7">
                    {col.map((gid) => {
                      const g = getGroup(gid)
                      return (
                        <div key={gid}>
                          <Link
                            to={`/modulos#${gid}`}
                            onClick={closeAll}
                            className="mb-2.5 block text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple hover:underline"
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
                                    className="group/item flex items-center gap-2 rounded-md px-2 py-1.5 text-[13.5px] font-medium text-brand-ink transition-colors hover:bg-brand-off-white hover:text-brand-purple"
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
              <div className="mt-6 flex items-center justify-between border-t border-brand-mist pt-4">
                <p className="text-sm text-brand-graphite">Mais de 30 módulos. Um único sistema, uma única base de dados.</p>
                <Link to="/modulos" onClick={closeAll} className="group inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple">
                  Ver todos os módulos
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
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
                <Link to={{ pathname: '/', hash: '#plataforma' }} onClick={closeAll} className="block rounded-lg px-3 py-3 text-base font-semibold text-brand-ink hover:bg-brand-off-white hover:text-brand-purple">
                  Plataforma
                </Link>
              </li>
              <li>
                <button
                  type="button"
                  className="flex w-full items-center justify-between rounded-lg px-3 py-3 text-base font-semibold text-brand-ink hover:bg-brand-off-white hover:text-brand-purple"
                  aria-expanded={mobileModules}
                  aria-controls="menu-mobile-modulos"
                  onClick={() => setMobileModules((v) => !v)}
                >
                  Módulos
                  <ChevronDown className={cn('h-5 w-5 transition-transform duration-300', mobileModules && 'rotate-180')} aria-hidden />
                </button>
                <AnimatePresence initial={false}>
                  {mobileModules && (
                    <m.div
                      id="menu-mobile-modulos"
                      initial={{ height: 0, opacity: 0 }}
                      animate={{ height: 'auto', opacity: 1 }}
                      exit={{ height: 0, opacity: 0 }}
                      transition={{ duration: 0.3, ease: EASE }}
                      className="overflow-hidden"
                    >
                      <div className="space-y-4 px-3 pb-3 pt-1">
                        {groups.map((g) => (
                          <div key={g.id}>
                            <p className="mb-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{g.name}</p>
                            <ul>
                              {modulesByGroup(g.id).map((mod) => (
                                <li key={mod.slug}>
                                  <Link to={modulePath(mod.slug)} onClick={closeAll} className="block rounded-md py-1.5 text-[15px] font-medium text-brand-ink/85 hover:text-brand-purple">
                                    {mod.name}
                                  </Link>
                                </li>
                              ))}
                            </ul>
                          </div>
                        ))}
                        <Link to="/modulos" onClick={closeAll} className="inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple">
                          Ver todos os módulos
                          <ArrowRight className="h-4 w-4" aria-hidden />
                        </Link>
                      </div>
                    </m.div>
                  )}
                </AnimatePresence>
              </li>
              {navLinks
                .filter((l) => l.hash !== '#plataforma')
                .map((l) => (
                  <li key={l.hash}>
                    <Link to={{ pathname: '/', hash: l.hash }} onClick={closeAll} className="block rounded-lg px-3 py-3 text-base font-semibold text-brand-ink hover:bg-brand-off-white hover:text-brand-purple">
                      {l.label}
                    </Link>
                  </li>
                ))}
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
