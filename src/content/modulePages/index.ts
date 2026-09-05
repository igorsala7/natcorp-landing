import registryJson from './registry.json'
import type { GroupId, ModulePage } from './types'
import type { IconName } from './icons'

export interface ModuleEntry {
  slug: string
  name: string
  group: GroupId
  icon: IconName
  short: string
}

export interface GroupMeta {
  id: GroupId
  name: string
  tagline: string
}

/** Grupos na ordem oficial do manual (seção 02). */
export const groups: GroupMeta[] = [
  { id: 'pessoal-e-folha', name: 'Pessoal e Folha', tagline: 'Folha, headcount, cargos, benefícios, eSocial e jurídico na mesma base.' },
  { id: 'ponto-e-jornada', name: 'Ponto e Jornada', tagline: 'Marcação, apuração e horas certas na folha.' },
  { id: 'saude-e-seguranca', name: 'Saúde e Segurança', tagline: 'SESMT dentro do sistema de RH.' },
  { id: 'talentos', name: 'Talentos', tagline: 'Da vaga à admissão sem papel.' },
  { id: 'desenvolvimento', name: 'Desenvolvimento', tagline: 'Avaliar, treinar, reconhecer e preparar sucessores.' },
  { id: 'autoatendimento', name: 'Autoatendimento', tagline: 'Portais, requisições, chamados e documentos digitais.' },
  { id: 'dados-ia-plataforma', name: 'Dados, IA e Plataforma', tagline: 'Dado para decidir, NATI e nuvem segura.' },
]

export const moduleRegistry = registryJson as ModuleEntry[]

export const modulesByGroup = (id: GroupId) => moduleRegistry.filter((m) => m.group === id)

export const getModuleEntry = (slug: string) => moduleRegistry.find((m) => m.slug === slug)

export const getGroup = (id: GroupId) => groups.find((g) => g.id === id)!

export const modulePath = (slug: string, hash?: string) => `/modulos/${slug}${hash ?? ''}`

const loaders = import.meta.glob<{ default: ModulePage }>('./*.ts', { eager: false })

/** Carrega o conteúdo completo de um módulo sob demanda (um chunk por módulo). */
export async function loadModulePage(slug: string): Promise<ModulePage | null> {
  const loader = loaders[`./${slug}.ts`]
  if (!loader) return null
  const mod = await loader()
  return mod.default
}
