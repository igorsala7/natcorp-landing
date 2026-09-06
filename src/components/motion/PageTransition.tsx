import type { ReactNode } from 'react'
import { m } from 'motion/react'
import { useLocation } from 'react-router'
import { EASE } from '@/lib/motion'

/**
 * Transição de cena entre rotas: entra subindo, sai esmaecendo.
 * No primeiro carregamento (location.key === 'default') a página aparece sem transição,
 * para que só as animações de entrada de cada seção rodem. Antes isso era feito com
 * `initial={false}` no AnimatePresence, o que desligava também o estado inicial de todos
 * os blocos `Reveal`/`Stagger` da primeira página carregada.
 */
export function PageTransition({ children }: { children: ReactNode }) {
  const firstLoad = useLocation().key === 'default'
  return (
    <m.div
      initial={firstLoad ? false : { opacity: 0, y: 14 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -8 }}
      transition={{ duration: 0.45, ease: EASE }}
    >
      {children}
    </m.div>
  )
}
