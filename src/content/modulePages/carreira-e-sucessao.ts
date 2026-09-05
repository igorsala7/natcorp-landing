import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'carreira-e-sucessao',
  name: 'Carreira e Sucessão',
  group: 'desenvolvimento',
  tagline: 'Sucessor pronto [[antes de a vaga abrir]].',
  summary:
    'Planos de carreira ligados aos requisitos de cada cargo, mapa de sucessão com prontidão e risco de perda, PDI (plano de desenvolvimento individual) acompanhado em tempo real. Tudo alimentado pelas avaliações e pela matriz nine box (desempenho x potencial).',
  seo: {
    title: 'Carreira e Sucessão com dados | Natcorp',
    description:
      'Carreira e sucessão para grandes empresas: posições-chave, sucessores com prontidão e risco de perda, PDI e trilhas ligados a cargos, avaliações e treinamento.',
  },
  highlights: [],
  benefits: [
    {
      title: 'Sucessor pronto antes de a vaga abrir',
      text: 'Posições-chave mapeadas com sucessores, nível de prontidão e risco de perda de quem ocupa hoje. Quando alguém sai, a resposta já existe.',
    },
    {
      title: 'Carreira clara para quem fica',
      text: 'O colaborador vê a trilha, os requisitos do próximo cargo e o próprio PDI no portal. Clareza sobre o futuro retém mais do que promessa.',
    },
    {
      title: 'Decisão com dados, não com indicação',
      text: 'Matriz nine box, avaliações, competências e formação no mesmo lugar. A promoção segue a política de cargos e passa pelo workflow de aprovação.',
    },
    {
      title: 'Ligado a cargos, avaliações e treinamento',
      text: 'Requisitos vêm de Cargos e Salários, resultados vêm das Avaliações, gaps viram trilhas em Treinamento. Nada é cadastrado duas vezes.',
    },
  ],
  features: [
    {
      title: 'Planos de carreira por cargo',
      text: 'Trilhas de crescimento com os requisitos de cada cargo: formação, experiência, competências e faixa salarial. Personalizadas por área ou por pessoa.',
      icon: 'git-branch',
    },
    {
      title: 'Mapa de sucessão',
      text: 'Posições-chave com sucessores indicados, nível de prontidão de cada um e risco de perda de quem ocupa a posição hoje.',
      icon: 'users',
    },
    {
      title: 'Risco de perda',
      text: 'Sinaliza talentos com risco de saída a partir de avaliações, feedbacks e padrões que a NATI identifica, para o RH agir antes do pedido de demissão.',
      icon: 'alert-triangle',
    },
    {
      title: 'Matriz nine box',
      text: 'Cruza potencial e desempenho do ciclo de avaliação para localizar quem tem alto potencial e quem está pronto para o próximo passo.',
      icon: 'layout-grid',
    },
    {
      title: 'PDI acompanhado',
      text: 'Plano de desenvolvimento individual com treinamentos, mentorias e prazos, acompanhado em tempo real por gestor e colaborador.',
      icon: 'list-checks',
    },
    {
      title: 'Competências e formação',
      text: 'Cadastro de competências por itens, grupos e subgrupos ligado ao cargo. Compare o perfil de hoje com o exigido pela próxima posição.',
      icon: 'graduation-cap',
    },
    {
      title: 'Promoção pelo workflow',
      text: 'Indicação para movimentação, promoção ou transferência passa pelas alçadas e, aprovada, atualiza cargo, salário e posição no headcount.',
      icon: 'workflow',
    },
    {
      title: 'Regras de mérito e progressão',
      text: 'Tabelas salariais com regras de mérito e promoção, progressão automática e travas para reajustes fora da política.',
      icon: 'trending-up',
    },
    {
      title: 'Histórico de cada pessoa',
      text: 'Visão evolutiva de desempenho, competências, feedbacks, metas e desenvolvimento ao longo do tempo, em um só lugar.',
      icon: 'history',
    },
    {
      title: 'Carreira no portal',
      text: 'O colaborador acompanha carreira, PDI e feedbacks no Painel do Colaborador. O gestor vê a equipe no Portal do Gestor.',
      icon: 'smartphone',
    },
  ],
  flow: {
    title: 'Da posição-chave ao sucessor pronto',
    steps: [
      { title: 'Posições-chave', text: 'O RH define quais cargos e posições não podem ficar sem sucessor.' },
      { title: 'Talentos mapeados', text: 'A matriz nine box e as avaliações apontam alto desempenho e alto potencial.' },
      { title: 'Sucessores e prontidão', text: 'Cada posição ganha sucessores, com nível de prontidão e risco de perda.' },
      { title: 'PDI em andamento', text: 'Gaps viram trilhas, treinamentos e mentorias, acompanhados em tempo real.' },
      { title: 'Movimentação aprovada', text: 'A promoção passa pelo workflow e atualiza cargo, salário e headcount.' },
    ],
  },
  personas: [
    { role: 'RH e diretoria', text: 'Enxerga posições-chave sem sucessor, risco de perda e prontidão em um painel. Planeja a próxima geração de líderes com dados.' },
    { role: 'Gestor', text: 'Acompanha o PDI de cada pessoa da equipe, indica movimentações e vê quem está pronto para o próximo passo.' },
    { role: 'Colaborador', text: 'Vê o plano de carreira, os requisitos do próximo cargo e o próprio PDI no portal, sem precisar perguntar ao RH.' },
  ],
  faq: [
    {
      q: 'Como o sistema identifica sucessores para as posições-chave?',
      a: 'Com dados concretos: a matriz nine box cruza potencial e desempenho do ciclo de avaliação, as competências e a formação vêm do cadastro de cargos, e cada sucessor recebe um nível de prontidão. O RH indica os sucessores e acompanha os PDIs até que estejam prontos.',
    },
    {
      q: 'O que é risco de perda e de onde vem esse dado?',
      a: 'É o sinal de que um talento pode sair. Ele considera avaliações, feedbacks e padrões que a NATI identifica no histórico da pessoa. Serve para o RH e o gestor agirem antes, com PDI, movimentação ou reconhecimento.',
    },
    {
      q: 'O colaborador consegue ver o próprio plano de carreira?',
      a: 'Sim. No Painel do Colaborador ele vê a trilha de carreira, os requisitos do próximo cargo, o próprio PDI e os feedbacks liberados pelo gestor, no celular ou no computador.',
    },
    {
      q: 'A promoção aprovada precisa ser lançada de novo na folha?',
      a: 'Não. A indicação de movimentação ou promoção passa pelo workflow de alçadas e, quando aprovada, atualiza cargo, salário e posição no headcount automaticamente, respeitando as regras da tabela salarial.',
    },
  ],
  related: ['avaliacoes-e-feedbacks', 'treinamento-e-desenvolvimento', 'cargos-e-salarios', 'administracao-de-pessoal'],
  sources: ['gestao-de-rh', 'gestao-de-avaliacoes', 'gestao-de-cargos-e-remuneracoes', 'gestao-de-headcount', 'gestao-de-treinamentos', 'apresentacao-natcorp'],
}

export default page
