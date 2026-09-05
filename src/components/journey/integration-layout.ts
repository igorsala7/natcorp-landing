/**
 * Geometria e dados do diagrama de integração (IntegrationDiagram).
 * Tudo aqui é puro: calcula colunas, quebras de linha e larguras a partir do conteúdo,
 * para que o componente só desenhe.
 */

import { phases, platformSlugs, stepsByPhase, type JourneyPhase } from '@/content/hiringJourney'
import { getModuleEntry, type ModuleEntry } from '@/content/modulePages'

/* ---------------- Caixa do desenho ---------------- */

export const VB_W = 1280
export const MARGIN_X = 32
export const COL_GAP = 56
export const COL_COUNT = 4
export const COL_W = (VB_W - MARGIN_X * 2 - COL_GAP * (COL_COUNT - 1)) / COL_COUNT // 262

export const RETURN_Y = 40
export const HEADER_Y = 80
export const HEADER_H = 64
export const RAIL_Y = HEADER_Y + HEADER_H / 2 // 112

export const NODES_Y = HEADER_Y + HEADER_H + 18 // 162
export const NODE_H = 44
export const NODE_GAP = 7
export const NODE_PITCH = NODE_H + NODE_GAP
/** Máximo de módulos desenhados por coluna antes do nó "+N módulos". */
export const MAX_NODES = 10
export const BAND_X = MARGIN_X
export const BAND_W = VB_W - MARGIN_X * 2
export const CHIP_H = 30
export const CHIP_ROW_GAP = 10
export const BAND_PAD_Y = 27
/** Largura reservada ao símbolo e à legenda no centro da faixa. */
export const BAND_CENTER_W = 176
export const BAND_SIDE_PAD = 14

export const colX = (i: number) => MARGIN_X + i * (COL_W + COL_GAP)
export const colCenter = (i: number) => colX(i) + COL_W / 2

/* ---------------- Medida aproximada de texto (Manrope) ---------------- */

/* Larguras em em, calibradas contra a Manrope renderizada (600 e 700, 12 a 16 px). */
const NARROW = new Set(['i', 'j', 'l', "'", '.', ',', ':', ';', '|', '!', 'í', 'ì', 'î'])
const SEMI_NARROW = new Set(['f', 't', 'r', 'I', '(', ')', '[', ']', '-'])
const WIDE_LOWER = new Set(['m', 'w'])
const WIDE_UPPER = new Set(['M', 'W', 'O', 'Q', 'G', 'D'])

/**
 * Largura estimada em px de um texto em Manrope. Serve para decidir quebras e larguras de chips;
 * fica a poucos por cento do valor real, e os consumidores somam uma folga.
 */
export function estimateTextWidth(text: string, fontSize: number, weight = 400, letterSpacing = 0) {
  let em = 0
  for (const ch of text) {
    if (ch === ' ') em += 0.27
    else if (NARROW.has(ch)) em += 0.28
    else if (SEMI_NARROW.has(ch)) em += 0.37
    else if (WIDE_LOWER.has(ch)) em += 0.86
    else if (/\d/.test(ch)) em += 0.6
    else if (ch === ch.toUpperCase() && ch !== ch.toLowerCase()) em += WIDE_UPPER.has(ch) ? 0.78 : 0.68
    else em += 0.56
  }
  const boldFactor = weight >= 700 ? 1.05 : weight >= 600 ? 1.02 : 1
  return em * fontSize * boldFactor + letterSpacing * fontSize * text.length
}

/**
 * Quebra um nome em até duas linhas, preenchendo a primeira o máximo possível.
 * Com `force`, divide mesmo que o texto caiba em uma linha (quando a decisão de quebrar já foi tomada).
 */
export function wrapLabel(text: string, maxWidth: number, fontSize: number, weight: number, force = false): string[] {
  if (!force && estimateTextWidth(text, fontSize, weight) <= maxWidth) return [text]
  const words = text.split(' ')
  if (words.length < 2) return [text]
  let best = 1
  for (let i = 1; i < words.length; i++) {
    const head = words.slice(0, i).join(' ')
    if (estimateTextWidth(head, fontSize, weight) <= maxWidth) best = i
    else break
  }
  return [words.slice(0, best).join(' '), words.slice(best).join(' ')]
}

/* ---------------- Colunas de fase ---------------- */

export interface FlowNode {
  kind: 'module'
  entry: ModuleEntry
  /** Nome em uma ou duas linhas, já quebrado para a largura do nó. */
  lines: string[]
}

export interface OverflowNode {
  kind: 'overflow'
  count: number
  /** Nomes dos módulos que ficaram fora do desenho (para o title e a lista acessível). */
  hidden: ModuleEntry[]
}

export type ColumnNode = FlowNode | OverflowNode

export interface PhaseColumn {
  phase: JourneyPhase
  index: number
  x: number
  /** Todos os módulos de fluxo da fase (sem os de plataforma), na ordem de primeira aparição. */
  entries: ModuleEntry[]
  /** O que é desenhado: até MAX_NODES módulos e, se houver mais, um nó de excedente. */
  nodes: ColumnNode[]
  /** y da borda inferior do último nó desenhado. */
  bottom: number
}

export const NODE_TEXT_X = 46
export const NODE_TEXT_MAX_W = COL_W - NODE_TEXT_X - 12
export const NODE_FONT = 13.5
export const NODE_FONT_2L = 12.5

export function buildColumns(): PhaseColumn[] {
  const platform = new Set<string>(platformSlugs)
  return phases.map((phase, index) => {
    const seen = new Set<string>()
    const entries: ModuleEntry[] = []
    for (const step of stepsByPhase(phase.n)) {
      for (const ref of step.modules) {
        if (platform.has(ref.slug) || seen.has(ref.slug)) continue
        seen.add(ref.slug)
        const entry = getModuleEntry(ref.slug)
        if (entry) entries.push(entry)
      }
    }
    const shown = entries.length > MAX_NODES ? entries.slice(0, MAX_NODES) : entries
    const hidden = entries.length > MAX_NODES ? entries.slice(MAX_NODES) : []
    const nodes: ColumnNode[] = shown.map((entry) => {
      /* Cabe em uma linha no tamanho padrão? Se não, vai para duas linhas no tamanho menor. */
      const fits = estimateTextWidth(entry.name, NODE_FONT, 700) <= NODE_TEXT_MAX_W
      const lines = fits ? [entry.name] : wrapLabel(entry.name, NODE_TEXT_MAX_W, NODE_FONT_2L, 700, true)
      return { kind: 'module', entry, lines }
    })
    if (hidden.length) nodes.push({ kind: 'overflow', count: hidden.length, hidden })
    const bottom = NODES_Y + nodes.length * NODE_PITCH - NODE_GAP
    return { phase, index, x: colX(index), entries, nodes, bottom }
  })
}

/** Linhas realmente usadas (a coluna mais cheia): a altura do desenho segue o conteúdo. */
export const MAX_ROWS = Math.max(...buildColumns().map((c) => c.nodes.length))
export const NODES_END = NODES_Y + MAX_ROWS * NODE_PITCH - NODE_GAP

export const BAND_Y = NODES_END + 44

/* ---------------- Faixa de plataforma ---------------- */

export const CHIP_FONT = 13
export const CHIP_TEXT_X = 31
export const CHIP_PAD_R = 13
export const CHIP_GAP = 8

export interface Chip {
  entry: ModuleEntry
  x: number
  y: number
  w: number
}

export interface PlatformBand {
  y: number
  h: number
  rows: number
  chips: Chip[]
  entries: ModuleEntry[]
}

const chipWidth = (name: string) => Math.ceil(CHIP_TEXT_X + estimateTextWidth(name, CHIP_FONT, 600) * 1.04 + CHIP_PAD_R)
const rowWidth = (row: Chip[]) => row.reduce((n, c) => n + c.w, 0) + CHIP_GAP * Math.max(0, row.length - 1)

/** Divide uma sequência em duas linhas, na ordem, minimizando a largura da linha mais larga. */
function splitRows(items: Chip[]): Chip[][] {
  if (items.length < 2) return items.length ? [items] : []
  let best = 1
  let bestScore = Infinity
  for (let i = 1; i < items.length; i++) {
    const score = Math.max(rowWidth(items.slice(0, i)), rowWidth(items.slice(i)))
    if (score < bestScore) {
      bestScore = score
      best = i
    }
  }
  return [items.slice(0, best), items.slice(best)]
}

/** Reparte os chips entre os dois lados do símbolo, duas linhas por lado, o mais equilibrado possível. */
function distribute(chips: Chip[]): { left: Chip[][]; right: Chip[][] } {
  const n = chips.length
  if (n < 4) return { left: splitRows(chips), right: [] }
  let bestK = Math.ceil(n / 2)
  let bestScore = Infinity
  for (let k = 2; k <= n - 2; k++) {
    const rows = [...splitRows(chips.slice(0, k)), ...splitRows(chips.slice(k))]
    const score = Math.max(...rows.map(rowWidth))
    const closer = Math.abs(k - n / 2) < Math.abs(bestK - n / 2)
    if (score < bestScore || (score === bestScore && closer)) {
      bestScore = score
      bestK = k
    }
  }
  return { left: splitRows(chips.slice(0, bestK)), right: splitRows(chips.slice(bestK)) }
}

/** Posiciona linhas de chips centradas em uma área, uma linha abaixo da outra. */
function placeRows(rows: Chip[][], areaX: number, areaW: number, top: number): Chip[] {
  return rows.flatMap((row, ri) => {
    let x = areaX + (areaW - rowWidth(row)) / 2
    const y = top + ri * (CHIP_H + CHIP_ROW_GAP)
    return row.map((c) => {
      const placed = { ...c, x, y }
      x += c.w + CHIP_GAP
      return placed
    })
  })
}

export function buildPlatformBand(): PlatformBand {
  const entries = platformSlugs.map(getModuleEntry).filter((e): e is ModuleEntry => Boolean(e))
  const chips: Chip[] = entries.map((entry) => ({ entry, x: 0, y: 0, w: chipWidth(entry.name) }))
  const { left, right } = distribute(chips)

  const sideW = (BAND_W - BAND_CENTER_W) / 2 - BAND_SIDE_PAD * 2
  const leftX = BAND_X + BAND_SIDE_PAD
  const rightX = BAND_X + BAND_W - BAND_SIDE_PAD - sideW

  const rows = Math.max(left.length, right.length, 2)
  const rowsH = rows * CHIP_H + (rows - 1) * CHIP_ROW_GAP
  /* A coluna central (símbolo + legenda) precisa de ~104 px; as linhas de chips, do que somarem. */
  const h = Math.max(124, rowsH + BAND_PAD_Y * 2)
  const top = BAND_Y + (h - rowsH) / 2

  return { y: BAND_Y, h, rows, chips: [...placeRows(left, leftX, sideW, top), ...placeRows(right, rightX, sideW, top)], entries }
}

/* ---------------- Trilho principal e arco de retorno ---------------- */

export const RAIL_X0 = MARGIN_X
export const RAIL_X1 = VB_W - MARGIN_X
const ARC_R = 12
const ARC_OUT = 16

/** Arco de retorno: sai do fim da fase 4, sobe, volta pela parte de cima e entra na fase 1. */
export const RETURN_ARC_D = [
  `M ${RAIL_X1},${RAIL_Y}`,
  `H ${RAIL_X1 + ARC_OUT - ARC_R}`,
  `Q ${RAIL_X1 + ARC_OUT},${RAIL_Y} ${RAIL_X1 + ARC_OUT},${RAIL_Y - ARC_R}`,
  `V ${RETURN_Y + ARC_R}`,
  `Q ${RAIL_X1 + ARC_OUT},${RETURN_Y} ${RAIL_X1 + ARC_OUT - ARC_R},${RETURN_Y}`,
  `H ${RAIL_X0 - ARC_OUT + ARC_R}`,
  `Q ${RAIL_X0 - ARC_OUT},${RETURN_Y} ${RAIL_X0 - ARC_OUT},${RETURN_Y + ARC_R}`,
  `V ${RAIL_Y - ARC_R}`,
  `Q ${RAIL_X0 - ARC_OUT},${RAIL_Y} ${RAIL_X0 - ARC_OUT + ARC_R},${RAIL_Y}`,
  `H ${RAIL_X0}`,
].join(' ')

/** Caminho completo do ciclo, para o ponto que percorre o fluxo: trilho e arco de retorno. */
export const LOOP_D = `M ${RAIL_X0},${RAIL_Y} H ${RAIL_X1} ${RETURN_ARC_D.replace(/^M [^ ]+ /, '')}`

/** Centro do intervalo entre duas colunas vizinhas (i e i+1). */
export const gapCenter = (i: number) => colX(i) + COL_W + COL_GAP / 2
