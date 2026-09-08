import { createContext, useContext, useEffect, useState } from 'react'
import { loadModulePage, moduleRegistry } from '@/content/modulePages'
import type { ModulePage } from '@/content/modulePages/types'

/**
 * O conteúdo das páginas de módulo dentro da apresentação. É o mesmo conteúdo das páginas do
 * site (src/content/modulePages), carregado uma vez e guardado em memória: a apresentação
 * carrega tudo assim que abre, para que abrir a página de um módulo no meio de uma reunião
 * seja instantâneo.
 */

const cache = new Map<string, ModulePage>()
let pending: Promise<void> | null = null

export function preloadModulePages(): Promise<void> {
  pending ??= Promise.all(
    moduleRegistry.map(async (m) => {
      const page = await loadModulePage(m.slug)
      if (page) cache.set(m.slug, page)
    }),
  ).then(() => undefined)
  return pending
}

export const getModulePage = (slug: string) => cache.get(slug)

/** O id do slide de um módulo na exportação (usado também nas notas do PowerPoint). */
export const moduleSlideId = (slug: string) => `modulo-${slug}`

/** True quando o conteúdo de todos os módulos já está em memória. */
export function useModulePagesReady(): boolean {
  const [ready, setReady] = useState(() => cache.size === moduleRegistry.length)
  useEffect(() => {
    if (ready) return
    let alive = true
    void preloadModulePages().then(() => {
      if (alive) setReady(true)
    })
    return () => {
      alive = false
    }
  }, [ready])
  return ready
}

/** Abre a página de um módulo por cima da apresentação. Nulo quando não há para onde abrir (exportação, impressão). */
export const OpenModuleContext = createContext<((slug: string) => void) | null>(null)

export const useOpenModule = () => useContext(OpenModuleContext)
