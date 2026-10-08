// Gera as folhas das páginas internas do APEX, uma por assunto, e monta o arquivo que sobe:
//
//   Natcorp_Menu.src.css     → Natcorp_Menu.css      cabeçalho superior e menu lateral
//   Natcorp_Paginas.src.css  → Natcorp_Paginas.css   conteúdo: regiões, campos, botões, modais
//   ../login/parte-login.css                         o login (gerador próprio: ../login/gerar-login.mjs)
//
//   login + menu + páginas + as outras FOLHAS, juntas, são coladas no fim do
//   ../login/Natcorp_Style_Min.css (abaixo do divisor "NOVAS IMPLEMENTAÇÕES"; acima fica a Skin
//   do cliente, intacta) — o Style_Min É O ARQUIVO QUE SOBE (veja sincronizarSkin). As folhas
//   AVULSAS (uma por página) sobem cada uma sozinha e não entram nele.
//   (Até 27/09 subia um Natcorp_Login.css com esse conteúdo; deixou de ser usado e de ser gerado
//   em 03/10.)
//
// Em cada fonte, "@app" vira o prefixo de prioridade e toda declaração ganha !important; os
// marcadores @@…@@ viram as imagens do painel da marca (../painel-natcorp.mjs, o mesmo do login).
// A pré-visualização ao vivo (preview.js) carrega uma cópia dele: .playwright-mcp/Natcorp_Preview.css.
//
//   node brand/apex/app/gerar-app.mjs            gera uma vez
//   node brand/apex/app/gerar-app.mjs --watch    gera de novo a cada mudança nas fontes

import { readFileSync, writeFileSync, watch, existsSync } from 'node:fs'
import { join } from 'node:path'
import { painel, PAINEL_MENU, logoBranco, simboloBranco, uri } from '../painel-natcorp.mjs'
import { createRequire } from 'node:module'
import { converter as converterHas, blocoMarcador, comBloco, versao as versaoMarcas } from './marcas-has.mjs'
const postcss = createRequire(new URL('../../../package.json', import.meta.url))('postcss')

/* O Style_Min sobe ENXUTO (07/10): sem comentários e uma regra por linha — toda página e toda
   moldura carregam e interpretam esse arquivo, e 1/4 dele eram comentários e espaços. Os
   comentários continuam nas fontes .src.css (lá é que se edita). Nada muda no CSS: o enxuto é
   conferido declaração por declaração contra o completo; se algo não bater, sobe o completo. */
function enxugar(css) {
  const assinatura = (raiz) => { const a = []; raiz.walkDecls((d) => a.push(d.prop + ':' + d.value.replace(/\s+/g, ' ').trim() + (d.important ? '!' : ''))); return a.join('\n') }
  const raiz = postcss.parse(css)
  const antes = assinatura(raiz)
  raiz.walkComments((c) => c.remove())
  raiz.walk((n) => {
    if (n.type === 'decl') { n.raws.before = ''; n.raws.between = ':' }
    else if (n.type === 'rule' || n.type === 'atrule') {
      n.raws.before = '\n'; n.raws.after = ''; n.raws.semicolon = false
      if (n.type === 'rule') { n.raws.between = ''; n.selector = n.selector.replace(/\s*\n\s*/g, ' ') }
    }
  })
  const out = raiz.toString().replace(/^\n+/, '') + '\n'
  if (assinatura(postcss.parse(out)) !== antes) { console.error('ATENÇÃO enxugar: o CSS enxuto não bateu com o completo — subindo o completo'); return css }
  return out
}

const aqui = new URL('.', import.meta.url).pathname
const REPO = join(aqui, '../../..')
const LOGIN = join(REPO, 'brand/apex/login/parte-login.css')
const PREVIEW = join(REPO, '.playwright-mcp/Natcorp_Preview.css')
const FOLHAS = ['Natcorp_Menu', 'Natcorp_Paginas', 'Natcorp_Temas', 'Natcorp_Registros', 'Natcorp_Trilha', 'Natcorp_Editor', 'Natcorp_Lov', 'Natcorp_Colab', 'Natcorp_Grade']
/* folhas AVULSAS: mesmo tratamento (@app, !important, imagens), mas fora do
   Natcorp_Style_Min — cada uma sobe sozinha e entra só na página dela (as variáveis --nc-…
   continuam vindo da folha geral, que toda página carrega) */
const AVULSAS = ['Natcorp_Beneficios', 'Natcorp_Ferias', 'Natcorp_Movimentacao', 'Natcorp_Requisicao', 'Natcorp_Desligamento', 'Natcorp_AlteracaoVaga', 'Natcorp_Cadastro', 'Natcorp_Dependentes', 'Natcorp_Treinamento', 'Natcorp_Ficha', 'Natcorp_Documentos', 'Natcorp_Avaliacao', 'Natcorp_Escala', 'Natcorp_Acidente', 'Natcorp_DadosPessoais', 'Natcorp_Formacao', 'Natcorp_Carta', 'Natcorp_Empregos', 'Natcorp_Funcional', 'Natcorp_Ponto', 'Natcorp_Atestado', 'Natcorp_Reembolso', 'Natcorp_PPP', 'Natcorp_HoraExtra', 'Natcorp_Terceiros', 'Natcorp_IndMovimentacao', 'Natcorp_Exames', 'Natcorp_Agenda', 'Natcorp_Abono', 'Natcorp_Apuracao', 'Natcorp_LinhaTempo', 'Natcorp_AgendaMedica', 'Natcorp_ExameMedico', 'Natcorp_LancamentoExames', 'Natcorp_ConsultaMedica', 'Natcorp_HistoricoColaborador', 'Natcorp_AvaliacaoMedica', 'Natcorp_HistoricoConsultas', 'Natcorp_DadosCandidato', 'Natcorp_ProcessosSeletivos', 'Natcorp_ProcessoDetalhe', 'Natcorp_CandidatoProcesso', 'Natcorp_ProcessoJanelas', 'Natcorp_BancoTalentos', 'Natcorp_QuestTreinamento', 'Natcorp_Chamada', 'Natcorp_PreAtendimento', 'Natcorp_ManutencaoAtestados', 'Natcorp_Cipa', 'Natcorp_Onboarding', 'Natcorp_Feedback', 'Natcorp_FeriasConsulta', 'Natcorp_Consulta', 'Natcorp_Contrato', 'Natcorp_Normas', 'Natcorp_BeneficiosConsulta', 'Natcorp_Marcacoes', 'Natcorp_Espelho', 'Natcorp_Lancamento', 'Natcorp_Folha', 'Natcorp_Cursos', 'Natcorp_Lote']

/* Só as páginas internas (o login tem a própria folha) e com o peso de DOIS IDs: a Natcorp
   Skin usa seletores de até um ID (:not(#nc-fake-id)) com !important.
   As páginas que abrem em MODAL são outro documento, num iframe, com o body
   .t-Dialog-page (sem .t-PageBody): sem entrar no :is elas ficavam só com a Skin. O :is
   vale o maior dos argumentos (0,2,0), o mesmo peso de antes. */
const PREFIXO = 'html body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2)'

/* Blocos mais internos "seletor { declarações }": cada declaração sem !important ganha um.
   Comentários viram marcadores enquanto isso, senão um comentário no meio da regra parte o
   bloco. :root e variáveis ficam como estão. */
const importantizar = (css) => {
  const coments = []
  const semComent = css.replace(/\/\*[\s\S]*?\*\//g, (c) => `\u0000${coments.push(c) - 1}\u0000`)
  const marcado = semComent.replace(/([^{}]*)\{([^{}]*)\}/g, (bloco, seletor, corpo) => {
    /* sem !important: @font-face, :root, @property (descritores) e os quadros de @keyframes
       (from / to / 50%) — ali o !important é inválido e o navegador descartaria o bloco */
    if (/@font-face|:root|@property/.test(seletor) || /^\s*(from|to|\d+(\.\d+)?%)(\s*,\s*(from|to|\d+(\.\d+)?%))*\s*$/.test(seletor)) return bloco
    const novo = corpo.replace(
      /(^|;)((?:\s|\u0000\d+\u0000)*)([a-z-]+\s*:[^;]*?)(\s*)(?=;|$)/g,
      (m, sep, esp, decl, fim) => (/!important\s*$/.test(decl) || /^--/.test(decl) ? m : `${sep}${esp}${decl} !important${fim}`),
    )
    return `${seletor}{${novo}}`
  })
  return marcado.replace(/\u0000(\d+)\u0000/g, (_, i) => coments[i])
}

const priorizar = (css) =>
  css
    .split(/(\/\*[\s\S]*?\*\/)/)
    .map((trecho, i) => (i % 2 ? trecho : trecho.replaceAll('@app', PREFIXO)))
    .join('')

/* Marcadores trocados DEPOIS do !important: o CSS de dentro dos SVGs também tem ";" e
   confundiria a etapa que marca as declarações. */
const IMAGENS = {
  '@@PAINEL_MENU_ANIMADO@@': () => uri(painel(PAINEL_MENU, true)),
  '@@PAINEL_MENU_PARADO@@': () => uri(painel(PAINEL_MENU, false)),
  '@@SIMBOLO_BRANCO@@': () => uri(simboloBranco()),
  '@@LOGO_BRANCO@@': () => uri(logoBranco()),
}
const trocarImagens = (css) => Object.entries(IMAGENS).reduce((c, [marca, f]) => (c.includes(marca) ? c.replaceAll(marca, f()) : c), css)

/* ../login/Natcorp_Style_Min.css é a Natcorp Skin do cliente com o nosso CSS colado no fim,
   depois de um divisor. Tudo ACIMA do divisor é da Skin e nunca é tocado; a cada geração a
   parte de BAIXO é trocada pelo CSS geral recém-gerado (login + FOLHAS). Sem o divisor no arquivo, não mexe em nada. */
const SKIN = join(REPO, 'brand/apex/login/Natcorp_Style_Min.css')
const MARCA_SKIN = 'NOVAS IMPLEMENTAÇÕES — Natcorp (a partir daqui)'
const divisorSkin = () => `/* ###########################################################################################
   ###########################################################################################
   ##                                                                                       ##
   ##   ${MARCA_SKIN}                                      ##
   ##                                                                                       ##
   ##   Tudo ACIMA deste bloco é a Natcorp Skin original, sem nenhuma alteração.             ##
   ##   Tudo ABAIXO é o CSS geral da Natcorp: login em tela dividida, cabeçalho e menu       ##
   ##   lateral, e as páginas internas (regiões, campos, relatórios clássico/interativo,     ##
   ##   grade interativa, modais, alertas, Alertify, apex.message, upload de arquivo).       ##
   ##                                                                                       ##
   ##   Vem DEPOIS da Skin de propósito: com a mesma prioridade, vence quem vem por último.  ##
   ##   Gerado por brand/apex/app/gerar-app.mjs — NÃO edite abaixo daqui: edite as fontes    ##
   ##   .src.css (esta parte é reescrita a cada geração; a de cima, nunca).                  ##
   ##                                                                                       ##
   ###########################################################################################
   ########################################################################################### */

`

function sincronizarSkin(completo) {
  if (!existsSync(SKIN)) return
  const atual = readFileSync(SKIN, 'utf8')
  const i = atual.indexOf(MARCA_SKIN)
  if (i < 0) return
  const inicioDivisor = atual.lastIndexOf('/*', i)
  const skin = atual.slice(0, inicioDivisor).replace(/\s+$/, '')
  const novo = `${skin}\n\n\n${divisorSkin()}${completo}`
  if (novo !== atual) { writeFileSync(SKIN, novo); mudaram.push(SKIN.split('/').pop()) }
}

/* Grava SÓ quando o conteúdo mudou. Antes, toda mudança em qualquer .src.css regravava TODOS os
   .css (com o mesmo conteúdo): a data de todos virava "agora" e não dava para saber quais subir.
   Agora o arquivo intacto fica com a data antiga, e o log lista só os que mudaram. */
let mudaram = []
function escrever(arq, txt) {
  if (existsSync(arq) && readFileSync(arq, 'utf8') === txt) return
  writeFileSync(arq, txt)
  mudaram.push(arq.split('/').pop())
}

function gerar() {
  mudaram = []
  const partes = []
  for (const nome of FOLHAS) {
    const src = readFileSync(join(aqui, `${nome}.src.css`), 'utf8')
    /* guarda: variável usada e não definida vira "sem borda"/"sem cor" em silêncio (já aconteceu:
       o :root sumiu numa edição e todos os campos perderam a borda) */
    const usadas = new Set([...src.matchAll(/var\((--nc-[a-z0-9-]+)\)/g)].map((m) => m[1]))
    const definidas = new Set([...src.matchAll(/(--nc-[a-z0-9-]+)\s*:/g)].map((m) => m[1]))
    const faltam = [...usadas].filter((v) => !definidas.has(v))
    if (faltam.length) console.error(`ATENÇÃO ${nome}.src.css usa sem definir: ${faltam.join(', ')}`)
    const out = trocarImagens(importantizar(priorizar(src)))
    escrever(join(aqui, `${nome}.css`), out)
    partes.push(`/* ===== ${nome}.css ===== */\n${out}`)
  }
  if (!existsSync(LOGIN)) throw new Error('falta brand/apex/login/parte-login.css — rode node brand/apex/login/gerar-login.mjs')
  const login = readFileSync(LOGIN, 'utf8')
  // o login primeiro: é ele que traz o @font-face da Manrope embutida
  const completo = `/* Natcorp — login, menu e páginas do APEX. Gerado por brand/apex/app/gerar-app.mjs: não edite. */\n/* ===== login ===== */\n${login}\n${partes.join('\n')}`
  for (const nome of AVULSAS) {
    const fonte = join(aqui, `${nome}.src.css`)
    if (!existsSync(fonte)) continue
    escrever(join(REPO, 'brand/apex/login', `${nome}.css`), trocarImagens(importantizar(priorizar(readFileSync(fonte, 'utf8')))))
  }
  /* 07/10: os :has() caros viram classes postas pelo marcador (marcas-has.mjs) — o bloco do marcador
     vai no Natcorp_Allow_Unload_Iframes.js (o único arquivo que TODO app carrega) e numa cópia para o
     montar-limpo.py. As fontes .src.css continuam com :has(): a troca é só no que sobe. */
  const conv = converterHas(completo)
  /* a versão das regras vai no CSS (:root --nc-marcas) e no bloco: só a cópia certa marca */
  conv.css += `\n:root { --nc-marcas: "${versaoMarcas(conv.regras)}"; }\n`
  const bloco = blocoMarcador(conv.regras)
  escrever(join(aqui, 'nc-marcas.bloco.js'), bloco + '\n')
  const AU = join(REPO, 'brand/apex/login/Natcorp_Allow_Unload_Iframes.js')
  if (existsSync(AU)) escrever(AU, comBloco(readFileSync(AU, 'utf8'), bloco))
  /* 08/10: e no Natcorp_Registros.js — há apps (ex.: 9180) que carregam o Style_Min e o Registros mas
     NÃO o Allow_Unload: sem o bloco, a cobertura "Carregando…" só saía pela trava de 12 s e os :has()
     trocados por classe não valiam. As duas cópias se protegem (__ncMarcas / __ncPronto / versão). */
  const RG = join(REPO, 'brand/apex/login/Natcorp_Registros.js')
  if (existsSync(RG)) escrever(RG, comBloco(readFileSync(RG, 'utf8'), bloco))
  escrever(PREVIEW, conv.css)
  sincronizarSkin(`/* Natcorp — gerado por brand/apex/app/gerar-app.mjs, versão enxuta (os comentários estão nas fontes brand/apex/app/*.src.css). Não edite. */\n${enxugar(conv.css)}`)
  const kb = (f) => (readFileSync(f).length / 1024).toFixed(1)
  if (process.argv.includes('--watch')) {
    console.log(`${new Date().toLocaleTimeString('pt-BR')}  ` + (mudaram.length ? 'mudou: ' + mudaram.join(' · ') : 'nada mudou'))
    return
  }
  console.log(
    `${new Date().toLocaleTimeString('pt-BR')}  ` +
      FOLHAS.map((n) => `${n}.css ${kb(join(aqui, `${n}.css`))} KB`).join(' · ') +
      ` · Natcorp_Style_Min.css ${kb(SKIN)} KB` +
      AVULSAS.filter((n) => existsSync(join(REPO, 'brand/apex/login', `${n}.css`))).map((n) => ` · ${n}.css ${kb(join(REPO, 'brand/apex/login', `${n}.css`))} KB`).join(''),
  )
}

gerar()

if (process.argv.includes('--watch')) {
  /* Vigia as PASTAS, não os arquivos: editores (e ferramentas) salvam gravando um arquivo
     novo e trocando pelo antigo, e o fs.watch de um arquivo continua preso ao que sumiu. */
  let espera
  const disparar = () => {
    clearTimeout(espera)
    espera = setTimeout(() => {
      try {
        gerar()
      } catch (e) {
        console.error('erro ao gerar:', e.message)
      }
    }, 120)
  }
  watch(aqui, (_, nome) => nome && nome.endsWith('.src.css') && disparar())
  watch(join(REPO, 'brand/apex/login'), (_, nome) => nome === 'parte-login.css' && disparar())
  console.log('vigiando brand/apex/app/*.src.css e brand/apex/login/parte-login.css — Ctrl+C para parar')
}
