import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'chamado-interno',
  name: 'Chamado Interno',
  group: 'autoatendimento',
  tagline: 'Toda dúvida vira chamado. [[Nenhuma se perde]].',
  summary:
    'A central de atendimento do RH e dos outros departamentos. O colaborador abre o chamado pelo celular, a NATI responde o que é rotina, o operador atende o resto em fila organizada, com prioridade, SLA e histórico completo.',
  seo: {
    title: 'Chamado Interno com SLA e triagem | Natcorp',
    description:
      'Central de atendimento para RH e outros departamentos: áreas e sub-áreas, prioridades, status, SLA, roteamento automático, triagem pela NATI e 28+ relatórios.',
  },
  highlights: [
    { value: '28+', label: 'relatórios nativos, do acompanhamento básico ao cruzamento' },
    { value: '70%', label: 'menos chamados com o atendimento a dúvidas automatizado' },
    { value: '24/7', label: 'a NATI responde dúvidas de rotina e faz a triagem' },
  ],
  benefits: [
    {
      title: 'O RH atende e prova que atendeu',
      text: 'Cada dúvida vira chamado com área, responsável, prazo e histórico. Nada se perde no e-mail, no telefone ou no corredor.',
    },
    {
      title: 'Menos chamados chegando ao RH',
      text: 'A NATI responde as dúvidas de rotina e faz a triagem. Só o que precisa de uma pessoa chega à fila do operador.',
    },
    {
      title: 'SLA e gargalos visíveis',
      text: 'Prioridade, fase e prazo em cada chamado. O gestor vê onde a fila trava, por área e sub-área, em tempo real.',
    },
    {
      title: 'Vai além do RH',
      text: 'Qualquer departamento parametrizado atende pelo mesmo canal, com suas próprias áreas, responsáveis e fases. Um só lugar para o colaborador.',
    },
  ],
  features: [
    {
      title: 'Áreas e sub-áreas de atendimento',
      text: 'Estruture o atendimento como o organograma: Departamento Pessoal, depois Folha de Pagamento, e assim por diante. Cada sub-área tem seus responsáveis.',
      icon: 'layers',
    },
    {
      title: 'Prioridades e tipos de atendimento',
      text: 'Urgente, Alta, Normal ou Baixa, escolhida por quem abre. Tipo de atendimento, como esclarecimento ou solicitação, para classificar e medir.',
      icon: 'filter',
    },
    {
      title: 'Status e fases personalizadas',
      text: 'Aguardando Atendimento, Em Andamento, Suspenso, Cancelado e Concluído. Ajuste as fases ao fluxo de cada área.',
      icon: 'list-checks',
    },
    {
      title: 'Roteamento automático',
      text: 'O chamado vai direto para a fila da sub-área. O operador assume, pede dados adicionais e o solicitante recebe alerta por e-mail e no portal.',
      icon: 'workflow',
    },
    {
      title: 'SLA e prazos',
      text: 'Controle de prazos por prioridade, previsibilidade de SLA e alertas para chamado parado.',
      icon: 'clock',
    },
    {
      title: 'Fila do operador',
      text: 'Todos os chamados sob sua responsabilidade em uma tela, com histórico de fases, comentários e anexos. Reatribua o responsável quando alguém faltar.',
      icon: 'users',
    },
    {
      title: 'Abertura pelo portal ou pelo app',
      text: 'O colaborador abre o chamado com área, prioridade, descrição e anexo, e acompanha pelo portal ou app. O e-mail é identificado automaticamente.',
      icon: 'smartphone',
    },
    {
      title: 'Triagem pela NATI',
      text: 'A NATI responde dúvidas de rotina a qualquer hora e encaminha os casos complexos para a área certa. Dúvidas recorrentes viram alerta para o RH.',
      icon: 'sparkles',
    },
    {
      title: '28+ relatórios nativos',
      text: 'Do acompanhamento básico ao cruzamento de área, sub-área, data, status e prioridade. O gestor cria suas próprias telas, gráficos e relatórios.',
      icon: 'bar-chart',
    },
    {
      title: 'Histórico imutável',
      text: 'Toda interação, edição e mudança de fase fica registrada, pronta para auditoria.',
      icon: 'history',
    },
  ],
  flow: {
    title: 'Da dúvida à conclusão',
    steps: [
      { title: 'Abertura', text: 'Colaborador ou gestor abre o chamado no portal, escolhe área, prioridade e anexa arquivos.' },
      { title: 'Triagem', text: 'A NATI responde o que é rotina; o resto vai para a fila da sub-área.' },
      { title: 'Atendimento', text: 'O operador assume, responde ou pede mais dados. O solicitante recebe alerta.' },
      { title: 'Conclusão', text: 'Chamado concluído com histórico completo e imutável.' },
      { title: 'Análise', text: 'Relatórios mostram volume, prazos e gargalos por área e sub-área.' },
    ],
  },
  personas: [
    { role: 'Colaborador', text: 'Abre o chamado pelo celular, anexa o que precisa e acompanha o status sem ligar para o RH.' },
    { role: 'Operador de RH', text: 'Trabalha em fila organizada, com prioridade e prazo, e tem o histórico completo de cada atendimento em uma tela.' },
    { role: 'Gestor de RH', text: 'Mede SLA, volume por área e gargalos com 28+ relatórios e painéis, e redistribui a equipe onde a fila trava.' },
  ],
  faq: [
    {
      q: 'Só o RH pode atender chamados?',
      a: 'Não. Qualquer departamento parametrizado pode ter suas áreas e sub-áreas de atendimento, com responsáveis, fases e tipos próprios. O colaborador usa o mesmo canal para tudo, e cada chamado vai para a fila certa.',
    },
    {
      q: 'Como a NATI ajuda no atendimento?',
      a: 'Ela é a primeira linha: responde dúvidas de rotina e consulta informações funcionais a qualquer hora, e faz a triagem do que é complexo para a área certa. Quando muitas pessoas perguntam a mesma coisa, ela alerta o RH para ajustar a política ou a comunicação.',
    },
    {
      q: 'O que o colaborador vê depois de abrir um chamado?',
      a: 'O status em tempo real, a data de abertura, a última mensagem e o responsável. Se o operador pedir mais dados, ele recebe alerta por e-mail e no portal. Tudo pelo celular ou pelo computador.',
    },
    {
      q: 'Quais relatórios existem?',
      a: 'Mais de 28 relatórios nativos, do acompanhamento de chamados ao cruzamento de área, sub-área, tipo de atendimento, data, status e prioridade. O gestor também cria suas próprias telas, gráficos e relatórios, sem depender de TI.',
    },
  ],
  related: ['requisicoes-com-workflow', 'nati', 'portais', 'business-intelligence'],
  sources: ['chamados-internos', 'paineis-inteligentes', 'abrangencia-do-sistema', 'paineis', 'produtividade-de-rh', 'apresentacao-natcorp', 'nati-ia'],
}

export default page
