import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'blog-corporativo',
  name: 'Blog Corporativo',
  group: 'autoatendimento',
  tagline: 'A comunicação da empresa em [[um canal único]], dentro do sistema de RH.',
  summary:
    'Avisos, comunicados, vídeos, imagens e arquivos publicados em uma linha do tempo que o colaborador vê nos portais que já usa. O RH escreve, agenda a publicação e define quem recebe. Sem mural, sem e-mail perdido.',
  seo: {
    title: 'Blog Corporativo: intranet em timeline | Natcorp',
    description:
      'Intranet em formato de timeline dentro do sistema de RH: avisos, comunicados, vídeos do YouTube, imagens e arquivos com agendamento e público por perfil.',
  },
  highlights: [],
  benefits: [
    {
      title: 'Todo mundo recebe a mesma mensagem',
      text: 'Um canal único para a comunicação institucional. O comunicado sai do RH e chega igual para toda a empresa, no portal, sem depender de repasse.',
    },
    {
      title: 'Engajamento desde o dia zero',
      text: 'Boas-vindas, instruções iniciais e vídeos de acolhimento ficam na timeline. Quem chega entende a empresa antes de precisar perguntar.',
    },
    {
      title: 'Menos e-mail, mais alcance',
      text: 'A publicação aparece para quem usa o portal no celular ou no computador, inclusive para quem está na operação e não abre e-mail.',
    },
    {
      title: 'Nenhuma ferramenta à parte',
      text: 'O blog vive dentro do mesmo sistema de RH, com o mesmo acesso dos portais. Nada extra para comprar, integrar ou manter.',
    },
  ],
  features: [
    {
      title: 'Linha do tempo de comunicados',
      text: 'Avisos e comunicados publicados em ordem cronológica, como uma timeline. O colaborador abre o portal e vê o que há de novo primeiro.',
      icon: 'layout-grid',
    },
    {
      title: 'Vídeos, inclusive do YouTube',
      text: 'Publique vídeos gravados pela empresa ou incorpore um vídeo do YouTube. O colaborador assiste sem sair do portal.',
      icon: 'link',
    },
    {
      title: 'Imagens, arquivos e textos',
      text: 'Cada post aceita texto, imagens e anexos, como políticas, manuais e informativos que a empresa quer deixar à mão.',
      icon: 'file-text',
    },
    {
      title: 'Agendamento de publicação',
      text: 'Escreva hoje, publique na data certa. O post entra na timeline sozinho no dia e na hora programados.',
      icon: 'calendar',
    },
    {
      title: 'Público por perfil',
      text: 'Escolha se o post aparece para toda a empresa ou só para um perfil, como gestores ou colaboradores, cada um no seu portal.',
      icon: 'users',
    },
    {
      title: 'Nos portais que a pessoa já usa',
      text: 'O blog aparece no Portal do Colaborador e no Portal do Gestor, no celular ou no computador, com o mesmo login do sistema.',
      icon: 'smartphone',
    },
    {
      title: 'E-mails, alertas e lembretes',
      text: 'Além do blog, o sistema dispara e-mails, alertas e lembretes. A mesma comunicação chega por mais de um caminho.',
      icon: 'bell',
    },
    {
      title: 'Instruções iniciais para quem chega',
      text: 'Boas-vindas, regras da casa e primeiros passos publicados para o novo colaborador, junto com o Onboarding.',
      icon: 'user-plus',
    },
    {
      title: 'Lembretes contextuais da NATI',
      text: 'A NATI personaliza e distribui lembretes de acordo com a etapa da jornada de cada colaborador.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Do rascunho à leitura no portal',
    steps: [
      { title: 'Criar o post', text: 'O RH escreve o texto e anexa vídeo, imagem ou arquivo.' },
      { title: 'Definir público e data', text: 'Escolhe quem vai ver e agenda a publicação.' },
      { title: 'Publicação automática', text: 'No dia marcado, o post entra na timeline dos portais.' },
      { title: 'Leitura onde a pessoa estiver', text: 'Colaboradores e gestores leem no celular ou no computador.' },
    ],
  },
  personas: [
    {
      role: 'RH e Comunicação Interna',
      text: 'Publica uma vez e alcança toda a empresa. Agenda campanhas, comunicados e vídeos sem depender de TI nem de mural.',
    },
    {
      role: 'Colaborador',
      text: 'Abre o portal e encontra os avisos, os vídeos e os arquivos da empresa no mesmo lugar do holerite e do ponto.',
    },
    {
      role: 'Gestor',
      text: 'Recebe os comunicados direcionados à liderança e repassa menos informação de mão em mão para a equipe.',
    },
  ],
  faq: [
    {
      q: 'Dá para publicar vídeos do YouTube?',
      a: 'Sim. O post aceita vídeos e links do YouTube, além de imagens, arquivos e textos. O colaborador assiste dentro do próprio portal.',
    },
    {
      q: 'Consigo agendar uma publicação?',
      a: 'Sim. Você escreve o post, define a data e a hora, e ele entra na timeline automaticamente. Serve para campanhas, feriados e comunicados com data marcada.',
    },
    {
      q: 'Onde o colaborador vê o blog?',
      a: 'Nos portais internos do sistema, no celular ou no computador, com o mesmo login. Não é preciso instalar outra ferramenta nem lembrar outra senha.',
    },
    {
      q: 'O blog substitui o e-mail?',
      a: 'Ele centraliza a comunicação institucional em um canal único. Quando precisar, o sistema também dispara e-mails, alertas e lembretes, inclusive personalizados pela NATI conforme a etapa da jornada do colaborador.',
    },
  ],
  related: ['portais', 'onboarding', 'chamado-interno', 'nati'],
  sources: ['gestao-de-rh', 'abrangencia-do-sistema', 'apresentacao-natcorp', 'performance-e-seguranca'],
}

export default page
