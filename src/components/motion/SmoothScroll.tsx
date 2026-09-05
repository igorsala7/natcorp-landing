import { useEffect } from 'react'
import Lenis from 'lenis'
import { useReducedMotion } from 'motion/react'

/**
 * Rolagem suave com Lenis. Desligada quando o usuário prefere menos movimento.
 * Âncoras (#secao) passam a rolar suavemente com compensação da barra fixa.
 */
export function SmoothScroll() {
  const reduced = useReducedMotion()

  useEffect(() => {
    if (reduced) return
    const lenis = new Lenis({
      lerp: 0.1,
      wheelMultiplier: 1,
      touchMultiplier: 1.4,
      anchors: { offset: -88 },
      autoRaf: true,
    })
    return () => lenis.destroy()
  }, [reduced])

  return null
}
