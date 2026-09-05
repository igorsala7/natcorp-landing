import type { IconName } from './icons'

export type GroupId =
  | 'pessoal-e-folha'
  | 'ponto-e-jornada'
  | 'saude-e-seguranca'
  | 'talentos'
  | 'desenvolvimento'
  | 'autoatendimento'
  | 'dados-ia-plataforma'

export interface ModuleHighlight {
  /** Número ou dado curto (ex.: "2.500", "4 : 1.000", "24 h"). Máx. 10 caracteres. */
  value: string
  /** O que o número significa. Máx. 60 caracteres. */
  label: string
}

export interface ModuleBenefit {
  title: string
  text: string
}

export interface ModuleFeature {
  title: string
  text: string
  icon: IconName
}

export interface ModuleFlowStep {
  title: string
  text: string
}

export interface ModulePersona {
  role: string
  text: string
}

export interface ModuleFaq {
  q: string
  a: string
}

/** Conteúdo completo de uma página de módulo. Uma entrada por arquivo em src/content/modulePages/<slug>.ts */
export interface ModulePage {
  slug: string
  name: string
  group: GroupId
  /** Título do hero. Até 80 caracteres; pode ter um trecho [[destacado]]. */
  tagline: string
  /** Parágrafo sob o título. Até 260 caracteres. */
  summary: string
  seo: {
    /** Até 60 caracteres, termina com " | Natcorp". */
    title: string
    /** 140 a 160 caracteres. */
    description: string
  }
  /** 0 a 4 dados de prova. Só números que existem nas apresentações. */
  highlights: ModuleHighlight[]
  /** 3 a 4 resultados para quem decide (CHRO, CFO, CEO, CTO). */
  benefits: ModuleBenefit[]
  /** 6 a 10 funcionalidades concretas. */
  features: ModuleFeature[]
  /** Como funciona: 3 a 6 passos em sequência real. */
  flow?: {
    title: string
    steps: ModuleFlowStep[]
  }
  /** Itens legais e normativos: layouts do eSocial, NRs, portarias, LGPD, ICP-Brasil. 0 a 8 itens curtos. */
  compliance?: string[]
  /** Para quem: 2 a 3 perfis (Gestor, Colaborador, RH, Financeiro...). */
  personas?: ModulePersona[]
  /** 3 a 4 perguntas. */
  faq: ModuleFaq[]
  /** 2 a 4 slugs de módulos relacionados (existentes no registry.json). */
  related: string[]
  /** Slugs das apresentações usadas como fonte (rastreabilidade). */
  sources: string[]
}
