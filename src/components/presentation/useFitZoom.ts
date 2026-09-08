import { useLayoutEffect, useRef } from 'react'

/**
 * Em telas largas, o conteúdo do slide nunca é cortado: se ele for mais alto do que o espaço
 * disponível (projetor 1280x720, notebook com a barra do navegador), o bloco inteiro é
 * reduzido com `zoom` até caber. No celular o slide cresce e rola normalmente.
 */
export function useFitZoom(enabled: boolean) {
  const outer = useRef<HTMLDivElement>(null)
  const inner = useRef<HTMLDivElement>(null)
  useLayoutEffect(() => {
    const o = outer.current
    const i = inner.current
    if (!o || !i) return
    if (!enabled) {
      i.style.zoom = ''
      return
    }
    let raf = 0
    const printMedia = window.matchMedia('print')
    const measure = () => {
      i.style.zoom = '1'
      const section = o.closest<HTMLElement>('.deck-slide')
      // Na tela, o slide cresce junto com o conteúdo (min-height) e o espaço real é o da janela;
      // na impressão, a página tem altura fixa e o conteúdo transborda dentro dela.
      let excess = 0
      if (section) {
        excess = printMedia.matches ? section.scrollHeight - section.clientHeight : section.getBoundingClientRect().height - window.innerHeight
      }
      const cs = window.getComputedStyle(o)
      const avail = o.clientHeight - parseFloat(cs.paddingTop) - parseFloat(cs.paddingBottom) - Math.max(0, excess)
      const need = i.scrollHeight
      if (avail > 0 && need > avail) i.style.zoom = String(Math.max(0.5, Math.floor((avail / need) * 985) / 1000))
    }
    const fit = () => {
      window.cancelAnimationFrame(raf)
      raf = window.requestAnimationFrame(measure)
    }
    fit()
    const ro = new ResizeObserver(fit)
    ro.observe(o)
    void document.fonts?.ready.then(fit)
    // Antes de imprimir, mede de novo com as medidas da página (síncrono: a impressão não espera um quadro).
    window.addEventListener('beforeprint', measure)
    printMedia.addEventListener('change', measure)
    return () => {
      ro.disconnect()
      window.cancelAnimationFrame(raf)
      window.removeEventListener('beforeprint', measure)
      printMedia.removeEventListener('change', measure)
    }
  }, [enabled])
  return { outer, inner }
}
