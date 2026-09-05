import type { GroupId } from './modulePages/types'

/** Conteúdo da NATI: o que ela faz em cada frente, os insights de exemplo e os números. */

export const capabilities = [
  { id: 'responde', name: 'Responde', text: 'Em linguagem natural, 24x7, para colaborador, gestor e RH.' },
  { id: 'analisa', name: 'Analisa', text: 'Cruza folha, ponto, SESMT e talentos em uma pergunta só.' },
  { id: 'alerta', name: 'Alerta', text: 'Aponta o desvio antes do fechamento, da auditoria e da multa.' },
  { id: 'executa', name: 'Executa', text: 'Prepara o agendamento, a requisição e a simulação. Executa só o que uma pessoa aprovou.' },
  { id: 'reporta', name: 'Reporta', text: 'Gera gráfico, tabela e relatório na hora, com as fontes citadas.' },
] as const

export type CapabilityId = (typeof capabilities)[number]['id']

/** Uma frase curta por frente e por capacidade: a matriz de cobertura. */
export const matrix: Record<GroupId, Record<CapabilityId, string>> = {
  'pessoal-e-folha': {
    responde: 'holerite, férias e 13º',
    analisa: 'variação da folha mês a mês',
    alerta: 'divergência antes do fechamento',
    executa: 'simula o reajuste da convenção',
    reporta: 'custo de folha por centro',
  },
  'ponto-e-jornada': {
    responde: 'saldo do banco de horas',
    analisa: 'horas extras por unidade e turno',
    alerta: 'marcação fora do padrão',
    executa: 'prepara o abono para a aprovação do gestor',
    reporta: 'absenteísmo por equipe',
  },
  'saude-e-seguranca': {
    responde: 'quando vence o meu ASO',
    analisa: 'afastamentos por CID e setor',
    alerta: 'exames e NRs a vencer',
    executa: 'prepara a agenda dos exames periódicos',
    reporta: 'indicadores do PGR e da CIPA',
  },
  talentos: {
    responde: 'status da candidatura',
    analisa: 'tempo de fechamento por vaga',
    alerta: 'vaga aberta há mais de 30 dias',
    executa: 'triagem de currículos por requisito',
    reporta: 'funil de seleção por área',
  },
  desenvolvimento: {
    responde: 'meu PDI e as minhas metas',
    analisa: 'gaps de competência por time',
    alerta: 'avaliação atrasada',
    executa: 'sugere trilhas e sucessores',
    reporta: 'mapa de sucessão e 9-box',
  },
  autoatendimento: {
    responde: 'dúvidas de RH, dia e noite',
    analisa: 'temas mais perguntados',
    alerta: 'chamado fora do prazo',
    executa: 'abre a requisição pedida e a leva ao fluxo de aprovação',
    reporta: 'SLA do atendimento',
  },
  'dados-ia-plataforma': {
    responde: 'qualquer indicador, em português',
    analisa: 'cruza módulos em uma pergunta',
    alerta: 'desvio de meta em tempo real',
    executa: 'gera gráfico e relatório na hora',
    reporta: 'painel pronto para a diretoria',
  },
}

export interface Insight {
  id: string
  /** Módulos envolvidos, como aparecem no registro. */
  modules: string[]
  text: string
  action: string
  chart: { kind: 'bars' | 'line'; values: number[]; labels?: string[]; unit?: string }
}

/** Análises de exemplo (cenário ilustrativo, empresa fictícia). */
export const insights: Insight[] = [
  {
    id: 'horas-extras',
    modules: ['Ponto Eletrônico', 'Folha de Pagamento', 'Medicina Ocupacional'],
    text: 'As horas extras da Unidade Barueri subiram 18% em agosto. Três afastamentos em Medicina Ocupacional explicam 70% do aumento. Sugiro redistribuir a escala 12x36 das equipes B e C.',
    action: 'Ver a escala sugerida',
    chart: { kind: 'bars', values: [42, 45, 44, 47, 46, 52, 61], labels: ['fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago'], unit: 'h' },
  },
  {
    id: 'aso',
    modules: ['Medicina Ocupacional', 'Segurança do Trabalho', 'Treinamento e Desenvolvimento'],
    text: '27 ASOs vencem em 15 dias na Unidade Guarulhos e 6 colaboradores estão sem treinamento de NR-35 válido para o cargo. Preparei o agendamento e o aviso aos gestores. Quer que eu envie?',
    action: 'Aprovar agendamento',
    chart: { kind: 'bars', values: [4, 9, 27, 12, 6], labels: ['hoje', '7 d', '15 d', '30 d', '60 d'], unit: 'ASOs' },
  },
  {
    id: 'reajuste',
    modules: ['Folha de Pagamento', 'Cargos e Salários', 'Business Intelligence'],
    text: 'Simulei o reajuste de 4,5% da convenção: impacto de R$ 312 mil na folha de novembro, com encargos. O relatório para a diretoria está pronto, com o comparativo por centro de custo.',
    action: 'Baixar o relatório',
    chart: { kind: 'bars', values: [6.9, 6.9, 7.0, 7.0, 7.3], labels: ['jul', 'ago', 'set', 'out', 'nov'], unit: 'R$ mi' },
  },
  {
    id: 'turnover',
    modules: ['People Analytics', 'Onboarding', 'Metas e Resultados'],
    text: 'O turnover do varejo ficou em 3,8% em agosto, acima da meta de 3,0%. As lojas 12 e 27 concentram 40% das saídas nos primeiros 90 dias. Sugiro revisar o onboarding dessas duas lojas.',
    action: 'Ver as lojas em detalhe',
    chart: { kind: 'line', values: [3.1, 2.9, 3.0, 3.4, 3.6, 3.8], labels: ['mar', 'abr', 'mai', 'jun', 'jul', 'ago'], unit: '%' },
  },
  {
    id: 'vagas',
    modules: ['Recrutamento e Seleção', 'Carreira e Sucessão', 'Avaliações, Pesquisas e Feedbacks'],
    text: '12 vagas estão abertas há mais de 30 dias. Para as 4 de Analista de Operações, encontrei 9 candidatos internos com PDI compatível e avaliação acima de 4,2. Sugiro abrir recrutamento interno.',
    action: 'Ver os candidatos internos',
    chart: { kind: 'bars', values: [9, 6, 4, 3], labels: ['internos', 'externos', 'em entrevista', 'aprovados'], unit: 'pessoas' },
  },
]

/** Números da NATI. Fontes: material comercial Natcorp ("Gestão otimizada" e "Produtividade de RH"). */
export const natiStats = [
  { value: 31, prefix: '', suffix: '', label: 'módulos lidos por um único agente de IA' },
  { value: 70, prefix: 'até ', suffix: '%', label: 'de aumento de produtividade no RH' },
  { value: 70, prefix: '', suffix: '%', label: 'menos chamados de colaboradores' },
  { value: 24, prefix: '', suffix: 'x7', label: 'no sistema, no WhatsApp e no Teams' },
]

/** Como uma resposta nasce. */
export const pipeline = [
  { title: 'Pergunta', text: 'Por texto ou voz, no sistema, no WhatsApp ou no Teams.' },
  { title: 'Entende', text: 'O contexto, o perfil e as permissões de quem pergunta.' },
  { title: 'Consulta', text: 'Os 31 módulos e as fontes que o RH liberou.' },
  { title: 'Cruza', text: 'Folha com ponto, ponto com saúde, talentos com metas.' },
  { title: 'Responde', text: 'Análise, diagnóstico, pontos de atenção e sugestão, com as fontes.' },
  { title: 'Executa', text: 'Agenda, abre a requisição, gera o relatório. Só depois que quem decide aprova.' },
]
