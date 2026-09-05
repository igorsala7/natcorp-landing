import { useEffect, useLayoutEffect, useRef } from 'react'
import { useLocation, useNavigationType } from 'react-router'
import { lenisStore } from '@/lib/lenisStore'

const NAV_OFFSET = -88

export function scrollToElement(el: HTMLElement, immediate = false) {
  const lenis = lenisStore.current
  if (lenis) {
    // A página pode ter acabado de trocar: recalcula a altura antes de mirar no alvo.
    lenis.resize()
    lenis.scrollTo(el, { offset: NAV_OFFSET, immediate })
  } else {
    const top = el.getBoundingClientRect().top + window.scrollY + NAV_OFFSET
    window.scrollTo({ top, behavior: immediate ? 'auto' : 'smooth' })
  }
}

export function scrollToTop(immediate = true) {
  const lenis = lenisStore.current
  if (lenis) lenis.scrollTo(0, { immediate })
  else window.scrollTo({ top: 0, behavior: immediate ? 'auto' : 'smooth' })
}

/**
 * Sincroniza rolagem com a navegação: nova rota começa no topo; hash rola até a seção
 * (esperando o conteúdo carregar); "voltar" deixa o navegador restaurar a posição.
 */
export function ScrollManager() {
  const { pathname, hash, key } = useLocation()
  const navType = useNavigationType()
  const lastPath = useRef(pathname)

  useLayoutEffect(() => {
    if (hash || navType === 'POP') return
    scrollToTop(true)
  }, [pathname, key, hash, navType])

  useEffect(() => {
    const pageChanged = lastPath.current !== pathname
    lastPath.current = pathname
    if (!hash) return
    const id = decodeURIComponent(hash.slice(1))
    let cancelled = false
    let tries = 0
    // Em troca de página, espera a transição de cena terminar antes de rolar até a seção.
    const initialDelay = pageChanged ? 520 : 30
    const attempt = () => {
      if (cancelled) return
      const el = document.getElementById(id)
      if (el) {
        // Dois quadros para a transição de página assentar o layout.
        requestAnimationFrame(() => requestAnimationFrame(() => !cancelled && scrollToElement(el, navType === 'POP')))
      } else if (tries++ < 40) {
        window.setTimeout(attempt, 50)
      }
    }
    window.setTimeout(attempt, initialDelay)
    return () => {
      cancelled = true
    }
  }, [pathname, hash, key, navType])

  return null
}
