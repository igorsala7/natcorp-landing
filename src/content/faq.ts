export interface FaqItem {
  q: string
  a: string
}

export const faqs: FaqItem[] = [
  {
    q: 'O que a Natcorp substitui na minha operação de RH?',
    a: 'Tudo o que o RH faz hoje em sistemas separados e planilhas: folha de pagamento, ponto eletrônico, eSocial, admissão digital, recrutamento, avaliações, treinamento, benefícios, saúde e segurança do trabalho, portais e requisições. São mais de 30 módulos em um único sistema, com um só cadastro e uma só base de dados.',
  },
  {
    q: 'A Natcorp é para empresas de que tamanho?',
    a: 'Para grandes empresas e contas enterprise, com milhares de colaboradores, várias unidades e regras de jornada, convenção e benefícios que precisam ser respeitadas com precisão. O sistema é flexível para acompanhar a estrutura da sua organização.',
  },
  {
    q: 'O sistema atende ao eSocial?',
    a: 'Sim. A integração com o eSocial é completa: o envio de cada layout, o acompanhamento e o retorno do status acontecem dentro do sistema, sem exportações manuais.',
  },
  {
    q: 'Como funciona o ponto para equipes em campo ou em várias unidades?',
    a: 'Com o NatPonto, o app de marcação com geolocalização e reconhecimento facial. O sistema também recebe marcações de relógios de ponto e de outros sistemas, apura as jornadas (fixas, flexíveis ou variáveis) e envia os eventos direto para a folha.',
  },
  {
    q: 'O que é a NATI?',
    a: 'A NATI é a inteligência artificial da Natcorp, que trabalha dentro do sistema. Ela atende colaboradores e gestores no autoatendimento, responde dúvidas, gera informações e apoia os operadores do RH nas rotinas do dia a dia.',
  },
  {
    q: 'Onde ficam os dados e como é a segurança?',
    a: 'Em nuvem segura, na infraestrutura Oracle Cloud, com ambientes separados de produção e homologação e um serviço de contingência (disaster recovery) para garantir a continuidade da operação. O tratamento de dados segue a LGPD.',
  },
  {
    q: 'A Natcorp se conecta aos sistemas que já usamos?',
    a: 'Sim. O módulo de importação e exportação de dados permite que o próprio usuário disponibilize as tabelas desejadas para enviar e receber informações de outros sistemas, como ERP, operadoras de benefícios e relógios de ponto.',
  },
  {
    q: 'Funciona no celular?',
    a: 'Sim. O sistema é responsivo e os Portais do Gestor, do Colaborador e do Candidato funcionam no celular, no tablet e no computador. O NatPonto é um aplicativo dedicado à marcação de ponto.',
  },
  {
    q: 'Como é a implantação e o acompanhamento?',
    a: 'Planejamento conjunto, migração dos dados, validação em ambiente de homologação e treinamento das equipes antes da entrada em produção. Depois, o acompanhamento continua de perto: atenção, esforço da equipe e agilidade nas respostas são parte do que entregamos.',
  },
]
