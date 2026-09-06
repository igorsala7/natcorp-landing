import { useEffect, useState } from 'react'
import type { ReactNode } from 'react'
import { IntroContext } from '@/hooks/useIntroDone'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { EASE, EASE_IN_OUT } from '@/lib/motion'
import { LOGO_MOTION_MS, LogoMotion } from '@/components/brand/LogoMotion'

const STORAGE_KEY = 'natcorp:intro'
/** A assinatura completa mais um respiro antes de a cortina subir. */
const HOLD_MS = LOGO_MOTION_MS + 350

function shouldShow() {
  if (typeof window === 'undefined') return false
  try {
    return window.sessionStorage.getItem(STORAGE_KEY) !== '1'
  } catch {
    return true
  }
}

/**
 * Sequência de abertura: os quatro módulos chegam e se encaixam, o raio rosa acende o X,
 * o wordmark surge ao lado e a cortina sobe revelando o hero. Uma vez por sessão; ignorada com movimento reduzido.
 */
export function IntroProvider({ children }: { children: ReactNode }) {
  const reduced = useReducedMotion()
  const [show, setShow] = useState(() => shouldShow() && !reduced)
  const [done, setDone] = useState(() => !(shouldShow() && !reduced))

  useEffect(() => {
    if (!show) return
    const root = document.documentElement
    root.style.overflow = 'hidden'
    const t = window.setTimeout(() => {
      setShow(false)
      setDone(true)
      root.style.overflow = ''
      try {
        window.sessionStorage.setItem(STORAGE_KEY, '1')
      } catch {
        /* armazenamento indisponível: apenas não persiste */
      }
    }, HOLD_MS)
    return () => {
      window.clearTimeout(t)
      root.style.overflow = ''
    }
  }, [show])

  return (
    <IntroContext.Provider value={done}>
      {children}
      <AnimatePresence>
        {show && (
          <m.div
            key="intro"
            aria-hidden
            className="fixed inset-0 z-[100] flex items-center justify-center bg-brand-blue"
            initial={{ y: 0 }}
            exit={{ y: '-100%', transition: { duration: 0.85, ease: EASE_IN_OUT } }}
          >
            <m.div exit={{ opacity: 0, y: -24, transition: { duration: 0.4, ease: EASE } }}>
              <LogoMotion tone="white" className="w-[min(80vw,520px)]" />
            </m.div>
          </m.div>
        )}
      </AnimatePresence>
    </IntroContext.Provider>
  )
}
