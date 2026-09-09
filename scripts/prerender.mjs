// Pré-renderiza cada rota do sitemap para HTML estático em dist/<rota>/index.html.
//
// POR QUE ISTO EXISTE
//
// O site é uma SPA: o index.html entrega `<div id="root"></div>` e o React
// preenche depois. O `useSeo` corrige título, descrição, canonical e Open Graph
// — mas só DEPOIS que o JavaScript roda. Quem não executa JS lê o HTML cru e vai
// embora com o que estava lá: sempre a home.
//
// Isso quebra dois canais que importam para venda B2B:
//
//   1. Prévia de link. LinkedIn, WhatsApp, Slack e Teams não executam JS. Um
//      link para /modulos/folha-de-pagamento aparecia como "Natcorp — Todo o RH
//      em um único sistema", com a imagem da home. As 57 URLs se anunciavam
//      como a mesma página.
//   2. Rastreadores sem renderização. Bing e os rastreadores de IA leem HTML.
//      Viam 57 páginas vazias.
//
// O Google renderiza, mas em segunda onda, com atraso e com risco: qualquer
// erro de JS ou timeout indexa a página vazia. E o LCP é pior quando o conteúdo
// depende de JS, o que conta em Core Web Vitals.
//
// COMO FUNCIONA
//
// Não duplicamos os textos de SEO aqui. Cada página já os declara no `useSeo`, e
// deixar duas fontes de verdade seria garantir que uma envelhecesse. Em vez
// disso, o próprio app renderiza: subimos um servidor estático sobre o dist/,
// abrimos cada rota no Chrome sem interface e salvamos o DOM já pronto. O HTML
// resultante tem o `<head>` correto E o conteúdo no corpo.
//
// O arquivo salvo continua sendo a mesma aplicação: ao abrir, o React assume o
// controle normalmente. Muda só o que o primeiro pedido entrega.
import { createServer } from 'node:http'
import { execFile } from 'node:child_process'
import { mkdirSync, readFileSync, writeFileSync, existsSync, statSync } from 'node:fs'
import { extname, join, resolve } from 'node:path'
import { promisify } from 'node:util'

const execFileAsync = promisify(execFile)
const root = resolve(import.meta.dirname, '..')
const dist = resolve(root, 'dist')

if (!existsSync(join(dist, 'index.html'))) {
  console.error('prerender: dist/index.html não existe. Rode o build antes.')
  process.exit(1)
}

/* As rotas são as mesmas do sitemap, lidas dos mesmos registros — uma fonte só. */
const ler = (p) => JSON.parse(readFileSync(resolve(root, p), 'utf8'))
const modulos = ler('src/content/modulePages/registry.json')
const segmentos = ler('src/content/segments/registry.json')
const estruturas = ler('src/content/structures/registry.json')

const rotas = [
  '/',
  '/sistema',
  '/modulos',
  '/seguranca',
  '/sobre',
  '/contato',
  '/portais',
  '/estruturas',
  ...estruturas.map((s) => `/estruturas/${s.slug}`),
  '/perguntas-frequentes',
  '/privacidade',
  '/termos-de-uso',
  '/politica-de-cookies',
  '/modelo-comercial',
  '/jornada-da-contratacao',
  ...modulos.map((m) => `/modulos/${m.slug}`),
  '/segmentos',
  ...segmentos.map((s) => `/segmentos/${s.slug}`),
]

const TIPOS = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.webp': 'image/webp',
  '.woff2': 'font/woff2',
  '.xml': 'application/xml',
  '.txt': 'text/plain',
}

/* Servidor estático com a MESMA resolução que a hospedagem precisa ter:
   o arquivo pedido, senão <caminho>/index.html, senão o index da raiz.
   É o `try_files $uri $uri/index.html /index.html` do nginx.

   A ordem importa. Pular o passo do meio faz o servidor devolver sempre o index
   da raiz e as páginas pré-renderizadas nunca chegam ao visitante — foi
   exatamente o que o `vite preview` fez quando testei, e por isso ele não serve
   para conferir este build. */
function resolverArquivo(caminho) {
  const tentativas = [join(dist, caminho), join(dist, caminho, 'index.html'), join(dist, 'index.html')]
  return tentativas.find((t) => existsSync(t) && statSync(t).isFile())
}

function subirServidor() {
  return new Promise((ok) => {
    const s = createServer((req, res) => {
      const caminho = decodeURIComponent(new URL(req.url, 'http://x').pathname)
      const arquivo = resolverArquivo(caminho)
      const tipo = TIPOS[extname(arquivo)] ?? 'application/octet-stream'
      res.writeHead(200, { 'Content-Type': tipo })
      res.end(readFileSync(arquivo))
    })
    s.listen(0, '127.0.0.1', () => ok({ servidor: s, porta: s.address().port }))
  })
}

const CHROMES = [
  process.env.CHROME_PATH,
  '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
  '/Applications/Chromium.app/Contents/MacOS/Chromium',
  '/usr/bin/google-chrome',
  '/usr/bin/chromium',
  '/usr/bin/chromium-browser',
].filter(Boolean)

const chrome = CHROMES.find((c) => existsSync(c))
if (!chrome) {
  console.error('prerender: Chrome não encontrado. Defina CHROME_PATH.')
  process.exit(1)
}

const { servidor, porta } = await subirServidor()
const base = `http://127.0.0.1:${porta}`
let feitas = 0
let falhas = 0

for (const rota of rotas) {
  try {
    // --dump-dom serializa o DOM já renderizado. O orçamento de tempo virtual
    // faz o Chrome avançar os temporizadores sem esperar em tempo real.
    const { stdout } = await execFileAsync(
      chrome,
      [
        '--headless',
        '--disable-gpu',
        '--no-sandbox',
        '--hide-scrollbars',
        '--virtual-time-budget=8000',
        '--dump-dom',
        `${base}${rota}`,
      ],
      { maxBuffer: 64 * 1024 * 1024 },
    )
    if (!stdout.includes('<title>') || stdout.length < 2000) throw new Error('DOM vazio ou sem título')

    const destino = rota === '/' ? join(dist, 'index.html') : join(dist, rota, 'index.html')
    mkdirSync(resolve(destino, '..'), { recursive: true })
    writeFileSync(destino, `<!doctype html>\n${stdout.trim()}\n`)
    feitas += 1
  } catch (e) {
    falhas += 1
    console.error(`prerender: falhou em ${rota} — ${e.message}`)
  }
}

servidor.close()
console.log(`prerender: ${feitas} rotas geradas${falhas ? `, ${falhas} falharam` : ''}`)
console.log('prerender: a hospedagem precisa resolver <caminho>/index.html antes do index da raiz')
console.log('prerender:   nginx   try_files $uri $uri/index.html /index.html;')
console.log('prerender:   Apache  DirectoryIndex index.html + RewriteCond -f antes do fallback')
console.log('prerender: `vite preview` NÃO faz isso e sempre devolve a home — não use para conferir')
/* Falhar o build é melhor que publicar um site meio pré-renderizado, onde
   algumas páginas teriam o head certo e outras não — e ninguém perceberia. */
if (falhas) process.exit(1)
