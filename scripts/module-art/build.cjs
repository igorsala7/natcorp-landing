/**
 * Gera os ícones e as ilustrações dos módulos em SVG e PNG.
 *
 *   node scripts/module-art/build.cjs                 # tudo, em brand/modulos
 *   node scripts/module-art/build.cjs --only natpay,nati --out /tmp/x --no-png
 *
 * PNG via Chromium (Playwright): ícones em 1024 e 256 (fundo transparente),
 * ilustrações em 2400x1600 (@2x) e 1200x800. Também monta folhas de contato.
 */
const fs = require('fs')
const path = require('path')
const kit = require('./kit.cjs')
const icons = require('./icons.cjs')

const ROOT = path.resolve(__dirname, '../..')
const registry = require(path.join(ROOT, 'src/content/modulePages/registry.json'))
const args = process.argv.slice(2)
const opt = (name) => {
  const i = args.indexOf(name)
  return i >= 0 ? args[i + 1] : undefined
}
const only = opt('--only')?.split(',').map((s) => s.trim()).filter(Boolean)
const OUT = path.resolve(opt('--out') || path.join(ROOT, 'brand/modulos'))
const NO_PNG = args.includes('--no-png')
const SHEETS = !args.includes('--no-sheets')

const modules = registry.filter((m) => !only || only.includes(m.slug))

function ensure(dir) {
  fs.mkdirSync(dir, { recursive: true })
  return dir
}
const dirs = {
  iconSvg: ensure(path.join(OUT, 'icones/svg')),
  iconPng: ensure(path.join(OUT, 'icones/png')),
  illSvg: ensure(path.join(OUT, 'ilustracoes/svg')),
  illPng: ensure(path.join(OUT, 'ilustracoes/png')),
}

function loadScene(slug) {
  const file = path.join(__dirname, 'scenes', `${slug}.cjs`)
  if (!fs.existsSync(file)) return null
  delete require.cache[file]
  return require(file)
}

const made = []
for (const m of modules) {
  const glyph = icons[m.slug]
  const entry = { slug: m.slug, name: m.name }
  if (glyph) {
    const svg = kit.iconSvg(glyph(kit), { id: `ic-${m.slug}`, label: `Ícone do módulo ${m.name}` })
    fs.writeFileSync(path.join(dirs.iconSvg, `${m.slug}.svg`), svg)
    entry.icon = svg
  } else {
    console.warn(`(sem ícone) ${m.slug}`)
  }
  const scene = loadScene(m.slug)
  if (scene) {
    const svg = kit.illustrationSvg(scene(kit, m), { id: `il-${m.slug}`, label: `Ilustração do módulo ${m.name}: ${m.short || ''}` })
    fs.writeFileSync(path.join(dirs.illSvg, `${m.slug}.svg`), svg)
    entry.ill = svg
  } else {
    console.warn(`(sem ilustração) ${m.slug}`)
  }
  made.push(entry)
}
console.log(`SVG: ${made.filter((e) => e.icon).length} ícones, ${made.filter((e) => e.ill).length} ilustrações → ${OUT}`)

if (NO_PNG) process.exit(0)

const fontCss = ['manrope-latin.woff2', 'manrope-latin-ext.woff2']
  .map((f) => {
    const b64 = fs.readFileSync(path.join(ROOT, 'public/fonts', f)).toString('base64')
    return `@font-face{font-family:Manrope;font-weight:200 800;src:url(data:font/woff2;base64,${b64}) format('woff2')}`
  })
  .join('')

async function main() {
  const { chromium } = require('playwright')
  const browser = await chromium.launch()
  const ctx = await browser.newContext({ deviceScaleFactor: 1 })
  const page = await ctx.newPage()

  async function render(svg, w, h, outFile, { transparent = false, scale = 1 } = {}) {
    await page.setViewportSize({ width: Math.round(w * scale), height: Math.round(h * scale) })
    const html = `<!doctype html><html><head><meta charset="utf-8"><style>${fontCss}
      html,body{margin:0;padding:0;background:${transparent ? 'transparent' : '#fff'}}
      svg{display:block;width:${w * scale}px;height:${h * scale}px}</style></head><body>${svg}</body></html>`
    await page.setContent(html)
    await page.evaluate(() => document.fonts.ready)
    await page.screenshot({ path: outFile, omitBackground: transparent, clip: { x: 0, y: 0, width: w * scale, height: h * scale } })
  }

  for (const e of made) {
    if (e.icon) {
      await render(e.icon, 1024, 1024, path.join(dirs.iconPng, `${e.slug}.png`), { transparent: true })
      await render(e.icon, 256, 256, path.join(dirs.iconPng, `${e.slug}@256.png`), { transparent: true })
    }
    if (e.ill) {
      await render(e.ill, 1200, 800, path.join(dirs.illPng, `${e.slug}@2x.png`), { scale: 2 })
      await render(e.ill, 1200, 800, path.join(dirs.illPng, `${e.slug}.png`))
    }
    process.stdout.write(`PNG ${e.slug}\n`)
  }

  if (SHEETS) {
    // Folhas de contato: ícones (7 colunas) e ilustrações (3 colunas), com os nomes.
    const label = (n) => `<div style="font:600 13px/1.3 Manrope,Arial;color:#4A4460;text-align:center;margin-top:6px">${n}</div>`
    const iconCells = made
      .filter((e) => e.icon)
      .map((e) => `<div>${e.icon.replace('<svg ', '<svg style="width:150px;height:150px" ')}${label(e.name)}</div>`)
      .join('')
    const illCells = made
      .filter((e) => e.ill)
      .map((e) => `<div>${e.ill.replace('<svg ', '<svg style="width:380px;height:253px;border:1px solid #E9E5F1;border-radius:8px" ')}${label(e.name)}</div>`)
      .join('')
    const sheet = async (cells, cols, cellW, cellH, file) => {
      const n = cells.split('</div></div>').length - 1
      const rows = Math.ceil(n / cols)
      const w = cols * cellW + 40
      const h = rows * cellH + 40
      await page.setViewportSize({ width: w, height: h })
      await page.setContent(`<!doctype html><html><head><meta charset="utf-8"><style>${fontCss}body{margin:0;padding:20px;background:#fff;display:grid;grid-template-columns:repeat(${cols},${cellW}px);gap:0}</style></head><body>${cells}</body></html>`)
      await page.evaluate(() => document.fonts.ready)
      await page.screenshot({ path: file, fullPage: true })
    }
    if (iconCells) await sheet(iconCells, 7, 170, 190, path.join(OUT, 'previa-icones.png'))
    if (illCells) await sheet(illCells, 3, 400, 300, path.join(OUT, 'previa-ilustracoes.png'))
  }
  await browser.close()
}
main().catch((e) => {
  console.error(e)
  process.exit(1)
})
