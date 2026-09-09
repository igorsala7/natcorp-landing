import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'seguranca-do-trabalho',
  name: 'Segurança do Trabalho',
  group: 'saude-e-seguranca',
  tagline: 'Sistema de segurança do trabalho: riscos mapeados, EPIs entregues, [[eSocial em dia]].',
  summary:
    'O sistema de SESMT da Natcorp reúne PGR, EPIs com CA validado, CAT, LTCAT, PPP e CIPA em um só lugar, no escritório ou em campo. Cada risco mapeado alimenta o GHE, o PCMSO, o PPP e os eventos S-2210 e S-2240 do eSocial. Menos papel, menos passivo, mais prevenção.',
  seo: {
    title: 'Sistema de Segurança do Trabalho e SESMT | Natcorp',
    description:
      'Sistema de segurança do trabalho e SESMT integrado ao RH: PGR/GRO, EPIs com CA, CAT com S-2210 no prazo, LTCAT, PPP eletrônico, CIPA e checklist de NRs.',
  },
  highlights: [
    { value: '1 dia útil', label: 'prazo do S-2210 após o acidente, com envio automático' },
    { value: '100%', label: 'digital: ficha de EPI, eleição da CIPA e checklists de NR' },
  ],
  benefits: [
    {
      title: 'Passivo trabalhista sob controle',
      text: 'Ficha de EPI (equipamento de proteção individual) assinada, checklists de NR, laudos versionados e histórico completo. Na ação trabalhista, a defesa sai da fonte, sem contradição.',
    },
    {
      title: 'Prazo legal cumprido sem correria',
      text: 'A CAT (Comunicação de Acidente de Trabalho) é aberta em poucos passos e o S-2210 sai até o primeiro dia útil seguinte ao acidente. O S-2240 nasce do PGR (Programa de Gerenciamento de Riscos). Um validador confere tudo antes de enviar ao eSocial.',
    },
    {
      title: 'Um dado, vários documentos',
      text: 'O risco mapeado no PGR alimenta o GHE (Grupo Homogêneo de Exposição), o PCMSO (Programa de Controle Médico de Saúde Ocupacional), o LTCAT (Laudo Técnico das Condições Ambientais do Trabalho) e o PPP (Perfil Profissiográfico Previdenciário). Mudou a exposição, os documentos acompanham, sem redigitar.',
    },
    {
      title: 'Prevenção que a NATI acompanha',
      text: 'A NATI analisa o PGR e o uso de EPIs, aponta lacunas nas NRs e avisa vencimentos de treinamentos e ASOs (Atestados de Saúde Ocupacional) antes que virem problema.',
    },
  ],
  features: [
    {
      title: 'PGR e GRO',
      text: 'Programa de Gerenciamento de Riscos e Gerenciamento de Riscos Ocupacionais: mapeamento de perigos e agentes, matriz de severidade e probabilidade e plano de ação 5W2H dinâmico, focado na mitigação contínua.',
      icon: 'alert-triangle',
    },
    {
      title: 'EPIs com validação de CA',
      text: 'Controle de estoque, entrega, substituição e devolução, com consulta automática do CA (Certificado de Aprovação) na base do Governo Federal e alerta de validade.',
      icon: 'hard-hat',
    },
    {
      title: 'Ficha de EPI 100% digital',
      text: 'O colaborador assina a entrega por biometria ou assinatura eletrônica. Sem papel e com prova de que recebeu o equipamento.',
      icon: 'file-signature',
    },
    {
      title: 'CAT e S-2210 no prazo legal',
      text: 'Abertura simplificada de CAT para acidentes com ou sem afastamento, de trajeto e doenças, com disparo automático do S-2210 até o primeiro dia útil seguinte ao acidente.',
      icon: 'zap',
    },
    {
      title: 'LTCAT e PPP eletrônico',
      text: 'LTCAT mantido com as atividades que ensejam aposentadoria especial e PPP gerado na hora a partir do histórico de riscos e do eSocial.',
      icon: 'file-text',
    },
    {
      title: 'CIPA e NR-05',
      text: 'Eleição 100% digital, com inscrição, votação, apuração e ata. Reuniões, planos de ação da comissão e gestão de brigadistas no mesmo lugar.',
      icon: 'users',
    },
    {
      title: 'Checklists de NR',
      text: 'Auditorias automatizadas de conformidade (NR-10, NR-12, NR-35 e outras), inspeção de EPIs e validade de treinamentos e brigada em um painel.',
      icon: 'list-checks',
    },
    {
      title: 'Laudos em nuvem',
      text: 'Repositório de laudos ergonômicos (AEP/AET) e medições quantitativas com controle de versão. Acervo histórico pronto para auditoria e processos.',
      icon: 'cloud',
    },
    {
      title: 'Canal de denúncias',
      text: 'Canal integrado e rastreável para prevenção de assédio, ligado à CIPA, com registro e acompanhamento das ocorrências.',
      icon: 'message-square',
    },
    {
      title: 'Inspeção em campo',
      text: 'As mesmas funções do escritório na inspeção de campo, no tablet ou no celular. Entrega de EPI, checklist e registro de incidente feitos na hora.',
      icon: 'smartphone',
    },
  ],
  flow: {
    title: 'Do risco mapeado ao eSocial',
    steps: [
      { title: 'Mapeamento no PGR', text: 'Perigos, agentes e riscos avaliados por ambiente e função, com plano de ação.' },
      { title: 'GHE e exposição', text: 'Colaboradores agrupados por exposição semelhante. LTCAT e PPP atualizados a partir daí.' },
      { title: 'Proteção entregue', text: 'EPIs com CA validado entregues e assinados digitalmente. Checklists de NR executados.' },
      { title: 'Ocorrência tratada', text: 'Acidente ou incidente registrado, CAT aberta e ações corretivas no plano.' },
      { title: 'Validação e envio', text: 'S-2210 e S-2240 passam pelo validador de divergências e seguem ao eSocial, o S-2210 até o primeiro dia útil seguinte ao acidente.' },
    ],
  },
  compliance: [
    'eSocial S-2210 (CAT) até o primeiro dia útil seguinte ao acidente',
    'eSocial S-2240 (agentes nocivos)',
    'PGR / GRO',
    'NR-05 (CIPA)',
    'Checklists de NR-10, NR-12 e NR-35',
    'LTCAT e PPP',
    'CA validado na base do Governo Federal',
  ],
  personas: [
    { role: 'Técnico e engenheiro de segurança', text: 'Mapeia riscos, roda checklists em campo pelo tablet, entrega EPI com assinatura digital e abre a CAT sem sair do sistema.' },
    { role: 'RH e Jurídico Trabalhista', text: 'Encontra ficha de EPI, laudo e histórico de exposição na hora que precisa, direto da fonte, para defesa e auditoria.' },
    { role: 'Colaborador', text: 'Recebe o EPI, assina pelo celular, participa da eleição da CIPA e registra incidentes pelo portal.' },
  ],
  faq: [
    {
      q: 'O sistema valida o CA dos EPIs?',
      a: 'Sim. O sistema consulta automaticamente o Certificado de Aprovação na base do Governo Federal e controla o prazo de validade. EPIs vencidos ou sem CA válido não passam despercebidos.',
    },
    {
      q: 'Como funciona a CAT e o envio do S-2210?',
      a: 'A CAT é aberta em poucos passos, para acidentes com ou sem afastamento, de trajeto e doenças ocupacionais. O evento S-2210 é disparado automaticamente até o primeiro dia útil seguinte ao acidente, cumprindo o prazo legal, depois de passar por um validador de divergências.',
    },
    {
      q: 'A eleição da CIPA pode ser feita pelo sistema?',
      a: 'Sim. O processo eleitoral é 100% digital: inscrição de candidatos, votação, apuração e ata. Depois, o módulo gerencia reuniões, planos de ação e o canal de denúncias da comissão, atendendo à NR-05.',
    },
    {
      q: 'O PPP e o LTCAT são gerados automaticamente?',
      a: 'Sim. O LTCAT é mantido com as atividades que ensejam aposentadoria especial, e o PPP eletrônico é gerado na hora a partir do histórico de riscos e exposição do colaborador, em conformidade com o eSocial. O PPP também pode ser pedido por requisição eletrônica.',
    },
  ],
  related: ['medicina-ocupacional', 'esocial', 'treinamento-e-desenvolvimento', 'juridico-trabalhista'],
  sources: ['gestao-do-sesmt', 'nati-operadores', 'abrangencia-do-sistema', 'csc-bpo', 'apresentacao-natcorp', 'gestao-de-requisicoes-eletronicas'],
}

export default page
