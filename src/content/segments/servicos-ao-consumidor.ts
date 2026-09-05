import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'servicos-ao-consumidor',
  name: 'Serviços ao Consumidor',
  ctaContext: 'de serviços ao consumidor',
  tagline: 'Atendimento em escala e equipe remota: o RH que responde [[a qualquer hora]].',
  summary:
    'Atendimento, serviços, hospitalidade e educação vivem de gente: escalas 6x1, home office, alto giro e metas de atendimento. A Natcorp recruta em volume, admite pelo celular, apura o ponto remoto com local e hora, paga a remuneração variável e deixa a NATI atender a equipe fora do horário.',
  seo: {
    title: 'RH para serviços ao consumidor: escalas e giro | Natcorp',
    description:
      'RH para atendimento, serviços, hospitalidade e educação: escalas 6x1, ponto remoto com geolocalização, recrutamento em volume, NR-17 e NATI no WhatsApp.',
  },
  context: [
    'Em serviços ao consumidor, o produto é a pessoa que atende. Centrais de atendimento operam em turnos e escalas 6x1, parte da equipe em casa, parte no site. Hotéis, restaurantes e escolas têm picos, temporários, jornada intermitente e supervisores com dezenas de liderados. O turnover é alto e o recrutamento nunca para.',
    'O RH precisa contratar em volume, admitir em dias, apurar o ponto de quem está em casa e de quem está no balcão, controlar absenteísmo e atestados, pagar remuneração variável por meta de atendimento e cuidar da ergonomia e da saúde mental exigidas pela NR-17. Quando cada gestor aprova por e-mail, a equipe fica sem resposta e a folha fecha com erro.',
  ],
  facts: [
    { value: 'Escala 6x1', label: 'turnos e folgas apurados pela convenção de cada categoria, com banco de horas' },
    { value: 'Home office e híbrido', label: 'ponto remoto com rosto, local e hora, no celular de quem atende de casa' },
    { value: 'Alto giro', label: 'recrutamento em volume com banco de talentos e admissão pelo celular em dias' },
  ],
  pains: [
    { icon: 'refresh', title: 'Turnover alto e recrutamento que nunca termina', text: 'A operação abre dezenas de vagas por mês para repor quem saiu. Cada processo repete triagem, entrevista e documentos do zero, e o gestor de equipe recebe gente sem cadastro no ponto.' },
    { icon: 'calendar', title: 'Escalas 6x1, turnos e folgas que mudam toda semana', text: 'A escala muda por semana, a folga cai em dia diferente para cada um e o intermitente é convocado por demanda. Sem apuração automática, DSR, adicional noturno e hora extra saem errados.' },
    { icon: 'map-pin', title: 'Ponto de quem trabalha em casa ou no híbrido', text: 'Parte da equipe atende de casa, parte no site, parte alterna. A empresa precisa provar jornada e intervalo de quem está remoto, sem controlar a pessoa nem perder a marcação.' },
    { icon: 'stethoscope', title: 'Absenteísmo, atestados e saúde mental na NR-17', text: 'Atestados chegam por foto no grupo do gestor. Afastamentos por ansiedade e LER se repetem numa operação e ninguém cruza com o posto de trabalho. A NR-17 exige pausas e ergonomia comprovadas.' },
    { icon: 'target', title: 'Metas de atendimento e remuneração variável', text: 'Tempo de atendimento, satisfação e conversão viram bônus por equipe e por pessoa, com regra para quem entrou, saiu ou se afastou no mês. Em planilha, o pagamento atrasa e a equipe desconfia do cálculo.' },
    { icon: 'smartphone', title: 'Dezenas de gestores aprovando e a equipe sem resposta', text: 'Cada supervisor cuida de vinte pessoas e aprova troca de escala, abono e férias no intervalo. A dúvida de holerite chega às 22h, quando o RH já foi embora, e fica sem resposta até o dia seguinte.' },
  ],
  answers: [
    {
      pain: 'Turnover e vagas',
      title: 'Recrutamento em volume com banco de talentos e admissão pelo celular',
      text: 'A requisição de pessoal do gestor abre o processo seletivo com etapas, questionários e triagem automatizada. A NATI cruza o banco de talentos com a vaga e indica os candidatos aderentes. O aprovado faz a admissão pelo celular, assina o contrato e já nasce no ponto, na folha e no onboarding da operação.',
      modules: ['recrutamento-e-selecao', 'quadro-de-vagas', 'admissao-digital', 'onboarding'],
    },
    {
      pain: 'Escalas e turnos',
      title: 'Escala 6x1, plantões com aceite digital e apuração direto na folha',
      text: 'O Ponto Eletrônico trata escalas de 8h, 6h e 12x36, plantões diurnos, noturnos e rotativos, folgas variáveis, DSR e adicional noturno pela regra de cada convenção. O gestor disponibiliza plantões e o colaborador aceita ou oferece troca pelo app, com termo assinado. Horas extras e faltas viram eventos de folha sem digitação.',
      modules: ['ponto-eletronico', 'portais', 'folha-de-pagamento', 'assinatura-eletronica'],
    },
    {
      pain: 'Ponto remoto',
      title: 'NatPonto no celular de quem atende de casa, com rosto, local e hora',
      text: 'O colaborador marca o ponto no próprio celular, com reconhecimento facial e o endereço da marcação registrado. Funciona sem internet e sincroniza depois. A marcação chega em segundos ao Ponto Eletrônico, o gestor vê entradas e saídas no mesmo dia e o espelho de ponto assinado digitalmente vale como prova.',
      modules: ['natponto', 'ponto-eletronico', 'assinatura-eletronica'],
    },
    {
      pain: 'Atestados e NR-17',
      title: 'Atestado pelo app, absenteísmo por CID e laudos ergonômicos no mesmo lugar',
      text: 'O colaborador envia o atestado pelo app, o sistema lê a imagem, valida e registra o CID, e o afastamento reflete no ponto, na folha e no eSocial. O painel de absenteísmo cruza atestados por CID e área e aponta padrões ergonômicos. Laudos AEP e AET ficam versionados no SESMT, e a NATI sugere ações preventivas.',
      modules: ['medicina-ocupacional', 'seguranca-do-trabalho', 'requisicoes-com-workflow', 'nati'],
    },
    {
      pain: 'Remuneração variável',
      title: 'Metas de atendimento negociadas no portal e bônus calculado na folha',
      text: 'O ciclo define elegibilidade por filial, centro de custo e cargo e as regras para admitidos, desligados e afastados. O supervisor propõe metas de equipe e individuais, o atendente concorda no portal, a apuração exige feedback do gestor e o valor segue para a Folha de Pagamento com planilha de conferência.',
      modules: ['metas-e-resultados', 'avaliacoes-e-feedbacks', 'folha-de-pagamento'],
    },
    {
      pain: 'Gestores e NATI',
      title: 'Portal do Gestor no celular e a NATI respondendo à equipe fora do horário',
      text: 'Troca de escala, abono, férias e vaga são aprovados pelo celular, com alçada por operação e suplente na folga do supervisor. A NATI responde dúvidas de holerite, ponto e benefícios 24 horas por dia no WhatsApp, no Teams e no portal, e avisa o RH quando a mesma pergunta se repete. O que precisa de gente vira chamado com prazo.',
      modules: ['portais', 'requisicoes-com-workflow', 'nati', 'chamado-interno'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Escala 6x1, adicional noturno e bônus de atendimento na mesma folha, com sindicatos de várias categorias e CNPJs.',
    'administracao-de-pessoal': 'Headcount por operação, célula e turno, com reposição de turnover planejada no orçamento e alerta de desvio.',
    'cargos-e-salarios': 'Faixas de atendente, monitor e supervisor por operação, com requisitos do cargo filtrando a seleção em volume.',
    'gestao-de-beneficios': 'Vale-transporte por escala e cidade, alimentação e plano de saúde com elegibilidade por cargo e turno.',
    natpay: 'O atendente pede o adiantamento na madrugada, entre duas chamadas, e recebe por Pix: um motivo a mais para ficar.',
    esocial: 'Admissões e desligamentos em volume enviados no prazo, com afastamentos e S-2220 saindo dos dados do sistema.',
    'juridico-trabalhista': 'Marcações remotas, espelhos assinados e termos de aceite de escala como prova em ações de jornada e intervalo.',
    'ponto-eletronico': 'Escalas 6x1, turnos rotativos, folgas variáveis, DSR e intervalos apurados pela convenção, com AFD e AEJ.',
    natponto: 'Ponto no celular de quem atende de casa, com rosto e endereço, e tablet multiusuário na recepção ou no site.',
    'medicina-ocupacional': 'Atestado enviado pelo app com CID validado e painel de absenteísmo por operação para agir na NR-17.',
    'seguranca-do-trabalho': 'Laudos ergonômicos AEP e AET versionados, PGR por posto de atendimento e canal de denúncias ligado à CIPA.',
    'recrutamento-e-selecao': 'Processos em volume com etapas, questionários e triagem automatizada, e a NATI cruzando o banco de talentos.',
    'quadro-de-vagas': 'Vagas de atendimento, hotelaria e escola publicadas com a marca da empresa, candidatura pelo celular.',
    'admissao-digital': 'Admissão em dias, pelo celular, com o cadastro nascendo no ponto e na folha antes do primeiro turno.',
    onboarding: 'Script de atendimento, políticas e trilha de entrada no celular do novato, na operação ou em casa.',
    offboarding: 'Desligamentos frequentes com rescisão, banco de horas e bloqueio de acessos em uma tela, conferidos pela NATI.',
    'avaliacoes-e-feedbacks': 'Feedback do supervisor por monitoria registrado pelo celular e pesquisa de clima por operação, anonimizada.',
    'metas-e-resultados': 'Metas de atendimento por equipe e pessoa, regras para admitidos e desligados no mês e bônus enviado à folha.',
    'treinamento-e-desenvolvimento': 'Certificações de produto e atendimento com validade, turmas online e híbridas e trilha de novo produto.',
    'carreira-e-sucessao': 'Trilha de atendente a supervisor com prontidão, e risco de perda sinalizado antes do pedido de demissão.',
    portais: 'Portal do Gestor no celular de cada supervisor e Portal do Colaborador com escala, holerite e feedbacks.',
    'requisicoes-com-workflow': 'Troca de escala, abono, férias, atestado e vaga com alçadas por operação; na folga do supervisor, o suplente aprova.',
    'chamado-interno': 'Dúvidas que a NATI não resolve viram chamado com prioridade, prazo e fila do operador de RH.',
    'blog-corporativo': 'Campanhas, mudanças de script e comunicados de escala na timeline do portal, também para quem está em casa.',
    'assinatura-eletronica': 'Contrato, termo de aceite de escala e espelho de ponto assinados pelo celular, com validade jurídica.',
    ged: 'Documentos de admissão enviados pelo celular e guardados por pessoa, com acesso por operação e LGPD.',
    'people-analytics': 'Turnover, absenteísmo e atestados cruzados por operação, célula e turno com o botão Ações, sem TI.',
    'business-intelligence': 'Painéis de absenteísmo, horas extras e headcount por operação, com alerta por e-mail quando saem da faixa.',
    nati: 'Responde à equipe de madrugada pelo WhatsApp e pelo Teams e alerta o RH quando a mesma dúvida se repete.',
    'conexao-com-outros-sistemas': 'Login corporativo, catraca do site e plataforma de ensino conectados, com a folha contabilizada no ERP.',
    'infraestrutura-e-seguranca': 'Nuvem com contingência para a operação 24 horas, dois fatores no acesso remoto e trilha de auditoria.',
  },
  spotlight: ['recrutamento-e-selecao', 'ponto-eletronico', 'natponto', 'nati', 'portais', 'metas-e-resultados'],
  compliance: [
    'NR-17: ergonomia, pausas e laudos para teleatendimento e postos de trabalho',
    'Convenções coletivas de telemarketing, hotelaria, alimentação e ensino',
    'Ponto eletrônico conforme a Portaria 671, com AFD, AEJ e espelho assinado',
    'CLT: intervalos, DSR e adicional noturno em escalas 6x1 e turnos',
    'eSocial: admissões, desligamentos e S-2220 no prazo',
    'LGPD nos dados de localização, candidatos e saúde',
  ],
  personas: [
    { role: 'Supervisor de atendimento', text: 'Aprova troca de escala, abono e férias pelo celular no intervalo e vê quem faltou antes de abrir a operação.' },
    { role: 'RH de operação', text: 'Recruta em volume com banco de talentos, admite pelo celular e enxerga turnover e absenteísmo por célula.' },
    { role: 'Atendente em home office', text: 'Marca o ponto no celular, vê a escala e o holerite no portal e pergunta à NATI no WhatsApp a qualquer hora.' },
  ],
  faq: [
    {
      q: 'Como funciona o ponto de quem trabalha em home office?',
      a: 'Pelo NatPonto, no celular do colaborador. A marcação usa reconhecimento facial e geolocalização, com o endereço visível, e funciona sem internet. Ela chega em segundos ao Ponto Eletrônico, que aplica escala, intervalos e banco de horas. O espelho de ponto é assinado digitalmente e tem validade legal.',
    },
    {
      q: 'O sistema aguenta recrutar dezenas de vagas por mês?',
      a: 'Sim. A requisição aprovada abre o processo seletivo com etapas, questionários e triagem automatizada, com recrutador e prazo por vaga. Os currículos ficam no banco de talentos e a NATI indica os mais aderentes a cada nova vaga. O aprovado segue para a Admissão Digital sem repetir nada.',
    },
    {
      q: 'A NATI responde a equipe fora do horário do RH?',
      a: 'Sim. A NATI responde dúvidas de holerite, ponto, benefícios e políticas 24 horas por dia, pelo sistema, pelo WhatsApp e pelo Teams, com confidencialidade. O que exige uma pessoa vira chamado para o RH, e a NATI avisa quando a mesma dúvida se repete.',
    },
    {
      q: 'Dá para controlar atestados e absenteísmo por operação?',
      a: 'Sim. O atestado é enviado pelo app, validado por imagem e registrado com o CID. O afastamento reflete no ponto, na folha e no eSocial. O painel de absenteísmo cruza atestados por CID, área e período e aponta padrões ergonômicos, e a NATI sugere ações preventivas.',
    },
  ],
  visual: 'whatsapp',
  related: ['varejo', 'telecom'],
}

export default page
