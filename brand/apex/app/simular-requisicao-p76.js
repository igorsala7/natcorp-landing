/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 76 do app 200 (Requisição de Posição)
   o que o script de exportação vai fazer no APEX — agrupa as seções soltas de "Informações de
   Vaga" em etapas (regiões novas, como na Requisição de Pessoal), põe as classes nc-req-* pelos
   títulos e cria a etapa "Prévia do anúncio". Roda antes do Natcorp_Requisicao.js. Não vai para
   o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '200' || pag !== '76' || window.__ncReqSimulada) return;
  window.__ncReqSimulada = true;

  function tit(r) {
    var h = r.querySelector(':scope > .t-Region-header .t-Region-title');
    if (!h) return '';
    var c = h.cloneNode(true);
    [].forEach.call(c.querySelectorAll('.nc-native-header__subtitle'), function (x) { x.remove(); });
    return c.textContent.replace(/\s+/g, ' ').trim();
  }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function um(t) { return regs.filter(function (r) { var x = tit(r); return t instanceof RegExp ? t.test(x) : x === t; })[0]; }
  function add(r) { if (r) r.classList.add.apply(r.classList, [].slice.call(arguments, 1)); return r; }
  function linha(conteudo) { var row = document.createElement('div'); row.className = 'row'; var col = document.createElement('div'); col.className = 'col col-12 apex-col-auto'; row.appendChild(col); if (conteudo) col.appendChild(conteudo); return row; }
  function regiao(id, cls, titulo) {
    var d = document.createElement('div');
    d.innerHTML = '<div class="t-Region ' + cls + ' t-Region--noPadding t-Region--removeHeader t-Region--noUI t-Region--scrollBody" id="' + id + '"><div class="t-Region-header"><div class="t-Region-headerItems t-Region-headerItems--title"><span class="t-Region-headerIcon"><span class="t-Icon" aria-hidden="true"></span></span><h2 class="t-Region-title">' + titulo + '</h2></div></div><div class="t-Region-bodyWrap"><div class="t-Region-body"><div class="container"></div></div></div></div>';
    return d.firstChild;
  }
  function corpo(r) { return r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body > .container'); }

  var host = add(document.getElementById('INF_VAGA') || um('Informações de Vaga'), 'nc-req-etapas');
  if (!host) return;
  var destino = corpo(host);

  /* as etapas (no APEX: regiões filhas de "Informações de Vaga", e as seções passam para dentro
     delas — mesma ordem da página) */
  var ETAPAS = [
    ['IDENTIFICACAO', 'Identificação', ['Requisição de Vaga', 'Informações da Vaga']],
    ['CARGO_ETAPA', 'Cargo', ['Cargo', 'Frequência']],
    ['REMUNERACAO_ETAPA', 'Remuneração', ['Remuneração', 'Insalubridade / Periculosidade', 'Projeto', 'Contrato', 'Vaga Faturável']],
    ['PERFIL_ETAPA', 'Perfil', ['PCD', 'Ferramentas de Apoio / Equipamentos']],
    ['DETALHAMENTO_ETAPA', 'Detalhamento', ['Descrição de Atividades', 'Observações / Políticas / Detalhes da Vaga']]
  ];
  ETAPAS.forEach(function (e) {
    var et = regiao(e[0], 'nc-req-etapa', e[1]);
    var cont = corpo(et);
    e[2].forEach(function (t) { var r = um(t); if (r) cont.appendChild(linha(r)); });
    destino.appendChild(linha(et));
  });
  /* linhas que ficaram vazias no host depois da mudança */
  [].forEach.call(destino.querySelectorAll(':scope > .row'), function (row) { if (!row.querySelector('.t-Region')) row.remove(); });

  /* "Requisição de Vaga" vira a Solicitação (número, situação, data e solicitante) */
  var sol = um('Requisição de Vaga');
  if (sol) { sol.querySelector(':scope > .t-Region-header .t-Region-title').textContent = 'Solicitação'; add(sol, 'nc-req-ficha', 'nc-req-solicitacao'); }

  ['Informações da Vaga', 'Cargo', 'Frequência', 'Remuneração', 'Insalubridade / Periculosidade', 'Projeto', 'Contrato', 'Vaga Faturável', 'PCD']
    .forEach(function (t) { var r = regs.filter(function (x) { return tit(x) === t && !x.classList.contains('nc-req-etapa'); })[0]; add(r, 'nc-req-ficha'); });
  add(um('Ferramentas de Apoio / Equipamentos'), 'nc-req-lista');
  add(um('Descrição de Atividades'), 'nc-req-escrita');
  add(um('Observações / Políticas / Detalhes da Vaga'), 'nc-req-textos');

  /* última etapa: a prévia do anúncio */
  var fim = regiao('PREVIA_ETAPA', 'nc-req-etapa nc-req-etapa-previa', 'Prévia do anúncio');
  corpo(fim).appendChild(linha(regiao('PREVIA_ANUNCIO', 'nc-req-previa', 'Como o candidato vai ver')));
  destino.appendChild(linha(fim));
})();
