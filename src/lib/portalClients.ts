import { supabase } from '@/lib/supabase'
import { normalizeSlug, portalClients, type PortalClient, type PortalUrls } from '@/content/portals'

/** Linha da tabela portal_clients. */
export interface PortalClientRow {
  slug: string
  name: string
  code: string
  apex: string
  logo_url: string | null
  urls_prod: PortalUrls | null
  urls_dev: PortalUrls | null
  active: boolean
  sort: number
  updated_at?: string
}

export const LOGO_BUCKET = 'portal-logos'
const TABLE = 'portal_clients'

export function rowToClient(r: PortalClientRow): PortalClient {
  return {
    slug: r.slug,
    name: r.name,
    code: r.code,
    apex: r.apex,
    logoUrl: r.logo_url ?? undefined,
    urls: { prod: r.urls_prod ?? {}, dev: r.urls_dev ?? {} },
    active: r.active,
  }
}

export function clientToRow(c: PortalClient, sort = 0): PortalClientRow {
  return {
    slug: normalizeSlug(c.slug),
    name: c.name.trim(),
    code: c.code.trim().toUpperCase(),
    apex: c.apex.trim().toLowerCase(),
    logo_url: c.logoUrl ?? null,
    urls_prod: cleanUrls(c.urls?.prod),
    urls_dev: cleanUrls(c.urls?.dev),
    active: c.active ?? true,
    sort,
  }
}

function cleanUrls(urls: PortalUrls | undefined): PortalUrls {
  const out: PortalUrls = {}
  for (const [k, v] of Object.entries(urls ?? {})) if (v && v.trim()) out[k as keyof PortalUrls] = v.trim()
  return out
}

/** A lista de reserva, na ordem em que foi escrita. */
export const fallbackClients = (): PortalClient[] => Object.values(portalClients).map((c) => ({ ...c, active: true }))

/** Um cliente pelo slug. `undefined` quando o banco não está configurado; `null` quando não existe. */
export async function fetchPortalClient(slug: string): Promise<PortalClient | null | undefined> {
  if (!supabase) return undefined
  const { data, error } = await supabase.from(TABLE).select('*').eq('slug', normalizeSlug(slug)).maybeSingle<PortalClientRow>()
  if (error) throw error
  return data ? rowToClient(data) : null
}

/** Todos os clientes, na ordem do cadastro. `undefined` sem o banco. */
export async function fetchPortalClients(): Promise<PortalClient[] | undefined> {
  if (!supabase) return undefined
  const { data, error } = await supabase.from(TABLE).select('*').order('sort', { ascending: true }).order('name', { ascending: true })
  if (error) throw error
  return (data as PortalClientRow[]).map(rowToClient)
}

export async function savePortalClient(client: PortalClient, previousSlug?: string): Promise<PortalClient> {
  if (!supabase) throw new Error('Banco não configurado.')
  const row = clientToRow(client)
  if (previousSlug && previousSlug !== row.slug) {
    // O slug é a chave: mudar o slug é gravar uma linha nova e apagar a antiga.
    const { data, error } = await supabase.from(TABLE).insert(row).select('*').single<PortalClientRow>()
    if (error) throw error
    const del = await supabase.from(TABLE).delete().eq('slug', previousSlug)
    if (del.error) throw del.error
    return rowToClient(data)
  }
  const { data, error } = await supabase.from(TABLE).upsert(row, { onConflict: 'slug' }).select('*').single<PortalClientRow>()
  if (error) throw error
  return rowToClient(data)
}

export async function deletePortalClient(slug: string): Promise<void> {
  if (!supabase) throw new Error('Banco não configurado.')
  const { error } = await supabase.from(TABLE).delete().eq('slug', slug)
  if (error) throw error
}

/** Sobe o logotipo para o balde público e devolve a URL. */
export async function uploadLogo(slug: string, file: File): Promise<string> {
  if (!supabase) throw new Error('Banco não configurado.')
  const ext = (file.name.split('.').pop() ?? 'png').toLowerCase().replace(/[^a-z0-9]/g, '') || 'png'
  const path = `${normalizeSlug(slug)}/${Date.now()}.${ext}`
  const { error } = await supabase.storage.from(LOGO_BUCKET).upload(path, file, { upsert: true, contentType: file.type || undefined, cacheControl: '3600' })
  if (error) throw error
  return supabase.storage.from(LOGO_BUCKET).getPublicUrl(path).data.publicUrl
}

/** Mensagens do Supabase em português simples. */
export function friendlyError(e: unknown): string {
  const msg = e instanceof Error ? e.message : typeof e === 'object' && e && 'message' in e ? String((e as { message: unknown }).message) : String(e)
  if (/Invalid login credentials/i.test(msg)) return 'E-mail ou senha incorretos.'
  if (/Email not confirmed/i.test(msg)) return 'Confirme o e-mail antes de entrar: abra a mensagem que enviamos.'
  if (/Database error saving new user|not allowed|restrito/i.test(msg)) return 'Este e-mail não está na lista de administradores.'
  if (/row-level security|permission denied|violates row-level/i.test(msg)) return 'Seu usuário não tem permissão para alterar o cadastro.'
  if (/duplicate key|already exists/i.test(msg)) return 'Já existe um cliente com esse slug.'
  if (/Password should be at least/i.test(msg)) return 'A senha precisa ter pelo menos 8 caracteres.'
  if (/rate limit|too many/i.test(msg)) return 'Muitas tentativas. Aguarde um minuto e tente de novo.'
  if (/Failed to fetch|NetworkError|Load failed/i.test(msg)) return 'Sem conexão com o banco. Verifique a internet e tente de novo.'
  return msg
}
