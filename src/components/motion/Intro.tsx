import { useEffect, useState } from 'react'
import type { ReactNode } from 'react'
import { IntroContext } from '@/hooks/useIntroDone'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { EASE, EASE_IN_OUT } from '@/lib/motion'
import { H_WIDTH, MODULES, SYMBOL_BOX, WORDMARK_H } from '@/components/brand/logo-paths'

const STORAGE_KEY = 'natcorp:intro'
const HOLD_MS = 1450

function shouldShow() {
  if (typeof window === 'undefined') return false
  try {
    return window.sessionStorage.getItem(STORAGE_KEY) !== '1'
  } catch {
    return true
  }
}

/**
 * Sequência de abertura: os quatro módulos do símbolo se encaixam, o wordmark surge,
 * e a cortina sobe revelando o hero. Uma vez por sessão; ignorada com movimento reduzido.
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
              <IntroMark />
            </m.div>
          </m.div>
        )}
      </AnimatePresence>
    </IntroContext.Provider>
  )
}

function IntroMark() {
  return (
    <svg viewBox={`0 0 ${H_WIDTH} ${SYMBOL_BOX}`} className="w-[min(60vw,320px)]" aria-hidden>
      {MODULES.map((d, i) => (
        <m.path
          key={i}
          d={d}
          fill="#ffffff"
          style={{ transformOrigin: 'center', transformBox: 'fill-box' }}
          initial={{ opacity: 0, scale: 0.4 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.6, ease: EASE, delay: 0.12 + i * 0.09 }}
        />
      ))}
      {WORDMARK_H.map((d, i) => (
        <m.path
          key={i}
          d={d}
          fill="#ffffff"
          initial={{ opacity: 0, x: -0.6 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.55, ease: EASE, delay: 0.5 + i * 0.04 }}
        />
      ))}
    </svg>
  )
}
