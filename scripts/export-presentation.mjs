// Exporta a apresentação executiva (/apresentacao) em PDF (um slide por página, 16:9) e,
// opcionalmente, em PNG por slide. Usa o Chromium do Playwright.
//
//   npm run build && npm run preview            # em um terminal
//   npm run export:deck                         # em outro: gera public/natcorp-apresentacao.pdf
//
// O arquivo em public/ é o que o botão "Baixar em PDF" da apresentação entrega: gere de novo
// depois de mudar o conteúdo e faça o build em seguida.
//
// Opções: --version completa|reduzida (padrão completa)
//         --url <endereço> (padrão http://localhost:4173/apresentacao ou /apresentacao/reduzida)
//         --out <arquivo.pdf> (padrão public/natcorp-apresentacao.pdf)
//         --png <pasta> (também salva slide-01.png, slide-02.png…)
//         --width <px> --height <px> (janela usada nas capturas; padrão 1920x1080)
// Requer o pacote `playwright` (npm i -D playwright && npx playwright install chromium).
import { mkdirSync } from 'node:fs'
import { dirname, resolve } from 'node:path'

const args = process.argv.slice(2)
const opt = (name, fallback) => {
  const i = args.indexOf(`--${name}`)
  return i >= 0 && args[i + 1] ? args[i + 1] : fallback
}
const version = opt('version', 'completa') // completa | reduzida
const url = opt('url', version === 'reduzida' ? 'http://localhost:4173/apresentacao/reduzida' : 'http://localhost:4173/apresentacao')
const out = resolve(opt('out', version === 'reduzida' ? 'public/natcorp-apresentacao-reduzida.pdf' : 'public/natcorp-apresentacao.pdf'))
const pngDir = opt('png', '')
const width = Number(opt('width', '1920'))
const height = Number(opt('height', '1080'))

const { chromium } = await import('playwright')
const browser = await chromium.launch()
const page = await browser.newPage({ viewport: { width, height }, deviceScaleFactor: 1 })
// A abertura da marca roda uma vez por sessão; aqui ela já foi vista.
await page.addInitScript(() => {
  try {
    window.sessionStorage.setItem('natcorp:intro', '1')
  } catch {
    /* sem armazenamento */
  }
})
await page.goto(url, { waitUntil: 'networkidle' })
await page.waitForSelector('.deck-root [data-slide]')
await page.waitForTimeout(600)

const total = await page.locator('.deck-root [data-slide]').count()
if (pngDir) mkdirSync(resolve(pngDir), { recursive: true })

// Passa por todos os slides para as animações de entrada acontecerem (e captura os PNGs).
for (let i = 0; i < total; i++) {
  await page.evaluate((n) => document.querySelector(`[data-slide="${n}"]`)?.scrollIntoView({ behavior: 'auto', block: 'start' }), i)
  await page.waitForTimeout(pngDir ? 1600 : 220)
  if (pngDir) {
    await page.screenshot({ path: resolve(pngDir, `slide-${String(i + 1).padStart(2, '0')}.png`), fullPage: false })
  }
}
await page.waitForTimeout(1400)

mkdirSync(dirname(out), { recursive: true })
await page.emulateMedia({ media: 'print' })
// Cada slide recalcula a escala para caber na página (Slide.tsx escuta a mudança de mídia).
await page.waitForTimeout(800)
// A página do PDF tem o tamanho da janela: o Chrome só usa essa largura no layout quando ela vem nas opções.
await page.pdf({ path: out, width: `${width}px`, height: `${height}px`, printBackground: true })
await browser.close()
console.log(`apresentação: ${total} slides → ${out}${pngDir ? ` (+ PNG em ${resolve(pngDir)})` : ''}`)
