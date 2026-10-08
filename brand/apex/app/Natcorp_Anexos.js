/* Natcorp — mostra o TIPO de cada anexo (PDF, DOCX, XLSX, CSV, PPTX, TXT…).

   Os links de anexo do Blog Corporativo (.publicacao .download a) apontam para um processo
   do APEX ("…APPLICATION_PROCESS=getBlogImg…"): a extensão só existe no NOME visível do
   arquivo, e o CSS não consegue ler texto. Este script lê a extensão do nome e marca o link:

     data-nc-ext     = "PDF"                 → escrito na folha do ícone
     data-nc-familia = "pdf" | "word" | …    → a cor da folha (no Natcorp_Style_Min.css)
     data-nc-tipo    = "Documento PDF"       → a segunda linha do cartão

   O desenho está no Natcorp_Style_Min.css (seção "BLOG CORPORATIVO"). Sem este script o
   cartão aparece igual, com um ícone de arquivo genérico no lugar do tipo.

   Onde colar: no fim do iframe_handling.js (como o Natcorp_Alert.js), SE a aplicação 300
   carrega esse arquivo — ou em Página 1500 › JavaScript › "Execute when Page Loads". */
(function () {
  'use strict';

  var TIPOS = {
    pdf: ['pdf', 'Documento PDF'],
    doc: ['word', 'Documento do Word'], docx: ['word', 'Documento do Word'], odt: ['word', 'Documento de texto'], rtf: ['word', 'Documento de texto'],
    xls: ['planilha', 'Planilha do Excel'], xlsx: ['planilha', 'Planilha do Excel'], xlsm: ['planilha', 'Planilha do Excel'], ods: ['planilha', 'Planilha'], csv: ['planilha', 'Planilha CSV'],
    ppt: ['apresentacao', 'Apresentação do PowerPoint'], pptx: ['apresentacao', 'Apresentação do PowerPoint'], pps: ['apresentacao', 'Apresentação do PowerPoint'], ppsx: ['apresentacao', 'Apresentação do PowerPoint'], odp: ['apresentacao', 'Apresentação'],
    txt: ['texto', 'Arquivo de texto'], log: ['texto', 'Arquivo de texto'], xml: ['texto', 'Arquivo XML'], json: ['texto', 'Arquivo JSON'],
    jpg: ['imagem', 'Imagem'], jpeg: ['imagem', 'Imagem'], png: ['imagem', 'Imagem'], gif: ['imagem', 'Imagem'], webp: ['imagem', 'Imagem'], bmp: ['imagem', 'Imagem'], svg: ['imagem', 'Imagem'],
    mp4: ['video', 'Vídeo'], mov: ['video', 'Vídeo'], avi: ['video', 'Vídeo'], wmv: ['video', 'Vídeo'], webm: ['video', 'Vídeo'],
    mp3: ['audio', 'Áudio'], wav: ['audio', 'Áudio'], ogg: ['audio', 'Áudio'], m4a: ['audio', 'Áudio'],
    zip: ['compactado', 'Arquivo compactado'], rar: ['compactado', 'Arquivo compactado'], '7z': ['compactado', 'Arquivo compactado']
  };

  function marcar(link) {
    if (link.hasAttribute('data-nc-ext')) return;
    var nomeEl = link.querySelector('.text_link') || link;
    var nome = (nomeEl.textContent || '').trim();
    var m = /\.([a-z0-9]{1,5})$/i.exec(nome);
    if (!m) return;                                   // sem extensão: fica o ícone genérico
    var ext = m[1].toLowerCase();
    var tipo = TIPOS[ext] || ['outro', 'Arquivo ' + ext.toUpperCase()];
    link.setAttribute('data-nc-ext', ext.toUpperCase().slice(0, 4));
    link.setAttribute('data-nc-familia', tipo[0]);
    link.setAttribute('data-nc-tipo', tipo[1]);
    /* a segunda linha é o ::after do NOME, e o attr() do CSS lê o atributo do próprio
       elemento: o tipo vai também no nome */
    if (nomeEl !== link) nomeEl.setAttribute('data-nc-tipo', tipo[1]);
    /* quem usa leitor de tela ouve o que o link faz, não só o nome */
    if (!link.getAttribute('aria-label')) {
      link.setAttribute('aria-label', 'Baixar ' + nome + ' (' + tipo[1] + ')' + (link.target === '_blank' ? ', abre em nova aba' : ''));
    }
    if (!link.title) link.title = nome;
  }

  function varrer(raiz) {
    var links = (raiz || document).querySelectorAll('.publicacao .download a');
    for (var i = 0; i < links.length; i++) marcar(links[i]);
  }

  function iniciar() {
    /* só a página do blog tem postagens: nas outras não fica nada vigiando o DOM (o
       arquivo vai colado no iframe_handling.js, que TODA página carrega) */
    if (!document.querySelector('.publicacao')) return;
    varrer(document);
    /* postagens recarregadas por ação dinâmica (refresh da região) chegam depois */
    if (window.MutationObserver) {
      new MutationObserver(function () { varrer(document); })
        .observe(document.body, { childList: true, subtree: true });
    }
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar);
  else iniciar();
})();
