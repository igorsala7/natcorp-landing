/* Natcorp — o nome da página na barra de título, em TODAS as páginas.

   A barra de título (.t-Body-title) mostra o breadcrumb; página sem breadcrumb chegava com
   a barra vazia, e o nome dela só existia no <title> da aba. O caminho de modelo —
   <h1 class="nc-TituloPagina">#TITLE#</h1> no HTML de cada modelo de página — exige editar
   todos os modelos de todas as aplicações. Este script faz o mesmo em qualquer página:
   se a barra existe e não tem o título, ele cria o título com o nome da página (o
   atributo "Título" dela, que é o que vai para o <title>).

   Quem decide se o título APARECE continua sendo o Natcorp_Style_Min.css:
     · breadcrumb com itens na barra, ou qualquer outra região nela → some;
     · página com a classe nc-sem-titulo (Page › CSS Classes) → some;
     · página cujo conteúdo é um iframe → a barra fica fechada.
   Modelo que já tem a linha do <h1> não ganha um segundo.

   Roda na hora em que o arquivo carrega (o APEX põe os arquivos no fim da página, com a
   barra já montada): o tema mede a altura da barra DEPOIS, no carregamento, e o conteúdo
   já começa abaixo do título. Vai colado no iframe_handling.js. */
(function () {
  'use strict';

  if (window.__ncTitulo) return;
  window.__ncTitulo = true;

  function nomeDaPagina() {
    var t = (document.title || '').replace(/\s+/g, ' ').trim();
    /* "NATCORP - Cursos e Formações": a marca já está no cabeçalho */
    return t.replace(/^natcorp\s*[-–—|:]\s*/i, '');
  }

  function colocar() {
    var barra = document.getElementById('t_Body_title') || document.querySelector('.t-Body-title');
    if (!barra || barra.querySelector('.nc-TituloPagina')) return false;
    var nome = nomeDaPagina();
    if (!nome) return false;
    var h1 = document.createElement('h1');
    h1.className = 'nc-TituloPagina';
    h1.textContent = nome;
    barra.insertBefore(h1, barra.firstChild);
    return true;
  }

  if (colocar()) {
    /* se o tema já tinha medido a barra (arquivo carregado tarde), mede de novo */
    if (document.readyState === 'complete' && window.apex && apex.jQuery) {
      apex.jQuery(window).trigger('apexwindowresized');
    }
  } else if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', colocar);
  }
})();
