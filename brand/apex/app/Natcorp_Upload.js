/* Natcorp — realce da área de soltar dos campos de arquivo (File Browse).
   O arrastar-e-soltar em si é do navegador (o Natcorp_Login.css estica o campo sobre a área);
   isto só liga as classes que o CSS usa:
     .is-dragover  — enquanto um arquivo passa por cima da área
     .tem-arquivo  — depois que um arquivo foi escolhido (por clique ou por soltar)
   Pode ir colado no fim do iframe_handling.js, como o Natcorp_Alert.js. */
(function () {
  'use strict';

  function area(e) {
    var t = e.target;
    return t && t.closest ? t.closest('.apex-item-group--file') : null;
  }

  ['dragenter', 'dragover'].forEach(function (tipo) {
    document.addEventListener(tipo, function (e) {
      var a = area(e);
      if (a) a.classList.add('is-dragover');
    }, true);
  });

  ['dragleave', 'drop'].forEach(function (tipo) {
    document.addEventListener(tipo, function (e) {
      var a = area(e);
      /* dragleave dispara ao passar para um filho: só apaga ao sair da área de verdade */
      if (a && (tipo === 'drop' || !a.contains(e.relatedTarget))) a.classList.remove('is-dragover');
    }, true);
  });

  document.addEventListener('change', function (e) {
    var i = e.target;
    if (!i || i.type !== 'file') return;
    var a = i.closest('.apex-item-group--file');
    if (a) a.classList.toggle('tem-arquivo', !!(i.files && i.files.length));
  }, true);
})();
