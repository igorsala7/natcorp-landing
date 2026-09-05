import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'juridico-trabalhista',
  name: 'Jurídico Trabalhista',
  group: 'pessoal-e-folha',
  tagline: 'Cada processo trabalhista [[com defesa, provisão e eSocial]] no mesmo painel.',
  summary:
    'Da petição inicial à execução: pautas, prepostos, provisões, depósitos e honorários em um único painel. Os dados do reclamante vêm da folha e do ponto, sem contradição na defesa, e os eventos S-2500 e S-2501 saem direto do processo para o eSocial.',
  seo: {
    title: 'Jurídico Trabalhista integrado ao eSocial | Natcorp',
    description:
      'Processos trabalhistas: petição, audiências, sentença, recursos e execução, provisão por grau de risco, dados da folha na defesa e envio de S-2500 e S-2501.',
  },
  highlights: [
    { value: '5', label: 'etapas, da petição inicial à execução, em um só fluxo' },
    { value: 'S-2500', label: 'e S-2501 enviados direto do processo ao eSocial' },
  ],
  benefits: [
    {
      title: 'Defesa sem contradição',
      text: 'Cargo, salários, jornada e histórico contratual do reclamante vêm direto da folha e do ponto. A empresa apresenta o mesmo dado que já enviou ao governo.',
    },
    {
      title: 'Contingência clara para o CFO',
      text: 'Valores pleiteados de um lado, provisão técnica por risco possível, provável ou remoto do outro. O gap de contingência aparece antes de virar surpresa no caixa.',
    },
    {
      title: 'Nenhuma pauta ou prazo perdido',
      text: 'Painel diário de audiências e prepostos, controle de protocolos e histórico de cada fase. O jurídico e o RH enxergam o mesmo andamento.',
    },
    {
      title: 'eSocial cumprido a partir do processo',
      text: 'Sentença ou acordo geram S-2500 e S-2501 com bases de cálculo, FGTS, IRRF e contribuições, inclusive para reclamantes sem vínculo.',
    },
  ],
  features: [
    {
      title: 'Cadastro do processo em 6 abas',
      text: 'Dados do processo, provisionamento, reclamada, reclamante, advogado do autor e dados do eSocial centralizados em um único cadastro.',
      icon: 'folder',
    },
    {
      title: 'Reclamante importado da folha',
      text: 'Pela matrícula, o sistema traz histórico contratual, cargo, salários e jornada. Terceiros e pessoas sem vínculo entram com o vínculo \'O\' exigido pelo eSocial.',
      icon: 'user-check',
    },
    {
      title: 'Fases, andamentos e verbas',
      text: 'Distribuição, audiência, sentença e recurso padronizados, com apontamentos detalhados e verbas indenizatórias e rescisórias mapeadas sem mexer na folha ativa.',
      icon: 'list-checks',
    },
    {
      title: 'Provisionamento por grau de risco',
      text: 'Cálculo e atualização da provisão por risco possível, provável ou remoto, com resultados de sentença e acordos registrados.',
      icon: 'scale',
    },
    {
      title: 'Painel de audiências e prepostos',
      text: 'Pautas do dia, prepostos designados e alertas de prazo, com controle de protocolos, envios e recebimentos de documentos.',
      icon: 'calendar',
    },
    {
      title: 'Penhoras e garantias do juízo',
      text: 'Depósitos em dinheiro ou penhora de bens com cronograma e um sinalizador que mostra se o valor apreendido cobre o juízo.',
      icon: 'lock',
    },
    {
      title: 'Honorários e escritórios',
      text: 'Cadastro de escritórios parceiros e advogados com OAB e validade, e rastreamento de pagamentos periciais e advocatícios.',
      icon: 'briefcase',
    },
    {
      title: 'Envio de S-2500 e S-2501',
      text: 'Dados da causa, bases contratuais, natureza do vínculo, IRRF e contribuições transmitidos do módulo jurídico ao eSocial.',
      icon: 'send',
    },
    {
      title: 'Termos de aceite digital',
      text: 'Políticas e termos com vigência e público-alvo, aceitos por matrícula, CPF e código, com data e hora registradas e reaceite obrigatório a cada versão.',
      icon: 'file-signature',
    },
    {
      title: 'Evidências rastreáveis',
      text: 'Fichas de EPI, espelhos de ponto e documentos no GED formam o prontuário da defesa, com histórico imutável de aprovações para auditoria.',
      icon: 'history',
    },
  ],
  flow: {
    title: 'O ciclo do processo em 5 etapas',
    steps: [
      { title: 'Petição inicial', text: 'Entrada, triagem e cadastro do pedido, com o reclamante importado da folha pela matrícula.' },
      { title: 'Audiências', text: 'Agendamento de pautas, designação de prepostos e controle de protocolos e prazos.' },
      { title: 'Sentença', text: 'Análise de contingência, provisão financeira por grau de risco e registro de acordos.' },
      { title: 'Recursos', text: 'Acompanhamento das instâncias superiores com histórico de cada fase.' },
      { title: 'Execução', text: 'Garantias do juízo, depósitos e penhoras, e envio nativo de S-2500 e S-2501 ao eSocial.' },
    ],
  },
  compliance: [
    'eSocial S-2500: processo trabalhista',
    'eSocial S-2501: tributos decorrentes de processo',
    'Vínculo \'O\' para reclamantes sem vínculo',
    'CLT e legislação trabalhista atualizada',
  ],
  personas: [
    { role: 'Jurídico e escritórios parceiros', text: 'Cadastra o processo, acompanha pautas e prepostos e registra andamentos com a base do RH ao alcance.' },
    { role: 'Departamento Pessoal', text: 'Fornece cargo, salário e jornada sem levantar papel e envia S-2500 e S-2501 sem redigitar.' },
    { role: 'CFO e Controladoria', text: 'Enxerga provisões por risco, depósitos judiciais e honorários para proteger o fluxo de caixa.' },
  ],
  faq: [
    {
      q: 'Os dados do reclamante precisam ser digitados no processo?',
      a: 'Não. Se o reclamante é ou foi colaborador, basta informar a matrícula: histórico contratual, cargo, salários e jornada vêm da folha. Para terceiros ou pessoas sem vínculo, o cadastro é simplificado e recebe o vínculo \'O\' exigido pelo eSocial.',
    },
    {
      q: 'Como o módulo ajuda a provisionar a contingência?',
      a: 'Cada processo registra os valores pleiteados e a provisão técnica calculada por grau de risco (possível, provável ou remoto), com datas de atualização, resultados de sentença e acordos. O gap entre os dois fica visível para o financeiro.',
    },
    {
      q: 'O envio ao eSocial é feito pelo módulo jurídico?',
      a: 'Sim. O S-2500 leva os dados da causa, bases contratuais e natureza do vínculo; o S-2501 leva bases de cálculo, IRRF e contribuições previdenciárias. Ambos saem direto do processo, sem retrabalho no Departamento Pessoal.',
    },
    {
      q: 'Dá para usar o módulo para termos e políticas internas?',
      a: 'Sim. O módulo de termos de aceite digital cria o texto, define vigência e público (ativos ou candidatos), vincula o aceite por matrícula, CPF e código e registra data e hora. Quando o termo muda, o reaceite é obrigatório e versionado.',
    },
  ],
  related: ['esocial', 'folha-de-pagamento', 'ponto-eletronico', 'ged'],
  sources: ['gestao-juridica-trabalhista', 'nati-operadores', 'csc-bpo', 'pagadoria'],
}

export default page
