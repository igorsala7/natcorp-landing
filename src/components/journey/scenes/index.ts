import type { ComponentType } from 'react'
import { Etapa01Scene } from './Etapa01Scene'

/**
 * Cenas montadas por camadas (cenário em SVG + figura 3D + interface animada), por id de etapa.
 * Têm prioridade sobre a cena ilustrada em arquivo (scene-<etapa>.jpg).
 */
export const composedScenes: Record<string, ComponentType> = {
  'etapa-01': Etapa01Scene,
}
