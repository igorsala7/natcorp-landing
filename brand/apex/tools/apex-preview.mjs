// Servidor de pré-visualização das páginas APEX salvas.
//
// As páginas salvas do APEX referenciam caminhos que não existem na pasta
// (`/i/app_ui/css/Core.min.css`, `natcorp/r/files/static/v986/Natcorp_Style_Min.css`),
// porque os assets foram gravados todos no mesmo nível. Este servidor resolve qualquer
// requisição pelo NOME DO ARQUIVO, então cada página renderiza com o tema real,
// as fontes reais e o JavaScript real.
//
// Ele também troca a folha Natcorp em tempo de requisição, o que dá o laço de
// comparação: um servidor com o CSS de produção (ANTES) e outro com o candidato (DEPOIS),
// em portas diferentes, mostrando a mesma página.
//
//   node brand/apex/tools/apex-preview.mjs --port 8801
//   node brand/apex/tools/apex-preview.mjs --port 8802 --css brand/apex/Natcorp_Style_V2.css
//
// Opções:
//   --root <pasta>  pasta com as páginas salvas (padrão: "brand/apex/APEX Style/APEX")
//   --port <n>      porta (padrão 8801)
//   --css <arquivo> substitui Natcorp_Style_Min.css por este arquivo (padrão: o original)
//   --quiet         não registra requisições
//
// Abra http://localhost:8801/ para o índice das páginas disponíveis.
//
// NÃO é mais necessário para medir o candidato sobre o APEX ao vivo: o Playwright
// lê a folha do disco e injeta direto (ver trabalho/publicacao.md). Este servidor
// continua útil só para abrir as páginas SALVAS offline. Ele também servia os
// woff2 da Manrope pelo nome do arquivo — o que mascarou, por quase toda a
// sessão, o fato de que as fontes NÃO estão publicadas no ambiente real.

import { createServer } from 'node:http'
import { readdirSync, readFileSync, statSync, existsSync } from 'node:fs'
import { extname, join, basename, resolve } from 'node:path'

const args = process.argv.slice(2)
const opt = (name, fallback) => {
  const i = args.indexOf(`--${name}`)
  return i >= 0 && args[i + 1] ? args[i + 1] : fallback
}
const flag = (name) => args.includes(`--${name}`)

const root = resolve(opt('root', 'brand/apex/APEX Style/APEX'))
const port = Number(opt('port', '8801'))
const cssOverride = opt('css', '')
const cssPath = cssOverride ? resolve(cssOverride) : ''
const quiet = flag('quiet')

if (!existsSync(root)) {
  console.error(`Pasta não encontrada: ${root}`)
  process.exit(1)
}
if (cssPath && !existsSync(cssPath)) {
  console.error(`CSS não encontrado: ${cssPath}`)
  process.exit(1)
}

// Índice nome-do-arquivo -> caminho real, montado uma vez. Nomes repetidos em
// subpastas ficam com a primeira ocorrência no nível mais raso.
const index = new Map()
const walk = (dir, depth = 0) => {
  if (depth > 3) return
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    if (entry.name.startsWith('.')) continue
    const full = join(dir, entry.name)
    if (entry.isDirectory()) walk(full, depth + 1)
    else if (!index.has(entry.name)) index.set(entry.name, full)
  }
}
walk(root)

const TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.eot': 'application/vnd.ms-fontobject',
}

const pages = [...index.keys()].filter((n) => n.endsWith('.html')).sort()

const homePage = () => `<!doctype html><meta charset="utf-8">
<title>Páginas APEX — ${cssPath ? 'DEPOIS' : 'ANTES'}</title>
<style>
  body{font:14px/1.6 ui-sans-serif,system-ui,sans-serif;margin:0;padding:32px 40px;background:#F4F2F7;color:#1B1238}
  h1{font-size:20px;letter-spacing:-.02em;margin:0 0 4px}
  p{color:#4A4460;margin:0 0 24px}
  code{background:#E9E5F1;padding:2px 6px;border-radius:5px;font-size:12px}
  ul{list-style:none;padding:0;margin:0;display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:8px}
  a{display:block;padding:10px 14px;background:#fff;border:1px solid #E9E5F1;border-radius:10px;
    text-decoration:none;color:#511C76;font-weight:600}
  a:hover{border-color:#511C76}
</style>
<h1>Páginas APEX salvas — ${cssPath ? 'DEPOIS (candidato)' : 'ANTES (produção)'}</h1>
<p>Folha Natcorp servida: <code>${cssPath ? cssPath : 'Natcorp_Style_Min.css (original)'}</code></p>
<ul>${pages.map((p) => `<li><a href="/${p}">${p.replace('.html', '')}</a></li>`).join('')}</ul>`

createServer((req, res) => {
  const url = new URL(req.url, `http://localhost:${port}`)
  const name = basename(decodeURIComponent(url.pathname))

  if (!name || url.pathname === '/') {
    res.writeHead(200, { 'content-type': TYPES['.html'] })
    return res.end(homePage())
  }

  // A troca que dá sentido ao servidor: a folha Natcorp vem do candidato.
  // `#WORKSPACE_IMAGES#` só é resolvido pelo próprio APEX; aqui vira a raiz,
  // e o servidor acha o arquivo pelo nome (as fontes ficam em brand/apex/fonts).
  if (cssPath && name === 'Natcorp_Style_Min.css') {
    if (!quiet) console.log(`  ${name} -> ${cssPath}`)
    const css = readFileSync(cssPath, 'utf8').replaceAll('#WORKSPACE_IMAGES#', '/')
    res.writeHead(200, {
      'content-type': TYPES['.css'],
      'cache-control': 'no-store',
      // permite buscar a folha de dentro do APEX real, para testar o candidato
      // sobre o ambiente de homologação sem publicar nada
      'access-control-allow-origin': '*',
    })
    return res.end(css)
  }

  const file = index.get(name)
  if (!file || !statSync(file).isFile()) {
    if (!quiet) console.log(`  404 ${url.pathname}`)
    res.writeHead(404, { 'content-type': 'text/plain; charset=utf-8' })
    return res.end(`não encontrado: ${name}`)
  }

  if (!quiet) console.log(`  200 ${name}`)
  res.writeHead(200, {
    'content-type': TYPES[extname(name).toLowerCase()] ?? 'application/octet-stream',
    'cache-control': 'no-store',
    'access-control-allow-origin': '*',
  })
  res.end(readFileSync(file))
}).listen(port, () => {
  console.log(`${cssPath ? 'DEPOIS' : 'ANTES '} → http://localhost:${port}/  (${pages.length} páginas, ${index.size} arquivos)`)
  if (cssPath) console.log(`         folha: ${cssPath}`)
})
