/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · PEDIDO DE LANÇAMENTO DIVERSO (REEMBOLSO)  —  o "arrumador" (JavaScript)       ║
   ║  App 2060 (REQ_REEMBOLSO_NATCORP) · Página 11 · Criar/Editar: Lançamentos Diversos       ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia: LANCAMENTO-MANUTENCAO.md. A lista (página 2) usa o motor Natcorp_Consulta.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Na maioria das vezes é um pedido de REEMBOLSO: a pessoa gastou do próprio dinheiro a
   trabalho e quer de volta, com a nota. Quase sempre no celular, por quem lê pouco. A janela
   vira um pedido em partes, na ordem em que a pessoa pensa:
     • o alto: "Novo pedido" (ou "Pedido nº 57743" com a situação colorida, quando já existe);
     • 1 · O que você está pedindo — Processo, Lançamento (Evento), Tipo e Motivo;
     • 2 · A nota e o valor — data da nota, quantidades (quando o lançamento pede), valor da
       nota com "R$" e, quando a página calcula, o "Valor que será lançado" em destaque
       (com o aviso quando ficou diferente do valor da nota: o limite do plano);
     • 3 · A foto da nota — os campos de arquivo como áreas grandes ("Tirar foto ou escolher
       arquivo"); comentário opcional;
     • "Enviar pedido" (o botão Criar), "Salvar", "Voltar"; aprovar/reprovar continuam;
     • o caminho da aprovação (o relatório Aprovadores), o MESMO desenho das outras requisições,
       logo abaixo do alto do pedido; Aprovar/Reprovar vão para dentro dele.
     As abas "Mostrar Tudo / Lançamentos / Anexos" saem: tudo numa tela, de cima para baixo.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não decide o que aparece: os campos, botões e regiões são os ORIGINAIS,
     com as ações dinâmicas deles (é a página que mostra horas/dias/metragem/valor conforme o
     lançamento, e que esconde o 2º arquivo). O desenho só muda de lugar (ordem visual por
     CSS), de nome (o texto do rótulo) e de roupa. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 11 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Lancamento.js
     Página 11 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Lancamento.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [L1] Como a página é reconhecida                                      CUIDADO
     [L2] Os textos (rótulos e ajudas)                                     PODE MEXER
     [L3] Ferramentas
     [L4] O alto e as abas
     [L5] As partes do pedido                                              CUIDADO
     [L6] O valor que será lançado
     [L7] A foto da nota, os botões, quem aprova
     [L8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncLancamento || !window.apex || !window.apex.jQuery) return;

  /* ═══ [L1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pelos itens P11_COD_PROCESSO + P11_COD_EVENTO + P11_MOTIVO. "Novo" = sem
              P11_COD_REQ (é assim que a própria página decide o que mostrar).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  if (!$id('P11_COD_PROCESSO') || !$id('P11_COD_EVENTO') || !$id('P11_MOTIVO')) return;
  window.__ncLancamento = true;
  var $ = window.apex.jQuery;

  /* ═══ [L2] OS TEXTOS ═════════════════════════════════════════════════════════════════════
     PODE MEXER  ROTULOS: o novo texto do rótulo de cada campo (só o texto; o campo é o mesmo).
                 DICAS: uma frase embaixo do campo. ORDEM: a posição de cada campo na tela.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    novo: 'Novo pedido',
    novoDica: 'Preencha as 3 partes e toque em "Enviar pedido".',
    pedido: function (n) { return 'Pedido nº ' + n; },
    aberto: function (d) { return 'Aberto em ' + d; },
    para: 'Para',
    parte1: 'O que você está pedindo',
    parte2: 'A nota e o valor',
    parte3: 'A foto da nota',
    parte3Dica: 'No celular, você pode tirar a foto na hora. A foto precisa mostrar a data e o valor.',
    lancado: 'Valor que será lançado',
    ajustado: 'Ficou diferente do valor da nota porque o seu plano tem um limite.',
    enviar: 'Enviar pedido',
    aprovadores: 'Quem aprova o seu pedido',
    semAprov: 'Ainda ninguém analisou este pedido.'
  };
  var ROTULOS = {
    P11_COD_PROCESSO: 'Tipo de pedido',
    P11_COD_EVENTO: 'Lançamento',
    P11_TIPO: 'Tipo de reembolso',
    P11_MOTIVO: 'Motivo',
    P11_DATA: 'Data da nota ou recibo',
    P11_QTD_HORAS: 'Horas',
    P11_QTD_MINUTOS: 'Minutos',
    P11_QTD_DIAS: 'Dias',
    P11_METRAGEM: 'Metragem (metros)',
    P11_VALOR_APRESENTADO: 'Valor da nota',
    P11_VALOR_APRESENTADO_DSP: 'Valor da nota',
    P11_OBS: 'Quer explicar algo? (opcional)',
    P11_ARQ_1: 'Foto da nota ou recibo',
    P11_ARQ_2: 'Outra foto (opcional)'
  };
  var DICAS = {
    P11_COD_PROCESSO: 'Toque para escolher. Ex.: reembolso de despesa, ajuda de custo.',
    P11_COD_EVENTO: 'Aparece sozinho depois do tipo de pedido.',
    P11_DATA: 'O dia que está escrito na nota.',
    P11_VALOR_APRESENTADO: 'O total da nota, em reais. Ex.: 35,90'
  };
  var ORDEM = ['P11_COD_PROCESSO', 'P11_COD_EVENTO', 'P11_TIPO', 'P11_MOTIVO', '#2', 'P11_DATA', 'P11_QTD_HORAS', 'P11_QTD_MINUTOS', 'P11_QTD_DIAS',
    'P11_METRAGEM', 'P11_METRAGEM_DSP', 'P11_VALOR_METRO_DSP', 'P11_VALOR_APRESENTADO', 'P11_VALOR_APRESENTADO_DSP', 'P11_VALOR_DSP', 'P11_OBS'];

  /* ═══ [L3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/ /g, ' ').replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  /* o texto que a pessoa vê: campo só de leitura aparece no _DISPLAY (o input escondido tem o código) */
  function v(id) { var d = $id(id + '_DISPLAY'); if (d && limpo(d.textContent)) return limpo(d.textContent); var e = $id(id); if (!e) return ''; if (e.tagName === 'SELECT') { var o = e.options[e.selectedIndex]; return o ? limpo(o.text) : ''; } return limpo(e.value != null && e.tagName !== 'SPAN' ? e.value : e.textContent); }
  function nomeDe(t) { return limpo(String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '')); }
  function bonito(t) { t = limpo(t); if (!t || t !== t.toUpperCase()) return t; return t.toLowerCase().replace(/(^|\s)(\S)/g, function (m, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)\s/g, function (m, w) { return ' ' + w.toLowerCase() + ' '; }); }
  function num(t) { t = limpo(t).replace(/[^\d,.-]/g, ''); if (!t) return null; if (/,/.test(t)) t = t.replace(/\./g, '').replace(',', '.'); var n = parseFloat(t); return isNaN(n) ? null : n; }
  function caixa(id) { return $id(id + '_CONTAINER'); }
  var IC = {
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1.1"/><circle cx="4.8" cy="12" r="1.1"/><circle cx="4.8" cy="17.5" r="1.1"/>',
    nota: '<path d="M6 3.5h12v17l-3-2-3 2-3-2-3 2z"/><path d="M9 8h6M9 11.5h6M9 15h3"/>',
    camera: '<path d="M4 8.5h3l1.5-2.5h7L17 8.5h3v10H4z"/><circle cx="12" cy="13" r="3.4"/>',
    enviar: '<path d="M4 12 20 4l-6 16-3-7z"/><path d="m11 13 9-9"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8v.1"/>'
  };
  function ic(n, cls) { return '<svg class="nc-ln-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  /* troca só o TEXTO do rótulo (o "(Valor Necessário)" escondido para leitor de tela fica) */
  function rotulo(id, txt) {
    var c = caixa(id), l = c && c.querySelector('.t-Form-label, label'); if (!l) return;
    var no = [].filter.call(l.childNodes, function (n) { return n.nodeType === 3 && limpo(n.textContent); })[0];
    if (no) no.textContent = txt + ' '; else l.insertBefore(document.createTextNode(txt + ' '), l.firstChild);
  }
  var TONS = [['cancelado', /cancel/], ['reprovado', /reprov|recus|negad/], ['concluido', /conclu/], ['aprovado', /aprov/], ['suspenso', /suspen/], ['andamento', /andamento|analise/], ['aberto', /abert/]];
  function tomDe(t) { var s = sem(t), x = TONS.filter(function (k) { return k[1].test(s); })[0]; return x ? x[0] : 'aberto'; }

  /* ═══ [L4] O ALTO E AS ABAS ══════════════════════════════════════════════════════════════ */
  var NOVO = !v('P11_COD_REQ');
  function montarTopo() {
    var reg = caixa('P11_COD_EMPRESA_DSP'); reg = reg && reg.closest('.t-Region');
    if (!reg) return;
    reg.classList.add('nc-ln-quem');
    var nome = bonito(nomeDe(v('P11_MATRICULA_DSP'))), emp = bonito(nomeDe(v('P11_COD_EMPRESA_DSP')));
    var sit = v('P11_COD_SIT_REQ'), dt = v('P11_DT_REQ');
    var topo = el('header', 'nc-ln-topo');
    topo.innerHTML = NOVO
      ? '<h2>' + ic('nota', 'nc-ln-topo-ic') + esc(T.novo) + '</h2><p>' + esc(T.novoDica) + '</p>'
      : '<h2>' + ic('nota', 'nc-ln-topo-ic') + esc(T.pedido(v('P11_COD_REQ'))) + '</h2>' +
        '<p class="nc-ln-topo-linha">' + (sit ? '<span class="nc-ln-sit nc-ln-sit--' + tomDe(sit) + '">' + esc(nomeDe(sit)) + '</span>' : '') + (dt ? '<span>' + esc(T.aberto(dt)) + '</span>' : '') + '</p>';
    if (nome) topo.insertAdjacentHTML('beforeend', '<p class="nc-ln-para">' + ic('pessoa') + '<span>' + esc(T.para) + ': <b>' + esc(nome) + '</b>' + (emp ? ' · ' + esc(emp) : '') + '</span></p>');
    reg.parentNode.insertBefore(topo, reg);
    /* "Dados da Requisição" (nº, data, situação) é o que o alto já mostra: sai da vista */
    var dados = caixa('P11_COD_REQ'); dados = dados && dados.closest('.t-Region'); if (dados && !NOVO) dados.classList.add('nc-ln-dados');
    /* as abas Mostrar Tudo / Lançamentos / Anexos saem: tudo numa tela só ("Mostrar Tudo") */
    var tudo = document.querySelector('.apex-rds a[href="#SHOW_ALL"]');
    if (tudo) tudo.click();
    var rds = document.querySelector('.apex-rds-container'); if (rds) rds.classList.add('nc-ln-sem-abas');
  }

  /* ═══ [L5] AS PARTES DO PEDIDO ═══════════════════════════════════════════════════════════
     CUIDADO  a região "Lançamentos" vira uma grade em que cada campo ganha uma posição
              (ORDEM) — a grade do APEX (row/col) fica "display: contents". Campos que a página
              esconde continuam escondidos (ações dinâmicas). Os títulos das partes são
              elementos a mais nessa grade.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function parte(n, txt, dica) { return '<span class="nc-ln-parte-n" aria-hidden="true">' + n + '</span><div><h3>' + esc(txt) + '</h3>' + (dica ? '<p>' + esc(dica) + '</p>' : '') + '</div>'; }
  function montarPartes() {
    var reg = caixa('P11_COD_PROCESSO'); reg = reg && reg.closest('.t-Region');
    if (!reg) return null;
    reg.classList.add('nc-ln-lanc');
    var grade = reg.querySelector('.t-Region-body > .container') || reg.querySelector('.container');
    if (!grade) return reg;
    grade.classList.add('nc-ln-grade');
    var h1 = el('div', 'nc-ln-parte', parte(1, T.parte1)); h1.style.order = 0;
    grade.insertBefore(h1, grade.firstChild);
    ORDEM.forEach(function (id, i) {
      if (id === '#2') { var h2 = el('div', 'nc-ln-parte nc-ln-parte--mais', parte(2, T.parte2)); h2.style.order = i + 1; grade.appendChild(h2); return; }
      var c = caixa(id); if (!c) return;
      c.style.order = i + 1;
      c.classList.add('nc-ln-campo');
      if (ROTULOS[id]) rotulo(id, ROTULOS[id]);
      if (DICAS[id] && NOVO && !c.querySelector('.nc-ln-dica')) (c.querySelector('.t-Form-inputContainer') || c).appendChild(el('p', 'nc-ln-dica', esc(DICAS[id])));
    });
    /* horas e minutos lado a lado */
    ['P11_QTD_HORAS', 'P11_QTD_MINUTOS'].forEach(function (id) { var c = caixa(id); if (c) c.classList.add('nc-ln-meio'); });
    /* "R$" na frente do valor da nota */
    var va = $id('P11_VALOR_APRESENTADO');
    if (va) { va.setAttribute('inputmode', 'decimal'); var w = va.closest('.t-Form-itemWrapper') || va.parentNode; if (!w.querySelector('.nc-ln-rs')) w.insertBefore(el('span', 'nc-ln-rs', 'R$'), va); }
    return reg;
  }

  /* ═══ [L6] O VALOR QUE SERÁ LANÇADO ══════════════════════════════════════════════════════
     P11_VALOR_DSP é calculado pela página (o valor da nota dentro do mínimo/máximo do plano).
     Quando difere do valor da nota, uma frase explica.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function valorLancado() {
    var c = caixa('P11_VALOR_DSP'); if (!c) return;
    c.classList.add('nc-ln-lancado');
    rotulo('P11_VALOR_DSP', T.lancado);
    var aviso = c.querySelector('.nc-ln-ajuste');
    if (!aviso) { aviso = el('p', 'nc-ln-ajuste'); (c.querySelector('.t-Form-inputContainer') || c).appendChild(aviso); }
    var a = num(v('P11_VALOR_APRESENTADO') || v('P11_VALOR_APRESENTADO_DSP')), d = num(v('P11_VALOR_DSP'));
    var dif = a !== null && d !== null && Math.abs(a - d) > 0.005;
    aviso.innerHTML = dif ? ic('info') + '<span>' + esc(T.ajustado) + '</span>' : '';
    aviso.hidden = !dif;
  }

  /* ═══ [L7] A FOTO DA NOTA, OS BOTÕES, QUEM APROVA ═════════════════════════════════════════ */
  function montarAnexos() {
    var c1 = caixa('P11_ARQ_1'), reg = c1 && c1.closest('.t-Region'); if (!reg) return;
    reg.classList.add('nc-ln-anexos');
    var corpo = reg.querySelector('.t-Region-body') || reg;
    if (!corpo.querySelector('.nc-ln-parte')) corpo.insertBefore(el('div', 'nc-ln-parte', parte(3, T.parte3, NOVO ? T.parte3Dica : '')), corpo.firstChild);
    ['P11_ARQ_1', 'P11_ARQ_2'].forEach(function (id) {
      var i = $id(id); if (!i) return;
      rotulo(id, ROTULOS[id]);
      if (i.type === 'file' && !i.getAttribute('accept')) i.setAttribute('accept', 'image/*,application/pdf');
    });
  }
  function montarBotoes() {
    [].forEach.call(document.querySelectorAll('button.t-Button'), function (b) {
      var t = sem(b.textContent);
      if (t === 'criar') { b.classList.add('nc-ln-enviar'); var lb = b.querySelector('.t-Button-label'); if (lb) lb.textContent = T.enviar; [].forEach.call(b.querySelectorAll('.t-Icon'), function (x) { x.remove(); }); b.insertAdjacentHTML('afterbegin', ic('enviar')); }
      else if (t === 'salvar') b.classList.add('nc-ln-enviar');
      else if (t === 'voltar') b.classList.add('nc-ln-voltar');
    });
  }
  /* O caminho da aprovação — o MESMO desenho das outras requisições (Benefícios [J12],
     Requisição, Desligamento, Treinamento, Atestado): o relatório "Aprovadores" vira uma faixa
     logo abaixo do alto do pedido, com o resumo ("1 de 2 · aguardando Fulano", "Aprovado por
     …"), os aprovadores em linha ligados por um fio e o que cada um escreveu. Os botões
     Aprovar/Reprovar da página (só para quem aprova) vão para dentro dela — os mesmos botões.
     A tabela continua na região, fora da vista. Colunas: APROVADOR, DATA, STATUS, JUSTIFICATIVA. */
  var AP = null, AP_ABERTO = false;
  function nomeAprovador(t) { var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || ''); return bonito(nomeDe(m ? m[1] : t)); }
  function montarAprovadores() {
    if (!AP) {
      var reg = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { var h = r.querySelector('.t-Region-title'); return h && /aprovadores/i.test(h.textContent); })[0];
      if (!reg) return;
      AP = { reg: reg, botoes: [].filter.call(document.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return /^(aprovar|reprovar)$/i.test(limpo(b.textContent)); }) };
      reg.classList.add('nc-ln-aprov');
      var topo = document.querySelector('.nc-ln-topo');
      if (topo) topo.parentNode.insertBefore(reg, topo.nextSibling);
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-ln-caminho');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-ln-caminho-ver')) { AP_ABERTO = !AP_ABERTO; montarAprovadores(); } });
    }
    var col = {};
    [].forEach.call(AP.reg.querySelectorAll('th[id]'), function (th) { col[sem(th.textContent) || th.id.toLowerCase()] = th.id; });
    function c(tr, k) { var id = col[k] || k.toUpperCase(), td = tr.querySelector('td[headers="' + id + '"]'); var t = td ? limpo(td.textContent) : ''; return /^[-–—]$/.test(t) ? '' : t; }
    var passos = [].filter.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr'), function (tr) { return tr.querySelector('td[headers]'); }).map(function (tr) {
      var st = c(tr, 'status');
      return { nome: nomeAprovador(c(tr, 'aprovador')), data: c(tr, 'data'), just: c(tr, 'justificativa'), status: st,
        estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome || x.status; });
    var n = passos.length;
    AP.reg.classList.toggle('nc-ln-aprov--vazio', !n);
    if (!n) { AP.box.innerHTML = ''; return; }
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; }), atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var sitCod = ($id('P11_COD_SIT_REQ') || {}).value || '', sitTxt = v('P11_COD_SIT_REQ');
    var cancelado = sitCod === '3' || sitCod === '6' || /cancel|suspens/i.test(sitTxt);
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome)
      : cancelado ? '<b>Pedido ' + (sitCod === '6' ? 'suspenso' : 'cancelado') + '</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos')
      : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    var justs = passos.filter(function (x) { return x.just; });
    AP.reg.classList.toggle('nc-ln-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-ln-caminho nc-ln-caminho--' + estado;
    AP.box.innerHTML =
      '<div class="nc-ln-caminho-cab"><p class="nc-ln-caminho-rot">Aprovação</p><p class="nc-ln-caminho-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-ln-caminho-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-ln-passos-ap">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var icx = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        return '<li class="nc-ln-ap ' + cls + '"><span class="nc-ln-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + icx + '</svg></span>' +
          '<span class="nc-ln-ap-texto"><span class="nc-ln-ap-nome">' + esc(x.nome || 'Aprovador') + '</span><span class="nc-ln-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      (bts.length ? '<div class="nc-ln-decisao"><p class="nc-ln-decisao-txt">Confira o pedido e decida.</p><div class="nc-ln-decisao-botoes" aria-label="Sua decisão"></div></div>' : '') +
      (justs.length ? '<div class="nc-ln-ap-justs">' + justs.map(function (x) {
        return '<blockquote class="nc-ln-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + (x.estado === 'nao' ? ' reprovou' : x.estado === 'ok' ? ' aprovou' : '') + ':</b> ' + esc(x.just) + '</blockquote>';
      }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-ln-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) {
      b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-ln-reprovar' : 'nc-ln-aprovar'); dest.appendChild(b);
    });
  }

  /* ═══ [L8] O MAESTRO ═════════════════════════════════════════════════════════════════════
     Depois das ações de abertura (apexreadyend): elas mostram/escondem os campos e preenchem
     valores. O valor lançado é refeito a cada change dos campos de valor.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var montado = false;
  function iniciar() {
    if (montado) return;
    montado = true;
    try {
      document.body.classList.add('nc-ln-ativo');
      document.body.classList.toggle('nc-ln-novo', NOVO);
      montarTopo();
      montarPartes();
      valorLancado();
      montarAnexos();
      montarBotoes();
      montarAprovadores();
      $('#P11_VALOR_APRESENTADO, #P11_VALOR_DSP, #P11_COD_EVENTO').on('change', function () { setTimeout(valorLancado, 50); });
      try { var dlg = window.frameElement && window.frameElement.closest('.ui-dialog'), tt = dlg && dlg.querySelector('.ui-dialog-title'); if (tt) tt.textContent = NOVO ? 'Novo pedido' : 'Seu pedido'; } catch (e) { /* outra origem */ }
    } catch (e) { if (window.console) console.error('Natcorp_Lancamento', e); }
  }
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 2000); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
})();
