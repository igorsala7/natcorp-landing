import { useSyncExternalStore } from 'react'

function subscribe(query: string) {
  return (callback: () => void) => {
    const mql = window.matchMedia(query)
    mql.addEventListener('change', callback)
    return () => mql.removeEventListener('change', callback)
  }
}

export function useMediaQuery(query: string, serverFallback = false) {
  return useSyncExternalStore(
    subscribe(query),
    () => window.matchMedia(query).matches,
    () => serverFallback,
  )
}

/** Mouse/trackpad (não toque): usado para habilitar efeitos de cursor. */
export function useIsFinePointer() {
  return useMediaQuery('(pointer: fine)')
}

export function useIsDesktop() {
  return useMediaQuery('(min-width: 1024px)')
}
