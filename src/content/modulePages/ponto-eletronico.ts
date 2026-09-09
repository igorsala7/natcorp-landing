import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'ponto-eletronico',
  name: 'Ponto Eletrônico',
  group: 'ponto-e-jornada',
  tagline: 'O sistema de ponto eletrônico que entrega a [[folha já apurada]].',
  summary:
    'O sistema de ponto eletrônico da Natcorp reúne escalas, plantões, banco de horas e abonos em um só lugar. As marcações chegam do NatPonto, de relógios de ponto ou de outros sistemas, o sistema aplica as regras da empresa e do sindicato, e o resultado vai direto para a folha, sem planilha nem digitação.',
  seo: {
    title: 'Sistema de Ponto Eletrônico e Gestão de Jornada | Natcorp',
    description:
      'Sistema de ponto eletrônico para grandes empresas: escalas, plantões 12x36, banco de horas, abono com workflow e apuração integrada à folha. AFD e AEJ.',
  },
  highlights: [
    { value: '75%', label: 'menos tempo no tratamento do ponto' },
    { value: '80%', label: 'mais rápido no fechamento da folha, com o ponto integrado' },
  ],
  benefits: [
    {
      title: 'Fechamento sem retrabalho',
      text: 'A apuração alimenta a folha direto, no formato que a sua regra exige, centesimal ou sexagesimal. Ninguém digita hora, ninguém confere planilha.',
    },
    {
      title: 'Regras da sua empresa, não do sistema',
      text: 'Jornadas fixas, flexíveis e variáveis, 12x36, plantões, DSR (descanso semanal remunerado), interjornada, adicional noturno e convenções sindicais. Configura uma vez e o sistema aplica sempre.',
    },
    {
      title: 'Segurança jurídica na jornada e na rescisão',
      text: 'AFD, AEJ e espelhos assinados digitalmente, trilha de auditoria em cada ajuste e banco de horas remanescente calculado automaticamente no desligamento.',
    },
    {
      title: 'Gestor e colaborador resolvem sozinhos',
      text: 'Abonos, horas extras, trocas de plantão e aprovação do ponto acontecem no portal ou no app, com workflow. O RH acompanha e deixa de ser o gargalo.',
    },
  ],
  features: [
    {
      title: 'Escalas e jornadas',
      text: 'Jornadas fixas, flexíveis e variáveis, escalas de 8h, 6h e 12x36, plantões diurnos, noturnos e rotativos, sobreaviso e folgas variáveis, com limites legais e sindicais.',
      icon: 'calendar',
    },
    {
      title: 'Plantões com aceite digital',
      text: 'O gestor disponibiliza plantões, o colaborador aceita ou oferece para troca pelo app e assina o termo de aceite. Tudo com trilha de auditoria.',
      icon: 'users',
    },
    {
      title: 'Banco de horas',
      text: 'Créditos, débitos, DSR, adicional noturno e folgas compensadas apurados automaticamente. Regras por sindicato, centro de custo ou colaborador e saldo em tempo real.',
      icon: 'clock',
    },
    {
      title: 'Abono de marcações com workflow',
      text: 'O colaborador ou o gestor pede o abono, anexa comprovante e justificativa, o aprovador decide e a marcação é regularizada. Individual ou coletivo.',
      icon: 'workflow',
    },
    {
      title: 'Marcações de qualquer origem',
      text: 'Recebe marcações do NatPonto, de relógios de ponto, catracas e outros sistemas por integração. Tudo chega em uma única base para apuração.',
      icon: 'plug',
    },
    {
      title: 'Apuração direto para a folha',
      text: 'Horas extras, faltas, atrasos e adicionais viram eventos de folha sem exportar nem importar. Formato centesimal ou sexagesimal, conforme a sua regra.',
      icon: 'wallet',
    },
    {
      title: 'Fechamento por empresa e unidade',
      text: 'Calendário de fechamento por empresa, pendências de cada filial visíveis para a matriz antes do corte e conferência por unidade. Feche a referência atual, recalcule uma anterior com trilha de auditoria ou projete o saldo do ano. Na rescisão, o banco remanescente é tratado sozinho.',
      icon: 'refresh',
    },
    {
      title: 'AFD, AEJ e espelho de ponto',
      text: 'Gera AFD e AEJ prontos para a fiscalização e emite espelhos de ponto originais, detalhados, simplificados e abonados, assinados digitalmente com validade legal.',
      icon: 'file-text',
    },
    {
      title: 'Aprovação do ponto pelo gestor',
      text: 'O gestor confere jornada, faltas e ocorrências da equipe e aprova o período no portal ou no celular, antes do fechamento.',
      icon: 'user-check',
    },
    {
      title: 'Indicadores de frequência',
      text: 'Absenteísmo, horas extras versus saldo do banco, abonos por situação e por filial e distribuição de escalas em painéis prontos, sem extração manual.',
      icon: 'bar-chart',
    },
  ],
  flow: {
    title: 'Da marcação ao fechamento da folha',
    steps: [
      { title: 'Marcação', text: 'O colaborador registra o ponto no NatPonto, no relógio de ponto ou em outro sistema conectado.' },
      { title: 'Regras aplicadas', text: 'O sistema confronta as marcações com escala, tolerâncias, DSR, interjornada e regras do sindicato.' },
      { title: 'Exceções tratadas', text: 'Abonos, horas extras e trocas de plantão passam pelo workflow, com justificativa e aprovação.' },
      { title: 'Aprovação do gestor', text: 'O gestor confere a jornada da equipe e aprova o período no portal ou no celular.' },
      { title: 'Pendências por unidade', text: 'A matriz vê o que ainda está aberto em cada filial antes do corte e confere por unidade.' },
      { title: 'Fechamento e folha', text: 'Ponto e banco de horas fechados, eventos enviados à folha e arquivos legais gerados.' },
    ],
  },
  compliance: [
    'AFD (Arquivo Fonte de Dados)',
    'AEJ (Arquivo Eletrônico de Jornada)',
    'Espelho de ponto (Portaria MTP 671/2021) com assinatura digital',
    'Portaria MTP 671/2021 e eSocial',
    'CLT: DSR, interjornada, intrajornada e adicional noturno',
    'LGPD',
  ],
  personas: [
    { role: 'RH e Departamento Pessoal', text: 'Configura as regras uma vez, acompanha as exceções e fecha o ponto sem conferir planilha nem digitar hora na folha.' },
    { role: 'Gestor', text: 'Vê a jornada da equipe, aprova abonos, horas extras e trocas de plantão e libera o período pelo portal ou pelo celular.' },
    { role: 'Colaborador', text: 'Consulta o espelho de ponto e o saldo do banco de horas, pede abono com comprovante e aceita plantões pelo app.' },
  ],
  faq: [
    {
      q: 'O sistema atende escalas 12x36 e plantões?',
      a: 'Sim. O módulo trata jornadas fixas, flexíveis e variáveis, escalas 12x36, plantões diurnos, noturnos e rotativos e sobreaviso, com controle de limites legais e das restrições de cada sindicato. O colaborador aceita ou troca plantões pelo app, com termo de aceite assinado digitalmente.',
    },
    {
      q: 'Como as marcações de relógios de ponto entram no sistema?',
      a: 'Por integração. O sistema recebe marcações do NatPonto, de relógios de ponto, catracas e outros sistemas e reúne tudo em uma única base. A partir daí, a apuração aplica as regras da empresa sem nenhuma digitação.',
    },
    {
      q: 'A apuração vai direto para a folha?',
      a: 'Sim. A integração é nativa: horas extras, faltas, atrasos e adicionais viram eventos de folha automaticamente, no formato centesimal ou sexagesimal que a sua regra exige. O fechamento segue o calendário de cada empresa, com as pendências de cada filial visíveis antes do corte, e pode ser feito na referência atual, anterior ou futura.',
    },
    {
      q: 'O módulo gera AFD, AEJ e espelho de ponto?',
      a: 'Sim. Gera AFD e AEJ prontos para a fiscalização e emite espelhos de ponto originais, detalhados, simplificados e abonados, com assinatura digital e validade legal. O colaborador consulta o espelho pelo portal.',
    },
  ],
  related: ['natponto', 'folha-de-pagamento', 'requisicoes-com-workflow', 'portais'],
  sources: ['gestao-de-frequencia', 'produtividade-de-rh', 'gestao-de-requisicoes-eletronicas', 'apresentacao-natcorp'],
}

export default page
