/* Natcorp — rolar o relatório para os lados sem ir até o fim da página.

   Relatório largo (Férias, Colaboradores: 30 colunas, 3.800 px) rola para os lados dentro
   dele mesmo, e a barra de rolagem fica no FIM da tabela: com 50 linhas, lá embaixo. Com
   mouse, para ver a coluna da direita era preciso descer até o último registro, pegar a
   barra, arrastar e subir de novo.

   Aqui, enquanto a tabela está na tela e a barra dela não, uma CÓPIA da barra fica presa
   no rodapé da janela, na largura do relatório — arrastar uma move a outra. Some sozinha
   quando a barra verdadeira aparece (fim da tabela) ou quando a tabela sai da tela.

   Outras formas que continuam valendo: Shift + rodinha do mouse; o gesto de dois dedos
   no touchpad. Vale para todo relatório interativo, na carga e a cada atualização.
   Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncRolagem || !window.jQuery) return;
  window.__ncRolagem = true;

  var $ = window.jQuery;
  var ligados = [];                 /* { rolo, barra, trilho } */

  /* quem rola: com o cabeçalho fixo o APEX parte a tabela e o corpo é o .t-fht-tbody;
     sem ele, o próprio recipiente da tabela */
  function acharRolos() {
    var cands = document.querySelectorAll('.a-IRR .t-fht-tbody, .a-IRR .a-IRR-tableContainer');
    var out = [];
    for (var i = 0; i < cands.length; i++) {
      var el = cands[i];
      if (el.classList.contains('a-IRR-tableContainer') && el.querySelector('.t-fht-tbody')) continue;
      var ox = window.getComputedStyle(el).overflowX;
      if (ox === 'auto' || ox === 'scroll') out.push(el);
    }
    return out;
  }

  function ligar(rolo) {
    for (var i = 0; i < ligados.length; i++) if (ligados[i].rolo === rolo) return ligados[i];
    var barra = document.createElement('div');
    barra.className = 'nc-barra-lateral';
    barra.setAttribute('aria-hidden', 'true');
    var trilho = document.createElement('div');
    trilho.className = 'nc-barra-lateral-trilho';
    barra.appendChild(trilho);
    document.body.appendChild(barra);

    var item = { rolo: rolo, barra: barra, trilho: trilho, mexendo: null };
    barra.addEventListener('scroll', function () {
      if (item.mexendo === 'rolo') return;
      item.mexendo = 'barra';
      rolo.scrollLeft = barra.scrollLeft;
      requestAnimationFrame(function () { item.mexendo = null; });
    }, { passive: true });
    rolo.addEventListener('scroll', function () {
      if (item.mexendo === 'barra') return;
      item.mexendo = 'rolo';
      barra.scrollLeft = rolo.scrollLeft;
      requestAnimationFrame(function () { item.mexendo = null; });
    }, { passive: true });
    ligados.push(item);
    return item;
  }

  function posicionar(item) {
    var r = item.rolo;
    if (!document.body.contains(r)) {                         /* relatório redesenhado */
      item.barra.remove();
      return false;
    }
    var largo = r.scrollWidth > r.clientWidth + 2;
    var rect = r.getBoundingClientRect();
    var alto = window.innerHeight;
    /* a barra verdadeira fica no fim do rolo: a cópia só enquanto o fim está abaixo da
       janela e a tabela ainda aparece (ao menos 80 px dela) */
    var mostrar = largo && rect.bottom > alto && rect.top < alto - 80 && rect.width > 0;
    item.barra.classList.toggle('is-visivel', mostrar);
    if (mostrar) {
      item.barra.style.left = Math.max(0, rect.left) + 'px';
      item.barra.style.width = Math.min(rect.width, window.innerWidth - Math.max(0, rect.left)) + 'px';
      item.trilho.style.width = r.scrollWidth + 'px';
      if (Math.abs(item.barra.scrollLeft - r.scrollLeft) > 1) item.barra.scrollLeft = r.scrollLeft;
    }
    return true;
  }

  /* A aplicação que já traz o PRÓPRIO plugin de barra flutuante (Chamados, app 118:
     jquery.ba-floatingscrollbar + add-floating-scrollbar) ficava com duas barras presas no
     rodapé, uma sobre a outra — com a região maximizada e depois dela. Lá vale a da
     aplicação; esta sai. O plugin carrega DEPOIS deste arquivo, por isso a checagem é a
     cada atualização, e não na carga. */
  function outroPlugin() {
    return !!($.fn && $.fn.floatingScrollbar) || !!document.querySelector('.floating-scrollbar');
  }

  function atualizar() {
    if (outroPlugin()) {
      for (var i = 0; i < ligados.length; i++) ligados[i].barra.remove();
      ligados = [];
      return;
    }
    var rolos = acharRolos();
    for (var i = 0; i < rolos.length; i++) ligar(rolos[i]);
    ligados = ligados.filter(posicionar);
  }

  var agendado = false;
  function agendar() {
    if (agendado) return;
    agendado = true;
    requestAnimationFrame(function () { agendado = false; atualizar(); });
  }

  window.addEventListener('scroll', agendar, { passive: true });
  window.addEventListener('resize', agendar);
  $(document).on('apexafterrefresh apexwindowresized', function () { setTimeout(agendar, 50); });
  /* colapsar o menu lateral, abrir o painel de filtros… mudam a largura sem "resize" */
  if (window.ResizeObserver) {
    var ro = new ResizeObserver(agendar);
    $(function () { var b = document.querySelector('.t-Body-content'); if (b) ro.observe(b); });
  }
  $(function () { setTimeout(atualizar, 300); });
})();
