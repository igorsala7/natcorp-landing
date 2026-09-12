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
const portais = ler('src/content/portals.json').clients

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
  '/implantacao',
  '/jornada-da-contratacao',
  ...modulos.map((m) => `/modulos/${m.slug}`),
  '/segmentos',
  ...segmentos.map((s) => `/segmentos/${s.slug}`),
  /* As páginas de acesso dos clientes, em produção e homologação.
  
     FORA do sitemap de propósito — são tela de entrada de cliente, não conteúdo
     para buscar — e a própria página já declara noindex quando é homologação ou
     quando não é a Natcorp. Mesmo assim precisam de HTML próprio: eram as ÚNICAS
     rotas do site sem arquivo, e o fallback entregava a home pré-renderizada.
     O cliente abria o endereço do portal dele e via 400 KB da home comercial da
     Natcorp até o React trocar — na primeira visita, com os chunks frios, isso
     dura o suficiente para a pessoa concluir que não funcionou. */
  ...portais.map((c) => `/portais/${c.slug}`),
  ...portais.map((c) => `/portais/dev/${c.slug}`),
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

/* Teto de tempo por rota.
   Sem ele, um Chrome que sobe e não responde deixa o `await` pendurado para
   sempre: o build fica vivo, sem processo filho, sem erro e sem fim — aconteceu
   aqui, parado na rota 54 de 61 por 40 minutos. 45s é folga generosa para uma
   página que leva ~2s; `SIGKILL` porque um Chrome travado ignora o TERM. */
const TIMEOUT_MS = 45_000

function renderizar(rota) {
  // --dump-dom serializa o DOM já renderizado. O orçamento de tempo virtual
  // faz o Chrome avançar os temporizadores sem esperar em tempo real.
  return execFileAsync(
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
    { maxBuffer: 64 * 1024 * 1024, timeout: TIMEOUT_MS, killSignal: 'SIGKILL' },
  )
}

for (const rota of rotas) {
  try {
    let stdout
    /* Uma segunda chance: o estouro de tempo costuma ser um Chrome que não subiu,
       não uma página que não renderiza. Duas falhas seguidas já são a página. */
    try {
      ;({ stdout } = await renderizar(rota))
    } catch (e) {
      if (e.killed || e.signal) {
        console.error(`prerender: ${rota} estourou ${TIMEOUT_MS / 1000}s — tentando de novo`)
        ;({ stdout } = await renderizar(rota))
      } else throw e
    }
    if (!stdout.includes('<title>') || stdout.length < 2000) throw new Error('DOM vazio ou sem título')

    /* Tira o endereço do servidor de build de dentro do HTML.

       O helper de preload do Vite injeta <link rel="modulepreload"> para os chunks
       das rotas lazy e resolve o caminho com `new URL(dep, import.meta.url).href`, que
       devolve a URL ABSOLUTA — com a origem http://127.0.0.1:<porta> desta build.
       O --dump-dom serializa isso, e o endereço da máquina de build ia parar no
       servidor: 1141 links em 61 páginas, todos apontando para o nada.

       O efeito era intermitente, que é o pior tipo. O preload falhava, o navegador
       repetia o pedido pelo caminho certo e às vezes chegava a tempo; quando não
       chegava, o import() da rota rejeitava e o React renderizava o NotFoundPage.
       A mesma URL abria ou dava "página não encontrada" conforme a corrida. E como
       a porta é sorteada a cada build, o sintoma mudava sem o código mudar. */
    const limpo = stdout.split(base).join('')

    const destino = rota === '/' ? join(dist, 'index.html') : join(dist, rota, 'index.html')
    mkdirSync(resolve(destino, '..'), { recursive: true })
    writeFileSync(destino, `<!doctype html>\n${limpo.trim()}\n`)
    feitas += 1
  } catch (e) {
    falhas += 1
    console.error(`prerender: falhou em ${rota} — ${e.message}`)
  }
}

servidor.close()

/* Rede de segurança para o caso acima: se um `http://127.0.0.1:` escapar por um
   caminho que eu não previ, é melhor o build morrer aqui do que o site publicar
   61 páginas que pedem recursos à máquina do visitante. */
const vazados = rotas
  .map((r) => (r === '/' ? join(dist, 'index.html') : join(dist, r, 'index.html')))
  .filter((f) => existsSync(f) && readFileSync(f, 'utf8').includes('http://127.0.0.1:'))
if (vazados.length) {
  console.error(`prerender: ${vazados.length} páginas ainda citam o servidor de build — ${vazados[0]}`)
  process.exit(1)
}

console.log(`prerender: ${feitas} rotas geradas${falhas ? `, ${falhas} falharam` : ''}`)
console.log('prerender: a hospedagem precisa resolver <caminho>/index.html antes do index da raiz')
console.log('prerender:   nginx   try_files $uri $uri/index.html /index.html;')
console.log('prerender:   Apache  DirectoryIndex index.html + RewriteCond -f antes do fallback')
console.log('prerender: `vite preview` NÃO faz isso e sempre devolve a home — não use para conferir')
/* Falhar o build é melhor que publicar um site meio pré-renderizado, onde
   algumas páginas teriam o head certo e outras não — e ninguém perceberia. */
if (falhas) process.exit(1)
