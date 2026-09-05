/** Reconhecimentos e clientes citados no material oficial da Natcorp (deck "Sistema de RH" e site anterior). */

export const awards = [
  { title: 'Top 5 · Top of Mind de RH', org: 'Sistemas de Folha de Pagamento, 2019 e 2020', kind: 'Prêmio nacional' },
  { title: 'Tech Innovator Awards', org: 'Innovation in Business', kind: 'Prêmio internacional' },
  { title: 'Technology Innovator Awards', org: 'Corporate Vision', kind: 'Prêmio internacional' },
  { title: 'Oracle Partner', org: 'Oracle', kind: 'Parceria' },
]

export const facts = [
  '35 anos de história',
  'O maior e mais completo sistema de RH e DP do Brasil',
  'Dados de mais de 500 mil colaboradores administrados no sistema',
  'Pioneira no uso de inteligência artificial para o RH',
]

/** Empresas e instituições atendidas, como aparecem no material oficial. */
export const clients = [
  'InCor · HCFMUSP',
  'Instituto Central · HCFMUSP',
  'Instituto do Câncer do Estado de São Paulo',
  'Instituto da Criança · HCFMUSP',
  'Instituto de Psiquiatria · HCFMUSP',
  'Instituto de Ortopedia e Traumatologia',
  'Instituto de Medicina Física e Reabilitação',
  'InRad · HCFMUSP',
  'LIM · HCFMUSP',
  'Hospital das Clínicas · FMUSP',
  'Fundação Zerbini',
  'Stefanini Group',
  'Haus',
  'Orbitall Payments',
  'Cyber Smart Defence',
  'Gauge',
  'SCM',
  'IHM',
  'Abril',
  'Prevcom',
  'Saque e Pague',
  'Leadec',
  'Teccloud',
  'Topaz',
  'Scala',
  'Brooke',
  'Huia',
  'Inlira',
  'W3haus',
  'N1IT',
  'Woopi',
  'Logbank',
  'Inspiring',
  'Ponto Certificado',
  'Mozaiko',
  'Infinit',
  'Real Food Alimentação',
  'Intelligenti',
  'Redeflex',
  'dn.ia',
]

/** Como os clientes se organizam: estrutura, sem números de porte (esses ficam para a demonstração). */
export interface ClientGroup {
  id: string
  title: string
  text: string
  /** Nomes como aparecem na lista de clientes. */
  examples: string[]
  links: { label: string; to: string }[]
}

export const clientGroups: ClientGroup[] = [
  {
    id: 'saude',
    title: 'Complexo hospitalar com vários institutos',
    text: 'Vários institutos e uma fundação, cada um com o seu regime e a sua escala, operando na mesma base.',
    examples: ['InCor', 'Instituto Central', 'ICESP', 'Instituto da Criança', 'Instituto de Psiquiatria', 'Instituto de Ortopedia e Traumatologia', 'Instituto de Medicina Física e Reabilitação', 'InRad', 'LIM', 'Hospital das Clínicas da FMUSP', 'Fundação Zerbini'],
    links: [{ label: 'Como atendemos a saúde', to: '/segmentos/saude-e-ciencias-biologicas' }],
  },
  {
    id: 'tecnologia',
    title: 'Grupos de tecnologia e serviços',
    text: 'Empresas com várias unidades e equipes distribuídas, folha e portais em um só sistema.',
    examples: ['Stefanini Group', 'Orbitall Payments', 'Topaz', 'Scala', 'Teccloud', 'N1IT', 'Cyber Smart Defence', 'Logbank'],
    links: [
      { label: 'Serviços financeiros', to: '/segmentos/servicos-financeiros' },
      { label: 'Telecom', to: '/segmentos/telecom' },
    ],
  },
  {
    id: 'industria',
    title: 'Indústria, varejo e serviços',
    text: 'Operações com turnos, escalas e sazonalidade diferentes, cada uma com as suas regras, na mesma folha.',
    examples: ['Abril', 'Real Food Alimentação', 'Saque e Pague', 'Leadec', 'Prevcom', 'Haus'],
    links: [{ label: 'Ver todos os segmentos', to: '/segmentos' }],
  },
]

/** Comparativo do deck "Nossos diferenciais": Natcorp x outros sistemas. */
export const comparison = [
  { feature: 'Módulos integrados', natcorp: '31 módulos nativos, 100% integrados', others: 'Módulos separados ou integração limitada' },
  { feature: 'Inteligência artificial', natcorp: 'NATI integrada ao sistema e ao WhatsApp', others: 'IA limitada ou inexistente' },
  { feature: 'Cobrança por usuário', natcorp: 'Usuários ilimitados, em produção e homologação', others: 'Cobrança por usuário adicional' },
  { feature: 'Cobrança por CNPJ', natcorp: 'CNPJs e sindicatos ilimitados', others: 'Cobrança adicional por CNPJ' },
  { feature: 'Histórico de dados', natcorp: 'Ilimitado, com migração sem limite de anos', others: 'Cobrança por histórico ou limitação' },
  { feature: 'Conexões com outros sistemas', natcorp: 'Conexões prontas e construtor pelo próprio usuário', others: 'Conexões limitadas ou cobradas à parte' },
  { feature: 'Velocidade da folha', natcorp: 'Mais de 2.500 folhas por minuto', others: 'Desempenho limitado' },
  { feature: 'Desenvolvimento', natcorp: '100% Natcorp, sem depender de terceiros', others: 'Dependência de fornecedores externos' },
]

/** Resultados apresentados no deck ("Gestão otimizada"). */
export const results = [
  { value: 'até 70%', label: 'de aumento de produtividade', text: 'A automação de processos libera o RH de tarefas repetitivas e operacionais.' },
  { value: 'até 40%', label: 'de redução de custos', text: 'Fim do retrabalho, dos papéis, das planilhas paralelas e dos sistemas redundantes.' },
  { value: '70%+', label: 'de ganho de tempo', text: 'Agilidade em processos críticos como folha, admissão, férias e rescisões.' },
]
