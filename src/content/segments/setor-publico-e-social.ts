import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'setor-publico-e-social',
  name: 'Setor Público e Social',
  ctaContext: 'no setor público e social',
  tagline: 'O RH que [[presta contas]]: cada servidor, cada cargo, cada alteração registrada.',
  summary:
    'Órgãos públicos, autarquias, fundações, hospitais filantrópicos e terceiro setor respondem ao controle externo por cada admissão, progressão e afastamento. A Natcorp registra quem alterou o quê, controla frequência e despesa com pessoal e alimenta o portal de transparência e o eSocial.',
  seo: {
    title: 'RH para o setor público: auditoria e progressões | Natcorp',
    description:
      'RH para órgãos públicos, autarquias e terceiro setor: trilha de auditoria, cargo público e de confiança, progressão automática, frequência, LRF e eSocial.',
  },
  context: [
    'No setor público e social, cada decisão de pessoal é auditada. Tribunais de contas, controladorias e conselhos perguntam quem admitiu, quem progrediu, quem se afastou e com base em quê. Cargo público e cargo de confiança convivem na mesma folha, a progressão por tempo de serviço é direito e não favor, e estabilidade, licenças e pensionistas exigem histórico completo. O portal de transparência precisa refletir tudo isso.',
    'O orçamento de pessoal tem teto. A Lei de Responsabilidade Fiscal limita a despesa com pessoal, e cada nomeação, reajuste ou terceirização precisa caber no previsto. Estagiários e terceirizados convivem com efetivos e comissionados, a frequência é obrigação legal, e hospitais filantrópicos e entidades do terceiro setor prestam contas a convênios. Sem trilha de auditoria, a resposta ao controle externo vira caça a papel.',
  ],
  facts: [
    { value: 'Controle externo', label: 'trilha de auditoria de quem alterou o quê, pronta para tribunal e controladoria' },
    { value: 'Progressão', label: 'automática por tempo de serviço, parametrizada no cargo público ou de confiança' },
    { value: 'LRF', label: 'orçamento de pessoal previsto e realizado, com alerta antes de estourar o limite' },
  ],
  pains: [
    { icon: 'eye', title: 'Responder ao controle externo sem trilha de auditoria', text: 'Tribunal de contas e controladoria perguntam quem alterou um salário, quem aprovou uma nomeação e quando. Sem registro automático, a resposta sai de e-mails antigos e da memória de quem já saiu.' },
    { icon: 'briefcase', title: 'Cargo público, cargo de confiança e progressão', text: 'Efetivos progridem por tempo de serviço, comissionados entram e saem com a gestão, e cada carreira tem sua tabela. Feito à mão, o servidor recebe atrasado ou recebe errado, e os dois viram passivo.' },
    { icon: 'bar-chart', title: 'Limite de despesa com pessoal sem visão do realizado', text: 'A Lei de Responsabilidade Fiscal impõe teto à despesa com pessoal. Quando previsto e realizado vivem em planilhas separadas, a nomeação que estoura o limite só aparece no relatório de gestão.' },
    { icon: 'clock', title: 'Frequência de servidores em muitas unidades', text: 'Escolas, postos de saúde, secretarias e repartições espalhadas, cada uma com seu horário. A frequência é exigência legal, e o ponto em folha de papel não sustenta auditoria nem desconto de falta.' },
    { icon: 'users', title: 'Licenças, pensionistas, estagiários e terceiros', text: 'Licenças longas, afastamentos com regras próprias, pensionistas na folha e estagiários e terceirizados fora dela. Cada grupo tem sua regra, e todos precisam aparecer certos na transparência.' },
    { icon: 'send', title: 'Transparência, eSocial e capacitação separados', text: 'O portal de transparência, o eSocial do órgão e o controle de capacitação continuada dependem de extrações manuais. Cada extração é uma chance de divergência entre o que foi pago e o que foi publicado.' },
  ],
  answers: [
    {
      pain: 'Auditoria',
      title: 'Cada alteração registrada: quem fez, o que mudou e quando',
      text: 'Dados cadastrais e funcionais só mudam por requisição eletrônica, com registro de quem alterou o quê. Cada aprovação, consulta e alteração fica em trilha de auditoria, com acesso por perfil e por estrutura organizacional. A resposta ao controle externo sai do sistema, não de uma caixa de papel.',
      modules: ['administracao-de-pessoal', 'requisicoes-com-workflow', 'infraestrutura-e-seguranca', 'ged'],
    },
    {
      pain: 'Cargos e progressão',
      title: 'Cargo público, cargo de confiança e progressão automática na ficha do cargo',
      text: 'A ficha do cargo em Cargos e Salários traz vigências, cargo de confiança, progressão automática e períodos de experiência parametrizados. As tabelas seguem regras de mérito e promoção, reajustes fora da política são travados, e a nomeação ou exoneração passa pelo workflow e atualiza a folha sem redigitação.',
      modules: ['cargos-e-salarios', 'folha-de-pagamento', 'requisicoes-com-workflow', 'carreira-e-sucessao'],
    },
    {
      pain: 'Despesa com pessoal',
      title: 'Orçamento de pessoal previsto e realizado, com alerta de desvio',
      text: 'Cada posição carrega salário, encargos e benefícios, e o quadro atual, planejado, orçado e realizado aparece lado a lado. A nomeação mostra o impacto antes de acontecer, a alçada financeira valida, e o alerta de desvio chega antes do fim do mês. Simule cenários de reajuste ou concurso antes de decidir.',
      modules: ['administracao-de-pessoal', 'business-intelligence', 'cargos-e-salarios', 'people-analytics'],
    },
    {
      pain: 'Frequência',
      title: 'Ponto por unidade, no tablet ou no relógio, com espelho assinado',
      text: 'O NatPonto em modo multiusuário atende a equipe de cada unidade com reconhecimento facial, e os relógios de ponto já instalados entram por integração. O Ponto Eletrônico aplica jornadas e escalas por órgão, apura faltas e abonos com workflow e emite espelhos assinados digitalmente, com AFD e AEJ prontos para a fiscalização.',
      modules: ['natponto', 'ponto-eletronico', 'conexao-com-outros-sistemas', 'assinatura-eletronica'],
    },
    {
      pain: 'Afastamentos e terceiros',
      title: 'Licenças, pensionistas, estagiários e terceiros na mesma base',
      text: 'Afastamentos e licenças entram por requisição, refletem no ponto, na folha e no eSocial e ficam no histórico do servidor. Pensionistas e serviços de terceiros e autônomos são mantidos por requisição eletrônica, com acesso por perfil. A folha trata vários vínculos na mesma base, do efetivo ao estagiário, com todos os órgãos e entidades do grupo.',
      modules: ['requisicoes-com-workflow', 'medicina-ocupacional', 'folha-de-pagamento', 'administracao-de-pessoal'],
    },
    {
      pain: 'Transparência',
      title: 'Transparência, eSocial e capacitação alimentados pela mesma base',
      text: 'APIs prontas, construtor de APIs e exportação de arquivos levam os dados da folha ao portal de transparência e ao ERP do órgão sem redigitar. Os eventos do eSocial saem da folha validada, com validador prévio de divergências. A capacitação continuada tem turmas, presença, certificados e validade no mesmo sistema.',
      modules: ['conexao-com-outros-sistemas', 'esocial', 'treinamento-e-desenvolvimento', 'portais'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Efetivos, comissionados, celetistas e pensionistas na mesma folha, com vários vínculos e conferência pela NATI.',
    'administracao-de-pessoal': 'Quadro de cargos previsto e realizado, despesa com pessoal dentro do limite e registro de quem alterou o quê.',
    'cargos-e-salarios': 'Cargo público e cargo de confiança com vigências, progressão automática por tempo de serviço e tabelas por carreira.',
    'gestao-de-beneficios': 'Auxílios, plano de saúde e vale-transporte com elegibilidade por cargo e regime, e fatura conferida antes de pagar.',
    natpay: 'Adiantamento com desconto automático no contracheque e histórico de cada pedido, quando a política do órgão ou da entidade permitir.',
    esocial: 'Eventos do órgão gerados da folha validada, com validador prévio, protocolo e retorno de cada layout acompanhados.',
    'juridico-trabalhista': 'Processos de celetistas e terceirizados com provisão por risco e S-2500 e S-2501 enviados direto do processo.',
    'ponto-eletronico': 'Jornadas e escalas por órgão e unidade, controle de frequência com abono por workflow e espelho assinado.',
    natponto: 'Tablet multiusuário na repartição, na escola ou no posto de saúde, com reconhecimento facial e uso sem internet.',
    'medicina-ocupacional': 'Licenças e afastamentos registrados uma vez, refletidos no ponto, na folha e no eSocial, com histórico por servidor.',
    'seguranca-do-trabalho': 'PGR, EPIs com CA validado, CIPA com eleição digital e CAT com S-2210 para as unidades operacionais do órgão.',
    'recrutamento-e-selecao': 'Processos seletivos de celetistas, estagiários e temporários com etapas, prazos e requisitos vindos do cargo.',
    'quadro-de-vagas': 'Vagas e processos seletivos publicados com a identidade do órgão ou da entidade, candidatura pelo celular.',
    'admissao-digital': 'Admissão e nomeação sem papel, com documentos no GED, termos assinados e cadastro nascendo na folha e no ponto.',
    onboarding: 'Acolhimento de novos servidores e comissionados com código de conduta, políticas e trilha de capacitação inicial.',
    offboarding: 'Exoneração e fim de contrato pelo workflow, com cálculo, bloqueio de acessos e histórico auditável de quem aprovou.',
    'avaliacoes-e-feedbacks': 'Avaliação de desempenho e de estágio probatório com ciclos, pesos e escalas definidos pelo RH, sem depender de TI.',
    'metas-e-resultados': 'Metas institucionais e por unidade, com apuração transparente e feedback obrigatório do gestor no fechamento.',
    'treinamento-e-desenvolvimento': 'Capacitação continuada com turmas, presença, certificados e validade, e orçamento de treinamento por unidade.',
    'carreira-e-sucessao': 'Planos de carreira por cargo e sucessão para chefias e funções de confiança, com prontidão e PDI acompanhados.',
    portais: 'O servidor consulta contracheque, frequência e requisições; a chefia aprova pelo celular dentro da alçada.',
    'requisicoes-com-workflow': 'Nomeação, licença, afastamento, pensionista, terceiro e alteração cadastral com alçadas e histórico permanente.',
    'chamado-interno': 'Atendimento ao servidor com SLA, fila por área e histórico imutável, pronto para a prestação de contas.',
    'blog-corporativo': 'Portarias, comunicados e campanhas publicados para todos os servidores, por perfil, na timeline do portal.',
    'assinatura-eletronica': 'Termos, espelhos de ponto e documentos funcionais assinados no padrão ICP-Brasil, verificáveis por qualquer auditor.',
    ged: 'Prontuário funcional digital por servidor, com acesso por perfil e evidências rastreáveis para auditoria.',
    'people-analytics': 'Servidores por cargo, regime, unidade e tempo de serviço em pivô e gráfico, exportados em Excel ou PDF.',
    'business-intelligence': 'Painéis de despesa com pessoal, quadro por unidade e absenteísmo, com alerta por e-mail quando sai da faixa.',
    nati: 'Responde ao servidor sobre contracheque e frequência e aponta, antes de a folha rodar, o que não bate com o regime e a tabela do cargo.',
    'conexao-com-outros-sistemas': 'APIs e arquivos alimentam o portal de transparência, o ERP e o sistema orçamentário do órgão sem redigitar.',
    'infraestrutura-e-seguranca': 'Trilha de auditoria de cada ação, dois fatores, acesso por perfil e nuvem com contingência para a folha não parar.',
  },
  spotlight: ['administracao-de-pessoal', 'cargos-e-salarios', 'ponto-eletronico', 'requisicoes-com-workflow', 'conexao-com-outros-sistemas', 'infraestrutura-e-seguranca'],
  compliance: [
    'Lei de Responsabilidade Fiscal: limite de despesa com pessoal, previsto e realizado',
    'Lei de Acesso à Informação e portal de transparência alimentados pela folha',
    'Prestação de contas a tribunais de contas e controladorias, com trilha de auditoria',
    'eSocial para órgãos públicos, com eventos gerados da folha validada',
    'Controle de frequência de servidores, com espelho de ponto assinado digitalmente',
    'LGPD no tratamento de dados de servidores, pensionistas e estagiários',
  ],
  personas: [
    { role: 'Gestor de pessoas do órgão', text: 'Responde ao tribunal de contas com a trilha de auditoria na tela, acompanha a despesa com pessoal e efetiva progressões sem planilha.' },
    { role: 'Chefia de unidade', text: 'Aprova frequência, licenças e requisições da equipe pelo celular, dentro da alçada, e vê o quadro da unidade em tempo real.' },
    { role: 'Servidor', text: 'Consulta contracheque, frequência e progressão no portal, pede licença por requisição e pergunta à NATI sem ir ao setor de pessoal.' },
  ],
  faq: [
    {
      q: 'O sistema diferencia cargo público de cargo de confiança e faz progressão automática?',
      a: 'Sim. A ficha do cargo em Cargos e Salários traz vigências, cargo de confiança, progressão automática e períodos de experiência. As tabelas salariais seguem regras de mérito e promoção por carreira, e a movimentação aprovada no workflow atualiza cargo, salário e posição na folha sem redigitação.',
    },
    {
      q: 'Como respondemos a uma auditoria do controle externo?',
      a: 'Pelo próprio sistema. Cada consulta, alteração e aprovação fica registrada com quem fez e quando, em trilha de auditoria. Dados cadastrais e funcionais só mudam por requisição, com histórico permanente, e o GED guarda o prontuário funcional com acesso por perfil.',
    },
    {
      q: 'Dá para acompanhar o limite de despesa com pessoal?',
      a: 'Sim. A Administração de Pessoal compara quadro atual, planejado, orçado e realizado, com salário, encargos e benefícios de cada posição. Nomeações e reajustes mostram o impacto antes de acontecer, e o alerta de desvio chega antes do fechamento. Os painéis do Business Intelligence mostram a evolução por unidade.',
    },
    {
      q: 'O portal de transparência e o eSocial podem ser alimentados pelo sistema?',
      a: 'Sim. As APIs prontas, o construtor de APIs e a exportação de arquivos levam os dados da folha ao portal de transparência e aos sistemas do órgão. Os eventos do eSocial saem da folha validada, com validador prévio de divergências e acompanhamento do retorno de cada layout.',
    },
  ],
  visual: 'operator',
  related: ['saude-e-ciencias-biologicas', 'servicos-financeiros'],
}

export default page
