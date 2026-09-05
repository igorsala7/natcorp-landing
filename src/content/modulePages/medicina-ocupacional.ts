import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'medicina-ocupacional',
  name: 'Medicina Ocupacional',
  group: 'saude-e-seguranca',
  tagline: 'Saúde ocupacional [[sem papel e sem prazo perdido]].',
  summary:
    'Exames, ASOs, PCMSO, atestados e afastamentos em um só lugar, ligados ao risco de cada função. O sistema agenda exames, avisa vencimentos, emite o ASO com assinatura digital e envia o S-2220 ao eSocial. Tudo integrado ao ponto e à folha.',
  seo: {
    title: 'Medicina Ocupacional: ASO, PCMSO e afastamentos | Natcorp',
    description:
      'Medicina ocupacional integrada ao RH: PCMSO com cronograma automático, ASO digital, atestados, afastamentos, clínicas e médicos, e evento S-2220 do eSocial.',
  },
  highlights: [
    { value: '100%', label: 'digital: exames, atestados e ASOs sem papel' },
    { value: '4', label: 'documentos encadeados: PGR, GHE, PCMSO e ASO' },
  ],
  benefits: [
    {
      title: 'Exame certo, na hora certa',
      text: 'O PCMSO nasce do risco do GHE e gera o cronograma anual sozinho. O sistema agenda e avisa antes de vencer. Nenhum ASO vence sem ninguém ver.',
    },
    {
      title: 'Afastamento sem efeito colateral na folha',
      text: 'O atestado lançado uma vez reflete no ponto, na folha e no eSocial. O RH deixa de conciliar planilhas e o colaborador recebe certo.',
    },
    {
      title: 'eSocial sem multa',
      text: 'O S-2220 sai dos dados que já estão no sistema e passa por um validador de divergências antes do envio. Prazos e conteúdo sob controle.',
    },
    {
      title: 'Absenteísmo com diagnóstico',
      text: 'O painel de atestados por CID mostra padrões epidêmicos ou ergonômicos por área. A NATI acompanha afastamentos e sugere ações preventivas.',
    },
  ],
  features: [
    {
      title: 'PCMSO ligado ao risco',
      text: 'O programa de exames é montado a partir do PGR e do GHE de cada função. Agendamento automático e cronograma anual gerados pelo sistema.',
      icon: 'heart-pulse',
    },
    {
      title: 'ASO digital',
      text: 'Emissão ágil com assinatura digital, vinculação automática dos exames realizados e alertas de vencimento. Admissional, periódico, de retorno e demissional.',
      icon: 'file-signature',
    },
    {
      title: 'Clínicas e médicos do trabalho',
      text: 'Cadastro de médicos do trabalho e da rede de clínicas credenciadas, com painel para acompanhar solicitações e atendimentos externos.',
      icon: 'stethoscope',
    },
    {
      title: 'Atestados com validação por imagem',
      text: 'O colaborador envia o atestado pelo app, o sistema lê a imagem, valida e registra o CID. O RH analisa e o histórico funcional fica completo.',
      icon: 'check-circle',
    },
    {
      title: 'Afastamentos integrados',
      text: 'Afastamentos registrados uma vez refletem no ponto, na folha e no eSocial. Requisição com workflow, análise do RH e histórico por colaborador.',
      icon: 'calendar',
    },
    {
      title: 'Evento S-2220 do eSocial',
      text: 'O monitoramento da saúde é enviado ao eSocial a partir do ASO, com validador prévio de divergências que evita rejeições e multas.',
      icon: 'send',
    },
    {
      title: 'Campanhas de saúde',
      text: 'Planeje ações preventivas para a equipe e acompanhe a execução no mesmo ambiente dos exames e do PCMSO.',
      icon: 'users',
    },
    {
      title: 'Painel de absenteísmo',
      text: 'Atestados por CID, área e período em painel analítico que detecta padrões epidêmicos ou ergonômicos. A NATI acompanha afastamentos e sugere melhorias.',
      icon: 'bar-chart',
    },
    {
      title: 'No consultório ou em campo',
      text: 'As mesmas funções no computador, no tablet e no celular. O médico e a equipe de SESMT trabalham de onde estiverem.',
      icon: 'smartphone',
    },
    {
      title: 'Telas e relatórios do seu jeito',
      text: 'Os próprios profissionais de SESMT criam telas personalizadas, gráficos dinâmicos e relatórios, sem depender de TI.',
      icon: 'layout-grid',
    },
  ],
  flow: {
    title: 'Do risco ao ASO',
    steps: [
      { title: 'PGR', text: 'Perigos mapeados e riscos avaliados por ambiente e função. É a origem de tudo.' },
      { title: 'GHE', text: 'Colaboradores com exposição semelhante agrupados a partir do PGR.' },
      { title: 'PCMSO', text: 'Plano de exames dinâmico, baseado no risco de cada GHE, com cronograma anual.' },
      { title: 'ASO', text: 'Exames vinculados, atestado emitido com assinatura digital e alerta de vencimento.' },
      { title: 'eSocial', text: 'O S-2220 é gerado a partir dos dados do ASO e validado antes do envio.' },
    ],
  },
  compliance: [
    'eSocial S-2220 (monitoramento da saúde) com validador prévio de divergências',
    'PCMSO com cronograma anual',
    'ASO com assinatura digital',
    'Cadeia PGR, GHE, PCMSO e ASO',
    'Atestados e afastamentos refletidos no eSocial',
  ],
  personas: [
    { role: 'Médico do trabalho e SESMT', text: 'Emite ASOs, acompanha o cronograma do PCMSO e valida atestados no computador ou no tablet, com o histórico de cada colaborador à mão.' },
    { role: 'RH e Departamento Pessoal', text: 'Recebe afastamentos já refletidos no ponto e na folha e envia o S-2220 sem redigitar nada.' },
    { role: 'Colaborador', text: 'Envia o atestado pelo app, acompanha o exame agendado e vê o status da requisição no portal.' },
  ],
  faq: [
    {
      q: 'Como o PCMSO se conecta ao PGR?',
      a: 'Em cadeia. O PGR mapeia os riscos, o GHE agrupa os colaboradores com exposição semelhante e o PCMSO define os exames de cada grupo a partir desse risco. O ASO consolida o resultado. Mudou o risco, o plano de exames acompanha.',
    },
    {
      q: 'O sistema avisa quando um exame ou ASO vai vencer?',
      a: 'Sim. O PCMSO gera o cronograma anual, agenda os exames e emite alertas antecipados de vencimento de ASOs, para o SESMT agir antes do prazo.',
    },
    {
      q: 'Como funciona o lançamento de atestados e afastamentos?',
      a: 'O colaborador ou o RH registra o atestado por requisição eletrônica, com a imagem anexada. O sistema valida o documento, registra o CID e, aprovado, o afastamento reflete no ponto, na folha e no eSocial automaticamente.',
    },
    {
      q: 'O módulo envia o S-2220 ao eSocial?',
      a: 'Sim. O evento de monitoramento da saúde é gerado a partir dos dados do ASO e passa por um validador prévio de divergências antes do envio, reduzindo rejeições e risco de multa. O acompanhamento do retorno fica no módulo eSocial.',
    },
  ],
  related: ['seguranca-do-trabalho', 'esocial', 'ponto-eletronico', 'requisicoes-com-workflow'],
  sources: ['gestao-do-sesmt', 'abrangencia-do-sistema', 'nati-operadores', 'apresentacao-natcorp', 'gestao-de-requisicoes-eletronicas', 'performance-e-seguranca'],
}

export default page
