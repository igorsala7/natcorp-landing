import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'varejo',
  name: 'Varejo',
  ctaContext: 'de varejo',
  tagline: 'O RH que acompanha [[cada loja]], da escala de domingo à admissão da temporada.',
  summary:
    'Dezenas de lojas, cada uma com sua escala, sua convenção e seu gerente no chão de loja. A Natcorp coloca headcount, ponto, folha, benefícios e admissão na mesma base, por unidade e região, para que o RH central enxergue tudo e a loja resolva o dia a dia sozinha.',
  seo: {
    title: 'Sistema de RH para varejo: escalas e lojas | Natcorp',
    description:
      'RH para varejo: escalas de shopping, ponto no tablet da loja, admissão em massa sem papel, vários CNPJs e sindicatos e indicadores por loja em um único sistema.',
  },
  context: [
    'No varejo, a operação de pessoas acontece longe da matriz. O gerente de loja abre e fecha o turno, cobre falta, aprova troca de escala e recebe o candidato da vaga que ele mesmo pediu. Cada cidade tem uma convenção, cada shopping tem um horário, e os picos de Black Friday, Dia das Mães e Natal multiplicam admissões e desligamentos em poucas semanas.',
    'O RH central precisa de duas coisas ao mesmo tempo: dar autonomia para a loja resolver sozinha e enxergar, em tempo real, headcount, custo, absenteísmo e horas extras de cada unidade. Quando isso depende de planilha e e-mail, a folha fecha atrasada e a hora extra não apurada vira passivo.',
  ],
  facts: [
    { value: 'Loja a loja', label: 'headcount, escala, custo e indicadores por unidade e região' },
    { value: 'Domingos e feriados', label: 'escalas de shopping, folgas e banco de horas pela regra da convenção' },
    { value: 'Temporada', label: 'admissão em massa sem papel, com onboarding no celular do novo colaborador' },
  ],
  pains: [
    { icon: 'clock', title: 'Escalas de shopping e horas extras sem controle', text: 'Domingos, feriados, horário estendido de dezembro e trocas de folga combinadas no balcão. Sem apuração automática, a hora extra aparece na folha tarde demais ou não aparece.' },
    { icon: 'user-plus', title: 'Contratar muita gente em pouco tempo', text: 'A temporada exige dezenas de admissões por semana, com documento, exame e contrato de cada pessoa. Em papel, a loja abre com gente sem cadastro na folha.' },
    { icon: 'building', title: 'Muitas lojas, CNPJs e convenções', text: 'Cada município tem sua convenção do comércio; cada bandeira, seu CNPJ. Regras diferentes de piso, adicional e jornada precisam conviver na mesma folha.' },
    { icon: 'refresh', title: 'Turnover alto e equipe sempre nova', text: 'Quem entra precisa aprender rápido a operação, a segurança e a política de atendimento. Quem sai leva conhecimento e abre uma vaga que a loja não pode esperar.' },
    { icon: 'smartphone', title: 'Gestor no chão de loja, sem computador', text: 'O gerente aprova férias, abono e vaga entre um cliente e outro. Se o sistema só funciona na mesa do RH, a decisão espera e a fila cresce.' },
    { icon: 'bar-chart', title: 'Custo de pessoal por loja invisível até o fechamento', text: 'Sem indicador por unidade, o desvio de horas extras ou de headcount de uma loja só aparece quando a folha do mês já fechou.' },
  ],
  answers: [
    {
      pain: 'Escalas e horas',
      title: 'Ponto no tablet da loja, escala pela convenção, hora extra apurada no dia',
      text: 'O NatPonto em modo multiusuário atende a equipe inteira no mesmo aparelho, com reconhecimento facial. O Ponto Eletrônico aplica escala de shopping, folgas de domingo, tolerâncias e banco de horas conforme a convenção de cada cidade, e a troca de folga vira requisição aprovada pelo gerente no celular.',
      modules: ['natponto', 'ponto-eletronico', 'requisicoes-com-workflow', 'folha-de-pagamento'],
    },
    {
      pain: 'Temporada',
      title: 'Admissão em massa sem papel, da vaga ao primeiro dia',
      text: 'A requisição de pessoal do gerente abre o processo seletivo, a vaga entra no quadro com a marca da empresa e o aprovado faz a admissão pelo celular: dados, documentos, benefícios e contrato assinado. O cadastro nasce na folha e no ponto antes de a loja abrir.',
      modules: ['recrutamento-e-selecao', 'quadro-de-vagas', 'admissao-digital', 'assinatura-eletronica', 'onboarding'],
    },
    {
      pain: 'CNPJs e convenções',
      title: 'Uma folha para todas as bandeiras e convenções',
      text: 'A folha trata múltiplos vínculos e sindicatos na mesma empresa, com todas as bandeiras e CNPJs da rede. Posições e orçamento são geridos por loja e centro de custo, o vale-transporte segue o trajeto de cada unidade e o eSocial recebe admissões e desligamentos no prazo.',
      modules: ['folha-de-pagamento', 'administracao-de-pessoal', 'gestao-de-beneficios', 'esocial'],
    },
    {
      pain: 'Turnover',
      title: 'Quem entra aprende rápido; quem cresce fica',
      text: 'A trilha de entrada do cargo matricula o novo colaborador nos treinamentos de integração e de segurança da loja. Metas e PLR por unidade, avaliações de experiência e o mapa de sucessão de líder de loja para gerente dão motivo para ficar.',
      modules: ['treinamento-e-desenvolvimento', 'metas-e-resultados', 'avaliacoes-e-feedbacks', 'carreira-e-sucessao'],
    },
    {
      pain: 'Gestor na loja',
      title: 'Portal do Gestor no celular e a NATI para a equipe',
      text: 'Férias, abono, vaga, promoção e desligamento são aprovados pelo celular, com alçadas definidas. O colaborador consulta holerite, escala e benefícios pelo portal ou pergunta à NATI no WhatsApp, e o NatPay adianta salário sem passar pelo DP.',
      modules: ['portais', 'nati', 'natpay', 'chamado-interno'],
    },
    {
      pain: 'Custo por loja',
      title: 'Indicadores por loja e região antes do fechamento',
      text: 'Headcount, horas extras, absenteísmo e custo de pessoal por unidade no painel, com alerta de desvio de orçamento. O comparativo entre meses mostra onde a folha subiu, e a NATI aponta as inconsistências antes de pagar.',
      modules: ['people-analytics', 'business-intelligence', 'administracao-de-pessoal', 'nati'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Múltiplos CNPJs, convenções e sindicatos na mesma folha, com o ponto de cada loja já apurado.',
    'administracao-de-pessoal': 'Posições, vagas e orçamento por loja, região e centro de custo, com alerta de desvio.',
    'cargos-e-salarios': 'Pisos por convenção, faixas por bandeira e política de mérito aplicada em toda a rede.',
    'gestao-de-beneficios': 'Vale-transporte por trajeto e loja, alimentação e plano de saúde com elegibilidade por cargo.',
    natpay: 'Adiantamento salarial por Pix, sem pedido ao DP da rede, com desconto automático na folha da loja.',
    esocial: 'Admissões e desligamentos em volume enviados no prazo, com validação antes do envio.',
    'juridico-trabalhista': 'Histórico de ponto, escala e pagamento pronto para responder reclamações de hora extra e domingo.',
    'ponto-eletronico': 'Escalas de shopping, folgas de domingo, tolerâncias e banco de horas pela regra de cada convenção.',
    natponto: 'Modo multiusuário no tablet da loja, com reconhecimento facial e geolocalização por unidade.',
    'medicina-ocupacional': 'Exames admissionais em volume na temporada e atestados registrados pelo portal.',
    'seguranca-do-trabalho': 'EPIs de açougue, padaria e estoque com CA validado e ficha assinada na tela.',
    'recrutamento-e-selecao': 'Processo seletivo aberto pela requisição do gerente, com banco de talentos por cidade.',
    'quadro-de-vagas': 'Vagas de todas as lojas publicadas com a marca da rede, candidatura pelo celular.',
    'admissao-digital': 'Admissão em massa sem papel: o candidato preenche, o RH valida, a folha recebe.',
    onboarding: 'Boas-vindas, política de atendimento e instruções da loja no celular desde o primeiro dia.',
    offboarding: 'Desligamento da temporada padronizado, com rescisão calculada e acessos encerrados.',
    'avaliacoes-e-feedbacks': 'Avaliação de experiência e feedback do gerente de loja pelo celular.',
    'metas-e-resultados': 'Metas e PLR por loja, região e função, com apuração proporcional ao tempo de contrato.',
    'treinamento-e-desenvolvimento': 'Trilha de entrada por cargo e treinamentos obrigatórios com validade controlada.',
    'carreira-e-sucessao': 'Mapa de sucessores para gerente de loja e supervisor regional, com prontidão.',
    portais: 'Portal do Gestor no celular do gerente e Portal do Colaborador para holerite, escala e requisições.',
    'requisicoes-com-workflow': 'Troca de folga, abono, férias, vaga e promoção com alçadas por loja e região.',
    'chamado-interno': 'Dúvidas da loja com o RH central registradas e respondidas com prazo.',
    'blog-corporativo': 'Campanhas, comunicados de temporada e reconhecimento de lojas em um só canal.',
    'assinatura-eletronica': 'Contratos de temporada e termos assinados pelo celular, com validade jurídica.',
    ged: 'Documentos de admissão e fichas de EPI guardados por pessoa, sem arquivo físico na loja.',
    'people-analytics': 'Headcount, turnover, absenteísmo e horas extras por loja, região e bandeira.',
    'business-intelligence': 'Painéis comparando lojas e períodos, com exportação para as reuniões de resultado.',
    nati: 'Responde à equipe de loja no domingo, quando o RH central está fechado, e confere a folha de cada CNPJ antes do fechamento.',
    'conexao-com-outros-sistemas': 'Conecta com o sistema de vendas para comissões e com a catraca e o ERP da rede.',
    'infraestrutura-e-seguranca': 'Nuvem com contingência para a rede inteira, acesso por perfil e por loja.',
  },
  spotlight: ['natponto', 'ponto-eletronico', 'admissao-digital', 'folha-de-pagamento', 'portais', 'people-analytics'],
  compliance: [
    'Convenções coletivas do comércio por município e categoria',
    'Trabalho aos domingos e feriados no comércio, conforme a lei e a convenção',
    'Ponto eletrônico conforme a Portaria 671, com arquivos AFD e AEJ',
    'eSocial: admissões e desligamentos em volume dentro do prazo',
    'NR-06 para EPIs de açougue, padaria, estoque e limpeza',
    'LGPD no tratamento de dados de candidatos e colaboradores da rede',
  ],
  personas: [
    { role: 'Gerente de loja', text: 'Aprova escala, abono, férias e vaga pelo celular, entre um cliente e outro, sem ligar para o RH.' },
    { role: 'RH regional', text: 'Enxerga headcount, horas extras e turnover de cada loja e age antes de a folha fechar.' },
    { role: 'Colaborador de loja', text: 'Bate o ponto no tablet, vê a escala e o holerite no celular e pergunta à NATI quando precisar.' },
  ],
  faq: [
    {
      q: 'O sistema trata escalas diferentes por loja e por cidade?',
      a: 'Sim. Escalas, folgas de domingo, tolerâncias e banco de horas são parametrizados por unidade e por convenção. O Ponto Eletrônico aplica a regra certa a cada loja e envia os eventos apurados para a folha.',
    },
    {
      q: 'Dá para bater ponto no mesmo tablet com toda a equipe da loja?',
      a: 'Sim. O NatPonto tem modo multiusuário: um aparelho fixo na loja atende toda a equipe, com reconhecimento facial, e funciona mesmo sem internet, sincronizando depois.',
    },
    {
      q: 'Como fica a admissão em massa na temporada?',
      a: 'A requisição do gerente abre a vaga, o candidato faz a admissão pelo celular, com documentos e contrato assinado, e o cadastro nasce na folha, no ponto e nos benefícios. O RH só valida.',
    },
    {
      q: 'Consigo comparar o custo de pessoal entre lojas?',
      a: 'Sim. O People Analytics e o Business Intelligence mostram headcount, horas extras, absenteísmo e custo por loja, região e bandeira, com comparativos entre períodos e alerta de desvio do orçamento.',
    },
  ],
  visual: 'natponto',
  related: ['bens-de-consumo', 'servicos-ao-consumidor'],
}

export default page
