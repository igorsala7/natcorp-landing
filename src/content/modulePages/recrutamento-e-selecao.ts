import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'recrutamento-e-selecao',
  name: 'Recrutamento e Seleção',
  group: 'talentos',
  tagline: 'Da vaga aprovada ao [[candidato contratado]], em um só fluxo.',
  summary:
    'A requisição de vaga aprovada no workflow abre o processo seletivo sozinha. O RH conduz etapas, recrutadores e prazos em uma tela, a NATI cruza o banco de talentos com a vaga e o aprovado segue direto para a Admissão Digital.',
  seo: {
    title: 'Recrutamento e Seleção integrado | Natcorp',
    description:
      'Recrutamento e seleção para grandes empresas: processo seletivo aberto pela requisição de vaga, banco de talentos com IA, SLAs por vaga e admissão digital.',
  },
  highlights: [
    { value: '100%', label: 'digital, da requisição de vaga à contratação' },
    { value: '0', label: 'redigitação: o aprovado vai direto para a Admissão Digital' },
    { value: 'NATI', label: 'faz o matching entre o banco de talentos e as vagas' },
  ],
  benefits: [
    {
      title: 'Vagas fechadas mais rápido',
      text: 'O processo seletivo nasce da requisição aprovada, sem cadastro manual. Prazos por vaga e recrutadores definidos deixam claro quem faz o quê e até quando.',
    },
    {
      title: 'Contratação dentro da política',
      text: 'Teto salarial, formação mínima e experiência exigida ficam no cadastro do cargo e filtram a seleção. Ninguém contrata fora da faixa ou do perfil.',
    },
    {
      title: 'Headcount e orçamento sempre atualizados',
      text: 'Cada contratação concluída atualiza o Orçamento de Pessoal e o headcount na hora. Diretoria e Financeiro veem o quadro real, sem planilha paralela.',
    },
    {
      title: 'Uma experiência boa para o candidato',
      text: 'O candidato se cadastra, acompanha as etapas e envia documentos pelo celular. Quem é aprovado já entra na Admissão Digital sem repetir nada.',
    },
  ],
  features: [
    {
      title: 'Processos seletivos sob medida',
      text: 'Crie e conduza cada processo com etapas, questionários personalizados e triagem automatizada. Tudo em um só lugar, do anúncio à aprovação.',
      icon: 'clipboard',
    },
    {
      title: 'Candidatos externos e internos',
      text: 'Receba currículos de fora pelo Quadro de Vagas e abra vagas para quem já trabalha na empresa. Mesmo funil, mesma gestão.',
      icon: 'users',
    },
    {
      title: 'Banco de talentos com matching da NATI',
      text: 'Currículos organizados para o futuro. A NATI cruza o banco de talentos com a requisição da vaga e acelera a triagem com análise preditiva.',
      icon: 'sparkles',
    },
    {
      title: 'Recrutadores e SLAs por vaga',
      text: 'Defina o recrutador responsável e o prazo de cada vaga. O RH acompanha o andamento e sabe onde o processo está travado.',
      icon: 'clock',
    },
    {
      title: 'Abertura pela requisição aprovada',
      text: 'A Requisição de Vaga ou de Pessoal passa pelo workflow de alçadas. Aprovada, o processo seletivo é criado automaticamente.',
      icon: 'workflow',
    },
    {
      title: 'Filtros de contratação',
      text: 'Teto salarial, formação mínima e desejável, tempo de experiência e limite de advertências vêm do cadastro do cargo e protegem a política salarial.',
      icon: 'filter',
    },
    {
      title: 'Portal do Candidato',
      text: 'O candidato se cadastra, atualiza o currículo, acompanha etapas, avaliações e status e envia documentos pelo celular ou computador.',
      icon: 'smartphone',
    },
    {
      title: 'Ligado à Admissão Digital',
      text: 'Candidato aprovado, admissão aberta. Os dados e documentos coletados na seleção seguem para a admissão sem redigitação.',
      icon: 'file-signature',
    },
    {
      title: 'Headcount e orçamento em tempo real',
      text: 'A contratação concluída atualiza o Orçamento de Pessoal, e a posição passa de em recrutamento para ocupada automaticamente.',
      icon: 'bar-chart',
    },
    {
      title: 'NATI avalia canais e qualidade',
      text: 'A NATI analisa a efetividade dos canais de recrutamento e a experiência do candidato e sugere estratégias para melhorar a qualidade da contratação.',
      icon: 'bot',
    },
  ],
  flow: {
    title: 'Da requisição de vaga ao primeiro dia',
    steps: [
      { title: 'Requisição de vaga', text: 'O gestor pede a vaga ou a reposição pelo Portal do Gestor, já com cargo, centro de custo e orçamento.' },
      { title: 'Aprovação no workflow', text: 'A requisição passa pela alçada financeira e pela aprovação final. Tudo registrado, sem e-mail.' },
      { title: 'Processo seletivo aberto', text: 'Aprovada, a vaga vira processo seletivo automaticamente e é publicada no Quadro de Vagas.' },
      { title: 'Triagem e etapas', text: 'A NATI sugere talentos do banco. Questionários, entrevistas e avaliações seguem as etapas definidas.' },
      { title: 'Candidato aprovado', text: 'O aprovado entra na Admissão Digital e preenche os dados pelo Portal do Candidato.' },
      { title: 'Contratado e no quadro', text: 'A admissão cria o cadastro na folha e atualiza headcount e Orçamento de Pessoal.' },
    ],
  },
  compliance: ['LGPD: tratamento dos dados de candidatos com acesso por perfil', 'Termos de aceite digitais direcionados a candidatos, com histórico e versionamento'],
  personas: [
    { role: 'RH e recrutadores', text: 'Conduzem processos, prazos e etapas em uma tela, com o banco de talentos e a NATI ajudando na triagem.' },
    { role: 'Gestor', text: 'Pede a vaga pelo portal, aprova no workflow e acompanha o status da seleção em tempo real, sem perguntar ao RH.' },
    { role: 'Candidato', text: 'Cadastra o currículo, acompanha as etapas e envia documentos pelo celular. Se aprovado, faz a admissão no mesmo portal.' },
  ],
  faq: [
    {
      q: 'O processo seletivo abre sozinho quando a vaga é aprovada?',
      a: 'Sim. A Requisição de Vaga ou de Pessoal passa pelo workflow de aprovação com alçadas. Assim que é aprovada, o sistema cria o processo seletivo automaticamente, já ligado ao cargo, ao centro de custo e ao orçamento.',
    },
    {
      q: 'Como o banco de talentos ajuda a preencher uma vaga nova?',
      a: 'Os currículos recebidos ficam organizados no banco de talentos. Quando uma requisição de vaga é aprovada, a NATI cruza o perfil da vaga com o banco e indica os candidatos mais aderentes, acelerando a triagem.',
    },
    {
      q: 'Colaboradores da empresa podem se candidatar às vagas?',
      a: 'Sim. O módulo trabalha com candidatos externos e internos no mesmo processo seletivo. Quem já está na empresa participa das etapas com o mesmo acompanhamento.',
    },
    {
      q: 'O que acontece depois que o candidato é aprovado?',
      a: 'A Admissão Digital é aberta automaticamente. O candidato completa os dados e assina o contrato pelo portal e, admitido, o cadastro nasce na folha. O headcount e o Orçamento de Pessoal são atualizados na hora.',
    },
  ],
  related: ['quadro-de-vagas', 'admissao-digital', 'administracao-de-pessoal', 'requisicoes-com-workflow'],
  sources: ['abrangencia-do-sistema', 'gestao-de-rh', 'nati-operadores', 'gestao-de-cargos-e-remuneracoes', 'apresentacao-natcorp', 'gestao-de-headcount', 'performance-e-seguranca', 'paineis-inteligentes'],
}

export default page
