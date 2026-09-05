import type { SegmentPage } from './types'

const page: SegmentPage = {
  slug: 'telecom',
  name: 'Telecom',
  tagline: 'O ponto que funciona [[onde não tem sinal]], do técnico em campo à central 24 horas.',
  summary:
    'Técnicos de instalação espalhados por dezenas de cidades, centrais de operação que não param e terceiros dentro da rede. A Natcorp registra o ponto sem sinal, apura sobreaviso e periculosidade, controla NR-10, NR-35 e EPIs e coloca a aprovação do gestor no celular, em todos os CNPJs.',
  seo: {
    title: 'Sistema de RH para telecom: campo, 24 horas e NRs | Natcorp',
    description:
      'RH para operadoras e provedores de telecom: ponto por geolocalização sem sinal, escalas 24 horas, sobreaviso, NR-10, NR-35, EPIs, terceiros e PLR.',
  },
  context: [
    'Em telecom, a operação de pessoas acontece no poste, na torre e na central. O técnico de instalação e manutenção roda várias cidades por dia, muitas vezes sem sinal, e marca o ponto onde está. A central de operações e o atendimento funcionam em escalas de 24 horas, com sobreaviso e horas extras que a convenção regula. Eletricidade e altura pedem NR-10, NR-35 e EPI em dia para cada pessoa que sobe.',
    'A rede cresce por aquisições e por contratos com prestadoras, e o RH acumula CNPJs, cidades, sindicatos e terceiros na mesma operação. Admissões e desligamentos chegam em volume, o atendimento gira rápido e o gestor de campo aprova tudo pelo celular, entre uma visita e outra. Sem uma base única, a hora extra vira passivo, o treinamento vence sem aviso e a folha fecha atrasada.',
  ],
  facts: [
    { value: 'Sem sinal', label: 'ponto do técnico em campo com rosto e local, sincronizado quando a rede volta' },
    { value: '24 horas', label: 'escalas de central de operações e atendimento, com sobreaviso e banco de horas' },
    { value: 'NR-10 e NR-35', label: 'treinamentos e EPIs com validade controlada para eletricidade e altura' },
  ],
  pains: [
    { icon: 'map-pin', title: 'Técnico em campo, sem sinal e sem relógio de ponto', text: 'O técnico começa o dia em uma cidade e termina em outra. Sem registro de onde e quando marcou, a jornada vira estimativa, e a hora extra aparece na reclamação trabalhista, não na folha.' },
    { icon: 'clock', title: 'Centrais 24 horas, sobreaviso e banco de horas', text: 'Operação e atendimento não param. Turnos rotativos, adicional noturno, sobreaviso e troca de plantão precisam de regra clara e apuração automática, ou o banco de horas vira passivo.' },
    { icon: 'hard-hat', title: 'Eletricidade, altura e periculosidade', text: 'Quem sobe no poste ou na torre precisa de NR-10, NR-35 e EPI válidos naquele dia. Treinamento vencido e ficha de EPI em papel não protegem a empresa quando o acidente acontece.' },
    { icon: 'users', title: 'Terceiros e subcontratadas dentro da operação', text: 'Prestadoras executam parte da rede com equipes próprias. O RH precisa registrar terceiros, guardar documentos, controlar EPIs e ter evidência de tudo se um deles acionar a empresa.' },
    { icon: 'building', title: 'Muitos CNPJs, convenções e gestores na rua', text: 'Cada aquisição traz um CNPJ e cada estado, uma convenção. O supervisor de campo aprova hora extra, abono e vaga entre uma visita e outra, e a decisão não pode esperar um computador.' },
    { icon: 'refresh', title: 'Volume de admissões, desligamentos e turnover', text: 'Atendimento e instalação giram rápido. Dezenas de admissões e rescisões por semana, em papel, atrasam a folha, o eSocial e o bloqueio de acessos de quem saiu.' },
  ],
  answers: [
    {
      pain: 'Campo sem sinal',
      title: 'NatPonto no celular do técnico, com rosto, local e hora, mesmo offline',
      text: 'O técnico marca o ponto no próprio celular, com reconhecimento facial e geolocalização. Sem sinal, a marcação fica guardada no aparelho e sincroniza sozinha quando a rede volta. Em segundos ela chega ao Ponto Eletrônico, que aplica a escala e envia horas extras e adicionais para a folha sem digitação.',
      modules: ['natponto', 'ponto-eletronico', 'folha-de-pagamento'],
    },
    {
      pain: 'Central 24 horas',
      title: 'Turnos rotativos, sobreaviso e banco de horas apurados sozinhos',
      text: 'O Ponto Eletrônico trata plantões diurnos, noturnos e rotativos, sobreaviso, adicional noturno, DSR e interjornada com os limites de cada sindicato. O colaborador aceita ou troca plantão pelo app com termo assinado, o gestor aprova o período no celular e o saldo do banco de horas fica visível em tempo real.',
      modules: ['ponto-eletronico', 'portais', 'requisicoes-com-workflow', 'assinatura-eletronica'],
    },
    {
      pain: 'NR-10 e NR-35',
      title: 'Treinamento válido, EPI com CA e CAT no prazo',
      text: 'Treinamentos de NR-10 e NR-35 têm validade controlada e alerta antes de vencer, e a validade entra nos checklists do SESMT. EPIs de altura e eletricidade têm CA validado e ficha assinada pelo celular em campo. O PGR alimenta o LTCAT e o PPP, a CAT dispara o S-2210 em até 24 horas e a periculosidade fica na ficha do cargo.',
      modules: ['treinamento-e-desenvolvimento', 'seguranca-do-trabalho', 'medicina-ocupacional', 'esocial', 'cargos-e-salarios'],
    },
    {
      pain: 'Terceiros',
      title: 'Prestadoras e autônomos registrados na mesma base',
      text: 'Serviços de terceiros e autônomos entram por requisição eletrônica, com alçadas e registro de quem cadastrou e alterou cada dado. EPIs entregues a quem trabalha na rede ficam com ficha assinada, e se um terceiro aciona a empresa, o Jurídico Trabalhista cadastra o reclamante sem vínculo com o código que o eSocial exige.',
      modules: ['requisicoes-com-workflow', 'administracao-de-pessoal', 'seguranca-do-trabalho', 'juridico-trabalhista'],
    },
    {
      pain: 'CNPJs e gestores',
      title: 'Uma folha para todos os CNPJs e o Portal do Gestor no celular',
      text: 'A folha trata múltiplos vínculos e sindicatos, sem limite de CNPJs, com a regra de cada convenção aplicada a cada pessoa. O supervisor aprova hora extra, abono, férias e vaga pelo celular, com alçadas por centro de custo e suplente automático, e a NATI responde à equipe no WhatsApp fora do horário do RH.',
      modules: ['folha-de-pagamento', 'portais', 'requisicoes-com-workflow', 'nati'],
    },
    {
      pain: 'Volume e turnover',
      title: 'Admissão e desligamento sem papel, em qualquer cidade',
      text: 'O aprovado faz a admissão pelo celular, com documentos e contrato assinado, e nasce na folha, no ponto e no SESMT. O desligamento passa pelo workflow e chega a uma tela com rescisão, banco de horas remanescente e bloqueio de acessos. O eSocial recebe tudo validado, e o People Analytics mostra onde o turnover se concentra.',
      modules: ['admissao-digital', 'offboarding', 'esocial', 'people-analytics'],
    },
  ],
  moduleNotes: {
    'folha-de-pagamento': 'Vários CNPJs, sindicatos e convenções por estado na mesma folha, com sobreaviso, periculosidade e adicional noturno já apurados.',
    'administracao-de-pessoal': 'Posições e orçamento por cidade, base operacional e centro de custo, com alerta quando o custo de campo sai do orçado.',
    'cargos-e-salarios': 'Periculosidade parametrizada na ficha do cargo de técnico e faixas por região para reter instalador e operador de central.',
    'gestao-de-beneficios': 'Vale-transporte por trajeto e cidade, seguro de vida com sinistros acompanhados e plano de saúde com fatura conferida.',
    natpay: 'Adiantamento pelo WhatsApp com limite pelos dias trabalhados no ponto, um motivo a mais para o atendente ficar.',
    esocial: 'Admissões e desligamentos em volume, S-2210 em até 24 horas após a CAT e S-2240 gerado do PGR de campo.',
    'juridico-trabalhista': 'Hora extra e periculosidade defendidas com jornada e fichas de EPI da própria base, e reclamante terceiro no vínculo exigido.',
    'ponto-eletronico': 'Turnos rotativos de central, sobreaviso, adicional noturno e banco de horas pelos limites de cada sindicato.',
    natponto: 'Ponto no celular do técnico com reconhecimento facial e geolocalização, guardado sem sinal e sincronizado depois.',
    'medicina-ocupacional': 'PCMSO ligado ao risco de altura e eletricidade, ASO com alerta de vencimento e atestados enviados pelo app em campo.',
    'seguranca-do-trabalho': 'EPIs de altura e eletricidade com CA validado e ficha assinada no celular, checklists de NR-10 e NR-35 e CAT em poucos passos.',
    'recrutamento-e-selecao': 'Processos seletivos por cidade abertos pela requisição do supervisor, com banco de talentos e SLA por vaga.',
    'quadro-de-vagas': 'Vagas de técnico e atendente em dezenas de cidades publicadas com a marca da operadora, candidatura pelo celular.',
    'admissao-digital': 'Admissão pelo celular em qualquer cidade, com documentos, contrato assinado e cadastro nascendo na folha, no ponto e no SESMT.',
    onboarding: 'Orientações de segurança, uso de EPI e conduta em campo no portal do novo técnico desde o primeiro dia.',
    offboarding: 'Rescisão com banco de horas remanescente e bloqueio de acessos registrado no mesmo fluxo, em qualquer CNPJ.',
    'avaliacoes-e-feedbacks': 'Feedback do supervisor registrado pelo celular depois da visita e pesquisa de clima na central de atendimento.',
    'metas-e-resultados': 'PLR por metas de instalação, disponibilidade de rede e atendimento, com regras para admitidos e desligados no ciclo.',
    'treinamento-e-desenvolvimento': 'NR-10 e NR-35 com validade controlada, alerta antes de vencer e presença registrada por turma.',
    'carreira-e-sucessao': 'Trilha de técnico a supervisor de campo e de atendente a líder de central, com sucessores mapeados.',
    portais: 'Portal do Gestor no celular do supervisor para aprovar hora extra, abono e vaga entre uma visita e outra.',
    'requisicoes-com-workflow': 'Hora extra, abono, troca de plantão, terceiros e vaga com alçadas por centro de custo e suplente automático.',
    'chamado-interno': 'Dúvidas do técnico e do atendente em fila com SLA, abertas pelo celular e triadas pela NATI.',
    'blog-corporativo': 'Alertas de segurança, campanhas de prevenção e comunicados da operação na timeline de quem não abre e-mail.',
    'assinatura-eletronica': 'Termo de aceite de plantão, ficha de EPI e espelho de ponto assinados pelo celular, com validade jurídica.',
    ged: 'Documentos de técnicos e atendentes por pessoa, com acesso por perfil e por filial, sem pasta na base operacional.',
    'people-analytics': 'Horas extras, sobreaviso e turnover por cidade, filial e centro de custo cruzados na hora, sem depender de TI.',
    'business-intelligence': 'Painéis de absenteísmo, horas extras e escalas por filial e departamento, com alerta por e-mail ao sair da faixa.',
    nati: 'Responde ao técnico no WhatsApp fora do horário do RH e aponta horas extras indevidas e lacunas de NR antes do fechamento.',
    'conexao-com-outros-sistemas': 'Relógios de ponto e catracas das centrais no Ponto Eletrônico, ERP e avisos automáticos de admissões e desligamentos.',
    'infraestrutura-e-seguranca': 'Nuvem com contingência para uma operação que não para, acesso por perfil e por filial em cada CNPJ.',
  },
  spotlight: ['natponto', 'ponto-eletronico', 'seguranca-do-trabalho', 'treinamento-e-desenvolvimento', 'portais', 'folha-de-pagamento'],
  compliance: [
    'NR-10 para eletricidade e NR-35 para trabalho em altura, com treinamentos válidos',
    'NR-06: EPIs com CA validado e ficha de entrega assinada',
    'Adicional de periculosidade para trabalho com eletricidade, conforme o laudo',
    'Ponto eletrônico conforme a Portaria 671, com AFD e AEJ para técnicos e centrais',
    'eSocial: S-2210 em até 24 horas após a CAT e S-2240 para agentes nocivos',
    'Convenções coletivas de telecomunicações por estado e categoria',
  ],
  personas: [
    { role: 'Supervisor de campo', text: 'Aprova hora extra, abono e troca de plantão pelo celular entre uma visita e outra, e recebe alerta de NR-35 vencendo antes de escalar.' },
    { role: 'Técnico de instalação', text: 'Marca o ponto no celular onde estiver, mesmo sem sinal, assina a ficha de EPI na tela e pergunta à NATI sobre o holerite no WhatsApp.' },
    { role: 'RH da operadora', text: 'Fecha a folha de todos os CNPJs com o ponto já apurado e enxerga horas extras, turnover e treinamentos vencidos por cidade.' },
  ],
  faq: [
    {
      q: 'O ponto funciona para técnicos que passam o dia sem sinal?',
      a: 'Sim. O NatPonto guarda as marcações no aparelho quando não há conexão e sincroniza sozinho quando a internet volta, com reconhecimento facial e geolocalização em cada registro. Nenhuma marcação se perde, e o RH não precisa corrigir nada depois.',
    },
    {
      q: 'Como o sistema trata escalas 24 horas, sobreaviso e banco de horas?',
      a: 'O Ponto Eletrônico configura plantões diurnos, noturnos e rotativos, sobreaviso, adicional noturno, DSR e interjornada com os limites legais e de cada sindicato. O banco de horas é apurado automaticamente, com saldo em tempo real, e o resultado vai para a folha sem digitação.',
    },
    {
      q: 'Dá para controlar o vencimento de NR-10, NR-35 e EPIs?',
      a: 'Sim. Treinamentos obrigatórios têm validade controlada e alerta automático para o colaborador e o gestor, e entram nos checklists de NR do SESMT. EPIs têm CA validado na base do Governo Federal, alerta de validade e ficha de entrega assinada pelo celular.',
    },
    {
      q: 'A folha atende vários CNPJs e sindicatos ao mesmo tempo?',
      a: 'Sim. A folha trata múltiplos vínculos e acordos sindicais na mesma empresa, sem limite de CNPJs, cada um com suas regras. O ponto de cada unidade já chega apurado, e o eSocial recebe admissões e desligamentos validados.',
    },
  ],
  visual: 'natponto',
  related: ['recursos-naturais', 'servicos-ao-consumidor'],
}

export default page
