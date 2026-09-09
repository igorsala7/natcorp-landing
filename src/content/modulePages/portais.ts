import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'portais',
  name: 'Portais',
  group: 'autoatendimento',
  tagline: 'O módulo de portais: [[um acesso por perfil]], configurado pelo RH.',
  summary:
    'O módulo que o RH configura para liberar cada portal: perfis de acesso por empresa, filial e centro de custo, permissões por função e identidade visual da empresa. O que cada pessoa vê depende do contexto e do acesso dela.',
  seo: {
    title: 'Módulo de Portais: perfis e permissões de acesso | Natcorp',
    description:
      'O módulo de portais do sistema de RH: perfis de acesso por empresa, filial e centro de custo, permissões por função, identidade da empresa e trilha de auditoria.',
  },
  highlights: [
    { value: '250+', label: 'funções gerenciais no Portal do Gestor e do Colaborador' },
    { value: '70%', label: 'menos chamados de dúvidas com o autoatendimento' },
    { value: '120+', label: 'idiomas disponíveis na plataforma' },
  ],
  benefits: [
    {
      title: 'RH livre do balcão',
      text: 'Holerite, espelho de ponto, férias, informes e pedidos saem do e-mail e do corredor. O colaborador resolve sozinho e o RH cuida do que exige gente.',
    },
    {
      title: 'Gestor com autonomia real',
      text: 'Equipe inteira em um único ambiente. Aprovações de ponto, férias e requisições em tempo real, pelo celular, sem esperar o RH.',
    },
    {
      title: 'Segurança de quem vê o quê',
      text: 'Cada usuário acessa só os módulos, dados e funções do seu contexto e perfil. O gestor vê a própria equipe, o RH da filial vê a sua filial, o colaborador vê os próprios dados.',
    },
    {
      title: 'Uma experiência do candidato ao diretor',
      text: 'Interface unificada para todos os perfis, sem múltiplos logins, no celular, no tablet e no computador.',
    },
  ],
  features: [
    {
      title: 'Portal do Gestor',
      text: 'Gestão da equipe consolidada em um só lugar: aprovações de ponto, férias e requisições, indicadores e movimentações em tempo real.',
      icon: 'users',
    },
    {
      title: 'Portal do Colaborador',
      text: 'Holerite, espelho de ponto, benefícios, informes, feedbacks, carreira e onboarding. Consultas e pedidos a qualquer hora.',
      icon: 'wallet',
    },
    {
      title: 'Portal do Candidato',
      text: 'Cadastro, currículo, acompanhamento das etapas do processo seletivo, avaliações, status e envio de documentos.',
      icon: 'user-plus',
    },
    {
      title: 'Requisições com workflow',
      text: 'Férias, abono de ponto, alteração cadastral, reembolso, desligamento e mais, pedidos no portal e aprovados no fluxo. Efetivação automática.',
      icon: 'workflow',
    },
    {
      title: 'Acesso por contexto e perfil',
      text: 'Módulos e funções aparecem conforme o acesso de cada usuário. Perfis, alçadas e restrições por empresa, filial e centro de custo: cada equipe vê e opera só o que é dela, e a matriz consolida.',
      icon: 'key',
    },
    {
      title: 'Celular, tablet e computador',
      text: 'Aplicativo para iOS e Android e telas responsivas. Sincronização em tempo real entre todos os dispositivos.',
      icon: 'smartphone',
    },
    {
      title: 'NATI dentro do portal',
      text: 'A assistente de IA responde dúvidas sobre holerite, ponto, benefícios e políticas 24 horas por dia, no portal, no WhatsApp e no Teams.',
      icon: 'bot',
    },
    {
      title: 'Chamado Interno',
      text: 'Quando precisa de gente, o colaborador abre um chamado para o RH ou outro departamento e acompanha o atendimento no mesmo portal.',
      icon: 'message-square',
    },
    {
      title: 'Escalas e plantões',
      text: 'O colaborador vê os plantões, oferece trocas e aceita turnos com termo de aceite e assinatura digital. O gestor acompanha pelo painel.',
      icon: 'calendar',
    },
    {
      title: 'Documentos e assinaturas',
      text: 'Contratos, termos, aviso de férias e espelho de ponto para consultar e assinar eletronicamente, com validade jurídica.',
      icon: 'file-signature',
    },
  ],
  flow: {
    title: 'Do pedido à efetivação, no portal',
    steps: [
      { title: 'Solicitação', text: 'O colaborador ou o gestor faz o pedido pelo portal: férias, abono, alteração cadastral, vaga.' },
      { title: 'Aprovação', text: 'O gestor aprova no Portal do Gestor, pelo celular, dentro das alçadas definidas.' },
      { title: 'Processamento', text: 'O RH processa o que precisa de conferência, com prazo controlado.' },
      { title: 'Efetivação automática', text: 'Aprovado, o pedido é efetivado na folha, no ponto ou nos benefícios sem redigitação.' },
      { title: 'Histórico visível', text: 'Status e histórico ficam disponíveis para quem pediu, quem aprovou e o RH.' },
    ],
  },
  compliance: ['LGPD: acesso por perfil, anonimização quando aplicável e trilha de auditoria', 'Logins criptografados e auditoria das ações no sistema'],
  personas: [
    { role: 'Gestor', text: 'Aprova ponto, férias e requisições, acompanha indicadores da equipe e pede vagas pelo portal, de onde estiver.' },
    { role: 'RH da filial', text: 'Admite, trata o ponto e lança movimentações e benefícios da sua unidade, dentro do seu perfil e das suas alçadas. A matriz acompanha as pendências e consolida.' },
    { role: 'Colaborador e candidato', text: 'O colaborador consulta holerite, espelho de ponto e benefícios, faz pedidos, aceita plantões e tira dúvidas com a NATI. O candidato acompanha a seleção e, aprovado, conclui a admissão no mesmo portal.' },
  ],
  faq: [
    {
      q: 'O RH de cada filial vê só a sua filial?',
      a: 'Sim. Os perfis seguem a estrutura da organização: empresa, filial e centro de custo. A equipe da filial admite, trata o ponto e lança movimentações dentro do seu perfil e das suas alçadas; o gestor vê só a própria equipe. A matriz enxerga o consolidado e as pendências de cada unidade, com trilha de auditoria de quem viu e alterou cada dado.',
    },
    {
      q: 'Os portais funcionam no celular?',
      a: 'Sim. Há aplicativo para iOS e Android e as telas são responsivas para celular, tablet e computador. Aprovações, consultas e pedidos funcionam em qualquer dispositivo, com sincronização em tempo real.',
    },
    {
      q: 'O que o colaborador consegue resolver sozinho?',
      a: 'Consultar holerite, espelho de ponto e benefícios, pedir férias, abonar marcações, atualizar cadastro, aceitar plantões, assinar documentos, ver feedbacks e treinamentos e tirar dúvidas com a NATI 24 horas por dia.',
    },
    {
      q: 'O candidato usa o mesmo portal?',
      a: 'O candidato tem o Portal do Candidato, com cadastro, currículo, acompanhamento das etapas e envio de documentos. Quando é aprovado, faz a Admissão Digital nele e, admitido, passa a usar o Portal do Colaborador.',
    },
  ],
  related: ['requisicoes-com-workflow', 'quadro-de-vagas', 'nati', 'blog-corporativo'],
  sources: ['paineis', 'paineis-inteligentes', 'gestao-de-rh', 'apresentacao-natcorp', 'nati-colaboradores', 'csc-bpo', 'produtividade-de-rh', 'gestao-de-frequencia', 'gestao-de-treinamentos'],
}

export default page
