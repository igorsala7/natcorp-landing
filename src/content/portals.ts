/**
 * Portais que os clientes usam para entrar no sistema (a página /portais/<cliente> e, para a base de
 * homologação, /portais/dev/<cliente>).
 *
 * Cada cliente tem o próprio ambiente no APEX. A URL de um portal é:
 *   https://www.natcorpbr.com.br/apex/<ambiente>/f?p=<PREFIXO>_<CÓDIGO DO CLIENTE>
 * O <ambiente> muda conforme o servidor do cliente (rh, natrh, hc, hcm, cloud) e é sempre "dev" na
 * base de homologação. Ex.: PO_NATCORP em /apex/rh/, PO_LEADEC em /apex/natrh/, PO_STEFANINI em /apex/hcm/.
 *
 * O logotipo do cliente entra pelo nome do arquivo em src/assets/portals/logos/<slug>.(svg|png|webp).
 */

export const APEX_HOST = 'https://www.natcorpbr.com.br/apex/'

export type PortalEnv = 'prod' | 'dev'
export type PortalKind = 'portal' | 'service'

export interface PortalApp {
  key: 'colaborador' | 'gestor' | 'operador' | 'candidato' | 'natdocs' | 'chamado'
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

export interface PortalClient {
  slug: string
  name: string
  /** Ambiente do cliente no APEX de produção: rh, natrh, hc, hcm, cloud. */
  apex: string
  /** Código usado no APEX quando difere do slug (opcional). */
  code?: string
}

/** Clientes com página de acesso. O slug é o trecho da URL (/portais/<slug>). */
export const portalClients: Record<string, PortalClient> = {
  natcorp: { slug: 'natcorp', name: 'Natcorp', apex: 'rh' },
  incor: { slug: 'incor', name: 'Incor', apex: 'rh' },
  redeflex: { slug: 'redeflex', name: 'Redeflex', apex: 'rh' },
  leadec: { slug: 'leadec', name: 'Leadec', apex: 'natrh' },
  saude: { slug: 'saude', name: 'Saúde', apex: 'hc' },
  stefanini: { slug: 'stefanini', name: 'Stefanini', apex: 'hcm' },
  realfood: { slug: 'realfood', name: 'RealFood', apex: 'cloud' },
}

/** Resolve o cliente a partir do trecho da URL; null quando não há ambiente com esse nome. */
export function resolveClient(raw: string | undefined): PortalClient | null {
  const slug = (raw ?? '').toLowerCase()
  return portalClients[slug] ?? null
}

/** Caminho do ambiente no APEX: o do cliente em produção, "dev" na homologação. */
export function apexPath(client: PortalClient, env: PortalEnv): string {
  return env === 'dev' ? 'dev' : client.apex
}

export function portalUrl(app: PortalApp, client: PortalClient, env: PortalEnv = 'prod'): string {
  return `${APEX_HOST}${apexPath(client, env)}/f?p=${app.prefix}_${(client.code ?? client.slug).toUpperCase()}`
}

export const hubPath = (slug = 'natcorp', env: PortalEnv = 'prod') => (env === 'dev' ? `/portais/dev/${slug}` : `/portais/${slug}`)

/** Saudação pela hora local de quem abre a página. */
export function greeting(date = new Date()): string {
  const h = date.getHours()
  if (h < 5) return 'Boa noite'
  if (h < 12) return 'Bom dia'
  if (h < 18) return 'Boa tarde'
  return 'Boa noite'
}

/* Logotipos dos clientes, descobertos pelo nome do arquivo (ver cabeçalho). */
const logoFiles = import.meta.glob<{ default: string }>('../assets/portals/logos/*.{svg,png,webp}', { eager: true })

/** Logotipo do cliente, quando existe o arquivo src/assets/portals/logos/<slug>.(svg|png|webp). */
export function clientLogo(slug: string): string | undefined {
  for (const [path, mod] of Object.entries(logoFiles)) {
    const file = path.split('/').pop() ?? ''
    if (file.replace(/\.(svg|png|webp)$/, '') === slug) return mod.default
  }
  return undefined
}
