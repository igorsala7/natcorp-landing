/* Natcorp — agrupa por PROCESSO a lista de questionários (e qualquer lista igual).

   A página "Questionários" (app 600, pág. 300) é um relatório clássico de uma coluna: cada
   linha é um link com o nome do questionário (<h2>) e o processo seletivo (<h5>
   "Processo: 57243 - ASSISTENTE DE SETOR"). O mesmo questionário aparece uma vez para cada
   processo, e na lista corrida parecia repetido. Este script junta as linhas pelo texto do
   <h5> e põe um título antes de cada grupo:

       Assistente de Setor   · Processo 57243 · 2 questionários
         [Conhecimento em Gestão]            [Responder]
         [Gestão e Implantação de Sistema…]  [Responder]

   A ordem dos grupos é a da primeira aparição de cada processo; dentro do grupo, a ordem
   da consulta. Dentro do cartão, o processo deixa de aparecer (já está no título). O desenho
   está no Natcorp_Style_Min.css ("LISTA DE LINKS COM TÍTULO" / "agrupada").

   Sem mexer na consulta. A alternativa nativa do APEX é separar o processo numa coluna e
   usar Break Formatting — ver a mensagem da entrega.

   Onde colar: Página 300 › JavaScript › "Execute when Page Loads" (ou no fim do
   iframe_handling.js, se a aplicação carrega esse arquivo). */
(function () {
  'use strict';

  var PEQUENAS = { de: 1, da: 1, do: 1, das: 1, dos: 1, e: 1, em: 1, a: 1, o: 1, para: 1, com: 1 };

  /* "ASSISTENTE DE SETOR" → "Assistente de Setor" (em caixa-alta tudo parece gritar) */
  function titulo(texto) {
    var t = texto.trim();
    if (t !== t.toUpperCase()) return t;               // já vem com caixa mista: respeita
    return t.toLowerCase().split(/\s+/).map(function (p, i) {
      if (i > 0 && PEQUENAS[p]) return p;
      return p.charAt(0).toUpperCase() + p.slice(1);
    }).join(' ');
  }

  function agrupar(tabela) {
    if (tabela.getAttribute('data-nc-agrupado') === '1') return;
    var corpo = tabela.tBodies[0];
    if (!corpo) return;
    var linhas = [].slice.call(corpo.rows).filter(function (tr) { return tr.querySelector('td > a > h2'); });
    if (linhas.length < 2) return;
    /* relatório com a quebra nativa do APEX (uma coluna antes da do link): o agrupamento
       já vem pronto — não mexe */
    if (linhas[0].cells.length > 1) return;

    var grupos = [], porChave = {};
    linhas.forEach(function (tr) {
      var sub = tr.querySelector('td > a > :is(h3, h4, h5, h6)');
      var chave = sub ? sub.textContent.replace(/\s+/g, ' ').trim() : '';
      if (!porChave[chave]) { porChave[chave] = { chave: chave, linhas: [] }; grupos.push(porChave[chave]); }
      porChave[chave].linhas.push(tr);
    });
    if (grupos.length < 2) return;                      // um processo só: nada a separar

    var colunas = (linhas[0].cells.length) || 1;
    grupos.forEach(function (g) {
      var m = /^processo:?\s*([\w.\/-]+)\s*-\s*(.+)$/i.exec(g.chave);
      var nome = m ? titulo(m[2]) : g.chave;
      var cab = document.createElement('tr');
      cab.className = 'nc-grupo';
      var th = document.createElement('th');
      th.colSpan = colunas;
      th.scope = 'rowgroup';
      var h = document.createElement('span');
      h.className = 'nc-grupo-nome';
      h.textContent = nome || 'Sem processo';
      th.appendChild(h);
      if (m) {
        var p = document.createElement('span');
        p.className = 'nc-grupo-processo';
        p.textContent = 'Processo ' + m[1];
        th.appendChild(p);
      }
      var q = document.createElement('span');
      q.className = 'nc-grupo-qtd';
      q.textContent = g.linhas.length + (g.linhas.length === 1 ? ' questionário' : ' questionários');
      th.appendChild(q);
      cab.appendChild(th);
      corpo.appendChild(cab);
      g.linhas.forEach(function (tr) { corpo.appendChild(tr); });
    });
    tabela.setAttribute('data-nc-agrupado', '1');
    var rel = tabela.closest('.t-Report');
    if (rel) rel.classList.add('nc-agrupado');
  }

  function varrer() {
    var tabelas = document.querySelectorAll('.t-Report table.t-Report-report');
    for (var i = 0; i < tabelas.length; i++) {
      if (tabelas[i].querySelector('td.t-Report-cell > a > h2')) agrupar(tabelas[i]);
    }
  }

  function iniciar() {
    varrer();
    /* o refresh da região troca a tabela inteira: agrupa a nova */
    if (window.apex && apex.jQuery) apex.jQuery(document).on('apexafterrefresh', varrer);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar);
  else iniciar();
})();
