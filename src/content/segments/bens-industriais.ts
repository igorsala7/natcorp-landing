import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'bens-industriais',
  name: 'Bens Industriais',
  tagline: 'Turno de revezamento, adicional e NR: [[o chão de fábrica]] na mesma base da folha.',
  summary:
    'Fábricas com turnos de revezamento, várias unidades, sindicatos fortes e NRs pesadas. A Natcorp apura ponto, adicionais e banco de horas pela regra de cada acordo, liga PGR, GHE, EPIs, CAT e PPP à folha e ao eSocial e coloca o gestor de turno no celular, com o RH central enxergando cada planta.',
  seo: {
    title: 'Sistema de RH para indústria: turnos, NRs e SESMT | Natcorp',
    description:
      'RH para a indústria: turnos de revezamento, adicional noturno e insalubridade na folha, banco de horas por acordo, PGR, EPIs, CAT e PPP ligados ao eSocial.',
  },
  context: [
    'Na indústria, a jornada não para. Turnos de revezamento, 12x36, terceiro turno e escalas 6x2 convivem na mesma planta, com adicional noturno, insalubridade e periculosidade calculados por função e por exposição. O banco de horas segue o acordo coletivo negociado com metalúrgicos ou químicos, e cada unidade tem seu sindicato, seu relógio de ponto e seus terceirizados dentro do portão.',
    'O SESMT carrega a parte mais pesada: PGR e GHE por ambiente, NR-12 nas máquinas, NR-10, NR-33 e NR-35 nas atividades críticas, EPIs entregues em massa, treinamentos com validade, CIPA, CAT e o LTCAT que sustenta o PPP da aposentadoria especial. Quando isso vive em planilhas separadas do RH, o adicional sai errado na folha, o treinamento vence sem aviso e a defesa trabalhista nasce sem evidência.',
  ],
  facts: [
    { value: 'Turnos de revezamento', label: 'escalas 6x2, 12x36 e terceiro turno apuradas com adicional noturno e DSR' },
    { value: 'NR-12 a NR-35', label: 'checklists de NR, EPIs com CA validado e treinamentos obrigatórios com validade' },
    { value: 'LTCAT e PPP', label: 'exposição do PGR e do GHE virando PPP para a aposentadoria especial' },
  ],
  pains: [
    { icon: 'clock', title: 'Turnos de revezamento e adicionais apurados na mão', text: 'Escala 6x2, 12x36 e terceiro turno na mesma planta, com adicional noturno, hora extra e DSR de regras diferentes. Apurado em planilha, o erro só aparece na folha ou na reclamação trabalhista.' },
    { icon: 'scale', title: 'Banco de horas e sindicato diferente em cada unidade', text: 'Metalúrgicos numa planta, químicos na outra, cada acordo coletivo com seu banco de horas, seu piso e seu adicional. A folha precisa aplicar a regra certa a cada CNPJ sem virar exceção manual.' },
    { icon: 'hard-hat', title: 'NRs pesadas, EPIs em massa e treinamento vencendo', text: 'NR-12 nas máquinas, NR-10, NR-33 e NR-35 nas atividades críticas. Centenas de EPIs entregues por mês e treinamentos com validade que vencem sem aviso. Sem controle, a fábrica opera fora da norma.' },
    { icon: 'alert-triangle', title: 'CAT, exposição e o PPP da aposentadoria especial', text: 'O acidente exige CAT e S-2210 em 24 horas. O agente nocivo exige S-2240, LTCAT atualizado e PPP correto. Quando o histórico de exposição vive em papel, o PPP sai incompleto e o passivo cresce.' },
    { icon: 'users', title: 'Várias plantas, terceiros e gestor de turno sem mesa', text: 'O supervisor aprova troca de turno, abono e hora extra no chão de fábrica, sem computador. Terceiros entram pelo mesmo portão e precisam de cadastro, EPI e controle de acesso como qualquer um.' },
    { icon: 'bar-chart', title: 'Absenteísmo e hora extra que só aparecem no fechamento', text: 'Falta no terceiro turno vira hora extra de quem cobre. Atestado por CID se repete numa linha e ninguém cruza com o risco do GHE. Sem indicador por planta e turno, o custo só aparece na folha.' },
  ],
  answers: [
    {
      pain: 'Turnos e adicionais',
      title: 'Escala de revezamento, adicional noturno e DSR apurados pela regra de cada turno',
      text: 'O Ponto Eletrônico trata jornadas fixas e variáveis, escalas 12x36, plantões noturnos e rotativos, DSR, interjornada e adicional noturno pela regra de cada sindicato. As marcações chegam do relógio de ponto da planta ou do NatPonto no celular, e horas extras, faltas e adicionais viram eventos de folha sem digitação.',
      modules: ['ponto-eletronico', 'natponto', 'folha-de-pagamento', 'conexao-com-outros-sistemas'],
    },
    {
      pain: 'Acordos e sindicatos',
      title: 'Uma folha para todas as plantas, com o banco de horas de cada acordo',
      text: 'A folha trata múltiplos vínculos e acordos sindicais na mesma empresa, sem limite de CNPJs, com periculosidade parametrizada no cargo e os adicionais da convenção aplicados no cálculo. O banco de horas tem regra por sindicato, centro de custo ou colaborador, e o dissídio é simulado com o impacto real na folha antes de aprovar.',
      modules: ['folha-de-pagamento', 'ponto-eletronico', 'cargos-e-salarios', 'esocial'],
    },
    {
      pain: 'NRs e EPIs',
      title: 'Checklists de NR, EPI com CA validado e treinamento com validade controlada',
      text: 'O SESMT roda checklists de NR-10, NR-12, NR-35 e outras no tablet, em campo. EPIs têm estoque, entrega, substituição e CA consultado na base do Governo Federal, com a ficha assinada por biometria ou assinatura eletrônica. Treinamentos obrigatórios têm validade com alerta e entram nos checklists antes de vencer.',
      modules: ['seguranca-do-trabalho', 'treinamento-e-desenvolvimento', 'assinatura-eletronica', 'nati'],
    },
    {
      pain: 'CAT, LTCAT e PPP',
      title: 'Do risco no PGR ao PPP: CAT em 24 horas e exposição pronta para o eSocial',
      text: 'O risco mapeado no PGR alimenta o GHE, o PCMSO, o LTCAT e o PPP. A CAT é aberta em poucos passos e o S-2210 sai em até 24 horas. O S-2240 nasce do PGR e o S-2220 do ASO, todos com validador antes do envio. O PPP é gerado na hora a partir do histórico de exposição, ou pedido por requisição.',
      modules: ['seguranca-do-trabalho', 'medicina-ocupacional', 'esocial', 'requisicoes-com-workflow'],
    },
    {
      pain: 'Gestor de turno',
      title: 'Portal do Gestor no celular do supervisor e terceiros dentro do sistema',
      text: 'Troca de turno, abono, hora extra e férias são aprovados pelo celular, com alçada por planta e centro de custo e suplente automático na virada de turno. Terceiros e autônomos entram por requisição, e a catraca e o controle de acesso da planta se conectam ao Ponto Eletrônico.',
      modules: ['portais', 'requisicoes-com-workflow', 'conexao-com-outros-sistemas', 'natponto'],
    },
    {
      pain: 'Absenteísmo e custo',
      title: 'Absenteísmo por turno, atestados por CID e hora extra antes do fechamento',
      text: 'O painel de absenteísmo cruza atestados por CID, área e período e aponta padrões ergonômicos por linha. Horas extras contra saldo do banco, abonos por filial e distribuição de escalas aparecem por planta e turno, e a NATI confere a folha e aponta horas extras indevidas antes de pagar.',
      modules: ['medicina-ocupacional', 'ponto-eletronico', 'business-intelligence', 'people-analytics', 'nati'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Adicional noturno, horas extras e banco de horas de cada acordo coletivo já apurados, com múltiplos CNPJs e sindicatos.',
    'administracao-de-pessoal': 'Headcount e orçamento por planta, turno e centro de custo, com alerta quando a hora extra estoura o previsto.',
    'cargos-e-salarios': 'Periculosidade e cargo de confiança na ficha do cargo, pisos por sindicato e simulação do dissídio dos metalúrgicos.',
    'gestao-de-beneficios': 'Cesta básica com postos de entrega por planta, vale-transporte por unidade e plano de saúde com fatura conferida.',
    natpay: 'Adiantamento pelo WhatsApp, com limite pelos dias trabalhados no ponto, para a equipe de turno não passar pelo DP.',
    esocial: 'S-2210 em até 24 horas após a CAT, S-2240 nascido do PGR e S-2220 do ASO, com validador antes do envio.',
    'juridico-trabalhista': 'Espelhos de ponto, fichas de EPI e laudos formam a defesa em ações de hora extra, insalubridade e acidente.',
    'ponto-eletronico': 'Escalas 6x2, 12x36 e revezamento, adicional noturno, DSR e interjornada pela regra de cada sindicato, com AFD e AEJ.',
    natponto: 'Marcação pelo celular para manutenção e campo, com rosto e local, e marcações do relógio da planta na mesma base.',
    'medicina-ocupacional': 'PCMSO montado a partir do GHE, ASO com alerta de vencimento e atestados por CID cruzados por linha e turno.',
    'seguranca-do-trabalho': 'PGR, GHE, EPIs com CA validado, checklists de NR-10, NR-12 e NR-35, CAT, LTCAT, PPP e CIPA no tablet, em campo.',
    'recrutamento-e-selecao': 'Operadores e técnicos selecionados com requisitos do cargo e banco de talentos por planta, com prazo por vaga.',
    'quadro-de-vagas': 'Vagas de produção e manutenção publicadas com a marca da indústria, com candidatura pelo celular.',
    'admissao-digital': 'Admissão sem papel que já cria o cadastro no SESMT, com exame admissional e EPI da função no primeiro dia.',
    onboarding: 'Regras de segurança da planta, vídeos de integração e treinamentos de entrada no celular antes do primeiro turno.',
    offboarding: 'Rescisão com saldo do banco de horas processado, documentos e bloqueio de acessos em uma tela, conferida pela NATI.',
    'avaliacoes-e-feedbacks': 'Feedback do supervisor registrado pelo celular no chão de fábrica e avaliação de operadores por competência técnica.',
    'metas-e-resultados': 'PLR por planta e turno negociada com o sindicato, com regras para admitidos, afastados e desligados no ciclo.',
    'treinamento-e-desenvolvimento': 'NR-10, NR-12, NR-33 e NR-35 com validade controlada, prova de aprendizagem e alerta antes de vencer.',
    'carreira-e-sucessao': 'Trilha de operador a líder de linha e sucessores prontos para supervisor de turno e gerente de planta.',
    portais: 'Portal do Gestor no celular do supervisor e Portal do Colaborador para espelho de ponto, holerite e EPI.',
    'requisicoes-com-workflow': 'Troca de turno, hora extra, abono, PPP, acidente de trabalho e terceiros com alçadas por planta e suplência.',
    'chamado-interno': 'Dúvidas de adicional, banco de horas e EPI de cada planta com fila, prazo e histórico no RH central.',
    'blog-corporativo': 'Comunicados de segurança, campanhas da CIPA e avisos de parada programada na timeline do portal.',
    'assinatura-eletronica': 'Ficha de EPI, espelho de ponto e termo de aceite de plantão assinados na tela, com validade jurídica.',
    ged: 'Documentos de admissão, fichas de EPI assinadas e contratos guardados por pessoa, sem arquivo físico na planta.',
    'people-analytics': 'Horas extras, absenteísmo e atestados cruzados por planta, turno e GHE com o botão Ações, sem depender de TI.',
    'business-intelligence': 'Painéis de absenteísmo, horas extras e headcount por unidade, com alerta por e-mail quando o indicador sai da faixa.',
    nati: 'Confere adicionais e horas extras antes do fechamento, aponta lacunas nas NRs e responde à equipe de turno pelo WhatsApp.',
    'conexao-com-outros-sistemas': 'Relógios de ponto, catracas e controle de acesso das plantas ligados ao ponto, e a folha contabilizada no ERP.',
    'infraestrutura-e-seguranca': 'Nuvem com contingência para todas as plantas, acesso por unidade e trilha de auditoria de cada alteração.',
  },
  spotlight: ['ponto-eletronico', 'seguranca-do-trabalho', 'medicina-ocupacional', 'folha-de-pagamento', 'treinamento-e-desenvolvimento', 'esocial'],
  compliance: [
    'NR-10, NR-12, NR-33 e NR-35 com checklists e treinamentos obrigatórios com validade',
    'PGR, GHE, PCMSO e LTCAT encadeados, com PPP para a aposentadoria especial',
    'eSocial: S-2210 em até 24 horas, S-2220 e S-2240',
    'NR-05 para a eleição da CIPA e NR-06 para EPIs com CA validado',
    'Acordos coletivos de metalúrgicos e químicos: banco de horas, adicionais e pisos',
    'Ponto eletrônico conforme a Portaria 671, com AFD e AEJ',
  ],
  personas: [
    { role: 'Supervisor de turno', text: 'Aprova troca de turno, hora extra e abono pelo celular no chão de fábrica e vê quem faltou antes de o turno começar.' },
    { role: 'Técnico de segurança', text: 'Roda checklist de NR no tablet, entrega EPI com assinatura digital e abre a CAT com o S-2210 saindo no prazo.' },
    { role: 'RH corporativo', text: 'Enxerga horas extras, absenteísmo e custo de cada planta e fecha a folha com os acordos de todos os sindicatos aplicados.' },
  ],
  faq: [
    {
      q: 'O sistema apura turnos de revezamento e adicional noturno de acordos diferentes?',
      a: 'Sim. O Ponto Eletrônico trata jornadas fixas e variáveis, escalas 12x36, plantões noturnos e rotativos, DSR, interjornada e adicional noturno, com regras de banco de horas por sindicato, centro de custo ou colaborador. O resultado vai para a folha sem digitação, no formato centesimal ou sexagesimal.',
    },
    {
      q: 'O LTCAT e o PPP para aposentadoria especial saem do sistema?',
      a: 'Sim. O risco mapeado no PGR alimenta o GHE, o LTCAT e o PPP. O LTCAT é mantido com as atividades que ensejam aposentadoria especial e o PPP eletrônico é gerado na hora a partir do histórico de exposição e do eSocial. O colaborador também pode pedir o PPP por requisição.',
    },
    {
      q: 'Como controlar EPIs e treinamentos de NR em várias plantas?',
      a: 'O SESMT controla estoque, entrega, substituição e devolução de EPIs, com o CA consultado na base do Governo Federal e ficha assinada digitalmente. Treinamentos de NR têm validade com alerta e entram nos checklists de auditoria. Tudo funciona no tablet, em campo, em qualquer unidade.',
    },
    {
      q: 'O relógio de ponto que já existe na fábrica continua valendo?',
      a: 'Sim. O Ponto Eletrônico recebe marcações de relógios de ponto, catracas e outros sistemas por integração, junto com as do NatPonto no celular. Tudo entra na mesma base para apuração, e o sistema gera AFD, AEJ e espelho de ponto assinado digitalmente.',
    },
  ],
  visual: 'operator',
  related: ['bens-de-consumo', 'recursos-naturais'],
}

export default page
