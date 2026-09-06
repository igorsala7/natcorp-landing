import type { GroupId } from './modulePages/types'

/**
 * Apresentação executiva (/apresentacao): o roteiro comercial do sistema, slide a slide.
 * Segue a seção 14 do Manual de Identidade v1.2: um assunto por slide, até três números de
 * destaque, seção de produto em Azul Profundo, rodapé com símbolo e número do slide.
 * Os números vêm do material comercial da Natcorp (os mesmos usados no site).
 */

export const deckMeta = {
  edition: 'Apresentação executiva · 2026',
  title: 'A transformação que seu RH precisa.',
  subtitle:
    'Gestão completa para RH e Departamento Pessoal em um único sistema, com a NATI, a inteligência artificial que trabalha dentro dele.',
  audience: ['CEO', 'CHRO', 'CFO', 'CTO', 'Diretoria e gerência de RH', 'Analistas de RH e DP'],
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
  'pessoal-e-folha': ['CFO', 'DP', 'Contabilidade'],
  'ponto-e-jornada': ['DP', 'Gestores', 'Jurídico'],
  'saude-e-seguranca': ['SESMT', 'RH', 'Jurídico'],
  talentos: ['CHRO', 'RH', 'Gestores'],
  desenvolvimento: ['CHRO', 'RH', 'Lideranças'],
  autoatendimento: ['Colaboradores', 'Gestores', 'RH'],
  'dados-ia-plataforma': ['CEO', 'CHRO', 'CTO'],
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
  lead: 'Agende uma demonstração guiada pela realidade da sua empresa. Sem compromisso e sem letra miúda. Respondemos em até 1 dia útil.',
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
