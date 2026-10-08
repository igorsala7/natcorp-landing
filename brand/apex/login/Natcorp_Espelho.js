/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ESPELHO DE PONTO  —  o "arrumador" da página (JavaScript)                     ║
   ║  App 9506 (FREQ_REL_NATCORP) · Página 45 · Relatório de Espelho de Ponto                 ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: ESPELHO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador vem aqui CONFERIR o espelho de ponto do período e ASSINAR, sem precisar
   gerar o PDF. Quase sempre no celular, e muitos leem com dificuldade. A página vira um
   espelho de ponto moderno, em 3 passos:
     1 · Escolha o período — os campos e botões ORIGINAIS (datas, tipo, opções), com o
         "Listar Relatório" chamado de "Ver meu espelho" e o "Gerar Relatório" de
         "Baixar em PDF";
     2 · Confira — o espelho:
         • o resumo: horas previstas e o banco de horas (anterior, do período, atual,
           remanescente), em números grandes;
         • os eventos do período (o relatório Eventos) numa lista simples;
         • os dias, separados por mês: a data, as batidas como horários e as ocorrências do
           dia em palavras ("Atraso 00:52", "Falta 12:00", "A mais 06:00"), com cor: o que
           tira hora em laranja, o que soma em verde. Descanso semanal fica claro;
         • Todos · Com ocorrência · Sem marcação, com a contagem;
     3 · Assine — a região original da assinatura (termo, aceite, "Assinar"), e as
         assinaturas já feitas ("Assinado em …").
     "Ver como tabela" mostra os relatórios originais.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada e não decide o que aparece: os botões e a região da assinatura são os
     ORIGINAIS (quem mostra/esconde continua sendo a página); os números são LIDOS dos
     relatórios e dos campos que a página calcula. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 45 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Espelho.js
     Página 45 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Espelho.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [E1] Como a página é reconhecida                                      CUIDADO
     [E2] Os textos e o significado das colunas                            PODE MEXER
     [E3] Ferramentas
     [E4] Passo 1 · os parâmetros
     [E5] Passo 2 · lê o espelho, os eventos e os totais                   CUIDADO
     [E6] Passo 2 · o desenho
     [E7] Passo 3 · a assinatura
     [E8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncEspelho || !window.apex || !window.apex.jQuery) return;

  /* ═══ [E1] COMO A PÁGINA É RECONHECIDA ═══════════════════════════════════════════════════
     CUIDADO  pelos itens P45_LIST_ESPELHO (botão) e P45_SALDO_ATUAL + P45_HORAS_PREVISTAS.
              Os relatórios têm ID estático: regiaolist (o espelho), regiaoevento (eventos),
              regiaoassinatura (assinaturas feitas) — são os que as ações da página atualizam.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  if (!$id('P45_SALDO_ATUAL') || !$id('P45_HORAS_PREVISTAS') || !$id('regiaolist')) return;
  window.__ncEspelho = true;
  var $ = window.apex.jQuery;

  /* ═══ [E2] OS TEXTOS E O SIGNIFICADO DAS COLUNAS ═════════════════════════════════════════
     PODE MEXER  OCORR: cada coluna do relatório que vira uma etiqueta no dia — o título da
                 coluna (sem acento, minúsculas), o texto da etiqueta e o tom ('menos' = tira
                 horas, laranja; 'mais' = soma, verde; 'neutro'). Coluna fora da lista não vira
                 etiqueta (aparece em "Ver como tabela").
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: 'Seu espelho de ponto',
    passo1: 'Escolha o período',
    passo1Dica: 'Confira as datas e toque em "Ver meu espelho".',
    ver: 'Ver meu espelho',
    pdf: 'Baixar em PDF',
    passo2: 'Confira o seu ponto',
    passo2Dica: 'Veja cada dia. Se algo estiver errado, fale com o seu gestor antes de assinar.',
    antes: 'Toque em "Ver meu espelho" para montar o espelho do período.',
    montando: 'Montando o seu espelho…',
    montandoDica: function (a, b) { return a && b ? 'Estamos juntando as suas marcações de ' + a + ' até ' + b + '. Costuma levar cerca de 1 minuto.' : 'Costuma levar cerca de 1 minuto.'; },
    passou: function (t) { return 'Tempo: ' + t; },
    frases: ['Buscando as suas marcações…', 'Conferindo dia por dia…', 'Somando as horas do período…', 'Calculando o banco de horas…', 'Quase pronto…'],
    completando: 'Trazendo os outros dias do período…',
    periodo: function (a, b) { return 'De ' + a + ' até ' + b; },
    previstas: 'Horas previstas',
    bhAnterior: 'Banco de horas antes',
    bhPeriodo: 'Banco de horas no período',
    bhAtual: 'Banco de horas agora',
    bhRemanescente: 'Saldo remanescente',
    eventos: 'Resumo do período',
    todos: 'Todos', ocorr: 'Com ocorrência', sem: 'Sem marcação',
    dsr: 'Descanso semanal remunerado',
    semMarcacao: 'Sem marcação',
    previsto: 'Previsto', trabalhou: 'Trabalhou',
    nenhum: 'Nenhum dia neste filtro.',
    passo3: 'Assine',
    passo3Dica: 'Se está tudo certo, aceite e toque em Assinar.',
    assinado: function (d) { return 'Assinado em ' + d; },
    verTabela: 'Ver como tabela',
    verEspelho: 'Ver como espelho'
  };
  var OCORR = [
    ['atr comp', 'Atraso compensado', 'neutro'],
    ['atr / s antec', 'Atraso / saída antes', 'menos'],
    ['falta', 'Falta', 'menos'],
    ['dif neg', 'A menos', 'menos'],
    ['dif pos', 'A mais', 'mais'],
    ['bh +', 'Banco de horas +', 'mais'],
    ['bh -', 'Banco de horas −', 'menos'],
    ['bh r(+)', 'Reflexo no banco +', 'mais'],
    ['bh r(-)', 'Reflexo no banco −', 'menos'],
    ['dsr', 'DSR', 'neutro'],
    ['dsr fer', 'DSR feriado', 'neutro'],
    ['de/s >1h', 'Entrada/saída acima de 1h', 'neutro']
  ];
  var SEMANA = ['domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sábado'];
  var SEM3 = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];

  /* ═══ [E3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/ /g, ' ').replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function vazio(t) { t = limpo(t); return !t || t === '-' || t === '—' || /^-?0?0:00$/.test(t); }
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function extenso(d) { return (d.getDate() === 1 ? '1º' : d.getDate()) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function v(id) { var e = $id(id); return e ? limpo(e.value != null && e.tagName !== 'SPAN' ? e.value : e.textContent) : ''; }
  function bonito(t) { t = limpo(t); if (!t || t !== t.toUpperCase()) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  var IC = {
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    olho: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    pdf: '<path d="M7 3h7l5 5v13H7z"/><path d="M14 3v5h5"/><path d="M10 13v5m-2-2 2 2 2-2"/>',
    ok: '<path d="m5 12.5 4.5 4.5L19 7.5"/>',
    caneta: '<path d="M4 20h4L19 9a2.8 2.8 0 0 0-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
    nota: '<path d="M5 4.5h14v15H5z"/><path d="M8.5 9h7M8.5 12.5h7M8.5 16h4"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M9 10v9"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1.1"/><circle cx="4.8" cy="12" r="1.1"/><circle cx="4.8" cy="17.5" r="1.1"/>',
    lua: '<path d="M19 14.5A7.5 7.5 0 0 1 9.5 5a7.5 7.5 0 1 0 9.5 9.5z"/>'
  };
  function ic(n, cls) { return '<svg class="nc-ep-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  function regiaoDe(id) { var e = $id(id); return e && e.closest('.t-Region'); }
  function rotuloBotao(b, txt, icone) {
    var lb = b.querySelector('.t-Button-label'); if (lb) lb.textContent = txt;
    [].forEach.call(b.querySelectorAll('.t-Icon, .fa'), function (i) { i.remove(); });
    if (icone && !b.querySelector('.nc-ep-ic')) b.insertAdjacentHTML('afterbegin', ic(icone));
  }

  /* ═══ [E4] PASSO 1 · OS PARÂMETROS ═══════════════════════════════════════════════════════
     A região "Parâmetros" fica (é ela que tem as datas, o tipo e as opções que os relatórios
     usam); ganha título de passo e os dois botões renomeados (os mesmos botões).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function passo(n, titulo, dica) {
    return '<div class="nc-ep-passo"><span class="nc-ep-passo-n" aria-hidden="true">' + n + '</span><div><h2>' + esc(titulo) + '</h2>' + (dica ? '<p>' + esc(dica) + '</p>' : '') + '</div></div>';
  }
  function montarParametros() {
    var reg = regiaoDe('P45_DATA_INI'); if (!reg) return null;
    reg.classList.add('nc-ep-param');
    var corpo = reg.querySelector('.t-Region-body') || reg;
    corpo.insertAdjacentHTML('afterbegin', passo(1, T.passo1, T.passo1Dica));
    /* rótulos do dia a dia (só o texto; os campos são os mesmos) */
    [['P45_DATA_INI', 'De'], ['P45_DATA_FIM', 'Até'], ['P45_TIPO_RELATORIO', 'Tipo do espelho']].forEach(function (x) {
      var l = $id(x[0] + '_CONTAINER'); l = l && l.querySelector('.t-Form-label'); if (l) l.textContent = x[1];
    });
    /* as duas opções (caixas de marcar) dizem o que são: o rótulo "Opção" de cima sai */
    ['P45_BANCO_HORAS', 'P45_SALDO_BH'].forEach(function (id) {
      var c = $id(id + '_CONTAINER'); if (!c) return;
      c.classList.add('nc-ep-opcao');
      [].forEach.call(c.querySelectorAll('.t-Form-label, legend'), function (l) { if (/^op[cç][aã]o$/i.test(limpo(l.textContent))) l.classList.add('nc-ep-oculto'); });
    });
    var listar = $id('P45_LIST_ESPELHO'), pdf = $id('P45_REL_ESPELHO'), pdf2 = $id('P45_REL_ESPELHO_V2'), assin = $id('P45_REL_ESPELHO_ASSINATURA');
    if (listar) { listar.classList.add('nc-ep-bt-ver'); rotuloBotao(listar, T.ver, 'olho'); }
    [pdf, pdf2, assin].forEach(function (b) { if (b) { b.classList.add('nc-ep-bt-pdf'); rotuloBotao(b, T.pdf, 'pdf'); } });
    return reg;
  }

  /* ═══ [E5] PASSO 2 · LÊ O ESPELHO, OS EVENTOS E OS TOTAIS ════════════════════════════════
     CUIDADO  as colunas do espelho pelo TÍTULO: "Data Ponto", "Dia", "Jornada Realizada",
              "H Prev", "H Trab", "Justificativa" e as de OCORR. As batidas vêm num texto só
              ("06:30 12:30 ------- -------"): os "-------" são posições vazias.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function colunas(reg) {
    var col = {};
    [].forEach.call(reg.querySelectorAll('th[id]'), function (th) { var k = sem(th.textContent); if (k && !col[k]) col[k] = th.id; });
    return col;
  }
  function lerDias() {
    var reg = $id('regiaolist'), col = colunas(reg);
    var linhas = [].slice.call(reg.querySelectorAll('table.a-IRR-table tr')).filter(function (tr) { return tr.querySelector('td[headers]'); });
    function txt(tr, k) { var td = col[k] && tr.querySelector('td[headers="' + col[k] + '"]'); return td ? limpo(td.textContent) : ''; }
    return linhas.map(function (tr) {
      var d = data(txt(tr, 'data ponto')); if (!d) return null;
      var real = txt(tr, 'jornada realizada');
      var dsr = /descanso/i.test(real);
      var horas = dsr ? [] : (real.match(/\b\d{2}:\d{2}\b/g) || []);
      var oc = OCORR.map(function (o) { var x = txt(tr, o[0]); return vazio(x) ? null : { rot: o[1], tom: o[2], val: x.replace(/^-/, '') }; }).filter(Boolean);
      var just = txt(tr, 'justificativa');
      return { d: d, dsr: dsr, horas: horas, outro: !dsr && !horas.length && !/^[-\s]*$/.test(real) ? bonito(real) : '',
        prev: vazio(txt(tr, 'h prev')) ? '' : txt(tr, 'h prev'), trab: txt(tr, 'h trab'), oc: oc, just: vazio(just) ? '' : just };
    }).filter(Boolean);
  }
  function lerEventos() {
    var reg = $id('regiaoevento'); if (!reg) return [];
    var col = colunas(reg);
    var linhas = [].slice.call(reg.querySelectorAll('table.a-IRR-table tr')).filter(function (tr) { return tr.querySelector('td[headers]'); });
    function txt(tr, k) { var td = col[k] && tr.querySelector('td[headers="' + col[k] + '"]'); return td ? limpo(td.textContent) : ''; }
    return linhas.map(function (tr) { return { nome: bonito(txt(tr, 'descricao evento')), total: txt(tr, 'total') }; }).filter(function (e) { return e.nome; });
  }
  function lerAssinaturas() {
    var reg = $id('regiaoassinatura'); if (!reg) return [];
    var col = colunas(reg);
    return [].slice.call(reg.querySelectorAll('table.a-IRR-table tr')).filter(function (tr) { return tr.querySelector('td[headers]'); }).map(function (tr) {
      var td = col['dt assinatura'] && tr.querySelector('td[headers="' + col['dt assinatura'] + '"]'); return td ? limpo(td.textContent) : '';
    }).filter(Boolean);
  }

  /* ═══ [E6] PASSO 2 · O DESENHO ═══════════════════════════════════════════════════════════ */
  var CAIXA, FILTRO = 'todos', LISTADO = false, MONTANDO = false, COMPLETANDO = false, RELOGIO = null, INICIO = 0;
  function temOcorr(d) { return d.oc.some(function (o) { return o.tom !== 'neutro'; }) || !!d.just; }
  function semMarc(d) { return !d.dsr && !d.horas.length && !d.outro && !!d.prev; }
  function passa(d) { return FILTRO === 'ocorr' ? temOcorr(d) : (FILTRO === 'sem' ? semMarc(d) : true); }
  function numero(rot, val, cls) { return '<div class="nc-ep-num' + (cls ? ' ' + cls : '') + '"><span>' + esc(rot) + '</span><b>' + esc(val || '—') + '</b></div>'; }
  function diaHtml(d) {
    var fds = d.d.getDay() === 0 || d.d.getDay() === 6;
    var corpo;
    if (d.dsr) corpo = '<p class="nc-ep-dsr">' + ic('lua') + esc(T.dsr) + '</p>';
    else if (d.horas.length) corpo = '<ul class="nc-ep-horas">' + d.horas.map(function (h) { return '<li>' + esc(h) + '</li>'; }).join('') + '</ul>';
    else if (d.outro) corpo = '<p class="nc-ep-dsr">' + esc(d.outro) + '</p>';
    else corpo = '<p class="nc-ep-semmarc">' + esc(T.semMarcacao) + '</p>';
    var jornada = (d.prev || (d.trab && !vazio(d.trab))) ? '<p class="nc-ep-jor">' + [d.prev ? T.previsto + ' ' + d.prev : '', d.trab && !vazio(d.trab) ? T.trabalhou + ' ' + d.trab : ''].filter(Boolean).map(esc).join(' · ') + '</p>' : '';
    return '<li class="nc-ep-dia' + (d.dsr ? ' nc-ep-dia--dsr' : '') + (fds ? ' nc-ep-dia--fds' : '') + (temOcorr(d) ? ' nc-ep-dia--oc' : '') + '">' +
      '<div class="nc-ep-data"><b>' + d.d.getDate() + '</b><span>' + SEM3[d.d.getDay()] + '</span></div>' +
      '<div class="nc-ep-dia-corpo">' + corpo + jornada +
        (d.oc.length ? '<ul class="nc-ep-oc">' + d.oc.map(function (o) { return '<li class="nc-ep-oc--' + o.tom + '">' + esc(o.rot) + ' <b>' + esc(o.val) + '</b></li>'; }).join('') + '</ul>' : '') +
        (d.just ? '<p class="nc-ep-just">' + ic('nota') + '<span>' + esc(d.just) + '</span></p>' : '') +
      '</div></li>';
  }
  /* "Montando o seu espelho…": relógio girando, barra andando, o espelho em esqueleto, uma
     frase que muda a cada 6 s e o tempo que já passou — o relatório leva ~1 min no servidor */
  var MINI_DIAS = 6;
  function montandoHtml() {
    var ini = data(v('P45_DATA_INI')), fim = data(v('P45_DATA_FIM'));
    var esq = ''; for (var i = 0; i < MINI_DIAS; i++) esq += '<li style="--ep-i:' + i + '"><i class="nc-ep-esq-data"></i><span><i></i><i></i><i></i></span></li>';
    return '<div class="nc-ep-montando" role="status">' +
      '<div class="nc-ep-montando-topo">' +
        '<svg class="nc-ep-relogio" viewBox="0 0 48 48" aria-hidden="true" focusable="false"><circle cx="24" cy="24" r="20"/>' +
          '<g class="nc-ep-ponteiro nc-ep-ponteiro--h"><path d="M24 24V14"/></g><g class="nc-ep-ponteiro nc-ep-ponteiro--m"><path d="M24 24V9"/></g><circle class="nc-ep-centro" cx="24" cy="24" r="2.4"/></svg>' +
        '<div><p class="nc-ep-montando-t">' + esc(T.montando) + '</p><p class="nc-ep-montando-f" aria-live="polite">' + esc(T.frases[0]) + '</p></div>' +
      '</div>' +
      '<div class="nc-ep-barra" aria-hidden="true"><i></i></div>' +
      '<p class="nc-ep-montando-d">' + esc(T.montandoDica(ini && extenso(ini), fim && extenso(fim))) + '</p>' +
      '<ul class="nc-ep-esqueleto" aria-hidden="true">' + esq + '</ul>' +
      '<p class="nc-ep-tempo"></p>' +
    '</div>';
  }
  function tique() {
    var b = CAIXA && CAIXA.querySelector('.nc-ep-montando'); if (!b) { pararRelogio(); return; }
    var seg = Math.floor((Date.now() - INICIO) / 1000);
    b.querySelector('.nc-ep-tempo').textContent = T.passou(Math.floor(seg / 60) + ':' + ('0' + seg % 60).slice(-2));
    var f = T.frases[Math.min(T.frases.length - 1, Math.floor(seg / 6))], fe = b.querySelector('.nc-ep-montando-f');
    if (fe.textContent !== f) { fe.textContent = f; fe.classList.remove('nc-ep-troca'); void fe.offsetWidth; fe.classList.add('nc-ep-troca'); }
  }
  function pararRelogio() { if (RELOGIO) { clearInterval(RELOGIO); RELOGIO = null; } }
  function desenhar() {
    var dias = lerDias(), evs = lerEventos();
    var corpo = CAIXA.querySelector('.nc-ep-conteudo');
    if (MONTANDO || (LISTADO && !dias.length)) {
      if (!corpo.querySelector('.nc-ep-montando')) corpo.innerHTML = montandoHtml();
      if (!RELOGIO) { tique(); RELOGIO = setInterval(tique, 1000); }
      return;
    }
    pararRelogio();
    if (!dias.length) {
      corpo.innerHTML = '<p class="nc-ep-aviso">' + esc(T.antes) + '</p>';
      return;
    }
    var ini = data(v('P45_DATA_INI')), fim = data(v('P45_DATA_FIM'));
    var n = { todos: dias.length, ocorr: dias.filter(temOcorr).length, sem: dias.filter(semMarc).length };
    if (FILTRO !== 'todos' && !n[FILTRO]) FILTRO = 'todos';
    var lista = dias.filter(passa), html = '', mes = '';
    lista.forEach(function (d) {
      var m = MESES[d.d.getMonth()] + ' de ' + d.d.getFullYear();
      if (m !== mes) { if (mes) html += '</ul></section>'; mes = m; html += '<section class="nc-ep-mes"><h4>' + esc(m.charAt(0).toUpperCase() + m.slice(1)) + '</h4><ul class="nc-ep-lista">'; }
      html += diaHtml(d);
    });
    if (mes) html += '</ul></section>';
    corpo.innerHTML =
      (ini && fim ? '<p class="nc-ep-periodo">' + ic('calendario') + '<span>' + esc(T.periodo(extenso(ini), extenso(fim))) + '</span></p>' : '') +
      '<div class="nc-ep-resumo">' +
        numero(T.previstas, v('P45_HORAS_PREVISTAS')) +
        numero(T.bhAnterior, v('P45_SALDO_BH_ANTERIOR')) +
        numero(T.bhPeriodo, v('P45_SALDO_BH_PERIODO')) +
        numero(T.bhAtual, v('P45_SALDO_ATUAL'), 'nc-ep-num--forte') +
        (vazio(v('P45_SALDO_BH_REMANESCENTE')) ? '' : numero(T.bhRemanescente, v('P45_SALDO_BH_REMANESCENTE'))) +
      '</div>' +
      (evs.length ? '<section class="nc-ep-eventos"><h4>' + esc(T.eventos) + '</h4><ul>' + evs.map(function (e) { return '<li><span>' + esc(e.nome) + '</span><b>' + esc(e.total) + '</b></li>'; }).join('') + '</ul></section>' : '') +
      '<div class="nc-ep-filtros" role="radiogroup" aria-label="Mostrar">' + ['todos', 'ocorr', 'sem'].filter(function (k) { return k === 'todos' || n[k]; }).map(function (k) {
        return '<button type="button" role="radio" aria-checked="' + (FILTRO === k) + '" data-f="' + k + '">' + esc(T[k]) + ' <b>' + n[k] + '</b></button>';
      }).join('') + '</div>' +
      (COMPLETANDO ? '<p class="nc-ep-completando" role="status"><i aria-hidden="true"></i>' + esc(T.completando) + '</p>' : '') +
      (lista.length ? html : '<p class="nc-ep-aviso">' + esc(T.nenhum) + '</p>');
  }
  /* o espelho vem de 50 em 50: pede todas as linhas (o mesmo que "Linhas por página").
     O pedido feito enquanto o relatório ainda está montando se perde: confere no próximo
     "apexafterrefresh" e tenta de novo (até 3 vezes). */
  var TENTATIVAS = 0;
  function carregarTodas() {
    var reg = $id('regiaolist');
    if (!reg.querySelector('.a-IRR-pagination [data-pagination]') || TENTATIVAS >= 3) { COMPLETANDO = false; return; }
    TENTATIVAS++;
    COMPLETANDO = true;
    setTimeout(function () {
      try { var w = $(reg.querySelector('.a-IRR-container')).interactiveReport('instance'); w.options.currentRowsPerPage = 1000; w._search('SEARCH'); } catch (e) { /* segue com a página que veio */ }
    }, 1200);
  }
  /* o cartão curto do colaborador é a peça global Natcorp_Colab; este app não carrega o
     Natcorp_Temas (que a traz), então ela vem da mesma pasta deste arquivo */
  function trazerColab() {
    if (window.__ncColab) return;
    var eu = [].filter.call(document.scripts, function (sc) { return /Natcorp_Espelho\.js/.test(sc.src); })[0];
    if (!eu) return;
    var sc = document.createElement('script'); sc.src = eu.src.replace(/Natcorp_Espelho\.js.*$/, 'Natcorp_Colab.js'); document.body.appendChild(sc);
  }

  /* ═══ [E7] PASSO 3 · A ASSINATURA ════════════════════════════════════════════════════════
     A região ORIGINAL do termo (P45_TEXTO_TERMO, o aceite P45_OPCAO e o botão Assinar) muda
     de lugar para depois do espelho; quem a mostra/esconde continua sendo a página. As
     assinaturas feitas são lidas do relatório "regiaoassinatura".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarAssinatura() {
    var termo = regiaoDe('P45_TEXTO_TERMO');
    var caixa = CAIXA.querySelector('.nc-ep-assinar');
    if (termo) { termo.classList.add('nc-ep-termo'); caixa.appendChild(termo); }
    var bt = termo && [].filter.call(termo.querySelectorAll('button'), function (b) { return /assinar/i.test(b.textContent); })[0];
    if (bt) rotuloBotao(bt, 'Assinar', 'caneta');
  }
  function desenharAssinaturas() {
    var feitas = lerAssinaturas(), p = CAIXA.querySelector('.nc-ep-assinado');
    p.innerHTML = feitas.length ? ic('ok') + '<span>' + esc(T.assinado(feitas[feitas.length - 1])) + '</span>' : '';
    p.hidden = !feitas.length;
    CAIXA.querySelector('.nc-ep-passo3').hidden = !feitas.length && !(CAIXA.querySelector('.nc-ep-termo') && getComputedStyle(CAIXA.querySelector('.nc-ep-termo')).display !== 'none');
  }

  /* ═══ [E8] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var CHAVE_MODO = 'nc-ep-modo';
  function modo(m) {
    try { localStorage.setItem(CHAVE_MODO, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-ep-tabela', m === 'tabela');
    [].forEach.call(document.querySelectorAll('.nc-ep-modo'), function (b) { b.hidden = b.getAttribute('data-modo') === m; });
  }
  var montado = false;
  function iniciar() {
    if (montado) return;
    montado = true;
    try {
      document.body.classList.add('nc-ep-ativo');
      var param = montarParametros();
      /* as regiões substituídas pelo desenho (ficam na página, fora da vista) */
      ['regiaolist', 'regiaoevento', 'regiaoassinatura'].forEach(function (id) { var r = $id(id), raiz = r && (r.parentElement.closest('.t-Region') || r); if (raiz) raiz.classList.add('nc-ep-original'); });
      var hp = regiaoDe('P45_HORAS_PREVISTAS'); if (hp) hp.classList.add('nc-ep-original');
      CAIXA = el('div', 'nc-ep');
      CAIXA.innerHTML =
        '<section class="nc-ep-cartao">' + passo(2, T.passo2, T.passo2Dica) + '<div class="nc-ep-conteudo" aria-live="polite"></div></section>' +
        '<section class="nc-ep-cartao nc-ep-passo3">' + passo(3, T.passo3, T.passo3Dica) + '<p class="nc-ep-assinado" hidden></p><div class="nc-ep-assinar"></div></section>' +
        '<button type="button" class="nc-ep-modo" data-modo="tabela">' + ic('tabela') + '<span>' + esc(T.verTabela) + '</span></button>';
      var depois = param || $id('ESPELHOPONTO');
      depois.parentNode.insertBefore(CAIXA, depois.nextSibling);
      var volta = el('button', 'nc-ep-modo nc-ep-modo--volta', ic('lista') + '<span>' + esc(T.verEspelho) + '</span>'); volta.type = 'button'; volta.setAttribute('data-modo', 'espelho');
      var esp = $id('ESPELHOPONTO'); if (esp) esp.parentNode.insertBefore(volta, esp);
      montarAssinatura();
      desenhar(); desenharAssinaturas();
      var m = 'espelho'; try { m = localStorage.getItem(CHAVE_MODO) || 'espelho'; } catch (e) { /* padrão */ }
      modo(m);
      /* "Ver meu espelho": a página calcula e atualiza os relatórios; o desenho segue */
      $(document).on('click', '#P45_LIST_ESPELHO', function () {
        LISTADO = true; MONTANDO = true; COMPLETANDO = false; TENTATIVAS = 0; INICIO = Date.now();
        modo('espelho');   /* "Ver meu espelho" mostra o espelho, mesmo que a pessoa estivesse na tabela */
        CAIXA.querySelector('.nc-ep-conteudo').innerHTML = ''; desenhar();
        var c = CAIXA.querySelector('.nc-ep-cartao'); if (c && c.getBoundingClientRect().top > window.innerHeight * .6) c.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
      $(document).on('apexafterrefresh', function (e) {
        var alvo = e.target && e.target.id;
        if (alvo === 'regiaolist' || $id('regiaolist').contains(e.target)) { setTimeout(function () { MONTANDO = false; COMPLETANDO = false; carregarTodas(); desenhar(); }, 30); }
        else if (alvo === 'regiaoevento' || ($id('regiaoevento') && $id('regiaoevento').contains(e.target))) setTimeout(desenhar, 30);
        else if (alvo === 'regiaoassinatura' || ($id('regiaoassinatura') && $id('regiaoassinatura').contains(e.target))) setTimeout(desenharAssinaturas, 30);
      });
      /* a validação do "Listar" recusou (mensagem em P45_MENSAGEM2): para o carregamento */
      $('#P45_MENSAGEM2').on('change', function () { if (v('P45_MENSAGEM2')) { MONTANDO = false; LISTADO = false; CAIXA.querySelector('.nc-ep-conteudo').innerHTML = ''; desenhar(); } });
      /* os totais chegam por ação dinâmica (change nos campos) */
      $('#P45_SALDO_ATUAL, #P45_HORAS_PREVISTAS, #P45_SALDO_BH_ANTERIOR, #P45_SALDO_BH_PERIODO').on('change', function () { setTimeout(desenhar, 30); });
      /* a região do termo aparece/some por ação dinâmica: o passo 3 acompanha */
      var termo = CAIXA.querySelector('.nc-ep-termo');
      if (termo && window.MutationObserver) new MutationObserver(desenharAssinaturas).observe(termo, { attributes: true, attributeFilter: ['style', 'class'] });
      document.addEventListener('click', function (e) {
        var md = e.target.closest('.nc-ep-modo'); if (md) { modo(md.getAttribute('data-modo')); return; }
        var f = e.target.closest('.nc-ep [data-f]'); if (f) { FILTRO = f.getAttribute('data-f'); desenhar(); }
      });
      carregarTodas();
      trazerColab();
    } catch (e) { if (window.console) console.error('Natcorp_Espelho', e); }
  }
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 1500); });
  if (document.readyState === 'complete') setTimeout(iniciar, 300);
})();
