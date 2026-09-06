import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'infraestrutura-e-seguranca',
  name: 'Infraestrutura e Segurança',
  group: 'dados-ia-plataforma',
  tagline: 'A folha não pode parar. [[A infraestrutura também não]].',
  summary:
    'O sistema Natcorp roda em servidores dedicados na Oracle Cloud, com produção, homologação e contingência separadas, duas cópias de segurança por dia e dados criptografados. Acesso por perfil, dois fatores e LGPD por desenho, em qualquer dispositivo.',
  seo: {
    title: 'Infraestrutura e Segurança de Dados do RH | Natcorp',
    description:
      'Servidores dedicados na Oracle Cloud para o sistema de RH: produção, homologação e contingência, dois backups diários, criptografia, dois fatores e LGPD.',
  },
  highlights: [
    { value: '2', label: 'cópias de segurança por dia, guardadas em área isolada' },
    { value: '3', label: 'datacenters em redundância, com plano de contingência' },
    { value: '2.500', label: 'colaboradores calculados por minuto na folha' },
    { value: '120+', label: 'idiomas disponíveis na plataforma' },
  ],
  benefits: [
    {
      title: 'A folha fecha, aconteça o que acontecer',
      text: 'Ambientes de alta disponibilidade e plano de recuperação de desastres garantem que a operação do RH continue mesmo diante do imprevisto.',
    },
    {
      title: 'Dados de pessoas protegidos de ponta a ponta',
      text: 'Informações pessoais, salariais e de saúde trafegam criptografadas, passam pelo firewall de aplicação e por uma camada de permissões antes do banco de dados, com acesso por perfil, dois fatores e registro de quem viu o quê.',
    },
    {
      title: 'Homologue antes de mudar a produção',
      text: 'Um ambiente de homologação separado permite testar regras, parametrizações e novidades sem tocar na folha real. A produção fica blindada.',
    },
    {
      title: 'Cresce sem perder velocidade',
      text: 'Datacenters de baixíssima latência e capacidade para 2.500 colaboradores por minuto na folha. Mais usuários e mais filiais não deixam o sistema lento.',
    },
  ],
  features: [
    {
      title: 'Servidores dedicados na Oracle Cloud',
      text: 'A Natcorp é parceira Oracle e roda o sistema em servidores dedicados na Oracle Cloud Infrastructure, em datacenters de alta disponibilidade e com proteção contra invasões e ameaças externas. O acesso passa por um firewall de aplicação; Oracle WebLogic e Oracle REST Data Services executam as aplicações; Oracle APEX conversa com o Oracle Database por uma camada de permissões.',
      icon: 'cloud',
    },
    {
      title: 'Produção, homologação e contingência',
      text: 'Ambientes separados para o dia a dia, para testes e para recuperação de desastres. O que está em teste nunca afeta a folha em produção.',
      icon: 'server',
    },
    {
      title: 'Duas cópias de segurança por dia',
      text: 'Backups diários blindados, guardados em área isolada, e redundância entre datacenters para restaurar a operação rapidamente.',
      icon: 'database',
    },
    {
      title: 'Criptografia em todo o caminho',
      text: 'Logins e todo o tráfego de informações e requisições são criptografados. Os dados sensíveis também ficam protegidos quando armazenados.',
      icon: 'lock',
    },
    {
      title: 'Autenticação em dois fatores',
      text: 'Além da senha, um segundo fator confirma quem está entrando. Perfis de acesso definem o que cada pessoa vê e faz no sistema.',
      icon: 'key',
    },
    {
      title: 'LGPD por desenho',
      text: 'Perfis granulares por empresa e filial, restrição a dados confidenciais, anonimização quando aplicável e trilha de auditoria de cada ação.',
      icon: 'shield-check',
    },
    {
      title: 'Auditoria de ações',
      text: 'Cada consulta, alteração e aprovação fica registrada com quem fez e quando. Tranquilidade em auditorias internas e externas.',
      icon: 'history',
    },
    {
      title: 'A mesma segurança em qualquer dispositivo',
      text: 'Computador, tablet e celular, iOS e Android, com o mesmo perfil, o mesmo segundo fator e a mesma trilha de auditoria. Interface responsiva e disponível em mais de 120 idiomas.',
      icon: 'smartphone',
    },
    {
      title: 'Canal direto com a engenharia',
      text: 'Um canal exclusivo para o cliente registrar incidentes e falar com a equipe técnica da Natcorp, com acompanhamento até a solução.',
      icon: 'message-square',
    },
  ],
  flow: {
    title: 'O ciclo seguro de cada novidade',
    steps: [
      { title: 'Desenvolvimento', text: 'Novas funções e ajustes são construídos em ambiente próprio, longe dos dados de produção.' },
      { title: 'Homologação e testes', text: 'A empresa valida regras e novidades em ambiente separado, com segurança.' },
      { title: 'Produção', text: 'Só o que foi aprovado entra no ambiente que o RH usa todos os dias.' },
      { title: 'Contingência', text: 'Cópias de segurança e redundância entre datacenters garantem a retomada se algo sair do previsto.' },
    ],
  },
  compliance: ['LGPD', 'Trilhas de auditoria de acesso e alterações', 'Conformidade com a legislação vigente em auditorias e no eSocial'],
  personas: [
    { role: 'CTO e TI', text: 'Recebe uma plataforma em servidores dedicados na Oracle Cloud, com ambientes segregados, redundância e canal direto com a engenharia, sem nada para instalar ou manter na empresa.' },
    { role: 'CHRO e CFO', text: 'Sabe que a folha não para e que dados salariais e de saúde estão protegidos e auditáveis.' },
    { role: 'RH e Departamento Pessoal', text: 'Trabalha de qualquer dispositivo, testa mudanças em homologação e opera a produção com tranquilidade.' },
  ],
  faq: [
    {
      q: 'Onde ficam os dados do sistema?',
      a: 'Em servidores dedicados na Oracle Cloud Infrastructure. A Natcorp é parceira Oracle e usa seus datacenters de alta disponibilidade, com proteção contra invasões e conexões de baixíssima latência. Há ainda redundância em outros datacenters e um ambiente dedicado à recuperação de desastres.',
    },
    {
      q: 'Como é a arquitetura por trás do sistema?',
      a: 'Em camadas. O usuário acessa pelo navegador, no desktop ou no celular, e a conexão passa por um Web Application Firewall, com HTTPS, filtro WAF, credenciais e autenticação em dois fatores. Dali, a requisição chega aos servidores dedicados na Oracle Cloud Infrastructure: Oracle WebLogic e Oracle REST Data Services executam as aplicações Java, e o Oracle APEX conversa com o Oracle Database por uma camada de permissões, que entrega só os dados que o perfil do usuário permite.',
    },
    {
      q: 'O que acontece se houver uma falha?',
      a: 'A operação continua. Os ambientes são redundantes, há duas cópias de segurança por dia guardadas em área isolada e um plano de recuperação de desastres para retomar o serviço. Processos críticos, como a folha, não param.',
    },
    {
      q: 'Como o acesso é controlado?',
      a: 'Por perfis granulares por empresa e filial, com login criptografado e autenticação em dois fatores. Cada usuário vê apenas o que a sua função permite, o RH de cada filial vê só a sua filial, dados confidenciais têm restrição adicional e todas as ações ficam registradas em trilha de auditoria.',
    },
    {
      q: 'O sistema atende à LGPD?',
      a: 'Sim. A arquitetura foi desenhada para a LGPD: controle granular de acesso, restrição a dados confidenciais, anonimização quando aplicável, criptografia do tráfego e trilhas de auditoria. Isso vale para todos os módulos, da admissão ao desligamento.',
    },
  ],
  related: ['conexao-com-outros-sistemas', 'esocial', 'nati', 'portais'],
  sources: ['infraestrutura-e-resiliencia', 'performance-e-seguranca', 'tecnologia', 'csc-bpo', 'apresentacao-natcorp', 'paineis-inteligentes'],
}

export default page
