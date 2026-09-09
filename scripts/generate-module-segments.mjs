// Gera src/content/modulePages/segments.json — em quais segmentos cada módulo mais pesa.
//
// POR QUE ISTO EXISTE
//
// O grafo de links do site estava completo em todas as direções, menos uma: das 31
// páginas de módulo, NENHUMA linkava para uma página de segmento. Por causa disso as
// 9 páginas de segmento eram as menos alimentadas do site (3 a 4 links cada, contra
// 20 a 32 das de módulo) — e são elas que carregam os termos de maior intenção, como
// "sistema de RH para indústria" e "RH para hospitais".
//
// POR QUE GERADO, E NÃO ESCRITO À MÃO
//
// A relação já existe e já é curada, só que na direção contrária: cada página de
// segmento declara `spotlight` (os módulos que mais pesam ali) e `answers[].modules`
// (os módulos que resolvem cada dor). Escrever um segundo mapa à mão seria criar uma
// fonte paralela para o mesmo fato — e garantir que uma das duas envelhecesse.
//
// Aqui a relação é apenas INVERTIDA. Quem manda continua sendo a página do segmento:
// ao mudar o `spotlight` de um segmento, o link aparece ou some da página do módulo
// no build seguinte, sem ninguém precisar lembrar.
//
// A ORDEM
//
// `spotlight` primeiro, porque é a lista curta e deliberada de cada segmento; depois
// `answers`, que é mais larga. Máximo de 4 por módulo — o bloco é um empurrão lateral,
// não um índice.
import { readFileSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const root = resolve(import.meta.dirname, '..')
const LIMITE = 4

const segRegistry = JSON.parse(readFileSync(resolve(root, 'src/content/segments/registry.json'), 'utf8'))
const modRegistry = JSON.parse(readFileSync(resolve(root, 'src/content/modulePages/registry.json'), 'utf8'))
const slugsValidos = new Set(modRegistry.map((m) => m.slug))

const porSpotlight = {}
const porResposta = {}
const desconhecidos = new Set()

for (const seg of segRegistry) {
  const src = readFileSync(resolve(root, `src/content/segments/${seg.slug}.ts`), 'utf8')

  const spot = src.match(/spotlight:\s*\[([^\]]*)\]/)
  if (spot) {
    for (const m of spot[1].matchAll(/'([^']+)'/g)) {
      if (!slugsValidos.has(m[1])) { desconhecidos.add(`${seg.slug} → ${m[1]}`); continue }
      ;(porSpotlight[m[1]] ??= []).push(seg.slug)
    }
  }

  /* `answers` fica entre a chave `answers:` e a próxima chave de topo, `moduleNotes`. */
  const ini = src.indexOf('answers:')
  const fim = src.indexOf('moduleNotes')
  const bloco = src.slice(ini, fim > ini ? fim : src.length)
  const daResposta = new Set()
  for (const lista of bloco.matchAll(/modules:\s*\[([^\]]*)\]/g)) {
    for (const m of lista[1].matchAll(/'([^']+)'/g)) {
      if (!slugsValidos.has(m[1])) { desconhecidos.add(`${seg.slug} → ${m[1]}`); continue }
      daResposta.add(m[1])
    }
  }
  for (const slug of daResposta) (porResposta[slug] ??= []).push(seg.slug)
}

/* Um slug que não existe no registro de módulos vira link quebrado. Melhor falhar o
   build do que publicar a página com um cartão que leva a lugar nenhum. */
if (desconhecidos.size) {
  console.error(`module-segments: módulo inexistente citado em segmento — ${[...desconhecidos].join(', ')}`)
  process.exit(1)
}

const mapa = {}
for (const mod of modRegistry) {
  const destaque = porSpotlight[mod.slug] ?? []
  const complemento = (porResposta[mod.slug] ?? []).filter((s) => !destaque.includes(s))
  const lista = [...destaque, ...complemento].slice(0, LIMITE)
  if (lista.length) mapa[mod.slug] = lista
}

writeFileSync(
  resolve(root, 'src/content/modulePages/segments.json'),
  JSON.stringify(mapa, null, 2) + '\n',
)

const semSegmento = modRegistry.filter((m) => !mapa[m.slug]).map((m) => m.slug)
console.log(`module-segments: ${Object.keys(mapa).length} de ${modRegistry.length} módulos com segmentos`)
if (semSegmento.length) {
  console.log(`module-segments: sem segmento (o bloco não aparece) — ${semSegmento.join(', ')}`)
}
