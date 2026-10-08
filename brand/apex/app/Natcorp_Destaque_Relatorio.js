/* Natcorp — a cor do DESTAQUE do relatório interativo vale de verdade.

   O destaque (Ações › Formatar › Destacar: "marcar em amarelo as linhas em que…") o APEX
   aplica por classe: a linha ganha "rule_<id>" e a página recebe
   <style>.rule_<id> td { background-color: #FFF5CE !important; color: … !important }</style>.
   Esse seletor é fraco: as regras de célula da Skin (html body .a-IRR-table td { color:
   … !important }) vencem, e a cor de TEXTO escolhida no destaque não aparecia (o fundo o
   Natcorp_Style_Min.css já deixa passar). Este script copia cada regra de destaque com um
   seletor mais forte — a mesma cor, o mesmo alcance, agora acima de tudo.

   Vale para todo relatório interativo, na carga e a cada atualização (filtro, ordem,
   paginação: o APEX troca o <style> junto com o relatório). Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncDestaque) return;
  window.__ncDestaque = true;

  /* três ids: acima do prefixo do Natcorp_Style_Min.css (dois) */
  var FORTE = 'html body:not(#nc-d1):not(#nc-d2):not(#nc-d3) ';

  function reforcar() {
    var estilos = document.querySelectorAll('style:not([data-nc-destaque])');
    for (var i = 0; i < estilos.length; i++) {
      var st = estilos[i];
      if (st.__ncDestaque || !/\.rule_\d+/.test(st.textContent)) continue;
      st.__ncDestaque = true;
      var css = st.textContent.replace(/([^{}]+)\{([^{}]*)\}/g, function (bloco, seletores, corpo) {
        if (!/\.rule_\d+/.test(seletores)) return '';
        var fortes = seletores.split(',').map(function (x) { return FORTE + x.trim(); }).join(', ');
        return fortes + ' {' + corpo + '}';
      });
      if (!css.trim()) continue;
      var novo = document.createElement('style');
      novo.setAttribute('data-nc-destaque', '');
      novo.textContent = css;
      st.parentNode.insertBefore(novo, st.nextSibling);
    }
  }

  reforcar();
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', reforcar);
  if (window.apex && apex.jQuery) apex.jQuery(document).on('apexafterrefresh', function () { setTimeout(reforcar, 0); });
})();
