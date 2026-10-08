/* Simula, só no navegador de teste, o que o aplicar-movimentacao-pagina116.py faz no APEX: as
   classes, "Opções" → "O que você quer fazer?" logo abaixo do colaborador, "Valor para benefícios"
   (P116_TOTAL / P116_SALDO), "Resumo da movimentação" antes do Parecer, os botões no fim e os
   rótulos. Roda ANTES do Natcorp_Beneficios.js e do Natcorp_Movimentacao.js. Não grava nada. */
(function () {
  'use strict';
  if (window.__ncSim116 || !document.getElementById('P116_BLK_CARGO')) return;
  window.__ncSim116 = true;
  function regs() { return [].slice.call(document.querySelectorAll('.t-Region')); }
  function tit(r) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); return h ? h.textContent.replace(/\s+/g, ' ').trim() : ''; }
  function uma(nome, dentro) { return regs().filter(function (r) { return tit(r) === nome && (!dentro || dentro.contains(r)); })[0]; }
  function filhos(r) { var c = r.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body'); return c ? [].slice.call(c.querySelectorAll('.t-Region')).filter(function (x) { return x.parentElement.closest('.t-Region') === r; }) : []; }
  function poeTit(r, t) { var h = r.querySelector(':scope > .t-Region-header .t-Region-title'); if (h) h.textContent = t; }
  function nova(id, nome, cls) {
    var r = document.createElement('div');
    r.className = 't-Region t-Region--scrollBody ' + cls; r.id = id;
    r.innerHTML = '<div class="t-Region-header"><div class="t-Region-headerItems t-Region-headerItems--title"><h2 class="t-Region-title">' + nome + '</h2></div></div><div class="t-Region-bodyWrap"><div class="t-Region-body"></div></div>';
    return r;
  }
  function rotulo(n, t) { var l = document.getElementById(n + '_LABEL'); if (!l) return; for (var i = 0; i < l.childNodes.length; i++) if (l.childNodes[i].nodeType === 3 && l.childNodes[i].textContent.trim()) { l.childNodes[i].textContent = t + ' '; return; } }
  function itemCls(n, c) { var x = document.getElementById(n + '_CONTAINER'); if (x) x.classList.add(c); }

  var COLAB = uma('Colaborador Solicitado'), ALT = uma('Alterações');
  if (COLAB) COLAB.classList.add('nc-ben-perfil-regiao');
  var OPC = COLAB && uma('Opções', COLAB);
  if (OPC) {
    poeTit(OPC, 'O que você quer fazer?');
    OPC.classList.add('nc-mov-intencoes');
    var col = COLAB.closest('.col') || COLAB, linha = col.closest('.row') || col;
    var nl = document.createElement('div'); nl.className = 'row';
    var nc = document.createElement('div'); nc.className = 'col col-12 apex-col-auto';
    nc.appendChild(OPC); nl.appendChild(nc); linha.after(nl);
  }
  if (ALT) {
    ALT.classList.add('nc-mov-alteracoes');
    filhos(ALT).forEach(function (b) {
      var f = filhos(b), hoje = f.filter(function (x) { return /\bAtua(l|is)\b/.test(tit(x)); }), dep = f.filter(function (x) { return /\bPropost[ao]s?\b/.test(tit(x)); });
      if (hoje.length !== 1 || dep.length !== 1) return;
      b.classList.add('nc-mov-bloco'); hoje[0].classList.add('nc-mov-hoje'); dep[0].classList.add('nc-mov-depois');
    });
    var sal = uma('Salário', ALT); if (sal) sal.classList.add('nc-mov-salario');
    var BEN = uma('Benefícios', ALT);
    if (BEN) {
      [['Benefícios Atuais', 'nc-ben-hoje', 'O que ele tem hoje'], ['Escolha os Benefícios', 'nc-ben-escolha', 'Adicionar um benefício'], ['Benefícios Escolhidos', 'nc-ben-pacote', 'Novo pacote']].forEach(function (x) {
        var r = uma(x[0], BEN); if (r) { r.classList.add(x[1]); poeTit(r, x[2]); }
      });
      var atu = BEN.querySelector('.nc-ben-hoje');
      var saldo = nova('SALDO_BENEFICIOS', 'Valor para benefícios', 'nc-ben-medidor t-Region--removeHeader');
      ['P116_TOTAL', 'P116_SALDO'].forEach(function (n) { var c = document.getElementById(n + '_CONTAINER'); if (c) saldo.querySelector('.t-Region-body').appendChild(c); });
      var colAtu = atu && (atu.closest('.col') || atu);
      if (colAtu) colAtu.parentNode.insertBefore(saldo, colAtu);
    }
    var par = uma('Parecer', ALT);
    var res = nova('RESUMO_MOVIMENTACAO', 'Resumo da movimentação', 'nc-mov-resumo');
    var colPar = par && (par.closest('.col') || par);
    if (colPar) colPar.parentNode.insertBefore(res, colPar);
  }
  /* botões: da barra do topo para o fim do conteúdo */
  var criar = document.getElementById('CREATE');
  var ref = criar || document.getElementById('CANCEL');
  var bot = ref && ref.closest('.t-ButtonRegion, .t-Region');
  if (bot) {
    bot.classList.add('nc-mov-acoes');
    if (!bot.id) bot.id = 'BOTOES';
    var fim = document.querySelector('.t-Body-contentInner') || document.querySelector('.t-Body-content');
    if (fim) fim.appendChild(bot);
    var l = criar && criar.querySelector('.t-Button-label'); if (l) l.textContent = 'Enviar movimentação';
  }
  ['P116_SALARIO', 'P116_REMUNERACAO_VARIAVEL', 'P116_TOTAL_REMUNERACAO'].forEach(function (n) { itemCls(n, 'nc-mov-moeda'); });
  rotulo('P116_REMUNERACAO_VARIAVEL', 'Remuneração variável');
  rotulo('P116_REMUNERACAO_VARIAVEL_PROP', 'Remuneração variável');
  rotulo('P116_PERC_REMUNERACAO_VAR_PROP', '% Aumento RV');
  itemCls('P116_OPCAO', 'nc-ben-segmento'); rotulo('P116_OPCAO', 'Que tipo de benefício?');
  itemCls('P116_BENEFICIO', 'nc-ben-chips'); rotulo('P116_BENEFICIO', 'Grupo');
  itemCls('P116_TIPO_BENEFICIO', 'nc-ben-cartoes'); rotulo('P116_TIPO_BENEFICIO', 'Escolha o benefício');
  itemCls('P116_VALOR', 'nc-ben-valor'); rotulo('P116_VALOR', 'Quanto neste benefício?');
})();
