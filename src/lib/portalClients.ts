import { normalizeSlug, portalClients, type PortalClient, type PortalUrls } from '@/content/portals'

/**
 * Gravação do cadastro dos portais no repositório, pela API do GitHub.
 *
 * A administração (/admin/portais) edita src/content/portals.json e os logotipos em src/assets/portals/logos/ e
 * faz o commit direto na branch de publicação; a Vercel publica em seguida. O token do GitHub (fine-grained, com
 * "Contents: Read and write" só neste repositório) fica apenas no navegador do administrador e nunca entra no site.
 */

export interface RepoTarget {
  owner: string
  repo: string
  branch: string
}

const env = import.meta.env
export const REPO: RepoTarget = {
  owner: (env.VITE_ADMIN_REPO_OWNER as string | undefined) || 'igorsala7',
  repo: (env.VITE_ADMIN_REPO as string | undefined) || 'natcorp-landing',
  branch: (env.VITE_ADMIN_BRANCH as string | undefined) || 'main',
}
export const REGISTRY_PATH = 'src/content/portals.json'
export const LOGOS_DIR = 'src/assets/portals/logos'
export const TOKEN_URL = 'https://github.com/settings/personal-access-tokens/new'

const TOKEN_KEY = 'natcorp:admin:github-token'
const API = 'https://api.github.com'

/* ---------------- token ---------------- */

export function getToken(): string | null {
  try {
    return window.localStorage.getItem(TOKEN_KEY)
  } catch {
    return null
  }
}

export function setToken(token: string | null) {
  try {
    if (token) window.localStorage.setItem(TOKEN_KEY, token)
    else window.localStorage.removeItem(TOKEN_KEY)
  } catch {
    /* armazenamento indisponível */
  }
}

/* ---------------- API ---------------- */

export class GitHubError extends Error {
  status: number
  constructor(status: number, message: string) {
    super(message)
    this.status = status
  }
}

async function gh<T>(token: string, path: string, init: RequestInit = {}): Promise<T> {
  const res = await fetch(`${API}${path}`, {
    ...init,
    headers: {
      Accept: 'application/vnd.github+json',
      Authorization: `Bearer ${token}`,
      'X-GitHub-Api-Version': '2022-11-28',
      ...(init.body ? { 'Content-Type': 'application/json' } : {}),
      ...(init.headers ?? {}),
    },
  })
  if (res.status === 204) return undefined as T
  const body = (await res.json().catch(() => ({}))) as { message?: string }
  if (!res.ok) throw new GitHubError(res.status, body.message ?? `HTTP ${res.status}`)
  return body as T
}

const contentsPath = (path: string) => `/repos/${REPO.owner}/${REPO.repo}/contents/${path.split('/').map(encodeURIComponent).join('/')}`

/** Quem é o token e se ele pode gravar no repositório. */
export async function checkAccess(token: string): Promise<{ login: string; push: boolean }> {
  const user = await gh<{ login: string }>(token, '/user')
  const repo = await gh<{ permissions?: { push?: boolean } }>(token, `/repos/${REPO.owner}/${REPO.repo}`)
  return { login: user.login, push: repo.permissions?.push === true }
}

interface ContentFile {
  sha: string
  content: string
  encoding: string
  html_url: string
}

async function readFile(token: string, path: string): Promise<ContentFile | null> {
  try {
    return await gh<ContentFile>(token, `${contentsPath(path)}?ref=${encodeURIComponent(REPO.branch)}`)
  } catch (e) {
    if (e instanceof GitHubError && e.status === 404) return null
    throw e
  }
}

interface CommitResult {
  commit: { sha: string; html_url: string }
  content: { sha: string } | null
}

async function writeFile(token: string, path: string, base64: string, message: string, sha?: string): Promise<CommitResult> {
  return gh<CommitResult>(token, contentsPath(path), { method: 'PUT', body: JSON.stringify({ message, content: base64, branch: REPO.branch, sha }) })
}

async function deleteFile(token: string, path: string, message: string): Promise<void> {
  const file = await readFile(token, path)
  if (!file) return
  await gh(token, contentsPath(path), { method: 'DELETE', body: JSON.stringify({ message, sha: file.sha, branch: REPO.branch }) })
}

/* ---------------- base64 ---------------- */

function bytesToBase64(bytes: Uint8Array): string {
  let bin = ''
  const chunk = 0x8000
  for (let i = 0; i < bytes.length; i += chunk) bin += String.fromCharCode(...bytes.subarray(i, i + chunk))
  return btoa(bin)
}

function base64ToText(b64: string): string {
  const bin = atob(b64.replace(/\s/g, ''))
  const bytes = Uint8Array.from(bin, (c) => c.charCodeAt(0))
  return new TextDecoder().decode(bytes)
}

const textToBase64 = (text: string) => bytesToBase64(new TextEncoder().encode(text))

/* ---------------- cadastro ---------------- */

interface Registry {
  _comentario?: string
  clients: PortalClient[]
}

export interface RegistrySnapshot {
  clients: PortalClient[]
  sha: string
  registry: Registry
}

/** O cadastro embutido no site (o que estava no repositório no último build). */
export const bundledClients = (): PortalClient[] => portalClients.map((c) => ({ ...c }))

/** O cadastro como está no repositório agora (pode estar à frente do site publicado). */
export async function fetchRegistry(token: string): Promise<RegistrySnapshot> {
  const file = await readFile(token, REGISTRY_PATH)
  if (!file) throw new GitHubError(404, `${REGISTRY_PATH} não existe na branch ${REPO.branch}.`)
  const registry = JSON.parse(base64ToText(file.content)) as Registry
  return { clients: registry.clients ?? [], sha: file.sha, registry }
}

function cleanUrls(urls: PortalUrls | undefined): PortalUrls {
  const out: PortalUrls = {}
  for (const [k, v] of Object.entries(urls ?? {})) if (v && v.trim()) out[k as keyof PortalUrls] = v.trim()
  return out
}

/** O cliente como vai para o arquivo: campos na ordem fixa, sem lixo. */
export function cleanClient(c: PortalClient): PortalClient {
  return {
    slug: normalizeSlug(c.slug),
    name: c.name.trim(),
    code: c.code.trim().toUpperCase(),
    apex: c.apex.trim().toLowerCase() || 'rh',
    logo: c.logo ?? null,
    active: c.active !== false,
    urls: { prod: cleanUrls(c.urls?.prod), dev: cleanUrls(c.urls?.dev) },
  }
}

const serialize = (registry: Registry) => `${JSON.stringify(registry, null, 2)}\n`

export interface SaveOptions {
  /** Slug anterior, quando o cliente já existia (o slug pode ter mudado). */
  previousSlug?: string
  /** Logotipo novo, para subir junto. */
  logoFile?: File | null
}

export interface SaveResult {
  client: PortalClient
  commitUrl: string
}

/** Grava um cliente (novo ou existente) no cadastro do repositório, com o logotipo se houver. */
export async function saveClient(token: string, input: PortalClient, { previousSlug, logoFile }: SaveOptions = {}): Promise<SaveResult> {
  const client = cleanClient(input)
  const snapshot = await fetchRegistry(token)
  const list = snapshot.clients
  const previous = previousSlug ? list.find((c) => c.slug === previousSlug) : undefined
  const isNew = !previous
  if (list.some((c) => c.slug === client.slug && c.slug !== previousSlug)) throw new GitHubError(409, `Já existe um cliente com o slug "${client.slug}".`)

  // logotipo: sobe o arquivo novo e remove o antigo quando trocou ou foi retirado
  if (logoFile) {
    const ext = (logoFile.name.split('.').pop() ?? 'png').toLowerCase().replace(/[^a-z0-9]/g, '') || 'png'
    const name = `${client.slug}.${ext}`
    const path = `${LOGOS_DIR}/${name}`
    const existing = await readFile(token, path)
    const bytes = new Uint8Array(await logoFile.arrayBuffer())
    await writeFile(token, path, bytesToBase64(bytes), `portais: logotipo de ${client.name}`, existing?.sha)
    if (previous?.logo && previous.logo !== name) await deleteFile(token, `${LOGOS_DIR}/${previous.logo}`, `portais: remove logotipo antigo de ${client.name}`)
    client.logo = name
  } else if (!client.logo && previous?.logo) {
    await deleteFile(token, `${LOGOS_DIR}/${previous.logo}`, `portais: remove logotipo de ${client.name}`)
  }

  const next = isNew ? [...list, client] : list.map((c) => (c.slug === previousSlug ? client : c))
  const registry: Registry = { ...snapshot.registry, clients: next }
  const result = await writeFile(token, REGISTRY_PATH, textToBase64(serialize(registry)), `portais: ${isNew ? 'cadastra' : 'atualiza'} ${client.name}`, snapshot.sha)
  return { client, commitUrl: result.commit.html_url }
}

/** Tira um cliente do cadastro (e o logotipo dele). */
export async function removeClient(token: string, slug: string): Promise<{ commitUrl: string }> {
  const snapshot = await fetchRegistry(token)
  const target = snapshot.clients.find((c) => c.slug === slug)
  if (!target) throw new GitHubError(404, 'Esse cliente já não está no cadastro.')
  if (target.logo) await deleteFile(token, `${LOGOS_DIR}/${target.logo}`, `portais: remove logotipo de ${target.name}`)
  const registry: Registry = { ...snapshot.registry, clients: snapshot.clients.filter((c) => c.slug !== slug) }
  const result = await writeFile(token, REGISTRY_PATH, textToBase64(serialize(registry)), `portais: exclui ${target.name}`, snapshot.sha)
  return { commitUrl: result.commit.html_url }
}

/** Mensagens da API em português simples. */
export function friendlyError(e: unknown): string {
  if (e instanceof GitHubError) {
    if (e.status === 401) return 'Token inválido ou expirado. Gere um token novo no GitHub e conecte de novo.'
    if (e.status === 403) return 'O token não tem permissão de escrita neste repositório (Contents: Read and write).'
    if (e.status === 404) return e.message.includes('não') ? e.message : 'Repositório ou arquivo não encontrado. Confira o token e o repositório.'
    if (e.status === 409) return e.message
    if (e.status === 422) return 'O GitHub recusou a gravação. Tente de novo em instantes.'
    return e.message
  }
  const msg = e instanceof Error ? e.message : String(e)
  if (/Failed to fetch|NetworkError|Load failed/i.test(msg)) return 'Sem conexão com o GitHub. Verifique a internet e tente de novo.'
  return msg
}
