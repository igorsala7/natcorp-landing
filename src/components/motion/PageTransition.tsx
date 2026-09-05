import type { ReactNode } from 'react'
import { m } from 'motion/react'
import { EASE } from '@/lib/motion'

/** Transição de cena entre rotas: entra subindo, sai esmaecendo. */
export function PageTransition({ children }: { children: ReactNode }) {
  return (
    <m.div
      initial={{ opacity: 0, y: 14 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -8 }}
      transition={{ duration: 0.45, ease: EASE }}
    >
      {children}
    </m.div>
  )
}
