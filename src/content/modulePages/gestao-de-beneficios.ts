import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'gestao-de-beneficios',
  name: 'Gestão de Benefícios',
  group: 'pessoal-e-folha',
  tagline: 'Todos os benefícios, [[do plano de saúde à folha]], sem planilha.',
  summary:
    'Plano de saúde, seguro de vida, vale-transporte, alimentação, previdência, empréstimos e bolsa de estudo com regras de elegibilidade, movimentações e exceções. Os valores viram rubricas na folha automaticamente e a NATI vigia custo e uso.',
  seo: {
    title: 'Gestão de Benefícios integrada à folha | Natcorp',
    description:
      'Gestão de benefícios: plano de saúde, VT, alimentação, previdência, empréstimos e bolsa de estudo com elegibilidade, fatura conferida e rubricas na folha.',
  },
  highlights: [
    { value: '24/7', label: 'a NATI responde dúvidas sobre descontos e regras' },
  ],
  benefits: [
    {
      title: 'Custo de benefícios sob controle',
      text: 'Acompanhe o gasto por benefício, área ou pessoa. A NATI identifica variações atípicas e desperdícios em contratos e sugere adequações.',
    },
    {
      title: 'Zero redigitação na folha',
      text: 'Coparticipação, vale-transporte, empréstimos e previdência viram rubricas na folha por exportação automática. Sem planilha paralela, sem erro de digitação.',
    },
    {
      title: 'Fatura da operadora conferida',
      text: 'Compare a fatura do plano de saúde com quem está ativo, com os dependentes e com a coparticipação registrada. Pague só o que é devido.',
    },
    {
      title: 'Menos dúvidas chegando ao RH',
      text: 'O colaborador consulta seus benefícios no portal e pergunta à NATI por que o desconto mudou. Dúvidas recorrentes viram alerta para ajustar a comunicação.',
    },
  ],
  features: [
    {
      title: 'Assistência médica',
      text: 'Coparticipação, parâmetros de desconto de dependentes, conferência de fatura das operadoras e histórico de planos por colaborador.',
      icon: 'heart-pulse',
    },
    {
      title: 'Seguro de vida e sinistros',
      text: 'Gestão de prestadoras, parâmetros por tipo de seguro e cadastro com acompanhamento de sinistros.',
      icon: 'shield-check',
    },
    {
      title: 'Alimentação e compras conveniadas',
      text: 'Cesta básica com estoque e postos de entrega, regras de pagamento e desconto por tipo de família, convênios com limite, carência e tabela de preços.',
      icon: 'receipt',
    },
    {
      title: 'Vale-transporte',
      text: 'Cadastro de tarifas e operadoras, reajuste automático das tarifas, geração de ocorrências e dos arquivos para as operadoras.',
      icon: 'map-pin',
    },
    {
      title: 'Empréstimos e consignado',
      text: 'Integração nativa com o Econsignado, fluxo de liberação pelo superior e pelo RH, controle de amortização e índices de correção mensal.',
      icon: 'banknote',
    },
    {
      title: 'Previdência privada',
      text: 'Operadoras e contratos corporativos, percentuais de contribuição, parâmetros por colaborador e perfis de risco.',
      icon: 'percent',
    },
    {
      title: 'Bolsa de estudo e serviço social',
      text: 'Bolsistas, cursos e instituições, cálculo do valor da bolsa, controle de inadimplência e conciliação com retorno bancário. Acompanhamento de assistência social.',
      icon: 'graduation-cap',
    },
    {
      title: 'Movimentações e exceções',
      text: 'Inclusões, exclusões e trocas de plano no dia a dia, por requisição eletrônica, com tratamento de casos fora da regra sem corromper a base.',
      icon: 'refresh',
    },
    {
      title: 'Rubricas automáticas na folha',
      text: 'Os valores calculados são exportados para a folha de cada empresa, dentro do calendário de fechamento dela, sem intervenção manual. Zero planilha, zero erro de digitação.',
      icon: 'wallet',
    },
    {
      title: 'Custos e uso auditados pela NATI',
      text: 'A IA analisa custos, regras de elegibilidade e taxas de utilização, aponta variações atípicas e sugere otimizações. Histórico completo para auditoria.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Da adesão ao desconto na folha',
    steps: [
      { title: 'Pedido de inclusão', text: 'O colaborador ou o gestor pede a inclusão, a exclusão ou a troca de plano por requisição eletrônica.' },
      { title: 'Elegibilidade e aprovação', text: 'O sistema aplica as regras de elegibilidade da política e encaminha a aprovação no workflow.' },
      { title: 'Movimentação registrada', text: 'Inclusões, exclusões e alterações ficam no histórico e prontas para envio às operadoras.' },
      { title: 'Conferência da fatura', text: 'A fatura da operadora é conferida com a base ativa, os dependentes e a coparticipação.' },
      { title: 'Conferência por unidade', text: 'Movimentações e faturas conferidas por empresa e filial, com as pendências visíveis para a matriz antes do corte da folha.' },
      { title: 'Rubrica na folha', text: 'Descontos e créditos são exportados automaticamente para a folha de cada empresa no mês.' },
    ],
  },
  personas: [
    { role: 'RH e Departamento Pessoal', text: 'Administra todos os benefícios em um lugar, confere a fatura e manda tudo para a folha sem planilha.' },
    { role: 'CFO e Financeiro', text: 'Vê o custo de benefícios em nível macro e por pessoa, com alertas de variação atípica nos contratos.' },
    { role: 'Colaborador', text: 'Consulta seus benefícios no portal, pede inclusão de dependente e entende cada desconto com a ajuda da NATI.' },
  ],
  faq: [
    {
      q: 'Os descontos de benefícios vão para a folha automaticamente?',
      a: 'Sim. Coparticipação, vale-transporte, empréstimos, previdência e demais valores são calculados no módulo e exportados como rubricas para a folha, sem intervenção manual e sem planilhas paralelas.',
    },
    {
      q: 'Dá para conferir a fatura do plano de saúde antes de pagar?',
      a: 'Sim. O módulo guarda o histórico de planos por colaborador, os dependentes e os parâmetros de coparticipação, e confere a fatura da operadora contra essa base, apontando divergências.',
    },
    {
      q: 'Como funciona um caso que foge da regra padrão?',
      a: 'O módulo tem tratamento de exceções para benefícios integrais: você registra o caso único fora da política sem alterar as regras gerais nem corromper a base, e tudo fica no histórico para auditoria.',
    },
    {
      q: 'O que a NATI faz na gestão de benefícios?',
      a: 'A NATI analisa custos, regras de elegibilidade e taxas de utilização, identifica variações atípicas em contratos e sugere adequações. Também responde ao colaborador sobre descontos e regras, e avisa o RH quando uma dúvida se repete.',
    },
  ],
  related: ['folha-de-pagamento', 'requisicoes-com-workflow', 'portais', 'natpay'],
  sources: ['gestao-de-beneficios', 'nati-gestores', 'produtividade-de-rh', 'nati-ia', 'gestao-de-requisicoes-eletronicas', 'csc-bpo'],
}

export default page
