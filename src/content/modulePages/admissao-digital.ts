import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'admissao-digital',
  name: 'Admissão Digital',
  group: 'talentos',
  tagline: 'A admissão que leva [[minutos, não dias]].',
  summary:
    'O candidato preenche os próprios dados, anexa os documentos e assina o contrato eletronicamente. O RH valida e admite em poucos cliques. Folha, ponto e benefícios já nascem prontos, sem papel e sem digitar nada de novo.',
  seo: {
    title: 'Admissão Digital sem papel | Natcorp',
    description:
      'Admissão digital para grandes empresas: dados e documentos pelo portal, assinatura com validade jurídica e cadastro direto na folha, sem papel e sem redigitar.',
  },
  highlights: [
    { value: '1 vez', label: 'o colaborador é cadastrado e já existe em todos os módulos' },
    { value: '5 passos', label: 'do candidato aprovado ao cadastro na folha, sem papel' },
  ],
  benefits: [
    {
      title: 'Tempo de contratação de dias para minutos',
      text: 'O candidato faz a parte dele no portal, o RH só valida. A vaga fecha mais rápido e a pessoa começa a trabalhar antes.',
    },
    {
      title: 'Zero digitação, zero retrabalho',
      text: 'Os dados coletados na admissão alimentam a folha, o ponto, os benefícios e o SESMT. Ninguém redigita um CPF.',
    },
    {
      title: 'Conformidade desde o primeiro dia',
      text: 'Validação automática de dados obrigatórios, tratamento conforme a LGPD e contrato assinado com validade jurídica.',
    },
    {
      title: 'Uma experiência que já começa bem',
      text: 'O novo colaborador percebe organização e cuidado antes mesmo do primeiro dia, com a marca da sua empresa em cada tela.',
    },
  ],
  features: [
    {
      title: 'Coleta eletrônica de dados',
      text: 'O candidato preenche dados pessoais, bancários, dependentes e endereço no Portal do Candidato, com validações que evitam erro.',
      icon: 'clipboard',
    },
    {
      title: 'Documentos no GED',
      text: 'RG, CPF, comprovante de endereço, CNH, reservista, currículo e documentos de dependentes anexados e organizados no GED (Gestão Eletrônica de Documentos).',
      icon: 'folder',
    },
    {
      title: 'Validação pelo RH',
      text: 'O RH confere o que foi enviado em uma única tela, devolve pendências ao candidato e aprova quando está tudo certo.',
      icon: 'user-check',
    },
    {
      title: 'Assinatura eletrônica do contrato',
      text: 'Contrato de trabalho, termos e políticas assinados digitalmente, com validade jurídica e verificação do documento.',
      icon: 'file-signature',
    },
    {
      title: 'Integração nativa com a folha',
      text: 'Aprovada a admissão, o cadastro é criado na folha, no ponto e nos benefícios automaticamente. Sem exportar nem importar.',
      icon: 'wallet',
    },
    {
      title: 'Ligado à requisição de vaga',
      text: 'A admissão nasce do processo seletivo aprovado no workflow e atualiza o headcount e o orçamento de pessoal.',
      icon: 'workflow',
    },
    {
      title: 'LGPD por desenho',
      text: 'Consentimento, acesso por perfil e trilha de auditoria sobre quem viu e alterou cada dado do candidato.',
      icon: 'shield-check',
    },
    {
      title: 'No celular ou no computador',
      text: 'O candidato conclui a admissão de onde estiver. O RH acompanha o status de cada pessoa em tempo real.',
      icon: 'smartphone',
    },
  ],
  flow: {
    title: 'Da aprovação do candidato ao primeiro dia',
    steps: [
      { title: 'Candidato aprovado', text: 'O processo seletivo termina e o sistema abre a admissão automaticamente.' },
      { title: 'Preenchimento no portal', text: 'O candidato informa os dados e anexa os documentos pelo Portal do Candidato.' },
      { title: 'Validação do RH', text: 'O RH confere, pede ajustes se precisar e aprova em poucos cliques.' },
      { title: 'Assinatura eletrônica', text: 'Contrato e termos são assinados digitalmente, com validade jurídica.' },
      { title: 'Admitido na folha', text: 'Cadastro criado na folha, no ponto, nos benefícios e no SESMT. Onboarding liberado.' },
    ],
  },
  compliance: ['LGPD', 'Assinatura eletrônica com validade jurídica (padrão ICP-Brasil)', 'eSocial: evento de admissão gerado a partir do cadastro'],
  personas: [
    { role: 'RH e Departamento Pessoal', text: 'Deixa de digitar cadastro e conferir cópia de documento. Valida, aprova e acompanha o status de cada admissão.' },
    { role: 'Candidato', text: 'Resolve tudo pelo celular, no seu tempo, sem imprimir nem levar papel na empresa.' },
    { role: 'Gestor', text: 'Vê quando a pessoa que pediu na requisição de vaga vai começar, sem perguntar ao RH.' },
  ],
  faq: [
    {
      q: 'A assinatura eletrônica do contrato tem validade jurídica?',
      a: 'Sim. A assinatura segue o padrão ICP-Brasil, com validade jurídica, e o documento assinado pode ser baixado e verificado a qualquer momento.',
    },
    {
      q: 'Os dados da admissão precisam ser digitados de novo na folha?',
      a: 'Não. A integração com a folha é nativa: aprovada a admissão, o cadastro é criado na folha, no ponto, nos benefícios e no SESMT sem nenhuma redigitação.',
    },
    {
      q: 'O candidato consegue fazer a admissão pelo celular?',
      a: 'Sim. O Portal do Candidato é responsivo e funciona no celular, no tablet e no computador. Os documentos podem ser fotografados e anexados na hora.',
    },
    {
      q: 'Como fica a LGPD nos dados do candidato?',
      a: 'O tratamento segue a LGPD: consentimento no portal, acesso por perfil, anonimização quando aplicável e trilha de auditoria de quem acessou cada informação.',
    },
  ],
  related: ['recrutamento-e-selecao', 'assinatura-eletronica', 'ged', 'onboarding'],
  sources: ['admissao-digital', 'performance-e-seguranca', 'gestao-de-rh', 'automacao-de-processos'],
}

export default page
