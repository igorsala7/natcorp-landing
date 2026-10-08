/* Natcorp — os títulos das colunas acompanham a rolagem em TODO relatório interativo.

   1. CABEÇALHO FIXO POR PADRÃO. No APEX isso é uma opção de cada relatório (Atributos ›
      Cabeçalho Fixo em: Página / Região / Nenhum). Aqui, o relatório que está em
      "Nenhum" passa a se comportar como "Página": ao descer a lista, a linha com os nomes
      das colunas fica presa embaixo da barra de título. "Região" continua como está.
      Para manter um relatório sem cabeçalho fixo: Região › Aparência › Classes CSS →
      nc-sem-cabecalho-fixo.

   2. SEM FAIXA TRANSPARENTE EM CIMA DOS TÍTULOS. O tema calcula onde o cabeçalho para
      (apex.theme.defaultStickyTop) somando 12 px sempre que a página tem um seletor de
      abas ("Region Display Selector"), para abrir espaço à faixa das abas. Em páginas com
      o seletor SEM NENHUMA ABA (Férias e outras consultas) não há faixa nenhuma: sobravam
      12 px transparentes entre a barra de título e os nomes das colunas, com as linhas
      passando por trás. Sem abas, os 12 px saem.

   Precisa carregar antes de a página montar os relatórios — o APEX põe os arquivos da
   aplicação antes do código de inicialização, então basta estar no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncCabecalhoRelatorio || !window.jQuery || !window.apex) return;
  window.__ncCabecalhoRelatorio = true;

  var $ = window.jQuery;

  function rdsSemAbas() {
    return !!document.querySelector('.apex-rds-container') &&
      !document.querySelector('.apex-rds-container .apex-rds > li');
  }

  /* ---------- 2. o topo do cabeçalho preso ---------- */
  function corrigirTopo() {
    if (!apex.theme || typeof apex.theme.defaultStickyTop !== 'function' || apex.theme.defaultStickyTop.__nc) return;
    var original = apex.theme.defaultStickyTop;
    var corrigido = function () {
      var h = original.apply(this, arguments);
      return rdsSemAbas() ? h - 12 : h;
    };
    corrigido.__nc = true;
    apex.theme.defaultStickyTop = corrigido;
  }

  /* ---------- 1. cabeçalho fixo por padrão ---------- */
  function semFixoPorEscolha(el) {
    var reg = el && el.closest && el.closest('.t-IRR-region, .t-Region');
    return !!(reg && reg.classList.contains('nc-sem-cabecalho-fixo'));
  }

  function fixarPorPadrao() {
    var W = $.apex && $.apex.interactiveReport;
    if (!W || !W.prototype || typeof W.prototype._initFixedHeader !== 'function' || W.prototype._initFixedHeader.__nc) return false;
    var original = W.prototype._initFixedHeader;
    var novo = function () {
      if (this.options && this.options.fixedHeader === 'NONE' && !semFixoPorEscolha(this.element && this.element[0])) {
        this.options.fixedHeader = 'PAGE';
      }
      return original.apply(this, arguments);
    };
    novo.__nc = true;
    W.prototype._initFixedHeader = novo;
    return true;
  }

  /* relatórios que já montaram antes deste arquivo (carregado tarde): aplica agora */
  function aplicarNosMontados() {
    $('.a-IRR-container').each(function () {
      var inst = $(this).data('apexInteractiveReport');
      if (!inst || inst.options.fixedHeader !== 'NONE' || semFixoPorEscolha(this)) return;
      if (this.querySelector('.t-fht-wrapper')) return;
      try { inst._initFixedHeader(true); } catch (e) { /* versão sem esse método */ }
    });
    /* e os cabeçalhos já presos recalculam o topo */
    $('.js-stickyWidget-toggle').each(function () {
      var w = $(this).data('apexStickyWidget');
      if (w && typeof w.refresh === 'function') { try { w.refresh(); } catch (e) {} }
    });
  }

  corrigirTopo();
  fixarPorPadrao();
  $(function () {
    corrigirTopo();
    fixarPorPadrao();
    setTimeout(aplicarNosMontados, 0);
  });
})();
