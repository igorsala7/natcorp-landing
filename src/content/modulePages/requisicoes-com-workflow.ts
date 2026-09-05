import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'requisicoes-com-workflow',
  name: 'Requisições com Workflow',
  group: 'autoatendimento',
  tagline: 'Pedido aprovado é pedido [[efetivado]]. Sem redigitar.',
  summary:
    'Vaga, pessoal, desligamento, treinamento, férias, movimentação, promoção, atestado, reembolso, abono de ponto e muito mais. Cada pedido nasce digital, passa pelas alçadas certas e, aprovado, é efetivado automaticamente na folha, no ponto e nos demais módulos.',
  seo: {
    title: 'Requisições com Workflow de aprovação | Natcorp',
    description:
      'Requisições eletrônicas com workflow: vaga, pessoal, desligamento, férias, promoção, atestado, reembolso e abono de ponto, com alçadas e efetivação automática.',
  },
  highlights: [
    { value: '24/7', label: 'para abrir e acompanhar pedidos, pelo celular ou computador' },
    { value: '1 pedido', label: 'dispara dezenas de atualizações no sistema, sem redigitar' },
    { value: '0', label: 'formulários em papel: tudo nasce como requisição eletrônica' },
  ],
  benefits: [
    {
      title: 'Aprovado é efetivado, sem redigitação',
      text: 'Férias aprovadas viram programação. Promoção aprovada atualiza cargo e salário. Desligamento aprovado abre o offboarding. Ninguém lança de novo.',
    },
    {
      title: 'Alçadas que seguem o seu organograma',
      text: 'Aprovadores por centro de custo, hierarquia ou estrutura matricial, com suplente automático. A decisão é descentralizada; a rastreabilidade, não.',
    },
    {
      title: 'Fim do e-mail perdido e da planilha paralela',
      text: 'Cada pedido tem status, responsável, prazo e histórico. Quem pediu vê onde está. Quem aprova recebe na fila, no celular ou no computador.',
    },
    {
      title: 'Menos trabalho manual no RH',
      text: 'O RH recebe tudo padronizado e já aprovado. Sobra tempo para o que exige análise, e as atividades de baixo valor saem da mesa.',
    },
  ],
  features: [
    {
      title: 'Dezenas de tipos de requisição',
      text: 'Vaga e headcount, pessoal, admissão, desligamento, treinamento, férias, movimentação, promoção, atestado, reembolso, abono de ponto, hora extra, benefícios e cadastro.',
      icon: 'clipboard',
    },
    {
      title: 'Alçadas parametrizadas',
      text: 'Grupos de aprovadores em sequência, alçada por centro de custo ou hierarquia, aprovadores globais e regras de exceção que sempre ou nunca aprovam.',
      icon: 'scale',
    },
    {
      title: 'Suplência automática',
      text: 'Aprovador ausente? A aprovação é delegada ao suplente na hora, e o pedido não para na fila de quem está de férias.',
      icon: 'user-check',
    },
    {
      title: 'Efetivação automática',
      text: 'Aprovado no fluxo, o sistema efetiva: folha, ponto, benefícios, headcount, treinamento e SESMT recebem a informação sem intervenção manual.',
      icon: 'zap',
    },
    {
      title: 'Anexos e justificativas',
      text: 'Comprovante de reembolso, atestado, justificativa de abono de ponto ou de hora extra anexados no próprio pedido.',
      icon: 'upload',
    },
    {
      title: 'Prazos e alertas',
      text: 'Controle automático de prazo em cada etapa e alerta para quem precisa agir. Responsabilidades separadas por etapa.',
      icon: 'clock',
    },
    {
      title: 'No portal, no celular ou no computador',
      text: 'O colaborador abre e acompanha no Portal do Colaborador. O gestor aprova ponto, férias e requisições no Portal do Gestor, em tempo real.',
      icon: 'smartphone',
    },
    {
      title: 'Rastreabilidade total',
      text: 'Cada interação, aprovação e alteração fica registrada. Histórico permanente para auditoria e compliance.',
      icon: 'history',
    },
    {
      title: 'Ligado a headcount e orçamento',
      text: 'A requisição de vaga valida a alçada financeira, respeita o orçamento de pessoal e, aprovada, abre o processo seletivo automaticamente.',
      icon: 'briefcase',
    },
    {
      title: 'Roteamento pela NATI',
      text: 'A NATI ajusta o fluxo conforme o perfil de quem pede e o tipo de solicitação, encaminhando cada demanda para a alçada certa.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Do pedido à efetivação',
    steps: [
      { title: 'Solicitação', text: 'Colaborador, gestor ou operador abre a requisição no portal, com anexos.' },
      { title: 'Análise', text: 'O sistema verifica regras e viabilidade e encaminha para a alçada certa.' },
      { title: 'Aprovação', text: 'Aprovadores em sequência, com suplência automática e prazos controlados.' },
      { title: 'Processamento', text: 'O RH executa o que precisa de tratamento humano, já padronizado.' },
      { title: 'Efetivação', text: 'Folha, ponto, benefícios ou headcount atualizados automaticamente.' },
      { title: 'Histórico', text: 'Registro permanente e rastreável de cada etapa.' },
    ],
  },
  compliance: ['LGPD: dados sensíveis (atestados, PPP, admissões) tramitam com acesso restrito por perfil'],
  personas: [
    { role: 'Colaborador', text: 'Pede férias, reembolso, abono de ponto ou atualização de cadastro pelo celular e acompanha o status sem ligar para o RH.' },
    { role: 'Gestor', text: 'Aprova os pedidos da equipe na fila do Portal do Gestor. Pede vaga, indica promoção e desligamento com a alçada já definida.' },
    { role: 'RH e Departamento Pessoal', text: 'Recebe tudo padronizado e aprovado. Processa o que exige análise e deixa a efetivação com o sistema.' },
  ],
  faq: [
    {
      q: 'Quais tipos de requisição existem?',
      a: 'Vaga e alteração de headcount, pessoal e admissão, desligamento, treinamento e indicação para curso, férias, escala, abono de marcações, hora extra, movimentação e promoção, alteração cadastral, dependentes, benefícios, atestados e afastamentos, exames, acidente de trabalho, PPP, terceiros, pensionistas e reembolsos.',
    },
    {
      q: 'Como funcionam as alçadas de aprovação?',
      a: 'O RH parametriza grupos de aprovadores em sequência lógica, por centro de custo, hierarquia ou estrutura matricial. Há aprovadores globais, suplência automática e regras de exceção. A requisição de vaga ainda passa pela validação de alçada financeira.',
    },
    {
      q: 'O que acontece quando a requisição é aprovada?',
      a: 'O sistema efetiva a informação automaticamente no módulo correspondente: folha, ponto, benefícios, headcount, treinamento ou SESMT. Uma única ação inicial gera as atualizações necessárias, sem redigitação, e tudo fica no histórico.',
    },
    {
      q: 'E se o aprovador estiver de férias?',
      a: 'A suplência ativa delega a aprovação automaticamente ao suplente definido, e o prazo da etapa continua sendo controlado. O pedido não fica parado esperando alguém voltar.',
    },
  ],
  related: ['portais', 'chamado-interno', 'administracao-de-pessoal', 'ponto-eletronico'],
  sources: ['gestao-de-requisicoes-eletronicas', 'automacao-de-processos', 'gestao-de-cargos-e-remuneracoes', 'gestao-de-headcount', 'csc-bpo', 'abrangencia-do-sistema', 'apresentacao-natcorp'],
}

export default page
