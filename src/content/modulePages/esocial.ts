import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'esocial',
  name: 'eSocial',
  group: 'pessoal-e-folha',
  tagline: 'Cada evento do eSocial [[enviado, acompanhado e respondido]] no mesmo sistema.',
  summary:
    'Folha, ponto, SESMT e jurídico geram os eventos do eSocial a partir dos dados já validados. Um validador prévio aponta divergências antes do envio, o retorno de cada layout fica visível e a IA prevê inconsistências. Sem retrabalho, sem multa por prazo.',
  seo: {
    title: 'Sistema de eSocial integrado e automático | Natcorp',
    description:
      'eSocial integrado: envio automático dos eventos de folha, SST e processos trabalhistas, validação prévia de divergências e retorno de cada layout acompanhado.',
  },
  highlights: [
    { value: '1 dia útil', label: 'prazo do S-2210 após o acidente, com envio automático' },
    { value: 'S-2500', label: 'processos trabalhistas enviados direto do módulo jurídico' },
  ],
  benefits: [
    {
      title: 'Sem redigitar nada para o governo',
      text: 'Admissão, folha, afastamento, CAT (Comunicação de Acidente de Trabalho), exames e processos trabalhistas já estão no sistema. O evento sai dali, com os dados que a folha e o SESMT validaram.',
    },
    {
      title: 'Divergência encontrada antes do envio',
      text: 'O validador prévio confere o evento contra a base e aponta o que seria rejeitado. A IA prevê inconsistências nos envios. Menos rejeição, menos multa.',
    },
    {
      title: 'Prazos legais cumpridos',
      text: 'A CAT registrada dispara o S-2210 até o primeiro dia útil seguinte ao acidente. Cada layout tem status de envio e retorno visíveis para quem precisa acompanhar.',
    },
    {
      title: 'RH, SESMT e jurídico na mesma fonte',
      text: 'Uma única base alimenta os eventos de folha, de saúde e segurança e de processos trabalhistas de todas as empresas do grupo. Ninguém envia um dado diferente do outro.',
    },
  ],
  features: [
    {
      title: 'Eventos gerados da folha',
      text: 'Admissões, alterações, afastamentos, férias, desligamentos e remuneração viram eventos a partir dos dados validados da folha, com envio automático.',
      icon: 'wallet',
    },
    {
      title: 'SST: S-2210, S-2220 e S-2240',
      text: 'CAT, monitoramento da saúde e agentes nocivos enviados direto do módulo de SESMT, com o S-2210 até o primeiro dia útil seguinte ao acidente.',
      icon: 'hard-hat',
    },
    {
      title: 'Processos trabalhistas: S-2500 e S-2501',
      text: 'Dados da causa, bases contratuais, vínculo, IRRF e contribuições transmitidos do módulo jurídico, incluindo reclamantes sem vínculo.',
      icon: 'gavel',
    },
    {
      title: 'Validador prévio de divergências',
      text: 'Antes de transmitir, o sistema confere o evento contra a base e aponta o que seria rejeitado, evitando retrabalho e multa.',
      icon: 'check-circle',
    },
    {
      title: 'Acompanhamento de cada layout',
      text: 'Status de envio, protocolo e retorno de cada evento em uma tela, no computador ou no celular. Rejeições aparecem com o motivo para correção e reenvio.',
      icon: 'eye',
    },
    {
      title: 'Inconsistências previstas pela IA',
      text: 'A IA audita a folha antes do fechamento e prevê inconsistências nos envios do eSocial, com análise, diagnóstico, pontos de atenção e sugestão.',
      icon: 'sparkles',
    },
    {
      title: 'Ponto em conformidade',
      text: 'Jornadas, horas extras e banco de horas apurados conforme CLT, eSocial e Portaria MTP 671/2021, com AFD e AEJ gerados pelo sistema.',
      icon: 'clock',
    },
    {
      title: 'Envio por empresa e CNPJ, em lotes',
      text: 'Cada empresa e CNPJ do grupo tem o seu envio e o seu acompanhamento. Os eventos saem em lotes, cada um volta com o retorno, e as rejeições são corrigidas e reenviadas sem sair da fila.',
      icon: 'building',
    },
  ],
  flow: {
    title: 'Do fato ao retorno do governo',
    steps: [
      { title: 'Fato registrado no sistema', text: 'Admissão, afastamento, CAT, exame ou sentença entram no módulo de origem, uma única vez.' },
      { title: 'Evento montado automaticamente', text: 'O sistema monta o layout correspondente com os dados já validados pela folha, pelo SESMT ou pelo jurídico.' },
      { title: 'Validação prévia', text: 'O validador confere o evento contra a base e a IA aponta possíveis inconsistências antes do envio.' },
      { title: 'Envio automático', text: 'O evento é transmitido dentro do prazo legal, por empresa e CNPJ, como o S-2210 até o primeiro dia útil seguinte ao acidente.' },
      { title: 'Retorno acompanhado', text: 'Protocolo, aceite ou rejeição ficam visíveis por layout. Rejeições voltam com o motivo para correção.' },
    ],
  },
  compliance: [
    'S-2210: Comunicação de Acidente de Trabalho até o primeiro dia útil seguinte ao acidente',
    'S-2220: Monitoramento da saúde do trabalhador',
    'S-2240: Condições ambientais e agentes nocivos',
    'S-2500 e S-2501: processos trabalhistas e tributos',
    'Portaria MTP 671/2021: AFD e AEJ do ponto eletrônico',
    'CLT e legislação trabalhista vigente',
    'LGPD',
  ],
  personas: [
    { role: 'Departamento Pessoal', text: 'Fecha a folha e vê os eventos saírem sozinhos, por empresa. Trata só o que o validador ou o retorno apontarem.' },
    { role: 'SESMT', text: 'Registra a CAT, o exame ou o risco no módulo e o evento de SST é enviado no prazo, sem depender do DP.' },
    { role: 'Jurídico e Financeiro', text: 'Envia S-2500 e S-2501 direto do processo, com bases de cálculo e tributos corretos e rastreáveis.' },
  ],
  faq: [
    {
      q: 'Preciso digitar os eventos do eSocial em outro sistema?',
      a: 'Não. O eSocial é integrado ao sistema: os eventos são gerados a partir dos dados já registrados na folha, no ponto, no SESMT e no jurídico e enviados automaticamente. Você acompanha o status e o retorno de cada layout na mesma tela.',
    },
    {
      q: 'Como o sistema evita rejeições e multas?',
      a: 'Um validador prévio confere cada evento contra a base antes do envio e aponta divergências. A IA ainda prevê inconsistências nos envios. Prazos críticos, como o S-2210 após uma CAT, são disparados automaticamente até o primeiro dia útil seguinte ao acidente.',
    },
    {
      q: 'Os eventos de SST e dos processos trabalhistas também são enviados?',
      a: 'Sim. O módulo de SESMT envia S-2210, S-2220 e S-2240, e o módulo jurídico envia S-2500 e S-2501, com tratamento de reclamantes sem vínculo. Tudo sai da mesma base que alimenta a folha.',
    },
    {
      q: 'Como funciona o envio para um grupo com vários CNPJs?',
      a: 'Por empresa e CNPJ. Os eventos saem em lotes a partir dos dados validados da folha, do SESMT e do jurídico, e cada um volta com status, protocolo e retorno do governo. Rejeições aparecem com o motivo, são corrigidas e reenviadas na mesma fila, e o histórico fica disponível por empresa para auditoria.',
    },
  ],
  related: ['folha-de-pagamento', 'seguranca-do-trabalho', 'medicina-ocupacional', 'juridico-trabalhista'],
  sources: ['pagadoria', 'gestao-do-sesmt', 'gestao-juridica-trabalhista', 'performance-e-seguranca', 'abrangencia-do-sistema', 'tecnologia', 'gestao-de-frequencia', 'produtividade-de-rh'],
}

export default page
