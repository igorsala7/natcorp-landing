/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSULTA DE FÉRIAS  —  o "arrumador" da página (JavaScript)                   ║
   ║  App 300 (Portal do Colaborador) · Página 77 · Requisição de Férias (a consulta)         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: FERIASCONSULTA-MANUTENCAO.md. O pedido em si é a página 78 (Natcorp_Ferias).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador quer VER os pedidos de férias dele de um jeito claro, no celular; as
   ferramentas do relatório interativo (busca, ações, colunas) ficam em segundo plano. Então:
     • o colaborador (quando a página mostra) vira um cartão curto: foto, nome, situação,
       admissão e o botão original "Visualizar";
     • "Pedir férias" (o botão ORIGINAL "Criar Requisição", com as validações dele) em destaque;
     • "Suas próximas férias" quando há uma saída marcada daqui para frente;
     • a situação em botões com a contagem (Todos · Aberta · Aprovada · Cancelada…) — filtra
       os cartões na hora;
     • cada pedido é um cartão: a situação em cor e palavra, o nº e quando foi aberto, as
       PARTES das férias ("Sai 3 de agosto · Volta 2 de setembro · 30 dias", "Vendeu 10 dias",
       "Adiantamento do 13º"), o período aquisitivo com o saldo, quem pediu (quando não foi a
       própria pessoa), "Ver pedido" (o link da linha) e "Pedir de novo" (o link original,
       quando a página oferece). Cancelados e reprovados ficam mais discretos;
     • "Ver como tabela" mostra o relatório original com todas as ferramentas.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não muda o que aparece: a consulta, a paginação, o botão Criar com as
     ações dele (validação, ação judicial, alerta) e os links são os da página. Os dados são
     LIDOS do relatório pelo TÍTULO de cada coluna. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 77 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_FeriasConsulta.js
     Página 77 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_FeriasConsulta.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [V1] Como a página é reconhecida                                      CUIDADO
     [V2] Os textos e as cores da situação                                 PODE MEXER
     [V3] Ferramentas (datas, nomes, ícones)
     [V4] Lê os pedidos do relatório (pelos títulos das colunas)           CUIDADO
     [V5] O colaborador
     [V6] O alto: Pedir férias, próximas férias, a situação
     [V7] Os cartões
     [V8] Cartões × tabela
     [V9] O maestro
*/
(function () {
  'use strict';
  if (window.__ncFeriasConsulta || !window.apex || !window.apex.jQuery) return;

  /* ═══ [V1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pelos itens ocultos P77_OK e P77_ALERT_ACAO_JURIDICO. O relatório (.a-IRR) só
              existe depois que o JS dele roda: é procurado na montagem. O botão "Criar
              Requisição" e o "Visualizar" pelo texto.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  /* 04/10: só pelos itens — o .a-IRR é montado pelo JS do relatório DEPOIS deste arquivo rodar
     (exigir aqui fazia o desenho desistir na página de verdade); o relatório é procurado em iniciar() */
  if (!$id('P77_OK') || !$id('P77_ALERT_ACAO_JURIDICO')) return;
  window.__ncFeriasConsulta = true;
  var $ = window.apex.jQuery;

  /* ═══ [V2] OS TEXTOS E AS CORES DA SITUAÇÃO ══════════════════════════════════════════════
     PODE MEXER  os textos e a cor (tom) de cada situação. As situações vêm da consulta
                 (Aberta, Concluída, Cancelada, Reprovada, Aprovada, Suspensa).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    pedir: 'Pedir férias',
    titulo: 'Seus pedidos de férias',
    todos: 'Todos',
    proximasTit: 'Suas próximas férias',
    faltam: function (n) { return n === 0 ? 'Começam hoje!' : n === 1 ? 'Começam amanhã!' : 'Faltam ' + n + ' dias'; },
    pedido: 'Pedido', aberto: 'aberto em',
    parte: function (n, total) { return total > 1 ? n + 'ª parte' : ''; },
    sai: 'Sai', volta: 'Volta',
    dias: function (n) { return n + (n === 1 ? ' dia' : ' dias'); },
    vendeu: function (n) { return 'Vendeu ' + n + (n === 1 ? ' dia' : ' dias'); },
    decimo: 'Adiantamento do 13º',
    semDatas: 'Sem datas marcadas',
    aquisitivo: 'Período aquisitivo', saldo: 'Saldo',
    pedidoPor: 'Pedido por',
    ver: 'Ver pedido', deNovo: 'Pedir de novo',
    verTabela: 'Ver como tabela', verCartoes: 'Ver em cartões',
    vazioTit: 'Você ainda não pediu férias por aqui',
    vazioTxt: 'Quando você fizer um pedido, ele aparece nesta lista.',
    nenhumFiltro: 'Nenhum pedido com essa situação nesta página.',
    nenhumValendo: 'Nenhum pedido em andamento ou concluído nesta página.',
    verEncerrados: function (n) { return 'Ver cancelados e reprovados (' + n + ')'; },
    esconderEncerrados: 'Esconder cancelados e reprovados',
    admissao: 'Na empresa desde'
  };
  /* 04/10: os 7 status padrão das requisições, com as cores do sistema (Natcorp_Paginas › STATUS
     DAS REQUISIÇÕES, pelo atributo data-nc-status). Sem diferença de maiúscula, acento ou gênero;
     a mesma lista do Natcorp_Registros (window.ncStatus). Fora da lista: cinza neutro. */
  var STATUS = [
    ['cancelado', /cancel/, 'x'], ['reprovado', /reprov|desaprov|recusad|negad|rejeit|indefer/, 'x'],
    ['suspenso', /suspens/, 'pausa'], ['concluido', /conclu|finaliz/, 'check'], ['aprovado', /aprovad|deferid/, 'check'],
    ['andamento', /andamento|em analise/, 'andamento'], ['aberto', /^(em )?abert[oa]s?$|em aberto/, 'relogio']
  ];
  /* encerradas: cartão mais discreto e fora das "próximas férias" */
  var ENCERRADA = /cancel|reprovad/i;

  /* ═══ [V3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function vazio(v) { return !v || v === '-'; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  var MES3 = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function dataBR(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function hoje() { var h = new Date(); h.setHours(0, 0, 0, 0); return h; }
  function extenso(d) { return d.getDate() + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function curta(d, comAno) { return d.getDate() + ' ' + MES3[d.getMonth()] + (comAno ? ' ' + d.getFullYear() : ''); }
  function num(t) { if (vazio(t)) return null; var n = parseFloat(String(t).replace(/\./g, '').replace(',', '.')); return isNaN(n) ? null : n; }
  function nomeDe(t) { return limpo(String(t || '').replace(/^\d+\s*-\s*/, '')); }
  function codDe(t) { return (/^(\d+)\s*-/.exec(limpo(t)) || [])[1] || ''; }
  var IC = {
    sol: '<circle cx="12" cy="12" r="4"/><path d="M12 2.5v2.5M12 19v2.5M2.5 12H5M19 12h2.5M5.3 5.3l1.8 1.8M16.9 16.9l1.8 1.8M5.3 18.7l1.8-1.8M16.9 7.1l1.8-1.8"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    relogio: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
    andamento: '<path d="M4.5 12a7.5 7.5 0 0 1 13.1-5"/><path d="M18.5 3.5V7.5h-4"/><path d="M19.5 12a7.5 7.5 0 0 1-13.1 5"/><path d="M5.5 20.5v-4h4"/>',
    pausa: '<path d="M9 6.5v11M15 6.5v11"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    aviao: '<path d="M10.5 13.5L4 11l1.5-1.5 7 1 3.8-3.8a2 2 0 0 1 2.9 2.9l-3.8 3.8 1 7L15 22l-2.5-6.5-3 3v2.5L8 22.5l-1-3-3-1L5.5 17H8z"/>',
    volta: '<path d="M9 14l-4-4 4-4"/><path d="M5 10h9a5 5 0 0 1 0 10h-2"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    moeda: '<circle cx="12" cy="12" r="8.5"/><path d="M14.5 9.2c-.5-.9-1.5-1.4-2.6-1.4-1.5 0-2.6.8-2.6 2s1.1 1.7 2.7 2c1.6.3 2.7.9 2.7 2.1s-1.2 2.1-2.8 2.1c-1.2 0-2.2-.6-2.7-1.5M12 6.3v1.5M12 16.5V18"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.7"/><path d="M5 20c.9-3.6 3.6-5.6 7-5.6s6.1 2 7 5.6"/>',
    seta: '<path d="M9.5 6l6 6-6 6"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    cartoes: '<rect x="3.5" y="4.5" width="17" height="6.5" rx="1.8"/><rect x="3.5" y="13" width="17" height="6.5" rx="1.8"/>',
    repetir: '<path d="M4.5 12a7.5 7.5 0 0 1 12.8-5.3L19.5 9"/><path d="M19.5 4.5V9H15"/><path d="M19.5 12a7.5 7.5 0 0 1-12.8 5.3L4.5 15"/><path d="M4.5 19.5V15H9"/>'
  };
  function ic(n, cls) { return '<svg class="nc-fc-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function tomDe(sit) { var s = sem(sit), t = STATUS.filter(function (x) { return x[1].test(s); })[0]; return t ? { tom: t[0], ic: t[2] } : { tom: 'neutro', ic: 'relogio' }; }

  /* ═══ [V4] LÊ OS PEDIDOS DO RELATÓRIO ════════════════════════════════════════════════════
     CUIDADO  cada coluna é achada pelo TÍTULO (th id ↔ td headers), não pela posição: o
              relatório pode ter as colunas em outra ordem. Os títulos esperados estão em COLS
              (sem acento, minúsculas). Coluna escondida no relatório (Ações › Colunas) = o
              cartão perde aquela informação.
              O "ver pedido" é a coluna LINK (o lápis); o "pedir de novo" é o link da coluna
              sem título (LINKS, só aparece com RECRIAR_REQ_CONCL_FUNC = S).
              "Matrícula Solicitada" tem um link quebrado na página (#MAT_SOLICITADO#): não é usado.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var COLS = {
    req: /^requisicao$/, abertura: /^data de abertura$/, sit: /^situacao$/,
    aqIni: /^dt\.? periodo inicio$/, aqFim: /^dt\.? periodo fim$/, saldo: /^saldo$/,
    solicitante: /^solicitante$/, solicitada: /^matricula solicitada$/,
    saida: /^dt\.? saida parcela (\d)$/, retorno: /^dt\.? retorno parcela (\d)$/,
    dias: /^n.? dias parcela (\d)$/, abono: /^n.? dias abono parcela (\d)$/, decimo: /^opcao 13.? parcela (\d)$/
  };
  var IR, IRREG;
  function tabela() { return [].slice.call(IR.querySelectorAll('.a-IRR-table')).sort(function (a, b) { return b.rows.length - a.rows.length; })[0] || null; }
  function lerPedidos() {
    var mapa = {};
    [].forEach.call(IR.querySelectorAll('th[id]'), function (th) {
      var t = sem(th.textContent);
      Object.keys(COLS).forEach(function (k) {
        var m = COLS[k].exec(t); if (!m) return;
        mapa[th.id] = m[1] ? { k: k, n: m[1] } : { k: k };
      });
    });
    var tb = tabela(); if (!tb) return [];
    return [].filter.call(tb.rows, function (tr) { return tr.querySelector('td[headers]'); }).map(function (tr) {
      var p = { partes: {}, ver: null, deNovo: null };
      [].forEach.call(tr.querySelectorAll('td[headers]'), function (td) {
        var h = td.getAttribute('headers'), c = mapa[h], v = limpo(td.textContent);
        if (h === 'LINK') { p.ver = td.querySelector('a[href]'); return; }
        if (!c) { var a = td.querySelector('a[href]'); if (a && !p.deNovo && /P78_FLAG_CTRL|fa-file-new/.test(td.innerHTML)) p.deNovo = a; return; }
        if (c.n) { p.partes[c.n] = p.partes[c.n] || {}; p.partes[c.n][c.k] = v; } else p[c.k] = v;
      });
      p.partes = Object.keys(p.partes).sort().map(function (n) {
        var x = p.partes[n];
        return { n: +n, sai: dataBR(x.saida), volta: dataBR(x.retorno), dias: num(x.dias), abono: num(x.abono), decimo: /^s/i.test(x.decimo || '') };
      }).filter(function (x) { return x.sai; });
      p.dataAbertura = dataBR(p.abertura);
      return p;
    });
  }

  /* ═══ [V5] O COLABORADOR ═════════════════════════════════════════════════════════════════
     A região "Colaborador" (só aparece quando a página recebe P77_MAT) vira um cartão curto.
     Os campos são de leitura (texto) e continuam na página; o botão "Visualizar" é o original.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarColaborador() {
    var mat = $id('P77_MATRICULA'); if (!mat) return;
    var reg = mat.closest('.t-Region'); if (!reg || reg.offsetParent === null || reg.classList.contains('nc-colab-reg')) return;   /* a peça global (Natcorp_Colab) já fez */
    var foto = reg.querySelector('img'), quem = mat.value || mat.textContent;
    var sit = ($id('P77_SITUACAO') || {}).value || '', adm = ($id('P77_DT_ADMISSAO') || {}).value || '';
    var sitTxt = limpo(sit.replace(/^\d+\s*-\s*/, '').replace(/\s*-\s*\d{2}\/\d{2}\/\d{4}$/, ''));
    var cartao = el('div', 'nc-fc-colab');
    cartao.innerHTML = (foto ? '<img class="nc-fc-colab-foto" alt="" src="' + esc(foto.getAttribute('src')) + '">' : '<span class="nc-fc-colab-foto">' + ic('pessoa') + '</span>') +
      '<div class="nc-fc-colab-txt"><b>' + esc(nomeDe(quem)) + '</b>' +
      '<span>' + esc([codDe(quem) ? 'Matrícula ' + codDe(quem) : '', sitTxt].filter(Boolean).join(' · ')) + '</span>' +
      (adm ? '<span>' + esc(T.admissao + ' ' + (dataBR(adm) ? extenso(dataBR(adm)) : adm)) + '</span>' : '') + '</div>';
    var bt = [].filter.call(reg.querySelectorAll('button, a.t-Button'), function (b) { return /visualizar/i.test(b.textContent + (b.title || '')) || b.querySelector('.fa-user'); })[0];
    if (bt) { bt.classList.add('nc-fc-colab-bt'); cartao.appendChild(bt); }
    reg.classList.add('nc-fc-colab-reg');
    var corpo = reg.querySelector('.t-Region-body'); if (corpo) corpo.insertBefore(cartao, corpo.firstChild);
  }

  /* ═══ [V6] O ALTO ════════════════════════════════════════════════════════════════════════ */
  var CAIXA, CARDS, FILTRO = '', LISTA = [];
  function proximas(lista) {
    var h = hoje(), melhor = null;
    lista.forEach(function (p) {
      if (ENCERRADA.test(p.sit || '')) return;
      p.partes.forEach(function (x) { if (x.sai >= h && (!melhor || x.sai < melhor.x.sai)) melhor = { p: p, x: x }; });
    });
    return melhor;
  }
  function situacoes(lista) {
    var c = {}; lista.forEach(function (p) { var s = p.sit || '—'; c[s] = (c[s] || 0) + 1; });
    return Object.keys(c).map(function (s) { return { s: s, n: c[s] }; });
  }

  /* ═══ [V7] OS CARTÕES ════════════════════════════════════════════════════════════════════ */
  function parteHtml(x, total) {
    var anoIgual = x.volta && x.volta.getFullYear() === x.sai.getFullYear();
    return '<li class="nc-fc-parte">' +
      (T.parte(x.n, total) ? '<span class="nc-fc-parte-n">' + esc(T.parte(x.n, total)) + '</span>' : '') +
      '<span class="nc-fc-datas">' +
        '<span class="nc-fc-data"><small>' + esc(T.sai) + '</small><b>' + esc(curta(x.sai, !anoIgual)) + '</b></span>' +
        (x.volta ? '<span class="nc-fc-flecha" aria-hidden="true">' + ic('seta') + '</span><span class="nc-fc-data"><small>' + esc(T.volta) + '</small><b>' + esc(curta(x.volta, true)) + '</b></span>' : '') +
      '</span>' +
      '<span class="nc-fc-chips">' +
        (x.dias ? '<span class="nc-fc-chip nc-fc-chip--dias">' + ic('sol') + esc(T.dias(x.dias)) + '</span>' : '') +
        (x.abono ? '<span class="nc-fc-chip">' + ic('moeda') + esc(T.vendeu(x.abono)) + '</span>' : '') +
        (x.decimo ? '<span class="nc-fc-chip">' + ic('moeda') + esc(T.decimo) + '</span>' : '') +
      '</span></li>';
  }
  function cartao(p, i, colab) {
    var t = tomDe(p.sit || ''), enc = ENCERRADA.test(p.sit || '');
    var aqI = dataBR(p.aqIni), aqF = dataBR(p.aqFim), saldo = num(p.saldo);
    var outro = p.solicitante && colab && codDe(p.solicitante) && codDe(p.solicitante) !== colab;
    return '<li class="nc-fc-item" data-sit="' + esc(p.sit || '—') + '"><article class="nc-fc-cartao nc-fc-cartao--' + t.tom + (enc ? ' is-encerrada' : '') + '">' +
      '<header class="nc-fc-cab">' +
        '<span class="nc-fc-sit nc-fc-sit--' + t.tom + '"' + (t.tom !== 'neutro' ? ' data-nc-status="' + t.tom + '"' : '') + '>' + ic(t.ic) + esc(p.sit || '—') + '</span>' +
        '<span class="nc-fc-num">' + esc(T.pedido + ' ' + (p.req || '')) + (p.dataAbertura ? ' · ' + esc(T.aberto + ' ' + curta(p.dataAbertura, true)) : '') + '</span>' +
      '</header>' +
      (p.partes.length ? '<ul class="nc-fc-partes">' + p.partes.map(function (x) { return parteHtml(x, p.partes.length); }).join('') + '</ul>'
                       : '<p class="nc-fc-semdatas">' + esc(T.semDatas) + '</p>') +
      '<dl class="nc-fc-info">' +
        (aqI && aqF ? '<div><dt>' + ic('calendario') + esc(T.aquisitivo) + '</dt><dd>' + esc(curta(aqI, true) + ' a ' + curta(aqF, true)) + (saldo != null ? ' · ' + esc(T.saldo) + ' ' + esc(T.dias(String(saldo).replace('.', ','))) : '') + '</dd></div>' : '') +
        (outro ? '<div><dt>' + ic('pessoa') + esc(T.pedidoPor) + '</dt><dd>' + esc(nomeDe(p.solicitante)) + '</dd></div>' : '') +
      '</dl>' +
      '<footer class="nc-fc-acoes">' +
        (p.deNovo ? '<button type="button" class="nc-fc-bt" data-denovo="' + i + '">' + ic('repetir') + esc(T.deNovo) + '</button>' : '') +
        (p.ver ? '<button type="button" class="nc-fc-bt nc-fc-bt--ver" data-ver="' + i + '">' + esc(T.ver) + ic('seta') + '</button>' : '') +
      '</footer>' +
    '</article></li>';
  }
  function desenhar() {
    IR = document.querySelector('.a-IRR'); if (!IR) return;
    IRREG = IR.closest('.t-IRR-region, .t-Region, [id^="R"]');
    LISTA = lerPedidos();
    var colab = codDe(($id('P77_MATRICULA') || {}).value || '') || (($id('P77_MAT') || {}).value || '');
    var prox = proximas(LISTA), sits = situacoes(LISTA);
    if (FILTRO && !sits.some(function (s) { return s.s === FILTRO; })) FILTRO = '';
    var h = '';
    if (prox) {
      var n = Math.round((prox.x.sai - hoje()) / 864e5);
      h += '<section class="nc-fc-proximas" aria-label="' + esc(T.proximasTit) + '">' + ic('sol', 'nc-fc-proximas-ic') +
        '<div><p class="nc-fc-proximas-tit">' + esc(T.proximasTit) + '</p>' +
        '<p class="nc-fc-proximas-data">' + esc(extenso(prox.x.sai)) + (prox.x.dias ? ' · ' + esc(T.dias(prox.x.dias)) : '') + '</p>' +
        '<p class="nc-fc-proximas-falta">' + esc(T.faltam(n)) + ' · ' + esc(prox.p.sit || '') + '</p></div></section>';
    }
    h += '<div class="nc-fc-lista-cab"><h2>' + esc(T.titulo) + '</h2>' +
      '<button type="button" class="nc-fc-modo" data-modo="tabela">' + ic('tabela') + '<span>' + esc(T.verTabela) + '</span></button></div>';
    if (LISTA.length && sits.length > 1) {
      h += '<div class="nc-fc-filtro" role="radiogroup" aria-label="Situação">' +
        '<button type="button" role="radio" data-f="" aria-checked="' + (!FILTRO) + '">' + esc(T.todos) + ' <b>' + LISTA.length + '</b></button>' +
        sits.map(function (s) { var t = tomDe(s.s); return '<button type="button" role="radio" class="nc-fc-f--' + t.tom + '" data-f="' + esc(s.s) + '" aria-checked="' + (FILTRO === s.s) + '"><i class="nc-fc-ponto nc-fc-ponto--' + t.tom + '" aria-hidden="true"></i>' + esc(s.s) + ' <b>' + s.n + '</b></button>'; }).join('') +
        '</div>';
    }
    if (!LISTA.length) {
      h += '<div class="nc-fc-vazio">' + ic('sol') + '<b>' + esc(T.vazioTit) + '</b><span>' + esc(T.vazioTxt) + '</span></div>';
    } else {
      h += '<ul class="nc-fc-cartoes">' + LISTA.map(function (p, i) { return cartao(p, i, colab); }).join('') + '</ul><p class="nc-fc-nenhum" hidden></p>' +
        '<button type="button" class="nc-fc-encerrados" aria-expanded="false" hidden></button>';
    }
    CAIXA.querySelector('.nc-fc-conteudo').innerHTML = h;
    CARDS = CAIXA.querySelector('.nc-fc-cartoes');
    filtrar();
  }
  /* Em "Todos", cancelados e reprovados ficam guardados atrás de um botão (o histórico deles
     não ajuda a ver as férias que valem); pela situação, aparecem direto. */
  var VER_ENC = false;
  function filtrar() {
    if (!CARDS) return;
    var n = 0, enc = 0;
    [].forEach.call(CARDS.children, function (li) {
      var s = li.getAttribute('data-sit'), e = ENCERRADA.test(s);
      if (!FILTRO && e) enc++;
      var ok = FILTRO ? s === FILTRO : (!e || VER_ENC);
      li.hidden = !ok; if (ok) n++;
    });
    var nn = CAIXA.querySelector('.nc-fc-nenhum'), bt = CAIXA.querySelector('.nc-fc-encerrados');
    var semValendo = !FILTRO && !VER_ENC && n === 0;
    if (nn) { nn.hidden = n > 0 && !semValendo; nn.textContent = FILTRO ? T.nenhumFiltro : T.nenhumValendo; if (n > 0) nn.hidden = true; }
    if (bt) {
      bt.hidden = !!FILTRO || !enc;
      bt.setAttribute('aria-expanded', String(VER_ENC));
      bt.innerHTML = ic(VER_ENC ? 'x' : 'mais') + '<span>' + esc(VER_ENC ? T.esconderEncerrados : T.verEncerrados(enc)) + '</span>';
    }
  }

  /* ═══ [V8] CARTÕES × TABELA ══════════════════════════════════════════════════════════════
     Em cartões, o relatório original fica na página (é ele que pagina e de onde se lê), só
     sem a tabela e sem a barra de busca à vista; a paginação continua embaixo dos cartões.
     "Ver como tabela" devolve tudo. A escolha fica no aparelho (localStorage).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var CHAVE_MODO = 'nc-fc-modo';
  function modo(m) {
    try { localStorage.setItem(CHAVE_MODO, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-fc-tabela', m === 'tabela');
    var b = CAIXA.querySelector('.nc-fc-modo');
    var volta = document.querySelector('.nc-fc-volta-cartoes');
    if (b) b.hidden = m === 'tabela';
    if (volta) volta.hidden = m !== 'tabela';
  }

  /* ═══ [V9] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var montado = false;
  function iniciar() {
    if (montado) return;
    montado = true;
    IR = document.querySelector('.a-IRR');
    if (!IR) { montado = false; return; }   /* o relatório ainda não montou: tenta no próximo sinal */
    try {
      document.body.classList.add('nc-fc-ativo');
      IRREG = IR.closest('.t-IRR-region') || IR.closest('[id^="R"]') || IR.parentNode;
      montarColaborador();
      CAIXA = el('div', 'nc-fc');
      CAIXA.innerHTML = '<div class="nc-fc-topo"></div><div class="nc-fc-conteudo"></div>';
      IRREG.parentNode.insertBefore(CAIXA, IRREG);
      /* "Criar Requisição": o botão ORIGINAL (as ações dele: validação, ação judicial, alerta) */
      var criar = [].filter.call(IRREG.querySelectorAll('button'), function (b) { return /criar/i.test(b.textContent); })[0];
      if (criar) {
        criar.classList.add('nc-fc-pedir');
        var lb = criar.querySelector('.t-Button-label'); if (lb) lb.textContent = T.pedir;
        CAIXA.querySelector('.nc-fc-topo').appendChild(criar);
      }
      /* em modo tabela: o botão de voltar aos cartões, no alto do relatório */
      var volta = el('button', 'nc-fc-modo nc-fc-volta-cartoes', ic('cartoes') + '<span>' + esc(T.verCartoes) + '</span>');
      volta.type = 'button'; volta.setAttribute('data-modo', 'cartoes'); volta.hidden = true;
      IRREG.parentNode.insertBefore(volta, IRREG);
      desenhar();
      var m = 'cartoes'; try { m = localStorage.getItem(CHAVE_MODO) || 'cartoes'; } catch (e) { /* padrão */ }
      modo(m);
      $(IRREG).on('apexafterrefresh', desenhar);
      $(document).on('apexafterrefresh', function (e) { if (IRREG.contains(e.target) || e.target === IRREG) desenhar(); });
      document.addEventListener('click', function (e) {
        var b = e.target.closest('.nc-fc [data-f]');
        if (b) { FILTRO = b.getAttribute('data-f'); [].forEach.call(b.parentNode.children, function (x) { x.setAttribute('aria-checked', String(x === b)); }); filtrar(); return; }
        if (e.target.closest('.nc-fc-encerrados')) { VER_ENC = !VER_ENC; filtrar(); return; }
        var md = e.target.closest('[data-modo]'); if (md) { modo(md.getAttribute('data-modo')); return; }
        var v = e.target.closest('.nc-fc [data-ver]'); if (v) { var p = LISTA[+v.getAttribute('data-ver')]; if (p && p.ver) p.ver.click(); return; }
        var d = e.target.closest('.nc-fc [data-denovo]'); if (d) { var q = LISTA[+d.getAttribute('data-denovo')]; if (q && q.deNovo) q.deNovo.click(); return; }
        /* tocar no cartão (fora dos botões) = ver o pedido */
        var c = e.target.closest('.nc-fc-cartao'); if (c && !e.target.closest('button, a')) { var bt = c.querySelector('[data-ver]'); if (bt) bt.click(); }
      });
    } catch (e) { if (window.console) console.error('Natcorp_FeriasConsulta', e); }
  }
  $(window).one('apexreadyend', iniciar);
  $(function () { setTimeout(iniciar, 0); setTimeout(iniciar, 800); setTimeout(iniciar, 3000); });
})();
