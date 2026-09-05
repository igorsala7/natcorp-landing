import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'onboarding',
  name: 'Onboarding',
  group: 'talentos',
  tagline: 'A primeira impressão [[que transforma]].',
  summary:
    'Vídeos, textos, imagens e arquivos que acolhem quem chega à empresa ou muda de cargo. O Onboarding nasce da Admissão Digital, aparece no Portal do Colaborador desde o primeiro dia e organiza informações, instruções iniciais e treinamentos de entrada.',
  seo: {
    title: 'Onboarding digital de colaboradores | Natcorp',
    description:
      'Onboarding digital integrado à admissão: vídeos, textos, imagens e arquivos no Portal do Colaborador para quem entra na empresa ou assume um novo cargo.',
  },
  highlights: [],
  benefits: [
    {
      title: 'Engajamento desde o primeiro dia',
      text: 'Quem chega encontra uma jornada de entrada organizada e acolhedora, com a marca da empresa. A marca empregadora se fortalece antes mesmo do primeiro resultado.',
    },
    {
      title: 'Menos tarefas manuais para o DP',
      text: 'O onboarding aproveita o cadastro da Admissão Digital. O colaborador valida os próprios dados e recebe as instruções iniciais sem o RH mandar e-mail um a um.',
    },
    {
      title: 'Mesma experiência em toda a empresa',
      text: 'Conteúdo padronizado por empresa, área ou cargo garante que todos recebam as mesmas informações, em qualquer unidade.',
    },
    {
      title: 'Também para quem muda de cargo',
      text: 'Promoção ou transferência também merece acolhimento. O onboarding de um novo cargo orienta o colaborador sobre as novas responsabilidades.',
    },
  ],
  features: [
    {
      title: 'Conteúdo de boas-vindas',
      text: 'Vídeos, imagens, arquivos e textos sobre a empresa, a cultura, as políticas e o dia a dia, organizados para quem está chegando.',
      icon: 'layers',
    },
    {
      title: 'Entrada na empresa ou em novo cargo',
      text: 'Monte um onboarding para novos colaboradores e outro para quem assume um cargo novo, com as informações de cada função.',
      icon: 'git-branch',
    },
    {
      title: 'Nasce da Admissão Digital',
      text: 'Admitido na folha, o colaborador já tem o onboarding liberado. Sem cadastro extra, sem enviar link por e-mail.',
      icon: 'file-signature',
    },
    {
      title: 'Por empresa, unidade, área ou cargo',
      text: 'Conteúdo montado por empresa, unidade, área ou cargo. Quem entra na filial vê a rotina dela; quem assume um cargo novo vê as responsabilidades da função. Tudo no Portal do Colaborador, ao lado de ponto, requisições e feedbacks.',
      icon: 'building',
    },
    {
      title: 'Instruções iniciais e lembretes',
      text: 'Alertas e lembretes contextuais chegam conforme a etapa da jornada, com a NATI personalizando a comunicação.',
      icon: 'bell',
    },
    {
      title: 'Questionários personalizados',
      text: 'Aplique questionários de integração para confirmar o entendimento das políticas e coletar informações do novo colaborador.',
      icon: 'list-checks',
    },
    {
      title: 'Documentos no GED',
      text: 'Os documentos do colaborador ficam no GED (Gestão Eletrônica de Documentos) desde a admissão, e políticas e termos podem ser aceitos digitalmente.',
      icon: 'folder',
    },
    {
      title: 'Blog Corporativo e comunicação',
      text: 'Comunicados, vídeos e avisos do Blog Corporativo entram no acolhimento, para o novato se sentir parte do time desde o dia zero.',
      icon: 'message-square',
    },
    {
      title: 'Treinamentos de entrada',
      text: 'Trilhas de onboarding no módulo de Treinamento e Desenvolvimento, com inscrições, presença e certificados no mesmo portal.',
      icon: 'graduation-cap',
    },
    {
      title: 'Acompanhamento de conclusão',
      text: 'O RH vê quem já assistiu, leu e respondeu cada etapa, por unidade, e cobra só quem ficou para trás. No caminho, o colaborador confere e completa os próprios dados com autonomia.',
      icon: 'user-check',
    },
  ],
  flow: {
    title: 'Da admissão ao primeiro mês',
    steps: [
      { title: 'Admissão concluída', text: 'O contrato é assinado e o cadastro nasce na folha. O onboarding é liberado.' },
      { title: 'Boas-vindas no portal', text: 'O colaborador acessa vídeos, textos e arquivos da empresa no Portal do Colaborador.' },
      { title: 'Instruções e lembretes', text: 'Alertas orientam cada etapa: políticas, termos, dados a completar e o que fazer no primeiro dia.' },
      { title: 'Treinamentos iniciais', text: 'Trilha de entrada com os cursos obrigatórios da função, presença e certificado registrados.' },
      { title: 'Integrado ao time', text: 'Feedbacks, Blog Corporativo e chamados ao RH no mesmo portal. O acolhimento continua depois da primeira semana.' },
    ],
  },
  personas: [
    { role: 'Novo colaborador', text: 'Chega sabendo onde encontrar informações, políticas e treinamentos, pelo celular, sem depender de alguém explicar tudo.' },
    { role: 'RH e Departamento Pessoal', text: 'Monta o conteúdo uma vez e deixa o sistema entregar a cada admissão. Acompanha quem já concluiu cada etapa, por unidade.' },
    { role: 'Gestor', text: 'Recebe o novo integrante já orientado e acompanha a participação nos treinamentos de entrada pelo Portal do Gestor.' },
  ],
  faq: [
    {
      q: 'Que tipo de conteúdo posso colocar no onboarding?',
      a: 'Vídeos, imagens, arquivos e textos: apresentação da empresa, políticas, benefícios, orientações do cargo e o que for útil para a entrada. O conteúdo fica no Portal do Colaborador.',
    },
    {
      q: 'O onboarding serve para quem muda de cargo?',
      a: 'Sim. Além da entrada na empresa, é possível montar um onboarding para o novo cargo, orientando o colaborador promovido ou transferido sobre as novas responsabilidades.',
    },
    {
      q: 'Preciso cadastrar o colaborador de novo para liberar o onboarding?',
      a: 'Não. O onboarding é integrado à Admissão Digital. Concluída a admissão, o colaborador já acessa o conteúdo com o mesmo login do portal.',
    },
    {
      q: 'O RH sabe quem concluiu o onboarding?',
      a: 'Sim. Cada etapa fica registrada: conteúdo visto, questionário respondido, termo aceito e treinamento concluído. O RH acompanha por empresa e unidade e o gestor vê a equipe dele no Portal do Gestor. O colaborador faz tudo no Portal do Colaborador, no celular, no tablet ou no computador.',
    },
  ],
  related: ['admissao-digital', 'blog-corporativo', 'treinamento-e-desenvolvimento', 'offboarding'],
  sources: ['admissao-digital', 'gestao-de-rh', 'performance-e-seguranca', 'abrangencia-do-sistema', 'apresentacao-natcorp', 'csc-bpo', 'gestao-de-treinamentos'],
}

export default page
