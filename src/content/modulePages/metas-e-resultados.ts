import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'metas-e-resultados',
  name: 'Metas e Resultados',
  group: 'desenvolvimento',
  tagline: 'Metas negociadas, bônus calculado, PLR [[direto na folha]].',
  summary:
    'Metas de empresa, área e indivíduo no mesmo ciclo. Elegibilidade, múltiplos e regras de admitidos, desligados e afastados parametrizados pelo RH. O sistema apura, calcula bônus e PLR (participação nos lucros e resultados) e envia o valor à Folha de Pagamento.',
  seo: {
    title: 'Metas, Bônus e PLR sem planilha | Natcorp',
    description:
      'Gestão de metas, bônus e PLR para grandes empresas: elegibilidade, negociação entre gestor e colaborador, apuração automática e integração com a folha.',
  },
  highlights: [
    { value: '100%', label: 'é a soma dos pesos das metas de cada contrato, sem furo' },
    { value: '3 níveis', label: 'de elegibilidade: filiais, centros de custo e cargos' },
    { value: '1 botão', label: 'para replicar a estrutura do ciclo do ano anterior' },
  ],
  benefits: [
    {
      title: 'PLR sem planilha e sem erro de cálculo',
      text: 'Múltiplos, elegibilidade e regras de admitidos, desligados e afastados ficam parametrizados. O sistema calcula e leva o valor para a folha.',
    },
    {
      title: 'Metas negociadas, não impostas',
      text: 'O gestor propõe, o colaborador analisa no portal e concorda ou pede revisão. Cada rodada fica registrada, e a meta só entra em vigor com acordo.',
    },
    {
      title: 'Transparência para pessoas e auditoria',
      text: 'Feedback obrigatório do gestor na apuração, contrato individual consultável e planilha gerencial para conferência antes do pagamento.',
    },
    {
      title: 'Da estratégia da empresa ao indivíduo',
      text: 'Metas de empresa, área e pessoa no mesmo ciclo, com pesos definidos, e acompanhamento em tempo real pela hierarquia.',
    },
  ],
  features: [
    {
      title: 'Ciclos replicáveis ano a ano',
      text: 'Crie o ciclo com data-base para o cálculo e previsão de depósito. No ano seguinte, replique a estrutura e ajuste só o que mudou.',
      icon: 'calendar',
    },
    {
      title: 'Elegibilidade em três níveis',
      text: 'Filiais, centros de custo e cargos ou classificações definem quem participa. O resultado é a população elegível, pronta para receber as metas.',
      icon: 'filter',
    },
    {
      title: 'Admitidos, desligados e afastados',
      text: 'Admitidos até uma data limite, mínimo de dias trabalhados para desligados e pedidos de demissão, e quais afastamentos contam, como licença-maternidade.',
      icon: 'list-checks',
    },
    {
      title: 'Metas de empresa, área e indivíduo',
      text: 'Categorias pessoal, empresa e profissional. Metas corporativas, metas comuns atribuídas em lote a grupos e modelos pré-aprovados para o gestor escolher.',
      icon: 'target',
    },
    {
      title: 'Negociação registrada no portal',
      text: 'O gestor propõe metas que somam 100%. O colaborador concorda ou registra a discordância, e o gestor recebe alerta para revisar.',
      icon: 'message-square',
    },
    {
      title: 'Apuração automática com feedback',
      text: 'Informado o valor atingido, o sistema calcula o percentual e a nota. O gestor precisa justificar o resultado por escrito antes de concluir.',
      icon: 'percent',
    },
    {
      title: 'Múltiplos por grupo salarial',
      text: 'Base de cálculo: múltiplo de PLR, em valor fixo ou percentual, sobre o salário nominal, parametrizado por grupo salarial.',
      icon: 'calculator',
    },
    {
      title: 'Plus por superação de meta',
      text: 'Quando a empresa supera a meta, o excedente é distribuído por grade salarial, proporcional ao tempo de contrato de cada pessoa.',
      icon: 'trending-up',
    },
    {
      title: 'Promoção no meio do ciclo',
      text: 'Mudou de cargo ou de área? Gere um novo contrato de metas e finalize o antigo. O cálculo final considera cada período corretamente.',
      icon: 'refresh',
    },
    {
      title: 'Fechamento integrado à folha',
      text: 'Consolide o valor bruto, confira em planilha gerencial exportável e envie para a Folha de Pagamento sem redigitar nada.',
      icon: 'wallet',
    },
  ],
  flow: {
    title: 'Do ciclo ao pagamento',
    steps: [
      { title: 'Estruturação', text: 'O RH cria o ciclo, define múltiplos, elegibilidade e o banco de metas.' },
      { title: 'Negociação', text: 'O gestor propõe as metas; o colaborador analisa e concorda no portal.' },
      { title: 'Acompanhamento', text: 'Painel por empresa, área, ciclo e status. Novo contrato quando alguém muda de cargo.' },
      { title: 'Apuração', text: 'Valor atingido informado, percentual e nota calculados, feedback do gestor registrado.' },
      { title: 'Pagamento', text: 'PLR e Plus consolidados, conferidos em planilha e integrados à folha.' },
    ],
  },
  personas: [
    { role: 'RH', text: 'Parametriza ciclos, múltiplos e regras uma vez, replica no ano seguinte e fecha o PLR com planilha de conferência e integração à folha.' },
    { role: 'Gestor', text: 'Propõe e negocia metas no portal, acompanha o time no painel e registra a apuração com o feedback obrigatório.' },
    { role: 'Colaborador', text: 'Vê o próprio contrato de metas, concorda ou pede revisão e acompanha o resultado com transparência.' },
  ],
  faq: [
    {
      q: 'Como o sistema trata quem foi admitido, desligado ou afastado durante o ciclo?',
      a: 'Por regras de participação definidas pelo RH: data limite de admissão, mínimo de dias trabalhados para desligados e pedidos de demissão, e quais situações de afastamento contam, como licença-maternidade. Quem muda de cargo recebe um novo contrato, e o antigo é finalizado.',
    },
    {
      q: 'O colaborador participa da definição das metas?',
      a: 'Sim. O gestor propõe as metas, com pesos que somam 100%, e o colaborador analisa no portal. Se concordar, o contrato fica ativo. Se discordar, registra o motivo, o gestor é alertado e a negociação segue até o acordo.',
    },
    {
      q: 'O valor do PLR vai automaticamente para a folha?',
      a: 'Sim. O sistema consolida o valor bruto com base no desempenho e no múltiplo salarial, gera uma planilha gerencial para conferência e auditoria e, confirmado, integra o valor à Folha de Pagamento. Também é possível exportar em XLS.',
    },
    {
      q: 'O que acontece se a empresa superar a meta?',
      a: 'O excedente vira o Plus. O percentual acima da meta é calculado e distribuído por grade salarial, de forma proporcional ao tempo de contrato, e entra na folha pelo indicador salarial correspondente.',
    },
  ],
  related: ['avaliacoes-e-feedbacks', 'folha-de-pagamento', 'cargos-e-salarios', 'portais'],
  sources: ['gestao-de-remuneracao-variavel', 'gestao-de-cargos-e-remuneracoes', 'gestao-de-rh', 'gestao-de-avaliacoes'],
}

export default page
