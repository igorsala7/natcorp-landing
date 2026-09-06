import type { ComponentType } from 'react'

/**
 * Cenas montadas por camadas (cenário em SVG + figura 3D + interface animada), por id de etapa.
 * Descobertas pelo nome do arquivo: `Etapa04Scene.tsx` exporta `Etapa04Scene` e vale para a "etapa-04".
 * Têm prioridade sobre a cena ilustrada em arquivo (scene-<etapa>.jpg).
 */
const files = import.meta.glob<Record<string, ComponentType>>('./Etapa*Scene.tsx', { eager: true })

export const composedScenes: Record<string, ComponentType> = Object.fromEntries(
  Object.entries(files).flatMap(([path, mod]) => {
    const match = path.match(/Etapa(\d+)Scene\.tsx$/)
    const component = match && mod[`Etapa${match[1]}Scene`]
    return match && component ? [[`etapa-${match[1]}`, component]] : []
  }),
)
