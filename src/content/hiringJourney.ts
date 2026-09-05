/**
 * Jornada do colaborador contada como um exemplo do dia a dia, em uma indústria.
 * As 24 etapas e as 4 fases seguem o fluxo completo da Natcorp: da requisição da vaga,
 * passando pela admissão digital e pelo primeiro dia, até a promoção ou o desligamento.
 * Empresa, pessoas, datas e valores são fictícios. As etapas e o que o sistema faz em cada uma são reais.
 */

import { journeyPath, paths } from './site'

export type PhaseNumber = 1 | 2 | 3 | 4

export interface JourneyPhase {
  n: PhaseNumber
  title: string
  subtitle: string
  /** Intervalo da história coberto pela fase. */
  range: string
  steps: [number, number]
}

export interface JourneyModuleRef {
  slug: string
  /** O que o módulo faz nesta etapa (curto). */
  note: string
}

/** Quem executa a etapa. Define a raia na visão prática. */
export type Actor = 'gestor' | 'candidato' | 'colaborador' | 'rh' | 'sesmt' | 'sistema'

export interface ActorMeta {
  key: Actor
  label: string
  short: string
  /** Cor de identificação da raia (tokens da marca ou tons derivados). */
  color: string
}

export const actors: ActorMeta[] = [
  { key: 'gestor', label: 'Gestor', short: 'Gestor', color: '#511C76' },
  { key: 'candidato', label: 'Candidato', short: 'Candidato', color: '#C95788' },
  { key: 'colaborador', label: 'Colaborador', short: 'Colaborador', color: '#9A408A' },
  { key: 'rh', label: 'Recursos Humanos', short: 'RH', color: '#2C1A63' },
  { key: 'sesmt', label: 'SESMT', short: 'SESMT', color: '#1F6B45' },
  { key: 'sistema', label: 'Sistema e NATI', short: 'Sistema', color: '#B06A1E' },
]

export const actorMeta = (key: Actor) => actors.find((a) => a.key === key)!

export type CastKey = 'ana' | 'marcos' | 'juliana' | 'claudia' | 'beatriz' | 'henrique' | 'rafael' | 'paulo' | 'nati'

export interface CastMember {
  key: CastKey
  name: string
  role: string
  initials: string
  hero?: boolean
}

export type VisualKey =
  | 'approval'
  | 'process'
  | 'jobboard'
  | 'candidate'
  | 'talent'
  | 'sla'
  | 'admission'
  | 'dataform'
  | 'benefits'
  | 'ged'
  | 'aso'
  | 'contract'
  | 'confirm'
  | 'portal'
  | 'onboarding'
  | 'natponto'
  | 'epi'
  | 'training'
  | 'evaluation'
  | 'request'
  | 'movement'
  | 'nati'
  | 'payroll'
  | 'succession'

export interface JourneyStep {
  id: string
  n: number
  phase: PhaseNumber
  /** Nome oficial da etapa no fluxo Natcorp. */
  name: string
  /** Descrição oficial da etapa, em uma linha. */
  official: string
  /** Quem executa. */
  actor: Actor
  /** Personagem em destaque na história. */
  character: CastKey
  /** Uma frase para a visão prática. */
  brief: string
  when: { day: string; date: string; time: string }
  title: string
  story: string[]
  system: string[]
  modules: JourneyModuleRef[]
  visual: VisualKey
}

export const company = {
  name: 'Vale Verde Alimentos',
  descriptor: 'indústria de alimentos, 10.000 colaboradores, 6 unidades',
  unit: 'unidade de Sorocaba (SP)',
  volume: 'cerca de 300 admissões por mês nas safras',
}

export const cast: CastMember[] = [
  { key: 'ana', name: 'Ana Ribeiro', role: 'Candidata, depois Supervisora de Produção', initials: 'AR', hero: true },
  { key: 'marcos', name: 'Marcos Tavares', role: 'Gerente de Produção, o gestor da vaga', initials: 'MT' },
  { key: 'juliana', name: 'Juliana Prado', role: 'Recrutadora, Recursos Humanos', initials: 'JP' },
  { key: 'claudia', name: 'Cláudia Nunes', role: 'Controladoria, alçada financeira', initials: 'CN' },
  { key: 'beatriz', name: 'Beatriz Lima', role: 'Analista de Admissão, Departamento Pessoal', initials: 'BL' },
  { key: 'henrique', name: 'Dr. Henrique Sales', role: 'Médico do Trabalho', initials: 'HS' },
  { key: 'rafael', name: 'Rafael Duarte', role: 'Técnico de Segurança do Trabalho', initials: 'RD' },
  { key: 'paulo', name: 'Paulo Mendes', role: 'Analista de Folha e eSocial', initials: 'PM' },
  { key: 'nati', name: 'NATI', role: 'Agente de IA da Natcorp, presente em todas as etapas', initials: 'N' },
]

export const castMember = (key: CastKey) => cast.find((c) => c.key === key)!

export const phases: JourneyPhase[] = [
  { n: 1, title: 'Atração e Seleção', subtitle: 'A vaga nasce no portal, é aprovada e encontra a pessoa certa.', range: 'Dia 1 a 10', steps: [1, 6] },
  { n: 2, title: 'Admissão Digital', subtitle: 'Documentos, dependentes, benefícios, exame e assinatura, sem papel. Depois, um clique.', range: 'Dia 10 a 16', steps: [7, 13] },
  { n: 3, title: 'Primeiro Dia', subtitle: 'Portal, onboarding, NatPonto, EPIs e treinamento já estavam preparados.', range: 'Dia 22', steps: [14, 18] },
  { n: 4, title: 'Trajetória', subtitle: 'Avaliações, requisições e movimentações, com o RH operando em paralelo, até a promoção.', range: 'Do mês 1 ao ano 1', steps: [19, 24] },
]

export const steps: JourneyStep[] = [
  /* ---------------- Fase 1 · Atração e Seleção ---------------- */
  {
    id: 'etapa-01',
    n: 1,
    phase: 1,
    name: 'Requisição de Vaga',
    official: 'Aumento de quadro pedido pelo gestor e aprovado por alçada.',
    actor: 'gestor',
    character: 'marcos',
    brief: 'O gestor pede a vaga pelo portal. Cargo e salário respeitam as faixas de Cargos e Salários. Aprovada, a vaga nasce no headcount.',
    when: { day: 'Dia 1', date: 'Seg · 07/09', time: '08:40' },
    title: 'Uma linha nova, uma vaga nova',
    story: [
      'Marcos Tavares atravessa a fábrica e abre o Portal do Gestor no celular. A Vale Verde vai ligar a segunda linha de embalagem em Sorocaba e ele precisa de mais uma Supervisora de Produção. Ele preenche os dados funcionais da vaga: unidade, departamento, centro de custo e turno. Ao escolher o cargo, o sistema mostra a grade e a faixa salarial de Supervisor(a) de Produção. O salário que ele informa fica dentro da faixa. Se saísse, a requisição nem seguiria.',
      'A requisição vai para a Controladoria. Cláudia Nunes vê o previsto e o realizado do centro de custo na mesma tela e aprova. A Diretoria de Operações aprova pelo celular. No mesmo minuto, a vaga aparece no headcount como aberta.',
    ],
    system: [
      'Requisição de Vaga pelo Portal do Gestor, com os dados funcionais e o cargo.',
      'Cargo e salário respeitam automaticamente as grades e faixas de Cargos e Salários.',
      'Aprovada por alçada, a vaga é criada no headcount sem cadastro manual.',
    ],
    modules: [
      { slug: 'portais', note: 'Portal do Gestor' },
      { slug: 'requisicoes-com-workflow', note: 'Requisição de Vaga e alçadas' },
      { slug: 'cargos-e-salarios', note: 'grade e faixa salarial' },
      { slug: 'administracao-de-pessoal', note: 'headcount e orçamento' },
    ],
    visual: 'approval',
  },
  {
    id: 'etapa-02',
    n: 2,
    phase: 1,
    name: 'Requisição de Pessoal',
    official: 'Aprovada, cria o processo seletivo e o entrega ao recrutador.',
    actor: 'gestor',
    character: 'marcos',
    brief: 'Com a vaga aberta, o gestor pede a contratação. Aprovada, o processo seletivo é criado sozinho e direcionado ao recrutador responsável.',
    when: { day: 'Dia 2', date: 'Ter · 08/09', time: '11:31' },
    title: 'O processo seletivo nasce pronto',
    story: [
      'Com a vaga aberta, Marcos abre a Requisição de Pessoal para ela: quantidade, prazo desejado e o motivo, aumento de quadro. A alçada aprova. Ninguém do RH cadastra nada: o processo seletivo é criado automaticamente e cai na fila de Juliana Prado, a recrutadora responsável pela unidade, já ligado ao cargo, ao centro de custo e à vaga aprovada. Ela confere as fases sugeridas, ajusta o questionário da área de produção e define o prazo de 20 dias.',
    ],
    system: [
      'A Requisição de Pessoal nasce da vaga aprovada, com histórico de cada alçada.',
      'Aprovada, o processo seletivo é criado e direcionado ao recrutador responsável.',
      'Fases, questionários e prazo por vaga definidos em uma tela.',
    ],
    modules: [
      { slug: 'requisicoes-com-workflow', note: 'Requisição de Pessoal' },
      { slug: 'recrutamento-e-selecao', note: 'processo criado automaticamente' },
      { slug: 'portais', note: 'Portal do Gestor' },
      { slug: 'people-analytics', note: 'prazo e funil da vaga' },
    ],
    visual: 'process',
  },
  {
    id: 'etapa-03',
    n: 3,
    phase: 1,
    name: 'Quadro de Vagas',
    official: 'Publicação no job board da empresa e no LinkedIn.',
    actor: 'rh',
    character: 'juliana',
    brief: 'A recrutadora publica em um clique no quadro de vagas com a marca da empresa e nas plataformas conectadas, como o LinkedIn.',
    when: { day: 'Dia 2', date: 'Ter · 08/09', time: '14:20' },
    title: 'Publicada com a cara da Vale Verde. E no LinkedIn.',
    story: [
      'Juliana publica a vaga em um clique. Ela aparece no quadro de vagas da Vale Verde, com as cores e o logotipo da empresa, e não em um site genérico de terceiros. No mesmo movimento, a vaga vai para o LinkedIn e para as outras plataformas conectadas. Quem visita a página de carreiras vê Supervisor(a) de Produção em Sorocaba com o texto que veio do cadastro do cargo, e se candidata pelo celular.',
    ],
    system: [
      'Publicação a partir do processo seletivo, sem redigitar título, descrição ou requisitos.',
      'Quadro de vagas com a identidade visual da empresa, para candidatos externos e internos.',
      'Divulgação no LinkedIn e em outras plataformas conectadas.',
    ],
    modules: [
      { slug: 'quadro-de-vagas', note: 'job board com a marca da empresa' },
      { slug: 'recrutamento-e-selecao', note: 'origem do anúncio' },
      { slug: 'conexao-com-outros-sistemas', note: 'LinkedIn e outras plataformas' },
    ],
    visual: 'jobboard',
  },
  {
    id: 'etapa-04',
    n: 4,
    phase: 1,
    name: 'Portal do Candidato',
    official: 'Inscrição com dados pessoais, formação, cursos, soft skills e histórico.',
    actor: 'candidato',
    character: 'ana',
    brief: 'A candidata cria o cadastro pelo celular: dados, formação, cursos, soft skills e histórico profissional. E se inscreve.',
    when: { day: 'Dia 3', date: 'Qua · 09/09', time: '21:15' },
    title: 'Ana se candidata do sofá',
    story: [
      'Ana Ribeiro tem curso técnico em alimentos e quatro anos em linha de produção. À noite, no sofá, ela vê a vaga no LinkedIn e cai no portal do candidato da Vale Verde. Cria o cadastro pelo celular: dados pessoais, formação, cursos, soft skills e histórico profissional. Aceita os termos de tratamento de dados e se inscreve no processo seletivo. Em doze minutos, está dentro.',
    ],
    system: [
      'Cadastro completo do candidato pelo celular, com currículo estruturado.',
      'Termos de aceite digitais, com histórico e versionamento, conforme a LGPD.',
      'O currículo entra no banco de talentos para esta e para as próximas vagas.',
    ],
    modules: [
      { slug: 'portais', note: 'Portal do Candidato' },
      { slug: 'recrutamento-e-selecao', note: 'inscrição no processo' },
      { slug: 'ged', note: 'currículo e anexos guardados' },
    ],
    visual: 'candidate',
  },
  {
    id: 'etapa-05',
    n: 5,
    phase: 1,
    name: 'Fases e Questionários',
    official: 'Questionários por fase aprovam ou reprovam automaticamente.',
    actor: 'sistema',
    character: 'nati',
    brief: 'Cada fase tem questionário e nota de corte: o sistema aprova ou reprova sozinho. A NATI indica os candidatos mais aderentes ao cargo.',
    when: { day: 'Dia 4', date: 'Qui · 10/09', time: '09:05' },
    title: 'Cada fase decide sozinha quem segue',
    story: [
      'O processo tem quatro fases: triagem, questionário técnico, entrevista com o RH e entrevista com o gestor. Ana responde ao questionário técnico no portal: boas práticas de fabricação, segurança de alimentos, liderança de turno. A nota fica acima do corte definido por Juliana, e o sistema a aprova para a próxima fase na hora. Quem fica abaixo recebe o retorno automaticamente.',
      'Antes das entrevistas, Juliana pede à NATI os candidatos mais aderentes ao cargo. A NATI cruza formação, experiência e respostas com os requisitos da vaga e devolve seis nomes, com Ana no topo.',
    ],
    system: [
      'Questionários por fase com nota de corte: aprovação ou reprovação automática, com retorno ao candidato.',
      'A NATI cruza o banco de talentos com os requisitos do cargo e indica os mais aderentes.',
      'O candidato acompanha cada fase pelo portal, no celular.',
    ],
    modules: [
      { slug: 'recrutamento-e-selecao', note: 'fases, questionários e corte' },
      { slug: 'nati', note: 'aderência ao cargo' },
      { slug: 'portais', note: 'acompanhamento pelo candidato' },
    ],
    visual: 'talent',
  },
  {
    id: 'etapa-06',
    n: 6,
    phase: 1,
    name: 'Entrevistas e Aprovação',
    official: 'Entrevistas registradas e proposta dentro da política salarial.',
    actor: 'gestor',
    character: 'marcos',
    brief: 'Recrutadora e gestor entrevistam. A proposta é conferida contra o teto do cargo. Aprovada, a vaga fecha dentro do prazo.',
    when: { day: 'Dia 8 a 10', date: 'Seg · 14/09 a Qua · 16/09', time: '10:00' },
    title: 'Entrevista com o gestor, política salarial por trás',
    story: [
      'Juliana e Marcos entrevistam quatro pessoas. Cada avaliação fica registrada na fase correspondente. Quando Marcos monta a proposta para Ana, o sistema confere o teto salarial, a formação e a experiência exigidas pelo cargo: está tudo dentro da política. Na quarta, às 10:00, Ana é aprovada. O painel de recrutamento mostra a vaga fechada em oito dias, dentro do prazo de vinte.',
    ],
    system: [
      'Avaliações e notas por fase, com acompanhamento em tempo real pelo gestor.',
      'Os filtros de contratação do cargo (teto salarial, formação, experiência) impedem proposta fora da política.',
      'O painel mostra tempo de fechamento, prazo por vaga e efetividade dos canais.',
    ],
    modules: [
      { slug: 'recrutamento-e-selecao', note: 'entrevistas e aprovação' },
      { slug: 'cargos-e-salarios', note: 'filtros de contratação' },
      { slug: 'business-intelligence', note: 'painel do recrutamento' },
      { slug: 'people-analytics', note: 'tempo de fechamento e funil' },
    ],
    visual: 'sla',
  },

  /* ---------------- Fase 2 · Admissão Digital ---------------- */
  {
    id: 'etapa-07',
    n: 7,
    phase: 2,
    name: 'Admissão Digital',
    official: 'Aprovado, o candidato é convidado a preencher a admissão.',
    actor: 'sistema',
    character: 'beatriz',
    brief: 'A aprovação abre a admissão sozinha. O candidato recebe o convite no portal e o RH acompanha o status sem enviar formulário.',
    when: { day: 'Dia 10', date: 'Qua · 16/09', time: '10:02' },
    title: 'Aprovada, a admissão abre sozinha',
    story: [
      'Dois minutos depois da aprovação, Ana recebe o convite para a admissão no mesmo portal em que se candidatou. Beatriz Lima, do time de Admissão, vê a admissão aparecer na lista dela com o status "aguardando o candidato". Ninguém enviou e-mail com formulário em anexo. Ninguém pediu cópia de documento.',
    ],
    system: [
      'A Admissão Digital nasce do processo seletivo aprovado, ligada à vaga e ao headcount.',
      'O RH acompanha o status de cada admissão em tempo real e só entra quando precisa validar.',
    ],
    modules: [
      { slug: 'admissao-digital', note: 'admissão aberta automaticamente' },
      { slug: 'recrutamento-e-selecao', note: 'candidata aprovada' },
      { slug: 'portais', note: 'convite no Portal do Candidato' },
    ],
    visual: 'admission',
  },
  {
    id: 'etapa-08',
    n: 8,
    phase: 2,
    name: 'Documentos e Dependentes',
    official: 'Dados de admissão, documentos obrigatórios e dependentes, com anexos.',
    actor: 'candidato',
    character: 'ana',
    brief: 'A candidata preenche os dados de admissão, fotografa RG, CPF, PIS e certidões, cadastra os dependentes e anexa os documentos deles. Tudo vai para o GED.',
    when: { day: 'Dia 10', date: 'Qua · 16/09', time: '20:10' },
    title: 'Dados preenchidos por quem mais sabe deles',
    story: [
      'À noite, Ana entra de novo no portal do candidato e preenche os dados da admissão: endereço, dados bancários, escolaridade, PIS. Fotografa pelo celular os documentos obrigatórios: RG, CPF, carteira de trabalho digital, comprovante de endereço e certidão de casamento. Cadastra o dependente, um filho de seis anos, e anexa a certidão de nascimento dele. As validações apontam um dígito errado na agência antes de ela seguir.',
      'Às 20:34, a parte dela está feita. Cada documento já está no GED da Vale Verde, em nuvem, organizado por pessoa e por tipo, à disposição do RH.',
    ],
    system: [
      'Coleta eletrônica de dados com validações que evitam erro de digitação.',
      'Documentos obrigatórios (RG, CPF, reservista, PIS, certidões) e documentos dos dependentes anexados pelo celular.',
      'Tudo disponível para o RH no GED, em nuvem, com trilha de auditoria.',
    ],
    modules: [
      { slug: 'admissao-digital', note: 'coleta eletrônica de dados' },
      { slug: 'portais', note: 'Portal do Candidato no celular' },
      { slug: 'ged', note: 'documentos e dependentes' },
    ],
    visual: 'dataform',
  },
  {
    id: 'etapa-09',
    n: 9,
    phase: 2,
    name: 'Escolha de Benefícios',
    official: 'Obrigatórios e complementares, por elegibilidade e valor disponível.',
    actor: 'candidato',
    character: 'ana',
    brief: 'Os benefícios obrigatórios já vêm marcados. Os complementares aparecem com o valor disponível, conforme a elegibilidade do cargo.',
    when: { day: 'Dia 10', date: 'Qua · 16/09', time: '20:31' },
    title: 'Os benefícios que o cargo dela permite',
    story: [
      'Ainda no portal, Ana vê os benefícios obrigatórios do cargo já marcados: vale-transporte e refeição no refeitório. Os complementares aparecem com o valor disponível para ela: plano de saúde com a opção de incluir o filho, odontológico e previdência privada. Ela inclui o dependente no plano, informa o trajeto para o vale-transporte e deixa a previdência para depois. As escolhas ficam registradas e prontas para virarem rubricas na folha.',
    ],
    system: [
      'Regras de elegibilidade por cargo, unidade e política da empresa aplicadas na hora.',
      'Benefícios obrigatórios e complementares, com o valor disponível para o colaborador.',
      'Inclusões e dependentes registrados com histórico, prontos para as operadoras e para a folha.',
    ],
    modules: [
      { slug: 'gestao-de-beneficios', note: 'elegibilidade e escolha' },
      { slug: 'portais', note: 'escolha pelo portal' },
      { slug: 'folha-de-pagamento', note: 'rubricas automáticas' },
    ],
    visual: 'benefits',
  },
  {
    id: 'etapa-10',
    n: 10,
    phase: 2,
    name: 'Conferência no GED',
    official: 'RH valida dados e documentos e devolve pendências pelo portal.',
    actor: 'rh',
    character: 'beatriz',
    brief: 'O RH confere dados e documentos lado a lado no GED. Pendência devolvida pelo portal, com comentário, e resolvida pelo celular.',
    when: { day: 'Dia 11', date: 'Qui · 17/09', time: '09:20' },
    title: 'Beatriz confere tudo em uma tela',
    story: [
      'Na manhã seguinte, Beatriz abre a admissão de Ana no notebook e confere dados e documentos lado a lado. O comprovante de endereço está ilegível. Ela devolve a pendência com um comentário e Ana, no intervalo do trabalho atual, fotografa de novo. Seis minutos depois, o documento novo está no lugar do antigo, com o histórico de quem viu e alterou o quê.',
    ],
    system: [
      'Documentos organizados por pessoa e por tipo, vinculados ao cadastro.',
      'Pendências devolvidas ao candidato pelo portal, com comentário e prazo.',
      'Acesso por perfil e trilha de auditoria, conforme a LGPD.',
    ],
    modules: [
      { slug: 'ged', note: 'arquivo e auditoria dos documentos' },
      { slug: 'admissao-digital', note: 'validação pelo RH' },
      { slug: 'portais', note: 'pendência devolvida ao candidato' },
    ],
    visual: 'ged',
  },
  {
    id: 'etapa-11',
    n: 11,
    phase: 2,
    name: 'Exame Admissional',
    official: 'ASO agendado direto na agenda do médico do trabalho.',
    actor: 'sesmt',
    character: 'henrique',
    brief: 'O exame é agendado na agenda do médico, com a guia gerada pelos riscos do cargo. O ASO sai com assinatura digital e vai para o eSocial.',
    when: { day: 'Dia 15', date: 'Seg · 21/09', time: '08:30' },
    title: 'O exame cai direto na agenda do médico',
    story: [
      'Com a documentação em ordem, Beatriz agenda o exame admissional pelo módulo de Medicina Ocupacional, direto na agenda do Dr. Henrique Sales, o médico do trabalho da unidade. A guia já traz o grupo de exposição do setor de produção, ruído e umidade, e o plano de exames que vem dele: clínico e audiometria. Ana recebe o horário no portal.',
      'Na clínica, o Dr. Henrique registra o resultado no sistema e emite o ASO com assinatura digital. Apta. A lista de EPIs exigidos para o cargo já fica separada para o primeiro dia.',
    ],
    system: [
      'Agendamento direto na agenda do médico, com guia gerada a partir do cargo e dos riscos da vaga.',
      'Do PGR ao GHE, do PCMSO ao ASO: o plano de exames vem do risco da função, não de uma lista genérica.',
      'ASO com assinatura digital, alerta de vencimento e evento de saúde gerado para o eSocial. Candidato inapto não entra na folha.',
    ],
    modules: [
      { slug: 'medicina-ocupacional', note: 'agenda, exames e ASO' },
      { slug: 'seguranca-do-trabalho', note: 'GHE e riscos do cargo' },
      { slug: 'esocial', note: 'S-2220 a partir do ASO' },
      { slug: 'portais', note: 'horário no Portal do Candidato' },
    ],
    visual: 'aso',
  },
  {
    id: 'etapa-12',
    n: 12,
    phase: 2,
    name: 'NatDocs · Assinatura',
    official: 'Contrato e termos assinados digitalmente, com cópia por e-mail.',
    actor: 'candidato',
    character: 'ana',
    brief: 'Contrato e termos chegam pelo NatDocs. Assinados no celular, ficam para download e chegam por e-mail com os originais.',
    when: { day: 'Dia 15', date: 'Seg · 21/09', time: '12:40' },
    title: 'Contrato assinado no celular, na hora do almoço',
    story: [
      'Com o ASO no cadastro, o contrato de trabalho, o termo de uso dos sistemas e as políticas internas chegam para Ana pelo NatDocs. Ela lê e assina pelo celular na hora do almoço. A Vale Verde assina do lado dela. O documento assinado fica disponível para download na plataforma, e Ana recebe por e-mail todos os anexos: os originais e as versões assinadas. Nada para imprimir, nada para levar no primeiro dia.',
    ],
    system: [
      'Assinatura eletrônica com validade jurídica, pelo celular.',
      'Signatários, prazo e status de cada documento acompanhados pelo RH.',
      'Documento assinado disponível para download e enviado por e-mail com os originais. O GED guarda tudo.',
    ],
    modules: [
      { slug: 'assinatura-eletronica', note: 'NatDocs, contrato e termos' },
      { slug: 'ged', note: 'guarda dos originais e assinados' },
      { slug: 'portais', note: 'pendência de assinatura no celular' },
    ],
    visual: 'contract',
  },
  {
    id: 'etapa-13',
    n: 13,
    phase: 2,
    name: 'Efetivação da Admissão',
    official: 'Código do candidato, data de admissão, confirmar. Pronto.',
    actor: 'rh',
    character: 'beatriz',
    brief: 'O time de Admissão informa o código da candidata e a data, e confirma. Folha, ponto, benefícios, eSocial, headcount e portais são atualizados de uma vez.',
    when: { day: 'Dia 16', date: 'Ter · 22/09', time: '09:40' },
    title: 'Código, data, confirmar. Ana faz parte da empresa.',
    story: [
      'Na terça de manhã, Beatriz abre o programa de admissão no sistema Natcorp, informa o código de candidata de Ana, a data de admissão, 28 de setembro, e confirma. Só isso. Nenhum dado é digitado de novo, porque tudo já veio do processo seletivo, do portal do candidato, da escolha de benefícios e do exame. É o momento em que uma única confirmação atualiza sete lugares ao mesmo tempo.',
    ],
    system: [
      'A admissão é confirmada com o código do candidato e a data, sem redigitação.',
      'Cadastro criado em folha, ponto, benefícios, eSocial, headcount e portais em um só clique.',
      'Catraca, ERP e e-mail corporativo avisados pela Conexão com outros sistemas.',
    ],
    modules: [
      { slug: 'admissao-digital', note: 'confirmação da admissão' },
      { slug: 'folha-de-pagamento', note: 'cadastro criado' },
      { slug: 'esocial', note: 'evento de admissão' },
      { slug: 'administracao-de-pessoal', note: 'posição ocupada' },
    ],
    visual: 'confirm',
  },

  /* ---------------- Fase 3 · Primeiro Dia ---------------- */
  {
    id: 'etapa-14',
    n: 14,
    phase: 3,
    name: 'Portal do Colaborador',
    official: 'Autogestão: dados, documentos, holerite, ponto, férias e requisições.',
    actor: 'colaborador',
    character: 'ana',
    brief: 'A colaboradora consulta dados, documentos, holerite, espelho de ponto e informe de rendimentos, e abre requisições que, aprovadas, efetivam sozinhas. A NATI está lá.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '06:05' },
    title: 'O primeiro dia começa antes de chegar',
    story: [
      'Segunda-feira, 28 de setembro. Ana acorda com o acesso ao Portal do Colaborador já liberado no celular. Lá estão os dados dela, os documentos assinados, a escala da semana e os espaços onde vão aparecer holerite, espelho de ponto, informe de rendimentos e aviso de férias.',
      'Também é ali que ela vai pedir férias, alterar o endereço, incluir um dependente, ajustar uma marcação de ponto, pedir autorização para horas extras ou enviar um atestado. Aprovado, o sistema efetiva sozinho, sem ninguém do RH digitar nada. E no canto da tela, a NATI se apresenta e pergunta se pode ajudar.',
    ],
    system: [
      'Portal liberado na efetivação, com os dados que a própria pessoa preencheu.',
      'Consultas: holerite, espelho de ponto, informe de rendimentos, aviso de férias, documentos e relatórios.',
      'Requisições que, aprovadas, efetivam os dados automaticamente. A NATI orienta no que for preciso, inclusive no uso do sistema.',
    ],
    modules: [
      { slug: 'portais', note: 'Portal do Colaborador' },
      { slug: 'requisicoes-com-workflow', note: 'pedidos que efetivam sozinhos' },
      { slug: 'nati', note: 'assistente pessoal de RH' },
    ],
    visual: 'portal',
  },
  {
    id: 'etapa-15',
    n: 15,
    phase: 3,
    name: 'Onboarding e Blog',
    official: 'Instruções por cargo, vídeos e comunicados no primeiro acesso.',
    actor: 'colaborador',
    character: 'ana',
    brief: 'No primeiro login, o onboarding traz as instruções do cargo, vídeos e arquivos. O Blog Corporativo mostra os comunicados e o vídeo institucional.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '06:40' },
    title: 'Boas-vindas com a cara da empresa',
    story: [
      'No primeiro login, o onboarding abre sozinho: as instruções iniciais do cargo de Supervisora de Produção, o vídeo de boas-vindas do diretor industrial, o código de conduta, o mapa da unidade com refeitório e vestiário e os arquivos que ela precisa ler na primeira semana. No Blog Corporativo, o comunicado de boas-vindas aos admitidos do mês e o vídeo institucional da Vale Verde já estão no ar. Ana assiste no ônibus.',
    ],
    system: [
      'Onboarding com instruções personalizadas por cargo: textos, vídeos, imagens e arquivos.',
      'Lembretes orientam cada etapa da primeira semana.',
      'Blog Corporativo com vídeos institucionais, avisos e comunicados, dentro do portal.',
    ],
    modules: [
      { slug: 'onboarding', note: 'instruções iniciais por cargo' },
      { slug: 'blog-corporativo', note: 'comunicados e vídeos' },
      { slug: 'portais', note: 'tudo no Portal do Colaborador' },
    ],
    visual: 'onboarding',
  },
  {
    id: 'etapa-16',
    n: 16,
    phase: 3,
    name: 'NatPonto',
    official: 'Acesso ao app: marcação com reconhecimento facial e geolocalização.',
    actor: 'colaborador',
    character: 'ana',
    brief: 'O acesso ao NatPonto chega junto com o portal. Marcação em tempo real, com reconhecimento facial e geolocalização, direto para a apuração.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '06:21' },
    title: 'Na portaria, o rosto e o lugar',
    story: [
      'Às 06:21, na portaria da unidade, Ana abre o NatPonto pela primeira vez. O acesso chegou junto com o do portal. O app reconhece o rosto dela, confirma que está dentro do raio da unidade e registra a entrada em tempo real. O comprovante, com código de verificação e localização, fica no celular. Em segundos, a marcação está no Ponto Eletrônico, pronta para a apuração da jornada das 06:30 às 15:48.',
    ],
    system: [
      'Reconhecimento facial e geolocalização com raio por unidade. Funciona sem internet e sincroniza depois.',
      'Comprovante de cada marcação com código de verificação.',
      'A apuração aplica escala, tolerâncias e regras do sindicato e envia os eventos para a folha.',
    ],
    modules: [
      { slug: 'natponto', note: 'marcação com facial e geolocalização' },
      { slug: 'ponto-eletronico', note: 'apuração da jornada' },
      { slug: 'folha-de-pagamento', note: 'eventos do ponto na folha' },
    ],
    visual: 'natponto',
  },
  {
    id: 'etapa-17',
    n: 17,
    phase: 3,
    name: 'Entrega de EPI',
    official: 'EPIs previstos pela vaga, com estoque planejado pelo SESMT.',
    actor: 'sesmt',
    character: 'rafael',
    brief: 'O sistema sabia os EPIs do cargo e do local antes da admissão. O estoque estava reservado. Ficha assinada na tela.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '07:30' },
    title: 'Os EPIs certos já estavam separados',
    story: [
      'Na sala de segurança, Rafael Duarte já tem a lista de Ana no tablet: protetor auricular, óculos de proteção, botina antiderrapante e touca. O sistema sabia desses EPIs antes da admissão, pelos dados da vaga: cargo, setor e local de trabalho definem o grupo de exposição. Por isso o estoque estava reservado. Cada item tem o certificado de aprovação conferido na base do governo. Ana recebe os itens e assina a ficha de EPI na tela. Nenhum papel para arquivar.',
    ],
    system: [
      'EPIs definidos pelo cargo e pelo local de trabalho, a partir do PGR e do GHE, antes da admissão.',
      'Previsibilidade para o SESMT gerenciar o estoque.',
      'CA validado automaticamente. Ficha de EPI assinada digitalmente e guardada no GED.',
    ],
    modules: [
      { slug: 'seguranca-do-trabalho', note: 'EPIs por cargo e local, estoque' },
      { slug: 'assinatura-eletronica', note: 'ficha de EPI assinada na tela' },
      { slug: 'ged', note: 'ficha guardada com auditoria' },
    ],
    visual: 'epi',
  },
  {
    id: 'etapa-18',
    n: 18,
    phase: 3,
    name: 'Treinamento',
    official: 'Matrícula automática na trilha de entrada do cargo.',
    actor: 'sistema',
    character: 'ana',
    brief: 'A matrícula na trilha do cargo foi feita pelo sistema na confirmação da admissão. Presença, certificado e validade das NRs registrados.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '09:00' },
    title: 'A trilha do cargo já estava agendada',
    story: [
      'Às nove, Ana entra na sala de treinamento. A matrícula na trilha de entrada foi feita pelo sistema quando a admissão foi confirmada: integração de segurança, uso e conservação de EPIs, boas práticas de fabricação e, nas próximas semanas, liderança de primeiro nível. Presença e certificado ficam registrados, e a validade de cada treinamento obrigatório passa a ser acompanhada pelo SESMT.',
    ],
    system: [
      'Trilha de entrada por cargo, com matrícula automática na admissão.',
      'Treinamentos de NR com validade controlada: sem a habilitação em dia, a mudança de cargo fica pendente até a regularização.',
      'Presença, carga horária, prova e certificado registrados no perfil da pessoa.',
    ],
    modules: [
      { slug: 'treinamento-e-desenvolvimento', note: 'trilha de entrada do cargo' },
      { slug: 'seguranca-do-trabalho', note: 'treinamentos de NR e validade' },
      { slug: 'cargos-e-salarios', note: 'competências exigidas pelo cargo' },
    ],
    visual: 'training',
  },

  /* ---------------- Fase 4 · Trajetória ---------------- */
  {
    id: 'etapa-19',
    n: 19,
    phase: 4,
    name: 'Avaliações e Feedbacks',
    official: 'Desempenho, autoavaliação, 180º, 360º e feedbacks.',
    actor: 'gestor',
    character: 'marcos',
    brief: 'Avaliações de experiência, desempenho, autoavaliação, 180º e 360º pelo celular. O histórico alimenta carreira, sucessão e treinamento.',
    when: { day: 'Dia 45 e dia 90', date: 'Qui · 12/11 e Seg · 28/12', time: '' },
    title: 'Avaliar vira rotina, não evento',
    story: [
      'No dia 45, Marcos recebe no Portal do Gestor a avaliação do primeiro período de experiência de Ana. Preenche em dez minutos e registra um feedback sobre a organização do turno. No dia 90, a segunda avaliação, e o contrato passa a prazo indeterminado sem ninguém lembrar. Ao longo do ano, Ana faz a autoavaliação, participa do ciclo 180º com o gestor e, como supervisora, do 360º com a equipe. Tudo pelo celular.',
    ],
    system: [
      'Períodos de experiência parametrizados no cargo, com progressão automática.',
      'Avaliação de desempenho, autoavaliação, 180º e 360º com perguntas personalizadas pelo RH.',
      'Feedbacks registrados. O histórico alimenta carreira, sucessão e treinamento.',
    ],
    modules: [
      { slug: 'avaliacoes-e-feedbacks', note: 'avaliações e feedbacks' },
      { slug: 'cargos-e-salarios', note: 'períodos de experiência no cargo' },
      { slug: 'portais', note: 'Portal do Gestor e do Colaborador' },
    ],
    visual: 'evaluation',
  },
  {
    id: 'etapa-20',
    n: 20,
    phase: 4,
    name: 'Requisições do Colaborador',
    official: 'Férias, dados, dependentes, ponto, horas extras, atestados, benefícios e CIPA.',
    actor: 'colaborador',
    character: 'ana',
    brief: 'Ajuste de ponto, mudança de endereço, horas extras, atestado, férias, benefícios e voto na CIPA, tudo pelo portal. Aprovado, efetivado.',
    when: { day: 'Mês 5 em diante', date: 'Qua · 10/02/2027', time: '13:31' },
    title: 'O dia a dia sem e-mail nem planilha',
    story: [
      'Numa quarta de fevereiro, Ana esquece de bater o ponto na volta do almoço. Pelo app, abre um ajuste de marcação com a justificativa. Marcos aprova no celular e a marcação é regularizada antes da apuração. Em março, ela muda de endereço e atualiza o cadastro pelo portal. Em abril, pede autorização para horas extras no fechamento da safra. Em maio, envia um atestado de dois dias: aprovado, o afastamento é lançado sozinho.',
      'Ela ainda emite o informe de rendimentos, agenda as férias, revê os benefícios na janela anual e vota na eleição da CIPA. Nada disso passa pelo RH digitar.',
    ],
    system: [
      'Requisições com workflow: férias, alteração de dados, dependentes, ajuste de marcação, horas extras, atestados e benefícios.',
      'Aprovada, a requisição efetiva o dado automaticamente. Atestado aprovado afasta o colaborador na hora.',
      'Relatórios (espelho de ponto, holerite, informe de rendimentos, aviso de férias) e votação da CIPA no portal.',
    ],
    modules: [
      { slug: 'requisicoes-com-workflow', note: 'ponto, dados, férias, atestados' },
      { slug: 'portais', note: 'Portal do Colaborador' },
      { slug: 'ponto-eletronico', note: 'regularização da marcação' },
      { slug: 'medicina-ocupacional', note: 'atestado e afastamento' },
      { slug: 'gestao-de-beneficios', note: 'janela anual de benefícios' },
    ],
    visual: 'request',
  },
  {
    id: 'etapa-21',
    n: 21,
    phase: 4,
    name: 'Movimentações pelo Gestor',
    official: 'Cargo, salário, posição, departamento e horário, com efetivação automática.',
    actor: 'gestor',
    character: 'marcos',
    brief: 'O gestor pede mudança de horário, departamento, cargo ou salário pelo portal. Aprovada, ponto, folha, organograma e eSocial já mudaram.',
    when: { day: 'Mês 7', date: 'Seg · 05/04/2027', time: '16:10' },
    title: 'Aprovou, o cadastro já mudou',
    story: [
      'Quando a segunda linha de embalagem passa a rodar em dois turnos, Marcos pede a mudança do horário contratual de Ana pelo Portal do Gestor. Meses depois, uma mudança de departamento e um reajuste por mérito. Cada pedido passa pela alçada e, aprovado, atualiza o cadastro de Ana na hora: horário no ponto, salário na folha, posição no organograma. O reajuste respeita a faixa do cargo, e o eSocial recebe a alteração contratual.',
    ],
    system: [
      'Requisições de mudança de cargo, salário, posição, departamento e horário pelo Portal do Gestor.',
      'Aprovadas, atualizam ponto, folha e organograma automaticamente.',
      'Faixas de Cargos e Salários e política de mérito conferidas antes da aprovação.',
    ],
    modules: [
      { slug: 'requisicoes-com-workflow', note: 'movimentações com alçada' },
      { slug: 'portais', note: 'Portal do Gestor' },
      { slug: 'cargos-e-salarios', note: 'faixa e política de mérito' },
      { slug: 'folha-de-pagamento', note: 'salário e horário atualizados' },
      { slug: 'esocial', note: 'alteração contratual' },
    ],
    visual: 'movement',
  },
  {
    id: 'etapa-22',
    n: 22,
    phase: 4,
    name: 'Chamado Interno',
    official: 'Dúvidas com o RH com protocolo, prazo e histórico.',
    actor: 'colaborador',
    character: 'nati',
    brief: 'Um desconto estranho no holerite? A NATI explica. Se precisar de detalhe, o Chamado Interno vai para o RH com protocolo e prazo.',
    when: { day: 'Mês 9', date: 'Sex · 04/06/2027', time: '18:22' },
    title: 'Um desconto estranho no holerite? Chamado aberto.',
    story: [
      'No holerite de junho, Ana vê um desconto que não reconhece. Antes de procurar alguém, pergunta à NATI, que explica: é a coparticipação do plano de saúde do filho, referente a uma consulta em maio. Ela quer o extrato e abre um Chamado Interno para o RH pelo portal. O time responde com o detalhe da operadora em duas horas. Em outro mês, é o saldo do banco de horas. Tudo com protocolo, prazo e histórico, e nada por corredor.',
    ],
    system: [
      'Central de atendimento do RH e de outros departamentos, com protocolo, prazo e histórico.',
      'A NATI responde às dúvidas mais comuns antes de virarem chamado.',
      'Indicadores de atendimento por assunto no painel do RH.',
    ],
    modules: [
      { slug: 'chamado-interno', note: 'protocolo, prazo e histórico' },
      { slug: 'nati', note: 'explica o holerite na hora' },
      { slug: 'portais', note: 'Portal do Colaborador' },
      { slug: 'folha-de-pagamento', note: 'origem do desconto' },
    ],
    visual: 'nati',
  },
  {
    id: 'etapa-23',
    n: 23,
    phase: 4,
    name: 'O RH em Paralelo',
    official: 'Ponto, folha, benefícios, eSocial, BI, People Analytics e jurídico, com a NATI.',
    actor: 'rh',
    character: 'paulo',
    brief: 'Enquanto a jornada acontece, o RH fecha ponto, folha e benefícios de toda a empresa, envia o eSocial e analisa nos painéis. A folha de 10.000 colaboradores sai em cerca de 4 minutos.',
    when: { day: 'Todo mês', date: 'fechamento', time: '' },
    title: 'Enquanto Ana trabalha, o RH fecha 10.000 folhas em 4 minutos',
    story: [
      'Em paralelo a toda a jornada de Ana, o time de RH da Vale Verde opera a empresa inteira. Cada uma das seis unidades conclui ponto, benefícios e movimentações até a data de corte do seu calendário de fechamento, e Paulo Mendes vê, numa fila só, o que ainda falta em cada filial. Fechado o ponto, ele confere os benefícios e roda a folha dos 10.000 colaboradores por empresa: a 2.500 folhas por minuto, o cálculo termina em cerca de quatro minutos e já está pronto para conferência. A NATI cruza frequência, benefícios e impostos e aponta as inconsistências antes do pagamento, em segundos, o que levaria horas em planilha.',
      'O eSocial recebe cada evento e devolve o retorno no mesmo lugar. Nos painéis de BI e People Analytics, a diretoria acompanha turnover, absenteísmo e custo por unidade. E as rescisões que viraram processo trabalhista são acompanhadas no Jurídico Trabalhista, com o histórico de ponto, ASO, EPIs e treinamentos pronto para a defesa.',
    ],
    system: [
      'Calendário de fechamento por filial: cada unidade conclui ponto, benefícios e movimentações até a data de corte no seu perfil; a matriz vê as pendências por filial, confere e roda a folha por empresa, com a contabilização de cada CNPJ para o ERP.',
      'Folha calculada a 2.500 colaboradores por minuto: 10.000 colaboradores em cerca de 4 minutos.',
      'A NATI confere folha, ponto e benefícios e aponta inconsistências antes de pagar.',
      'eSocial, BI, People Analytics e Jurídico Trabalhista na mesma base, sem exportar planilha.',
    ],
    modules: [
      { slug: 'folha-de-pagamento', note: 'cálculo e fechamento' },
      { slug: 'ponto-eletronico', note: 'fechamento do ponto' },
      { slug: 'gestao-de-beneficios', note: 'conferência e operadoras' },
      { slug: 'esocial', note: 'envio e retorno dos eventos' },
      { slug: 'business-intelligence', note: 'painéis da diretoria' },
      { slug: 'people-analytics', note: 'turnover, absenteísmo, custo' },
      { slug: 'juridico-trabalhista', note: 'processos com histórico pronto' },
      { slug: 'nati', note: 'conferência em segundos' },
    ],
    visual: 'payroll',
  },
  {
    id: 'etapa-24',
    n: 24,
    phase: 4,
    name: 'Promoção ou Desligamento',
    official: 'Carreira e Sucessão ou Offboarding, fechando o ciclo.',
    actor: 'gestor',
    character: 'ana',
    brief: 'Promoção pelo mapa de sucessão, dentro da política, efetivada sem redigitar. Ou desligamento com Offboarding: pedido, aprovação, documentos assinados e rescisão.',
    when: { day: 'Ano 1', date: 'Set · 2027', time: '' },
    title: 'Um ano depois, o mapa de sucessão aponta para Ana',
    story: [
      'Na avaliação anual, Ana aparece no mapa de talentos como pronta para a Coordenação de Produção. Quando a coordenadora atual é transferida para outra unidade, Marcos abre a Requisição de Promoção. O sistema confere a faixa do novo cargo e a política de mérito, a alçada aprova e a mudança é efetivada na folha e no organograma. É o caminho que a história de Ana toma.',
      'O outro caminho também existe. Quando alguém sai, o gestor abre a solicitação de desligamento pelo portal. Aprovada, o Offboarding emite a documentação, o colaborador assina pelo NatDocs e o RH segue para o cálculo rescisório e a efetivação. A posição volta ao headcount, e a jornada recomeça na etapa 1.',
    ],
    system: [
      'Posições-chave, prontidão e risco de perda mapeados com dados de avaliação e desempenho.',
      'Promoção dentro da política efetivada sem redigitar. Fora dela, travada.',
      'Offboarding: solicitação, aprovação, documentos assinados, rescisão calculada e posição devolvida ao headcount.',
    ],
    modules: [
      { slug: 'carreira-e-sucessao', note: 'mapa de sucessão e prontidão' },
      { slug: 'cargos-e-salarios', note: 'faixa e política de mérito' },
      { slug: 'requisicoes-com-workflow', note: 'promoção ou desligamento' },
      { slug: 'offboarding', note: 'quando o ciclo se fecha' },
      { slug: 'assinatura-eletronica', note: 'documentos da rescisão' },
      { slug: 'folha-de-pagamento', note: 'promoção efetivada, rescisão calculada' },
    ],
    visual: 'succession',
  },
]

/** Etapa após a qual o hub de efetivação aparece. */
export const EFFECTIVATION_AFTER = 13

/** A confirmação da admissão atualiza vários módulos de uma só vez (etapa 13). */
export const effectivation = {
  when: { day: 'Dia 16', date: 'Ter · 22/09', time: '09:40' },
  title: 'Uma confirmação, sete atualizações',
  text: 'Beatriz confirma a admissão de Ana. Sem exportar arquivo, sem digitar de novo, o cadastro nasce em todos os lugares em que a Vale Verde precisa dele.',
  by: 'Beatriz Lima · Admissão',
  targets: [
    { slug: 'folha-de-pagamento', note: 'Cadastro criado, salário e rubricas prontos para o primeiro cálculo.' },
    { slug: 'administracao-de-pessoal', note: 'A posição passa a ocupada e o custo realizado atualiza o orçamento.' },
    { slug: 'ponto-eletronico', note: 'Jornada e escala aplicadas. O NatPonto é liberado.' },
    { slug: 'gestao-de-beneficios', note: 'Plano de saúde com dependente, vale-transporte e refeição ativados.' },
    { slug: 'esocial', note: 'Evento de admissão montado, validado e enviado antes do primeiro dia.' },
    { slug: 'conexao-com-outros-sistemas', note: 'Catraca, ERP e e-mail corporativo avisados automaticamente.' },
    { slug: 'portais', note: 'Portal do Colaborador, onboarding e NatPonto liberados para o dia 28.' },
  ],
  base: { slug: 'infraestrutura-e-seguranca', note: 'Tudo em nuvem, com trilha de auditoria de quem viu e alterou cada dado.' },
}

/** E quando a admissão não é uma, mas centenas? O mesmo fluxo, em série (aparece logo depois da efetivação). */
export const volume = {
  title: 'E quando são 300 de uma vez?',
  text: 'Na safra, a Vale Verde abre dezenas de requisições de uma vez, dispara os convites de admissão pelo portal, acompanha a fila de pendências por unidade e confirma as admissões em série. Cada evento do eSocial sai validado antes do primeiro dia.',
  modules: ['admissao-digital', 'esocial'],
  more: { to: paths.groups, label: 'Grupos com várias empresas e filiais' },
}

/** Números da história (para a abertura e o fechamento). */
export const outcomes = [
  { value: '24', label: 'etapas, da vaga à promoção, em um único fluxo' },
  { value: '0', label: 'formulários em papel na admissão, e nenhuma planilha paralela' },
  { value: '1 vez', label: 'cada dado foi digitado, por quem mais sabia dele' },
  { value: '4 min', label: 'para calcular a folha dos 10.000 colaboradores' },
]

/** Módulos que sustentam todas as etapas (camada de plataforma do diagrama de integração). */
export const platformSlugs = [
  'portais',
  'requisicoes-com-workflow',
  'ged',
  'assinatura-eletronica',
  'nati',
  'esocial',
  'business-intelligence',
  'people-analytics',
  'conexao-com-outros-sistemas',
  'infraestrutura-e-seguranca',
]

export { journeyPath }

export const stepsByPhase = (n: PhaseNumber) => steps.filter((s) => s.phase === n)

/** Slugs de todos os módulos citados na história, sem repetição, na ordem em que aparecem. */
export function journeyModuleSlugs(): string[] {
  const seen = new Set<string>()
  const out: string[] = []
  const push = (slug: string) => {
    if (!seen.has(slug)) {
      seen.add(slug)
      out.push(slug)
    }
  }
  for (const s of steps) {
    for (const m of s.modules) push(m.slug)
    if (s.n === EFFECTIVATION_AFTER) {
      for (const t of effectivation.targets) push(t.slug)
      push(effectivation.base.slug)
    }
  }
  return out
}
