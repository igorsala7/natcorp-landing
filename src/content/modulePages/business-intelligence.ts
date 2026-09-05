import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'business-intelligence',
  name: 'Business Intelligence',
  group: 'dados-ia-plataforma',
  tagline: 'Painéis para cada nível da empresa, [[em tempo real]] e sem depender de TI.',
  summary:
    'Dashboards executivos, operacionais e analíticos alimentados por todos os módulos do sistema. O próprio usuário cria telas, gráficos e relatórios, recebe alertas por e-mail e exporta para a ferramenta de BI que a empresa já usa.',
  seo: {
    title: 'Business Intelligence para RH e DP | Natcorp',
    description:
      'BI no sistema de RH: painéis executivos, operacionais e analíticos em tempo real, telas e gráficos criados pelo usuário e integração com ferramentas de BI.',
  },
  highlights: [
    { value: '3.500+', label: 'telas customizáveis pelo próprio usuário' },
    { value: '1.800+', label: 'relatórios para extração e cruzamento de dados' },
    { value: '900+', label: 'gráficos gerenciais gerados na própria interface' },
  ],
  benefits: [
    {
      title: 'Cada nível vê o que precisa',
      text: 'Visão executiva para a alta gestão, operacional para as lideranças e analítica para a equipe de RH. O mesmo dado, no nível certo de detalhe, por empresa e filial ou consolidado para o grupo.',
    },
    {
      title: 'Decisão com o dado de agora',
      text: 'Os painéis leem os módulos em tempo real. Headcount, custo, absenteísmo e horas extras aparecem como estão hoje, não como estavam no último fechamento.',
    },
    {
      title: 'Autonomia total para o RH',
      text: 'O usuário cria telas, campos, gráficos e relatórios sem chamado para a TI. O ambiente de trabalho é desenhado por quem usa.',
    },
    {
      title: 'Custos sob controle',
      text: 'Simule cenários, compare o headcount com o orçamento e cruze o faturamento de projetos com o custo real das pessoas. O desvio aparece antes de virar prejuízo.',
    },
  ],
  features: [
    {
      title: 'Painéis por nível',
      text: 'Visão executiva para a alta gestão, operacional para as lideranças e analítica para o RH, cada uma com os indicadores do seu público. Painéis por empresa e filial e o consolidado do grupo para a matriz.',
      icon: 'layout-grid',
    },
    {
      title: 'Dashboards em tempo real',
      text: 'Indicadores completos para a diretoria, atualizados conforme os módulos são movimentados. Sem extração manual.',
      icon: 'bar-chart',
    },
    {
      title: 'Telas e gráficos criados pelo usuário',
      text: 'Crie campos, telas dinâmicas, menus e gráficos gerenciais adaptados ao fluxo do seu departamento, sem código e sem TI.',
      icon: 'layers',
    },
    {
      title: 'Relatórios sob demanda',
      text: 'Ferramentas integradas para extrair e cruzar dados do jeito que a diretoria pede, sem depender de chamados.',
      icon: 'file-text',
    },
    {
      title: 'Alertas inteligentes',
      text: 'O usuário parametriza alertas preventivos e informativos, com disparo automático por e-mail quando um indicador sai da faixa.',
      icon: 'bell',
    },
    {
      title: 'Simulação de cenários',
      text: 'Teste alternativas antes de decidir e detalhe as oportunidades com segurança.',
      icon: 'target',
    },
    {
      title: 'Indicadores de ponto e absenteísmo',
      text: 'Faltas, presença, horas extras, abonos e distribuição de escalas por filial e departamento, cruzados com o organograma.',
      icon: 'clock',
    },
    {
      title: 'Headcount versus orçamento',
      text: 'Painéis que comparam o planejado com o realizado e cruzam o custo real das pessoas com o faturamento dos projetos.',
      icon: 'trending-up',
    },
    {
      title: 'Leitura da NATI',
      text: 'A inteligência artificial analisa os indicadores e gráficos gerados e entrega comparativos e insights prontos para a decisão.',
      icon: 'sparkles',
    },
    {
      title: 'Exportação e integração com BI',
      text: 'Exporte com facilidade ou conecte à ferramenta de BI que a empresa já usa. Um ecossistema aberto, sem criar novo silo.',
      icon: 'cable',
    },
  ],
  flow: {
    title: 'Do dado ao painel da diretoria',
    steps: [
      { title: 'O dado nasce no módulo', text: 'Folha, ponto, benefícios, SESMT e talentos alimentam a mesma base.' },
      { title: 'Cruzamento nativo', text: 'Os indicadores se cruzam automaticamente, sem exportar nem importar.' },
      { title: 'Painel por nível', text: 'Executivo, operacional ou analítico, montado pelo próprio usuário.' },
      { title: 'Leitura e alerta', text: 'A NATI comenta os indicadores e os alertas avisam por e-mail.' },
      { title: 'Exportação ou integração', text: 'O resultado vai para a apresentação ou para o BI corporativo.' },
    ],
  },
  personas: [
    {
      role: 'CEO, CFO e CHRO',
      text: 'Visão executiva com custo de pessoal, headcount e desvios orçamentários em tempo real, sem esperar o fechamento.',
    },
    {
      role: 'Lideranças',
      text: 'Visão operacional da equipe: absenteísmo, horas extras, abonos e escalas por filial e departamento.',
    },
    {
      role: 'Equipe de RH',
      text: 'Visão analítica com telas, gráficos e relatórios que ela mesma cria e ajusta.',
    },
  ],
  faq: [
    {
      q: 'Preciso da TI para criar um painel?',
      a: 'Não. O usuário cria telas, campos, gráficos e relatórios direto na interface. São mais de 3.500 telas customizáveis, 1.800 relatórios e 900 gráficos gerenciais à disposição.',
    },
    {
      q: 'Os painéis funcionam com a ferramenta de BI que já usamos?',
      a: 'Sim. O sistema exporta com facilidade e se integra a outras soluções de BI para visualizações personalizadas, sem criar um novo silo de dados.',
    },
    {
      q: 'Os dados são em tempo real?',
      a: 'Sim. Os painéis leem os módulos do sistema conforme eles são movimentados. Não há extração manual nem planilha intermediária.',
    },
    {
      q: 'Qual a diferença entre Business Intelligence e People Analytics?',
      a: 'O Business Intelligence entrega painéis e indicadores prontos para cada nível da empresa. O People Analytics é a análise livre sobre qualquer listagem, com o botão Ações. Os dois usam a mesma base e se complementam.',
    },
  ],
  related: ['people-analytics', 'nati', 'conexao-com-outros-sistemas', 'administracao-de-pessoal'],
  sources: [
    'business-intelligence-people-analytics',
    'paineis',
    'paineis-inteligentes',
    'csc-bpo',
    'tecnologia',
    'gestao-de-frequencia',
    'apresentacao-natcorp',
    'gestao-de-rh',
  ],
}

export default page
