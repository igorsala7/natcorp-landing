import { Briefcase, Building, MapPin, Network, Users } from 'lucide-react'
import registryJson from './registry.json'
import type { Operator, StructurePage, StructureSlug } from './types'

export type { Operator, StructurePage, StructureSlug } from './types'

export const structureIcons = {
  building: Building,
  'map-pin': MapPin,
  network: Network,
  users: Users,
  briefcase: Briefcase,
} as const

export type StructureIconName = keyof typeof structureIcons

export interface StructureEntry {
  slug: StructureSlug
  name: string
  /** Rótulo curto para chips, menu e cartões. */
  label: string
  icon: StructureIconName
  short: string
  /** Os atributos que descrevem a estrutura (chips dos cartões). */
  tags: string[]
}

export const structureRegistry = registryJson as StructureEntry[]

export const getStructureEntry = (slug: string) => structureRegistry.find((s) => s.slug === slug)

export const structuresPath = '/estruturas'

export const structurePath = (slug: string) => `${structuresPath}/${slug}`

/** Quem executa cada parte da rotina, com o rótulo e a cor usados nos mapas e no fluxo. */
export const operatorMeta: Record<Operator, { label: string; short: string; color: string }> = {
  gestores: { label: 'Gestores e colaboradores', short: 'Gestores', color: '#C95788' },
  'rh-unidade': { label: 'RH da unidade', short: 'RH da unidade', color: '#9A408A' },
  'rh-central': { label: 'RH central', short: 'RH central', color: '#511C76' },
  nati: { label: 'NATI', short: 'NATI', color: '#2C1A63' },
}

/* ------------------------------------------------------------------------------------------------
 * "Como é a sua estrutura?": três perguntas curtas levam à estrutura certa.
 * ---------------------------------------------------------------------------------------------- */

export type CompaniesAnswer = 'uma' | 'varias'
export type UnitsAnswer = 'sede' | 'filiais' | 'clientes'
export type HrAnswer = 'central' | 'unidade'

export interface ChooserAnswers {
  empresas?: CompaniesAnswer
  unidades?: UnitsAnswer
  rh?: HrAnswer
}

export interface ChooserOption<T extends string> {
  value: T
  label: string
  hint: string
}

export interface ChooserQuestion<K extends keyof ChooserAnswers> {
  key: K
  question: string
  options: ChooserOption<NonNullable<ChooserAnswers[K]>>[]
}

export const chooserQuestions: [ChooserQuestion<'empresas'>, ChooserQuestion<'unidades'>, ChooserQuestion<'rh'>] = [
  {
    key: 'empresas',
    question: 'Quantas empresas?',
    options: [
      { value: 'uma', label: 'Uma empresa', hint: 'Um CNPJ, ou matriz e filiais do mesmo CNPJ' },
      { value: 'varias', label: 'Várias empresas', hint: 'Grupo, holding ou empresas irmãs, com CNPJs e sindicatos diferentes' },
    ],
  },
  {
    key: 'unidades',
    question: 'Onde estão as equipes?',
    options: [
      { value: 'sede', label: 'Só na sede', hint: 'Todo mundo no mesmo endereço, ou remoto' },
      { value: 'filiais', label: 'Em várias unidades', hint: 'Filiais, lojas, plantas ou centros de distribuição' },
      { value: 'clientes', label: 'Alocadas em clientes', hint: 'Colaboradores trabalhando dentro de cada cliente' },
    ],
  },
  {
    key: 'rh',
    question: 'Como o RH opera?',
    options: [
      { value: 'central', label: 'Um time central', hint: 'Um RH cuida de todas as unidades' },
      { value: 'unidade', label: 'Um time em cada unidade', hint: 'Cada unidade tem o seu RH' },
    ],
  },
]

/** A pergunta sobre o RH só muda o resultado quando há várias unidades. */
export const hrQuestionMatters = (a: ChooserAnswers) => a.unidades === 'filiais'

/** Com as três respostas (ou as que importam), qual estrutura descreve a operação. */
export function matchStructure(a: ChooserAnswers): StructureSlug | null {
  if (!a.empresas || !a.unidades) return null
  if (a.unidades === 'clientes') return 'equipes-em-clientes'
  if (a.unidades === 'sede') return a.empresas === 'uma' ? 'empresa-unica' : 'grupo-rh-central'
  if (!a.rh) return null
  if (a.rh === 'unidade') return 'rh-por-unidade'
  return a.empresas === 'uma' ? 'varias-unidades' : 'grupo-rh-central'
}

const loaders = import.meta.glob<{ default: StructurePage }>('./*.ts', { eager: false })

/** Carrega o conteúdo completo de uma estrutura sob demanda (um chunk por estrutura). */
export async function loadStructurePage(slug: string): Promise<StructurePage | null> {
  const loader = loaders[`./${slug}.ts`]
  if (!loader) return null
  const mod = await loader()
  return mod.default
}
