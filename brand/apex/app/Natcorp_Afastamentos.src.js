/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AFASTAMENTOS  —  o painel de indicadores (JavaScript)                          ║
   ║  App 200 · Página 25 (Controle de Funcionários Afastados)                                 ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: AFASTAMENTOS-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima do relatório, um RESUMO para quem cuida das pessoas (gestor, RH, DP), escrito do jeito
   que se fala:
     HOJE        Fora agora · Voltam em até 7 dias · Volta atrasada · Sem data de volta ·
                 Há mais de 15 dias fora. Tocar num número mostra QUEM são, logo abaixo, já na
                 ordem que importa (o mais atrasado primeiro, quem está fora há mais tempo…).
     NO PERÍODO  uma frase ("37 pessoas se afastaram 52 vezes, somando 1.240 dias fora") e o
                 índice "de cada 100 dias de trabalho, X foram perdidos"; mês a mês; o que mais
                 afasta; onde mais acontece (por centro de custo, empresa, filial, unidade adm.,
                 atividade, cargo ou vínculo — quem olha escolhe); quem se afastou mais de uma vez.
     FILTRAR     "Filtrar este resumo" (as colunas da tabela, VÁRIOS valores em cada uma) e tocar numa barra de "O que mais afasta"
                 ou "Onde mais acontece" deixam o RESUMO inteiro só com aquilo — Hoje e o período —,
                 na hora: o servidor manda cada afastamento com as colunas e as contas são feitas aqui
                 (12/10). A tabela não muda (ela tem os filtros da página e a busca dela).
   Os números vêm do servidor (processo NC_AFAST_INDICADORES) com os MESMOS filtros da página.
   Sem data no filtro, o período é o dos últimos 12 meses (o painel diz isso).

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda o relatório nem os filtros. O "Pesquisar" da página continua igual (e o painel
       recalcula quando a página volta).
     • Os filtros feitos DENTRO do relatório (menu Ações) não entram nos números: o painel avisa.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 25 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_Afastamentos.js
     Página 25 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_Afastamentos.css
     Página 25 › Processing › Ajax Callback NC_AFAST_INDICADORES  (NC_AFAST_INDICADORES.plsql.sql)
   O COMBINADO com a página: o relatório tem Static ID "IR" e os filtros são os itens P25_*.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Textos e ferramentas ............ frases, ícones, datas                     PODE MEXER
     [J2] Os dados ........................ chamada ao servidor                        CUIDADO
     [J3] A moldura ....................... título, esconder/mostrar
     [J4] Hoje ............................ a régua de 5 números e a lista "quem são"  PODE MEXER
     [J5] No período ...................... frase, mês a mês, motivos, setores, pessoas PODE MEXER
     [J7] Filtrar e cruzar ................ as colunas, as contas na tela, a faixa de filtros  PODE MEXER
     [J6] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncAfast) return;
  window.__ncAfast = true;

  /* este relatório continua com Tabela | Cartões (o Natcorp_Registros pula página que tem um
     desenho próprio — esta tem — a não ser que o relatório venha marcado com nc-reg-sim) */
  function marcarRelatorio() { var ir = document.getElementById('IR'); if (ir) ir.classList.add('nc-reg-sim'); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  /* ═══ [J1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_AFAST_INDICADORES';
  var ITENS = ['P25_EMPRESA', 'P25_FILIAL', 'P25_CCUSTO', 'P25_UNIDADE_ADM', 'P25_ATIVIDADE', 'P25_CARGO', 'P25_MATRICULA', 'P25_SITUACAO', 'P25_DATA_INI', 'P25_DATA_FIM'];
  var POR_VEZ = 30;                       /* pessoas que a lista "quem são" mostra de cada vez */
  var POR_VEZ_Q = 6;                      /* linhas de cada quadro do período, de cada vez */
  var GUARDA = 'nc-af-fechado';           /* o painel escondido fica lembrado neste navegador */
  var VALIDADE = 10 * 60 * 1000;         /* o resumo calculado vale 10 min nesta aba (mesmos filtros) */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

  /* as colunas da tabela que o resumo sabe filtrar e cruzar. "i" = a posição em cada afastamento
     (ev) e em "k" de cada pessoa de hoje — a MESMA ordem do NC_AFAST_INDICADORES; "col" = a coluna do
     relatório onde o "Ver na tabela" procura (o alias da consulta); "nome" = o nome do
     filtro da página ("curto" = no "por" do quadro, que é estreito). A ordem aqui é a ordem na faixa
     "Filtrar este resumo". */
  var DIMS = [
    { k: 'emp',  i: 1, col: 'NOME_EMPRESA', nome: 'Empresa',                  todos: 'Todas' },
    { k: 'fil',  i: 2, col: 'NOME_FILIAL',  nome: 'Filial',                   todos: 'Todas' },
    { k: 'cc',   i: 3, col: 'NOME_CCUSTO',  nome: 'Centro de Custo (Célula)', todos: 'Todos', curto: 'Centro de custo' },
    { k: 'un',   i: 4, col: 'UNIDADE_ADM',  nome: 'Unidade Adm. (Cliente)',   todos: 'Todas', curto: 'Unidade adm. (cliente)' },
    { k: 'at',   i: 5, col: 'ATIVIDADE',    nome: 'Atividade (Serviço)',      todos: 'Todas', curto: 'Atividade (serviço)' },
    { k: 'car',  i: 6, col: 'CARGO',        nome: 'Cargo',                    todos: 'Todos' },
    { k: 'vin',  i: 7, col: 'VINCULO',      nome: 'Vínculo',                  todos: 'Todos' },
    { k: 'tipo', i: 0, col: 'SITUACAO',     nome: 'Motivo do afastamento',    todos: 'Todos' }
  ];
  var DIM = {}; DIMS.forEach(function (x) { DIM[x.k] = x; });
  var POR_PADRAO = 'cc';                  /* "Onde mais acontece" abre por centro de custo */
  var GUARDA_POR = 'nc-af-por';           /* a última escolha do "por" fica lembrada neste navegador */

  /* os 5 números de HOJE: a ordem é a ordem na tela */
  var HOJE = [
    { k: 'total',     cor: 'roxo',     ic: 'pessoas', diz: 'Fora agora',           dica: 'estão afastadas hoje' },
    { k: 'voltam7',   cor: 'verde',    ic: 'volta',   diz: 'Voltam em até 7 dias', dica: 'prepare a volta ao trabalho' },
    { k: 'atrasados', cor: 'vermelho', ic: 'alarme',  diz: 'Volta atrasada',       dica: 'a data de volta já passou: confirme com a pessoa', alerta: true },
    { k: 'semData',   cor: 'ambar',    ic: 'duvida',  diz: 'Sem data de volta',    dica: 'falta informar quando a pessoa volta', alerta: true },
    { k: 'mais15',    cor: 'rosa',     ic: 'relogio', diz: 'Há mais de 15 dias',   dica: 'em doença, do 16º dia em diante quem paga é o INSS' }
  ];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    volta: '<path d="M4 12a8 8 0 1 0 2.3-5.6"/><path d="M4 4v4h4"/><path d="M12 8v4l2.5 2"/>',
    alarme: '<circle cx="12" cy="13" r="7"/><path d="M12 9.5V13l2 1.5M5 4.5 3 6.5M19 4.5l2 2"/>',
    duvida: '<circle cx="12" cy="12" r="8.5"/><path d="M9.6 9.4a2.5 2.5 0 0 1 4.8.9c0 1.7-2.4 2-2.4 3.7"/><path d="M12 17h.01"/>',
    relogio: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4"/><path d="M9 14h3v3"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>',
    tirar: '<path d="M7 7l10 10M17 7 7 17"/>',
    filtro: '<path d="M4 5.5h16l-6.2 7.3v5.4l-3.6 1.8v-7.2z"/>',
    marca: '<path d="M5 12.5l4.2 4.2L19 7"/>'
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
    return 'nc-af-dados2:' + ITENS.map(function (i) { var e = document.getElementById(i); return e ? (apex.item(i).getValue() || '') : ''; }).join('|');
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
    var ir = document.getElementById('IR');
    if (!ir) return false;
    var caixa = el('section', 'nc-af');
    caixa.setAttribute('aria-labelledby', 'nc-af-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-af-titulo">Resumo dos afastamentos</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-af-esconde aria-controls="nc-af-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-af-corpo"></div>';
    ir.parentNode.insertBefore(caixa, ir);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-af-esconde]'), filtro: null, quantos: POR_VEZ, f: {}, por: POR_PADRAO };
    try { var por = localStorage.getItem(GUARDA_POR); if (DIM[por] && por !== 'tipo') P.por = por; } catch (e) { /* ok */ }
    /* nasce COMPACTO (só a faixa de números; a tabela é a função principal): abre a análise quem pediu */
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '0'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    caixa.addEventListener('click', clique);
    caixa.addEventListener('change', mudou);
    return true;
  }
  function abrirFechar(aberto) {
    if (typeof fecharLista === 'function') fecharLista(false);
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
    if (b.hasAttribute('data-af-filtra')) { alternar(b.getAttribute('data-af-filtra'), b.getAttribute('data-af-valor')); return; }
    if (b.hasAttribute('data-af-tira')) { tirarFiltro(b.getAttribute('data-af-tira')); return; }
    if (b.hasAttribute('data-af-limpa')) { limparFiltros(); return; }
    if (b.hasAttribute('data-af-abre')) { var ab = b.getAttribute('data-af-abre'); if (P.pop && P.pop.k === ab) fecharLista(true); else abrirLista(ab); return; }
    if (b.hasAttribute('data-af-pronto')) { fecharLista(true); return; }
    if (b.hasAttribute('data-af-pop-limpa')) { delete P.f[P.pop.k]; redesenhar({ pop: true }); marcarLista(); return; }
    if (b.hasAttribute('data-af-tabela')) { naTabela(b.getAttribute('data-af-tabela'), b.getAttribute('data-af-col')); return; }
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
    /* conta pesada (todos os afastamentos do período): depois de 6 s, dizer que segue trabalhando */
    pararCalculo();
    P.lento = calculando(["Buscando os afastamentos…", "Contando quem está fora hoje…", "Montando o período…", "Ainda calculando: com muitos colaboradores leva mais tempo"]);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_AFAST|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia AFASTAMENTOS-MANUTENCAO.md).'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [J4] HOJE ═════════════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    var hoje = data(d.hoje) || new Date();
    /* cada pessoa ganha: dias fora, e como está a volta (atrasada / sem data / logo / depois) */
    (d.pessoas || []).forEach(function (p) {
      p.dD = data(p.d); p.dR = data(p.r);
      p.fora = p.dD ? dias(p.dD, hoje) + 1 : null;
      p.volta = !p.dR ? 'sem' : p.dR < hoje ? 'atrasada' : dias(hoje, p.dR) <= 7 ? 'logo' : 'depois';
      p.kk = typeof p.k === 'string' ? p.k.split(',').map(Number) : null;   /* as colunas, em números (v2) */
    });
    P.dados = d; P.hoje = hoje; P.filtro = null;
    P.hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.caixa.querySelector('[data-af-atualiza]').hidden = false;
    P.corpo.innerHTML =
      '<div class="nc-af-filtros" role="group" aria-label="Filtrar este resumo" hidden></div>' +
      '<div class="nc-af-secao"><p class="nc-af-rot">Hoje</p><div class="nc-af-regua" role="group" aria-label="Quem está afastado hoje"></div>' +
      '<div class="nc-af-quem" id="nc-af-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    redesenhar();
  }
  /* refaz o resumo com os filtros do painel (sem ir ao servidor): contas, faixa de filtros, Hoje e
     período. "foco" = o controle que estava em uso, para o teclado não se perder no redesenho. */
  function redesenhar(foco) {
    if (P.pop && !(foco && foco.pop)) fecharLista(false);
    P.A = agregar();
    var n = Object.keys(P.A.fi).length;
    P.quando.innerHTML = 'Hoje, <b>' + esc(P.dados.hoje) + '</b> · com os filtros da página' +
      (n ? ' e <b>' + plural(n, 'filtro', 'filtros') + ' deste resumo</b>' : '') + (P.hm ? ' · calculado às ' + P.hm : '');
    desenharFiltros();
    desenharHoje();
    desenharPeriodo();
    if (foco) refocar(foco);
  }
  function desenharHoje() {
    var a = P.A.agora || {};
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
  var PESO = { atrasada: 0, sem: 1, logo: 2, depois: 3 };
  function daLista(k) {
    var ps = P.A.pessoas.slice();
    if (k === 'voltam7') return ps.filter(function (p) { return p.volta === 'logo'; }).sort(function (x, y) { return x.dR - y.dR; });
    if (k === 'atrasados') return ps.filter(function (p) { return p.volta === 'atrasada'; }).sort(function (x, y) { return x.dR - y.dR; });
    if (k === 'semData') return ps.filter(function (p) { return p.volta === 'sem'; }).sort(function (x, y) { return (y.fora || 0) - (x.fora || 0); });
    if (k === 'mais15') return ps.filter(function (p) { return (p.fora || 0) > 15; }).sort(function (x, y) { return (y.fora || 0) - (x.fora || 0); });
    return ps.sort(function (x, y) { return PESO[x.volta] - PESO[y.volta] || (x.dR || 0) - (y.dR || 0); });
  }
  var ORDEM = { total: 'o que pede atenção primeiro', voltam7: 'quem volta antes primeiro', atrasados: 'o mais atrasado primeiro', semData: 'quem está fora há mais tempo primeiro', mais15: 'quem está fora há mais tempo primeiro' };
  function voltaHtml(p) {
    if (p.volta === 'sem') return '<span class="nc-af-volta nc-af-volta--sem">Sem data de volta</span>';
    var n = dias(P.hoje, p.dR);
    if (p.volta === 'atrasada') return '<span class="nc-af-volta nc-af-volta--atrasada">Atrasada há ' + plural(-n, 'dia', 'dias') + ' · era ' + curta(p.dR) + '</span>';
    if (p.volta === 'logo') return '<span class="nc-af-volta nc-af-volta--logo">' + (n === 0 ? 'Volta hoje' : n === 1 ? 'Volta amanhã' : 'Volta em ' + n + ' dias') + ' · ' + curta(p.dR) + '</span>';
    return '<span class="nc-af-volta">Volta em ' + esc(p.r) + '</span>';
  }
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro) { box.hidden = true; box.innerHTML = ''; return; }
    var h = HOJE.filter(function (x) { return x.k === P.filtro; })[0], ps = daLista(P.filtro);
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + h.diz + ': ' + plural(ps.length, 'pessoa', 'pessoas') + '</h3><p>' + ORDEM[P.filtro] + ' · toque numa pessoa para ver os afastamentos dela na tabela</p>' +
      (ps.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome, cargo, setor ou motivo" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', ps.map(function (p) {
        var t = partes(p.t);
        return '<li data-af-texto="' + esc(semAcento([p.n, p.c, p.s, p.t].join(' '))) + '"><button type="button" class="nc-af-p" data-af-tabela="' + esc(p.n) + '" data-af-col="COLABORADOR" title="Ver os afastamentos de ' + esc(partes(p.n)[1]) + ' na tabela">' +
          '<span class="nc-af-p-quem"><b>' + esc(p.n) + '</b><span>' + esc(partes(p.c)[1]) + ' · ' + esc(partes(p.s)[1]) + '</span></span>' +
          '<span class="nc-af-p-tipo">' + esc(t[1] || p.t) + '</span>' +
          '<span class="nc-af-p-desde">Desde ' + esc(p.d || '—') + (p.fora != null ? '<span>há ' + plural(p.fora, 'dia', 'dias') + '</span>' : '') + '</span>' +
          voltaHtml(p) + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
      }), POR_VEZ, 'pessoas') +
      (P.dados.agora && P.dados.agora.cortou ? '<p class="nc-af-nota">A lista mostra as primeiras ' + num((P.dados.pessoas || []).length) + ' pessoas' +
        (P.A.filtrado ? ' (e os números de hoje, com o filtro deste resumo, contam só elas)' : '') + '. Use os filtros da página para ver menos de cada vez.</p>' : '');
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
     Tocar num motivo, num centro de custo ou numa pessoa usa a PRÓPRIA busca do relatório, MAS SÓ NA
     COLUNA certa (13/10, pedido do usuário: procurar o texto em todas as colunas deixava o relatório
     lento). É o mesmo que escolher a coluna na lupa da busca ("Pesquisar: C.Custo") e digitar: o
     menu da lupa é um menu do APEX cujo grupo de opções tem set(coluna) — chamamos esse set. Coluna
     que o relatório não mostra (ex.: Vínculo oculto) não está no menu: aí a busca vai em todas.
     O texto buscado é o que a coluna mostra ("14 - Aposent. Invalidez", "10560103 - Linha De Frente").
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* escolhe a coluna da busca do relatório; devolve o nome dela na tela ("C.Custo") ou null (todas).
     O menu da lupa só monta as opções quando é aberto (e abre com uma chamada ao servidor), então
     fazemos o que o set() dele faz: o alias no campo escondido IR_column_search_current_column e o
     "Pesquisar: C.Custo" no campo. A coluna só vale se o relatório a MOSTRA (título no cabeçalho) —
     coluna oculta pelo usuário (ex.: Vínculo) faz a busca ir em todas. */
  var TITULO_COL = { NOME_EMPRESA: 'Empresa', NOME_FILIAL: 'Filial', NOME_CCUSTO: 'C.Custo', UNIDADE_ADM: 'Unidade Adm.', ATIVIDADE: 'Atividade',
                     CARGO: 'Cargo', VINCULO: 'Vínculo', SITUACAO: 'Situação', COLABORADOR: 'Colaborador' };
  function colunaDaBusca(col) {
    var h = document.getElementById('IR_column_search_current_column'), f = document.getElementById('IR_search_field');
    if (!h || !f) return null;
    var tit = TITULO_COL[col], visivel = tit && [].some.call(document.querySelectorAll('#IR .a-IRR-table th'), function (th) { return th.textContent.trim() === tit; });
    var rot = visivel ? 'Pesquisar: ' + tit : '';
    h.value = visivel ? col : '';
    f.setAttribute('placeholder', rot); f.setAttribute('title', rot || 'Pesquisar');
    return visivel ? tit : null;
  }
  function naTabela(texto, col) {
    var f = document.getElementById('IR_search_field'), b = document.getElementById('IR_search_button');
    if (!f || !b) return irParaTabela();
    /* o relatório (ou a Trajetória) ainda carregando PERDE o clique na busca (visto em 08/10): espera a
       página ficar livre (até 8 s) e só então busca */
    P.quando.textContent = 'Filtrando a tabela…';
    irParaTabela();
    var t0 = Date.now();
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      var nomeCol = colunaDaBusca(col);
      f.value = texto;
      b.click();
      P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>' + (nomeCol ? ' (na coluna ' + esc(nomeCol) + ')' : '') +
        '. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
    })();
  }
  function irParaTabela() {
    var ir = document.getElementById('IR'); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [J5] NO PERÍODO ═══════════════════════════════════════════════════════════════════ */
  function desenharPeriodo() {
    var d = P.dados, A = P.A, pe = A.periodo || { vezes: 0, pessoas: 0, dias: 0 }, ini = data(d.ini), fim = data(d.fim);
    var rot = d.padrao ? 'Nos últimos 12 meses' : 'De ' + esc(d.ini) + ' a ' + esc(d.fim);
    var frase;
    if (!pe.vezes) frase = '<p class="nc-af-frase">Nenhum afastamento neste período' + (A.filtrado ? ' com os filtros deste resumo' : '') + '.</p>';
    else {
      frase = '<p class="nc-af-frase"><b>' + plural(pe.pessoas, 'pessoa', 'pessoas') + '</b> ' + (pe.pessoas === 1 ? 'se afastou' : 'se afastaram') +
        ' <b>' + plural(pe.vezes, 'vez', 'vezes') + '</b>, somando <b>' + plural(pe.dias, 'dia', 'dias') + '</b> fora do trabalho.';
      var diasPer = ini && fim ? dias(ini, fim) + 1 : 0;
      if (A.quadro && diasPer) {
        var taxa = pe.dias / (A.quadro * diasPer) * 100;
        frase += '<span class="nc-af-taxa">De cada 100 dias de trabalho, <b>' + (taxa < 0.1 ? 'menos de 0,1' : taxa.toLocaleString('pt-BR', { maximumFractionDigits: 1 })) +
          '</b> foram perdidos com afastamentos (' + plural(A.quadro, 'pessoa', 'pessoas') + ' no quadro' + (A.quadroFiltrado ? ' com estes filtros' : '') + ').</span>';
      }
      frase += '</p>';
    }
    P.caixa.querySelector('.nc-af-periodo').innerHTML = '<p class="nc-af-rot">' + rot + '</p>' + frase +
      (pe.vezes || A.tipos.length || A.setores.length ? '<div class="nc-af-quadros">' +
        quadro('Quando começaram', 'Afastamentos que começaram em cada período · passe o mouse nas colunas', meses(A.meses || [], ini, fim), 'nc-af-q--meses') +
        quadro('O que mais afasta', A.v2 ? 'Os motivos · toque para filtrar o resumo' : 'Os motivos · toque para ver na tabela', barras(A.tipos, A.totTipos, 'SITUACAO')) +
        quadro('Onde mais acontece', A.v2 ? 'Toque para filtrar o resumo' : 'Centros de custo · toque para ver na tabela', barras(A.setores, A.totOnde, 'NOME_CCUSTO'), '', A.v2 ? verPor() : '') +
        quadro('Mais de uma vez', 'Pessoas que se afastaram 2 vezes ou mais', (A.repetem || []).length ? barras(A.repetem, 0, 'COLABORADOR') : '<p class="nc-af-vazio-q">Ninguém se afastou mais de uma vez neste período.</p>') +
        '</div>' : '');
    var per = P.caixa.querySelector('.nc-af-periodo');
    ligarRolos(per);
    ajustarMeses();
  }
  function quadro(tit, dica, corpo, cls, extra) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3>' + (extra || '') + '<p>' + dica + '</p>' + corpo + '</section>'; }
  /* cada linha é um BOTÃO "ver na tabela"; o número mostra vezes, a parte do total (%) e os dias */
  /* Linha com "dim" (motivos e "onde", v2): tocar FILTRA o resumo (de novo: tira o filtro) e o botão
     pequeno à direita leva para a tabela. Linha sem "dim" (pessoas, ou o servidor antigo): a linha
     inteira leva para a tabela, como antes. Com uma linha escolhida, as outras ficam apagadas — a lista
     não some (dá para trocar de escolha) — e a escolhida fica sempre à vista no rolo. */
  function barras(xs, total, col) {
    xs = xs || [];
    if (!xs.length) return '<p class="nc-af-vazio-q">Nada neste período' + (P.A && P.A.filtrado ? ' com estes filtros' : '') + '.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    var iSel = -1; xs.forEach(function (x, i) { if (x.sel) iSel = i; });      /* a ÚLTIMA escolhida: o rolo mostra até ela */
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = total ? Math.round(x.q / total * 100) : null;
      var miolo = '<span class="nc-af-b-nome">' + (x.sel ? ic('marca') : '') + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? 'vez' : 'vezes') + (pct != null ? ' · ' + (pct < 1 ? '&lt;1' : pct) + '%' : '') + (x.d != null ? ' · ' + plural(x.d, 'dia', 'dias') : '') + '</small></span>';
      if (!x.dim) {
        return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-af-tabela="' + esc(x.t) + '" data-af-col="' + (col || '') + '" title="Ver ' + esc(x.t) + ' na tabela">' + miolo +
          '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
      }
      var cls = (x.sel ? ' is-escolhido' : iSel >= 0 ? ' is-apagado' : '') + (i === 0 && iSel < 0 ? ' is-maior' : '');
      return '<li class="nc-af-bl"><button type="button" class="nc-af-b nc-af-b--filtra' + cls + '" data-af-filtra="' + x.dim + '" data-af-valor="' + esc(x.t) + '" aria-pressed="' + !!x.sel + '"' +
        ' title="' + (x.sel ? 'Tirar ' + esc(x.t) + ' do filtro' : iSel >= 0 ? 'Juntar ' + esc(x.t) + ' ao filtro' : 'Ver o resumo só de ' + esc(x.t)) + '">' + miolo + '</button>' +
        '<button type="button" class="nc-af-b-tab" data-af-tabela="' + esc(x.t) + '" data-af-col="' + DIM[x.dim].col + '" title="Ver ' + esc(x.t) + ' na tabela" aria-label="Ver ' + esc(x.t) + ' na tabela">' + ic('tabela') + '</button></li>';
    }), Math.max(POR_VEZ_Q, iSel + 1), 'linhas');
  }
  /* MÊS A MÊS que se adapta ao período: até 24 meses, uma coluna por mês; até 24 trimestres, por
     trimestre; acima disso, por ano (o título do quadro diz qual). Muitas colunas estreitas: o nome
     só nos marcos e o número só no pico — o resto aparece ao passar o mouse ou tocar (ajustarMeses). */
  function meses(ms, ini, fim) {
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
    if (!grupos.some(function (g) { return g.v; })) return '<p class="nc-af-vazio-q">Nenhum afastamento começou neste período. Os que aparecem nos números começaram antes e continuam.</p>';
    var max = Math.max.apply(null, grupos.map(function (g) { return g.v; })) || 1;
    var pico = grupos.reduce(function (a, g) { return g.v > a.v ? g : a; }, grupos[0]);
    var por = modo === 'mes' ? 'mês' : modo === 'tri' ? 'trimestre' : 'ano';
    return '<p class="nc-af-por">Por ' + por + '</p><ol class="nc-af-meses">' + grupos.map(function (g) {
      var rot = g.dica + ': ' + plural(g.v, 'afastamento', 'afastamentos');
      return '<li class="nc-af-mes' + (g.atual ? ' is-atual' : '') + (g.marco ? ' is-marco' : '') + (g === pico ? ' is-pico' : '') + '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '">' +
        '<b>' + (g.v ? num(g.v) : '') + '</b><i style="height:' + (g.v ? Math.max(4, Math.round(g.v / max * 100)) : 0) + '%"></i><span>' + g.curto + (g.novoAno ? '<em>' + g.ano + '</em>' : '') + '</span></li>';
    }).join('') + '</ol>' +
      '<p class="nc-af-pico">' + (modo === 'mes' ? 'Mês' : modo === 'tri' ? 'Trimestre' : 'Ano') + ' com mais: <b>' + pico.dica + '</b> · ' + plural(pico.v, 'afastamento', 'afastamentos') + '</p>';
  }
  /* cada coluna com menos de 34 px: modo "denso" (só marcos e pico) */
  function ajustarMeses() {
    var ol = P && P.caixa.querySelector('.nc-af-meses'); if (!ol || !ol.children.length) return;
    ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 34);
  }
  var tAj = 0;
  window.addEventListener('resize', function () { clearTimeout(tAj); tAj = setTimeout(ajustarMeses, 120); });
  function chaveMes(m) { return m.getFullYear() + '-' + ('0' + (m.getMonth() + 1)).slice(-2); }

  /* ═══ [J7] FILTRAR E CRUZAR ═════════════════════════════════════════════════════════════
     O servidor (v2) manda CADA afastamento do período como números: ev = [motivo, empresa, filial,
     ccusto, unidade, atividade, cargo, vínculo, pessoa, AAAAMM, dias], e os nomes em dims. As contas
     do resumo são feitas aqui, então filtrar ou trocar o "por" é na hora, sem calcular de novo.
     O filtro guarda os NOMES, vários por coluna (P.f = { fil: ["3 - Filial Centro", "4 - Filial Norte"] }):
     sobrevive ao "Atualizar". Dentro da coluna vale QUALQUER um dos escolhidos; entre colunas, TODAS.
     Uma lista ignora o filtro da PRÓPRIA coluna (mostra as outras opções apagadas, dá para trocar);
     todo o resto respeita todos os filtros.
     CUIDADO  As posições (DIMS[].i) são as do NC_AFAST_INDICADORES. Servidor antigo (sem "ev"): o
              resumo funciona como antes, sem a faixa de filtros e sem o "por".
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* os filtros em números (posição do nome em dims); um nome que sumiu dos dados sai do filtro */
  function filtrosIdx() {
    var fi = {}, dims = P.dados.dims || {};
    Object.keys(P.f).forEach(function (k) {
      var m = {}, ok = [];
      (P.f[k] || []).forEach(function (t) { var i = (dims[k] || []).indexOf(t); if (i >= 0) { m[i] = 1; ok.push(t); } });
      if (ok.length) { fi[k] = m; P.f[k] = ok; } else delete P.f[k];
    });
    return fi;
  }
  /* a linha passa nos filtros? "base" = deslocamento das colunas (quadroG não tem o motivo: -1);
     "sem" = a coluna cujo filtro não vale (a lista dela mesma) */
  function passa(r, base, fi, sem) {
    for (var k in fi) {
      if (k === sem) continue;
      var c = DIM[k].i + base;
      if (c < 0) continue;
      if (!fi[k][r[c]]) return false;            /* qualquer um dos escolhidos da coluna */
    }
    return true;
  }
  function agregar() {
    var d = P.dados, pe0 = d.periodo || { vezes: 0, pessoas: 0, dias: 0 };
    if (!d.ev) {
      return { v2: false, fi: {}, filtrado: false, pessoas: d.pessoas || [], agora: d.agora, periodo: pe0, tipos: d.tipos || [], setores: d.setores || [],
               repetem: d.repetem || [], meses: d.meses || [], quadro: d.quadro, totTipos: pe0.vezes, totOnde: pe0.vezes };
    }
    var fi = filtrosIdx(), filtrado = Object.keys(fi).length > 0, dims = d.dims || {}, por = DIM[P.por] && P.por !== 'tipo' ? P.por : POR_PADRAO;
    var pe = { vezes: 0, pessoas: 0, dias: 0 }, vistos = {}, ms = {}, rep = {}, gT = {}, gO = {}, iPor = DIM[por].i;
    function junta(g, v, r) {
      var x = g[v] || (g[v] = { q: 0, d: 0, p: 0, ps: {} });
      x.q++; x.d += r[10];
      if (!x.ps[r[8]]) { x.ps[r[8]] = 1; x.p++; }
    }
    d.ev.forEach(function (r) {
      var todos = !filtrado || passa(r, 0, fi);
      if (todos) {
        pe.vezes++; pe.dias += r[10];
        if (!vistos[r[8]]) { vistos[r[8]] = 1; pe.pessoas++; }
        ms[r[9]] = (ms[r[9]] || 0) + 1;
        var x = rep[r[8]] || (rep[r[8]] = { q: 0, d: 0 }); x.q++; x.d += r[10];
      }
      if (todos || passa(r, 0, fi, 'tipo')) junta(gT, r[0], r);
      if (todos || passa(r, 0, fi, por)) junta(gO, r[iPor], r);
    });
    function lista(g, dim) {
      var tot = 0;
      var xs = Object.keys(g).map(function (v) { var x = g[v]; tot += x.q; return { t: (dims[dim] || [])[v], q: x.q, d: x.d, p: x.p, dim: dim, sel: !!(fi[dim] && fi[dim][v]) }; })
        .sort(function (a, b) { return b.q - a.q || b.d - a.d; }).slice(0, 300);
      return { xs: xs, tot: tot };
    }
    var T = lista(gT, 'tipo'), O = lista(gO, por);
    var repetem = Object.keys(rep).filter(function (k) { return rep[k].q >= 2; })
      .map(function (k) { return { t: (d.nomes || {})[k] || 'Pessoa ' + k, q: rep[k].q, d: rep[k].d }; })
      .sort(function (a, b) { return b.q - a.q || b.d - a.d; }).slice(0, 300);
    var meses = Object.keys(ms).map(function (m) { return { m: m.slice(0, 4) + '-' + m.slice(4, 6), q: ms[m] }; });
    /* o quadro (para o índice) com os filtros das colunas da pessoa; o motivo não muda o quadro */
    var quadro = d.quadro, qf = Object.keys(fi).some(function (k) { return k !== 'tipo'; });
    if (qf && d.quadroG) { quadro = 0; d.quadroG.forEach(function (r) { if (passa(r, -1, fi)) quadro += r[7]; }); }
    /* hoje: as pessoas com os filtros; os 5 números contados aqui, com a mesma regra do servidor */
    var pessoas = d.pessoas || [], agora = d.agora;
    if (filtrado) {
      pessoas = pessoas.filter(function (p) { return p.kk && passa(p.kk, 0, fi); });
      agora = { total: pessoas.length, voltam7: 0, atrasados: 0, semData: 0, mais15: 0, cortou: d.agora && d.agora.cortou };
      pessoas.forEach(function (p) {
        if (p.volta === 'sem') agora.semData++; else if (p.volta === 'atrasada') agora.atrasados++; else if (p.volta === 'logo') agora.voltam7++;
        if ((p.fora || 0) > 15) agora.mais15++;
      });
    }
    return { v2: true, fi: fi, filtrado: filtrado, por: por, pessoas: pessoas, agora: agora, periodo: pe, tipos: T.xs, totTipos: T.tot,
             setores: O.xs, totOnde: O.tot, repetem: repetem, meses: meses, quadro: quadro, quadroFiltrado: qf };
  }

  /* a FAIXA "Filtrar este resumo": um botão por coluna, que abre a LISTA DE MARCAR (vários valores).
     A lista só tem o que existe nos dados, com os outros filtros já valendo (e o número de
     afastamentos de cada um); coluna com uma opção só NOS DADOS TODOS não aparece (decidido sem os
     filtros: a faixa não muda de forma enquanto se filtra). Com filtro, os "chips" (o que está
     filtrado, com ×) — são eles que ficam no modo compacto. */
  function comparar(a, b) { return String(a).localeCompare(String(b), 'pt-BR', { numeric: true, sensitivity: 'base' }); }
  function desenharFiltros() {
    var box = P.caixa.querySelector('.nc-af-filtros'); if (!box) return;
    var A = P.A;
    if (!A.v2) { box.hidden = true; return; }
    var d = P.dados, fi = A.fi, dims = d.dims || {}, n = Object.keys(fi).length;
    P.opc = {};
    if (P.nDims !== d) {                        /* quantos valores cada coluna tem, sem filtro (uma vez por dado) */
      P.nDims = d; P.nVal = {};
      DIMS.forEach(function (D) {
        var t = {}; d.ev.forEach(function (r) { t[r[D.i]] = 1; }); (d.pessoas || []).forEach(function (p) { if (p.kk) t[p.kk[D.i]] = 1; });
        P.nVal[D.k] = Object.keys(t).length;
      });
    }
    var campos = DIMS.map(function (D) {
      var tem = {};
      d.ev.forEach(function (r) { if (passa(r, 0, fi, D.k)) tem[r[D.i]] = (tem[r[D.i]] || 0) + 1; });
      (d.pessoas || []).forEach(function (p) { if (p.kk && passa(p.kk, 0, fi, D.k) && !(p.kk[D.i] in tem)) tem[p.kk[D.i]] = 0; });
      (P.f[D.k] || []).forEach(function (t) { var i = (dims[D.k] || []).indexOf(t); if (i >= 0 && !(i in tem)) tem[i] = 0; });
      var vs = Object.keys(tem).map(function (v) { return { t: (dims[D.k] || [])[v], n: tem[v] }; })
        .filter(function (x) { return x.t != null; }).sort(function (a, b) { return comparar(a.t, b.t); });
      P.opc[D.k] = vs;
      var esc_ = P.f[D.k] || [];
      if (P.nVal[D.k] < 2 && !esc_.length) return '';
      var aberto = P.pop && P.pop.k === D.k;
      return '<div class="nc-af-campo' + (esc_.length ? ' is-ativo' : '') + '"><span class="nc-af-campo-rot" id="nc-af-rot-' + D.k + '">' + D.nome + '</span>' +
        '<button type="button" class="nc-af-escolha" data-af-abre="' + D.k + '" aria-haspopup="true" aria-expanded="' + aberto + '" aria-controls="nc-af-pop"' +
        ' aria-labelledby="nc-af-rot-' + D.k + ' nc-af-val-' + D.k + '"><span class="nc-af-escolha-txt" id="nc-af-val-' + D.k + '">' +
        (esc_.length ? esc(esc_[0]) : D.todos) + '</span>' + (esc_.length > 1 ? '<b class="nc-af-mais-n" aria-label="e mais ' + (esc_.length - 1) + '">+' + (esc_.length - 1) + '</b>' : '') +
        ic('abrir') + '</button></div>';
    }).join('');
    var chips = Object.keys(fi).map(function (k) {
      var t = P.f[k], tudo = t.join(', ');
      return '<button type="button" class="nc-af-chip" data-af-tira="' + k + '" title="Tirar este filtro: ' + esc(tudo) + '" aria-label="Tirar o filtro ' + esc(DIM[k].nome + ': ' + tudo) + '">' +
        '<span>' + DIM[k].nome + '</span><b>' + esc(t[0]) + '</b>' + (t.length > 1 ? '<em>+' + (t.length - 1) + '</em>' : '') + ic('tirar') + '</button>';
    }).join('');
    box.hidden = !campos && !n;
    box.classList.toggle('is-ativo', n > 0);
    box.innerHTML = '<div class="nc-af-filtros-cab">' + ic('filtro') + '<p class="nc-af-filtros-tit">Filtrar este resumo</p>' +
      '<p class="nc-af-filtros-nota">' + (n ? 'A tabela abaixo continua com os filtros da página.' : 'Escolha um ou mais em cada caixa. A tabela abaixo não muda.') + '</p>' +
      (n ? '<button type="button" class="nc-af-limpa" data-af-limpa>' + ic('tirar') + '<span>' + (n === 1 ? 'Limpar o filtro' : 'Limpar os ' + n + ' filtros') + '</span></button>' : '') +
      '</div><div class="nc-af-filtros-campos">' + campos + '</div>' +
      (n ? '<div class="nc-af-filtros-chips"><span class="nc-af-filtros-chips-rot">Resumo só de:</span>' + chips + '</div>' : '');
  }

  /* a LISTA DE MARCAR de uma coluna: os escolhidos no alto, depois os outros em ordem; busca quando há
     mais de 8. Marcar vale NA HORA (o resumo muda atrás da lista, que fica aberta para marcar outros).
     Fecha em "Pronto", Esc ou tocando fora. Ela mora na caixa do painel (fora da faixa que é
     redesenhada) e é reposicionada embaixo do botão depois de cada redesenho. */
  function abrirLista(k) {
    fecharLista(false);
    var pop = P.caixa.querySelector('.nc-af-pop');
    if (!pop) { pop = el('div', 'nc-af-pop'); pop.id = 'nc-af-pop'; pop.setAttribute('role', 'dialog'); pop.hidden = true; P.caixa.appendChild(pop); }
    var D = DIM[k], vs = P.opc[k] || [], esc_ = P.f[k] || [];
    var ordem = vs.filter(function (x) { return esc_.indexOf(x.t) >= 0; }).concat(vs.filter(function (x) { return esc_.indexOf(x.t) < 0; }));
    pop.setAttribute('aria-label', D.nome);
    pop.innerHTML = '<div class="nc-af-pop-cab"><b>' + D.nome + '</b><span>marque um ou mais</span></div>' +
      (vs.length > 8 ? '<label class="nc-af-procura nc-af-pop-busca">' + ic('busca') + '<span class="nc-af-vis">Procurar em ' + D.nome + '</span>' +
        '<input type="search" placeholder="Procurar código ou nome" data-af-pop-busca autocomplete="off"></label>' : '') +
      '<ul class="nc-af-pop-lista">' + ordem.map(function (x) {
        return '<li data-af-texto="' + esc(semAcento(x.t)) + '"><label><input type="checkbox" data-af-marca value="' + esc(x.t) + '"' + (esc_.indexOf(x.t) >= 0 ? ' checked' : '') + '>' +
          '<span>' + esc(x.t) + '</span>' + (x.n ? '<small title="afastamentos no período">' + num(x.n) + '</small>' : '') + '</label></li>';
      }).join('') + '</ul><p class="nc-af-pop-nada" hidden>Nada com esse nome.</p>' +
      '<div class="nc-af-pop-pe"><button type="button" class="nc-af-limpa" data-af-pop-limpa>Desmarcar todos</button>' +
      '<button type="button" class="nc-af-bt nc-af-bt--cheio" data-af-pronto>Pronto</button></div>';
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
    if (!P.pop) return;
    var k = P.pop.k;
    P.pop.el.hidden = true; P.pop.el.innerHTML = ''; P.pop = null;
    var b = P.caixa.querySelector('[data-af-abre="' + k + '"]');
    if (b) { b.setAttribute('aria-expanded', 'false'); if (devolve) b.focus({ preventScroll: true }); }
  }
  /* embaixo do botão da coluna, sem passar da borda do painel */
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
  /* as marcas da lista seguem o filtro (depois de "Desmarcar todos" ou de tocar numa barra) */
  function marcarLista() {
    if (!P.pop) return;
    var esc_ = P.f[P.pop.k] || [];
    [].forEach.call(P.pop.el.querySelectorAll('[data-af-marca]'), function (x) { x.checked = esc_.indexOf(x.value) >= 0; });
  }
  document.addEventListener('mousedown', function (e) {
    if (P && P.pop && !P.pop.el.contains(e.target) && !e.target.closest('[data-af-abre]')) fecharLista(false);
  }, true);
  document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && P && P.pop) { e.preventDefault(); fecharLista(true); } });
  window.addEventListener('resize', function () { if (P && P.pop) posicionarLista(); });

  /* o "por" do quadro "Onde mais acontece" */
  function verPor() {
    return '<label class="nc-af-ver-por"><span>por</span><select data-af-por aria-label="Onde mais acontece: ver por">' +
      DIMS.filter(function (D) { return D.k !== 'tipo'; }).map(function (D) {
        return '<option value="' + D.k + '"' + (D.k === P.A.por ? ' selected' : '') + '>' + (D.curto || D.nome) + '</option>';
      }).join('') + '</select></label>';
  }
  function mudou(e) {
    var s = e.target;
    if (s.matches('[data-af-marca]') && P.pop) {
      var k = P.pop.k, l = (P.f[k] || []).filter(function (t) { return t !== s.value; });
      if (s.checked) l.push(s.value);
      if (l.length) P.f[k] = l; else delete P.f[k];
      redesenhar({ pop: true });
    } else if (s.matches('select[data-af-por]')) {
      P.por = s.value;
      try { if (s.value === POR_PADRAO) localStorage.removeItem(GUARDA_POR); else localStorage.setItem(GUARDA_POR, s.value); } catch (e2) { /* ok */ }
      redesenhar({ attr: 'data-af-por', v: '' });
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
  /* o redesenho troca os elementos: o foco volta para o equivalente novo */
  function refocar(f) {
    if (f.pop) { posicionarLista(); return; }      /* a lista continua aberta e com o foco */
    var alvo = null;
    if (f.attr) {
      [].some.call(P.caixa.querySelectorAll('[' + f.attr + ']'), function (x) { if (!f.v || x.getAttribute(f.attr) === f.v) { alvo = x; return true; } return false; });
    }
    if (!alvo && f.depois) alvo = P.caixa.querySelector(f.depois);
    if (!alvo) return;
    var li = alvo.closest('li'); if (li && li.hidden) li.hidden = false;
    alvo.focus({ preventScroll: true });
  }

  /* ═══ [J6] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() { if (window.__ncAfastIniciou) return; if (montar()) { window.__ncAfastIniciou = true; buscar(); } }
  window.__ncAfastDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
