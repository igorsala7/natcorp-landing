import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'saude-e-ciencias-biologicas',
  name: 'Saúde e Ciências Biológicas',
  tagline: 'O RH que não para, [[plantão após plantão]], do pronto-socorro ao laboratório.',
  summary:
    'Hospitais, clínicas, laboratórios e indústria farmacêutica funcionam 24 horas, com escalas 12x36, trocas de plantão e profissionais em mais de um vínculo. A Natcorp coloca ponto, folha, SESMT e treinamentos da NR-32 na mesma base, por unidade e setor, para o RH fechar o mês sem passivo.',
  seo: {
    title: 'RH para hospitais e saúde: plantões 12x36 e NR-32 | Natcorp',
    description:
      'RH para hospitais, clínicas, laboratórios e farmacêuticas: plantões 12x36, múltiplos vínculos, NR-32, PCMSO, CAT de perfurocortante e folha com plantões extras.',
  },
  context: [
    'Na saúde, a operação não fecha. UTI, pronto-socorro, centro cirúrgico e laboratório funcionam 24 horas, em escalas 12x36 e plantões que mudam de mão no corredor. O mesmo médico ou enfermeiro pode ter dois vínculos na instituição, atuar em mais de uma unidade ou entrar como cooperado ou PJ. Cada setor tem sua escala, seu adicional e seu risco, e a troca de plantão combinada na hora precisa chegar certa à folha.',
    'O RH responde por muito mais que a folha. A NR-32 exige treinamentos com validade controlada, o PCMSO pede ASO por função e risco, a vacinação precisa estar em dia e um acidente com perfurocortante exige CAT em prazo curto. Absenteísmo alto e residentes, estagiários e terceirizados ao lado do quadro efetivo completam o cenário. Em planilha, o adicional sai errado, o treinamento vence sem aviso e a CAT atrasa.',
  ],
  facts: [
    { value: '12x36', label: 'plantões por setor, trocas com aceite digital e adicional noturno apurados' },
    { value: 'NR-32', label: 'treinamentos com validade, PCMSO, vacinação e CAT de perfurocortante no SESMT' },
    { value: 'Múltiplos vínculos', label: 'o mesmo profissional em dois vínculos ou unidades, cada um com sua regra' },
  ],
  pains: [
    { icon: 'clock', title: 'Plantões 12x36, trocas e plantões extras sem apuração', text: 'Escalas por setor, trocas combinadas no corredor e plantões extras cobertos na hora. Sem apuração automática, o adicional noturno e a hora extra chegam errados à folha ou viram reclamação trabalhista.' },
    { icon: 'layers', title: 'O mesmo profissional em dois vínculos ou unidades', text: 'Médicos e enfermeiros com dois contratos na instituição, cooperados e PJs ao lado do quadro CLT. Cada vínculo tem sua jornada, seu sindicato e seu cálculo, e a folha precisa tratar todos de uma vez.' },
    { icon: 'heart-pulse', title: 'NR-32, exames e vacinação com validade que vence', text: 'Treinamentos da NR-32, ASO por risco, vacinação e campanhas têm prazo. Quando o controle está em planilha, o vencimento aparece na fiscalização ou na auditoria de acreditação, não antes.' },
    { icon: 'alert-triangle', title: 'Perfurocortante, CAT e eSocial contra o relógio', text: 'Um acidente com agulha exige CAT e envio ao eSocial em prazo curto. Sem fluxo integrado, o SESMT depende do DP para transmitir, e o prazo passa enquanto a informação circula por e-mail.' },
    { icon: 'users', title: 'Absenteísmo alto e residentes, estagiários e terceiros', text: 'Atestados, afastamentos e faltas pesam em quem cobre o plantão. Residentes, estagiários, cooperados e terceirizados precisam de cadastro, acesso e controle sem entrar na folha como CLT.' },
    { icon: 'smartphone', title: 'Ponto por unidade, em um tablet compartilhado', text: 'A equipe do setor entra e sai em horários diferentes, e ninguém pode ficar com o celular na mão no centro cirúrgico. O ponto precisa de um aparelho fixo, rápido, que identifique cada pessoa.' },
  ],
  answers: [
    {
      pain: 'Plantões',
      title: 'Escala 12x36 por setor, troca de plantão com aceite e folha apurada',
      text: 'O Ponto Eletrônico trata escalas 12x36, plantões diurnos, noturnos e rotativos e sobreaviso, com limites legais e sindicais. O gestor disponibiliza plantões, o profissional aceita ou oferece para troca pelo app e assina o termo de aceite. Adicional noturno, DSR e horas extras seguem para a folha sem digitação.',
      modules: ['ponto-eletronico', 'natponto', 'requisicoes-com-workflow', 'folha-de-pagamento'],
    },
    {
      pain: 'Múltiplos vínculos',
      title: 'Uma folha para todos os vínculos, sindicatos e unidades',
      text: 'A Folha de Pagamento trata vários vínculos e acordos sindicais na mesma empresa, cada um com suas regras, sem limite de CNPJs. Serviços de terceiros e autônomos entram por requisição, e o cargo carrega periculosidade e progressão parametrizadas. A NATI confere proventos e descontos antes do fechamento.',
      modules: ['folha-de-pagamento', 'administracao-de-pessoal', 'cargos-e-salarios', 'nati'],
    },
    {
      pain: 'NR-32 e exames',
      title: 'PCMSO por risco, ASO digital, vacinação e treinamentos com validade',
      text: 'O PGR mapeia os riscos biológicos de cada setor, o GHE agrupa quem tem exposição semelhante e o PCMSO gera o cronograma de exames sozinho, com alerta de vencimento do ASO. Campanhas de vacinação ficam no mesmo ambiente. Os treinamentos da NR-32 têm validade controlada e entram nos checklists do SESMT.',
      modules: ['medicina-ocupacional', 'seguranca-do-trabalho', 'treinamento-e-desenvolvimento'],
    },
    {
      pain: 'CAT e eSocial',
      title: 'CAT aberta em poucos passos, S-2210 em até 24 horas',
      text: 'O acidente com perfurocortante é registrado no SESMT, a CAT é aberta em poucos passos e o evento S-2210 sai automaticamente em até 24 horas, depois do validador de divergências. O S-2220 nasce do ASO e o S-2240 do PGR. CIPA e brigadistas são geridos no mesmo módulo, com eleição digital.',
      modules: ['seguranca-do-trabalho', 'esocial', 'medicina-ocupacional'],
    },
    {
      pain: 'Absenteísmo',
      title: 'Atestado pelo app, painel por CID e terceiros fora da folha CLT',
      text: 'O profissional envia o atestado pelo app, o sistema lê a imagem e registra o CID, e o afastamento reflete no ponto, na folha e no eSocial. O painel de absenteísmo mostra padrões por área e período. Cooperados, PJs e terceiros são cadastrados como serviços de terceiros e autônomos por requisição, com acesso por perfil.',
      modules: ['medicina-ocupacional', 'requisicoes-com-workflow', 'people-analytics', 'administracao-de-pessoal'],
    },
    {
      pain: 'Ponto na unidade',
      title: 'NatPonto multiusuário no tablet do setor, com reconhecimento facial',
      text: 'Um tablet fixo no posto de enfermagem atende a equipe inteira no modo multiusuário, cada pessoa identificada pelo rosto, sem celular na mão. Funciona sem internet e sincroniza depois. Quem atende em domicílio marca no próprio celular, com o local registrado. A marcação chega em segundos ao Ponto Eletrônico.',
      modules: ['natponto', 'ponto-eletronico', 'portais'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Plantões extras, adicional noturno e insalubridade apurados do ponto, com vários vínculos e sindicatos na mesma folha.',
    'administracao-de-pessoal': 'Posições por unidade e setor, custo dos plantões no orçamento e cadastro de autônomos e terceiros por requisição.',
    'cargos-e-salarios': 'Ficha do cargo com periculosidade, cargo de confiança e progressão automática, e piso por convenção de cada categoria.',
    'gestao-de-beneficios': 'Plano de saúde com coparticipação e fatura da operadora conferida, alimentação e vale-transporte por unidade.',
    natpay: 'Adiantamento pelo WhatsApp com limite pelos dias trabalhados no ponto, para quem depende do plantão extra.',
    esocial: 'S-2210 da CAT de perfurocortante em até 24 horas, S-2220 do ASO e S-2240 dos riscos biológicos do PGR.',
    'juridico-trabalhista': 'Espelhos de plantão, termos de troca e histórico de adicionais prontos para responder ações de jornada.',
    'ponto-eletronico': 'Escalas 12x36 por setor, plantões rotativos, sobreaviso, troca de plantão com aceite e adicional noturno apurado.',
    natponto: 'Tablet multiusuário no posto de cada unidade, com reconhecimento facial, e celular para o atendimento domiciliar.',
    'medicina-ocupacional': 'PCMSO por risco biológico, ASO digital com alerta de vencimento, atestados pelo app e campanhas de vacinação.',
    'seguranca-do-trabalho': 'PGR por setor, EPIs com CA validado, CAT de perfurocortante com S-2210, CIPA e brigadistas no mesmo módulo.',
    'recrutamento-e-selecao': 'Processos seletivos por unidade e categoria, com filtros de formação e experiência definidos no cargo.',
    'quadro-de-vagas': 'Vagas de enfermagem, técnicas e administrativas publicadas com a marca da instituição, candidatura pelo celular.',
    'admissao-digital': 'Admissão pelo celular, com documentos e contrato assinados, e cadastro criado na folha, no ponto e no SESMT.',
    onboarding: 'Boas-vindas com protocolos do setor, políticas de segurança e trilha de entrada da NR-32 desde o primeiro dia.',
    offboarding: 'Desligamento pelo workflow, com saldo de banco de horas dos plantões calculado e acessos bloqueados na mesma tela.',
    'avaliacoes-e-feedbacks': 'Avaliação de residentes e equipes por setor, feedback do coordenador pelo celular e pesquisa de clima anônima.',
    'metas-e-resultados': 'Metas e PLR por unidade, setor e categoria, com regras para admitidos, desligados e afastados no ciclo.',
    'treinamento-e-desenvolvimento': 'Treinamentos da NR-32 e certificações com validade controlada, alerta de vencimento e checklist do SESMT.',
    'carreira-e-sucessao': 'Sucessores para coordenação de enfermagem e chefias de setor, com prontidão e risco de perda mapeados.',
    portais: 'O profissional vê escala, plantões, espelho e holerite no celular; o coordenador aprova trocas e abonos.',
    'requisicoes-com-workflow': 'Troca de plantão, hora extra, atestado, exame, acidente e cadastro de terceiros com alçadas por unidade.',
    'chamado-interno': 'Dúvidas de plantão, adicional e escala registradas com prazo, e a NATI responde o que é rotina.',
    'blog-corporativo': 'Campanhas de vacinação, protocolos e comunicados por unidade na timeline que a equipe vê no celular.',
    'assinatura-eletronica': 'Termos de aceite de plantão, espelhos de ponto e fichas de EPI assinados na tela, com validade jurídica.',
    ged: 'Documentos de admissão, registros profissionais e fichas de EPI por pessoa, com acesso restrito por perfil.',
    'people-analytics': 'Absenteísmo, horas extras e plantões extras cruzados por unidade, setor e categoria, sem depender de TI.',
    'business-intelligence': 'Painéis de absenteísmo, escalas e custo de pessoal por unidade e setor, com alerta quando sai da faixa.',
    nati: 'Responde a dúvidas de plantão e holerite no WhatsApp, 24 horas, e confere adicionais na folha antes do fechamento.',
    'conexao-com-outros-sistemas': 'Conecta com catracas, relógios de ponto, ERP do hospital e operadoras de benefícios sem redigitar.',
    'infraestrutura-e-seguranca': 'Nuvem com contingência para a operação 24 horas, dados de saúde criptografados e acesso por perfil e unidade.',
  },
  spotlight: ['ponto-eletronico', 'natponto', 'folha-de-pagamento', 'medicina-ocupacional', 'seguranca-do-trabalho', 'esocial'],
  compliance: [
    'NR-32: segurança e saúde em serviços de saúde, com treinamentos de validade controlada',
    'Escala 12x36 e adicional noturno conforme a CLT e as convenções das categorias da saúde',
    'PCMSO e ASO por risco, com o evento S-2220 do eSocial',
    'CAT de acidentes com perfurocortantes e S-2210 em até 24 horas',
    'Ponto eletrônico conforme a Portaria 671, com arquivos AFD e AEJ',
    'LGPD no tratamento de dados de saúde dos profissionais',
  ],
  personas: [
    { role: 'Coordenador de enfermagem', text: 'Monta a escala do setor, libera plantões, aprova trocas e abonos pelo celular e vê quem está de atestado antes de o turno começar.' },
    { role: 'SESMT do hospital', text: 'Abre a CAT do perfurocortante, acompanha o PCMSO e os treinamentos da NR-32 e envia S-2210 e S-2220 sem depender do DP.' },
    { role: 'Técnico de enfermagem', text: 'Bate o ponto no tablet do posto, aceita plantão extra pelo app, envia o atestado pela foto e pergunta à NATI sobre o adicional.' },
  ],
  faq: [
    {
      q: 'O sistema trata o mesmo profissional com dois vínculos na instituição?',
      a: 'Sim. A Folha de Pagamento trata vários vínculos trabalhistas e acordos sindicais na mesma empresa, cada um com suas regras de jornada e cálculo. O Ponto Eletrônico apura cada vínculo pela sua escala, e a NATI confere adicionais e descontos antes do fechamento.',
    },
    {
      q: 'Como funciona a troca de plantão?',
      a: 'O gestor disponibiliza os plantões no sistema. O profissional aceita ou oferece para troca pelo app e assina o termo de aceite eletronicamente, com trilha de auditoria. A apuração aplica a escala nova, e o adicional noturno segue para a folha.',
    },
    {
      q: 'Dá para controlar os treinamentos da NR-32 e o vencimento dos ASOs?',
      a: 'Sim. Treinamentos obrigatórios têm validade controlada e alerta de vencimento para o colaborador e o gestor, e entram nos checklists de NR do SESMT. O PCMSO gera o cronograma de exames a partir do risco de cada função e avisa antes de o ASO vencer.',
    },
    {
      q: 'O que acontece quando há um acidente com perfurocortante?',
      a: 'O SESMT registra o acidente e abre a CAT em poucos passos, pelo computador ou pelo tablet. O evento S-2210 passa pelo validador de divergências e é enviado ao eSocial em até 24 horas. Se houver afastamento, ele reflete no ponto e na folha.',
    },
  ],
  visual: 'medicine',
  related: ['servicos-ao-consumidor', 'setor-publico-e-social'],
}

export default page
