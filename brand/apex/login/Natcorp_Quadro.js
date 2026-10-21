/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · QUADRO DE PESSOAS  —  o painel de indicadores (JavaScript)                     ║
   ║  App 200 · Página 16 (Informações Funcionais)                                             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: QUADRO-MANUTENCAO.md.

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Acima do relatório de dados pessoais e funcionais, um RESUMO do quadro de pessoas com o que uma
   grande empresa não pode deixar de acompanhar:
     HOJE         Quadro ativo (trabalhando · afastados) · Experiência acabando (15 dias) · Cota de
                  PCD (Lei 8.213, por empresa) · Documentos profissionais vencendo · Cadastro
                  incompleto (sem PIS, CPF ou conta). Tocar num número mostra QUEM são.
     12 MESES     entraram, saíram e a rotatividade em palavras; entradas e saídas por mês; por que
                  saíram; onde estão as pessoas; tempo de casa; idade; escolaridade.
   A página só mostra dados depois do "Pesquisar" (P16_PESQUISA = S): o painel segue a mesma
   regra — antes disso, explica o que fazer. Os números vêm do servidor (NC_QUADRO_INDICADORES),
   com os MESMOS filtros e a MESMA segurança (quem pode ver quem) do relatório.
   Mesmo desenho dos painéis de afastamentos (200:25) e férias (200:26): o CSS é o mesmo,
   gerado como Natcorp_Quadro.css a partir do Natcorp_Afastamentos.src.css.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 16 › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Quadro.js
     Página 16 › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_Quadro.css
     Página 16 › Processing › Ajax Callback NC_QUADRO_INDICADORES   (aplicar-quadro-pagina16.py)
   O COMBINADO com a página: o relatório tem Static ID "INF_FUNC_PESS" e os filtros são os P16_*.

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [J1] Textos e ferramentas ............ frases, ícones, datas                     PODE MEXER
     [J2] Os dados ........................ chamada ao servidor                        CUIDADO
     [J3] A moldura ....................... título, esconder/mostrar
     [J4] Hoje ............................ a régua de 5 números e a lista "quem são"  PODE MEXER
     [J5] 12 meses ........................ movimento, entradas e saídas, perfil
     [J6] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncQuadro) return;
  window.__ncQuadro = true;
  var RID = 'INF_FUNC_PESS';              /* o Static ID do relatório desta página */

  /* este relatório continua com Tabela | Cartões (o Natcorp_Registros pula página que tem um
     desenho próprio — esta tem — a não ser que o relatório venha marcado com nc-reg-sim) */
  function marcarRelatorio() { var ir = document.getElementById(RID); if (ir) ir.classList.add('nc-reg-sim'); }
  marcarRelatorio();
  document.addEventListener('DOMContentLoaded', marcarRelatorio);

  /* ═══ [J1] TEXTOS E FERRAMENTAS ═════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_QUADRO_INDICADORES';
  var ITENS = ['P16_EMPRESA', 'P16_FILIAL', 'P16_CCUSTO', 'P16_UNIDADE_ADM', 'P16_ATIVIDADE', 'P16_CARGO', 'P16_MATRICULA', 'P16_EMP', 'P16_MAT', 'P16_PESQUISA'];
  var POR_VEZ = 30;                       /* pessoas que a lista "quem são" mostra de cada vez */
  var POR_VEZ_Q = 6;                      /* linhas de cada quadro do período, de cada vez */
  var GUARDA = 'nc-qd-fechado';           /* o painel escondido fica lembrado neste navegador */
  var VALIDADE = 10 * 60 * 1000;         /* o resumo calculado vale 10 min nesta aba (mesmos filtros) */
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

  /* os 5 números de HOJE: a ordem é a ordem na tela. semLista = o número não abre lista */
  var HOJE = [
    { k: 'ativos',      cor: 'roxo',     ic: 'pessoas', diz: 'Quadro ativo',          dica: '', semLista: true },
    { k: 'experiencia', cor: 'ambar',    ic: 'relogio', diz: 'Experiência acabando',  dica: 'nos próximos 15 dias: decida antes do prazo', alerta: true },
    { k: 'pcd_faltam',  cor: 'vermelho', ic: 'cota',    diz: 'Cota de PCD',           dica: '', alerta: true, lista: 'cota' },
    { k: 'documentos',  cor: 'vermelho', ic: 'alarme',  diz: 'Documentos vencendo',   dica: 'conselho de classe ou CNH de motorista, até 30 dias', alerta: true },
    { k: 'cadastro',    cor: 'ambar',    ic: 'duvida',  diz: 'Cadastro incompleto',   dica: 'sem PIS, CPF ou conta: trava o eSocial e a folha', alerta: true }
  ];

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    cota: '<circle cx="12" cy="7" r="3"/><path d="M12 10v5M8.5 21l3.5-6 3.5 6M7 13.5h10"/>',
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
    return 'nc-qd-dados:' + ITENS.map(function (i) { var e = document.getElementById(i); return e ? (apex.item(i).getValue() || '') : ''; }).join('|');
  }
  function buscar(forcar) {
    /* a página só traz dados depois do "Pesquisar": antes, o painel explica o que fazer */
    if ((apex.item('P16_PESQUISA').getValue() || 'N') !== 'S') { semPesquisa(); return; }
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
    var caixa = el('section', 'nc-af nc-qd');
    caixa.setAttribute('aria-labelledby', 'nc-af-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-af-titulo">Resumo do quadro de pessoas</h2>' +
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
    if (b.hasAttribute('data-qd-aba')) { P.aba = b.getAttribute('data-qd-aba'); P.sub = null; try { localStorage.setItem('nc-qd-aba', P.aba); } catch (x) { /* ok */ } desenharPeriodo(); return; }
    if (b.hasAttribute('data-qd-sub')) { var ks = b.getAttribute('data-qd-sub'); P.sub = P.sub === ks ? null : ks; desenharSub(); return; }
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
    /* conta pesada (todas as pessoas do filtro): depois de 6 s, dizer que segue trabalhando */
    pararCalculo();
    P.lento = calculando(["Buscando o quadro de pessoas…", "Contando entradas e saídas…", "Conferindo prazos e documentos…", "Ainda calculando: com muitos colaboradores leva mais tempo"]);
  }
  function semPesquisa() {
    P.quando.textContent = '';
    P.caixa.querySelector('[data-af-atualiza]').hidden = true;
    P.corpo.innerHTML = '<div class="nc-af-aviso nc-qd-convite">' + ic('busca') + '<div><b>Escolha os filtros ao lado e toque em Pesquisar.</b>' +
      'O resumo do quadro de pessoas (quantas pessoas, prazos, cota de PCD, entradas e saídas) aparece aqui, com os mesmos filtros da tabela.</div></div>';
  }
  function erro(msg) {
    var falta = /processo ausente|NC_QUADRO|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia QUADRO-MANUTENCAO.md).'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-af-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [J4] HOJE ═════════════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    chegou();
    var hoje = data(d.hoje) || new Date();
    ['experiencia', 'documentos', 'cadastro'].forEach(function (k) { (d[k] || []).forEach(function (p) { p.dA = data(p.a); }); });
    P.dados = d; P.hoje = hoje; P.filtro = null;
    var hm = quando ? new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '';
    P.quando.innerHTML = 'Hoje, <b>' + esc(d.hoje) + '</b> · com os filtros da página' + (hm ? ' · calculado às ' + hm : '');
    P.caixa.querySelector('[data-af-atualiza]').hidden = false;
    P.corpo.innerHTML =
      '<div class="nc-af-secao"><p class="nc-af-rot">Hoje</p><div class="nc-af-regua" role="group" aria-label="O quadro de pessoas hoje"></div>' +
      '<div class="nc-af-quem" id="nc-af-quem" hidden aria-live="polite"></div></div>' +
      '<div class="nc-af-secao nc-af-periodo"></div>';
    desenharHoje();
    desenharPeriodo();
  }
  /* o que cada número diz embaixo, que depende dos dados */
  function dicaDe(h, a, d) {
    if (h.k === 'ativos') return num(a.trabalhando) + ' trabalhando · ' + num(a.afastados) + ' ' + (a.afastados === 1 ? 'afastada' : 'afastadas');
    if (h.k === 'pcd_faltam') return d.estrutura ? 'a cota é da empresa toda: tire os filtros de filial, centro de custo, cargo… para ver'
      : !(d.cota || []).some(function (c) { return c.exige; }) ? 'empresa com menos de 100 pessoas: sem cota'
      : a.pcd_faltam ? 'pessoas com deficiência faltando para a cota da lei (Lei 8.213)' : 'a cota da lei está cumprida (Lei 8.213)';
    return h.dica;
  }
  function desenharHoje() {
    var a = P.dados.agora || {}, d = P.dados;
    P.caixa.querySelector('.nc-af-regua').innerHTML = HOJE.map(function (h) {
      var v = Number(a[h.k] || 0), on = P.filtro === h.k, semCota = h.k === 'pcd_faltam' && (d.estrutura || !(d.cota || []).some(function (c) { return c.exige; }));
      /* cota cumprida: o quadro fica verde (é notícia boa), mas ainda abre a conta por empresa */
      var cor = h.k === 'pcd_faltam' && !v ? 'verde' : h.cor, temLista = !h.semLista && !semCota && (h.k === 'pcd_faltam' ? (d.cota || []).length : v);
      var unid = h.k === 'pcd_faltam' ? (v === 1 ? 'falta' : 'faltam') : v === 1 ? 'pessoa' : 'pessoas';
      var valor = semCota ? '—' : h.k === 'pcd_faltam' && !v ? 'Em dia' : num(v);
      return '<button type="button" class="nc-af-num nc-af-num--' + cor + (v || h.semLista ? '' : ' is-zero') + (h.alerta && v ? ' is-alerta' : '') + '" data-af-num="' + h.k + '"' +
        ' aria-pressed="' + on + '" aria-controls="nc-af-quem"' + (temLista ? '' : ' disabled') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span>' +
        '<span class="nc-af-valor' + (/\d/.test(valor) ? '' : ' is-texto') + '">' + valor + (semCota || (h.k === 'pcd_faltam' && !v) ? '' : '<small>' + unid + '</small>') + '</span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + dicaDe(h, a, d) + '</span></button>';
    }).join('');
    desenharLista();
  }
  var ORDEM = { experiencia: 'o prazo mais perto primeiro', documentos: 'o mais vencido primeiro', cadastro: 'por empresa e matrícula', pcd_faltam: 'por empresa' };
  /* o meio da linha e o selo do fim */
  function detalhe(k, p) {
    var n = p.dA ? dias(P.hoje, p.dA) : null;
    if (k === 'experiencia') return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">' + (n === 0 ? 'Hoje' : n === 1 ? 'Amanhã' : 'Em ' + n + ' dias') + ' · ' + curta(p.dA) + '</span>'];
    if (k === 'documentos') return [esc(p.t), n < 0 ? '<span class="nc-af-volta nc-af-volta--atrasada">Vencido em ' + esc(p.a) + '</span>' : '<span class="nc-af-volta nc-af-volta--sem">' + (n === 0 ? 'Vence hoje' : 'Vence em ' + plural(n, 'dia', 'dias')) + ' · ' + curta(p.dA) + '</span>'];
    return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">Completar o cadastro</span>'];
  }
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (!P.filtro) { box.hidden = true; box.innerHTML = ''; return; }
    var k = P.filtro, h = HOJE.filter(function (x) { return x.k === k; })[0], tot = Number((P.dados.agora || {})[k] || 0);
    box.hidden = false;
    /* a COTA: uma linha por empresa (não é lista de pessoas) */
    if (k === 'pcd_faltam') {
      box.innerHTML = '<div class="nc-af-quem-cab"><h3>Cota de PCD por empresa</h3><p>a lei conta os empregados da empresa toda: 100 a 200 = 2% · 201 a 500 = 3% · 501 a 1.000 = 4% · mais de 1.000 = 5%</p></div>' +
        rolo('ul', 'nc-af-lista', (P.dados.cota || []).map(function (c) {
          var falta = Math.max(0, c.exige - c.tem);
          return '<li><div class="nc-af-p nc-fp-p nc-qd-cota"><span class="nc-af-p-quem"><b>' + esc(c.t) + '</b><span>' + plural(c.ativos, 'pessoa ativa', 'pessoas ativas') + '</span></span>' +
            '<span class="nc-af-p-tipo">' + (c.exige ? 'Tem ' + num(c.tem) + ' de ' + num(c.exige) + ' exigidas' : 'Menos de 100 pessoas: sem cota') + '</span>' +
            (c.exige ? (falta ? '<span class="nc-af-volta nc-af-volta--atrasada">Faltam ' + num(falta) + '</span>' : '<span class="nc-af-volta nc-af-volta--logo">Cota cumprida</span>') : '<span></span>') + '<span></span></div></li>';
        }), POR_VEZ, 'linhas');
      ligarRolos(box); return;
    }
    listaPessoas(box, h.diz, ORDEM[k], P.dados[k], function (p) { return detalhe(k, p); }, tot);
  }
  /* uma lista "quem são" em qualquer caixa (a de HOJE e as das abas): busca, rolagem, ver na tabela */
  function listaPessoas(box, titulo, ordem, lista, det, tot) {
    var ps = (lista || []).slice();
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>' + titulo + ': ' + plural(tot, 'pessoa', 'pessoas') + '</h3><p>' + ordem + ' · toque numa pessoa para ver o cadastro dela na tabela</p>' +
      (ps.length > 12 ? '<label class="nc-af-procura">' + ic('busca') + '<span class="nc-af-vis">Procurar nesta lista</span><input type="search" placeholder="Procurar nome, cargo ou centro de custo" data-af-procura autocomplete="off"></label>' : '') + '</div>' +
      rolo('ul', 'nc-af-lista', ps.map(function (p) {
        var dt = det(p);
        return '<li data-af-texto="' + esc(semAcento([p.n, p.s, p.t].join(' '))) + '"><button type="button" class="nc-af-p nc-fp-p" data-af-tabela="' + esc(p.q || p.n) + '" title="Ver ' + esc(partes(p.n)[1]) + ' na tabela">' +
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
    if (!t) { if (box.classList.contains('nc-qd-subquem')) desenharSub(); else desenharLista(); var p2 = box.querySelector('[data-af-procura]') || P.caixa.querySelector('[data-af-procura]'); if (p2) p2.focus(); return; }
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

  /* ═══ [J5] A ANÁLISE: TRÊS ABAS ════════════════════════════════════════════════════════
     Quadro e movimento · Remuneração (só para quem vê salário: a mesma regra da tabela) ·
     Contratos e jornada. Cada aba tem a sua faixa de números (que abrem listas) e os quadros.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function reais(v) { return Number(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL', maximumFractionDigits: 0 }); }
  var ABAS = [['quadro', 'Quadro e movimento'], ['remun', 'Remuneração'], ['contr', 'Contratos e jornada']];
  function desenharPeriodo() {
    var d = P.dados, temRem = d.remun && d.remun.acesso;
    if (!P.aba) { try { P.aba = localStorage.getItem('nc-qd-aba') || 'quadro'; } catch (e) { P.aba = 'quadro'; } }
    if (P.aba === 'remun' && !temRem) P.aba = 'quadro';
    var abas = ABAS.filter(function (a) { return a[0] !== 'remun' || temRem; });
    var per = P.caixa.querySelector('.nc-af-periodo');
    per.innerHTML = '<div class="nc-qd-abas" role="tablist" aria-label="Assuntos da análise">' + abas.map(function (a) {
      return '<button type="button" role="tab" data-qd-aba="' + a[0] + '" aria-selected="' + (P.aba === a[0]) + '" id="nc-qd-aba-' + a[0] + '" aria-controls="nc-qd-painel">' + a[1] + '</button>';
    }).join('') + '</div><div class="nc-qd-painel" id="nc-qd-painel" role="tabpanel" aria-labelledby="nc-qd-aba-' + P.aba + '">' +
      (P.aba === 'remun' ? abaRemuneracao(d) : P.aba === 'contr' ? abaContratos(d) : abaQuadro(d)) + '</div>';
    ligarRolos(per);
    ajustarMeses();
    if (P.sub) desenharSub();
  }
  /* a faixa de números de uma aba: cada número abre a sua lista logo abaixo (ou não abre, sem lista) */
  function subRegua(itens) {
    return '<div class="nc-af-regua nc-af-regua--mini" role="group">' + itens.map(function (h) {
      var temLista = h.lista && h.v, on = P.sub === h.k;
      return '<button type="button" class="nc-af-num nc-af-num--' + (h.v ? h.cor : 'roxo') + (h.v ? '' : ' is-zero') + (h.alerta && h.v ? ' is-alerta' : '') + '"' + (temLista ? ' data-qd-sub="' + h.k + '" aria-pressed="' + on + '"' : ' disabled') + '>' +
        '<span class="nc-af-sinal">' + ic(h.ic) + '</span><span class="nc-af-valor' + (/\d/.test(h.valor) ? '' : ' is-texto') + '">' + h.valor + (h.unid ? '<small>' + h.unid + '</small>' : '') + '</span>' +
        '<span class="nc-af-diz">' + h.diz + '</span><span class="nc-af-dica">' + h.dica + '</span></button>';
    }).join('') + '</div><div class="nc-af-quem nc-qd-subquem" hidden aria-live="polite"></div>';
  }
  var SUB = {
    equiparacao: { tit: 'Possível equiparação salarial', ordem: 'a maior diferença primeiro', total: function (d) { return d.remun.equip; },
      det: function (p) { return [esc(p.t), '<span class="nc-af-volta nc-af-volta--atrasada">Analisar</span>']; } },
    semreajuste: { tit: 'Sem reajuste há mais de 12 meses', ordem: 'há mais tempo primeiro', total: function (d) { return d.remun.sem_reaj12; },
      det: function (p) { var m = p.dA ? Math.round(dias(p.dA, P.hoje) / 30.4) : null; return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">' + (m >= 24 ? 'Há ' + Math.floor(m / 12) + ' anos' : 'Há ' + m + ' meses') + ' · ' + esc(p.a) + '</span>']; } },
    adicionais: { tit: 'Com adicional de insalubridade ou periculosidade', ordem: 'por empresa e matrícula', total: function (d) { return (d.remun.insal || 0) + (d.remun.peric || 0); },
      det: function (p) { return [esc(p.t), '<span class="nc-af-volta">Conferir o laudo</span>']; } },
    aviso: { tit: 'Em aviso prévio', ordem: 'o aviso mais antigo primeiro', total: function (d) { return d.contr.aviso; },
      det: function (p) { var n = p.dA ? dias(p.dA, P.hoje) : null; return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">Desde ' + esc(p.a) + (n != null ? ' · há ' + plural(n, 'dia', 'dias') : '') + '</span>']; } },
    pontonao: { tit: 'Não marcam ponto (fora de liderança)', ordem: 'por empresa e matrícula', total: function (d) { return d.contr.ponto_outros; },
      det: function (p) { return [esc(p.t), '<span class="nc-af-volta nc-af-volta--sem">Conferir o motivo</span>']; } }
  };
  function desenharSub() {
    var box = P.caixa.querySelector('.nc-qd-subquem'); if (!box) return;
    [].forEach.call(P.caixa.querySelectorAll('[data-qd-sub]'), function (b) { b.setAttribute('aria-pressed', String(b.getAttribute('data-qd-sub') === P.sub)); });
    if (!P.sub || !SUB[P.sub]) { box.hidden = true; box.innerHTML = ''; return; }
    var c = SUB[P.sub];
    listaPessoas(box, c.tit, c.ordem, P.dados[P.sub], c.det, Number(c.total(P.dados) || 0));
  }

  /* ── ABA 1: quadro e movimento ── */
  function abaQuadro(d) {
    var mv = d.mov || {}, a = d.agora || {}, sx = d.sexo || {};
    /* quadro de 12 meses atrás = ativos − entraram + saíram. Cadastro com saída ANTES da admissão (visto
       na base de teste) deixa isso negativo: aí não há rotatividade confiável e a frase não aparece */
    var medio = mv.ativos_inicio > 0 ? (mv.ativos_inicio + (a.ativos || 0)) / 2 : 0, rot = medio ? ((mv.entraram || 0) + (mv.sairam || 0)) / 2 / medio * 100 : 0;
    var frase = '<p class="nc-af-frase">Nos últimos 12 meses <b>' + plural(mv.entraram || 0, 'pessoa entrou', 'pessoas entraram') + '</b> e <b>' + plural(mv.sairam || 0, 'saiu', 'saíram') + '</b>.' +
      (medio ? '<span class="nc-af-taxa">Rotatividade de <b>' + rot.toLocaleString('pt-BR', { maximumFractionDigits: 1 }) + '%</b>: é como se, de cada 100 vagas, ' + Math.round(rot) + ' tivessem trocado de pessoa no ano.</span>' : '') +
      (sx.f + sx.m ? '<span class="nc-af-taxa">Hoje: <b>' + Math.round(sx.f / (sx.f + sx.m) * 100) + '%</b> mulheres e <b>' + Math.round(sx.m / (sx.f + sx.m) * 100) + '%</b> homens' + (d.aprendizes ? ' · <b>' + num(d.aprendizes) + '</b> jovens aprendizes' : '') + '.</span>' : '') + '</p>';
    var tSai = (d.saidas || []).reduce(function (s, x) { return s + x.q; }, 0);
    return frase + '<div class="nc-af-quadros nc-af-quadros--3">' +
      quadro('Entradas e saídas por mês', 'Quem entrou e quem saiu em cada mês · passe o mouse nas colunas', entradasSaidas(d.meses || []), 'nc-af-q--meses') +
      quadro('Por que saíram', tSai ? 'Das ' + plural(tSai, 'saída', 'saídas') + ' dos últimos 12 meses' : 'Ninguém saiu nos últimos 12 meses', tSai ? fixas(d.saidas, tSai, 'pessoa', 'pessoas') : '<p class="nc-af-vazio-q">Nenhuma saída no período.</p>') +
      quadro('Onde estão as pessoas', 'Centros de custo · toque para ver na tabela', (d.setores || []).length ? barras(d.setores, { total: a.ativos, um: 'pessoa', varios: 'pessoas' }) : '<p class="nc-af-vazio-q">Ninguém ativo com estes filtros.</p>') +
      quadro('Tempo de casa', 'Há quanto tempo as pessoas estão na empresa', fixas(d.casa, a.ativos, 'pessoa', 'pessoas')) +
      quadro('Idade', 'As pessoas ativas por faixa de idade', fixas(d.idade, a.ativos, 'pessoa', 'pessoas')) +
      quadro('Escolaridade', 'Até onde as pessoas estudaram', fixas(d.escolaridade, a.ativos, 'pessoa', 'pessoas')) +
      '</div>';
  }

  /* ── ABA 2: remuneração ── */
  function abaRemuneracao(d) {
    var r = d.remun, gap = r.m_media && r.f_media ? (r.m_media - r.f_media) / r.m_media * 100 : null;
    var regua = subRegua([
      { k: 'equiparacao', cor: 'vermelho', ic: 'alarme', valor: num(r.equip), unid: r.equip === 1 ? 'pessoa' : 'pessoas', v: r.equip, lista: true, alerta: true,
        diz: 'Possível equiparação', dica: 'mesmo cargo e filial, colega ganha 10% ou mais (CLT art. 461)' },
      { k: 'genero', cor: gap != null && Math.abs(gap) >= 5 ? 'ambar' : 'verde', ic: 'pessoas', v: gap != null ? 1 : 0,
        valor: gap == null ? '—' : Math.abs(gap).toLocaleString('pt-BR', { maximumFractionDigits: 1 }) + '%',
        diz: gap == null ? 'Mulheres x homens' : gap > 0 ? 'Mulheres ganham menos' : gap < 0 ? 'Mulheres ganham mais' : 'Mulheres e homens iguais',
        dica: 'média geral; no mesmo cargo, veja o quadro abaixo (Lei 14.611)' },
      { k: 'semreajuste', cor: 'ambar', ic: 'relogio', valor: num(r.sem_reaj12), unid: r.sem_reaj12 === 1 ? 'pessoa' : 'pessoas', v: r.sem_reaj12, lista: true, alerta: true,
        diz: 'Sem reajuste há 12+ meses', dica: num(r.sem_reaj24) + ' há mais de 2 anos' },
      { k: 'adicionais', cor: 'rosa', ic: 'duvida', valor: num((r.insal || 0) + (r.peric || 0)), unid: 'pessoas', v: (r.insal || 0) + (r.peric || 0), lista: true,
        diz: 'Insalubridade ou periculosidade', dica: num(r.insal) + ' insalubridade · ' + num(r.peric) + ' periculosidade' }
    ]);
    var frase = '<p class="nc-af-frase">A folha de salários deste filtro é de <b>' + reais(r.massa) + '</b> por mês, com salário médio de <b>' + reais(r.massa / Math.max(1, r.n)) + '</b>' +
      ' <span class="nc-qd-cinza">(' + plural(r.n, 'pessoa', 'pessoas') + ' com salário que você pode ver)</span>.</p>';
    return regua + frase + '<div class="nc-af-quadros nc-af-quadros--3">' +
      quadro('Dispersão salarial por cargo', 'Do menor ao maior salário em cada cargo · a caixa é onde está a maioria; o ponto, o salário do meio', dispersao(d.cargos || []), 'nc-af-q--largo') +
      quadro('Mulheres x homens no mesmo cargo', 'Cargos com 2 ou mais de cada · a maior diferença primeiro', genero(d.genero || [])) +
      quadro('Folha por centro de custo', 'Soma dos salários · toque para ver na tabela', (d.massacc || []).length ? barrasValor(d.massacc, r.massa) : '<p class="nc-af-vazio-q">Sem informação.</p>') +
      quadro('Por que foi o último reajuste', 'Reajustes dos últimos 12 meses, pelo motivo', (d.reajustes || []).length ? fixas(d.reajustes, d.reajustes.reduce(function (s, x) { return s + x.q; }, 0), 'pessoa', 'pessoas') : '<p class="nc-af-vazio-q">Nenhum reajuste nos últimos 12 meses.</p>') +
      quadro('Adicionais por grau', 'Quantas pessoas recebem cada adicional', (d.adicionaisgrau || []).length ? fixas(d.adicionaisgrau, (r.insal || 0) + (r.peric || 0), 'pessoa', 'pessoas') : '<p class="nc-af-vazio-q">Ninguém com insalubridade ou periculosidade.</p>') +
      '</div>';
  }
  /* DISPERSÃO: uma régua comum a todos os cargos (do menor ao maior salário mostrado), com a linha do
     menor ao maior, a caixa do 1º ao 3º quartil (onde está a metade do meio) e o ponto da mediana */
  function dispersao(cs) {
    if (!cs.length) return '<p class="nc-af-vazio-q">Nenhum cargo com 3 pessoas ou mais com salário visível.</p>';
    var lo = Math.min.apply(null, cs.map(function (c) { return c.min; })), hi = Math.max.apply(null, cs.map(function (c) { return c.max; })), w = hi - lo || 1;
    var pos = function (v) { return ((v - lo) / w * 100).toFixed(2); };
    return rolo('ol', 'nc-qd-disp', cs.map(function (c) {
      var amp = Math.round((c.max / Math.max(1, c.min) - 1) * 100), nivel = amp >= 100 ? 'atrasada' : amp >= 50 ? 'sem' : 'logo', p = partes(c.t);
      return '<li><div class="nc-qd-disp-l" title="' + esc(c.t) + '">' +
        '<p class="nc-qd-disp-cab"><span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-volta nc-af-volta--' + nivel + '">' + (amp ? 'o maior ganha ' + amp + '% a mais' : 'todos iguais') + '</span></p>' +
        '<span class="nc-qd-faixa" aria-hidden="true"><i class="nc-qd-f-linha" style="left:' + pos(c.min) + '%;width:' + (pos(c.max) - pos(c.min)).toFixed(2) + '%"></i>' +
        '<i class="nc-qd-f-caixa" style="left:' + pos(c.q1) + '%;width:' + Math.max(0.6, pos(c.q3) - pos(c.q1)).toFixed(2) + '%"></i><i class="nc-qd-f-med" style="left:' + pos(c.med) + '%"></i></span>' +
        '<p class="nc-qd-disp-txt">' + plural(c.n, 'pessoa', 'pessoas') + ' · de <b>' + reais(c.min) + '</b> a <b>' + reais(c.max) + '</b> · a maioria entre ' + reais(c.q1) + ' e ' + reais(c.q3) + ' · metade ganha até ' + reais(c.med) + '</p></div></li>';
    }), 6, 'linhas');
  }
  function genero(gs) {
    if (!gs.length) return '<p class="nc-af-vazio-q">Nenhum cargo com 2 ou mais mulheres e 2 ou mais homens com salário visível.</p>';
    return rolo('ol', 'nc-af-barras', gs.map(function (g) {
      var mx = Math.max(g.f, g.m) || 1, p = partes(g.t), menos = g.gap > 0;
      return '<li><div class="nc-af-b nc-af-b--fixa nc-qd-gen" title="' + esc(g.t) + '"><span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-qd-gen-frase nc-af-volta nc-af-volta--' + (Math.abs(g.gap) >= 5 ? 'sem' : 'logo') + '">' + (Math.abs(g.gap) < 0.5 ? 'Salários iguais' : 'Mulheres ganham ' + Math.abs(g.gap).toLocaleString('pt-BR', { maximumFractionDigits: 1 }) + '% ' + (menos ? 'menos' : 'mais')) + '</span>' +
        '<span class="nc-qd-gen-l"><small>Mulheres (' + g.fn + ')</small><span class="nc-af-b-trilho"><i class="nc-qd-gen-f" style="width:' + Math.round(g.f / mx * 100) + '%"></i></span><b>' + reais(g.f) + '</b></span>' +
        '<span class="nc-qd-gen-l"><small>Homens (' + g.mn + ')</small><span class="nc-af-b-trilho"><i style="width:' + Math.round(g.m / mx * 100) + '%"></i></span><b>' + reais(g.m) + '</b></span></div></li>';
    }), 6, 'linhas');
  }
  /* barras de VALOR (folha por centro de custo): reais, % da folha, pessoas; toque = ver na tabela */
  function barrasValor(xs, total) {
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = total ? Math.round(x.q / total * 100) : null;
      return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-af-tabela="' + esc(x.k || x.t) + '" title="Ver ' + esc(x.t) + ' na tabela">' +
        '<span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + reais(x.q) + ' <small>· ' + (pct < 1 ? '&lt;1' : pct) + '% · ' + plural(x.n, 'pessoa', 'pessoas') + '</small></span>' +
        '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
    }), POR_VEZ_Q, 'linhas');
  }

  /* ── ABA 3: contratos e jornada ── */
  function abaContratos(d) {
    var c = d.contr || {}, a = d.agora || {};
    var regua = subRegua([
      { k: 'aviso', cor: 'ambar', ic: 'relogio', valor: num(c.aviso), unid: c.aviso === 1 ? 'pessoa' : 'pessoas', v: c.aviso, lista: true, alerta: true,
        diz: 'Em aviso prévio', dica: 'aviso dado nos últimos 90 dias: prepare a rescisão' },
      { k: 'pontonao', cor: 'vermelho', ic: 'alarme', valor: num(c.ponto_outros), unid: c.ponto_outros === 1 ? 'pessoa' : 'pessoas', v: c.ponto_outros, lista: true, alerta: true,
        diz: 'Não marcam ponto', dica: 'fora de liderança (risco de hora extra) · ' + num(c.ponto_lider) + ' de liderança, permitido (CLT art. 62)' },
      { k: 'apos', cor: 'roxo', ic: 'pessoas', valor: num(c.aposentados), unid: 'pessoas', v: c.aposentados,
        diz: 'Aposentados trabalhando', dica: num(c.mais60) + ' pessoas com 60 anos ou mais' },
      { k: 'interm', cor: 'roxo', ic: 'duvida', valor: num(c.intermitentes), unid: 'pessoas', v: c.intermitentes,
        diz: 'Trabalho intermitente', dica: num(c.estrangeiros) + ' ' + (c.estrangeiros === 1 ? 'estrangeiro' : 'estrangeiros') + ' no quadro' }
    ]);
    /* poucos mas não nenhum: "<1%", nunca "0%" (3 sindicalizados em 750 não são zero) */
    var pct = function (v) { var x = a.ativos ? (v || 0) / a.ativos * 100 : 0; return v && x < 1 ? '&lt;1' : Math.round(x); };
    var frase = '<p class="nc-af-frase"><b>' + pct(c.sindicalizados) + '%</b> das pessoas são sindicalizadas e <b>' + pct(c.adiantamento) + '%</b> recebem adiantamento salarial.</p>';
    return regua + frase + '<div class="nc-af-quadros">' +
      quadro('Mão de obra', 'Direta (produz) e indireta (apoio)', fixas(d.maoobra, a.ativos, 'pessoa', 'pessoas')) +
      quadro('Onde trabalham', 'Presencial, home office ou misto', fixas(d.modalidade, a.ativos, 'pessoa', 'pessoas')) +
      quadro('Jornada', 'Horas de trabalho por mês', fixas(d.jornada, a.ativos, 'pessoa', 'pessoas')) +
      quadro('Tipo de cargo', 'Operacional, administrativo, liderança…', fixas(d.classes, a.ativos, 'pessoa', 'pessoas')) +
      '</div>';
  }
  function quadro(tit, dica, corpo, cls) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3><p>' + dica + '</p>' + corpo + '</section>'; }
  /* cada linha é um BOTÃO "ver na tabela" (busca pelo código k, quando há) */
  function barras(xs, o) {
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var p = partes(x.t), pct = o.total ? Math.round(x.q / o.total * 100) : null;
      return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '" data-af-tabela="' + esc(x.k || x.t) + '" title="Ver ' + esc(x.t) + ' na tabela">' +
        '<span class="nc-af-b-nome">' + (p[0] ? '<em>' + esc(p[0]) + '</em>' : '') + esc(p[1]) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + num(x.q) + ' <small>' + (x.q === 1 ? o.um : o.varios) + (pct != null ? ' · ' + (pct < 1 ? '&lt;1' : pct) + '%' : '') + '</small></span>' +
        '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
    }), POR_VEZ_Q, 'linhas');
  }
  /* barras SÓ DE LEITURA (faixas e motivos): número, % do total; a maior em rosa */
  function fixas(xs, total, um, varios) {
    xs = xs || [];
    if (!xs.length) return '<p class="nc-af-vazio-q">Sem informação.</p>';
    var max = Math.max.apply(null, xs.map(function (x) { return x.q; })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x) {
      var pct = total ? Math.round(x.q / total * 100) : 0;
      return '<li><div class="nc-af-b nc-af-b--fixa' + (x.q === max ? ' is-maior' : '') + '" title="' + esc(x.t) + '"><span class="nc-af-b-nome">' + esc(x.t) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(x.q / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + (pct < 1 ? '&lt;1' : pct) + '% <small>· ' + plural(x.q, um, varios) + '</small></span></div></li>';
    }), 8, 'linhas');
  }
  /* ENTRADAS E SAÍDAS: duas colunas por mês (entraram em roxo, saíram em rosa), a dica com os dois */
  function entradasSaidas(ms) {
    if (!ms.length || !ms.some(function (m) { return m.e || m.s; })) return '<p class="nc-af-vazio-q">Ninguém entrou nem saiu nos últimos 12 meses.</p>';
    var max = Math.max.apply(null, ms.map(function (m) { return Math.max(m.e, m.s); })) || 1;
    return '<p class="nc-af-legenda"><span class="nc-af-leg nc-af-leg--e"></span>Entraram <span class="nc-af-leg nc-af-leg--s"></span>Saíram</p>' +
      '<ol class="nc-af-meses nc-af-meses--par">' + ms.map(function (m, i) {
        var dt = new Date(+m.m.slice(0, 4), +m.m.slice(5, 7) - 1, 1), rot = MESES[dt.getMonth()] + '/' + dt.getFullYear() + ': ' + plural(m.e, 'entrou', 'entraram') + ' · ' + plural(m.s, 'saiu', 'saíram');
        var ano = dt.getMonth() === 0 || i === 0 ? '<em>' + dt.getFullYear() + '</em>' : '';
        return '<li class="nc-af-mes' + (i === 0 || dt.getMonth() % 3 === 0 ? ' is-marco' : '') + '" tabindex="0" aria-label="' + rot + '" data-dica="' + rot + '">' +
          '<b></b><span class="nc-af-par"><i class="nc-af-par-e" style="height:' + (m.e ? Math.max(4, Math.round(m.e / max * 100)) : 0) + '%"></i><i class="nc-af-par-s" style="height:' + (m.s ? Math.max(4, Math.round(m.s / max * 100)) : 0) + '%"></i></span>' +
          '<span>' + MESES[dt.getMonth()] + ano + '</span></li>';
      }).join('') + '</ol>';
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
  function iniciar() { if (window.__ncQuadroIniciou) return; if (montar()) { window.__ncQuadroIniciou = true; buscar(); } }
  window.__ncQuadroDesenhar = function (d) { if (montar()) desenhar(d); };   /* para conferir o desenho com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
