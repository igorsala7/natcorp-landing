// Prova que uma edição mexeu SÓ em comentários: compara o código de antes e o de depois sem
// os comentários. Serve para as rodadas de documentação dos .src.js / .src.css — um comentário
// a mais nunca muda o que a página faz; um caractere de código a mais, sim.
//
//   node conferir-so-comentarios.mjs <pasta-de-antes> [arquivos…]
//     sem arquivos: confere todos os *.src.js, *.src.css e *.janela.css da pasta de antes
//
// JS: o TypeScript lê o arquivo e reimprime sem comentários (a mesma leitura de antes e de
// depois). CSS: o PostCSS lê e lista regras e declarações sem comentários.
// Também conta os comentários que os GERADORES usam (/*@@…@@*/ e /*reserva*/): esses não podem
// sumir nem mudar de número.
import { readFileSync, readdirSync, existsSync } from 'node:fs'
import { join, basename } from 'node:path'
import { createRequire } from 'node:module'

const require = createRequire(join(new URL('.', import.meta.url).pathname, '../../../package.json'))
const ts = require('typescript')
const postcss = require('postcss')

const [antes, ...lista] = process.argv.slice(2)
if (!antes) { console.error('uso: node conferir-so-comentarios.mjs <pasta-de-antes> [arquivos…]'); process.exit(2) }
const aqui = new URL('.', import.meta.url).pathname
const arquivos = lista.length ? lista.map((f) => basename(f)) : readdirSync(antes).filter((f) => /\.(src\.js|src\.css|janela\.css)$/.test(f))

const semComentJS = (src, nome) => {
  const sf = ts.createSourceFile(nome, src, ts.ScriptTarget.Latest, false, ts.ScriptKind.JS)
  if (sf.parseDiagnostics?.length) throw new Error('JS com erro de sintaxe: ' + sf.parseDiagnostics[0].messageText)
  return ts.createPrinter({ removeComments: true }).printFile(sf)
}
const semComentCSS = (src) => {
  const out = []
  postcss.parse(src).walk((n) => {
    if (n.type === 'comment') return
    if (n.type === 'rule') out.push('R ' + n.selector.replace(/\/\*[\s\S]*?\*\//g, '').replace(/\s+/g, ' ').trim())
    else if (n.type === 'atrule') out.push('@' + n.name + ' ' + n.params.replace(/\s+/g, ' ').trim())
    else if (n.type === 'decl') out.push('D ' + n.prop + ':' + n.value.replace(/\s+/g, ' ').trim() + (n.important ? ' !i' : ''))
  })
  return out.join('\n')
}
const marcas = (s) => (s.match(/\/\*@@[\s\S]*?@@\*\/|\/\*reserva\*\//g) || []).join('|')

let ruins = 0
for (const f of arquivos) {
  const a = join(antes, f), d = join(aqui, f)
  if (!existsSync(a) || !existsSync(d)) { console.log(`?  ${f}: falta o de antes ou o de depois`); ruins++; continue }
  const sa = readFileSync(a, 'utf8'), sd = readFileSync(d, 'utf8')
  try {
    const css = f.endsWith('.css')
    const ca = css ? semComentCSS(sa) : semComentJS(sa, f), cd = css ? semComentCSS(sd) : semComentJS(sd, f)
    const problemas = []
    if (ca !== cd) {
      const la = ca.split('\n'), ld = cd.split('\n')
      let i = 0; while (i < la.length && la[i] === ld[i]) i++
      problemas.push(`o CÓDIGO mudou (1ª diferença perto de: «${(la[i] || '').trim().slice(0, 90)}» → «${(ld[i] || '').trim().slice(0, 90)}»)`)
    }
    if (marcas(sa) !== marcas(sd)) problemas.push('um comentário de GERADOR (/*@@…@@*/ ou /*reserva*/) sumiu ou mudou')
    const pct = Math.round((sd.length / sa.length - 1) * 100)
    if (problemas.length) { ruins++; console.log(`✗  ${f}: ${problemas.join('; ')}`) }
    else console.log(`ok ${f}${sa === sd ? ' (sem mudança)' : `  +${pct}% de comentário`}`)
  } catch (e) { ruins++; console.log(`✗  ${f}: ${e.message}`) }
}
console.log(ruins ? `\n${ruins} arquivo(s) com problema` : `\ntudo certo: só comentários mudaram`)
process.exit(ruins ? 1 : 0)
