// Gera um documento técnico Natcorp: figuras SVG, HTML, PDF A4 e prévias PNG.
//
// Uso (a partir da raiz do natcorp-landing):
//   node .claude/skills/documento-tecnico/toolkit/gerar.mjs <pasta-do-documento> [--sem-png] [--so-html]
//
// A pasta do documento tem: documento.config.mjs, conteudo.md, figuras/fig_*.mjs (opcional),
// assets/ (opcional, imagens usadas pelas figuras ou pela capa). Tudo o que é gerado vai para
// <doc>/build/ e o PDF final para <doc>/<config.arquivoPdf>.
import { readFileSync, writeFileSync, mkdirSync, readdirSync, unlinkSync, existsSync, renameSync, cpSync, copyFileSync, rmSync } from 'node:fs';
import { dirname, join, resolve, basename } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { execFileSync } from 'node:child_process';
import { homedir } from 'node:os';
import { chromium } from 'playwright-core';
import montar from './src/montar.mjs';

const toolkit = dirname(fileURLToPath(import.meta.url));
const args = process.argv.slice(2);
const docArg = args.find((a) => !a.startsWith('--'));
if (!docArg) { console.error('Uso: node gerar.mjs <pasta-do-documento> [--sem-png] [--so-html]'); process.exit(1); }
const doc = resolve(docArg);
const semPng = args.includes('--sem-png');
const soHtml = args.includes('--so-html');
const { default: config } = await import(pathToFileURL(join(doc, 'documento.config.mjs')).href + '?v=' + Date.now());

// 1. pasta de build com o sistema visual + recursos do documento
const build = join(doc, 'build');
rmSync(build, { recursive: true, force: true });
mkdirSync(join(build, 'figuras'), { recursive: true });
for (const f of ['estilo.css', 'documento.css']) copyFileSync(join(toolkit, f), join(build, f));
// rodapé de cada página (a regra @page não pode passar pelo acabamento tipográfico do HTML)
const rodape = String(config.rodape || 'NATCORP').replace(/["\\]/g, '');
writeFileSync(join(build, 'estilo.css'), readFileSync(join(build, 'estilo.css'), 'utf8').replace('content: "NATCORP";', `content: "${rodape}";`));
cpSync(join(toolkit, 'fonts'), join(build, 'fonts'), { recursive: true });
cpSync(join(toolkit, 'marca'), join(build, 'marca'), { recursive: true });
if (existsSync(join(doc, 'assets'))) cpSync(join(doc, 'assets'), join(build, 'marca'), { recursive: true });

// 2. figuras: cada módulo de doc/figuras exporta default () => string SVG; config.figuras mapeia o nome do SVG
copyFileSync(join(toolkit, 'src', 'lib.mjs'), join(build, 'figuras', 'lib.mjs'));
if (existsSync(join(doc, 'figuras'))) {
  for (const f of readdirSync(join(doc, 'figuras'))) if (f.endsWith('.mjs')) copyFileSync(join(doc, 'figuras', f), join(build, 'figuras', f));
}
for (const [svgNome, mod] of Object.entries(config.figuras || {})) {
  const { default: gerarFig } = await import(pathToFileURL(join(build, 'figuras', mod)).href + '?v=' + Date.now());
  const conteudo = gerarFig();
  if (/—/.test(conteudo)) throw new Error('travessão encontrado na figura ' + svgNome);
  writeFileSync(join(build, svgNome), conteudo);
  console.log('figura ', svgNome);
}

// 3. HTML
const r = montar({ doc, build, config });
if (r.travessao || r.meiaRisca) console.warn('AVISO: há travessão no texto. Reescreva com vírgula, dois-pontos ou parênteses.');
if (soHtml) process.exit(0);

// 4. PDF (Chrome de testes do Playwright, ou CHROME_PATH)
function acharChrome() {
  if (process.env.CHROME_PATH) return process.env.CHROME_PATH;
  const raiz = join(homedir(), 'Library', 'Caches', 'ms-playwright');
  if (!existsSync(raiz)) return undefined;
  for (const d of readdirSync(raiz).filter((x) => x.startsWith('chromium-')).sort().reverse()) {
    for (const plat of ['chrome-mac-arm64', 'chrome-mac']) {
      const p = join(raiz, d, plat, 'Google Chrome for Testing.app', 'Contents', 'MacOS', 'Google Chrome for Testing');
      if (existsSync(p)) return p;
    }
  }
  return undefined;
}
const executablePath = acharChrome();
const abrir = () => chromium.launch(executablePath ? { executablePath } : {});

async function imprimir(htmlPath, pdfPath) {
  const browser = await abrir();
  const page = await browser.newPage();
  await page.goto(pathToFileURL(htmlPath).href, { waitUntil: 'load' });
  await page.emulateMedia({ media: 'print' });
  await page.evaluate(async () => { await document.fonts.ready; await document.fonts.load('16px "Manrope Variable"', 'Ação'); });
  const faltando = await page.evaluate(() => [...document.fonts].filter((f) => f.status === 'error').map((f) => f.family));
  if (faltando.length) console.warn('AVISO: fontes que falharam:', faltando.join(', '));
  await page.pdf({ path: pdfPath, format: 'A4', printBackground: true, preferCSSPageSize: true });
  await browser.close();
}

// SVGs entram inline (herdam as fontes do estilo.css)
let html = readFileSync(join(build, 'documento.html'), 'utf8');
html = html.replace(/<!--#svg\s+([\w./-]+)\s*-->/g, (_, arq) => readFileSync(join(build, arq), 'utf8').replace(/^<\?xml[^>]*>\s*/, ''));
const expandido = join(build, '.documento.render.html');
writeFileSync(expandido, html);
const pdf = join(build, 'documento.pdf');
await imprimir(expandido, pdf);
unlinkSync(expandido);

// capa e contracapa sem margem (sangram até a borda), trocadas no PDF
const capasPdf = join(build, 'capas.pdf');
await imprimir(join(build, 'capas.html'), capasPdf);
const py = (codigo, ...a) => execFileSync('python3', ['-E', '-c', codigo, ...a]).toString().trim();
py(`
import sys
try:
    import pymupdf as fitz
except ImportError:
    import fitz
doc = fitz.open(sys.argv[1]); capas = fitz.open(sys.argv[2])
assert len(capas) == 2, f"capas.pdf com {len(capas)} páginas"
doc.delete_page(0); doc.insert_pdf(capas, from_page=0, to_page=0, start_at=0)
doc.delete_page(len(doc) - 1); doc.insert_pdf(capas, from_page=1, to_page=1)
doc.save(sys.argv[1] + '.tmp', garbage=3, deflate=True)
`, pdf, capasPdf);
renameSync(pdf + '.tmp', pdf);
unlinkSync(capasPdf);
const final = join(doc, config.arquivoPdf || `${basename(doc)}.pdf`);
copyFileSync(pdf, final);
console.log('PDF:', final);

// 5. prévias PNG por página + folhas de contato (para a revisão visual)
if (!semPng) {
  const dirPng = join(build, 'png');
  mkdirSync(dirPng, { recursive: true });
  const n = py(`
import sys, math
try:
    import pymupdf as fitz
except ImportError:
    import fitz
doc = fitz.open(sys.argv[1])
for i, p in enumerate(doc):
    p.get_pixmap(matrix=fitz.Matrix(1.6, 1.6)).save(f"{sys.argv[2]}/p{i+1:02d}.png")
try:
    from PIL import Image
    fs = [f"{sys.argv[2]}/p{i+1:02d}.png" for i in range(len(doc))]
    ims = [Image.open(f) for f in fs]
    w, h = ims[0].size; tw = 300; th = int(h * tw / w); cols = 7
    for k in range(0, len(ims), 21):
        lote = ims[k:k + 21]; rows = math.ceil(len(lote) / cols)
        folha = Image.new('RGB', (cols * tw + (cols + 1) * 8, rows * th + (rows + 1) * 8), '#888')
        for i, im in enumerate(lote):
            folha.paste(im.convert('RGB').resize((tw, th)), (8 + (i % cols) * (tw + 8), 8 + (i // cols) * (th + 8)))
        folha.save(f"{sys.argv[2]}/folha-{k // 21 + 1}.png")
except ImportError:
    pass
print(len(doc))
`, final, dirPng);
  console.log(`PNG: ${n} páginas em ${dirPng} (folha-N.png = visão geral para revisão)`);
}
