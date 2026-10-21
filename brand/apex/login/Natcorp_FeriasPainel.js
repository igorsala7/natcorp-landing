/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · FÉRIAS  —  o painel de indicadores (JavaScript)                                ║
   ║  App 200 · Página 26 (Férias)                                                             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: FERIASPAINEL-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima do relatório de férias (e do seletor Tabela · Trajetória · Cronologia do
   Natcorp_LinhaTempo, que continua igual), um RESUMO para quem cuida das pessoas, com o que o
   Departamento Pessoal precisa olhar todo dia:
     HOJE          De férias hoje · Saem nos próximos 30 dias · Prazo vencido (paga em dobro) ·
                   Vencem em até 60 dias · Dois períodos acumulados. Tocar num número mostra QUEM
                   são, já na ordem que importa (o prazo mais antigo primeiro…).
     PLANEJAMENTO  a frase dos dias a tirar e do % em dia; saídas por mês; onde há férias vencidas;
                   quem tem mais dias para tirar; como as férias são tiradas (parcelas, venda de
                   10 dias, 13º junto).
   Tocar numa pessoa ou num centro de custo filtra a TABELA (volta para o modo Tabela antes).
   Os números vêm do servidor (processo NC_FERIAS_INDICADORES) com os MESMOS filtros da página.
   É o mesmo desenho do painel de afastamentos (200:25): o CSS é o mesmo, gerado como
   Natcorp_FeriasPainel.css a partir do Natcorp_Afastamentos.src.css.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 26 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_FeriasPainel.js (com o LinhaTempo)
     Página 26 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_FeriasPainel.css (com o LinhaTempo)
     Página 26 › Processing › Ajax Callback NC_FERIAS_INDICADORES   (aplicar-feriaspainel-pagina26.py)
   O COMBINADO com a página: o relatório tem Static ID "IR_1" e os filtros são os itens P26_*.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Textos e ferramentas ............ frases, ícones, datas                     PODE MEXER
     [J2] Os dados ........................ chamada ao servidor                        CUIDADO
     [J3] A moldura ....................... título, esconder/mostrar
     [J4] Hoje ............................ a régua de 5 números e a lista "quem são"  PODE MEXER
     [J5] Planejamento .................... frase, saídas por mês, setores, saldo, parcelas
     [J6] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncFerPainel) return;
  window.__ncFerPainel = true;
  var RID = 'IR_1';                       /* o Static ID do relatório desta página */

  /* este relatório continua com Tabela | Cartões (o Natcorp_Registros pula página que tem um
     desenho próprio — esta tem — a não ser que o relatório venha marcado com nc-reg-sim) */
  function marcarRelatorio() { var ir = document.getElementById(RID); if (ir) ir.classList.add('nc-reg-sim'); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  /* ═══ [J1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_FERIAS_INDICADORES';
  var ITENS = ['P26_EMPRESA', 'P26_FILIAL', 'P26_CCUSTO', 'P26_UNIDADE_ADM', 'P26_ATIVIDADE', 'P26_CARGO', 'P26_MATRICULA_1', 'P26_SITUACAO', 'P26_CHK_PENDENTES', 'P26_DATA_INI', 'P26_DATA_FIM', 'P26_EMP', 'P26_MAT'];
  var POR_VEZ = 30;                       /* pessoas que a lista "quem são" mostra de cada vez */
  var POR_VEZ_Q = 6;                      /* linhas de cada quadro do período, de cada vez */
  var GUARDA = 'nc-fp-fechado';           /* o painel escondido fica lembrado neste navegador */
  var VALIDADE = 10 * 60 * 1000;         /* o resumo calculado vale 10 min nesta aba (mesmos filtros) */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

  /* os 5 números de HOJE: a ordem é a ordem na tela */
  var HOJE = [
    { k: 'ferias',    cor: 'roxo',     ic: 'sol',     diz: 'De férias hoje',           dica: 'estão de férias agora' },
    { k: 'saem30',    cor: 'verde',    ic: 'mala',    diz: 'Saem nos próximos 30 dias', dica: 'combine quem cobre o trabalho' },
    { k: 'vencido',   cor: 'vermelho', ic: 'alarme',  diz: 'Prazo vencido',            dica: 'passou do prazo para tirar: a empresa paga em dobro', alerta: true },
    { k: 'vence60',   cor: 'ambar',    ic: 'relogio', diz: 'Vencem em até 60 dias',    dica: 'ainda sem férias marcadas: marque antes do prazo', alerta: true },
    { k: 'acumulado', cor: 'rosa',     ic: 'pilha',   diz: 'Dois períodos acumulados', dica: 'têm 2 anos ou mais de férias para tirar' }
  ];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    sol: '<circle cx="12" cy="12" r="4"/><path d="M12 3v2M12 19v2M3 12h2M19 12h2M5.6 5.6l1.4 1.4M17 17l1.4 1.4M5.6 18.4 7 17M17 7l1.4-1.4"/>',
    mala: '<rect x="4" y="7.5" width="16" height="12" rx="2.5"/><path d="M9 7.5V5.5a1.5 1.5 0 0 1 1.5-1.5h3A1.5 1.5 0 0 1 15 5.5v2M4 12.5h16"/>',
    pilha: '<rect x="4" y="13" width="16" height="6" rx="1.5"/><rect x="6" y="6" width="12" height="6" rx="1.5"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    volta: '<path d="M4 12a8 8 0 1 0 2.3-5.6"/><path d="M4 4v4h4"/><path d="M12 8v4l2.5 2"/>',
    alarme: '<circle cx="12" cy="13" r="7"/><path d="M12 9.5V13l2 1.5M5 4.5 3 6.5M19 4.5l2 2"/>',
    duvida: '<circle cx="12" cy="12" r="8.5"/><path d="M9.6 9.4a2.5 2.5 0 0 1 4.8.9c0 1.7-2.4 2-2.4 3.7"/><path d="M12 17h.01"/>',
    relogio: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4"/><path d="M9 14h3v3"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>'
  };
  function ic(n) { return '<svg class="nc-af-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function num(n) { return Number(n || 0).toLocaleString('pt-BR'); }
  function plural(n, um, varios) { return num(n) + ' ' + (Number(n) === 1 ? um : varios); }
  function data(t) { var m = /^(\d{2})\/(\d{2})\/(\d{4})$/.exec(t || ''); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  function dias(a, b) { return Math.round((b - a) / 864e5); }
  function curta(d) { return ('0' + d.getDate()).slice(-2) + '/' + ('0' + (d.getMonth() + 1)).slice(-2); }
  /* "123 - Fulano De Tal" → ["123", "Fulano De Tal"] (o código fica, como no resto do sistema) */
  function partes(t) { var m = /^(\S+)\s+-\s+(.+)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }

  /* ═══ [J2] OS DADOS ═════════════════════════════════════════════════════════════════════
     CUIDADO  Os filtros vão com a chamada (pageItems) — os mesmos que o relatório usa.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o resultado fica guardado na ABA (sessionStorage some ao fechar — tem nomes de pessoas) por 10 min,
     por combinação de filtros: voltar à página não recalcula. "Atualizar" força. */
  function chaveCache() {
    return 'nc-fp-dados:' + ITENS.map(function (i) { var e = document.getElementById(i); return e ? (apex.item(i).getValue() || '') : ''; }).join('|');
  }
  function buscar(forcar) {
    var k = chaveCache(), c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && c && c.d && Date.now() - c.t < VALIDADE) { desenhar(c.d, c.t); return; }
    carregando();
    var itens = ITENS.filter(function (i) { return document.getElementById(i); }).map(function (i) { return '#' + i; }).join(',');
    /* error próprio: sem ele o APEX abre o aviso vermelho dele ("Ocorreu 1 erro") além do nosso */
    apex.server.process(PROCESSO, { pageItems: itens }, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio ou bloqueado: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      /* processo que não existe na página: o APEX responde 200 VAZIO (o JSON quebra sem texto) */
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [J3] A MOLDURA ═══════════════════════════════════════════════════════════════════ */
  var P = null;   /* { caixa, corpo, quando, botao, dados, filtro, quantos } */
  function montar() {
    if (P) return true;
    var ir = document.getElementById(RID);
    if (!ir) return false;
    var caixa = el('section', 'nc-af nc-fp');
    caixa.setAttribute('aria-labelledby', 'nc-af-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-af-titulo">Resumo das férias</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-esconde aria-controls="nc-af-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-af-corpo"></div>';
    ir.parentNode.insertBefore(caixa, ir);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-af-esconde]'), filtro: null, quantos: POR_VEZ };
    /* nasce COMPACTO (só a faixa de números; a tabela é a função principal): abre a análise quem pediu */
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '0'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    caixa.addEventListener('click', clique);
    return true;
  }
  function abrirFechar(aberto) {
    P.caixa.classList.toggle('is-fechado', !aberto);
    P.botao.setAttribute('aria-expanded', String(aberto));
    P.botao.innerHTML = ic(aberto ? 'fechar' : 'abrir') + '<span>' + (aberto ? 'Mostrar menos' : 'Ver análise completa') + '</span>';
    try { if (aberto) localStorage.setItem(GUARDA, '0'); else localStorage.removeItem(GUARDA); } catch (e) { /* ok */ }
    if (aberto && typeof ajustarMeses === 'function') setTimeout(ajustarMeses, 0);   /* o gráfico mede a largura só quando aparece */
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-af-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-af-num')) {
      var k = b.getAttribute('data-af-num');
      P.filtro = P.filtro === k ? null : k;
      desenharHoje(); return;
    }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-af-tabela')) { naTabela(b.getAttribute('data-af-tabela')); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-af-tenta') || b.hasAttribute('data-af-atualiza')) buscar(true);
  }
  /* CALCULANDO: o painel ganha a faixa que corre no topo; o texto diz o que está fazendo (muda a cada
     4 s) e há quantos segundos — o número fica fora do aria-live (leitor de tela não repete a cada 1 s) */
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
  function pararCalculo() {
    clearInterval(P.lento);
    P.caixa.classList.remove('is-calculando');
    P.caixa.removeAttribute('aria-busy');
  }
  /* CHEGOU: os números sobem e as barras crescem UMA vez (escolher um número depois não repete) */
  function chegou() {
    P.caixa.classList.add('is-novo');
    clearTimeout(P.novo);
    P.novo = setTimeout(function () { P.caixa.classList.remove('is-novo'); }, 1400);
  }
  function carregando() {
    var regua = HOJE.map(function (h) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor"><i class="nc-af-esq" style="width:56px;height:26px"></i></span><span class="nc-af-diz">' + h.diz + '</span></div>';
    }).join('');
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><p class="nc-af-rot">Hoje</p><div class="nc-af-regua">' + regua + '</div></div>' +
      '<div class="nc-af-secao"><i class="nc-af-esq" style="width:60%;height:16px"></i><div class="nc-af-quadros" style="margin-top:14px">' +
      '<div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div><div class="nc-af-q" style="height:190px"></div></div></div>';
    P.quando.textContent = 'Calculando…';
    P.caixa.querySelector('[data-af-atualiza]').hidden = true;
    /* conta pesada (todos os períodos de férias do filtro): depois de 6 s, dizer que segue trabalhando */
    pararCalculo();
    P.lento = calculando(["Buscando as férias…", "Conferindo os prazos…", "Somando os saldos…", "Ainda calculando: com muitos colaboradores leva mais tempo"]);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_FERIAS|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia FERIASPAINEL-MANUTENCAO.md).'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [J4] HOJE ═════════════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    var hoje = data(d.hoje) || new Date();
    /* as listas chegam do servidor por situação: { n, s (centro de custo), a, b (datas), x (dias) } */
    HOJE.forEach(function (h) { (d[h.k] || []).forEach(function (p) { p.dA = data(p.a); p.dB = data(p.b); }); });
    P.dados = d; P.hoje = hoje; P.filtro = null;
    var hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.quando.innerHTML = 'Hoje, <b>' + esc(d.hoje) + '</b> · com os filtros da página' + (hm ? ' · calculado às ' + hm : '');
    P.caixa.querySelector('[data-af-atualiza]').hidden = false;
    P.corpo.innerHTML =
      '<div class="nc-af-secao"><p class="nc-af-rot">Hoje</p><div class="nc-af-regua" role="group" aria-label="As férias hoje"></div>' +
      '<div class="nc-af-quem" id="nc-af-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    desenharHoje();
    desenharPeriodo();
  }
  function desenharHoje() {
    var a = P.dados.agora || {};
    P.caixa.querySelector('.nc-af-regua').innerHTML = HOJE.map(function (h) {
      var v = Number(a[h.k] || 0), on = P.filtro === h.k;
      return '<button type="button" class="nc-af-num nc-af-num--' + h.cor + (v ? '' : ' is-zero') + (h.alerta && v ? ' is-alerta' : '') + '" data-af-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-af-quem"' + (v ? '' : ' disabled') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor">' + num(v) + '<small>' + (v === 1 ? 'pessoa' : 'pessoas') + '</small></span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + h.dica + '</span></button>';
    }).join('');
    desenharLista();
  }
  /* quem entra em cada número, e em que ordem (o que pede ação primeiro) */
  function daLista(k) {
    var ps = (P.dados[k] || []).slice(), por = function (c, desc) { return function (x, y) { return desc ? (y[c] || 0) - (x[c] || 0) : (x[c] || 0) - (y[c] || 0); }; };
    if (k === 'ferias') return ps.sort(por('dB'));            /* quem volta antes */
    if (k === 'acumulado') return ps.sort(por('x', true));    /* mais dias a tirar */
    return ps.sort(por('dA'));                                /* saída mais perto / prazo mais antigo */
  }
  var ORDEM = { ferias: 'quem volta antes primeiro', saem30: 'quem sai antes primeiro', vencido: 'o prazo vencido há mais tempo primeiro', vence60: 'o prazo mais perto primeiro', acumulado: 'quem tem mais dias para tirar primeiro' };
  /* o que cada lista mostra no meio da linha e no selo do fim */
  function detalhe(k, p) {
    var n;
    if (k === 'ferias') { n = p.dB ? dias(P.hoje, p.dB) : null;
      return ['Saiu em ' + esc(p.a || '—'), '<span class="nc-af-volta nc-af-volta--logo">' + (n == null ? 'De férias' : n <= 0 ? 'Volta hoje' : n === 1 ? 'Volta amanhã' : 'Volta em ' + n + ' dias · ' + curta(p.dB)) + '</span>']; }
    if (k === 'saem30') { n = p.dA ? dias(P.hoje, p.dA) : null;
      return ['Férias marcadas', '<span class="nc-af-volta">' + (n === 1 ? 'Sai amanhã' : 'Sai em ' + n + ' dias') + ' · ' + curta(p.dA) + '</span>']; }
    if (k === 'vencido') { n = p.dA ? -dias(P.hoje, p.dA) : null;
      return [plural(p.x, 'dia', 'dias') + ' para tirar', '<span class="nc-af-volta nc-af-volta--atrasada">Prazo era ' + esc(p.a) + (n ? ' · venceu há ' + plural(n, 'dia', 'dias') : '') + '</span>']; }
    if (k === 'vence60') { n = p.dA ? dias(P.hoje, p.dA) : null;
      return [plural(p.x, 'dia', 'dias') + ' para tirar', '<span class="nc-af-volta nc-af-volta--sem">' + (n === 0 ? 'Vence hoje' : 'Vence em ' + plural(n, 'dia', 'dias')) + ' · ' + esc(p.a) + '</span>']; }
    return [plural(p.x, 'dia', 'dias') + ' de férias vencidas', '<span class="nc-af-volta nc-af-volta--atrasada">2 períodos ou mais</span>'];
  }
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro) { box.hidden = true; box.innerHTML = ''; return; }
    var k = P.filtro, h = HOJE.filter(function (x) { return x.k === k; })[0], ps = daLista(k), tot = Number((P.dados.agora || {})[k] || 0);
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + h.diz + ': ' + plural(tot, 'pessoa', 'pessoas') + '</h3><p>' + ORDEM[k] + ' · toque numa pessoa para ver as férias dela na tabela</p>' +
      (ps.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome ou centro de custo" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', ps.map(function (p) {
        var dt = detalhe(k, p);
        return '<li data-af-texto="' + esc(semAcento([p.n, p.s].join(' '))) + '"><button type="button" class="nc-af-p nc-fp-p" data-af-tabela="' + esc(p.n) + '" title="Ver as férias de ' + esc(partes(p.n)[1]) + ' na tabela">' +
          '<span class="nc-af-p-quem"><b>' + esc(p.n) + '</b><span>' + esc(p.s || '') + '</span></span>' +
          '<span class="nc-af-p-tipo">' + dt[0] + '</span>' + dt[1] + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
      }), POR_VEZ, 'pessoas') +
      (tot > ps.length ? '<p class="nc-af-nota">A lista mostra ' + num(ps.length) + ' de ' + num(tot) + ' pessoas. Use os filtros da página para ver menos de cada vez.</p>' : '');
    ligarRolos(box);
    var pr = box.querySelector('[data-af-procura]');
    if (pr) pr.addEventListener('input', function () { procurar(box, pr.value); });
  }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase(); }
  /* a busca da lista: mostra só quem bate (todas as linhas, sem o "de pouco em pouco") */
  function procurar(box, q) {
    var r = box.querySelector('.nc-af-rolo'), lis = r.querySelectorAll('li'), t = semAcento(q.trim()), n = 0;
    if (!t) { desenharLista(); var p2 = P.caixa.querySelector('[data-af-procura]'); if (p2) p2.focus(); return; }
    [].forEach.call(lis, function (li) { var ok = li.getAttribute('data-af-texto').indexOf(t) >= 0; li.hidden = !ok; if (ok) n++; });
    var bt = r.nextElementSibling; if (bt && bt.hasAttribute('data-af-revela')) bt.hidden = true;
    var nada = r.querySelector('.nc-af-nada'); if (nada) nada.remove();
    if (!n) r.insertAdjacentHTML('beforeend', '<p class="nc-af-nada">Ninguém nesta lista com “' + esc(q.trim()) + '”.</p>');
  }

  /* ═══ LISTAS QUE VÃO APARECENDO ═════════════════════════════════════════════════════════
     Cada lista mora numa caixa de altura máxima (.nc-af-rolo) que rola por dentro. Mostra as
     primeiras N linhas; ao chegar perto do fim da caixa, aparecem as próximas N sozinhas; e o botão
     embaixo diz quantas faltam (para quem prefere tocar, ou usa o teclado).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function rolo(tag, cls, itens, passo, unid) {
    return '<div class="nc-af-rolo" data-af-unid="' + unid + '"><' + tag + ' class="' + cls + '">' +
      itens.map(function (h, i) { return i < passo ? h : h.replace(/^<li/, '<li hidden'); }).join('') +
      '</' + tag + '><span class="nc-af-sentinela" aria-hidden="true"></span></div>' +
      (itens.length > passo ? '<button type="button" class="nc-af-mais" data-af-revela="' + passo + '"></button>' : '');
  }
  function escondidos(r) { return r.querySelectorAll('li[hidden]:not(.is-filtrado)'); }
  function revelar(r, passo, foco) {
    var esc_ = [].slice.call(escondidos(r), 0, passo);
    esc_.forEach(function (li) { li.hidden = false; });
    if (foco && esc_[0]) { var b = esc_[0].querySelector('button'); (b || esc_[0]).focus({ preventScroll: true }); esc_[0].scrollIntoView({ block: 'nearest', behavior: 'smooth' }); }
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
      /* perto do fim da caixa (60 px antes), revela as próximas sozinho */
      var io = new IntersectionObserver(function (es) { if (es[0].isIntersecting && escondidos(r).length) revelar(r, passo); }, { root: r, rootMargin: '0px 0px 60px 0px' });
      io.observe(r.querySelector('.nc-af-sentinela'));
    });
  }

  /* ═══ VER NA TABELA ═════════════════════════════════════════════════════════════════════
     Tocar num motivo, num centro de custo ou numa pessoa usa a PRÓPRIA busca do relatório
     (campo + "Ir"): a tabela fica só com aquilo, com o filtro à vista e o × para tirar. O texto
     buscado é o mesmo que a coluna mostra ("14 - Aposent. Invalidez", "10560103 - Linha De Frente").
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function naTabela(texto) {
    /* o LinhaTempo pode estar em Trajetória/Cronologia (a tabela escondida): volta para a Tabela */
    var tb = document.querySelector('#' + RID + ' [data-modo="tabela"]');
    if (tb && tb.getAttribute('aria-pressed') !== 'true') tb.click();
    var f = document.getElementById(RID + '_search_field'), b = document.getElementById(RID + '_search_button');
    if (!f || !b) return irParaTabela();
    /* o relatório (ou a Trajetória) ainda carregando PERDE o clique na busca (visto em 08/10): espera a
       página ficar livre (até 8 s) e só então busca */
    P.quando.textContent = 'Filtrando a tabela…';
    irParaTabela();
    var t0 = Date.now();
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      f.value = texto;
      b.click();
      P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
    })();
  }
  function irParaTabela() {
    var ir = document.getElementById(RID); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [J5] PLANEJAMENTO ═════════════════════════════════════════════════════════════════ */
  function desenharPeriodo() {
    var d = P.dados, sa = d.saldo || { dias: 0, vencidos: 0, periodos: 0, em_dia: 0 }, co = d.como || {};
    var frase;
    if (!d.pessoas) frase = '<p class="nc-af-frase">Nenhum período de férias com estes filtros.</p>';
    else if (!sa.dias) frase = '<p class="nc-af-frase">Ninguém com férias a tirar com estes filtros.</p>';
    else {
      /* para BAIXO: 816 de 820 não pode virar "100% em dia" com 4 pessoas vencidas */
      var emDia = Math.floor((sa.em_dia || 0) / d.pessoas * 100);
      frase = '<p class="nc-af-frase"><b>' + plural(d.pessoas, 'pessoa', 'pessoas') + '</b> ' + (d.pessoas === 1 ? 'tem' : 'têm') + ' <b>' + plural(sa.dias, 'dia', 'dias') + '</b> de férias para tirar' +
        (sa.vencidos ? ', dos quais <b>' + num(sa.vencidos) + '</b> de períodos já completos' : '') + '.' +
        '<span class="nc-af-taxa"><b>' + emDia + '%</b> das pessoas estão com as férias em dia (sem prazo vencido).</span></p>';
    }
    var tv = (d.setores || []).reduce(function (s, x) { return s + x.q; }, 0);
    P.caixa.querySelector('.nc-af-periodo').innerHTML = '<p class="nc-af-rot">Planejamento</p>' + frase +
      (d.pessoas ? '<div class="nc-af-quadros">' +
        quadro('Saídas de férias por mês', 'Quantas pessoas saem em cada mês · passe o mouse nas colunas', meses(d.meses || [], data(d.cal_ini), data(d.cal_fim), { um: 'pessoa sai', varios: 'pessoas saem', vazio: 'Ninguém com saída de férias marcada nestes meses.', pico: 'com mais saídas' }), 'nc-af-q--meses') +
        quadro('Onde há férias vencidas', 'Centros de custo · toque para ver na tabela', (d.setores || []).length ? barras(d.setores, { total: tv, um: 'período', varios: 'períodos', d: ['dia', 'dias'] }) : '<p class="nc-af-vazio-q">Nenhum prazo vencido. Tudo em dia.</p>') +
        quadro('Quem tem mais dias para tirar', 'De períodos já completos · toque para ver na tabela', (d.maissaldo || []).length ? barras(d.maissaldo, { um: 'dia', varios: 'dias', d: ['período', 'períodos'] }) : '<p class="nc-af-vazio-q">Ninguém com período completo para tirar.</p>') +
        quadro('Como tiram as férias', co.periodos ? 'Dos ' + plural(co.periodos, 'período', 'períodos') + ' com férias marcadas' : 'Ainda sem férias marcadas', como(co)) +
        '</div>' : '');
    var per = P.caixa.querySelector('.nc-af-periodo');
    ligarRolos(per);
    ajustarMeses();
  }
  function quadro(tit, dica, corpo, cls) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3><p>' + dica + '</p>' + corpo + '</section>'; }
  /* cada linha é um BOTÃO "ver na tabela": q (com a unidade), a parte do total (%) e d */
  function barras(xs, o) {
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = o.total ? Math.round(x.q / o.total * 100) : null;
      return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-af-tabela="' + esc(x.t) + '" title="Ver ' + esc(x.t) + ' na tabela">' +
        '<span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? o.um : o.varios) + (pct != null ? ' · ' + (pct < 1 ? '&lt;1' : pct) + '%' : '') + (x.d != null && o.d ? ' · ' + plural(x.d, o.d[0], o.d[1]) : '') + '</small></span>' +
        '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
    }), POR_VEZ_Q, 'linhas');
  }
  /* COMO TIRAM: barras só de leitura (não filtram a tabela), em % dos períodos marcados */
  function como(co) {
    if (!co.periodos) return '<p class="nc-af-vazio-q">Quando houver férias marcadas, aqui aparece em quantas partes as pessoas tiram, quem vende 10 dias e quem pede o 13º junto.</p>';
    var linhas = [['Em 1 parte só', co.p1], ['Em 2 partes', co.p2], ['Em 3 partes', co.p3], ['Vendem dias (abono de 1/3)', co.abono], ['Pedem o adiantamento do 13º', co.dec]];
    return '<div class="nc-af-rolo"><ol class="nc-af-barras">' + linhas.map(function (l, i) {
      var pct = Math.round((l[1] || 0) / co.periodos * 100), txt = pct < 1 && l[1] ? '&lt;1' : pct;
      return '<li><div class="nc-af-b nc-af-b--fixa' + (i === 3 ? ' is-separa' : '') + '"><span class="nc-af-b-nome">' + l[0] + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(l[1] ? 3 : 0, pct) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + txt + '% <small>· ' + plural(l[1] || 0, 'período', 'períodos') + '</small></span></div></li>';
    }).join('') + '</ol></div>';
  }
  /* MÊS A MÊS que se adapta ao período: até 24 meses, uma coluna por mês; até 24 trimestres, por
     trimestre; acima disso, por ano (o título do quadro diz qual). Muitas colunas estreitas: o nome
     só nos marcos e o número só no pico — o resto aparece ao passar o mouse ou tocar (ajustarMeses). */
  function meses(ms, ini, fim, o) {
    if (!ini || !fim) return '';
    var q = {}; ms.forEach(function (m) { q[m.m] = m.q; });
    var lista = [], c = new Date(ini.getFullYear(), ini.getMonth(), 1), ultimo = new Date(fim.getFullYear(), fim.getMonth(), 1);
    while (c <= ultimo && lista.length < 600) { lista.push(new Date(c)); c.setMonth(c.getMonth() + 1); }
    var nMes = lista.length, modo = nMes <= 24 ? 'mes' : nMes <= 72 ? 'tri' : 'ano';
    /* os grupos: { chave, rotulo curto, rotulo da dica, marco (mostra o nome no modo denso), ano novo, valor } */
    var grupos = [], atual = P.hoje;
    lista.forEach(function (m) {
      var k = modo === 'mes' ? chaveMes(m) : modo === 'tri' ? m.getFullYear() + 'T' + (Math.floor(m.getMonth() / 3) + 1) : String(m.getFullYear());
      var g = grupos[grupos.length - 1];
      if (!g || g.k !== k) {
        var tri = Math.floor(m.getMonth() / 3) + 1;
        g = { k: k, v: 0, ano: m.getFullYear(),
              curto: modo === 'mes' ? MESES[m.getMonth()] : modo === 'tri' ? tri + 'º tri' : String(m.getFullYear()),
              dica: modo === 'mes' ? MESES[m.getMonth()] + '/' + m.getFullYear() : modo === 'tri' ? tri + 'º trimestre de ' + m.getFullYear() : String(m.getFullYear()),
              novoAno: modo !== 'ano' && (grupos.length === 0 || m.getMonth() < (modo === 'mes' ? 1 : 3)),
              marco: modo === 'ano' || grupos.length === 0 || (modo === 'mes' ? m.getMonth() % 3 === 0 : tri === 1),
              atual: m.getFullYear() === atual.getFullYear() && (modo === 'ano' || (modo === 'mes' ? m.getMonth() === atual.getMonth() : Math.floor(m.getMonth() / 3) === Math.floor(atual.getMonth() / 3))) };
        grupos.push(g);
      }
      g.v += q[chaveMes(m)] || 0;
    });
    if (!grupos.some(function (g) { return g.v; })) return '<p class="nc-af-vazio-q">' + o.vazio + '</p>';
    var max = Math.max.apply(null, grupos.map(function (g) { return g.v; })) || 1;
    var pico = grupos.reduce(function (a, g) { return g.v > a.v ? g : a; }, grupos[0]);
    var por = modo === 'mes' ? 'mês' : modo === 'tri' ? 'trimestre' : 'ano';
    return '<p class="nc-af-por">Por ' + por + '</p><ol class="nc-af-meses">' + grupos.map(function (g) {
      var rot = g.dica + ': ' + plural(g.v, o.um, o.varios);
      return '<li class="nc-af-mes' + (g.atual ? ' is-atual' : '') + (g.marco ? ' is-marco' : '') + (g === pico ? ' is-pico' : '') + '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '">' +
        '<b>' + (g.v ? num(g.v) : '') + '</b><i style="height:' + (g.v ? Math.max(4, Math.round(g.v / max * 100)) : 0) + '%"></i><span>' + g.curto + (g.novoAno ? '<em>' + g.ano + '</em>' : '') + '</span></li>';
    }).join('') + '</ol>' +
      '<p class="nc-af-pico">' + (modo === 'mes' ? 'Mês' : modo === 'tri' ? 'Trimestre' : 'Ano') + ' ' + o.pico + ': <b>' + pico.dica + '</b> · ' + plural(pico.v, o.um, o.varios) + '</p>';
  }
  /* cada coluna com menos de 34 px: modo "denso" (só marcos e pico) */
  function ajustarMeses() {
    var ol = P && P.caixa.querySelector('.nc-af-meses'); if (!ol || !ol.children.length) return;
    ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 34);
  }
  var tAj = 0;
  window.addEventListener('resize', function () { clearTimeout(tAj); tAj = setTimeout(ajustarMeses, 120); });
  function chaveMes(m) { return m.getFullYear() + '-' + ('0' + (m.getMonth() + 1)).slice(-2); }

  /* ═══ [J6] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncFerPainelIniciou) return; if (montar()) { window.__ncFerPainelIniciou = true; buscar(); } }
  window.__ncFerPainelDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
