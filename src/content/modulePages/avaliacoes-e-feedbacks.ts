import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'avaliacoes-e-feedbacks',
  name: 'Avaliações, Pesquisas e Feedbacks',
  group: 'desenvolvimento',
  tagline: 'Desempenho acompanhado [[o ano inteiro]], não só no fim dele.',
  summary:
    'Ciclos de 90° a 360°, pesquisas de clima e feedback contínuo em um só lugar. O RH monta perguntas, pesos e escalas sem depender de TI. O resultado alimenta calibração, a matriz nine box (desempenho x potencial), o plano de desenvolvimento, bônus e sucessão.',
  seo: {
    title: 'Avaliações, Pesquisas e Feedbacks | Natcorp',
    description:
      'Avaliação de desempenho: ciclos de 90° a 360°, pesquisas de clima, feedback contínuo, calibração e nine box, com LGPD e integração a bônus, PDI e sucessão.',
  },
  highlights: [
    { value: '90° a 360°', label: 'ciclos anuais, semestrais ou trimestrais, como o RH definir' },
  ],
  benefits: [
    {
      title: 'Do evento anual à gestão contínua',
      text: 'Ciclos flexíveis e feedback registrado na hora em que acontece. O desempenho deixa de ser surpresa de fim de ano e vira acompanhamento do dia a dia.',
    },
    {
      title: 'Autonomia total do RH',
      text: 'O RH cria ciclos, perguntas, escalas, pesos e fórmulas sem código e sem chamado para a TI. Mudou a política de avaliação? Muda o modelo.',
    },
    {
      title: 'Decisões justas e rastreáveis',
      text: 'A calibração compara áreas, mostra distorções e registra a decisão do comitê. Promoção, bônus e sucessão nascem de dados, não de impressão.',
    },
    {
      title: 'Ligado a metas, remuneração e carreira',
      text: 'O resultado da avaliação alimenta o cálculo de bônus, a matriz nine box, o PDI (plano de desenvolvimento individual) e o mapa de sucessão. Sem planilha, sem redigitar nota.',
    },
  ],
  features: [
    {
      title: 'Ciclos de 90° a 360°',
      text: 'Avaliações anuais, semestrais ou trimestrais em 90°, 180°, 270° ou 360°: gestor, pares, liderados, clientes e autoavaliação, como a empresa definir.',
      icon: 'refresh',
    },
    {
      title: 'Perguntas e escalas do seu jeito',
      text: 'O RH define critérios, pesos, escalas, perguntas e fórmulas de cada modelo de avaliação ou pesquisa. Sem desenvolvimento.',
      icon: 'clipboard',
    },
    {
      title: 'Workflow com prazos e lembretes',
      text: 'Etapas, prazos, aprovações e lembretes automáticos. O sistema avisa quem está atrasado e trata as exceções do ciclo.',
      icon: 'workflow',
    },
    {
      title: 'Desempenho, competências e valores',
      text: 'Mede resultados integrados às metas e avalia habilidades técnicas, comportamentais, liderança e aderência à cultura da empresa.',
      icon: 'target',
    },
    {
      title: 'Feedback contínuo',
      text: 'O gestor localiza a pessoa, registra título, pontos fortes, pontos de atenção e nota por estrelas. Pelo celular, no chão de fábrica ou em viagem.',
      icon: 'message-square',
    },
    {
      title: 'Privacidade de cada feedback',
      text: 'Feedback privado, que só o autor vê, ou público para gestores autorizados. O gestor decide se o colaborador pode visualizar.',
      icon: 'lock',
    },
    {
      title: 'Pesquisas de clima',
      text: 'Escuta ativa do clima interno com perguntas e escalas montadas pelo RH e respostas tratadas com anonimização, conforme a LGPD.',
      icon: 'users',
    },
    {
      title: 'Calibração entre áreas',
      text: 'Compara as avaliações de equipes e áreas em uma grade, aponta distorções e registra a decisão do comitê de forma imutável.',
      icon: 'scale',
    },
    {
      title: 'Matriz nine box e PDI',
      text: 'Cruza potencial e desempenho para achar talentos e sucessores. Planos de desenvolvimento, treinamentos e mentorias acompanhados em tempo real.',
      icon: 'layout-grid',
    },
    {
      title: 'Painéis e leitura da NATI',
      text: 'Distribuição de notas, tendências e pontos de atenção em tempo real. A NATI identifica padrões, inconsistências e risco de perda de talentos.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Do desenho do ciclo à decisão',
    steps: [
      { title: 'RH monta o ciclo', text: 'Define público, modelo, perguntas, pesos, escalas e prazos, sem depender de TI.' },
      { title: 'Todos avaliam', text: 'Gestor, pares, liderados e o próprio colaborador respondem no portal, com lembretes automáticos.' },
      { title: 'Calibração', text: 'Comitês comparam resultados entre áreas e registram os ajustes.' },
      { title: 'Matriz nine box e PDI', text: 'Talentos mapeados, planos de desenvolvimento criados e acompanhados.' },
      { title: 'Bônus, carreira e sucessão', text: 'O resultado alimenta a remuneração variável, o plano de carreira e o mapa de sucessão.' },
    ],
  },
  compliance: ['LGPD: acesso por perfil, confidencialidade, anonimização e trilha de auditoria'],
  personas: [
    { role: 'RH', text: 'Cria ciclos, perguntas e escalas sem TI. Acompanha quem respondeu, calibra resultados e leva tudo para bônus e sucessão.' },
    { role: 'Gestor', text: 'Registra feedback na hora, pelo celular, e vê a evolução de cada pessoa da equipe em um só painel.' },
    { role: 'Colaborador', text: 'Faz a autoavaliação, responde às pesquisas e consulta os feedbacks liberados no Painel do Colaborador.' },
  ],
  faq: [
    {
      q: 'O RH consegue criar as perguntas e escalas sem a TI?',
      a: 'Sim. Critérios, pesos, escalas, perguntas e fórmulas de cada modelo são definidos pelo próprio RH na tela, sem desenvolvimento. Vale para avaliações e para pesquisas.',
    },
    {
      q: 'Quais tipos de ciclo o módulo suporta?',
      a: 'Ciclos anuais, semestrais e trimestrais, em formato 90°, 180°, 270° ou 360°. A empresa escolhe quem avalia quem: gestor, pares, liderados, clientes e autoavaliação. O workflow controla etapas, prazos e lembretes.',
    },
    {
      q: 'O colaborador vê o feedback que o gestor registrou?',
      a: 'Só se o gestor liberar. Cada feedback tem controle de visualização pelo colaborador e pode ser privado, visível apenas para o autor, ou público, visível para gestores autorizados. O que for liberado aparece no Painel do Colaborador.',
    },
    {
      q: 'Como fica a LGPD nas avaliações e pesquisas?',
      a: 'Acesso por perfil, confidencialidade nas avaliações 360°, anonimização nas pesquisas, criptografia e trilha de auditoria de quem viu e alterou cada informação. O histórico de cada pessoa fica preservado e rastreável.',
    },
  ],
  related: ['metas-e-resultados', 'carreira-e-sucessao', 'treinamento-e-desenvolvimento', 'portais'],
  sources: ['gestao-de-avaliacoes', 'feedback', 'gestao-de-rh', 'apresentacao-natcorp', 'csc-bpo', 'nati-gestores'],
}

export default page
