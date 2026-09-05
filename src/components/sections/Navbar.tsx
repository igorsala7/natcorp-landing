import { useEffect, useState } from 'react'
import { AnimatePresence, m } from 'motion/react'
import { ArrowRight, Menu, X } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Logo } from '@/components/brand/Logo'
import { useScrolled } from '@/hooks/useScrolled'
import { navLinks } from '@/content/site'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

export function Navbar() {
  const scrolled = useScrolled(32)
  const [open, setOpen] = useState(false)
  const onDark = !scrolled && !open

  useEffect(() => {
    if (!open) return
    const onKey = (e: KeyboardEvent) => e.key === 'Escape' && setOpen(false)
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [open])

  useEffect(() => {
    const mql = window.matchMedia('(min-width: 1024px)')
    const close = () => mql.matches && setOpen(false)
    mql.addEventListener('change', close)
    return () => mql.removeEventListener('change', close)
  }, [])

  return (
    <header
      className={cn(
        'fixed inset-x-0 top-0 z-50 transition-[background-color,box-shadow] duration-500 ease-brand',
        scrolled || open
          ? 'bg-white/85 shadow-[0_1px_0_0_#E9E5F1] backdrop-blur-xl supports-[backdrop-filter]:bg-white/75'
          : 'bg-transparent',
      )}
    >
      <div className="container flex h-[var(--nav-h)] items-center justify-between gap-6">
        <a href="#top" className="flex shrink-0 items-center rounded-md" aria-label="Natcorp — início">
          <Logo tone={onDark ? 'white' : 'gradient'} className="h-8 w-auto transition-opacity duration-300" />
        </a>

        <nav className="hidden items-center gap-1 lg:flex" aria-label="Navegação principal">
          {navLinks.map((l) => (
            <a
              key={l.href}
              href={l.href}
              className={cn(
                'rounded-lg px-3.5 py-2 text-[14px] font-semibold transition-colors duration-300',
                onDark ? 'text-white/85 hover:bg-white/10 hover:text-white' : 'text-brand-ink/80 hover:bg-brand-off-white hover:text-brand-purple',
              )}
            >
              {l.label}
            </a>
          ))}
        </nav>

        <div className="hidden items-center gap-3 lg:flex">
          <Button asChild variant={onDark ? 'inverse' : 'default'} className="px-5">
            <a href="#contato">
              Agendar demonstração
              <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
            </a>
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

      <AnimatePresence>
        {open && (
          <m.nav
            id="menu-mobile"
            key="menu"
            aria-label="Navegação principal (celular)"
            className="border-t border-brand-mist bg-white px-5 pb-6 pt-3 lg:hidden"
            initial={{ opacity: 0, y: -8 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -8 }}
            transition={{ duration: 0.28, ease: EASE }}
          >
            <ul className="space-y-1">
              {navLinks.map((l, i) => (
                <m.li
                  key={l.href}
                  initial={{ opacity: 0, x: -8 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.3, ease: EASE, delay: 0.04 * i }}
                >
                  <a
                    href={l.href}
                    className="block rounded-lg px-3 py-3 text-base font-semibold text-brand-ink hover:bg-brand-off-white hover:text-brand-purple"
                    onClick={() => setOpen(false)}
                  >
                    {l.label}
                  </a>
                </m.li>
              ))}
            </ul>
            <Button asChild size="lg" className="mt-4 w-full">
              <a href="#contato" onClick={() => setOpen(false)}>
                Agendar demonstração
                <ArrowRight />
              </a>
            </Button>
          </m.nav>
        )}
      </AnimatePresence>
    </header>
  )
}
