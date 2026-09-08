import type { GroupId } from './modulePages/types'
import type { CastKey } from './hiringJourney'

/**
 * Apresentação executiva (/apresentacao): o roteiro comercial do sistema, slide a slide.
 * Segue a seção 14 do Manual de Identidade v1.2: um assunto por slide, até três números de
 * destaque, seção de produto em Azul Profundo, rodapé com símbolo e número do slide.
 * Os números vêm do material comercial da Natcorp (os mesmos usados no site).
 */

export const deckMeta = {
  edition: 'Apresentação comercial · 2026',
  title: 'A transformação que seu RH precisa.',
  subtitle:
    'Todo o RH em um único sistema: folha, ponto, eSocial, admissão, saúde e segurança, talentos e People Analytics, com a NATI, a inteligência artificial que trabalha dentro dele.',
  audience: ['Gerência e diretoria de RH', 'Departamento Pessoal', 'SESMT', 'Diretoria de TI'],
  seoTitle: 'A transformação que seu RH precisa | Apresentação executiva Natcorp',
  seoDescription:
    'Apresentação executiva do sistema de RH da Natcorp: mais de 30 módulos integrados, a NATI, servidores dedicados na Oracle Cloud e os resultados que grandes empresas alcançam. Para CEO, CHRO, CFO, CTO e times de RH e DP.',
}

/* 01 · O momento: por que agora. */
export const momento = {
  title: 'O RH das empresas que lideram [[já mudou de lugar]].',
  lead:
    'Saiu do operacional e sentou na mesa do negócio: decide com dados, automatiza a rotina e responde ao colaborador em segundos. Quem ainda fecha a folha na planilha não está atrasado no RH. Está atrasado no negócio.',
  shifts: [
    { title: 'Dado, não achismo.', text: 'Turnover, headcount e custo por centro de custo em tempo real, não no fim do mês.' },
    { title: 'IA dentro do sistema.', text: 'A inteligência artificial responde, analisa e alerta antes do problema, não depois.' },
    { title: 'Autonomia na ponta.', text: 'O gestor aprova no celular, o colaborador se resolve sozinho e o RH cuida do que é estratégico.' },
  ],
  punch: 'A pergunta não é se o seu RH vai passar por essa transformação. É se vai liderar ou correr atrás.',
}


/* As duas versões da apresentação. */
export const deckVersions = {
  completa: { label: 'Completa', duration: 'cerca de 45 minutos', text: 'Todas as frentes do sistema, uma a uma, com a tecnologia e o modelo comercial.' },
  reduzida: { label: 'Reduzida', duration: 'cerca de 20 minutos', text: 'O dia do RH, o sistema resolvendo e os números. Para a primeira conversa.' },
} as const
export type DeckVersion = keyof typeof deckVersions

/* 01 · Um dia no seu RH: as dores na ordem em que aparecem, e a resposta de cada uma. */
export const diaNoRh = {
  title: 'Você reconhece [[este dia]]?',
  lead: 'Um dia comum em um RH que ainda trabalha com sistemas separados e planilhas. Cada hora tem uma dor. Todas têm resposta no mesmo sistema.',
  moments: [
    {
      time: '07h50',
      title: 'O eSocial rejeitou três eventos',
      pain: 'O erro está no cadastro de um sistema e o envio saiu de outro. Alguém vai passar a manhã comparando telas.',
      answer: 'Cadastro único e eSocial acompanhado na mesma tela em que a folha é calculada. A inconsistência aparece antes do envio.',
      module: 'eSocial',
    },
    {
      time: '09h10',
      title: 'O gestor não aprovou as férias',
      pain: 'O pedido está em um e-mail de duas semanas atrás. O colaborador liga para o RH. O RH liga para o gestor.',
      answer: 'O gestor aprova no celular e a folha recebe as férias sozinha. Aprovou, efetivou.',
      module: 'Requisições com Workflow',
    },
    {
      time: '11h30',
      title: 'A diretoria pediu o turnover por unidade',
      pain: 'Exporta de um sistema, cola na planilha, confere com o mês passado. É a sétima versão da mesma planilha.',
      answer: 'People Analytics com os dados de todos os módulos. Ou uma pergunta à NATI, em português, com o gráfico na resposta.',
      module: 'People Analytics',
    },
    {
      time: '14h00',
      title: 'Um atestado sumiu no caminho',
      pain: 'Foi entregue na portaria, passou pelo gestor e não chegou ao DP antes do corte. O desconto saiu errado.',
      answer: 'O colaborador envia o atestado pelo portal ou pelo app. Medicina Ocupacional e folha recebem o mesmo registro.',
      module: 'Medicina Ocupacional',
    },
    {
      time: '16h20',
      title: 'O fechamento começou. De novo.',
      pain: 'Ponto em um sistema, folha em outro. Horas redigitadas, conferidas e cobradas por e-mail até tarde.',
      answer: 'O ponto apurado entra direto na folha. 10.000 colaboradores calculados em cerca de quatro minutos, com 100% da folha auditada pela NATI.',
      module: 'Folha de Pagamento',
    },
    {
      time: '18h05',
      title: 'A auditoria pediu quem acessou o quê',
      pain: 'Salário, CPF e atestado circulam por e-mail e planilha. Ninguém sabe dizer quem viu o quê.',
      answer: 'Perfis por empresa e filial, trilha de auditoria de cada acesso e os dados pessoais dentro do sistema, como a LGPD pede.',
      module: 'Segurança e LGPD',
    },
  ],
}

/* O fechamento da folha: o número que muda a conversa. */
export const fechamento = {
  title: '10.000 colaboradores. [[Quatro minutos.]] Folha pronta para conferir.',
  lead:
    'A folha calcula 2.500 colaboradores por minuto sobre o ponto já apurado, com o eSocial acompanhado na mesma tela e a contabilização pronta para o ERP. A NATI audita 100% dos cálculos, sem amostragem, e aponta o desvio antes do pagamento.',
  steps: [
    { label: 'Ponto apurado', text: 'As horas certas já estão na folha, sem redigitar.' },
    { label: 'Cálculo', text: '2.500 colaboradores por minuto, por empresa, CNPJ e centro de custo.' },
    { label: 'Auditoria da NATI', text: 'Todos os cálculos conferidos. Cada inconsistência vem com o motivo.' },
    { label: 'eSocial e contabilização', text: 'Eventos acompanhados e a folha contabilizada, pronta para o ERP.' },
  ],
  numbers: [
    { value: 2500, label: 'colaboradores calculados por minuto' },
    { value: '80%', label: 'mais rápido no fechamento' },
    { value: '100%', label: 'da folha auditada, sem amostragem' },
  ],
}

/* O catálogo: todos os módulos, cada um com a sua página. */
export const modulosCatalogo = {
  title: 'Mais de 30 módulos. [[Clique em qualquer um]].',
  lead: 'Cada módulo tem a sua página aqui dentro: o que faz, como funciona o processo e os números. Abra o que a conversa pedir e volte para o slide de onde saiu.',
  leadPrint: 'Cada módulo tem a sua página nesta apresentação: o que faz, como funciona o processo e os números. As páginas vêm logo depois do último slide.',
}

/* A jornada de Ana, em quatro fases. Poucas palavras: quem apresenta conta o resto. */
export const jornadaResumo = {
  title: 'Da vaga à promoção, [[uma história só]]: a de Ana.',
  lead: 'Cinco pessoas, um cadastro, o mesmo sistema em cada fase.',
  phases: [
    {
      key: 'vaga',
      label: 'Vaga e seleção',
      when: 'Semana 1',
      who: ['marcos', 'juliana'] as CastKey[],
      headline: 'A vaga abre pelo celular do gestor.',
      beats: ['Requisição aprovada no fluxo', 'Vaga no ar com a marca da empresa', 'Triagem por fase, sem planilha'],
      modules: [
        { name: 'Requisições com Workflow', slug: 'requisicoes-com-workflow' },
        { name: 'Recrutamento e Seleção', slug: 'recrutamento-e-selecao' },
        { name: 'Quadro de Vagas', slug: 'quadro-de-vagas' },
      ],
    },
    {
      key: 'admissao',
      label: 'Admissão sem papel',
      when: 'Semana 3',
      who: ['ana', 'beatriz', 'henrique'] as CastKey[],
      headline: 'Ana se admite sozinha, do celular.',
      beats: ['A candidata preenche os próprios dados', 'Exame agendado e contrato assinado', 'O DP confere em uma tela só'],
      modules: [
        { name: 'Admissão Digital', slug: 'admissao-digital' },
        { name: 'Medicina Ocupacional', slug: 'medicina-ocupacional' },
        { name: 'Assinatura Eletrônica', slug: 'assinatura-eletronica' },
      ],
    },
    {
      key: 'primeiro-dia',
      label: 'Primeiro dia',
      when: 'Dia 1',
      who: ['ana', 'rafael'] as CastKey[],
      headline: 'O primeiro dia já estava pronto.',
      beats: ['Ponto por reconhecimento facial', 'EPIs do cargo separados', 'Treinamentos das NRs agendados'],
      modules: [
        { name: 'NatPonto', slug: 'natponto' },
        { name: 'Segurança do Trabalho', slug: 'seguranca-do-trabalho' },
        { name: 'Treinamento e Desenvolvimento', slug: 'treinamento-e-desenvolvimento' },
      ],
    },
    {
      key: 'rotina',
      label: 'Rotina e crescimento',
      when: 'Do 1º mês ao 1º ano',
      who: ['ana', 'paulo', 'marcos'] as CastKey[],
      headline: 'A rotina se resolve sem o RH no meio.',
      beats: ['Férias e holerite no portal', '10.000 folhas em quatro minutos', 'O mapa de sucessão aponta para Ana'],
      modules: [
        { name: 'Portais', slug: 'portais' },
        { name: 'Folha de Pagamento', slug: 'folha-de-pagamento' },
        { name: 'Carreira e Sucessão', slug: 'carreira-e-sucessao' },
      ],
    },
  ],
  hub: 'Uma confirmação, sete atualizações: folha, ponto, benefícios, SESMT, treinamento, portal e eSocial recebem a mesma admissão.',
}

/* Portais e NatPonto: cada pessoa entra pela sua porta. */
export const portaisSlide = {
  title: 'Cada pessoa entra pela [[sua porta]]. O RH deixa de ser o balcão.',
  lead: 'Três portais e um app, sobre a mesma base. O colaborador se resolve sozinho, o gestor aprova onde estiver e o RH cuida do que precisa de gente.',
  portals: [
    { name: 'Portal do Colaborador', who: 'Para todas as pessoas da empresa', items: ['Holerite e informe de rendimentos', 'Espelho de ponto e banco de horas', 'Férias, requisições e documentos para assinar'] },
    { name: 'Portal do Gestor', who: 'Para quem lidera uma equipe', items: ['Aprovações de requisições e ponto', 'Férias e escalas da equipe', 'Avaliações e indicadores do time'] },
    { name: 'Portal do Operador', who: 'Para o RH e o Departamento Pessoal', items: ['O sistema completo: folha, ponto, eSocial, admissão', 'Benefícios, saúde e segurança, talentos', 'Painéis e a NATI'] },
  ],
  app: { name: 'NatPonto', text: 'Ponto por reconhecimento facial e geolocalização, com marcação offline que sincroniza depois. Holerite, escala e avisos no mesmo app.' },
  stat: { value: '70%', label: 'menos chamados de dúvidas com o autoatendimento e a NATI' },
}

/* A mesma rotina, antes e depois. */
export const antesDepois = {
  title: 'A mesma rotina, [[antes e depois]].',
  lead: 'O que muda no dia a dia de quem opera o RH.',
  rows: [
    { task: 'Fechar a folha', before: 'Exportar o ponto, redigitar horas, conferir por amostragem, cobrar pendências por e-mail.', after: 'Ponto apurado já na folha. Cálculo em minutos. 100% auditado pela NATI antes do pagamento.' },
    { task: 'Admitir alguém', before: 'Papel, fichas, cópias e um cadastro em cada sistema. Dias até o primeiro dia.', after: 'A pessoa preenche os próprios dados. Um cadastro só. Contrato assinado no celular.' },
    { task: 'Responder ao colaborador', before: 'Ligação, e-mail, chamado. O RH procura a informação e responde um a um.', after: 'A NATI responde em segundos, no portal, no WhatsApp ou no Teams. Holerite, saldo de férias, ponto.' },
    { task: 'Aprovar férias e requisições', before: 'E-mail para o gestor, planilha de controle e lançamento manual no sistema.', after: 'O gestor aprova no celular. O sistema efetiva. Ninguém redigita.' },
    { task: 'Responder à diretoria', before: 'Exportar, colar, conferir. A sétima versão da planilha de turnover.', after: 'Painel pronto com os dados de todos os módulos. Ou uma pergunta à NATI, com o gráfico na resposta.' },
    { task: 'Cuidar dos prazos de SST', before: 'ASO vencendo descoberto tarde, S-2210 fora do prazo, multa.', after: 'Vencimentos avisados com antecedência. Eventos de SST do eSocial enviados no prazo, sem retrabalho.' },
  ],
}

/* A NATI nos canais e avisando antes. */
export const natiCanais = {
  title: 'A NATI responde onde o colaborador [[já está]]. E avisa o RH antes.',
  lead:
    'No portal, no WhatsApp e no Microsoft Teams, 24 horas. Para o RH, a NATI lê todos os módulos ao mesmo tempo e aponta o desvio antes do fechamento, da auditoria e da multa.',
  bullets: [
    'Holerite, informe, saldo de férias e ponto respondidos em segundos',
    'Requisições e atestados enviados pela própria conversa',
    'Alertas de vencimento, desvio e prazo, com a ação já preparada',
    'Executa só o que uma pessoa aprovou',
  ],
}

/* People Analytics: a resposta pronta antes da pergunta. */
export const analyticsSlide = {
  title: 'A resposta para a diretoria [[já está pronta]] quando a pergunta chega.',
  lead:
    'People Analytics e BI com os dados de todos os módulos: headcount, turnover, custo por centro de custo, absenteísmo, medicina ocupacional. Painéis prontos, e o próprio usuário cruza, filtra e exporta, sem depender de TI.',
  numbers: [
    { value: '3.500+', label: 'telas customizáveis pelo usuário' },
    { value: '1.800+', label: 'relatórios prontos para cruzar' },
    { value: '900+', label: 'gráficos gerenciais na interface' },
  ],
}

/* 02 · O custo do RH operacional. */
export const custo = {
  title: 'Quanto do tempo do seu RH ainda vai para o que [[não é estratégico]]?',
  pains: [
    {
      title: 'Vários sistemas, nenhum integrado.',
      text: 'Folha em um, ponto em outro, recrutamento em um terceiro. O mesmo dado é digitado três vezes e a divergência aparece depois de pagar.',
    },
    {
      title: 'Planilha para tudo o que o sistema não entrega.',
      text: 'Turnover, headcount, custo por centro de custo: o RH exporta, cola e mantém uma planilha paralela para responder à diretoria.',
    },
    {
      title: 'Horas de trabalho manual, todo mês.',
      text: 'Analistas conferem, redigitam e cobram pendências por e-mail. O tempo que devia ir para as pessoas vai para o operacional.',
    },
  ],
  /* A cena "hoje": quatro lugares, quatro versões da mesma informação (cenário ilustrativo). */
  today: [
    { title: 'Sistema de ponto', file: 'ponto.exe', badge: 'Exporta, importa, confere' },
    { title: 'Sistema de folha', file: 'folha.exe', badge: 'Horas redigitadas à mão' },
    { title: 'Planilha de indicadores', file: 'turnover_v7.xlsx', badge: '7 versões da mesma planilha' },
    { title: 'E-mail do RH', file: 'caixa de entrada', badge: '42 pendências cobradas à mão' },
  ],
  risk: 'Dado pessoal em planilha e em e-mail é risco de LGPD que ninguém contabiliza.',
}

/* 03 · A resposta. */
export const resposta = {
  title: 'Todo o RH. [[Um único sistema.]]',
  lead:
    'Uma HR Tech brasileira que há mais de 35 anos faz uma única coisa: tecnologia para a gestão de pessoas das grandes empresas. Departamento Pessoal, Recursos Humanos, Medicina e Segurança do Trabalho na mesma base, com a NATI trabalhando dentro do sistema.',
  numbers: [
    { value: 35, suffix: '+', label: 'anos dedicados exclusivamente à gestão de pessoas' },
    { value: 30, suffix: '+', label: 'módulos nativos, na mesma base de dados' },
    { value: 500, suffix: ' mil+', label: 'colaboradores administrados no sistema' },
  ],
}

/* 04 · A plataforma. */
export const plataforma = {
  title: 'Mais de 30 módulos. [[Um sistema. Uma IA.]]',
  lead: 'Um cadastro, uma base, uma experiência. Cada módulo existe por si e só faz sentido no conjunto, como os quatro módulos do símbolo.',
}

/* Números de destaque por frente (material comercial, os mesmos das páginas de módulo). */
export const groupHighlights: Record<GroupId, { value: string; label: string }[]> = {
  'pessoal-e-folha': [
    { value: '2.500', label: 'colaboradores calculados por minuto' },
    { value: '80%', label: 'mais rápido no fechamento da folha' },
    { value: '100%', label: 'da folha auditada pela IA, sem amostragem' },
  ],
  'ponto-e-jornada': [
    { value: '75%', label: 'menos tempo no tratamento do ponto' },
    { value: '0', label: 'marcações perdidas sem internet' },
    { value: 'REP-P', label: 'conforme a Portaria MTP 671/2021' },
  ],
  'saude-e-seguranca': [
    { value: '100%', label: 'digital: exames, atestados e ASOs sem papel' },
    { value: '4', label: 'documentos encadeados: PGR, GHE, PCMSO e ASO' },
    { value: '1 dia útil', label: 'prazo do S-2210, com envio automático' },
  ],
  talentos: [
    { value: '100%', label: 'digital, da requisição de vaga à contratação' },
    { value: '1 vez', label: 'o colaborador é cadastrado e já existe em todos os módulos' },
    { value: '5 passos', label: 'do candidato aprovado ao cadastro na folha' },
  ],
  desenvolvimento: [
    { value: '90° a 360°', label: 'ciclos de avaliação, como o RH definir' },
    { value: '100%', label: 'é a soma dos pesos das metas, sem furo' },
    { value: '1 botão', label: 'para replicar o ciclo do ano anterior' },
  ],
  autoatendimento: [
    { value: '250+', label: 'funções nos Portais do Gestor e do Colaborador' },
    { value: '70%', label: 'menos chamados de dúvidas' },
    { value: '1 pedido', label: 'dispara dezenas de atualizações, sem redigitar' },
  ],
  'dados-ia-plataforma': [
    { value: '3.500+', label: 'telas customizáveis pelo próprio usuário' },
    { value: '1.800+', label: 'relatórios para extração e cruzamento' },
    { value: '900+', label: 'gráficos gerenciais na própria interface' },
  ],
}

/* Título de cada frente, com o trecho em destaque. */
export const groupTitles: Record<GroupId, string> = {
  'pessoal-e-folha': 'A folha fecha com o ponto, o eSocial e o orçamento [[no mesmo lugar]].',
  'ponto-e-jornada': 'Marcação no celular, apuração automática e [[horas certas na folha]].',
  'saude-e-seguranca': 'SESMT [[dentro do sistema de RH]]: exames, riscos, documentos e prazos.',
  talentos: 'Da requisição da vaga à admissão [[sem papel]], em um fluxo só.',
  desenvolvimento: 'Avaliar, treinar, reconhecer e preparar sucessores [[com dados]].',
  autoatendimento: 'Gestor e colaborador resolvem sozinhos. O RH aprova, [[o sistema efetiva]].',
  'dados-ia-plataforma': 'Dado para decidir, IA que trabalha dentro do sistema e [[nuvem segura]].',
}

/* Para quem cada frente fala primeiro. */
export const groupAudience: Record<GroupId, string[]> = {
  'pessoal-e-folha': ['DP', 'RH', 'Contabilidade'],
  'ponto-e-jornada': ['DP', 'Gestores', 'Jurídico'],
  'saude-e-seguranca': ['SESMT', 'RH', 'Jurídico'],
  talentos: ['RH', 'Gestores', 'Candidatos'],
  desenvolvimento: ['RH', 'Lideranças', 'Colaboradores'],
  autoatendimento: ['Colaboradores', 'Gestores', 'RH'],
  'dados-ia-plataforma': ['Diretoria de RH', 'Diretoria', 'TI'],
}

/* 11 · NATI. */
export const natiSlide = {
  title: 'A inteligência artificial que [[trabalha dentro do seu RH]].',
  lead: 'A NATI lê todos os módulos ao mesmo tempo. Responde ao colaborador, analisa para o gestor, alerta o RH e prepara a próxima ação. Executa só o que uma pessoa aprovou.',
  question: 'Por que as horas extras da Unidade Barueri subiram em agosto?',
}

/* 12 · Segurança e infraestrutura. */
export const seguranca = {
  title: 'Servidores dedicados na Oracle Cloud, [[com plano de contingência]].',
  lead: 'A operação de RH não pode parar. Por isso o sistema roda em servidores dedicados, administrados pelo time de infraestrutura da Natcorp, com cada camada protegida do navegador ao banco de dados.',
  items: [
    { title: 'Servidores dedicados na Oracle Cloud', text: 'Oracle Cloud Infrastructure dedicada à sua operação. Nada para instalar ou manter na empresa.' },
    { title: 'Três ambientes', text: 'Produção, homologação e contingência (recuperação de desastres), com espelhamento.' },
    { title: 'Dois backups por dia', text: 'Automatizados, guardados em ambiente isolado, com políticas de retenção e restauração.' },
    { title: 'Segurança em camadas', text: 'Criptografia, HTTPS, firewall de aplicação, dois fatores, VPN e login corporativo (SSO).' },
    { title: 'Cibersegurança 24 horas', text: 'Monitoramento contínuo por um time especializado, com auditoria de acessos.' },
    { title: 'LGPD por desenho', text: 'Perfis por empresa e filial, trilha de auditoria, anonimização e retenção conforme a política da empresa.' },
  ],
}

/* 13 · Conexões e performance. */
export const conexoes = {
  title: 'Conversa com o que a sua empresa já usa. E [[não fica lento]] quando ela cresce.',
  paths: [
    { title: 'Conexões prontas', text: 'Para o ERP, as operadoras de benefícios, os relógios de ponto e os sistemas que a empresa já tem.' },
    { title: 'Construtor pelo próprio usuário', text: 'O RH disponibiliza tabelas para enviar e receber dados, sem depender de TI nem de projeto.' },
    { title: 'Arquivos e eventos', text: 'Importação e exportação por arquivo e avisos automáticos para outros sistemas quando algo muda.' },
    { title: 'ERP no fechamento', text: 'Contabilização da folha por empresa, CNPJ e centro de custo, com as provisões, pronta para o ERP.' },
  ],
  numbers: [
    { value: '2.500', label: 'colaboradores calculados por minuto na folha' },
    { value: '3', label: 'datacenters em redundância, com plano de contingência' },
    { value: '120+', label: 'idiomas disponíveis na plataforma' },
  ],
  platforms: ['Computador', 'Tablet', 'Celular', 'WhatsApp', 'Microsoft Teams'],
}

/* 14 · Resultados. */
export const resultados = {
  title: 'Menos operação, menos custo, [[mais retorno]]. Em números.',
  /* Resultados observados na operação de clientes (material comercial "Produtividade de RH"). */
  gains: [
    { label: 'Fechamento da folha', pct: 80, note: 'até 80% mais rápido' },
    { label: 'Tratamento do ponto', pct: 75, note: '75% menos tempo' },
    { label: 'Dúvidas de colaboradores', pct: 70, note: '70% menos chamados' },
    { label: 'Gestão de benefícios', pct: 65, note: '65% mais eficiente' },
  ],
  roi: {
    title: 'ROI',
    text: 'Menos horas de operação, menos sistemas para manter, menos multa e passivo. O retorno aparece no primeiro fechamento.',
  },
  roes: {
    title: 'ROES',
    text: 'Retorno na experiência do colaborador: resposta em segundos, gestor autônomo, admissão sem papel e um RH com tempo para as pessoas.',
  },
  source: 'Resultados observados na operação de clientes Natcorp (material comercial "Gestão otimizada" e "Produtividade de RH").',
}

/* 15 · Para cada cadeira na mesa. */
export const cadeiras = {
  title: 'Do C-Level ao estagiário, [[cada um ganha]] algo diferente.',
}

/* 16 · Comparativo. */
export const comparativo = {
  title: 'Sem cobrar por usuário, por CNPJ [[nem por histórico]].',
  lead: 'O que vem incluído na Natcorp e o que costuma ser limite ou custo extra em outros sistemas.',
}

/* 17 · Modelo comercial. */
export const comercial = {
  title: 'Modular, em nuvem, [[pelo número de colaboradores]].',
  pillars: [
    { kicker: 'Modular', title: 'Contrate o que a sua operação precisa.', text: 'Módulos nativos, todos na mesma base. Folha, ponto, eSocial, talentos, SESMT e NATI conversando desde o primeiro dia.' },
    { kicker: 'SaaS em nuvem', title: 'Nada para instalar na empresa.', text: 'Produção, homologação e contingência em servidores dedicados na Oracle Cloud, monitorados 24 horas pela Natcorp.' },
    { kicker: 'Por colaborador', title: 'Um valor que acompanha o tamanho da empresa.', text: 'Contratou, abriu uma filial, incorporou uma empresa? A conta segue a mesma lógica. Simples de prever.' },
  ],
  included: [
    'Usuários ilimitados, em produção e homologação',
    'CNPJs e sindicatos ilimitados na mesma base',
    'Histórico ilimitado, migrado sem limite de anos',
    'Nuvem Oracle com três ambientes e dois backups por dia',
    'NATI integrada ao sistema, ao WhatsApp e ao Teams',
    'Suporte por chamados, com prazos e histórico',
  ],
}

/* 18 · Implantação e acompanhamento. */
export const implantacao = {
  title: 'Todo o histórico da empresa entra. [[O time da Natcorp fica]].',
  steps: [
    { title: 'Planejamento', text: 'Por empresa, filial e convenção, com o calendário de fechamento de cada uma.' },
    { title: 'Migração do histórico', text: 'Toda a trajetória de cada colaborador, sem limite de anos. Nada fica para trás.' },
    { title: 'Homologação', text: 'Folha nova em paralelo com a atual até bater, em ambiente próprio.' },
    { title: 'Treinamento', text: 'Equipes da matriz e das unidades preparadas antes de entrar em produção.' },
    { title: 'Produção e suporte', text: 'Central de chamados com prazos, histórico e controle de qualidade do atendimento.' },
  ],
  services: ['Implantação', 'Migração de dados', 'Treinamento', 'Suporte por chamados', 'BPO de folha', 'Atualização legal contínua'],
  proximity: 'Acompanhamento próximo, atenção e agilidade de resposta. Um time que conhece a sua operação pelo nome.',
}

/* 19 · Quem confia. */
export const confianca = {
  title: 'Quem leva a gestão de pessoas a sério [[já escolheu]].',
  /* Uma seleção dos clientes citados no material oficial (content/recognition.ts traz a lista completa). */
  clients: [
    'Hospital das Clínicas · FMUSP',
    'InCor · HCFMUSP',
    'Instituto do Câncer do Estado de São Paulo',
    'Fundação Zerbini',
    'Stefanini Group',
    'Abril',
    'Orbitall Payments',
    'Leadec',
    'Prevcom',
    'Saque e Pague',
    'Topaz',
    'Scala',
    'Haus',
    'Gauge',
    'Teccloud',
    'Real Food Alimentação',
    'Logbank',
    'Redeflex',
  ],
}

/* 20 · O custo de esperar. */
export const espera = {
  title: 'Cada mês sem integração tem um preço. [[Ele só não aparece na fatura]].',
  items: [
    { title: 'Mais um fechamento na mão.', text: 'Horas de conferência, redigitação e cobrança de pendências por e-mail. Todo mês, de novo.' },
    { title: 'Mais um mês de dado pessoal em planilha.', text: 'Salário, CPF e atestado circulando fora do sistema. Um risco de LGPD que ninguém contabiliza.' },
    { title: 'Mais uma decisão sem dado.', text: 'Turnover, headcount e custo por centro respondidos de memória para a diretoria.' },
    { title: 'Mais um talento esperando resposta.', text: 'Dias para uma admissão, uma promoção ou uma dúvida simples. O candidato e o colaborador percebem.' },
  ],
  punch: 'Enquanto isso, quem já decidiu fecha a folha até 80% mais rápido e responde ao colaborador em segundos.',
}

/* 21 · Próximos passos. */
export const proximos = {
  title: 'Três passos. [[Nenhuma surpresa]] depois.',
  steps: [
    { title: 'Demonstração com os seus dados', text: 'Você mostra a operação: empresas, unidades, convenções, volumes. A gente mostra o sistema resolvendo cada ponto.', when: 'Semana 1' },
    { title: 'Proposta modular', text: 'Os módulos da sua operação e o valor calculado pelo número de colaboradores. Sem letra pequena.', when: 'Semana 2' },
    { title: 'Implantação com o histórico completo', text: 'Planejamento por empresa e filial, migração, homologação em paralelo e treinamento antes de entrar em produção.', when: 'A partir do aceite' },
  ],
  ask: {
    title: 'O que precisamos de você',
    items: ['45 minutos com quem decide e quem opera', 'A realidade da sua operação: empresas, unidades, convenções e volumes', 'Os três processos que mais doem hoje'],
  },
}

/* 22 · Contato. */
export const contato = {
  title: 'A transformação que seu RH precisa [[começa com uma conversa]].',
  lead: 'Agende uma demonstração guiada pela realidade da sua empresa. Sem compromisso e sem letra miúda.',
}

/* Notas do apresentador, por slide (tecla N). */
export const notes: Record<string, string[]> = {
  capa: [
    'Abra com a promessa: transformação digital do RH, de verdade. Menos operação manual, menos custo, mais dado para decidir.',
    'Pergunte quem está na sala (RH, financeiro, tecnologia) e ajuste o tempo em cada bloco.',
  ],
  momento: [
    'O RH que lidera o negócio já opera com dados, IA e autonomia. O objetivo aqui é criar urgência sem alarmismo.',
    'Feche com a frase: liderar ou correr atrás.',
  ],
  'dia-no-rh': [
    'Peça para a plateia apontar qual dessas horas é a pior na empresa deles. A conversa começa aí.',
    'Cada momento tem a dor e a resposta: toque no horário para trocar. O slide passa sozinho até alguém tocar.',
  ],
  fechamento: [
    'O número que muda a conversa: 10.000 colaboradores em cerca de quatro minutos, com o ponto já apurado e 100% auditado.',
    'Pergunte quantas horas o fechamento leva hoje e quantas pessoas ficam nele.',
  ],
  jornada: [
    'Conte a história de Ana em quatro fases. Toque nas fases para avançar; o slide também passa sozinho.',
    'Fase 1: Marcos abre a requisição no meio da fábrica, pelo celular. Fase 2: Ana preenche os próprios dados, o exame cai na agenda do médico e o contrato é assinado no celular; Beatriz confere em uma tela. Fase 3: na portaria, ponto por reconhecimento facial, EPIs separados e trilha de treinamento agendada. Fase 4: férias e holerite no portal, Paulo fecha 10.000 folhas em quatro minutos e, um ano depois, o mapa de sucessão aponta para Ana.',
    'Feche com o hub: uma confirmação, sete atualizações. É o argumento da base única.',
    'Os módulos de cada fase são clicáveis: se perguntarem o detalhe, abra a página do módulo e volte.',
  ],
  modulos: [
    'Este é o mapa do sistema: sete frentes, mais de 30 módulos, cada um com a sua página nesta apresentação.',
    'Pergunte por onde eles querem começar e clique no módulo. A página mostra o que faz, o processo passo a passo e os números.',
    'Esc volta para este slide. A tecla M abre a lista de módulos de qualquer lugar da apresentação.',
  ],
  portais: [
    'Três portais e o NatPonto sobre a mesma base. O RH deixa de ser o balcão de perguntas.',
    'O celular ao lado troca de tela sozinho: início, reconhecimento facial e a marcação confirmada.',
  ],
  'antes-e-depois': [
    'Deixe o "Hoje" na tela por alguns segundos, depois alterne para "Com a Natcorp". O contraste faz o trabalho.',
    'Peça para a plateia escolher a linha que mais dói.',
  ],
  'nati-canais': [
    'A NATI no WhatsApp e no Teams responde ao colaborador onde ele já está. Para o RH, ela avisa antes: vencimentos, desvios, prazos.',
    'Executa só o que uma pessoa aprovou. Isso tranquiliza quem tem medo de automação.',
  ],
  analytics: [
    'O painel ao lado é o Painel do Operador de verdade, com indicadores de Medicina Ocupacional. Tudo vem dos módulos, sem exportar.',
    '3.500 telas, 1.800 relatórios, 900 gráficos: o usuário monta o que precisa, sem TI.',
  ],
  custo: [
    'Convide a plateia a reconhecer a própria rotina: quantos sistemas, quantas planilhas, quantas horas por fechamento.',
    'A cena "hoje" é ilustrativa. Pergunte quantas versões da planilha de turnover existem na empresa.',
  ],
  resposta: [
    'Posicionamento: HR Tech brasileira, 35 anos, uma única especialidade. DP, RH e SESMT na mesma base.',
    'Os três números são a prova de solidez: tempo de mercado, abrangência e escala.',
  ],
  plataforma: [
    'As sete frentes são a forma oficial de apresentar os módulos. Um cadastro, uma base, uma experiência.',
    'Aqui você pode acelerar ou aprofundar nas frentes seguintes conforme o perfil da plateia.',
  ],
  'pessoal-e-folha': ['Para CFO e DP: a folha fecha com o ponto apurado, o eSocial acompanhado e a contabilização pronta para o ERP.', '2.500 colaboradores por minuto e 100% da folha auditada pela IA.'],
  'ponto-e-jornada': ['NatPonto com reconhecimento facial e geolocalização; marcação offline sincroniza depois.', 'Abono com workflow: o gestor aprova no celular e a folha recebe a hora certa.'],
  'saude-e-seguranca': ['SESMT dentro do sistema de RH: ASO, PCMSO, PGR, PPP e EPIs na mesma base da folha.', 'S-2210 enviado automaticamente no prazo. Menos risco, menos multa.'],
  talentos: ['Da requisição da vaga à admissão sem papel, em um fluxo só. O colaborador é cadastrado uma vez.', 'Quadro de vagas com a marca da empresa e portal do candidato.'],
  desenvolvimento: ['Avaliações de 90° a 360°, metas com bônus e PLR, treinamento com orçamento e sucessão. Tudo na mesma base da folha.'],
  autoatendimento: ['Gestor e colaborador resolvem sozinhos. O RH aprova, o sistema efetiva: aprovou, efetivou.', '70% menos chamados de dúvidas com o autoatendimento e a NATI.'],
  'dados-ia-plataforma': ['People Analytics e BI sem depender de TI: o próprio usuário cruza, filtra e exporta.', 'Painel pronto para a diretoria, com dados de todos os módulos.'],
  nati: ['A NATI não é um chat: lê todos os módulos, cruza folha com ponto e saúde, e prepara a ação. Executa só o que uma pessoa aprovou.', 'Disponível no sistema, no WhatsApp e no Teams, 24 horas.'],
  seguranca: ['Para o CTO: servidores dedicados na Oracle Cloud, três ambientes, dois backups por dia, monitoramento 24 horas e LGPD por desenho.', 'Nada para instalar ou manter na empresa.'],
  conexoes: ['Quatro caminhos de conexão e contabilização pronta para o ERP. Sem planilha no meio do caminho.', 'Performance: 2.500 colaboradores por minuto, filiais e usuários a mais não deixam o sistema lento.'],
  resultados: ['Os números vêm da operação de clientes. Traduza para a realidade da plateia: horas por fechamento, chamados por mês, sistemas mantidos.', 'ROI é o retorno financeiro; ROES é o retorno na experiência do colaborador.'],
  cadeiras: ['Fale diretamente com cada cadeira presente. CHRO: lugar na mesa. CFO: custo previsível. CTO: um sistema, nuvem segura. RH e DP: fim do retrabalho.'],
  comparativo: ['O que outros sistemas cobram à parte ou limitam: usuário, CNPJ, histórico, conexões. Aqui vem incluído.', 'Desenvolvimento 100% Natcorp, sem depender de terceiros.'],
  comercial: ['Três decisões simples: modular, SaaS em nuvem e pelo número de colaboradores. Nenhuma surpresa depois.'],
  implantacao: ['Dois pontos que travam a troca de sistema e aqui já fazem parte: histórico completo e ERP conectado.', 'Proximidade é pilar da marca: um time que conhece a operação pelo nome.'],
  confianca: ['Clientes e reconhecimentos do material oficial. Mais de 500 mil colaboradores administrados.'],
  espera: ['Custo de esperar: cada mês sem integração custa horas, risco e decisões sem dado. Feche com a comparação com quem já decidiu.'],
  proximos: ['Proponha a demonstração com os dados da própria empresa e marque a data ainda na reunião.'],
  contato: ['Deixe o contato na tela e pergunte: qual é o melhor dia para a demonstração?'],
}
