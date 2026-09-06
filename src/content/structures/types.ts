import type { IconName } from '../modulePages/icons'

/** As cinco estruturas de operação de RH que o site descreve. */
export type StructureSlug = 'empresa-unica' | 'varias-unidades' | 'grupo-rh-central' | 'rh-por-unidade' | 'equipes-em-clientes'

/** Quem executa cada parte da rotina de RH em uma estrutura. */
export type Operator = 'gestores' | 'rh-unidade' | 'rh-central' | 'nati'

export interface StructureFact {
  /** Marca da estrutura, curta (ex.: "1 CNPJ", "CSC", "N filiais"). Máx. 22 caracteres. */
  value: string
  /** O que isso significa para o RH. Máx. 80 caracteres. */
  label: string
}

export interface StructurePain {
  icon: IconName
  title: string
  text: string
}

export interface StructureAnswer {
  /** Rótulo curto da dor respondida. */
  pain: string
  title: string
  text: string
  /** Slugs de módulos (registry.json) que resolvem a dor. */
  modules: string[]
}

/** Uma linha do mapa "quem faz o quê": a tarefa, quem executa e onde. */
export interface Responsibility {
  /** Ex.: "Admissão", "Tratamento do ponto", "Fechamento da folha". */
  task: string
  by: Operator
  /** Como ou onde acontece (ex.: "pelo Portal do Gestor, dentro da alçada da unidade"). */
  note: string
  /** Slugs dos módulos envolvidos (1 a 3). */
  modules: string[]
}

/** O fluxo do centro de serviços: entradas por origem, o centro que processa e o que sai pronto. */
export interface ServiceFlow {
  inputs: { from: string; operator: Operator; items: string[] }[]
  center: { title: string; text: string; modules: string[] }
  outputs: { title: string; modules: string[] }[]
}

export interface StructureCsc {
  title: string
  text: string
  /** O caminho (3 a 4 passos) até um único time operar todas as empresas e unidades. */
  steps: { title: string; text: string }[]
}

export interface StructurePersona {
  role: string
  text: string
}

export interface StructureFaq {
  q: string
  a: string
}

export interface StructurePage {
  slug: StructureSlug
  name: string
  /** Frase de abertura; um trecho pode ser [[destacado]]. */
  tagline: string
  summary: string
  seo: { title: string; description: string }
  /** Como o RH costuma funcionar nessa estrutura (dois parágrafos). */
  context: string[]
  /** Três marcas da estrutura. */
  facts: StructureFact[]
  /** As maiores dores de RH dessa estrutura (3 a 4). */
  pains: StructurePain[]
  /** Como o sistema responde a cada dor, com os módulos envolvidos (mesma ordem das dores). */
  answers: StructureAnswer[]
  /** Quem faz o quê: a rotina distribuída entre gestores, RH da unidade, RH central e NATI (8 a 12 linhas). */
  responsibilities: Responsibility[]
  /** O fluxo do centro de serviços nessa estrutura. */
  flow: ServiceFlow
  /** Módulos que mais pesam nessa estrutura (5 a 6 slugs). */
  spotlight: string[]
  /** Uma frase por módulo: como cada um se aplica a essa estrutura (todos os slugs do registro). */
  moduleNotes: Record<string, string>
  /** Onde isso leva: o caminho para o centro de serviços compartilhados. */
  csc: StructureCsc
  personas: StructurePersona[]
  faq: StructureFaq[]
  /** Outras estruturas parecidas ou o próximo passo natural (slugs). */
  related: StructureSlug[]
}
