import { useEffect, useState } from 'react'
import { normalizeSlug, resolveClient, type PortalClient } from '@/content/portals'
import { fetchPortalClient, fetchPortalClients, fallbackClients } from '@/lib/portalClients'
import { supabaseConfigured } from '@/lib/supabase'

type Status = 'loading' | 'ready' | 'missing'

/**
 * O cliente da página /portais/<slug>: vem do cadastro (banco) e, sem banco ou sem resposta, da lista de reserva.
 * Enquanto o banco responde, um cliente que existe na reserva já aparece; um desconhecido espera a resposta.
 */
export function usePortalClient(raw: string | undefined): { client: PortalClient | null; status: Status } {
  const slug = normalizeSlug(raw ?? '')
  const fallback = resolveClient(slug)
  const [state, setState] = useState<{ slug: string; client: PortalClient | null; status: Status }>(() => ({
    slug,
    client: fallback,
    status: supabaseConfigured ? (fallback ? 'ready' : 'loading') : fallback ? 'ready' : 'missing',
  }))

  useEffect(() => {
    if (!supabaseConfigured) return
    let alive = true
    fetchPortalClient(slug)
      .then((c) => {
        if (!alive) return
        if (c === undefined) return
        setState({ slug, client: c && c.active !== false ? c : null, status: c && c.active !== false ? 'ready' : 'missing' })
      })
      .catch(() => {
        if (!alive) return
        const fb = resolveClient(slug)
        setState({ slug, client: fb, status: fb ? 'ready' : 'missing' })
      })
    return () => {
      alive = false
    }
  }, [slug])

  // Slug trocado na mesma página: volta ao estado inicial daquele slug (derivado durante a renderização).
  if (state.slug !== slug) {
    const fb = resolveClient(slug)
    const next = { slug, client: fb, status: (supabaseConfigured ? (fb ? 'ready' : 'loading') : fb ? 'ready' : 'missing') as Status }
    setState(next)
    return { client: next.client, status: next.status }
  }
  return { client: state.client, status: state.status }
}

/** Todos os clientes ativos (para a lista da página "ambiente não encontrado"). */
export function usePortalClients(): PortalClient[] {
  const [list, setList] = useState<PortalClient[]>(() => fallbackClients())
  useEffect(() => {
    if (!supabaseConfigured) return
    let alive = true
    fetchPortalClients()
      .then((rows) => {
        if (alive && rows) setList(rows.filter((c) => c.active !== false))
      })
      .catch(() => {})
    return () => {
      alive = false
    }
  }, [])
  return list
}
