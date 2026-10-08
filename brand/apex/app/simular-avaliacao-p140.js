/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz nas páginas 140 e 144 do app 9118 (Avaliação) o
   que o script de exportação vai fazer no APEX — as classes nc-av-* pelos títulos das regiões.
   Roda antes do Natcorp_Avaliacao.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (window.__ncAvSimulada || !((pag === '140' && document.getElementById('P140_COD_AVALIACAO')) || (pag === '144' && document.getElementById('P144_ORDEM_COUNT')))) return;
  window.__ncAvSimulada = true;
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function por(t, cls) { var r = regs.filter(function (x) { return typeof t === 'string' ? tit(x) === t : t.test(tit(x)); })[0]; if (r) r.classList.add(cls); }
  if (pag === '140') {
    por('Botões', 'nc-av-acoes'); por('Avaliação', 'nc-av-dados'); por('Relatórios', 'nc-av-relatorios');
    por('Resultado', 'nc-av-resultado'); por('Questões', 'nc-av-questoes'); por('Plano de Desenvolvimento', 'nc-av-plano');
    por('Feedback', 'nc-av-feedback'); por('Comentário', 'nc-av-comentario'); por('Conclusão', 'nc-av-conclusao');
  } else {
    por(/^Pergunta \d+ de \d+$/, 'nc-av-pergunta'); por('Respostas', 'nc-av-respostas');
  }
})();
