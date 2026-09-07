/**
 * Portais que os clientes usam para entrar no sistema (a página /portais/<cliente>).
 * Cada cliente tem o próprio ambiente no APEX: o aplicativo é o prefixo do portal mais o código do cliente
 * (PG_NATCORP, PC_VERDEALIMENTOS...). Clientes conhecidos ganham nome bonito; os demais usam o próprio slug.
 */

export const APEX_BASE = 'https://www.natcorpbr.com.br/apex/rh/f?p='

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
}

export const portalApps: PortalApp[] = [
  {
    key: 'colaborador',
    name: 'Portal do Colaborador',
    short: 'Colaborador',
    prefix: 'PC',
    kind: 'portal',
    audience: 'Para todas as pessoas da empresa',
    description: 'Holerite, espelho de ponto, férias, benefícios, documentos e chamados, sem passar pelo RH.',
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
    audience: 'Suporte Natcorp',
    description: 'Abra e acompanhe chamados com a equipe de suporte da Natcorp. Cada pedido tem número, prazo e histórico.',
    tasks: ['Abrir chamado', 'Acompanhar o andamento', 'Histórico de atendimentos'],
  },
]

export interface PortalClient {
  slug: string
  name: string
  /** Código usado no APEX quando difere do slug (opcional). */
  code?: string
}

/** Clientes com nome próprio na página. Os demais aparecem com o slug capitalizado. */
export const portalClients: Record<string, PortalClient> = {
  natcorp: { slug: 'natcorp', name: 'Natcorp' },
  verdealimentos: { slug: 'verdealimentos', name: 'Verde Alimentos' },
}

const SLUG = /^[a-z0-9][a-z0-9-]{0,40}$/

/** Resolve o cliente a partir do trecho da URL. Slugs inválidos caem no ambiente da Natcorp. */
export function resolveClient(raw: string | undefined): PortalClient {
  const slug = (raw ?? 'natcorp').toLowerCase()
  if (!SLUG.test(slug)) return portalClients.natcorp
  return portalClients[slug] ?? { slug, name: slug.charAt(0).toUpperCase() + slug.slice(1) }
}

export function portalUrl(app: PortalApp, client: PortalClient): string {
  return `${APEX_BASE}${app.prefix}_${(client.code ?? client.slug).toUpperCase()}`
}

export const hubPath = (slug = 'natcorp') => `/portais/${slug}`

/** Saudação pela hora local de quem abre a página. */
export function greeting(date = new Date()): string {
  const h = date.getHours()
  if (h < 5) return 'Boa noite'
  if (h < 12) return 'Bom dia'
  if (h < 18) return 'Boa tarde'
  return 'Boa noite'
}
