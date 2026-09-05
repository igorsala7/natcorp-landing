/**
 * Arte da jornada: figuras 3D dos personagens (corpo inteiro ou meio corpo) e cenas ilustradas por etapa.
 * Os arquivos são opcionais e descobertos pelo nome, para que novas imagens entrem sem mudar código:
 *   src/assets/journey/figure-<personagem>.png   (recorte com fundo transparente; ex.: figure-ana.png)
 *   src/assets/journey/bust-<personagem>.png     (retrato para o avatar redondo; ex.: bust-marcos.png)
 *   src/assets/journey/scene-<id-da-etapa>.jpg   (cena ilustrada; ex.: scene-etapa-16.jpg)
 * Personagens: ana, marcos, juliana, claudia, beatriz, henrique, rafael, paulo, nati.
 */

import type { CastKey } from './hiringJourney'

const figureFiles = import.meta.glob<{ default: string }>('../assets/journey/figure-*.{png,webp}', { eager: true })
const bustFiles = import.meta.glob<{ default: string }>('../assets/journey/bust-*.{png,webp}', { eager: true })
const sceneFiles = import.meta.glob<{ default: string }>('../assets/journey/scene-*.{jpg,png,webp}', { eager: true })

function byName(files: Record<string, { default: string }>, prefix: string): Record<string, string> {
  const out: Record<string, string> = {}
  for (const [path, mod] of Object.entries(files)) {
    const file = path.split('/').pop() ?? ''
    const key = file.replace(new RegExp(`^${prefix}-`), '').replace(/\.(png|webp|jpg)$/, '')
    out[key] = mod.default
  }
  return out
}

/** Figuras de corpo inteiro ou meio corpo, recortadas, por personagem. */
export const figures = byName(figureFiles, 'figure') as Partial<Record<CastKey, string>>

/** Retratos para o avatar redondo, por personagem (a Ana e a NATI têm avatares próprios em src/assets/avatars). */
export const busts = byName(bustFiles, 'bust') as Partial<Record<CastKey, string>>

/** Cenas ilustradas por etapa (chave = id da etapa, ex.: "etapa-16"). */
export const scenes = byName(sceneFiles, 'scene') as Record<string, string | undefined>

/** Legendas das cenas, para acessibilidade. Só as etapas com cena prevista. */
export const sceneCaptions: Record<string, string> = {
  'etapa-01': 'Marcos, gerente de produção, abre a requisição de vaga no celular, no meio da fábrica.',
  'etapa-04': 'Ana, no sofá, se candidata pelo celular.',
  'etapa-10': 'Beatriz confere a admissão no notebook.',
  'etapa-11': 'Dr. Henrique registra o exame admissional no sistema.',
  'etapa-13': 'Beatriz confirma a admissão com um clique.',
  'etapa-16': 'Ana marca o ponto na portaria com o NatPonto, por reconhecimento facial.',
  'etapa-17': 'Rafael entrega os EPIs e Ana assina a ficha na tela.',
  'etapa-18': 'Ana na sala de treinamento, na trilha de entrada do cargo.',
  'etapa-23': 'O time de RH fecha a folha de 10.000 colaboradores nos notebooks, com a NATI.',
  'etapa-24': 'Ana, promovida a coordenadora, com a equipe.',
}

export const hasFigure = (who: CastKey) => Boolean(figures[who])
