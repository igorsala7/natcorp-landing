/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · LISTA DE ESCOLHA (POPUP LOV)  —  o "arrumador" (JavaScript) — SISTEMA TODO     ║
   ║  Item "Popup LOV" do APEX 19.2 com VÁRIAS colunas, em qualquer aplicação                  ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: LOV-MANUTENCAO.md. A aparência está no Natcorp_Lov.css (dentro do Style_Min).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   A janela "Caixa de Diálogo Pesquisar" do Popup LOV com várias colunas abria com 700 px e 14
   colunas espremidas ("576…", "Ass…", "Nat…") — impossível achar o que escolher. Quando a lista
   tem 3 colunas ou mais:
     • a JANELA cresce (até 1000 px e 86% da altura) e o título vira o nome do campo;
     • cada resultado vira um CARTÃO: o nome do item em destaque e as outras colunas como
       "rótulo valor" seguidos (vazios e "-" saem); o que foi digitado na busca fica marcado;
     • ESCOLHER é o mesmo de antes: o toque/Enter no cartão aciona a linha ORIGINAL da grade —
       o APEX devolve o valor e roda as ações do campo como sempre;
     • TECLADO: da busca, ↓ entra nos cartões; ↑/↓ andam; Enter escolhe; ↑ no primeiro volta
       para a busca; Esc fecha (do APEX);
     • "Cartões | Tabela" (lembrado): a Tabela é a grade original, inteira;
     • "- Selecione -" vira "Deixar em branco" (o mesmo botão, que limpa o campo).
   Lista com 1 ou 2 colunas não muda.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não muda a consulta, a busca (continua a do APEX, no servidor), nem o valor devolvido.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Trazido pelo Natcorp_Temas.js (aplicação casca, 200), lista PECAS, e repassado aos iframes.
     CUIDADO: o APEX abre esta janela na janela PRINCIPAL (a casca), mesmo quando o campo está
     numa aplicação dentro de um iframe — por isso o arquivo precisa estar no alto também.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [L1] Ajustes                                               PODE MEXER
     [L2] Ferramentas
     [L3] Ler a grade (títulos e linhas)                        CUIDADO
     [L4] Desenhar os cartões
     [L5] Escolher e o teclado
     [L6] Montar a janela
     [L7] Achar as janelas (agora e depois)
     [L8] Espalhar para os iframes
*/
(function () {
  'use strict';
  if (window.__ncLov) return;
  window.__ncLov = true;
  var EU = (document.currentScript && document.currentScript.src) || window.__ncLovSrc || '';
  if (EU) window.__ncLovSrc = EU;

  /* ═══ [L1] AJUSTES ═══════════════════════════════════════════════════════════════════════ */
  var MIN_COLUNAS = 3;          /* a partir de quantas colunas a lista vira cartões */
  var LARGURA_MAX = 1000;       /* px */
  var CHAVE = 'nc-lov-visao';   /* lembra Cartões | Tabela */

  /* ═══ [L2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function vazio(t) { return !t || /^[\s\-–]*$/.test(t); }
  function nome(t) { return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); }); }
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  /* marca o termo buscado (sem acento/maiúscula), devolvendo HTML seguro */
  function marcar(texto, termo) {
    texto = String(texto || ''); var t = sem(termo).trim();
    if (!t) return esc(texto);
    var base = sem(texto), out = '', i = 0, k;
    while ((k = base.indexOf(t, i)) >= 0) { out += esc(texto.slice(i, k)) + '<mark>' + esc(texto.slice(k, k + t.length)) + '</mark>'; i = k + t.length; }
    return out + esc(texto.slice(i));
  }
  function lembrada() { try { return localStorage.getItem(CHAVE) === 'tabela' ? 'tabela' : 'cartoes'; } catch (e) { return 'cartoes'; } }

  /* ═══ [L3] LER A GRADE ═══════════════════════════════════════════════════════════════════
     CUIDADO  A grade (a-GV) tem DUAS tabelas: a do cabeçalho fixo (.a-GV-hdr, com os títulos)
              e a de dados (.a-GV-w-scroll). A célula com a-GV-rowHeader é a coluna de EXIBIÇÃO
              do LOV (o nome do item) — vira o título do cartão.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function titulos(dlg) {
    return [].map.call(dlg.querySelectorAll('.a-GV-hdr thead th'), function (th) { return (th.textContent || '').replace(/\s+/g, ' ').trim(); });
  }
  function linhas(dlg) {
    var tb = dlg.querySelector('.a-GV-w-scroll table tbody');
    return tb ? [].slice.call(tb.querySelectorAll(':scope > tr')) : [];
  }

  /* ═══ [L4] DESENHAR OS CARTÕES ═══════════════════════════════════════════════════════════ */
  function desenhar(dlg) {
    var lista = dlg.querySelector('.nc-lov-lista'); if (!lista) return;
    /* se um cartão tinha o foco, ele volta para o mesmo lugar depois de redesenhar */
    var ativo = document.activeElement, focoEm = ativo && lista.contains(ativo) && ativo.getAttribute('data-i');
    var cols = titulos(dlg), trs = linhas(dlg);
    var termo = (dlg.querySelector('.a-PopupLOV-search') || {}).value || '';
    lista.innerHTML = trs.map(function (tr, i) {
      var tds = [].slice.call(tr.querySelectorAll('td'));
      var tCel = tr.querySelector('td.a-GV-rowHeader') || tds[0];
      var titulo = tCel ? tCel.textContent.replace(/\s+/g, ' ').trim() : '';
      var fatos = tds.map(function (td, k) {
        if (td === tCel) return '';
        var v = td.textContent.replace(/\s+/g, ' ').trim();
        if (vazio(v) || (titulo && titulo.indexOf(v) >= 0 && v.length > 2)) return '';   /* vazio, ou já está no título */
        return '<span class="nc-lov-fato"><i>' + esc(cols[k] || '') + '</i> ' + marcar(/[a-z]/.test(v) ? v : (/^\d/.test(v) && v.indexOf(' - ') > 0 ? v.replace(/ - (.+)$/, function (m, r) { return ' - ' + nome(r); }) : v), termo) + '</span>';
      }).join('');
      var atual = tr.classList.contains('is-selected') || tr.getAttribute('aria-selected') === 'true';
      return '<li class="nc-lov-item' + (atual ? ' is-atual' : '') + '" role="option" tabindex="-1" data-i="' + i + '" aria-selected="' + atual + '">' +
        '<p class="nc-lov-tit">' + marcar(titulo, termo) + (atual ? ' <span class="nc-lov-selo">escolhido</span>' : '') + '</p>' +
        (fatos ? '<p class="nc-lov-fatos">' + fatos + '</p>' : '') + '</li>';
    }).join('');
    if (focoEm !== null && focoEm !== undefined && focoEm !== false) focar(dlg, +focoEm);
    larguras(dlg);
    var conta = dlg.querySelector('.nc-lov-conta');
    if (conta) {
      var mais = dlg.querySelector('.a-GV-loadMoreButton, .a-GV-moreDataMsg');
      var temMais = mais && mais.offsetParent !== null;
      conta.textContent = trs.length ? (trs.length === 1 ? '1 resultado' : trs.length + ' resultados') + (temMais ? ' — role para ver mais' : '') + (termo ? ' para “' + termo + '”' : '') : '';
    }
  }

  /* ═══ [L4b] A TABELA LEGÍVEL ════════════════════════════════════════════════════════════
     A grade do APEX divide a largura POR IGUAL entre as colunas: com 14 colunas tudo vira "Natco…".
     No modo Tabela cada coluna ganha a largura do que precisa mostrar (título e valores, medidos
     com a letra da grade), entre COL_MIN e COL_MAX; a tabela rola de lado e o cabeçalho junto.
     CUIDADO  o cabeçalho fixo e as linhas são DUAS tabelas: as MESMAS larguras vão nos <col> das
              duas (e na largura de cada tabela), senão os títulos saem do lugar.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COL_MIN = 70, COL_MAX = 360, REGUA = null;
  function medir(txt, fonte) {
    REGUA = REGUA || document.createElement('canvas').getContext('2d');
    REGUA.font = fonte; return REGUA.measureText(txt).width;
  }
  function larguras(dlg) {
    if (!dlg.closest('.nc-lov-tabela')) return;
    var hdr = dlg.querySelector('.a-GV-hdr table'), bdy = dlg.querySelector('.a-GV-w-scroll > table');
    if (!hdr || !bdy) return;
    var ths = hdr.querySelectorAll('thead th'), trs = linhas(dlg).slice(0, 60);
    if (!ths.length) return;
    var celula = trs[0] && trs[0].querySelector('td'), th0 = ths[0];
    var cs = celula ? getComputedStyle(celula) : null, ch = getComputedStyle(th0);
    var fC = cs ? cs.fontWeight + ' ' + cs.fontSize + ' ' + cs.fontFamily : '400 13px sans-serif';
    var fH = ch.fontWeight + ' ' + ch.fontSize + ' ' + ch.fontFamily;
    var folga = (cs ? parseFloat(cs.paddingLeft) + parseFloat(cs.paddingRight) : 20) + 6;
    var ws = [].map.call(ths, function (th, k) {
      var w = medir(th.textContent.trim(), fH) + folga + 8;
      trs.forEach(function (tr) { var td = tr.children[k]; if (td) w = Math.max(w, medir(td.textContent.trim(), fC) + folga); });
      return Math.round(Math.max(COL_MIN, Math.min(COL_MAX, w)));
    });
    var total = ws.reduce(function (a, b) { return a + b; }, 0);
    var cheio = dlg.querySelector('.a-GV-w-scroll').clientWidth;
    if (total < cheio) { var extra = (cheio - total) / ws.length; ws = ws.map(function (w) { return Math.floor(w + extra); }); total = ws.reduce(function (a, b) { return a + b; }, 0); }
    [hdr, bdy].forEach(function (t) {
      var cols = t.querySelectorAll('colgroup col');
      ws.forEach(function (w, k) { if (cols[k]) cols[k].style.width = w + 'px'; });
      t.style.width = total + 'px'; t.style.minWidth = total + 'px';
    });
    /* o cabeçalho acompanha a rolagem de lado */
    var rola = dlg.querySelector('.a-GV-w-scroll'), wh = dlg.querySelector('.a-GV-w-hdr');
    if (rola && wh && !rola.__ncSync) { rola.__ncSync = true; rola.addEventListener('scroll', function () { wh.scrollLeft = rola.scrollLeft; }); }
    if (wh && rola) wh.scrollLeft = rola.scrollLeft;
  }

  /* ═══ [L5] ESCOLHER E O TECLADO ══════════════════════════════════════════════════════════
     Escolher = clicar na linha ORIGINAL (a grade do APEX faz o resto: devolve o valor, fecha a
     janela e dispara o change do campo).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function escolher(dlg, i) {
    var tr = linhas(dlg)[i]; if (!tr) return;
    var td = tr.querySelector('td.a-GV-rowHeader') || tr.querySelector('td'); if (!td) return;
    ['mousedown', 'mouseup', 'click'].forEach(function (t) { td.dispatchEvent(new MouseEvent(t, { bubbles: true, cancelable: true, view: window, button: 0 })); });
  }
  function focar(dlg, i) {
    var itens = dlg.querySelectorAll('.nc-lov-item'); if (!itens.length) return;
    i = Math.max(0, Math.min(itens.length - 1, i));
    var li = itens[i]; li.focus(); li.scrollIntoView({ block: 'nearest' });
  }
  function teclado(dlg) {
    var busca = dlg.querySelector('.a-PopupLOV-search'), lista = dlg.querySelector('.nc-lov-lista');
    /* CUIDADO  o APEX trata o ↓ da busca antes (leva o foco para a grade escondida): por isso a
                escuta é na JANELA, em captura — roda antes de qualquer outra */
    var cartoes = function () { return dlg.closest('.nc-lov') && !dlg.closest('.nc-lov-tabela'); };
    /* (o campo de busca é REDESENHADO pelo APEX: compara pela classe, não pelo elemento guardado) */
    window.addEventListener('keydown', function (e) {
      if (e.key !== 'ArrowDown' || !cartoes() || !dlg.contains(e.target)) return;
      if (!e.target.closest('.a-PopupLOV-searchBar, .a-PopupLOV-clear')) return;
      e.preventDefault(); e.stopImmediatePropagation(); focar(dlg, 0);
    }, true);
    /* se mesmo assim o foco cair na grade escondida (cabeçalho ou célula), passa para o cartão */
    dlg.addEventListener('focusin', function (e) {
      if (!cartoes() || !e.target.closest) return;
      if (!e.target.closest('.a-GV-hdr, .a-GV-w-scroll > table')) return;
      var tr = e.target.closest('tbody tr'), i = tr ? linhas(dlg).indexOf(tr) : 0;
      focar(dlg, Math.max(0, i));
    });
    lista.addEventListener('keydown', function (e) {
      var li = e.target.closest('.nc-lov-item'); if (!li) return;
      var i = +li.getAttribute('data-i');
      /* a lista mora DENTRO da grade: sem isto a grade também andaria (e mudaria a seleção dela) */
      if (/^(ArrowDown|ArrowUp|Enter| |Home|End)$/.test(e.key)) e.stopPropagation();
      if (e.key === 'ArrowDown') { e.preventDefault(); focar(dlg, i + 1); }
      else if (e.key === 'ArrowUp') { e.preventDefault(); var bq = dlg.querySelector('.a-PopupLOV-search'); if (i === 0 && bq) bq.focus(); else focar(dlg, i - 1); }
      else if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); escolher(dlg, i); }
      else if (e.key === 'Home') { e.preventDefault(); focar(dlg, 0); }
      else if (e.key === 'End') { e.preventDefault(); focar(dlg, 1e6); }
    });
    lista.addEventListener('click', function (e) { var li = e.target.closest('.nc-lov-item'); if (li) { e.stopPropagation(); escolher(dlg, +li.getAttribute('data-i')); } });
  }

  /* ═══ [L6] MONTAR A JANELA ═══════════════════════════════════════════════════════════════ */
  function rotuloDoCampo(dlg) {
    var m = /^PopupLov_\d+_(.+)_dlg$/.exec(dlg.id || ''); if (!m) return '';
    var id = m[1] + '_LABEL', achado = '';
    (function busca(w, n) {
      if (achado || n > 4) return;
      try { var l = w.document.getElementById(id); if (l) { achado = l.textContent.replace(/\(Valor Necessário\)|\*/gi, '').replace(/\s+/g, ' ').trim(); return; } } catch (e) { return; }
      for (var k = 0; k < w.frames.length; k++) busca(w.frames[k], n + 1);
    })(window.top || window, 0);
    return achado;
  }
  function tamanho(dlg) {
    var $ = window.apex && apex.jQuery; if (!$) return;
    try {
      var $d = $(dlg);
      $d.dialog('option', { width: Math.min(LARGURA_MAX, window.innerWidth - 24), height: Math.min(Math.round(window.innerHeight * 0.86), 820) });
      $d.dialog('option', 'position', { my: 'center', at: 'center', of: window });
      /* a grade só se ajusta quando alguém arrasta a borda (o "resize" do dialog): chama o mesmo */
      /* CUIDADO  resizeStop do APEX lê ui.size — sem ele dá erro (e a grade não recalcula) */
      var o = $d.dialog('option'), $j = $d.closest('.ui-dialog');
      var ui = { size: { width: $j.outerWidth(), height: $j.outerHeight() }, originalSize: { width: $j.outerWidth(), height: $j.outerHeight() }, position: $j.position(), originalPosition: $j.position() };
      ['resize', 'resizeStop'].forEach(function (k) { if (typeof o[k] === 'function') { try { o[k].call(dlg, $.Event('dialog' + k.toLowerCase()), ui); } catch (e) { /* segue */ } } });
      larguras(dlg);   /* a grade acabou de redistribuir por igual: volta às larguras do conteúdo */
    } catch (e) { /* não é um dialog jQuery UI */ }
  }
  function montar(dlg) {
    var janela = dlg.closest('.ui-dialog'); if (!janela) return;
    var cols = titulos(dlg);
    if (cols.length < MIN_COLUNAS) return;
    if (dlg.__ncLov) { tamanho(dlg); desenhar(dlg); return; }
    dlg.__ncLov = true;
    janela.classList.add('nc-lov');
    if (lembrada() === 'tabela') janela.classList.add('nc-lov-tabela');
    var nome = rotuloDoCampo(dlg), tit = janela.querySelector('.ui-dialog-title');
    if (nome && tit) tit.textContent = frase(nome);
    /* barra: quantos + Cartões | Tabela */
    var barra = document.createElement('div');
    barra.className = 'nc-lov-barra';
    barra.innerHTML = '<span class="nc-lov-conta" aria-live="polite"></span>' +
      '<span class="nc-lov-visao" role="group" aria-label="Ver como"><button type="button" data-v="cartoes">Cartões</button><button type="button" data-v="tabela">Tabela</button></span>';
    var res = dlg.querySelector('.a-PopupLOV-results');
    res.parentNode.insertBefore(barra, res);
    var marca = function () { [].forEach.call(barra.querySelectorAll('[data-v]'), function (b) { b.setAttribute('aria-pressed', String((b.getAttribute('data-v') === 'tabela') === janela.classList.contains('nc-lov-tabela'))); }); };
    marca();
    barra.addEventListener('click', function (e) {
      var b = e.target.closest('[data-v]'); if (!b) return;
      janela.classList.toggle('nc-lov-tabela', b.getAttribute('data-v') === 'tabela');
      if (b.getAttribute('data-v') === 'tabela') requestAnimationFrame(function () { larguras(dlg); });
      else [].forEach.call(dlg.querySelectorAll('.a-GV-hdr table, .a-GV-w-scroll > table'), function (t) { t.style.minWidth = ''; t.style.width = ''; });   /* Cartões: a lista volta à largura da janela */
      try { localStorage.setItem(CHAVE, b.getAttribute('data-v')); } catch (x) { /* sem armazenamento */ }
      marca();
    });
    /* "- Selecione -" (o valor nulo) vira "Deixar em branco" */
    var limpa = dlg.querySelector('.a-PopupLOV-clearButton');
    if (limpa && /selecione/i.test(limpa.textContent)) limpa.textContent = 'Deixar em branco';
    /* a lista de cartões entra junto da grade (a rolagem e o "carregar mais" continuam os dela) */
    var rola = dlg.querySelector('.a-GV-w-scroll'), tab = rola && rola.querySelector('table');
    if (!rola || !tab) return;
    var lista = document.createElement('ol');
    lista.className = 'nc-lov-lista'; lista.setAttribute('role', 'listbox'); lista.setAttribute('aria-label', nome || 'Resultados');
    rola.insertBefore(lista, tab.nextSibling);
    teclado(dlg);
    /* arrastar a borda da janela faz a grade redistribuir por igual: volta às larguras do conteúdo */
    if (window.apex && apex.jQuery) apex.jQuery(dlg).on('dialogresizestop', function () { setTimeout(function () { larguras(dlg); }, 0); });
    var agendado = false;
    var redesenhar = function () { if (agendado) return; agendado = true; requestAnimationFrame(function () { agendado = false; desenhar(dlg); }); };
    new MutationObserver(function (ms) {
      if (ms.some(function (m) { return !lista.contains(m.target) && m.target !== lista; })) redesenhar();
    }).observe(rola, { childList: true, subtree: true, characterData: true, attributes: true, attributeFilter: ['class', 'aria-selected'] });
    tamanho(dlg);
    desenhar(dlg);
  }

  /* ═══ [L7] ACHAR AS JANELAS (agora e as que abrirem depois) ══════════════════════════════
     A janela do Popup LOV é criada na primeira vez e REAPROVEITADA nas seguintes (só mostra de
     novo): por isso olha também quando ela volta a aparecer (dialogopen).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* CUIDADO  só age quando a janela PASSA de escondida a visível: ajustar o tamanho muda o style
              dela, e reagir a isso de novo daria um laço sem fim */
  function procurar() {
    [].forEach.call(document.querySelectorAll('.a-PopupLOV-dialog'), function (d) {
      var j = d.closest('.ui-dialog'); if (!j) return;
      var vis = getComputedStyle(j).display !== 'none';
      if (vis && !j.__ncAberta) { j.__ncAberta = true; montar(d); }
      else if (!vis) j.__ncAberta = false;
    });
  }
  var pendente = false;
  function agendar() { if (pendente) return; pendente = true; setTimeout(function () { pendente = false; procurar(); }, 60); }
  if (window.MutationObserver) {
    new MutationObserver(function (ms) {
      for (var k = 0; k < ms.length; k++) {
        var m = ms[k];
        if (m.target.closest && m.target.closest('.nc-lov-lista')) continue;
        if (m.type === 'childList' || (m.target.classList && m.target.classList.contains('ui-dialog-popuplov'))) { agendar(); return; }
      }
    }).observe(document.body || document.documentElement, { childList: true, subtree: true, attributes: true, attributeFilter: ['style'] });
  }
  window.addEventListener('resize', function () { [].forEach.call(document.querySelectorAll('.nc-lov .a-PopupLOV-dialog'), function (d) { if (d.closest('.ui-dialog').style.display !== 'none') tamanho(d); }); });
  procurar();

  /* ═══ [L8] ESPALHAR PARA OS IFRAMES (as outras aplicações e as janelas) ══════════════════ */
  function porNoIframe(f) {
    try {
      var w = f.contentWindow, d = f.contentDocument;
      if (!w || !d || w.__ncLov || !w.apex || !d.head || !EU) return;
      if (d.querySelector('script[src*="Natcorp_Lov.js"]')) return;
      var s = d.createElement('script'); s.src = EU; d.head.appendChild(s);
    } catch (e) { /* iframe de outro endereço: não é nosso */ }
  }
  function vigiar(f) {
    if (f.__ncLovVigia || (f.classList && f.classList.contains('cke_wysiwyg_frame'))) return;
    f.__ncLovVigia = true;
    f.addEventListener('load', function () { porNoIframe(f); });
    porNoIframe(f);
  }
  [].forEach.call(document.querySelectorAll('iframe'), vigiar);
  if (window.MutationObserver) {
    new MutationObserver(function (ms) {
      ms.forEach(function (m) {
        [].forEach.call(m.addedNodes, function (no) {
          if (no.nodeType !== 1) return;
          if (no.tagName === 'IFRAME') vigiar(no); else if (no.querySelector) [].forEach.call(no.querySelectorAll('iframe'), vigiar);
        });
      });
    }).observe(document.documentElement, { childList: true, subtree: true });
  }
})();
