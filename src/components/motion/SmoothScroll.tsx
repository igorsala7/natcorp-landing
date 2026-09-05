import { useEffect } from 'react'
import Lenis from 'lenis'
import { useReducedMotion } from 'motion/react'
import { lenisStore } from '@/lib/lenisStore'

/**
 * Rolagem suave com Lenis. Desligada quando o usuário prefere menos movimento.
 * A navegação por âncoras é tratada pelo ScrollManager (rotas + hash).
 */
export function SmoothScroll() {
  const reduced = useReducedMotion()

  useEffect(() => {
    if (reduced) return
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
