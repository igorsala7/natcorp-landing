/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ACIDENTES DE TRABALHO  —  o painel de resumo (JavaScript)                      ║
   ║  App 200 · Página 150 (Acidente de Trabalho — consulta)                                   ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: ACIDPAINEL-MANUTENCAO.md. A roupa é a MESMA do painel de afastamentos
   (Natcorp_AcidPainel.css = cópia do Natcorp_Afastamentos.css; as peças só daqui são .nc-ac-*).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima do relatório, um RESUMO para quem cuida da segurança e das pessoas (SESMT, RH, DP),
   escrito do jeito que se fala:
     AGORA       Dias sem acidente no trabalho · Afastados por acidente hoje · Com estabilidade ·
                 Sem número da CAT · Análise não concluída. Tocar num número mostra QUEM são, já
                 na ordem que importa; tocar num acidente ABRE a análise dele (página 151).
     NO PERÍODO  12 meses, 2 anos, 5 anos ou tudo: a frase ("23 acidentes com 21 pessoas…"), o
                 índice "de cada 1.000 pessoas", a comparação com o período anterior, mês a mês,
                 que tipo, em que dia e hora, onde, em que cargo, e quem se acidentou mais de uma vez.
     FILTRAR     "Filtrar este resumo" (as colunas da tabela, VÁRIOS valores em cada uma) e tocar
                 numa barra deixam o resumo inteiro só com aquilo, na hora (contas feitas aqui).
   Os dados vêm do servidor (processo NC_ACID_INDICADORES) com os MESMOS filtros da página.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda o relatório nem os filtros da página. Os filtros feitos DENTRO do relatório (menu
       Ações) não entram nos números.
     • Não grava nada: a análise é aberta na página dela (151), como pela lupa da tabela.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 150 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_AcidPainel.js
     Página 150 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_AcidPainel.css
     Página 150 › Processing › Ajax Callback NC_ACID_INDICADORES  (NC_ACID_INDICADORES.plsql.sql)
   Tudo já vem na exportação f200_page_150.sql (aplicar-acidpainel-pagina150.py), que também dá ao
   relatório o Static ID "IR". Sem o Static ID o painel acha o relatório sozinho.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [K1] Textos e regras ................. frases, ícones, o que é trajeto/doença/ocorrência  PODE MEXER
     [K2] Os dados ........................ chamada ao servidor                        CUIDADO
     [K3] A moldura ....................... título, esconder/mostrar, carregando, erro
     [K4] Agora ........................... os 5 números e a lista "quem são"           PODE MEXER
     [K5] No período ...................... frase, mês a mês, tipo, dia e hora, onde, cargo, pessoas  PODE MEXER
     [K6] Filtrar e cruzar ................ as colunas, as contas na tela, a lista de marcar
     [K7] Ver na tabela ................... a busca do próprio relatório, na coluna certa
     [K8] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncAcid) return;
  window.__ncAcid = true;

  /* ═══ [K1] TEXTOS E REGRAS ══════════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_ACID_INDICADORES';
  var ITENS = ['P150_SITUACAO', 'P150_EMPRESA', 'P150_FILIAL', 'P150_CCUSTO', 'P150_UNIDADE_ADM', 'P150_ATIVIDADE', 'P150_CARGO', 'P150_MATRICULA', 'P150_EMP', 'P150_MAT'];
  var POR_VEZ = 30;                       /* linhas que a lista "quem são" mostra de cada vez */
  var POR_VEZ_Q = 6;                      /* linhas de cada quadro do período, de cada vez */
  var PEND_MESES = 24;                    /* "Sem número da CAT" e "Análise não concluída" olham os últimos 24 meses */
  var GUARDA = 'nc-ac-aberto';            /* o painel aberto fica lembrado neste navegador */
  var GUARDA_PER = 'nc-ac-per';           /* o período escolhido */
  var GUARDA_POR = 'nc-ac-por';           /* o "por" do quadro Onde */
  var VALIDADE = 10 * 60 * 1000;          /* o resumo calculado vale 10 min nesta aba (mesmos filtros) */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  var SEMANA = ['domingo', 'segunda-feira', 'terça-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 'sábado'];
  var SEM_CURTO = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
  var FAIXAS = [{ t: 'Madrugada', h: '0h às 6h' }, { t: 'Manhã', h: '6h às 12h' }, { t: 'Tarde', h: '12h às 18h' }, { t: 'Noite', h: '18h às 24h' }];
  var PERIODOS = [{ m: 12, t: '12 meses' }, { m: 24, t: '2 anos' }, { m: 60, t: '5 anos' }, { m: 0, t: 'Tudo' }];

  /* O TIPO pelo nome (a tabela acidente_tipo muda de base para base):
       ocorrência  "Cadastro de Ocorrência", incidente, quase acidente — não é acidente, não pede CAT
       trajeto     no caminho de casa para o trabalho (ou volta)
       doença      doença do trabalho / ocupacional (pede CAT, mas não tem "hora")
       típico      o resto: o acidente no trabalho. "Dias sem acidente" conta só estes (NBR 14280). */
  function classe(nome) {
    var t = semAcento(nome);
    if (/ocorr|incidente|quase/.test(t)) return 'ocorr';
    if (/trajet/.test(t)) return 'trajeto';
    if (/doen/.test(t)) return 'doenca';
    return 'tipico';
  }

  /* as colunas que o resumo sabe filtrar e cruzar. "i" = a posição em cada acidente (ac), a MESMA
     ordem do NC_ACID_INDICADORES; "p" = a posição no "k" das pessoas (afastados/estabilidade; tipo e
     local não valem para pessoa); "col" = a coluna do relatório (o alias da consulta) */
  var DIMS = [
    { k: 'emp',  i: 1, p: 0, col: 'EMPRESA',           tit: 'Empresa',           nome: 'Empresa',                  todos: 'Todas' },
    { k: 'fil',  i: 2, p: 1, col: 'FILIAL',            tit: 'Filial',            nome: 'Filial',                   todos: 'Todas' },
    { k: 'cc',   i: 3, p: 2, col: 'CENTRO_DE_CUSTO',   tit: 'Centro de Custo',   nome: 'Centro de Custo (Célula)', todos: 'Todos', curto: 'Centro de custo' },
    { k: 'un',   i: 4, p: 3, col: null,                tit: null,                nome: 'Unidade Adm. (Cliente)',   todos: 'Todas', curto: 'Unidade adm. (cliente)' },
    { k: 'at',   i: 5, p: 4, col: null,                tit: null,                nome: 'Atividade (Serviço)',      todos: 'Todas', curto: 'Atividade (serviço)' },
    { k: 'car',  i: 6, p: 5, col: 'CARGO',             tit: 'Cargo',             nome: 'Cargo',                    todos: 'Todos' },
    { k: 'loc',  i: 7, p: -1, col: 'LOCAL_DE_TRABALHO', tit: 'Local de Trabalho', nome: 'Local de trabalho',        todos: 'Todos' },
    { k: 'tipo', i: 0, p: -1, col: 'TIPO',             tit: 'Tipo',              nome: 'Tipo de acidente',         todos: 'Todos' }
  ];
  var DIM = {}; DIMS.forEach(function (x) { DIM[x.k] = x; });
  var POR_PADRAO = 'loc';                 /* "Onde mais acontece" abre por local de trabalho */
  /* posições em cada acidente (ac), depois das 8 colunas */
  var A_PES = 8, A_DT = 9, A_HORA = 10, A_ST = 11, A_CAT = 12, A_TRAT = 13, A_AFI = 14, A_COD = 15, A_URL = 16, A_DTCAT = 17;

  /* os 5 números de AGORA: a ordem é a ordem na tela */
  var AGORA = [
    { k: 'dias',   cor: 'verde',    ic: 'escudo',  diz: 'Sem acidente no trabalho' },
    { k: 'afast',  cor: 'rosa',     ic: 'cama',    diz: 'Afastados por acidente', dica: 'pelo INSS · na volta, 12 meses de estabilidade' },
    { k: 'estab',  cor: 'roxo',     ic: 'cadeado', diz: 'Com estabilidade',       dica: 'voltaram há menos de 12 meses: não demitir sem justa causa' },
    { k: 'semCat', cor: 'vermelho', ic: 'doc',     diz: 'Sem número da CAT',      dica: 'prazo: 1º dia útil depois do acidente (eSocial)', alerta: true },
    { k: 'pend',   cor: 'ambar',    ic: 'lupa',    diz: 'Análise não concluída',  dica: 'falta concluir a investigação', alerta: true }
  ];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    escudo: '<path d="M12 3.2 5 6v5.6c0 4.3 2.9 7.6 7 9.2 4.1-1.6 7-4.9 7-9.2V6z"/><path d="M8.8 12.2l2.2 2.2 4.2-4.4"/>',
    cama: '<path d="M3 18V7M3 14h18v4M21 14v-2.5a3 3 0 0 0-3-3h-7v5.5"/><circle cx="7" cy="11" r="1.8"/>',
    cadeado: '<rect x="5" y="10.5" width="14" height="10" rx="2.5"/><path d="M8 10.5V8a4 4 0 0 1 8 0v2.5M12 14.5v2.5"/>',
    doc: '<path d="M7 3.5h7l4 4v13H7z"/><path d="M14 3.5v4h4M9.5 12.5h6M9.5 16h4"/>',
    lupa: '<circle cx="10.5" cy="10.5" r="6"/><path d="M15 15l5 5M8 10.5h5"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>',
    tirar: '<path d="M7 7l10 10M17 7 7 17"/>',
    filtro: '<path d="M4 5.5h16l-6.2 7.3v5.4l-3.6 1.8v-7.2z"/>',
    marca: '<path d="M5 12.5l4.2 4.2L19 7"/>',
    sair: '<path d="M14 4h6v6M20 4l-8.5 8.5"/><path d="M18 14v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h5"/>'
  };
  function ic(n) { return '<svg class="nc-af-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function num(n) { return Number(n || 0).toLocaleString('pt-BR'); }
  function plural(n, um, varios) { return num(n) + ' ' + (Number(n) === 1 ? um : varios); }
  function data(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dataYmd(t) { var m = /^(\d{4})(\d{2})(\d{2})$/.exec(t || ''); return m ? new Date(+m[1], +m[2] - 1, +m[3]) : null; }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  function dma(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2) + '/' + d.getFullYear(); }
  function curta(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2); }
  function haDias(n) { return n <= 0 ? 'hoje' : n === 1 ? 'ontem' : 'há ' + plural(n, 'dia', 'dias'); }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  /* "123 - Fulano De Tal" → ["123", "Fulano De Tal"] (o código fica, como no resto do sistema) */
  function partes(t) { var m = /^(\S+)\s+-\s*(.*)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }
  function nomeSo(t) { return partes(t)[1] || t || ''; }
  function addMeses(d, n) { var x = new Date(d.getFullYear(), d.getMonth() + n, d.getDate()); return x; }
  /* o prazo da CAT: o 1º dia útil depois do acidente (sábado e domingo pulam; feriado não é conhecido aqui) */
  function prazoCat(d) { var x = new Date(d.getFullYear(), d.getMonth(), d.getDate() + 1); while (x.getDay() === 0 || x.getDay() === 6) x.setDate(x.getDate() + 1); return x; }

  /* ═══ [K2] OS DADOS ═════════════════════════════════════════════════════════════════════
     CUIDADO  Os filtros vão com a chamada (pageItems) — os mesmos que o relatório usa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function valor(i) { return document.getElementById(i) && window.apex && apex.item ? (apex.item(i).getValue() || '') : ''; }
  function chaveCache() { return 'nc-ac-dados1:' + ITENS.map(valor).join('|'); }
  function buscar(forcar) {
    var k = chaveCache(), c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && c && c.d && Date.now() - c.t < VALIDADE) { desenhar(c.d, c.t); return; }
    carregando();
    var itens = ITENS.filter(function (i) { return document.getElementById(i); }).map(function (i) { return '#' + i; }).join(',');
    apex.server.process(PROCESSO, { pageItems: itens }, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio ou bloqueado: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      /* processo que não existe na página: o APEX responde 200 VAZIO */
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [K3] A MOLDURA ═══════════════════════════════════════════════════════════════════ */
  var P = null;
  /* o relatório: Static ID "IR" (a exportação dá) ou o primeiro Interactive Report da página */
  function relatorio() {
    var r = document.getElementById('IR');
    if (r) return { el: r, id: 'IR' };
    var w = document.querySelector('.a-IRR-container');
    r = w && w.closest('.t-Region, .t-IRR-region, [id^="R"]');
    return r ? { el: r, id: r.id } : null;
  }
  function marcarRelatorio() { var r = relatorio(); if (r) r.el.classList.add('nc-reg-sim'); }   /* continua com Tabela | Cartões */
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  function montar() {
    if (P) return true;
    var ir = relatorio();
    if (!ir) return false;
    var caixa = el('section', 'nc-af nc-ac');
    caixa.setAttribute('aria-labelledby', 'nc-ac-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-ac-titulo">Resumo dos acidentes de trabalho</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-ac-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-ac-esconde aria-controls="nc-ac-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-ac-corpo"></div>';
    ir.el.parentNode.insertBefore(caixa, ir.el);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-ac-esconde]'),
          filtro: null, f: {}, por: POR_PADRAO, per: 12 };
    try {
      var por = localStorage.getItem(GUARDA_POR); if (DIM[por] && por !== 'tipo' && por !== 'car') P.por = por;
      var per = localStorage.getItem(GUARDA_PER); if (per != null && PERIODOS.some(function (x) { return String(x.m) === per; })) P.per = +per;
    } catch (e) { /* ok */ }
    /* nasce COMPACTO (só os 5 números; a tabela é a função principal): abre a análise quem pediu */
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '1'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    caixa.addEventListener('click', clique);
    caixa.addEventListener('change', mudou);
    return true;
  }
  function abrirFechar(aberto) {
    fecharLista(false);
    P.caixa.classList.toggle('is-fechado', !aberto);
    P.botao.setAttribute('aria-expanded', String(aberto));
    P.botao.innerHTML = ic(aberto ? 'fechar' : 'abrir') + '<span>' + (aberto ? 'Mostrar menos' : 'Ver análise completa') + '</span>';
    try { if (aberto) localStorage.setItem(GUARDA, '1'); else localStorage.removeItem(GUARDA); } catch (e) { /* ok */ }
    if (aberto) setTimeout(ajustarMeses, 0);   /* o gráfico mede a largura só quando aparece */
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-ac-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-ac-num')) { var k = b.getAttribute('data-ac-num'); P.filtro = P.filtro === k ? null : k; desenharAgora(); return; }
    if (b.hasAttribute('data-ac-per')) { P.per = +b.getAttribute('data-ac-per'); try { localStorage.setItem(GUARDA_PER, String(P.per)); } catch (e2) { /* ok */ } redesenhar({ attr: 'data-ac-per', v: String(P.per) }); return; }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-ac-filtra')) { alternar(b.getAttribute('data-ac-filtra'), b.getAttribute('data-ac-valor')); return; }
    if (b.hasAttribute('data-ac-tira')) { delete P.f[b.getAttribute('data-ac-tira')]; redesenhar({ attr: 'data-ac-tira', v: Object.keys(P.f)[0] || null, depois: '.nc-af-filtros-campos [data-ac-abre]' }); return; }
    if (b.hasAttribute('data-ac-limpa')) { P.f = {}; redesenhar({ attr: null, depois: '.nc-af-filtros-campos [data-ac-abre]' }); return; }
    if (b.hasAttribute('data-ac-abre')) { var ab = b.getAttribute('data-ac-abre'); if (P.pop && P.pop.k === ab) fecharLista(true); else abrirLista(ab); return; }
    if (b.hasAttribute('data-ac-pronto')) { fecharLista(true); return; }
    if (b.hasAttribute('data-ac-pop-limpa')) { delete P.f[P.pop.k]; redesenhar({ pop: true }); marcarLista(); return; }
    if (b.hasAttribute('data-ac-tabela')) { naTabela(b.getAttribute('data-ac-tabela'), b.getAttribute('data-ac-col')); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-ac-tenta') || b.hasAttribute('data-ac-atualiza')) buscar(true);
  }
  /* CALCULANDO: a faixa que corre no topo e o texto do que está fazendo (muda a cada 4 s) */
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
  function carregando() {
    var regua = AGORA.map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('');
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">Agora</p><div class="nc-af-regua">' + regua + '</div></div>' +
      '<div class="nc-af-secao nc-af-periodo"><i class="nc-af-esq" style="width:60%;height:16px"></i><div class="nc-af-quadros nc-af-quadros--3" style="margin-top:14px">' +
      '<div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div></div></div>';
    P.quando.textContent = 'Calculando…';
    P.caixa.querySelector('[data-ac-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(['Buscando os acidentes…', 'Conferindo CAT e análises…', 'Vendo quem está afastado e quem tem estabilidade…', 'Ainda calculando: com muitos colaboradores leva mais tempo']);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_ACID|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia ACIDPAINEL-MANUTENCAO.md). A tabela abaixo funciona normalmente.'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-ac-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [K4] AGORA ════════════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    var hoje = data(d.hoje) || new Date();
    hoje = new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate());
    var tipos = (d.dims && d.dims.tipo) || [];
    /* cada acidente vira um objeto com o que as contas usam */
    P.ac = (d.ac || []).map(function (r) {
      var D = dataYmd(r[A_DT]), hm = /^(\d{2}):(\d{2})$/.exec(r[A_HORA] || ''), cl = classe(tipos[r[0]]);
      /* 00:00 é como o sistema guarda a hora em branco: conta como "sem hora" */
      var h = hm && !(hm[1] === '00' && hm[2] === '00') ? +hm[1] : -1;
      var st = r[A_ST] || '', pendente = st !== 'C' && st !== 'N';
      return { r: r, D: D, h: h, cl: cl, st: st, pendente: pendente,
               precisaCat: cl !== 'ocorr' && st !== 'N', temCat: r[A_CAT] === 1,
               afasta: r[A_AFI] === 1 || (r[A_TRAT] || 0) > 0, trat: r[A_TRAT] };
    });
    (d.afast || []).forEach(function (p) { p.kk = String(p.k || '').split(',').map(Number); p.dD = data(p.d); p.dR = data(p.r); });
    (d.estab || []).forEach(function (p) { p.kk = String(p.k || '').split(',').map(Number); p.dV = data(p.v); p.dA = data(p.a); });
    P.dados = d; P.hoje = hoje; P.filtro = null;
    P.hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.caixa.querySelector('[data-ac-atualiza]').hidden = false;
    P.corpo.innerHTML =
      '<div class="nc-af-filtros" role="group" aria-label="Filtrar este resumo" hidden></div>' +
      '<div class="nc-af-secao"><p class="nc-af-rot">Agora</p><div class="nc-af-regua" role="group" aria-label="O que pede atenção agora"></div>' +
      '<div class="nc-af-quem" id="nc-ac-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    redesenhar();
  }
  function redesenhar(foco) {
    if (P.pop && !(foco && foco.pop)) fecharLista(false);
    P.A = agregar();
    var n = Object.keys(P.A.fi).length;
    P.quando.innerHTML = 'Hoje, <b>' + esc(P.dados.hoje) + '</b> · com os filtros da página' +
      (n ? ' e <b>' + plural(n, 'filtro', 'filtros') + ' deste resumo</b>' : '') + (P.hm ? ' · calculado às ' + P.hm : '');
    desenharFiltros();
    desenharAgora();
    desenharPeriodo();
    if (foco) refocar(foco);
  }
  function desenharAgora() {
    var A = P.A, ult = A.ultimo;
    P.caixa.querySelector('.nc-af-regua').innerHTML = AGORA.map(function (h) {
      var v, valorHtml, dica = h.dica, on = P.filtro === h.k, cor = h.cor;
      if (h.k === 'dias') {
        if (!ult) { valorHtml = '<span class="nc-af-valor is-texto">Nenhum</span>'; dica = 'nenhum acidente no trabalho registrado'; v = 0; }
        else {
          v = dias(ult.D, P.hoje);
          valorHtml = '<span class="nc-af-valor">' + num(v) + '<small>' + (v === 1 ? 'dia' : 'dias') + '</small></span>';
          dica = 'o último foi ' + (v === 0 ? 'hoje' : v === 1 ? 'ontem' : 'em ' + dma(ult.D));
          if (v < 7) cor = 'ambar';
          v = A.recentes.length;               /* o botão só toca se há o que mostrar */
        }
      } else {
        v = (A.listas[h.k] || []).length;
        valorHtml = '<span class="nc-af-valor">' + num(v) + '<small>' + (h.k === 'afast' || h.k === 'estab' ? (v === 1 ? 'pessoa' : 'pessoas') : (v === 1 ? 'acidente' : 'acidentes')) + '</small></span>';
      }
      return '<button type="button" class="nc-af-num nc-af-num--' + cor + (v ? '' : ' is-zero') + (h.alerta && v ? ' is-alerta' : '') + '" data-ac-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-ac-quem"' + (v ? '' : ' disabled') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' + valorHtml +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + dica + '</span></button>';
    }).join('');
    desenharLista();
  }

  /* a lista "quem são" de cada número, já na ordem que importa */
  var CAB = {
    dias:   { t: 'Os acidentes mais recentes', o: 'do mais novo para o mais antigo · toque para abrir a análise' },
    afast:  { t: 'Afastados por acidente hoje', o: 'quem está fora há mais tempo primeiro · toque para ver os acidentes da pessoa na tabela' },
    estab:  { t: 'Com estabilidade', o: 'quem tem a estabilidade acabando antes primeiro · a data é contada da volta: confira com a carta do INSS' },
    semCat: { t: 'Sem número da CAT', o: 'nos últimos ' + PEND_MESES + ' meses, do mais novo para o mais antigo · toque para abrir a análise e registrar' },
    pend:   { t: 'Análise não concluída', o: 'nos últimos ' + PEND_MESES + ' meses, a mais antiga primeiro · toque para abrir e concluir' }
  };
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro) { box.hidden = true; box.innerHTML = ''; return; }
    var k = P.filtro, xs = k === 'dias' ? P.A.recentes : P.A.listas[k] || [], c = CAB[k];
    var unid = k === 'afast' || k === 'estab' ? ['pessoa', 'pessoas'] : ['acidente', 'acidentes'];
    box.hidden = false;
    var linhas = xs.map(function (x) { return k === 'afast' ? linhaAfast(x) : k === 'estab' ? linhaEstab(x) : linhaAcidente(x, k); });
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + c.t + ': ' + plural(xs.length, unid[0], unid[1]) + '</h3><p>' + c.o + '</p>' +
      (xs.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome, cargo ou local" data-ac-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', linhas, POR_VEZ, unid);
    ligarRolos(box);
    var pr = box.querySelector('[data-ac-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value); });
  }
  function nomes() { return P.dados.nomes || {}; }
  function rotulo(dim, i) { return ((P.dados.dims || {})[dim] || [])[i]; }
  /* um acidente: quem · tipo · quando · o selo do que falta · abrir */
  function linhaAcidente(a, lista) {
    var r = a.r, pessoa = nomes()[r[A_PES]] || 'Pessoa', cargo = nomeSo(rotulo('car', r[6])), local = nomeSo(rotulo('loc', r[7])), tipo = nomeSo(rotulo('tipo', r[0]));
    var n = a.D ? dias(a.D, P.hoje) : null;
    var quando = a.D ? dma(a.D) + (r[A_HORA] && a.h >= 0 ? ' às ' + r[A_HORA] : '') : 'sem data';
    var selo;
    if (lista === 'semCat' && a.D) {
      var pz = prazoCat(a.D);
      selo = pz < P.hoje ? '<span class="nc-af-volta nc-af-volta--atrasada">Prazo era ' + curta(pz) + '</span>' : '<span class="nc-af-volta nc-af-volta--sem">Registrar até ' + curta(pz) + '</span>';
    } else if (lista === 'pend') {
      selo = '<span class="nc-af-volta nc-af-volta--sem">' + (n != null ? 'Pendente ' + haDias(n) : 'Pendente') + '</span>';
    } else if (a.precisaCat && !a.temCat) selo = '<span class="nc-af-volta nc-af-volta--atrasada">Sem número da CAT</span>';
    else if (a.pendente) selo = '<span class="nc-af-volta nc-af-volta--sem">Análise pendente</span>';
    else if (a.st === 'N') selo = '<span class="nc-af-volta">Cancelada</span>';
    else selo = '<span class="nc-af-volta nc-af-volta--logo">Análise concluída</span>';
    var miolo = '<span class="nc-af-p-quem"><b>' + esc(pessoa) + '</b><span>' + esc(cargo) + (local ? ' · ' + esc(local) : '') + '</span></span>' +
      '<span class="nc-af-p-tipo">' + esc(tipo) + (a.trat > 0 ? '<span class="nc-ac-trat">' + plural(a.trat, 'dia', 'dias') + ' de tratamento</span>' : '') + '</span>' +
      '<span class="nc-af-p-desde">' + esc(quando) + (n != null ? '<span>' + haDias(n) + '</span>' : '') + '</span>' + selo;
    var texto = esc(semAcento([pessoa, cargo, local, tipo].join(' ')));
    if (r[A_URL]) {
      return '<li data-af-texto="' + texto + '"><a class="nc-af-p nc-ac-p" href="' + esc(r[A_URL]) + '" title="Abrir a análise do acidente nº ' + esc(r[A_COD]) + '">' + miolo +
        '<span class="nc-af-p-ir" aria-hidden="true">' + ic('sair') + '</span></a></li>';
    }
    return '<li data-af-texto="' + texto + '"><button type="button" class="nc-af-p nc-ac-p" data-ac-tabela="' + esc(pessoa) + '" data-ac-col="COLABORADOR" title="Ver na tabela">' + miolo +
      '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }
  function linhaAfast(p) {
    var fora = p.dD ? dias(p.dD, P.hoje) + 1 : null, volta;
    if (!p.dR) volta = '<span class="nc-af-volta nc-af-volta--sem">Sem data de volta</span>';
    else if (p.dR < P.hoje) volta = '<span class="nc-af-volta nc-af-volta--atrasada">Volta era ' + curta(p.dR) + '</span>';
    else volta = '<span class="nc-af-volta nc-af-volta--logo">Volta prevista ' + esc(p.r) + '</span>';
    return '<li data-af-texto="' + esc(semAcento([p.n, p.c, p.s, p.t].join(' '))) + '"><button type="button" class="nc-af-p nc-ac-p" data-ac-tabela="' + esc(p.n) + '" data-ac-col="COLABORADOR" title="Ver os acidentes de ' + esc(nomeSo(p.n)) + ' na tabela">' +
      '<span class="nc-af-p-quem"><b>' + esc(p.n) + '</b><span>' + esc(nomeSo(p.c)) + ' · ' + esc(nomeSo(p.s)) + '</span></span>' +
      '<span class="nc-af-p-tipo">' + esc(nomeSo(p.t)) + '</span>' +
      '<span class="nc-af-p-desde">Desde ' + esc(p.d || '—') + (fora != null ? '<span>há ' + plural(fora, 'dia', 'dias') + '</span>' : '') + '</span>' +
      volta + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }
  function linhaEstab(p) {
    var falta = p.dA ? dias(P.hoje, p.dA) : null;
    var selo = '<span class="nc-af-volta nc-ac-selo-estab' + (falta != null && falta <= 30 ? ' is-acabando' : '') + '">Estável até ' + esc(p.a) + '</span>';
    return '<li data-af-texto="' + esc(semAcento([p.n, p.c, p.s, p.t].join(' '))) + '"><button type="button" class="nc-af-p nc-ac-p" data-ac-tabela="' + esc(p.n) + '" data-ac-col="COLABORADOR" title="Ver os acidentes de ' + esc(nomeSo(p.n)) + ' na tabela">' +
      '<span class="nc-af-p-quem"><b>' + esc(p.n) + '</b><span>' + esc(nomeSo(p.c)) + ' · ' + esc(nomeSo(p.s)) + '</span></span>' +
      '<span class="nc-af-p-tipo">Voltou de ' + esc(nomeSo(p.t)) + '</span>' +
      '<span class="nc-af-p-desde">Voltou em ' + esc(p.v || '—') + (falta != null ? '<span>' + (falta === 0 ? 'último dia hoje' : 'faltam ' + plural(falta, 'dia', 'dias')) + '</span>' : '') + '</span>' +
      selo + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }
  function procurar(box, q) {
    var r = box.querySelector('.nc-af-rolo'), lis = r.querySelectorAll('li'), t = semAcento(q.trim()), n = 0;
    if (!t) { desenharLista(); var p2 = P.caixa.querySelector('[data-ac-procura]'); if (p2) p2.focus(); return; }
    [].forEach.call(lis, function (li) { var ok = li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
    var bt = r.nextElementSibling; if (bt && bt.hasAttribute('data-af-revela')) bt.hidden = true;
    var nada = r.querySelector('.nc-af-nada'); if (nada) nada.remove();
    if (!n) r.insertAdjacentHTML('beforeend', '<p class="nc-af-nada">Ninguém nesta lista com “' + esc(q.trim()) + '”.</p>');
  }

  /* ── listas que vão aparecendo (a mesma mecânica do painel de afastamentos) ── */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-ac-unid="' + unid.join('|') + '"><' + tag + ' class="' + cls + '">' +
      itens.map(function (h, i) { return i < passo ? h : h.replace(/^<li/, '<li hidden'); }).join('') +
      '</' + tag + '><span class="nc-af-sentinela" aria-hidden="true"></span></div>' +
      (itens.length > passo ? '<button type="button" class="nc-af-mais" data-af-revela="' + passo + '"></button>' : '');
  }
  function escondidos(r) { return r.querySelectorAll('li[hidden]'); }
  function revelar(r, passo, foco) {
    var lis = [].slice.call(escondidos(r), 0, passo);
    lis.forEach(function (li) { li.hidden = false; });
    if (foco && lis[0]) { var b = lis[0].querySelector('button, a'); (b || lis[0]).focus({ preventScroll: true }); lis[0].scrollIntoView({ block: 'nearest', behavior: 'smooth' }); }
    contar(r);
  }
  function contar(r) {
    var bt = r.nextElementSibling; if (!bt || !bt.hasAttribute('data-af-revela')) return;
    var falta = escondidos(r).length, passo = +bt.getAttribute('data-af-revela'), u = r.getAttribute('data-ac-unid').split('|');
    bt.hidden = !falta;
    bt.textContent = 'Mostrar mais ' + Math.min(passo, falta) + ' · ' + (falta === 1 ? 'falta 1 ' + u[0] : 'faltam ' + num(falta) + ' ' + u[1]);
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

  /* ═══ [K5] NO PERÍODO ═══════════════════════════════════════════════════════════════════ */
  function desenharPeriodo() {
    var A = P.A, pe = A.pe, rot = P.per ? 'Nos últimos ' + PERIODOS.filter(function (x) { return x.m === P.per; })[0].t : 'Desde o primeiro registro';
    var seletor = '<div class="nc-ac-per" role="group" aria-label="Período do resumo">' + PERIODOS.map(function (x) {
      return '<button type="button" data-ac-per="' + x.m + '" aria-pressed="' + (x.m === P.per) + '">' + x.t + '</button>';
    }).join('') + '</div>';
    var frase;
    if (!pe.n && !pe.ocorr) frase = '<p class="nc-af-frase">Nenhum acidente neste período' + (A.filtrado ? ' com os filtros deste resumo' : '') + '.</p>';
    else {
      var det = [];
      if (pe.trajeto) det.push(plural(pe.trajeto, 'no trajeto', 'no trajeto'));
      if (pe.doenca) det.push(plural(pe.doenca, 'doença do trabalho', 'doenças do trabalho'));
      frase = '<p class="nc-af-frase">' + (pe.n ? '<b>' + plural(pe.n, 'acidente', 'acidentes') + '</b> com <b>' + plural(pe.pessoas, 'pessoa', 'pessoas') + '</b>' +
        (det.length ? ' (' + det.join(' e ') + ')' : '') + '. ' + (pe.afasta ? '<b>' + num(pe.afasta) + '</b> ' + (pe.afasta === 1 ? 'precisou' : 'precisaram') + ' se afastar.' : 'Nenhum precisou de afastamento.') : 'Nenhum acidente.') +
        (pe.ocorr ? ' Mais ' + plural(pe.ocorr, 'ocorrência registrada', 'ocorrências registradas') + ' (sem acidente).' : '');
      var extra = [];
      if (A.quadro && pe.pessoas) {
        var taxa = pe.pessoas / A.quadro * 1000;
        extra.push('De cada 1.000 pessoas do quadro, <b>' + (taxa < 0.1 ? 'menos de 0,1' : taxa.toLocaleString('pt-BR', { maximumFractionDigits: 1 })) + '</b> se acidentaram (' + plural(A.quadro, 'pessoa', 'pessoas') + ' no quadro' + (A.quadroFiltrado ? ' com estes filtros' : '') + ').');
      }
      if (P.per && A.antes != null) {
        var dif = pe.n - A.antes;
        extra.push('No período anterior, do mesmo tamanho: ' + plural(A.antes, 'acidente', 'acidentes') +
          (dif === 0 ? ' — igual.' : dif < 0 ? ' — <b class="nc-ac-melhor">' + plural(-dif, 'acidente a menos', 'acidentes a menos') + '</b> agora.' : ' — <b class="nc-ac-pior">' + plural(dif, 'acidente a mais', 'acidentes a mais') + '</b> agora.'));
      }
      if (extra.length) frase += '<span class="nc-af-taxa">' + extra.join(' ') + '</span>';
      frase += '</p>';
    }
    var temAlgo = pe.n || pe.ocorr;
    P.caixa.querySelector('.nc-af-periodo').innerHTML = '<div class="nc-ac-per-cab"><p class="nc-af-rot">' + rot + '</p>' + seletor + '</div>' + frase +
      (temAlgo ? '<div class="nc-af-quadros nc-af-quadros--3">' +
        quadro('Quando aconteceram', 'Acidentes em cada período · passe o mouse nas colunas', meses(A.meses, A.ini, P.hoje), 'nc-af-q--meses') +
        quadro('Que tipo de acidente', 'Toque para filtrar o resumo', barras(A.tipos, A.totTipos, ['registro', 'registros'])) +
        quadro('Em que dia e hora', 'Quanto mais escura a casa, mais acidentes', calor(A.calor, A.semHora)) +
        quadro('Onde mais acontece', 'Toque para filtrar o resumo', barras(A.onde, A.totOnde), '', verPor()) +
        quadro('Em que cargo', 'Os cargos com mais acidentes · toque para filtrar', barras(A.cargos, A.totCargos)) +
        quadro('Mais de uma vez', 'Pessoas que se acidentaram 2 vezes ou mais', A.repetem.length ? barras(A.repetem, 0) : '<p class="nc-af-vazio-q">Ninguém se acidentou mais de uma vez neste período.</p>') +
        '</div>' : '');
    ligarRolos(P.caixa.querySelector('.nc-af-periodo'));
    ajustarMeses();
  }
  function quadro(tit, dica, corpo, cls, extra) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3>' + (extra || '') + '<p>' + dica + '</p>' + corpo + '</section>'; }
  /* linha com "dim": tocar FILTRA o resumo e o botão pequeno leva para a tabela. Sem "dim" (pessoas):
     a linha inteira leva para a tabela. */
  function barras(xs, total, unid) {
    xs = xs || []; unid = unid || ['acidente', 'acidentes'];
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada neste período' + (P.A && P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    var iSel = -1; xs.forEach(function (x, i) { if (x.sel) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = total ? Math.round(x.q / total * 100) : null;
      var miolo = '<span class="nc-af-b-nome">' + (x.sel ? ic('marca') : '') + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1] || x.t) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? unid[0] : unid[1]) + (pct != null ? ' · ' + (pct < 1 ? '&lt;1' : pct) + '%' : '') + '</small></span>';
      if (!x.dim) {
        return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-ac-tabela="' + esc(x.t) + '" data-ac-col="COLABORADOR" title="Ver ' + esc(x.t) + ' na tabela">' + miolo +
          '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
      }
      var cls = (x.sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '') + (i === 0 && iSel < 0 ? ' is-maior' : '');
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra' + cls + '" data-ac-filtra="' + x.dim + '" data-ac-valor="' + esc(x.t) + '" aria-pressed="' + !!x.sel + '"' +
        ' title="' + (x.sel ? 'Tirar ' + esc(x.t) + ' do filtro' : iSel >= 0 ? 'Juntar ' + esc(x.t) + ' ao filtro' : 'Ver o resumo só de ' + esc(x.t)) + '">' + miolo + '</button>' +
        '<button type="button" class="nc-af-b-tab" data-ac-tabela="' + esc(textoBusca(x.dim, x.t)) + '" data-ac-col="' + (DIM[x.dim].col || '') + '" title="Ver ' + esc(x.t) + ' na tabela" aria-label="Ver ' + esc(x.t) + ' na tabela">' + ic('tabela') + '</button></li>';
    }), Math.max(POR_VEZ_Q, iSel + 1), ['linha', 'linhas']);
  }
  /* o local sem nome aparece como "1 - (sem nome)"; na tabela ele é "1 -" */
  function textoBusca(dim, t) { return dim === 'loc' ? String(t).replace(/ \(sem nome\)$/, '') : t; }

  /* MÊS A MÊS que se adapta ao período (o mesmo do painel de afastamentos): até 24 meses, por mês;
     até 72, por trimestre; acima, por ano */
  function meses(ms, ini, fim) {
    if (!ini || !fim) return '';
    var lista = [], c = new Date(ini.getFullYear(), ini.getMonth(), 1), ultimo = new Date(fim.getFullYear(), fim.getMonth(), 1);
    while (c <= ultimo && lista.length < 600) { lista.push(new Date(c)); c.setMonth(c.getMonth() + 1); }
    var nMes = lista.length, modo = nMes <= 24 ? 'mes' : nMes <= 72 ? 'tri' : 'ano', grupos = [], atual = P.hoje;
    lista.forEach(function (m) {
      var tri = Math.floor(m.getMonth() / 3) + 1;
      var k = modo === 'mes' ? chaveMes(m) : modo === 'tri' ? m.getFullYear() + 'T' + tri : String(m.getFullYear());
      var g = grupos[grupos.length - 1];
      if (!g || g.k !== k) {
        g = { k: k, v: 0, ano: m.getFullYear(),
              curto: modo === 'mes' ? MESES[m.getMonth()] : modo === 'tri' ? tri + 'º tri' : String(m.getFullYear()),
              dica: modo === 'mes' ? MESES[m.getMonth()] + '/' + m.getFullYear() : modo === 'tri' ? tri + 'º trimestre de ' + m.getFullYear() : String(m.getFullYear()),
              novoAno: modo !== 'ano' && (grupos.length === 0 || m.getMonth() < (modo === 'mes' ? 1 : 3)),
              marco: modo === 'ano' || grupos.length === 0 || (modo === 'mes' ? m.getMonth() % 3 === 0 : tri === 1),
              atual: m.getFullYear() === atual.getFullYear() && (modo === 'ano' || (modo === 'mes' ? m.getMonth() === atual.getMonth() : Math.floor(m.getMonth() / 3) === Math.floor(atual.getMonth() / 3))) };
        grupos.push(g);
      }
      g.v += ms[chaveMes(m)] || 0;
    });
    if (!grupos.some(function (g) { return g.v; })) return '<p class="nc-af-vazio-q">Nenhum acidente neste período.</p>';
    var max = Math.max.apply(null, grupos.map(function (g) { return g.v; })) || 1;
    var pico = grupos.reduce(function (a, g) { return g.v > a.v ? g : a; }, grupos[0]);
    var por = modo === 'mes' ? 'mês' : modo === 'tri' ? 'trimestre' : 'ano';
    return '<p class="nc-af-por">Por ' + por + '</p><ol class="nc-af-meses">' + grupos.map(function (g) {
      var rot = g.dica + ': ' + plural(g.v, 'acidente', 'acidentes');
      return '<li class="nc-af-mes' + (g.atual ? ' is-atual' : '') + (g.marco ? ' is-marco' : '') + (g === pico ? ' is-pico' : '') + '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '">' +
        '<b>' + (g.v ? num(g.v) : '') + '</b><i style="height:' + (g.v ? Math.max(4, Math.round(g.v / max * 100)) : 0) + '%"></i><span>' + g.curto + (g.novoAno ? '<em>' + g.ano + '</em>' : '') + '</span></li>';
    }).join('') + '</ol>' +
      '<p class="nc-af-pico">' + (modo === 'mes' ? 'Mês' : modo === 'tri' ? 'Trimestre' : 'Ano') + ' com mais: <b>' + pico.dica + '</b> · ' + plural(pico.v, 'acidente', 'acidentes') + '</p>';
  }
  function ajustarMeses() {
    var ol = P && P.caixa.querySelector('.nc-af-meses'); if (!ol || !ol.children.length) return;
    ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 34);
  }
  var tAj = 0;
  window.addEventListener('resize', function () { clearTimeout(tAj); tAj = setTimeout(ajustarMeses, 120); });
  function chaveMes(m) { return m.getFullYear() + '-' + ('0' + (m.getMonth() + 1)).slice(-2); }

  /* DIA E HORA: uma tabela de 7 dias × 4 partes do dia; a cor da casa é a quantidade. Embaixo, a
     frase com a casa que mais teve. Doença não entra (não tem hora); hora em branco fica de fora e
     é contada embaixo. */
  function calor(c, semHora) {
    var max = 0, top = null, tot = 0;
    for (var d = 0; d < 7; d++) for (var f = 0; f < 4; f++) { var v = c[d][f]; tot += v; if (v > max) { max = v; top = { d: d, f: f, v: v }; } }
    if (!tot) return '<p class="nc-af-vazio-q">Nenhum acidente com hora informada neste período.</p>';
    var ordem = [1, 2, 3, 4, 5, 6, 0];                 /* a semana começa na segunda */
    var html = '<table class="nc-ac-calor"><caption class="nc-af-vis">Acidentes por dia da semana e parte do dia</caption><thead><tr><th scope="col"><span class="nc-af-vis">Dia</span></th>' +
      FAIXAS.map(function (x) { return '<th scope="col" title="' + x.h + '">' + x.t + '<small>' + x.h + '</small></th>'; }).join('') + '</tr></thead><tbody>' +
      ordem.map(function (d) {
        return '<tr><th scope="row">' + SEM_CURTO[d] + '</th>' + c[d].map(function (v, f) {
          var p = max ? v / max : 0, rot = SEMANA[d] + ', ' + FAIXAS[f].t.toLowerCase() + ' (' + FAIXAS[f].h + '): ' + plural(v, 'acidente', 'acidentes');
          return '<td class="' + (v ? (p > .55 ? 'is-forte' : '') : 'is-zero') + (top && top.d === d && top.f === f ? ' is-topo' : '') + '" style="--v:' + p.toFixed(2) + '" title="' + rot + '"><span class="nc-af-vis">' + rot + '</span><b aria-hidden="true">' + (v || '') + '</b></td>';
        }).join('') + '</tr>';
      }).join('') + '</tbody></table>';
    return html + '<p class="nc-af-pico">Mais acidentes: <b>' + SEMANA[top.d] + ', ' + (top.f === 0 ? 'de madrugada' : top.f === 1 ? 'de manhã' : top.f === 2 ? 'à tarde' : 'à noite') + '</b> · ' + plural(top.v, 'acidente', 'acidentes') +
      (semHora ? '<span class="nc-ac-semhora">' + plural(semHora, 'acidente sem hora informada ficou', 'acidentes sem hora informada ficaram') + ' de fora.</span>' : '') + '</p>';
  }

  /* ═══ [K6] FILTRAR E CRUZAR ═════════════════════════════════════════════════════════════
     O servidor manda CADA acidente com as colunas em números (ac) e os nomes (dims); as contas são
     feitas aqui. O filtro guarda os NOMES, vários por coluna (P.f = { loc: ["6 - Açougue"] }).
     Dentro da coluna vale QUALQUER um; entre colunas, TODAS. A lista de uma coluna ignora o filtro
     dela mesma (mostra as outras opções, dá para trocar).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function filtrosIdx() {
    var fi = {}, dims = P.dados.dims || {};
    Object.keys(P.f).forEach(function (k) {
      var m = {}, ok = [];
      (P.f[k] || []).forEach(function (t) { var i = (dims[k] || []).indexOf(t); if (i >= 0) { m[i] = 1; ok.push(t); } });
      if (ok.length) { fi[k] = m; P.f[k] = ok; } else delete P.f[k];
    });
    return fi;
  }
  /* o acidente passa? ("sem" = a coluna cujo filtro não vale) */
  function passaA(r, fi, sem) {
    for (var k in fi) { if (k === sem) continue; if (!fi[k][r[DIM[k].i]]) return false; }
    return true;
  }
  /* a pessoa (afastados, estabilidade, quadro) passa? tipo e local não são da pessoa: não contam */
  function passaP(kk, fi) {
    for (var k in fi) { var c = DIM[k].p; if (c < 0) continue; if (!fi[k][kk[c]]) return false; }
    return true;
  }
  function agregar() {
    var d = P.dados, fi = filtrosIdx(), filtrado = Object.keys(fi).length > 0, hoje = P.hoje;
    var ini = P.per ? addMeses(hoje, -P.per) : null, iniAntes = P.per ? addMeses(hoje, -2 * P.per) : null;
    if (ini) ini.setDate(ini.getDate() + 1);
    var corte = addMeses(hoje, -PEND_MESES);
    var por = DIM[P.por] && P.por !== 'tipo' && P.por !== 'car' ? P.por : POR_PADRAO;
    var pe = { n: 0, pessoas: 0, trajeto: 0, doenca: 0, afasta: 0, ocorr: 0 }, vistos = {}, ms = {}, rep = {}, gT = {}, gO = {}, gC = {}, antes = 0;
    var cal = [0, 1, 2, 3, 4, 5, 6].map(function () { return [0, 0, 0, 0]; }), semHora = 0;
    var ultimo = null, recentes = [], semCat = [], pend = [], primeiro = null;
    function junta(g, v) { g[v] = (g[v] || 0) + 1; }
    P.ac.forEach(function (a) {
      var r = a.r, todos = !filtrado || passaA(r, fi);
      if (todos) {
        /* AGORA (não depende do período): o último típico, os recentes e as pendências dos últimos 24 meses */
        if (a.D && a.D <= hoje) {
          if (a.cl === 'tipico' && (!ultimo || a.D > ultimo.D)) ultimo = a;
          if (a.cl !== 'ocorr' && recentes.length < 400) recentes.push(a);
          if (a.D >= corte) {
            if (a.precisaCat && !a.temCat) semCat.push(a);
            if (a.pendente) pend.push(a);
          }
        }
        if (a.D && (!primeiro || a.D < primeiro)) primeiro = a.D;
      }
      if (!a.D || a.D > hoje || (ini && a.D < ini)) {
        if (todos && iniAntes && a.D && a.D >= iniAntes && a.D < ini && a.cl !== 'ocorr') antes++;
        return;
      }
      /* NO PERÍODO */
      if (todos) {
        if (a.cl === 'ocorr') pe.ocorr++;
        else {
          pe.n++;
          if (!vistos[r[A_PES]]) { vistos[r[A_PES]] = 1; pe.pessoas++; }
          if (a.cl === 'trajeto') pe.trajeto++;
          if (a.cl === 'doenca') pe.doenca++;
          if (a.afasta) pe.afasta++;
          junta(ms, chaveMes(a.D));
          rep[r[A_PES]] = (rep[r[A_PES]] || 0) + 1;
          if (a.cl !== 'doenca') { if (a.h >= 0) cal[a.D.getDay()][Math.floor(a.h / 6)]++; else semHora++; }
        }
      }
      if (todos || passaA(r, fi, 'tipo')) junta(gT, r[DIM.tipo.i]);
      if (a.cl !== 'ocorr') {
        if (todos || passaA(r, fi, por)) junta(gO, r[DIM[por].i]);
        if (todos || passaA(r, fi, 'car')) junta(gC, r[DIM.car.i]);
      }
    });
    function lista(g, dim) {
      var tot = 0;
      var xs = Object.keys(g).map(function (v) { tot += g[v]; return { t: ((d.dims || {})[dim] || [])[v], q: g[v], dim: dim, sel: !!(fi[dim] && fi[dim][v]) }; })
        .filter(function (x) { return x.t != null; })
        .sort(function (a, b) { return b.q - a.q || comparar(a.t, b.t); }).slice(0, 300);
      return { xs: xs, tot: tot };
    }
    var T = lista(gT, 'tipo'), O = lista(gO, por), C = lista(gC, 'car');
    var repetem = Object.keys(rep).filter(function (k) { return rep[k] >= 2; })
      .map(function (k) { return { t: (d.nomes || {})[k] || 'Pessoa ' + k, q: rep[k] }; })
      .sort(function (a, b) { return b.q - a.q || comparar(a.t, b.t); }).slice(0, 300);
    /* o quadro, com os filtros das colunas da pessoa */
    var quadro = d.quadro, qf = Object.keys(fi).some(function (k) { return DIM[k].p >= 0; });
    if (qf && d.quadroG) { quadro = 0; d.quadroG.forEach(function (r) { if (passaP(r, fi)) quadro += r[6]; }); }
    recentes.sort(function (a, b) { return b.D - a.D; });
    semCat.sort(function (a, b) { return b.D - a.D; });
    pend.sort(function (a, b) { return a.D - b.D; });
    var afast = (d.afast || []).filter(function (p) { return !filtrado || passaP(p.kk, fi); })
      .sort(function (a, b) { return (a.dD || 0) - (b.dD || 0); });
    var estab = (d.estab || []).filter(function (p) { return !filtrado || passaP(p.kk, fi); })
      .sort(function (a, b) { return (a.dA || 0) - (b.dA || 0); });
    return { fi: fi, filtrado: filtrado, por: por, pe: pe, ini: ini || primeiro || hoje, antes: P.per ? antes : null, meses: ms,
             tipos: T.xs, totTipos: T.tot, onde: O.xs, totOnde: O.tot, cargos: C.xs, totCargos: C.tot, repetem: repetem,
             calor: cal, semHora: semHora, quadro: quadro, quadroFiltrado: qf, ultimo: ultimo, recentes: recentes,
             listas: { afast: afast, estab: estab, semCat: semCat, pend: pend } };
  }

  /* a FAIXA "Filtrar este resumo": um botão por coluna, que abre a lista de marcar */
  function comparar(a, b) { return String(a).localeCompare(String(b), 'pt-BR', { numeric: true, sensitivity: 'base' }); }
  function desenharFiltros() {
    var box = P.caixa.querySelector('.nc-af-filtros'); if (!box) return;
    var d = P.dados, fi = P.A.fi, dims = d.dims || {}, n = Object.keys(fi).length;
    P.opc = {};
    if (P.nDims !== d) {                        /* quantos valores cada coluna tem, sem filtro (uma vez por dado) */
      P.nDims = d; P.nVal = {};
      DIMS.forEach(function (D) { var t = {}; P.ac.forEach(function (a) { t[a.r[D.i]] = 1; }); P.nVal[D.k] = Object.keys(t).length; });
    }
    var campos = DIMS.map(function (D) {
      var tem = {};
      P.ac.forEach(function (a) { if (passaA(a.r, fi, D.k)) tem[a.r[D.i]] = (tem[a.r[D.i]] || 0) + 1; });
      (P.f[D.k] || []).forEach(function (t) { var i = (dims[D.k] || []).indexOf(t); if (i >= 0 && !(i in tem)) tem[i] = 0; });
      var vs = Object.keys(tem).map(function (v) { return { t: (dims[D.k] || [])[v], n: tem[v] }; })
        .filter(function (x) { return x.t != null; }).sort(function (a, b) { return comparar(a.t, b.t); });
      P.opc[D.k] = vs;
      var esc_ = P.f[D.k] || [];
      if (P.nVal[D.k] < 2 && !esc_.length) return '';
      var aberto = P.pop && P.pop.k === D.k;
      return '<div class="nc-af-campo' + (esc_.length ? ' is-ativo' : '') + '"><span class="nc-af-campo-rot" id="nc-ac-rot-' + D.k + '">' + D.nome + '</span>' +
        '<button type="button" class="nc-af-escolha" data-ac-abre="' + D.k + '" aria-haspopup="true" aria-expanded="' + aberto + '" aria-controls="nc-ac-pop"' +
        ' aria-labelledby="nc-ac-rot-' + D.k + ' nc-ac-val-' + D.k + '"><span class="nc-af-escolha-txt" id="nc-ac-val-' + D.k + '">' +
        (esc_.length ? esc(esc_[0]) : D.todos) + '</span>' + (esc_.length > 1 ? '<b class="nc-af-mais-n" aria-label="e mais ' + (esc_.length - 1) + '">+' + (esc_.length - 1) + '</b>' : '') +
        ic('abrir') + '</button></div>';
    }).join('');
    var chips = Object.keys(fi).map(function (k) {
      var t = P.f[k], tudo = t.join(', ');
      return '<button type="button" class="nc-af-chip" data-ac-tira="' + k + '" title="Tirar este filtro: ' + esc(tudo) + '" aria-label="Tirar o filtro ' + esc(DIM[k].nome + ': ' + tudo) + '">' +
        '<span>' + DIM[k].nome + '</span><b>' + esc(t[0]) + '</b>' + (t.length > 1 ? '<em>+' + (t.length - 1) + '</em>' : '') + ic('tirar') + '</button>';
    }).join('');
    box.hidden = !campos && !n;
    box.classList.toggle('is-ativo', n > 0);
    box.innerHTML = '<div class="nc-af-filtros-cab">' + ic('filtro') + '<p class="nc-af-filtros-tit">Filtrar este resumo</p>' +
      '<p class="nc-af-filtros-nota">' + (n ? 'A tabela abaixo continua com os filtros da página.' : 'Escolha um ou mais em cada caixa. A tabela abaixo não muda.') + '</p>' +
      (n ? '<button type="button" class="nc-af-limpa" data-ac-limpa>' + ic('tirar') + '<span>' + (n === 1 ? 'Limpar o filtro' : 'Limpar os ' + n + ' filtros') + '</span></button>' : '') +
      '</div><div class="nc-af-filtros-campos">' + campos + '</div>' +
      (n ? '<div class="nc-af-filtros-chips"><span class="nc-af-filtros-chips-rot">Resumo só de:</span>' + chips + '</div>' : '');
  }
  function abrirLista(k) {
    fecharLista(false);
    var pop = P.caixa.querySelector('.nc-af-pop');
    if (!pop) { pop = el('div', 'nc-af-pop'); pop.id = 'nc-ac-pop'; pop.setAttribute('role', 'dialog'); pop.hidden = true; P.caixa.appendChild(pop); }
    var D = DIM[k], vs = P.opc[k] || [], esc_ = P.f[k] || [];
    var ordem = vs.filter(function (x) { return esc_.indexOf(x.t) >= 0; }).concat(vs.filter(function (x) { return esc_.indexOf(x.t) < 0; }));
    pop.setAttribute('aria-label', D.nome);
    pop.innerHTML = '<div class="nc-af-pop-cab"><b>' + D.nome + '</b><span>marque um ou mais</span></div>' +
      (vs.length > 8 ? '<label class="nc-af-procura nc-af-pop-busca">' + ic('busca') + '<span class="nc-af-vis">Procurar em ' + D.nome + '</span>' +
        '<input type="search" placeholder="Procurar código ou nome" data-ac-pop-busca autocomplete="off"></label>' : '') +
      '<ul class="nc-af-pop-lista">' + ordem.map(function (x) {
        return '<li data-af-texto="' + esc(semAcento(x.t)) + '"><label><input type="checkbox" data-ac-marca value="' + esc(x.t) + '"' + (esc_.indexOf(x.t) >= 0 ? ' checked' : '') + '>' +
          '<span>' + esc(x.t) + '</span>' + (x.n ? '<small title="acidentes">' + num(x.n) + '</small>' : '') + '</label></li>';
      }).join('') + '</ul><p class="nc-af-pop-nada" hidden>Nada com esse nome.</p>' +
      '<div class="nc-af-pop-pe"><button type="button" class="nc-af-limpa" data-ac-pop-limpa>Desmarcar todos</button>' +
      '<button type="button" class="nc-af-bt nc-af-bt--cheio" data-ac-pronto>Pronto</button></div>';
    P.pop = { k: k, el: pop };
    pop.hidden = false;
    posicionarLista();
    marcarLista();
    var foco = pop.querySelector('[data-ac-pop-busca]') || pop.querySelector('[data-ac-marca]');
    if (foco) foco.focus({ preventScroll: true });
    var busca = pop.querySelector('[data-ac-pop-busca]');
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
    var b = P.caixa.querySelector('[data-ac-abre="' + k + '"]');
    if (b) { b.setAttribute('aria-expanded', 'false'); if (devolve) b.focus({ preventScroll: true }); }
  }
  function posicionarLista() {
    if (!P.pop) return;
    var b = P.caixa.querySelector('[data-ac-abre="' + P.pop.k + '"]');
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
    var esc_ = P.f[P.pop.k] || [];
    [].forEach.call(P.pop.el.querySelectorAll('[data-ac-marca]'), function (x) { x.checked = esc_.indexOf(x.value) >= 0; });
  }
  document.addEventListener('mousedown', function (e) {
    if (P && P.pop && !P.pop.el.contains(e.target) && !e.target.closest('[data-ac-abre]')) fecharLista(false);
  }, true);
  document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && P && P.pop) { e.preventDefault(); fecharLista(true); } });
  window.addEventListener('resize', function () { if (P && P.pop) posicionarLista(); });

  /* o "por" do quadro "Onde mais acontece" (cargo e tipo têm quadro próprio) */
  function verPor() {
    return '<label class="nc-af-ver-por"><span>por</span><select data-ac-por aria-label="Onde mais acontece: ver por">' +
      DIMS.filter(function (D) { return D.k !== 'tipo' && D.k !== 'car'; }).map(function (D) {
        return '<option value="' + D.k + '"' + (D.k === P.A.por ? ' selected' : '') + '>' + (D.curto || D.nome) + '</option>';
      }).join('') + '</select></label>';
  }
  function mudou(e) {
    var s = e.target;
    if (s.matches('[data-ac-marca]') && P.pop) {
      var k = P.pop.k, l = (P.f[k] || []).filter(function (t) { return t !== s.value; });
      if (s.checked) l.push(s.value);
      if (l.length) P.f[k] = l; else delete P.f[k];
      redesenhar({ pop: true });
    } else if (s.matches('select[data-ac-por]')) {
      P.por = s.value;
      try { if (s.value === POR_PADRAO) localStorage.removeItem(GUARDA_POR); else localStorage.setItem(GUARDA_POR, s.value); } catch (e2) { /* ok */ }
      redesenhar({ attr: 'data-ac-por', v: '' });
    }
  }
  function alternar(k, t) {
    var l = P.f[k] || [], i = l.indexOf(t);
    if (i >= 0) l.splice(i, 1); else l.push(t);
    if (l.length) P.f[k] = l; else delete P.f[k];
    redesenhar({ attr: 'data-ac-valor', v: t });
  }
  function refocar(f) {
    if (f.pop) { posicionarLista(); return; }
    var alvo = null;
    if (f.attr) [].some.call(P.caixa.querySelectorAll('[' + f.attr + ']'), function (x) { if (!f.v || x.getAttribute(f.attr) === f.v) { alvo = x; return true; } return false; });
    if (!alvo && f.depois) alvo = P.caixa.querySelector(f.depois);
    if (!alvo) return;
    var li = alvo.closest('li'); if (li && li.hidden) li.hidden = false;
    alvo.focus({ preventScroll: true });
  }

  /* ═══ [K7] VER NA TABELA ════════════════════════════════════════════════════════════════
     Usa a PRÓPRIA busca do relatório, só na coluna certa (o mesmo que escolher a coluna na lupa e
     digitar). Coluna que o relatório não mostra (ex.: Unidade Adm.): a busca vai em todas.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function colunaDaBusca(pre, col) {
    var h = document.getElementById(pre + '_column_search_current_column'), f = document.getElementById(pre + '_search_field');
    if (!h || !f) return null;
    var D = DIMS.filter(function (x) { return x.col === col; })[0], tit = col === 'COLABORADOR' ? 'Colaborador' : D && D.tit;
    var visivel = tit && [].some.call(document.querySelectorAll('#' + pre + ' .a-IRR-table th'), function (th) { return th.textContent.trim() === tit; });
    var rot = visivel ? 'Pesquisar: ' + tit : '';
    h.value = visivel ? col : '';
    f.setAttribute('placeholder', rot); f.setAttribute('title', rot || 'Pesquisar');
    return visivel ? tit : null;
  }
  function naTabela(texto, col) {
    var ir = relatorio(), pre = ir && ir.id;
    var f = pre && document.getElementById(pre + '_search_field'), b = pre && document.getElementById(pre + '_search_button');
    if (!f || !b) return irParaTabela();
    P.quando.textContent = 'Filtrando a tabela…';
    irParaTabela();
    var t0 = Date.now();
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      var nomeCol = colunaDaBusca(pre, col);
      f.value = texto;
      b.click();
      P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>' + (nomeCol ? ' (na coluna ' + esc(nomeCol) + ')' : '') +
        '. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
    })();
  }
  function irParaTabela() {
    var ir = relatorio(); if (!ir) return;
    ir.el.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [K8] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncAcidIniciou) return; if (montar()) { window.__ncAcidIniciou = true; buscar(); } }
  window.__ncAcidDesenhar = function (d) { if (montar()) desenhar(d, Date.now()); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
