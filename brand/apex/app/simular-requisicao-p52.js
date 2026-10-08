/* SÓ PARA A PRÉ-VISUALIZAÇÃO (preview.js): faz na página 52 do app 2010 o que o script de
   exportação vai fazer no APEX — as classes nc-req-* pelos títulos das regiões, as regiões
   "Candidatos" e "Prévia do anúncio", o título "Solicitação" e o rótulo "DDD". Roda antes do
   Natcorp_Requisicao.js. Não vai para o Workspace Images. */
(function () {
  'use strict';
  var app = (document.getElementById('pFlowId') || {}).value;
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  if (app !== '2010' || pag !== '52' || window.__ncReqSimulada) return;
  window.__ncReqSimulada = true;

  function tit(r) {
    var h = r.querySelector(':scope > .t-Region-header .t-Region-title');
    if (!h) return '';
    var c = h.cloneNode(true);
    [].forEach.call(c.querySelectorAll('.nc-native-header__subtitle'), function (x) { x.remove(); });
    return c.textContent.replace(/\s+/g, ' ').trim();
  }
  function pai(r) { return r.parentElement.closest('.t-Region'); }
  var regs = [].slice.call(document.querySelectorAll('.t-Region'));
  function um(t, p) { return regs.filter(function (r) { var x = tit(r); return (t instanceof RegExp ? t.test(x) : x === t) && (!p || pai(r) === p); })[0]; }
  function add(r) { if (r) r.classList.add.apply(r.classList, [].slice.call(arguments, 1)); return r; }
  function linha(conteudo) { var row = document.createElement('div'); row.className = 'row'; var col = document.createElement('div'); col.className = 'col col-12 apex-col-auto'; row.appendChild(col); if (conteudo) col.appendChild(conteudo); return row; }
  function regiao(id, cls, titulo) {
    var d = document.createElement('div');
    d.innerHTML = '<div class="t-Region ' + cls + ' t-Region--scrollBody" id="' + id + '"><div class="t-Region-header"><div class="t-Region-headerItems t-Region-headerItems--title"><span class="t-Region-headerIcon"><span class="t-Icon" aria-hidden="true"></span></span><h2 class="t-Region-title">' + titulo + '</h2></div></div><div class="t-Region-bodyWrap"><div class="t-Region-body"><div class="container"></div></div></div></div>';
    return d.firstChild;
  }

  var host = add(regs.filter(function (r) { return r.classList.contains('nc-stepper-host') && !pai(r); })[0] || um('Steppers'), 'nc-req-etapas');
  if (!host) return;
  /* a etapa "Vaga e Local" deixa de existir: as regiões dela (Empresa e Estrutura, Local de
     Trabalho, Publicação de Vaga) passam para a Identificação, depois das que já estão lá.
     No APEX: região pai dessas três = Identificação; "Vaga e Local" em Condição › Nunca. */
  var vaga = document.getElementById('VAGA') || regs.filter(function (r) { return tit(r) === 'Vaga e Local' && pai(r) === host; })[0];
  var ident = regs.filter(function (r) { return tit(r) === 'Identificação' && pai(r) === host; })[0];
  if (vaga && ident) {
    var destino = ident.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body > .container');
    var origem = vaga.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body > .container');
    if (destino && origem) [].slice.call(origem.children).forEach(function (row) { destino.appendChild(row); });
    vaga.style.display = 'none';
  }
  var etapas = regs.filter(function (r) { return pai(r) === host && r !== vaga && !/Botões/.test(tit(r)); });
  etapas.forEach(function (r) { r.classList.add('nc-req-etapa'); });

  var solic = um(/^Requisição de Pessoal/);
  if (solic) { solic.querySelector(':scope > .t-Region-header .t-Region-title').textContent = 'Solicitação'; }
  ['Solicitação', 'Informações da Vaga', 'Empresa e Estrutura', 'Local de Trabalho', 'Publicação de Vaga', 'Cargo', 'Horário Contratual',
    'Controle de Frequência', 'Remuneração', 'Insalubridade / Periculosidade', 'Projeto e Contrato', 'Características do Candidato', 'Parecer', 'Gestor', 'Avaliador']
    .forEach(function (t) { var r = regs.filter(function (x) { return tit(x) === t && !x.classList.contains('nc-req-etapa'); })[0]; add(r, 'nc-req-ficha'); });
  ['Formação', 'Cursos / Certificados Necessários', 'Experiência', 'Conhecimento', 'Idiomas Necessários', 'Características para desempenho da função',
    'Tarefas que irá desempenhar', 'Ferramentas de Apoio / Equipamentos'].forEach(function (t) { add(um(t), 'nc-req-lista'); });
  add(um('Requisitos Técnicos'), 'nc-req-grupo');
  add(um('Desempenho da Função'), 'nc-req-grupo');
  add(document.getElementById('INDICACAO_CANDIDATO') || um('Indicação de Candidato'), 'nc-req-opcional');
  add(document.getElementById('INDICACAO_AVALIAR') || um('Indicação Para Avaliar Requisição'), 'nc-req-plano');
  add(um('Perfil da Vaga'), 'nc-req-opcional');
  var desc = add(document.getElementById('detalhamento') || um('Detalhamento da Requisição'), 'nc-req-escrita');
  var ddd = document.getElementById('P52_DDD_INDICADO_LABEL'); if (ddd) ddd.textContent = 'DDD';
  var obs = document.getElementById('P52_OBSERVACAO_LABEL');
  if (obs) { var req = obs.querySelector('.u-VisuallyHidden'); obs.textContent = 'Observações para o recrutamento '; if (req) obs.appendChild(req); }
  add(um('Parecer'), 'nc-req-textos');
  add(um('Perfil da Vaga'), 'nc-req-textos');
  add(um('Aprovadores'), 'nc-req-aprovadores');
  add(um('Solicitação'), 'nc-req-solicitacao');

  /* ações da requisição: região das etapas (o JS as leva para o trilho) */
  var acoes = add(um('Botões Requisição'), 'nc-req-acoes');
  if (acoes && etapas[0]) { var r0 = etapas[0].closest('.row'); r0.parentNode.insertBefore(linha(acoes), r0); }

  /* etapa Candidatos, com os dois relatórios de inscritos — só numa requisição já gravada
     (no APEX: condição "Item não nulo" P52_ROWID; na criação ela não existe) */
  var ult = etapas[etapas.length - 1];
  var gravada = !!(window.apex && apex.item('P52_ROWID').node && apex.item('P52_ROWID').getValue());
  if (ult && !gravada) ['Colaboradores Inscritos', 'Candidatos Inscritos'].forEach(function (t) { var e = um(t); if (e) e.style.display = 'none'; });
  if (ult && gravada) {
    var cand = regiao('CANDIDATOS', 'nc-req-etapa nc-req-candidatos', 'Candidatos');
    var cont = cand.querySelector('.container');
    ['Colaboradores Inscritos', 'Candidatos Inscritos'].forEach(function (t) { var e = um(t); if (e) { e.classList.add('nc-req-pessoas'); cont.appendChild(linha(e)); } });
    var ur = ult.closest('.row'); ur.parentNode.insertBefore(linha(cand), ur.nextSibling);
  }

  /* última etapa: a prévia do anúncio (uma etapa com a região da prévia dentro) */
  var fim = regiao('PREVIA_ETAPA', 'nc-req-etapa nc-req-etapa-previa', 'Prévia do anúncio');
  fim.querySelector('.container').appendChild(linha(regiao('PREVIA_ANUNCIO', 'nc-req-previa', 'Como o candidato vai ver')));
  var rows = host.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body > .container');
  if (rows) rows.appendChild(linha(fim));
})();
