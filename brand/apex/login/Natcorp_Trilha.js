/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · TRILHA  —  o caminho que a pessoa fez (histórico, não o menu)  (JavaScript)   ║
   ║  Vale para o SISTEMA TODO: entra pela aplicação casca (200), pelo Natcorp_Temas.js       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia: TRILHA-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Logo abaixo do menu superior, uma faixa com o CAMINHO que a pessoa fez nesta aba:

       [‹ Voltar]   ⟲  Home  ›  Medicina Ocupacional  ›  Agenda  ›  Avaliação Médica

     • as 3 últimas páginas visitadas e a atual (em negrito), com o NOME DA PÁGINA (o título
       que o APEX dá a ela) — não é a estrutura do menu, é o histórico de verdade;
     • "Voltar" leva à página anterior do caminho; tocar num item leva direto a ele;
     • voltar a uma página que já está no caminho CORTA o caminho ali (Home › A › Home vira
       só Home), para a trilha não virar um zigue-zague;
     • vale para as duas formas de navegar: na CASCA (a página 762 do app 200, com as outras
       aplicações dentro de um iframe) e nas páginas do próprio app 200, que abrem direto.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     • Não grava nada no banco: o caminho fica na aba (sessionStorage "nc-trilha"); fechou a
       aba ou entrou de novo no sistema (sessão nova), começa do zero.
     • Janelas (diálogos) e a tela de login não entram no caminho.
     • CUIDADO — SESSÃO: todo endereço guardado é aberto com o número da sessão ATUAL no lugar
       do que estava nele. Abrir um endereço com sessão antiga derruba a sessão da pessoa.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Ninguém põe URL dele em página nenhuma: o Natcorp_Temas.js (casca, todas as páginas) o
     traz da mesma pasta ([J0], lista PECAS). Só precisa SUBIR o arquivo:
       #WORKSPACE_IMAGES#Natcorp_Trilha.js
     O visual está no Natcorp_Trilha.src.css, que entra no Natcorp_Style_Min.css (gerar-app.mjs).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [T1]  Ajustes (quantas páginas; títulos genéricos → nome da aba)     PODE MEXER
     [T2]  Ferramentas
     [T3]  Ler a página (nome, qual é) e guardar o caminho                 CUIDADO
     [T4]  Ir para uma página do caminho                                   CUIDADO
     [T5]  Desenhar a faixa
     [T6]  Casca (iframe) ou página direta
*/
(function () {
  'use strict';
  /* só na janela de cima (nunca dentro do iframe da casca nem de uma janela de diálogo) */
  if (window.__ncTrilha || window.top !== window || !document.body) return;
  window.__ncTrilha = true;

  /* ═══ [T1] AJUSTES ═══════════════════════════════════════════════════════════════════════
     MOSTRA   quantas páginas ANTERIORES aparecem antes da atual (pedido: 3).
     GUARDA   quantas ficam guardadas na aba (o "…" indica que há mais para trás).
     PODE MEXER
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOSTRA = 3, GUARDA = 15;
  /* página cujo título é genérico: no caminho ela leva o NOME DA ABA do navegador (o título da
     casca, que diz o módulo — ex.: "Menu - Módulo" vira "Medicina Ocupacional"). Comparação sem
     maiúsculas/minúsculas e sem acento. */
  var GENERICOS = ['menu - modulo'];
  var CHAVE = 'nc-trilha', ABRIR = 'nc-trilha-abrir';

  /* ═══ [T2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  /* "CONSULTA MATRICULA" → "Consulta matricula" (título todo em maiúsculas vira frase) */
  function frase(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function val(d, id) { var e = d && d.getElementById(id); return e ? String(e.value || '') : ''; }
  function ler() { try { return JSON.parse(sessionStorage.getItem(CHAVE) || 'null') || { s: '', l: [] }; } catch (x) { return { s: '', l: [] }; } }
  function guardar(t) { try { sessionStorage.setItem(CHAVE, JSON.stringify(t)); } catch (x) { /* modo privado: vale só nesta página */ } }
  var IC = {
    voltar: '<path d="M14.5 6l-6 6 6 6"/>',
    passou: '<path d="M4.5 12a7.5 7.5 0 1 0 2.2-5.3"/><path d="M4 4.5v3.7h3.7"/><path d="M12 8.2V12l2.6 1.7"/>',
    seta: '<path d="M9.5 6.5l5 5.5-5 5.5"/>'
  };
  function ic(n, cls) { return '<svg class="nc-tr-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }

  /* ═══ [T3] LER A PÁGINA E GUARDAR O CAMINHO ══════════════════════════════════════════════
     CUIDADO  Qual página é: pFlowId + pFlowStepId (os campos ocultos que toda página APEX tem),
              não o endereço — depois de um "Salvar" o endereço pode ser o wwv_flow.accept.
              O nome: o título da página (o que o APEX põe na aba do navegador); sem ele, o
              rótulo do breadcrumb ou o primeiro título.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function sessao(d) { return val(d || document, 'pInstance'); }
  function semAcento(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/\s+/g, ' ').trim(); }
  function generico(t) { return GENERICOS.indexOf(semAcento(t)) >= 0; }
  function pagina(w, modo) {
    var d = w.document, app = val(d, 'pFlowId'), pg = val(d, 'pFlowStepId');
    if (!app || !pg || !d.body) return null;
    if (d.body.classList.contains('t-PageBody--login') || d.body.classList.contains('t-Dialog-page') || /^(101|9999)$/.test(pg)) return null;
    var nome = frase(d.title);
    if (!nome) { var h = d.querySelector('.t-Breadcrumb-item.is-active .t-Breadcrumb-label, .t-Body-title h1, h1'); nome = h ? frase(h.textContent) : 'Página ' + pg; }
    if (generico(nome) && d !== document && document.title && !generico(document.title)) nome = frase(document.title);   /* o nome da aba */
    var u = String(w.location.href);
    if (!/[?&]p=/.test(u)) u = u.replace(/[^\/]*$/, '') + 'f?p=' + app + ':' + pg + ':' + sessao(d);   /* página reaberta após um envio */
    return { k: app + ':' + pg, t: nome, u: u, m: modo, c: modo === 'casca' ? String(location.href) : '' };
  }
  function registrar(e) {
    if (!e) return;
    var t = ler(), s = sessao();
    if (t.s !== s) t = { s: s, l: [] };   /* sessão nova (entrou de novo): caminho do zero */
    var l = t.l, i = -1;
    for (var k = l.length - 1; k >= 0; k--) if (l[k].k === e.k) { i = k; break; }
    if (i >= 0) { l = l.slice(0, i + 1); l[i] = e; }   /* a mesma página, ou voltou a uma do caminho: corta ali */
    else l.push(e);
    t.l = l.slice(-GUARDA);
    guardar(t);
    desenhar();
  }

  /* ═══ [T4] IR PARA UMA PÁGINA DO CAMINHO ═════════════════════════════════════════════════
     CUIDADO  O endereço guardado é aberto com a sessão ATUAL (3º pedaço do f?p=APP:PÁGINA:
              SESSÃO). Página que era da casca, vista agora numa página direta: abre a casca e
              ela carrega a página no iframe (sessionStorage "nc-trilha-abrir").
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function comSessao(u) {
    var s = sessao(); if (!s) return u;
    return String(u).replace(/([?&]p=[^:&]*:[^:&]*:)[^:&]*/, '$1' + s);
  }
  function ir(e) {
    if (!e) return;
    var alvo = comSessao(e.u);
    if (e.m === 'casca') {
      if (IFRAME) { IFRAME.contentWindow.location.href = alvo; return; }
      try { sessionStorage.setItem(ABRIR, JSON.stringify({ u: alvo, t: Date.now() })); } catch (x) { /* sem armazenamento: a casca abre no início */ }
      location.href = comSessao(e.c);
      return;
    }
    location.href = alvo;
  }

  /* ═══ [T5] DESENHAR A FAIXA ══════════════════════════════════════════════════════════════ */
  var FAIXA = null, IFRAME = null;
  function desenhar() {
    if (!FAIXA) return;
    var l = ler().l, atual = l.length - 1, ant = l[atual - 1];
    var ini = Math.max(0, atual - MOSTRA), vis = l.slice(ini);
    FAIXA.innerHTML =
      '<button type="button" class="nc-tr-voltar" data-ir="' + (atual - 1) + '"' + (ant ? ' title="Voltar para ' + esc(ant.t) + '"' : ' disabled title="Esta é a primeira página desta aba"') + '>' +
        ic('voltar') + '<span>Voltar</span></button>' +
      '<ol class="nc-tr-caminho">' +
        '<li class="nc-tr-passou" aria-hidden="true">' + ic('passou') + '</li>' +
        (ini > 0 ? '<li class="nc-tr-mais"><span title="Há mais ' + ini + ' página' + (ini > 1 ? 's' : '') + ' para trás">…</span>' + ic('seta', 'nc-tr-sep') + '</li>' : '') +
        vis.map(function (e, j) {
          var i = ini + j, ult = i === atual;
          return '<li' + (ult ? ' class="is-atual"' : '') + '>' +
            (ult ? '<span aria-current="page" title="' + esc(e.t) + '">' + esc(e.t) + '</span>'
                 : '<a href="#" data-ir="' + i + '" title="' + esc(e.t) + '">' + esc(e.t) + '</a>' + ic('seta', 'nc-tr-sep')) + '</li>';
        }).join('') +
      '</ol>';
  }
  function montarFaixa(antesDe) {
    FAIXA = document.createElement('nav');
    FAIXA.className = 'nc-tr';
    FAIXA.setAttribute('aria-label', 'Páginas visitadas nesta aba');
    antesDe.parentNode.insertBefore(FAIXA, antesDe);
    document.body.classList.add('nc-tr-ativo');
    FAIXA.addEventListener('click', function (ev) {
      var b = ev.target.closest('[data-ir]'); if (!b || b.disabled) return;
      ev.preventDefault();
      ir(ler().l[+b.getAttribute('data-ir')]);
    });
    desenhar();
  }

  /* ═══ [T6] CASCA (IFRAME) OU PÁGINA DIRETA ═══════════════════════════════════════════════
     Casca: a página com o iframe grande do conteúdo (fora de janela de diálogo). A faixa vai
     logo acima do iframe (abaixo do menu superior) e o iframe encolhe a altura dela (CSS).
     Página direta: a faixa vai no alto do corpo da página, abaixo do menu superior.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* 04/10: só iframe de PÁGINA DO SISTEMA (mesmo endereço, f?p=). Um vídeo do YouTube num
     conteúdo (OnBoarding 300:2500) era tomado pela casca e a faixa entrava no meio do texto. */
  function doSistema(f) {
    var src = f.getAttribute('src') || '';
    try { var u = new URL(src, location.href); return u.origin === location.origin && /f\?p=|\/r\//.test(u.pathname + u.search); } catch (x) { return false; }
  }
  function iframeDaCasca() {
    var fs = document.querySelectorAll('.t-Body-content iframe, #APP_REGION iframe');
    for (var i = 0; i < fs.length; i++) if (!fs[i].closest('.ui-dialog') && doSistema(fs[i]) && fs[i].getBoundingClientRect().height > 200) return fs[i];
    return null;
  }
  function iniciar() {
    IFRAME = iframeDaCasca();
    if (IFRAME) {
      montarFaixa(IFRAME);
      document.body.classList.add('nc-tr-casca');
      var lerIframe = function () { try { registrar(pagina(IFRAME.contentWindow, 'casca')); } catch (x) { /* outro endereço (fora do sistema): fica de fora */ } };
      IFRAME.addEventListener('load', lerIframe);
      /* veio de uma página direta para uma página da casca: abre a que foi pedida */
      var pedido = null;
      try { pedido = JSON.parse(sessionStorage.getItem(ABRIR) || 'null'); sessionStorage.removeItem(ABRIR); } catch (x) { pedido = null; }
      if (pedido && pedido.u && Date.now() - (pedido.t || 0) < 60000) IFRAME.contentWindow.location.href = pedido.u;
      else if (IFRAME.contentDocument && IFRAME.contentDocument.readyState === 'complete') lerIframe();
      return;
    }
    /* a barra de título do APEX é FIXA no alto (abaixo do menu): a faixa entra DENTRO dela, no
       começo — sobe e desce junto. Sem barra de título, vai no alto do corpo da página. */
    var titulo = document.querySelector('.t-Body-title'), corpo = document.querySelector('.t-Body-content');
    var alvo = titulo && titulo.firstElementChild ? titulo.firstElementChild : corpo && corpo.firstElementChild;
    if (!alvo) return;
    montarFaixa(alvo);
    if (titulo && titulo.contains(FAIXA)) {
      document.body.classList.add('nc-tr-no-titulo');
      /* a barra ficou mais alta: o APEX recalcula o recuo do conteúdo no "resize" */
      setTimeout(function () { window.dispatchEvent(new Event('resize')); if (window.apex && apex.jQuery) apex.jQuery(window).trigger('apexwindowresized'); }, 0);
    }
    registrar(pagina(window, 'topo'));
  }
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp trilha]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else window.addEventListener('load', vai);
})();
