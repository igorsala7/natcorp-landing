/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONFERÊNCIA DO PONTO  —  o painel de indicadores (JavaScript) — v2 (19/10)     ║
   ║  App 9503 · Página 204 (Abono Individual — a lista que leva à Tratativa de Abono, 203)    ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: PONTOPAINEL-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima da lista de colaboradores, um RESUMO do ponto para quem opera (DP, gestor) e para quem
   decide (RH, diretoria), escrito do jeito que se fala:
     PERÍODO        De / Até no próprio painel (padrão: o mês corrente) e atalhos: Este mês, Mês
                    passado, Período do ponto (o fechamento), Últimos 30 dias. Arrastar sobre o
                    gráfico "Dia a dia" escolhe um trecho.
     PARA CONFERIR  Batida faltando · Pedidos esperando · Sem nenhuma batida · Riscos à CLT ·
     (operação)     Ajustadas à mão.
     GESTÃO         Absenteísmo · Horas extras · Banco de horas · Faltas · Atrasos e saídas.
     (estratégia)   Tocar num número mostra QUEM são, na ordem do que pede ação, e cada pessoa tem
                    "Abrir o ponto" (vai direto para a Tratativa de Abono dela, 203).
     QUADROS        Dia a dia (com o que mostrar e a seleção de um trecho) · O que a apuração gerou
                    (por categoria) · Onde (por coluna e por indicador) · Banco de horas (por faixa) ·
                    Riscos à CLT · Mês a mês (períodos com 2 meses ou mais). Cada quadro tem "Ampliar".
     FILTRAR        "Filtrar este resumo" (as colunas da tabela, vários valores em cada uma) e tocar
                    numa barra de "Onde" deixam o resumo inteiro só com aquilo, na hora.
   Os números vêm do servidor (processo NC_PONTO_INDICADORES): as MESMAS pessoas do relatório e,
   de cada uma, as MESMAS tabelas da 203.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda o relatório nem os filtros da página. Não grava nada.
     • As categorias dos eventos (falta, atraso, hora extra…) são lidas pelo NOME do evento ([J1],
       CATS): se um evento da empresa tiver outro nome, ajustar ali.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 204 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_PontoPainel.js
     Página 204 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_PontoPainel.css
     Página 204 › Processing › Ajax Callback NC_PONTO_INDICADORES  (NC_PONTO_INDICADORES.plsql.sql)
   O COMBINADO com a página: o relatório tem Static ID "COLABORADORES" e os filtros são P204_*.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Textos e ferramentas ............ números, categorias, colunas, horas e datas PODE MEXER
     [J2] Os dados ........................ chamada ao servidor e o preparo            CUIDADO
     [J3] A moldura e o período ........... título, De/Até, atalhos, calculando
     [J4] Os números ...................... as duas réguas e a lista "quem são"        PODE MEXER
     [J5] Os quadros ...................... dia a dia, eventos, onde, banco, riscos, meses
     [J6] Ampliar ......................... o quadro em tela grande
     [J7] Filtrar e cruzar ................ as colunas, as contas, a lista de marcar
     [J8] Abrir o ponto e ver na tabela
     [J9] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncPonto) return;
  window.__ncPonto = true;

  var IR_ID = 'COLABORADORES';
  function marcarRelatorio() { var ir = document.getElementById(IR_ID); if (ir) ir.classList.add('nc-reg-sim'); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  /* ═══ [J1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_PONTO_INDICADORES';
  var ITENS = ['P204_CHK_COLABORADORES_DIRETOS', 'P204_SITUACAO', 'P204_EMPRESA', 'P204_FILIAL', 'P204_CCUSTO',
               'P204_UNIDADE_ADM', 'P204_ATIVIDADE', 'P204_CARGO', 'P204_MATRICULA'];
  var POR_VEZ = 30;                       /* pessoas que cada lista mostra de cada vez */
  var POR_VEZ_Q = 8;                      /* linhas de cada quadro, de cada vez */
  var GUARDA = 'nc-pp-fechado';           /* o painel aberto fica lembrado neste navegador ('0' = aberto) */
  var GUARDA_POR = 'nc-pp-por';
  var VALIDADE = 10 * 60 * 1000;         /* o resumo calculado vale 10 min nesta aba (mesmos filtros e datas) */
  var MAX_DIAS = 186;                     /* o servidor corta acima disso (6 meses) */
  var LIM_HE_DIA = 120;                   /* minutos de hora extra por dia útil (CLT art. 59: até 2 h) */
  var BANCO_ALTO = 40 * 60;               /* saldo do banco que pede atenção (40 h, para mais ou para menos) */
  var SEMANA = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb'];
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

  /* PODE MEXER — as CATEGORIAS dos eventos da folha, pelo NOME do evento (a 1ª que bater vale; a
     ordem importa: "FALTA ABONADA" é justificada, não falta). Eventos do banco são sempre "banco". */
  var CATS = [
    /* \bJUSTIFICAD: começo de palavra — "INJUSTIFICADAS" é falta, não justificada */
    { k: 'just',   re: /ATESTAD|ABONAD|ABONO|\bJUSTIFICAD|LICEN|DECLARA/i, nome: 'Ausência justificada' },
    { k: 'falta',  re: /FALTA/i,                                       nome: 'Falta' },
    { k: 'atraso', re: /ATRAS/i,                                       nome: 'Atraso' },
    { k: 'saida',  re: /SA[IÍ]DA|ANTECIPAD/i,                          nome: 'Saída antecipada' },
    { k: 'he',     re: /EXTRA|\bH\.?\s?E\.?\b/i,                       nome: 'Hora extra' },
    { k: 'not',    re: /NOTURN/i,                                      nome: 'Adicional noturno' },
    { k: 'dsr',    re: /DSR|REPOUSO/i,                                 nome: 'DSR' }
  ];
  var GRUPO_EV = [
    { k: 'todos', nome: 'Todos' },
    { k: 'aus',   nome: 'Ausências',     cats: ['falta', 'atraso', 'saida', 'just'] },
    { k: 'he',    nome: 'Horas extras',  cats: ['he', 'not'] },
    { k: 'banco', nome: 'Banco de horas', cats: ['banco'] },
    { k: 'outro', nome: 'Outros',        cats: ['dsr', 'outro'] }
  ];
  var TIPO_EV = { C: ['Crédito', 'credito', 'crédito no banco de horas'], D: ['Débito', 'debito', 'débito no banco de horas'], H: ['Folha', 'folha', 'vai para a folha de pagamento'] };

  /* as colunas da tabela que o resumo filtra e cruza ("i" = posição em pes, a do NC_PONTO_INDICADORES) */
  var DIMS = [
    { k: 'emp',  i: 0, col: 'NOME_EMPRESA', tit: 'Empresa',                  nome: 'Empresa',                  todos: 'Todas' },
    { k: 'fil',  i: 1, col: 'NOME_FILIAL',  tit: 'Filial',                   nome: 'Filial',                   todos: 'Todas' },
    { k: 'cc',   i: 2, col: 'NOME_CCUSTO',  tit: 'Centro de Custo (Célula)', nome: 'Centro de Custo (Célula)', todos: 'Todos', curto: 'Centro de custo' },
    { k: 'gest', i: 7, col: 'GESTOR',       tit: 'Gestor',                   nome: 'Gestor',                   todos: 'Todos' },
    { k: 'un',   i: 3, col: 'UNIDADE_ADM',  tit: 'Unidade Adm. (Cliente)',   nome: 'Unidade Adm. (Cliente)',   todos: 'Todas', curto: 'Unidade adm. (cliente)' },
    { k: 'at',   i: 4, col: 'ATIVIDADE',    tit: 'Atividade (Serviço)',      nome: 'Atividade (Serviço)',      todos: 'Todas', curto: 'Atividade (serviço)' },
    { k: 'car',  i: 5, col: 'CARGO',        tit: 'Cargo',                    nome: 'Cargo',                    todos: 'Todos' },
    { k: 'sind', i: 6, col: 'SINDICATO',    tit: 'Sindicato',                nome: 'Sindicato',                todos: 'Todos' },
    { k: 'vin',  i: 8, col: 'VINCULO',      tit: 'Vínculo',                  nome: 'Vínculo',                  todos: 'Todos' }
  ];
  var DIM = {}; DIMS.forEach(function (x) { DIM[x.k] = x; });
  var POR_PADRAO = 'cc';

  /* as DUAS réguas: a ordem é a ordem na tela */
  var OPER = [
    { k: 'falta',  cor: 'vermelho', ic: 'batida', diz: 'Batida faltando',    alerta: true },
    { k: 'pedido', cor: 'ambar',    ic: 'espera', diz: 'Pedidos esperando',  alerta: true },
    { k: 'sem',    cor: 'rosa',     ic: 'vazio',  diz: 'Sem nenhuma batida' },
    { k: 'risco',  cor: 'vermelho', ic: 'lei',    diz: 'Riscos à CLT',       alerta: true },
    { k: 'ajuste', cor: 'roxo',     ic: 'lapis',  diz: 'Ajustadas à mão' }
  ];
  var GEST = [
    { k: 'abs',    cor: 'roxo',     ic: 'pessoas', diz: 'Absenteísmo' },
    { k: 'he',     cor: 'ambar',    ic: 'relogio', diz: 'Horas extras' },
    { k: 'banco',  cor: 'verde',    ic: 'banco',   diz: 'Banco de horas' },
    { k: 'faltas', cor: 'vermelho', ic: 'falta',   diz: 'Faltas' },
    { k: 'atrasos', cor: 'rosa',    ic: 'atraso',  diz: 'Atrasos e saídas' }
  ];
  var NUM = {}; OPER.concat(GEST).forEach(function (x) { NUM[x.k] = x; });
  var REQ = [['ajuste', 'ajustes'], ['apuração', 'apurações'], ['hora extra', 'horas extras']];
  var RISCOS = [
    { b: 1, k: 'inter', nome: 'Descanso < 11 h', curto: 'interjornada', lei: 'Descanso menor que 11 h entre um dia e outro (CLT art. 66)' },
    { b: 2, k: 'longa', nome: 'Jornada > 10 h',  curto: 'jornada longa', lei: 'Mais de 10 h trabalhadas no dia: 8 h + 2 h extras (CLT art. 59)' },
    { b: 4, k: 'intv',  nome: 'Intervalo < 1 h', curto: 'intervalo', lei: 'Intervalo menor que 1 h em dia com mais de 6 h de trabalho (CLT art. 71)' }
  ];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    batida: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/><path d="M4.5 4.5l15 15"/>',
    espera: '<path d="M7 3.5h10M7 20.5h10M8 3.5c0 4 4 5.5 4 8.5s-4 4.5-4 8.5M16 3.5c0 4-4 5.5-4 8.5s4 4.5 4 8.5"/>',
    vazio: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5 1.5 0 2.8.5 3.8 1.5"/><path d="M15.5 15.5l5 5M20.5 15.5l-5 5"/>',
    lapis: '<path d="M4 20l1-4.5L15.5 5a2.1 2.1 0 0 1 3 3L8 18.5z"/><path d="M13.5 7l3 3"/>',
    banco: '<path d="M3.5 9.5 12 4.5l8.5 5"/><path d="M5.5 10v7M10 10v7M14 10v7M18.5 10v7M3.5 19.5h17"/>',
    lei: '<path d="M12 4v16M7 20h10M5 7h14"/><path d="M5 7l-2.5 6a2.5 2.5 0 0 0 5 0zM19 7l-2.5 6a2.5 2.5 0 0 0 5 0z"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    relogio: '<circle cx="12" cy="13" r="7.5"/><path d="M12 9v4l2.5 1.5M9.5 3h5"/>',
    falta: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4M9.5 13l5 4.5M14.5 13l-5 4.5"/>',
    atraso: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7v5h4"/><path d="M18.5 4.5l2 2"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>',
    tirar: '<path d="M7 7l10 10M17 7 7 17"/>',
    filtro: '<path d="M4 5.5h16l-6.2 7.3v5.4l-3.6 1.8v-7.2z"/>',
    marca: '<path d="M5 12.5l4.2 4.2L19 7"/>',
    ponto: '<rect x="4.5" y="4" width="15" height="16.5" rx="2.5"/><path d="M8.5 2.5v3M15.5 2.5v3M8 10.5h8M8 14.5h5"/>',
    ampliar: '<path d="M14 4h6v6M10 20H4v-6M20 4l-7 7M4 20l7-7"/>',
    calendario: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4"/>'
  };
  function ic(n) { return '<svg class="nc-af-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function num(n) { return Number(n || 0).toLocaleString('pt-BR'); }
  function plural(n, um, varios) { return num(n) + ' ' + (Number(n) === 1 ? um : varios); }
  function data(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function texto(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function iso(d) { return d.getFullYear() + '-' + ('0' + (d.getMonth() + 1)).slice(-2) + '-' + ('0' + d.getDate()).slice(-2); }
  function deIso(t) { var m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(t || ''); return m ? new Date(+m[1], +m[2] - 1, +m[3]) : null; }
  function mais(d, n) { var x = new Date(d.getTime()); x.setDate(x.getDate() + n); return x; }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  function curta(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2); }
  function partes(t) { var m = /^(\S+)\s+-\s+(.+)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  /* minutos → "12h30"; com sinal quando pedido. Acima de 1.000 h, "1,2 mil h" (o número inteiro vai na dica) */
  function horas(min, sinal) {
    var m = Math.round(Math.abs(min || 0)), h = Math.floor(m / 60), r = m % 60, t;
    if (h >= 1000) t = (h / 1000).toLocaleString('pt-BR', { maximumFractionDigits: h >= 10000 ? 0 : 1 }) + ' mil h';
    else t = !m ? '0h' : h.toLocaleString('pt-BR') + 'h' + (r ? ('0' + r).slice(-2) : '');
    return (min < 0 && m ? '−' : sinal && min > 0 ? '+' : '') + t;
  }
  function horasExato(min) { var m = Math.round(Math.abs(min || 0)); return (min < 0 ? '−' : '') + Math.floor(m / 60).toLocaleString('pt-BR') + 'h' + ('0' + m % 60).slice(-2); }
  function pct(a, b, casas) {
    if (!b) return '0%';
    var v = a / b * 100;
    if (v > 0 && v < (casas ? .1 : 1)) return '&lt;' + (casas ? '0,1' : '1') + '%';
    return v.toLocaleString('pt-BR', { maximumFractionDigits: casas || 0 }) + '%';
  }
  function listaDatas(ds) {
    var t = ds.slice(0, 4).map(curta), resto = ds.length - t.length;
    if (resto > 0) return t.join(', ') + ' e mais ' + resto;
    return t.length > 1 ? t.slice(0, -1).join(', ') + ' e ' + t[t.length - 1] : t[0] || '';
  }
  function categoria(t, tipo) {
    if (tipo === 'C' || tipo === 'D') return 'banco';
    for (var i = 0; i < CATS.length; i++) if (CATS[i].re.test(t || '')) return CATS[i].k;
    return 'outro';
  }

  /* ═══ [J2] OS DADOS ═════════════════════════════════════════════════════════════════════
     CUIDADO  Os filtros da página vão com a chamada (pageItems); as datas do painel em x01/x02.
     O resultado fica guardado na ABA (sessionStorage) por 10 min, por filtros + datas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function valor(i) { try { return apex.item(i).getValue() || ''; } catch (e) { return ''; } }
  function chaveCache() { return 'nc-pp-dados2:' + P.ini + '|' + P.fim + '|' + ITENS.map(function (i) { return document.getElementById(i) ? valor(i) : ''; }).join('|'); }
  function buscar(forcar) {
    var k = chaveCache(), c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && c && c.d && Date.now() - c.t < VALIDADE) { desenhar(c.d, c.t); return; }
    carregando();
    var itens = ITENS.filter(function (i) { return document.getElementById(i); }).map(function (i) { return '#' + i; }).join(',');
    var pedido = ++P.pedido;
    apex.server.process(PROCESSO, { pageItems: itens, x01: P.ini, x02: P.fim }, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        if (pedido !== P.pedido) return;                 /* outro período foi pedido depois: este perdeu */
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      .fail(function (x) { if (pedido !== P.pedido) return; pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* o PREPARO: cada pessoa ganha as contas dela (uma vez por dado; os filtros só escolhem quem entra) */
  function preparar(d) {
    var hoje = data(d.hoje) || new Date(), ini = data(d.ini), fim = data(d.fim), L = d.dias || (ini && fim ? dias(ini, fim) + 1 : 0);
    var dds = []; for (var j = 0; j < L; j++) dds.push(mais(ini, j));
    var per = (d.per || []).map(function (p) { return { ini: data(p[0]), fim: data(p[1]) }; });
    var evs = (d.evs || []).map(function (e, i) { return { i: i, t: e[0], tipo: e[1], cat: categoria(e[0], e[1]) }; });
    var meses = (d.meses || []).map(function (m) { return { k: m, d: new Date(+m.slice(0, 4), +m.slice(4, 6) - 1, 1) }; });
    /* dias úteis já passados (base do limite de hora extra) */
    var uteis = 0; dds.forEach(function (x) { if (x < hoje && x.getDay() > 0 && x.getDay() < 6) uteis++; });
    var ps = (d.pes || []).map(function (r, i) {
      var dm = (d.dm || [])[i] || '', da = (d.da || [])[i] || '', df = (d.df || [])[i] || '', pv = (d.pv || [])[i];
      var p = { i: i, k: r, nome: (d.nomes || [])[i] || '', url: r[11] ? (r[11].charAt(0) === '!' ? r[11].slice(1) : (d.u0 || '') + r[11]) : '',
                trab: r[10] === 1, ponto: per[r[9]] || null, batidas: 0, ajust: 0, diasCom: 0, impar: [], risco: { inter: [], longa: [], intv: [] }, nRisco: 0,
                tr: (d.tr || [])[i] || 0, pv: pv != null && pv >= 0 ? pv : null, ev: [], cat: {}, cred: 0, deb: 0, folha: 0,
                req: [[0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]], pend: [0, 0, 0], nPend: 0, nReq: 0, espera: 0 };
      for (var j = 0; j < dm.length && j < L; j++) {
        var n = +dm.charAt(j), f = +df.charAt(j) || 0, dia = dds[j];
        if (n) { p.batidas += n; p.diasCom++; }
        p.ajust += +da.charAt(j) || 0;
        if (dia < hoje) {
          if (n % 2 === 1) p.impar.push(dia);
          if (f) { RISCOS.forEach(function (R) { if (f & R.b) p.risco[R.k].push(dia); }); p.nRisco++; }
        }
      }
      p.sem = p.trab && ini <= hoje && p.batidas === 0;
      return p;
    });
    (d.ev || []).forEach(function (r) {
      var p = ps[r[0]], e = evs[r[1]]; if (!p || !e) return;
      p.ev.push([r[1], r[2], r[3]]);
      p.cat[e.cat] = (p.cat[e.cat] || 0) + r[3];
      if (e.tipo === 'C') p.cred += r[3]; else if (e.tipo === 'D') p.deb += r[3]; else p.folha += r[3];
    });
    (d.req || []).forEach(function (r) {
      var p = ps[r[0]]; if (!p || !p.req[r[1]]) return;
      p.req[r[1]][r[2]] = (p.req[r[1]][r[2]] || 0) + r[3]; p.nReq += r[3];
      if (r[2] === 1) { p.pend[r[1]] += r[3]; p.nPend += r[3]; p.espera = Math.max(p.espera, r[4] || 0); }
    });
    ps.forEach(function (p) {
      var c = p.cat;
      p.saldo = p.cred - p.deb;
      p.falta = c.falta || 0; p.atraso = (c.atraso || 0) + (c.saida || 0); p.just = c.just || 0;
      p.aus = p.falta + p.atraso + p.just;
      p.he = (c.he || 0);
      p.limHE = uteis * LIM_HE_DIA;
    });
    var conta = {}; ps.forEach(function (p) { if (p.ponto) { var c = p.k[9]; conta[c] = (conta[c] || 0) + 1; } });
    var ponto = Object.keys(conta).sort(function (a, b) { return conta[b] - conta[a]; }).map(function (c) { return per[c]; });
    return { hoje: hoje, ini: ini, fim: fim, L: L, dds: dds, per: per, evs: evs, meses: meses, ps: ps, ponto: ponto, uteis: uteis,
             prev: d.prev || { ok: 0, falhas: 0, parcial: false } };
  }

  /* ═══ [J3] A MOLDURA E O PERÍODO ════════════════════════════════════════════════════════ */
  var P = null;
  function montar() {
    if (P) return true;
    var ir = document.getElementById(IR_ID);
    if (!ir) return false;
    var caixa = el('section', 'nc-af nc-pp');
    caixa.setAttribute('aria-labelledby', 'nc-pp-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-pp-titulo">Conferência do ponto</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a lista</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-esconde aria-controls="nc-pp-corpo"></button></header>' +
      '<div class="nc-pp-datas" role="group" aria-label="Período do resumo"></div>' +
      '<div class="nc-pp-corpo" id="nc-pp-corpo"></div>';
    ir.parentNode.insertBefore(caixa, ir);
    var hoje = new Date(); hoje.setHours(0, 0, 0, 0);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-pp-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-af-esconde]'),
          datas: caixa.querySelector('.nc-pp-datas'), hoje: hoje, filtro: null, filtroEv: null, f: {}, por: POR_PADRAO, met: 'conferir', metDia: 'falta',
          grupoEv: 'todos', faixa: 'todos', pedido: 0, zoom: null };
    var m = mesDe(hoje, 0); P.ini = texto(m[0]); P.fim = texto(m[1]);
    try { var por = localStorage.getItem(GUARDA_POR); if (DIM[por]) P.por = por; } catch (e) { /* ok */ }
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '0'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    desenharDatas();
    caixa.addEventListener('click', clique);
    caixa.addEventListener('change', mudou);
    caixa.addEventListener('keydown', teclas);
    ligarArrasto();
    return true;
  }
  function mesDe(d, desloca) { var a = new Date(d.getFullYear(), d.getMonth() + desloca, 1); return [a, new Date(a.getFullYear(), a.getMonth() + 1, 0)]; }
  /* a BARRA DO PERÍODO: atalhos e De/Até (fica fora do corpo: não some ao recalcular) */
  function atalhos() {
    var h = P.hoje, ponto = P.X && P.X.ponto[0];
    return [
      { k: 'mes', t: 'Este mês', d: mesDe(h, 0) },
      { k: 'mesant', t: 'Mês passado', d: mesDe(h, -1) },
      { k: 'ponto', t: 'Período do ponto', d: ponto ? [ponto.ini, ponto.fim] : null, dica: ponto ? curta(ponto.ini) + ' a ' + curta(ponto.fim) : 'aparece depois do 1º cálculo' },
      { k: 'trinta', t: 'Últimos 30 dias', d: [mais(h, -29), h] }
    ];
  }
  function desenharDatas() {
    var ini = data(P.ini), fim = data(P.fim);
    P.datas.innerHTML = '<span class="nc-pp-datas-rot">' + ic('calendario') + 'Período</span>' +
      '<div class="nc-pp-atalhos" role="group" aria-label="Atalhos de período">' + atalhos().map(function (a) {
        var on = a.d && texto(a.d[0]) === P.ini && texto(a.d[1]) === P.fim;
        return '<button type="button" class="nc-pp-atalho' + (on ? ' is-on' : '') + '" data-pp-atalho="' + a.k + '" aria-pressed="' + !!on + '"' + (a.d ? '' : ' disabled') +
          (a.dica ? ' title="' + esc(a.dica) + '"' : '') + '>' + a.t + '</button>';
      }).join('') + '</div>' +
      '<div class="nc-pp-de-ate"><label><span>De</span><input type="date" data-pp-ini value="' + (ini ? iso(ini) : '') + '"></label>' +
      '<label><span>Até</span><input type="date" data-pp-fim value="' + (fim ? iso(fim) : '') + '"></label>' +
      '<button type="button" class="nc-af-bt nc-af-bt--cheio" data-pp-aplica>Ver</button></div>' +
      '<p class="nc-pp-datas-msg" aria-live="polite"></p>';
  }
  function usarPeriodo(a, b) {
    if (!a || !b) return msgDatas('Escolha as duas datas.');
    if (b < a) { var t = a; a = b; b = t; }
    var corte = dias(a, b) + 1 > MAX_DIAS;
    if (corte) b = mais(a, MAX_DIAS - 1);
    P.ini = texto(a); P.fim = texto(b);
    desenharDatas();
    if (corte) msgDatas('O resumo vai até 6 meses de cada vez: ficou de ' + curta(a) + ' a ' + texto(b) + '.');
    buscar();
  }
  function msgDatas(t) { var m = P.datas.querySelector('.nc-pp-datas-msg'); if (m) m.textContent = t; }
  function abrirFechar(aberto) {
    fecharLista(false);
    P.caixa.classList.toggle('is-fechado', !aberto);
    P.botao.setAttribute('aria-expanded', String(aberto));
    P.botao.innerHTML = ic(aberto ? 'fechar' : 'abrir') + '<span>' + (aberto ? 'Mostrar menos' : 'Ver análise completa') + '</span>';
    try { if (aberto) localStorage.setItem(GUARDA, '0'); else localStorage.removeItem(GUARDA); } catch (e) { /* ok */ }
    if (aberto) setTimeout(ajustarDias, 0);
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-af-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-pp-atalho')) { var a = atalhos().filter(function (x) { return x.k === b.getAttribute('data-pp-atalho'); })[0]; if (a && a.d) usarPeriodo(a.d[0], a.d[1]); return; }
    if (b.hasAttribute('data-pp-aplica')) { usarPeriodo(deIso(P.datas.querySelector('[data-pp-ini]').value), deIso(P.datas.querySelector('[data-pp-fim]').value)); return; }
    if (b.hasAttribute('data-pp-trecho')) { var s = P.sel; P.sel = null; if (s) usarPeriodo(s.a, s.b); return; }
    if (b.hasAttribute('data-pp-trecho-tira')) { P.sel = null; desenharQuadros(); return; }
    if (b.hasAttribute('data-af-num')) { var k = b.getAttribute('data-af-num'); P.filtro = P.filtro === k ? null : k; desenharNums(); return; }
    if (b.hasAttribute('data-af-ev')) { var v = +b.getAttribute('data-af-ev'); P.filtroEv = P.filtroEv === v ? null : v; desenharQuadros({ attr: 'data-af-ev', v: String(v) }); return; }
    if (b.hasAttribute('data-pp-seg')) { P[b.getAttribute('data-pp-seg')] = b.getAttribute('data-pp-v'); if (b.getAttribute('data-pp-seg') === 'grupoEv') P.filtroEv = null; desenharQuadros({ attr: 'data-pp-v', v: b.getAttribute('data-pp-v') }); return; }
    if (b.hasAttribute('data-pp-zoom')) { abrirZoom(b.getAttribute('data-pp-zoom'), b); return; }
    if (b.hasAttribute('data-pp-zoom-fecha')) { fecharZoom(); return; }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-af-filtra')) { alternar(b.getAttribute('data-af-filtra'), b.getAttribute('data-af-valor')); return; }
    if (b.hasAttribute('data-af-tira')) { tirarFiltro(b.getAttribute('data-af-tira')); return; }
    if (b.hasAttribute('data-af-limpa')) { limparFiltros(); return; }
    if (b.hasAttribute('data-af-abre')) { var ab = b.getAttribute('data-af-abre'); if (P.pop && P.pop.k === ab) fecharLista(true); else abrirLista(ab); return; }
    if (b.hasAttribute('data-af-pronto')) { fecharLista(true); return; }
    if (b.hasAttribute('data-af-pop-limpa')) { delete P.f[P.pop.k]; redesenhar({ pop: true }); marcarLista(); return; }
    if (b.hasAttribute('data-af-ponto')) { abrirPonto(+b.getAttribute('data-af-ponto')); return; }
    if (b.hasAttribute('data-af-tabela')) { naTabela(b.getAttribute('data-af-tabela'), b.getAttribute('data-af-col')); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-af-tenta') || b.hasAttribute('data-af-atualiza')) buscar(true);
  }
  function teclas(e) {
    if (e.key === 'Enter' && e.target.matches('[data-pp-ini], [data-pp-fim]')) { e.preventDefault(); P.datas.querySelector('[data-pp-aplica]').click(); }
    if (e.key === 'Escape' && P.zoom && !P.pop) { e.preventDefault(); fecharZoom(); }
  }
  function calculando(passos) {
    var t0 = Date.now(), passo = -1;
    P.caixa.classList.add('is-calculando');
    P.caixa.setAttribute('aria-busy', 'true');
    function tique() {
      var s = Math.floor((Date.now() - t0) / 1000), i = Math.min(passos.length - 1, Math.floor(s / 4));
      if (i !== passo) { passo = i; P.quando.innerHTML = '<span class="nc-af-pulso" aria-hidden="true"></span>' + passos[i] + '<span class="nc-af-seg" aria-hidden="true" hidden></span>'; }
      var seg = P.quando.querySelector('.nc-af-seg'); if (seg && s >= 3) { seg.hidden = false; seg.textContent = s + ' s'; }
    }
    tique();
    return setInterval(tique, 1000);
  }
  function pararCalculo() { clearInterval(P.lento); P.caixa.classList.remove('is-calculando'); P.caixa.removeAttribute('aria-busy'); }
  function chegou() { P.caixa.classList.add('is-novo'); clearTimeout(P.novo); P.novo = setTimeout(function () { P.caixa.classList.remove('is-novo'); }, 1400); }
  function esqueleto(l) {
    return '<div class="nc-af-regua">' + l.map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span><span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('') + '</div>';
  }
  function carregando() {
    fecharZoom(true);
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">Para conferir antes de fechar</p>' + esqueleto(OPER) + '</div>' +
      '<div class="nc-af-secao nc-pp-gestao"><p class="nc-af-rot">Indicadores de gestão</p>' + esqueleto(GEST) + '</div>' +
      '<div class="nc-af-secao nc-af-periodo"><i class="nc-af-esq" style="width:60%;height:16px"></i><div class="nc-af-quadros nc-af-quadros--3" style="margin-top:14px">' +
      '<div class="nc-af-q nc-pp-q--largo" style="height:300px"></div><div class="nc-af-q" style="height:300px"></div></div></div>';
    P.caixa.querySelector('[data-af-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(['Buscando as batidas de ' + P.ini.slice(0, 5) + ' a ' + P.fim.slice(0, 5) + '…', 'Somando os eventos da apuração…', 'Conferindo descansos e intervalos…', 'Ainda calculando: com muitos colaboradores leva mais tempo']);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_PONTO|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia PONTOPAINEL-MANUTENCAO.md).'
             : 'A lista abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }
  /* o cabeçalho: o período, quantas pessoas, o fechamento do ponto, a hora do cálculo */
  function cabecalho() {
    var X = P.X, A = P.A, n = Object.keys(A.fi).length, t = 'De <b>' + curta(X.ini) + ' a ' + texto(X.fim) + '</b> · ' + plural(A.ps.length, 'colaborador', 'colaboradores');
    if (X.ponto.length === 1) {
      var falta = dias(X.hoje, X.ponto[0].fim);
      t += ' · fechamento do ponto ' + (falta > 1 ? 'em ' + falta + ' dias' : falta === 1 ? 'amanhã' : falta === 0 ? '<b>hoje</b>' : 'foi em ' + curta(X.ponto[0].fim));
    }
    P.quando.innerHTML = t + (n ? ' · <b>' + plural(n, 'filtro', 'filtros') + ' deste resumo</b>' : '') + (P.hm ? ' · calculado às ' + P.hm : '');
  }

  /* ═══ [J4] OS NÚMEROS ═══════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    P.dados = d; P.X = preparar(d); P.filtro = null; P.filtroEv = null; P.sel = null;
    P.hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.caixa.querySelector('[data-af-atualiza]').hidden = false;
    desenharDatas();
    if (d.cortouDias) msgDatas('O resumo vai até 6 meses de cada vez: ficou até ' + d.fim + '.');
    P.corpo.innerHTML =
      '<div class="nc-af-filtros" role="group" aria-label="Filtrar este resumo" hidden></div>' +
      '<div class="nc-af-secao"><p class="nc-af-rot">Para conferir antes de fechar</p><div class="nc-af-regua nc-pp-regua-oper" role="group" aria-label="O que conferir no ponto"></div></div>' +
      '<div class="nc-af-secao nc-pp-gestao"><p class="nc-af-rot">Indicadores de gestão</p><div class="nc-af-regua nc-pp-regua-gest" role="group" aria-label="Indicadores de gestão do ponto"></div>' +
      '<p class="nc-pp-base" hidden></p></div>' +
      '<div class="nc-af-quem" id="nc-af-quem" hidden aria-live="polite"></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>' +
      (d.cortou ? '<p class="nc-af-nota">O resumo mostra os primeiros ' + num((d.pes || []).length) + ' de ' + num(d.total) + ' colaboradores. Use os filtros da página para ver menos de cada vez.</p>' : '');
    redesenhar();
  }
  function redesenhar(foco) {
    if (P.pop && !(foco && foco.pop)) fecharLista(false);
    P.A = agregar();
    cabecalho();
    desenharFiltros();
    desenharNums();
    desenharPeriodo();
    if (foco) refocar(foco);
  }
  function regua(l, box) {
    var a = P.A.nums;
    box.innerHTML = l.map(function (h) {
      var x = a[h.k], on = P.filtro === h.k, vazio = !x.n;
      return '<button type="button" class="nc-af-num nc-af-num--' + h.cor + (vazio ? ' is-zero' : '') + ((h.alerta && x.n) || x.alerta ? ' is-alerta' : '') + '" data-af-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-af-quem"' + (vazio ? ' disabled' : '') + (x.dicaLonga ? ' title="' + esc(x.dicaLonga) + '"' : '') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor' + (x.texto ? ' is-texto' : '') + '">' + x.v + '<small>' + x.u + '</small></span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + x.dica + '</span></button>';
    }).join('');
  }
  function desenharNums() {
    regua(OPER, P.caixa.querySelector('.nc-pp-regua-oper'));
    regua(GEST, P.caixa.querySelector('.nc-pp-regua-gest'));
    var base = P.caixa.querySelector('.nc-pp-base'), b = P.A.base;
    base.hidden = !b.nota; base.innerHTML = b.nota || '';
    desenharQuem(P.caixa.querySelector('#nc-af-quem'), P.filtro ? daLista(P.filtro) : null);
  }
  /* quem entra em cada número, em que ordem, e o que a linha diz */
  function daLista(k) {
    var ps = P.A.ps.slice(), L = { tit: NUM[k].diz, ordem: '', xs: [] }, X = P.X;
    function ord(f, g) { return ps.filter(f).sort(g); }
    if (k === 'falta') {
      L.ordem = 'quem tem mais dias primeiro';
      L.xs = ord(function (p) { return p.impar.length; }, function (x, y) { return y.impar.length - x.impar.length; })
        .map(function (p) { return { p: p, diz: plural(p.impar.length, 'dia', 'dias') + ': ' + listaDatas(p.impar), cor: 'vermelho' }; });
    } else if (k === 'pedido') {
      L.ordem = 'quem espera há mais tempo primeiro';
      L.xs = ord(function (p) { return p.nPend; }, function (x, y) { return y.espera - x.espera || y.nPend - x.nPend; })
        .map(function (p) {
          var t = p.pend.map(function (q, i) { return q ? plural(q, REQ[i][0], REQ[i][1]) : ''; }).filter(Boolean).join(' · ');
          return { p: p, diz: t + (p.espera ? ' · esperando há ' + plural(p.espera, 'dia', 'dias') : ' · pedido de hoje'), cor: p.espera > 3 ? 'vermelho' : 'ambar' };
        });
    } else if (k === 'sem') {
      L.ordem = 'em ordem de nome';
      L.xs = ord(function (p) { return p.sem; }, function (x, y) { return partes(x.nome)[1].localeCompare(partes(y.nome)[1], 'pt-BR'); })
        .map(function (p) { return { p: p, diz: 'Nenhuma batida desde ' + curta(X.ini), cor: 'rosa' }; });
    } else if (k === 'risco') {
      L.ordem = 'quem tem mais dias com risco primeiro';
      L.xs = ord(function (p) { return p.nRisco; }, function (x, y) { return y.nRisco - x.nRisco; })
        .map(function (p) { return { p: p, diz: RISCOS.filter(function (R) { return p.risco[R.k].length; }).map(function (R) { return plural(p.risco[R.k].length, 'dia', 'dias') + ' de ' + R.curto; }).join(' · '), cor: 'vermelho' }; });
    } else if (k === 'ajuste') {
      L.ordem = 'quem teve mais batidas ajustadas primeiro';
      L.xs = ord(function (p) { return p.ajust; }, function (x, y) { return y.ajust - x.ajust; })
        .map(function (p) { return { p: p, diz: plural(p.ajust, 'batida ajustada', 'batidas ajustadas') + ' de ' + num(p.batidas) + ' (' + pct(p.ajust, p.batidas) + ')' }; });
    } else if (k === 'abs') {
      L.ordem = 'quem ficou mais horas fora primeiro';
      L.xs = ord(function (p) { return p.aus; }, function (x, y) { return y.aus - x.aus; })
        .map(function (p) {
          var t = [p.falta ? 'faltas ' + horas(p.falta) : '', p.atraso ? 'atrasos e saídas ' + horas(p.atraso) : '', p.just ? 'justificadas ' + horas(p.just) : ''].filter(Boolean).join(' · ');
          return { p: p, diz: '<b>' + horas(p.aus) + '</b> fora' + (p.pv ? ' (' + pct(p.aus, p.pv, 1) + ' das horas previstas)' : '') + ' · ' + t, html: true, cor: 'vermelho' };
        });
    } else if (k === 'he') {
      L.ordem = 'quem fez mais horas extras primeiro';
      L.xs = ord(function (p) { return p.he; }, function (x, y) { return y.he - x.he; })
        .map(function (p) { var acima = p.limHE && p.he > p.limHE; return { p: p, diz: '<b>' + horas(p.he) + '</b>' + (acima ? ' · acima do limite de ' + horas(p.limHE) + ' (2 h por dia útil)' : ''), html: true, cor: acima ? 'vermelho' : 'ambar' }; });
    } else if (k === 'banco') {
      L.ordem = 'quem deve mais horas primeiro';
      L.xs = ord(function (p) { return p.cred || p.deb; }, function (x, y) { return x.saldo - y.saldo; })
        .map(function (p) { return { p: p, diz: '<b>' + horas(p.saldo, true) + '</b> no período · créditos ' + horas(p.cred) + ' · débitos ' + horas(p.deb), cor: p.saldo < 0 ? 'vermelho' : 'verde', html: true }; });
    } else if (k === 'faltas') {
      L.ordem = 'quem faltou mais horas primeiro';
      L.xs = ord(function (p) { return p.falta; }, function (x, y) { return y.falta - x.falta; })
        .map(function (p) { return { p: p, diz: horas(p.falta) + ' de falta no período', cor: 'vermelho' }; });
    } else if (k === 'atrasos') {
      L.ordem = 'quem tem mais horas de atraso e saída antecipada primeiro';
      L.xs = ord(function (p) { return p.atraso; }, function (x, y) { return y.atraso - x.atraso; })
        .map(function (p) { return { p: p, diz: horas(p.atraso) + ' de atraso e saída antecipada', cor: 'rosa' }; });
    }
    return L;
  }
  function desenharQuem(box, L, grande) {
    if (!box) return;
    if (!L) { box.hidden = true; box.innerHTML = ''; return; }
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + esc(L.tit) + ': ' + plural(L.xs.length, 'pessoa', 'pessoas') + '</h3><p>' + L.ordem +
      ' · toque em <b>Abrir o ponto</b> para tratar na Tratativa de Abono</p>' +
      (L.xs.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome, cargo ou setor" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      (L.xs.length ? rolo('ul', 'nc-af-lista', L.xs.map(function (x) {
        var p = x.p, dims = P.dados.dims || {}, cargo = partes((dims.car || [])[p.k[5]])[1], setor = partes((dims.cc || [])[p.k[2]])[1];
        return '<li data-af-texto="' + esc(semAcento([p.nome, cargo, setor].join(' '))) + '"><div class="nc-af-p nc-pp-linha">' +
          '<span class="nc-af-p-quem"><b>' + esc(p.nome) + '</b><span>' + esc(cargo) + (setor ? ' · ' + esc(setor) : '') + '</span></span>' +
          '<span class="nc-pp-p-diz' + (x.cor ? ' nc-pp-p-diz--' + x.cor : '') + '">' + (x.html ? x.diz : esc(x.diz)) + '</span>' +
          (p.url ? '<button type="button" class="nc-pp-abre" data-af-ponto="' + p.i + '" title="Abrir o ponto de ' + esc(partes(p.nome)[1]) + ' na Tratativa de Abono">' + ic('ponto') + '<span>Abrir o ponto</span></button>' : '') +
          '</div></li>';
      }), grande ? 400 : POR_VEZ, 'pessoas') : '<p class="nc-af-vazio-q">Ninguém com estes filtros.</p>');
    ligarRolos(box);
    var pr = box.querySelector('[data-af-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value, L, grande); });
  }
  function procurar(box, q, L, grande) {
    var r = box.querySelector('.nc-af-rolo'); if (!r) return;
    var lis = r.querySelectorAll('li'), t = semAcento(q.trim()), n = 0;
    if (!t) { desenharQuem(box, L, grande); var p2 = box.querySelector('[data-af-procura]'); if (p2) p2.focus(); return; }
    [].forEach.call(lis, function (li) { var ok = li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
    var bt = r.nextElementSibling; if (bt && bt.hasAttribute('data-af-revela')) bt.hidden = true;
    var nada = r.querySelector('.nc-af-nada'); if (nada) nada.remove();
    if (!n) r.insertAdjacentHTML('beforeend', '<p class="nc-af-nada">Ninguém nesta lista com “' + esc(q.trim()) + '”.</p>');
  }

  /* listas que vão aparecendo: a caixa rola por dentro, revela as próximas N perto do fim */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-af-unid="' + unid + '"><' + tag + ' class="' + cls + '">' +
      itens.map(function (h, i) { return i < passo ? h : h.replace(/^<li/, '<li hidden'); }).join('') +
      '</' + tag + '><span class="nc-af-sentinela" aria-hidden="true"></span></div>' +
      (itens.length > passo ? '<button type="button" class="nc-af-mais" data-af-revela="' + passo + '"></button>' : '');
  }
  function escondidos(r) { return r.querySelectorAll('li[hidden]'); }
  function revelar(r, passo, foco) {
    var es = [].slice.call(escondidos(r), 0, passo);
    es.forEach(function (li) { li.hidden = false; });
    if (foco && es[0]) { var b = es[0].querySelector('button'); (b || es[0]).focus({ preventScroll: true }); es[0].scrollIntoView({ block: 'nearest', behavior: 'smooth' }); }
    contar(r);
  }
  function contar(r) {
    var bt = r.nextElementSibling; if (!bt || !bt.hasAttribute('data-af-revela')) return;
    var falta = escondidos(r).length, passo = +bt.getAttribute('data-af-revela'), u = r.getAttribute('data-af-unid');
    bt.hidden = !falta;
    bt.textContent = 'Mostrar mais ' + Math.min(passo, falta) + ' · ' + (falta === 1 ? 'falta 1' : 'faltam ' + num(falta)) + ' ' + (u === 'pessoas' ? (falta === 1 ? 'pessoa' : 'pessoas') : (falta === 1 ? 'linha' : 'linhas'));
  }
  function ligarRolos(raiz) {
    [].forEach.call(raiz.querySelectorAll('.nc-af-rolo'), function (r) {
      contar(r);
      var bt = r.nextElementSibling, passo = bt && bt.hasAttribute('data-af-revela') ? +bt.getAttribute('data-af-revela') : 0;
      if (!passo || !window.IntersectionObserver) return;
      var io = new IntersectionObserver(function (es) { if (es[0].isIntersecting && escondidos(r).length) revelar(r, passo); }, { root: r, rootMargin: '0px 0px 60px 0px' });
      io.observe(r.querySelector('.nc-af-sentinela'));
    });
  }

  /* ═══ [J5] OS QUADROS ═══════════════════════════════════════════════════════════════════ */
  function desenharPeriodo() {
    var A = P.A, box = P.caixa.querySelector('.nc-af-periodo'); if (!box) return;
    var t = A.tot, frase;
    if (!A.ps.length) frase = '<p class="nc-af-frase">Ninguém' + (A.filtrado ? ' com os filtros deste resumo' : ' nesta lista') + '.</p>';
    else if (!t.batidas && !t.evMin) frase = '<p class="nc-af-frase">Nenhuma batida nem evento de apuração neste período.</p>';
    else {
      frase = '<p class="nc-af-frase"><b>' + plural(t.comBatida, 'pessoa', 'pessoas') + '</b> ' + (t.comBatida === 1 ? 'bateu' : 'bateram') + ' o ponto em <b>' +
        plural(t.diasCom, 'dia', 'dias') + '</b>, somando <b>' + plural(t.batidas, 'batida', 'batidas') + '</b>' +
        (t.tr ? ' e <b>' + horas(t.tr) + '</b> trabalhadas' : '') + (t.batidas ? '; <b>' + pct(t.ajust, t.batidas) + '</b> das batidas ' + (t.ajust === 1 ? 'foi ajustada' : 'foram ajustadas') + ' à mão' : '') + '.' +
        (t.evMin ? '<span class="nc-af-taxa">A apuração somou <b>' + horas(t.aus) + '</b> de ausências, <b>' + horas(t.he) + '</b> de horas extras e, no banco de horas, <b>' +
          horas(t.cred) + '</b> de crédito e <b>' + horas(t.deb) + '</b> de débito (saldo de <b>' + horas(t.cred - t.deb, true) + '</b>).</span>' : '') + '</p>';
    }
    box.innerHTML = '<p class="nc-af-rot">No período · ' + curta(P.X.ini) + ' a ' + texto(P.X.fim) + '</p>' + frase +
      (A.ps.length ? '<div class="nc-af-quadros nc-af-quadros--3 nc-pp-quadros"></div><div class="nc-af-quem nc-pp-quem--ev" id="nc-pp-quem-ev" hidden aria-live="polite"></div>' : '');
    desenharQuadros();
  }
  var QUADROS = ['dias', 'eventos', 'onde', 'banco', 'riscos', 'meses'];
  function desenharQuadros(foco) {
    var box = P.caixa.querySelector('.nc-pp-quadros');
    if (box) {
      box.innerHTML = QUADROS.map(function (q) { return quadro(q, false); }).join('');
      ligarRolos(box);
      ajustarDias();
      desenharQuemEv(P.caixa.querySelector('.nc-af-periodo .nc-pp-quem--ev'), false);
    }
    if (P.zoom) desenharZoom();
    if (foco) refocar(foco);
  }
  /* cada quadro: título, controles, "Ampliar" e o conteúdo. "grande" = dentro do Ampliar */
  function quadro(q, grande) {
    var Q;
    if (q === 'dias') Q = { tit: 'Dia a dia', cls: 'nc-pp-q--largo nc-pp-q--dias', extra: seg('metDia', [['falta', 'Batida faltando'], ['risco', 'Riscos à CLT'], ['bateu', 'Bateram o ponto']]),
                            dica: 'Arraste sobre os dias para escolher um trecho · passe o mouse ou toque nas colunas', corpo: diaADia(grande) };
    else if (q === 'eventos') Q = { tit: 'O que a apuração gerou', extra: seg('grupoEv', GRUPO_EV.map(function (g) { return [g.k, g.nome]; })),
                                    dica: 'Crédito e débito vão para o banco de horas; folha vai para o pagamento · toque para ver quem tem', corpo: eventos(grande) };
    else if (q === 'onde') Q = { tit: 'Onde', extra: verPor(), dica: ondeDica(), corpo: ondes(grande) };
    else if (q === 'banco') Q = { tit: 'Banco de horas', extra: seg('faixa', [['todos', 'Todos'], ['deve10', 'Devendo +10h'], ['deve', 'Devendo até 10h'], ['tem', 'Até 10h a mais'], ['tem10', '+10h a mais']]),
                                  dica: 'Saldo do período (créditos − débitos) · quem deve mais primeiro', corpo: banco(grande) };
    else if (q === 'riscos') Q = { tit: 'Riscos à CLT', dica: 'Dias já passados, pelas batidas · toque no ícone para abrir o ponto da pessoa', corpo: riscos(grande) };
    else if (q === 'meses') { if (P.X.meses.length < 2) return ''; Q = { tit: 'Mês a mês', cls: 'nc-pp-q--todo', dica: 'Horas de ausência e de horas extras em cada mês', corpo: mesAMes() }; }
    return '<section class="nc-af-q nc-pp-q' + (Q.cls ? ' ' + Q.cls : '') + (grande ? ' is-grande' : '') + '" data-pp-q="' + q + '">' +
      '<div class="nc-pp-q-cab"><h3' + (grande ? ' id="nc-pp-zoom-tit"' : '') + '>' + Q.tit + '</h3>' +
      (grande ? '' : '<button type="button" class="nc-pp-ampliar" data-pp-zoom="' + q + '" title="Ampliar este quadro" aria-label="Ampliar o quadro ' + Q.tit + '">' + ic('ampliar') + '<span>Ampliar</span></button>') + '</div>' +
      (Q.extra || '') + '<p>' + Q.dica + '</p>' + Q.corpo + '</section>';
  }
  /* controle segmentado (o que mostrar): botões com aria-pressed */
  function seg(chave, ops) {
    return '<div class="nc-pp-seg" role="group">' + ops.map(function (o) {
      var on = P[chave] === o[0];
      return '<button type="button" class="nc-pp-seg-b' + (on ? ' is-on' : '') + '" data-pp-seg="' + chave + '" data-pp-v="' + o[0] + '" aria-pressed="' + on + '">' + o[1] + '</button>';
    }).join('') + '</div>';
  }
  /* linha de barra: nome · barra + número · detalhe (numa linha própria: não estoura com números grandes) */
  function linhaBarra(o) {
    var p = partes(o.t);
    return '<span class="nc-af-b-nome">' + (o.sel ? ic('marca') : '') + (o.etq || '') + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
      '<span class="nc-af-b-trilho' + (o.trilho ? ' ' + o.trilho : '') + '" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(o.w)) + '%"></i></span>' +
      '<span class="nc-af-b-num' + (o.numCls ? ' ' + o.numCls : '') + '"' + (o.exato ? ' title="' + esc(o.exato) + '"' : '') + '>' + o.v + '</span>' +
      (o.det ? '<span class="nc-pp-b-det">' + o.det + '</span>' : '');
  }
  /* DIA A DIA: uma coluna por dia (acima de 62 dias, por semana); arrastar escolhe um trecho */
  function serieDia() {
    var X = P.X, met = P.metDia, v = []; for (var z = 0; z < X.L; z++) v.push(0);
    P.A.ps.forEach(function (p) {
      if (met === 'falta') p.impar.forEach(function (d) { v[dias(X.ini, d)]++; });
      else if (met === 'risco') { var vis = {}; RISCOS.forEach(function (R) { p.risco[R.k].forEach(function (d) { var i = dias(X.ini, d); if (!vis[i]) { vis[i] = 1; v[i]++; } }); }); }
      else { var dm = (P.dados.dm || [])[p.i] || ''; for (var j = 0; j < dm.length && j < X.L; j++) if (dm.charAt(j) !== '0') v[j]++; }
    });
    var semana = X.L > 62, g = [];
    if (!semana) X.dds.forEach(function (d, j) { g.push({ a: d, b: d, v: v[j] }); });
    else {
      for (var j = 0; j < X.L; j += 7) {
        var s = 0, k2 = Math.min(X.L - 1, j + 6);
        for (var q = j; q <= k2; q++) s = met === 'bateu' ? Math.max(s, v[q]) : s + v[q];
        g.push({ a: X.dds[j], b: X.dds[k2], v: s });
      }
    }
    return { g: g, semana: semana };
  }
  function diaADia(grande) {
    var X = P.X, S = serieDia(), met = P.metDia;
    if (!S.g.some(function (x) { return x.v; })) return '<p class="nc-af-vazio-q">' + (met === 'falta' ? 'Nenhum dia com batida faltando' : met === 'risco' ? 'Nenhum dia com risco à CLT' : 'Ninguém bateu o ponto') + (P.A.filtrado ? ' com estes filtros' : '') + ' neste período.</p>';
    var max = Math.max.apply(null, S.g.map(function (x) { return x.v; })) || 1, pico = S.g.reduce(function (a, x) { return x.v > a.v ? x : a; }, S.g[0]);
    var unid = met === 'falta' ? ['pessoa com batida faltando', 'pessoas com batida faltando'] : met === 'risco' ? ['pessoa com risco', 'pessoas com risco'] : ['pessoa bateu o ponto', 'pessoas bateram o ponto'];
    var sel = P.sel;
    var html = '<ol class="nc-af-meses nc-pp-dias' + (grande ? ' is-grande' : '') + (S.semana ? ' is-semana' : '') + '">' + S.g.map(function (x, i) {
      var fds = !S.semana && (x.a.getDay() === 0 || x.a.getDay() === 6), futuro = x.a >= X.hoje && met !== 'bateu';
      var rot = (S.semana ? 'Semana de ' + curta(x.a) + ' a ' + curta(x.b) : SEMANA[x.a.getDay()] + ' ' + curta(x.a)) + ': ' +
        (futuro ? (x.a.getTime() === X.hoje.getTime() ? 'hoje, ainda acontecendo' : 'ainda não chegou') : plural(x.v, unid[0], unid[1]) + (S.semana && met === 'bateu' ? ' (o dia com mais)' : ''));
      var dentro = sel && x.b >= sel.a && x.a <= sel.b;
      var marco = S.semana ? x.a.getDate() <= 7 || i === 0 : x.a.getDate() === 1 || i === 0 || x.a.getDay() === 1;
      return '<li class="nc-af-mes nc-pp-dia' + (fds ? ' is-fds' : '') + (futuro ? ' is-futuro' : '') + (x.a <= X.hoje && x.b >= X.hoje ? ' is-atual' : '') + (marco ? ' is-marco' : '') +
        (x === pico ? ' is-pico' : '') + (dentro ? ' is-sel' : '') + '" tabindex="0" data-pp-i="' + i + '" data-pp-a="' + texto(x.a) + '" data-pp-b="' + texto(x.b) + '" aria-label="' + rot + '" data-dica="' + rot + '">' +
        '<b>' + (x.v ? num(x.v) : '') + '</b><i style="height:' + (x.v ? Math.max(5, Math.round(x.v / max * 100)) : 0) + '%"></i><span>' + x.a.getDate() +
        (x.a.getDate() <= (S.semana ? 7 : 1) || i === 0 ? '<em>' + MESES[x.a.getMonth()] + '</em>' : '') + '</span></li>';
    }).join('') + '</ol>';
    html += sel ? '<div class="nc-pp-trecho" role="status"><span>Trecho escolhido: <b>' + curta(sel.a) + ' a ' + curta(sel.b) + '</b> (' + plural(dias(sel.a, sel.b) + 1, 'dia', 'dias') + ')</span>' +
        '<button type="button" class="nc-af-bt nc-af-bt--cheio" data-pp-trecho>Ver só este trecho</button><button type="button" class="nc-af-limpa" data-pp-trecho-tira>' + ic('tirar') + '<span>Desfazer</span></button></div>'
      : '<p class="nc-af-pico">' + (S.semana ? 'Semana' : 'Dia') + ' com mais: <b>' + (S.semana ? curta(pico.a) + ' a ' + curta(pico.b) : SEMANA[pico.a.getDay()] + ' ' + curta(pico.a)) + '</b> · ' + plural(pico.v, unid[0], unid[1]) + '</p>';
    return html;
  }
  function ajustarDias() {
    [].forEach.call(P ? P.caixa.querySelectorAll('.nc-pp-dias') : [], function (ol) { if (ol.children.length) ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 26); });
  }
  var tAj = 0;
  window.addEventListener('resize', function () { clearTimeout(tAj); tAj = setTimeout(ajustarDias, 120); });
  /* ARRASTAR sobre o Dia a dia: do 1º ao último dia tocado vira o "trecho escolhido" (Enter numa coluna
     também marca: a 1ª vez o começo, a 2ª o fim) */
  function ligarArrasto() {
    var ini = null, ol = null;
    function li(e) { var t = document.elementFromPoint(e.clientX, e.clientY); return t && t.closest ? t.closest('.nc-pp-dia') : null; }
    function marca(a, b) {
      if (!ol) return;
      var i0 = Math.min(a, b), i1 = Math.max(a, b);
      [].forEach.call(ol.children, function (x, i) { x.classList.toggle('is-sel', i >= i0 && i <= i1); });
    }
    P.caixa.addEventListener('pointerdown', function (e) {
      var x = e.target.closest && e.target.closest('.nc-pp-dia'); if (!x || e.button > 0) return;
      ol = x.parentNode; ini = +x.getAttribute('data-pp-i'); marca(ini, ini);
      e.preventDefault();
    });
    document.addEventListener('pointermove', function (e) { if (ini == null) return; var x = li(e); if (x && x.parentNode === ol) marca(ini, +x.getAttribute('data-pp-i')); });
    document.addEventListener('pointerup', function (e) {
      if (ini == null) return;
      var x = li(e), fim = x && x.parentNode === ol ? +x.getAttribute('data-pp-i') : ini, a = Math.min(ini, fim), b = Math.max(ini, fim);
      P.sel = { a: data(ol.children[a].getAttribute('data-pp-a')), b: data(ol.children[b].getAttribute('data-pp-b')) };
      ini = null; ol = null;
      desenharQuadros({ attr: 'data-pp-trecho' });
    });
    P.caixa.addEventListener('keydown', function (e) {
      var x = e.target; if (e.key !== 'Enter' || !x.classList || !x.classList.contains('nc-pp-dia')) return;
      e.preventDefault();
      var d0 = data(x.getAttribute('data-pp-a')), d1 = data(x.getAttribute('data-pp-b'));
      if (P.sel && P.sel.meio) P.sel = { a: d0 < P.sel.a ? d0 : P.sel.a, b: d1 > P.sel.b ? d1 : P.sel.b };
      else P.sel = { a: d0, b: d1, meio: true };
      desenharQuadros({ attr: 'data-pp-i', v: x.getAttribute('data-pp-i') });
    });
  }
  /* O QUE A APURAÇÃO GEROU: cada evento (filtrado pelo grupo escolhido), com horas, pessoas e parte do total */
  function eventos(grande) {
    var g = GRUPO_EV.filter(function (x) { return x.k === P.grupoEv; })[0] || GRUPO_EV[0];
    var xs = P.A.evs.filter(function (x) { return !g.cats || g.cats.indexOf(x.e.cat) >= 0; });
    if (!xs.length) return '<p class="nc-af-vazio-q">Nenhum evento ' + (g.cats ? 'deste grupo ' : '') + 'no período' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.m; })) || 1, tot = 0;
    xs.forEach(function (x) { tot += x.m; });
    var iSel = -1; xs.forEach(function (x, i) { if (x.e.i === P.filtroEv) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var tp = TIPO_EV[x.e.tipo] || TIPO_EV.H, sel = x.e.i === P.filtroEv;
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra nc-pp-b' + (sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : i === 0 ? ' is-maior' : '') + '" data-af-ev="' + x.e.i + '" aria-pressed="' + sel + '"' +
        ' aria-controls="nc-pp-quem-ev" title="' + (sel ? 'Fechar a lista de ' : 'Ver quem tem ') + esc(x.e.t) + '">' +
        linhaBarra({ t: x.e.t, sel: sel, etq: '<i class="nc-pp-tipo nc-pp-tipo--' + tp[1] + '" title="' + tp[2] + '">' + tp[0] + '</i>', w: x.m / max * 100, trilho: 'nc-pp-b-trilho--' + tp[1],
                     v: horas(x.m), exato: horasExato(x.m), det: plural(x.p, 'pessoa', 'pessoas') + ' · ' + pct(x.m, tot) + ' do total' }) + '</button></li>';
    }), grande ? 300 : Math.max(POR_VEZ_Q, iSel + 1), 'linhas');
  }
  function desenharQuemEv(box, grande) {
    if (!box) return;
    if (P.filtroEv == null) return desenharQuem(box, null);
    var e = P.X.evs[P.filtroEv], L = { tit: e ? e.t : 'Evento', ordem: 'quem tem mais horas primeiro', xs: [] };
    L.xs = P.A.ps.map(function (p) { var m = 0; p.ev.forEach(function (x) { if (x[0] === P.filtroEv) m += x[2]; }); return { p: p, m: m }; })
      .filter(function (x) { return x.m; }).sort(function (a, b) { return b.m - a.m; })
      .map(function (x) { return { p: x.p, diz: horas(x.m) + ' no período', cor: e && e.tipo === 'D' ? 'vermelho' : e && e.tipo === 'C' ? 'verde' : '' }; });
    desenharQuem(box, L, grande);
  }
  /* ONDE: a coluna escolhida e o indicador escolhido */
  var METS = [
    ['conferir', 'Para conferir', 'dias com batida faltando e pedidos esperando'],
    ['abs', 'Absenteísmo', 'horas de ausência sobre as horas previstas'],
    ['he', 'Horas extras', 'horas extras do período'],
    ['saldo', 'Banco de horas', 'saldo do banco (créditos − débitos)'],
    ['risco', 'Riscos à CLT', 'dias com risco à CLT']
  ];
  function ondeDica() { var m = METS.filter(function (x) { return x[0] === P.met; })[0] || METS[0]; return 'Por ' + m[2] + ' · toque para filtrar o resumo'; }
  function ondes(grande) {
    var xs = P.A.onde, met = P.met;
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada para mostrar' + (P.A.filtrado ? ' com estes filtros' : '') + ' neste indicador.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return Math.abs(x.q); })) || 1;
    var iSel = -1; xs.forEach(function (x, i) { if (x.sel) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var v, det;
      if (met === 'conferir') { v = plural(x.f, 'dia', 'dias'); det = (x.r ? plural(x.r, 'pedido esperando', 'pedidos esperando') + ' · ' : '') + plural(x.p, 'pessoa', 'pessoas'); }
      else if (met === 'abs') { v = pct(x.aus, x.base, 1); det = horas(x.aus) + ' fora · ' + plural(x.p, 'pessoa', 'pessoas'); }
      else if (met === 'he') { v = horas(x.q); det = plural(x.p, 'pessoa', 'pessoas') + (x.acima ? ' · ' + num(x.acima) + ' acima do limite' : ''); }
      else if (met === 'saldo') { v = horas(x.q, true); det = plural(x.neg, 'pessoa devendo', 'pessoas devendo') + ' · ' + plural(x.p, 'pessoa', 'pessoas'); }
      else { v = plural(x.q, 'dia', 'dias'); det = plural(x.p, 'pessoa', 'pessoas'); }
      var cls = (x.sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '') + (i === 0 && iSel < 0 ? ' is-maior' : '');
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra nc-pp-b' + cls + '" data-af-filtra="' + x.dim + '" data-af-valor="' + esc(x.t) + '" aria-pressed="' + !!x.sel + '"' +
        ' title="' + (x.sel ? 'Tirar ' + esc(x.t) + ' do filtro' : iSel >= 0 ? 'Juntar ' + esc(x.t) + ' ao filtro' : 'Ver o resumo só de ' + esc(x.t)) + '">' +
        linhaBarra({ t: x.t, sel: x.sel, w: Math.abs(x.q) / max * 100, trilho: met === 'saldo' ? (x.q < 0 ? 'nc-pp-b-trilho--debito' : 'nc-pp-b-trilho--credito') : '',
                     v: v, numCls: met === 'saldo' ? (x.q < 0 ? 'nc-pp-b-num--neg' : 'nc-pp-b-num--pos') : '', det: det }) + '</button>' +
        (x.t !== 'Sem gestor' && x.t !== 'Não informado' ? '<button type="button" class="nc-af-b-tab" data-af-tabela="' + esc(x.t) + '" data-af-col="' + DIM[x.dim].col + '" title="Ver ' + esc(x.t) + ' na lista" aria-label="Ver ' + esc(x.t) + ' na lista">' + ic('tabela') + '</button>' : '') + '</li>';
    }), grande ? 300 : Math.max(POR_VEZ_Q, iSel + 1), 'linhas');
  }
  /* BANCO DE HORAS por FAIXA */
  var FAIXAS = { todos: function () { return true; }, deve10: function (s) { return s < -600; }, deve: function (s) { return s < 0 && s >= -600; }, tem: function (s) { return s > 0 && s <= 600; }, tem10: function (s) { return s > 600; } };
  function banco(grande) {
    var todos = P.A.ps.filter(function (p) { return p.cred || p.deb; });
    if (!todos.length) return '<p class="nc-af-vazio-q">Nenhum crédito ou débito no banco de horas neste período.</p>';
    var neg = 0, pos = 0, alto = 0, max = 1;
    todos.forEach(function (p) { if (p.saldo < 0) neg++; else if (p.saldo > 0) pos++; if (Math.abs(p.saldo) >= BANCO_ALTO) alto++; });
    var xs = todos.filter(function (p) { return (FAIXAS[P.faixa] || FAIXAS.todos)(p.saldo); }).sort(function (a, b) { return a.saldo - b.saldo; });
    xs.forEach(function (p) { max = Math.max(max, Math.abs(p.saldo)); });
    return '<p class="nc-pp-banco-resumo"><span class="nc-pp-banco-neg"><b>' + num(neg) + '</b> devendo</span><span class="nc-pp-banco-pos"><b>' + num(pos) + '</b> com horas a mais</span>' +
      (alto ? '<span class="nc-pp-banco-alto" title="saldo de 40 h ou mais, para mais ou para menos"><b>' + num(alto) + '</b> com 40h ou mais</span>' : '') + '</p>' +
      (xs.length ? rolo('ol', 'nc-af-barras nc-pp-barras--banco', xs.map(function (p) {
        var lado = p.saldo < 0 ? 'neg' : 'pos';
        return '<li class="nc-af-bl"><div class="nc-af-b nc-af-b--fixa nc-pp-b">' +
          linhaBarra({ t: partes(p.nome)[1], w: Math.abs(p.saldo) / max * 100, trilho: 'nc-pp-b-trilho--' + (lado === 'neg' ? 'debito' : 'credito'), v: horas(p.saldo, true), exato: horasExato(p.saldo),
                       numCls: 'nc-pp-b-num--' + lado, det: 'créditos ' + horas(p.cred) + ' · débitos ' + horas(p.deb) }) + '</div>' +
          (p.url ? '<button type="button" class="nc-af-b-tab" data-af-ponto="' + p.i + '" title="Abrir o ponto de ' + esc(partes(p.nome)[1]) + '" aria-label="Abrir o ponto de ' + esc(partes(p.nome)[1]) + '">' + ic('ponto') + '</button>' : '') + '</li>';
      }), grande ? 400 : POR_VEZ_Q, 'pessoas') : '<p class="nc-af-vazio-q">Ninguém nesta faixa.</p>');
  }
  /* RISCOS À CLT: os 3 contadores e quem tem */
  function riscos(grande) {
    var ps = P.A.ps.filter(function (p) { return p.nRisco; }).sort(function (a, b) { return b.nRisco - a.nRisco; });
    var c = RISCOS.map(function (R) { var d = 0, n = 0; P.A.ps.forEach(function (p) { if (p.risco[R.k].length) { n++; d += p.risco[R.k].length; } }); return { R: R, d: d, n: n }; });
    var topo = '<ul class="nc-pp-riscos">' + c.map(function (x) {
      return '<li' + (x.n ? ' class="is-ha"' : '') + ' title="' + x.R.lei + '"><b>' + num(x.n) + '</b><span>' + x.R.nome + '</span><small>' + plural(x.n, 'pessoa', 'pessoas') + ' · ' + plural(x.d, 'dia', 'dias') + '</small></li>';
    }).join('') + '</ul>';
    if (!ps.length) return topo + '<p class="nc-af-vazio-q">Nenhum dia com risco à CLT neste período' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = ps[0].nRisco || 1;
    return topo + rolo('ol', 'nc-af-barras', ps.map(function (p) {
      return '<li class="nc-af-bl"><div class="nc-af-b nc-af-b--fixa nc-pp-b">' +
        linhaBarra({ t: partes(p.nome)[1], w: p.nRisco / max * 100, trilho: 'nc-pp-b-trilho--debito', v: plural(p.nRisco, 'dia', 'dias'),
                     det: RISCOS.filter(function (R) { return p.risco[R.k].length; }).map(function (R) { return num(p.risco[R.k].length) + ' ' + R.curto; }).join(' · ') }) + '</div>' +
        (p.url ? '<button type="button" class="nc-af-b-tab" data-af-ponto="' + p.i + '" title="Abrir o ponto de ' + esc(partes(p.nome)[1]) + '" aria-label="Abrir o ponto de ' + esc(partes(p.nome)[1]) + '">' + ic('ponto') + '</button>' : '') + '</li>';
    }), grande ? 400 : POR_VEZ_Q, 'pessoas');
  }
  /* MÊS A MÊS: ausência (roxo) e horas extras (rosa), dois por mês */
  function mesAMes() {
    var X = P.X, ms = X.meses.map(function (m, i) { return { m: m, i: i, aus: 0, he: 0 }; });
    P.A.ps.forEach(function (p) {
      p.ev.forEach(function (x) { var e = X.evs[x[0]], c = ms[x[1]]; if (!e || !c) return; if (['falta', 'atraso', 'saida', 'just'].indexOf(e.cat) >= 0) c.aus += x[2]; else if (e.cat === 'he') c.he += x[2]; });
    });
    ms.sort(function (a, b) { return a.m.d - b.m.d; });
    var max = Math.max.apply(null, ms.map(function (m) { return Math.max(m.aus, m.he); })) || 1;
    return '<p class="nc-af-legenda"><span class="nc-af-leg nc-af-leg--e"></span>Ausências <span class="nc-af-leg nc-af-leg--s"></span>Horas extras</p>' +
      '<ol class="nc-af-meses nc-af-meses--par">' + ms.map(function (m, i) {
        var d = m.m.d, rot = MESES[d.getMonth()] + '/' + d.getFullYear() + ': ' + horas(m.aus) + ' de ausência · ' + horas(m.he) + ' de horas extras';
        return '<li class="nc-af-mes is-marco" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '"><b></b><span class="nc-af-par">' +
          '<i class="nc-af-par-e" style="height:' + (m.aus ? Math.max(4, Math.round(m.aus / max * 100)) : 0) + '%"></i><i class="nc-af-par-s" style="height:' + (m.he ? Math.max(4, Math.round(m.he / max * 100)) : 0) + '%"></i></span>' +
          '<span>' + MESES[d.getMonth()] + (d.getMonth() === 0 || i === 0 ? '<em>' + d.getFullYear() + '</em>' : '') + '</span></li>';
      }).join('') + '</ol>';
  }

  /* ═══ [J6] AMPLIAR ══════════════════════════════════════════════════════════════════════
     O quadro abre por cima da página (fixo, com o fundo escurecido), maior, com TODAS as linhas e o
     gráfico alto. Fecha no ×, no Esc ou tocando fora. O foco volta para o botão que abriu.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function abrirZoom(q, botao) {
    P.zoom = q; P.zoomDe = botao;
    var z = P.caixa.querySelector('.nc-pp-zoom');
    if (!z) {
      z = el('div', 'nc-pp-zoom');
      z.innerHTML = '<div class="nc-pp-zoom-fundo" data-pp-zoom-fundo></div><div class="nc-pp-zoom-caixa" role="dialog" aria-modal="true" aria-labelledby="nc-pp-zoom-tit">' +
        '<button type="button" class="nc-pp-zoom-fecha" data-pp-zoom-fecha aria-label="Fechar o quadro ampliado">' + ic('tirar') + '<span>Fechar</span></button><div class="nc-pp-zoom-corpo"></div></div>';
      z.querySelector('[data-pp-zoom-fundo]').addEventListener('click', function () { fecharZoom(); });
      P.caixa.appendChild(z);
    }
    z.hidden = false;
    document.documentElement.classList.add('nc-af-travado');
    desenharZoom();
    z.querySelector('.nc-pp-zoom-fecha').focus({ preventScroll: true });
  }
  function desenharZoom() {
    var z = P.caixa.querySelector('.nc-pp-zoom'); if (!z || !P.zoom || !P.A) return;
    var c = z.querySelector('.nc-pp-zoom-corpo');
    c.innerHTML = quadro(P.zoom, true) + (P.zoom === 'eventos' ? '<div class="nc-af-quem nc-pp-quem--ev" hidden aria-live="polite"></div>' : '');
    ligarRolos(c);
    if (P.zoom === 'eventos') desenharQuemEv(c.querySelector('.nc-pp-quem--ev'), true);
    ajustarDias();
  }
  function fecharZoom(semFoco) {
    var z = P && P.caixa.querySelector('.nc-pp-zoom'); if (!z || z.hidden) { if (P) P.zoom = null; return; }
    z.hidden = true; z.querySelector('.nc-pp-zoom-corpo').innerHTML = '';
    document.documentElement.classList.remove('nc-af-travado');
    var de = P.zoomDe; P.zoom = null; P.zoomDe = null;
    if (!semFoco) { var b = de && P.caixa.contains(de) ? de : P.caixa.querySelector('[data-pp-zoom]'); if (b) b.focus({ preventScroll: true }); }
  }

  /* ═══ [J7] FILTRAR E CRUZAR ═════════════════════════════════════════════════════════════ */
  function filtrosIdx() {
    var fi = {}, dims = P.dados.dims || {};
    Object.keys(P.f).forEach(function (k) {
      var m = {}, ok = [];
      (P.f[k] || []).forEach(function (t) { var i = (dims[k] || []).indexOf(t); if (i >= 0) { m[i] = 1; ok.push(t); } });
      if (ok.length) { fi[k] = m; P.f[k] = ok; } else delete P.f[k];
    });
    return fi;
  }
  function passa(p, fi, sem) { for (var k in fi) { if (k !== sem && !fi[k][p.k[DIM[k].i]]) return false; } return true; }
  /* a base do absenteísmo: as horas PREVISTAS (função do espelho); sem ela, trabalhadas + ausências */
  function baseAbs(ps) {
    var comPv = ps.filter(function (p) { return p.pv; }), usa = comPv.length > 0 && comPv.length >= ps.length * 0.5;
    var lista = usa ? comPv : ps, base = 0, aus = 0;
    lista.forEach(function (p) { base += usa ? p.pv : p.tr + p.aus; aus += p.aus; });
    return { base: base, aus: aus, prevista: usa, n: lista.length };
  }
  function agregar() {
    var X = P.X, fi = filtrosIdx(), filtrado = Object.keys(fi).length > 0, dims = P.dados.dims || {}, por = DIM[P.por] ? P.por : POR_PADRAO;
    var ps = X.ps.filter(function (p) { return !filtrado || passa(p, fi); });
    var t = { batidas: 0, ajust: 0, diasCom: 0, comBatida: 0, cred: 0, deb: 0, folha: 0, evMin: 0, tr: 0, aus: 0, he: 0, falta: 0, atraso: 0, just: 0 };
    var c = { falta: [0, 0], ped: [0, 0, 0], sem: 0, risco: [0, 0], ajuste: 0, banco: [0, 0, 0], he: [0, 0], faltas: 0, atrasos: 0 };
    var gE = {};
    ps.forEach(function (p) {
      t.batidas += p.batidas; t.ajust += p.ajust; t.diasCom += p.diasCom; if (p.batidas) t.comBatida++;
      t.cred += p.cred; t.deb += p.deb; t.folha += p.folha; t.tr += p.tr; t.aus += p.aus; t.he += p.he; t.falta += p.falta; t.atraso += p.atraso; t.just += p.just;
      if (p.impar.length) { c.falta[0]++; c.falta[1] += p.impar.length; }
      if (p.nPend) { c.ped[0]++; c.ped[1] += p.nPend; c.ped[2] = Math.max(c.ped[2], p.espera); }
      if (p.sem) c.sem++;
      if (p.nRisco) { c.risco[0]++; c.risco[1] += p.nRisco; }
      if (p.ajust) c.ajuste++;
      if (p.cred || p.deb) { c.banco[0]++; if (p.saldo < 0) c.banco[1]++; if (Math.abs(p.saldo) >= BANCO_ALTO) c.banco[2]++; }
      if (p.he) { c.he[0]++; if (p.limHE && p.he > p.limHE) c.he[1]++; }
      if (p.falta) c.faltas++;
      if (p.atraso) c.atrasos++;
      p.ev.forEach(function (x) { var g = gE[x[0]] || (gE[x[0]] = { m: 0, ps: {} }); g.m += x[2]; g.ps[p.i] = 1; });
    });
    t.evMin = t.cred + t.deb + t.folha;
    var evs = Object.keys(gE).map(function (i) { return { e: X.evs[i], m: gE[i].m, p: Object.keys(gE[i].ps).length }; }).filter(function (x) { return x.e; })
      .sort(function (a, b) { return b.m - a.m; }).slice(0, 300);
    /* onde: a coluna escolhida e o indicador escolhido; a lista ignora o filtro da própria coluna */
    var gO = {}, iPor = DIM[por].i, met = P.met;
    X.ps.forEach(function (p) {
      if (filtrado && !passa(p, fi, por)) return;
      var v = p.k[iPor]; (gO[v] || (gO[v] = [])).push(p);
    });
    var onde = Object.keys(gO).map(function (v) {
      var g = gO[v], x = { t: (dims[por] || [])[v], dim: por, sel: !!(fi[por] && fi[por][v]), p: 0, q: 0, f: 0, r: 0, acima: 0, neg: 0 };
      if (met === 'abs') { var b = baseAbs(g); x.aus = b.aus; x.base = b.base; x.q = b.base ? b.aus / b.base : 0; x.p = g.filter(function (p) { return p.aus; }).length; return x; }
      g.forEach(function (p) {
        if (met === 'conferir') { var q = p.impar.length + p.nPend; if (q) { x.q += q; x.f += p.impar.length; x.r += p.nPend; x.p++; } }
        else if (met === 'he') { if (p.he) { x.q += p.he; x.p++; if (p.limHE && p.he > p.limHE) x.acima++; } }
        else if (met === 'saldo') { if (p.cred || p.deb) { x.q += p.saldo; x.p++; if (p.saldo < 0) x.neg++; } }
        else if (met === 'risco') { if (p.nRisco) { x.q += p.nRisco; x.p++; } }
      });
      return x;
    }).filter(function (x) { return x.t != null && (x.q || x.sel); })
      .sort(function (a, b) { return met === 'saldo' ? a.q - b.q : b.q - a.q || b.p - a.p; }).slice(0, 300);
    var B = baseAbs(ps);
    var nota = '';
    if (t.aus || B.base) nota = 'Absenteísmo = horas de ausência (faltas, atrasos, saídas antecipadas e ausências justificadas) ÷ ' +
      (B.prevista ? 'horas previstas (' + horas(B.base) + (B.n < ps.length ? ', de ' + plural(B.n, 'pessoa', 'pessoas') : '') + ')' : '<b>horas trabalhadas + ausências</b> (' + horas(B.base) + '), porque as horas previstas não vieram do espelho de ponto') +
      (X.prev.parcial ? '. As horas previstas foram lidas só para parte das pessoas (tempo esgotado).' : '.') +
      ' Hora extra acima do limite: mais de 2 h por dia útil já passado (' + plural(X.uteis, 'dia útil', 'dias úteis') + ').';
    var saldo = t.cred - t.deb;
    var N = {
      falta:  { n: c.falta[0], v: num(c.falta[0]), u: c.falta[0] === 1 ? 'pessoa' : 'pessoas', dica: c.falta[0] ? plural(c.falta[1], 'dia', 'dias') + ' para conferir' : 'tudo batido até ontem' },
      pedido: { n: c.ped[1], v: num(c.ped[1]), u: c.ped[1] === 1 ? 'pedido' : 'pedidos', dica: c.ped[1] ? 'de ' + plural(c.ped[0], 'pessoa', 'pessoas') + (c.ped[2] > 1 ? ' · o mais antigo há ' + c.ped[2] + ' dias' : '') : 'nenhum esperando aprovação' },
      sem:    { n: c.sem, v: num(c.sem), u: c.sem === 1 ? 'pessoa' : 'pessoas', dica: c.sem ? 'trabalhando, sem batida no período' : 'todos bateram o ponto' },
      risco:  { n: c.risco[0], v: num(c.risco[0]), u: c.risco[0] === 1 ? 'pessoa' : 'pessoas', dica: c.risco[0] ? plural(c.risco[1], 'dia', 'dias') + ': descanso, jornada ou intervalo' : 'nenhum descanso, jornada ou intervalo fora da lei' },
      ajuste: { n: t.ajust, texto: true, v: pct(t.ajust, t.batidas), u: 'das batidas', dica: t.ajust ? plural(t.ajust, 'batida', 'batidas') + ' de ' + plural(c.ajuste, 'pessoa', 'pessoas') : 'nenhuma batida ajustada' },
      abs:    { n: t.aus, texto: true, v: pct(B.aus, B.base, 1), u: B.prevista ? 'das horas' : 'estimado', dica: t.aus ? horas(t.aus) + ' fora · faltas ' + horas(t.falta) + ' · atrasos ' + horas(t.atraso) : 'nenhuma ausência apurada',
                dicaLonga: 'Absenteísmo: ' + horasExato(B.aus) + ' de ausência sobre ' + horasExato(B.base) + (B.prevista ? ' previstas' : ' (trabalhadas + ausências)') },
      he:     { n: t.he, texto: true, v: horas(t.he), u: B.base ? pct(t.he, B.base, 1) + ' das horas' : 'no período', dica: t.he ? plural(c.he[0], 'pessoa', 'pessoas') + (c.he[1] ? ' · <b>' + num(c.he[1]) + ' acima do limite</b>' : '') : 'nenhuma hora extra apurada', alerta: c.he[1] > 0, dicaLonga: 'Horas extras: ' + horasExato(t.he) },
      banco:  { n: c.banco[0], texto: true, v: horas(saldo, true), u: 'no período', dica: c.banco[0] ? plural(c.banco[1], 'pessoa devendo', 'pessoas devendo') + (c.banco[2] ? ' · ' + num(c.banco[2]) + ' com 40h ou mais' : '') : 'sem crédito nem débito no período', dicaLonga: 'Saldo do banco no período: ' + horasExato(saldo) },
      faltas: { n: t.falta, texto: true, v: horas(t.falta), u: 'de falta', dica: c.faltas ? plural(c.faltas, 'pessoa faltou', 'pessoas faltaram') : 'ninguém faltou', dicaLonga: 'Faltas: ' + horasExato(t.falta) },
      atrasos: { n: t.atraso, texto: true, v: horas(t.atraso), u: 'no período', dica: c.atrasos ? plural(c.atrasos, 'pessoa', 'pessoas') + ' com atraso ou saída antecipada' : 'nenhum atraso apurado', dicaLonga: 'Atrasos e saídas antecipadas: ' + horasExato(t.atraso) }
    };
    return { fi: fi, filtrado: filtrado, por: por, ps: ps, tot: t, nums: N, evs: evs, onde: onde, base: { nota: nota } };
  }

  function comparar(a, b) { return String(a).localeCompare(String(b), 'pt-BR', { numeric: true, sensitivity: 'base' }); }
  function desenharFiltros() {
    var box = P.caixa.querySelector('.nc-af-filtros'); if (!box) return;
    var X = P.X, fi = P.A.fi, dims = P.dados.dims || {}, n = Object.keys(fi).length;
    P.opc = {};
    if (P.nDims !== P.dados) { P.nDims = P.dados; P.nVal = {}; DIMS.forEach(function (D) { var t = {}; X.ps.forEach(function (p) { t[p.k[D.i]] = 1; }); P.nVal[D.k] = Object.keys(t).length; }); }
    var campos = DIMS.map(function (D) {
      var tem = {};
      X.ps.forEach(function (p) { if (passa(p, fi, D.k)) tem[p.k[D.i]] = (tem[p.k[D.i]] || 0) + 1; });
      (P.f[D.k] || []).forEach(function (t) { var i = (dims[D.k] || []).indexOf(t); if (i >= 0 && !(i in tem)) tem[i] = 0; });
      var vs = Object.keys(tem).map(function (v) { return { t: (dims[D.k] || [])[v], n: tem[v] }; }).filter(function (x) { return x.t != null; }).sort(function (a, b) { return comparar(a.t, b.t); });
      P.opc[D.k] = vs;
      var es = P.f[D.k] || [];
      if (P.nVal[D.k] < 2 && !es.length) return '';
      var aberto = P.pop && P.pop.k === D.k;
      return '<div class="nc-af-campo' + (es.length ? ' is-ativo' : '') + '"><span class="nc-af-campo-rot" id="nc-pp-rot-' + D.k + '">' + D.nome + '</span>' +
        '<button type="button" class="nc-af-escolha" data-af-abre="' + D.k + '" aria-haspopup="true" aria-expanded="' + aberto + '" aria-controls="nc-af-pop"' +
        ' aria-labelledby="nc-pp-rot-' + D.k + ' nc-pp-val-' + D.k + '"><span class="nc-af-escolha-txt" id="nc-pp-val-' + D.k + '">' +
        (es.length ? esc(es[0]) : D.todos) + '</span>' + (es.length > 1 ? '<b class="nc-af-mais-n" aria-label="e mais ' + (es.length - 1) + '">+' + (es.length - 1) + '</b>' : '') + ic('abrir') + '</button></div>';
    }).join('');
    var chips = Object.keys(fi).map(function (k) {
      var t = P.f[k], tudo = t.join(', ');
      return '<button type="button" class="nc-af-chip" data-af-tira="' + k + '" title="Tirar este filtro: ' + esc(tudo) + '" aria-label="Tirar o filtro ' + esc(DIM[k].nome + ': ' + tudo) + '">' +
        '<span>' + DIM[k].nome + '</span><b>' + esc(t[0]) + '</b>' + (t.length > 1 ? '<em>+' + (t.length - 1) + '</em>' : '') + ic('tirar') + '</button>';
    }).join('');
    box.hidden = !campos && !n;
    box.classList.toggle('is-ativo', n > 0);
    box.innerHTML = '<div class="nc-af-filtros-cab">' + ic('filtro') + '<p class="nc-af-filtros-tit">Filtrar este resumo</p>' +
      '<p class="nc-af-filtros-nota">' + (n ? 'A lista abaixo continua com os filtros da página.' : 'Escolha um ou mais em cada caixa. A lista abaixo não muda.') + '</p>' +
      (n ? '<button type="button" class="nc-af-limpa" data-af-limpa>' + ic('tirar') + '<span>' + (n === 1 ? 'Limpar o filtro' : 'Limpar os ' + n + ' filtros') + '</span></button>' : '') +
      '</div><div class="nc-af-filtros-campos">' + campos + '</div>' +
      (n ? '<div class="nc-af-filtros-chips"><span class="nc-af-filtros-chips-rot">Resumo só de:</span>' + chips + '</div>' : '');
  }
  function abrirLista(k) {
    fecharLista(false);
    var pop = P.caixa.querySelector('.nc-af-pop');
    if (!pop) { pop = el('div', 'nc-af-pop'); pop.id = 'nc-af-pop'; pop.setAttribute('role', 'dialog'); pop.hidden = true; P.caixa.appendChild(pop); }
    var D = DIM[k], vs = P.opc[k] || [], es = P.f[k] || [];
    var ordem = vs.filter(function (x) { return es.indexOf(x.t) >= 0; }).concat(vs.filter(function (x) { return es.indexOf(x.t) < 0; }));
    pop.setAttribute('aria-label', D.nome);
    pop.innerHTML = '<div class="nc-af-pop-cab"><b>' + D.nome + '</b><span>marque um ou mais</span></div>' +
      (vs.length > 8 ? '<label class="nc-af-procura nc-af-pop-busca">' + ic('busca') + '<span class="nc-af-vis">Procurar em ' + D.nome + '</span><input type="search" placeholder="Procurar código ou nome" data-af-pop-busca autocomplete="off"></label>' : '') +
      '<ul class="nc-af-pop-lista">' + ordem.map(function (x) {
        return '<li data-af-texto="' + esc(semAcento(x.t)) + '"><label><input type="checkbox" data-af-marca value="' + esc(x.t) + '"' + (es.indexOf(x.t) >= 0 ? ' checked' : '') + '>' +
          '<span>' + esc(x.t) + '</span>' + (x.n ? '<small title="colaboradores">' + num(x.n) + '</small>' : '') + '</label></li>';
      }).join('') + '</ul><p class="nc-af-pop-nada" hidden>Nada com esse nome.</p>' +
      '<div class="nc-af-pop-pe"><button type="button" class="nc-af-limpa" data-af-pop-limpa>Desmarcar todos</button><button type="button" class="nc-af-bt nc-af-bt--cheio" data-af-pronto>Pronto</button></div>';
    P.pop = { k: k, el: pop };
    pop.hidden = false;
    posicionarLista();
    marcarLista();
    var foco = pop.querySelector('[data-af-pop-busca]') || pop.querySelector('[data-af-marca]');
    if (foco) foco.focus({ preventScroll: true });
    var busca = pop.querySelector('[data-af-pop-busca]');
    if (busca) busca.addEventListener('input', function () {
      var t = semAcento(busca.value.trim()), n = 0;
      [].forEach.call(pop.querySelectorAll('.nc-af-pop-lista li'), function (li) { var ok = !t || li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
      pop.querySelector('.nc-af-pop-nada').hidden = n > 0;
    });
  }
  function fecharLista(devolve) {
    if (!P || !P.pop) return;
    var k = P.pop.k;
    P.pop.el.hidden = true; P.pop.el.innerHTML = ''; P.pop = null;
    var b = P.caixa.querySelector('[data-af-abre="' + k + '"]');
    if (b) { b.setAttribute('aria-expanded', 'false'); if (devolve) b.focus({ preventScroll: true }); }
  }
  function posicionarLista() {
    if (!P.pop) return;
    var b = P.caixa.querySelector('[data-af-abre="' + P.pop.k + '"]');
    if (!b) return fecharLista(false);
    b.setAttribute('aria-expanded', 'true');
    var c = P.caixa.getBoundingClientRect(), r = b.getBoundingClientRect(), pop = P.pop.el;
    var larg = Math.min(Math.max(r.width, 320), c.width - 16);
    pop.style.width = larg + 'px';
    pop.style.left = Math.max(8, Math.min(r.left - c.left, c.width - larg - 8)) + 'px';
    pop.style.top = (r.bottom - c.top + 6) + 'px';
  }
  function marcarLista() {
    if (!P.pop) return;
    var es = P.f[P.pop.k] || [];
    [].forEach.call(P.pop.el.querySelectorAll('[data-af-marca]'), function (x) { x.checked = es.indexOf(x.value) >= 0; });
  }
  document.addEventListener('mousedown', function (e) { if (P && P.pop && !P.pop.el.contains(e.target) && !e.target.closest('[data-af-abre]')) fecharLista(false); }, true);
  document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && P && P.pop) { e.preventDefault(); fecharLista(true); } });
  window.addEventListener('resize', function () { if (P && P.pop) posicionarLista(); });

  function verPor() {
    return '<div class="nc-pp-onde-ctl"><label class="nc-af-ver-por"><span>por</span><select data-pp-por aria-label="Onde: ver por">' +
      DIMS.map(function (D) { return '<option value="' + D.k + '"' + (D.k === P.A.por ? ' selected' : '') + '>' + (D.curto || D.nome) + '</option>'; }).join('') + '</select></label>' +
      '<label class="nc-af-ver-por"><span>ver</span><select data-pp-met aria-label="Onde: indicador">' +
      METS.map(function (m) { return '<option value="' + m[0] + '"' + (m[0] === P.met ? ' selected' : '') + '>' + m[1] + '</option>'; }).join('') + '</select></label></div>';
  }
  function mudou(e) {
    var s = e.target;
    if (s.matches('[data-af-marca]') && P.pop) {
      var k = P.pop.k, l = (P.f[k] || []).filter(function (t) { return t !== s.value; });
      if (s.checked) l.push(s.value);
      if (l.length) P.f[k] = l; else delete P.f[k];
      redesenhar({ pop: true });
    } else if (s.matches('select[data-pp-por]')) {
      P.por = s.value;
      try { if (s.value === POR_PADRAO) localStorage.removeItem(GUARDA_POR); else localStorage.setItem(GUARDA_POR, s.value); } catch (e2) { /* ok */ }
      redesenhar({ attr: 'data-pp-por', v: '' });
    } else if (s.matches('select[data-pp-met]')) {
      P.met = s.value;
      redesenhar({ attr: 'data-pp-met', v: '' });
    }
  }
  function alternar(k, t) {
    var l = P.f[k] || [], i = l.indexOf(t);
    if (i >= 0) l.splice(i, 1); else l.push(t);
    if (l.length) P.f[k] = l; else delete P.f[k];
    redesenhar({ attr: 'data-af-valor', v: t });
  }
  function tirarFiltro(k) { delete P.f[k]; redesenhar({ attr: 'data-af-tira', v: Object.keys(P.f)[0] || null, depois: '.nc-af-filtros-campos [data-af-abre]' }); }
  function limparFiltros() { P.f = {}; redesenhar({ attr: null, depois: '.nc-af-filtros-campos [data-af-abre]' }); }
  function refocar(f) {
    if (f.pop) { posicionarLista(); return; }
    var raiz = P.zoom ? P.caixa.querySelector('.nc-pp-zoom-corpo') : P.caixa, alvo = null;
    if (f.attr) [].some.call(raiz.querySelectorAll('[' + f.attr + ']'), function (x) { if (!f.v || x.getAttribute(f.attr) === f.v) { alvo = x; return true; } return false; });
    if (!alvo && f.depois) alvo = P.caixa.querySelector(f.depois);
    if (!alvo) return;
    var li = alvo.closest('li'); if (li && li.hidden) li.hidden = false;
    alvo.focus({ preventScroll: true });
  }

  /* ═══ [J8] ABRIR O PONTO E VER NA TABELA ════════════════════════════════════════════════ */
  function abrirPonto(i) {
    var p = P.X.ps[i]; if (!p || !p.url) return;
    try { apex.widget.waitPopup(); } catch (e) { /* ok */ }
    window.location.href = p.url;
  }
  function colunaDaBusca(col) {
    var h = document.getElementById(IR_ID + '_column_search_current_column'), f = document.getElementById(IR_ID + '_search_field');
    if (!h || !f) return null;
    var D = DIMS.filter(function (x) { return x.col === col; })[0], tit = D ? D.tit : col === 'COLABORADOR' ? 'Colaborador' : null;
    var visivel = tit && [].some.call(document.querySelectorAll('#' + IR_ID + ' .a-IRR-table th'), function (th) { return th.textContent.trim() === tit; });
    var rot = visivel ? 'Pesquisar: ' + tit : '';
    h.value = visivel ? col : '';
    f.setAttribute('placeholder', rot); f.setAttribute('title', rot || 'Pesquisar');
    return visivel ? tit : null;
  }
  function naTabela(texto_, col) {
    var f = document.getElementById(IR_ID + '_search_field'), b = document.getElementById(IR_ID + '_search_button');
    fecharZoom(true);
    if (!f || !b) return irParaTabela();
    P.quando.textContent = 'Filtrando a lista…';
    irParaTabela();
    var t0 = Date.now();
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      var nomeCol = colunaDaBusca(col);
      f.value = texto_;
      b.click();
      P.quando.innerHTML = 'A lista abaixo agora mostra só <b>' + esc(texto_) + '</b>' + (nomeCol ? ' (na coluna ' + esc(nomeCol) + ')' : '') +
        '. Para ver todos de novo, toque no <b>×</b> do filtro, em cima da lista.';
    })();
  }
  function irParaTabela() {
    var ir = document.getElementById(IR_ID); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [J9] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncPontoIniciou) return; if (montar()) { window.__ncPontoIniciou = true; buscar(); } }
  window.__ncPontoDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
