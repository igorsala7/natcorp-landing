/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · HEADCOUNT  —  o painel de resumo das posições (JavaScript)                     ║
   ║  App 200 · Página 30 (Headcount — consulta das posições/vagas)                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: POSICOES-MANUTENCAO.md. A roupa é a MESMA do painel de afastamentos
   (Natcorp_Posicoes.css = cópia do Natcorp_Afastamentos.css; as peças só daqui são .nc-hc-*).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima do relatório, um RESUMO do quadro de posições (o "headcount aprovado"), escrito do jeito
   que se fala, para quem controla o quadro (RH, DP, gestor):
     AGORA        Quadro aprovado (ocupadas × vagas) · Vagas abertas · Trabalhando sem posição ·
                  Mais de uma pessoa na posição · Cadastro a conferir. Tocar num número mostra
                  QUAIS são, já na ordem que importa; tocar numa posição ABRE a ficha dela (página 31).
     ONDE ESTÃO   aprovado × ocupado por hierarquia (ou filial, cargo, função…), a situação das
                  posições, as vagas há mais tempo, os cargos com mais vagas e a liderança.
     FILTRAR      "Filtrar este resumo" e tocar numa barra deixam o resumo inteiro só com aquilo.
   Os dados vêm do servidor (processo NC_POSICOES_INDICADORES) com as MESMAS regras do relatório.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda o relatório, não grava nada. Os filtros feitos DENTRO do relatório (menu Ações)
       não entram nos números.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 30 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Posicoes.js
     Página 30 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Posicoes.css
     Página 30 › Processing › Ajax Callback NC_POSICOES_INDICADORES  (NC_POSICOES_INDICADORES.plsql.sql)
   Tudo já vem na exportação f200_page_30.sql (aplicar-posicoes-pagina30.py), com o Static ID "IR".

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [H1] Textos e regras ................. frases, ícones, o que é "vaga", "a conferir"   PODE MEXER
     [H2] Os dados ........................ chamada ao servidor                        CUIDADO
     [H3] A moldura ....................... título, esconder/mostrar, carregando, erro
     [H4] Agora ........................... os 5 números e a lista "quais são"         PODE MEXER
     [H5] Onde estão ...................... frase, aprovado × ocupado, situação, vagas, cargos, liderança
     [H6] Filtrar e cruzar ................ as colunas, as contas na tela, a lista de marcar
     [H7] Ver na tabela ................... a busca do próprio relatório, na coluna certa
     [H8] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncPosicoes) return;
  window.__ncPosicoes = true;

  /* ═══ [H1] TEXTOS E REGRAS ══════════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_POSICOES_INDICADORES';
  var ITENS = ['P30_EMP', 'P30_FILIAL', 'P30_CCUSTO'];
  var POR_VEZ = 30;
  var POR_VEZ_Q = 6;
  var VAGA_VELHA = 60;                    /* vaga aberta há mais de 60 dias: o selo fica âmbar */
  var GUARDA = 'nc-hc-aberto';
  var GUARDA_POR = 'nc-hc-por';
  var VALIDADE = 10 * 60 * 1000;

  /* as colunas que o resumo sabe filtrar e cruzar. "i" = a posição em cada posição (pos), a MESMA
     ordem do NC_POSICOES_INDICADORES; "p" = a posição no "k" de quem trabalha sem posição
     (emp, fil, cc, car, vin; -1 = não vale para pessoa); "col" = a coluna do relatório */
  var DIMS = [
    { k: 'emp', i: 0, p: 0,  col: 'EMPRESA_DESC',       tit: 'Empresa',          nome: 'Empresa',           todos: 'Todas' },
    { k: 'fil', i: 1, p: 1,  col: 'FILIAL_DESC',        tit: 'Filial',           nome: 'Filial',            todos: 'Todas' },
    { k: 'cc',  i: 2, p: 2,  col: 'CCUSTO_DESC',        tit: 'Hierarquia',       nome: 'Hierarquia',        todos: 'Todas' },
    { k: 'cct', i: 3, p: -1, col: 'CCUSTO_CONTAB_DESC', tit: 'C.Custo Contábil', nome: 'C. Custo Contábil', todos: 'Todos', curto: 'C. custo contábil' },
    { k: 'car', i: 4, p: 3,  col: 'CARGO_DESC',         tit: 'Cargo',            nome: 'Cargo',             todos: 'Todos' },
    { k: 'fun', i: 5, p: -1, col: 'FUNCAO_DESC',        tit: 'Função',           nome: 'Função',            todos: 'Todas' },
    { k: 'vin', i: 6, p: 4,  col: 'VINCULO',            tit: 'Vínculo',          nome: 'Vínculo',           todos: 'Todos' },
    { k: 'sit', i: 7, p: -1, col: 'SIT_VAGA',           tit: 'Situação da Vaga', nome: 'Situação da posição', todos: 'Todas' }
  ];
  var DIM = {}; DIMS.forEach(function (x) { DIM[x.k] = x; });
  var POR_PADRAO = 'cc';                  /* "Aprovado e ocupado" abre por hierarquia */
  /* posições em cada "pos", depois das 8 colunas */
  var X_VAGA = 8, X_DISP = 9, X_COMP = 10, X_GEST = 11, X_REQ = 12, X_INI = 13, X_FIM = 14, X_OCUP = 15, X_SAIU = 16;

  var AGORA = [
    { k: 'quadro',  cor: 'roxo',     ic: 'quadro',  diz: 'Posições aprovadas' },
    { k: 'vagas',   cor: 'verde',    ic: 'cadeira', diz: 'Vagas abertas',                dica: 'posição ativa sem ninguém: pode contratar' },
    { k: 'sem',     cor: 'vermelho', ic: 'pessoa',  diz: 'Trabalhando sem posição',      dica: 'fora do quadro aprovado', alerta: true },
    { k: 'acima',   cor: 'vermelho', ic: 'duas',    diz: 'Mais de uma pessoa na posição', dica: 'posição não compartilhada', alerta: true },
    { k: 'conferir', cor: 'ambar',   ic: 'lupa',    diz: 'Cadastro a conferir',          dica: 'a posição diz uma coisa, a realidade outra', alerta: true }
  ];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    quadro: '<rect x="3.5" y="4.5" width="7" height="6" rx="1.5"/><rect x="13.5" y="4.5" width="7" height="6" rx="1.5"/><rect x="3.5" y="13.5" width="7" height="6" rx="1.5"/><rect x="13.5" y="13.5" width="7" height="6" rx="1.5" stroke-dasharray="2.2 1.8"/>',
    cadeira: '<path d="M7 4h10v8H7z"/><path d="M5 12h14M7 12v8M17 12v8"/>',
    pessoa: '<circle cx="12" cy="8" r="3.4"/><path d="M5.5 20c.7-3.6 3.2-5.6 6.5-5.6s5.8 2 6.5 5.6"/><path d="M18 4l3 3M21 4l-3 3"/>',
    duas: '<circle cx="8.5" cy="9" r="3"/><circle cx="15.5" cy="9" r="3"/><path d="M3 19.5c.6-3 2.7-4.7 5.5-4.7s4.9 1.7 5.5 4.7M10 19.5c.6-3 2.7-4.7 5.5-4.7s4.9 1.7 5.5 4.7"/>',
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
  function pct(a, b) { return b ? Math.round(a / b * 100) : 0; }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function partes(t) { var m = /^(\S+)\s+-\s*(.*)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }
  function nomeSo(t) { return partes(t)[1] || t || ''; }
  function comparar(a, b) { return String(a).localeCompare(String(b), 'pt-BR', { numeric: true, sensitivity: 'base' }); }

  /* ═══ [H2] OS DADOS ═════════════════════════════════════════════════════════════════════ */
  function valor(i) { return document.getElementById(i) && window.apex && apex.item ? (apex.item(i).getValue() || '') : ''; }
  function chaveCache() { return 'nc-hc-dados1:' + ITENS.map(valor).join('|'); }
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
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [H3] A MOLDURA ═══════════════════════════════════════════════════════════════════ */
  var P = null;
  function relatorio() {
    var r = document.getElementById('IR');
    if (r) return { el: r, id: 'IR' };
    var w = document.querySelector('.a-IRR-container');
    r = w && w.closest('.t-Region, .t-IRR-region, [id^="R"]');
    return r ? { el: r, id: r.id } : null;
  }
  function marcarRelatorio() { var r = relatorio(); if (r) r.el.classList.add('nc-reg-sim'); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  function montar() {
    if (P) return true;
    var ir = relatorio();
    if (!ir) return false;
    var caixa = el('section', 'nc-af nc-hc');
    caixa.setAttribute('aria-labelledby', 'nc-hc-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-hc-titulo">Resumo do quadro de posições</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-hc-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-hc-esconde aria-controls="nc-hc-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-hc-corpo"></div>';
    ir.el.parentNode.insertBefore(caixa, ir.el);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-hc-esconde]'),
          filtro: null, f: {}, por: POR_PADRAO };
    try { var por = localStorage.getItem(GUARDA_POR); if (DIM[por] && por !== 'sit') P.por = por; } catch (e) { /* ok */ }
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
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-hc-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-hc-num')) { var k = b.getAttribute('data-hc-num'); P.filtro = P.filtro === k ? null : k; desenharAgora(); return; }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-hc-filtra')) { alternar(b.getAttribute('data-hc-filtra'), b.getAttribute('data-hc-valor')); return; }
    if (b.hasAttribute('data-hc-tira')) { delete P.f[b.getAttribute('data-hc-tira')]; redesenhar({ attr: 'data-hc-tira', v: Object.keys(P.f)[0] || null, depois: '.nc-af-filtros-campos [data-hc-abre]' }); return; }
    if (b.hasAttribute('data-hc-limpa')) { P.f = {}; redesenhar({ attr: null, depois: '.nc-af-filtros-campos [data-hc-abre]' }); return; }
    if (b.hasAttribute('data-hc-abre')) { var ab = b.getAttribute('data-hc-abre'); if (P.pop && P.pop.k === ab) fecharLista(true); else abrirLista(ab); return; }
    if (b.hasAttribute('data-hc-pronto')) { fecharLista(true); return; }
    if (b.hasAttribute('data-hc-pop-limpa')) { delete P.f[P.pop.k]; redesenhar({ pop: true }); marcarLista(); return; }
    if (b.hasAttribute('data-hc-tabela')) { naTabela(b.getAttribute('data-hc-tabela'), b.getAttribute('data-hc-col')); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-hc-tenta') || b.hasAttribute('data-hc-atualiza')) buscar(true);
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
  function carregando() {
    var regua = AGORA.map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('');
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">Agora</p><div class="nc-af-regua">' + regua + '</div></div>' +
      '<div class="nc-af-secao nc-af-periodo"><i class="nc-af-esq" style="width:60%;height:16px"></i><div class="nc-af-quadros nc-af-quadros--3" style="margin-top:14px">' +
      '<div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div></div></div>';
    P.quando.textContent = 'Calculando…';
    P.caixa.querySelector('[data-hc-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(['Buscando as posições…', 'Vendo quem ocupa cada posição…', 'Procurando quem trabalha sem posição…', 'Ainda calculando: com muitas posições leva mais tempo']);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_POSICOES|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia POSICOES-MANUTENCAO.md). A tabela abaixo funciona normalmente.'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-hc-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [H4] AGORA ════════════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    var hoje = data(d.hoje) || new Date();
    hoje = new Date(hoje.getFullYear(), hoje.getMonth(), hoje.getDate());
    var sits = (d.dims && d.dims.sit) || [], urls = d.urls || {}, oc = d.oc || {};
    /* cada posição vira um objeto com o que as contas usam */
    P.pos = (d.pos || []).map(function (r, i) {
      var ativa = semAcento(sits[r[7]]) === 'ativa', ocup = r[X_OCUP] || 0, comp = r[X_COMP] === 1;
      var fim = dataYmd(r[X_FIM]), ini = dataYmd(r[X_INI]), saiu = dataYmd(r[X_SAIU]);
      var p = { r: r, i: i, ativa: ativa, ocup: ocup, comp: comp, url: urls[i] || '', gente: oc[i] || [], fim: fim, ini: ini };
      p.vaga = ativa && ocup === 0;
      /* aberta desde: a última saída; sem saída, o início da posição */
      p.desde = p.vaga ? (saiu && (!ini || saiu > ini) ? saiu : ini) : null;
      p.diasVaga = p.desde ? Math.max(0, dias(p.desde, hoje)) : null;
      p.acima = ativa && ocup >= 2 && !comp;
      /* o que está para conferir, em palavras */
      var mot = [];
      if (ativa && r[X_DISP] === 1 && ocup > 0) mot.push('marcada "disponível", mas tem ' + plural(ocup, 'pessoa', 'pessoas'));
      if (ativa && r[X_DISP] === 0 && ocup === 0) mot.push('marcada "não disponível", mas está vazia');
      if (ativa && fim && fim < hoje) mot.push('ativa, mas a data fim já passou (' + dma(fim) + ')');
      if (!ativa && ocup > 0) mot.push((nomeSo(sits[r[7]]) || 'inativa').toLowerCase() + ', mas tem ' + plural(ocup, 'pessoa', 'pessoas'));
      p.conferir = mot;
      return p;
    });
    (d.sem && d.sem.lista || []).forEach(function (s) { s.kk = String(s.k || '').split(',').map(Number); });
    P.dados = d; P.hoje = hoje; P.filtro = null;
    P.hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.caixa.querySelector('[data-hc-atualiza]').hidden = false;
    P.corpo.innerHTML =
      '<div class="nc-af-filtros" role="group" aria-label="Filtrar este resumo" hidden></div>' +
      '<div class="nc-af-secao"><p class="nc-af-rot">Agora</p><div class="nc-af-regua" role="group" aria-label="O quadro de posições agora"></div>' +
      '<div class="nc-af-quem" id="nc-hc-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    redesenhar();
  }
  function redesenhar(foco) {
    if (P.pop && !(foco && foco.pop)) fecharLista(false);
    P.A = agregar();
    var n = Object.keys(P.A.fi).length;
    P.quando.innerHTML = 'Hoje, <b>' + esc(P.dados.hoje) + '</b>' + (n ? ' · com <b>' + plural(n, 'filtro', 'filtros') + ' deste resumo</b>' : '') + (P.hm ? ' · calculado às ' + P.hm : '');
    desenharFiltros();
    desenharAgora();
    desenharOnde();
    if (foco) refocar(foco);
  }
  function desenharAgora() {
    var A = P.A;
    P.caixa.querySelector('.nc-af-regua').innerHTML = AGORA.map(function (h) {
      var v, dica = h.dica, on = P.filtro === h.k, extra = '', unid;
      if (h.k === 'quadro') {
        v = A.ativas.length;
        dica = num(A.ocupadas) + ' ocupadas · ' + num(A.vagas.length) + ' vagas';
        extra = '<span class="nc-hc-ocupa" aria-hidden="true"><i style="width:' + pct(A.ocupadas, v) + '%"></i></span>' +
          '<span class="nc-hc-ocupa-txt">' + pct(A.ocupadas, v) + '% preenchido</span>';
        unid = ['posição', 'posições'];
      } else if (h.k === 'sem') { v = A.semTotal; unid = ['pessoa', 'pessoas']; }
      else { v = (A.listas[h.k] || []).length; unid = ['posição', 'posições']; }
      return '<button type="button" class="nc-af-num nc-af-num--' + h.cor + (v ? '' : ' is-zero') + (h.alerta && v ? ' is-alerta' : '') + '" data-hc-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-hc-quem"' + (v ? '' : ' disabled') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor">' + num(v) + '<small>' + (v === 1 ? unid[0] : unid[1]) + '</small></span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + dica + '</span>' + extra + '</button>';
    }).join('');
    desenharLista();
  }

  var CAB = {
    quadro:   { t: 'Posições aprovadas (ativas)', o: 'as vagas primeiro · toque para abrir a posição' },
    vagas:    { t: 'Vagas abertas', o: 'a que está vaga há mais tempo primeiro · toque para abrir a posição' },
    sem:      { t: 'Trabalhando sem posição', o: 'colaboradores ativos sem posição, ou com uma posição que não existe nesta filial · corrija na ficha da pessoa (Dados Funcionais)' },
    acima:    { t: 'Mais de uma pessoa na posição', o: 'posições não compartilhadas com 2 pessoas ou mais · toque para abrir a posição' },
    conferir: { t: 'Cadastro a conferir', o: 'o motivo está em cada linha · toque para abrir a posição e corrigir' }
  };
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro) { box.hidden = true; box.innerHTML = ''; return; }
    var k = P.filtro, c = CAB[k], xs, linhas, unid;
    if (k === 'sem') { xs = P.A.sem; unid = ['pessoa', 'pessoas']; linhas = xs.map(linhaSem); }
    else {
      xs = k === 'quadro' ? P.A.ativas.slice().sort(function (a, b) { return (b.vaga - a.vaga) || ((b.diasVaga || 0) - (a.diasVaga || 0)); }) : P.A.listas[k] || [];
      unid = ['posição', 'posições']; linhas = xs.map(function (p) { return linhaPos(p, k); });
    }
    var total = k === 'sem' ? P.A.semTotal : xs.length;
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + c.t + ': ' + plural(total, unid[0], unid[1]) + '</h3><p>' + c.o + '</p>' +
      (xs.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar cargo, filial, hierarquia ou nº" data-hc-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', linhas, POR_VEZ, unid) +
      (k === 'sem' && P.dados.cortou ? '<p class="nc-af-nota">A lista mostra as primeiras ' + num(P.A.sem.length) + ' pessoas de ' + num(P.A.semTotal) + '.</p>' : '');
    ligarRolos(box);
    var pr = box.querySelector('[data-hc-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value); });
  }
  function rotulo(dim, i) { return ((P.dados.dims || {})[dim] || [])[i]; }
  /* uma posição: nº e cargo · onde · desde quando · o selo · abrir */
  function linhaPos(p, lista) {
    var r = p.r, cargo = rotulo('car', r[4]), fun = rotulo('fun', r[5]), fil = rotulo('fil', r[1]), cc = rotulo('cc', r[2]);
    var selo, quando;
    if (lista === 'conferir') selo = '<span class="nc-af-volta nc-af-volta--sem nc-hc-motivo">' + esc(p.conferir.join(' · ')) + '</span>';
    else if (lista === 'acima') selo = '<span class="nc-af-volta nc-af-volta--atrasada">' + plural(p.ocup, 'pessoa', 'pessoas') + ' na mesma posição</span>';
    else if (p.vaga) selo = '<span class="nc-af-volta ' + (p.diasVaga > VAGA_VELHA ? 'nc-af-volta--sem' : 'nc-af-volta--logo') + '">' + (p.diasVaga != null ? 'Vaga há ' + plural(p.diasVaga, 'dia', 'dias') : 'Vaga') + '</span>';
    else selo = '<span class="nc-af-volta">' + (p.ocup > 1 ? plural(p.ocup, 'pessoa', 'pessoas') : 'Ocupada') + '</span>';
    if (lista === 'acima' && p.gente.length) quando = '<span class="nc-af-p-desde nc-hc-gente">' + p.gente.map(function (g) { return '<span>' + esc(g) + '</span>'; }).join('') + '</span>';
    else quando = '<span class="nc-af-p-desde">' + (r[X_REQ] ? 'Requisição ' + esc(r[X_REQ]) : p.vaga ? '<span class="nc-hc-semreq">sem requisição</span>' : '') +
      (p.desde ? '<span>aberta desde ' + dma(p.desde) + '</span>' : '') + '</span>';
    var miolo = '<span class="nc-af-p-quem"><b>Posição ' + esc(r[X_VAGA]) + ' · ' + esc(nomeSo(cargo)) + '</b><span>' + esc(nomeSo(fil)) + ' · ' + esc(nomeSo(cc)) + '</span></span>' +
      '<span class="nc-af-p-tipo">' + esc(nomeSo(fun)) + (r[X_GEST] === 1 ? '<span class="nc-hc-gestor">posição de gestor</span>' : '') + '</span>' + quando + selo;
    var texto = esc(semAcento([r[X_VAGA], cargo, fun, fil, cc, (p.gente || []).join(' ')].join(' ')));
    if (p.url) return '<li data-af-texto="' + texto + '"><a class="nc-af-p nc-hc-p" href="' + esc(p.url) + '" title="Abrir a posição ' + esc(r[X_VAGA]) + '">' + miolo + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('sair') + '</span></a></li>';
    return '<li data-af-texto="' + texto + '"><button type="button" class="nc-af-p nc-hc-p" data-hc-tabela="' + esc(r[X_VAGA]) + '" data-hc-col="COD_VAGA" title="Ver a posição ' + esc(r[X_VAGA]) + ' na tabela">' + miolo + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }
  function linhaSem(s) {
    return '<li data-af-texto="' + esc(semAcento([s.n, s.c, s.s, s.f].join(' '))) + '"><div class="nc-af-p nc-hc-p is-leitura">' +
      '<span class="nc-af-p-quem"><b>' + esc(s.n) + '</b><span>' + esc(nomeSo(s.c)) + '</span></span>' +
      '<span class="nc-af-p-tipo">' + esc(nomeSo(s.f)) + '</span><span class="nc-af-p-desde">' + esc(nomeSo(s.s)) + '</span>' +
      '<span class="nc-af-volta nc-af-volta--atrasada">Sem posição</span><span></span></div></li>';
  }
  function procurar(box, q) {
    var r = box.querySelector('.nc-af-rolo'), lis = r.querySelectorAll('li'), t = semAcento(q.trim()), n = 0;
    if (!t) { desenharLista(); var p2 = P.caixa.querySelector('[data-hc-procura]'); if (p2) p2.focus(); return; }
    [].forEach.call(lis, function (li) { var ok = li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
    var bt = r.nextElementSibling; if (bt && bt.hasAttribute('data-af-revela')) bt.hidden = true;
    var nada = r.querySelector('.nc-af-nada'); if (nada) nada.remove();
    if (!n) r.insertAdjacentHTML('beforeend', '<p class="nc-af-nada">Nada nesta lista com “' + esc(q.trim()) + '”.</p>');
  }

  /* ── listas que vão aparecendo (a mesma mecânica dos outros painéis) ── */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-hc-unid="' + unid.join('|') + '"><' + tag + ' class="' + cls + '">' +
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
    var falta = escondidos(r).length, passo = +bt.getAttribute('data-af-revela'), u = r.getAttribute('data-hc-unid').split('|');
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

  /* ═══ [H5] ONDE ESTÃO ═══════════════════════════════════════════════════════════════════ */
  function desenharOnde() {
    var A = P.A, at = A.ativas.length;
    var frase = '<p class="nc-af-frase">' + (at ? '<b>' + plural(at, 'posição ativa', 'posições ativas') + '</b>: <b>' + plural(A.ocupadas, 'ocupada', 'ocupadas') + '</b> e <b>' +
        plural(A.vagas.length, 'vaga', 'vagas') + '</b> — ' + pct(A.ocupadas, at) + '% do quadro preenchido.' : 'Nenhuma posição ativa' + (A.filtrado ? ' com estes filtros' : '') + '.') +
      (A.suspensas || A.extintas ? ' Além delas, ' + [A.suspensas ? plural(A.suspensas, 'suspensa', 'suspensas') : '', A.extintas ? plural(A.extintas, 'extinta', 'extintas') : ''].filter(Boolean).join(' e ') + '.' : '');
    var extra = [];
    if (A.vagas.length) extra.push(A.comReq ? plural(A.comReq, 'vaga já tem', 'vagas já têm') + ' requisição; ' + plural(A.vagas.length - A.comReq, 'ainda não tem', 'ainda não têm') + '.' : 'Nenhuma vaga tem requisição ainda.');
    if (A.semTotal) extra.push('<b class="nc-ac-pior">' + plural(A.semTotal, 'pessoa trabalha', 'pessoas trabalham') + ' sem posição</b> (fora do quadro aprovado).');
    if (A.excesso) extra.push('<b class="nc-ac-pior">' + plural(A.excesso, 'pessoa a mais', 'pessoas a mais') + '</b> em posições não compartilhadas.');
    if (extra.length) frase += '<span class="nc-af-taxa">' + extra.join(' ') + '</span>';
    frase += '</p>';
    P.caixa.querySelector('.nc-af-periodo').innerHTML = '<p class="nc-af-rot">Onde estão as posições</p>' + frase +
      (at || A.suspensas || A.extintas ? '<div class="nc-af-quadros nc-af-quadros--3">' +
        quadro('Aprovado e ocupado', 'Cada linha: posições ativas, quantas têm gente e quantas estão vagas · toque para filtrar', aprovado(A.onde), 'nc-af-q--largo', verPor()) +
        quadro('Situação das posições', 'Toque para filtrar o resumo', barras(A.sits, A.totSits)) +
        quadro('Vagas há mais tempo', 'As posições vazias há mais dias · toque para abrir', A.velhas.length ? listaCurta(A.velhas) : '<p class="nc-af-vazio-q">Nenhuma vaga aberta.</p>') +
        quadro('Cargos com mais vagas', 'Toque para filtrar o resumo', barras(A.cargos, A.vagas.length, ['vaga', 'vagas'])) +
        quadro('Liderança', 'Posições de gestor', lideranca(A)) +
        '</div>' : '');
    ligarRolos(P.caixa.querySelector('.nc-af-periodo'));
  }
  function quadro(tit, dica, corpo, cls, extra) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3>' + (extra || '') + '<p>' + dica + '</p>' + corpo + '</section>'; }
  /* APROVADO × OCUPADO: a barra é o aprovado; a parte cheia é o ocupado, a clara é a vaga; o que
     passa (gente a mais em posição não compartilhada) aparece em vermelho depois do fim */
  function aprovado(xs) {
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada com estes filtros.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.ap + x.ex; })) || 1;
    var iSel = -1; xs.forEach(function (x, i) { if (x.sel) iSel = i; });
    return '<div class="nc-hc-legenda" aria-hidden="true"><span><i class="is-ocup"></i>ocupadas</span><span><i class="is-vaga"></i>vagas</span><span><i class="is-ex"></i>pessoas a mais</span></div>' +
      rolo('ol', 'nc-af-barras nc-hc-aprov', xs.map(function (x) {
        var p = partes(x.t), cls = x.sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '';
        var w = function (n) { return (n / max * 100).toFixed(2) + '%'; };
        return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra' + cls + '" data-hc-filtra="' + x.dim + '" data-hc-valor="' + esc(x.t) + '" aria-pressed="' + !!x.sel + '"' +
          ' title="' + (x.sel ? 'Tirar ' + esc(x.t) + ' do filtro' : 'Ver o resumo só de ' + esc(x.t)) + '">' +
          '<span class="nc-af-b-nome">' + (x.sel ? ic('marca') : '') + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1] || x.t) + '</span>' +
          '<span class="nc-hc-trilho" aria-hidden="true"><i class="is-ocup" style="width:' + w(x.oc) + '"></i><i class="is-vaga" style="width:' + w(x.va) + '"></i>' + (x.ex ? '<i class="is-ex" style="width:' + w(x.ex) + '"></i>' : '') + '</span>' +
          '<span class="nc-af-b-num">' + num(x.oc) + ' <small>de ' + num(x.ap) + '</small>' + (x.va ? ' <small class="nc-hc-num-vaga">· ' + plural(x.va, 'vaga', 'vagas') + '</small>' : '') +
          (x.ex ? ' <small class="nc-hc-num-ex">· ' + plural(x.ex, 'a mais', 'a mais') + '</small>' : '') + '</span></button>' +
          (DIM[x.dim].col ? '<button type="button" class="nc-af-b-tab" data-hc-tabela="' + esc(x.t) + '" data-hc-col="' + DIM[x.dim].col + '" title="Ver ' + esc(x.t) + ' na tabela" aria-label="Ver ' + esc(x.t) + ' na tabela">' + ic('tabela') + '</button>' : '') + '</li>';
      }), Math.max(8, iSel + 1), ['linha', 'linhas']);
  }
  function barras(xs, total, unid) {
    xs = xs || []; unid = unid || ['posição', 'posições'];
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada' + (P.A && P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    var iSel = -1; xs.forEach(function (x, i) { if (x.sel) iSel = i; });
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pc = total ? Math.round(x.q / total * 100) : null;
      var miolo = '<span class="nc-af-b-nome">' + (x.sel ? ic('marca') : '') + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1] || x.t) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? unid[0] : unid[1]) + (pc != null ? ' · ' + (pc < 1 ? '&lt;1' : pc) + '%' : '') + '</small></span>';
      var cls = (x.sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '') + (i === 0 && iSel < 0 ? ' is-maior' : '');
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra' + cls + '" data-hc-filtra="' + x.dim + '" data-hc-valor="' + esc(x.t) + '" aria-pressed="' + !!x.sel + '"' +
        ' title="' + (x.sel ? 'Tirar ' + esc(x.t) + ' do filtro' : 'Ver o resumo só de ' + esc(x.t)) + '">' + miolo + '</button>' +
        (DIM[x.dim].col ? '<button type="button" class="nc-af-b-tab" data-hc-tabela="' + esc(x.t) + '" data-hc-col="' + DIM[x.dim].col + '" title="Ver ' + esc(x.t) + ' na tabela" aria-label="Ver ' + esc(x.t) + ' na tabela">' + ic('tabela') + '</button>' : '') + '</li>';
    }), Math.max(POR_VEZ_Q, iSel + 1), ['linha', 'linhas']);
  }
  /* uma lista curta de posições dentro de um quadro (vagas há mais tempo, gestor vago) */
  function listaCurta(ps) {
    return rolo('ul', 'nc-af-lista nc-hc-curta', ps.map(function (p) {
      var r = p.r, miolo = '<span class="nc-af-p-quem"><b>' + esc(nomeSo(rotulo('car', r[4]))) + '</b><span>Posição ' + esc(r[X_VAGA]) + ' · ' + esc(nomeSo(rotulo('fil', r[1]))) + '</span></span>' +
        '<span class="nc-af-volta ' + (p.diasVaga > VAGA_VELHA ? 'nc-af-volta--sem' : 'nc-af-volta--logo') + '">' + (p.diasVaga != null ? plural(p.diasVaga, 'dia', 'dias') : 'vaga') + '</span>';
      return p.url ? '<li><a class="nc-af-p nc-fp-p nc-hc-p" href="' + esc(p.url) + '" title="Abrir a posição ' + esc(r[X_VAGA]) + '">' + miolo + '</a></li>'
                   : '<li><button type="button" class="nc-af-p nc-fp-p nc-hc-p" data-hc-tabela="' + esc(r[X_VAGA]) + '" data-hc-col="COD_VAGA">' + miolo + '</button></li>';
    }), POR_VEZ_Q, ['posição', 'posições']);
  }
  function lideranca(A) {
    var g = A.gestor;
    if (!g.total) return '<p class="nc-af-vazio-q">Nenhuma posição ativa marcada como de gestor' + (A.filtrado ? ' com estes filtros' : '') + '.</p>';
    return '<p class="nc-hc-lider"><b>' + num(g.ocup) + '</b> de <b>' + num(g.total) + '</b> posições de gestor têm alguém.' +
      (g.vagas.length ? ' <b class="nc-ac-pior">' + plural(g.vagas.length, 'está vaga', 'estão vagas') + '</b>: a equipe pode estar sem líder.' : ' Nenhuma vaga.') + '</p>' +
      (g.vagas.length ? listaCurta(g.vagas) : '');
  }

  /* ═══ [H6] FILTRAR E CRUZAR ═════════════════════════════════════════════════════════════ */
  function filtrosIdx() {
    var fi = {}, dims = P.dados.dims || {};
    Object.keys(P.f).forEach(function (k) {
      var m = {}, ok = [];
      (P.f[k] || []).forEach(function (t) { var i = (dims[k] || []).indexOf(t); if (i >= 0) { m[i] = 1; ok.push(t); } });
      if (ok.length) { fi[k] = m; P.f[k] = ok; } else delete P.f[k];
    });
    return fi;
  }
  function passaX(r, fi, sem) { for (var k in fi) { if (k === sem) continue; if (!fi[k][r[DIM[k].i]]) return false; } return true; }
  /* pessoa sem posição: só as colunas que a pessoa tem; um filtro de coluna que ela não tem (função,
     c. custo contábil, situação da posição) deixa ela de fora */
  function passaP(kk, fi) { for (var k in fi) { var c = DIM[k].p; if (c < 0) return false; if (!fi[k][kk[c]]) return false; } return true; }
  function agregar() {
    var d = P.dados, fi = filtrosIdx(), filtrado = Object.keys(fi).length > 0;
    var por = DIM[P.por] && P.por !== 'sit' ? P.por : POR_PADRAO;
    var ativas = [], vagas = [], acima = [], conferir = [], ocupadas = 0, suspensas = 0, extintas = 0, comReq = 0, excesso = 0;
    var gO = {}, gS = {}, gC = {}, gestor = { total: 0, ocup: 0, vagas: [] };
    P.pos.forEach(function (p) {
      var r = p.r, todos = !filtrado || passaX(r, fi);
      if (todos) {
        if (p.ativa) {
          ativas.push(p);
          if (p.ocup > 0) ocupadas++; else { vagas.push(p); if (r[X_REQ]) comReq++; }
          if (p.acima) { acima.push(p); excesso += p.ocup - 1; }
          if (r[X_GEST] === 1) { gestor.total++; if (p.ocup > 0) gestor.ocup++; else gestor.vagas.push(p); }
        } else {
          var s = semAcento(rotulo('sit', r[7]));
          if (/susp/.test(s)) suspensas++; else if (/extin/.test(s)) extintas++;
        }
        if (p.conferir.length) conferir.push(p);
      }
      if (todos || passaX(r, fi, 'sit')) gS[r[7]] = (gS[r[7]] || 0) + 1;
      if (p.ativa && (todos || passaX(r, fi, por))) {
        var g = gO[r[DIM[por].i]] || (gO[r[DIM[por].i]] = { ap: 0, oc: 0, va: 0, ex: 0 });
        g.ap++; if (p.ocup > 0) g.oc++; else g.va++;
        if (p.acima) g.ex += p.ocup - 1;
      }
      if (p.vaga && (todos || passaX(r, fi, 'car'))) gC[r[4]] = (gC[r[4]] || 0) + 1;
    });
    function lista(g, dim) {
      var tot = 0;
      var xs = Object.keys(g).map(function (v) { tot += g[v]; return { t: rotulo(dim, v), q: g[v], dim: dim, sel: !!(fi[dim] && fi[dim][v]) }; })
        .filter(function (x) { return x.t != null; }).sort(function (a, b) { return b.q - a.q || comparar(a.t, b.t); }).slice(0, 300);
      return { xs: xs, tot: tot };
    }
    var onde = Object.keys(gO).map(function (v) { var g = gO[v]; return { t: rotulo(por, v), ap: g.ap, oc: g.oc, va: g.va, ex: g.ex, dim: por, sel: !!(fi[por] && fi[por][v]) }; })
      .filter(function (x) { return x.t != null; })
      .sort(function (a, b) { return (b.va + b.ex) - (a.va + a.ex) || b.ap - a.ap || comparar(a.t, b.t); }).slice(0, 400);
    var S = lista(gS, 'sit'), C = lista(gC, 'car');
    var porDias = function (a, b) { return (b.diasVaga || 0) - (a.diasVaga || 0); };
    vagas.sort(porDias); gestor.vagas.sort(porDias);
    acima.sort(function (a, b) { return b.ocup - a.ocup; });
    var sem = ((d.sem && d.sem.lista) || []).filter(function (s) { return !filtrado || passaP(s.kk, fi); });
    var semTotal = filtrado ? sem.length : (d.sem && d.sem.total) || sem.length;
    return { fi: fi, filtrado: filtrado, por: por, ativas: ativas, ocupadas: ocupadas, vagas: vagas, suspensas: suspensas, extintas: extintas, comReq: comReq,
             excesso: excesso, onde: onde, sits: S.xs, totSits: S.tot, cargos: C.xs, velhas: vagas.slice(0, 200), gestor: gestor,
             sem: sem, semTotal: semTotal, listas: { vagas: vagas, acima: acima, conferir: conferir } };
  }

  function desenharFiltros() {
    var box = P.caixa.querySelector('.nc-af-filtros'); if (!box) return;
    var d = P.dados, fi = P.A.fi, dims = d.dims || {}, n = Object.keys(fi).length;
    P.opc = {};
    if (P.nDims !== d) {
      P.nDims = d; P.nVal = {};
      DIMS.forEach(function (D) { var t = {}; P.pos.forEach(function (p) { t[p.r[D.i]] = 1; }); P.nVal[D.k] = Object.keys(t).length; });
    }
    var campos = DIMS.map(function (D) {
      var tem = {};
      P.pos.forEach(function (p) { if (passaX(p.r, fi, D.k)) tem[p.r[D.i]] = (tem[p.r[D.i]] || 0) + 1; });
      (P.f[D.k] || []).forEach(function (t) { var i = (dims[D.k] || []).indexOf(t); if (i >= 0 && !(i in tem)) tem[i] = 0; });
      var vs = Object.keys(tem).map(function (v) { return { t: (dims[D.k] || [])[v], n: tem[v] }; })
        .filter(function (x) { return x.t != null; }).sort(function (a, b) { return comparar(a.t, b.t); });
      P.opc[D.k] = vs;
      var esc_ = P.f[D.k] || [];
      if (P.nVal[D.k] < 2 && !esc_.length) return '';
      var aberto = P.pop && P.pop.k === D.k;
      return '<div class="nc-af-campo' + (esc_.length ? ' is-ativo' : '') + '"><span class="nc-af-campo-rot" id="nc-hc-rot-' + D.k + '">' + D.nome + '</span>' +
        '<button type="button" class="nc-af-escolha" data-hc-abre="' + D.k + '" aria-haspopup="true" aria-expanded="' + aberto + '" aria-controls="nc-hc-pop"' +
        ' aria-labelledby="nc-hc-rot-' + D.k + ' nc-hc-val-' + D.k + '"><span class="nc-af-escolha-txt" id="nc-hc-val-' + D.k + '">' +
        (esc_.length ? esc(esc_[0]) : D.todos) + '</span>' + (esc_.length > 1 ? '<b class="nc-af-mais-n" aria-label="e mais ' + (esc_.length - 1) + '">+' + (esc_.length - 1) + '</b>' : '') +
        ic('abrir') + '</button></div>';
    }).join('');
    var chips = Object.keys(fi).map(function (k) {
      var t = P.f[k], tudo = t.join(', ');
      return '<button type="button" class="nc-af-chip" data-hc-tira="' + k + '" title="Tirar este filtro: ' + esc(tudo) + '" aria-label="Tirar o filtro ' + esc(DIM[k].nome + ': ' + tudo) + '">' +
        '<span>' + DIM[k].nome + '</span><b>' + esc(t[0]) + '</b>' + (t.length > 1 ? '<em>+' + (t.length - 1) + '</em>' : '') + ic('tirar') + '</button>';
    }).join('');
    box.hidden = !campos && !n;
    box.classList.toggle('is-ativo', n > 0);
    box.innerHTML = '<div class="nc-af-filtros-cab">' + ic('filtro') + '<p class="nc-af-filtros-tit">Filtrar este resumo</p>' +
      '<p class="nc-af-filtros-nota">' + (n ? 'A tabela abaixo não muda.' : 'Escolha um ou mais em cada caixa. A tabela abaixo não muda.') + '</p>' +
      (n ? '<button type="button" class="nc-af-limpa" data-hc-limpa>' + ic('tirar') + '<span>' + (n === 1 ? 'Limpar o filtro' : 'Limpar os ' + n + ' filtros') + '</span></button>' : '') +
      '</div><div class="nc-af-filtros-campos">' + campos + '</div>' +
      (n ? '<div class="nc-af-filtros-chips"><span class="nc-af-filtros-chips-rot">Resumo só de:</span>' + chips + '</div>' : '');
  }
  function abrirLista(k) {
    fecharLista(false);
    var pop = P.caixa.querySelector('.nc-af-pop');
    if (!pop) { pop = el('div', 'nc-af-pop'); pop.id = 'nc-hc-pop'; pop.setAttribute('role', 'dialog'); pop.hidden = true; P.caixa.appendChild(pop); }
    var D = DIM[k], vs = P.opc[k] || [], esc_ = P.f[k] || [];
    var ordem = vs.filter(function (x) { return esc_.indexOf(x.t) >= 0; }).concat(vs.filter(function (x) { return esc_.indexOf(x.t) < 0; }));
    pop.setAttribute('aria-label', D.nome);
    pop.innerHTML = '<div class="nc-af-pop-cab"><b>' + D.nome + '</b><span>marque um ou mais</span></div>' +
      (vs.length > 8 ? '<label class="nc-af-procura nc-af-pop-busca">' + ic('busca') + '<span class="nc-af-vis">Procurar em ' + D.nome + '</span>' +
        '<input type="search" placeholder="Procurar código ou nome" data-hc-pop-busca autocomplete="off"></label>' : '') +
      '<ul class="nc-af-pop-lista">' + ordem.map(function (x) {
        return '<li data-af-texto="' + esc(semAcento(x.t)) + '"><label><input type="checkbox" data-hc-marca value="' + esc(x.t) + '"' + (esc_.indexOf(x.t) >= 0 ? ' checked' : '') + '>' +
          '<span>' + esc(x.t) + '</span>' + (x.n ? '<small title="posições">' + num(x.n) + '</small>' : '') + '</label></li>';
      }).join('') + '</ul><p class="nc-af-pop-nada" hidden>Nada com esse nome.</p>' +
      '<div class="nc-af-pop-pe"><button type="button" class="nc-af-limpa" data-hc-pop-limpa>Desmarcar todos</button>' +
      '<button type="button" class="nc-af-bt nc-af-bt--cheio" data-hc-pronto>Pronto</button></div>';
    P.pop = { k: k, el: pop };
    pop.hidden = false;
    posicionarLista();
    marcarLista();
    var foco = pop.querySelector('[data-hc-pop-busca]') || pop.querySelector('[data-hc-marca]');
    if (foco) foco.focus({ preventScroll: true });
    var busca = pop.querySelector('[data-hc-pop-busca]');
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
    var b = P.caixa.querySelector('[data-hc-abre="' + k + '"]');
    if (b) { b.setAttribute('aria-expanded', 'false'); if (devolve) b.focus({ preventScroll: true }); }
  }
  function posicionarLista() {
    if (!P.pop) return;
    var b = P.caixa.querySelector('[data-hc-abre="' + P.pop.k + '"]');
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
    [].forEach.call(P.pop.el.querySelectorAll('[data-hc-marca]'), function (x) { x.checked = esc_.indexOf(x.value) >= 0; });
  }
  document.addEventListener('mousedown', function (e) {
    if (P && P.pop && !P.pop.el.contains(e.target) && !e.target.closest('[data-hc-abre]')) fecharLista(false);
  }, true);
  document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && P && P.pop) { e.preventDefault(); fecharLista(true); } });
  window.addEventListener('resize', function () { if (P && P.pop) posicionarLista(); });

  function verPor() {
    return '<label class="nc-af-ver-por"><span>por</span><select data-hc-por aria-label="Aprovado e ocupado: ver por">' +
      DIMS.filter(function (D) { return D.k !== 'sit'; }).map(function (D) {
        return '<option value="' + D.k + '"' + (D.k === P.A.por ? ' selected' : '') + '>' + (D.curto || D.nome) + '</option>';
      }).join('') + '</select></label>';
  }
  function mudou(e) {
    var s = e.target;
    if (s.matches('[data-hc-marca]') && P.pop) {
      var k = P.pop.k, l = (P.f[k] || []).filter(function (t) { return t !== s.value; });
      if (s.checked) l.push(s.value);
      if (l.length) P.f[k] = l; else delete P.f[k];
      redesenhar({ pop: true });
    } else if (s.matches('select[data-hc-por]')) {
      P.por = s.value;
      try { if (s.value === POR_PADRAO) localStorage.removeItem(GUARDA_POR); else localStorage.setItem(GUARDA_POR, s.value); } catch (e2) { /* ok */ }
      redesenhar({ attr: 'data-hc-por', v: '' });
    }
  }
  function alternar(k, t) {
    var l = P.f[k] || [], i = l.indexOf(t);
    if (i >= 0) l.splice(i, 1); else l.push(t);
    if (l.length) P.f[k] = l; else delete P.f[k];
    redesenhar({ attr: 'data-hc-valor', v: t });
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

  /* ═══ [H7] VER NA TABELA ════════════════════════════════════════════════════════════════ */
  function colunaDaBusca(pre, col) {
    var h = document.getElementById(pre + '_column_search_current_column'), f = document.getElementById(pre + '_search_field');
    if (!h || !f) return null;
    var D = DIMS.filter(function (x) { return x.col === col; })[0], tit = col === 'COD_VAGA' ? 'Vaga' : D && D.tit;
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

  /* ═══ [H8] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncPosicoesIniciou) return; if (montar()) { window.__ncPosicoesIniciou = true; buscar(); } }
  window.__ncPosicoesDesenhar = function (d) { if (montar()) desenhar(d, Date.now()); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
