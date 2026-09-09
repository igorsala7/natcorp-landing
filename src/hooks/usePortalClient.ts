import { useMemo } from 'react'
import { portalClients, resolveClient, type PortalClient } from '@/content/portals'

/** O cliente da página /portais_beta/<slug>, do cadastro embutido no site (src/content/portals.json). */
export function usePortalClient(raw: string | undefined): PortalClient | null {
  return useMemo(() => resolveClient(raw), [raw])
}

/** Todos os clientes ativos, na ordem do cadastro (para a lista da página "ambiente não encontrado"). */
export function usePortalClients(): PortalClient[] {
  return useMemo(() => portalClients.filter((c) => c.active !== false), [])
}
