import type { LegalDoc } from './types'
import { empresa } from './types'

/** Transcrição íntegra dos Termos de Uso publicados em www.natcorp.com.br/termos-de-uso/. */
export const termosDeUso: LegalDoc = {
  path: '/termos-de-uso',
  title: 'Termos de Uso',
  lead: 'As regras do contrato entre a sua empresa e a Natcorp para o uso do sistema.',
  updated: '25 de agosto de 2025',
  seo: {
    title: 'Termos de Uso do sistema de RH | Natcorp',
    description:
      'Termos de uso do sistema de RH da Natcorp em modelo SaaS: licença, contas e responsabilidades, pagamentos, propriedade intelectual, proteção de dados e garantias.',
  },
  intro: [
    {
      t: 'p',
      text: `Bem-vindo aos Termos de Uso do Sistema Natcorp (“Termos”). Estes Termos constituem um acordo legal vinculante entre você (“Usuário”, “Cliente” ou “Você”) e a ${empresa.razaoSocial} (“Natcorp”, “Nós” ou “Empresa”), uma empresa brasileira com sede em ${empresa.endereco}, inscrita no CNPJ sob o nº ${empresa.cnpj}, para o uso do nosso Sistema de Recursos Humanos (“Sistema” ou “Software”), oferecido no modelo Software as a Service (SaaS).`,
    },
    {
      t: 'p',
      text: 'Ao acessar, registrar-se ou utilizar o Sistema, Você concorda em cumprir estes Termos, bem como nossa Política de Privacidade, que é incorporada por referência a estes Termos. Se Você não concordar com estes Termos, não acesse ou utilize o Sistema.',
    },
    {
      t: 'p',
      text: 'A Natcorp reserva-se o direito de alterar estes Termos a qualquer momento, notificando Você por e-mail, através do Sistema ou com sua visita regular aos termos de uso neste site. O uso continuado após alterações implica aceitação das mesmas.',
    },
  ],
  sections: [
    {
      id: 'descricao',
      title: 'Descrição do Sistema',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp é uma empresa brasileira de tecnologia especializada no desenvolvimento e fornecimento de soluções SaaS B2B para gestão de Recursos Humanos (RH). Nosso Sistema é projetado para empresas de diversos segmentos.',
        },
        {
          t: 'p',
          text: 'O Sistema opera em conformidade com a legislação brasileira, incluindo a Consolidação das Leis do Trabalho (CLT), Lei Geral de Proteção de Dados Pessoais (LGPD — Lei nº 13.709/2018), eSocial e Normas Regulamentadoras (NRs), promovendo as melhores práticas de gestão de pessoas.',
        },
        { t: 'h3', text: 'Infraestrutura e tecnologia' },
        {
          t: 'ul',
          items: [
            'Infraestrutura: hospedado em servidores na nuvem, com ambientes robustos e seguros de produção, homologação e disaster recovery (serviço de contingência).',
            'Acesso: multiplataforma, responsivo para mobile e desktop.',
            'Segurança: criptografia de dados em trânsito e repouso, autenticação multifator (MFA), firewalls, monitoramento contínuo, backups regulares e auditorias internas/externas.',
            'Integrações: API RESTful para importação/exportação de dados, integrações com terceiros (ex.: eSocial e provedores de benefícios).',
          ],
        },
        { t: 'h3', text: 'Módulos e funcionalidades principais' },
        {
          t: 'p',
          text: 'O Sistema oferece módulos integrados para Departamento Pessoal e RH, com acesso para candidatos, colaboradores, gestores e operadores. Inclui, mas não se limita a:',
        },
        {
          t: 'ul',
          items: [
            'Folha de Pagamento: processamento completo de pagamentos, impostos e obrigações trabalhistas.',
            'Ponto Eletrônico: controle de frequência via app “NatPonto” com geolocalização, reconhecimento facial, integração API, workflows de aprovação, gestão de jornadas (flexíveis, fixas, variáveis), escalas, banco de horas e apuração para folha.',
            'Jurídico: gestão de processos trabalhistas integrada ao eSocial.',
            'Recrutamento e Seleção: criação de processos seletivos, gestão de candidatos, currículos, banco de talentos, SLAs, integrado a Admissão Digital e requisições de pessoal.',
            'Medicina Ocupacional: gestão de saúde e segurança, exames (ASOs), afastamentos, riscos, PCMSO, acidentes de trabalho.',
            'Segurança do Trabalho: análise de riscos, EPIs/EPCs, PPP, PGR, em conformidade com NRs.',
            'Administração de Pessoal: headcount, planejamento e orçamento de pessoal.',
            'Gestão de Cargos e Salários: estruturação e administração.',
            'Gestão de Metas e Resultados: bônus, PLR.',
            'People Analytics e Business Intelligence: gráficos, exportações para Excel, cruzamentos de dados.',
            'Inteligência Artificial: autoserviço, chatbot e geração de informações.',
            'Gestão de Benefícios: pedidos e integrações.',
            'eSocial: integração completa para envios e retornos.',
            'Avaliações e Desempenho: personalização de avaliações, pesquisas, feedbacks.',
            'Treinamento e Desenvolvimento: gestão de turmas, custos, questionários, atendimento a NRs.',
            'Planejamento de Carreira e Sucessão.',
            'Requisições Eletrônicas: workflows para vagas, desligamentos, férias, movimentações, etc., com automação.',
            'Admissão Digital: preenchimento online, validação e assinatura eletrônica.',
            'Assinatura Eletrônica: para contratos, termos, espelhos de ponto, etc.',
            'GED (Gestão Eletrônica de Documentos): armazenamento de documentos de colaboradores e candidatos (RG, CPF, etc.).',
            'Blog Corporativo: intranet para comunicados.',
            'OnBoarding e OffBoarding: fluxos para integração e desligamento.',
            'Chamado Interno: atendimento a dúvidas.',
            'Portais: para gestor, colaborador e candidato, com autoatendimento.',
            'Quadro de Vagas: JobBoard customizável.',
            'ChatBot IA via WhatsApp ou Microsoft Teams: atendimento a usuários.',
          ],
        },
        {
          t: 'p',
          text: 'O Sistema processa dados pessoais como Operadora sob instruções do Cliente (Controlador), em conformidade com a LGPD.',
        },
      ],
    },
    {
      id: 'definicoes',
      title: 'Definições',
      blocks: [
        {
          t: 'ul',
          items: [
            'Cliente: empresa contratante do Sistema.',
            'Usuário: qualquer indivíduo autorizado pelo Cliente a acessar o Sistema (ex.: colaboradores, gestores, candidatos).',
            'Dados Pessoais: informações relacionadas a pessoa natural identificada ou identificável, conforme LGPD.',
            'Controlador: o Cliente, responsável por definir finalidades e meios do tratamento de dados.',
            'Operadora: a Natcorp, que processa dados sob instruções do Controlador.',
            'Período de Vigência: duração do contrato de assinatura.',
          ],
        },
      ],
    },
    {
      id: 'licenca',
      title: 'Licença de uso',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp concede ao Cliente licença não exclusiva, intransferível e revogável para acessar e usar o Sistema durante o Período de Vigência, sujeito ao pagamento de taxas aplicáveis e cumprimento destes Termos. O uso é limitado aos fins de gestão interna do Cliente.',
        },
        { t: 'h3', text: 'Restrições' },
        {
          t: 'ul',
          items: [
            'Não copiar, modificar, descompilar ou criar trabalhos derivados do Sistema.',
            'Não sublicenciar, revender ou compartilhar o acesso sem autorização.',
            'Cumprir todas as leis aplicáveis, incluindo LGPD e CLT.',
          ],
        },
      ],
    },
    {
      id: 'contas',
      title: 'Contas de usuários e responsabilidades',
      blocks: [
        {
          t: 'ul',
          items: [
            'Registro: o Cliente deve criar contas para Usuários autorizados, fornecendo informações precisas.',
            'Segurança: o Cliente é responsável por manter senhas confidenciais e notificar a Natcorp sobre acessos não autorizados.',
            'Uso Adequado: o Cliente garante que o uso do Sistema não viole direitos de terceiros, inclua conteúdo ilegal ou sobrecarregue a infraestrutura.',
            'Dados do Cliente: o Cliente é responsável pela precisão e legalidade dos dados inseridos, incluindo obtenção de consentimentos para dados pessoais sensíveis (ex.: biometria, saúde).',
          ],
        },
      ],
    },
    {
      id: 'pagamentos',
      title: 'Pagamentos e taxas',
      blocks: [
        {
          t: 'p',
          text: 'As taxas pelo uso do Sistema são definidas no contrato de assinatura. O não pagamento pode resultar em suspensão ou término do acesso. A Natcorp pode ajustar taxas com notificação prévia de 30 dias.',
        },
      ],
    },
    {
      id: 'propriedade',
      title: 'Propriedade intelectual',
      blocks: [
        {
          t: 'p',
          text: 'O Sistema, incluindo software, módulos, APIs e documentação, é propriedade exclusiva da Natcorp. O Cliente retém direitos sobre seus dados, concedendo à Natcorp licença para processá-los conforme necessário para fornecer o serviço. Todos os desenvolvimentos, novas implementações, ajustes ou customizações no software da Natcorp, seja realizado pela Natcorp, Terceiros ou pelo Cliente, a propriedade é da Natcorp.',
        },
      ],
    },
    {
      id: 'dados',
      title: 'Confidencialidade e proteção de dados',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp trata dados pessoais conforme sua Política de Privacidade (incorporada aqui). Como Operadora, processamos dados sob instruções do Cliente, com medidas de segurança descritas na Política (ex.: criptografia, MFA).',
        },
        {
          t: 'ul',
          items: [
            'Transferências Internacionais: dados podem ser transferidos, com cláusulas contratuais padrão aprovadas pela ANPD.',
            'Incidentes: em caso de vazamentos, notificamos a ANPD em 72 horas e o Cliente para coordenação.',
            'Retenção: dados são retidos conforme instruções do Cliente e prazos legais (ex.: folha de pagamento por 30 anos).',
            'Dados Sensíveis: processados sob bases legais do Cliente (ex.: cumprimento de NRs).',
          ],
        },
        { t: 'p', text: 'O Cliente deve garantir conformidade com LGPD como Controlador.' },
      ],
    },
    {
      id: 'garantias',
      title: 'Garantias e isenções',
      blocks: [
        {
          t: 'p',
          text: 'A Natcorp garante que o Sistema funcionará substancialmente conforme descrito, com disponibilidade de 99% (exceto manutenções programadas ou de emergência). Não garantimos ausência de erros ou interrupções.',
        },
        {
          t: 'p',
          text: 'ISENÇÃO: O SISTEMA É FORNECIDO “COMO ESTÁ”, SEM GARANTIAS IMPLÍCITAS. A NATCORP NÃO SE RESPONSABILIZA POR DANOS INDIRETOS, CONSEQUENCIAIS OU PERDAS SEJAM FINANCEIRAS OU DE DADOS.',
        },
      ],
    },
    {
      id: 'responsabilidade',
      title: 'Limitação de responsabilidade',
      blocks: [
        {
          t: 'p',
          text: 'A responsabilidade total da Natcorp é limitada ao valor pago pelo Cliente na vigência do contrato, enquanto está sendo pago. Não respondemos por falhas causadas pelo Cliente ou terceiros.',
        },
      ],
    },
    {
      id: 'termino',
      title: 'Término',
      blocks: [
        {
          t: 'ul',
          items: [
            'Pelo Cliente: cancelamento com notificação de no mínimo 90 dias.',
            'Pela Natcorp: por violação destes Termos, com notificação.',
            'Efeitos: ao término, acesso é revogado; dados são excluídos conforme Política de Privacidade, salvo obrigações legais.',
          ],
        },
      ],
    },
    {
      id: 'lei',
      title: 'Lei aplicável e resolução de disputas',
      blocks: [
        {
          t: 'p',
          text: `Esses Termos são regidos pelas leis da República Federativa do Brasil. Disputas serão resolvidas no foro de ${empresa.foro}.`,
        },
      ],
    },
    {
      id: 'gerais',
      title: 'Disposições gerais',
      blocks: [
        {
          t: 'ul',
          items: [
            'Inteireza: estes Termos representam o acordo completo.',
            'Independência: cláusulas inválidas não afetam as demais.',
          ],
        },
        { t: 'contact' },
        { t: 'p', text: 'Ao usar o Sistema, Você confirma ter lido e aceitado estes Termos.' },
      ],
    },
  ],
}
