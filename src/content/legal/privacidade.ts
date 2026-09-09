import type { LegalDoc } from './types'

/** Transcrição íntegra da Política de Privacidade publicada em www.natcorp.com.br/privacidade/. */
export const privacidade: LegalDoc = {
  path: '/privacidade',
  title: 'Política de Privacidade',
  lead: 'Como a Natcorp coleta, usa, compartilha e protege dados pessoais — e como você exerce os seus direitos.',
  updated: '25 de agosto de 2025',
  seo: {
    title: 'Política de Privacidade e Proteção de Dados | Natcorp',
    description:
      'Como a Natcorp trata dados pessoais sob a LGPD: papéis de controladora e operadora, finalidades, compartilhamento, retenção, segurança e canais do encarregado.',
  },
  intro: [
    {
      t: 'p',
      text: 'A Natcorp tem uma grande preocupação com a Privacidade e Proteção de dados. Importante compartilhar com você, titular de dados pessoais, nossa Política de Privacidade e Proteção de dados pessoais, para que você conheça nosso zelo, proteção e transparência no tratamento dos seus dados pessoais.',
    },
    {
      t: 'note',
      title: 'Antes de tudo: o seu caso é qual?',
      text: 'Se você é colaborador, ex-colaborador, candidato, dependente ou terceiro de uma empresa que usa o sistema Natcorp, quem responde pelos seus dados é essa empresa — ela é a Controladora, e é com ela que você exerce seus direitos. A Natcorp é a Operadora e age apenas sob instrução dela. Se você é visitante deste site, cliente, parceiro ou usuário da nossa plataforma, a Natcorp é a Controladora e você fala direto com o nosso encarregado.',
    },
    {
      t: 'p',
      text: 'Essa Política é feita para você, com o objetivo de apresentar as diretrizes e a forma como a Natcorp coleta, processa, armazena e protege as informações pessoais no tratamento dos dados pessoais como CONTROLADORA, quando caberá à Natcorp as decisões referentes ao tratamento do seu dado pessoal.',
    },
    {
      t: 'p',
      text: 'Portanto, essa Política é para mostrar a você nossas atividades de coleta de dados tanto on-line e off-line, abrangendo os dados pessoais que a Natcorp coleta por meio de nossos vários canais, incluindo — mas não limitado a — sites na web, aplicativos, redes sociais de terceiros, pesquisas e eventos. Por favor, note que a Natcorp poderá agregar dados pessoais combinados de diferentes fontes (por exemplo, nosso site e eventos off-line) ou parceiros da Natcorp. Você pode consultar a seção “Sobre seus direitos referentes a dados pessoais” para obter mais informações sobre como se opor a isso.',
    },
    {
      t: 'p',
      text: 'Em alguns casos específicos, se você decidir por não nos fornecer os seus dados pessoais apontados como necessários (a Natcorp indicará quando esse for o caso, por exemplo, colocando explicitamente essa informação em nossos formulários de registro), talvez não possamos prover a você nossos serviços.',
    },
    {
      t: 'p',
      text: 'A Natcorp reafirma seu compromisso com a Privacidade e a Proteção de Dados, em conformidade com a Lei Geral de Proteção de Dados Pessoais (Lei nº 13.709/2018 — LGPD), a Constituição Federal e demais legislações trabalhistas e regulatórias aplicáveis.',
    },
    {
      t: 'p',
      text: 'Esta Política tem como objetivo explicar, de forma clara e transparente, como tratamos dados pessoais, especificando o papel da Natcorp como OPERADORA de dados pessoais de colaboradores e candidatos de seus clientes, e como CONTROLADORA em situações específicas relacionadas aos seus próprios usuários, parceiros e visitantes.',
    },
  ],
  sections: [
    {
      id: 'papeis',
      title: 'Papéis no tratamento de dados',
      blocks: [
        {
          t: 'ul',
          items: [
            'A Natcorp atua como OPERADORA dos dados pessoais de colaboradores, candidatos, terceiros e dependentes, processados em nome de seus clientes, que são os CONTROLADORES responsáveis por definir finalidades e meios do tratamento.',
            'A Natcorp atua como CONTROLADORA apenas em relação aos dados de seus próprios funcionários, prestadores de serviços, representantes dos seus clientes, usuários da sua plataforma, visitantes de seus sites entre outros meios online e offline.',
          ],
        },
      ],
    },
    {
      id: 'onde-coletamos',
      title: 'Onde coletamos os dados pessoais?',
      blocks: [
        { t: 'p', text: 'A Natcorp poderá coletar seus dados pessoais por meio das seguintes fontes:' },
        {
          t: 'ul',
          items: [
            'Sites da Natcorp: todos os nossos sites podem ser utilizados para coleta de dados pessoais. Isso inclui tanto site que operamos diretamente através dos nossos domínios e endereços IPs, quanto sites ou páginas que a Natcorp estabelece em serviços de terceiros, como Facebook, LinkedIn, e demais que ofertam esse tipo de serviço.',
            'Correio Eletrônico e sistemas de troca de mensagens instantâneas: serviços utilizados para manter comunicações eletrônicas entre você e a Natcorp, incluindo aqueles disponibilizados diretamente pela Natcorp, ou serviços de terceiros como WhatsApp, Telegram, SMS (serviço de mensagens curtas) e similares.',
            'Aplicativos móveis da Natcorp: aplicativos móveis fornecidos diretamente pela Natcorp ou através de serviços de terceiros como Google ou Apple.',
            'Anúncios, propagandas e formulários on-line: interações com qualquer tipo de anúncios, propagandas e formulários on-line da Natcorp.',
            'Registros off-line: registros preenchidos off-line, distribuídos durante eventos e outras interações com a Natcorp.',
            'Dados recebidos de terceiros: incluindo, mas não limitado a redes sociais e sites de terceiros como, por exemplo, WhatsApp, Facebook, Instagram, LinkedIn, YouTube, Google Analytics e similares, serviços de agregadores de dados, parceiros da Natcorp, fontes públicas e dados recebidos durante aquisição de outras empresas.',
          ],
        },
        {
          t: 'p',
          text: 'A Natcorp como OPERADORA dos dados pessoais de colaboradores, ex-colaboradores, terceiros, candidatos e dependentes, processados em nome de seus clientes, que são os CONTROLADORES responsáveis por definir finalidades e meios do tratamento. A Natcorp processa os dados estritamente em nome e sob as instruções documentadas de seus clientes, que são os verdadeiros Controladores dos dados.',
        },
      ],
    },
    {
      id: 'quais-dados',
      title: 'Quais dados pessoais coletamos e como são coletados?',
      blocks: [
        {
          t: 'p',
          text: 'Durante sua interação junto à Natcorp, usando uma das fontes de coleta previamente mencionadas, podemos coletar vários tipos de dados pessoais sobre você, conforme exposto a seguir:',
        },
        {
          t: 'ul',
          items: [
            'Informações de Contato: inclui qualquer tipo de informação que possa facilitar nosso contato com você, incluindo seu endereço físico de correspondência, números de telefone, endereços de correio eletrônico, sites e perfis em redes sociais.',
            'Informações de login: quaisquer informações para se identificar e autenticar em serviços fornecidos pela Natcorp, incluindo seu nome de registro (login), senha em formato irrecuperável (criptografado) e perguntas de segurança.',
            'Informações demográficas e seus interesses: qualquer informação que possa descrever seus dados demográficos, hábitos ou suas características de comportamento, incluindo itens como seu aniversário, data de nascimento, idade ou faixa etária, gênero, localização geográfica, produtos favoritos, hobbies e passatempos, demais interesses e informações familiares ou sobre seu estilo de vida.',
            'Informações técnicas sobre seus equipamentos computacionais ou dispositivos móveis: detalhes sobre o seu computador ou outro dispositivo portátil que tenha sido utilizado para acessar um de nossos sites, serviços ou aplicativos, incluindo o registro do endereço IP utilizado para conectar seu computador ou dispositivo à internet, sua localização geográfica, o tipo e a versão de sistema operacional e o tipo e a versão do navegador da web. Se você acessar um site ou aplicativo da Natcorp usando um dispositivo móvel, como um celular inteligente ou tablet, as informações coletadas também incluirão, sempre que permitido, o ID de dispositivo exclusivo de seu telefone, a localização geográfica e outros dados similares do dispositivo móvel.',
            'Informações sobre como você utiliza nossos sites e serviços: durante sua interação com nossos sites e serviços, a Natcorp utilizará tecnologias de coleta automática de dados para capturar informações sobre as ações que você tomou. Isso pode incluir detalhes como em quais links você clica, quais páginas ou conteúdos você visualiza e por quanto tempo, e outras informações e estatísticas semelhantes sobre suas interações, como tempos de resposta a conteúdo, erros de download e duração das visitas a determinadas páginas. Essas informações são capturadas por meio de tecnologias automatizadas, como Cookies (Cookies de navegador, Cookies Flash e similares) e web beacons, e também via rastreamento de terceiros. Você possui total liberdade para se opor à utilização de tais tecnologias.',
            'Pesquisas de mercado e feedback de consumidores: são informações que você compartilha voluntariamente com a Natcorp sobre sua experiência de uso de nossos produtos e serviços.',
            'Conteúdo gerado por titulares de dados pessoais: incluindo qualquer conteúdo que você cria e compartilha com a Natcorp em redes sociais de terceiros ou por meio de carregamento para um de nossos sites, aplicativos e demais serviços on-line e off-line, incluindo o uso de aplicativos de rede social de terceiros, como o Facebook, Instagram, LinkedIn e similares. Esses dados incluem textos, comentários, artigos, fotos, vídeos, histórias pessoais ou outros conteúdos e mídias semelhantes.',
            'Informações de redes sociais de terceiros: trata-se de quaisquer dados que você compartilha publicamente em uma rede social de terceiros ou informações que fazem parte de seu perfil em uma rede social de terceiros (como o Facebook, Instagram, LinkedIn e similares) e que você permite que a rede social de terceiros compartilhe conosco. Esses dados podem incluir detalhes como suas informações básicas de conta (nome, endereço de e-mail, gênero, data de nascimento, cidade atual, foto de perfil, ID de usuário, lista de amigos e informações similares) e quaisquer outras informações ou atividades adicionais que você permita que a rede social de terceiros compartilhe conosco.',
            'Dados Pessoais Sensíveis: a Natcorp não realiza o tratamento de dados pessoais considerados sensíveis de acordo com a legislação vigente, excetuando-se em situações previstas na legislação vigente. Dessa forma, não temos a intenção de coletar ou processar dados pessoais sensíveis no curso normal de suas interações com nossos produtos, serviços, sites, aplicativos, etc. Se processarmos seus dados pessoais sensíveis, a Natcorp estará apoiada nas seguintes bases legais: (i) detecção e prevenção de crime, (ii) cumprimento da lei aplicável e (iii) consentimento do titular.',
          ],
        },
        {
          t: 'p',
          text: 'Como OPERADORA, o sistema da Natcorp utilizado e operado pelo cliente executa o processamento de dados sensíveis (ex.: dados de saúde para gestão de plano médico) exclusivamente sob as instruções do CONTROLADOR, que é o responsável por obter a base legal necessária para tal tratamento.',
        },
      ],
    },
    {
      id: 'uso',
      title: 'Sobre o uso de seus dados pessoais',
      blocks: [
        {
          t: 'p',
          text: 'Os itens a seguir descrevem as finalidades para as quais a Natcorp coleta seus dados pessoais, e os diferentes tipos de dados pessoais que coleta para cada finalidade. Note, por favor, que nem todos os usos abaixo serão relevantes para todos os indivíduos e podem se aplicar apenas a situações específicas.',
        },
        { t: 'h3', text: 'Serviços ao titular' },
        {
          t: 'p',
          text: 'Seus dados pessoais são utilizados para a finalidade de prestar serviços a você como titular dos dados pessoais, incluindo responder a suas dúvidas, questionamentos e sugestões. Normalmente, isso requer certas informações pessoais de contato e informações sobre o motivo de seu questionamento, dúvida ou sugestão.',
        },
        {
          t: 'ul',
          items: [
            {
              text: 'Motivo para uso dos seus dados pessoais nessa situação:',
              items: [
                'Cumprir obrigações contratuais;',
                'Obrigações legais;',
                'Nossos interesses legítimos;',
                'Obtivemos o seu consentimento (quando necessário).',
              ],
            },
            {
              text: 'Nossos interesses legítimos nessa situação:',
              items: [
                'Melhorar e desenvolver novos produtos e serviços;',
                'Ser mais eficientes no atendimento às suas solicitações;',
                'Proteger nossos sistemas, redes e colaboradores;',
                'Cumprir integralmente obrigações legais.',
              ],
            },
          ],
        },
        { t: 'h3', text: 'Realização de concursos, promoções e demais ações de marketing' },
        {
          t: 'p',
          text: 'Com seu consentimento (quando necessário conforme legislação vigente), a Natcorp utilizará seus dados pessoais para fornecer informações sobre produtos ou serviços como, por exemplo, comunicações de marketing, campanhas publicitárias ou promoções. Isso pode ser feito por diversos meios de comunicação, incluindo o e-mail, anúncios, envio de mensagens por SMS, mensagens por WhatsApp, ligações telefônicas e correspondências postais (conforme permitido pela legislação vigente), além de nossos próprios sites, redes sociais e aplicativos de terceiros. Nesta situação, o uso de seus dados pessoais é completamente voluntário, o que significa que você pode se opor ou mesmo retirar seu consentimento ao tratamento de seus dados pessoais para estas finalidades a qualquer momento.',
        },
        {
          t: 'ul',
          items: [
            {
              text: 'Motivo para uso dos seus dados pessoais nessa situação:',
              items: [
                'Cumprir obrigações contratuais;',
                'Nossos interesses legítimos;',
                'Obtermos o seu consentimento (quando necessário).',
              ],
            },
            {
              text: 'Nossos interesses legítimos nessa situação:',
              items: [
                'Entender quais de nossos produtos e serviços podem interessar a você e fornecer informações sobre eles;',
                'Definir consumidores para novos produtos ou serviços.',
              ],
            },
          ],
        },
        { t: 'h3', text: 'Redes sociais e sites de terceiros' },
        {
          t: 'p',
          text: 'Usaremos seus dados pessoais quando você interagir com funções de redes sociais e sites de terceiros, como “curtir”, para fornecer anúncios e interagir com você em redes sociais de terceiros. A forma como essas interações funcionam, os dados de perfil que a Natcorp obtém sobre você, e como cancelá-los (“opt-out”) podem ser entendidos revisando as políticas de privacidade diretamente nas respectivas redes sociais e sites de terceiros.',
        },
        { t: 'h3', text: 'Personalização (off-line e on-line)' },
        {
          t: 'p',
          text: 'Com base em seu consentimento (quando exigido conforme legislação vigente), a Natcorp utilizará seus dados pessoais (i) para entender suas preferências e hábitos, (ii) para antecipar suas necessidades, baseadas em nosso entendimento do seu perfil, (iii) para melhorar e personalizar sua experiência em nossos sites e aplicativos; (iv) para assegurar que o conteúdo de nossos sites e aplicativos seja otimizado para você e para seu computador ou dispositivo; (v) para enviar a você publicidade e conteúdo dirigidos, e (vi) para permitir que você participe de funções interativas, sempre que decidir fazê-lo. Nesta situação, o uso de seus dados pessoais é completamente voluntário, o que significa que você pode se opor, ou mesmo retirar seu consentimento a qualquer momento.',
        },
        { t: 'h3', text: 'Motivos legais ou fusão/aquisição' },
        {
          t: 'p',
          text: 'Caso a Natcorp ou seus bens sejam adquiridos por, ou fundidos com, outra empresa, incluindo por motivo de falência, compartilharemos seus dados pessoais com nossos sucessores legais, respeitando as exigências da legislação vigente. Também divulgaremos seus dados pessoais a terceiros (i) quando requerido pela lei aplicável; (ii) em resposta a procedimentos legais; (iii) em resposta a um pedido da autoridade legal competente; (iv) para proteger nossos direitos, privacidade, segurança ou propriedade; ou (v) para fazer cumprir os termos de qualquer acordo ou os termos do nosso site, produtos e serviços, conforme a legislação vigente.',
        },
      ],
    },
    {
      id: 'compartilhamento',
      title: 'Sobre o compartilhamento de seus dados pessoais',
      blocks: [
        {
          t: 'p',
          text: 'Além das entidades que fazem parte da Natcorp, poderemos compartilhar seus dados pessoais com os seguintes tipos de organizações de terceiros:',
        },
        {
          t: 'ul',
          items: [
            'Provedores de serviços: incluem companhias externas que são utilizadas pela Natcorp para auxiliar a operar nosso negócio. Provedores de serviços e seus colaboradores selecionados só estão autorizados a acessar seus dados pessoais em nome da Natcorp para as tarefas específicas, que forem requisitadas a eles com base em nossas instruções diretas. Nossos provedores de serviços são obrigados contratualmente a manter seus dados pessoais confidenciais e seguros, e em casos de violação respondem solidariamente conforme a legislação vigente.',
            'Agências de análise de crédito, cobrança de dívidas e serviços financeiros: conforme permitido pela lei aplicável, agências de análise de crédito e/ou de cobrança de dívidas são empresas externas que a Natcorp poderá utilizar para nos auxiliarem a verificar a situação do seu crédito ou para coletar pagamentos vencidos.',
            'Empresas terceiras que usam dados pessoais para suas próprias finalidades de marketing: excetuando-se situações em que você deu seu consentimento específico, a Natcorp não licencia ou vende seus dados pessoais a empresas terceiras para suas próprias finalidades de marketing. Em casos onde esse tipo de compartilhamento ocorra, a identidade dessas empresas terceiras será revelada antes da obtenção do seu consentimento.',
            'Terceiros que usam seus dados pessoais por motivos legais ou devido a fusão/aquisição: divulgaremos seus dados pessoais a terceiros por motivos legais ou no contexto de uma fusão ou aquisição na Natcorp.',
          ],
        },
        {
          t: 'p',
          text: 'Como Operadora, a Natcorp utiliza os dados dos colaboradores, ex-colaboradores, dependentes, terceiros e candidatos apenas para cumprir obrigações legais e contratuais da finalidade a que o software da Natcorp está destinado. A Natcorp também poderá compartilhar dados pessoais com fornecedores e parceiros, sempre de forma controlada e segura. Entre eles: fornecedores de benefícios (como refeição, transporte), Governo Brasileiro (como eSocial), serviços financeiros e bancários, provedores de cloud (Microsoft Azure, Oracle Cloud, UOL Diveo), serviços de mensagens (WhatsApp, Telegram, Google Chat, Microsoft Teams), ferramentas de analytics e para suporte técnico. Em integrações como APIs, dados são processados com criptografia e sob DPA com terceiros, limitados à finalidade de RH.',
        },
      ],
    },
    {
      id: 'retencao',
      title: 'Por quanto tempo manteremos seus dados pessoais?',
      blocks: [
        {
          t: 'p',
          text: 'De acordo com a legislação vigente, a Natcorp utilizará seus dados pessoais por quanto tempo for necessário para satisfazer as finalidades para as quais seus dados pessoais foram coletados, conforme descrito nesta política, ou para cumprir com os requerimentos legais aplicáveis.',
        },
        {
          t: 'p',
          text: 'Dados pessoais usados para fornecer uma experiência personalizada a você serão mantidos exclusivamente pelo tempo permitido, de acordo com a legislação vigente. Você pode obter detalhes sobre a retenção dos seus dados pessoais através dos canais de comunicação detalhados nesta política.',
        },
        {
          t: 'p',
          text: 'Quando o tratamento de seus dados pessoais terminar, eles serão eliminados no âmbito e nos limites técnicos das atividades, autorizada a conservação nas situações previstas na legislação vigente.',
        },
        {
          t: 'p',
          text: 'Como OPERADORA: o cliente armazena os dados no sistema Natcorp, retendo os dados pessoais de colaboradores, ex-colaboradores, candidatos e terceiros somente pelo período em que o cliente mantiver seu contrato de prestação de serviços. Após o término do contrato, os dados serão removidos de nossos sistemas, seguindo as instruções do Controlador e os procedimentos internos de segurança da Natcorp.',
        },
        {
          t: 'p',
          text: 'A retenção de dados está sob instrução do Controlador, com prazos mínimos legais (ex.: folha de pagamento: 30 anos; ponto eletrônico: 5 anos). Após o fim do contrato com o cliente, os dados são eliminados em até 30 dias, salvo obrigações legais.',
        },
      ],
    },
    {
      id: 'armazenamento',
      title: 'Sobre o armazenamento ou transferência de seus dados pessoais',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp adota medidas adequadas para garantir que seus dados pessoais sejam mantidos de forma confidencial e segura. Entretanto, essas proteções não se aplicam a informações que você tenha escolhido compartilhar em áreas públicas, como redes sociais de terceiros.',
        },
        {
          t: 'ul',
          items: [
            'Pessoas que podem acessar seus Dados Pessoais: seus dados pessoais serão tratados por nossos colaboradores ou agentes autorizados, desde que eles precisem ter acesso a tais informações, dependendo dos propósitos específicos para os quais seus dados pessoais tenham sido coletados.',
            'Medidas tomadas em ambientes operacionais: armazenaremos seus dados pessoais em ambientes operacionais que usam medidas de segurança, tanto técnicas quanto administrativas, aptas para prevenir qualquer tipo de acesso não autorizado.',
            'Medidas que a Natcorp espera que você tome: é importante que você também tenha um papel em manter seus dados pessoais seguros. Quando criar uma conta on-line, por favor, assegure-se de escolher uma senha que seja forte para evitar que partes não autorizadas a adivinhem. Recomendamos que você nunca revele ou compartilhe sua senha com outras pessoas. Você é o único responsável por manter essa senha confidencial e por qualquer ação realizada através de sua conta nos sites e serviços compatíveis da Natcorp.',
            {
              text: 'Medidas de Segurança: a Natcorp adota medidas adequadas para garantir que seus dados pessoais sejam mantidos de forma confidencial e segura. Nossos ambientes operacionais usam medidas de segurança, tanto técnicas quanto administrativas, aptas para prevenir qualquer tipo de acesso não autorizado. As medidas incluem, mas não se limitam a:',
              items: [
                'Criptografia de dados em trânsito e em repouso.',
                'Controles de acesso rigorosos, com autenticação de múltiplos fatores (MFA).',
                'Firewalls e monitoramento contínuo de segurança.',
                'Backups regulares e planos de recuperação de desastres.',
                'Auditorias internas e externas de segurança.',
              ],
            },
            'Transferência de seus dados pessoais: dada a natureza do nosso negócio, é possível que tenhamos que transferir seus dados pessoais armazenados dentro da Natcorp para outras localidades, incluindo aquelas fora do controle direto da Natcorp, de acordo com as finalidades estabelecidas nesta Política de Privacidade. Por esse motivo, poderemos transferir seus dados pessoais para outros países, desde que eles possuam leis e regulamentações compatíveis com as vigentes no Brasil.',
          ],
        },
        {
          t: 'p',
          text: 'Se você usar um computador compartilhado ou público, nunca escolha a opção de lembrar seu nome de login, endereço de e-mail ou senha, e certifique-se de que você saiu da sua conta (realizou o log out) sempre que deixar o computador. Você também deve usar quaisquer configurações de privacidade ou controles que a Natcorp fornece em nosso site, serviços ou aplicativos, inclusive aquelas consideradas opcionais.',
        },
        { t: 'h3', text: 'Transferências internacionais' },
        {
          t: 'p',
          text: 'Dados podem ser transferidos para provedores, com cláusulas contratuais padrão aprovadas pela ANPD e avaliações de impacto (TIA — Transfer Impact Assessment). Não transferimos dados para países sem adequação sem salvaguardas equivalentes.',
        },
        { t: 'h3', text: 'Incidentes de segurança e notificações' },
        {
          t: 'p',
          text: 'Em caso de incidentes, notificamos a ANPD em até 72 horas e os titulares afetados, conforme Art. 48 da LGPD. Como Operadora, reportamos ao Controlador para coordenação.',
        },
      ],
    },
    {
      id: 'direitos',
      title: 'Sobre seus direitos referentes a dados pessoais',
      blocks: [
        {
          t: 'p',
          text: 'Você tem direito de confirmar a existência, acessar, revisar, modificar e/ou requisitar uma cópia eletrônica da informação dos seus dados pessoais que são tratados pela Natcorp.',
        },
        {
          t: 'p',
          text: 'Você também tem direito de requisitar detalhes sobre a origem / fonte de obtenção de seus dados pessoais ou o compartilhamento desses dados com terceiros. A qualquer momento você também poderá limitar o uso e divulgação ou revogar o consentimento a qualquer uma de nossas atividades de tratamento de seus dados pessoais, excetuando-se em situações previstas na legislação vigente.',
        },
        {
          t: 'p',
          text: 'Esses direitos podem ser exercidos através dos canais de comunicação detalhados nessa política, sendo necessária a validação da sua identidade através do fornecimento de uma cópia de seu RG ou meios equivalentes de identificação, em conformidade com a legislação vigente. Sempre que um pedido for submetido sem o fornecimento das provas necessárias à comprovação da legitimidade do titular dos dados, o pedido será automaticamente rejeitado. Ressaltamos que qualquer informação de identificação fornecida à Natcorp somente será processada de acordo com e na medida permitida pelas leis vigentes.',
        },
        {
          t: 'p',
          text: 'Ressaltamos que, em determinados casos, não podemos excluir seus dados pessoais sem também excluir sua conta de usuário. Adicionalmente, algumas situações requerem a retenção de seus dados pessoais depois que você pedir sua exclusão, para satisfazer obrigações legais ou contratuais.',
        },
        {
          t: 'p',
          text: 'Quando disponíveis, nossos sites, aplicativos e serviços on-line podem ter uma função dedicada onde será possível você revisar e editar os seus dados pessoais. Ressaltamos que a Natcorp solicita a validação de sua identidade usando, por exemplo, um sistema de login com senha de acesso ou recurso similar, antes de permitir o acesso ou a modificação de seus dados pessoais, dessa forma garantindo que não exista acesso não autorizado à sua conta e dados pessoais associados.',
        },
        {
          t: 'p',
          text: 'A Natcorp faz o máximo possível para poder atender todas as questões que você possa ter sobre a forma a qual processamos seus dados pessoais. Contudo, se você tiver preocupações não resolvidas, você tem o direito de reclamar às autoridades de proteção de dados competentes.',
        },
        {
          t: 'note',
          title: 'A quem você pede — depende do seu vínculo',
          text: 'Visitantes e clientes (Natcorp como Controladora): seus direitos de acesso, correção, anonimização, bloqueio ou eliminação podem ser exercidos diretamente com a Natcorp, pelos canais desta página. Colaboradores, candidatos e terceiros de nossos clientes (Natcorp como Operadora): para exercer seus direitos você deve entrar em contato diretamente com a empresa onde trabalha ou com a qual mantém vínculo — ela é a Controladora. A Natcorp processará solicitações de exclusão, correção ou outras ações apenas mediante instrução expressa e documentada do nosso cliente.',
        },
      ],
    },
    {
      id: 'escolhas',
      title: 'Quais são suas escolhas sobre como utilizamos e divulgamos seus dados pessoais',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp fará o máximo para dar a você liberdade de escolha sobre os dados pessoais que você nos fornece. Os seguintes mecanismos dão a você o controle sobre o tratamento de seus dados pessoais:',
        },
        {
          t: 'ul',
          items: [
            {
              text: 'Cookies/Tecnologias Similares: você pode gerenciar o seu consentimento usando:',
              items: [
                'Nossas soluções de gerenciamento de consentimento;',
                'As configurações do seu navegador para recusar alguns ou todos os Cookies e tecnologias similares, ou para alertá-lo quando estão sendo usados.',
              ],
            },
            'Publicidade, marketing e promoções: você pode consentir que seus dados pessoais sejam usados pela Natcorp para promover nossos produtos ou serviços por meio de caixas de verificação localizadas nos formulários de registro ou respondendo questões apresentadas pelos nossos representantes.',
            'Personalização (off-line e on-line): sempre que permitido por lei, se você quiser que seus dados pessoais sejam usados pela Natcorp para fornecer-lhe uma experiência personalizada ou publicidade e conteúdo dirigidos, você pode indicar isso por meio das caixas de checagem relevantes localizadas no formulário de registro ou respondendo a perguntas apresentadas pelos nossos representantes.',
            'Publicidade direcionada: a Natcorp pode realizar parcerias com redes de anúncios e outros provedores de serviços ou anúncios, que apresentam propagandas e demais anúncios em nosso nome ou no nome de outras empresas não afiliadas à Natcorp. Alguns desses anúncios podem ser ajustados aos seus interesses, com base nas informações coletadas nos sites e demais serviços compatíveis da Natcorp ou em sites de organizações não afiliadas à Natcorp.',
          ],
        },
        {
          t: 'p',
          text: 'Se você decidir que não deseja mais receber tais comunicações, você pode cancelar sua subscrição para receber comunicações relacionadas a marketing em qualquer momento, seguindo as instruções fornecidas em tais comunicações. Para cancelar a subscrição de comunicações de marketing enviadas por qualquer meio, incluindo redes sociais de terceiros, você pode optar por sair a qualquer tempo, cancelando sua subscrição, pelos links disponíveis em nossas comunicações, fazendo login em nossos sites, aplicativos, serviços on-line compatíveis ou redes sociais de terceiros, e ajustando suas preferências de usuário ou ligando diretamente para nosso serviço de atendimento.',
        },
        {
          t: 'p',
          text: 'É importante lembrar que, mesmo com o seu cancelamento de subscrição às nossas comunicações de marketing, você continuará a receber comunicações administrativas da Natcorp, como pedidos, confirmações de transação, notificações sobre suas atividades de conta em nossos sites e serviços compatíveis, e outros anúncios importantes não relacionados a marketing.',
        },
      ],
    },
    {
      id: 'menores',
      title: 'Sobre dados pessoais de crianças e adolescentes',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp não solicita, coleta, processa, armazena ou compartilha, conscientemente, dados pessoais de crianças e adolescentes menores de idade, excetuando-se casos onde há uma previsão legal, ou consentimento explícito de seus pais ou responsáveis legais, conforme a legislação vigente. Se descobrirmos a ocorrência de qualquer tipo de tratamento deste tipo de dado pessoal, de forma não-intencional, removeremos os dados pessoais daquela criança ou adolescente de nossos registros rapidamente.',
        },
      ],
    },
    {
      id: 'cookies',
      title: 'Sobre o uso de cookies, arquivos de registros (logs) e similares',
      blocks: [
        {
          t: 'p',
          text: 'Os sites e serviços da Natcorp também poderão usar outras tecnologias de rastreamento similares a cookies, que são capazes de coletar informações tais como endereços IP, arquivos de registro e sinalizadores da web, dentre outras. Esses dados também são utilizados para nos ajudar a adaptar os sites e demais serviços compatíveis da Natcorp às suas necessidades pessoais. Veja detalhes a seguir:',
        },
        {
          t: 'ul',
          items: [
            {
              text: 'Endereços de IP: um endereço de IP é um número usado na internet ou em uma rede para identificar seu computador. Todas as vezes que você se conecta na internet, seu computador recebe um IP atribuído pelo seu provedor de serviços de internet. Podemos registrar endereços de IP para as seguintes finalidades:',
              items: [
                'Tratamento de problemas técnicos;',
                'Manutenção da proteção e segurança dos nossos sites e demais serviços on-line;',
                'Obter uma melhor compreensão de como nossos sites e demais serviços on-line são utilizados;',
                'Adaptar nosso conteúdo às suas necessidades, dependendo da sua localização geográfica.',
              ],
            },
            {
              text: 'Arquivos de Registro: a Natcorp ou um terceiro trabalhando em nosso nome poderá coletar informações na forma de arquivos de registro (logs) que detalham as atividades do site e coletam estatísticas sobre os hábitos de navegação do usuário. Normalmente, esses registros são gerados anonimamente e nos ajudam a entender detalhes como:',
              items: [
                'O tipo de navegador e o sistema utilizado pelos usuários de nossos sites ou serviços on-line;',
                'Detalhes sobre a sessão do usuário, incluindo a URL de origem, a data, hora e quais páginas o usuário visitou em nossos sites e serviços compatíveis, e quanto tempo o usuário permaneceu utilizando-os;',
                'Demais detalhes de navegação ou de contagem de cliques incluindo relatórios de tráfego de site, contagem de visitantes únicos e dados similares.',
              ],
            },
            {
              text: 'Sinalizadores da web (web beacons): a Natcorp poderá utilizar os sinalizadores da web (ou GIFs transparentes) nos sites ou comunicações eletrônicas da Natcorp. Os sinalizadores da web (também conhecidos como web bugs ou web beacons) são pequenas sequências de código que permitem a entrega de uma imagem gráfica em uma página da web com o objetivo de transferir dados de volta para a Natcorp. Usamos as informações dos sinalizadores da web para os mais variados propósitos, incluindo:',
              items: [
                'Entender como um usuário responde a campanhas de e-mail;',
                'Relatórios de tráfego dos nossos sites e serviços compatíveis;',
                'Realizar a contagem de visitantes únicos, auditoria e relatórios de propaganda e e-mail e personalização em nossos sites e demais serviços compatíveis.',
              ],
            },
          ],
        },
        {
          t: 'p',
          text: 'É importante lembrar que cabe a você assegurar que as configurações do seu computador ou dispositivo portátil reflitam se você consente ao uso de cookies ou não.',
        },
        {
          t: 'p',
          text: 'A maioria dos navegadores permite que você estabeleça regras para avisá-lo antes de aceitar cookies ou simplesmente recusá-los. Você não precisa ter cookies habilitados para usar ou navegar na maior parte dos sites e serviços on-line da Natcorp, entretanto, nesse caso, não podemos assegurar que você vai conseguir acessar todos os seus recursos. Recomendamos que você veja no botão “ajuda” no seu navegador como realizar esse tipo de configuração. Lembre-se de que, se você usar navegadores, ou mesmo computadores e/ou dispositivos portáteis diferentes em locais diferentes, você precisará se assegurar de que cada dispositivo e navegador esteja ajustado para suas preferências pessoais de cookies.',
        },
        {
          t: 'p',
          text: 'Como os nossos sinalizadores da web (web beacons) podem fazer parte de uma página da web, não é possível excluir (“opt-out”) esse tipo de recurso, mas você pode torná-lo completamente não-funcional ativando o recurso “opt-out” para os cookies colocados por esse sinalizador.',
        },
      ],
    },
    {
      id: 'alteracoes',
      title: 'Alterações em nossa Política de Privacidade',
      blocks: [
        {
          t: 'p',
          text: 'Sempre que a Natcorp decidir mudar a forma que tratamos seus dados pessoais, essa Política será atualizada. Nos reservamos o direito de fazer alterações às nossas práticas e a essa Política a qualquer tempo, desde que mantida a conformidade com a legislação vigente. Recomendamos que você a acesse frequentemente, ou sempre que tiver dúvidas, para ver quaisquer atualizações ou mudanças à nossa Política de Privacidade.',
        },
      ],
    },
    {
      id: 'contato',
      title: 'Como entrar em contato',
      blocks: [
        { t: 'p', text: 'Você pode entrar em contato para:' },
        {
          t: 'ul',
          items: [
            'Fazer perguntas ou comentários sobre essa política e nossas práticas de privacidade e proteção de dados pessoais;',
            'Fazer uma reclamação;',
            'Confirmação da existência de tratamento de seus dados pessoais;',
            'Obter informações sobre como acessar seus dados pessoais;',
            'Realizar/solicitar a correção de dados pessoais incompletos, inexatos ou desatualizados;',
            'Obter informações sobre a anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade com o disposto na legislação vigente;',
            'Obter informações sobre a portabilidade dos seus dados pessoais a outro fornecedor de serviço ou produto, mediante requisição expressa, em conformidade com a legislação vigente;',
            'Solicitar a eliminação dos dados pessoais tratados com o seu consentimento, excetuando-se as hipóteses previstas na legislação vigente;',
            'Solicitar detalhes das entidades públicas e privadas com as quais realizamos o compartilhamento de seus dados pessoais;',
            'Obter informações sobre a possibilidade de não fornecer consentimento e sobre as consequências dessa negativa;',
            'Realizar a revogação do consentimento para o tratamento dos seus dados pessoais, excetuando-se as hipóteses previstas na legislação vigente;',
            'Demais direitos do titular dos dados pessoais, conforme legislação vigente.',
          ],
        },
        { t: 'contact' },
        {
          t: 'p',
          text: 'A Natcorp receberá, investigará e responderá, dentro de um prazo considerado razoável, qualquer solicitação ou reclamação sobre a forma como a Natcorp trata seus dados pessoais, incluindo reclamações sobre desrespeito aos seus direitos sob as leis de privacidade e proteção de dados pessoais vigentes.',
        },
      ],
    },
  ],
}
