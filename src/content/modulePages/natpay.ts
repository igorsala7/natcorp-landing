import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'natpay',
  name: 'NatPay',
  group: 'pessoal-e-folha',
  tagline: 'Salário disponível [[quando o colaborador precisar]].',
  summary:
    'O NatPay é o adiantamento salarial da Natcorp. O colaborador pede pelo WhatsApp, o limite é calculado pelos dias já trabalhados e registrados no ponto e o valor cai na conta por Pix, na hora. O desconto entra sozinho na folha de pagamento.',
  seo: {
    title: 'NatPay: adiantamento salarial via WhatsApp e Pix | Natcorp',
    description:
      'Adiantamento salarial pedido pelo WhatsApp, com limite calculado pelos dias trabalhados no ponto, pagamento instantâneo via Pix e desconto automático na folha.',
  },
  highlights: [
    { value: 'Pix', label: 'pagamento instantâneo na conta do colaborador' },
    { value: 'WhatsApp', label: 'solicitação simples, sem formulário nem fila no DP' },
    { value: '0', label: 'digitação: ponto e folha integrados automaticamente' },
  ],
  benefits: [
    {
      title: 'Menos turnover, mais permanência',
      text: 'Ter acesso ao salário já trabalhado, sem burocracia, alivia o aperto do mês. O colaborador sente o cuidado da empresa e ganha mais um motivo para ficar.',
    },
    {
      title: 'O DP sai do circuito do adiantamento',
      text: 'Ninguém abre chamado, confere planilha ou lança desconto à mão. Pedido, limite, pagamento e desconto correm dentro do sistema, com histórico.',
    },
    {
      title: 'Limite ligado ao que já foi trabalhado',
      text: 'O valor disponível é calculado pelos dias já trabalhados e registrados no ponto. O colaborador adianta parte do que já trabalhou, sem surpresa na folha.',
    },
    {
      title: 'Desconto certo, folha sem retrabalho',
      text: 'Cada adiantamento pago vira desconto automático na folha de pagamento, integrado ao ponto. Nada de lançamento manual nem conciliação no fechamento.',
    },
  ],
  features: [
    {
      title: 'Pedido pelo WhatsApp',
      text: 'O colaborador conversa com o canal de RH da empresa no WhatsApp, pergunta quanto pode adiantar e informa o valor. Sem formulário, sem e-mail, sem ir ao DP.',
      icon: 'message-square',
    },
    {
      title: 'Limite pelos dias trabalhados',
      text: 'O sistema consulta o ponto e calcula o valor disponível com base nos dias já trabalhados. O colaborador vê o limite antes de escolher quanto adiantar.',
      icon: 'clock',
    },
    {
      title: 'Confirmação antes de pagar',
      text: 'Antes de enviar, o sistema mostra o valor solicitado e o saldo restante. O colaborador confirma, cancela ou muda o valor na própria conversa.',
      icon: 'check-circle',
    },
    {
      title: 'Pagamento instantâneo via Pix',
      text: 'Confirmado o pedido, o valor cai na conta do colaborador por Pix, na hora. Sem aguardar lote, aprovação em papel ou data de pagamento.',
      icon: 'zap',
    },
    {
      title: 'Desconto automático na folha',
      text: 'Cada adiantamento pago entra como desconto na folha de pagamento, sem lançamento manual. O fechamento já nasce conciliado.',
      icon: 'wallet',
    },
    {
      title: 'Histórico de cada pedido',
      text: 'Pedidos, valores, datas e descontos ficam registrados com a trilha completa. O DP consulta tudo no sistema, sem pedir extrato a ninguém.',
      icon: 'history',
    },
    {
      title: 'Sem papel, sem planilha',
      text: 'Todo o fluxo acontece no celular do colaborador e dentro do sistema de RH. Nenhum formulário impresso, nenhuma planilha paralela de controle.',
      icon: 'smartphone',
    },
  ],
  flow: {
    title: 'Do WhatsApp à folha',
    steps: [
      { title: 'Colaborador pede pelo WhatsApp', text: 'No canal de RH da empresa, o colaborador pergunta quanto pode adiantar.' },
      { title: 'Limite calculado pelo ponto', text: 'O sistema consulta os dias trabalhados registrados no ponto e informa o valor disponível.' },
      { title: 'Escolha e confirmação do valor', text: 'O colaborador informa o valor, vê o saldo restante e confirma, cancela ou ajusta.' },
      { title: 'Pix na hora', text: 'O valor é enviado por Pix para a conta do colaborador, instantaneamente.' },
      { title: 'Desconto automático na folha', text: 'O adiantamento entra como desconto na folha de pagamento, sem lançamento manual e com histórico.' },
    ],
  },
  compliance: [
    'Desconto lançado automaticamente na folha, com histórico',
    'LGPD: acesso por perfil e trilha de auditoria',
  ],
  personas: [
    { role: 'Colaborador', text: 'Pede o adiantamento pelo WhatsApp, vê quanto pode adiantar, confirma e recebe por Pix na hora. Sem constrangimento, sem fila no DP.' },
    { role: 'Departamento Pessoal', text: 'Deixa de receber pedidos por e-mail e de lançar descontos à mão. Acompanha cada adiantamento no sistema e fecha a folha com tudo conciliado.' },
    { role: 'CFO e Financeiro', text: 'Vê os adiantamentos ligados aos dias já trabalhados e descontados automaticamente na folha, com histórico. Um benefício que reduz turnover sem controle paralelo.' },
  ],
  faq: [
    {
      q: 'Como o colaborador pede o adiantamento?',
      a: 'Pelo WhatsApp, no canal de RH da empresa. Ele pergunta quanto pode adiantar, recebe o limite disponível, informa o valor e confirma. Exemplo ilustrativo: com limite de R$ 900,00 pelos dias trabalhados, o colaborador pede R$ 400,00, vê o saldo restante de R$ 500,00 e confirma. O Pix é enviado na hora.',
    },
    {
      q: 'Como o limite disponível é calculado?',
      a: 'Com base nos dias já trabalhados e registrados no ponto. O sistema consulta a frequência do colaborador e informa o valor disponível antes do pedido. Assim, o adiantamento fica ligado ao que a pessoa já trabalhou no período.',
    },
    {
      q: 'Como o desconto chega à folha?',
      a: 'Automaticamente. O NatPay é integrado ao ponto e à folha de pagamento: cada adiantamento pago vira um desconto lançado na folha, sem digitação e com histórico do pedido, do valor e da data. O DP não precisa conciliar nada no fechamento.',
    },
    {
      q: 'Por que o NatPay ajuda a reduzir o turnover?',
      a: 'Porque dá ao colaborador acesso ao salário quando ele precisa, sem burocracia e sem constrangimento. É um benefício percebido no dia a dia, que mostra o cuidado da empresa e pesa na decisão de ficar.',
    },
  ],
  related: ['folha-de-pagamento', 'ponto-eletronico', 'nati', 'natponto'],
  sources: ['sistema-de-rh'],
}

export default page
