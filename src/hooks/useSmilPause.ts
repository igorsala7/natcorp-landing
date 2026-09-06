import { useEffect, type RefObject } from 'react'

/**
 * Pausa as animações SMIL de um SVG enquanto ele está fora da tela ou a aba está escondida.
 * SMIL continua rodando (e repintando) mesmo sem ser visto, o que pesa em páginas longas,
 * principalmente no Safari. Volta a rodar quando o SVG se aproxima da área visível.
 */
export function useSmilPause(ref: RefObject<SVGSVGElement | null>, margin = '200px 0px') {
  useEffect(() => {
    const svg = ref.current
    if (!svg || typeof IntersectionObserver === 'undefined' || typeof svg.pauseAnimations !== 'function') return
    let near = true
    const sync = () => {
      if (near && !document.hidden) svg.unpauseAnimations()
      else svg.pauseAnimations()
    }
    const io = new IntersectionObserver(
      (entries) => {
        near = entries.some((e) => e.isIntersecting)
        sync()
      },
      { rootMargin: margin },
    )
    io.observe(svg)
    document.addEventListener('visibilitychange', sync)
    return () => {
      io.disconnect()
      document.removeEventListener('visibilitychange', sync)
      svg.unpauseAnimations()
    }
  }, [ref, margin])
}
