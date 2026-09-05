import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'people-analytics',
  name: 'People Analytics',
  group: 'dados-ia-plataforma',
  tagline: 'Cruze, filtre e desenhe o gráfico [[sem depender de TI]].',
  summary:
    'Qualquer listagem do sistema vira análise com o botão Ações: filtre, agrupe, monte a matriz, calcule, destaque e gere o gráfico. Salve o relatório, exporte para Excel ou PDF. Dados de todos os módulos, em tempo real.',
  seo: {
    title: 'People Analytics sem depender de TI | Natcorp',
    description:
      'People Analytics no sistema de RH: filtros, agrupamentos, pivô, cálculos, destaques e gráficos em tempo real, relatórios salvos e exportação para Excel e PDF.',
  },
  highlights: [
    { value: '1 botão', label: 'Ações: filtre, agrupe, cruze, destaque e gere o gráfico' },
    { value: '2 eixos', label: 'cruzados no pivô, com soma, contagem ou média' },
    { value: '3', label: 'formatos de exportação: CSV, Excel e PDF' },
  ],
  benefits: [
    {
      title: 'Resposta na hora, não na próxima semana',
      text: 'Quanto custa a folha por departamento? Quantas pessoas de cada cargo há em cada centro de custo? A resposta sai na tela, sem pedir relatório para a TI.',
    },
    {
      title: 'Dado de agora, não a foto de ontem',
      text: 'A análise roda sobre o dado vivo do sistema. Nada de planilha exportada que já nasce defasada e circula por e-mail.',
    },
    {
      title: 'Segurança preservada',
      text: 'A informação não sai do sistema para ser analisada. Perfis de acesso e segurança nativa continuam valendo dentro da análise.',
    },
    {
      title: 'Análise que vira patrimônio da empresa',
      text: 'Salve a visão como relatório público ou privado. O que um analista descobriu vira consulta recorrente para toda a equipe.',
    },
  ],
  features: [
    {
      title: 'Selecionar colunas e filtrar',
      text: 'Mostre só o que importa e segmente a base na hora, como isolar os colaboradores ativos de um centro de custo.',
      icon: 'filter',
    },
    {
      title: 'Quebra de controle',
      text: 'Separe a lista em blocos visuais por filial, cargo ou empresa. A visão por filial e o consolidado do grupo na mesma tela, pronta para a diretoria.',
      icon: 'layers',
    },
    {
      title: 'Agrupar e calcular',
      text: 'Some, conte ou tire a média por qualquer coluna. Exemplo: a folha total somando os salários por departamento.',
      icon: 'calculator',
    },
    {
      title: 'Pivô (matriz)',
      text: 'Cruze dois eixos e deixe o sistema contar. Quantas pessoas de cada cargo existem em cada centro de custo?',
      icon: 'table',
    },
    {
      title: 'Destacar desvios',
      text: 'Defina uma regra e o sistema colore células ou linhas inteiras. Alertas e exceções saltam aos olhos.',
      icon: 'alert-triangle',
    },
    {
      title: 'Gráficos em um clique',
      text: 'Transforme qualquer cruzamento em pizza, barras ou linhas e troque o tipo de gráfico conforme a história que quer contar.',
      icon: 'pie-chart',
    },
    {
      title: 'Salvar relatório público ou privado',
      text: 'Guarde a visão montada para consultas recorrentes. Compartilhe com a equipe ou mantenha só para você.',
      icon: 'clipboard',
    },
    {
      title: 'Exportar em CSV, Excel ou PDF',
      text: 'Leve o resultado para apresentações e reuniões sem redigitar nada.',
      icon: 'download',
    },
    {
      title: 'Cruzamento entre módulos',
      text: 'Folha, ponto, benefícios, cargos, avaliações e SESMT na mesma análise, de forma nativa. O dado entra uma vez e serve a todos.',
      icon: 'database',
    },
    {
      title: 'Leitura da NATI',
      text: 'A inteligência artificial analisa os indicadores e gráficos gerados e explica tendências, como turnover e absenteísmo, em linguagem natural.',
      icon: 'sparkles',
    },
  ],
  flow: {
    title: 'Do dado bruto ao relatório compartilhado',
    steps: [
      { title: 'Escolha a base', text: 'Qualquer listagem do sistema: colaboradores, folha, ponto, benefícios.' },
      { title: 'Estruture', text: 'Selecione colunas, filtre e classifique com o botão Ações.' },
      { title: 'Analise', text: 'Quebra de controle, agrupamento, pivô e cálculos nas interseções.' },
      { title: 'Visualize', text: 'Destaque os desvios e gere o gráfico de pizza, barras ou linhas.' },
      { title: 'Distribua', text: 'Salve como relatório público ou privado e exporte em CSV, Excel ou PDF.' },
    ],
  },
  personas: [
    {
      role: 'Analista de RH e DP',
      text: 'Monta a própria análise em minutos e responde à diretoria sem abrir chamado para a TI.',
    },
    {
      role: 'Gestor',
      text: 'Vê headcount, custo e ocorrências da equipe cruzados do jeito que precisa, em tempo real.',
    },
    {
      role: 'CHRO e diretoria',
      text: 'Recebe relatórios salvos e gráficos prontos, com a leitura da NATI sobre o que mudou e por quê.',
    },
  ],
  faq: [
    {
      q: 'Preciso da TI para montar um relatório?',
      a: 'Não. O botão Ações coloca filtros, agrupamentos, pivô, cálculos, destaques e gráficos nas mãos do usuário. Ele monta, salva e exporta a análise sozinho.',
    },
    {
      q: 'Os dados estão atualizados?',
      a: 'Sim. A análise roda sobre o dado do sistema em tempo real, sem exportar para planilha. O que você vê é o que está na base agora.',
    },
    {
      q: 'Consigo cruzar dados de módulos diferentes?',
      a: 'Sim. O cruzamento é nativo: folha, ponto, benefícios, cargos, avaliações e SESMT podem entrar na mesma análise, porque compartilham o mesmo cadastro. O resultado sai por filial e consolidado para o grupo.',
    },
    {
      q: 'Como compartilho uma análise?',
      a: 'Salve o relatório como público, para a equipe, ou privado, só para você. Também dá para exportar em CSV, Excel ou PDF para apresentações.',
    },
  ],
  related: ['business-intelligence', 'nati', 'administracao-de-pessoal', 'folha-de-pagamento'],
  sources: ['people-analytics-estrategico', 'business-intelligence-people-analytics', 'gestao-de-rh', 'abrangencia-do-sistema', 'csc-bpo'],
}

export default page
