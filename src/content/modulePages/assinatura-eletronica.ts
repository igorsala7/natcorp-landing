import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'assinatura-eletronica',
  name: 'Assinatura Eletrônica',
  group: 'autoatendimento',
  tagline: 'Documentos de RH assinados com [[validade jurídica]], sem imprimir nada.',
  summary:
    'Contrato de trabalho, termos aditivos, espelho de ponto e aviso de férias assinados na tela, no padrão ICP-Brasil. O colaborador assina pelo celular, o RH acompanha por status e o documento original fica disponível para verificação.',
  seo: {
    title: 'Assinatura Eletrônica ICP-Brasil para o RH | Natcorp',
    description:
      'Assinatura eletrônica de documentos de RH com validade jurídica ICP-Brasil: contratos, termos, espelho de ponto e aviso de férias. Perfis, prazos e status.',
  },
  highlights: [
    { value: 'ICP-Brasil', label: 'padrão de validade jurídica em cada documento assinado' },
    { value: '3 perfis', label: 'Master, Operador e Colaborador, cada um com o seu acesso' },
  ],
  benefits: [
    {
      title: 'Segurança jurídica em cada assinatura',
      text: 'Toda assinatura segue o padrão ICP-Brasil. O documento original pode ser baixado e verificado de forma independente, por qualquer pessoa.',
    },
    {
      title: 'Contratação de dias para minutos',
      text: 'O candidato assina o contrato pelo celular, no mesmo ambiente da admissão. Sem trânsito de papel, sem espera por correio ou visita ao RH.',
    },
    {
      title: 'Controle de quem faz o quê',
      text: 'Perfis Master, Operador e Colaborador definem quem cria processos, quem altera prazos e quem apenas assina. A empresa configura conforme a sua hierarquia.',
    },
    {
      title: 'Fim do arquivo físico',
      text: 'O documento assinado fica guardado no sistema, na nuvem, sem espaço físico nem risco de extravio.',
    },
  ],
  features: [
    {
      title: 'Validade jurídica ICP-Brasil',
      text: 'Assinaturas com respaldo legal e rastreabilidade. Os dados trafegam criptografados entre o servidor Natcorp e a chancela oficial.',
      icon: 'shield-check',
    },
    {
      title: 'Documento verificável',
      text: 'O original assinado fica disponível para download e as assinaturas são validáveis em qualquer leitor de PDF, de forma independente.',
      icon: 'check-circle',
    },
    {
      title: 'Todos os documentos do RH',
      text: 'Contrato de trabalho, termos aditivos, espelho de ponto, aviso de férias, termo de aceite de plantão e ficha de EPI (equipamento de proteção individual), entre outros.',
      icon: 'file-signature',
    },
    {
      title: 'Perfis Master, Operador e Colaborador',
      text: 'O Master administra cadastros, prazos e processos. O Operador cria e opera. O colaborador ou candidato vê e assina só o que é dele.',
      icon: 'key',
    },
    {
      title: 'Prazos protegidos',
      text: 'Criado o processo, só quem tem perfil Master ou Administrador altera o prazo final. O cronograma não muda por acidente.',
      icon: 'clock',
    },
    {
      title: 'Acompanhamento por status',
      text: 'Filtre os processos por status, categoria, tipo e subtipo e veja na hora quem já assinou e o que ainda está pendente.',
      icon: 'filter',
    },
    {
      title: 'Signatários de toda a estrutura',
      text: 'De colaboradores ativos a candidatos em admissão, com busca por empresa, filial, centro de custo, perfil ou período e situação em tempo real.',
      icon: 'users',
    },
    {
      title: 'Organograma carregado sozinho',
      text: 'Empresas, filiais e centros de custo entram no módulo automaticamente na implantação e a cada novo cadastro. Zero retrabalho.',
      icon: 'building',
    },
    {
      title: 'Lotes de contratos e vários signatários',
      text: 'Envie o mesmo documento para vários signatários ou crie um lote de contratos de uma vez, como as admissões do mês ou os espelhos de ponto de uma filial. Cada processo do lote aparece por status.',
      icon: 'layers',
    },
    {
      title: 'Integrada à admissão e ao ponto',
      text: 'O contrato é assinado dentro da Admissão Digital. Espelhos de ponto e aceites de plantão chegam prontos para assinatura, com validade legal.',
      icon: 'link',
    },
  ],
  flow: {
    title: 'Do envio ao documento verificado',
    steps: [
      { title: 'Criação do processo', text: 'O operador escolhe o documento, os signatários e o prazo final, um a um ou em lote.' },
      { title: 'Pendência para o signatário', text: 'Colaborador ou candidato recebe a pendência no portal, no celular ou no computador, e vê só o que exige a sua ação.' },
      { title: 'Assinatura e confirmação', text: 'Assina em poucos toques e recebe a confirmação de processamento na hora.' },
      { title: 'Acompanhamento pelo RH', text: 'Status, categoria e tipo mostram quem já assinou. Só o Master altera prazos.' },
      { title: 'Original disponível', text: 'O documento assinado fica guardado e pode ser baixado e validado a qualquer momento.' },
    ],
  },
  compliance: [
    'Assinatura eletrônica no padrão ICP-Brasil, com validade jurídica',
    'Espelho de ponto (Portaria MTP 671/2021) assinado digitalmente',
    'LGPD: acesso por perfil aos documentos e dados do signatário',
  ],
  personas: [
    {
      role: 'RH e Departamento Pessoal',
      text: 'Cria o processo, um a um ou em lote, acompanha por status e para de imprimir, colher assinatura e arquivar papel.',
    },
    {
      role: 'Colaborador e candidato',
      text: 'Vê só as próprias pendências, assina pelo celular e baixa o documento original quando quiser.',
    },
    {
      role: 'Administrador do sistema',
      text: 'Define perfis e acessos conforme a hierarquia da empresa e é o único que altera prazos finais.',
    },
  ],
  faq: [
    {
      q: 'A assinatura tem validade jurídica?',
      a: 'Sim. Ela segue o padrão ICP-Brasil, com validade jurídica e rastreabilidade. O documento original fica disponível para download e as assinaturas podem ser validadas de forma independente em qualquer leitor de PDF.',
    },
    {
      q: 'Quais documentos posso assinar?',
      a: 'Contrato de trabalho, termos aditivos, espelho de ponto, aviso de férias, termo de aceite de plantão, ficha de EPI e outros documentos corporativos que a empresa cadastrar.',
    },
    {
      q: 'Quem pode alterar o prazo de assinatura?',
      a: 'Só usuários com perfil Master ou Administrador. O Operador cria e acompanha processos, mas não altera prazos. O colaborador apenas visualiza e assina os próprios documentos.',
    },
    {
      q: 'Consigo enviar um lote de contratos de uma vez?',
      a: 'Sim. O mesmo documento pode ir para vários signatários, e um lote de contratos, como as admissões do mês ou os espelhos de ponto de uma filial, é criado de uma vez, inclusive para candidatos ainda em admissão. O acompanhamento é por status, categoria e tipo: quem já assinou, o que está pendente e o prazo de cada processo.',
    },
  ],
  related: ['admissao-digital', 'ged', 'ponto-eletronico', 'portais'],
  sources: [
    'gestao-de-assinaturas-eletronicas',
    'admissao-digital',
    'automacao-de-processos',
    'gestao-de-frequencia',
    'paineis-inteligentes',
    'gestao-do-sesmt',
  ],
}

export default page
