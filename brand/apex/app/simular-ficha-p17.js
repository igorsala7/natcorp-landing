/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 17 do app 200 (Dados Funcionais) o que o
   script de exportação vai fazer no APEX — as classes nc-df-* pelos títulos das regiões. Roda
   antes do Natcorp_Ficha.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || pag !== '17' || window.__ncDfSimulada) return;
  window.__ncDfSimulada = true;
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function um(t) { return regs.filter(function (r) { return tit(r) === t; })[0]; }
  var a = um('Colaborador'); if (a) a.classList.add('nc-df-colaborador');
  var b = um('Informações'); if (b) b.classList.add('nc-df-info');
  var c = um('Benefícios Relatório'); if (c) c.classList.add('nc-df-beneficios');
})();
