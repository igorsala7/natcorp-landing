/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 163 do app 200 (Requisição de Alteração
   de Vaga) o que o script de exportação vai fazer no APEX — as classes nc-alt-* pelos títulos das
   regiões. Roda antes do Natcorp_AlteracaoVaga.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || pag !== '163' || window.__ncAltSimulada) return;
  window.__ncAltSimulada = true;
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function um(t) { return regs.filter(function (r) { var x = tit(r); return t instanceof RegExp ? t.test(x) : x === t; })[0]; }
  function add(r, cls) { if (r) r.classList.add(cls); }
  add(um(/^Requisição de Alteração de Vaga/), 'nc-alt-solicitacao');
  add(document.getElementById('VAGA') || um('Vaga'), 'nc-alt-vaga');
  add(document.getElementById('ATUAL') || um('Dados Atuais'), 'nc-alt-atual');
  add(document.getElementById('PROPOSTA') || um('Mudança de Posição'), 'nc-alt-proposta');
  add(document.getElementById('OBS') || um('Observações'), 'nc-alt-obs');
  add(um('Aprovadores'), 'nc-alt-aprovadores');
  var b = [].slice.call(document.querySelectorAll('.t-ButtonRegion:not(.t-ButtonRegion--dialogRegion) button')).filter(function (x) { return /^\s*(Salvar|Criar|Voltar)\s*$/.test(x.textContent); })[0];
  if (b) add(b.closest('.t-ButtonRegion'), 'nc-alt-acoes');
})();
