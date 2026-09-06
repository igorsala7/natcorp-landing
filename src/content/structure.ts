/**
 * Perguntas que grupos com várias empresas e filiais fazem antes de qualquer outra.
 * Usadas em /perguntas-frequentes. As respostas vêm do material oficial (comparativo, portais, segurança).
 * O restante do conteúdo sobre estruturas vive em `content/structures/` (página "Como é a sua estrutura?").
 */

import type { FaqItem } from './faq'

/** Perguntas que grupos fazem antes de qualquer outra. */
export const structureFaqs: FaqItem[] = [
  {
    q: 'Quantas empresas e CNPJs cabem em uma base?',
    a: 'Quantas o grupo tiver. Empresas, CNPJs e sindicatos são ilimitados no mesmo cadastro, sem cobrança adicional. Cada empresa mantém as suas convenções, o seu calendário de fechamento e a sua contabilização; a matriz vê tudo consolidado.',
  },
  {
    q: 'O RH de cada filial vê só a sua filial?',
    a: 'Sim. Os perfis de acesso seguem a estrutura da organização: empresa, filial e centro de custo. A equipe da filial admite, trata o ponto e lança movimentações dentro do seu perfil e das suas alçadas. A matriz enxerga o consolidado e as pendências de cada unidade.',
  },
  {
    q: 'Como a matriz fecha a folha de várias filiais sem redigitar?',
    a: 'Ponto, benefícios e movimentações lançados pelas filiais já chegam apurados à folha, na mesma base. A matriz acompanha o que ainda está pendente por unidade, confere com a NATI e roda a folha por empresa, a 2.500 colaboradores por minuto. A contabilização de cada CNPJ e os eventos do eSocial saem por empresa.',
  },
  {
    q: 'Como é a implantação para um grupo com várias empresas e filiais?',
    a: 'Planejamento por empresa e filial, migração do histórico sem limite de anos, validação em homologação com a folha atual em paralelo e treinamento das equipes da matriz e das filiais antes da entrada em produção. Depois, suporte por chamados com prazo e histórico.',
  },
]
