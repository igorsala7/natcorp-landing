/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 136 do app 200 (Requisição de Alteração
   Cadastral) o que o script de exportação vai fazer no APEX — as classes nc-cad-* pelos títulos
   das regiões. Roda antes do Natcorp_Cadastro.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || pag !== '136' || window.__ncCadSimulada) return;
  window.__ncCadSimulada = true;
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function todas(t) { return regs.filter(function (r) { var x = tit(r); return t instanceof RegExp ? t.test(x) : x === t; }); }
  function add(t, cls) { todas(t).forEach(function (r) { r.classList.add(cls); }); }
  add('Colaborador', 'nc-cad-colaborador');
  add('Requisição de Alteração Cadastral', 'nc-cad-solicitacao');
  add('Seletor', 'nc-cad-seletor');
  add('Documentos (Upload)', 'nc-cad-anexos');
  var TEMAS = {
    endereco: ['Endereço'], contato: ['Contato'], banco: ['Dados Bancários'], pessoais: ['Dados Pessoais'],
    familia: ['Dados da Mãe', 'Dados do Pai', 'Dados do Conjuge'], estudo: ['Formação / Escolaridade'],
    documentos: ['Identidade', 'CPF', 'Reservista', 'Título de Eleitor', 'Carteira Nacional de Habilitação', 'PIS / PASEP', 'Carteira Profissional', 'Habilitação Profissional'],
    uniforme: ['Medidas'], deficiencia: ['Portador de Necessidades']
  };
  Object.keys(TEMAS).forEach(function (k) { TEMAS[k].forEach(function (t) { add(t, 'nc-cad-tema-' + k); }); });
  var b = [].slice.call(document.querySelectorAll('.t-ButtonRegion:not(.t-ButtonRegion--dialogRegion) button')).filter(function (x) { return /^\s*(Salvar|Criar|Voltar)\s*$/.test(x.textContent); })[0];
  if (b) b.closest('.t-ButtonRegion').classList.add('nc-cad-acoes');
})();
