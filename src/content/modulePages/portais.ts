import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'portais',
  name: 'Portais',
  group: 'autoatendimento',
  tagline: 'Cada pessoa vê o que precisa, [[sem depender do RH]].',
  summary:
    'Portais do Gestor, do Colaborador e do Candidato. Cada perfil acessa os próprios dados, faz requisições e resolve o dia a dia sozinho, no celular ou no computador. O que aparece depende do contexto e do acesso de cada usuário.',
  seo: {
    title: 'Portais do Gestor, Colaborador e Candidato | Natcorp',
    description:
      'Portais de autoatendimento de RH: o gestor aprova e acompanha a equipe, o colaborador consulta holerite e faz pedidos, o candidato acompanha a seleção.',
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
      text: 'Cada usuário acessa só os módulos, dados e funções do seu contexto e perfil. Gestor vê a própria equipe, colaborador vê os próprios dados.',
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
      text: 'Módulos e funções aparecem conforme o acesso de cada usuário. Perfis, alçadas e restrições por empresa, filial ou centro de custo.',
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
    { role: 'Colaborador', text: 'Consulta holerite, espelho de ponto e benefícios, faz pedidos, aceita plantões e tira dúvidas com a NATI, sem procurar o RH.' },
    { role: 'Candidato', text: 'Cadastra o currículo, acompanha as etapas da seleção e, aprovado, conclui a admissão no mesmo portal.' },
  ],
  faq: [
    {
      q: 'O gestor consegue ver dados de outras equipes?',
      a: 'Só se o perfil dele permitir. O acesso é por contexto: cada usuário vê apenas os módulos, dados e funções liberados para o seu perfil, empresa, filial ou centro de custo, com trilha de auditoria.',
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
  related: ['requisicoes-com-workflow', 'chamado-interno', 'nati', 'quadro-de-vagas'],
  sources: ['paineis', 'paineis-inteligentes', 'gestao-de-rh', 'apresentacao-natcorp', 'nati-colaboradores', 'csc-bpo', 'produtividade-de-rh', 'gestao-de-frequencia', 'gestao-de-treinamentos'],
}

export default page
