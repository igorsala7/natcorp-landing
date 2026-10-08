// Troca os :has() CAROS do nosso CSS por classes postas por um marcador (JS), sem mudar o efeito.
//
// Por quê (medido 07/10, 2010:52, CPU 4×): com os :has() o cálculo de estilo na abertura da página
// levava 31,8 s; sem os 162 seletores de 5 tipos (condição no body, foto do colaborador, campo
// alterado em amarelo, grade .row/.col, região), 3,6 s. O :has() obriga o navegador a reavaliar
// (e, no body, a refazer a página inteira) a cada mudança no DOM — e o APEX faz centenas ao montar.
//
// Como: cada  SUJEITO:has(X)  de um seletor caro vira  SUJEITO:where(.nc-hK)  + enchimentos que
// SEMPRE casam (:not(#nc-zN), :not(.nc-zN), :not(nc-zN)) para a especificidade ficar IGUAL à do
// :has(X). O marcador (no Natcorp_Allow_Unload_Iframes.js) põe .nc-hK em quem casa  BASE:has(X)
// via querySelectorAll — uma avaliação só, sem a reinvalidação do CSS — e reavalia quando o DOM muda.
// Ficam de fora (continuam :has) os que dependem de estado que não muda o DOM (:hover, :focus,
// :checked…) e os tipos baratos (campos, relatórios, cartões…): eles não pesam.
import { createRequire } from 'node:module'
const req = createRequire(new URL('../../../package.json', import.meta.url))
const postcss = req('postcss')
const psp = req('postcss-selector-parser')

const PRE = 'html body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2)'
/* estados que mudam SEM mexer no DOM: o marcador não teria como saber — esses ficam :has() */
const NAO_OBSERVAVEL = /:(hover|focus|focus-visible|focus-within|active|checked|indeterminate|invalid|valid|user-invalid|user-valid|placeholder-shown|autofill|visited|target|in-range|out-of-range|default|open|modal|popover-open)\b/
const SEM_SUJEITO = new Set([':has', ':nth-child', ':nth-last-child', ':nth-of-type', ':nth-last-of-type', ':first-child', ':last-child', ':only-child', ':first-of-type', ':last-of-type', ':only-of-type', ':empty', ':root', ':scope', ':hover', ':focus', ':focus-visible', ':focus-within', ':active'])
const LISTA = new Set([':is', ':not', ':where', ':matches', ':-webkit-any', ':has'])
const ELEMENTO_PSEUDO = new Set([':before', ':after', ':first-line', ':first-letter'])

/* os 5 tipos caros (os mesmos da medição de 07/10) */
export function tipo(p) {
  if (/\[style\*=/.test(p)) return 'amarelo'
  if (/FOTO_COLAB/.test(p)) return 'fotoColab'
  if (p.startsWith(PRE + ':has(') || /^(html|body|html body):has\(/.test(p)) return 'body'
  if (/\.t-Report[^-\w]*[^\s]*:has|\.t-Report:has/.test(p)) return 'report'
  if (/\.t-Cards?[\w.-]*:has|\.t-Card:has/.test(p)) return 'cards'
  if (/\.row:has|\.col:has|\.col:not\(:has|\.container:has/.test(p)) return 'grade'
  if (/t-Form-fieldContainer[^ ]*:has|t-Form-itemWrapper[^ ]*:has|t-Form-labelContainer[^ ]*:has|apex-item[\w-]*\)?:has/.test(p)) return 'campo'
  if (/\.t-Region[^ ]*:has|t-Region-body[^ ]*:has/.test(p)) return 'regiao'
  return 'outros'
}
const CAROS = new Set(['body', 'fotoColab', 'amarelo', 'grade', 'regiao'])

/* especificidade [ids, classes, tipos] de um seletor (nó Selector do postcss-selector-parser) */
function espec(sel) {
  const s = [0, 0, 0]
  const soma = (x) => { s[0] += x[0]; s[1] += x[1]; s[2] += x[2] }
  sel.each((n) => {
    if (n.type === 'id') s[0]++
    else if (n.type === 'class' || n.type === 'attribute') s[1]++
    else if (n.type === 'tag') s[2]++
    else if (n.type === 'pseudo') {
      const v = n.value.toLowerCase()
      if (v === ':where') return
      if (LISTA.has(v)) { soma(maior(n.nodes.map(espec))); return }
      if (v.startsWith('::') || ELEMENTO_PSEUDO.has(v)) s[2]++
      else s[1]++
    }
  })
  return s
}
function maior(lista) {
  return lista.reduce((m, x) => (x[0] > m[0] || (x[0] === m[0] && (x[1] > m[1] || (x[1] === m[1] && x[2] > m[2]))) ? x : m), [0, 0, 0])
}
function hash(t) { let h = 2166136261; for (let i = 0; i < t.length; i++) { h ^= t.charCodeAt(i); h = Math.imul(h, 16777619) } return (h >>> 0).toString(36) }

/* o composto (entre combinadores) de um nó, dentro do seletor dele */
function composto(no) {
  const sel = no.parent; const nos = sel.nodes; const i = nos.indexOf(no)
  let a = i, b = i
  while (a > 0 && nos[a - 1].type !== 'combinator') a--
  while (b < nos.length - 1 && nos[b + 1].type !== 'combinator') b++
  return nos.slice(a, b + 1)
}
/* a BASE para o querySelectorAll: o composto sem :has, sem estados e sem pseudo-elementos; se o
   :has está sozinho dentro de um :not()/:is() (".col:not(:has(X))"), sobe para o composto de fora */
function base(noHas) {
  let no = noHas
  for (;;) {
    const partes = composto(no).filter((n) => {
      if (n === no) return false
      if (n.type === 'combinator' || n.type === 'comment') return false
      if (n.type === 'pseudo') {
        const v = n.value.toLowerCase()
        if (!LISTA.has(v) || v === ':has') return false
        const t = String(n)
        return !t.includes(':has(') && !NAO_OBSERVAVEL.test(t)
      }
      return ['tag', 'class', 'id', 'attribute', 'universal'].includes(n.type)
    })
    const txt = partes.map(String).join('').trim()
    const pai = no.parent && no.parent.parent
    if (txt || !pai || pai.type !== 'pseudo') return txt || '*'
    no = pai   // o :not()/:is() que contém o :has — o composto dele está no seletor de fora
  }
}

/* converte o CSS; devolve o CSS novo e a lista [classe, seletor-para-o-marcador] */
export function converter(css) {
  const raiz = postcss.parse(css)
  const regras = new Map()
  let convertidos = 0, mantidos = 0
  raiz.walkRules((r) => {
    if (!r.selector.includes(':has(')) return
    const novos = r.selectors.map((p) => {
      if (!p.includes(':has(') || !CAROS.has(tipo(p))) return p
      const ast = psp().astSync(p)
      const trocas = []
      let pode = true
      ast.walkPseudos((n) => {
        if (n.value.toLowerCase() !== ':has') return
        if (n.parent && n.parent.parent && n.parent.parent.type === 'pseudo' && n.parent.parent.value.toLowerCase() === ':has') return   // :has dentro de :has: vai junto no seletor do de fora
        const arg = n.nodes.map(String).join(',').trim()
        if (NAO_OBSERVAVEL.test(arg)) { pode = false; return }
        trocas.push(n)
      })
      if (!pode || !trocas.length) { mantidos++; return p }
      /* primeiro calcula tudo (base, condição, especificidade) — só depois troca: com dois :has no
         mesmo composto, trocar o 1º antes de ler o 2º sujaria a base dele */
      const plano = trocas.map((n) => {
        const arg = n.nodes.map(String).join(', ').trim()
        const alvo = `${base(n)}:has(${arg})`
        const k = 'nc-h' + hash(alvo)
        const [a, c, t] = maior(n.nodes.map(espec))
        let ench = ''
        for (let z = 0; z < a; z++) ench += `:not(#nc-z${z})`
        for (let z = 0; z < c; z++) ench += `:not(.nc-z${z})`
        for (let z = 0; z < t; z++) ench += `:not(nc-z${z})`
        regras.set(k, alvo)
        return `:where(.${k})${ench}`
      })
      trocas.forEach((n, idx) => n.replaceWith(psp.tag({ value: `__NCH${idx}__` })))
      let txt = ast.toString()
      plano.forEach((t, idx) => { txt = txt.split(`__NCH${idx}__`).join(t) })
      convertidos++
      return txt
    })
    r.selectors = novos
  })
  return { css: raiz.toString(), regras: [...regras.entries()], convertidos, mantidos }
}

/* o bloco do marcador (vai no fim do Natcorp_Allow_Unload_Iframes.js, entre as marcas) */
export const INICIO = '/* ===== NC-MARCAS: INÍCIO (gerado por brand/apex/app/gerar-app.mjs — não edite à mão) ===== */'
export const FIM = '/* ===== NC-MARCAS: FIM ===== */'
/* 08/10: a "versão" das regras (muda a cada geração em que as condições mudam). O CSS publica a mesma
   em :root { --nc-marcas } e o marcador só trabalha se as duas baterem: o bloco vai em MAIS DE UM
   arquivo (Allow_Unload e Natcorp_Registros) e uma cópia velha não pode marcar classes de outro CSS. */
export function versao(regras) {
  let h = 5381
  for (const ch of JSON.stringify(regras)) h = ((h * 33) ^ ch.charCodeAt(0)) >>> 0
  return h.toString(36)
}

export function blocoMarcador(regras) {
  /* as classes citadas DENTRO das condições: mudança de classe que não toca nenhuma delas não pede
     nova rodada (páginas com scripts que mexem em classes o tempo todo) */
  const classes = new Set()
  for (const [, s] of regras) for (const m of s.matchAll(/\.([A-Za-z_][\w-]*)/g)) classes.add(m[1])
  return `${INICIO}
/* O marcador dos seletores :has() CAROS do Natcorp_Style_Min.css. O gerador troca cada um por uma
   classe (.nc-h…) e este bloco põe a classe em quem casa a condição original — uma avaliação só
   (querySelectorAll), em vez de o navegador reavaliar a página inteira a cada mudança. Reavalia ao
   abrir, quando o APEX termina de montar, quando uma região atualiza e quando o DOM muda (no
   máximo a cada ~300 ms: páginas com scripts que mexem no DOM o tempo todo não o fazem rodar sem
   parar). window.__ncMarcasRodadas / __ncMarcasMs contam as rodadas e o tempo gasto. Medido 07/10 (2010:52, CPU 4×): estilo 31,8 s → 3,6 s. */
(function () {
  "use strict";
  var R = ${JSON.stringify(regras)};
  var CLASSES = ${JSON.stringify([...classes].sort())};
  var COM_ESTILO = "input, select, textarea, .t-Form-fieldContainer, iframe";
  /* a versão do CSS desta página (--nc-marcas) tem de ser a deste bloco; se não for, esta cópia não
     marca nada e deixa para a outra (o bloco vai no Allow_Unload e no Natcorp_Registros.js) */
  var VERSAO = "${versao(regras)}";
  try {
    var vc = getComputedStyle(document.documentElement).getPropertyValue("--nc-marcas").replace(/["'\s]/g, "");
    if (vc && vc !== VERSAO) return;
  } catch (e) { /* segue */ }
  if (!R.length || !document.querySelectorAll || window.__ncMarcas) return;
  window.__ncMarcas = true;
  var obs = null, marcando = false, agendado = false, ultimo = 0;
  var INTERVALO = 300;
  window.__ncMarcasRodadas = 0; window.__ncMarcasMs = 0;
  function marcar() {
    agendado = false; ultimo = Date.now(); marcando = true;
    var t0 = (window.performance && performance.now) ? performance.now() : 0;
    for (var i = 0; i < R.length; i++) {
      var k = R[i][0], lista;
      try { lista = document.querySelectorAll(R[i][1]); } catch (e) { continue; }
      var sim = new Set();
      for (var j = 0; j < lista.length; j++) { sim.add(lista[j]); if (!lista[j].classList.contains(k)) lista[j].classList.add(k); }
      var tem = document.getElementsByClassName(k);
      for (var m = tem.length - 1; m >= 0; m--) { if (!sim.has(tem[m])) tem[m].classList.remove(k); }
    }
    if (obs) obs.takeRecords();   /* as mudanças que o próprio marcador fez não pedem outra rodada */
    marcando = false;
    window.__ncMarcasRodadas++;
    if (t0) window.__ncMarcasMs += performance.now() - t0;
  }
  function agendar() {
    if (agendado || marcando) return;
    agendado = true;
    var espera = Math.max(0, INTERVALO - (Date.now() - ultimo));
    setTimeout(function () { (window.requestAnimationFrame || setTimeout)(marcar); }, espera);
  }
  /* durante a montagem o DOM muda sem parar: só os marcos (agora, DOM pronto, carregado, APEX
     pronto); a vigilância das mudanças começa quando a página fica pronta */
  var RELEVANTE = {}; for (var c = 0; c < CLASSES.length; c++) RELEVANTE[CLASSES[c]] = 1;
  function tocaClasse(antes, depois) {
    var a = (antes || "").split(/\s+/), d = (depois || "").split(/\s+/), i;
    for (i = 0; i < a.length; i++) if (RELEVANTE[a[i]] && d.indexOf(a[i]) < 0) return true;
    for (i = 0; i < d.length; i++) if (RELEVANTE[d[i]] && a.indexOf(d[i]) < 0) return true;
    return false;
  }
  /* só o que pode mudar alguma condição: elemento entrando/saindo, classe citada entrando/saindo,
     style de campo/contêiner/moldura, e os demais atributos observados */
  function importa(lista) {
    for (var i = 0; i < lista.length; i++) {
      var r = lista[i], el = r.target;
      if (r.type === "childList") return true;
      if (r.attributeName === "class") { if (tocaClasse(r.oldValue, el.getAttribute("class"))) return true; continue; }
      if (r.attributeName === "style") { if (el.matches && el.matches(COM_ESTILO)) return true; continue; }
      return true;
    }
    return false;
  }
  function vigiar() {
    if (obs || !window.MutationObserver) return;
    obs = new MutationObserver(function (lista) { if (importa(lista)) agendar(); });
    obs.observe(document.documentElement, { subtree: true, childList: true, attributes: true, attributeOldValue: true,
      attributeFilter: ["class", "style", "id", "value", "disabled", "hidden", "width", "aria-hidden", "src"] });
  }
  function pronto() { marcar(); vigiar(); }
  marcar();
  document.addEventListener("DOMContentLoaded", marcar);
  window.addEventListener("load", function () { marcar(); setTimeout(vigiar, 3000); });
  /* 08/10: este bloco também vai no Natcorp_Registros.js, que em alguns apps carrega ANTES da
     biblioteca do APEX: sem o apex ainda, liga no fim do HTML (antes do apexreadyend acontecer) */
  function ligarApex() {
    if (!window.apex || !apex.jQuery) return false;
    apex.jQuery(window).on("apexreadyend", pronto);
    apex.jQuery(document).on("apexreadyend", pronto).on("apexafterrefresh", marcar);
    /* injetado DEPOIS de a página ficar pronta (há apps em que a casca põe o Registros na moldura
       depois do apexreadyend): o aviso já passou — começa agora */
    if (apex.jQuery.isReady) setTimeout(pronto, 0);
    return true;
  }
  if (!ligarApex()) {
    document.addEventListener("DOMContentLoaded", function () { if (!ligarApex()) setTimeout(vigiar, 3000); });
  }
  window.__ncMarcar = marcar;
})();

/* A PÁGINA PRONTA (07/10): o CSS (Natcorp_Style_Min.css [C14b]) abre toda página interna coberta pelo
   carregando; aqui ela é revelada (html.nc-pronto) quando ficou pronta de verdade:
     1. o APEX terminou de montar (apexreadyend; sem APEX, o load);
     2. não há Ajax pendente (as ações dinâmicas de abertura);
     3. a página passou 250 ms sem inserir/remover elementos (os desenhos montaram);
     4. as fontes carregaram.
   No máximo 8 s depois que a página começou — se ela nunca sossegar, abre assim mesmo (e o próprio CSS
   ainda tem a trava de 12 s). Volta pelo "voltar" do navegador: já revelada. */
(function () {
  "use strict";
  if (window.__ncPronto) return;
  window.__ncPronto = true;
  var html = document.documentElement, feito = false, comecou = false, LIMITE = 8000;
  function revelar() {
    if (feito) return;
    feito = true;
    try { if (window.__ncMarcar) window.__ncMarcar(); } catch (e) { /* segue */ }
    html.classList.add("nc-pronto");
  }
  var agora = (window.performance && performance.now) ? performance.now() : 0;
  setTimeout(revelar, Math.max(0, LIMITE - agora));
  window.addEventListener("pageshow", function (e) { if (e.persisted) revelar(); });
  function depoisDasFontes(cb) {
    var f = document.fonts && document.fonts.ready;
    if (f && typeof f.then === "function") f.then(cb, cb); else cb();
  }
  function aguardarQuieto() {
    if (comecou || feito) return;
    comecou = true;
    var t = null, mo = null;
    function checar() {
      var $ = window.apex && apex.jQuery;
      if ($ && $.active > 0) { t = setTimeout(checar, 120); return; }
      if (mo) mo.disconnect();
      depoisDasFontes(function () {
        var raf = window.requestAnimationFrame || function (f) { return setTimeout(f, 16); };
        raf(function () { raf(revelar); });
      });
    }
    function mexeu(lista) {
      for (var i = 0; i < lista.length; i++) {
        var r = lista[i], j;
        for (j = 0; j < r.addedNodes.length; j++) if (r.addedNodes[j].nodeType === 1) { clearTimeout(t); t = setTimeout(checar, 250); return; }
        for (j = 0; j < r.removedNodes.length; j++) if (r.removedNodes[j].nodeType === 1) { clearTimeout(t); t = setTimeout(checar, 250); return; }
      }
    }
    if (window.MutationObserver && document.body) {
      mo = new MutationObserver(mexeu);
      mo.observe(document.body, { childList: true, subtree: true });
    }
    t = setTimeout(checar, 250);
  }
  /* no document: um handler que devolve false ali não o impede. Sem o apex ainda (o bloco carregou antes
     da biblioteca), liga no fim do HTML — o APEX só avisa depois disso */
  function ligarPronto() {
    if (!window.apex || !apex.jQuery) return false;
    apex.jQuery(document).one("apexreadyend", aguardarQuieto);
    /* chegou depois de o APEX montar a página (arquivo injetado tarde): o aviso já passou, então
       espera a página sossegar a partir de agora (aguardarQuieto ainda espera Ajax e 250 ms quietos) */
    if (apex.jQuery.isReady) setTimeout(aguardarQuieto, 0);
    return true;
  }
  if (!ligarPronto()) {
    if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", ligarPronto);
    else setTimeout(aguardarQuieto, 0);
  }
  /* sem o aviso do APEX (página sem APEX, ou ele já passou): começa 1,5 s depois do load */
  window.addEventListener("load", function () { setTimeout(aguardarQuieto, 1500); });
  if (document.readyState === "complete") setTimeout(aguardarQuieto, 1500);
})();
${FIM}`
}

/* põe (ou troca) o bloco num arquivo JS */
export function comBloco(js, bloco) {
  const a = js.indexOf(INICIO), b = js.indexOf(FIM)
  if (a >= 0 && b > a) return js.slice(0, a) + bloco + js.slice(b + FIM.length)
  return js.replace(/\s*$/, '\n\n') + bloco + '\n'
}
