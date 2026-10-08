/* Natcorp — contador entre colchetes nos itens da barra do topo.

   Aplicações que mostram uma contagem no nome do item da barra de navegação escrevem o
   rótulo como "[&P0_QTD_ALERTAS.] Alertas". Com o item vazio, chegava "[] Alertas" na
   tela (Chamados); com número, "[3] Alertas" — os colchetes crus.
   Aqui: colchete vazio (ou zero) some; número vira uma etiqueta depois do nome, que é o
   jeito que a contagem se lê em qualquer outro sistema. O texto para leitor de tela fica
   "Alertas, 3". Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncBarra) return;
  window.__ncBarra = true;

  var PADRAO = /^\s*\[\s*(\d*)\s*\]\s*/;

  function arrumar() {
    var rotulos = document.querySelectorAll('.t-NavigationBar .t-Button-label, .t-NavigationBar-item .t-Button-label');
    for (var i = 0; i < rotulos.length; i++) {
      var el = rotulos[i];
      if (el.__nc) continue;
      var m = (el.textContent || '').match(PADRAO);
      if (!m) continue;
      el.__nc = true;
      var nome = el.textContent.replace(PADRAO, '');
      var n = parseInt(m[1], 10);
      el.textContent = nome;
      if (n > 0) {
        var selo = document.createElement('span');
        selo.className = 'nc-contador';
        selo.textContent = n > 99 ? '99+' : String(n);
        selo.setAttribute('aria-label', ', ' + n);
        el.appendChild(selo);
      }
    }
  }

  /* Menu no topo: dentro do Painel (iframe) a barra é clara — o roxo do painel já está em
     cima dela. Numa JANELA PRÓPRIA (Chamados) ela é o cabeçalho da aplicação e fica no roxo
     do Painel do Operador. O CSS não sabe se a página está num iframe; esta marca diz. */
  function marcarJanela() {
    var propria = true;
    try { propria = window.self === window.top; } catch (e) { propria = false; }
    if (propria && document.body) document.body.classList.add('nc-janela-propria');
  }

  marcarJanela();
  arrumar();
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { marcarJanela(); arrumar(); });
})();
