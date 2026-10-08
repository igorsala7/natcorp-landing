/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · MARCAÇÕES DE PONTO  —  o "arrumador" das páginas (JavaScript)                 ║
   ║  App 300 (Portal do Colaborador) · Página 28 (os dias) + Página 9998 (o mapa, janela)    ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia destas páginas: MARCACOES-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O colaborador vem CONFERIR o próprio ponto: em que horas bateu em cada dia, e se a batida
   foi feita no lugar certo. Quase sempre no celular, e muitos leem com dificuldade. Então:
     Página 28 (Marcações de Ponto)
       • o horário de trabalho dele no alto ("Das 09:00 às 13:00 e das 14:40 às 18:00");
       • os dias em lista, os mais novos primeiro, separados por mês: a data grande com o dia
         da semana, e as POSIÇÕES do dia (posição 1, 2, 3…, como a empresa chama) como
         horários de tocar; cada horário tem uma bolinha: verde = dentro do raio, laranja =
         fora do raio. Tocar abre o mapa (o link original da batida, a janela 9998);
       • dias sem marcação ficam claros e dizem "Sem marcação"; exceção de escala e
         justificativa aparecem no dia;
       • botões no alto: Todos · Com marcação · Sem marcação · Fora do raio (com a contagem);
       • todas as linhas de uma vez (o relatório vinha de 50 em 50);
       • os filtros da página (datas, Batidas, Exceção, Pesquisar) continuam os ORIGINAIS.
     Página 9998 (a janela do mapa)
       • no alto: "Posição 1 · 06:30", o dia por extenso, e a situação (dentro/fora do raio);
       • o mapa maior;
       • "Abrir no mapa do celular" (Google Maps no ponto exato).

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Não grava nada. Não soma horas: a empresa trata as marcações por POSIÇÃO, não como
     entrada/saída (ver a memória do projeto). Os dados são LIDOS do relatório pelo TÍTULO das
     colunas. Tirou as URLs: volta o de antes.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Páginas 28 e 9998 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Marcacoes.js
     Páginas 28 e 9998 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Marcacoes.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [M1] Como as páginas são reconhecidas                                 CUIDADO
     [M2] Os textos                                                        PODE MEXER
     [M3] Ferramentas
     [M4] 28 · lê os dias do relatório (pelos títulos)                     CUIDADO
     [M5] 28 · o desenho: horário, filtros, meses e dias
     [M6] 28 · cartões × tabela, todas as linhas
     [M7] 9998 · a janela do mapa
     [M8] O maestro
*/
(function () {
  'use strict';
  if (window.__ncMarcacoes || !window.apex || !window.apex.jQuery) return;

  /* ═══ [M1] COMO AS PÁGINAS SÃO RECONHECIDAS ══════════════════════════════════════════════
     CUIDADO  28   = os itens P28_DATA_INI + P28_BATIDAS (o relatório .a-IRR é montado depois
                     deste arquivo: procurado na montagem, com novas tentativas);
              9998 = os itens P9998_LATLNG + P9998_POS.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function $id(id) { return document.getElementById(id); }
  var PAG = $id('P28_DATA_INI') && $id('P28_BATIDAS') ? 28 : ($id('P9998_LATLNG') && $id('P9998_POS') ? 9998 : 0);
  if (!PAG) return;
  window.__ncMarcacoes = true;
  var $ = window.apex.jQuery;

  /* ═══ [M2] OS TEXTOS ═════════════════════════════════════════════════════════════════════ */
  var T = {
    titulo: 'Suas marcações de ponto',
    periodo: function (a, b) { return 'De ' + a + ' até ' + b; },
    horario: 'Seu horário',
    dica: 'Toque no horário para ver no mapa onde a marcação foi feita.',
    todos: 'Todos', com: 'Com marcação', sem: 'Sem marcação', fora: 'Fora do raio',
    semMarcacao: 'Sem marcação',
    posicao: function (n) { return 'Posição ' + n; },
    dentro: 'Dentro do raio',
    foraRaio: 'Fora do raio',
    semLocal: 'Sem localização',
    comLocal: 'Com localização',
    excecao: 'Exceção de escala',
    nenhum: 'Nenhum dia neste filtro.',
    vazio: 'Nenhuma marcação no período. Escolha outras datas e toque em Pesquisar.',
    verTabela: 'Ver como tabela',
    verCartoes: 'Ver como lista',
    carregando: 'Trazendo todos os dias…',
    /* 9998 */
    abrirMapa: 'Abrir no mapa do celular',
    semPonto: 'Esta marcação não tem localização gravada.'
  };
  var SEMANA = ['domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sábado'];
  var SEM3 = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];

  /* ═══ [M3] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function limpo(t) { return String(t == null ? '' : t).replace(/ /g, ' ').replace(/\s+/g, ' ').trim(); }
  function sem(t) { return limpo(t).toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  function vazio(t) { return !t || /^\s*(-|—|null)\s*$/i.test(t); }
  function data(t) { var m = /(\d{2})\/(\d{2})\/(\d{4})/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function extenso(d) { return (d.getDate() === 1 ? '1º' : d.getDate()) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear(); }
  function nomeDe(t) { return limpo(String(t || '').replace(/^\s*[\w.]+\s+-\s+/, '')); }
  var IC = {
    relogio: '<circle cx="12" cy="12" r="8.2"/><path d="M12 7.5V12l3 2"/>',
    pino: '<path d="M12 21s-6.5-5.6-6.5-11a6.5 6.5 0 0 1 13 0c0 5.4-6.5 11-6.5 11z"/><circle cx="12" cy="10" r="2.4"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14.5" rx="2"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    alerta: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2v.1"/>',
    nota: '<path d="M5 4.5h14v15H5z"/><path d="M8.5 9h7M8.5 12.5h7M8.5 16h4"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M9 10v9"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1.1"/><circle cx="4.8" cy="12" r="1.1"/><circle cx="4.8" cy="17.5" r="1.1"/>',
    externo: '<path d="M14 4.5h5.5V10M19.5 4.5 11 13M18 14v4.5a1.5 1.5 0 0 1-1.5 1.5h-11A1.5 1.5 0 0 1 4 18.5v-11A1.5 1.5 0 0 1 5.5 6H10"/>'
  };
  function ic(n, cls) { return '<svg class="nc-mc-ic' + (cls ? ' ' + cls : '') + '" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + IC[n] + '</svg>'; }
  /* "181 - Das 09:00 Às 13:00 E 14:40 As 18:00" → "Das 09:00 às 13:00 e das 14:40 às 18:00" */
  function jornada(t) {
    t = nomeDe(t).toLowerCase().replace(/\bas\b/g, 'às').replace(/\s+e\s+(\d)/g, ' e das $1');
    return t.charAt(0).toUpperCase() + t.slice(1);
  }
  function statusDe(t) { var s = sem(t); return /fora/.test(s) ? 'fora' : (/dentro/.test(s) ? 'dentro' : (/\d/.test(s) ? 'ponto' : '')); }

  /* ═══ [M4] 28 · LÊ OS DIAS DO RELATÓRIO (PELOS TÍTULOS) ══════════════════════════════════
     CUIDADO  colunas: "Data", "Batida N" (o link abre o mapa), "Local N" (a coordenada + "Dentro
              do Raio"/"Fora do Raio"), "Jornada", "Escala", "Exceção (Escala)", "Justificativa",
              "Local de Trabalho". As colunas N vão até 10; as que a pessoa escondeu no relatório
              simplesmente não vêm.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var IR, IRREG, CAIXA, DIAS = [], FILTRO = 'todos';
  function lerDias() {
    var col = {};
    [].forEach.call(IR.querySelectorAll('th[id]'), function (th) { var k = sem(th.textContent); if (k && !col[k]) col[k] = th.id; });
    function td(tr, k) { return col[k] && tr.querySelector('td[headers="' + col[k] + '"]'); }
    function txt(tr, k) { var c = td(tr, k); return c ? limpo(c.textContent) : ''; }
    var linhas = [].slice.call(IR.querySelectorAll('table.a-IRR-table tr')).filter(function (tr) { return tr.querySelector('td[headers]'); });
    return linhas.map(function (tr) {
      var d = data(txt(tr, 'data')); if (!d) return null;
      var pos = [];
      for (var n = 1; n <= 10; n++) {
        var b = td(tr, 'batida ' + n); if (!b) continue;
        var hora = limpo(b.textContent); if (vazio(hora)) continue;
        var l = td(tr, 'local ' + n);
        pos.push({ n: n, hora: hora, link: b.querySelector('a') || (l && l.querySelector('a')), status: l ? statusDe(l.textContent) : '' });
      }
      return {
        d: d, pos: pos, jornada: txt(tr, 'jornada'), escala: txt(tr, 'escala'), local: txt(tr, 'local de trabalho'),
        excecao: /^sim/i.test(txt(tr, 'excecao (escala)')), justif: vazio(txt(tr, 'justificativa')) ? '' : txt(tr, 'justificativa')
      };
    }).filter(Boolean).sort(function (a, b) { return b.d - a.d; });
  }

  /* ═══ [M5] 28 · O DESENHO: HORÁRIO, FILTROS, MESES E DIAS ════════════════════════════════ */
  function passa(dia) {
    if (FILTRO === 'com') return dia.pos.length > 0;
    if (FILTRO === 'sem') return dia.pos.length === 0;
    if (FILTRO === 'fora') return dia.pos.some(function (p) { return p.status === 'fora'; });
    return true;
  }
  function diaHtml(dia, i) {
    var fds = dia.d.getDay() === 0 || dia.d.getDay() === 6;
    return '<li class="nc-mc-dia' + (dia.pos.length ? '' : ' nc-mc-dia--sem') + (fds ? ' nc-mc-dia--fds' : '') + '">' +
      '<div class="nc-mc-data"><b>' + dia.d.getDate() + '</b><span>' + SEM3[dia.d.getDay()] + '</span></div>' +
      '<div class="nc-mc-dia-corpo">' +
        '<p class="nc-mc-dia-nome">' + esc(SEMANA[dia.d.getDay()].charAt(0).toUpperCase() + SEMANA[dia.d.getDay()].slice(1) + ', ' + dia.d.getDate() + ' de ' + MESES[dia.d.getMonth()]) + '</p>' +
        (dia.pos.length ? '<ul class="nc-mc-posicoes">' + dia.pos.map(function (p) {
          var st = p.status === 'fora' ? T.foraRaio : (p.status === 'dentro' ? T.dentro : (p.status === 'ponto' ? T.comLocal : T.semLocal));
          return '<li><button type="button" class="nc-mc-pos nc-mc-pos--' + (p.status || 'nada') + '" data-dia="' + i + '" data-n="' + p.n + '"' + (p.link ? '' : ' disabled') +
            ' aria-label="' + esc(T.posicao(p.n) + ', ' + p.hora + ', ' + st) + '">' +
            '<span class="nc-mc-pos-n">' + esc(T.posicao(p.n)) + '</span><b>' + esc(p.hora) + '</b>' +
            '<i class="nc-mc-ponto" title="' + esc(st) + '"></i></button></li>';
        }).join('') + '</ul>' : '<p class="nc-mc-semmarc">' + esc(T.semMarcacao) + '</p>') +
        ((dia.excecao || dia.justif) ? '<p class="nc-mc-obs">' + (dia.excecao ? '<span class="nc-mc-etq">' + esc(T.excecao) + '</span>' : '') + (dia.justif ? '<span>' + ic('nota') + esc(dia.justif) + '</span>' : '') + '</p>' : '') +
      '</div></li>';
  }
  function desenhar() {
    DIAS = lerDias();
    var topo = CAIXA.querySelector('.nc-mc-topo-info'), corpo = CAIXA.querySelector('.nc-mc-dias'), filtros = CAIXA.querySelector('.nc-mc-filtros');
    /* o horário: o mais comum entre os dias */
    var conta = {}; DIAS.forEach(function (d) { if (d.jornada) conta[d.jornada] = (conta[d.jornada] || 0) + 1; });
    var jor = Object.keys(conta).sort(function (a, b) { return conta[b] - conta[a]; })[0];
    var ini = data(($id('P28_DATA_INI') || {}).value), fim = data(($id('P28_DATA_FIM') || {}).value);
    var local = DIAS[0] && DIAS[0].local ? nomeDe(DIAS[0].local).replace(/\s(De|Da|Do|Das|Dos|E)\s/g, function (m, w) { return ' ' + w.toLowerCase() + ' '; }).replace(/\bRh\b/g, 'RH').replace(/\bGerencia\b/g, 'Gerência') : '';
    topo.innerHTML =
      (ini && fim ? '<p class="nc-mc-periodo">' + ic('calendario') + '<span>' + esc(T.periodo(extenso(ini), extenso(fim))) + '</span></p>' : '') +
      (jor ? '<div class="nc-mc-horario"><span>' + esc(T.horario) + '</span><b>' + esc(jornada(jor)) + '</b>' + (local ? '<em>' + esc(local) + '</em>' : '') + '</div>' : '');
    var n = { todos: DIAS.length, com: 0, sem: 0, fora: 0 };
    DIAS.forEach(function (d) { if (d.pos.length) n.com++; else n.sem++; if (d.pos.some(function (p) { return p.status === 'fora'; })) n.fora++; });
    if (FILTRO !== 'todos' && !n[FILTRO]) FILTRO = 'todos';
    filtros.innerHTML = ['todos', 'com', 'sem', 'fora'].filter(function (k) { return k === 'todos' || n[k]; }).map(function (k) {
      return '<button type="button" role="radio" aria-checked="' + (FILTRO === k) + '" data-f="' + k + '" class="nc-mc-f--' + k + '">' + (k === 'fora' ? '<i class="nc-mc-ponto nc-mc-ponto--fora"></i>' : '') + esc(T[k]) + ' <b>' + n[k] + '</b></button>';
    }).join('');
    filtros.hidden = DIAS.length === 0;
    if (!DIAS.length) { corpo.innerHTML = '<p class="nc-mc-vazio">' + esc(T.vazio) + '</p>'; return; }
    var html = '', mesAtual = '';
    var lista = DIAS.filter(passa);
    lista.forEach(function (d) {
      var mes = MESES[d.d.getMonth()] + ' de ' + d.d.getFullYear();
      if (mes !== mesAtual) { if (mesAtual) html += '</ul></section>'; mesAtual = mes; html += '<section class="nc-mc-mes"><h3>' + esc(mes.charAt(0).toUpperCase() + mes.slice(1)) + '</h3><ul class="nc-mc-lista">'; }
      html += diaHtml(d, DIAS.indexOf(d));
    });
    if (mesAtual) html += '</ul></section>';
    corpo.innerHTML = lista.length ? html : '<p class="nc-mc-vazio">' + esc(T.nenhum) + '</p>';
  }

  /* ═══ [M6] 28 · CARTÕES × TABELA, TODAS AS LINHAS ════════════════════════════════════════ */
  var CHAVE_MODO = 'nc-mc-modo', TODAS = false;
  function modo(m) {
    try { localStorage.setItem(CHAVE_MODO, m); } catch (e) { /* sem armazenamento */ }
    document.body.classList.toggle('nc-mc-tabela', m === 'tabela');
    [].forEach.call(document.querySelectorAll('.nc-mc-modo'), function (b) { b.hidden = b.getAttribute('data-modo') === m; });
  }
  /* o relatório vem de 50 em 50: pede todas (o mesmo que "Linhas por página" no menu Ações) */
  function carregarTodas() {
    if (TODAS) return;
    if (!IRREG.querySelector('.a-IRR-pagination [data-pagination]')) return;
    TODAS = true;
    try {
      var w = $(IRREG.querySelector('.a-IRR-container')).interactiveReport('instance');
      w.options.currentRowsPerPage = 1000;
      CAIXA.querySelector('.nc-mc-dias').insertAdjacentHTML('afterbegin', '<p class="nc-mc-carregando">' + esc(T.carregando) + '</p>');
      w._search('SEARCH');
    } catch (e) { /* segue com a página que veio */ }
  }
  var montado = false;
  function iniciar28() {
    if (montado) return;
    IR = document.querySelector('.a-IRR');
    if (!IR) return;
    montado = true;
    try {
      document.body.classList.add('nc-mc-ativo');
      IRREG = IR.closest('.t-IRR-region, .t-Region') || IR.parentNode;
      CAIXA = el('div', 'nc-mc');
      CAIXA.innerHTML =
        '<header class="nc-mc-topo"><h2 class="nc-mc-h1">' + ic('relogio', 'nc-mc-h1-ic') + esc(T.titulo) + '</h2><div class="nc-mc-topo-info"></div>' +
          '<p class="nc-mc-dica">' + ic('pino') + '<span>' + esc(T.dica) + '</span></p></header>' +
        '<div class="nc-mc-filtros" role="radiogroup" aria-label="Mostrar"></div>' +
        '<div class="nc-mc-dias" aria-live="polite"></div>' +
        '<button type="button" class="nc-mc-modo" data-modo="tabela">' + ic('tabela') + '<span>' + esc(T.verTabela) + '</span></button>';
      IRREG.parentNode.insertBefore(CAIXA, IRREG);
      var volta = el('button', 'nc-mc-modo nc-mc-modo--volta', ic('lista') + '<span>' + esc(T.verCartoes) + '</span>'); volta.type = 'button'; volta.setAttribute('data-modo', 'cartoes');
      IRREG.parentNode.insertBefore(volta, IRREG);
      desenhar();
      var m = 'cartoes'; try { m = localStorage.getItem(CHAVE_MODO) || 'cartoes'; } catch (e) { /* padrão */ }
      modo(m);
      carregarTodas();
      $(document).on('apexafterrefresh', function (e) { if (IRREG.contains(e.target) || e.target === IRREG) { IR = IRREG.querySelector('.a-IRR') || IR; desenhar(); } });
      CAIXA.addEventListener('click', function (e) {
        var f = e.target.closest('[data-f]');
        if (f) { FILTRO = f.getAttribute('data-f'); desenhar(); return; }
        var p = e.target.closest('.nc-mc-pos');
        if (p) {
          var dia = DIAS[+p.getAttribute('data-dia')], n = +p.getAttribute('data-n');
          var pos = dia && dia.pos.filter(function (x) { return x.n === n; })[0];
          if (!pos || !pos.link) return;
          /* a janela do mapa só recebe os códigos: o dia, a hora e a situação vão junto */
          try { sessionStorage.setItem('nc-mc-abrindo', JSON.stringify({ n: n, hora: pos.hora, status: pos.status, dia: dia.d.getTime() })); } catch (x) { /* sem armazenamento */ }
          pos.link.click();
        }
      });
      document.addEventListener('click', function (e) { var md = e.target.closest('.nc-mc-modo'); if (md) modo(md.getAttribute('data-modo')); });
    } catch (e) { if (window.console) console.error('Natcorp_Marcacoes', e); }
  }

  /* ═══ [M7] 9998 · A JANELA DO MAPA ═══════════════════════════════════════════════════════
     A posição (P9998_POS) e a coordenada (P9998_LAT/LNG, que chegam por ação dinâmica ao abrir)
     são da página. O dia por extenso, a hora e a situação vêm da página 28 (sessionStorage),
     só quando a posição bate.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function iniciar9998() {
    if (document.body.classList.contains('nc-mc-janela')) return;
    document.body.classList.add('nc-mc-janela');
    var pos = limpo($id('P9998_POS').value);
    var info = {}; try { info = JSON.parse(sessionStorage.getItem('nc-mc-abrindo') || '{}'); } catch (e) { info = {}; }
    if (String(info.n) !== pos) info = {};
    var d = info.dia ? new Date(info.dia) : data($id('P9998_DATA') && $id('P9998_DATA').value);
    var stEl = $id('P9998_STATUS_DISPLAY') || $id('P9998_STATUS');
    var stTxt = limpo(stEl ? (stEl.value != null && stEl.tagName === 'INPUT' ? stEl.value : stEl.textContent) : '');
    var st = statusDe(stTxt) || info.status || '';
    var cab = el('div', 'nc-mc-mapa-cab');
    function desenharCab() {
      var lat = limpo(($id('P9998_LAT') || {}).value), lng = limpo(($id('P9998_LNG') || {}).value);
      var tem = lat && lng && lat !== '0' && lng !== '0';
      /* a situação já está no alto: o campo Status da página (o mesmo texto) sai da vista */
      document.body.classList.toggle('nc-mc-com-situacao', st === 'dentro' || st === 'fora');
      cab.innerHTML =
        '<p class="nc-mc-mapa-pos">' + esc(T.posicao(pos)) + (info.hora ? ' · <b>' + esc(info.hora) + '</b>' : '') + '</p>' +
        (d ? '<p class="nc-mc-mapa-dia">' + esc(SEMANA[d.getDay()].charAt(0).toUpperCase() + SEMANA[d.getDay()].slice(1) + ', ' + extenso(d)) + '</p>' : '') +
        (st === 'dentro' || st === 'fora' ? '<p class="nc-mc-mapa-st nc-mc-mapa-st--' + st + '"><i class="nc-mc-ponto nc-mc-ponto--' + st + '"></i>' + esc(st === 'fora' ? T.foraRaio : T.dentro) + '</p>' : '') +
        (tem ? '<a class="nc-mc-mapa-link" target="_blank" rel="noopener" href="https://www.google.com/maps/search/?api=1&query=' + encodeURIComponent(lat.replace(',', '.') + ',' + lng.replace(',', '.')) + '">' + ic('externo') + '<span>' + esc(T.abrirMapa) + '</span></a>'
             : '<p class="nc-mc-mapa-sem">' + esc(T.semPonto) + '</p>');
    }
    /* entra antes da região "Mapa" (pelo título, que existe mesmo escondido) */
    var reg = [].filter.call(document.querySelectorAll('.t-Region'), function (r) { var h = r.querySelector('.t-Region-title'); return h && /mapa/i.test(h.textContent); })[0] || document.querySelector('.t-Dialog-body .t-Region');
    if (!reg) return;
    reg.classList.add('nc-mc-mapa-reg');
    reg.parentNode.insertBefore(cab, reg);
    desenharCab();
    $('#P9998_LAT, #P9998_LNG, #P9998_LATLNG').on('change', desenharCab);
    $(window).one('apexreadyend', function () { setTimeout(desenharCab, 50); });
    try { var dlg = window.frameElement && window.frameElement.closest('.ui-dialog'), tt = dlg && dlg.querySelector('.ui-dialog-title'); if (tt) tt.textContent = 'Onde a marcação foi feita'; } catch (e) { /* outra origem */ }
  }

  /* ═══ [M8] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var iniciar = PAG === 28 ? iniciar28 : iniciar9998;
  $(window).one('apexreadyend', function () { setTimeout(iniciar, 0); });
  $(function () { setTimeout(iniciar, 800); setTimeout(iniciar, 3000); });
  if (document.readyState === 'complete') setTimeout(iniciar, 200);
})();
