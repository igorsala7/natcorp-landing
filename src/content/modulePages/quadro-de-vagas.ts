import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'quadro-de-vagas',
  name: 'Quadro de Vagas',
  group: 'talentos',
  tagline: 'O job board com a [[cara da sua empresa]].',
  summary:
    'Um quadro de vagas com a identidade visual da sua empresa, publicado a partir dos processos seletivos. O candidato vê as vagas abertas, se cadastra, envia o currículo e acompanha cada etapa pelo Portal do Candidato, no celular ou no computador.',
  seo: {
    title: 'Quadro de Vagas whitelabel | Natcorp',
    description:
      'Job board whitelabel para grandes empresas: vagas publicadas direto do processo seletivo, candidatura pelo celular e acompanhamento das etapas pelo candidato.',
  },
  highlights: [],
  benefits: [
    {
      title: 'Marca empregadora desde o primeiro contato',
      text: 'O candidato conhece sua empresa em um quadro de vagas com as suas cores e o seu logotipo, e não em um site genérico de terceiros.',
    },
    {
      title: 'Menos trabalho para o RH',
      text: 'A vaga aprovada no workflow vira anúncio sem retrabalho. Currículos e documentos chegam organizados no sistema e alimentam o banco de talentos.',
    },
    {
      title: 'Candidato informado, RH sem telefonemas',
      text: 'O candidato acompanha inscrição, etapas, avaliações e status pelo Portal do Candidato. Ninguém precisa ligar para saber como está.',
    },
    {
      title: 'Gestor com visão da vaga em tempo real',
      text: 'Quem pediu a vaga vê o status da seleção pelo Portal do Gestor, do anúncio à contratação, sem perguntar ao RH.',
    },
  ],
  features: [
    {
      title: 'Com a marca da sua empresa',
      text: 'Quadro de vagas whitelabel, personalizado com a identidade visual da empresa, para o candidato ver as vagas abertas.',
      icon: 'building',
    },
    {
      title: 'Vagas publicadas do processo seletivo',
      text: 'As vagas vêm do módulo de Recrutamento e Seleção, já ligadas ao cargo aprovado na requisição. Sem anúncio digitado duas vezes.',
      icon: 'briefcase',
    },
    {
      title: 'Vagas de todas as empresas e unidades',
      text: 'As vagas de cada empresa e filial do grupo ficam no mesmo quadro, cada uma vinda do seu processo seletivo. O candidato vê as vagas abertas por empresa e unidade e usa um só cadastro para todas.',
      icon: 'map-pin',
    },
    {
      title: 'Cadastro e currículo do candidato',
      text: 'O candidato cria o perfil, mantém o currículo atualizado e usa o mesmo cadastro para concorrer a outras vagas.',
      icon: 'user-plus',
    },
    {
      title: 'Acompanhamento das etapas',
      text: 'Inscrição, etapas do processo, avaliações e status ficam visíveis no Portal do Candidato. Transparência para candidato, gestor e RH.',
      icon: 'eye',
    },
    {
      title: 'Documentos enviados online',
      text: 'O candidato anexa documentos pelo portal. Se for aprovado, eles seguem para a Admissão Digital e para o GED (Gestão Eletrônica de Documentos).',
      icon: 'upload',
    },
    {
      title: 'Currículos no banco de talentos',
      text: 'Todo currículo recebido vai para o banco de talentos, organizado para vagas futuras e para o matching da NATI.',
      icon: 'database',
    },
    {
      title: 'Vagas internas para quem já é da casa',
      text: 'Abra vagas para candidatos internos. Os colaboradores participam do mesmo processo, com o mesmo acompanhamento.',
      icon: 'users',
    },
    {
      title: 'Link no site e nos canais da empresa',
      text: 'O quadro de vagas fica acessível por link direto, para divulgar no site institucional e nos canais da empresa.',
      icon: 'link',
    },
    {
      title: 'Questionários na candidatura',
      text: 'O processo seletivo pode incluir questionários personalizados e triagem automatizada já na inscrição, como definido em Recrutamento e Seleção. O RH recebe candidatos já classificados.',
      icon: 'clipboard',
    },
  ],
  flow: {
    title: 'Da vaga aberta à candidatura',
    steps: [
      { title: 'Vaga aprovada', text: 'A requisição passa pelo workflow e o processo seletivo é criado.' },
      { title: 'Publicação no quadro', text: 'A vaga aparece no Quadro de Vagas com a marca da empresa.' },
      { title: 'Cadastro e candidatura', text: 'O candidato cria o perfil, envia o currículo e se candidata pelo celular ou computador.' },
      { title: 'Etapas acompanhadas', text: 'Triagem, avaliações e entrevistas com status visível no Portal do Candidato.' },
      { title: 'Aprovado, admissão aberta', text: 'O aprovado segue para a Admissão Digital sem repetir cadastro.' },
    ],
  },
  compliance: ['LGPD: consentimento e acesso por perfil aos dados do candidato', 'Termos de aceite digitais direcionados a candidatos'],
  personas: [
    { role: 'Candidato', text: 'Encontra as vagas, se candidata pelo celular e acompanha cada etapa sem depender de retorno por e-mail.' },
    { role: 'RH e recrutadores', text: 'Publicam vagas a partir do processo seletivo e recebem currículos e documentos já organizados no sistema.' },
    { role: 'Gestor', text: 'Acompanha o status da vaga que pediu, em tempo real, pelo Portal do Gestor.' },
  ],
  faq: [
    {
      q: 'O quadro de vagas pode ter a identidade visual da minha empresa?',
      a: 'Sim. O Quadro de Vagas é whitelabel: leva as cores, o logotipo e a identidade da sua empresa. O candidato vê a sua marca, não a da Natcorp.',
    },
    {
      q: 'Preciso cadastrar a vaga de novo para publicar?',
      a: 'Não. A vaga nasce da requisição aprovada no workflow e do processo seletivo criado em Recrutamento e Seleção. A publicação usa esses dados, sem digitar de novo.',
    },
    {
      q: 'Posso publicar vagas de várias empresas do grupo no mesmo quadro?',
      a: 'Sim. O quadro reúne as vagas de todas as empresas e unidades do grupo, cada uma vinda do seu processo seletivo. O candidato vê as vagas abertas por empresa e unidade, acompanha as etapas pelo Portal do Candidato e usa o mesmo cadastro para concorrer a qualquer uma delas, pelo celular ou pelo computador.',
    },
    {
      q: 'O que acontece com os currículos de quem não foi aprovado?',
      a: 'Ficam no banco de talentos, organizados para vagas futuras. Quando uma nova vaga é aprovada, a NATI cruza o banco com o perfil da vaga e indica candidatos aderentes.',
    },
  ],
  related: ['recrutamento-e-selecao', 'portais', 'admissao-digital', 'ged'],
  sources: ['gestao-de-rh', 'abrangencia-do-sistema', 'apresentacao-natcorp', 'paineis-inteligentes', 'csc-bpo'],
}

export default page
