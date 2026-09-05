import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'administracao-de-pessoal',
  name: 'Administração de Pessoal',
  group: 'pessoal-e-folha',
  tagline: 'Quem ocupa cada posição e quanto custa, [[em tempo real]].',
  summary:
    'Estrutura, posições, vagas, movimentações e orçamento de pessoal no mesmo lugar. O gestor pede, a alçada financeira valida, o RH efetiva. Previsto e realizado lado a lado, por empresa e filial, com alerta quando o custo sai do orçado.',
  seo: {
    title: 'Administração de Pessoal e Headcount | Natcorp',
    description:
      'Administração de pessoal: headcount, posições, movimentações e orçamento previsto x realizado integrados à folha, com workflow de aprovação e alerta de desvio.',
  },
  highlights: [
    { value: '4 : 1.000', label: 'operadores para 1.000 colaboradores; mais um a cada 1.000' },
    { value: '5', label: 'status de posição, de planejada a ocupada, em tempo real' },
  ],
  benefits: [
    {
      title: 'RH, Finanças e Gestão com o mesmo número',
      text: 'Acaba a planilha paralela. Posições, vagas e custo de pessoal ficam em uma única fonte de verdade, por empresa, filial e centro de custo, com o consolidado para a matriz e o mesmo dado para quem contrata e para quem paga.',
    },
    {
      title: 'Desvio de orçamento descoberto na hora',
      text: 'Cada contratação, promoção ou reajuste mostra o impacto financeiro antes de acontecer. O alerta de desvio chega antes do fim do mês, não depois.',
    },
    {
      title: 'Movimentações sem redigitar',
      text: 'Admissão, transferência, promoção e desligamento nascem de requisições aprovadas no workflow e são efetivadas automaticamente na folha.',
    },
    {
      title: 'Equipe enxuta, mesmo com milhares de pessoas',
      text: 'Com entradas digitais e efetivação automática, a Administração de Pessoal opera com 4 operadores para 1.000 colaboradores; a cada 1.000 novos, mais um.',
    },
  ],
  features: [
    {
      title: 'Estrutura organizacional completa',
      text: 'Empresas, filiais, áreas, departamentos, centros de custo, cargos e posições mapeados e vinculados ao organograma do grupo. Headcount e orçamento por empresa, filial e centro de custo, consolidados para a matriz.',
      icon: 'building',
    },
    {
      title: 'Posições com status em tempo real',
      text: 'Cada posição aparece como ocupada, disponível, planejada, congelada ou em recrutamento. Vagas podem nascer automaticamente das premissas de headcount.',
      icon: 'layout-grid',
    },
    {
      title: 'Movimentações de pessoal',
      text: 'Admissões, desligamentos, transferências, promoções e alterações funcionais registradas com histórico e efetivadas na folha.',
      icon: 'refresh',
    },
    {
      title: 'Workflow com alçada financeira',
      text: 'O gestor solicita a criação ou reposição de posição, a alçada financeira valida e a aprovação final libera a vaga para o recrutamento.',
      icon: 'workflow',
    },
    {
      title: 'Orçamento previsto x realizado',
      text: 'Salários, encargos e benefícios compõem o custo de cada posição. Compare quadro atual, planejado, orçado e realizado, por empresa, filial e centro de custo, por hora ou por mês.',
      icon: 'bar-chart',
    },
    {
      title: 'Simulação de cenários',
      text: 'Projete crescimento ou redução do quadro e veja o impacto financeiro total antes de decidir uma expansão ou reestruturação.',
      icon: 'trending-up',
    },
    {
      title: 'Alertas de desvio e indicadores',
      text: 'Headcount, FTE, vagas abertas, turnover e custos monitorados, com alerta automático de desvio orçamentário e de inconsistências.',
      icon: 'bell',
    },
    {
      title: 'Dados cadastrais e funcionais',
      text: 'Endereço, dados bancários, dependentes, pensionistas e autônomos mantidos por requisição eletrônica, com registro de quem alterou o quê.',
      icon: 'clipboard',
    },
    {
      title: 'Conectado ao recrutamento e à folha',
      text: 'Uma contratação concluída no Recrutamento e Seleção atualiza o orçamento de pessoal e o headcount na hora, sem dupla digitação.',
      icon: 'link',
    },
    {
      title: 'Rastreabilidade e acesso por perfil',
      text: 'Histórico completo de alterações e controle de acesso por perfil e estrutura organizacional, pronto para auditoria.',
      icon: 'shield-check',
    },
  ],
  flow: {
    title: 'Da vaga pedida ao colaborador na folha',
    steps: [
      { title: 'Solicitação do gestor', text: 'O gestor pede a criação ou a reposição de uma posição pelo Portal do Gestor, com centro de custo e justificativa.' },
      { title: 'Validação da alçada financeira', text: 'O sistema mostra o custo da posição e o impacto no orçamento. Finanças valida dentro da alçada.' },
      { title: 'Aprovação e liberação', text: 'Aprovada, a posição fica em recrutamento e o processo seletivo é aberto automaticamente.' },
      { title: 'Admissão efetivada', text: 'Contratado o candidato, a Admissão Digital cria o cadastro e a posição passa a ocupada.' },
      { title: 'Orçamento atualizado', text: 'Headcount, FTE e custo realizado se atualizam na hora para RH, Finanças e Gestão.' },
    ],
  },
  compliance: ['LGPD: acesso por perfil e histórico de alterações', 'eSocial alimentado pelas movimentações registradas'],
  personas: [
    { role: 'Gestor', text: 'Pede a vaga, acompanha a aprovação e vê quando a pessoa começa, sem perguntar ao RH.' },
    { role: 'CFO e Finanças', text: 'Valida contratações dentro da alçada e enxerga previsto x realizado do custo de pessoal antes do fechamento.' },
    { role: 'RH e Departamento Pessoal', text: 'Efetiva movimentações aprovadas em poucos cliques e mantém organograma e quadro sempre atualizados.' },
  ],
  faq: [
    {
      q: 'O orçamento de pessoal considera encargos e benefícios ou só salário?',
      a: 'Considera o custo total da posição: salário base, encargos, benefícios e ocorrências. É esse valor que aparece no comparativo entre quadro atual, planejado, orçado e realizado e que dispara o alerta de desvio.',
    },
    {
      q: 'O gestor consegue pedir uma vaga sem passar por e-mail ou planilha?',
      a: 'Sim. A requisição de headcount é feita no Portal do Gestor, segue para a alçada financeira e para a aprovação final no workflow, com prazo controlado e histórico de cada etapa. Aprovada, o recrutamento é aberto automaticamente.',
    },
    {
      q: 'O módulo se integra com o ERP e o financeiro da empresa?',
      a: 'Sim. Além da integração nativa com Recrutamento e Seleção e Folha de Pagamento, o módulo se conecta a ERP, financeiro e BI, para que o custo de pessoal seja o mesmo em todos os sistemas.',
    },
    {
      q: 'Como fica a segurança de quem vê salário e custo por área?',
      a: 'O acesso é controlado por perfil e por estrutura organizacional, e todo acesso ou alteração fica registrado em histórico auditável, em conformidade com a LGPD.',
    },
  ],
  related: ['folha-de-pagamento', 'recrutamento-e-selecao', 'requisicoes-com-workflow', 'cargos-e-salarios'],
  sources: ['gestao-de-headcount', 'gestao-de-rh', 'gestao-de-requisicoes-eletronicas', 'pagadoria', 'produtividade-de-rh', 'gestao-de-cargos-e-remuneracoes'],
}

export default page
