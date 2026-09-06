import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'offboarding',
  name: 'Offboarding',
  group: 'talentos',
  tagline: 'Desligamento com [[segurança jurídica]] e respeito.',
  summary:
    'O desligamento começa na Requisição de Desligamento, passa pelo workflow de aprovação e chega a uma única tela com cálculos da rescisão, bloqueios de acesso e documentos rescisórios. Com a burocracia resolvida, o RH tem tempo para a conversa de saída.',
  seo: {
    title: 'Offboarding digital com workflow | Natcorp',
    description:
      'Offboarding para grandes empresas: Requisição de Desligamento com workflow, cálculos da rescisão, banco de horas, bloqueios de acesso e documentos em uma tela.',
  },
  highlights: [
    { value: '1 tela', label: 'para cálculos, bloqueios de acesso e documentos rescisórios' },
    { value: '6 passos', label: 'da requisição ao encerramento, com histórico de cada um' },
  ],
  benefits: [
    {
      title: 'Menos risco de passivo trabalhista',
      text: 'Regras aplicadas automaticamente, banco de horas remanescente processado e documentos gerados no sistema. Menos falha operacional, mais segurança jurídica.',
    },
    {
      title: 'Um processo só, do pedido ao fechamento',
      text: 'A Requisição de Desligamento, a aprovação, o cálculo e a documentação ficam no mesmo fluxo, com histórico de quem pediu, aprovou e executou.',
    },
    {
      title: 'Tempo para tratar a pessoa com respeito',
      text: 'Com a automação resolvendo a burocracia, o RH conduz a entrevista de desligamento com atenção e cuida de uma transição estruturada.',
    },
    {
      title: 'Quadro e orçamento atualizados na hora',
      text: 'A saída libera a posição no headcount e ajusta o Orçamento de Pessoal automaticamente. Gestor e Financeiro veem o quadro real.',
    },
  ],
  features: [
    {
      title: 'Requisição de Desligamento',
      text: 'O gestor ou o RH abre o pedido com motivo e data. A requisição segue pelo workflow de aprovação com alçadas antes de qualquer cálculo.',
      icon: 'workflow',
    },
    {
      title: 'Tudo em uma tela',
      text: 'Cálculos da rescisão, bloqueios de acesso e documentos rescisórios centralizados em uma única tela do Departamento Pessoal.',
      icon: 'layout-grid',
    },
    {
      title: 'Banco de horas na rescisão',
      text: 'O saldo remanescente do banco de horas é processado automaticamente, com as regras específicas de desligamento aplicadas.',
      icon: 'clock',
    },
    {
      title: 'Bloqueio de acessos',
      text: 'Os bloqueios de acesso fazem parte do fluxo e ficam registrados junto com o cálculo e os documentos. Ninguém sai com porta aberta.',
      icon: 'lock',
    },
    {
      title: 'Documentos rescisórios',
      text: 'Documentos da rescisão gerados no mesmo fluxo e assinados eletronicamente, com documentação auditável no fechamento do ciclo.',
      icon: 'file-text',
    },
    {
      title: 'Conferência pela NATI',
      text: 'A NATI audita a rescisão junto com admissão, férias e folha, gera conferências automáticas e aponta inconsistências antes do fechamento.',
      icon: 'bot',
    },
    {
      title: 'eSocial integrado',
      text: 'Os dados validados da rescisão geram o evento S-2299 de desligamento no eSocial de forma integrada, por empresa, sem retrabalho.',
      icon: 'send',
    },
    {
      title: 'Headcount e orçamento atualizados',
      text: 'A posição volta a ficar disponível no headcount e o Orçamento de Pessoal reflete a saída na hora.',
      icon: 'bar-chart',
    },
    {
      title: 'Histórico e rastreabilidade',
      text: 'Cada etapa fica registrada: quem pediu, quem aprovou, quando foi calculado. Histórico permanente para auditorias.',
      icon: 'history',
    },
    {
      title: 'Pelo celular também',
      text: 'A rescisão pode ser processada do smartphone, de qualquer lugar, com a mesma segurança.',
      icon: 'smartphone',
    },
  ],
  flow: {
    title: 'Da requisição ao encerramento',
    steps: [
      { title: 'Requisição de Desligamento', text: 'Gestor ou RH abre o pedido com motivo e data pelo portal.' },
      { title: 'Aprovação no workflow', text: 'A requisição passa pelas alçadas definidas. Tudo registrado.' },
      { title: 'Cálculo da rescisão', text: 'Verbas rescisórias e saldo do banco de horas calculados automaticamente.' },
      { title: 'Bloqueios e documentos', text: 'Acessos bloqueados e documentos rescisórios gerados na mesma tela.' },
      { title: 'Conferência e eSocial', text: 'A NATI confere o cálculo e os dados validados geram o S-2299 no eSocial.' },
      { title: 'Encerramento humano', text: 'Com a burocracia resolvida, o RH conduz a entrevista de desligamento com tempo e respeito.' },
    ],
  },
  compliance: ['CLT: verbas rescisórias e regras de desligamento aplicadas automaticamente', 'eSocial: evento S-2299 de desligamento gerado da rescisão validada', 'LGPD: acesso por perfil e trilha de auditoria'],
  personas: [
    { role: 'RH e Departamento Pessoal', text: 'Calcula, bloqueia e documenta em uma tela, com a NATI conferindo. Ganha tempo para a conversa de saída.' },
    { role: 'Gestor', text: 'Abre a Requisição de Desligamento pelo portal e acompanha o status até o fechamento, sem trocar e-mails com o RH.' },
    { role: 'Colaborador que sai', text: 'Passa por uma transição organizada e respeitosa, com documentos e prazos corretos.' },
  ],
  faq: [
    {
      q: 'Como começa o desligamento no sistema?',
      a: 'Pela Requisição de Desligamento. O gestor ou o RH registra motivo e data, a requisição passa pelo workflow de aprovação e, aprovada, abre o fluxo de Offboarding com cálculo, bloqueios e documentos.',
    },
    {
      q: 'O banco de horas entra no cálculo da rescisão?',
      a: 'Sim. O saldo remanescente do banco de horas é processado automaticamente no desligamento, com as regras específicas de rescisão aplicadas. Nada de calcular saldo acumulado à mão.',
    },
    {
      q: 'Os acessos do colaborador são bloqueados?',
      a: 'Sim. Os bloqueios de acesso fazem parte do fluxo de Offboarding e ficam na mesma tela dos cálculos e dos documentos rescisórios.',
    },
    {
      q: 'O Offboarding ajuda a reduzir passivo trabalhista?',
      a: 'Sim. A automação garante o cumprimento das obrigações legais, a NATI confere a rescisão antes do fechamento e todo o processo fica rastreável e auditável, da requisição ao encerramento.',
    },
  ],
  related: ['requisicoes-com-workflow', 'folha-de-pagamento', 'ponto-eletronico', 'administracao-de-pessoal'],
  sources: ['admissao-digital', 'gestao-de-rh', 'gestao-de-frequencia', 'gestao-de-requisicoes-eletronicas', 'apresentacao-natcorp', 'performance-e-seguranca', 'automacao-de-processos'],
}

export default page
