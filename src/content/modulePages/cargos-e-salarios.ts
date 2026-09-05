import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'cargos-e-salarios',
  name: 'Cargos e Salários',
  group: 'pessoal-e-folha',
  tagline: 'Cargos, faixas e reajustes [[sempre dentro da política]].',
  summary:
    'Descrições, requisitos, competências e tabelas salariais em um cadastro só. Reajustes fora da política são travados, desvios geram alerta ao gestor e a NATI aponta distorções de equidade. Simule o impacto na folha antes de aprovar.',
  seo: {
    title: 'Cargos e Salários com equidade | Natcorp',
    description:
      'Gestão de cargos e salários: descrições com CBO, requisitos de admissão, tabelas salariais, travas de política, simulação de reajustes e equidade pela NATI.',
  },
  highlights: [],
  benefits: [
    {
      title: 'Política salarial executada sem exceções',
      text: 'Só os motivos de alteração permitidos passam. Reajustes acima do limite ou fora da regra são travados na hora, e o gestor recebe alerta de desvio.',
    },
    {
      title: 'Equidade interna visível',
      text: 'A NATI cruza a remuneração de toda a estrutura, aponta distorções entre pessoas e áreas e sugere a revisão de faixas. Decisão com dado, não com impressão.',
    },
    {
      title: 'Impacto na folha antes do reajuste',
      text: 'Simule mérito ou dissídio e veja o custo real na folha. Compare com o histórico salarial e os espelhos retroativos antes de aprovar.',
    },
    {
      title: 'Contratação dentro do perfil e do teto',
      text: 'Cada cargo carrega teto salarial, formação e experiência mínima. A vaga já nasce com esses filtros, sem contratar fora da política.',
    },
  ],
  features: [
    {
      title: 'Ficha completa do cargo',
      text: 'Vigências, cargo de confiança, periculosidade, períodos de experiência, progressão automática e percentual de adiantamento parametrizados por cargo.',
      icon: 'briefcase',
    },
    {
      title: 'Descrições e funções com CBO',
      text: 'Descrição sumária, atividades detalhadas, chefia imediata e orientações de segurança por local, com função ligada ao CBO e associação em massa.',
      icon: 'file-text',
    },
    {
      title: 'Requisitos de admissão',
      text: 'Teto salarial, formação mínima e desejável, experiência em anos e meses e limite de advertências definidos no cargo e usados no recrutamento.',
      icon: 'filter',
    },
    {
      title: 'Competências por cargo',
      text: 'Cadastro de competências em itens, grupos e subgrupos, que alimenta o plano de carreira e as avaliações de desempenho.',
      icon: 'list-checks',
    },
    {
      title: 'Tabelas salariais e faixas',
      text: 'Estruturação de tabelas com regras de mérito e promoção, visíveis por hora ou por mês, para apoiar decisões salariais com dados.',
      icon: 'table',
    },
    {
      title: 'Travas e alertas de política',
      text: 'Motivos permitidos de alteração salarial, bloqueio de reajustes fora da regra e notificação automática ao gestor em caso de desvio.',
      icon: 'lock',
    },
    {
      title: 'Simulação de reajustes',
      text: 'Cenários de mérito ou acordo sindical com o impacto financeiro real na folha, ao lado do histórico salarial e das evoluções cadastrais.',
      icon: 'calculator',
    },
    {
      title: 'Workflow com alçadas',
      text: 'Grupos de aprovadores em sequência, suplência automática e regras de exceção, adaptados a hierarquia por centro de custo ou estrutura matricial.',
      icon: 'workflow',
    },
    {
      title: 'Custo da posição',
      text: 'Cada vaga calcula seu custo: salário base mais benefícios e ocorrências. Vagas geradas automaticamente a partir das premissas de headcount.',
      icon: 'banknote',
    },
    {
      title: 'Equidade analisada pela NATI',
      text: 'A IA diagnostica distorções de equidade interna e competitividade e sugere ajustes de faixa. A NATI sugere, o gestor decide.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Do pedido de reajuste à folha',
    steps: [
      { title: 'Pedido de alteração salarial', text: 'O gestor solicita mérito, promoção ou enquadramento pelo portal, informando o motivo previsto na política.' },
      { title: 'Checagem da política', text: 'O sistema valida motivo, faixa e limite percentual. Fora da regra, o reajuste é travado e o gestor recebe alerta.' },
      { title: 'Simulação do impacto', text: 'O RH vê o custo real na folha e o histórico salarial da pessoa antes de seguir.' },
      { title: 'Aprovação por alçada', text: 'O pedido percorre os grupos de aprovadores, com suplência automática se alguém estiver ausente.' },
      { title: 'Efetivação na folha', text: 'Aprovado, o novo salário entra na folha e no histórico, sem redigitar.' },
    ],
  },
  compliance: ['CBO (Classificação Brasileira de Ocupações) nas funções', 'Periculosidade e cargo de confiança parametrizados por cargo', 'Acordos sindicais e dissídio nos cenários de reajuste'],
  personas: [
    { role: 'RH e Remuneração', text: 'Mantém estrutura de cargos, tabelas e faixas em um só cadastro e simula reajustes antes de levar à diretoria.' },
    { role: 'Gestor', text: 'Pede promoções e méritos dentro da política, com alçada clara, e recebe alerta se algo sair da regra.' },
    { role: 'Colaborador', text: 'Entende a estrutura de cargos e os critérios de promoção pelo portal e tira dúvidas com a NATI.' },
  ],
  faq: [
    {
      q: 'O sistema impede um reajuste fora da política salarial?',
      a: 'Sim. Você define os motivos permitidos de alteração e os limites percentuais. Um reajuste que viole a política ou ultrapasse o limite é travado imediatamente, e o gestor recebe uma notificação de desvio.',
    },
    {
      q: 'Dá para simular o impacto de um dissídio ou de um ciclo de mérito?',
      a: 'Sim. O módulo monta o cenário de mérito ou acordo sindical e mostra o impacto financeiro real na folha, ao lado dos históricos salariais e dos espelhos retroativos para comparação.',
    },
    {
      q: 'Como a NATI ajuda na equidade salarial?',
      a: 'A NATI trata os dados de remuneração de toda a estrutura, diagnostica distorções de equidade interna e competitividade e sugere revisão de faixas. Ela não decide nem altera salário: apresenta análise, diagnóstico, pontos de atenção e sugestão para o gestor.',
    },
    {
      q: 'As descrições de cargo servem para outros módulos?',
      a: 'Sim. Requisitos, competências e funções com CBO alimentam o Recrutamento e Seleção, o plano de carreira e as avaliações. As orientações de segurança por local de trabalho apoiam o SESMT.',
    },
  ],
  related: ['administracao-de-pessoal', 'carreira-e-sucessao', 'metas-e-resultados', 'folha-de-pagamento'],
  sources: ['gestao-de-cargos-e-remuneracoes', 'nati-gestores', 'gestao-de-rh', 'nati-operadores', 'nati-colaboradores'],
}

export default page
