import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'ged',
  name: 'GED',
  group: 'autoatendimento',
  tagline: 'Todos os documentos de RH [[em um só lugar]], sem pasta nem arquivo morto.',
  summary:
    'RG, CPF, comprovante de endereço, CNH, reservista, currículo e certidões dos dependentes digitalizados e organizados por pessoa. O candidato envia pelo celular, o RH valida e cada documento fica acessível conforme o perfil, com a LGPD respeitada.',
  seo: {
    title: 'GED: gestão eletrônica de documentos de RH | Natcorp',
    description:
      'Gestão eletrônica de documentos de colaboradores, candidatos e dependentes: envio pelo celular, busca instantânea, nuvem segura e acesso por perfil (LGPD).',
  },
  highlights: [],
  benefits: [
    {
      title: 'Fim do espaço físico e do extravio',
      text: 'Nenhuma pasta, nenhum armário. Todo documento fica digitalizado, guardado em nuvem segura e localizado em segundos.',
    },
    {
      title: 'O documento nasce digital na admissão',
      text: 'O candidato fotografa e envia RG, CPF e comprovantes pelo Portal do Candidato. O RH valida e o GED (Gestão Eletrônica de Documentos) já está montado no primeiro dia.',
    },
    {
      title: 'LGPD com acesso por perfil',
      text: 'Cada pessoa vê apenas o que o seu perfil permite, com restrição por empresa e filial e aos dados confidenciais. As ações no sistema ficam auditadas.',
    },
    {
      title: 'Evidência pronta para o jurídico',
      text: 'Contratos, fichas e comprovantes ficam rastreáveis. Na hora de uma defesa trabalhista, a evidência sai do sistema, não de uma caixa.',
    },
  ],
  features: [
    {
      title: 'Documentos do colaborador e do candidato',
      text: 'RG, CPF, comprovante de endereço, CNH, reservista, currículo e demais documentos pessoais organizados por pessoa.',
      icon: 'folder',
    },
    {
      title: 'Documentos dos dependentes',
      text: 'Certidão de nascimento, certidão de casamento e outros comprovantes dos dependentes ligados ao cadastro do titular.',
      icon: 'users',
    },
    {
      title: 'Pendências por admissão e por unidade',
      text: 'O RH vê o que falta em cada admissão e em cada unidade, devolve a pendência a quem precisa completar e valida o que chegou. O envio é pelo portal, no celular ou no computador, sem cópia em papel.',
      icon: 'list-checks',
    },
    {
      title: 'Busca instantânea',
      text: 'Armazenamento centralizado com localização imediata por pessoa ou tipo de documento. Nada de procurar em pasta.',
      icon: 'search',
    },
    {
      title: 'Nuvem segura',
      text: 'Documentos digitalizados na hora e guardados em nuvem segura, com cópia de segurança e plano de contingência.',
      icon: 'cloud',
    },
    {
      title: 'Acesso por perfil e LGPD',
      text: 'Controle de quem vê cada documento, com restrição por empresa e filial e aos dados confidenciais, conforme a LGPD.',
      icon: 'lock',
    },
    {
      title: 'Integrado à Admissão Digital',
      text: 'A documentação admissional é digitalizada na entrada e já fica vinculada ao cadastro que alimenta a folha.',
      icon: 'user-plus',
    },
    {
      title: 'Documentos assinados ficam guardados',
      text: 'Contratos, termos e espelhos assinados eletronicamente ficam no GED, com o original disponível para download.',
      icon: 'file-signature',
    },
    {
      title: 'Consulta pelo próprio colaborador',
      text: 'No Portal do Colaborador, a pessoa consulta os próprios documentos funcionais sem abrir chamado no RH.',
      icon: 'eye',
    },
    {
      title: 'Evidências para o Jurídico Trabalhista',
      text: 'Prontuários enxutos e rastreáveis, com armazenamento eletrônico das evidências usadas em processos trabalhistas.',
      icon: 'gavel',
    },
  ],
  flow: {
    title: 'Do envio à consulta segura',
    steps: [
      { title: 'Envio pelo portal', text: 'Candidato ou colaborador fotografa e anexa o documento pelo celular ou computador.' },
      { title: 'Validação pelo RH', text: 'O RH confere o que chegou e devolve pendências se algo faltar.' },
      { title: 'Arquivo no GED', text: 'O documento fica vinculado ao cadastro da pessoa, organizado por tipo.' },
      { title: 'Consulta por perfil', text: 'RH, gestor e o próprio colaborador acessam conforme o perfil, com auditoria das ações.' },
    ],
  },
  compliance: ['LGPD: acesso por perfil, restrição por empresa e filial e a dados confidenciais'],
  personas: [
    {
      role: 'RH e Departamento Pessoal',
      text: 'Recebe, valida e localiza documentos sem manusear papel. Sabe na hora o que falta em cada admissão e em cada unidade.',
    },
    {
      role: 'Colaborador e candidato',
      text: 'Envia os documentos pelo celular e consulta os próprios arquivos no portal quando precisar.',
    },
    {
      role: 'Jurídico',
      text: 'Encontra contratos, fichas e comprovantes rastreáveis para montar a defesa a partir da fonte original.',
    },
  ],
  faq: [
    {
      q: 'Quais documentos o GED guarda?',
      a: 'Documentos de colaboradores e candidatos, como RG, CPF, comprovante de endereço, CNH, reservista e currículo, e dos dependentes, como certidão de nascimento e de casamento. Contratos e termos assinados eletronicamente também ficam guardados.',
    },
    {
      q: 'Como o RH sabe o que falta na documentação de uma admissão?',
      a: 'Na própria tela de validação. O candidato fotografa e envia pelo Portal do Candidato, no celular ou no computador; o RH confere o que chegou, devolve a pendência para quem precisa completar e aprova quando está tudo certo. A visão é por pessoa e por unidade, e o arquivo já fica no GED ligado ao cadastro.',
    },
    {
      q: 'Quem tem acesso aos documentos?',
      a: 'Quem o perfil permitir. O acesso pode ser restrito por empresa, por filial e a dados confidenciais, conforme a LGPD, com auditoria das ações no sistema.',
    },
    {
      q: 'Os documentos assinados eletronicamente ficam no GED?',
      a: 'Sim. O documento assinado fica guardado com o original disponível para download e validação independente das assinaturas.',
    },
  ],
  related: ['admissao-digital', 'assinatura-eletronica', 'infraestrutura-e-seguranca', 'juridico-trabalhista'],
  sources: [
    'admissao-digital',
    'automacao-de-processos',
    'gestao-de-assinaturas-eletronicas',
    'apresentacao-natcorp',
    'csc-bpo',
    'performance-e-seguranca',
    'produtividade-de-rh',
    'paineis-inteligentes',
  ],
}

export default page
