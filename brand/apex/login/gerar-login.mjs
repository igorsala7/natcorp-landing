// Gera a PARTE DO LOGIN (parte-login.css) a partir de Natcorp_Login.src.css, embutindo a
// fonte e três imagens, e em seguida chama o ../app/gerar-app.mjs, que cola login + menu +
// páginas no fim do Natcorp_Style_Min.css (a folha geral que o APEX carrega e o arquivo que
// sobe). Marcas trocadas aqui:
//   @@FONTE@@           Inter latina (brand/apex/fonts/inter-latin.woff2), em base64
//   @@FONTE_EXT@@       Inter latina estendida (brand/apex/fonts/inter-latin-ext.woff2), em base64
//   @@PAINEL_ANIMADO@@  o painel lateral com os efeitos do hero dos portais, animado por CSS dentro do SVG
//   @@PAINEL_PARADO@@   o mesmo painel no estado final, para prefers-reduced-motion
//   @@LOGO@@            a assinatura Natcorp horizontal em branco
//
// O APEX só aceita uma folha (sem JS, sem template), por isso tudo vai como data URI.
// A geometria dos losangos é a de src/components/portals/ModuleLights.tsx e o logo sai de
// src/components/brand/logo-paths.ts — mudou lá, rode de novo:
//
//   node brand/apex/login/gerar-login.mjs

import { readFileSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'
import { painel as painelNatcorp, PAINEL_LOGIN, logoBranco, uri } from '../painel-natcorp.mjs'

const here = new URL('.', import.meta.url).pathname
const REPO = join(here, '../../..')

/* O painel e a assinatura vêm do módulo compartilhado com o menu das páginas internas. */
const logo = logoBranco()
const painel = (animado) => painelNatcorp(PAINEL_LOGIN, animado)

const src = readFileSync(join(here, 'Natcorp_Login.src.css'), 'utf8')
const fonte = readFileSync(join(REPO, 'brand/apex/fonts/inter-latin.woff2')).toString('base64')
const fonteExt = readFileSync(join(REPO, 'brand/apex/fonts/inter-latin-ext.woff2')).toString('base64')
/* PRIORIDADE — o Natcorp_Style_Min.css do workspace natcorp traz outro redesenho do login
   com 115 !important e seletores de até um ID (:not(#nc-fake-id)). Para esta folha valer
   por cima dele sem editá-lo:
   1. toda declaração ganha !important (menos @font-face, onde é inválido, e variáveis);
   2. todo "body.t-PageBody--login" ganha :not(#nc-p1):not(#nc-p2) — o peso de DOIS IDs,
      sem ID nenhum na página. Entre dois !important decide a especificidade: 2 IDs > 1.
   Só atua fora dos comentários, para a fonte seguir legível. */
const PRIORIDADE = ':not(#nc-p1):not(#nc-p2)'
const foraDosComentarios = (css, fn) =>
  css
    .split(/(\/\*[\s\S]*?\*\/)/)
    .map((trecho, i) => (i % 2 ? trecho : fn(trecho)))
    .join('')
const priorizar = (css) =>
  foraDosComentarios(css, (t) => t.replace(/body\.t-PageBody--login(?![\w-])/g, `body.t-PageBody--login${PRIORIDADE}`))
/* Blocos mais internos "seletor { declarações }": cada declaração sem !important ganha um.
   Os comentários viram marcadores (\u0000n\u0000, sem chave nem ponto e vírgula) enquanto isso,
   senão um comentário no meio da regra parte o bloco e as declarações seguintes escapam. */
const importantizar = (css) => {
  const coments = []
  const semComent = css.replace(/\/\*[\s\S]*?\*\//g, (c) => `\u0000${coments.push(c) - 1}\u0000`)
  const marcado = semComent.replace(/([^{}]*)\{([^{}]*)\}/g, (bloco, seletor, corpo) => {
    if (/@font-face/.test(seletor)) return bloco
    const novo = corpo.replace(
      /(^|;)((?:\s|\u0000\d+\u0000)*)([a-z-]+\s*:[^;]*?)(\s*)(?=;|$)/g,
      (m, sep, esp, decl, fim) => (/!important\s*$/.test(decl) || /^--/.test(decl) ? m : `${sep}${esp}${decl} !important${fim}`),
    )
    return `${seletor}{${novo}}`
  })
  return marcado.replace(/\u0000(\d+)\u0000/g, (_, i) => coments[i])
}

const out = priorizar(importantizar(src))
  .replace('@@PAINEL_ANIMADO@@', uri(painel(true)))
  .replace('@@PAINEL_PARADO@@', uri(painel(false)))
  .replace('@@LOGO@@', uri(logo))
  .replace('@@FONTE@@', `url("data:font/woff2;base64,${fonte}")`)
  .replace('@@FONTE_EXT@@', `url("data:font/woff2;base64,${fonteExt}")`)
writeFileSync(join(here, 'parte-login.css'), out)
console.log(`parte-login.css: ${(out.length / 1024).toFixed(1)} KB (fonte ${(src.length / 1024).toFixed(1)} KB)`)

// monta o CSS geral (login + menu + páginas) dentro do Natcorp_Style_Min.css
await import('../app/gerar-app.mjs')
