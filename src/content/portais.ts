import ilustraColaborador from '@/assets/portais/colaborador.webp'
import ilustraGestor from '@/assets/portais/gestor.webp'
import ilustraOperador from '@/assets/portais/operador.webp'

/**
 * Portais por cliente — a fonte da verdade das páginas /portais/:slug.
 *
 * ESTE ARQUIVO É EDITADO PELA TELA /admin/portais. Ela não grava sozinha: um
 * site estático não escreve no repositório. A tela monta o conteúdo novo deste
 * arquivo e entrega para copiar ou baixar; quem comita é uma pessoa. É por isso
 * que o formato abaixo é estável e previsível — ele precisa continuar legível
 * num diff de git.
 *
 * Reconstruído em 07/09/2026 a partir do build publicado, depois de o código
 * original ter se perdido num `git reset` antes de qualquer commit. Os 7
 * clientes, os 6 sistemas e as 84 URLs vieram extraídos do HTML, não digitados.
 */

/** Os seis destinos que um cliente pode ter. `portal` é tela de uso diário; `service` é serviço pontual. */
export type SistemaKey = 'colaborador' | 'gestor' | 'operador' | 'candidato' | 'natdocs' | 'chamado'

/** Cada cliente existe em produção e em homologação, com o mesmo conjunto de sistemas. */
export type Ambiente = 'prod' | 'dev'

export interface Sistema {
  key: SistemaKey
  /** Nome por extenso, como aparece no cartão. */
  name: string
  /** Nome curto, para chip e menu. */
  short: string
  /** Prefixo da aplicação APEX: a URL é f?p=<prefix>_<CODE>. */
  prefix: string
  kind: 'portal' | 'service'
  /** Para quem é — a primeira coisa que a pessoa precisa saber. */
  audience: string
  description: string
  tasks: string[]
  /** Observação exibida junto do cartão, quando existe. */
  note?: string
  /** Cor do acento no cartão. */
  color: string
}

export interface Cliente {
  /** Identificador na URL: /portais/<slug>. */
  slug: string
  name: string
  /** Sufixo das aplicações APEX deste cliente. */
  code: string
  /** Instância APEX onde o cliente está hospedado. */
  apex: string
  /** Logotipo do cliente. Só o nome do arquivo (`leadec.svg`): a pasta vem do
   *  slug. Aceita também caminho absoluto ou URL, para exceções.
   *  `null` usa a marca Natcorp. */
  logo: string | null
  /** Cliente inativo continua no arquivo, mas some da listagem. */
  active: boolean
  urls: Record<Ambiente, Record<SistemaKey, string>>
}

/**
 * Onde ficam os logotipos dos clientes.
 *
 * Em `public/` porque é arquivo que uma pessoa troca sem recompilar: o que fica
 * em `src/assets/` passa pelo empacotador e ganha nome com hash. Ver o LEIA-ME
 * dentro da pasta.
 */
export const PASTA_LOGOS = '/sistema/portais/arquivos/logos'

/** A pasta de um cliente: cada um tem a sua, nomeada pelo slug. */
export const pastaDoCliente = (slug: string): string => `${PASTA_LOGOS}/${slug}`

/**
 * Monta o endereço do logotipo.
 *
 * Guardar só o nome do arquivo, e derivar a pasta do slug, evita repetir o
 * caminho em cada cliente: PASTA_LOGOS vira o único lugar a mudar se a
 * estrutura se mover, e renomear um cliente não deixa o logo para trás.
 * Caminho absoluto e URL passam intactos, para um logotipo hospedado fora.
 */
export function urlLogo(cliente: Pick<Cliente, 'slug' | 'logo'>): string | null {
  if (!cliente.logo) return null
  return /^(https?:|\/)/.test(cliente.logo) ? cliente.logo : `${pastaDoCliente(cliente.slug)}/${cliente.logo}`
}

export const sistemas: Sistema[] = [
  {
    key: 'colaborador',
    name: 'Portal do Colaborador',
    short: 'Colaborador',
    prefix: 'PC',
    kind: 'portal',
    audience: 'Para todas as pessoas da empresa',
    description: 'Holerite, espelho de ponto, férias, benefícios, documentos e chamados internos, sem passar pelo RH.',
    tasks: [
      'Holerite e informe de rendimentos',
      'Espelho de ponto',
      'Férias e requisições',
      'Documentos para assinar'
    ],
    color: '#9A408A'
  },
  {
    key: 'gestor',
    name: 'Portal do Gestor',
    short: 'Gestor',
    prefix: 'PG',
    kind: 'portal',
    audience: 'Para quem lidera uma equipe',
    description: 'A equipe inteira em uma tela: aprovações, ponto, férias, avaliações e os indicadores do time.',
    tasks: [
      'Aprovações de requisições e ponto',
      'Férias e escalas da equipe',
      'Avaliações e feedbacks',
      'Indicadores do time'
    ],
    color: '#511C76'
  },
  {
    key: 'operador',
    name: 'Portal do Operador',
    short: 'Operador',
    prefix: 'PO',
    kind: 'portal',
    audience: 'Para o RH e o Departamento Pessoal',
    description: 'O sistema completo: folha, ponto, eSocial, admissão, benefícios, saúde e segurança e talentos.',
    tasks: [
      'Folha, eSocial e NatPay',
      'Admissão digital',
      'Ponto e jornada',
      'SESMT e talentos'
    ],
    color: '#2C1A63'
  },
  {
    key: 'candidato',
    name: 'Portal do Candidato',
    short: 'Candidato',
    prefix: 'CV',
    kind: 'service',
    audience: 'Para quem quer trabalhar na empresa',
    description: 'Cadastre o currículo, candidate-se às vagas abertas e acompanhe cada etapa do processo seletivo.',
    tasks: [
      'Cadastro de currículo',
      'Vagas abertas',
      'Acompanhamento da seleção'
    ],
    color: '#C95788'
  },
  {
    key: 'natdocs',
    name: 'NatDocs',
    short: 'NatDocs',
    prefix: 'NATDOCS',
    kind: 'service',
    audience: 'Assinatura eletrônica',
    description: 'Contratos, termos e documentos do RH assinados eletronicamente, com validade jurídica e trilha de auditoria.',
    tasks: [
      'Assinar documentos',
      'Acompanhar assinaturas',
      'Baixar a via assinada'
    ],
    color: '#81347D'
  },
  {
    key: 'chamado',
    name: 'Chamado',
    short: 'Chamado',
    prefix: 'CHAMADO',
    kind: 'service',
    audience: 'Só para o RH: suporte Natcorp',
    description: 'O RH e o Departamento Pessoal abrem e acompanham chamados com a equipe de suporte da Natcorp. Cada pedido tem número, prazo e histórico.',
    tasks: [
      'Abrir chamado',
      'Acompanhar o andamento',
      'Histórico de atendimentos'
    ],
    note: 'Colaboradores e gestores falam com o RH da própria empresa, pelo Portal do Colaborador.',
    color: '#4A4460'
  }
]

export const clientes: Cliente[] = [
  {
    slug: 'natcorp',
    name: 'Natcorp',
    code: 'NATCORP',
    apex: 'rh',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/rh/f?p=PC_NATCORP',
        gestor: 'https://www.natcorpbr.com.br/apex/rh/f?p=PG_NATCORP',
        operador: 'https://www.natcorpbr.com.br/apex/rh/f?p=PO_NATCORP',
        candidato: 'https://www.natcorpbr.com.br/apex/rh/f?p=CV_NATCORP',
        natdocs: 'https://www.natcorpbr.com.br/apex/rh/f?p=NATDOCS_NATCORP',
        chamado: 'https://www.natcorpbr.com.br/apex/rh/f?p=CHAMADO_NATCORP'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_NATCORP',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_NATCORP',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_NATCORP',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_NATCORP',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_NATCORP',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_NATCORP'
      }
    }
  },
  {
    slug: 'incor',
    name: 'Incor',
    code: 'INCOR',
    apex: 'rh',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/rh/f?p=PC_INCOR',
        gestor: 'https://www.natcorpbr.com.br/apex/rh/f?p=PG_INCOR',
        operador: 'https://www.natcorpbr.com.br/apex/rh/f?p=PO_INCOR',
        candidato: 'https://www.natcorpbr.com.br/apex/rh/f?p=CV_INCOR',
        natdocs: 'https://www.natcorpbr.com.br/apex/rh/f?p=NATDOCS_INCOR',
        chamado: 'https://www.natcorpbr.com.br/apex/rh/f?p=CHAMADO_INCOR'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_INCOR',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_INCOR',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_INCOR',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_INCOR',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_INCOR',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_INCOR'
      }
    }
  },
  {
    slug: 'redeflex',
    name: 'Redeflex',
    code: 'REDEFLEX',
    apex: 'rh',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/rh/f?p=PC_REDEFLEX',
        gestor: 'https://www.natcorpbr.com.br/apex/rh/f?p=PG_REDEFLEX',
        operador: 'https://www.natcorpbr.com.br/apex/rh/f?p=PO_REDEFLEX',
        candidato: 'https://www.natcorpbr.com.br/apex/rh/f?p=CV_REDEFLEX',
        natdocs: 'https://www.natcorpbr.com.br/apex/rh/f?p=NATDOCS_REDEFLEX',
        chamado: 'https://www.natcorpbr.com.br/apex/rh/f?p=CHAMADO_REDEFLEX'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_REDEFLEX',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_REDEFLEX',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_REDEFLEX',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_REDEFLEX',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_REDEFLEX',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_REDEFLEX'
      }
    }
  },
  {
    slug: 'leadec',
    name: 'Leadec',
    code: 'LEADEC',
    apex: 'natrh',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/natrh/f?p=PC_LEADEC',
        gestor: 'https://www.natcorpbr.com.br/apex/natrh/f?p=PG_LEADEC',
        operador: 'https://www.natcorpbr.com.br/apex/natrh/f?p=PO_LEADEC',
        candidato: 'https://www.natcorpbr.com.br/apex/natrh/f?p=CV_LEADEC',
        natdocs: 'https://www.natcorpbr.com.br/apex/natrh/f?p=NATDOCS_LEADEC',
        chamado: 'https://www.natcorpbr.com.br/apex/natrh/f?p=CHAMADO_LEADEC'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_LEADEC',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_LEADEC',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_LEADEC',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_LEADEC',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_LEADEC',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_LEADEC'
      }
    }
  },
  {
    slug: 'saude',
    name: 'Saúde',
    code: 'SAUDE',
    apex: 'hc',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/hc/f?p=PC_SAUDE',
        gestor: 'https://www.natcorpbr.com.br/apex/hc/f?p=PG_SAUDE',
        operador: 'https://www.natcorpbr.com.br/apex/hc/f?p=PO_SAUDE',
        candidato: 'https://www.natcorpbr.com.br/apex/hc/f?p=CV_SAUDE',
        natdocs: 'https://www.natcorpbr.com.br/apex/hc/f?p=NATDOCS_SAUDE',
        chamado: 'https://www.natcorpbr.com.br/apex/hc/f?p=CHAMADO_SAUDE'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_SAUDE',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_SAUDE',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_SAUDE',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_SAUDE',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_SAUDE',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_SAUDE'
      }
    }
  },
  {
    slug: 'stefanini',
    name: 'Stefanini',
    code: 'STEFANINI',
    apex: 'hcm',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/hcm/f?p=PC_STEFANINI',
        gestor: 'https://www.natcorpbr.com.br/apex/hcm/f?p=PG_STEFANINI',
        operador: 'https://www.natcorpbr.com.br/apex/hcm/f?p=PO_STEFANINI',
        candidato: 'https://www.natcorpbr.com.br/apex/hcm/f?p=CV_STEFANINI',
        natdocs: 'https://www.natcorpbr.com.br/apex/hcm/f?p=NATDOCS_STEFANINI',
        chamado: 'https://www.natcorpbr.com.br/apex/hcm/f?p=CHAMADO_STEFANINI'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_STEFANINI',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_STEFANINI',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_STEFANINI',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_STEFANINI',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_STEFANINI',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_STEFANINI'
      }
    }
  },
  {
    slug: 'realfood',
    name: 'RealFood',
    code: 'REALFOOD',
    apex: 'cloud',
    logo: null,
    active: true,
    urls: {
      prod: {
        colaborador: 'https://www.natcorpbr.com.br/apex/cloud/f?p=PC_REALFOOD',
        gestor: 'https://www.natcorpbr.com.br/apex/cloud/f?p=PG_REALFOOD',
        operador: 'https://www.natcorpbr.com.br/apex/cloud/f?p=PO_REALFOOD',
        candidato: 'https://www.natcorpbr.com.br/apex/cloud/f?p=CV_REALFOOD',
        natdocs: 'https://www.natcorpbr.com.br/apex/cloud/f?p=NATDOCS_REALFOOD',
        chamado: 'https://www.natcorpbr.com.br/apex/cloud/f?p=CHAMADO_REALFOOD'
      },
      dev: {
        colaborador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PC_REALFOOD',
        gestor: 'https://www.natcorpbr.com.br/apex/dev/f?p=PG_REALFOOD',
        operador: 'https://www.natcorpbr.com.br/apex/dev/f?p=PO_REALFOOD',
        candidato: 'https://www.natcorpbr.com.br/apex/dev/f?p=CV_REALFOOD',
        natdocs: 'https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_REALFOOD',
        chamado: 'https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_REALFOOD'
      }
    }
  }
]

/** Só os clientes ativos, na ordem do arquivo. */
export const clientesAtivos = (): Cliente[] => clientes.filter((c) => c.active)

export const acharCliente = (slug: string): Cliente | undefined =>
  clientes.find((c) => c.slug === slug)

export const acharSistema = (key: SistemaKey): Sistema | undefined =>
  sistemas.find((s) => s.key === key)

/** A URL segue sempre o mesmo padrão; serve para conferir o que está no arquivo. */
export const urlEsperada = (cliente: Cliente, sistema: Sistema, ambiente: Ambiente): string =>
  `https://www.natcorpbr.com.br/apex/${ambiente === 'dev' ? 'dev' : cliente.apex}/f?p=${sistema.prefix}_${cliente.code}`

/* -------------------------------------------------------------------------
   Conteúdo da página do portal.

   Fica aqui, e não dentro do componente, pela mesma razão do resto do site:
   texto é conteúdo, e conteúdo se edita sem abrir código de layout.
   ---------------------------------------------------------------------- */

/** Ilustração do topo do cartão, só para os três portais de uso diário. */
export const ilustracoes: Partial<Record<SistemaKey, { src: string; alt: string }>> = {
  colaborador: { src: ilustraColaborador, alt: 'Colaborador de camisa com a marca Natcorp, com o celular na mão' },
  gestor: { src: ilustraGestor, alt: 'Gestor de blazer roxo, com o tablet na mão' },
  operador: { src: ilustraOperador, alt: 'Analista do RH com o notebook na mão' },
}

export const copy = {
  hero: {
    lead: 'Escolha o seu portal. É o mesmo sistema e a mesma base de dados: o que muda é o que cada perfil vê e pode fazer.',
  },
  perfis: {
    eyebrow: 'Portais do sistema',
    titulo: 'Entre pelo seu perfil.',
    lead: 'Cada portal mostra só o que faz sentido para você. O cadastro é um só: o que muda é o que você vê e o que pode fazer.',
  },
  servicos: {
    eyebrow: 'Aplicativos e serviços',
    titulo: 'Candidatura, documentos e suporte.',
    lead: 'Três entradas fora do dia a dia: para quem ainda não é da empresa, para quem tem algo a assinar e para o RH falar com a Natcorp.',
  },
  natponto: {
    eyebrow: 'NatPonto · App de ponto',
    titulo: 'O ponto é pelo celular.',
    lead: 'A marcação é no app NatPonto, com reconhecimento facial e geolocalização. Baixe o app, entre com o acesso liberado pelo RH da sua empresa e marque o ponto. O espelho e os ajustes ficam no Portal do Colaborador.',
    chips: ['Reconhecimento facial', 'Local dentro do raio', 'Funciona sem internet', 'Comprovante com QR'],
    apple: 'https://apps.apple.com/br/app/natponto/id6474680680',
    google: 'https://play.google.com/store/apps/details?id=br.com.natcorp.natponto',
  },
  ajuda: {
    /* A NATI não é oferecida nestas páginas por decisão do cliente: ela não
       fica ativa nos portais. Saíram daqui o cartão 'Pergunte à NATI' e a
       menção no texto do hero. Se um dia for ligada, os dois voltam. */
    eyebrow: 'Precisa de ajuda?',
    titulo: 'Antes de abrir um chamado.',
    lead: 'O acesso é criado pela sua empresa. Os problemas mais comuns se resolvem em um minuto.',
    cartoes: [
      {
        titulo: 'Primeiro acesso',
        texto: 'Seu usuário é criado pelo RH da sua empresa. Se ainda não recebeu, fale com o RH antes de tentar entrar.',
      },
      {
        titulo: 'Esqueci a senha',
        texto: 'Peça a redefinição na tela de entrada do portal ou ao RH da sua empresa. A senha é sua: a Natcorp não tem acesso a ela.',
      },
      {
        titulo: 'Suporte Natcorp (RH)',
        texto: 'Problema no sistema? O RH da empresa abre um chamado com a Natcorp. Colaboradores e gestores falam com o próprio RH.',
      },
    ],
    seguranca: {
      titulo: 'Seus dados, protegidos.',
      texto: 'Servidores dedicados na Oracle Cloud, com contingência, criptografia e acesso por perfil. Nunca compartilhe sua senha.',
      link: 'Como cuidamos da segurança',
    },
  },
  rodape: {
    tagline: 'HR Tech brasileira. Há mais de 35 anos, todo o RH em um único sistema.',
    nota: 'Os portais abrem em natcorpbr.com.br, o ambiente do sistema.',
  },
} as const
