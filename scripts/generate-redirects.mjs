// Gera as regras de redirecionamento 301 a partir de src/content/legacyRedirects.ts.
//
// POR QUE ISTO EXISTE
//
// As mesmas ~130 regras precisam existir em cinco formatos: Netlify (_redirects),
// Vercel (vercel.json), Apache, Nginx e IIS. Manter cinco listas à mão é garantir
// que uma delas fique para trás — e um redirecionamento que falta só aparece
// quando o cliente já clicou e viu o 404.
//
// A fonte é uma só: o arquivo legacyRedirects.ts. Tudo aqui é derivado dele.
//
// COM E SEM BARRA FINAL
//
// Os endereços do WordPress terminam com barra (`/artigo/`), mas os links de
// terceiros e os favoritos aparecem das duas formas. Cada formato abaixo trata as
// duas: no Apache e no Nginx com `/?$` no padrão; no Netlify e no Vercel duplicando
// a regra, porque eles casam caminho literal.
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs'
import { resolve, join } from 'node:path'

const root = resolve(import.meta.dirname, '..')

/* O arquivo-fonte é TypeScript e o Node não o importa direto. As entradas são
   objetos de uma linha só, num formato fixo — extrair por padrão é confiável e
   evita acrescentar um passo de compilação só para ler uma lista. */
const fonte = readFileSync(resolve(root, 'src/content/legacyRedirects.ts'), 'utf8')
const regras = [...fonte.matchAll(/\{\s*from:\s*'([^']+)',\s*to:\s*'([^']+)'(,\s*republicar:\s*true)?\s*\}/g)].map((m) => ({
  from: m[1],
  to: m[2],
  republicar: Boolean(m[3]),
}))

if (regras.length < 100) {
  console.error(`generate-redirects: só ${regras.length} regras lidas — o formato do arquivo-fonte mudou?`)
  process.exit(1)
}

/* Duas regras não podem sair do mesmo endereço: a segunda seria ignorada em
   silêncio, e o endereço iria parar no lugar errado. */
const vistos = new Set()
const duplicados = regras.filter((r) => (vistos.has(r.from) ? true : (vistos.add(r.from), false)))
if (duplicados.length) {
  console.error(`generate-redirects: origem duplicada — ${duplicados.map((d) => d.from).join(', ')}`)
  process.exit(1)
}

/* Um destino que não existe é pior que o 404 que ele substitui: o visitante passa
   por um redirecionamento para cair na página de erro, e o Google trata como
   soft-404. Os destinos são conferidos contra as rotas reais do sitemap. */
const rotas = new Set(
  [...readFileSync(resolve(root, 'public/sitemap.xml'), 'utf8').matchAll(/<loc>([^<]+)<\/loc>/g)].map((m) =>
    new URL(m[1]).pathname.replace(/\/$/, ''),
  ),
)
rotas.add('') // a raiz, que no sitemap é '/'
const quebrados = regras.filter((r) => !rotas.has(r.to.split('#')[0].replace(/\/$/, '')))
if (quebrados.length) {
  console.error(`generate-redirects: destino inexistente — ${quebrados.map((d) => `${d.from} -> ${d.to}`).join(', ')}`)
  process.exit(1)
}

const esc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
const larg = Math.max(...regras.map((r) => r.from.length)) + 2

/* ── Netlify / prévias (public/_redirects) ─────────────────────────────────── */
const netlify = `# Endereços do site institucional antigo -> rotas novas.
# GERADO por scripts/generate-redirects.mjs a partir de src/content/legacyRedirects.ts.
# Não edite à mão: rode \`npm run redirects\`.
#
# ${regras.length} regras, cada uma com e sem barra final.

${regras.map((r) => `${r.from.padEnd(larg)}${r.to}  301\n${(r.from + '/').padEnd(larg)}${r.to}  301`).join('\n')}

# Acesso aos portais dos clientes.
#
# Em PRODUÇÃO (www.natcorp.com.br) o prefixo /portais/ é servido pelo servidor antigo, que continua no
# ar — nada disto vale lá, porque este arquivo é da Vercel/Netlify. Aqui, nas prévias, a pasta antiga não
# existe: sem esta regra o link do rodapé cairia no 404. É reescrita (200) e não redirecionamento, para o
# endereço na barra continuar sendo o que a pessoa clicou.
#
# /portais sozinho NÃO entra: é a página de marketing "Portais e autoatendimento", do próprio site.
/portais/*  /portais_beta/:splat  200

# SPA: qualquer outro caminho devolve o index.html
/*    /index.html   200
`
writeFileSync(resolve(root, 'public/_redirects'), netlify)

/* ── Vercel (vercel.json) ──────────────────────────────────────────────────── */
const vercelPath = resolve(root, 'vercel.json')
const vercel = JSON.parse(readFileSync(vercelPath, 'utf8'))
vercel.redirects = regras.map((r) => ({ source: r.from, destination: r.to, permanent: true }))
writeFileSync(vercelPath, JSON.stringify(vercel, null, 2) + '\n')

/* ── Blocos para a empresa de hospedagem ───────────────────────────────────── */
const dir = resolve(root, 'redirects')
mkdirSync(dir, { recursive: true })

const cabecalho = (fmt) =>
  `# ${regras.length} redirecionamentos 301 do site antigo para o novo — formato ${fmt}.\n` +
  `# GERADO por scripts/generate-redirects.mjs. Não edite à mão.\n` +
  `# Cada regra vale com e sem barra final.\n`

writeFileSync(
  join(dir, 'apache.txt'),
  cabecalho('Apache (.htaccess)') +
    `# Cole DEPOIS do bloco de HTTPS/www e ANTES do SPA fallback.\n\n` +
    regras.map((r) => `RewriteRule ^${esc(r.from.slice(1))}/?$ ${r.to} [R=301,L]`).join('\n') +
    '\n',
)

writeFileSync(
  join(dir, 'nginx.conf'),
  cabecalho('Nginx').replace(/^#/gm, '#') +
    `# Cole dentro do bloco server{}, ANTES do location / que faz o try_files.\n\n` +
    regras.map((r) => `rewrite ^${esc(r.from)}/?$ ${r.to} permanent;`).join('\n') +
    '\n',
)

writeFileSync(
  join(dir, 'iis.xml'),
  `<!-- ${regras.length} redirecionamentos 301 do site antigo para o novo — formato IIS (web.config).\n` +
    `     GERADO por scripts/generate-redirects.mjs. Não edite à mão.\n` +
    `     Cole dentro de <rules>, ANTES da regra de SPA fallback. -->\n` +
    regras
      .map(
        (r, i) =>
          `<rule name="legacy-${String(i + 1).padStart(3, '0')}" stopProcessing="true">\n` +
          `  <match url="^${esc(r.from.slice(1))}/?$" />\n` +
          `  <action type="Redirect" url="${r.to}" redirectType="Permanent" />\n` +
          `</rule>`,
      )
      .join('\n') +
    '\n',
)

const republicar = regras.filter((r) => r.republicar)
writeFileSync(
  join(dir, 'republicar.md'),
  `# Artigos que valem republicação\n\n` +
    `Estes ${republicar.length} endereços atendem buscas informativas que nenhuma página do site novo cobre.\n` +
    `O 301 temático segura o valor deles por ora. Ao republicar cada artigo, troque o destino em\n` +
    `\`src/content/legacyRedirects.ts\` para o endereço novo e rode \`npm run redirects\`.\n\n` +
    republicar.map((r) => `- \`${r.from}\` → hoje aponta para \`${r.to}\``).join('\n') +
    '\n',
)

console.log(`redirects: ${regras.length} regras geradas`)
console.log(`redirects:   public/_redirects (Netlify/prévias)`)
console.log(`redirects:   vercel.json`)
console.log(`redirects:   redirects/apache.txt, nginx.conf, iis.xml`)
console.log(`redirects:   redirects/republicar.md — ${republicar.length} artigos a republicar`)
