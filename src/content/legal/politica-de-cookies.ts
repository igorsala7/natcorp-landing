import type { LegalDoc } from './types'

/**
 * Política de Cookies.
 *
 * Diferente dos outros dois documentos, este não é transcrição: o site antigo não tinha
 * uma página de cookies publicada, e o comportamento descrito aqui é o do site NOVO,
 * lido do código que o implementa (src/lib/consent.ts e src/lib/analytics.ts).
 *
 * O que o código faz, e que esta página afirma:
 *   - nada de rastreamento antes do aceite. GTM e Meta Pixel só são carregados depois,
 *     porque a própria requisição a googletagmanager.com já identificaria o visitante;
 *   - a escolha fica em localStorage (`natcorp:consentimento`), não em cookie;
 *   - a escolha vale 180 dias e depois volta a ser pergunta;
 *   - sem ID configurado, a tag não carrega — homologação não polui produção.
 *
 * Se o comportamento do código mudar, esta página tem de mudar junto. É uma declaração
 * pública sobre tratamento de dados, não texto de marketing.
 */
export const politicaDeCookies: LegalDoc = {
  path: '/politica-de-cookies',
  title: 'Política de Cookies',
  lead: 'O que guardamos no seu navegador, por quanto tempo e como você muda de ideia a qualquer momento.',
  updated: '9 de setembro de 2026',
  seo: {
    title: 'Política de Cookies | Natcorp',
    description:
      'Quais cookies e tecnologias o site da Natcorp usa, o que cada um faz e por quanto tempo dura. Nenhuma tag de medição ou marketing carrega antes do seu aceite.',
  },
  intro: [
    {
      t: 'note',
      title: 'Nada carrega antes do seu aceite',
      text: 'Enquanto você não responde à barra de consentimento, este site não carrega Google Tag Manager, Meta Pixel nem qualquer outra tag de medição ou marketing. Não é que elas venham desligadas: elas não são requisitadas. A diferença importa, porque a simples requisição a um servidor de terceiro já entregaria o seu endereço de IP e a página que você está vendo.',
    },
    {
      t: 'p',
      text: 'Esta Política de Cookies explica quais tecnologias de armazenamento e rastreamento o site da Natcorp utiliza, com que finalidade, por quanto tempo e como você controla cada uma delas. Ela complementa a nossa Política de Privacidade, que descreve o tratamento de dados pessoais de forma mais ampla.',
    },
    {
      t: 'p',
      text: 'Ela vale para o site institucional www.natcorp.com.br. Os portais de acesso dos clientes e o sistema Natcorp são ambientes autenticados, com cookies de sessão próprios, necessários para manter você conectado — esses são tratados no contrato com a empresa contratante.',
    },
  ],
  sections: [
    {
      id: 'o-que-sao',
      title: 'O que são cookies e tecnologias similares',
      blocks: [
        {
          t: 'p',
          text: 'Cookies são pequenos arquivos de texto que um site grava no seu navegador para lembrar de alguma coisa entre uma página e outra, ou entre uma visita e outra. Tecnologias similares — como localStorage, sessionStorage, pixels e sinalizadores da web (web beacons) — fazem a mesma coisa por outros meios.',
        },
        {
          t: 'p',
          text: 'Eles podem ser definidos pelo próprio site que você está visitando (primeira parte) ou por um serviço de terceiro carregado dentro dele (terceira parte), como uma ferramenta de medição de audiência ou de publicidade.',
        },
        {
          t: 'p',
          text: 'Quanto à duração, um cookie de sessão é apagado quando você fecha o navegador; um cookie persistente fica até a data de validade dele ou até você apagá-lo.',
        },
      ],
    },
    {
      id: 'como-pedimos',
      title: 'Como pedimos o seu consentimento',
      blocks: [
        {
          t: 'p',
          text: 'Na sua primeira visita, uma barra aparece na parte de baixo da tela com duas opções claras — Aceitar e Recusar — e um link para esta política. Nenhuma das duas vem pré-selecionada, e fechar a página sem responder equivale a não consentir.',
        },
        {
          t: 'ul',
          items: [
            'Se você recusar: nada além do essencial é gravado, e nenhuma tag de terceiro é carregada. O site funciona normalmente.',
            'Se você aceitar: as tags de medição e marketing descritas abaixo passam a ser carregadas.',
            'A sua escolha vale por 180 dias. Depois disso, perguntamos de novo — consentimento não é para sempre.',
            'Você pode mudar de ideia a qualquer momento, nos dois sentidos, pelo botão desta página ou pelo link “Cookies” no rodapé do site.',
          ],
        },
        {
          t: 'note',
          title: 'Uma observação técnica honesta',
          text: 'Depois que uma tag de terceiro é carregada em uma página, não há como descarregá-la daquela sessão. Por isso, quando você revoga o consentimento, a mudança passa a valer no próximo carregamento de página — e é também por isso que a recusa é respeitada antes, e não depois.',
        },
        { t: 'consent' },
      ],
    },
    {
      id: 'necessarios',
      title: 'Necessários — sempre ativos',
      blocks: [
        {
          t: 'p',
          text: 'São os que permitem ao site lembrar da sua própria decisão sobre cookies. Sem eles, a barra de consentimento reapareceria a cada página. Não identificam você, não saem do seu navegador e não dependem de consentimento, conforme o Art. 7º da LGPD.',
        },
        {
          t: 'table',
          head: ['Nome', 'Tipo', 'Definido por', 'Para quê', 'Duração'],
          rows: [
            [
              'natcorp:consentimento',
              'localStorage',
              'Natcorp (primeira parte)',
              'Guarda se você aceitou ou recusou e a data da escolha.',
              '180 dias',
            ],
          ],
        },
        {
          t: 'p',
          text: 'Optamos por localStorage em vez de cookie de propósito: a escolha é do seu navegador, não precisa ser enviada ao servidor a cada requisição, e um cookie para lembrar da recusa de cookies seria uma contradição desnecessária.',
        },
      ],
    },
    {
      id: 'medicao',
      title: 'Medição de audiência — só com o seu aceite',
      blocks: [
        {
          t: 'p',
          text: 'Servem para entender como o site é usado — quais páginas são vistas, por quanto tempo, por qual caminho — e melhorar o conteúdo a partir disso. São carregados por meio do Google Tag Manager, um contêiner que aciona as tags de medição configuradas pela Natcorp.',
        },
        {
          t: 'table',
          head: ['Nome', 'Definido por', 'Para quê', 'Duração'],
          rows: [
            [
              '_ga',
              'Google (terceira parte)',
              'Distingue visitantes atribuindo um identificador aleatório.',
              '2 anos',
            ],
            [
              '_ga_<ID>',
              'Google (terceira parte)',
              'Mantém o estado da sessão no Google Analytics 4.',
              '2 anos',
            ],
            [
              '_gid',
              'Google (terceira parte)',
              'Distingue visitantes ao longo de um dia.',
              '24 horas',
            ],
            [
              '_gat',
              'Google (terceira parte)',
              'Limita a taxa de requisições enviadas ao servidor de medição.',
              '1 minuto',
            ],
          ],
        },
        {
          t: 'p',
          text: 'O Google Tag Manager é um contêiner: as tags que ele aciona são definidas na configuração mantida pela Natcorp e podem mudar ao longo do tempo. A lista acima corresponde às tags de medição do Google Analytics, que é o uso atual. Se novas tags forem adicionadas, esta política será atualizada.',
        },
        {
          t: 'p',
          text: 'Mais informações sobre o tratamento de dados pelo Google estão na política de privacidade do Google e nos termos do Google Analytics.',
        },
      ],
    },
    {
      id: 'marketing',
      title: 'Marketing e publicidade — só com o seu aceite',
      blocks: [
        {
          t: 'p',
          text: 'Servem para medir o resultado das nossas campanhas e para apresentar anúncios da Natcorp a quem demonstrou interesse. São carregados pelo Meta Pixel, da Meta Platforms (Facebook, Instagram e WhatsApp).',
        },
        {
          t: 'table',
          head: ['Nome', 'Definido por', 'Para quê', 'Duração'],
          rows: [
            [
              '_fbp',
              'Meta (terceira parte)',
              'Identifica o navegador para medir conversões e exibir anúncios.',
              '3 meses',
            ],
            [
              'fr',
              'Meta (terceira parte)',
              'Entrega publicidade e mede a eficácia dos anúncios. Definido no domínio facebook.com.',
              '3 meses',
            ],
          ],
        },
        {
          t: 'p',
          text: 'O Meta Pixel registra que você visitou uma página do nosso site e quais ações realizou nela — por exemplo, o envio de um formulário de contato. Não enviamos à Meta o conteúdo dos campos que você preenche.',
        },
        {
          t: 'p',
          text: 'Você também pode controlar a publicidade direcionada diretamente nas configurações de anúncios da sua conta na Meta e do Google, independentemente da sua escolha aqui.',
        },
      ],
    },
    {
      id: 'nao-usamos',
      title: 'O que este site não faz',
      blocks: [
        {
          t: 'p',
          text: 'Para ser específico onde políticas de cookies costumam ser vagas:',
        },
        {
          t: 'ul',
          items: [
            'Não carregamos nenhuma tag de terceiro antes do seu aceite — nem em modo anônimo, nem “apenas para contar visitas”.',
            'Não vendemos nem licenciamos seus dados de navegação a terceiros para as finalidades de marketing deles.',
            'Não usamos fingerprinting de dispositivo como alternativa a cookies.',
            'Não há muro de cookies: recusar não bloqueia nenhuma parte do conteúdo do site.',
            'Ambientes de homologação não carregam tag alguma, porque sem identificador configurado o código não requisita nada.',
          ],
        },
      ],
    },
    {
      id: 'como-controlar',
      title: 'Como controlar cookies no seu navegador',
      blocks: [
        {
          t: 'p',
          text: 'Além da escolha feita neste site, todo navegador permite bloquear, apagar ou ser avisado sobre cookies. Onde encontrar:',
        },
        {
          t: 'ul',
          items: [
            'Google Chrome: Configurações → Privacidade e segurança → Cookies de terceiros.',
            'Mozilla Firefox: Configurações → Privacidade e Segurança → Cookies e dados de sites.',
            'Safari: Ajustes → Safari → Privacidade e Segurança (iOS) ou Safari → Configurações → Privacidade (macOS).',
            'Microsoft Edge: Configurações → Cookies e permissões do site.',
          ],
        },
        {
          t: 'p',
          text: 'Vale lembrar que essas configurações valem por navegador e por dispositivo. Se você usa o site no computador e no celular, precisa ajustar os dois. E, ao apagar os dados do site, você apaga também o registro da sua escolha aqui — a barra voltará a perguntar na próxima visita.',
        },
      ],
    },
    {
      id: 'direitos',
      title: 'Seus direitos e como falar com a gente',
      blocks: [
        {
          t: 'p',
          text: 'Os dados coletados por cookies de medição e marketing são dados pessoais, e você tem sobre eles todos os direitos previstos na LGPD: confirmação de tratamento, acesso, correção, anonimização, portabilidade, eliminação e revogação do consentimento.',
        },
        {
          t: 'p',
          text: 'Como esta é uma coleta feita pelo próprio site da Natcorp, aqui a Natcorp é a Controladora e você fala diretamente com o nosso encarregado:',
        },
        { t: 'contact' },
        {
          t: 'p',
          text: 'Se a Natcorp alterar as tecnologias descritas aqui, esta política será atualizada e a data de última atualização, no topo da página, mudará junto.',
        },
      ],
    },
  ],
}
