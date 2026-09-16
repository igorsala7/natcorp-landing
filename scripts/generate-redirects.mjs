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

# NÃO há catch-all de SPA aqui, de propósito.
#
# No Netlify o _redirects roda DEPOIS de procurar o arquivo estático, então um
# "/*  /index.html  200" no fim é inofensivo. No Cloudflare Pages a documentação
# diz o contrário — "redirects are always followed, regardless of whether or not
# an asset matches" — e relatos da comunidade dizem o oposto disso. Com 75
# páginas pré-renderizadas em jogo, apostar em qualquer das duas leituras é
# apostar o site inteiro.
#
# A saída não depende de quem está certo: sem catch-all, as páginas reais são
# servidas como arquivo, e o que não existe cai no 404.html, que é a casca do
# SPA. As rotas que só existem no cliente (a administração) carregam por ali.
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
const htaccess =
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

# ── 1a. Marcador de versão deste arquivo ────────────────────────────────
#    Responde, em UM pedido, "o .htaccess novo subiu?".
#
#    O arquivo começa com ponto e a maioria dos clientes de FTP não envia
#    arquivo oculto sem que se peça. Quando isso acontece, o site fica com o
#    HTML novo e as REGRAS velhas — e o sintoma (cache do CDN que não solta)
#    não diz qual dos dois está errado. Ficamos dois dias sem conseguir separar
#    as duas hipóteses, porque o único sinal do arquivo novo era justamente o
#    cabeçalho que não aparecia.
#
#    Agora é direto: abrir /__htaccess-2026-09-14__
#      403           = o arquivo novo está no servidor
#      a home do site = ainda é o antigo
#
#    A data no nome é o que faz o teste valer: muda a cada versão que importa,
#    então um 403 nunca vem de um arquivo antigo por engano.
RewriteRule ^__htaccess-2026-09-14__$ - [F,L]

#    E a cópia de nome visível nunca é servida: ela existe só para atravessar o
#    FTP, e publicar a configuração entrega de graça quais caminhos bloqueamos.
RewriteRule ^htaccess\\.txt$ - [F,L]

# ── 1b. Quadro de vagas: /jobs e /jobs_dev sem redirecionamento ─────────
#    Sem estas duas linhas, /jobs?company=... (sem barra) depende do
#    DirectorySlash do Apache, que responde 301 para /jobs/?company=... — e 301
#    é permanente: navegadores e CDN guardam, cada um por sua conta.
#
#    Isso já custou caro. Enquanto existiu uma 301 de /jobs para /sobre nesta
#    lista, os links de vaga clicados naquela janela ficaram PRESOS: mesmo
#    depois de o servidor ser corrigido, o CDN seguia entregando o 301 velho
#    para aquelas URLs exatas. Medido: vaga nova abre certo (MISS), a URL já
#    pedida continua caindo em /sobre (HIT).
#
#    Reescrita interna resolve de vez: o servidor ENTREGA o redirecionador em
#    /jobs, sem responder redirecionamento nenhum. Não há 301 para ninguém
#    guardar, e o candidato economiza uma ida e volta. A query string viaja
#    sozinha — reescrita interna não mexe nela.
RewriteRule ^jobs$ /jobs/index.html [L]
RewriteRule ^jobs_dev$ /jobs_dev/index.html [L]

# ── 1c. Pastas guardadas como backup: no disco, fora do ar ──────────────
#    Renomear uma pasta no servidor NÃO a tira do ar: o Apache serve tudo
#    abaixo da raiz, então /portais_old/ continuaria público — com os
#    form-handler.php do site antigo dentro, sem manutenção, e com o
#    conteúdo legado rastreável pelo Google num endereço novo.
#    O ideal é guardar o backup FORA da raiz do site. Esta regra é a rede
#    para quando ele fica dentro, e vem antes do fallback, senão nunca roda.
#
#    Só o prefixo "portais", de propósito. Uma regra genérica (qualquer pasta
#    terminada em _old) parecia mais segura e não é: ela engoliria
#    /solucao-de-rh-old, que é uma das 125 origens de redirect do site antigo
#    — o visitante levaria 403 no lugar do 301. Testado, não suposto.
RewriteRule ^portais[_-]?(old|antigo|antiga|backup|bkp|legado)(/|$) - [F,L]

# ── 2. Endereços do site antigo (${regras.length} regras) ────────────────────────────
#    Os ~90 artigos do blog antigo estavam na raiz, no padrão do WordPress.
#    Sem estas regras, cada um vira 404 no dia da virada e o Google descarta
#    a autoridade que levaram anos para juntar.
${regrasApache}

# ── 2b. Arquivo que não existe devolve 404 DE VERDADE ───────────────────
#    Sem isto, o fallback abaixo captura TAMBÉM os pedidos de imagem, CSS e PDF
#    — e um arquivo inexistente responde 200 com os 400 KB da home.
#
#    Descoberto em 16/09, quando uma assinatura de e-mail parou de aparecer:
#    /email/Assinatura-Carlos-Alberto.png devolvia text/html com 400.120 bytes.
#    O Outlook pede uma imagem, recebe uma página, e mostra ícone quebrado —
#    baixando 400 KB a cada abertura para isso.
#
#    Pior para a busca: o Google lê 200 OK em endereço que não existe. São
#    soft-404, que gastam orçamento de rastreamento e sujam o índice.
#
#    E pior para nós: arquivo faltando falha em SILÊNCIO, com cara de sucesso.
#    No caso da assinatura, isso me fez concluir errado duas vezes. Só depois
#    de medir \`NOC-CDN-CacheStatus: MISS\` ficou claro que a resposta vinha da
#    ORIGEM, e que era o LiteSpeed — não a CDN, não o nome do arquivo — que
#    não enxergava \`/app/html/email/\`, mesmo o \`ls\` do dono mostrando os
#    arquivos lá. Um 404 de verdade teria dito isso na primeira tentativa.
#
#    As duas primeiras condições preservam o que existe; a terceira limita a
#    regra a pedidos com extensão de arquivo — rota de SPA não tem extensão, e
#    por isso continua caindo no fallback.
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_URI} \\.(png|jpe?g|gif|webp|avif|svg|ico|bmp|css|js|mjs|map|json|woff2?|ttf|otf|eot|pdf|zip|rar|mp4|webm|mp3|wav|txt|xml|csv|doc|docx|xls|xlsx|ppt|pptx)$ [NC]
RewriteRule ^ - [R=404,L]

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
#    O HTML NÃO PODE SER GUARDADO. É ele que aponta para os arquivos da versão
#    nova: se o visitante recebe um index.html velho, ele pede os assets velhos
#    e o site fica congelado, por mais que o servidor já tenha o novo.
#
#    O bloco de mod_expires vem antes DE PROPÓSITO. Medido em produção em
#    13/09/2026 (LiteSpeed atrás do CDN da noc.org): o bloco mod_headers abaixo
#    é IGNORADO — nenhum Cache-Control chega ao navegador, nem forçando MISS no
#    CDN para falar direto com a origem. <IfModule> sem o módulo pula o bloco em
#    silêncio, sem erro no log; foi por isso que passou despercebido. Já
#    mod_expires responde: os .js e .svg de lá saem com max-age=86400 mais
#    Expires, que não vêm deste arquivo.
#
#    Os dois ficam: onde mod_headers existir ele é mais preciso (tem
#    "immutable"); onde não existir, mod_expires segura o que importa.
<IfModule mod_expires.c>
  ExpiresActive On
  ExpiresByType text/html "access plus 0 seconds"
  ExpiresByType application/xml "access plus 0 seconds"
  ExpiresByType text/xml "access plus 0 seconds"
  ExpiresByType text/plain "access plus 0 seconds"
  ExpiresByType application/json "access plus 0 seconds"
</IfModule>

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
#    ATENÇÃO: em 13/09/2026 este bloco NÃO estava valendo em produção. Só
#    X-Content-Type-Options chegava ao navegador, e provavelmente do próprio
#    servidor: o HSTS entregue vem SEM includeSubDomains (o daqui tem) e ainda
#    aparece um X-XSS-Protection que não existe neste arquivo. Referrer-Policy
#    e X-Frame-Options não chegam. Cabeçalho de resposta arbitrário só sai por
#    mod_headers — peça à hospedagem para habilitar.
#
#    Ligar o HSTS só depois de confirmar que TODO o site responde em HTTPS:
#    com ele ligado, o navegador passa a recusar HTTP por um ano.
  Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
  Header always set X-Content-Type-Options "nosniff"
  Header always set Referrer-Policy "strict-origin-when-cross-origin"
  Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>
`

writeFileSync(resolve(root, 'public/.htaccess'), htaccess)

/* A MESMA configuração, com um nome que o FTP não esconde.

   O arquivo de verdade começa com ponto, e a maioria dos clientes de FTP não
   envia arquivo oculto sem que se peça. Foi o que deixou o servidor rodando
   com as regras de um dia e o HTML de outro por dois dias, com um sintoma
   (cache que não solta) que não dizia qual dos dois estava velho.

   Sobe-se esta cópia, renomeia-se para .htaccess no painel e apaga-se ela. A
   regra da seção 1a garante que, enquanto estiver lá, ninguém a leia pelo
   navegador: publicar a configuração entrega de graça o que está bloqueado. */
writeFileSync(resolve(root, 'public/htaccess.txt'), htaccess)

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
/* O _headers do Cloudflare Pages: é ele o motivo da mudança de hospedagem.
   Na hospedagem anterior, medido, o .htaccess só executava mod_rewrite — nem
   mod_headers nem mod_expires produziam cabeçalho algum. Sem Cache-Control, o
   CDN guardava o HTML por conta própria e publicação nova não chegava ao
   visitante. Aqui cabeçalho é um arquivo, não um módulo que pode faltar.

   A ORDEM VAI DO GERAL PARA O ESPECÍFICO. Se a sobreposição não valer nesta
   plataforma, o pior caso é o asset revalidar à toa — custo de um 304, não de
   uma página errada. O contrário, HTML em cache, é o bug que nos trouxe aqui. */
const headers = `# Cabeçalhos servidos pelo Cloudflare Pages.
# GERADO por scripts/generate-redirects.mjs. Não edite à mão.

/*
  Cache-Control: no-cache
  X-Content-Type-Options: nosniff
  X-Frame-Options: SAMEORIGIN
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: geolocation=(), microphone=(), camera=()
  Strict-Transport-Security: max-age=31536000; includeSubDomains

# Tudo aqui tem hash no nome: conteúdo novo, nome novo. Um ano, sem revalidar.
/assets/*
  Cache-Control: public, max-age=31536000, immutable
`
writeFileSync(resolve(root, 'public/_headers'), headers)
console.log(`redirects:   public/_headers (Cloudflare Pages)`)
console.log(`redirects:   public/_redirects (Netlify/prévias)`)
console.log(`redirects:   vercel.json`)
console.log(`redirects:   redirects/apache.txt, nginx.conf, iis.xml`)
console.log(`redirects:   redirects/republicar.md — ${republicar.length} artigos a republicar`)
