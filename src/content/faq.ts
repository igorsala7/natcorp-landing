export interface FaqItem {
  q: string
  a: string
}

/** As quatro primeiras aparecem na home. */
export const faqs: FaqItem[] = [
  {
    q: 'O que a Natcorp substitui na minha operação de RH?',
    a: 'Tudo o que o RH faz hoje em sistemas separados e planilhas: folha de pagamento, ponto eletrônico, eSocial, admissão digital, recrutamento, avaliações, treinamento, benefícios, saúde e segurança do trabalho, portais e requisições. São 31 módulos em um único sistema, com um só cadastro e uma só base de dados.',
  },
  {
    q: 'A Natcorp é para empresas de que tamanho e estrutura?',
    a: 'Para grandes empresas e grupos: milhares de colaboradores, várias empresas e CNPJs, filiais em cidades diferentes e regras de jornada, convenção e benefícios que precisam ser respeitadas com precisão. Empresas, CNPJs e sindicatos são ilimitados na mesma base, e os perfis de acesso seguem a estrutura da sua organização: por empresa, filial e centro de custo.',
  },
  {
    q: 'O sistema aguenta o volume de um grupo grande?',
    a: 'Sim. A folha calcula 2.500 colaboradores por minuto: 20 mil colaboradores ficam calculados em cerca de 8 minutos, prontos para a conferência da NATI. Cada evento do eSocial é enviado e acompanhado na mesma tela, por empresa.',
  },
  {
    q: 'Cada filial pode operar o seu RH e a matriz fechar a folha?',
    a: 'Sim. O RH de cada unidade admite, trata o ponto, lança movimentações e benefícios dentro do seu perfil e das suas alçadas. Tudo cai na mesma base, e a matriz fecha a folha, confere por filial e consolida por empresa, sem receber planilha nem redigitar nada.',
  },
  {
    q: 'O sistema atende ao eSocial?',
    a: 'Sim. A integração com o eSocial é completa: o envio de cada layout, o acompanhamento e o retorno do status acontecem dentro do sistema, por empresa, sem exportações manuais.',
  },
  {
    q: 'Como funciona o ponto para equipes em campo ou em várias unidades?',
    a: 'Com o NatPonto, o app de marcação com geolocalização e reconhecimento facial, com um raio de marcação por unidade. O sistema também recebe marcações de relógios de ponto e de outros sistemas, apura as jornadas (fixas, flexíveis ou variáveis) e envia os eventos direto para a folha.',
  },
  {
    q: 'O que é a NATI?',
    a: 'A NATI é a inteligência artificial da Natcorp, que trabalha dentro do sistema. Ela atende colaboradores e gestores no autoatendimento, responde dúvidas, gera informações, confere a folha antes do fechamento e apoia os operadores do RH nas rotinas do dia a dia. Cada pessoa vê apenas o que o seu perfil permite.',
  },
  {
    q: 'Onde ficam os dados e como é a segurança?',
    a: 'Em nuvem segura, na infraestrutura Oracle Cloud, com ambientes separados de produção e homologação e um serviço de contingência (disaster recovery) para garantir a continuidade da operação. Perfis de acesso por empresa e filial, trilha de auditoria e tratamento de dados conforme a LGPD.',
  },
  {
    q: 'A Natcorp se conecta aos sistemas que já usamos?',
    a: 'Sim. O módulo de importação e exportação de dados permite que o próprio usuário disponibilize as tabelas desejadas para enviar e receber informações de outros sistemas, como ERP, operadoras de benefícios e relógios de ponto. A contabilização da folha sai por empresa, pronta para o ERP.',
  },
  {
    q: 'Funciona no celular?',
    a: 'Sim. O sistema é responsivo e os Portais do Gestor, do Colaborador e do Candidato funcionam no celular, no tablet e no computador. O NatPonto é um aplicativo dedicado à marcação de ponto.',
  },
  {
    q: 'Como é a implantação para um grupo com várias empresas e filiais?',
    a: 'Planejamento por empresa e filial, migração do histórico sem limite de anos, validação em ambiente de homologação com a folha atual em paralelo e treinamento das equipes da matriz e das filiais antes da entrada em produção. Depois, o acompanhamento continua de perto: suporte por chamados com prazo e histórico, e um time que conhece a sua operação.',
  },
  {
    q: 'Como a Natcorp cobra?',
    a: 'A proposta considera o porte e os módulos que a sua operação precisa. Não há cobrança por usuário, por CNPJ nem por histórico: todos os colaboradores acessam os portais, todas as empresas do grupo entram na mesma base e a migração traz o histórico completo.',
  },
]
