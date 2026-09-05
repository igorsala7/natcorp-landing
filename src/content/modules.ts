import type { LucideIcon } from 'lucide-react'
import {
  BarChart3,
  Clock,
  HeartPulse,
  LayoutGrid,
  TrendingUp,
  UserPlus,
  Wallet,
} from 'lucide-react'

export interface ModuleItem {
  name: string
  desc: string
  /** Página de módulo (src/content/modulePages/registry.json). */
  slug: string
  /** Seção da página (ex.: '#funcionalidades') quando o item é um recurso dentro de um módulo. */
  hash?: string
}

export interface ModuleGroup {
  id: string
  name: string
  tagline: string
  description: string
  icon: LucideIcon
  modules: ModuleItem[]
}

/**
 * Agrupamento oficial dos módulos (Manual de Identidade, seção 02 — "Um símbolo, mais de 30 módulos").
 * Sempre com estes nomes e nesta ordem.
 */
export const moduleGroups: ModuleGroup[] = [
  {
    id: 'pessoal-e-folha',
    name: 'Pessoal e Folha',
    tagline: 'A folha fecha com o ponto, o eSocial e o orçamento no mesmo lugar.',
    description:
      'Do cálculo da folha ao envio do eSocial, com headcount, cargos, benefícios e jurídico trabalhista na mesma base de dados.',
    icon: Wallet,
    modules: [
      { name: 'Folha de Pagamento', slug: 'folha-de-pagamento', desc: 'Cálculo, encargos e fechamento com a apuração do ponto já dentro da folha.' },
      { name: 'Administração de Pessoal', slug: 'administracao-de-pessoal', desc: 'Headcount, planejamento de pessoal e orçamento previsto × realizado.' },
      { name: 'Cargos e Salários', slug: 'cargos-e-salarios', desc: 'Estrutura de cargos, faixas salariais e equidade remuneratória.' },
      { name: 'Gestão de Benefícios', slug: 'gestao-de-beneficios', desc: 'Gestão total e pedido de compra de benefícios por integração com as operadoras.' },
      { name: 'NatPay', slug: 'natpay', desc: 'Adiantamento salarial pedido pelo WhatsApp, pago via Pix e descontado automaticamente na folha.' },
      { name: 'eSocial', slug: 'esocial', desc: 'Envio, acompanhamento e retorno de cada layout, sem sair do sistema.' },
      { name: 'Jurídico Trabalhista', slug: 'juridico-trabalhista', desc: 'Acompanhamento e gestão de processos trabalhistas, já integrado ao eSocial.' },
    ],
  },
  {
    id: 'ponto-e-jornada',
    name: 'Ponto e Jornada',
    tagline: 'Marcação no celular, apuração automática e horas certas na folha.',
    description:
      'Controle completo de frequência para jornadas fixas, flexíveis e variáveis, com o app NatPonto e workflow de abono.',
    icon: Clock,
    modules: [
      { name: 'Ponto Eletrônico', slug: 'ponto-eletronico', desc: 'Controle completo de frequência, com apuração de eventos direto para a folha.' },
      { name: 'NatPonto', slug: 'natponto', desc: 'App de marcação de ponto com geolocalização e reconhecimento facial.' },
      { name: 'Escalas e Jornadas', slug: 'ponto-eletronico', hash: '#funcionalidades', desc: 'Jornadas fixas, flexíveis e variáveis, com gestão de escalas por equipe.' },
      { name: 'Banco de Horas', slug: 'ponto-eletronico', hash: '#funcionalidades', desc: 'Pagamento e compensação de horas com as regras de cada convenção.' },
      { name: 'Abono com Workflow', slug: 'ponto-eletronico', hash: '#funcionalidades', desc: 'Requisições de abono com anexo de comprovante, justificativa e aprovação do gestor.' },
      { name: 'Marcações de outros sistemas', slug: 'ponto-eletronico', hash: '#funcionalidades', desc: 'Recebe marcações de relógios de ponto e outras fontes automaticamente.' },
    ],
  },
  {
    id: 'saude-e-seguranca',
    name: 'Saúde e Segurança',
    tagline: 'SESMT dentro do sistema de RH: exames, riscos, documentos e prazos.',
    description:
      'Medicina e Segurança do Trabalho operando na mesma base do RH: ASO, PCMSO, PGR, PPP, EPIs, afastamentos e acidentes.',
    icon: HeartPulse,
    modules: [
      { name: 'Medicina Ocupacional', slug: 'medicina-ocupacional', desc: 'Médicos, clínicas, exames e afastamentos. Emissão de ASO e PCMSO.' },
      { name: 'Segurança do Trabalho', slug: 'seguranca-do-trabalho', desc: 'Análise de riscos, EPIs e EPCs, com emissão de PGR e PPP.' },
      { name: 'Afastamentos e Acidentes', slug: 'medicina-ocupacional', hash: '#funcionalidades', desc: 'Registro, acompanhamento e comunicação de acidentes de trabalho.' },
      { name: 'Treinamentos de NRs', slug: 'treinamento-e-desenvolvimento', hash: '#funcionalidades', desc: 'Turmas, questionários e certificados para atender às Normas Regulamentadoras.' },
    ],
  },
  {
    id: 'talentos',
    name: 'Talentos',
    tagline: 'Da requisição da vaga à admissão sem papel, em um fluxo só.',
    description:
      'Recrutamento, quadro de vagas com a sua marca, admissão digital, onboarding e offboarding conectados por workflow.',
    icon: UserPlus,
    modules: [
      { name: 'Recrutamento e Seleção', slug: 'recrutamento-e-selecao', desc: 'Processos seletivos, banco de talentos, recrutadores e SLAs por vaga.' },
      { name: 'Quadro de Vagas', slug: 'quadro-de-vagas', desc: 'Job board com a marca da sua empresa para candidatos externos e internos.' },
      { name: 'Admissão Digital', slug: 'admissao-digital', desc: 'O candidato preenche, o RH valida e admite em poucos cliques. Sem papel.' },
      { name: 'Onboarding', slug: 'onboarding', desc: 'Vídeos, textos e arquivos que acolhem quem chega ou muda de cargo.' },
      { name: 'Offboarding', slug: 'offboarding', desc: 'Fluxo de desligamento ligado à requisição e ao workflow de aprovação.' },
    ],
  },
  {
    id: 'desenvolvimento',
    name: 'Desenvolvimento',
    tagline: 'Avaliar, treinar, reconhecer e preparar sucessores com dados.',
    description:
      'Ciclos de avaliação e feedback, metas com bônus e PLR, treinamento com orçamento e planos de carreira e sucessão.',
    icon: TrendingUp,
    modules: [
      { name: 'Avaliações, Pesquisas e Feedbacks', slug: 'avaliacoes-e-feedbacks', desc: 'O RH personaliza perguntas e respostas para gestores e colaboradores.' },
      { name: 'Metas e Resultados', slug: 'metas-e-resultados', desc: 'Acompanhamento de metas, bônus e PLR com transparência e controle.' },
      { name: 'Treinamento e Desenvolvimento', slug: 'treinamento-e-desenvolvimento', desc: 'Turmas, orçamento, custos e questionários de treinamento.' },
      { name: 'Carreira e Sucessão', slug: 'carreira-e-sucessao', desc: 'Planejamento de carreira e mapa de sucessão para posições-chave.' },
    ],
  },
  {
    id: 'autoatendimento',
    name: 'Autoatendimento',
    tagline: 'Gestor e colaborador resolvem sozinhos. O RH aprova, o sistema efetiva.',
    description:
      'Portais por perfil, requisições com workflow, chamados, intranet, assinatura eletrônica e documentos digitais.',
    icon: LayoutGrid,
    modules: [
      { name: 'Portais', slug: 'portais', desc: 'Portais do Gestor, do Colaborador e do Candidato, cada um com o seu contexto e acesso.' },
      { name: 'Requisições com Workflow', slug: 'requisicoes-com-workflow', desc: 'Vaga, pessoal, férias, desligamento, promoção, reembolso, atestado: aprovou, efetivou.' },
      { name: 'Chamado Interno', slug: 'chamado-interno', desc: 'Central de atendimento do RH e de outros departamentos, com histórico.' },
      { name: 'Blog Corporativo', slug: 'blog-corporativo', desc: 'Intranet em formato de timeline para avisos, vídeos, imagens e comunicados.' },
      { name: 'Assinatura Eletrônica', slug: 'assinatura-eletronica', desc: 'Contratos, termos aditivos, espelho de ponto e aviso de férias assinados digitalmente.' },
      { name: 'GED', slug: 'ged', desc: 'Documentos de colaboradores, candidatos e dependentes digitalizados e organizados.' },
    ],
  },
  {
    id: 'dados-ia-plataforma',
    name: 'Dados, IA e Plataforma',
    tagline: 'Dado para decidir, IA que trabalha dentro do sistema e nuvem segura.',
    description:
      'People Analytics, BI, a NATI, conexão com outros sistemas e infraestrutura em nuvem com contingência.',
    icon: BarChart3,
    modules: [
      { name: 'People Analytics', slug: 'people-analytics', desc: 'Gráficos, cruzamentos de dados e exportação para Excel a partir de todos os módulos.' },
      { name: 'Business Intelligence', slug: 'business-intelligence', desc: 'Painéis e indicadores para decisões de RH baseadas em dados.' },
      { name: 'NATI', slug: 'nati', desc: 'Agente de IA para autoatendimento, dúvidas e informações de colaboradores, gestores e RH.' },
      { name: 'Conexão com outros sistemas', slug: 'conexao-com-outros-sistemas', desc: 'O próprio usuário disponibiliza tabelas para enviar e receber dados de outros sistemas.' },
      { name: 'Nuvem segura', slug: 'infraestrutura-e-seguranca', desc: 'Infraestrutura Oracle Cloud com ambientes de produção, homologação e contingência.' },
      { name: 'Multiplataforma', slug: 'infraestrutura-e-seguranca', hash: '#multiplataforma', desc: 'Responsivo: no celular, no tablet e no computador.' },
    ],
  },
]

export const allModuleNames = moduleGroups.flatMap((g) => g.modules.map((m) => m.name))
