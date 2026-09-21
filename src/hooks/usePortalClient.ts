import { useEffect, useState } from 'react'
import { normalizeSlug, type PortalClient } from '@/content/portals'

/**
 * Os dados do cliente da página /portais/<slug>, buscados em tempo de execução.
 *
 * POR QUE NÃO VEM DO PACOTE. O cadastro inteiro morava dentro do JavaScript do
 * site e podia ser lido por qualquer visitante — os sete clientes com código,
 * servidor do APEX e endereços. Retirado em 21/09/2026 a pedido do dono:
 * "JAMAIS pode expor essas informações".
 *
 * Agora cada cliente tem o próprio arquivo, em /portais/dados/<slug>.json, e a
 * página carrega SÓ o dela. Quem não souber o nome do cliente não tem de onde
 * tirar a lista: não existe arquivo publicado que a contenha.
 *
 * O ESTADO TEM TRÊS VALORES, e os três importam. Sem 'carregando' a página
 * pisca "ambiente não encontrado" no primeiro quadro de toda visita, inclusive
 * na do cliente certo — que é a tela de entrada dele no sistema.
 */
export type PortalClientState = { status: 'carregando'; client: null } | { status: 'ok'; client: PortalClient } | { status: 'ausente'; client: null }

/** Só letras, números e hífen: o slug entra numa URL de arquivo. */
const slugValido = (s: string) => /^[a-z0-9][a-z0-9-]{0,63}$/.test(s)

export function usePortalClient(raw: string | undefined): PortalClientState {
  const slug = normalizeSlug(raw ?? '')
  const [state, setState] = useState<PortalClientState>(() => (slugValido(slug) ? { status: 'carregando', client: null } : { status: 'ausente', client: null }))

  useEffect(() => {
    if (!slugValido(slug)) {
      setState({ status: 'ausente', client: null })
      return
    }
    let vivo = true
    setState({ status: 'carregando', client: null })
    fetch(`/portais/dados/${slug}.json`, { headers: { Accept: 'application/json' } })
      .then((res) => {
        /* A hospedagem devolve o index.html em vez de 404 para caminho
           inexistente. Sem conferir o tipo, o JSON.parse estoura em HTML e o
           erro vira "ausente" por acidente — o que dá certo por sorte, e sorte
           não é comportamento. */
        if (!res.ok) return null
        const tipo = res.headers.get('content-type') ?? ''
        if (!tipo.includes('json')) return null
        return res.json() as Promise<PortalClient>
      })
      .then((client) => {
        if (!vivo) return
        setState(client && client.slug ? { status: 'ok', client } : { status: 'ausente', client: null })
      })
      .catch(() => {
        if (vivo) setState({ status: 'ausente', client: null })
      })
    return () => {
      vivo = false
    }
  }, [slug])

  return state
}
