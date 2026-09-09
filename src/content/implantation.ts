/**
 * Implantação, migração e serviços — conteúdo da página /implantacao.
 *
 * POR QUE ESTA PÁGINA EXISTE
 *
 * O conteúdo de serviços vivia como uma seção dentro de /sobre, e 49 links internos
 * apontavam para `/sobre#servicos` — um FRAGMENTO de página institucional. Era o
 * segundo destino mais linkado do site, à frente da página de folha de pagamento.
 *
 * Dois problemas nisso. Para quem busca: "implantação de sistema de RH" e "migração
 * de sistema de RH" são consultas reais, e âncora dentro de "quem somos" não ranqueia
 * para elas. Para quem compra: como é a implantação e quem atende depois é a maior
 * objeção do diretor de TI e a segunda do diretor de RH — e estava enterrada numa
 * página sobre a história da empresa.
 *
 * Agora é página própria, e os 49 links passam a apontar para ela.
 */

export interface ImplantationStep {
  /** Nome curto do passo, como aparece no diagrama. */
  title: string
  text: string
}

/** As etapas de uma implantação, na ordem em que acontecem. Vira HowTo em JSON-LD. */
export const implantationSteps: ImplantationStep[] = [
  {
    title: 'Levantamento por empresa e filial',
    text: 'Mapeamos as convenções, os acordos, as regras de jornada e os benefícios de cada empresa e de cada unidade. Grupo com vários CNPJs é tratado como grupo desde o primeiro dia, não como somatório de empresas isoladas.',
  },
  {
    title: 'Migração do histórico completo',
    text: 'O histórico da empresa entra inteiro, sem limite de anos: cadastros, movimentações, férias, afastamentos, rescisões e a base de cálculo de médias. Sem histórico truncado, não há cálculo de média errado no primeiro fechamento.',
  },
  {
    title: 'Parametrização das regras',
    text: 'Rubricas, tabelas, políticas de cargo e salário, regras de ponto e workflows de aprovação são configurados conforme a operação já funciona hoje — e não conforme um padrão de sistema.',
  },
  {
    title: 'Homologação com a folha atual em paralelo',
    text: 'A folha roda nos dois sistemas ao mesmo tempo e os resultados são comparados colaborador a colaborador. A virada só acontece quando os números batem.',
  },
  {
    title: 'Treinamento por perfil de uso',
    text: 'A equipe de RH, os gestores e os operadores das filiais são treinados no que cada um vai usar, antes da entrada em produção. Ninguém aprende o sistema no dia do fechamento.',
  },
  {
    title: 'Entrada em produção acompanhada',
    text: 'O primeiro fechamento de folha é acompanhado de perto pelo time de implantação. Só depois dele o projeto é considerado concluído.',
  },
  {
    title: 'Suporte por chamados, com prazo e histórico',
    text: 'A partir daí, central de chamados com prazos definidos, histórico de cada atendimento e um time que já conhece a sua operação — porque foi quem implantou.',
  },
]

export interface ImplantationFaq {
  q: string
  a: string
}

export const implantationFaqs: ImplantationFaq[] = [
  {
    q: 'Quanto tempo leva a implantação de um sistema de RH?',
    a: 'Depende do número de empresas, das convenções envolvidas e do volume de histórico a migrar. O que define o cronograma não é o tamanho da empresa, e sim a quantidade de regras diferentes: um grupo com uma convenção só implanta mais rápido que uma empresa única com cinco acordos coletivos. O plano é montado empresa a empresa e filial a filial, com marcos e responsáveis definidos antes de começar.',
  },
  {
    q: 'A migração traz todo o histórico ou só os dados atuais?',
    a: 'Traz o histórico completo, sem limite de anos: cadastros, movimentações, férias, afastamentos, rescisões e a base de cálculo de médias. Isso importa mais do que parece — histórico truncado produz cálculo de média errado já no primeiro fechamento, e o erro só aparece quando o colaborador reclama.',
  },
  {
    q: 'Como vocês garantem que a folha não vai sair errada na virada?',
    a: 'A folha roda em paralelo nos dois sistemas durante a homologação, e os resultados são comparados colaborador a colaborador. A virada só acontece quando os números batem. O primeiro fechamento em produção também é acompanhado pelo time que implantou.',
  },
  {
    q: 'Quem faz a implantação: a Natcorp ou um parceiro?',
    a: 'A própria Natcorp. Implantação, migração, treinamento, desenvolvimento sob medida e suporte são feitos por times da casa, sem intermediário. É a mesma equipe que conhece o sistema por dentro e que responde depois, no dia a dia.',
  },
  {
    q: 'E depois que entra em produção, quem atende?',
    a: 'Central de chamados com prazos definidos, histórico de cada atendimento e controle de qualidade. Quem atende conhece a sua operação porque acompanhou a implantação. Quando faz sentido para a empresa, também há alocação de consultores dentro da operação e BPO de folha e rotinas de Departamento Pessoal.',
  },
  {
    q: 'A Natcorp desenvolve customizações?',
    a: 'Sim, com fábrica de software própria. Desenvolvimentos sob medida são feitos pela Natcorp, sem depender de terceiros. Vale registrar o que consta dos Termos de Uso: a propriedade dos desenvolvimentos, ajustes e customizações no software é da Natcorp, mesmo quando solicitados ou realizados pelo cliente.',
  },
]
