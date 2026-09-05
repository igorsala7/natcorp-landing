import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'folha-de-pagamento',
  name: 'Folha de Pagamento',
  group: 'pessoal-e-folha',
  tagline: 'Folha calculada a [[2.500 colaboradores por minuto]], conferida pela NATI.',
  summary:
    'Ponto, benefícios, admissões e afastamentos chegam prontos à folha, sem redigitar. O cálculo roda em minutos, a NATI aponta inconsistências antes do fechamento e o eSocial recebe os dados validados. Férias, 13º, rescisões e EFD-Reinf no mesmo motor.',
  seo: {
    title: 'Folha de Pagamento para grandes empresas | Natcorp',
    description:
      'Folha de pagamento integrada a ponto, benefícios e eSocial: 2.500 colaboradores por minuto, folha por empresa e conferência por IA antes do fechamento.',
  },
  highlights: [
    { value: '2.500', label: 'colaboradores calculados por minuto' },
    { value: '80%', label: 'mais rápido no fechamento da folha' },
    { value: '4 : 1.000', label: 'operadores para 1.000 colaboradores; mais um a cada 1.000' },
    { value: '100%', label: 'da folha auditada pela IA, sem conferência por amostragem' },
  ],
  benefits: [
    {
      title: 'Fechamento em minutos, não em dias',
      text: 'O motor calcula 2.500 colaboradores por minuto e roda a folha de cada empresa do grupo. Reprocessar e simular tem reflexo imediato, e o fechamento fica até 80% mais rápido.',
    },
    {
      title: 'Erros encontrados antes de pagar',
      text: 'A NATI cruza frequência, benefícios e impostos, aponta proventos e descontos atípicos e sugere a correção antes do fechamento. Sem amostragem manual.',
    },
    {
      title: 'Equipe enxuta, mesmo crescendo',
      text: 'Com ponto, benefícios e admissões chegando prontos, são 4 operadores para 1.000 colaboradores; a cada 1.000 novos, mais um.',
    },
    {
      title: 'Menos risco trabalhista e fiscal',
      text: 'Dados validados seguem direto para o eSocial e para a contabilização com provisões. Menos retrabalho, menos multa, mais segurança jurídica.',
    },
  ],
  features: [
    {
      title: 'Cálculo em alta velocidade',
      text: 'Folha mensal, adiantamentos, férias, 13º, PLR (participação nos lucros e resultados) e rescisões processados a 2.500 colaboradores por minuto, com reprocessamento instantâneo.',
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
      title: 'Várias empresas, CNPJs e sindicatos',
      text: 'Várias empresas e CNPJs na mesma base, cada uma com as suas convenções e o seu calendário de fechamento; a matriz vê o consolidado. Vários vínculos e acordos sindicais tratados ao mesmo tempo.',
      icon: 'building',
    },
    {
      title: 'Fechamento por empresa',
      text: 'Calendário de fechamento por empresa. As pendências de cada filial ficam visíveis para a matriz antes do corte, a conferência é por unidade e a folha roda por empresa, com a contabilização de cada CNPJ.',
      icon: 'calendar',
    },
    {
      title: 'Rotinas anuais automatizadas',
      text: 'Férias, 13º salário, PLR e as obrigações acessórias pelo eSocial e pela EFD-Reinf rodam no mesmo motor, com as regras já parametrizadas e o histórico preservado.',
      icon: 'refresh',
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
  ],
  flow: {
    title: 'Do ponto batido ao eSocial',
    steps: [
      { title: 'Entradas digitais', text: 'Admissões, alterações, férias, afastamentos e benefícios entram por requisições eletrônicas aprovadas no workflow.' },
      { title: 'Ponto apurado', text: 'As marcações do NatPonto são apuradas e as variáveis de frequência seguem para a folha automaticamente.' },
      { title: 'Pendências por unidade', text: 'A matriz vê o que ainda está aberto em cada filial antes do corte e confere por unidade.' },
      { title: 'Cálculo da folha', text: 'O motor roda a folha de cada empresa a 2.500 colaboradores por minuto. Simule e reprocesse com reflexo imediato.' },
      { title: 'Conferência pela NATI', text: 'A IA cruza frequência, benefícios e impostos e aponta inconsistências com sugestão de correção.' },
      { title: 'Fechamento e envio', text: 'Dados validados vão para o eSocial, para a contabilização de cada CNPJ com provisões e para os créditos de pagamento.' },
    ],
  },
  compliance: [
    'eSocial: eventos gerados a partir da folha validada',
    'EFD-Reinf e demais obrigações acessórias',
    'CLT e legislação trabalhista sempre atualizada',
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
      q: 'O sistema aguenta a folha de 20 mil colaboradores em várias empresas?',
      a: 'Sim. O motor calcula 2.500 colaboradores por minuto: cerca de 8 minutos para 20 mil. A folha roda por empresa, cada uma com o seu calendário de fechamento e as suas convenções, e a NATI confere cada uma antes do corte. O sistema trata múltiplos vínculos e sindicatos e roda em nuvem Oracle, com ambientes de produção, homologação e contingência para a folha não parar.',
    },
    {
      q: 'Dá para fechar a folha fora do escritório?',
      a: 'Sim. O sistema é 100% web e responsivo. Cálculo de folha, rescisões, férias e gestão do eSocial podem ser processados pelo celular ou tablet, com os dados sincronizados em tempo real.',
    },
  ],
  related: ['ponto-eletronico', 'gestao-de-beneficios', 'esocial', 'natpay'],
  sources: ['pagadoria', 'csc-bpo', 'produtividade-de-rh', 'performance-e-seguranca', 'tecnologia', 'gestao-de-frequencia', 'gestao-de-beneficios', 'nati-ia'],
}

export default page
