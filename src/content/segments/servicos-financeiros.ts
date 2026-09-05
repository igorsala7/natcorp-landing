import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'servicos-financeiros',
  name: 'Serviços Financeiros',
  ctaContext: 'de serviços financeiros',
  tagline: 'Jornada de 6 horas, bônus por meta e trilha de auditoria [[na mesma base]].',
  summary:
    'Bancos, fintechs, seguradoras e cooperativas vivem sob regulação, auditoria e metas. A Natcorp apura a jornada de 6 horas e o cargo de confiança, calcula bônus e PLR por carteira, registra quem viu e alterou cada dado e entrega ao auditor a trilha pronta, do ponto remoto ao fechamento da folha.',
  seo: {
    title: 'Sistema de RH para bancos, fintechs e seguradoras | Natcorp',
    description:
      'RH para serviços financeiros: jornada bancária de 6 horas, bônus e PLR por meta, ponto remoto, perfis de acesso, dois fatores e trilha de auditoria.',
  },
  context: [
    'No setor financeiro, o RH trabalha sob o olhar do auditor. O bancário cumpre 6 horas, o cargo de confiança cumpre 8, e cada minuto além disso vira hora extra que a convenção dos bancários regula em detalhe. A remuneração variável combina bônus, PLR e metas por carteira, produto ou agência, apuradas em ciclos que mudam a cada ano. Quem trabalha em casa ou no híbrido precisa de ponto remoto com a mesma segurança da agência.',
    'Regulação e LGPD exigem segregação de funções, perfis de acesso, dois fatores e registro de quem viu e alterou cada dado sensível. Ao mesmo tempo, fintechs e áreas de tecnologia disputam talentos com o mercado inteiro, a sucessão de lideranças precisa estar mapeada, e previdência complementar e plano de saúde com coparticipação pesam no custo. Em planilhas e sistemas separados, a auditoria vira semanas de trabalho.',
  ],
  facts: [
    { value: '6 horas', label: 'jornada bancária e cargo de confiança de 8 horas apurados pela convenção' },
    { value: 'Bônus e PLR', label: 'metas por carteira, produto e agência calculadas e enviadas à folha' },
    { value: 'Trilha de auditoria', label: 'perfis de acesso, dois fatores e registro de quem viu e alterou cada dado' },
  ],
  pains: [
    { icon: 'clock', title: 'Jornada de 6 horas e cargo de confiança sem folga', text: 'O bancário cumpre 6 horas, o gerente cumpre 8, e a convenção define tolerância, intervalo e hora extra de cada um. Apurar isso à mão gera passivo, e a fiscalização pede AFD e AEJ prontos.' },
    { icon: 'percent', title: 'Bônus, PLR e metas por carteira em planilhas', text: 'Cada área tem múltiplo, elegibilidade e meta própria. Admitidos, desligados e promovidos no meio do ciclo quebram a fórmula, e o valor chega à folha digitado, sem conferência.' },
    { icon: 'lock', title: 'Auditoria e regulação sobre dados sensíveis', text: 'Auditor interno, regulador e LGPD perguntam quem viu salário, quem alterou conta bancária e quem aprovou o reajuste. Sem perfil, dois fatores e trilha, a resposta leva semanas.' },
    { icon: 'map-pin', title: 'Home office e híbrido com ponto confiável', text: 'Parte da equipe trabalha em casa, parte na agência, parte alterna. O ponto precisa registrar rosto, local e hora com a mesma segurança em todos os cenários, sem relógio na parede.' },
    { icon: 'refresh', title: 'Disputa por talentos de tecnologia e sucessão', text: 'Fintechs e bancos disputam os mesmos desenvolvedores e analistas de dados. Quem sai leva conhecimento, e quem lidera precisa de sucessor pronto antes de a vaga abrir.' },
    { icon: 'receipt', title: 'Previdência, coparticipação e custo de benefícios', text: 'Previdência complementar, plano de saúde com coparticipação e seguro de vida pesam na folha. A fatura da operadora chega sem conferência e o desconto entra por planilha.' },
  ],
  answers: [
    {
      pain: 'Jornada bancária',
      title: 'Escala de 6 horas, cargo de confiança e hora extra pela convenção',
      text: 'O Ponto Eletrônico aplica escalas de 6 e 8 horas, tolerâncias, intervalos e banco de horas conforme a convenção dos bancários, com o cargo de confiança parametrizado em Cargos e Salários. Cada ajuste tem trilha de auditoria, o gestor aprova o período no portal e AFD, AEJ e espelho assinado ficam prontos para a fiscalização.',
      modules: ['ponto-eletronico', 'cargos-e-salarios', 'folha-de-pagamento', 'assinatura-eletronica'],
    },
    {
      pain: 'Remuneração variável',
      title: 'Bônus e PLR por carteira calculados e enviados à folha',
      text: 'Metas de empresa, área e pessoa no mesmo ciclo, com elegibilidade por filial, centro de custo e cargo e múltiplos por grupo salarial. Admitidos, desligados e afastados seguem a regra do RH, e quem muda de cargo recebe novo contrato. A apuração exige feedback do gestor, gera planilha de conferência e integra o valor à folha.',
      modules: ['metas-e-resultados', 'avaliacoes-e-feedbacks', 'folha-de-pagamento', 'cargos-e-salarios'],
    },
    {
      pain: 'Auditoria e LGPD',
      title: 'Perfis, dois fatores e trilha de quem viu e alterou cada dado',
      text: 'O acesso é por perfil, empresa, filial e centro de custo, com dois fatores e login corporativo pelo Active Directory. Dados bancários e cadastrais mudam só por requisição, com registro de quem alterou. Cada consulta, aprovação e alteração fica na trilha de auditoria, e o desligamento bloqueia acessos no mesmo fluxo.',
      modules: ['infraestrutura-e-seguranca', 'conexao-com-outros-sistemas', 'administracao-de-pessoal', 'requisicoes-com-workflow', 'offboarding'],
    },
    {
      pain: 'Ponto remoto',
      title: 'NatPonto em casa, na agência e no híbrido, com rosto e local',
      text: 'O colaborador marca o ponto no próprio celular, com reconhecimento facial e geolocalização, em casa ou na agência. Sem sinal, a marcação fica guardada e sincroniza depois. Na agência, catracas e relógios de ponto entram por integração na mesma base, e o gestor vê a frequência da equipe no mesmo dia.',
      modules: ['natponto', 'ponto-eletronico', 'conexao-com-outros-sistemas', 'portais'],
    },
    {
      pain: 'Talentos e sucessão',
      title: 'Banco de talentos, carreira clara e sucessor mapeado',
      text: 'A NATI cruza o banco de talentos com a vaga aprovada, e o Quadro de Vagas leva a marca da instituição ao candidato. Avaliações e nine box alimentam o mapa de sucessão das posições-chave, com prontidão e risco de perda, e o PDI vira trilha de treinamento. O NatPay e a carreira visível no portal dão motivo para ficar.',
      modules: ['recrutamento-e-selecao', 'carreira-e-sucessao', 'avaliacoes-e-feedbacks', 'treinamento-e-desenvolvimento', 'natpay'],
    },
    {
      pain: 'Benefícios',
      title: 'Previdência, coparticipação e fatura conferida antes de pagar',
      text: 'Previdência privada com contratos corporativos, percentuais de contribuição e perfis de risco, plano de saúde com coparticipação, seguro de vida e consignado no mesmo módulo. A fatura da operadora é conferida com a base ativa, os valores viram rubricas na folha sem planilha e a NATI aponta variações atípicas nos contratos.',
      modules: ['gestao-de-beneficios', 'folha-de-pagamento', 'nati', 'requisicoes-com-workflow'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Jornada de 6 horas, cargo de confiança, bônus e PLR na mesma folha, com vários sindicatos e CNPJs e conferência da NATI.',
    'administracao-de-pessoal': 'Dados bancários e cadastrais alterados só por requisição, com registro de quem mudou, e headcount por agência e área.',
    'cargos-e-salarios': 'Cargo de confiança e progressão parametrizados por cargo, travas de política salarial e equidade analisada pela NATI.',
    'gestao-de-beneficios': 'Previdência privada, plano de saúde com coparticipação, seguro de vida e consignado com fatura conferida e rubricas na folha.',
    natpay: 'Adiantamento salarial com limite definido pela política da instituição e desconto automático na folha, um benefício a mais na disputa por talentos.',
    esocial: 'Eventos de folha, afastamentos e processos trabalhistas com validador prévio, para não haver rejeição apontada em auditoria.',
    'juridico-trabalhista': 'Ações de hora extra e cargo de confiança defendidas com jornada e salários da própria folha, e termos de aceite versionados.',
    'ponto-eletronico': 'Escalas de 6 e 8 horas, tolerâncias e banco de horas pela convenção dos bancários, com AFD, AEJ e trilha em cada ajuste.',
    natponto: 'Ponto no celular com reconhecimento facial e geolocalização para home office, híbrido e agência, mesmo sem sinal.',
    'medicina-ocupacional': 'PCMSO e ASO por função, atestados lidos por imagem e painel por CID que revela padrões ergonômicos por área.',
    'seguranca-do-trabalho': 'Laudos ergonômicos da NR-17 versionados, PGR de agências e escritórios, CIPA digital e canal de denúncias rastreável.',
    'recrutamento-e-selecao': 'Banco de talentos com matching da NATI e SLA por vaga para disputar profissionais de tecnologia e dados com o mercado.',
    'quadro-de-vagas': 'Vagas de tecnologia, produtos e agências com a marca da instituição, abertas também para candidatos internos.',
    'admissao-digital': 'Admissão sem papel, com consentimento LGPD, acesso por perfil e trilha de quem viu cada dado do candidato.',
    onboarding: 'Políticas de conduta, segurança da informação e compliance no portal desde o primeiro dia, com questionário de entendimento.',
    offboarding: 'Desligamento com bloqueio de acessos no mesmo fluxo do cálculo, banco de horas remanescente e histórico auditável.',
    'avaliacoes-e-feedbacks': 'Ciclos de desempenho com calibração entre áreas e nine box que alimentam bônus, PDI e sucessão.',
    'metas-e-resultados': 'Bônus e PLR por carteira, produto e agência, com múltiplos por grupo salarial e planilha de conferência antes da folha.',
    'treinamento-e-desenvolvimento': 'Certificações e treinamentos obrigatórios de compliance com validade controlada e trilhas para programas de liderança.',
    'carreira-e-sucessao': 'Posições-chave de liderança com sucessores, prontidão e risco de perda, para a operação não parar quando alguém sai.',
    portais: 'Acesso por perfil, empresa, filial e centro de custo, com login criptografado e auditoria das ações de cada usuário.',
    'requisicoes-com-workflow': 'Alçadas em sequência com suplência automática e histórico permanente para reajuste, férias e alteração cadastral.',
    'chamado-interno': 'Dúvidas de holerite, bônus e benefícios em fila com SLA e histórico imutável, com a NATI respondendo o que é rotina.',
    'blog-corporativo': 'Comunicados de compliance, campanhas e resultados publicados por perfil, com agendamento, no portal que a equipe já usa.',
    'assinatura-eletronica': 'Espelho de ponto, termos e políticas assinados no padrão ICP-Brasil, com perfis Master, Operador e Colaborador.',
    ged: 'Documentos com acesso restrito por perfil e por filial, prontos para auditoria interna e defesa trabalhista.',
    'people-analytics': 'Custo por agência, horas extras por cargo e turnover de tecnologia cruzados sem sair do sistema e sem perder o perfil de acesso.',
    'business-intelligence': 'Painéis executivos de custo de pessoal, headcount e desvio orçamentário, com alerta por e-mail quando o indicador sai da faixa.',
    nati: 'Audita a folha e as horas extras da jornada de 6 horas antes do fechamento, aponta distorções de equidade e responde ao colaborador no Teams.',
    'conexao-com-outros-sistemas': 'Login corporativo com Active Directory, contabilização da folha no ERP e catracas das agências no Ponto Eletrônico.',
    'infraestrutura-e-seguranca': 'Nuvem com produção, homologação e contingência, dados criptografados, dois fatores e trilha de auditoria de cada ação.',
  },
  spotlight: ['ponto-eletronico', 'metas-e-resultados', 'infraestrutura-e-seguranca', 'natponto', 'gestao-de-beneficios', 'carreira-e-sucessao'],
  compliance: [
    'Convenção coletiva dos bancários: jornada de 6 horas e cargo de confiança de 8 horas',
    'Ponto eletrônico conforme a Portaria 671, com AFD, AEJ e espelho assinado',
    'LGPD para dados sensíveis, com acesso por perfil, dois fatores e trilha de auditoria',
    'NR-17 e laudos ergonômicos para o trabalho em agências, centrais e escritórios',
    'eSocial: folha, afastamentos e processos trabalhistas com validador prévio',
    'Assinatura eletrônica no padrão ICP-Brasil para contratos, termos e espelhos de ponto',
  ],
  personas: [
    { role: 'Gerente de agência', text: 'Aprova o ponto da equipe, propõe as metas do ciclo e pede reposição de vaga pelo celular, dentro da alçada e com tudo registrado.' },
    { role: 'Auditoria e compliance', text: 'Recebe a trilha de quem viu, alterou e aprovou cada dado, com perfis por filial e dois fatores, sem pedir extração ao RH.' },
    { role: 'Analista de tecnologia', text: 'Marca o ponto em casa pelo NatPonto, vê o contrato de metas e o plano de carreira no portal e pergunta à NATI no Teams.' },
  ],
  faq: [
    {
      q: 'O sistema trata a jornada de 6 horas do bancário e as 8 horas do cargo de confiança?',
      a: 'Sim. O Ponto Eletrônico tem escalas de 6 e 8 horas com tolerâncias, intervalos e banco de horas parametrizados pela convenção, e o cargo de confiança fica registrado na ficha do cargo em Cargos e Salários. A apuração vai direto para a folha, e AFD e AEJ saem do sistema.',
    },
    {
      q: 'Como o sistema calcula bônus e PLR com metas diferentes por área?',
      a: 'O ciclo de Metas e Resultados define elegibilidade por filial, centro de custo e cargo, múltiplos por grupo salarial e regras para admitidos, desligados e afastados. O gestor negocia as metas no portal, apura com feedback obrigatório e o valor segue para a folha depois da planilha de conferência.',
    },
    {
      q: 'Como o RH responde a uma auditoria de acesso a dados sensíveis?',
      a: 'Cada consulta, alteração e aprovação fica registrada com quem fez e quando. O acesso é por perfil, empresa, filial e centro de custo, com dois fatores e login corporativo. Dados confidenciais têm restrição adicional, e o histórico fica disponível para auditorias internas e externas.',
    },
    {
      q: 'O ponto funciona para quem trabalha em casa ou no híbrido?',
      a: 'Sim. O NatPonto registra a marcação no celular com reconhecimento facial e geolocalização, em casa ou na agência, e funciona sem internet, sincronizando depois. Na agência, relógios de ponto e catracas entram por integração na mesma base de apuração.',
    },
  ],
  visual: 'financial',
  related: ['setor-publico-e-social', 'servicos-ao-consumidor'],
}

export default page
