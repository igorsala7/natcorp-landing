import { CreditCard, Factory, Globe, Handshake, HeartPulse, Landmark, Package, RadioTower, ShoppingCart } from 'lucide-react'
import registryJson from './registry.json'
import type { SegmentPage } from './types'

export const segmentIcons = {
  factory: Factory,
  package: Package,
  handshake: Handshake,
  'heart-pulse': HeartPulse,
  globe: Globe,
  landmark: Landmark,
  'credit-card': CreditCard,
  'shopping-cart': ShoppingCart,
  'radio-tower': RadioTower,
} as const

export type SegmentIconName = keyof typeof segmentIcons

export interface SegmentEntry {
  slug: string
  name: string
  /** Rótulo no menu (pode ser mais longo que o nome). */
  label: string
  icon: SegmentIconName
  short: string
}

export const segmentRegistry = registryJson as SegmentEntry[]

export const getSegmentEntry = (slug: string) => segmentRegistry.find((s) => s.slug === slug)

export const segmentsPath = '/segmentos'

export const segmentPath = (slug: string) => `${segmentsPath}/${slug}`

const loaders = import.meta.glob<{ default: SegmentPage }>('./*.ts', { eager: false })

/** Carrega o conteúdo completo de um segmento sob demanda (um chunk por segmento). */
export async function loadSegmentPage(slug: string): Promise<SegmentPage | null> {
  const loader = loaders[`./${slug}.ts`]
  if (!loader) return null
  const mod = await loader()
  return mod.default
}
