import type { IconName } from '../modulePages/icons'

/** Mockup em HTML/CSS que ilustra a página do segmento. */
export type SegmentVisual = 'natponto' | 'operator' | 'medicine' | 'financial' | 'devices' | 'whatsapp' | 'recruitment'

export interface SegmentFact {
  /** Marca do segmento, qualitativa ou normativa (ex.: "12x36", "NR-32", "Loja a loja"). Máx. 22 caracteres. */
  value: string
  /** O que isso significa para o RH. Máx. 80 caracteres. */
  label: string
}

export interface SegmentPain {
  icon: IconName
  title: string
  text: string
}

export interface SegmentAnswer {
  /** Rótulo curto da dor respondida. */
  pain: string
  title: string
  text: string
  /** Slugs de módulos (registry.json) que resolvem a dor. */
  modules: string[]
}

export interface SegmentPersona {
  role: string
  text: string
}

export interface SegmentFaq {
  q: string
  a: string
}

export interface SegmentPage {
  slug: string
  name: string
  /**
   * Complemento do CTA final, em minúsculas: "Veja a Natcorp com a realidade da sua operação {ctaContext}."
   * Ex.: "de varejo", "industrial", "no setor público e social". Sem ele, usa "de {name}".
   */
  ctaContext?: string
  /** Mostra o cartão que leva à jornada do colaborador (contada numa indústria de alimentos). */
  journey?: boolean
  /** Frase de abertura; um trecho pode ser [[destacado]]. */
  tagline: string
  summary: string
  seo: { title: string; description: string }
  /** Como é o RH nesse segmento (dois parágrafos). */
  context: string[]
  /** Três marcas do segmento. */
  facts: SegmentFact[]
  /** As maiores dores e dificuldades de RH do segmento. */
  pains: SegmentPain[]
  /** Como o sistema responde a cada dor, com os módulos envolvidos. */
  answers: SegmentAnswer[]
  /** Uma frase por módulo: como cada um se aplica ao segmento (todos os slugs do registro). */
  moduleNotes: Record<string, string>
  /** Módulos que mais pesam no segmento (4 a 6 slugs). */
  spotlight: string[]
  /** Normas, leis e obrigações típicas do segmento. */
  compliance: string[]
  personas: SegmentPersona[]
  faq: SegmentFaq[]
  visual: SegmentVisual
  /** Outros segmentos parecidos (slugs). */
  related: string[]
}
