import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'treinamento-e-desenvolvimento',
  name: 'Treinamento e Desenvolvimento',
  group: 'desenvolvimento',
  tagline: 'Treinamento que fecha o gap [[e prova que fechou]].',
  summary:
    'Turmas, orçamento, questionários e certificações com vencimento em um só lugar. A matriz de competências mostra o que falta em cada cargo, as trilhas organizam o caminho e os treinamentos de NRs ficam sob controle do SESMT.',
  seo: {
    title: 'Treinamento e Desenvolvimento | Natcorp',
    description:
      'Gestão de treinamentos para grandes empresas: turmas, orçamento, questionários, certificações com vencimento, treinamentos de NRs, trilhas e competências.',
  },
  highlights: [],
  benefits: [
    {
      title: 'Investimento onde a estratégia precisa',
      text: 'A matriz de competências mostra o gap de cada cargo e de cada equipe. O orçamento vai para o treinamento que muda o desempenho, não para o curso que ninguém pediu.',
    },
    {
      title: 'Nenhum treinamento obrigatório vencido',
      text: 'Certificações e treinamentos exigidos por NRs com validade controlada e alerta antes de vencer. Menos risco jurídico, mais segurança na operação.',
    },
    {
      title: 'Orçamento e custo por turma sob controle',
      text: 'Fornecedores, instrutores, viagens, materiais e infraestrutura registrados por turma. Custo, participação e retorno aparecem nos painéis.',
    },
    {
      title: 'Eficácia medida, não presumida',
      text: 'Pré e pós-teste, prova, pesquisa de reação e avaliação de desempenho depois do treinamento. Você sabe o que funcionou e o que repetir.',
    },
  ],
  features: [
    {
      title: 'Catálogo e turmas',
      text: 'Cursos, trilhas, workshops e eventos presenciais, online ou híbridos. Turmas com calendário, instrutor, local, vagas, carga horária e recursos.',
      icon: 'graduation-cap',
    },
    {
      title: 'Orçamento e custos',
      text: 'Planeje o orçamento do ano e registre os custos de fornecedores, instrutores, viagens, materiais e infraestrutura de cada turma.',
      icon: 'banknote',
    },
    {
      title: 'Inscrições com aprovação',
      text: 'Pedido do colaborador ou indicação do gestor via requisição, aprovação no workflow, matrícula automática ou manual, lista de espera e cancelamento.',
      icon: 'workflow',
    },
    {
      title: 'Questionários e provas',
      text: 'Pré e pós-testes, provas, exercícios e notas comprovam o que foi aprendido. Pesquisa de reação mede a satisfação com a turma.',
      icon: 'clipboard',
    },
    {
      title: 'Certificações com vencimento',
      text: 'Validade, renovação de requisitos e alerta automático de vencimento para o colaborador e para o gestor.',
      icon: 'award',
    },
    {
      title: 'Treinamentos obrigatórios e NRs',
      text: 'Controle das capacitações exigidas por lei, normas de segurança e compliance. A validade entra nos checklists de NRs do SESMT.',
      icon: 'hard-hat',
    },
    {
      title: 'Matriz de competências',
      text: 'Compara as competências exigidas pelo cargo com o perfil atual e mostra, na hora, o gap de cada pessoa e de cada equipe.',
      icon: 'layout-grid',
    },
    {
      title: 'Trilhas de aprendizagem',
      text: 'Jornadas por cargo, carreira, competência, área ou objetivo. Base para universidade corporativa, academias internas e programas de liderança.',
      icon: 'git-branch',
    },
    {
      title: 'Presença e eficácia',
      text: 'Frequência, carga horária e conclusão por turma. Avaliação de desempenho pós-treinamento, individual e por equipe.',
      icon: 'check-circle',
    },
    {
      title: 'Recomendações da NATI',
      text: 'A NATI cruza cargo, competências, desempenho e carreira para sugerir cursos e trilhas e apontar os treinamentos que cada posição exige.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Do gap ao resultado',
    steps: [
      { title: 'Competências do cargo', text: 'Cada cargo tem as competências exigidas cadastradas em Cargos e Salários.' },
      { title: 'Gap identificado', text: 'A avaliação de desempenho e a matriz de competências mostram o que falta.' },
      { title: 'PDI e inscrição', text: 'O PDI (plano de desenvolvimento individual) gera a indicação; a inscrição passa pelo workflow e vira matrícula.' },
      { title: 'Turma realizada', text: 'Presença, carga horária, prova e certificado registrados.' },
      { title: 'Eficácia medida', text: 'Pesquisa de reação, avaliação pós-treinamento e competências atualizadas no perfil.' },
    ],
  },
  compliance: [
    'Treinamentos exigidos por NRs (ex.: NR-10, NR-12, NR-35) com validade controlada',
    'LGPD: acesso por perfil, segregação de dados e trilha de auditoria',
  ],
  personas: [
    { role: 'RH e T&D', text: 'Monta o catálogo, abre turmas, controla orçamento e custos e prova a eficácia com dados, sem planilha paralela.' },
    { role: 'Gestor', text: 'Vê as necessidades da equipe, aprova matrículas, acompanha participação e o mapa de gaps do time no Portal do Gestor.' },
    { role: 'Colaborador', text: 'Consulta o catálogo, se inscreve, vê agenda, histórico, certificados e o próprio PDI no Portal do Colaborador.' },
  ],
  faq: [
    {
      q: 'Dá para controlar os treinamentos de NRs e o vencimento deles?',
      a: 'Sim. Treinamentos obrigatórios por legislação e normas de segurança têm validade controlada, alerta automático de vencimento e entram nos checklists de auditoria de NRs do módulo de Segurança do Trabalho. Questionários podem ser aplicados para comprovar o aprendizado.',
    },
    {
      q: 'Como o gestor pede um treinamento para a equipe?',
      a: 'Por requisição: de treinamento, de criação de curso ou de indicação para curso. O pedido passa pelo workflow de aprovação e, aprovado, vira matrícula na turma, com lista de espera quando não há vaga.',
    },
    {
      q: 'O módulo mede se o treinamento funcionou?',
      a: 'Sim, em três camadas: presença e conclusão da turma, avaliação de aprendizagem com pré e pós-teste ou prova, e avaliação de eficácia, com pesquisa de reação e desempenho depois do treinamento, individual e por equipe.',
    },
    {
      q: 'Consigo saber quanto custou cada turma?',
      a: 'Sim. Fornecedores, instrutores, viagens, materiais e infraestrutura são registrados por turma e comparados ao orçamento planejado. Os painéis mostram custo, participação, conclusão, horas e retorno do investimento.',
    },
  ],
  related: ['avaliacoes-e-feedbacks', 'carreira-e-sucessao', 'seguranca-do-trabalho', 'requisicoes-com-workflow'],
  sources: ['gestao-de-treinamentos', 'gestao-do-sesmt', 'gestao-de-rh', 'apresentacao-natcorp', 'automacao-de-processos'],
}

export default page
