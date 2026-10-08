/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 59 do app 200 o que o script de
   exportação vai fazer no APEX — as classes nc-desl-* pelos títulos das regiões. Roda antes
   do Natcorp_Desligamento.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || pag !== '59' || window.__ncDeslSimulada) return;
  window.__ncDeslSimulada = true;

  function tit(r) {
    var h = r.querySelector(':scope > .t-Region-header .t-Region-title');
    return h ? h.textContent.replace(/\s+/g, ' ').trim() : '';
  }
  var regs = [].slice.call(document.querySelectorAll('.t-Region, .t-ButtonRegion'));
  function um(t) { return regs.filter(function (r) { var x = tit(r); return t instanceof RegExp ? t.test(x) : x === t; })[0]; }
  function add(r, cls) { if (r) r.classList.add.apply(r.classList, cls.split(' ')); }

  add(um(/^Requisição de Desligamento/), 'nc-desl-solicitacao');
  add(document.getElementById('COLABORADOR') || um('Colaborador Solicitado'), 'nc-desl-perfil');
  add(um('Aprovadores'), 'nc-desl-aprovadores');
  add(um('Informações para Desligamento'), 'nc-desl-form');
  /* a região dos botões Voltar / Salvar (sem título; o Salvar só existe quando dá para gravar) */
  var salvar = [].slice.call(document.querySelectorAll('.t-ButtonRegion:not(.t-ButtonRegion--dialogRegion) button')).filter(function (b) { return /^\s*(Salvar|Voltar)\s*$/.test(b.textContent); })[0];
  if (salvar) add(salvar.closest('.t-ButtonRegion'), 'nc-desl-acoes');
})();
