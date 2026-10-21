/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · SAÚDE E SEGURANÇA DO TRABALHO  —  o painel de indicadores (JavaScript) — v1    ║
   ║  App 2937 · Página 5 (Dados de Funcionário — a lista que leva ao Histórico, página 6)     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: SAUDEPAINEL-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima da lista de colaboradores, um RESUMO de saúde e segurança para quem cuida das pessoas
   (médico do trabalho, engenheiro e técnico de segurança, analista de DP) e para quem decide (RH,
   diretoria), escrito do jeito que se fala:
     PARA AGIR HOJE  Exame vencido · Exame vence em 30 dias · Afastados hoje · 15 dias de atestado
     (a situação     (INSS) · Estabilidade por acidente · Vacina atrasada · Restrição ou doença em
     de hoje)        aberto. Tocar num número mostra QUEM são, na ordem do que pede ação, e cada
                     pessoa tem "Abrir o histórico" (a janela da página 6, a mesma do lápis).
     NO PERÍODO      Absenteísmo por doença · Atestados · Acidentes · Dias sem acidente · Exames
     (gestão)        feitos · Atendimentos. O período fica no próprio painel (padrão: os últimos 12
                     meses), com atalhos.
     QUADROS         Mês a mês · Exames periódicos (PCMSO) · Causas dos afastamentos (CID) · Onde ·
                     Acidentes · Vacinas. Cada quadro tem "Ampliar".
     FILTRAR         "Filtrar este resumo" (as colunas da tabela e a faixa de idade) e tocar numa barra
                     de "Onde" deixam o resumo inteiro só com aquilo, na hora.
   Os números vêm do servidor (processo NC_SAUDE_INDICADORES): as MESMAS pessoas do relatório e, de
   cada uma, as MESMAS tabelas do Histórico (página 6).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda o relatório nem os filtros da página. Não grava nada.
     • "Afastado" pela SITUAÇÃO funcional é lido pelo NOME da situação ([S1], AFASTA): se uma
       situação da empresa tiver outro nome, ajustar ali.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 5 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_SaudePainel.js
     Página 5 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_SaudePainel.css
     Página 5 › Processing › Ajax Callback NC_SAUDE_INDICADORES  (NC_SAUDE_INDICADORES.plsql.sql)
   O COMBINADO com a página: o relatório tem Static ID "COLABORADORES" e os filtros são P5_*.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [S1] Textos e ferramentas ............ números, colunas, faixas, regras            PODE MEXER
     [S2] Os dados ........................ chamada ao servidor e o preparo            CUIDADO
     [S3] A moldura e o período ........... título, De/Até, atalhos, calculando
     [S4] Os números ...................... as duas réguas e a lista "quem são"        PODE MEXER
     [S5] Os quadros ...................... mês a mês, PCMSO, causas, onde, acidentes, vacinas
     [S6] Ampliar ......................... o quadro em tela grande
     [S7] Filtrar e cruzar ................ as colunas, as contas, a lista de marcar
     [S8] Abrir o histórico e ver na tabela
     [S9] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncSaude) return;
  window.__ncSaude = true;

  var IR_ID = 'COLABORADORES';
  function marcarRelatorio() { var ir = document.getElementById(IR_ID); if (ir) ir.classList.add('nc-reg-sim'); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  /* ═══ [S1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_SAUDE_INDICADORES';
  var ITENS = ['P5_SITUACAO', 'P5_EMPRESA', 'P5_FILIAL', 'P5_CCUSTO', 'P5_UNIDADE_ADM', 'P5_ATIVIDADE', 'P5_CARGO', 'P5_MATRICULA'];
  var POR_VEZ = 30;                       /* pessoas que cada lista mostra de cada vez */
  var POR_VEZ_Q = 8;                      /* linhas de cada quadro, de cada vez */
  var GUARDA = 'nc-sp-fechado';           /* o painel aberto fica lembrado neste navegador ('0' = aberto) */
  var GUARDA_POR = 'nc-sp-por';
  var VALIDADE = 10 * 60 * 1000;         /* o resumo calculado vale 10 min nesta aba (mesmos filtros e datas) */
  var MAX_DIAS = 731;                     /* o servidor corta acima disso (2 anos) */
  var VENCE = 30;                         /* "vence em breve": dias */
  var INSS = 15;                          /* mais de 15 dias de atestado em 60 dias: a partir do 16º, INSS */
  var INSS_PERTO = 11;                    /* a partir de quantos dias a pessoa entra como "chegando" */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

  /* PODE MEXER — a situação funcional que conta como AFASTADO, pelo NOME (férias nunca) */
  var AFASTA = /AFAST|ACID|DOEN[CÇ]A|AUX[IÍ]LIO|INSS|LICEN[CÇ]A.{0,4}(M[EÉ]D|MATERN)|MATERNIDADE/i;
  var NAO_AFASTA = /F[EÉ]RIAS/i;
  /* resultado de exame que pede atenção, pelo NOME do resultado */
  var INAPTO = /INAPT/i, ALTERADO = /ALTERAD|ANORMAL/i;

  var TIPO_EXAME = { A: 'Admissional', P: 'Periódico', D: 'Demissional', R: 'Retorno ao trabalho', M: 'Mudança de função', T: 'Transferência', C: 'Clínico' };
  var TIPO_ACID = { 1: 'Típico', 2: 'Doença ocupacional', 3: 'Trajeto', 4: 'Incidente' };
  var CLASSE_ACID = { 1: 'Físico', 2: 'Químico', 3: 'Biológico', 4: 'Ergonômico', 5: 'Acidente/Mecânico' };
  var DOSE = { UD: 'Dose única', D1: '1ª dose', D2: '2ª dose', D3: '3ª dose', D4: '4ª dose', D5: '5ª dose', D6: '6ª dose', RF: 'Reforço', NA: '' };
  var FAIXAS_IDADE = ['Até 24 anos', '25 a 34 anos', '35 a 44 anos', '45 a 54 anos', '55 anos ou mais', 'Sem data de nascimento'];
  /* os grupos da CID-10 (capítulos), pela letra e número */
  var CAPS = [
    ['A00', 'B99', 'Infecciosas e parasitárias'], ['C00', 'D48', 'Tumores'], ['D50', 'D89', 'Sangue e imunidade'],
    ['E00', 'E90', 'Endócrinas e metabólicas'], ['F00', 'F99', 'Saúde mental'], ['G00', 'G99', 'Sistema nervoso'],
    ['H00', 'H59', 'Olhos'], ['H60', 'H95', 'Ouvidos'], ['I00', 'I99', 'Circulatórias (coração, pressão)'],
    ['J00', 'J99', 'Respiratórias'], ['K00', 'K93', 'Digestivas'], ['L00', 'L99', 'Pele'],
    ['M00', 'M99', 'Ossos, músculos e articulações'], ['N00', 'N99', 'Rins e aparelho urinário/genital'],
    ['O00', 'O99', 'Gravidez e parto'], ['P00', 'P96', 'Período perinatal'], ['Q00', 'Q99', 'Malformações'],
    ['R00', 'R99', 'Sintomas sem diagnóstico'], ['S00', 'T98', 'Lesões e traumas'], ['V01', 'Y98', 'Causas externas'],
    ['Z00', 'Z99', 'Consultas, exames e acompanhamento']
  ];

  /* as colunas da tabela que o resumo filtra e cruza ("i" = posição em p.k) */
  var DIMS = [
    { k: 'emp',   i: 0, col: 'COD_EMPRESA_DSP', tit: 'Empresa',        nome: 'Empresa',           todos: 'Todas' },
    { k: 'fil',   i: 1, col: 'FILIAL',          tit: 'Filial',         nome: 'Filial',            todos: 'Todas' },
    { k: 'cc',    i: 2, col: 'SETOR',           tit: 'Setor Trabalho', nome: 'Setor',             todos: 'Todos' },
    { k: 'loc',   i: 3, col: 'LOCAL',           tit: 'Local Trabalho', nome: 'Local de trabalho', todos: 'Todos' },
    { k: 'car',   i: 4, col: 'CARGO',           tit: 'Cargo',          nome: 'Cargo',             todos: 'Todos' },
    { k: 'idade', i: 5, col: null,              tit: null,             nome: 'Faixa de idade',    todos: 'Todas' }
  ];
  var DIM = {}; DIMS.forEach(function (x) { DIM[x.k] = x; });
  var POR_PADRAO = 'cc';

  /* as DUAS réguas: a ordem é a ordem na tela */
  var HOJE = [
    { k: 'exame',  cor: 'vermelho', ic: 'exame',    diz: 'Exame vencido',              alerta: true },
    { k: 'vence',  cor: 'ambar',    ic: 'relogio',  diz: 'Exame vence em ' + VENCE + ' dias' },
    { k: 'afast',  cor: 'roxo',     ic: 'cama',     diz: 'Afastados hoje' },
    { k: 'inss',   cor: 'vermelho', ic: 'inss',     diz: INSS + ' dias de atestado (INSS)', alerta: true },
    { k: 'estab',  cor: 'verde',    ic: 'escudo',   diz: 'Estabilidade por acidente' },
    { k: 'vacina', cor: 'rosa',     ic: 'seringa',  diz: 'Vacina atrasada' },
    { k: 'restr',  cor: 'roxo',     ic: 'aviso',    diz: 'Restrição ou doença em aberto' }
  ];
  var PERIODO = [
    { k: 'abs',     cor: 'roxo',     ic: 'pessoas',  diz: 'Absenteísmo por doença' },
    { k: 'atest',   cor: 'ambar',    ic: 'documento', diz: 'Atestados' },
    { k: 'acid',    cor: 'vermelho', ic: 'alerta',   diz: 'Acidentes' },
    { k: 'semacid', cor: 'verde',    ic: 'escudo',   diz: 'Dias sem acidente', fixo: true },
    { k: 'exames',  cor: 'roxo',     ic: 'frasco',   diz: 'Exames feitos' },
    { k: 'cons',    cor: 'rosa',     ic: 'estetoscopio', diz: 'Atendimentos' }
  ];
  var NUM = {}; HOJE.concat(PERIODO).forEach(function (x) { NUM[x.k] = x; });

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    exame: '<path d="M9 3.5h6M10 3.5v5.2L5.1 17.3A2 2 0 0 0 6.8 20.3h10.4a2 2 0 0 0 1.7-3L14 8.7V3.5"/><path d="M7.4 14h9.2"/>',
    frasco: '<path d="M9 3.5h6M10 3.5v5.2L5.1 17.3A2 2 0 0 0 6.8 20.3h10.4a2 2 0 0 0 1.7-3L14 8.7V3.5"/><path d="M7.4 14h9.2"/>',
    relogio: '<circle cx="12" cy="13" r="7.5"/><path d="M12 9v4l2.5 1.5M9.5 3h5"/>',
    cama: '<path d="M3 18.5V6M3 14h18v4.5M21 14v-2.5a3 3 0 0 0-3-3h-7V14"/><circle cx="7" cy="10.5" r="2"/>',
    inss: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4M8 13.5h3M8 16.5h6"/>',
    escudo: '<path d="M12 3.5 5 6.5v5c0 4.3 3 7.9 7 9 4-1.1 7-4.7 7-9v-5z"/><path d="M9 12l2.2 2.2L15.5 10"/>',
    seringa: '<path d="M14.5 3.5l6 6M17.5 6.5l-9 9-3-3 9-9M8.5 15.5l-5 5M10 9l2 2M12.5 6.5l2 2"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>',
    alerta: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    documento: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h6"/>',
    estetoscopio: '<path d="M6 4v5a4 4 0 0 0 8 0V4"/><path d="M10 13v2a4.5 4.5 0 0 0 9 0v-1.5"/><circle cx="19" cy="12" r="1.8"/>',
    historico: '<rect x="5.5" y="5" width="13" height="15.5" rx="2"/><path d="M9 5V3.5h6V5M8.5 10.5h7M8.5 14h7M8.5 17.5h4"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    tirar: '<path d="M7 7l10 10M17 7 7 17"/>',
    filtro: '<path d="M4 5.5h16l-6.2 7.3v5.4l-3.6 1.8v-7.2z"/>',
    marca: '<path d="M5 12.5l4.2 4.2L19 7"/>',
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
  function pct(a, b, casas) {
    if (!b) return '0%';
    var v = a / b * 100;
    if (v > 0 && v < (casas ? .1 : 1)) return '&lt;' + (casas ? '0,1' : '1') + '%';
    return v.toLocaleString('pt-BR', { maximumFractionDigits: casas || 0 }) + '%';
  }
  /* quanto tempo: 12 dias · 3 meses · 2 anos e 4 meses */
  function quanto(n) {
    n = Math.abs(n);
    if (n >= 365) { var a = Math.floor(n / 365.25), m = Math.floor((n - a * 365.25) / 30.44); return a + (a === 1 ? ' ano' : ' anos') + (m > 0 && a < 3 ? ' e ' + m + (m === 1 ? ' mês' : ' meses') : ''); }
    if (n >= 60) return Math.floor(n / 30.44) + ' meses';
    return n + (n === 1 ? ' dia' : ' dias');
  }
  function faixaIdade(i) { return i == null || i < 14 || i > 100 ? 5 : i < 25 ? 0 : i < 35 ? 1 : i < 45 ? 2 : i < 55 ? 3 : 4; }
  function capitulo(cid) {
    var c = String(cid || '').toUpperCase().replace(/[^A-Z0-9]/g, '').slice(0, 3);
    if (!/^[A-Z]\d\d$/.test(c)) return null;
    for (var i = 0; i < CAPS.length; i++) if (c >= CAPS[i][0] && c <= CAPS[i][1]) return i;
    return null;
  }
  function primeiro(t) { return partes(t)[1] || t; }

  /* ═══ [S2] OS DADOS ═════════════════════════════════════════════════════════════════════
     CUIDADO  Os filtros da página vão com a chamada (pageItems); as datas do painel em x01/x02.
     O resultado fica guardado na ABA (sessionStorage) por 10 min, por filtros + datas.
     Datas chegam como DIAS a partir de hoje (hoje = 0, ontem = -1): "rel" abaixo.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function valor(i) { try { return apex.item(i).getValue() || ''; } catch (e) { return ''; } }
  function chaveCache() { return 'nc-sp-dados1:' + P.ini + '|' + P.fim + '|' + ITENS.map(function (i) { return document.getElementById(i) ? valor(i) : ''; }).join('|'); }
  function buscar(forcar) {
    var k = chaveCache(), c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && c && c.d && Date.now() - c.t < VALIDADE) { desenhar(c.d, c.t); return; }
    carregando();
    var itens = ITENS.filter(function (i) { return document.getElementById(i); }).map(function (i) { return '#' + i; }).join(',');
    var pedido = ++P.pedido;
    apex.server.process(PROCESSO, { pageItems: itens, x01: P.ini, x02: P.fim }, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        if (pedido !== P.pedido) return;
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      .fail(function (x) { if (pedido !== P.pedido) return; pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* o PREPARO: cada pessoa ganha as contas dela (uma vez por dado; os filtros só escolhem quem entra) */
  function preparar(d) {
    var hoje = data(d.hoje) || new Date(), ini = data(d.ini), fim = data(d.fim);
    var dIni = dias(hoje, ini), dFim = dias(hoje, fim), fimEf = Math.min(dFim, 0), Lef = fimEf >= dIni ? fimEf - dIni + 1 : 0;
    var cat = d.cat || {}, nomesSit = cat.sit || [], acid = d.acid || ',';
    var meses = (d.meses || []).map(function (m) { return { k: m, d: new Date(+m.slice(0, 4), +m.slice(4, 6) - 1, 1) }; });
    var mesDe = {}; meses.forEach(function (m, i) { mesDe[m.k] = i; });
    function rel(n) { return n == null ? null : mais(hoje, n); }
    function chaveMes(n) { var x = rel(n); return x.getFullYear() + ('0' + (x.getMonth() + 1)).slice(-2); }
    var sitAf = nomesSit.map(function (t) { var c = partes(t)[0]; return acid.indexOf(',' + c + ',') >= 0 ? 'acid' : AFASTA.test(t) && !NAO_AFASTA.test(t) ? 'afast' : ''; });
    var resRuim = (cat.res || []).map(function (t) { return INAPTO.test(t) ? 'inapto' : ALTERADO.test(t) ? 'alterado' : ''; });
    var ps = (d.pes || []).map(function (r, i) {
      return { i: i, k: [r[0], r[1], r[2], r[3], r[4], faixaIdade(r[5])], nome: (d.nomes || [])[i] || '', idade: r[5], sit: r[6], ultEx: r[7], nEx: r[8] || 0,
               ex: [], venc: [], v30: [], xf: [], nXf: 0, inapto: 0, alterado: 0, at: [], dz: [], vc: [], vAtr: [], v30v: [], rs: '', ac: [], cs: 0, csM: {}, es: null,
               perdidos: 0, nAt: 0, inss: 0, inssCap: 0, afastAt: null, afastAtD: null, atM: {}, atMn: {} };
    });
    (d.ex || []).forEach(function (r) {
      var p = ps[r[0]]; if (!p) return;
      var e = { e: r[1], ult: r[2], prox: r[3] };
      p.ex.push(e);
      if (e.prox < 0) p.venc.push(e); else if (e.prox <= VENCE) p.v30.push(e);
    });
    (d.xf || []).forEach(function (r) {
      var p = ps[r[0]]; if (!p) return;
      p.xf.push({ m: r[1], tipo: r[2], res: r[3], n: r[4] }); p.nXf += r[4];
      if (resRuim[r[3]] === 'inapto') p.inapto += r[4]; else if (resRuim[r[3]] === 'alterado') p.alterado += r[4];
    });
    (d.at || []).forEach(function (r) {
      var p = ps[r[0]]; if (!p) return;
      var a = { ini: r[1], fim: r[2], dias: r[3], min: r[4], cid: r[5], tat: r[6], ocup: r[7] === 'S', dt: r[8] };
      if (a.ini == null) return;
      /* os dias do atestado: o término, ou a quantidade de dias; sem nenhum dos dois, é de horas (0 dia) */
      var n = a.fim != null ? Math.max(0, a.fim - a.ini + 1) : (a.dias > 0 ? a.dias : 0);
      if (a.fim == null) a.fim = a.ini + Math.max(n, 1) - 1;
      a.n = n;
      a.cap = a.cid >= 0 ? capitulo(partes((cat.cid || [])[a.cid])[0] || (cat.cid || [])[a.cid]) : null;
      p.at.push(a);
      if (a.ini >= dIni && a.ini <= dFim) {
        p.nAt++;
        var mk = mesDe[chaveMes(a.ini)]; if (mk != null) p.atMn[mk] = (p.atMn[mk] || 0) + 1;
      }
      if (n > 0) {
        /* dias perdidos no período (até hoje), mês a mês */
        var a0 = Math.max(a.ini, dIni), a1 = Math.min(a.fim, fimEf);
        for (var x = a0; x <= a1; x++) { p.perdidos++; var mi = mesDe[chaveMes(x)]; if (mi != null) p.atM[mi] = (p.atM[mi] || 0) + 1; }
        a.perd = Math.max(0, a1 - a0 + 1);
        /* afastado hoje por atestado */
        if (a.ini <= 0 && a.fim >= 0) { if (p.afastAt == null || a.fim > p.afastAt) { p.afastAt = a.fim; p.afastAtD = a; } }
        /* a regra do INSS: dias de atestado nos últimos 60 dias (o atual conta inteiro) */
        if (a.fim >= -60 && a.ini <= 0) { var dd = a.fim - Math.max(a.ini, -60) + 1; p.inss += dd; a.inss = dd; }
      }
    });
    ps.forEach(function (p) {
      var porCap = {};
      p.at.forEach(function (a) { if (a.inss && a.cap != null) porCap[a.cap] = (porCap[a.cap] || 0) + a.inss; });
      Object.keys(porCap).forEach(function (c) { if (porCap[c] > p.inssCap) { p.inssCap = porCap[c]; p.inssCapK = +c; } });
    });
    (d.dz || []).forEach(function (r) { var p = ps[r[0]]; if (p) p.dz.push({ cid: r[1], ini: r[2] }); });
    (d.vc || []).forEach(function (r) {
      var p = ps[r[0]]; if (!p) return;
      var v = { v: r[1], ult: r[2], prox: r[3], dose: r[4] };
      p.vc.push(v); if (v.prox < 0) p.vAtr.push(v); else p.v30v.push(v);
    });
    (d.rs || []).forEach(function (r) { var p = ps[r[0]]; if (p) p.rs = r[1]; });
    (d.ac || []).forEach(function (r) {
      var p = ps[r[0]]; if (!p) return;
      p.ac.push({ d: r[1], tipo: r[2], cls: r[3], afast: r[4] === 'S', dias: r[5], cid: r[6], m: mesDe[chaveMes(r[1])] });
    });
    (d.cs || []).forEach(function (r) { var p = ps[r[0]]; if (!p) return; p.cs += r[2]; p.csM[r[1]] = (p.csM[r[1]] || 0) + r[2]; });
    (d.es || []).forEach(function (r) { var p = ps[r[0]]; if (p) p.es = { volta: r[1], ate: r[2], sit: r[3] }; });
    ps.forEach(function (p) {
      p.nunca = !p.nEx;
      p.atraso = p.venc.length > 0 || p.nunca;
      p.atrasoMax = p.venc.reduce(function (a, e) { return Math.max(a, -e.prox); }, 0);
      p.v30min = p.v30.reduce(function (a, e) { return Math.min(a, e.prox); }, 999);
      p.afastSit = p.sit >= 0 ? sitAf[p.sit] : '';
      p.afast = p.afastAt != null || !!p.afastSit;
      p.nAc = p.ac.length; p.nAcAf = p.ac.filter(function (a) { return a.afast; }).length;
      p.diasAc = p.ac.reduce(function (s, a) { return s + (a.dias || 0); }, 0);
    });
    return { hoje: hoje, ini: ini, fim: fim, dIni: dIni, dFim: dFim, Lef: Lef, meses: meses, cat: cat, ps: ps, ua: d.ua || [null, null], rel: rel, resRuim: resRuim };
  }

  /* ═══ [S3] A MOLDURA E O PERÍODO ════════════════════════════════════════════════════════ */
  var P = null;
  function montar() {
    if (P) return true;
    var ir = document.getElementById(IR_ID);
    if (!ir) return false;
    var caixa = el('section', 'nc-af nc-pp nc-sp');
    caixa.setAttribute('aria-labelledby', 'nc-sp-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-sp-titulo">Saúde e segurança do trabalho</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a lista</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-esconde aria-controls="nc-sp-corpo"></button></header>' +
      '<div class="nc-pp-datas" role="group" aria-label="Período do resumo"></div>' +
      '<div class="nc-pp-corpo" id="nc-sp-corpo"></div>';
    ir.parentNode.insertBefore(caixa, ir);
    var hoje = new Date(); hoje.setHours(0, 0, 0, 0);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-pp-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-af-esconde]'),
          datas: caixa.querySelector('.nc-pp-datas'), hoje: hoje, filtro: null, f: {}, por: POR_PADRAO, met: 'atraso', serie: 'dias', faixa: 'v90',
          cidVer: 'cid', escolha: null, pedido: 0, zoom: null };
    var a = doze(hoje); P.ini = texto(a[0]); P.fim = texto(a[1]);
    try { var por = localStorage.getItem(GUARDA_POR); if (DIM[por]) P.por = por; } catch (e) { /* ok */ }
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '0'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    desenharDatas();
    caixa.addEventListener('click', clique);
    caixa.addEventListener('change', mudou);
    caixa.addEventListener('keydown', teclas);
    return true;
  }
  function mesDe(d, desloca) { var a = new Date(d.getFullYear(), d.getMonth() + desloca, 1); return [a, new Date(a.getFullYear(), a.getMonth() + 1, 0)]; }
  function doze(h) { return [new Date(h.getFullYear(), h.getMonth() - 11, 1), new Date(h.getFullYear(), h.getMonth() + 1, 0)]; }
  /* a BARRA DO PERÍODO: atalhos e De/Até (fica fora do corpo: não some ao recalcular) */
  function atalhos() {
    var h = P.hoje;
    return [
      { k: 'doze', t: 'Últimos 12 meses', d: doze(h) },
      { k: 'ano', t: 'Este ano', d: [new Date(h.getFullYear(), 0, 1), new Date(h.getFullYear(), 11, 31)] },
      { k: 'tres', t: 'Últimos 3 meses', d: [new Date(h.getFullYear(), h.getMonth() - 2, 1), new Date(h.getFullYear(), h.getMonth() + 1, 0)] },
      { k: 'mes', t: 'Este mês', d: mesDe(h, 0) }
    ];
  }
  function desenharDatas() {
    var ini = data(P.ini), fim = data(P.fim);
    P.datas.innerHTML = '<span class="nc-pp-datas-rot">' + ic('calendario') + 'Período</span>' +
      '<div class="nc-pp-atalhos" role="group" aria-label="Atalhos de período">' + atalhos().map(function (a) {
        var on = texto(a.d[0]) === P.ini && texto(a.d[1]) === P.fim;
        return '<button type="button" class="nc-pp-atalho' + (on ? ' is-on' : '') + '" data-pp-atalho="' + a.k + '" aria-pressed="' + on + '">' + a.t + '</button>';
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
    if (corte) msgDatas('O resumo vai até 2 anos de cada vez: ficou de ' + texto(a) + ' a ' + texto(b) + '.');
    buscar();
  }
  function msgDatas(t) { var m = P.datas.querySelector('.nc-pp-datas-msg'); if (m) m.textContent = t; }
  function abrirFechar(aberto) {
    fecharLista(false);
    P.caixa.classList.toggle('is-fechado', !aberto);
    P.botao.setAttribute('aria-expanded', String(aberto));
    P.botao.innerHTML = ic(aberto ? 'fechar' : 'abrir') + '<span>' + (aberto ? 'Mostrar menos' : 'Ver análise completa') + '</span>';
    try { if (aberto) localStorage.setItem(GUARDA, '0'); else localStorage.removeItem(GUARDA); } catch (e) { /* ok */ }
    if (aberto) setTimeout(ajustarMeses, 0);
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-af-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-pp-atalho')) { var a = atalhos().filter(function (x) { return x.k === b.getAttribute('data-pp-atalho'); })[0]; if (a) usarPeriodo(a.d[0], a.d[1]); return; }
    if (b.hasAttribute('data-pp-aplica')) { usarPeriodo(deIso(P.datas.querySelector('[data-pp-ini]').value), deIso(P.datas.querySelector('[data-pp-fim]').value)); return; }
    if (b.hasAttribute('data-af-num')) { var k = b.getAttribute('data-af-num'); P.filtro = P.filtro === k ? null : k; desenharNums(); return; }
    if (b.hasAttribute('data-sp-esc')) { var v = b.getAttribute('data-sp-esc'); P.escolha = P.escolha === v ? null : v; desenharQuadros({ attr: 'data-sp-esc', v: v }); return; }
    if (b.hasAttribute('data-pp-seg')) {
      var sg = b.getAttribute('data-pp-seg'), sv = b.getAttribute('data-pp-v');
      P[sg] = sv;
      /* as causas são somadas no agregar(): trocar CID/grupo refaz o resumo; o resto só redesenha os quadros */
      if (sg === 'cidVer') { P.escolha = null; redesenhar({ attr: 'data-pp-v', v: sv }); } else desenharQuadros({ attr: 'data-pp-v', v: sv });
      return;
    }
    if (b.hasAttribute('data-pp-zoom')) { abrirZoom(b.getAttribute('data-pp-zoom'), b); return; }
    if (b.hasAttribute('data-pp-zoom-fecha')) { fecharZoom(); return; }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-af-filtra')) { alternar(b.getAttribute('data-af-filtra'), b.getAttribute('data-af-valor')); return; }
    if (b.hasAttribute('data-af-tira')) { tirarFiltro(b.getAttribute('data-af-tira')); return; }
    if (b.hasAttribute('data-af-limpa')) { limparFiltros(); return; }
    if (b.hasAttribute('data-af-abre')) { var ab = b.getAttribute('data-af-abre'); if (P.pop && P.pop.k === ab) fecharLista(true); else abrirLista(ab); return; }
    if (b.hasAttribute('data-af-pronto')) { fecharLista(true); return; }
    if (b.hasAttribute('data-af-pop-limpa')) { delete P.f[P.pop.k]; redesenhar({ pop: true }); marcarLista(); return; }
    if (b.hasAttribute('data-sp-hist')) { abrirHistorico(+b.getAttribute('data-sp-hist'), b); return; }
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
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">Para agir hoje</p>' + esqueleto(HOJE) + '</div>' +
      '<div class="nc-af-secao nc-pp-gestao"><p class="nc-af-rot">No período</p>' + esqueleto(PERIODO) + '</div>' +
      '<div class="nc-af-secao nc-af-periodo"><i class="nc-af-esq" style="width:60%;height:16px"></i><div class="nc-af-quadros nc-af-quadros--3" style="margin-top:14px">' +
      '<div class="nc-af-q nc-pp-q--largo" style="height:300px"></div><div class="nc-af-q" style="height:300px"></div></div></div>';
    P.caixa.querySelector('[data-af-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(['Lendo os exames, atestados e vacinas…', 'Conferindo vencimentos e afastamentos…', 'Somando acidentes e atendimentos…', 'Ainda calculando: com muitos colaboradores leva mais tempo']);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_SAUDE|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia SAUDEPAINEL-MANUTENCAO.md).'
             : 'A lista abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }
  function cabecalho() {
    var X = P.X, A = P.A, n = Object.keys(A.fi).length;
    P.quando.innerHTML = 'De <b>' + texto(X.ini) + ' a ' + texto(X.fim) + '</b> · ' + plural(A.ps.length, 'colaborador', 'colaboradores') +
      (n ? ' · <b>' + plural(n, 'filtro', 'filtros') + ' deste resumo</b>' : '') + (P.hm ? ' · calculado às ' + P.hm : '');
  }

  /* ═══ [S4] OS NÚMEROS ═══════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    P.dados = d; P.X = preparar(d); P.filtro = null; P.escolha = null;
    P.dims = {}; Object.keys(d.dims || {}).forEach(function (k) { P.dims[k] = d.dims[k]; }); P.dims.idade = FAIXAS_IDADE;
    P.hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.caixa.querySelector('[data-af-atualiza]').hidden = false;
    desenharDatas();
    if (d.cortouDias) msgDatas('O resumo vai até 2 anos de cada vez: ficou até ' + d.fim + '.');
    P.corpo.innerHTML =
      '<div class="nc-af-filtros" role="group" aria-label="Filtrar este resumo" hidden></div>' +
      '<div class="nc-af-secao"><p class="nc-af-rot">Para agir hoje <span class="nc-sp-rot-nota">a situação de hoje, em qualquer período</span></p>' +
        '<div class="nc-af-regua nc-sp-regua-hoje" role="group" aria-label="Para agir hoje"></div></div>' +
      '<div class="nc-af-secao nc-pp-gestao"><p class="nc-af-rot">No período <span class="nc-sp-rot-nota">' + curta(P.X.ini) + ' a ' + texto(P.X.fim) + '</span></p>' +
        '<div class="nc-af-regua nc-sp-regua-per" role="group" aria-label="Indicadores do período"></div><p class="nc-pp-base" hidden></p></div>' +
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
      var x = a[h.k], on = P.filtro === h.k, vazio = !x.n, tag = h.fixo ? 'div' : 'button';
      return '<' + tag + (h.fixo ? '' : ' type="button"') + ' class="nc-af-num nc-af-num--' + h.cor + (vazio ? ' is-zero' : '') + ((h.alerta && x.n) || x.alerta ? ' is-alerta' : '') + (h.fixo ? ' nc-sp-num--fixo' : '') + '"' +
        (h.fixo ? '' : ' data-af-num="' + h.k + '" aria-pressed="' + on + '" aria-controls="nc-af-quem"' + (vazio ? ' disabled' : '')) + (x.dicaLonga ? ' title="' + esc(x.dicaLonga) + '"' : '') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor' + (x.texto ? ' is-texto' : '') + '">' + x.v + '<small>' + x.u + '</small></span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + x.dica + '</span></' + tag + '>';
    }).join('');
  }
  function desenharNums() {
    regua(HOJE, P.caixa.querySelector('.nc-sp-regua-hoje'));
    regua(PERIODO, P.caixa.querySelector('.nc-sp-regua-per'));
    var base = P.caixa.querySelector('.nc-pp-base');
    base.hidden = !P.A.nota; base.innerHTML = P.A.nota || '';
    desenharQuem(P.caixa.querySelector('#nc-af-quem'), P.filtro ? daLista(P.filtro) : null);
  }
  /* nomes dos catálogos */
  function nomeCat(c, i) { return i == null || i < 0 ? '' : ((P.X.cat[c] || [])[i] || ''); }
  function exameCurto(i) { return primeiro(nomeCat('ex', i)); }
  function dataRel(n) { return texto(P.X.rel(n)); }
  function listaCurta(xs, n) { var t = xs.slice(0, n || 2), r = xs.length - t.length; return t.join(' · ') + (r > 0 ? ' · e mais ' + r : ''); }
  /* quem entra em cada número, em que ordem, e o que a linha diz */
  function daLista(k) {
    var ps = P.A.ps.slice(), L = { tit: NUM[k].diz, ordem: '', xs: [] };
    function ord(f, g) { return ps.filter(f).sort(g); }
    if (k === 'exame') {
      L.ordem = 'quem está há mais tempo vencido primeiro; depois, quem não tem exame registrado';
      L.xs = ord(function (p) { return p.atraso; }, function (x, y) { return (y.venc.length ? 1 : 0) - (x.venc.length ? 1 : 0) || y.atrasoMax - x.atrasoMax; })
        .map(function (p) {
          if (!p.venc.length) return { p: p, diz: 'Nenhum exame registrado', cor: 'ambar' };
          var xs = p.venc.slice().sort(function (a, b) { return a.prox - b.prox; }).map(function (e) { return '<b>' + esc(exameCurto(e.e)) + '</b> venceu há ' + quanto(e.prox) + ' (' + dataRel(e.prox) + ')'; });
          return { p: p, diz: listaCurta(xs), html: true, cor: 'vermelho' };
        });
    } else if (k === 'vence') {
      L.ordem = 'quem vence primeiro';
      L.xs = ord(function (p) { return p.v30.length; }, function (x, y) { return x.v30min - y.v30min; })
        .map(function (p) {
          var xs = p.v30.slice().sort(function (a, b) { return a.prox - b.prox; }).map(function (e) { return '<b>' + esc(exameCurto(e.e)) + '</b> ' + (e.prox ? 'vence em ' + quanto(e.prox) : 'vence hoje') + ' (' + dataRel(e.prox) + ')'; });
          return { p: p, diz: listaCurta(xs), html: true, cor: 'ambar' };
        });
    } else if (k === 'afast') {
      L.ordem = 'quem volta por último primeiro';
      L.xs = ord(function (p) { return p.afast; }, function (x, y) { return (y.afastAt == null ? 9999 : y.afastAt) - (x.afastAt == null ? 9999 : x.afastAt); })
        .map(function (p) {
          var t = [];
          if (p.afastAt != null) { var a = p.afastAtD, cid = nomeCat('cid', a.cid); t.push('Atestado até <b>' + dataRel(p.afastAt) + '</b> (' + plural(a.n, 'dia', 'dias') + ')' + (cid ? ' · ' + esc(partes(cid)[0]) : '')); }
          if (p.afastSit) t.push('Situação: ' + esc(nomeCat('sit', p.sit)));
          return { p: p, diz: t.join(' · '), html: true, cor: 'roxo' };
        });
    } else if (k === 'inss') {
      L.ordem = 'quem tem mais dias primeiro · entram também os que chegam perto (' + INSS_PERTO + ' a ' + INSS + ' dias)';
      L.xs = ord(function (p) { return p.inss >= INSS_PERTO; }, function (x, y) { return y.inss - x.inss; })
        .map(function (p) {
          var cap = p.inssCap && p.inssCapK != null ? ' · ' + plural(p.inssCap, 'dia', 'dias') + ' no mesmo grupo (' + CAPS[p.inssCapK][2].toLowerCase() + ')' : '';
          return { p: p, diz: '<b>' + plural(p.inss, 'dia', 'dias') + '</b> de atestado em 60 dias' + (p.inss > INSS ? ' · <b>passou de ' + INSS + ': o 16º dia em diante é do INSS</b>' : ' · perto do limite') + cap, html: true, cor: p.inss > INSS ? 'vermelho' : 'ambar' };
        });
    } else if (k === 'estab') {
      L.ordem = 'quem termina a estabilidade primeiro';
      L.xs = ord(function (p) { return p.es; }, function (x, y) { return x.es.ate - y.es.ate; })
        .map(function (p) { return { p: p, diz: 'Estável até <b>' + dataRel(p.es.ate) + '</b> · voltou do afastamento por acidente em ' + dataRel(p.es.volta) + ' · não pode ser demitido sem justa causa', html: true, cor: 'verde' }; });
    } else if (k === 'vacina') {
      L.ordem = 'quem tem a dose mais atrasada primeiro';
      L.xs = ord(function (p) { return p.vAtr.length; }, function (x, y) { return Math.min.apply(null, x.vAtr.map(function (v) { return v.prox; })) - Math.min.apply(null, y.vAtr.map(function (v) { return v.prox; })); })
        .map(function (p) {
          var xs = p.vAtr.map(function (v) { return '<b>' + esc(primeiro(nomeCat('vac', v.v))) + '</b>: próxima dose desde ' + dataRel(v.prox); });
          return { p: p, diz: listaCurta(xs), html: true, cor: 'rosa' };
        });
    } else if (k === 'restr') {
      L.ordem = 'restrições primeiro';
      L.xs = ord(function (p) { return p.rs || p.dz.length; }, function (x, y) { return (y.rs ? 1 : 0) - (x.rs ? 1 : 0); })
        .map(function (p) {
          var t = [];
          if (p.rs) t.push('<b>Restrição:</b> ' + esc(p.rs.length > 140 ? p.rs.slice(0, 140) + '…' : p.rs));
          p.dz.forEach(function (z) { t.push('<b>' + esc(nomeCat('cid', z.cid) || 'Doença sem CID') + '</b> desde ' + (z.ini != null ? dataRel(z.ini) : '?') + ', sem término'); });
          return { p: p, diz: listaCurta(t, 2), html: true, cor: p.rs ? 'vermelho' : 'ambar' };
        });
    } else if (k === 'abs' || k === 'atest') {
      L.ordem = 'quem perdeu mais dias primeiro';
      L.xs = ord(function (p) { return k === 'abs' ? p.perdidos : p.nAt; }, function (x, y) { return y.perdidos - x.perdidos || y.nAt - x.nAt; })
        .map(function (p) {
          var cids = {}; p.at.forEach(function (a) { if (a.perd && a.cid >= 0) cids[a.cid] = (cids[a.cid] || 0) + a.perd; });
          var top = Object.keys(cids).sort(function (a, b) { return cids[b] - cids[a]; })[0];
          return { p: p, diz: '<b>' + plural(p.perdidos, 'dia perdido', 'dias perdidos') + '</b> · ' + plural(p.nAt, 'atestado', 'atestados') + (top != null ? ' · mais por ' + esc(nomeCat('cid', +top)) : ''), html: true, cor: 'vermelho' };
        });
    } else if (k === 'acid') {
      L.ordem = 'os mais recentes primeiro';
      L.xs = ord(function (p) { return p.nAc; }, function (x, y) { return Math.max.apply(null, y.ac.map(function (a) { return a.d; })) - Math.max.apply(null, x.ac.map(function (a) { return a.d; })); })
        .map(function (p) {
          var xs = p.ac.slice().sort(function (a, b) { return b.d - a.d; }).map(function (a) { return dataRel(a.d) + ' · <b>' + (TIPO_ACID[a.tipo] || 'Acidente') + '</b>' + (a.afast ? ' · afastado' + (a.dias ? ' ' + plural(a.dias, 'dia', 'dias') : '') : ' · sem afastamento'); });
          return { p: p, diz: listaCurta(xs), html: true, cor: p.nAcAf ? 'vermelho' : 'ambar' };
        });
    } else if (k === 'exames') {
      L.ordem = 'inaptos e alterados primeiro';
      L.xs = ord(function (p) { return p.nXf; }, function (x, y) { return y.inapto - x.inapto || y.alterado - x.alterado || y.nXf - x.nXf; })
        .map(function (p) {
          var tipos = {}; p.xf.forEach(function (x) { tipos[x.tipo] = (tipos[x.tipo] || 0) + x.n; });
          var t = Object.keys(tipos).map(function (k2) { return (TIPO_EXAME[k2] || k2 || 'Sem tipo').toLowerCase() + ' ' + tipos[k2]; }).join(' · ');
          return { p: p, diz: (p.inapto ? '<b>' + plural(p.inapto, 'resultado inapto', 'resultados inaptos') + '</b> · ' : '') + (p.alterado ? '<b>' + plural(p.alterado, 'alterado', 'alterados') + '</b> · ' : '') + plural(p.nXf, 'exame', 'exames') + ': ' + esc(t), html: true, cor: p.inapto ? 'vermelho' : p.alterado ? 'ambar' : '' };
        });
    } else if (k === 'cons') {
      L.ordem = 'quem foi mais vezes primeiro';
      L.xs = ord(function (p) { return p.cs; }, function (x, y) { return y.cs - x.cs; })
        .map(function (p) { return { p: p, diz: plural(p.cs, 'atendimento', 'atendimentos') + ' no período' }; });
    }
    return L;
  }
  function desenharQuem(box, L, grande) {
    if (!box) return;
    if (!L) { box.hidden = true; box.innerHTML = ''; return; }
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + esc(L.tit) + ': ' + plural(L.xs.length, 'pessoa', 'pessoas') + '</h3><p>' + L.ordem +
      ' · toque em <b>Abrir o histórico</b> para ver e lançar exames, atestados e vacinas</p>' +
      (L.xs.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome, cargo ou setor" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      (L.xs.length ? rolo('ul', 'nc-af-lista', L.xs.map(function (x) {
        var p = x.p, cargo = primeiro((P.dims.car || [])[p.k[4]]), setor = primeiro((P.dims.cc || [])[p.k[2]]);
        return '<li data-af-texto="' + esc(semAcento([p.nome, cargo, setor].join(' '))) + '"><div class="nc-af-p nc-pp-linha">' +
          '<span class="nc-af-p-quem"><b>' + esc(p.nome) + '</b><span>' + esc(cargo) + (setor ? ' · ' + esc(setor) : '') + (p.idade ? ' · ' + p.idade + ' anos' : '') + '</span></span>' +
          '<span class="nc-pp-p-diz' + (x.cor ? ' nc-pp-p-diz--' + x.cor : '') + '">' + (x.html ? x.diz : esc(x.diz)) + '</span>' +
          botaoHist(p, true) + '</div></li>';
      }), grande ? 400 : POR_VEZ, 'pessoas') : '<p class="nc-af-vazio-q">Ninguém com estes filtros.</p>');
    ligarRolos(box);
    var pr = box.querySelector('[data-af-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value, L, grande); });
  }
  function botaoHist(p, comTexto) {
    var nm = esc(primeiro(p.nome));
    return comTexto ? '<button type="button" class="nc-pp-abre" data-sp-hist="' + p.i + '" title="Abrir o histórico de ' + nm + ' (exames, atestados, vacinas, acidentes)">' + ic('historico') + '<span>Abrir o histórico</span></button>'
      : '<button type="button" class="nc-af-b-tab" data-sp-hist="' + p.i + '" title="Abrir o histórico de ' + nm + '" aria-label="Abrir o histórico de ' + nm + '">' + ic('historico') + '</button>';
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

  /* ═══ [S5] OS QUADROS ═══════════════════════════════════════════════════════════════════ */
  function desenharPeriodo() {
    var A = P.A, box = P.caixa.querySelector('.nc-af-periodo'); if (!box) return;
    var t = A.tot, frase;
    if (!A.ps.length) frase = '<p class="nc-af-frase">Ninguém' + (A.filtrado ? ' com os filtros deste resumo' : ' nesta lista') + '.</p>';
    else {
      frase = '<p class="nc-af-frase"><b>' + pct(A.ps.length - t.atraso, A.ps.length) + '</b> dos colaboradores estão com os exames em dia' +
        (t.atraso ? ' (<b>' + plural(t.atraso, 'pessoa', 'pessoas') + '</b> com exame vencido ou sem exame)' : '') + '.' +
        (t.nAt || t.nAc ? '<span class="nc-af-taxa">No período: <b>' + plural(t.nAt, 'atestado', 'atestados') + '</b> somando <b>' + plural(t.perdidos, 'dia perdido', 'dias perdidos') + '</b>' +
          (t.topCap != null ? ', a maior parte por <b>' + CAPS[t.topCap][2].toLowerCase() + '</b>' : '') + '; <b>' + plural(t.nAc, 'acidente', 'acidentes') + '</b>' +
          (t.nAc ? ' (' + plural(t.nAcAf, 'com afastamento', 'com afastamento') + ')' : '') + '.</span>' : '') + '</p>';
    }
    box.innerHTML = '<p class="nc-af-rot">No período · ' + curta(P.X.ini) + ' a ' + texto(P.X.fim) + '</p>' + frase +
      (A.ps.length ? '<div class="nc-af-quadros nc-af-quadros--3 nc-pp-quadros"></div><div class="nc-af-quem nc-pp-quem--ev" id="nc-sp-quem-esc" hidden aria-live="polite"></div>' : '');
    desenharQuadros();
  }
  var QUADROS = ['meses', 'pcmso', 'causas', 'onde', 'acidentes', 'vacinas'];
  function desenharQuadros(foco) {
    var box = P.caixa.querySelector('.nc-pp-quadros');
    if (box) {
      box.innerHTML = QUADROS.map(function (q) { return quadro(q, false); }).join('');
      ligarRolos(box);
      ajustarMeses();
      desenharQuemEsc(P.caixa.querySelector('.nc-af-periodo .nc-pp-quem--ev'), false);
    }
    if (P.zoom) desenharZoom();
    if (foco) refocar(foco);
  }
  var SERIES = [['dias', 'Dias perdidos'], ['atest', 'Atestados'], ['acid', 'Acidentes'], ['exames', 'Exames feitos'], ['cons', 'Atendimentos']];
  function quadro(q, grande) {
    var Q;
    if (q === 'meses') Q = { tit: 'Mês a mês', cls: 'nc-pp-q--largo', extra: seg('serie', SERIES), dica: serieDica(), corpo: mesAMes(grande) };
    else if (q === 'pcmso') Q = { tit: 'Exames periódicos (PCMSO)', dica: 'O último de cada exame, pela data do próximo · toque numa caixa para ver quem', corpo: pcmso(grande) };
    else if (q === 'causas') Q = { tit: 'Causas dos afastamentos', extra: seg('cidVer', [['cid', 'Por CID'], ['grupo', 'Por grupo de doença']]), dica: 'Dias perdidos por atestado no período · toque para ver quem', corpo: causas(grande) };
    else if (q === 'onde') Q = { tit: 'Onde', extra: verPor(), dica: ondeDica(), corpo: ondes(grande) };
    else if (q === 'acidentes') Q = { tit: 'Acidentes do período', dica: 'Pelo tipo e, abaixo, cada acidente, do mais recente', corpo: acidentes(grande) };
    else if (q === 'vacinas') Q = { tit: 'Vacinas', dica: 'A última dose de cada vacina: atrasada ou vencendo em ' + VENCE + ' dias · toque para ver quem', corpo: vacinas(grande) };
    return '<section class="nc-af-q nc-pp-q' + (Q.cls ? ' ' + Q.cls : '') + (grande ? ' is-grande' : '') + '" data-pp-q="' + q + '">' +
      '<div class="nc-pp-q-cab"><h3' + (grande ? ' id="nc-pp-zoom-tit"' : '') + '>' + Q.tit + '</h3>' +
      (grande ? '' : '<button type="button" class="nc-pp-ampliar" data-pp-zoom="' + q + '" title="Ampliar este quadro" aria-label="Ampliar o quadro ' + Q.tit + '">' + ic('ampliar') + '<span>Ampliar</span></button>') + '</div>' +
      (Q.extra || '') + '<p>' + Q.dica + '</p>' + Q.corpo + '</section>';
  }
  function seg(chave, ops) {
    return '<div class="nc-pp-seg" role="group">' + ops.map(function (o) {
      var on = P[chave] === o[0];
      return '<button type="button" class="nc-pp-seg-b' + (on ? ' is-on' : '') + '" data-pp-seg="' + chave + '" data-pp-v="' + o[0] + '" aria-pressed="' + on + '">' + o[1] + '</button>';
    }).join('') + '</div>';
  }
  function linhaBarra(o) {
    var p = partes(o.t);
    return '<span class="nc-af-b-nome">' + (o.sel ? ic('marca') : '') + (o.etq || '') + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
      '<span class="nc-af-b-trilho' + (o.trilho ? ' ' + o.trilho : '') + '" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(o.w)) + '%"></i></span>' +
      '<span class="nc-af-b-num' + (o.numCls ? ' ' + o.numCls : '') + '"' + (o.exato ? ' title="' + esc(o.exato) + '"' : '') + '>' + o.v + '</span>' +
      (o.det ? '<span class="nc-pp-b-det">' + o.det + '</span>' : '');
  }
  /* MÊS A MÊS: uma coluna por mês, a série escolhida */
  function serieDica() {
    return { dias: 'Dias de atestado em cada mês (até hoje)', atest: 'Atestados que começaram em cada mês', acid: 'Acidentes em cada mês', exames: 'Exames feitos em cada mês', cons: 'Atendimentos (consultas) em cada mês' }[P.serie];
  }
  function mesAMes(grande) {
    var X = P.X, v = X.meses.map(function () { return 0; }), s = P.serie;
    P.A.ps.forEach(function (p) {
      if (s === 'dias') Object.keys(p.atM).forEach(function (m) { v[m] += p.atM[m]; });
      else if (s === 'atest') Object.keys(p.atMn).forEach(function (m) { v[m] += p.atMn[m]; });
      else if (s === 'acid') p.ac.forEach(function (a) { if (a.m != null) v[a.m]++; });
      else if (s === 'exames') p.xf.forEach(function (x) { v[x.m] += x.n; });
      else Object.keys(p.csM).forEach(function (m) { v[m] += p.csM[m]; });
    });
    if (!v.some(function (x) { return x; })) return '<p class="nc-af-vazio-q">Nada neste período' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, v) || 1, pico = 0; v.forEach(function (x, i) { if (x > v[pico]) pico = i; });
    var unid = { dias: ['dia perdido', 'dias perdidos'], atest: ['atestado', 'atestados'], acid: ['acidente', 'acidentes'], exames: ['exame', 'exames'], cons: ['atendimento', 'atendimentos'] }[s];
    var tot = v.reduce(function (a, b) { return a + b; }, 0);
    return '<ol class="nc-af-meses nc-pp-dias nc-sp-meses' + (grande ? ' is-grande' : '') + '">' + X.meses.map(function (m, i) {
      var d = m.d, rot = MESES[d.getMonth()] + '/' + d.getFullYear() + ': ' + plural(v[i], unid[0], unid[1]), futuro = d > X.hoje;
      return '<li class="nc-af-mes nc-pp-dia is-marco' + (i === pico && v[i] ? ' is-pico' : '') + (futuro ? ' is-futuro' : '') + (d.getFullYear() === X.hoje.getFullYear() && d.getMonth() === X.hoje.getMonth() ? ' is-atual' : '') +
        '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '"><b>' + (v[i] ? num(v[i]) : '') + '</b><i style="height:' + (v[i] ? Math.max(5, Math.round(v[i] / max * 100)) : 0) + '%"></i>' +
        '<span>' + MESES[d.getMonth()] + (d.getMonth() === 0 || i === 0 ? '<em>' + d.getFullYear() + '</em>' : '') + '</span></li>';
    }).join('') + '</ol>' +
      '<p class="nc-af-pico">Mês com mais: <b>' + MESES[X.meses[pico].d.getMonth()] + '/' + X.meses[pico].d.getFullYear() + '</b> · ' + plural(v[pico], unid[0], unid[1]) +
      ' · no período todo, ' + plural(tot, unid[0], unid[1]) + (s === 'dias' && P.A.ps.length ? ' (' + pct(tot, P.A.ps.length * X.Lef, 2) + ' dos dias de trabalho)' : '') + '</p>';
  }
  function ajustarMeses() {
    [].forEach.call(P ? P.caixa.querySelectorAll('.nc-pp-dias') : [], function (ol) { if (ol.children.length) ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 26); });
  }
  var tAj = 0;
  window.addEventListener('resize', function () { clearTimeout(tAj); tAj = setTimeout(ajustarMeses, 120); });
  /* PCMSO: as faixas de vencimento */
  var FAIXAS_EX = [
    { k: 'v90',  t: 'Vencidos há +90 dias', f: function (e) { return e.prox < -90; } },
    { k: 'v0',   t: 'Vencidos até 90 dias', f: function (e) { return e.prox < 0 && e.prox >= -90; } },
    { k: 'v30',  t: 'Vencem em ' + VENCE + ' dias', f: function (e) { return e.prox >= 0 && e.prox <= VENCE; } },
    { k: 'nunca', t: 'Sem exame registrado' }
  ];
  function pcmso(grande) {
    var F = FAIXAS_EX.filter(function (f) { return f.k === P.faixa; })[0] || FAIXAS_EX[0], ps = P.A.ps;
    var cont = FAIXAS_EX.map(function (f) {
      var n = 0, e = 0;
      ps.forEach(function (p) { if (f.k === 'nunca') { if (p.nunca) n++; return; } var x = p.ex.filter(f.f).length; if (x) { n++; e += x; } });
      return { f: f, n: n, e: e };
    });
    var topo = '<div class="nc-pp-riscos nc-sp-cont" role="group" aria-label="Faixa de vencimento">' + cont.map(function (c) {
      var ruim = c.f.k === 'v90' || c.f.k === 'v0', on = c.f.k === F.k;
      return '<button type="button" class="' + (c.n ? (ruim ? 'is-ha' : 'is-ambar') : '') + (on ? ' is-on' : '') + '" data-pp-seg="faixa" data-pp-v="' + c.f.k + '" aria-pressed="' + on + '"' +
        ' title="' + plural(c.n, 'pessoa', 'pessoas') + (c.f.k === 'nunca' ? '' : ' · ' + plural(c.e, 'exame', 'exames')) + '"><b>' + num(c.n) + '</b><span>' + c.f.t + '</span></button>';
    }).join('') + '</div>';
    var xs;
    if (F.k === 'nunca') {
      xs = ps.filter(function (p) { return p.nunca; }).sort(function (a, b) { return partes(a.nome)[1].localeCompare(partes(b.nome)[1], 'pt-BR'); });
      if (!xs.length) return topo + '<p class="nc-af-vazio-q">Todos têm algum exame registrado.</p>';
      return topo + rolo('ol', 'nc-af-barras', xs.map(function (p) {
        return '<li class="nc-af-bl"><div class="nc-af-b nc-af-b--fixa nc-pp-b">' + linhaBarra({ t: primeiro(p.nome), w: 100, trilho: 'nc-sp-trilho--ambar', v: 'nenhum', det: esc(primeiro((P.dims.car || [])[p.k[4]])) }) + '</div>' + botaoHist(p) + '</li>';
      }), grande ? 400 : POR_VEZ_Q, 'pessoas');
    }
    xs = ps.map(function (p) { var es = p.ex.filter(F.f).sort(function (a, b) { return a.prox - b.prox; }); return { p: p, es: es }; }).filter(function (x) { return x.es.length; })
      .sort(function (a, b) { return a.es[0].prox - b.es[0].prox; });
    if (!xs.length) return topo + '<p class="nc-af-vazio-q">Ninguém nesta faixa' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return Math.abs(x.es[0].prox); })) || 1;
    return topo + rolo('ol', 'nc-af-barras', xs.map(function (x) {
      var e0 = x.es[0], venc = e0.prox < 0;
      return '<li class="nc-af-bl"><div class="nc-af-b nc-af-b--fixa nc-pp-b">' +
        linhaBarra({ t: primeiro(x.p.nome), w: F.k === 'v30' ? (VENCE - e0.prox) / VENCE * 100 : Math.abs(e0.prox) / max * 100, trilho: venc ? 'nc-pp-b-trilho--debito' : 'nc-sp-trilho--ambar',
                     v: venc ? quanto(e0.prox) : e0.prox ? 'em ' + quanto(e0.prox) : 'hoje', numCls: venc ? 'nc-pp-b-num--neg' : '', exato: (venc ? 'Venceu em ' : 'Vence em ') + dataRel(e0.prox),
                     det: listaCurta(x.es.map(function (e) { return esc(exameCurto(e.e)) + ' ' + dataRel(e.prox); }), 3) }) + '</div>' + botaoHist(x.p) + '</li>';
    }), grande ? 400 : POR_VEZ_Q, 'pessoas');
  }
  /* CAUSAS: dias perdidos por CID (ou grupo da CID) */
  function causas(grande) {
    var xs = P.A.causas;
    if (!xs.length) return '<p class="nc-af-vazio-q">Nenhum dia perdido por atestado neste período' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = xs[0].d || 1, tot = P.A.tot.perdidos || 1, iSel = -1;
    xs.forEach(function (x, i) { if (P.escolha === 'c:' + x.v) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var sel = P.escolha === 'c:' + x.v;
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra nc-pp-b' + (sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : i === 0 ? ' is-maior' : '') + '" data-sp-esc="c:' + x.v + '" aria-pressed="' + sel + '"' +
        ' aria-controls="nc-sp-quem-esc" title="' + (sel ? 'Fechar a lista' : 'Ver quem se afastou por ' + esc(x.t)) + '">' +
        linhaBarra({ t: x.t, sel: sel, w: x.d / max * 100, trilho: 'nc-pp-b-trilho--debito', v: plural(x.d, 'dia', 'dias'), det: plural(x.n, 'atestado', 'atestados') + ' · ' + plural(x.p, 'pessoa', 'pessoas') + ' · ' + pct(x.d, tot) + ' dos dias' }) + '</button></li>';
    }), grande ? 300 : Math.max(POR_VEZ_Q, iSel + 1), 'linhas');
  }
  /* VACINAS: por vacina, atrasadas e vencendo */
  function vacinas(grande) {
    var g = {};
    P.A.ps.forEach(function (p) { p.vc.forEach(function (v) { var x = g[v.v] || (g[v.v] = { v: v.v, atr: 0, v30: 0 }); if (v.prox < 0) x.atr++; else x.v30++; }); });
    var xs = Object.keys(g).map(function (k) { return g[k]; }).sort(function (a, b) { return b.atr - a.atr || b.v30 - a.v30; });
    if (!xs.length) return '<p class="nc-af-vazio-q">Nenhuma dose atrasada ou vencendo' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.atr + x.v30; })) || 1, iSel = -1;
    xs.forEach(function (x, i) { if (P.escolha === 'v:' + x.v) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var sel = P.escolha === 'v:' + x.v;
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra nc-pp-b' + (sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '') + '" data-sp-esc="v:' + x.v + '" aria-pressed="' + sel + '" aria-controls="nc-sp-quem-esc">' +
        linhaBarra({ t: nomeCat('vac', x.v), sel: sel, w: (x.atr + x.v30) / max * 100, trilho: x.atr ? 'nc-sp-trilho--rosa' : 'nc-sp-trilho--ambar', v: x.atr ? plural(x.atr, 'atrasada', 'atrasadas') : plural(x.v30, 'vencendo', 'vencendo'),
                     det: (x.atr && x.v30 ? plural(x.v30, 'vence', 'vencem') + ' em ' + VENCE + ' dias · ' : '') + plural(x.atr + x.v30, 'pessoa', 'pessoas') }) + '</button></li>';
    }), grande ? 300 : Math.max(POR_VEZ_Q, iSel + 1), 'linhas');
  }
  /* ACIDENTES: por tipo e a lista */
  function acidentes(grande) {
    var tipos = { 1: [0, 0], 3: [0, 0], 2: [0, 0], 4: [0, 0] }, xs = [];
    P.A.ps.forEach(function (p) { p.ac.forEach(function (a) { var t = tipos[a.tipo] || (tipos[a.tipo] = [0, 0]); t[0]++; if (a.afast) t[1]++; xs.push({ p: p, a: a }); }); });
    var topo = '<ul class="nc-pp-riscos nc-sp-cont nc-sp-cont--4">' + ['1', '3', '2', '4'].map(function (k) {
      var t = tipos[k] || [0, 0];
      return '<li' + (t[0] ? ' class="' + (k === '4' ? 'is-ambar' : 'is-ha') + '"' : '') + '><b>' + num(t[0]) + '</b><span>' + TIPO_ACID[k] + '</span><small>' + (t[0] ? plural(t[1], 'com afastamento', 'com afastamento') : 'nenhum') + '</small></li>';
    }).join('') + '</ul>';
    var ua = P.X.ua;
    var semAc = ua[0] != null ? '<p class="nc-sp-semacid">' + ic('escudo') + '<span><b>' + plural(-ua[0], 'dia', 'dias') + '</b> sem acidente na lista toda' +
      (ua[1] != null && ua[1] !== ua[0] ? ' · <b>' + plural(-ua[1], 'dia', 'dias') + '</b> sem acidente com afastamento' : '') + '</span></p>' : '';
    if (!xs.length) return topo + semAc + '<p class="nc-af-vazio-q">Nenhum acidente neste período' + (P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    xs.sort(function (a, b) { return b.a.d - a.a.d; });
    return topo + semAc + rolo('ol', 'nc-af-barras', xs.map(function (x) {
      var a = x.a;
      return '<li class="nc-af-bl"><div class="nc-af-b nc-af-b--fixa nc-pp-b nc-sp-acid">' +
        '<span class="nc-af-b-nome"><em>' + dataRel(a.d) + '</em>' + esc(primeiro(x.p.nome)) + '</span>' +
        '<span class="nc-pp-b-det">' + (a.afast ? '<b class="nc-sp-afast">Afastado' + (a.dias ? ' ' + plural(a.dias, 'dia', 'dias') : '') + '</b>' : 'Sem afastamento') + ' · ' +
        (TIPO_ACID[a.tipo] || 'Acidente') + (CLASSE_ACID[a.cls] ? ' · ' + CLASSE_ACID[a.cls] : '') + (a.cid ? ' · CID ' + esc(a.cid) : '') + '</span></div>' + botaoHist(x.p) + '</li>';
    }), grande ? 400 : POR_VEZ_Q, 'linhas');
  }
  /* a lista de quem tem a CID / a vacina escolhida, abaixo dos quadros */
  function desenharQuemEsc(box, grande) {
    if (!box) return;
    if (!P.escolha) return desenharQuem(box, null);
    var tipo = P.escolha.charAt(0), v = +P.escolha.slice(2), L;
    if (tipo === 'c') {
      var grupo = P.cidVer === 'grupo', nomeT = grupo ? (CAPS[v] ? CAPS[v][2] : 'Sem CID') : (v >= 0 ? nomeCat('cid', v) : 'Sem CID');
      L = { tit: nomeT, ordem: 'quem perdeu mais dias primeiro', xs: [] };
      L.xs = P.A.ps.map(function (p) { var d = 0, n = 0; p.at.forEach(function (a) { if (a.perd && (grupo ? (a.cap == null ? -1 : a.cap) === v : a.cid === v)) { d += a.perd; n++; } }); return { p: p, d: d, n: n }; })
        .filter(function (x) { return x.d; }).sort(function (a, b) { return b.d - a.d; })
        .map(function (x) { return { p: x.p, diz: '<b>' + plural(x.d, 'dia perdido', 'dias perdidos') + '</b> · ' + plural(x.n, 'atestado', 'atestados'), html: true, cor: 'vermelho' }; });
    } else {
      L = { tit: nomeCat('vac', v), ordem: 'a dose mais atrasada primeiro', xs: [] };
      L.xs = P.A.ps.map(function (p) { return { p: p, x: p.vc.filter(function (z) { return z.v === v; })[0] }; }).filter(function (x) { return x.x; })
        .sort(function (a, b) { return a.x.prox - b.x.prox; })
        .map(function (x) { var z = x.x; return { p: x.p, diz: (z.prox < 0 ? '<b>Atrasada</b> desde ' : 'Vence em ') + dataRel(z.prox) + (DOSE[z.dose] ? ' · última: ' + DOSE[z.dose] + ' em ' + dataRel(z.ult) : ''), html: true, cor: z.prox < 0 ? 'rosa' : 'ambar' }; });
    }
    desenharQuem(box, L, grande);
  }
  /* ONDE: a coluna escolhida e o indicador escolhido */
  var METS = [
    ['atraso', 'Exames em atraso', 'pessoas com exame vencido ou sem exame'],
    ['abs', 'Absenteísmo por doença', 'dias perdidos sobre os dias de trabalho'],
    ['dias', 'Dias perdidos', 'dias de atestado no período'],
    ['acid', 'Acidentes', 'acidentes no período'],
    ['afast', 'Afastados hoje', 'pessoas afastadas hoje']
  ];
  function ondeDica() { var m = METS.filter(function (x) { return x[0] === P.met; })[0] || METS[0]; return 'Por ' + m[2] + ' · toque para filtrar o resumo'; }
  function ondes(grande) {
    var xs = P.A.onde, met = P.met;
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada para mostrar' + (P.A.filtrado ? ' com estes filtros' : '') + ' neste indicador.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1, iSel = -1;
    xs.forEach(function (x, i) { if (x.sel) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var v, det;
      if (met === 'atraso') { v = plural(x.c, 'pessoa', 'pessoas'); det = pct(x.c, x.p) + ' de ' + plural(x.p, 'colaborador', 'colaboradores'); }
      else if (met === 'abs') { v = pct(x.c, x.base, 2); det = plural(x.c, 'dia perdido', 'dias perdidos') + ' · ' + plural(x.p, 'colaborador', 'colaboradores'); }
      else if (met === 'dias') { v = plural(x.c, 'dia', 'dias'); det = plural(x.n, 'atestado', 'atestados') + ' · ' + plural(x.p, 'colaborador', 'colaboradores'); }
      else if (met === 'acid') { v = plural(x.c, 'acidente', 'acidentes'); det = plural(x.n, 'com afastamento', 'com afastamento') + ' · ' + plural(x.p, 'colaborador', 'colaboradores'); }
      else { v = plural(x.c, 'pessoa', 'pessoas'); det = pct(x.c, x.p) + ' de ' + plural(x.p, 'colaborador', 'colaboradores'); }
      var cls = (x.sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '') + (i === 0 && iSel < 0 ? ' is-maior' : '');
      var D = DIM[x.dim];
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra nc-pp-b' + cls + '" data-af-filtra="' + x.dim + '" data-af-valor="' + esc(x.t) + '" aria-pressed="' + !!x.sel + '"' +
        ' title="' + (x.sel ? 'Tirar ' + esc(x.t) + ' do filtro' : iSel >= 0 ? 'Juntar ' + esc(x.t) + ' ao filtro' : 'Ver o resumo só de ' + esc(x.t)) + '">' +
        linhaBarra({ t: x.t, sel: x.sel, w: x.q / max * 100, v: v, det: det }) + '</button>' +
        (D.col && x.t !== 'Não informado' ? '<button type="button" class="nc-af-b-tab" data-af-tabela="' + esc(x.t) + '" data-af-col="' + D.col + '" title="Ver ' + esc(x.t) + ' na lista" aria-label="Ver ' + esc(x.t) + ' na lista">' + ic('tabela') + '</button>' : '') + '</li>';
    }), grande ? 300 : Math.max(POR_VEZ_Q, iSel + 1), 'linhas');
  }

  /* ═══ [S6] AMPLIAR ══════════════════════════════════════════════════════════════════════ */
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
    var c = z.querySelector('.nc-pp-zoom-corpo'), esc2 = P.zoom === 'causas' || P.zoom === 'vacinas';
    c.innerHTML = quadro(P.zoom, true) + (esc2 ? '<div class="nc-af-quem nc-pp-quem--ev" hidden aria-live="polite"></div>' : '');
    ligarRolos(c);
    if (esc2) desenharQuemEsc(c.querySelector('.nc-pp-quem--ev'), true);
    ajustarMeses();
  }
  function fecharZoom(semFoco) {
    var z = P && P.caixa.querySelector('.nc-pp-zoom'); if (!z || z.hidden) { if (P) P.zoom = null; return; }
    z.hidden = true; z.querySelector('.nc-pp-zoom-corpo').innerHTML = '';
    document.documentElement.classList.remove('nc-af-travado');
    var de = P.zoomDe; P.zoom = null; P.zoomDe = null;
    if (!semFoco) { var b = de && P.caixa.contains(de) ? de : P.caixa.querySelector('[data-pp-zoom]'); if (b) b.focus({ preventScroll: true }); }
  }

  /* ═══ [S7] FILTRAR E CRUZAR ═════════════════════════════════════════════════════════════ */
  function filtrosIdx() {
    var fi = {}, dims = P.dims;
    Object.keys(P.f).forEach(function (k) {
      var m = {}, ok = [];
      (P.f[k] || []).forEach(function (t) { var i = (dims[k] || []).indexOf(t); if (i >= 0) { m[i] = 1; ok.push(t); } });
      if (ok.length) { fi[k] = m; P.f[k] = ok; } else delete P.f[k];
    });
    return fi;
  }
  function passa(p, fi, sem) { for (var k in fi) { if (k !== sem && !fi[k][p.k[DIM[k].i]]) return false; } return true; }
  function agregar() {
    var X = P.X, fi = filtrosIdx(), filtrado = Object.keys(fi).length > 0, dims = P.dims, por = DIM[P.por] ? P.por : POR_PADRAO;
    var ps = X.ps.filter(function (p) { return !filtrado || passa(p, fi); });
    var t = { atraso: 0, venc: 0, nunca: 0, nVencEx: 0, v30: 0, nV30Ex: 0, afast: 0, afAt: 0, afSit: 0, inss: 0, inssPerto: 0, estab: 0, vac: 0, vacV30: 0, nDoses: 0, restr: 0, rs: 0, dz: 0,
              perdidos: 0, nAt: 0, pAt: 0, ocup: 0, nAc: 0, nAcAf: 0, diasAc: 0, nXf: 0, inapto: 0, alterado: 0, cs: 0, pCs: 0, topCap: null };
    var gC = {}, capD = {};
    ps.forEach(function (p) {
      if (p.atraso) t.atraso++; if (p.venc.length) { t.venc++; t.nVencEx += p.venc.length; } if (p.nunca) t.nunca++;
      if (p.v30.length) { t.v30++; t.nV30Ex += p.v30.length; }
      if (p.afast) { t.afast++; if (p.afastAt != null) t.afAt++; else t.afSit++; }
      if (p.inss > INSS) t.inss++; else if (p.inss >= INSS_PERTO) t.inssPerto++;
      if (p.es) t.estab++;
      if (p.vAtr.length) { t.vac++; t.nDoses += p.vAtr.length; } if (p.v30v.length) t.vacV30++;
      if (p.rs || p.dz.length) t.restr++; if (p.rs) t.rs++; if (p.dz.length) t.dz++;
      t.perdidos += p.perdidos; t.nAt += p.nAt; if (p.nAt) t.pAt++;
      p.at.forEach(function (a) {
        if (a.ini >= X.dIni && a.ini <= X.dFim && a.ocup) t.ocup++;
        if (!a.perd) return;
        var kc = P.cidVer === 'grupo' ? (a.cap == null ? -1 : a.cap) : a.cid;
        var g = gC[kc] || (gC[kc] = { v: kc, d: 0, n: 0, ps: {} }); g.d += a.perd; g.n++; g.ps[p.i] = 1;
        if (a.cap != null) capD[a.cap] = (capD[a.cap] || 0) + a.perd;
      });
      t.nAc += p.nAc; t.nAcAf += p.nAcAf; t.diasAc += p.diasAc;
      t.nXf += p.nXf; t.inapto += p.inapto; t.alterado += p.alterado;
      t.cs += p.cs; if (p.cs) t.pCs++;
    });
    Object.keys(capD).forEach(function (c) { if (t.topCap == null || capD[c] > capD[t.topCap]) t.topCap = +c; });
    var causasL = Object.keys(gC).map(function (k) {
      var g = gC[k], v = +k;
      return { v: v, t: P.cidVer === 'grupo' ? (CAPS[v] ? CAPS[v][2] : 'Sem CID informado') : (v >= 0 ? nomeCat('cid', v) : 'Sem CID informado'), d: g.d, n: g.n, p: Object.keys(g.ps).length };
    }).sort(function (a, b) { return b.d - a.d; }).slice(0, 300);
    /* onde: a coluna escolhida e o indicador escolhido; a lista ignora o filtro da própria coluna */
    var gO = {}, iPor = DIM[por].i, met = P.met;
    X.ps.forEach(function (p) { if (filtrado && !passa(p, fi, por)) return; var v = p.k[iPor]; (gO[v] || (gO[v] = [])).push(p); });
    var onde = Object.keys(gO).map(function (v) {
      var g = gO[v], x = { t: (dims[por] || [])[v], dim: por, sel: !!(fi[por] && fi[por][v]), p: g.length, c: 0, n: 0, q: 0, base: g.length * X.Lef };
      g.forEach(function (p) {
        if (met === 'atraso') { if (p.atraso) x.c++; }
        else if (met === 'abs' || met === 'dias') { x.c += p.perdidos; x.n += p.nAt; }
        else if (met === 'acid') { x.c += p.nAc; x.n += p.nAcAf; }
        else if (p.afast) x.c++;
      });
      x.q = met === 'abs' ? (x.base ? x.c / x.base : 0) : met === 'atraso' || met === 'afast' ? x.c + x.c / (x.p || 1) / 1000 : x.c;
      return x;
    }).filter(function (x) { return x.t != null && (x.c || x.sel); })
      .sort(function (a, b) { return b.q - a.q || b.p - a.p; }).slice(0, 300);
    var base = ps.length * X.Lef, ua = X.ua;
    var nota = (t.perdidos || base ? 'Absenteísmo por doença = dias de atestado dentro do período, até hoje (' + plural(t.perdidos, 'dia', 'dias') + ') ÷ dias de calendário das pessoas da lista (' +
      num(ps.length) + ' × ' + plural(X.Lef, 'dia', 'dias') + '). ' : '') +
      'A regra do INSS: mais de ' + INSS + ' dias de atestado em 60 dias (pelo mesmo motivo) — do 16º dia em diante, o afastamento é do INSS. Confira o motivo antes de encaminhar.';
    var N = {
      exame:  { n: t.atraso, v: num(t.atraso), u: t.atraso === 1 ? 'pessoa' : 'pessoas', dica: t.atraso ? (t.venc ? plural(t.nVencEx, 'exame vencido', 'exames vencidos') : '') + (t.venc && t.nunca ? ' · ' : '') + (t.nunca ? plural(t.nunca, 'sem exame registrado', 'sem exame registrado') : '') : 'todos com os exames em dia' },
      vence:  { n: t.v30, v: num(t.v30), u: t.v30 === 1 ? 'pessoa' : 'pessoas', dica: t.v30 ? plural(t.nV30Ex, 'exame', 'exames') + ': hora de convocar' : 'nenhum exame vence em ' + VENCE + ' dias' },
      afast:  { n: t.afast, v: num(t.afast), u: t.afast === 1 ? 'pessoa' : 'pessoas', dica: t.afast ? [t.afAt ? plural(t.afAt, 'por atestado', 'por atestado') : '', t.afSit ? plural(t.afSit, 'pela situação funcional', 'pela situação funcional') : ''].filter(Boolean).join(' · ') : 'ninguém afastado hoje' },
      inss:   { n: t.inss + t.inssPerto, v: num(t.inss), u: t.inss === 1 ? 'pessoa' : 'pessoas', alerta: t.inss > 0, dica: t.inss || t.inssPerto ? (t.inss ? 'passaram de ' + INSS + ' dias em 60' : 'ninguém passou') + (t.inssPerto ? ' · <b>' + num(t.inssPerto) + ' chegando perto</b>' : '') : 'ninguém perto do limite' },
      estab:  { n: t.estab, v: num(t.estab), u: t.estab === 1 ? 'pessoa' : 'pessoas', dica: t.estab ? '12 meses depois da volta (art. 118)' : 'ninguém em estabilidade por acidente' },
      vacina: { n: t.vac, v: num(t.vac), u: t.vac === 1 ? 'pessoa' : 'pessoas', dica: t.vac ? plural(t.nDoses, 'dose atrasada', 'doses atrasadas') + (t.vacV30 ? ' · ' + num(t.vacV30) + ' vencem em ' + VENCE + ' dias' : '') : t.vacV30 ? num(t.vacV30) + ' com dose vencendo em ' + VENCE + ' dias' : 'nenhuma dose atrasada' },
      restr:  { n: t.restr, v: num(t.restr), u: t.restr === 1 ? 'pessoa' : 'pessoas', dica: t.restr ? [t.rs ? plural(t.rs, 'com restrição', 'com restrição') : '', t.dz ? plural(t.dz, 'com doença sem término', 'com doença sem término') : ''].filter(Boolean).join(' · ') : 'nenhuma restrição registrada' },
      abs:    { n: t.perdidos, texto: true, v: pct(t.perdidos, base, 2), u: 'dos dias', dica: t.perdidos ? plural(t.perdidos, 'dia perdido', 'dias perdidos') + ' por atestado' : 'nenhum dia perdido por atestado', dicaLonga: 'Absenteísmo por doença: ' + num(t.perdidos) + ' dias de atestado sobre ' + num(base) + ' dias de calendário' },
      atest:  { n: t.nAt, v: num(t.nAt), u: t.nAt === 1 ? 'atestado' : 'atestados', dica: t.nAt ? plural(t.pAt, 'pessoa', 'pessoas') + (t.ocup ? ' · ' + plural(t.ocup, 'ocupacional', 'ocupacionais') : '') : 'nenhum atestado no período' },
      acid:   { n: t.nAc, v: num(t.nAc), u: t.nAc === 1 ? 'acidente' : 'acidentes', alerta: t.nAcAf > 0, dica: t.nAc ? plural(t.nAcAf, 'com afastamento', 'com afastamento') + (t.diasAc ? ' · ' + plural(t.diasAc, 'dia perdido', 'dias perdidos') : '') : 'nenhum acidente no período' },
      semacid: { n: ua[0] != null ? 1 : 0, v: ua[0] != null ? num(-ua[0]) : '—', u: ua[0] != null ? (-ua[0] === 1 ? 'dia' : 'dias') : '', dica: ua[0] != null ? 'último em ' + dataRel(ua[0]) + (ua[1] != null && ua[1] !== ua[0] ? ' · com afastamento há ' + plural(-ua[1], 'dia', 'dias') : '') + ' · na lista toda' : 'nenhum acidente registrado na lista' },
      exames: { n: t.nXf, v: num(t.nXf), u: t.nXf === 1 ? 'exame' : 'exames', alerta: t.inapto > 0, dica: t.nXf ? (t.inapto ? '<b>' + plural(t.inapto, 'inapto', 'inaptos') + '</b>' : 'nenhum inapto') + (t.alterado ? ' · ' + plural(t.alterado, 'alterado', 'alterados') : '') : 'nenhum exame no período' },
      cons:   { n: t.cs, v: num(t.cs), u: t.cs === 1 ? 'atendimento' : 'atendimentos', dica: t.cs ? plural(t.pCs, 'pessoa atendida', 'pessoas atendidas') : 'nenhuma consulta no período' }
    };
    return { fi: fi, filtrado: filtrado, por: por, ps: ps, tot: t, nums: N, causas: causasL, onde: onde, nota: nota };
  }

  function comparar(a, b) { return String(a).localeCompare(String(b), 'pt-BR', { numeric: true, sensitivity: 'base' }); }
  function desenharFiltros() {
    var box = P.caixa.querySelector('.nc-af-filtros'); if (!box) return;
    var X = P.X, fi = P.A.fi, dims = P.dims, n = Object.keys(fi).length;
    P.opc = {};
    if (P.nDims !== P.dados) { P.nDims = P.dados; P.nVal = {}; DIMS.forEach(function (D) { var t = {}; X.ps.forEach(function (p) { t[p.k[D.i]] = 1; }); P.nVal[D.k] = Object.keys(t).length; }); }
    var campos = DIMS.map(function (D) {
      var tem = {};
      X.ps.forEach(function (p) { if (passa(p, fi, D.k)) tem[p.k[D.i]] = (tem[p.k[D.i]] || 0) + 1; });
      (P.f[D.k] || []).forEach(function (t) { var i = (dims[D.k] || []).indexOf(t); if (i >= 0 && !(i in tem)) tem[i] = 0; });
      var vs = Object.keys(tem).map(function (v) { return { t: (dims[D.k] || [])[v], n: tem[v], i: +v }; }).filter(function (x) { return x.t != null; })
        .sort(function (a, b) { return D.k === 'idade' ? a.i - b.i : comparar(a.t, b.t); });
      P.opc[D.k] = vs;
      var es = P.f[D.k] || [];
      if (P.nVal[D.k] < 2 && !es.length) return '';
      var aberto = P.pop && P.pop.k === D.k;
      return '<div class="nc-af-campo' + (es.length ? ' is-ativo' : '') + '"><span class="nc-af-campo-rot" id="nc-sp-rot-' + D.k + '">' + D.nome + '</span>' +
        '<button type="button" class="nc-af-escolha" data-af-abre="' + D.k + '" aria-haspopup="true" aria-expanded="' + aberto + '" aria-controls="nc-af-pop"' +
        ' aria-labelledby="nc-sp-rot-' + D.k + ' nc-sp-val-' + D.k + '"><span class="nc-af-escolha-txt" id="nc-sp-val-' + D.k + '">' +
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
      DIMS.map(function (D) { return '<option value="' + D.k + '"' + (D.k === P.A.por ? ' selected' : '') + '>' + D.nome + '</option>'; }).join('') + '</select></label>' +
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

  /* ═══ [S8] ABRIR O HISTÓRICO E VER NA TABELA ═══════════════════════════════════════════
     CUIDADO  O Histórico (página 6) é uma janela modal com checksum: o endereço vem do servidor
              (apex_page.get_url, o mesmo do lápis da lista) só na hora do toque, por pessoa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function abrirHistorico(i, botao) {
    var p = P.X.ps[i]; if (!p) return;
    var emp = partes((P.dims.emp || [])[p.k[0]])[0], mat = partes(p.nome)[0];
    if (!emp || !mat) return;
    if (botao) { botao.disabled = true; botao.classList.add('is-abrindo'); }
    fecharZoom(true);
    apex.server.process(PROCESSO, { x01: 'LINK', x02: emp, x03: mat }, { dataType: 'json' })
      .done(function (d) {
        var u = d && d.url;
        if (!u) return;
        if (/^javascript:/i.test(u)) { try { (new Function(decodeURIComponent(u.slice(11))))(); } catch (e) { try { apex.navigation.redirect(u); } catch (e2) { /* ok */ } } }
        else apex.navigation.redirect(u);
      })
      .always(function () { if (botao) { botao.disabled = false; botao.classList.remove('is-abrindo'); } });
  }
  function colunaDaBusca(col) {
    var h = document.getElementById(IR_ID + '_column_search_current_column'), f = document.getElementById(IR_ID + '_search_field');
    if (!h || !f) return null;
    var D = DIMS.filter(function (x) { return x.col === col; })[0], tit = D ? D.tit : null;
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

  /* ═══ [S9] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncSaudeIniciou) return; if (montar()) { window.__ncSaudeIniciou = true; buscar(); } }
  window.__ncSaudeDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
