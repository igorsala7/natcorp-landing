import { useEffect } from 'react'
import Lenis from 'lenis'
import { useReducedMotion } from 'motion/react'
import { lenisStore } from '@/lib/lenisStore'

/**
 * Rolagem suave com Lenis. Desligada quando o usuário prefere menos movimento e no Safari
 * (desktop e iOS), onde a rolagem dirigida por JavaScript perde a rolagem assíncrona nativa e pesa.
 * A navegação por âncoras é tratada pelo ScrollManager (rotas + hash).
 */
const isSafari = () => {
  if (typeof navigator === 'undefined') return false
  const ua = navigator.userAgent
  return /Safari/i.test(ua) && !/Chrome|Chromium|CriOS|FxiOS|Edg|OPR|Android/i.test(ua)
}

export function SmoothScroll() {
  const reduced = useReducedMotion()

  useEffect(() => {
    if (reduced || isSafari()) return
    const lenis = new Lenis({
      lerp: 0.1,
      wheelMultiplier: 1,
      touchMultiplier: 1.4,
      autoRaf: true,
    })
    lenisStore.current = lenis
    return () => {
      lenis.destroy()
      lenisStore.current = null
    }
  }, [reduced])

  return null
}
