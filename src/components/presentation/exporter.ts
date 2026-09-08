import { toPng } from 'html-to-image'

/**
 * Exportação da apresentação no próprio navegador: cada slide é fotografado como está na tela
 * (com as animações de entrada já concluídas) e vira uma página 16:9 no PDF ou um slide no
 * PowerPoint. O PPTX leva as notas do apresentador no painel de notas de cada slide.
 *
 * A imagem é fiel ao que se vê; o texto do slide não é editável no PowerPoint (as notas são).
 */

export type ExportFormat = 'pdf' | 'pptx'

export interface ExportProgress {
  /** O que está acontecendo, para a barra de progresso. */
  stage: 'preparando' | 'capturando' | 'montando'
  done: number
  total: number
}

export interface ExportOptions {
  /** A raiz rolável da apresentação (`.deck-root`). */
  root: HTMLElement
  /** Título do documento (e do arquivo). */
  title: string
  fileName: string
  /** Notas por id de slide, para o painel de notas do PowerPoint. */
  notes: Record<string, string[] | undefined>
  onProgress?: (p: ExportProgress) => void
  signal?: AbortSignal
}

/** A página de saída: 16:9, no tamanho de um projetor Full HD. */
const PAGE = { w: 1920, h: 1080 } as const

/** Cor de fundo de cada tom de slide, para as bordas quando a tela não é 16:9. */
const fill: Record<string, string> = {
  white: '#FFFFFF',
  off: '#F4F2F7',
  dark: '#2C1A63',
  gradient: '#511C76',
}

const wait = (ms: number) => new Promise<void>((r) => window.setTimeout(r, ms))

function assertNotAborted(signal?: AbortSignal) {
  if (signal?.aborted) throw new DOMException('Exportação cancelada', 'AbortError')
}

function slidesOf(root: HTMLElement) {
  return Array.from(root.querySelectorAll<HTMLElement>('[data-slide]'))
}

/** Passa por todos os slides para as animações de entrada (que rodam uma vez, ao aparecer) acontecerem. */
async function warmUp(slides: HTMLElement[], signal?: AbortSignal) {
  for (const el of slides) {
    assertNotAborted(signal)
    el.scrollIntoView({ behavior: 'auto', block: 'start' })
    await wait(140)
  }
  // O último slide visto ainda está animando: dá tempo para as entradas mais longas terminarem.
  await wait(1200)
}

/** Fotografa um slide e o encaixa, centralizado, numa página 16:9 com o fundo do próprio tom. */
async function capture(el: HTMLElement): Promise<string> {
  const ratio = Math.min(2, PAGE.w / Math.max(1, el.clientWidth))
  const png = await toPng(el, {
    pixelRatio: ratio,
    cacheBust: false,
    // A interface fixa da apresentação (barra, índice, notas) fica fora da seção; nada a filtrar aqui.
    backgroundColor: fill[el.dataset.tone ?? 'white'] ?? '#FFFFFF',
  })
  const img = await new Promise<HTMLImageElement>((resolve, reject) => {
    const i = new Image()
    i.onload = () => resolve(i)
    i.onerror = () => reject(new Error('Não deu para ler a imagem do slide.'))
    i.src = png
  })
  const canvas = document.createElement('canvas')
  canvas.width = PAGE.w
  canvas.height = PAGE.h
  const ctx = canvas.getContext('2d')
  if (!ctx) throw new Error('Sem canvas para montar a página.')
  ctx.fillStyle = fill[el.dataset.tone ?? 'white'] ?? '#FFFFFF'
  ctx.fillRect(0, 0, PAGE.w, PAGE.h)
  const scale = Math.min(PAGE.w / img.width, PAGE.h / img.height)
  const w = Math.round(img.width * scale)
  const h = Math.round(img.height * scale)
  ctx.imageSmoothingQuality = 'high'
  ctx.drawImage(img, Math.round((PAGE.w - w) / 2), Math.round((PAGE.h - h) / 2), w, h)
  return canvas.toDataURL('image/jpeg', 0.92)
}

interface Captured {
  id: string
  title: string
  image: string
}

async function captureAll(opts: ExportOptions): Promise<Captured[]> {
  const { root, onProgress, signal } = opts
  const slides = slidesOf(root)
  const total = slides.length
  const before = root.scrollTop
  onProgress?.({ stage: 'preparando', done: 0, total })
  await warmUp(slides, signal)
  const out: Captured[] = []
  for (let i = 0; i < slides.length; i++) {
    assertNotAborted(signal)
    const el = slides[i]
    onProgress?.({ stage: 'capturando', done: i, total })
    el.scrollIntoView({ behavior: 'auto', block: 'start' })
    await wait(260)
    out.push({ id: el.dataset.slideId ?? String(i), title: el.dataset.label ?? `Slide ${i + 1}`, image: await capture(el) })
  }
  onProgress?.({ stage: 'montando', done: total, total })
  root.scrollTo({ top: before, behavior: 'auto' })
  return out
}

/** PDF: uma página 16:9 por slide. */
export async function exportPdf(opts: ExportOptions): Promise<void> {
  const pages = await captureAll(opts)
  const { jsPDF } = await import('jspdf')
  const pdf = new jsPDF({ orientation: 'landscape', unit: 'px', format: [PAGE.w, PAGE.h], compress: true, hotfixes: ['px_scaling'] })
  pdf.setProperties({ title: opts.title, author: 'Natcorp', subject: 'Apresentação comercial', creator: 'natcorp.com.br' })
  pages.forEach((p, i) => {
    if (i > 0) pdf.addPage([PAGE.w, PAGE.h], 'landscape')
    pdf.addImage(p.image, 'JPEG', 0, 0, PAGE.w, PAGE.h, undefined, 'FAST')
  })
  assertNotAborted(opts.signal)
  pdf.save(`${opts.fileName}.pdf`)
}

/** PowerPoint: um slide 16:9 por slide, com a imagem ao fundo e as notas do apresentador. */
export async function exportPptx(opts: ExportOptions): Promise<void> {
  const pages = await captureAll(opts)
  const { default: PptxGenJS } = await import('pptxgenjs')
  const pptx = new PptxGenJS()
  pptx.layout = 'LAYOUT_16x9'
  pptx.title = opts.title
  pptx.author = 'Natcorp'
  pptx.company = 'Natcorp'
  pptx.subject = 'Apresentação comercial'
  pages.forEach((p) => {
    const slide = pptx.addSlide()
    slide.addImage({ data: p.image, x: 0, y: 0, w: '100%', h: '100%' })
    const notes = opts.notes[p.id]
    slide.addNotes([p.title, ...(notes ?? [])].join('\n'))
  })
  assertNotAborted(opts.signal)
  await pptx.writeFile({ fileName: `${opts.fileName}.pptx` })
}

export function runExport(format: ExportFormat, opts: ExportOptions) {
  return format === 'pdf' ? exportPdf(opts) : exportPptx(opts)
}
