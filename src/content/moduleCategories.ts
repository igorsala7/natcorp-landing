import type { IconName } from './modulePages/icons'
import type { GroupId } from './modulePages/types'

/** Lado do palco de módulos (home, desktop) em que a frente aparece, em volta da base de dados. */
export type StageSide = 'left' | 'right' | 'top'

export interface CategoryMeta {
  /** Ícone que representa a frente (um dos ícones permitidos do manual). */
  icon: IconName
  side: StageSide
}

/**
 * Apresentação das sete frentes na home: ícone e posição no palco.
 * Nomes, ordem e taglines continuam vindo de `groups` (src/content/modulePages).
 */
export const categoryMeta: Record<GroupId, CategoryMeta> = {
  'pessoal-e-folha': { icon: 'wallet', side: 'left' },
  'ponto-e-jornada': { icon: 'clock', side: 'left' },
  'saude-e-seguranca': { icon: 'heart-pulse', side: 'left' },
  talentos: { icon: 'user-plus', side: 'right' },
  desenvolvimento: { icon: 'graduation-cap', side: 'right' },
  autoatendimento: { icon: 'layout-grid', side: 'right' },
  'dados-ia-plataforma': { icon: 'sparkles', side: 'top' },
}

/** O que a frente de dados acrescenta no cartão de destaque da home. */
export const dataFrontNote =
  'Painéis, relatórios e a NATI lendo os 31 módulos ao mesmo tempo. Tudo em nuvem segura, com APIs prontas para conversar com os outros sistemas da empresa.'

export const natiNote = 'A NATI lê os 31 módulos, cruza folha, ponto, SESMT e talentos e responde em segundos, com análise e sugestão.'
