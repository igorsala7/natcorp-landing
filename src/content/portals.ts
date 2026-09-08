/**
 * Portais que os clientes usam para entrar no sistema (a página /portais/<cliente> e, para a base de
 * homologação, /portais/dev/<cliente>).
 *
 * O cadastro dos clientes fica em src/content/portals.json, editado em /admin/portais (que grava o arquivo no
 * repositório; a Vercel publica em seguida). Cada cliente guarda o endereço de cada portal, em produção e em
 * homologação, porque a estrutura dessas URLs é a do servidor de cada cliente e não pode ser alterada pelo site.
 * Quando um endereço não foi informado, vale o padrão do APEX:
 *   https://www.natcorpbr.com.br/apex/<ambiente>/f?p=<PREFIXO>_<CÓDIGO DO CLIENTE>
 * O <ambiente> muda conforme o servidor do cliente (rh, natrh, hc, hcm, cloud) e é "dev" na homologação.
 *
 * O logotipo é um arquivo em src/assets/portals/logos/ (o nome fica no cadastro; sem ele, vale <slug>.svg|png|webp).
 */
import registry from './portals.json'

export const APEX_HOST = 'https://www.natcorpbr.com.br/apex/'

export type PortalEnv = 'prod' | 'dev'
export type PortalKind = 'portal' | 'service'
export type PortalKey = 'colaborador' | 'gestor' | 'operador' | 'candidato' | 'natdocs' | 'chamado'

export interface PortalApp {
  key: PortalKey
  name: string
  /** Nome curto, para botões e listas. */
  short: string
  /** Prefixo do aplicativo no APEX, antes do código do cliente. */
  prefix: string
  /** Portais do sistema (por perfil) ou aplicativos e serviços. */
  kind: PortalKind
  /** Para quem é, em uma linha. */
  audience: string
  description: string
  /** O que a pessoa faz ali (chips). */
  tasks: string[]
  /** Aviso curto sobre quem deve usar, quando o público é restrito. */
  note?: string
}

export const portalApps: PortalApp[] = [
  {
    key: 'colaborador',
    name: 'Portal do Colaborador',
    short: 'Colaborador',
    prefix: 'PC',
    kind: 'portal',
    audience: 'Para todas as pessoas da empresa',
    description: 'Holerite, espelho de ponto, férias, benefícios, documentos e chamados internos, sem passar pelo RH.',
    tasks: ['Holerite e informe de rendimentos', 'Espelho de ponto', 'Férias e requisições', 'Documentos para assinar'],
  },
  {
    key: 'gestor',
    name: 'Portal do Gestor',
    short: 'Gestor',
    prefix: 'PG',
    kind: 'portal',
    audience: 'Para quem lidera uma equipe',
    description: 'A equipe inteira em uma tela: aprovações, ponto, férias, avaliações e os indicadores do time.',
    tasks: ['Aprovações de requisições e ponto', 'Férias e escalas da equipe', 'Avaliações e feedbacks', 'Indicadores do time'],
  },
  {
    key: 'operador',
    name: 'Portal do Operador',
    short: 'Operador',
    prefix: 'PO',
    kind: 'portal',
    audience: 'Para o RH e o Departamento Pessoal',
    description: 'O sistema completo: folha, ponto, eSocial, admissão, benefícios, saúde e segurança e talentos.',
    tasks: ['Folha, eSocial e NatPay', 'Admissão digital', 'Ponto e jornada', 'SESMT e talentos'],
  },
  {
    key: 'candidato',
    name: 'Portal do Candidato',
    short: 'Candidato',
    prefix: 'CV',
    kind: 'service',
    audience: 'Para quem quer trabalhar na empresa',
    description: 'Cadastre o currículo, candidate-se às vagas abertas e acompanhe cada etapa do processo seletivo.',
    tasks: ['Cadastro de currículo', 'Vagas abertas', 'Acompanhamento da seleção'],
  },
  {
    key: 'natdocs',
    name: 'NatDocs',
    short: 'NatDocs',
    prefix: 'NATDOCS',
    kind: 'service',
    audience: 'Assinatura eletrônica',
    description: 'Contratos, termos e documentos do RH assinados eletronicamente, com validade jurídica e trilha de auditoria.',
    tasks: ['Assinar documentos', 'Acompanhar assinaturas', 'Baixar a via assinada'],
  },
  {
    key: 'chamado',
    name: 'Chamado',
    short: 'Chamado',
    prefix: 'CHAMADO',
    kind: 'service',
    audience: 'Só para o RH: suporte Natcorp',
    description: 'O RH e o Departamento Pessoal abrem e acompanham chamados com a equipe de suporte da Natcorp. Cada pedido tem número, prazo e histórico.',
    tasks: ['Abrir chamado', 'Acompanhar o andamento', 'Histórico de atendimentos'],
    note: 'Colaboradores e gestores falam com o RH da própria empresa, pelo Portal do Colaborador.',
  },
]

export const portalKeys = portalApps.map((a) => a.key)

/** Endereços dos portais de um ambiente, por aplicativo. Um aplicativo sem endereço usa o padrão do APEX. */
export type PortalUrls = Partial<Record<PortalKey, string>>

export interface PortalClient {
  /** Trecho da URL da página: /portais/<slug>. */
  slug: string
  name: string
  /** Código do cliente no APEX (o que vem depois do prefixo em f?p=PO_<CÓDIGO>). */
  code: string
  /** Ambiente do cliente no APEX de produção (rh, natrh, hc, hcm, cloud), para montar o endereço padrão. */
  apex: string
  /** Nome do arquivo do logotipo em src/assets/portals/logos/ (null: sem logotipo, mostra o nome). */
  logo?: string | null
  active?: boolean
  /** Endereços informados no cadastro, por ambiente. */
  urls?: { prod?: PortalUrls; dev?: PortalUrls }
}

/** O cadastro, como está em src/content/portals.json, na ordem do arquivo. */
export const portalClients: PortalClient[] = (registry as { clients: PortalClient[] }).clients

/** Servidores conhecidos do APEX de produção (para o preenchimento automático no cadastro). */
export const apexServers = ['rh', 'natrh', 'hc', 'hcm', 'cloud'] as const

export const normalizeSlug = (raw: string) =>
  raw
    .trim()
    .toLowerCase()
    .replace(/^\/+|\/+$/g, '')

/** Resolve o cliente a partir do trecho da URL; null quando não há ambiente ativo com esse nome. */
export function resolveClient(raw: string | undefined): PortalClient | null {
  const slug = normalizeSlug(raw ?? '')
  return portalClients.find((c) => c.slug === slug && c.active !== false) ?? null
}

/** Caminho do ambiente no APEX: o do cliente em produção, "dev" na homologação. */
export function apexPath(client: Pick<PortalClient, 'apex'>, env: PortalEnv): string {
  return env === 'dev' ? 'dev' : client.apex || 'rh'
}

/** Endereço padrão do APEX para um aplicativo, ambiente e cliente. */
export function defaultPortalUrl(app: Pick<PortalApp, 'prefix'>, client: Pick<PortalClient, 'apex' | 'code' | 'slug'>, env: PortalEnv = 'prod'): string {
  const code = (client.code || client.slug).toUpperCase()
  return `${APEX_HOST}${apexPath(client, env)}/f?p=${app.prefix}_${code}`
}

/** Endereço padrão dos seis aplicativos, para preencher um cadastro. */
export function defaultPortalUrls(client: Pick<PortalClient, 'apex' | 'code' | 'slug'>, env: PortalEnv): Record<PortalKey, string> {
  return Object.fromEntries(portalApps.map((app) => [app.key, defaultPortalUrl(app, client, env)])) as Record<PortalKey, string>
}

/** Endereço de um portal: o informado no cadastro ou, na falta dele, o padrão do APEX. */
export function portalUrl(app: PortalApp, client: PortalClient, env: PortalEnv = 'prod'): string {
  const custom = client.urls?.[env]?.[app.key]?.trim()
  return custom || defaultPortalUrl(app, client, env)
}

/** Domínio onde os portais abrem (pelo Portal do Operador), para o rodapé. */
export function portalHost(client: PortalClient, env: PortalEnv): string {
  const operador = portalApps.find((a) => a.key === 'operador')!
  try {
    return new URL(portalUrl(operador, client, env)).host.replace(/^www\./, '')
  } catch {
    return 'natcorpbr.com.br'
  }
}

export const hubPath = (slug = 'natcorp', env: PortalEnv = 'prod') => (env === 'dev' ? `/portais/dev/${slug}` : `/portais/${slug}`)

/* Logotipos dos clientes, descobertos pelo nome do arquivo em src/assets/portals/logos/. */
const logoFiles = import.meta.glob<{ default: string }>('../assets/portals/logos/*.{svg,png,webp,jpg,jpeg}', { eager: true })

/** URL do arquivo de logotipo pelo nome (ex.: "stefanini.svg"), quando existe na pasta. */
export function logoFile(name: string | null | undefined): string | undefined {
  if (!name) return undefined
  for (const [path, mod] of Object.entries(logoFiles)) if (path.split('/').pop() === name) return mod.default
  return undefined
}

/** Logotipo do cliente: o arquivo do cadastro ou, na falta dele, <slug>.(svg|png|webp) na mesma pasta. */
export function clientLogo(client: Pick<PortalClient, 'slug' | 'logo'>): string | undefined {
  const named = logoFile(client.logo)
  if (named) return named
  for (const [path, mod] of Object.entries(logoFiles)) {
    const file = path.split('/').pop() ?? ''
    if (file.replace(/\.(svg|png|webp|jpe?g)$/, '') === client.slug) return mod.default
  }
  return undefined
}
