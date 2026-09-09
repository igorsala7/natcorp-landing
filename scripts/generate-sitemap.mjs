// Gera public/sitemap.xml e public/robots.txt a partir dos registros de módulos, segmentos e estruturas.
import { readFileSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const root = resolve(import.meta.dirname, '..')
const siteUrl = (process.env.VITE_SITE_URL || 'https://www.natcorp.com.br').replace(/\/$/, '')
const registry = JSON.parse(readFileSync(resolve(root, 'src/content/modulePages/registry.json'), 'utf8'))
const segments = JSON.parse(readFileSync(resolve(root, 'src/content/segments/registry.json'), 'utf8'))
const structures = JSON.parse(readFileSync(resolve(root, 'src/content/structures/registry.json'), 'utf8'))
const today = new Date().toISOString().slice(0, 10)

const urls = [
  { loc: '/', priority: '1.0', changefreq: 'weekly' },
  { loc: '/sistema', priority: '0.9', changefreq: 'weekly' },
  { loc: '/modulos', priority: '0.9', changefreq: 'weekly' },
  { loc: '/seguranca', priority: '0.7', changefreq: 'monthly' },
  { loc: '/sobre', priority: '0.7', changefreq: 'monthly' },
  { loc: '/contato', priority: '0.8', changefreq: 'monthly' },
  { loc: '/portais', priority: '0.8', changefreq: 'monthly' },
  // As páginas de acesso dos clientes (/portais_beta/<slug>/) ficam FORA do sitemap e saem com
  // `noindex`: o endereço em uso é o do servidor antigo (/portais/<slug>/), e indexar as duas
  // criaria conteúdo duplicado. Voltam para cá quando a virada acontecer.
  { loc: '/estruturas', priority: '0.9', changefreq: 'monthly' },
  ...structures.map((s) => ({ loc: `/estruturas/${s.slug}`, priority: '0.8', changefreq: 'monthly' })),
  { loc: '/perguntas-frequentes', priority: '0.7', changefreq: 'monthly' },
  { loc: '/privacidade', priority: '0.3', changefreq: 'yearly' },
  { loc: '/termos-de-uso', priority: '0.3', changefreq: 'yearly' },
  { loc: '/politica-de-cookies', priority: '0.3', changefreq: 'yearly' },
  { loc: '/modelo-comercial', priority: '0.8', changefreq: 'monthly' },
  { loc: '/implantacao', priority: '0.8', changefreq: 'monthly' },
  { loc: '/jornada-da-contratacao', priority: '0.8', changefreq: 'monthly' },
  ...registry.map((m) => ({ loc: `/modulos/${m.slug}`, priority: '0.8', changefreq: 'monthly' })),
  { loc: '/segmentos', priority: '0.9', changefreq: 'monthly' },
  ...segments.map((s) => ({ loc: `/segmentos/${s.slug}`, priority: '0.8', changefreq: 'monthly' })),
]

const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls
  .map(
    (u) => `  <url>
    <loc>${siteUrl}${u.loc}</loc>
    <lastmod>${today}</lastmod>
    <changefreq>${u.changefreq}</changefreq>
    <priority>${u.priority}</priority>
  </url>`,
  )
  .join('\n')}
</urlset>
`

writeFileSync(resolve(root, 'public/sitemap.xml'), xml)
writeFileSync(resolve(root, 'public/robots.txt'), `User-agent: *\nAllow: /\n\nSitemap: ${siteUrl}/sitemap.xml\n`)
console.log(`sitemap: ${urls.length} URLs (${siteUrl})`)
