/* Natcorp — a região que atualiza mostra que está atualizando, e o conteúdo novo chega.

   Quando uma região recarrega sem trocar a página (o relatório depois de um filtro, uma
   ordenação, a paginação; uma região atualizada por ação dinâmica), o APEX avisa com os
   eventos "apexbeforerefresh" e "apexafterrefresh". Aqui:
     · antes: a região ganha nc-atualizando — o conteúdo recua (fica esmaecido) enquanto o
       carregando da Natcorp gira no meio dela;
     · depois: nc-atualizando sai e entra nc-atualizou por um instante — o conteúdo novo
       chega com um leve assentar.
   O desenho está no Natcorp_Style_Min.css (seção "MOVIMENTO"). A chegada das regiões ao
   abrir a página é só CSS e não depende deste arquivo. Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncAnimacao || !window.jQuery) return;
  window.__ncAnimacao = true;

  var $ = window.jQuery;

  function regiaoDe(el) {
    return el && el.closest ? el.closest('.t-IRR-region, .t-Region') : null;
  }

  $(document).on('apexbeforerefresh', function (e) {
    var r = regiaoDe(e.target);
    if (!r) return;
    r.classList.remove('nc-atualizou');
    r.classList.add('nc-atualizando');
    /* se o "depois" nunca vier (erro na atualização), a região não fica apagada */
    clearTimeout(r.__ncAtualizando);
    r.__ncAtualizando = setTimeout(function () { r.classList.remove('nc-atualizando'); }, 30000);   /* relatório pesado leva 12 s */
  });

  $(document).on('apexafterrefresh', function (e) {
    var r = regiaoDe(e.target);
    if (!r) return;
    clearTimeout(r.__ncAtualizando);
    r.classList.remove('nc-atualizando');
    r.classList.remove('nc-atualizou');
    void r.offsetWidth;                  /* recomeça a animação se vier outra em seguida */
    r.classList.add('nc-atualizou');
    clearTimeout(r.__ncAtualizou);
    r.__ncAtualizou = setTimeout(function () { r.classList.remove('nc-atualizou'); }, 400);
  });
})();
