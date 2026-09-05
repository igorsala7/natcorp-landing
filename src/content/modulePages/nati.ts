import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'nati',
  name: 'NATI',
  group: 'dados-ia-plataforma',
  tagline: 'A NATI analisa e sugere. [[O gestor decide]].',
  summary:
    'A inteligência artificial que trabalha dentro do sistema de RH. Ela cruza folha, ponto, benefícios, cargos, talentos e SESMT, aponta inconsistências antes do fechamento e responde ao colaborador 24 horas por dia, pelo sistema, WhatsApp ou Teams.',
  seo: {
    title: 'NATI: a inteligência artificial do RH | Natcorp',
    description:
      'NATI, a IA da Natcorp: audita a folha antes do fechamento, analisa dez frentes do RH e responde a colaboradores 24/7 no sistema, WhatsApp e Teams.',
  },
  highlights: [
    { value: '10', label: 'frentes do RH analisadas por um único motor' },
    { value: '24/7', label: 'respostas padronizadas e confidenciais ao colaborador' },
    { value: '120+', label: 'idiomas disponíveis na plataforma Natcorp' },
    { value: '4', label: 'etapas por resposta: análise, diagnóstico, alerta e sugestão' },
  ],
  benefits: [
    {
      title: 'Erros encontrados antes do fechamento',
      text: 'A NATI audita a folha e a frequência com o mês ainda aberto. Inconsistências de cálculo e desvios da CLT aparecem com sugestão de correção, não na auditoria seguinte.',
    },
    {
      title: 'Menos conferência manual, mais decisão',
      text: 'A liderança para de coletar e validar dado. Recebe análise, diagnóstico, pontos de atenção e sugestão prontos e usa o tempo para decidir.',
    },
    {
      title: 'Custos invisíveis à vista',
      text: 'Variações atípicas em contratos de benefícios, horas extras indevidas e distorções salariais são apontadas de forma contínua.',
    },
    {
      title: 'O colaborador não fica sem resposta',
      text: 'Dúvida de holerite, ponto ou benefício respondida na hora, com confidencialidade. O RH recebe o padrão das dúvidas e corrige a causa.',
    },
  ],
  features: [
    {
      title: 'Análise, diagnóstico, atenção e sugestão',
      text: 'Regra do sistema: toda consulta, interação ou relatório da NATI devolve análise, diagnóstico, pontos de atenção e sugestão.',
      icon: 'list-checks',
    },
    {
      title: 'Auditoria da folha antes do fechamento',
      text: 'Analisa proventos e descontos, diagnostica inconsistências de cálculo e sugere correções com a folha ainda aberta.',
      icon: 'wallet',
    },
    {
      title: 'Frequência e administração de pessoal',
      text: 'Cruza ponto, horas extras e banco de horas com a CLT e o eSocial. Padroniza admissões, férias e desligamentos.',
      icon: 'clock',
    },
    {
      title: 'Benefícios e custos',
      text: 'Analisa contratos, elegibilidade e utilização. Identifica variações atípicas e desperdícios em contratos de benefícios.',
      icon: 'receipt',
    },
    {
      title: 'Cargos e salários',
      text: 'Mapeia a estrutura para diagnosticar distorções de equidade interna e competitividade e sugere a revisão de faixas.',
      icon: 'scale',
    },
    {
      title: 'Talentos: R&S, feedback e treinamento',
      text: 'Avalia canais de recrutamento, diagnostica lacunas entre desempenho e desenvolvimento e sugere planos de capacitação.',
      icon: 'graduation-cap',
    },
    {
      title: 'Saúde e segurança',
      text: 'Analisa exames, PCMSO, PGR e uso de EPIs. Aponta falhas de conformidade com as NRs e sugere ações preventivas.',
      icon: 'hard-hat',
    },
    {
      title: 'Chat com o colaborador, 24/7',
      text: 'Responde dúvidas de holerite, ponto e benefícios pelo sistema, pelo WhatsApp ou pelo Teams, a qualquer hora.',
      icon: 'message-square',
    },
    {
      title: 'Dúvidas que viram diagnóstico',
      text: 'Quando muitos perguntam a mesma coisa, a NATI identifica a recorrência e alerta o RH para ajustar a política ou a comunicação.',
      icon: 'refresh',
    },
    {
      title: 'Limites claros de atuação',
      text: 'Atuação analítica e orientativa. Não aprova solicitações, não executa demissões e não define políticas. O gestor decide.',
      icon: 'shield-check',
    },
  ],
  flow: {
    title: 'Como a NATI responde a qualquer pergunta',
    steps: [
      { title: 'Análise', text: 'Lê regras, processos, parametrizações e comparativos históricos.' },
      { title: 'Diagnóstico', text: 'Identifica inconsistências, lacunas operacionais e falta de aderência legal.' },
      { title: 'Pontos de atenção', text: 'Alerta sobre riscos financeiros ou de compliance antes do fechamento.' },
      { title: 'Sugestão', text: 'Recomenda a correção ou o plano de ação para resolver.' },
      { title: 'Decisão humana', text: 'O gestor ou o RH avalia e decide. A NATI não aprova nem executa.' },
    ],
  },
  compliance: [
    'LGPD: confidencialidade em todas as interações',
    'CLT e eSocial nas análises de folha e frequência',
    'NRs, PCMSO e PGR nas análises de saúde e segurança',
  ],
  personas: [
    {
      role: 'Colaborador',
      text: 'Pergunta sobre o holerite, o ponto ou um benefício e recebe resposta clara e confidencial na hora, sem abrir chamado.',
    },
    {
      role: 'Gestor',
      text: 'Recebe a equipe consolidada: equidade salarial, variações de custo e necessidades reais de capacitação, prontas para decidir.',
    },
    {
      role: 'Operador de RH e DP',
      text: 'Deixa a auditoria manual. A NATI aponta o que corrigir na folha, no ponto e nas admissões antes do fechamento.',
    },
  ],
  faq: [
    {
      q: 'A NATI toma decisões pelo RH?',
      a: 'Não. A atuação é analítica e orientativa. Ela não aprova solicitações, não executa demissões e não define políticas. A NATI analisa e sugere; o gestor humano decide.',
    },
    {
      q: 'Por onde o colaborador fala com a NATI?',
      a: 'Pelo próprio sistema, pelo WhatsApp ou pelo Teams, 24 horas por dia. As respostas são padronizadas e confidenciais.',
    },
    {
      q: 'O que a NATI analisa?',
      a: 'Dez frentes do RH: folha de pagamento, administração de pessoal, frequência, benefícios, cargos e salários, medicina, segurança do trabalho, recrutamento, feedback e treinamento. Sempre com análise, diagnóstico, pontos de atenção e sugestão.',
    },
    {
      q: 'Como fica a LGPD nas conversas com a NATI?',
      a: 'O atendimento é confidencial e usa critérios objetivos sobre dados consolidados, dentro das políticas internas da empresa. A NATI não age por intuição nem por achismo.',
    },
  ],
  related: ['people-analytics', 'business-intelligence', 'folha-de-pagamento', 'chamado-interno'],
  sources: [
    'nati-ia',
    'nati-colaboradores',
    'nati-gestores',
    'nati-operadores',
    'apresentacao-natcorp',
    'abrangencia-do-sistema',
    'paineis',
    'paineis-inteligentes',
    'csc-bpo',
  ],
}

export default page
