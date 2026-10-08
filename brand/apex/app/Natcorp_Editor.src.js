/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · EDITOR DE TEXTO RICO  —  o "arrumador" do editor (JavaScript) — SISTEMA TODO   ║
   ║  Item "Rich Text Editor" do APEX 19.2 (CKEditor 4.11), em qualquer aplicação              ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: EDITOR-MANUTENCAO.md. A aparência está no Natcorp_Editor.css (dentro do Style_Min).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Em todo editor de texto rico que existir na página (e nos que aparecerem depois):
     1. LETRA CONFORTÁVEL dentro do texto: a área de escrever é um iframe do CKEditor, com
        Arial 13 px e margens apertadas; aqui ela ganha 15 px, entrelinha 1,6 e respiro. É só a
        APARÊNCIA ao escrever — o texto gravado (o HTML do item) não muda em nada.
     2. "MAIS FERRAMENTAS": os botões raros (recortar/colar, imprimir, modelos do editor, emoji,
        caracteres especiais, quebra de página, fonte e tamanho…) ficam atrás de um "⋯" no fim da
        barra. Um toque mostra todos; outro esconde. Nada é removido. A escolha fica lembrada.
     3. LARGURA: tira a largura fixa em pixels que o APEX escreve (o CSS também cuida disso).
   E se repassa para os iframes do mesmo endereço (as outras aplicações e as janelas), como o
   Natcorp_Registros.js.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não muda a configuração do editor, o valor do item nem o que é gravado ou enviado.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Trazido pelo Natcorp_Temas.js (aplicação casca, 200), lista PECAS — sobe no Workspace Images.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [E1] Os botões raros                                       PODE MEXER
     [E2] A letra dentro do texto                               PODE MEXER
     [E3] Arrumar um editor
     [E4] Achar os editores (agora e depois)
     [E5] Espalhar para os iframes                              CUIDADO
*/
(function () {
  'use strict';
  if (window.__ncEditor) return;
  window.__ncEditor = true;
  var EU = (document.currentScript && document.currentScript.src) || window.__ncEditorSrc || '';
  if (EU) window.__ncEditorSrc = EU;

  /* ═══ [E1] OS BOTÕES RAROS ═══════════════════════════════════════════════════════════════
     PODE MEXER  o nome é o do CKEditor (a classe cke_button__NOME / cke_combo__NOME). Tirar um
                 nome daqui = ele volta a aparecer sempre.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var RAROS = ['cut', 'copy', 'paste', 'pastetext', 'pastefromword', 'print', 'preview', 'newpage', 'save', 'templates',
    'anchor', 'smiley', 'specialchar', 'pagebreak', 'iframe', 'flash', 'showblocks', 'subscript', 'superscript',
    'styles', 'font', 'fontsize', 'selectall', 'find', 'replace', 'scayt', 'about', 'creatediv', 'language',
    'bidiltr', 'bidirtl', 'copyformatting', 'blockquote', 'justifyblock'];
  var CHAVE = 'nc-ed-tudo';

  /* ═══ [E2] A LETRA DENTRO DO TEXTO (só aparência ao escrever) ═════════════════════════════ */
  var LETRA = [
    'html{background:#fff}',
    /* body.cke_editable: o contents.css do CKEditor usa .cke_editable (13 px), que vence "body" */
    'body.cke_editable,body{font-family:Inter,"Inter NC",-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Arial,sans-serif!important;font-size:15px!important;line-height:1.6!important;color:#1B1238;margin:16px 20px!important;max-width:72ch;word-wrap:break-word}',
    'p{margin:0 0 .8em}',
    'a{color:#511C76}',
    'blockquote{margin:.8em 0;padding:2px 0 2px 14px;border-left:3px solid #E9E5F1;color:#4A4460;font-style:normal}',
    'ul,ol{padding-left:1.4em}',
    'h1,h2,h3{line-height:1.3;margin:1em 0 .5em}',
    'table{border-collapse:collapse}td,th{border:1px solid #E9E5F1;padding:6px 8px}',
    'img{max-width:100%;height:auto}',
    '::selection{background:rgba(81,28,118,.16)}'
  ].join('');

  /* ═══ [E3] ARRUMAR UM EDITOR ═════════════════════════════════════════════════════════════ */
  var MAIS = '<svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="5.5" cy="12" r="1.8"/><circle cx="12" cy="12" r="1.8"/><circle cx="18.5" cy="12" r="1.8"/></svg>';
  function lembrado() { try { return localStorage.getItem(CHAVE) === '1'; } catch (e) { return false; } }
  function letra(ed) {
    try {
      var d = ed.document && ed.document.$;            /* o documento do iframe de escrever */
      if (!d || !d.head || d.getElementById('nc-ed-letra')) return;
      var st = d.createElement('style'); st.id = 'nc-ed-letra'; st.textContent = LETRA; d.head.appendChild(st);
    } catch (e) { /* modo código-fonte: sem iframe */ }
  }
  function arrumar(ed) {
    if (!ed || ed.__ncEd) { if (ed) letra(ed); return; }
    ed.__ncEd = true;
    var c = ed.container && ed.container.$; if (!c) return;
    c.style.width = '';
    letra(ed);
    ed.on('contentDom', function () { letra(ed); });            /* volta do código-fonte, setData… */
    var caixa = c.querySelector('.cke_toolbox'); if (!caixa) return;
    /* marca os raros e os grupos que só têm raros */
    var algum = false;
    RAROS.forEach(function (n) {
      [].forEach.call(caixa.querySelectorAll('.cke_button__' + n + ', .cke_combo__' + n), function (b) { b.classList.add('nc-ed-extra'); algum = true; });
    });
    [].forEach.call(caixa.querySelectorAll('.cke_toolbar'), function (g) {
      var itens = g.querySelectorAll('.cke_button, .cke_combo');
      if (itens.length && [].every.call(itens, function (b) { return b.classList.contains('nc-ed-extra'); })) g.classList.add('nc-ed-extra');
    });
    /* separador que ficaria sobrando (no começo, no fim ou colado a outro, depois de esconder os
       raros) também vira raro */
    [].forEach.call(caixa.querySelectorAll('.cke_toolgroup'), function (gr) {
      var antes = false, pendente = null;
      [].forEach.call(gr.children, function (x) {
        var vis = !x.classList.contains('nc-ed-extra');
        if (x.classList.contains('cke_toolbar_separator')) { if (!antes || pendente) x.classList.add('nc-ed-extra'); else pendente = x; return; }
        if (vis) { antes = true; pendente = null; }
      });
      if (pendente) pendente.classList.add('nc-ed-extra');
    });
    /* o primeiro grupo à vista não leva o fio da esquerda */
    var primeiro = [].filter.call(caixa.querySelectorAll('.cke_toolbar'), function (g) { return !g.classList.contains('nc-ed-extra'); })[0];
    if (primeiro) primeiro.classList.add('nc-ed-primeiro');
    if (!algum) return;
    if (lembrado()) c.classList.add('nc-ed-tudo');
    var g = document.createElement('span');
    g.className = 'cke_toolbar nc-ed-mais-grupo';
    g.innerHTML = '<span class="cke_toolgroup"><a class="cke_button nc-ed-mais" href="javascript:void(0)" role="button" tabindex="0" title="Mais ferramentas" aria-pressed="' + c.classList.contains('nc-ed-tudo') + '">' + MAIS + '<span>Mais</span></a></span>';
    caixa.appendChild(g);
    var bt = g.querySelector('a');
    var alternar = function (e) {
      if (e) e.preventDefault();
      var on = c.classList.toggle('nc-ed-tudo');
      bt.setAttribute('aria-pressed', String(on)); bt.querySelector('span').textContent = on ? 'Menos' : 'Mais';
      bt.title = on ? 'Esconder as ferramentas raras' : 'Mais ferramentas';
      try { localStorage.setItem(CHAVE, on ? '1' : '0'); } catch (x) { /* sem armazenamento */ }
    };
    if (c.classList.contains('nc-ed-tudo')) { bt.querySelector('span').textContent = 'Menos'; bt.title = 'Esconder as ferramentas raras'; }
    bt.addEventListener('click', alternar);
    bt.addEventListener('keydown', function (e) { if (e.key === 'Enter' || e.key === ' ') alternar(e); });
  }

  /* ═══ [E4] ACHAR OS EDITORES (agora e os que aparecerem depois) ══════════════════════════ */
  function ligar() {
    var CK = window.CKEDITOR; if (!CK || CK.__ncEd) return !!CK;
    CK.__ncEd = true;
    Object.keys(CK.instances || {}).forEach(function (k) {
      var ed = CK.instances[k];
      if (ed.status === 'ready') arrumar(ed); else ed.on('instanceReady', function () { arrumar(ed); });
    });
    CK.on('instanceReady', function (ev) { arrumar(ev.editor); });
    return true;
  }
  if (!ligar()) {
    /* o CKEditor só existe nas páginas com editor; espera ele até a página terminar de abrir */
    var n = 0, t = setInterval(function () { if (ligar() || ++n > 40) clearInterval(t); }, 250);
  }

  /* ═══ [E5] ESPALHAR PARA OS IFRAMES (as outras aplicações e as janelas) ══════════════════
     CUIDADO  Mesmo jeito do Natcorp_Registros.js [R7]: só iframes do mesmo endereço com APEX;
              cada janela guarda window.__ncEditor para não carregar duas vezes.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function porNoIframe(f) {
    try {
      var w = f.contentWindow, d = f.contentDocument;
      if (!w || !d || w.__ncEditor || !w.apex || !d.head || !EU) return;
      if (d.querySelector('script[src*="Natcorp_Editor.js"]')) return;
      var s = d.createElement('script'); s.src = EU; d.head.appendChild(s);
    } catch (e) { /* iframe de outro endereço: não é nosso */ }
  }
  function vigiar(f) {
    if (f.__ncEdVigia) return;
    f.__ncEdVigia = true;
    f.addEventListener('load', function () { porNoIframe(f); });
    porNoIframe(f);
  }
  [].forEach.call(document.querySelectorAll('iframe'), vigiar);
  if (window.MutationObserver) {
    new MutationObserver(function (ms) {
      ms.forEach(function (m) {
        [].forEach.call(m.addedNodes, function (no) {
          if (no.nodeType !== 1) return;
          if (no.tagName === 'IFRAME') { if (!no.classList.contains('cke_wysiwyg_frame')) vigiar(no); }
          else if (no.querySelector) [].forEach.call(no.querySelectorAll('iframe:not(.cke_wysiwyg_frame)'), vigiar);
        });
      });
    }).observe(document.documentElement, { childList: true, subtree: true });
  }
})();
