/**
 * Como o sistema se encaixa na estrutura de cada organização: empresa única com várias unidades,
 * holding com RH centralizado e grupo com RH em cada filial. Usado na home, em /grupos, nos segmentos,
 * na jornada e em /portais. As capacidades citadas vêm do material oficial (comparativo, portais, segurança).
 */

import type { FaqItem } from './faq'
import { modulePath } from './modulePages'
import { paths } from './site'

export type StructureKey = 'unica' | 'central' | 'filiais'

export interface StructureLink {
  label: string
  to: string
}

export interface StructureCard {
  key: StructureKey
  eyebrow: string
  title: string
  text: string
  bullets: string[]
  links: StructureLink[]
}

export const structureCards: StructureCard[] = [
  {
    key: 'unica',
    eyebrow: 'Empresa única, várias unidades',
    title: 'Uma base, perfis por unidade e centro de custo.',
    text: 'Cada gestor aprova pelo celular o que é da equipe dele. O RH enxerga tudo, por unidade ou no total, e o ponto tem um raio por unidade.',
    bullets: ['Perfis de acesso por unidade e centro de custo', 'Alçadas de aprovação por área', 'Um raio de marcação por unidade no NatPonto'],
    links: [
      { label: 'Portais e perfis', to: paths.portals },
      { label: 'NatPonto', to: modulePath('natponto') },
    ],
  },
  {
    key: 'central',
    eyebrow: 'Holding com RH central',
    title: 'Vários CNPJs na mesma folha. Um time cuidando de todos.',
    text: 'Empresas, CNPJs e sindicatos ilimitados no mesmo cadastro. Headcount e orçamento consolidados por empresa e filial, folha calculada por empresa e conferida pela NATI, admissões e desligamentos em volume, e uma fila única de requisições e chamados para o time central.',
    bullets: ['CNPJs e sindicatos sem limite nem custo extra', 'Folha por empresa, consolidado para a matriz', 'Autoatendimento e NATI absorvendo a rotina de milhares de pessoas'],
    links: [
      { label: 'Folha de Pagamento', to: modulePath('folha-de-pagamento') },
      { label: 'Business Intelligence', to: modulePath('business-intelligence') },
      { label: 'Requisições com Workflow', to: modulePath('requisicoes-com-workflow') },
    ],
  },
  {
    key: 'filiais',
    eyebrow: 'Grupo com RH em cada filial',
    title: 'Cada equipe vê só a sua filial. A matriz fecha a folha.',
    text: 'O RH de cada unidade admite, trata o ponto, lança movimentações e benefícios dentro do seu perfil e das suas alçadas. Tudo cai na mesma base: a matriz acompanha as pendências por filial, confere e fecha a folha por empresa, com a contabilização de cada CNPJ para o ERP.',
    bullets: ['Perfis e alçadas por filial, políticas padronizadas pela matriz', 'Pendências e conferência por unidade antes do fechamento', 'Relatórios por filial e consolidado no BI e no People Analytics'],
    links: [
      { label: 'Portais', to: paths.portals },
      { label: 'Ponto Eletrônico', to: modulePath('ponto-eletronico') },
      { label: 'People Analytics', to: modulePath('people-analytics') },
    ],
  },
]

/** O que muda no sistema para um grupo (página /grupos). */
export interface GroupCapability {
  title: string
  text: string
  slug: string
}

export const groupCapabilities: GroupCapability[] = [
  { title: 'Empresas, CNPJs e sindicatos ilimitados', text: 'Todas as empresas do grupo no mesmo cadastro, cada uma com as suas convenções, sem cobrança adicional por CNPJ.', slug: 'folha-de-pagamento' },
  { title: 'Perfis por empresa, filial e centro de custo', text: 'Cada pessoa vê e opera só o que o perfil permite. Trilha de auditoria de quem viu e alterou cada dado.', slug: 'infraestrutura-e-seguranca' },
  { title: 'Alçadas por unidade', text: 'Requisições de vaga, pessoal, férias, movimentação e desligamento com aprovadores definidos por filial e por área.', slug: 'requisicoes-com-workflow' },
  { title: 'Headcount e orçamento consolidados', text: 'Posições, previsto e realizado por empresa, filial e centro de custo, com a visão do grupo para a matriz.', slug: 'administracao-de-pessoal' },
  { title: 'Fechamento por empresa, pendências por filial', text: 'Ponto, benefícios e movimentações chegam à folha já apurados. A matriz confere por unidade e roda a folha de cada empresa em minutos.', slug: 'ponto-eletronico' },
  { title: 'eSocial e contabilização por CNPJ', text: 'Eventos enviados e acompanhados por empresa, e a contabilização de cada CNPJ pronta para o ERP.', slug: 'esocial' },
  { title: 'Admissões e desligamentos em volume', text: 'Convites de admissão pelo portal, documentos no GED, assinatura pelo NatDocs e efetivação em série, com as pendências acompanhadas por unidade.', slug: 'admissao-digital' },
  { title: 'Indicadores por filial e do grupo', text: 'Turnover, absenteísmo, custo e horas extras por empresa e unidade, e o consolidado para a diretoria.', slug: 'business-intelligence' },
]

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
    q: 'O sistema aguenta centenas de admissões e desligamentos por mês?',
    a: 'Sim. A admissão é digital de ponta a ponta: o candidato preenche e anexa, o RH confere no GED, o contrato é assinado pelo NatDocs e a efetivação atualiza folha, ponto, benefícios, eSocial e portais de uma vez. O desligamento segue o mesmo fluxo pelo Offboarding. As pendências ficam em fila por unidade.',
  },
  {
    q: 'Como é a implantação para um grupo com várias empresas e filiais?',
    a: 'Planejamento por empresa e filial, migração do histórico sem limite de anos, validação em homologação com a folha atual em paralelo e treinamento das equipes da matriz e das filiais antes da entrada em produção. Depois, suporte por chamados com prazo e histórico.',
  },
]
