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

/* Destino com âncora precisa de `NE` (noescape) no Apache: sem ele o `#` vira `%23`
   e o visitante cai em /sobre%23reconhecimento, que é um 404. */
const flagsApache = (to) => (to.includes('#') ? '[R=301,NE,L]' : '[R=301,L]')

/* ── Netlify / prévias (public/_redirects) ─────────────────────────────────── */
const netlify = `# Endereços do site institucional antigo -> rotas novas.
# GERADO por scripts/generate-redirects.mjs a partir de src/content/legacyRedirects.ts.
# Não edite à mão: rode \`npm run redirects\`.
#
# ${regras.length} regras, cada uma com e sem barra final.

${regras.map((r) => `${r.from.padEnd(larg)}${r.to}  301\n${(r.from + '/').padEnd(larg)}${r.to}  301`).join('\n')}

# Os portais dos clientes (/portais/<cliente>) são rota do próprio site agora, resolvida
# pelo SPA a partir de src/content/portals.json — não precisam de reescrita própria.
# A regra abaixo já os cobre.

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

const regrasApache = regras.map((r) => `RewriteRule ^${esc(r.from.slice(1))}/?$ ${r.to} ${flagsApache(r.to)}`).join('\n')

writeFileSync(
  join(dir, 'apache.txt'),
  cabecalho('Apache (.htaccess)') +
    `# Só as regras 301. O arquivo COMPLETO, pronto para subir, é public/.htaccess.\n\n` +
    regrasApache +
    '\n',
)

/* O .htaccess inteiro, gerado junto com as regras para não divergir delas.
   Vai em public/ porque tudo ali é copiado para dist/ no build — assim o arquivo
   viaja com a entrega, em vez de depender de alguém lembrar de copiá-lo à parte.

   A ORDEM DENTRO DO ARQUIVO É O QUE FAZ ELE FUNCIONAR:
   HTTPS e www primeiro (senão as 301 abaixo redirecionam para o domínio errado),
   as 301 no meio, e o SPA fallback POR ÚLTIMO — ele captura tudo o que sobrou, e
   qualquer regra depois dele nunca roda. */
writeFileSync(
  resolve(root, 'public/.htaccess'),
  `# Natcorp — configuração do Apache/LiteSpeed para o site estático.
# GERADO por scripts/generate-redirects.mjs. Não edite à mão: rode \`npm run redirects\`.
#
# Este arquivo vai na RAIZ do site, ao lado do index.html. Ele é copiado
# automaticamente para dist/ no build, então já vem junto com a entrega.

RewriteEngine On

# ── 1. HTTPS e domínio canônico (www) ───────────────────────────────────
#    Precisa vir antes de tudo: se uma 301 rodar primeiro, ela leva o visitante
#    para o domínio errado e o navegador faz dois saltos em vez de um.
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://www.natcorp.com.br/$1 [R=301,L]
RewriteCond %{HTTP_HOST} ^natcorp\\.com\\.br$ [NC]
RewriteRule ^(.*)$ https://www.natcorp.com.br/$1 [R=301,L]

# ── 1b. Pastas guardadas como backup: no disco, fora do ar ──────────────
#    Renomear uma pasta no servidor NÃO a tira do ar: o Apache serve tudo
#    abaixo da raiz, então /portais_old/ continuaria público — com os
#    form-handler.php do site antigo dentro, sem manutenção, e com o
#    conteúdo legado rastreável pelo Google num endereço novo.
#    O ideal é guardar o backup FORA da raiz do site. Esta regra é a rede
#    para quando ele fica dentro, e vem antes do fallback, senão nunca roda.
#
#    Só o prefixo `portais`, de propósito. Uma regra genérica (qualquer pasta
#    terminada em _old) parecia mais segura e não é: ela engoliria
#    /solucao-de-rh-old, que é uma das 125 origens de redirect do site antigo
#    — o visitante levaria 403 no lugar do 301. Testado, não suposto.
RewriteRule ^portais[_-]?(old|antigo|antiga|backup|bkp|legado)(/|$) - [F,L]

# ── 2. Endereços do site antigo (${regras.length} regras) ────────────────────────────
#    Os ~90 artigos do blog antigo estavam na raiz, no padrão do WordPress.
#    Sem estas regras, cada um vira 404 no dia da virada e o Google descarta
#    a autoridade que levaram anos para juntar.
${regrasApache}

# ── 3. SPA fallback: SÓ quando não existe arquivo nem pasta ─────────────
#    POR ÚLTIMO, sempre. As duas condições são o que preserva a pasta
#    /portais/<cliente>/ migrada do servidor atual: sem elas o servidor
#    devolve a home para tudo, as ${regras.length > 0 ? '61' : '61'} páginas viram uma só e os clientes
#    perdem o acesso.
DirectoryIndex index.html
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ /index.html [L]

# ── 4. Tipos MIME ──────────────────────────────────────────────────────
#    Sem o woff2 declarado, o navegador recusa a fonte e o site cai em Arial.
AddType font/woff2 .woff2
AddType application/manifest+json .webmanifest
AddType image/svg+xml .svg
AddType image/webp .webp

# ── 5. Compressão ──────────────────────────────────────────────────────
#    Os dois guardas são necessários: o DEFLATE vem do mod_deflate, mas a diretiva
#    AddOutputFilterByType vem do mod_filter. Guardar só o primeiro derruba o Apache
#    num servidor que tenha deflate e não tenha filter.
<IfModule mod_deflate.c>
  <IfModule mod_filter.c>
    AddOutputFilterByType DEFLATE text/html text/css text/javascript \\
      application/javascript image/svg+xml application/json application/xml
  </IfModule>
</IfModule>

# ── 6. Cache ───────────────────────────────────────────────────────────
#    Um ano em .js e .css vale porque no nosso build todos têm hash no nome.
#    O index.html é \`no-cache\`: guardar, mas revalidar — é ele que aponta
#    para os arquivos da versão nova.
<IfModule mod_headers.c>
  <FilesMatch "\\.(js|css|woff2)$">
    Header set Cache-Control "public, max-age=31536000, immutable"
  </FilesMatch>
  <FilesMatch "\\.(png|jpe?g|webp|svg|ico)$">
    Header set Cache-Control "public, max-age=2592000"
  </FilesMatch>
  <FilesMatch "\\.(html|xml|txt|webmanifest)$">
    Header set Cache-Control "no-cache"
  </FilesMatch>

# ── 7. Segurança ───────────────────────────────────────────────────────
#    Ligar o HSTS só depois de confirmar que TODO o site responde em HTTPS:
#    com ele ligado, o navegador passa a recusar HTTP por um ano.
  Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
  Header always set X-Content-Type-Options "nosniff"
  Header always set Referrer-Policy "strict-origin-when-cross-origin"
  Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>
`,
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
