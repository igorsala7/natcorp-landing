export const siteConfig = {
  name: 'Natcorp',
  tagline: 'Todo o RH em um único sistema.',
  url: 'https://natcorp.com.br',
  email: 'contato@natcorp.com.br',
  phone: '+55 11 5096-0711',
  phoneHref: 'tel:+551150960711',
  whatsapp: '+55 11 97446-6729',
  whatsappHref: 'https://wa.me/5511974466729',
  city: 'Barueri e São Paulo · SP',
  coverage: 'Atendemos todo o território nacional.',
  youtube: 'https://www.youtube.com/@natcorpbr',
  defaultTitle: 'Natcorp — Todo o RH em um único sistema | Sistema de RH para grandes empresas',
  defaultDescription:
    'Folha de pagamento, ponto eletrônico, eSocial, admissão digital, saúde e segurança do trabalho, people analytics e a NATI, nossa inteligência artificial: mais de 30 módulos integrados em um único sistema de RH para grandes empresas. Há mais de 30 anos.',
}

/** Escritórios da Natcorp, como constam na página "Fale conosco" do site anterior. */
export const offices = [
  {
    name: 'Matriz',
    lines: ['Av. Marcos Penteado de Ulhoa Rodrigues, 939', 'Ed. Jacarandá, 8º andar · Tamboré', 'Barueri · SP · CEP 06460-040'],
  },
  {
    name: 'Brooklin',
    lines: ['Av. das Nações Unidas, 12495', 'Nações Unidas Tower, 15º andar · Brooklin Novo', 'São Paulo · SP · CEP 04578-000'],
  },
  {
    name: 'Centro Operacional',
    lines: ['Rua Américo Brasiliense, 1923', '10º andar · Chácara Santo Antônio', 'São Paulo · SP · CEP 04715-005'],
  },
]

/** Página da jornada do colaborador (história etapa por etapa). */
export const journeyPath = '/jornada-da-contratacao'

/** Caminhos das páginas principais. */
export const paths = {
  home: '/',
  system: '/sistema',
  modules: '/modulos',
  security: '/seguranca',
  about: '/sobre',
  contact: '/contato',
  portals: '/portais',
  journey: journeyPath,
  segments: '/segmentos',
  nati: '/modulos/nati',
} as const

export interface NavLink {
  to: string
  label: string
  short?: string
}

/** Menu "Sistema": entradas gerais, antes das colunas de módulos por grupo. */
export const systemLinks: NavLink[] = [
  { to: paths.modules, label: 'Todos os módulos', short: 'Mais de 30, cada um com a sua página' },
  { to: paths.journey, label: 'Jornada do colaborador', short: 'As 24 etapas, da vaga à promoção' },
  { to: paths.security, label: 'Segurança e infraestrutura', short: 'Nuvem Oracle, contingência e LGPD' },
  { to: paths.portals, label: 'Portais e autoatendimento', short: 'Gestor, colaborador e candidato' },
]

/** Visão geral do sistema (/sistema): escondida do menu por enquanto, mas a página continua no ar. */
export const systemOverviewLink: NavLink = { to: paths.system, label: 'Visão geral do sistema', short: 'As sete frentes, com telas e módulos' }

/** Produtos com nome próprio dentro do sistema (escondidos do menu por enquanto). */
export const appLinks: NavLink[] = [
  { to: paths.nati, label: 'NATI', short: 'A inteligência artificial do RH' },
  { to: '/modulos/natponto', label: 'NatPonto', short: 'App de ponto com reconhecimento facial' },
  { to: '/modulos/natpay', label: 'NatPay', short: 'Adiantamento salarial via WhatsApp e Pix' },
  { to: '/modulos/people-analytics', label: 'People Analytics', short: 'Painéis prontos e gráficos próprios' },
]

/** Menu "Empresa". */
export const companyLinks: NavLink[] = [
  { to: paths.about, label: 'Sobre a Natcorp', short: '35 anos, missão, visão e valores' },
  { to: `${paths.about}#reconhecimento`, label: 'Reconhecimentos e clientes', short: 'Prêmios e quem usa o sistema' },
  { to: `${paths.about}#servicos`, label: 'Serviços', short: 'Implantação, BPO, treinamento e suporte' },
  { to: `${paths.about}#videos`, label: 'Vídeos', short: 'O canal da Natcorp' },
]
