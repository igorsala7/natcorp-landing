/**
 * Converte um PNG gerado (qualquer tamanho) em src/assets/journey/scene-<etapa>.jpg, 1920x1080, qualidade 82,
 * usando o Chromium do Playwright (não há sharp nem PIL no ambiente).
 * Uso: NODE_PATH=$(npm root -g) node scripts/journey-scene-to-jpg.cjs <arquivo.png> <id-da-etapa>
 */
const { chromium } = require('playwright')
const fs = require('fs')
const path = require('path')
;(async () => {
  const [src, id] = process.argv.slice(2)
  if (!src || !id) throw new Error('uso: journey-scene-to-jpg.cjs <arquivo.png> <id-da-etapa>')
  const out = path.resolve(__dirname, '..', 'src', 'assets', 'journey', `scene-${id}.jpg`)
  const data = `data:image/png;base64,${fs.readFileSync(src).toString('base64')}`
  const b = await chromium.launch()
  const p = await b.newPage()
  const jpg = await p.evaluate(async (data) => {
    const img = new Image()
    await new Promise((r, j) => { img.onload = r; img.onerror = j; img.src = data })
    const c = document.createElement('canvas'); c.width = 1920; c.height = 1080
    const ctx = c.getContext('2d')
    const s = Math.max(1920 / img.width, 1080 / img.height)
    const w = img.width * s, h = img.height * s
    ctx.drawImage(img, (1920 - w) / 2, (1080 - h) / 2, w, h)
    return c.toDataURL('image/jpeg', 0.82).split(',')[1]
  }, data)
  fs.writeFileSync(out, Buffer.from(jpg, 'base64'))
  await b.close()
  console.log('escrito', out, fs.statSync(out).size, 'bytes')
})().catch((e) => { console.error(e); process.exit(1) })
