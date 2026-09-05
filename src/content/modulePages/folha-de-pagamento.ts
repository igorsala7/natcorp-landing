import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'folha-de-pagamento',
  name: 'Folha de Pagamento',
  group: 'pessoal-e-folha',
  tagline: 'Folha calculada a [[2.500 colaboradores por minuto]], conferida pela NATI.',
  summary:
    'Ponto, benefícios, admissões e afastamentos chegam prontos à folha, sem redigitar. O cálculo roda em minutos, a NATI aponta inconsistências antes do fechamento e o eSocial recebe os dados validados. Férias, 13º, rescisões e DIRF no mesmo motor.',
  seo: {
    title: 'Folha de Pagamento para grandes empresas | Natcorp',
    description:
      'Folha de pagamento integrada a ponto, benefícios e eSocial: 2.500 colaboradores por minuto, conferência por IA antes do fechamento e 13º e DIRF automáticos.',
  },
  highlights: [
    { value: '2.500', label: 'colaboradores calculados por minuto' },
    { value: '80%', label: 'mais rápido no fechamento da folha' },
    { value: '4 : 1.000', label: 'operadores por colaboradores na Administração de Pessoal' },
    { value: '100%', label: 'da folha auditada pela IA, sem conferência por amostragem' },
  ],
  benefits: [
    {
      title: 'Fechamento em minutos, não em dias',
      text: 'O motor calcula 2.500 colaboradores por minuto. Reprocessar e simular tem reflexo imediato, e o fechamento da folha fica até 80% mais rápido.',
    },
    {
      title: 'Erros encontrados antes de pagar',
      text: 'A NATI cruza frequência, benefícios e impostos, aponta proventos e descontos atípicos e sugere a correção antes do fechamento. Sem amostragem manual.',
    },
    {
      title: 'Equipe enxuta, mesmo crescendo',
      text: 'Com ponto, benefícios e admissões chegando prontos, 4 operadores cuidam de 1.000 colaboradores. A cada 1.000 novos, entra só mais um operador.',
    },
    {
      title: 'Menos risco trabalhista e fiscal',
      text: 'Dados validados seguem direto para o eSocial e para a contabilização com provisões. Menos retrabalho, menos multa, mais segurança jurídica.',
    },
  ],
  features: [
    {
      title: 'Cálculo em alta velocidade',
      text: 'Folha mensal, adiantamentos, férias, 13º, PLR e rescisões processados a 2.500 colaboradores por minuto, com reprocessamento instantâneo.',
      icon: 'zap',
    },
    {
      title: 'Simulações e reprocessamento',
      text: 'Simule cenários e reprocesse a folha quantas vezes precisar. O reflexo aparece na hora, sem esperar lote nem fila.',
      icon: 'calculator',
    },
    {
      title: 'Ponto apurado direto na folha',
      text: 'Horas, faltas, extras e banco de horas chegam da apuração de ponto no formato da sua regra, centesimal ou sexagesimal. Nada é redigitado.',
      icon: 'clock',
    },
    {
      title: 'Benefícios como rubricas automáticas',
      text: 'Plano de saúde, vale-transporte, alimentação, empréstimos e previdência viram rubricas na folha por exportação automática. Zero planilha paralela.',
      icon: 'receipt',
    },
    {
      title: 'Conferência pela NATI',
      text: 'A IA analisa proventos e descontos, diagnostica inconsistências de cálculo, alerta pontos de atenção e sugere correções antes do fechamento.',
      icon: 'sparkles',
    },
    {
      title: 'Múltiplos vínculos e sindicatos',
      text: 'Tratamento simultâneo de vários vínculos trabalhistas e acordos sindicais diferentes na mesma empresa, cada um com suas próprias regras.',
      icon: 'layers',
    },
    {
      title: 'Rotinas anuais automatizadas',
      text: 'Férias, 13º salário, PLR e DIRF rodam no mesmo motor, com as regras já parametrizadas e o histórico preservado.',
      icon: 'calendar',
    },
    {
      title: 'Contabilização com provisões',
      text: 'A folha gera a contabilização com provisões e as informações de crédito para pagamento, conectada aos sistemas financeiros da empresa.',
      icon: 'bar-chart',
    },
    {
      title: 'eSocial alimentado pela folha',
      text: 'Os eventos do eSocial saem dos dados já validados da folha, com envio automático e acompanhamento do retorno de cada layout.',
      icon: 'send',
    },
    {
      title: 'Folha no celular',
      text: 'Cálculo de folha, rescisões, férias e eSocial podem ser processados pelo smartphone. O colaborador consulta o holerite no portal ou no app.',
      icon: 'smartphone',
    },
  ],
  flow: {
    title: 'Do ponto batido ao eSocial',
    steps: [
      { title: 'Entradas digitais', text: 'Admissões, alterações, férias, afastamentos e benefícios entram por requisições eletrônicas aprovadas no workflow.' },
      { title: 'Ponto apurado', text: 'As marcações do NatPonto são apuradas e as variáveis de frequência seguem para a folha automaticamente.' },
      { title: 'Cálculo da folha', text: 'O motor calcula a folha a 2.500 colaboradores por minuto. Simule e reprocesse com reflexo imediato.' },
      { title: 'Conferência pela NATI', text: 'A IA cruza frequência, benefícios e impostos e aponta inconsistências com sugestão de correção.' },
      { title: 'Fechamento e envio', text: 'Dados validados vão para o eSocial, para a contabilização com provisões e para os créditos de pagamento.' },
    ],
  },
  compliance: [
    'eSocial: eventos gerados a partir da folha validada',
    'CLT e legislação trabalhista sempre atualizada',
    'DIRF e demais obrigações anuais',
    'LGPD: acesso por perfil e trilha de auditoria',
  ],
  personas: [
    { role: 'Departamento Pessoal', text: 'Deixa de conferir a folha por amostragem. Recebe da NATI a lista de inconsistências com sugestão e fecha em uma fração do tempo.' },
    { role: 'CFO e Financeiro', text: 'Recebe a contabilização com provisões e os créditos de pagamento prontos, integrados ao financeiro, com o custo de pessoal visível.' },
    { role: 'Colaborador', text: 'Consulta holerite e informes no portal ou no app e tira dúvidas sobre descontos com a NATI, a qualquer hora.' },
  ],
  faq: [
    {
      q: 'A folha se integra com o ponto e os benefícios sem exportar arquivos?',
      a: 'Sim. A integração é nativa: a apuração de ponto e as movimentações de benefícios já alimentam a folha dentro do mesmo sistema, sem exportar, importar ou redigitar. O dado entra uma vez e vale para todos os módulos.',
    },
    {
      q: 'Como a IA confere a folha?',
      a: 'A NATI lê regras, cálculos e comparativos históricos, cruza frequência, benefícios e impostos e devolve análise, diagnóstico, pontos de atenção e sugestão de correção antes do fechamento. A decisão de corrigir continua com a equipe.',
    },
    {
      q: 'O sistema aguenta o volume de uma grande empresa?',
      a: 'Sim. O motor processa 2.500 colaboradores por minuto, trata múltiplos vínculos e acordos sindicais e roda em nuvem Oracle, com ambientes de produção, homologação e contingência para a folha não parar.',
    },
    {
      q: 'Dá para fechar a folha fora do escritório?',
      a: 'Sim. O sistema é 100% web e responsivo. Cálculo de folha, rescisões, férias e gestão do eSocial podem ser processados pelo celular ou tablet, com os dados sincronizados em tempo real.',
    },
  ],
  related: ['ponto-eletronico', 'gestao-de-beneficios', 'esocial', 'nati'],
  sources: ['pagadoria', 'csc-bpo', 'produtividade-de-rh', 'performance-e-seguranca', 'tecnologia', 'gestao-de-frequencia', 'gestao-de-beneficios', 'nati-ia'],
}

export default page
