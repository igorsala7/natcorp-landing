import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'conexao-com-outros-sistemas',
  name: 'Conexão com Outros Sistemas',
  group: 'dados-ia-plataforma',
  tagline: 'O RH conversa com [[todos os sistemas da empresa]].',
  summary:
    'ERP, financeiro, controle de acesso, operadoras de benefícios e relógios de ponto conectados ao RH. APIs prontas, construtor de APIs pelo próprio usuário, arquivos e avisos automáticos: o dado entra uma vez e circula sem redigitação.',
  seo: {
    title: 'Conexão com Outros Sistemas e APIs de RH | Natcorp',
    description:
      'Conecte o RH a ERPs, financeiro, operadoras de benefícios, relógios de ponto e login corporativo com APIs prontas, construtor de APIs, arquivos e webhooks.',
  },
  highlights: [
    { value: 'minutos', label: 'para conectar com APIs prontas, em vez de meses' },
    { value: '4', label: 'caminhos de conexão: APIs, construtor, arquivos e eventos' },
    { value: '0', label: 'digitação dupla: o dado entra uma vez e circula' },
  ],
  benefits: [
    {
      title: 'Fim da digitação dupla',
      text: 'Admissão, férias, desligamento e folha fluem para o ERP, o financeiro e as operadoras sem alguém redigitar. O RH vira a fonte única da verdade.',
    },
    {
      title: 'Integração em minutos, não em meses',
      text: 'APIs prontas para os dados operacionais padrão e para o login corporativo. Sua TI conecta o que já existe sem projeto de desenvolvimento.',
    },
    {
      title: 'Autonomia para conectar o que for preciso',
      text: 'Quando a opção pronta não resolve, o próprio usuário cria a API da tabela que precisa, para consultar ou inserir dados, em ambiente isolado e seguro.',
    },
    {
      title: 'Menos manutenção para a TI',
      text: 'Menos integrações quebradas a cada atualização e liberdade para trocar sistemas legados no futuro sem parar o RH.',
    },
  ],
  features: [
    {
      title: 'APIs prontas para uso',
      text: 'Pontos de conexão pré-mapeados para os dados operacionais mais usados, com protocolos de segurança nativos. Conecte em minutos, sem desenvolvimento.',
      icon: 'plug',
    },
    {
      title: 'Construtor de APIs',
      text: 'O próprio usuário publica APIs das tabelas que quiser, para consultar ou inserir dados, escolhendo só os campos necessários. Tudo em ambiente isolado.',
      icon: 'layers',
    },
    {
      title: 'Importação de arquivos',
      text: 'Recebe arquivos TXT, CSV e XML de ERPs antigos ou sistemas locais, valida o formato antes de gravar e converte o layout para a estrutura do RH.',
      icon: 'upload',
    },
    {
      title: 'Exportação de dados',
      text: 'Gera arquivos TXT, CSV e XML e exporta consultas e relatórios para Excel, para alimentar contabilidade, BI e outros sistemas.',
      icon: 'download',
    },
    {
      title: 'Avisos automáticos (webhooks)',
      text: 'O sistema avisa os outros sistemas quando algo muda, como admissão, demissão ou férias. Sincronização nos dois sentidos, sem consulta manual.',
      icon: 'bell',
    },
    {
      title: 'Login corporativo (SSO)',
      text: 'Integração com o Active Directory e login único da empresa. O colaborador entra com a senha que já usa e o acesso segue as regras de TI.',
      icon: 'key',
    },
    {
      title: 'ERP, financeiro e contabilidade',
      text: 'Contabilização da folha com provisões e informações de crédito para pagamento enviadas aos sistemas financeiros e ao ERP.',
      icon: 'building',
    },
    {
      title: 'Operadoras de benefícios',
      text: 'Pedidos de compra e movimentações enviados às operadoras por integração, com arquivos para vale-transporte e API para consignado.',
      icon: 'receipt',
    },
    {
      title: 'Relógios de ponto e catracas',
      text: 'Marcações de relógios de ponto, catracas e sistemas de controle de acesso entram por API direto no Ponto Eletrônico, prontas para apurar.',
      icon: 'clock',
    },
    {
      title: 'BI e plataformas de treinamento',
      text: 'Dados disponíveis para as ferramentas de BI da empresa e integração aberta com plataformas de ensino (LMS) e provedores de conteúdo.',
      icon: 'bar-chart',
    },
  ],
  flow: {
    title: 'Como uma integração acontece',
    steps: [
      { title: 'O sistema de origem envia', text: 'Um ERP, uma catraca ou outro sistema dispara o dado para a Natcorp.' },
      { title: 'Acesso validado', text: 'A identidade e a permissão são conferidas antes de qualquer processamento.' },
      { title: 'Dado recebido e checado', text: 'A API recebe a informação, confere o formato e valida o conteúdo.' },
      { title: 'Resposta em milissegundos', text: 'O sistema de origem recebe a confirmação e o dado já está no RH.' },
      { title: 'Outros sistemas avisados', text: 'Se a mudança interessa a outro sistema, o RH avisa automaticamente.' },
    ],
  },
  personas: [
    { role: 'CTO e TI', text: 'Conecta ERP, Active Directory e sistemas legados com APIs prontas, mantém a governança e gasta menos horas consertando integrações.' },
    { role: 'RH e Departamento Pessoal', text: 'Publica a API da tabela que precisa ou importa o arquivo do sistema antigo sem abrir chamado para a TI.' },
    { role: 'Financeiro e Contabilidade', text: 'Recebe a contabilização da folha e as informações de pagamento direto no ERP, sem planilha intermediária.' },
  ],
  faq: [
    {
      q: 'Preciso de um projeto de desenvolvimento para integrar?',
      a: 'Não para o básico. As APIs prontas cobrem os dados operacionais padrão e o login corporativo, e ficam ativas em minutos. Para regras exclusivas, o construtor de APIs permite criar pontos de conexão sob medida sem sair do ambiente seguro da Natcorp.',
    },
    {
      q: 'O próprio usuário do RH consegue criar uma API?',
      a: 'Sim. No módulo de importação e exportação de dados, o usuário escolhe a tabela e os campos e publica uma API para consultar ou inserir informações, sem depender de TI. Tudo roda em ambiente isolado, com a governança mantida.',
    },
    {
      q: 'Meu sistema antigo só exporta arquivos. Funciona?',
      a: 'Sim. A importação de arquivos recebe TXT, CSV e XML, identifica erros de formatação antes de gravar e converte o layout para a estrutura do RH. É o caminho ideal para ERPs legados.',
    },
    {
      q: 'Como o RH avisa os outros sistemas quando algo muda?',
      a: 'Por webhooks e eventos. Quando ocorre uma admissão, um desligamento ou férias, a Natcorp avisa ativamente os sistemas configurados, sem esperar consulta. A sincronização é bidirecional e elimina intervenções manuais.',
    },
  ],
  related: ['infraestrutura-e-seguranca', 'ponto-eletronico', 'gestao-de-beneficios', 'people-analytics'],
  sources: ['integracoes', 'csc-bpo', 'abrangencia-do-sistema', 'tecnologia', 'apresentacao-natcorp', 'gestao-de-beneficios', 'gestao-de-treinamentos'],
}

export default page
