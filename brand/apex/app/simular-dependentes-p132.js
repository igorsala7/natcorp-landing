/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 132 do app 200 (Requisição de
   Dependentes) o que o script de exportação vai fazer no APEX — as classes nc-dep-* pelos
   títulos das regiões. Roda antes do Natcorp_Dependentes.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || pag !== '132' || window.__ncDepSimulada) return;
  window.__ncDepSimulada = true;
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function um(t) { return regs.filter(function (r) { var x = tit(r); return t instanceof RegExp ? t.test(x) : x === t; })[0]; }
  function add(r, cls) { if (r) r.classList.add(cls); }
  add(document.getElementById('COLABORADOR') || um('Colaborador'), 'nc-dep-colaborador');
  add(um(/^Requisição de Dependentes/), 'nc-dep-solicitacao');
  add(um('Dados do Dependente'), 'nc-dep-form');
  add(document.getElementById('UPLOAD_DOCS') || um('Documentos'), 'nc-dep-anexos');
  var b = [].slice.call(document.querySelectorAll('.t-ButtonRegion:not(.t-ButtonRegion--dialogRegion) .t-Button')).filter(function (x) { return /^\s*(Salvar|Criar|Voltar)\s*$/.test(x.textContent); })[0];
  if (b) add(b.closest('.t-ButtonRegion'), 'nc-dep-acoes');
})();
