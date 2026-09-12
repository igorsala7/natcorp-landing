import { useEffect, useState } from 'react'
import type { ReactNode } from 'react'
import { IntroContext } from '@/hooks/useIntroDone'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { EASE, EASE_IN_OUT } from '@/lib/motion'
import { LOGO_MOTION_MS, LogoMotion } from '@/components/brand/LogoMotion'

const STORAGE_KEY = 'natcorp:intro'
/** A assinatura completa mais um respiro antes de a cortina subir. */
const HOLD_MS = LOGO_MOTION_MS + 450

/**
 * Páginas de trabalho abrem direto, sem a assinatura.
 *
 * A porta de entrada dos portais (/portais/<cliente> e /portais/dev/<cliente>)
 * e a administração (/admin/...): quem chega ali quer entrar no sistema. A documentação
 * de publicação (/hospedagem): quem abre o link está com o servidor na mão. E '/animatic',
 * TEMPORÁRIO, porque a abertura atrapalharia a fotografia dos quadros.
 */
function skipsIntro() {
  const where = `${window.location.pathname}${window.location.hash}`
  return (
    /(^|#)\/portais\/(dev\/)?[^/]+\/?$/.test(where) ||
    /(^|#)\/admin(\/|$)/.test(where) ||
    /(^|#)\/hospedagem\/?$/.test(where) ||
    /(^|#)\/animatic/.test(where) ||
    // Documentos legais: quem abre a política de privacidade está no meio de uma
    // tarefa — quer exercer um direito ou conferir uma cláusula. Uma abertura de
    // marca antes disso é atrito, não boas-vindas.
    /(^|#)\/(privacidade|termos-de-uso|politica-de-cookies)\/?$/.test(where)
  )
}

function shouldShow() {
  if (typeof window === 'undefined') return false
  if (skipsIntro()) return false
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
            className="fixed inset-0 z-[100] flex items-center justify-center bg-white bg-[radial-gradient(ellipse_at_center,#FFFFFF_0%,#F4F2F7_55%,#E9E5F1_100%)]"
            initial={{ y: 0 }}
            exit={{ y: '-100%', transition: { duration: 0.85, ease: EASE_IN_OUT } }}
          >
            <m.div exit={{ opacity: 0, y: -24, transition: { duration: 0.4, ease: EASE } }}>
              <LogoMotion tone="gradient" className="w-[min(86vw,640px)]" />
            </m.div>
          </m.div>
        )}
      </AnimatePresence>
    </IntroContext.Provider>
  )
}
