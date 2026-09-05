/**
 * Jornada do colaborador contada como um exemplo do dia a dia.
 * As 21 etapas e as 4 fases seguem o fluxo oficial da Natcorp ("Do recrutamento à promoção,
 * tudo conectado em uma plataforma"). Empresa, pessoas, datas e valores são fictícios.
 */

import { journeyPath } from './site'

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
  | 'contract'
  | 'aso'
  | 'portal'
  | 'onboarding'
  | 'epi'
  | 'training'
  | 'natponto'
  | 'evaluation'
  | 'nati'
  | 'request'
  | 'succession'

export interface JourneyStep {
  id: string
  n: number
  phase: PhaseNumber
  /** Nome oficial da etapa no fluxo Natcorp. */
  name: string
  /** Descrição oficial da etapa, em uma linha. */
  official: string
  when: { day: string; date: string; time: string }
  title: string
  story: string[]
  system: string[]
  modules: JourneyModuleRef[]
  visual: VisualKey
}

export const company = {
  name: 'Vale Verde Alimentos',
  descriptor: 'indústria de alimentos, 3.200 colaboradores, 4 unidades',
  unit: 'unidade de Sorocaba (SP)',
}

export const cast = [
  { name: 'Ana Ribeiro', role: 'Candidata, depois Supervisora de Setor', initials: 'AR', hero: true },
  { name: 'Marcos Tavares', role: 'Gerente de Produção, o gestor da vaga', initials: 'MT' },
  { name: 'Juliana Prado', role: 'Recrutadora, Recursos Humanos', initials: 'JP' },
  { name: 'Cláudia Nunes', role: 'Controladoria, alçada financeira', initials: 'CN' },
  { name: 'Beatriz Lima', role: 'Analista de Departamento Pessoal', initials: 'BL' },
  { name: 'Dr. Henrique Sales', role: 'Médico do Trabalho', initials: 'HS' },
  { name: 'Rafael Duarte', role: 'Técnico de Segurança do Trabalho', initials: 'RD' },
]

export const phases: JourneyPhase[] = [
  { n: 1, title: 'Atração e Seleção', subtitle: 'A vaga nasce, é aprovada e encontra a pessoa certa.', range: 'Dia 1 a 10', steps: [1, 6] },
  { n: 2, title: 'Admissão e Onboarding', subtitle: 'Dados, benefícios, documentos, contrato e exame, sem papel.', range: 'Dia 10 a 16', steps: [7, 12] },
  { n: 3, title: 'Integração e Treinamento', subtitle: 'O primeiro dia: portal, instruções, EPIs e a trilha do cargo.', range: 'Dia 22', steps: [13, 16] },
  { n: 4, title: 'Operação Contínua', subtitle: 'Ponto, avaliações, remuneração e rotinas do dia a dia, até a promoção.', range: 'Do dia 22 em diante', steps: [17, 21] },
]

export const steps: JourneyStep[] = [
  {
    id: 'etapa-01',
    n: 1,
    phase: 1,
    name: 'Headcount',
    official: 'Vaga disponível aberta e aprovada por alçada.',
    when: { day: 'Dia 1', date: 'Seg · 07/09', time: '08:40' },
    title: 'Uma cadeira vazia na produção',
    story: [
      'Marcos Tavares chega à unidade de Sorocaba e abre o Portal do Gestor no celular. A posição de Supervisor(a) de Setor da Produção aparece como disponível desde a sexta-feira, quando o desligamento da supervisora anterior foi concluído no Offboarding. Ele abre uma Requisição de Pessoal para repor a posição: o cargo já traz descrição, requisitos e o custo total da vaga, e ele só anexa a justificativa.',
      'Na terça de manhã, Cláudia Nunes, da Controladoria, recebe a pendência com o previsto e o realizado do centro de custo na mesma tela. A reposição está dentro do orçado e a NATI confirma que não há impacto no realizado. A Diretoria de Operações aprova às 11:30, pelo celular. Um minuto depois, a posição muda para "em recrutamento".',
    ],
    system: [
      'A posição disponível vem do Offboarding e já mostra o custo total: salário base, benefícios e ocorrências.',
      'A requisição passa pela alçada financeira e pela aprovação final, com prazo controlado e histórico de cada etapa.',
      'Aprovada, a posição passa a "em recrutamento" e o ERP financeiro é avisado automaticamente.',
    ],
    modules: [
      { slug: 'administracao-de-pessoal', note: 'posição, custo e orçamento' },
      { slug: 'requisicoes-com-workflow', note: 'Requisição de Pessoal e alçadas' },
      { slug: 'cargos-e-salarios', note: 'requisitos e custo do cargo' },
      { slug: 'portais', note: 'Portal do Gestor' },
      { slug: 'offboarding', note: 'origem da posição vaga' },
      { slug: 'nati', note: 'alerta de orçamento' },
    ],
    visual: 'approval',
  },
  {
    id: 'etapa-02',
    n: 2,
    phase: 1,
    name: 'Recrutamento e Seleção',
    official: 'Criação do processo seletivo para a vaga.',
    when: { day: 'Dia 2', date: 'Ter · 08/09', time: '11:31' },
    title: 'O processo seletivo nasce pronto',
    story: [
      'Juliana Prado, recrutadora da Vale Verde, não cria nada. O processo seletivo apareceu na fila dela no mesmo minuto da aprovação, já ligado ao cargo, ao centro de custo e ao orçamento da vaga. Ela confere as etapas sugeridas, ajusta o questionário para a área de produção, define o prazo de 20 dias e assume como recrutadora responsável.',
    ],
    system: [
      'A requisição aprovada cria o processo seletivo automaticamente, sem cadastro manual.',
      'Etapas, questionários, recrutador responsável e prazo por vaga ficam definidos em uma tela.',
      'O prazo da vaga entra no painel de recrutamento desde o primeiro dia.',
    ],
    modules: [
      { slug: 'recrutamento-e-selecao', note: 'processo, etapas e prazo' },
      { slug: 'requisicoes-com-workflow', note: 'origem do processo' },
      { slug: 'people-analytics', note: 'prazo e funil da vaga' },
    ],
    visual: 'process',
  },
  {
    id: 'etapa-03',
    n: 3,
    phase: 1,
    name: 'Quadro de Vagas',
    official: 'Publicação no JobBoard da empresa.',
    when: { day: 'Dia 2', date: 'Ter · 08/09', time: '14:20' },
    title: 'Publicada com a cara da Vale Verde',
    story: [
      'Com o processo revisado, Juliana publica a vaga. Ela aparece no quadro de vagas da empresa, com as cores e o logotipo da Vale Verde, e não em um site genérico de terceiros. Quem visita a página de carreiras vê a vaga de Supervisor(a) de Setor em Sorocaba com o texto que veio do cadastro do cargo.',
    ],
    system: [
      'A vaga é publicada a partir do processo seletivo, sem redigitar título, descrição ou requisitos.',
      'O quadro de vagas é da empresa: identidade visual própria e candidatura pelo celular.',
    ],
    modules: [
      { slug: 'quadro-de-vagas', note: 'job board com a marca da empresa' },
      { slug: 'recrutamento-e-selecao', note: 'origem do anúncio' },
    ],
    visual: 'jobboard',
  },
  {
    id: 'etapa-04',
    n: 4,
    phase: 1,
    name: 'Portal do Candidato',
    official: 'Candidato se inscreve e preenche informações.',
    when: { day: 'Dia 3', date: 'Qua · 09/09', time: '21:15' },
    title: 'Ana se candidata do sofá',
    story: [
      'Ana Ribeiro tem curso técnico e quatro anos em linha de produção. Ela já tinha cadastrado o currículo no portal da Vale Verde meses antes, em uma vaga que não deu certo. À noite, recebe o aviso da nova vaga no celular, atualiza a experiência mais recente, responde ao questionário da área e aceita os termos de tratamento de dados. Em doze minutos, a inscrição está completa.',
    ],
    system: [
      'O candidato se cadastra, atualiza o currículo, responde a questionários e acompanha cada etapa pelo celular.',
      'Termos de aceite digitais, com histórico e versionamento, conforme a LGPD.',
      'O currículo já fica no banco de talentos para esta e para as próximas vagas.',
    ],
    modules: [
      { slug: 'portais', note: 'Portal do Candidato' },
      { slug: 'recrutamento-e-selecao', note: 'inscrição e questionário' },
      { slug: 'ged', note: 'currículo guardado' },
    ],
    visual: 'candidate',
  },
  {
    id: 'etapa-05',
    n: 5,
    phase: 1,
    name: 'Banco de Talentos',
    official: 'RH seleciona candidatos do pool por skills e cargo.',
    when: { day: 'Dia 4', date: 'Qui · 10/09', time: '09:05' },
    title: 'A NATI lembra de quem já bateu na porta',
    story: [
      'Na manhã seguinte, Juliana abre a vaga e pede à NATI os talentos mais aderentes. A NATI cruza o banco de talentos com os requisitos do cargo e devolve seis nomes, com Ana no topo: formação técnica, experiência em produção e questionário completo. Juliana convoca quatro pessoas para entrevista e o gestor recebe a agenda no portal.',
    ],
    system: [
      'A NATI cruza o banco de talentos com a requisição da vaga e indica os candidatos mais aderentes.',
      'A triagem automatizada acelera o funil sem tirar a decisão do RH.',
    ],
    modules: [
      { slug: 'nati', note: 'matching com o banco de talentos' },
      { slug: 'recrutamento-e-selecao', note: 'banco de talentos e convocação' },
    ],
    visual: 'talent',
  },
  {
    id: 'etapa-06',
    n: 6,
    phase: 1,
    name: 'Processo Seletivo',
    official: 'Triagem, entrevistas e avaliações dos candidatos.',
    when: { day: 'Dia 8 a 10', date: 'Seg · 14/09 a Qua · 16/09', time: '15:00' },
    title: 'Entrevista com o gestor, política salarial por trás',
    story: [
      'Marcos e Juliana entrevistam os quatro candidatos na segunda e na terça. Cada avaliação é registrada na etapa correspondente. Quando Marcos monta a proposta para Ana, o sistema confere o teto salarial, a formação e a experiência exigidas pelo cargo: está tudo dentro da política. Na quarta, às 10:00, Ana é aprovada. O painel de recrutamento mostra a vaga fechada em oito dias, dentro do prazo de vinte.',
    ],
    system: [
      'Avaliações e notas ficam registradas por etapa, com acompanhamento em tempo real pelo gestor.',
      'Os filtros de contratação do cargo (teto salarial, formação, experiência) impedem proposta fora da política.',
      'O painel mostra tempo de fechamento, prazo por vaga e efetividade dos canais.',
    ],
    modules: [
      { slug: 'recrutamento-e-selecao', note: 'etapas, entrevistas e aprovação' },
      { slug: 'cargos-e-salarios', note: 'filtros de contratação' },
      { slug: 'people-analytics', note: 'tempo de fechamento e funil' },
      { slug: 'business-intelligence', note: 'painel do recrutamento' },
    ],
    visual: 'sla',
  },
  {
    id: 'etapa-07',
    n: 7,
    phase: 2,
    name: 'Admissão Digital',
    official: 'Formalização de admissão após o onboarding.',
    when: { day: 'Dia 10', date: 'Qua · 16/09', time: '10:02' },
    title: 'Aprovada, a admissão abre sozinha',
    story: [
      'Dois minutos depois da aprovação, Ana recebe o convite para a admissão no mesmo portal em que se candidatou. Beatriz Lima, do Departamento Pessoal, vê a admissão aparecer na lista dela com o status "aguardando o candidato". Ninguém enviou e-mail com formulário em anexo. Ninguém pediu cópia de documento.',
    ],
    system: [
      'A Admissão Digital nasce do processo seletivo aprovado, ligada à requisição de vaga e ao headcount.',
      'O RH acompanha o status de cada admissão em tempo real e só entra quando precisa validar.',
    ],
    modules: [
      { slug: 'admissao-digital', note: 'admissão aberta automaticamente' },
      { slug: 'recrutamento-e-selecao', note: 'candidato aprovado' },
      { slug: 'portais', note: 'convite no Portal do Candidato' },
    ],
    visual: 'admission',
  },
  {
    id: 'etapa-08',
    n: 8,
    phase: 2,
    name: 'OnBoarding',
    official: 'Preenche dados, documentos pessoais e etc.',
    when: { day: 'Dia 10', date: 'Qua · 16/09', time: '20:10' },
    title: 'Dados preenchidos por quem mais sabe deles',
    story: [
      'À noite, Ana preenche dados pessoais, endereço, dados bancários e o dependente, um filho de seis anos. As validações apontam um dígito errado na agência antes de ela seguir. Depois fotografa RG, CPF, CNH, comprovante de endereço e a certidão de nascimento do filho, tudo pelo celular. Às 20:34, a parte dela está feita.',
    ],
    system: [
      'Coleta eletrônica de dados com validações que evitam erro de digitação.',
      'Documentos fotografados e anexados pelo celular, sem papel.',
      'O dado entra uma vez e vale para folha, ponto, benefícios e SESMT.',
    ],
    modules: [
      { slug: 'admissao-digital', note: 'coleta eletrônica de dados' },
      { slug: 'portais', note: 'Portal do Candidato no celular' },
      { slug: 'ged', note: 'documentos anexados' },
    ],
    visual: 'dataform',
  },
  {
    id: 'etapa-09',
    n: 9,
    phase: 2,
    name: 'Escolha de Benefícios',
    official: 'Colaborador escolhe os benefícios que deseja.',
    when: { day: 'Dia 10', date: 'Qua · 16/09', time: '20:31' },
    title: 'Os benefícios que o cargo dela permite',
    story: [
      'Ainda no portal, Ana vê os benefícios elegíveis para o cargo: plano de saúde com a opção de incluir o filho, vale-transporte, vale-alimentação e previdência privada. Ela inclui o dependente no plano, informa o trajeto para o vale-transporte e deixa a previdência para depois. As escolhas ficam registradas e prontas para virarem rubricas na folha.',
    ],
    system: [
      'Regras de elegibilidade por cargo, unidade e política da empresa aplicadas na hora.',
      'Inclusões e dependentes registrados com histórico, prontos para envio às operadoras.',
      'Descontos e créditos viram rubricas automáticas na folha.',
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
    name: 'GED · Documentos',
    official: 'Todos os documentos armazenados com auditoria.',
    when: { day: 'Dia 15', date: 'Seg · 21/09', time: '09:20' },
    title: 'Beatriz confere tudo em uma tela',
    story: [
      'Na segunda, Beatriz abre a admissão de Ana e confere dados e documentos lado a lado. O comprovante de endereço está ilegível. Ela devolve a pendência com um comentário e Ana, no intervalo do trabalho atual, fotografa de novo. Seis minutos depois, o documento novo está no lugar do antigo, com o histórico de quem viu e alterou o quê.',
    ],
    system: [
      'Documentos organizados por pessoa e por tipo, vinculados ao cadastro.',
      'Pendências devolvidas ao candidato pelo portal, com comentário e prazo.',
      'Acesso por perfil e trilha de auditoria, conforme a LGPD.',
    ],
    modules: [
      { slug: 'ged', note: 'arquivo e auditoria dos documentos' },
      { slug: 'admissao-digital', note: 'validação pelo RH' },
    ],
    visual: 'ged',
  },
  {
    id: 'etapa-11',
    n: 11,
    phase: 2,
    name: 'NatDocs · Assinatura',
    official: 'Contrato assinado online com validade ICP-Brasil.',
    when: { day: 'Dia 15', date: 'Seg · 21/09', time: '12:40' },
    title: 'Contrato assinado no celular, na hora do almoço',
    story: [
      'Com a admissão validada, o contrato de experiência, o termo de uso dos sistemas e as políticas internas chegam para Ana como pendências de assinatura. Ela lê, assina pelo celular e recebe a confirmação na hora. A Vale Verde assina do lado dela. O documento original fica disponível para download e verificação a qualquer momento.',
    ],
    system: [
      'Assinatura eletrônica no padrão ICP-Brasil, com validade jurídica.',
      'Signatários, prazo e status do processo acompanhados pelo RH.',
      'O contrato assinado fica guardado junto aos demais documentos da pessoa.',
    ],
    modules: [
      { slug: 'assinatura-eletronica', note: 'NatDocs, contrato e termos' },
      { slug: 'ged', note: 'guarda do original' },
      { slug: 'portais', note: 'pendência no celular' },
    ],
    visual: 'contract',
  },
  {
    id: 'etapa-12',
    n: 12,
    phase: 2,
    name: 'SESMT · Admissional',
    official: 'ASO e verificação dos EPIs necessários para o cargo.',
    when: { day: 'Dia 16', date: 'Ter · 22/09', time: '08:30' },
    title: 'O exame já sabe o risco da função',
    story: [
      'A guia do exame admissional foi gerada quando Ana entrou na admissão, com base no cargo e nos riscos da vaga. Na clínica, o Dr. Henrique Sales vê o grupo de exposição do setor de produção, ruído e umidade, e o plano de exames que vem dele: clínico e audiometria. Ana está apta. O ASO sai com assinatura digital, e a lista de EPIs exigidos para o cargo já fica separada para o primeiro dia.',
      'Às 09:40, Beatriz aprova a admissão. É o momento em que uma única aprovação atualiza sete lugares ao mesmo tempo.',
    ],
    system: [
      'Do PGR ao GHE, do PCMSO ao ASO: o plano de exames vem do risco da função, não de uma lista genérica.',
      'ASO com assinatura digital, alerta de vencimento e evento de saúde gerado para o eSocial.',
      'Candidato inapto não entra na folha: o bloqueio é automático.',
    ],
    modules: [
      { slug: 'medicina-ocupacional', note: 'guia, exames e ASO' },
      { slug: 'seguranca-do-trabalho', note: 'GHE, riscos e EPIs do cargo' },
      { slug: 'esocial', note: 'S-2220 a partir do ASO' },
      { slug: 'requisicoes-com-workflow', note: 'Requisição de Exames' },
    ],
    visual: 'aso',
  },
  {
    id: 'etapa-13',
    n: 13,
    phase: 3,
    name: 'Portal do Colaborador',
    official: 'Autosserviço: holerite, férias, requisições e mais.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '06:05' },
    title: 'O primeiro dia começa antes de chegar',
    story: [
      'Segunda-feira, 28 de setembro. Ana acorda com o acesso ao Portal do Colaborador já liberado no celular: escala da semana, dados cadastrais, benefícios ativos e o espaço onde o holerite vai aparecer. Ela abre um chamado interno pedindo o crachá de acesso ao setor de qualidade e recebe o número do protocolo. Tudo antes do café.',
    ],
    system: [
      'O portal é liberado na efetivação, com os dados que a própria pessoa preencheu.',
      'Requisições, consultas e chamados ao RH no mesmo lugar, no celular ou no computador.',
    ],
    modules: [
      { slug: 'portais', note: 'Portal do Colaborador' },
      { slug: 'chamado-interno', note: 'pedido do crachá com protocolo' },
    ],
    visual: 'portal',
  },
  {
    id: 'etapa-14',
    n: 14,
    phase: 3,
    name: 'Instruções Iniciais',
    official: 'Orientações em texto, vídeos e materiais por perfil.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '06:40' },
    title: 'Boas-vindas com a cara da empresa',
    story: [
      'No ônibus, Ana assiste ao vídeo de boas-vindas do diretor industrial, lê o código de conduta e vê o mapa da unidade com o refeitório e o vestiário marcados. Um lembrete avisa o que fazer na primeira semana: assinar o termo de EPI, concluir a trilha de entrada, conhecer o time. No blog corporativo, o comunicado de boas-vindas aos admitidos do mês já está no ar.',
    ],
    system: [
      'Onboarding com vídeos, textos, imagens e arquivos por perfil, liberado pela admissão.',
      'Lembretes orientam cada etapa da primeira semana.',
      'Comunicados da empresa no blog corporativo, dentro dos portais.',
    ],
    modules: [
      { slug: 'onboarding', note: 'instruções iniciais por perfil' },
      { slug: 'blog-corporativo', note: 'comunicado de boas-vindas' },
      { slug: 'portais', note: 'tudo no Portal do Colaborador' },
    ],
    visual: 'onboarding',
  },
  {
    id: 'etapa-15',
    n: 15,
    phase: 3,
    name: 'Entrega de EPI',
    official: 'Recebimento conforme cargo e local de trabalho.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '07:30' },
    title: 'Os EPIs certos para o cargo e o local dela',
    story: [
      'Na sala de segurança, Rafael Duarte já tem a lista de Ana na tela do tablet: protetor auricular, óculos de proteção, botina antiderrapante e touca. São os EPIs do grupo de exposição do setor de produção, definidos pelo cargo e pelo local de trabalho, cada um com o certificado de aprovação conferido na base do governo. Ana recebe os itens e assina a ficha de EPI na tela. Nenhum papel para arquivar.',
    ],
    system: [
      'EPIs definidos pelo cargo e pelo local de trabalho, a partir do PGR e do GHE.',
      'Certificado de aprovação validado automaticamente; item vencido não é entregue.',
      'Ficha de EPI assinada digitalmente e guardada com o histórico de entregas e trocas.',
    ],
    modules: [
      { slug: 'seguranca-do-trabalho', note: 'EPIs por cargo e local, CA validado' },
      { slug: 'assinatura-eletronica', note: 'ficha de EPI assinada na tela' },
      { slug: 'ged', note: 'ficha guardada com auditoria' },
    ],
    visual: 'epi',
  },
  {
    id: 'etapa-16',
    n: 16,
    phase: 3,
    name: 'Treinamento',
    official: 'Capacitação no uso correto do EPI e na nova atividade.',
    when: { day: 'Dia 22', date: 'Seg · 28/09', time: '09:00' },
    title: 'A trilha de entrada do cargo já estava matriculada',
    story: [
      'Às nove, Ana entra na sala de treinamento. A matrícula na trilha de entrada de Supervisor(a) de Setor foi feita pelo sistema quando a admissão foi aprovada: integração de segurança, uso e conservação de EPIs, segurança em máquinas, boas práticas de fabricação e, nas próximas semanas, o módulo de liderança de primeiro nível. Presença e certificado ficam registrados, e a validade de cada treinamento obrigatório passa a ser acompanhada pelo SESMT.',
    ],
    system: [
      'Trilha de entrada por cargo, com matrícula automática na admissão.',
      'Treinamentos de NR com validade controlada: sem habilitação, a mudança de cargo é bloqueada.',
      'Presença, carga horária, prova e certificado registrados no perfil da pessoa.',
    ],
    modules: [
      { slug: 'treinamento-e-desenvolvimento', note: 'trilha de entrada do cargo' },
      { slug: 'seguranca-do-trabalho', note: 'treinamentos de NR e validade' },
      { slug: 'cargos-e-salarios', note: 'competências exigidas pelo cargo' },
    ],
    visual: 'training',
  },
  {
    id: 'etapa-17',
    n: 17,
    phase: 4,
    name: 'NatPonto',
    official: 'Marcação de ponto pelo app, com facial e geo.',
    when: { day: 'Todo dia', date: 'a partir de 28/09', time: '06:21' },
    title: 'Todo dia começa com o rosto e o lugar',
    story: [
      'Desde a primeira segunda-feira, a rotina de Ana começa na portaria da unidade, às 06:21. Ela abre o NatPonto, o app reconhece o rosto dela, confirma que está dentro do raio da unidade e registra a marcação. O comprovante, com código de verificação e a localização, fica no celular. Em segundos, a marcação está no Ponto Eletrônico, pronta para a apuração da jornada das 06:30 às 18:00.',
    ],
    system: [
      'Reconhecimento facial e geolocalização com raio por unidade; funciona sem internet e sincroniza depois.',
      'Comprovante de cada marcação com código de verificação e hash.',
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
    id: 'etapa-18',
    n: 18,
    phase: 4,
    name: 'Avaliações',
    official: 'Ciclos de avaliação de desempenho e feedback.',
    when: { day: 'Dia 45 e dia 90', date: 'Qui · 12/11 e Dom · 27/12', time: '' },
    title: 'A experiência vira efetivação sem ninguém lembrar',
    story: [
      'No dia 45, Marcos recebe no Portal do Gestor a avaliação do primeiro período de experiência de Ana. Ele preenche em dez minutos e registra um feedback sobre a organização do turno. No dia 90, a segunda avaliação. Os dois períodos estavam cadastrados no cargo, e a passagem para o contrato por prazo indeterminado é efetivada pelo sistema, sem requisição nem lembrete manual.',
    ],
    system: [
      'Períodos de experiência 1 e 2 parametrizados no cargo, com progressão automática.',
      'Avaliações e feedbacks com perguntas personalizadas pelo RH, respondidos pelo celular.',
      'O histórico de avaliação alimenta carreira, sucessão e treinamento.',
    ],
    modules: [
      { slug: 'avaliacoes-e-feedbacks', note: 'avaliação de experiência e feedback' },
      { slug: 'cargos-e-salarios', note: 'períodos de experiência no cargo' },
      { slug: 'portais', note: 'Portal do Gestor' },
    ],
    visual: 'evaluation',
  },
  {
    id: 'etapa-19',
    n: 19,
    phase: 4,
    name: 'Remunerações',
    official: 'Pagamentos, bônus e PLR processados na folha.',
    when: { day: 'Dia 40', date: 'Sex · 06/11', time: '22:05' },
    title: 'A primeira folha completa, conferida pela NATI',
    story: [
      'Em novembro, a folha de outubro de Ana fecha junto com a dos outros 3.200 colaboradores: horas apuradas pelo ponto, plano de saúde do filho e vale-transporte como rubricas, e o adiantamento que ela pediu pelo WhatsApp com o NatPay, descontado automaticamente. Antes do fechamento, a NATI apontou duas inconsistências na unidade, nenhuma no cadastro dela. À noite, Ana pergunta à NATI quando cai o pagamento e recebe a resposta na hora.',
    ],
    system: [
      'Ponto, benefícios e adiantamentos chegam à folha sem redigitação.',
      'A NATI cruza frequência, benefícios e impostos e aponta inconsistências antes de pagar.',
      'PLR e bônus seguem o ciclo de metas, com cálculo proporcional ao tempo de contrato.',
    ],
    modules: [
      { slug: 'folha-de-pagamento', note: 'cálculo e fechamento' },
      { slug: 'gestao-de-beneficios', note: 'rubricas automáticas' },
      { slug: 'natpay', note: 'adiantamento pelo WhatsApp' },
      { slug: 'nati', note: 'conferência e respostas' },
      { slug: 'metas-e-resultados', note: 'PLR proporcional' },
    ],
    visual: 'nati',
  },
  {
    id: 'etapa-20',
    n: 20,
    phase: 4,
    name: 'Rotinas DP e RH',
    official: 'Atestados, abonos, férias, reembolsos contínuos.',
    when: { day: 'Mês 5', date: 'Qua · 10/02/2027', time: '13:31' },
    title: 'O dia a dia sem e-mail nem planilha',
    story: [
      'Numa quarta de fevereiro, Ana esquece de bater o ponto na volta do almoço. Pelo app, abre uma Requisição de Abono com a justificativa; Marcos aprova no celular no fim do turno, e a marcação é regularizada antes da apuração. Um mês depois, um atestado de um dia enviado pelo portal vai para o prontuário e para a folha. Nada disso passa por e-mail, e tudo fica no histórico da pessoa, pronto para uma auditoria ou para o jurídico, se um dia for preciso.',
    ],
    system: [
      'Abonos, horas extras, férias, atestados e reembolsos como requisições com workflow.',
      'Atestados no prontuário, com fluxo automático para o INSS quando passam de 15 dias.',
      'Histórico completo de ponto, ASO, EPIs e treinamentos disponível para o jurídico trabalhista.',
    ],
    modules: [
      { slug: 'requisicoes-com-workflow', note: 'abono, férias, reembolsos' },
      { slug: 'ponto-eletronico', note: 'regularização da marcação' },
      { slug: 'medicina-ocupacional', note: 'atestado no prontuário' },
      { slug: 'juridico-trabalhista', note: 'histórico pronto para defesa' },
      { slug: 'chamado-interno', note: 'dúvidas com o RH' },
    ],
    visual: 'request',
  },
  {
    id: 'etapa-21',
    n: 21,
    phase: 4,
    name: 'Promoção ou Desligamento',
    official: 'Evolução com Carreira e Sucessão ou OffBoarding.',
    when: { day: 'Ano 1', date: 'Set · 2027', time: '' },
    title: 'Um ano depois, o mapa de sucessão aponta para Ana',
    story: [
      'Na avaliação anual, Ana aparece no mapa de talentos como pronta para a Coordenação de Produção em até um ano. Quando a coordenadora atual é transferida para outra unidade, Marcos abre a Requisição de Promoção. O sistema confere a faixa salarial do novo cargo e a política de mérito, a alçada aprova e a mudança é efetivada na folha e no organograma. Se um dia Ana sair, o Offboarding fecha o ciclo com a mesma calma, e a posição volta ao passo 1 desta história.',
    ],
    system: [
      'Posições-chave, prontidão e risco de perda mapeados com dados de avaliação e desempenho.',
      'Reajuste fora da política é travado; dentro dela, a promoção é efetivada sem redigitar.',
      'O Offboarding cuida do desligamento e devolve a posição ao headcount, reiniciando o fluxo.',
    ],
    modules: [
      { slug: 'carreira-e-sucessao', note: 'mapa de sucessão e prontidão' },
      { slug: 'cargos-e-salarios', note: 'faixa e política de mérito' },
      { slug: 'requisicoes-com-workflow', note: 'Requisição de Promoção' },
      { slug: 'people-analytics', note: 'avaliação anual e indicadores' },
      { slug: 'offboarding', note: 'quando o ciclo se fecha' },
    ],
    visual: 'succession',
  },
]

/** A aprovação da admissão atualiza vários módulos de uma só vez (etapa 12 → 13). */
export const effectivation = {
  when: { day: 'Dia 16', date: 'Ter · 22/09', time: '09:40' },
  title: 'Uma aprovação, sete atualizações',
  text: 'Beatriz aprova a admissão de Ana. Sem exportar arquivo, sem digitar de novo, o cadastro nasce em todos os lugares em que a Vale Verde precisa dele.',
  targets: [
    { slug: 'folha-de-pagamento', note: 'Cadastro criado, salário e rubricas prontos para o primeiro cálculo.' },
    { slug: 'administracao-de-pessoal', note: 'A posição passa a ocupada e o custo realizado atualiza o orçamento.' },
    { slug: 'ponto-eletronico', note: 'Jornada das 06:30 às 18:00 e escala aplicadas; o NatPonto é liberado.' },
    { slug: 'gestao-de-beneficios', note: 'Plano de saúde com dependente, vale-transporte e vale-alimentação ativados.' },
    { slug: 'esocial', note: 'Evento de admissão montado, validado e enviado antes do primeiro dia.' },
    { slug: 'conexao-com-outros-sistemas', note: 'Catraca, ERP e e-mail corporativo avisados automaticamente.' },
    { slug: 'portais', note: 'Portal do Colaborador e onboarding liberados para o dia 28.' },
  ],
  base: { slug: 'infraestrutura-e-seguranca', note: 'Tudo em nuvem, com trilha de auditoria de quem viu e alterou cada dado.' },
}

/** Números da história (para o fechamento). */
export const outcomes = [
  { value: '21', label: 'etapas, da vaga à promoção' },
  { value: '8 dias', label: 'da aprovação da vaga à candidata aprovada' },
  { value: '0', label: 'formulários em papel ou planilhas paralelas' },
  { value: '1 vez', label: 'cada dado foi digitado, por quem mais sabia dele' },
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
    if (s.n === 12) {
      for (const t of effectivation.targets) push(t.slug)
      push(effectivation.base.slug)
    }
  }
  return out
}
