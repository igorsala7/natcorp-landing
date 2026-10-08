/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · HISTÓRICO DE CONSULTAS  —  o "arrumador" da tela (JavaScript)                 ║
   ║  App 2937 (Medicina Ocupacional) · Página 26 ("Consulta Matricula", a janela)            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Guia desta página: HISTORICOCONSULTAS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   O médico abre esta janela para ver o passado do paciente na agenda: quando foi atendido,
   por quem, que tipo de consulta, se veio, se foi atendido. Antes: 5 campos de pesquisa e
   uma planilha de 10 colunas ("Hr. Início Previsto", "Compareceu: Não"…).
   Agora:
     • no alto, QUEM é o paciente (código - nome, funcionário ou candidato, empresa) e o
       resumo em uma frase ("6 consultas de 2019 a 2026 · 1 realizada · 4 faltas"), com a
       FAIXA DE COMPARECIMENTO: uma marca por consulta, da mais antiga à mais nova, na cor da
       situação — o padrão de faltas aparece num olhar; tocar numa marca leva à consulta;
     • a próxima consulta marcada, se houver;
     • a lista por ano, da mais nova para a mais antiga: a data (dia, mês, dia da semana), o
       tipo de consulta, o profissional, a situação (Realizada / Veio, não foi atendido /
       Faltou / Agendada / Sem registro) e os horários numa frase (previsto, chegada,
       atendimento e quanto durou, quanto esperou);
     • filtros: período (Tudo, 12 meses, 3 anos, Escolher datas), situação e tipo (com
       quantos), profissional, busca; "Limpar filtros";
     • "Trocar paciente" abre a pesquisa original (empresa, tipo, paciente);
     • Lista | Tabela: a Tabela é o relatório original (exportar, imprimir…);
     • vinda da Agenda (botão "Histórico de consultas" do paciente), a janela já abre com ele.

   ── O QUE ELE NÃO FAZ (de propósito) ──────────────────────────────────────────────────────
     Nada é gravado: a janela só lê. Os itens de pesquisa são os originais (P26_*) — o
     relatório da Tabela e a ação dinâmica "Atualiza informações" seguem como sempre.
     A lista vem do processo NC_HIST_CONSULTAS (Ajax Callback que o
     aplicar-historicoconsultas-pagina26.py põe). Sem ele, a página fica como era.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 26 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_HistoricoConsultas.js
     Página 26 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_HistoricoConsultas.css

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [H1]  Textos, situações e tipos de consulta                            PODE MEXER
     [H2]  Ferramentas
     [H3]  Ler o histórico (processo NC_HIST_CONSULTAS)                     CUIDADO
     [H4]  Montar a tela: quem, resumo, filtros, lista
     [H5]  Período (os itens de data originais)
     [H6]  Filtrar e desenhar a lista
     [H7]  Vindo da Agenda: o paciente já escolhido                         CUIDADO
     [H8]  O maestro
*/
(function () {
  'use strict';
  if (window.__ncHistoricoConsultas || !window.apex || !window.apex.jQuery) return;
  var $ = apex.jQuery;

  /* ═══ [H1] TEXTOS, SITUAÇÕES E TIPOS DE CONSULTA ═════════════════════════════════════════
     SITUACOES  o nome de cada situação (a cor é do CSS [C5], pela chave).
     CONSULTAS  o tom de cada tipo de consulta, pelo código — o MESMO da Agenda (página 10).
     PODE MEXER
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PROC = 'NC_HIST_CONSULTAS';
  var SITUACOES = {
    realizada: 'Realizada',
    veio: 'Veio, não foi atendido',
    faltou: 'Faltou',
    agendada: 'Agendada',
    sem: 'Sem registro'
  };
  var ORDEM_SIT = ['realizada', 'veio', 'faltou', 'agendada', 'sem'];
  var CONSULTAS = { '04': 'admissional', '05': 'demissional', '01': 'periodico', '07': 'mudanca', '09': 'retorno', '11': 'retorno',
    '02': 'ocupacional', '03': 'pericia', '13': 'pericia', '06': 'abono', '08': 'avaliacao', '10': 'avaliacao', '12': 'pericia' };
  var PERIODOS = [['tudo', 'Tudo'], ['12m', '12 meses'], ['3a', '3 anos'], ['datas', 'Escolher datas']];
  var CHAVE_AGENDA = 'nc-hc-abrir';   /* a Agenda (Natcorp_AgendaMedica.js) deixa o paciente aqui */

  /* ═══ [H2] FERRAMENTAS ═══════════════════════════════════════════════════════════════════ */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var SEMANA = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  function $id(id) { return document.getElementById(id); }
  function el(tag, cls, h) { var e = document.createElement(tag); if (cls) e.className = cls; if (h !== undefined) e.innerHTML = h; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function nome(t) {
    return String(t || '').toLowerCase().replace(/(^|[\s'(/-])([a-zà-ú])/g, function (m, a, b) { return a + b.toUpperCase(); })
      .replace(/\s(De|Da|Do|Das|Dos|E|Em)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  /* "07 - MUDANÇA DE FUNÇÃO" → "07 - Mudança de função" (pessoa e empresa: cada palavra) */
  function frase(t) { t = String(t || '').trim(); if (/[a-zà-ú]/.test(t)) return t; t = t.toLowerCase(); return t.charAt(0).toUpperCase() + t.slice(1); }
  function codDesc(t, pessoa) {
    t = String(t || '').trim(); if (!t) return '';
    var m = /^(\S+)\s+-\s+(.+)$/.exec(t), f = pessoa ? nome : frase;
    if (!m) return /[a-zà-ú]/.test(t) ? t : f(t);
    return m[1] + ' - ' + (/[a-zà-ú]/.test(m[2]) ? m[2] : f(m[2]));
  }
  function valor(id) { return apex.item(id) ? String(apex.item(id).getValue() || '') : ''; }
  function mostra(id) { var e = $id(id + '_DISPLAY') || $id(id); if (!e) return ''; if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : ''; return String(e.value || e.textContent || '').trim(); }
  /* "05/10/2026" ↔ Date */
  function data(t) { var m = /^(\d{1,2})\/(\d{1,2})\/(\d{4})/.exec(String(t || '')); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function ddmm(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function hoje() { var n = new Date(); return new Date(n.getFullYear(), n.getMonth(), n.getDate()); }
  /* "08:05" → minutos; "00:00" é o campo vazio do banco (hora sem valor), não meia-noite */
  function hm(t) { var m = /^(\d{1,2}):(\d{2})/.exec(String(t || '')); if (!m || (m[1] === '00' && m[2] === '00')) return null; return +m[1] * 60 + +m[2]; }
  function hora(t) { return hm(t) === null ? '' : String(t).slice(0, 5); }
  function dur(min) { if (min == null || min < 0) return ''; return min < 60 ? min + ' min' : Math.floor(min / 60) + ' h' + (min % 60 ? ' ' + (min % 60) + ' min' : ''); }
  function plural(n, um, varios) { return n + ' ' + (n === 1 ? um : varios); }
  function sem(t) { return String(t || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
  var IC = {
    trocar: '<path d="M4 8h12.5M13 4.5L16.5 8 13 11.5M20 16H7.5M11 12.5L7.5 16l3.5 3.5"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4 4"/>',
    check: '<path d="M5.5 12.5l4.2 4.2 8.8-9.4"/>',
    x: '<path d="M7 7l10 10M17 7L7 17"/>',
    relogio: '<circle cx="12" cy="12" r="8"/><path d="M12 7.5V12l3 2"/>',
    porta: '<path d="M10 7l5 5-5 5M15 12H4M14 4.5h4.5A1.5 1.5 0 0 1 20 6v12a1.5 1.5 0 0 1-1.5 1.5H14"/>',
    calendario: '<rect x="4" y="5.5" width="16" height="14" rx="2.5"/><path d="M4 10h16M8.5 3.5v4M15.5 3.5v4"/>',
    traco: '<path d="M7 12h10"/>',
    lista: '<path d="M9 6.5h11M9 12h11M9 17.5h11"/><circle cx="4.8" cy="6.5" r="1"/><circle cx="4.8" cy="12" r="1"/><circle cx="4.8" cy="17.5" r="1"/>',
    tabela: '<rect x="3.5" y="5" width="17" height="14" rx="2"/><path d="M3.5 10h17M3.5 14.5h17M9.5 10v9"/>',
    pessoa: '<circle cx="12" cy="8.5" r="3.5"/><path d="M5 20a7 7 0 0 1 14 0"/>'
  };
  function ic(n) { return '<svg class="nc-hc-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  var ICS = { realizada: 'check', veio: 'porta', faltou: 'x', agendada: 'calendario', sem: 'traco' };
  function digitando(e) { return e && (/^(TEXTAREA|SELECT)$/.test(e.tagName) || (e.tagName === 'INPUT' && !/^(button|checkbox|radio)$/i.test(e.type)) || e.isContentEditable); }
  /* espera o APEX terminar as chamadas (a cascata empresa/tipo → paciente) */
  function quandoLivre(fn, t0) { t0 = t0 || Date.now(); if ($.active > 0 && Date.now() - t0 < 5000) return setTimeout(function () { quandoLivre(fn, t0); }, 80); setTimeout(fn, 60); }

  /* ═══ [H3] LER O HISTÓRICO ═══════════════════════════════════════════════════════════════
     CUIDADO  NC_HIST_CONSULTAS lê agendas_medicos_horarios do paciente (mesma consulta do
              relatório "Horários", sem o filtro de datas — o período é filtrado aqui) e
              devolve { consultas: [ {data, ini_prev, fim_prev, chegada, ini_real, fim_real,
              compareceu, realizou, tipo, tipo_desc, prof, prof_nome} ] }. Os itens P26_* vão
              junto (pageItems). error próprio: sem o aviso vermelho do APEX se o processo
              ainda não foi importado.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var ITENS = '#P26_COD_EMPRESA,#P26_TIPO_PACIENTE,#P26_COD_PACIENTE';
  function ler() {
    return apex.server.process(PROC, { pageItems: ITENS }, { dataType: 'json', error: function () {} });
  }
  function situacao(c, d) {
    if (c.realizou === 'S') return 'realizada';
    if (c.compareceu === 'S') return 'veio';
    if (d && d >= hoje()) return 'agendada';
    if (c.compareceu === 'N') return 'faltou';
    return 'sem';
  }
  function normalizar(lista) {
    return (lista || []).map(function (c, i) {
      var d = data(c.data), ini = hm(c.ini_real), fim = hm(c.fim_real), che = hm(c.chegada);
      var o = {
        i: i, d: d, data: c.data || '',
        prevIni: hora(c.ini_prev), prevFim: hora(c.fim_prev), chegada: hora(c.chegada), realIni: hora(c.ini_real), realFim: hora(c.fim_real),
        tipo: String(c.tipo || ''), tipoTxt: c.tipo ? codDesc(c.tipo + (c.tipo_desc ? ' - ' + c.tipo_desc : '')) : 'Tipo não informado',
        prof: String(c.prof || ''), profTxt: c.prof ? codDesc(c.prof + (c.prof_nome ? ' - ' + c.prof_nome : ''), true) : '',
        duracao: ini != null && fim != null ? fim - ini : null,
        espera: che != null && ini != null ? ini - che : null
      };
      o.sit = situacao(c, d);
      o.busca = sem([o.data, o.tipoTxt, o.profTxt, SITUACOES[o.sit]].join(' '));
      return o;
    });
  }

  /* ═══ [H4] MONTAR A TELA ══════════════════════════════════════════════════════════════════ */
  function iniciar() {
    var cEmp = $id('P26_COD_EMPRESA_CONTAINER'), cPac = $id('P26_COD_PACIENTE_CONTAINER');
    if (!cEmp || !cPac) return;
    window.__ncHistoricoConsultas = true;
    var regBusca = cEmp.closest('.t-Region');
    var ir = document.querySelector('.a-IRR-container, .a-IRR');
    var regIR = ir && (ir.closest('.t-Region') || ir.closest('[id^="R"]'));
    var cIni = $id('P26_DATA_INICIAL_CONTAINER'), cFim = $id('P26_DATA_FINAL_CONTAINER');
    var DADOS = null, F = { sit: '', tipo: '', prof: '', q: '' }, MODO = 'lista', LEITURA = null;
    try { MODO = localStorage.getItem('nc-hc-modo') === 'tabela' ? 'tabela' : 'lista'; } catch (x) { /* sem armazenamento: começa na lista */ }

    /* o processo existe? Só depois da 1ª resposta a tela muda (sem ele, a página fica como era) */
    var app;
    vindoDaAgenda(function () {
      ler().done(function (d) {
        if (!d || !d.consultas) return;
        montar();
        receber(d);
      });
    });

    function montar() {
      document.body.classList.add('nc-hc-ativo');
      app = el('section', 'nc-hc'); app.setAttribute('aria-label', 'Histórico de consultas');
      regBusca.parentNode.insertBefore(app, regBusca);
      app.innerHTML =
        '<header class="nc-hc-cab"></header>' +
        '<div class="nc-hc-trocar" hidden><div class="nc-hc-trocar-cab"><h2>Escolha o paciente</h2><p>Empresa, tipo e paciente — a lista se atualiza sozinha.</p></div></div>' +
        '<div class="nc-hc-corpo"></div>';
      var painel = app.querySelector('.nc-hc-trocar');
      painel.appendChild(regBusca);
      regBusca.classList.add('nc-hc-busca');
      /* as datas vão para a barra de filtros (Escolher datas) */
      app._datas = el('div', 'nc-hc-datas'); app._datas.hidden = true;
      [cIni, cFim].forEach(function (c) { if (c) app._datas.appendChild(c); });
      if (regIR) { regIR.classList.add('nc-hc-tabela'); app.appendChild(regIR); }
      ligar();
    }

    /* — recebe os dados e redesenha tudo — */
    function receber(d) {
      DADOS = normalizar(d.consultas);
      F = { sit: '', tipo: '', prof: '', q: '' };
      cabecalho();
      corpo();
    }
    function recarregar() {
      if (!app) return;
      if (!temPaciente()) { DADOS = []; cabecalho(); corpo(); return; }
      app.querySelector('.nc-hc-corpo').innerHTML = '<p class="nc-hc-carregando" role="status">Carregando o histórico…</p>';
      ler().done(function (d) { receber(d || {}); }).fail(function () {
        app.querySelector('.nc-hc-corpo').innerHTML = '<div class="nc-hc-vazio" role="alert"><p><b>Não foi possível ler o histórico.</b></p><p>Tente de novo; se continuar, use a Tabela.</p><button type="button" class="nc-hc-bt" data-recarregar>Tentar de novo</button></div>';
      });
    }
    function temPaciente() { return !!(valor('P26_COD_EMPRESA') && valor('P26_TIPO_PACIENTE') && valor('P26_COD_PACIENTE')); }

    /* — quem é o paciente + resumo + faixa de comparecimento — */
    function cabecalho() {
      var cab = app.querySelector('.nc-hc-cab'), painel = app.querySelector('.nc-hc-trocar');
      if (!temPaciente()) {
        cab.hidden = true; painel.hidden = false;
        setTimeout(function () { var i = painel.querySelector('input:not([type=hidden]), select'); if (i && !valor('P26_COD_EMPRESA')) i.focus(); }, 80);
        return;
      }
      cab.hidden = false; painel.hidden = true;   /* paciente escolhido: a pesquisa se recolhe */
      var quem = mostra('P26_COD_PACIENTE'), m = /^\s*(\S+)\s+-\s+(.+)$/.exec(quem), cod = m ? m[1] : valor('P26_COD_PACIENTE'), nm = m ? m[2] : quem;
      if (nm && !/[a-zà-ú]/.test(nm)) nm = nome(nm);
      var ini = String(nm || '?').split(/\s+/).filter(function (p) { return p.length > 2; });
      ini = ((ini[0] || '?').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '')).toUpperCase();
      var tipo = mostra('P26_TIPO_PACIENTE') || (valor('P26_TIPO_PACIENTE') === '2' ? 'Candidato' : 'Funcionário');
      var emp = codDesc(mostra('P26_COD_EMPRESA'), true);
      var n = DADOS.length, cont = contar(DADOS, 'sit');
      var datas = DADOS.map(function (c) { return c.d; }).filter(Boolean).sort(function (a, b) { return a - b; });
      var resumo = n ? [plural(n, 'consulta', 'consultas') + (datas.length ? (datas[0].getFullYear() === datas[datas.length - 1].getFullYear() ? ' em ' + datas[0].getFullYear() : ' de ' + datas[0].getFullYear() + ' a ' + datas[datas.length - 1].getFullYear()) : '')]
        .concat(ORDEM_SIT.filter(function (s) { return cont[s]; }).map(function (s) { return '<span data-s="' + s + '">' + plural(cont[s], rotuloCurto(s, 1), rotuloCurto(s, 2)) + '</span>'; })).join(' · ')
        : 'Nenhuma consulta na agenda';
      /* a faixa: da mais antiga para a mais nova (lê-se como o tempo) */
      var faixa = DADOS.slice().sort(function (a, b) { return (a.d || 0) - (b.d || 0); });
      var prox = DADOS.filter(function (c) { return c.sit === 'agendada'; }).sort(function (a, b) { return a.d - b.d; })[0];
      cab.innerHTML =
        '<div class="nc-hc-quem"><span class="nc-hc-avatar" aria-hidden="true">' + esc(ini) + '</span>' +
          '<div class="nc-hc-quem-txt"><h1>' + (cod ? '<span class="nc-hc-cod">' + esc(cod) + ' - </span>' : '') + esc(nm || 'Paciente') + '</h1>' +
          '<p>' + esc(tipo) + (emp ? ' · ' + esc(emp) : '') + '</p></div>' +
          '<button type="button" class="nc-hc-bt" data-trocar aria-expanded="' + (!app.querySelector('.nc-hc-trocar').hidden) + '">' + ic('trocar') + 'Trocar paciente</button></div>' +
        '<p class="nc-hc-resumo">' + resumo + '</p>' +
        /* a faixa entre a 1ª e a última data: "17/04/2019 ▮▮▮▮▮▮ 05/10/2026" */
        (faixa.length > 1 ? '<div class="nc-hc-faixa-linha"><span class="nc-hc-faixa-d">' + esc(faixa[0].data) + '</span>' +
          '<div class="nc-hc-faixa" role="list" aria-label="Comparecimento, da consulta mais antiga para a mais nova">' + faixa.map(function (c) {
            return '<button type="button" role="listitem" class="nc-hc-marca" data-s="' + c.sit + '" data-ir="' + c.i + '" title="' + esc(c.data + ' · ' + SITUACOES[c.sit] + ' · ' + c.tipoTxt) + '" aria-label="' + esc(c.data + ', ' + SITUACOES[c.sit]) + '"></button>';
          }).join('') + '</div><span class="nc-hc-faixa-d">' + esc(faixa[faixa.length - 1].data) + '</span></div>' : '') +
        (prox ? '<p class="nc-hc-proxima">' + ic('calendario') + '<span>Próxima consulta: <b>' + esc(prox.data) + (prox.prevIni ? ' às ' + esc(prox.prevIni) : '') + '</b> · ' + esc(prox.tipoTxt) + (prox.profTxt ? ' · com ' + esc(prox.profTxt) : '') + '</span></p>' : '');
    }
    function rotuloCurto(s, n) {
      return { realizada: ['realizada', 'realizadas'], veio: ['veio sem atendimento', 'vieram sem atendimento'], faltou: ['falta', 'faltas'], agendada: ['agendada', 'agendadas'], sem: ['sem registro', 'sem registro'] }[s][n === 1 ? 0 : 1];
    }
    function contar(lista, campo) { var o = {}; lista.forEach(function (c) { o[c[campo]] = (o[c[campo]] || 0) + 1; }); return o; }

    /* — filtros + lista (ou a Tabela) — */
    function corpo() {
      var cp = app.querySelector('.nc-hc-corpo');
      if (regIR) regIR.hidden = !(MODO === 'tabela' && temPaciente());
      app.classList.toggle('is-tabela', MODO === 'tabela');
      if (!temPaciente()) { cp.innerHTML = '<div class="nc-hc-vazio"><p><b>Escolha o paciente acima</b> para ver as consultas dele.</p></div>'; app._datas.hidden = true; cp.appendChild(app._datas); return; }
      var tipos = contar(DADOS, 'tipo'), profs = contar(DADOS, 'prof'), sits = contar(DADOS, 'sit');
      var nomeTipo = {}, nomeProf = {};
      DADOS.forEach(function (c) { nomeTipo[c.tipo] = c.tipoTxt; nomeProf[c.prof] = c.profTxt || 'Sem profissional'; });
      var chips = function (grupo, mapa, rot, todos) {
        var ks = Object.keys(mapa);
        if (ks.length < 2) return '';
        return '<div class="nc-hc-grupo" role="group" aria-label="' + esc(todos) + '"><button type="button" data-f="' + grupo + '" data-v="" aria-pressed="' + (!F[grupo]) + '">Todas</button>' +
          ks.map(function (k) { return '<button type="button" data-f="' + grupo + '" data-v="' + esc(k) + '" aria-pressed="' + (F[grupo] === k) + '"' + (grupo === 'sit' ? ' data-s="' + k + '"' : '') + '>' + esc(rot(k)) + ' <span>' + mapa[k] + '</span></button>'; }).join('') + '</div>';
      };
      var ordSits = {}; ORDEM_SIT.forEach(function (s) { if (sits[s]) ordSits[s] = sits[s]; });
      cp.innerHTML =
        '<div class="nc-hc-barra">' +
          '<div class="nc-hc-linha">' +
            '<div class="nc-hc-grupo nc-hc-periodo" role="group" aria-label="Período">' + PERIODOS.map(function (p) { return '<button type="button" data-periodo="' + p[0] + '" aria-pressed="false">' + esc(p[1]) + '</button>'; }).join('') + '</div>' +
            '<label class="nc-hc-busca-q">' + ic('busca') + '<span class="nc-hc-oculto">Buscar</span><input type="search" placeholder="Buscar data, tipo ou profissional" value="' + esc(F.q) + '" autocomplete="off"></label>' +
            '<div class="nc-hc-modo" role="group" aria-label="Ver como"><button type="button" data-modo="lista" aria-pressed="' + (MODO === 'lista') + '">' + ic('lista') + 'Lista</button>' + (regIR ? '<button type="button" data-modo="tabela" aria-pressed="' + (MODO === 'tabela') + '">' + ic('tabela') + 'Tabela</button>' : '') + '</div>' +
          '</div>' +
          '<div class="nc-hc-datas-lugar"></div>' +
          '<div class="nc-hc-linha nc-hc-chips">' +
            chips('sit', ordSits, function (k) { return SITUACOES[k]; }, 'Situação') +
            chips('tipo', tipos, function (k) { return nomeTipo[k]; }, 'Tipo de consulta') +
            (Object.keys(profs).length > 1 ? '<label class="nc-hc-prof"><span class="nc-hc-oculto">Profissional</span><select><option value="">Todos os profissionais</option>' + Object.keys(profs).map(function (k) { return '<option value="' + esc(k) + '"' + (F.prof === k ? ' selected' : '') + '>' + esc(nomeProf[k]) + ' (' + profs[k] + ')</option>'; }).join('') + '</select></label>' : '') +
          '</div>' +
          '<p class="nc-hc-conta" aria-live="polite"></p>' +
        '</div>' +
        '<div class="nc-hc-lista"></div>';
      cp.querySelector('.nc-hc-datas-lugar').appendChild(app._datas);
      cp.querySelector('.nc-hc-barra').hidden = false;
      periodoPintar();
      lista();
    }

    /* ═══ [H5] PERÍODO ═════════════════════════════════════════════════════════════════════
       Os botões escrevem nos itens originais P26_DATA_INICIAL / P26_DATA_FINAL (a Tabela filtra
       pelos mesmos itens). "Escolher datas" mostra os dois campos originais.
       ════════════════════════════════════════════════════════════════════════════════════ */
    function menos(meses) { var d = hoje(); d.setMonth(d.getMonth() - meses); return ddmm(d); }
    function periodoAtual() {
      var a = valor('P26_DATA_INICIAL'), b = valor('P26_DATA_FINAL');
      if (app && app._escolher) return 'datas';
      if (!a && !b) return 'tudo';
      if (!b && a === menos(12)) return '12m';
      if (!b && a === menos(36)) return '3a';
      return 'datas';
    }
    function periodoPintar() {
      var at = periodoAtual();
      [].forEach.call(app.querySelectorAll('[data-periodo]'), function (b) { b.setAttribute('aria-pressed', b.getAttribute('data-periodo') === at ? 'true' : 'false'); });
      app._datas.hidden = at !== 'datas';
    }
    function periodo(p) {
      app._escolher = p === 'datas';
      var ini = p === '12m' ? menos(12) : p === '3a' ? menos(36) : p === 'datas' ? valor('P26_DATA_INICIAL') : '';
      var fim = p === 'datas' ? valor('P26_DATA_FINAL') : '';
      if (valor('P26_DATA_INICIAL') !== ini) apex.item('P26_DATA_INICIAL').setValue(ini);
      if (valor('P26_DATA_FINAL') !== fim) apex.item('P26_DATA_FINAL').setValue(fim);
      periodoPintar(); lista();
      if (p === 'datas') { var i = $id('P26_DATA_INICIAL'); if (i) i.focus(); }
    }

    /* ═══ [H6] FILTRAR E DESENHAR A LISTA ══════════════════════════════════════════════════ */
    function passa(c) {
      var a = data(valor('P26_DATA_INICIAL')), b = data(valor('P26_DATA_FINAL'));
      if (a && c.d && c.d < a) return false;
      if (b && c.d && c.d > b) return false;
      if (F.sit && c.sit !== F.sit) return false;
      if (F.tipo && c.tipo !== F.tipo) return false;
      if (F.prof && c.prof !== F.prof) return false;
      if (F.q && c.busca.indexOf(sem(F.q)) < 0) return false;
      return true;
    }
    function filtrando() { return !!(F.sit || F.tipo || F.prof || F.q || valor('P26_DATA_INICIAL') || valor('P26_DATA_FINAL')); }
    function lista() {
      var lu = app.querySelector('.nc-hc-lista'); if (!lu) return;
      lu.hidden = MODO === 'tabela';
      var vis = DADOS.filter(passa), conta = app.querySelector('.nc-hc-conta');
      conta.innerHTML = filtrando() ? 'Mostrando ' + vis.length + ' de ' + plural(DADOS.length, 'consulta', 'consultas') + ' · <button type="button" class="nc-hc-link" data-limpar>Limpar filtros</button>' : '';
      if (!DADOS.length) { lu.innerHTML = '<div class="nc-hc-vazio"><p><b>Nenhuma consulta na agenda deste paciente.</b></p><p>Confira a empresa e o tipo (funcionário ou candidato) em "Trocar paciente".</p></div>'; return; }
      if (!vis.length) { lu.innerHTML = '<div class="nc-hc-vazio"><p><b>Nenhuma consulta com estes filtros.</b></p><button type="button" class="nc-hc-bt" data-limpar>Limpar filtros</button></div>'; return; }
      var anos = {}, ordem = [];
      vis.forEach(function (c) { var y = c.d ? c.d.getFullYear() : 'Sem data'; if (!anos[y]) { anos[y] = []; ordem.push(y); } anos[y].push(c); });
      lu.innerHTML = ordem.map(function (y) {
        return '<section class="nc-hc-ano" aria-label="' + y + '"><h3><span>' + y + '</span><small>' + plural(anos[y].length, 'consulta', 'consultas') + '</small></h3><ol>' +
          anos[y].map(linha).join('') + '</ol></section>';
      }).join('');
    }
    function linha(c) {
      var horas = [];
      if (c.prevIni) horas.push('Marcada ' + c.prevIni + (c.prevFim ? '–' + c.prevFim : ''));
      if (c.chegada) horas.push('chegou ' + c.chegada);
      if (c.realIni) horas.push('atendido ' + c.realIni + (c.realFim ? '–' + c.realFim : '') + (c.duracao != null && c.duracao >= 0 ? ' (' + dur(c.duracao) + ')' : ''));
      if (c.espera != null && c.espera > 0) horas.push('esperou ' + dur(c.espera));
      return '<li class="nc-hc-item" id="nc-hc-i-' + c.i + '" data-s="' + c.sit + '" tabindex="-1">' +
        '<div class="nc-hc-dia"' + (c.d ? ' aria-label="' + esc(c.data) + '"' : '') + '>' + (c.d ? '<b>' + ('0' + c.d.getDate()).slice(-2) + '</b><span>' + MESES[c.d.getMonth()] + '</span><small>' + SEMANA[c.d.getDay()] + '</small>' : '<span>—</span>') + '</div>' +
        '<div class="nc-hc-meio">' +
          '<p class="nc-hc-l1"><span class="nc-hc-tipo" data-tom="' + (CONSULTAS[c.tipo] || '') + '">' + esc(c.tipoTxt) + '</span>' + (c.profTxt ? '<span class="nc-hc-prof-txt">' + ic('pessoa') + esc(c.profTxt) + '</span>' : '') + '</p>' +
          (horas.length ? '<p class="nc-hc-horas">' + ic('relogio') + esc(horas.join(' · ')) + '</p>' : '') +
        '</div>' +
        '<span class="nc-hc-sit" data-s="' + c.sit + '">' + ic(ICS[c.sit]) + esc(SITUACOES[c.sit]) + '</span>' +
      '</li>';
    }

    /* — os cliques e o teclado (um só ouvinte para a tela toda) — */
    function ligar() {
      app.addEventListener('click', function (ev) {
        var t = ev.target, b;
        if ((b = t.closest('[data-trocar]'))) {
          var p = app.querySelector('.nc-hc-trocar'); p.hidden = !p.hidden; b.setAttribute('aria-expanded', String(!p.hidden));
          if (!p.hidden) { var i = p.querySelector('#P26_COD_PACIENTE, input:not([type=hidden])'); if (i) i.focus(); }
          return;
        }
        if ((b = t.closest('[data-periodo]'))) return periodo(b.getAttribute('data-periodo'));
        if ((b = t.closest('[data-f]'))) { var g = b.getAttribute('data-f'), v = b.getAttribute('data-v'); F[g] = F[g] === v ? '' : v; [].forEach.call(app.querySelectorAll('[data-f="' + g + '"]'), function (x) { x.setAttribute('aria-pressed', String(x.getAttribute('data-v') === F[g])); }); return lista(); }
        if ((b = t.closest('[data-limpar]'))) { F = { sit: '', tipo: '', prof: '', q: '' }; app._escolher = false; periodo('tudo'); corpo(); return; }
        if ((b = t.closest('[data-modo]'))) {
          MODO = b.getAttribute('data-modo');
          try { localStorage.setItem('nc-hc-modo', MODO); } catch (x) { /* sem armazenamento */ }
          [].forEach.call(app.querySelectorAll('[data-modo]'), function (x) { x.setAttribute('aria-pressed', String(x === b)); });
          app.classList.toggle('is-tabela', MODO === 'tabela');
          if (regIR) { regIR.hidden = MODO !== 'tabela'; if (MODO === 'tabela') $(window).trigger('resize'); }
          lista(); return;
        }
        if ((b = t.closest('[data-ir]'))) {
          var alvo = $id('nc-hc-i-' + b.getAttribute('data-ir'));
          if (!alvo || alvo.closest('[hidden]') || MODO === 'tabela') { F = { sit: '', tipo: '', prof: '', q: '' }; app._escolher = false; if (MODO === 'tabela') { MODO = 'lista'; } periodo('tudo'); corpo(); alvo = $id('nc-hc-i-' + b.getAttribute('data-ir')); }
          if (alvo) { alvo.scrollIntoView({ block: 'center', behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' }); alvo.classList.remove('is-achada'); void alvo.offsetWidth; alvo.classList.add('is-achada'); alvo.focus({ preventScroll: true }); }
          return;
        }
        if ((b = t.closest('[data-recarregar]'))) return recarregar();
      });
      app.addEventListener('input', function (ev) { if (ev.target.matches('.nc-hc-busca-q input')) { F.q = ev.target.value.trim(); lista(); } });
      app.addEventListener('change', function (ev) { if (ev.target.matches('.nc-hc-prof select')) { F.prof = ev.target.value; lista(); } });
      document.addEventListener('keydown', function (ev) {
        var q = app.querySelector('.nc-hc-busca-q input');
        if (ev.key === '/' && q && !digitando(ev.target) && !ev.ctrlKey && !ev.metaKey) { ev.preventDefault(); q.focus(); q.select(); }
        if (ev.key === 'Escape' && ev.target === q && q.value) { ev.preventDefault(); ev.stopPropagation(); q.value = ''; F.q = ''; lista(); }
      }, true);
      /* trocou empresa, tipo ou paciente: lê de novo; trocou a data: só filtra */
      /* a cascata (empresa/tipo → paciente) dispara mais de um change: uma leitura só */
      $('#P26_COD_EMPRESA, #P26_TIPO_PACIENTE, #P26_COD_PACIENTE').on('change', function () {
        clearTimeout(LEITURA); LEITURA = setTimeout(function () { quandoLivre(recarregar); }, 150);
      });
      $('#P26_DATA_INICIAL, #P26_DATA_FINAL').on('change', function () { if (DADOS) { periodoPintar(); lista(); } });
    }
  }

  /* ═══ [H7] VINDO DA AGENDA ═══════════════════════════════════════════════════════════════
     CUIDADO  O botão "Histórico de consultas" do paciente, na Agenda (Natcorp_AgendaMedica.js),
              guarda { emp, empTxt, tipo, pac, pacTxt, t } em sessionStorage (CHAVE_AGENDA) e
              aperta o botão original CONSULTA_MATRICULA. Aqui: empresa e tipo primeiro, espera
              a cascata limpar o paciente, e só então o paciente (senão a cascata o apaga).
              Vale por 60 segundos e é apagado ao ser lido.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function vindoDaAgenda(depois) {
    var v = null;
    try { v = JSON.parse(sessionStorage.getItem(CHAVE_AGENDA) || 'null'); sessionStorage.removeItem(CHAVE_AGENDA); } catch (x) { v = null; }
    if (!v || !v.pac || Date.now() - (v.t || 0) > 60000) return depois();
    var mudou = false;
    if (v.emp && valor('P26_COD_EMPRESA') !== String(v.emp)) { apex.item('P26_COD_EMPRESA').setValue(String(v.emp), v.empTxt || String(v.emp)); mudou = true; }
    if (v.tipo && valor('P26_TIPO_PACIENTE') !== String(v.tipo)) { apex.item('P26_TIPO_PACIENTE').setValue(String(v.tipo)); mudou = true; }
    ['P26_DATA_INICIAL', 'P26_DATA_FINAL'].forEach(function (i) { if (valor(i)) apex.item(i).setValue(''); });
    quandoLivre(function () {
      if (mudou || valor('P26_COD_PACIENTE') !== String(v.pac)) apex.item('P26_COD_PACIENTE').setValue(String(v.pac), v.pacTxt || String(v.pac));
      quandoLivre(depois);
    });
  }

  /* ═══ [H8] O MAESTRO ═════════════════════════════════════════════════════════════════════ */
  var foi = false, vai = function () { if (foi) return; foi = true; setTimeout(function () { try { iniciar(); } catch (e) { if (window.console) console.warn('[Natcorp histórico de consultas]', e); } }, 0); };
  if (document.readyState === 'complete') vai();
  else { if (window.apex.gPageContext$) $(apex.gPageContext$).one('apexreadyend', vai); window.addEventListener('load', vai); }
})();
