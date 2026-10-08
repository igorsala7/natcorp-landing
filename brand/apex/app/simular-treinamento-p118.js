/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz nas páginas 118 e 120 do app 200 (Requisição de
   Treinamento e Requisição de Curso) o que o script de exportação vai fazer no APEX — as classes nc-tre-* pelos
   títulos das regiões. Roda antes do Natcorp_Treinamento.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || (pag !== '118' && pag !== '120') || window.__ncTreSimulada) return;
  window.__ncTreSimulada = true;
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function um(t) { return regs.filter(function (r) { var x = tit(r); return t instanceof RegExp ? t.test(x) : x === t; })[0]; }
  function add(r, cls) { if (r) r.classList.add(cls); }
  add(um(/^Requisição de (Participante|Curso)/), 'nc-tre-solicitacao');
  add(um('Aprovadores'), 'nc-tre-aprovadores');
  add(document.getElementById('COLABORADOR') || um('Colaborador Solicitado') || um('Solicitante'), 'nc-tre-colaborador');
  add(um('Turma'), 'nc-tre-turma');
  add(um('Curso'), 'nc-tre-curso');                    /* página 120 */
  var b = [].slice.call(document.querySelectorAll('.t-ButtonRegion:not(.t-ButtonRegion--dialogRegion) .t-Button')).filter(function (x) { return /^\s*(Salvar|Criar|Voltar)\s*$/.test(x.textContent); })[0];
  if (b) add(b.closest('.t-ButtonRegion'), 'nc-tre-acoes');
})();
