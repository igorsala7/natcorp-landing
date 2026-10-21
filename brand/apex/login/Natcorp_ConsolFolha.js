/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSOLIDAÇÃO DO HISTÓRICO FINANCEIRO  —  escolher o "por" e o resumo da folha  ║
   ║  App 9181 · Páginas 50 (Consolidação), 55 (Comparativos) e 58 (Tabular, 18 meses)         ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1).
   Guia desta página: CONSOLFOLHA-MANUTENCAO.md. A roupa do resumo é a MESMA dos outros painéis
   (Natcorp_ConsolFolha.css = cópia do Natcorp_Afastamentos.css; as peças só daqui são .nc-cf-*).

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   [C] COMO VER A FOLHA  O campo "Histórico Por" (18 opções numa lista de texto corrido) vira um
       botão "Ver a folha por: Empresa › Filial › Centro de custo" que abre as opções em 3 assuntos
       (Estrutura da empresa · Cargos · Custos), cada uma dizendo em palavras o que mostra. Escolher
       PREENCHE O CAMPO ORIGINAL (setValue + change): as ações da página mostram/escondem os filtros
       como sempre. O campo original continua lá, escondido.
   [R] RESUMO DA FOLHA   Acima da tabela que está na tela (IR_1…IR_18), para conferir a folha:
         NÚMEROS    Ganhos · Descontos · Líquido · Pessoas na folha · Para conferir (verbas e locais
                    que mudaram muito do mês anterior para o último, valores negativos) — sempre.
         ANÁLISE    a frase do último mês × o anterior, mês a mês, por origem (Folha, 13º, Rescisão…),
                    para onde vai o dinheiro, descontos, encargos e informativas, onde está o custo
                    (por filial, centro de custo, cargo… — os níveis do "por" escolhido) e as verbas
                    que mais pesam. Com 2 meses ou mais, cada quadro é uma tabela com uma coluna por mês.
         VER NA TABELA  tocar numa linha põe o FILTRO da tabela: "=" com um valor, "em" com vários.
       Os números vêm do processo NC_CONSOL_RESUMO, que soma EM CIMA da consulta da própria tabela.
       Antes de pesquisar, no lugar da tabela: o que fazer, em 3 passos.

   [T] PÁGINA 58 ("Comparativos … - Tabular"): os 18 fechamentos mais recentes, sem escolher mês — a
       tela da Consolidação (vários meses), com os números do processo NC_TAB_RESUMO. Guia:
       TABFOLHA-MANUTENCAO.md.
   [M] MODO COMPARAÇÃO (página 55, "Comparativos de Históricos Financeiros")  A MESMA tela, reconhecida
       pelo campo P55_HISTOCORR: dois meses (Período 1 → Período 2) na ordem que a pessoa escolheu;
       números do Período 2 com o Período 1 ao lado; tabelas com Período 1 · Período 2 · Diferença ·
       Variação; atalhos de período ("último × anterior", "mesmo mês do ano passado", "inverter") e o
       aviso de período invertido. Os números vêm do processo NC_COMP_RESUMO (o fechamento de cada mês,
       com a consulta da Consolidação). Guia: COMPFOLHA-MANUTENCAO.md.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda o Pesquisar nem os campos da página. Não grava nada no banco. Os filtros que ele
       põe na tabela são os mesmos do Ações › Filtro (a pessoa tira no × do filtro).

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 50 › JavaScript › File URLs:   #WORKSPACE_IMAGES#Natcorp_ConsolFolha.js
     Página 50 › CSS › File URLs:          #WORKSPACE_IMAGES#Natcorp_ConsolFolha.css
     Página 50 › Processing › Ajax Callback NC_CONSOL_RESUMO  (NC_CONSOL_RESUMO.plsql.sql)
   Tudo já vem na exportação f9181_page_50.sql (aplicar-consolfolha-pagina50.py).

   ── ÍNDICE ────────────────────────────────────────────────────────────────────────────────
     [C1] As 18 formas de ver, em assuntos ....................................... PODE MEXER
     [C2] O botão e a lista de escolher
     [R1] Textos e regras do resumo (o que é ganho, desconto, "mudou muito") ..... PODE MEXER
     [R2] Os dados · [R3] A moldura · [R4] Os números · [R5] A análise · [R6] Ver na tabela
     [R7] O começo
   ════════════════════════════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';
  if (window.__ncConsol) return;
  window.__ncConsol = true;

  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html != null) e.innerHTML = html; return e; }
  function esc(t) { return String(t == null ? '' : t).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function num(n) { return Number(n || 0).toLocaleString('pt-BR'); }
  function plural(n, um, varios) { return num(n) + ' ' + (Number(n) === 1 ? um : varios); }
  function semAcento(t) { return String(t || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase(); }
  function partes(t) { var m = /^(\S+)\s+-\s*(.*)$/.exec(t || ''); return m ? [m[1], m[2]] : ['', t || '']; }
  function comparar(a, b) { return String(a).localeCompare(String(b), 'pt-BR', { numeric: true, sensitivity: 'base' }); }
  /* dinheiro: inteiro nos números grandes, com centavos quando é pequeno */
  /* dinheiro: a máscara do sistema, R$1.234,90 — sempre com centavos; negativo = -R$1.234,90 */
  function rs(v) {
    var n = Number(v || 0);
    return (n < 0 ? '-' : '') + 'R$' + Math.abs(n).toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }
  /* o mesmo número sem o R$ (para colar no Excel) */
  function n2(v) { return Number(v || 0).toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 }); }
  function pctTxt(a, b) {
    if (!b) return '';
    var p = (a - b) / Math.abs(b) * 100;
    return (p > 0 ? '+' : '') + p.toLocaleString('pt-BR', { maximumFractionDigits: Math.abs(p) < 10 ? 1 : 0 }) + '%';
  }

  var IC = {
    tabela: '<path d="M5 12h14M13 6l6 6-6 6"/>',
    busca: '<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4.5 4.5"/>',
    descer: '<path d="M12 5v14M6 13l6 6 6-6"/>',
    subir: '<path d="M12 19V5M6 11l6-6 6 6"/>',
    copiar: '<rect x="8.5" y="8.5" width="11" height="11" rx="2"/><path d="M15.5 8.5V6a1.5 1.5 0 0 0-1.5-1.5H6A1.5 1.5 0 0 0 4.5 6v8A1.5 1.5 0 0 0 6 15.5h2.5"/>',
    filtro: '<path d="M4 5h16l-6 7.5V19l-4-2v-4.5z"/>',
    atualiza: '<path d="M20 11a8 8 0 0 0-14.6-4.5L4 8"/><path d="M4 4v4h4"/><path d="M4 13a8 8 0 0 0 14.6 4.5L20 16"/><path d="M20 20v-4h-4"/>',
    entra: '<path d="M12 4v16M6 14l6 6 6-6"/>',
    sai: '<path d="M12 20V4M6 10l6-6 6 6"/>',
    carteira: '<path d="M4 7.5h14.5a1.5 1.5 0 0 1 1.5 1.5v9a1.5 1.5 0 0 1-1.5 1.5H5.5A1.5 1.5 0 0 1 4 18V7.5z"/><path d="M4 7.5 15.5 4v3.5M16 13.5h.01"/>',
    pessoas: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19c.6-3.2 2.8-5 5.5-5s4.9 1.8 5.5 5"/><circle cx="17" cy="9" r="2.4"/><path d="M15.5 14.2c2.4.1 4.3 1.6 5 4.8"/>',
    lupa: '<circle cx="10.5" cy="10.5" r="6"/><path d="M15 15l5 5M8 10.5h5"/>',
    fechar: '<path d="M6 15l6-6 6 6"/>',
    abrir: '<path d="M6 9l6 6 6-6"/>',
    aviso: '<path d="M12 4 2.8 19.5h18.4z"/><path d="M12 10v4.5M12 17.2h.01"/>',
    predio: '<path d="M4 20V6l8-3 8 3v14M4 20h16M9 9h.01M15 9h.01M9 13h.01M15 13h.01M10 20v-3h4v3"/>',
    cracha: '<rect x="5" y="4" width="14" height="17" rx="2.5"/><circle cx="12" cy="11" r="2.6"/><path d="M8.5 17.5c.6-1.8 1.9-2.8 3.5-2.8s2.9 1 3.5 2.8M10 4V2.5h4V4"/>',
    moedas: '<ellipse cx="9" cy="7" rx="5" ry="2.5"/><path d="M4 7v4c0 1.4 2.2 2.5 5 2.5s5-1.1 5-2.5V7"/><path d="M10 15.4c.7.4 1.8.6 3 .6 2.8 0 5-1.1 5-2.5v-4c0-1.2-1.6-2.2-3.8-2.4"/>',
    marca: '<path d="M5 12.5l4.2 4.2L19 7"/>',
    passo1: '<path d="M4 6h16M7 12h10M10 18h4"/>',
    calend: '<rect x="4" y="5" width="16" height="15" rx="2.5"/><path d="M4 9.5h16M8.5 3v4M15.5 3v4"/>'
  };
  function ic(n) { return '<svg class="nc-af-ic" viewBox="0 0 24 24" aria-hidden="true" focusable="false">' + (IC[n] || '') + '</svg>'; }

  /* ═══ [C1] AS 18 FORMAS DE VER, EM ASSUNTOS ═════════════════════════════════════════════
     v = o valor do campo P50_OCORRENCIA (NÃO MUDAR: as ações da página e as regiões dependem dele);
     orig = o texto da lista original (é o que o campo mostra); c = o caminho; d = o que a pessoa vê.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var FORMAS = [
    { g: 'Estrutura da empresa', ic: 'predio', itens: [
      { v: 'E',     orig: 'Empresa',                                c: ['Empresa'],                                   d: 'O total da empresa, verba a verba' },
      { v: 'EF',    orig: 'Empresa, Filial',                        c: ['Empresa', 'Filial'],                         d: 'Cada filial separada' },
      { v: 'EFCC',  orig: 'Empresa, Filial, CCusto',                c: ['Empresa', 'Filial', 'Centro de custo'],      d: 'Cada setor de cada filial' },
      { v: 'ECC',   orig: 'Empresa, Centro de Custo ',              c: ['Empresa', 'Centro de custo'],                d: 'Cada setor, juntando as filiais' },
      { v: 'EFUA',  orig: 'Empresa, Filial, Unid. Adm.',            c: ['Empresa', 'Filial', 'Unidade adm.'],         d: 'Cada unidade administrativa (cliente) de cada filial' },
      { v: 'EFUCC', orig: 'Empresa, Filial, Unidade adm, CCusto ',  c: ['Empresa', 'Filial', 'Unidade adm.', 'Centro de custo'], d: 'O setor dentro da unidade administrativa' },
      { v: 'ED',    orig: 'Empresa, Divisão',                       c: ['Empresa', 'Divisão'],                        d: 'Cada divisão' },
      { v: 'ER',    orig: 'Empresa, Regional ',                     c: ['Empresa', 'Regional'],                       d: 'Cada regional' },
      { v: 'EU',    orig: 'Empresa, Unidade de Negócio',            c: ['Empresa', 'Unidade de negócio'],             d: 'Cada unidade de negócio' },
      { v: 'EL',    orig: 'Empresa, Local',                         c: ['Empresa', 'Local de trabalho'],              d: 'Cada local de trabalho' }
    ] },
    { g: 'Cargos', ic: 'cracha', itens: [
      { v: 'ECAR',    orig: 'Empresa, Cargo ',                       c: ['Empresa', 'Cargo'],                          d: 'Cada cargo, juntando as filiais' },
      { v: 'EFCAR',   orig: 'Empresa, Filial, Cargo ',               c: ['Empresa', 'Filial', 'Cargo'],                d: 'Cada cargo dentro de cada filial' },
      { v: 'EFCCCAR', orig: 'Empresa, Filial, Ccusto, Cargo ',       c: ['Empresa', 'Filial', 'Centro de custo', 'Cargo'], d: 'O mais detalhado: cargo, setor e filial' },
      { v: 'ECATCAR', orig: 'Empresa, Categoria de Cargo',           c: ['Empresa', 'Categoria de cargo'],             d: 'Por categoria (liderança, operacional…)' },
      { v: 'EFCCAR',  orig: 'Empresa, Filial, Class Cargo ',         c: ['Empresa', 'Filial', 'Classificação do cargo'], d: 'A classificação do cargo em cada filial' }
    ] },
    { g: 'Custos', ic: 'moedas', itens: [
      { v: 'ECATCCUS', orig: 'Empresa, Categoria de Ccusto ',        c: ['Empresa', 'Categoria de c. custo'],          d: 'Por categoria de centro de custo (administrativo, operação…)' },
      { v: 'EFCCCUS',  orig: 'Empresa, Filial, Class Custo',         c: ['Empresa', 'Filial', 'Classificação do custo'], d: 'A classificação do custo em cada filial' },
      { v: 'EFCMO',    orig: 'Empresa, Filial, Obra, Ccusto',        c: ['Empresa', 'Filial', 'Obra / centro de custo'], d: 'Mão de obra direta e indireta, por obra' }
    ] }
  ];
  var FORMA = {}; FORMAS.forEach(function (g) { g.itens.forEach(function (x) { x.grupo = g.g; FORMA[x.v] = x; }); });
  function caminho(x) { return x.c.map(esc).join('<i aria-hidden="true">›</i>'); }

  /* ═══ [M1] QUAL PÁGINA ═══════════════════════════════════════════════════════════════════
     Reconhecida pelo CAMPO que existe nela (não pelo número): P50_OCORRENCIA = Consolidação (N meses);
     P55_HISTOCORR = Comparativos (Período 1 × Período 2).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MODO = 'consol', COMP = false, CAMPO = 'P50_OCORRENCIA';
  var PAGINAS = {
    consol: { campo: 'P50_OCORRENCIA', processo: 'NC_CONSOL_RESUMO', guia: 'CONSOLFOLHA', datas: ['P50_DATA_REF'] },
    comp:   { campo: 'P55_HISTOCORR',  processo: 'NC_COMP_RESUMO',   guia: 'COMPFOLHA',   datas: ['P55_DATA_REF1', 'P55_DATA_REF2'] },
    tab:    { campo: 'P58_HISTOCORR',  processo: 'NC_TAB_RESUMO',    guia: 'TABFOLHA',    datas: [] }   /* 58: os últimos 18 fechamentos, sem escolher mês */
  };
  function configurar() {
    MODO = document.getElementById('P50_OCORRENCIA') ? 'consol' : document.getElementById('P55_HISTOCORR') ? 'comp' : document.getElementById('P58_HISTOCORR') ? 'tab' : 'consol';
    var c = PAGINAS[MODO];
    COMP = MODO === 'comp';
    CAMPO = c.campo;
    PROCESSO = c.processo;
    var pre = CAMPO.slice(0, 4);
    ITENS = [CAMPO].concat(['EMPRESA', 'FILIAL', 'CCUSTO', 'UNIDADM', 'DIVISAO', 'REGIONAL', 'CARGO', 'CLASSCTO', 'CLASSCGO', 'MAOBRA', 'LOCAL', 'UNIDNEG']
      .map(function (n) { return pre + n; }), c.datas);
  }
  /* "Período 1 · out/2024" na comparação; "out/2025" na consolidação */
  function perTxt(m, curto) {
    if (!COMP || !P || !P.A) return mesTxt(m);
    var n = P.A.meses.indexOf(m) + 1;
    return (curto ? '' : 'Período ' + n + ' · ') + mesTxt(m);
  }

  /* ═══ [C2] O BOTÃO E A LISTA DE ESCOLHER ════════════════════════════════════════════════ */
  var C = null;
  function montarEscolha() {
    if (C) return;
    var orig = document.getElementById(CAMPO + '_CONTAINER') || (document.getElementById(CAMPO) || {}).closest && document.getElementById(CAMPO).closest('.t-Form-fieldContainer');
    if (!orig || !window.apex || !apex.item) return;
    var caixa = el('div', 'nc-cf-por');
    caixa.innerHTML = '<span class="nc-cf-por-rot" id="nc-cf-por-rot">Ver a folha por</span>' +
      '<button type="button" class="nc-cf-por-bt" aria-haspopup="dialog" aria-expanded="false" aria-controls="nc-cf-formas" aria-labelledby="nc-cf-por-rot nc-cf-por-val">' +
      '<span class="nc-cf-por-val" id="nc-cf-por-val"></span><span class="nc-cf-por-troca">Trocar</span></button>' +
      '<div class="nc-cf-formas" id="nc-cf-formas" role="dialog" aria-label="Como você quer ver a folha?" hidden></div>';
    orig.parentNode.insertBefore(caixa, orig);
    orig.classList.add('nc-cf-orig');
    C = { caixa: caixa, bt: caixa.querySelector('.nc-cf-por-bt'), val: caixa.querySelector('.nc-cf-por-val'), lista: caixa.querySelector('.nc-cf-formas') };
    C.bt.addEventListener('click', function () { if (C.lista.hidden) abrirFormas(); else fecharFormas(true); });
    C.lista.addEventListener('click', function (e) {
      var b = e.target.closest('[data-cf-forma]'); if (!b) return;
      escolher(b.getAttribute('data-cf-forma'));
    });
    document.addEventListener('mousedown', function (e) { if (!C.lista.hidden && !C.caixa.contains(e.target)) fecharFormas(false); }, true);
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && !C.lista.hidden) { e.preventDefault(); fecharFormas(true); } });
    mostrarEscolhida();
    apex.jQuery('#' + CAMPO).on('change', mostrarEscolhida);
  }
  function atual() { try { return apex.item(CAMPO).getValue(); } catch (e) { return ''; } }
  function mostrarEscolhida() {
    var x = FORMA[atual()];
    C.val.innerHTML = x ? '<b>' + caminho(x) + '</b>' : '<b class="nc-cf-vazio">Escolha como ver</b>';
    C.caixa.classList.toggle('is-vazio', !x);
  }
  function abrirFormas() {
    var v = atual();
    C.lista.innerHTML = '<p class="nc-cf-formas-tit">Como você quer ver a folha?</p>' + FORMAS.map(function (g) {
      return '<section class="nc-cf-grupo"><h3>' + ic(g.ic) + g.g + '</h3><ul>' + g.itens.map(function (x) {
        return '<li><button type="button" class="nc-cf-forma' + (x.v === v ? ' is-atual' : '') + '" data-cf-forma="' + x.v + '" aria-pressed="' + (x.v === v) + '">' +
          '<span class="nc-cf-caminho">' + caminho(x) + '</span><span class="nc-cf-d">' + esc(x.d) + '</span>' + (x.v === v ? ic('marca') : '') + '</button></li>';
      }).join('') + '</ul></section>';
    }).join('');
    C.lista.hidden = false;
    C.bt.setAttribute('aria-expanded', 'true');
    posicionarFormas();
    var f = C.lista.querySelector('.is-atual') || C.lista.querySelector('[data-cf-forma]');
    if (f) f.focus({ preventScroll: true });
  }
  /* a lista é larga (as 18 formas com a explicação): flutua presa ao botão, por cima da página, sem
     ser cortada pela coluna de filtros (que rola por dentro) */
  function posicionarFormas() {
    if (C.lista.hidden) return;
    var r = C.bt.getBoundingClientRect(), vw = document.documentElement.clientWidth, vh = window.innerHeight;
    var larg = Math.min(600, vw - 24), esq = Math.max(12, Math.min(r.left, vw - larg - 12));
    var cima = r.bottom + 6, cabe = vh - cima - 12;
    if (cabe < 320 && r.top > cabe) { C.lista.style.top = ''; C.lista.style.bottom = (vh - r.top + 6) + 'px'; C.lista.style.maxHeight = (r.top - 18) + 'px'; }
    else { C.lista.style.bottom = ''; C.lista.style.top = cima + 'px'; C.lista.style.maxHeight = cabe + 'px'; }
    C.lista.style.left = esq + 'px';
    C.lista.style.width = larg + 'px';
  }
  window.addEventListener('resize', function () { if (C) posicionarFormas(); });
  function fecharFormas(devolve) {
    C.lista.hidden = true; C.lista.innerHTML = '';
    C.bt.setAttribute('aria-expanded', 'false');
    if (devolve) C.bt.focus({ preventScroll: true });
  }
  function escolher(v) {
    var x = FORMA[v]; if (!x) return;
    var mudou = v !== atual();
    /* o campo ORIGINAL recebe o valor: o change dispara as ações da página (mostrar/esconder filtros) */
    apex.item(CAMPO).setValue(v, x.orig);
    fecharFormas(true);
    mostrarEscolhida();
    if (mudou) avisarPesquisar();
  }
  /* trocou o "por": a tabela só muda depois do Pesquisar — o botão pede atenção */
  function avisarPesquisar(texto, onde) {
    var b = document.querySelector('#PARAMETROS button[id*="Pesquisar" i], #PARAMETROS .t-Button--hot');
    if (b) b.classList.add('nc-cf-pede');
    var cx = onde || (C && C.caixa); if (!cx) return;     /* o recado fica junto de quem mudou (o "por" ou os períodos) */
    var n = cx.querySelector('.nc-cf-nota');
    if (!n) { n = el('p', 'nc-cf-nota'); n.setAttribute('role', 'status'); cx.appendChild(n); }
    n.textContent = texto || 'Agora toque em Pesquisar para ver a folha deste jeito.';
  }

  /* ═══ [M2] OS DOIS PERÍODOS (comparação) ════════════════════════════════════════════════
     Embaixo dos campos "Período 1" e "Período 2" (os originais, que vão no Pesquisar): o que cada um
     é, atalhos de um toque e o aviso quando o Período 1 vem DEPOIS do Período 2 (aí tudo o que subiu
     aparece como queda). Os atalhos usam os meses que existem (NC_COMP_RESUMO, x01 = MESES).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PER = null;
  function dataDe(v) { var m = /^(\d{2})\/(\d{2})\/(\d{2,4})/.exec(v || ''); return m ? (m[3].length === 2 ? '20' + m[3] : m[3]) + m[2] + m[1] : ''; }
  function per(n) { var id = 'P55_DATA_REF' + n, e = document.getElementById(id); return { id: id, v: (function () { try { return apex.item(id).getValue(); } catch (x) { return ''; } })(), d: e ? e.value : '' }; }
  function montarPeriodos() {
    if (!COMP || PER) return;
    var c1 = document.getElementById('P55_DATA_REF1_CONTAINER'), c2 = document.getElementById('P55_DATA_REF2_CONTAINER');
    if (!c1 || !c2) return;
    [[c1, 'o mês de antes: a base da comparação'], [c2, 'o mês que você quer conferir']].forEach(function (p) {
      var h = el('p', 'nc-cf-dica-campo', p[1]); p[0].parentNode.insertBefore(h, p[0].nextSibling);   /* embaixo do campo, fora da grade rótulo|campo */
    });
    var box = el('div', 'nc-cf-per');
    box.innerHTML = '<span class="nc-cf-per-rot">Atalhos</span><div class="nc-cf-per-l"></div><p class="nc-cf-per-av" role="status" hidden></p>';
    var dica2 = c2.nextSibling; c2.parentNode.insertBefore(box, dica2 ? dica2.nextSibling : null);
    PER = { box: box, l: box.querySelector('.nc-cf-per-l'), av: box.querySelector('.nc-cf-per-av'), meses: [] };
    box.addEventListener('click', function (e) {
      var b = e.target.closest('button'); if (!b) return;
      if (b.hasAttribute('data-cf-inverte')) return inverterPeriodos();
      var a = b.getAttribute('data-cf-p1'), z = b.getAttribute('data-cf-p2');
      if (a && z) { porPeriodo(1, a); porPeriodo(2, z); conferirPeriodos(); avisarPesquisar(TOQUE_MESES, PER.box); }
    });
    apex.jQuery('#P55_DATA_REF1, #P55_DATA_REF2').on('change', conferirPeriodos);
    desenharAtalhos();
    conferirPeriodos();
    apex.server.process(PROCESSO, { x01: 'MESES' }, { dataType: 'json', error: function () { /* sem atalhos de mês */ } })
      .done(function (d) { PER.meses = (d && d.meses) || []; desenharAtalhos(); });
  }
  function porPeriodo(n, v) {
    var m = PER.meses.filter(function (x) { return x.v === v; })[0];
    apex.item('P55_DATA_REF' + n).setValue(v, m ? m.d : v);
  }
  function desenharAtalhos() {
    var ms = PER.meses, h = '';
    if (ms.length > 1) {
      var u = ms[0], a = ms[1], ano = ms.filter(function (x) { return dataDe(x.v) === String(+dataDe(u.v).slice(0, 4) - 1) + dataDe(u.v).slice(4); })[0];
      h += '<button type="button" class="nc-cf-per-bt" data-cf-p1="' + esc(a.v) + '" data-cf-p2="' + esc(u.v) + '"><b>Último mês × anterior</b><span>' + mesTxt(dataDe(a.v).slice(0, 6)) + ' → ' + mesTxt(dataDe(u.v).slice(0, 6)) + '</span></button>';
      if (ano) h += '<button type="button" class="nc-cf-per-bt" data-cf-p1="' + esc(ano.v) + '" data-cf-p2="' + esc(u.v) + '"><b>Mesmo mês do ano passado</b><span>' + mesTxt(dataDe(ano.v).slice(0, 6)) + ' → ' + mesTxt(dataDe(u.v).slice(0, 6)) + '</span></button>';
    }
    h += '<button type="button" class="nc-cf-per-bt nc-cf-per-bt--inv" data-cf-inverte><b>' + ic('atualiza') + 'Inverter</b><span>troca o Período 1 com o 2</span></button>';
    PER.l.innerHTML = h;
  }
  function inverterPeriodos() {
    var a = per(1), b = per(2);
    apex.item(a.id).setValue(b.v, b.d);
    apex.item(b.id).setValue(a.v, a.d);
    conferirPeriodos();
    avisarPesquisar(TOQUE_MESES, PER.box);
  }
  var TOQUE_MESES = 'Agora toque em Pesquisar para comparar estes dois meses.';
  function conferirPeriodos() {
    if (!PER) return;
    var a = dataDe(per(1).v), b = dataDe(per(2).v), t = '';
    if (a && b && a === b) t = 'Os dois períodos são o mesmo mês: escolha meses diferentes para comparar.';
    else if (a && b && a > b) t = 'O Período 1 é DEPOIS do Período 2: o que subiu vai aparecer como queda. Toque em "Inverter".';
    PER.av.hidden = !t; PER.av.textContent = t;
    PER.box.classList.toggle('is-alerta', !!t);
  }

  /* ═══ [R1] TEXTOS E REGRAS DO RESUMO ════════════════════════════════════════════════════
     GANHO     verba do tipo Provento que incide no líquido; DESCONTO = Desconto que incide no líquido
               (a regra da região Totais da 200:21). LÍQUIDO = ganhos − descontos.
     ENCARGOS  verbas do tipo Informativa (FGTS, INSS da empresa… conforme o cadastro da verba).
     TOTAIS    as verbas 996–999 e 9996–9999 são os totais da própria folha: não entram em nada.
     PARA CONFERIR  (sempre que achar alguma coisa — com um mês só, também)
       VERBA MUDOU    do penúltimo para o último mês: nova, que sumiu, ou que mudou mais de MUDOU_PCT %
                      e mais de MUDOU_MIN reais.
       LOCAL MUDOU    no 1º nível com mais de um membro (a filial, o setor…): ganhos que apareceram,
                      sumiram ou mudaram mais de LOCAL_PCT % e mais de LOCAL_MIN reais.
       NEGATIVO       verba com total negativo no último mês; local com líquido negativo (descontos
                      maiores que os ganhos).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var PROCESSO = 'NC_CONSOL_RESUMO';
  var MUDOU_PCT = 20, MUDOU_MIN = 500, LOCAL_PCT = 20, LOCAL_MIN = 5000;
  var GUARDA = 'nc-cf-aberto', GUARDA_NIV = 'nc-cf-nivel', GUARDA_FILTROS = 'nc-cf-filtros:';
  var MESES = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  function mesTxt(m) { return MESES[+m.slice(4, 6) - 1] + '/' + m.slice(0, 4); }
  function eTotal(verba) { var c = +partes(verba)[0]; return (c >= 996 && c <= 999) || (c >= 9996 && c <= 9999); }
  /* o NOME como está no banco (o que vem depois do primeiro " - "): é ele que vai no filtro da tabela */
  function nomeDe(t) { t = String(t == null ? '' : t); var i = t.indexOf(' - '); return i >= 0 ? t.slice(i + 3) : t; }
  function codDe(t) { t = String(t == null ? '' : t); var i = t.indexOf(' - '); return i >= 0 ? t.slice(0, i) : ''; }
  /* o banco guarda em MAIÚSCULAS; para ler, a primeira letra de cada palavra (siglas continuam siglas) */
  var SIGLAS = /^(FGTS|INSS|IRRF|IR|DSR|PLR|PPR|VT|VR|VA|CLT|CIPA|PAT|SAT|RAT|FAP|CTPS|PIS|PASEP|ATS|CCT|ACT|EPI|ASO|RH|DP|TI|CPF|CNPJ|UF|LTDA|S\/A|SA|ME|EPP|II|III|IV|VI|VII|VIII|IX|XI|XII|XIII)$/;
  var MIUDAS = { de: 1, da: 1, do: 1, das: 1, dos: 1, e: 1, em: 1, a: 1, o: 1, na: 1, no: 1, nas: 1, nos: 1, com: 1, por: 1, para: 1, sem: 1, ao: 1, 'à': 1 };
  function bonito(t) {
    t = String(t == null ? '' : t);
    /* já tem minúsculas: fica como está, só as palavras pequenas no meio descem ("Salários E Ordenados") */
    if (t !== t.toUpperCase()) return t.replace(/ (E|De|Da|Do|Das|Dos|Em|Na|No|Nas|Nos|Com|Por|Para|Sem|Ao) (?=\S)/g, function (m, w) { return ' ' + w.toLowerCase() + ' '; });
    return t.toLowerCase().replace(/[^\s\/()\-.,]+/g, function (w, i) {
      var W = w.toUpperCase();
      if (SIGLAS.test(W)) return W;
      if (i > 0 && MIUDAS[w]) return w;
      return w.charAt(0).toUpperCase() + w.slice(1);
    });
  }
  /* "350 - SALARIO" → <em>350</em>Salario (o código miúdo na frente) */
  function rotulo(t) {
    var c = codDe(t), n = c ? nomeDe(t) : String(t || '');
    return (c ? '<em>' + esc(c) + '</em>' : '') + esc(bonito(n.trim() || t));
  }
  function rotuloTxt(t) { var c = codDe(t); return (c ? c + ' - ' : '') + bonito((c ? nomeDe(t) : t).trim()); }

  /* ═══ [R2] OS DADOS ═════════════════════════════════════════════════════════════════════ */
  var ITENS = [];                       /* os campos que vão com o pedido: configurar() [M1] */
  function buscar(forcar) {
    var k = 'nc-cf-dados2:' + CAMPO + ':' + P.ir + ':' + ITENS.map(function (i) { try { var v = document.getElementById(i) ? apex.item(i).getValue() : ''; return Array.isArray(v) ? v.join(':') : v; } catch (e) { return ''; } }).join('|'), c = null;
    try { c = JSON.parse(sessionStorage.getItem(k) || 'null'); } catch (e) { /* ok */ }
    if (!forcar && c && c.d && Date.now() - c.t < 10 * 60 * 1000) { desenhar(c.d, c.t); return; }
    carregando();
    var itens = ITENS.filter(function (i) { return document.getElementById(i); }).map(function (i) { return '#' + i; }).join(',');
    apex.server.process(PROCESSO, { x01: P.ir, x02: MODO !== 'consol' ? atual() : '', pageItems: itens }, { dataType: 'json', error: function () { /* tratado no .fail */ } })
      .done(function (d) {
        pararCalculo();
        if (!d || d.erro) return erro(d && d.erro);
        try { sessionStorage.setItem(k, JSON.stringify({ t: Date.now(), d: d })); } catch (e) { /* cheio: só não guarda */ }
        try { desenhar(d, Date.now()); } catch (e) { erro(e && e.message); }
      })
      .fail(function (x) { pararCalculo(); erro(x && (x.status === 404 || (x.status === 200 && !x.responseText)) ? 'processo ausente' : (x && x.responseText || '').slice(0, 160)); });
  }

  /* ═══ [R3] A MOLDURA ═══════════════════════════════════════════════════════════════════ */
  var P = null;
  function relatorioNaTela() {
    var r = [].filter.call(document.querySelectorAll('[id^="IR_"]'), function (e) { return /^IR_\d+$/.test(e.id); })[0];
    return r || null;
  }
  function montar() {
    if (P) return true;
    var ir = relatorioNaTela();
    if (!ir) { comoUsar(); return false; }
    ir.classList.add('nc-reg-sim');
    var x = FORMA[atual()];
    var caixa = el('section', 'nc-af nc-cf');
    caixa.setAttribute('aria-labelledby', 'nc-cf-titulo');
    caixa.innerHTML =
      '<header class="nc-af-cab"><h2 id="nc-cf-titulo">' + (COMP ? 'Comparação da folha' : MODO === 'tab' ? 'Os últimos fechamentos da folha' : 'Resumo da folha') + '</h2>' +
      '<p class="nc-af-quando" aria-live="polite"></p><span class="nc-af-espaco"></span>' +
      '<button type="button" class="nc-af-bt" data-af-ir-tabela>' + ic('descer') + '<span>Ir para a tabela</span></button>' +
      '<button type="button" class="nc-af-bt" data-cf-atualiza hidden>' + ic('atualiza') + '<span>Atualizar</span></button>' +
      '<button type="button" class="nc-af-bt" data-cf-esconde aria-controls="nc-cf-corpo"></button></header>' +
      '<div class="nc-af-corpo" id="nc-cf-corpo"></div>';
    /* DENTRO da região, antes do relatório: depois do Pesquisar a própria página maximiza a tabela
       (ação "Expandir IR após Pesquisa") — o resumo vai junto, no alto da tela maximizada */
    var w = document.getElementById(ir.id + '_ir');
    if (w && w.parentNode === ir) ir.insertBefore(caixa, w); else ir.parentNode.insertBefore(caixa, ir);
    P = { caixa: caixa, corpo: caixa.querySelector('.nc-af-corpo'), quando: caixa.querySelector('.nc-af-quando'), botao: caixa.querySelector('[data-cf-esconde]'),
          ir: ir.id, forma: x, filtro: null, nivel: 0, fx: [],
          ref: null,                         /* o MÊS CONFERIDO (AAAAMM); vazio = o último da pesquisa */
          ord: {}, so: {}, tabs: {},         /* por tabela: ordem, "só o que mudou", o que está na tela (copiar) */
          varRS: false,                      /* variação em R$ (true) ou em % */
          series: { g: 1, d: 1, l: 1, media: 1 } };
    try { P.nivelNome = localStorage.getItem(GUARDA_NIV) || ''; } catch (e) { /* ok */ }
    var aberto = false; try { aberto = localStorage.getItem(GUARDA) === '1'; } catch (e) { /* ok */ }
    abrirFechar(aberto);
    caixa.addEventListener('click', clique);
    caixa.addEventListener('change', mudou);
    caixa.addEventListener('mouseover', function (e) { var g = e.target.closest && e.target.closest('.nc-cf-gm'); if (g) leitura(g.getAttribute('data-cf-mes')); });
    caixa.addEventListener('focusin', function (e) { var g = e.target.closest && e.target.closest('.nc-cf-gm'); if (g) leitura(g.getAttribute('data-cf-mes')); });
    caixa.addEventListener('mouseout', function (e) {
      var gr = e.target.closest && e.target.closest('.nc-cf-graf'); if (!gr || (e.relatedTarget && gr.contains(e.relatedTarget))) return;
      leitura(P.A.ult);
    });
    caixa.addEventListener('scroll', function (e) { if (e.target.classList && e.target.classList.contains('nc-cf-tab')) rolando(e.target); }, true);
    return true;
  }
  /* antes de pesquisar: o que fazer, no lugar da tabela */
  function comoUsar() {
    if (document.querySelector('.nc-cf-comousar')) return;
    var alvo = document.querySelector('.t-Body-contentInner .container, .t-Body-contentInner');
    if (!alvo) return;
    var b = el('section', 'nc-cf-comousar');
    b.innerHTML = COMP ? '<h2>Comparar a folha de dois meses em 3 passos</h2><ol>' +
      '<li>' + ic('passo1') + '<div><b>Escolha como ver</b><span>Em "Ver a folha por", à esquerda: a empresa toda, por filial, por setor, por cargo…</span></div></li>' +
      '<li>' + ic('calend') + '<div><b>Escolha a empresa e os dois meses</b><span>Período 1 é o mês de antes; Período 2, o mês que você quer conferir. Os atalhos embaixo deles escolhem por você.</span></div></li>' +
      '<li>' + ic('lupa') + '<div><b>Toque em Pesquisar</b><span>Aparece o que mudou de um mês para o outro (ganhos, descontos, líquido, verbas) e a tabela com cada verba.</span></div></li></ol>'
      : MODO === 'tab' ? '<h2>Ver os últimos 18 fechamentos em 3 passos</h2><ol>' +
      '<li>' + ic('passo1') + '<div><b>Escolha como ver</b><span>Em "Ver a folha por", à esquerda: a empresa toda, por filial, por setor, por cargo…</span></div></li>' +
      '<li>' + ic('calend') + '<div><b>Escolha a empresa</b><span>Não precisa escolher meses: a página mostra sempre os 18 fechamentos mais recentes, lado a lado.</span></div></li>' +
      '<li>' + ic('lupa') + '<div><b>Toque em Pesquisar</b><span>Aparece o resumo mês a mês (ganhos, descontos, líquido, o que fugiu do normal) e a tabela com cada verba.</span></div></li></ol>'
      : '<h2>Conferir a folha em 3 passos</h2><ol>' +
      '<li>' + ic('passo1') + '<div><b>Escolha como ver</b><span>Em "Ver a folha por", à esquerda: a empresa toda, por filial, por setor, por cargo…</span></div></li>' +
      '<li>' + ic('calend') + '<div><b>Escolha a empresa e os meses</b><span>Um mês para conferir o fechamento; dois ou mais para comparar.</span></div></li>' +
      '<li>' + ic('lupa') + '<div><b>Toque em Pesquisar</b><span>Aparece o resumo (ganhos, descontos, líquido, o que mudou) e a tabela com cada verba.</span></div></li></ol>';
    alvo.insertBefore(b, alvo.firstChild);
  }
  function abrirFechar(aberto) {
    P.caixa.classList.toggle('is-fechado', !aberto);
    P.botao.setAttribute('aria-expanded', String(aberto));
    P.botao.innerHTML = ic(aberto ? 'fechar' : 'abrir') + '<span>' + (aberto ? 'Mostrar menos' : 'Ver análise completa') + '</span>';
    try { if (aberto) localStorage.setItem(GUARDA, '1'); else localStorage.removeItem(GUARDA); } catch (e) { /* ok */ }
    if (aberto) setTimeout(ajustarMeses, 0);
  }
  function clique(e) {
    var b = e.target.closest('button'); if (!b || !P.caixa.contains(b)) return;
    if (b.hasAttribute('data-cf-esconde')) return abrirFechar(P.caixa.classList.contains('is-fechado'));
    if (b.hasAttribute('data-cf-num')) { var k = b.getAttribute('data-cf-num'); P.filtro = P.filtro === k ? null : k; desenharNumeros(); return; }
    if (b.hasAttribute('data-af-revela')) { revelar(b.previousElementSibling, +b.getAttribute('data-af-revela'), true); return; }
    if (b.hasAttribute('data-cf-f')) { filtrar(P.fx[+b.getAttribute('data-cf-f')]); return; }
    if (b.hasAttribute('data-af-ir-tabela')) { irParaTabela(); return; }
    if (b.hasAttribute('data-cf-mes')) { escolherMes(b.getAttribute('data-cf-mes'), b); return; }
    if (b.hasAttribute('data-cf-serie')) { var sr = b.getAttribute('data-cf-serie'); P.series[sr] = P.series[sr] ? 0 : 1; redesenhar(b); return; }
    if (b.hasAttribute('data-cf-varmodo')) { P.varRS = b.getAttribute('data-cf-varmodo') === 'rs'; redesenhar(b); return; }
    if (b.hasAttribute('data-cf-so')) { var ks = b.getAttribute('data-cf-so'); P.so[ks] = !P.so[ks]; redesenhar(b); return; }
    if (b.hasAttribute('data-cf-copia')) { copiar(b.getAttribute('data-cf-copia'), b); return; }
    if (b.hasAttribute('data-cf-ord')) {
      var o = b.getAttribute('data-cf-ord').split('|'), at = P.ord[o[0]];
      /* 1º toque: nome de A a Z, números do maior para o menor; tocar de novo inverte */
      P.ord[o[0]] = { c: o[1], d: at && at.c === o[1] ? -at.d : (o[1] === 'n' ? 1 : -1) };
      redesenhar(b); return;
    }
    if (b.hasAttribute('data-cf-tenta') || b.hasAttribute('data-cf-atualiza')) buscar(true);
  }
  /* redesenha a análise e devolve o foco ao mesmo botão (o de antes foi trocado) */
  function seletorDe(b) {
    var a = ['data-cf-mes', 'data-cf-serie', 'data-cf-varmodo', 'data-cf-so', 'data-cf-ord'].filter(function (x) { return b.hasAttribute(x); })[0];
    var c = b.closest('.nc-cf-mesref, .nc-cf-mt, .nc-cf-graf, .nc-cf-leg, .nc-af-regua, .nc-af-periodo');
    var pre = c ? '.' + c.className.split(' ')[0] + ' ' : '';
    return a ? pre + '[' + a + '="' + b.getAttribute(a) + '"]' : '';
  }
  function redesenhar(b) {
    var sel = b ? seletorDe(b) : '';
    desenharAnalise();
    mesesEmNumeros();
    focar(sel);
  }
  function focar(sel) {
    if (!sel) return;
    var n = P.caixa.querySelector(sel); if (n) n.focus({ preventScroll: true });
  }
  /* o MÊS CONFERIDO: os números, o "Para conferir" e a coluna em destaque passam a ser dele (comparado
     com o mês anterior a ele) */
  function escolherMes(m, b) {
    if (!m || m === P.A.ult || COMP) return;      /* na comparação o conferido é sempre o Período 2 */
    var sel = b ? seletorDe(b) : '';
    P.ref = m; P.fx = [];
    P.A = agregar(P.dados, m);
    if (P.filtro === 'c' && !P.A.conferir.length) P.filtro = null;
    desenharNumeros();
    desenharAnalise();
    focar(sel);
  }
  function mudou(e) {
    if (e.target.matches('select[data-cf-nivel]')) {
      P.nivel = +e.target.value; P.nivelNome = (P.dados.niveis[P.nivel] || {}).nome || '';
      try { localStorage.setItem(GUARDA_NIV, P.nivelNome); } catch (e2) { /* ok */ }
      desenharAnalise();
      var s = P.caixa.querySelector('select[data-cf-nivel]'); if (s) s.focus({ preventScroll: true });
    }
  }
  function calculando(passos) {
    var t0 = Date.now(), passo = -1;
    P.caixa.classList.add('is-calculando'); P.caixa.setAttribute('aria-busy', 'true');
    function tique() {
      var s = Math.floor((Date.now() - t0) / 1000), i = Math.min(passos.length - 1, Math.floor(s / 4));
      if (i !== passo) { passo = i; P.quando.innerHTML = '<span class="nc-af-pulso" aria-hidden="true"></span>' + passos[i] + '<span class="nc-af-seg" aria-hidden="true" hidden></span>'; }
      var seg = P.quando.querySelector('.nc-af-seg'); if (seg && s >= 3) { seg.hidden = false; seg.textContent = s + ' s'; }
    }
    tique();
    return setInterval(tique, 1000);
  }
  function pararCalculo() { clearInterval(P.lento); P.caixa.classList.remove('is-calculando'); P.caixa.removeAttribute('aria-busy'); }
  function carregando() {
    P.corpo.innerHTML = '<div class="nc-af-secao" aria-busy="true"><div class="nc-af-regua">' + ['carteira', 'carteira', 'carteira', 'pessoas', 'lupa'].map(function (i) {
      return '<div class="nc-af-num is-carregando"><span class="nc-af-sinal">' + ic(i) + '</span><span class="nc-af-valor"><i class="nc-af-esq" style="width:96px;height:26px"></i></span><span class="nc-af-diz"><i class="nc-af-esq" style="width:70px;height:12px"></i></span></div>';
    }).join('') + '</div></div>';
    P.quando.textContent = 'Somando…';
    P.caixa.querySelector('[data-cf-atualiza]').hidden = true;
    pararCalculo();
    P.lento = calculando(['Somando as verbas da tabela…', 'Separando ganhos, descontos e encargos…', 'Comparando os meses…', 'Ainda somando: a tabela tem muitas linhas']);
  }
  function erro(msg) {
    var falta = /processo ausente|NC_CONSOL|ERR-1002|not found/i.test(msg || '');
    P.quando.textContent = '';
    P.corpo.innerHTML = '<div class="nc-af-aviso" role="alert">' + ic('aviso') + '<div><b>Não foi possível montar o resumo agora.</b>' +
      (falta ? 'Falta instalar nesta página o processo ' + PROCESSO + ' (veja o guia ' + PAGINAS[MODO].guia + '-MANUTENCAO.md). A tabela abaixo funciona normalmente.'
             : 'A tabela abaixo continua funcionando. Tente de novo em instantes; se continuar, avise a equipe de sistemas.' + (msg ? ' <small>(' + esc(msg) + ')</small>' : '')) +
      '</div><span class="nc-af-espaco"></span><button type="button" class="nc-af-bt" data-cf-tenta>Tentar de novo</button></div>';
  }

  /* ═══ [R4] OS NÚMEROS ═══════════════════════════════════════════════════════════════════ */
  function desenhar(d, quando) {
    pararCalculo();
    P.caixa.classList.add('is-novo'); setTimeout(function () { P.caixa.classList.remove('is-novo'); }, 1400);
    P.dados = d;
    P.v2 = d.v >= 2;
    P.cols = d.cols || {};
    P.fx = [];
    P.nivel = 0;
    (d.niveis || []).forEach(function (n, i) { if (n.nome === P.nivelNome) P.nivel = i; });
    P.A = agregar(d, P.ref);
    if (P.ref && P.A.ult !== P.ref) P.ref = null;
    var A = P.A, x = P.forma, ultimo = A.meses[A.meses.length - 1];
    P.caixa.querySelector('[data-cf-atualiza]').hidden = false;
    P.quando.innerHTML = (A.meses.length ? '<b>' + (A.meses.length === 1 ? mesTxt(A.meses[0]) : mesTxt(A.meses[0]) + (COMP ? ' → ' : ' a ') + mesTxt(ultimo)) + '</b>' : 'Sem meses') +
      (x ? ' · por ' + x.c.join(' › ') : '') + (quando ? ' · calculado às ' + new Date(quando).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }) : '');
    P.corpo.innerHTML = '<div class="nc-af-secao"><div class="nc-cf-mesref" hidden></div><div class="nc-af-regua" role="group" aria-label="A folha no mês conferido"></div>' +
      '<div class="nc-af-quem" id="nc-cf-quem" hidden aria-live="polite"></div><div class="nc-cf-mt"></div></div><div class="nc-af-secao nc-af-periodo"></div>';
    desenharNumeros();
    desenharAnalise();
  }
  /* um filtro guardado para o botão (data-cf-f = posição na lista) */
  function fx(f) { if (!f || !f.col || !f.vals || !f.vals.length) return ''; P.fx.push(f); return ' data-cf-f="' + (P.fx.length - 1) + '"'; }
  function fVerbas(vbs, rot) { return { col: P.cols.rubn || 'NOME_COD_OCORR', vals: vbs.map(nomeDe), rot: rot, busca: vbs.length === 1 ? nomeDe(vbs[0]) : '', colBusca: P.cols.rubn || 'NOME_COD_OCORR' }; }
  function fMembros(nv, ts, rot) {
    if (!nv) return null;
    return { col: nv.colNome || nv.col, vals: ts.map(function (t) { return nv.colNome ? nomeDe(t) : (codDe(t) || t); }), rot: rot,
             busca: ts.length === 1 ? (nv.colNome ? nomeDe(ts[0]) : codDe(ts[0])) : '', colBusca: nv.colNome || nv.col };
  }

  function agregar(d, ref) {
    var nm = d.nomes || {}, tipo = nm.tipo || [], orig = nm.origem || [], verba = nm.verba || [], cat = nm.cat || [];
    var T = { meses: {}, porMes: {}, origem: {}, catG: {}, catD: {}, enc: {}, verbas: {} };
    /* cada linha de quadro guarda o valor de CADA mês (m) e as verbas que a compõem (vb) */
    function poe(o, k, m, v, vb) { var x = o[k] || (o[k] = { t: k, m: {}, vb: {} }); x.m[m] = (x.m[m] || 0) + v; if (vb) x.vb[vb] = 1; return x; }
    (d.rub || []).forEach(function (r) {
      var m = r[0], t = semAcento(tipo[r[2]]), liq = r[3] === 1, vb = verba[r[4]], v = +r[6] || 0;
      if (!m || eTotal(vb)) return;
      T.meses[m] = 1;
      var pm = T.porMes[m] || (T.porMes[m] = { g: 0, d: 0, e: 0 });
      var classe = t.indexOf('provento') === 0 && liq ? 'g' : t.indexOf('desconto') === 0 && liq ? 'd' : t.indexOf('informativa') === 0 ? 'e' : null;
      if (!classe) return;
      pm[classe] += v;
      if (classe === 'g') { poe(T.origem, orig[r[1]], m, v, vb); poe(T.catG, cat[r[5]], m, v, vb); }
      if (classe === 'd') poe(T.catD, cat[r[5]], m, v, vb);
      if (classe === 'e') poe(T.enc, vb, m, v, vb);
      var x = T.verbas[vb] || (T.verbas[vb] = { t: vb, classe: classe, cat: cat[r[5]], m: {}, p: {}, vb: {} });
      x.vb[vb] = 1; x.m[m] = (x.m[m] || 0) + v; x.p[m] = Math.max(x.p[m] || 0, +r[7] || 0);
    });
    /* ult = o MÊS CONFERIDO (o escolhido, ou o último da pesquisa); pen = o mês antes dele */
    var meses = d.ordem && d.ordem.length ? d.ordem.filter(function (m, i, a) { return m && a.indexOf(m) === i; }) : Object.keys(T.meses).sort(), iu = ref && meses.indexOf(ref) >= 0 ? meses.indexOf(ref) : meses.length - 1;
    var ult = meses[iu], pen = meses[iu - 1];
    meses.forEach(function (m) { T.porMes[m] = T.porMes[m] || { g: 0, d: 0, e: 0 }; });
    var tot = { g: 0, d: 0, e: 0 }; meses.forEach(function (m) { tot.g += T.porMes[m].g; tot.d += T.porMes[m].d; tot.e += T.porMes[m].e; });
    /* linhas de quadro: o valor do último mês manda na ordem; some quem não tem valor em mês nenhum */
    function lista(o) {
      return Object.keys(o).map(function (k) { var x = o[k]; x.q = x.m[ult] || 0; x.vbs = Object.keys(x.vb); return x; })
        .filter(function (x) { return meses.some(function (m) { return Math.abs(x.m[m] || 0) >= 0.01; }); })
        .sort(function (a, b) { return b.q - a.q || (b.m[pen] || 0) - (a.m[pen] || 0); });
    }
    /* o que mudou do penúltimo para o último mês, verba a verba */
    var mudancas = [];
    if (pen) Object.keys(T.verbas).forEach(function (k) {
      var x = T.verbas[k], a = x.m[pen] || 0, b = x.m[ult] || 0, dif = b - a;
      if (Math.abs(dif) < 0.01) return;
      var tipoM = !a && b ? 'nova' : a && !b ? 'sumiu' : Math.abs(dif) >= MUDOU_MIN && Math.abs(dif) / Math.abs(a) * 100 >= MUDOU_PCT ? 'mudou' : null;
      mudancas.push({ sec: 'verba', t: x.t, classe: x.classe, a: a, b: b, dif: dif, tipo: tipoM, pa: x.p[pen] || 0, pb: x.p[ult] || 0 });
    });
    mudancas.sort(function (p, q) { return Math.abs(q.dif) - Math.abs(p.dif); });
    var A = { meses: meses, ult: ult, pen: pen, porMes: T.porMes, tot: tot, pes: d.pessoas || {},
              origem: lista(T.origem), catG: lista(T.catG), catD: lista(T.catD), enc: lista(T.enc), verbas: lista(T.verbas) };
    A.conferir = achados(d, A, mudancas.filter(function (x) { return x.tipo; }));
    return A;
  }

  /* PARA CONFERIR: tudo o que foge do normal, em 3 grupos (a regra em [R1]) */
  function achados(d, A, verbas) {
    var ult = A.ult, pen = A.pen, xs = verbas.slice();
    /* valores negativos no último mês */
    A.verbas.forEach(function (x) {
      var b = x.m[ult] || 0;
      if (b < -0.01) xs.push({ sec: 'neg', t: x.t, classe: x.classe, b: b, pb: x.p[ult] || 0, tipo: 'negativo' });
    });
    /* os locais: o primeiro nível com mais de um membro (filial, setor…) */
    var nv = (d.niveis || []).filter(function (n) { return (n.membros || []).length > 1; })[0];
    if (nv) {
      var g = {};
      (nv.v || []).forEach(function (r) {
        var x = g[r[0]] || (g[r[0]] = { t: nv.membros[r[0]], u: 0, a: 0, du: 0, pu: 0, pa: 0 });
        if (r[1] === ult) { x.u += r[2]; x.du += r[3]; x.pu += r[4]; } else if (r[1] === pen) { x.a += r[2]; x.pa += r[4]; }
      });
      Object.keys(g).forEach(function (k) {
        var x = g[k], dif = x.u - x.a, tipoM = null;
        if (pen) tipoM = !x.a && x.u ? 'nova' : x.a && !x.u ? 'sumiu' : x.a && Math.abs(dif) >= LOCAL_MIN && Math.abs(dif) / Math.abs(x.a) * 100 >= LOCAL_PCT ? 'mudou' : null;
        if (tipoM) xs.push({ sec: 'local', nv: nv, t: x.t, a: x.a, b: x.u, dif: dif, tipo: tipoM, pa: x.pa, pb: x.pu });
        if (x.u - x.du < -0.01) xs.push({ sec: 'neg', nv: nv, t: x.t, b: x.u - x.du, g: x.u, d: x.du, tipo: 'liqneg' });
      });
    }
    xs.sort(function (p, q) { return Math.abs(q.dif != null ? q.dif : q.b) - Math.abs(p.dif != null ? p.dif : p.b); });
    return xs;
  }

  /* o valor de dinheiro de um cartão: "R$" miúdo e o número do tamanho que couber (--n = quantos
     caracteres; o CSS divide a largura do cartão por eles) */
  function rsCartao(v) {
    var t = rs(v), neg = t.charAt(0) === '-', n = t.replace(/^-?R\$/, '');
    return { h: (neg ? '-' : '') + '<small class="nc-cf-moeda">R$</small>' + n, n: n.length + (neg ? 1 : 0) + 1.6 };
  }
  function desenharNumeros() {
    var A = P.A, U = A.porMes[A.ult] || { g: 0, d: 0 }, Pn = A.porMes[A.pen], varios = A.meses.length > 1;
    var pesU = A.pes[A.ult] || 0, pesP = A.pen ? A.pes[A.pen] || 0 : 0, nM = A.meses.length;
    function comp(a, b) { return varios && Pn ? '<span class="nc-cf-comp' + (a > b ? ' is-sobe' : a < b ? ' is-desce' : '') + '">' + (a === b ? 'igual a ' : pctTxt(a, b) + ' sobre ') + mesTxt(A.pen) + '</span>' : ''; }
    var noMes = A.ult ? (COMP ? 'no ' + perTxt(A.ult) : 'em ' + mesTxt(A.ult)) : '';
    var nConf = A.conferir.length;
    /* comparação: o valor do Período 1 logo embaixo, para ler os dois juntos */
    function antes(v, fmt) { return COMP && A.pen ? '<span class="nc-cf-soma">Período 1 · ' + mesTxt(A.pen) + ': <b>' + (fmt || rs)(v) + '</b></span>' : ''; }
    var cards = [
      { k: 'g', cor: 'verde', ic: 'entra', diz: 'Ganhos', v: rsCartao(U.g), dica: noMes + antes(Pn && Pn.g), extra: comp(U.g, Pn && Pn.g) },
      { k: 'd', cor: 'rosa', ic: 'sai', diz: 'Descontos', v: rsCartao(U.d), dica: noMes + antes(Pn && Pn.d), extra: comp(U.d, Pn && Pn.d) },
      { k: 'l', cor: 'roxo', ic: 'carteira', diz: 'Líquido', v: rsCartao(U.g - U.d), dica: noMes + (COMP ? '' : ' · ganhos menos descontos') + antes(Pn && Pn.g - Pn.d), extra: comp(U.g - U.d, Pn && Pn.g - Pn.d) },
      { k: 'p', cor: 'roxo', ic: 'pessoas', diz: 'Pessoas na folha', v: { h: num(pesU), n: num(pesU).length }, dica: noMes + (pesU && !COMP ? ' · média de ' + rs(U.g / pesU) + ' em ganhos' : '') + antes(pesP, num), extra: comp(pesU, pesP) },
      { k: 'c', cor: nConf ? 'ambar' : 'verde', ic: nConf ? 'lupa' : 'marca', diz: 'Para conferir', v: { h: num(nConf), n: String(nConf).length }, lista: nConf > 0, alerta: nConf > 0,
        dica: nConf ? 'o que mudou muito ou está fora do normal em ' + mesTxt(A.ult) + ' · toque para ver'
                    : A.pen ? 'nada mudou muito de ' + mesTxt(A.pen) + ' para ' + mesTxt(A.ult) + ', nem há valor negativo'
                            : varios ? 'nenhum valor negativo · ' + mesTxt(A.ult) + ' é o 1º mês: não há anterior para comparar'
                                     : 'nenhum valor negativo · pesquise 2 meses ou mais para ver o que mudou' }
    ];
    /* o mês conferido: um botão por mês da pesquisa */
    var ch = P.caixa.querySelector('.nc-cf-mesref');
    ch.hidden = !varios;
    /* comparação: no lugar dos botões de mês, o que está sendo comparado (e o aviso de ordem trocada) */
    if (COMP) ch.innerHTML = !varios ? '' : '<span class="nc-cf-mesref-rot">' + ic('calend') + 'Comparando</span>' +
      '<span class="nc-cf-duelo"><span>Período 1<b>' + mesTxt(A.pen) + '</b></span>' + ic('tabela') + '<span class="is-p2">Período 2<b>' + mesTxt(A.ult) + '</b></span></span>' +
      '<span class="nc-cf-mesref-d">os números abaixo são do <b>Período 2</b>; o Período 1 aparece embaixo de cada um, para comparar</span>' +
      (A.pen > A.ult ? '<p class="nc-cf-duelo-av" role="note">' + ic('aviso') + '<span><b>Atenção: o Período 1 (' + mesTxt(A.pen) + ') é depois do Período 2 (' + mesTxt(A.ult) + ').</b> O que subiu aparece como queda. Para corrigir, toque em "Inverter" nos filtros e em Pesquisar.</span></p>' : '');
    else ch.innerHTML = !varios ? '' : '<span class="nc-cf-mesref-rot" id="nc-cf-mesref-rot">' + ic('calend') + 'Mês conferido</span>' +
      '<div class="nc-cf-mesref-l" role="group" aria-labelledby="nc-cf-mesref-rot">' + A.meses.map(function (m) {
        return '<button type="button" data-cf-mes="' + m + '" aria-pressed="' + (m === A.ult) + '">' + mesTxt(m) + '</button>';
      }).join('') + '</div><span class="nc-cf-mesref-d">' + (A.pen ? 'os números abaixo são de <b>' + mesTxt(A.ult) + '</b>, comparados com ' + mesTxt(A.pen)
        : '<b>' + mesTxt(A.ult) + '</b> é o primeiro mês: não há anterior para comparar') + ' · os outros meses estão na tabela logo abaixo dos números</span>';
    P.caixa.querySelector('.nc-af-regua').innerHTML = cards.map(function (c) {
      var on = P.filtro === c.k, toca = !!c.lista;
      return '<' + (toca ? 'button type="button" data-cf-num="' + c.k + '" aria-pressed="' + on + '" aria-controls="nc-cf-quem"' : 'div') +
        ' class="nc-af-num nc-af-num--' + c.cor + (c.alerta ? ' is-alerta' : '') + (toca ? '' : ' nc-cf-fixo') + '">' +
        '<span class="nc-af-sinal">' + ic(c.ic) + '</span><span class="nc-af-diz">' + c.diz + '</span>' +
        '<span class="nc-af-valor nc-cf-valor" style="--n:' + c.v.n + '">' + c.v.h + '</span>' +
        '<span class="nc-af-dica">' + c.dica + '</span>' + (c.extra || '') + '</' + (toca ? 'button' : 'div') + '>';
    }).join('');
    if (P.filtro === 'c' && !nConf) P.filtro = null;
    desenharLista();
    mesesEmNumeros();
  }
  /* MÊS A MÊS EM NÚMEROS: os números dos cartões em todos os meses, lado a lado (uma coluna por mês,
     a média do período e a variação do mês conferido). Tocar no mês = conferir aquele mês. */
  function mesesEmNumeros() {
    var box = P.caixa.querySelector('.nc-cf-mt'), A = P.A, ms = A.meses;
    if (ms.length < 2) { box.innerHTML = ''; return; }
    if (COMP) return doisPeriodos(box);
    function linha(rot, cls, f, fmt) {
      var x = { m: {} }, t = 0; ms.forEach(function (m) { x.m[m] = f(m); t += x.m[m]; });
      var vals = ms.map(function (m) { return '<span class="nc-cf-tl-v' + (m === A.ult ? ' is-ref' : '') + '">' + fmt(x.m[m]) + '</span>'; }).join('');
      return '<div class="nc-cf-tl"><span class="nc-cf-tl-nome"><span><i class="nc-cf-mt-' + cls + '" aria-hidden="true"></i>' + rot + '</span></span>' + vals +
        '<span class="nc-cf-tl-v nc-cf-mt-med">' + fmt(t / ms.length) + '</span>' + variacao(x.m[A.ult], x.m[A.pen], null, fmt) + '</div>';
    }
    var g = function (m) { return A.porMes[m].g; }, d = function (m) { return A.porMes[m].d; };
    var cab = '<div class="nc-cf-tl nc-cf-tl--cab"><span class="nc-cf-tl-nome"></span>' + ms.map(function (m) {
      return '<button type="button" class="nc-cf-th nc-cf-tl-v' + (m === A.ult ? ' is-ref' : '') + '" data-cf-mes="' + m + '" aria-pressed="' + (m === A.ult) + '" aria-label="' + mesTxt(m) +
        (m === A.ult ? ' (mês conferido)' : ' · conferir este mês') + '">' + MESES[+m.slice(4, 6) - 1] + '<em>/' + m.slice(2, 4) + '</em></button>';
    }).join('') + '<span class="nc-cf-th nc-cf-tl-v nc-cf-mt-med">Média</span><span class="nc-cf-th nc-cf-var">Variação</span></div>';
    box.innerHTML = '<div class="nc-cf-mt-cab"><h3>Mês a mês em números</h3><p>Toque num mês para conferi-lo · a variação é de ' +
      (A.pen ? mesTxt(A.pen) + ' para ' + mesTxt(A.ult) : mesTxt(A.ult)) + '</p></div>' +
      '<div class="nc-cf-tab" style="--cf-n:' + (ms.length + 1) + '"><div class="nc-cf-tab-in">' + cab +
      linha('Ganhos', 'g', g, rs) + linha('Descontos', 'd', d, rs) + linha('Líquido', 'l', function (m) { return g(m) - d(m); }, rs) +
      linha('Pessoas na folha', 'p', function (m) { return A.pes[m] || 0; }, function (v) { return num(Math.round(v)); }) +
      linha('Ganho médio por pessoa', 'p', function (m) { return A.pes[m] ? g(m) / A.pes[m] : 0; }, rs) +
      '</div></div>';
    ajustarMeses();
  }
  /* comparação: Período 1 · Período 2 · Diferença · Variação, linha a linha */
  function doisPeriodos(box) {
    var A = P.A, a = A.pen, z = A.ult;
    function linha(rot, cls, f, fmt) {
      var va = f(a), vz = f(z), d = vz - va;
      return '<div class="nc-cf-tl"><span class="nc-cf-tl-nome"><span><i class="nc-cf-mt-' + cls + '" aria-hidden="true"></i>' + rot + '</span></span>' +
        '<span class="nc-cf-tl-v">' + fmt(va) + '</span><span class="nc-cf-tl-v is-ref">' + fmt(vz) + '</span>' +
        '<span class="nc-cf-tl-v nc-cf-tl-dif">' + (Math.abs(d) < 0.005 ? '=' : (d > 0 ? '+' : '') + fmt(d)) + '</span>' + variacao(vz, va, null, fmt) + '</div>';
    }
    var g = function (m) { return A.porMes[m].g; }, d = function (m) { return A.porMes[m].d; };
    var cab = '<div class="nc-cf-tl nc-cf-tl--cab"><span class="nc-cf-tl-nome"></span>' + cabPeriodo(a, 1, '') + cabPeriodo(z, 2, ' is-ref') +
      '<span class="nc-cf-th nc-cf-tl-v nc-cf-tl-dif">Diferença</span><span class="nc-cf-th nc-cf-var">Variação</span></div>';
    box.innerHTML = '<div class="nc-cf-mt-cab"><h3>Os dois períodos em números</h3><p>do Período 1 (' + mesTxt(a) + ') para o Período 2 (' + mesTxt(z) + ')</p></div>' +
      '<div class="nc-cf-tab" style="--cf-n:3"><div class="nc-cf-tab-in">' + cab +
      linha('Ganhos', 'g', g, rs) + linha('Descontos', 'd', d, rs) + linha('Líquido', 'l', function (m) { return g(m) - d(m); }, rs) +
      linha('Pessoas na folha', 'p', function (m) { return A.pes[m] || 0; }, function (v) { return num(Math.round(v)); }) +
      linha('Ganho médio por pessoa', 'p', function (m) { return A.pes[m] ? g(m) / A.pes[m] : 0; }, rs) +
      '</div></div>';
    ajustarMeses();
  }
  /* o título de coluna de um período, em duas linhas: "Período 1" e o mês */
  function cabPeriodo(m, n, cls) { return '<span class="nc-cf-th nc-cf-th--2l nc-cf-tl-v' + cls + '"><small>Período ' + n + '</small>' + mesTxt(m) + '</span>'; }
  var CLASSE = { g: 'Ganho', d: 'Desconto', e: 'Encargo / informativa' };
  var SECOES = {
    verba: { tit: function (A) { return 'Verbas que mudaram de ' + mesTxt(A.pen) + ' para ' + mesTxt(A.ult); }, d: 'novas, que sumiram ou que mudaram mais de ' + MUDOU_PCT + '%' },
    local: { tit: function (A, nv) { return nv.nome + ': ganhos que mudaram muito'; }, d: 'apareceram, sumiram ou mudaram mais de ' + LOCAL_PCT + '% (e mais de ' + rs(LOCAL_MIN) + ')' },
    neg:   { tit: function (A) { return 'Valores negativos em ' + mesTxt(A.ult); }, d: 'estorno, devolução ou lançamento a conferir' }
  };
  function desenharLista() {
    var box = P.caixa.querySelector('.nc-af-quem');
    if (P.filtro !== 'c') { box.hidden = true; box.innerHTML = ''; return; }
    var A = P.A, xs = A.conferir, linhas = [];
    ['verba', 'local', 'neg'].forEach(function (s) {
      var grupo = xs.filter(function (x) { return x.sec === s; }); if (!grupo.length) return;
      var nv = grupo[0].nv, f = null;
      if (s === 'verba') f = fVerbas(grupo.map(function (x) { return x.t; }), plural(grupo.length, 'verba que mudou', 'verbas que mudaram'));
      else if (s === 'local') f = fMembros(nv, grupo.map(function (x) { return x.t; }), plural(grupo.length, 'item que mudou', 'itens que mudaram') + ' (' + nv.nome.toLowerCase() + ')');
      linhas.push('<li class="nc-cf-sec"><div><b>' + SECOES[s].tit(A, nv) + ' · ' + grupo.length + '</b><span>' + SECOES[s].d + '</span></div>' +
        (f && grupo.length > 1 ? '<button type="button" class="nc-af-bt nc-cf-sec-bt"' + fx(f) + '>' + ic('tabela') + '<span>Ver ' + (grupo.length === 2 ? 'as duas' : 'todas as ' + grupo.length) + ' na tabela</span></button>' : '') + '</li>');
      grupo.forEach(function (x) { linhas.push(linhaAchado(x)); });
    });
    box.hidden = false;
    box.innerHTML = '<div class="nc-af-quem-cab"><h3>Para conferir: ' + plural(xs.length, 'item', 'itens') + '</h3><p>' +
      (A.pen ? 'de ' + mesTxt(A.pen) + ' para ' + mesTxt(A.ult) + ' · ' : 'em ' + mesTxt(A.ult) + ' · ') + 'os que mais mexem no valor primeiro · toque para ver na tabela</p></div>' +
      rolo('ul', 'nc-af-lista', linhas, 40, ['item', 'itens']);
    ligarRolos(box);
  }
  function linhaAchado(x) {
    var A = P.A, f, quem, antes = '', depois, selo;
    var pess = function (n) { return n ? '<span>' + plural(n, 'pessoa', 'pessoas') + '</span>' : ''; };
    if (x.sec === 'local' || (x.sec === 'neg' && x.nv)) { f = fMembros(x.nv, [x.t], rotuloTxt(x.t)); quem = '<b>' + rotulo(x.t) + '</b><span>' + esc(x.nv.nome) + '</span>'; }
    else { f = fVerbas([x.t], rotuloTxt(x.t)); quem = '<b>' + rotulo(x.t) + '</b><span>' + CLASSE[x.classe] + '</span>'; }
    if (x.tipo === 'liqneg') {
      antes = 'Ganhos: ' + rs(x.g); depois = 'Descontos: ' + rs(x.d);
      selo = '<span class="nc-af-volta nc-af-volta--atrasada">Líquido negativo: ' + rs(x.b) + '</span>';
    } else if (x.tipo === 'negativo') {
      depois = mesTxt(A.ult) + ': ' + rs(x.b) + pess(x.pb);
      selo = '<span class="nc-af-volta nc-af-volta--atrasada">Valor negativo</span>';
    } else {
      antes = mesTxt(A.pen) + ': ' + rs(x.a) + pess(x.pa);
      depois = mesTxt(A.ult) + ': ' + rs(x.b) + pess(x.pb);
      if (COMP && x.tipo === 'nova' && x.sec === 'verba') { f = null; depois += '<span class="nc-cf-fora-tab">não aparece na tabela comparativa (ela parte do Período 1)</span>'; }
      selo = x.tipo === 'nova' ? '<span class="nc-af-volta nc-af-volta--sem">' + (x.sec === 'local' ? 'Apareceu' : 'Nova') + ' em ' + mesTxt(A.ult) + '</span>'
        : x.tipo === 'sumiu' ? '<span class="nc-af-volta nc-af-volta--atrasada">Sumiu em ' + mesTxt(A.ult) + '</span>'
        : '<span class="nc-af-volta ' + (x.dif > 0 ? 'nc-af-volta--sem' : 'nc-af-volta--logo') + '">' + (x.dif > 0 ? 'Subiu ' : 'Caiu ') + rs(Math.abs(x.dif)) + ' · ' + pctTxt(x.b, x.a) + '</span>';
    }
    return '<li><button type="button" class="nc-af-p nc-cf-p"' + fx(f) + (f ? ' title="Ver na tabela"' : ' disabled') + '>' +
      '<span class="nc-af-p-quem">' + quem + '</span><span class="nc-af-p-tipo">' + antes + '</span><span class="nc-af-p-desde">' + depois + '</span>' +
      selo + '<span class="nc-af-p-ir" aria-hidden="true">' + ic('tabela') + '</span></button></li>';
  }

  /* ═══ [R5] A ANÁLISE ════════════════════════════════════════════════════════════════════
     UM MÊS      cada quadro em barras, com o valor do mês.
     VÁRIOS      cada quadro numa tabela: uma coluna por mês, a linha Total e a variação do penúltimo
                 para o último — nunca um valor somado sem dizer de que mês é.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function desenharAnalise() {
    var A = P.A, U = A.porMes[A.ult], Pn = A.porMes[A.pen], pesU = A.pes[A.ult] || 0, varios = A.meses.length > 1;
    var frase = '';
    if (U) {
      frase = '<p class="nc-af-frase">' + (COMP ? 'No <b>' + perTxt(A.ult) + '</b>' : 'Em <b>' + mesTxt(A.ult) + '</b>') + ' a folha pagou <b>' + rs(U.g) + '</b> em ganhos' + (pesU ? ' a <b>' + plural(pesU, 'pessoa', 'pessoas') + '</b>' : '') +
        ', descontou <b>' + rs(U.d) + '</b> e o líquido foi <b>' + rs(U.g - U.d) + '</b>.';
      if (Pn) {
        var dif = U.g - Pn.g;
        frase += '<span class="nc-af-taxa">Comparado ' + (COMP ? 'ao ' + perTxt(A.pen) : 'a ' + mesTxt(A.pen)) + ': ganhos ' + (Math.abs(dif) < 0.01 ? 'iguais' : (dif > 0 ? '<b class="nc-cf-sobe">' + rs(dif) + ' a mais' : '<b class="nc-cf-desce">' + rs(-dif) + ' a menos') + ' (' + pctTxt(U.g, Pn.g) + ')</b>') + '.</span>';
      }
      frase += '<span class="nc-af-taxa">' + (A.conferir.length ? plural(A.conferir.length, 'item merece', 'itens merecem') + ' conferência (toque em "Para conferir", acima).' : 'Nada fora do normal para conferir.') + '</span>';
      if (U.e) frase += '<span class="nc-af-taxa">Encargos e informativas no mês (não saem do pagamento): ' + rs(U.e) + '.</span>';
      frase += '</p>';
    }
    var nv = (P.dados.niveis || [])[P.nivel];
    var deQue = COMP ? 'cada período' : varios ? 'cada mês' : mesTxt(A.ult);
    /* as ferramentas das tabelas que valem para todas: variação em % ou em R$, e a legenda do destaque */
    var ferr = !varios ? '' : COMP ? '<div class="nc-cf-ferr-g"><span class="nc-cf-ferr-rot">Diferença e variação</span><span class="nc-cf-ferr-d">do Período 1 (' + mesTxt(A.pen) +
      ') para o Período 2 (' + mesTxt(A.ult) + ') · âmbar = mudou mais de ' + MUDOU_PCT + '%, apareceu ou sumiu · toque no título de uma coluna para ordenar</span></div>' : '<div class="nc-cf-ferr-g"><span class="nc-cf-ferr-rot" id="nc-cf-var-rot">Variação em</span>' +
      '<div class="nc-cf-seg" role="group" aria-labelledby="nc-cf-var-rot">' +
      '<button type="button" data-cf-varmodo="pct" aria-pressed="' + !P.varRS + '">%</button><button type="button" data-cf-varmodo="rs" aria-pressed="' + P.varRS + '">R$</button></div>' +
      '<span class="nc-cf-ferr-d">de ' + (A.pen ? mesTxt(A.pen) + ' para ' + mesTxt(A.ult) : mesTxt(A.ult)) + ' · toque no título de uma coluna para ordenar</span>' +
      (A.meses.length > 2 ? '<span class="nc-cf-legfora"><i aria-hidden="true"></i>mês fora do normal da linha (mais de ' + MUDOU_PCT + '% longe do valor do meio)</span>' : '') + '</div>';
    var grade = P.caixa.querySelector('.nc-af-periodo');
    P.tabs = {};
    if (COMP) P.varRS = false;               /* a comparação mostra as duas: Diferença (R$) e Variação (%) */
    P.caixa.classList.toggle('is-var-rs', P.varRS);
    grade.innerHTML = '<p class="nc-af-rot">Para analisar</p>' + frase + ferr +
      '<div class="nc-af-quadros nc-af-quadros--3' + (varios ? ' nc-cf-grade' : '') + '" style="--cf-n:' + (COMP ? 3 : A.meses.length) + '">' +
      (varios ? graficoMeses() : '') +
      quadroT('orig', 'Por origem', 'Ganhos de ' + deQue + ' · de onde vêm (Folha, 13º, Rescisão…)', A.origem,
        { total: true, f: function (x) { return P.cols.orig ? { col: P.cols.orig, vals: [x.t], rot: 'a origem ' + bonito(x.t), busca: x.t, colBusca: P.cols.orig } : null; } }) +
      (P.dados.niveis && P.dados.niveis.length ? ondeEsta(nv, deQue) : '') +
      quadroT('catG', 'Para onde vai o dinheiro', 'Ganhos de ' + deQue + ', por grupo de verbas', A.catG,
        { total: true, f: function (x) { return fVerbas(x.vbs, plural(x.vbs.length, 'verba', 'verbas') + ' de ' + bonito(x.t)); } }) +
      quadroT('catD', 'Descontos', 'Descontos de ' + deQue + ', por grupo', A.catD,
        { total: true, f: function (x) { return fVerbas(x.vbs, plural(x.vbs.length, 'verba', 'verbas') + ' de ' + bonito(x.t)); } }) +
      quadroT('enc', 'Encargos e informativas', 'De ' + deQue + ' · não entram no líquido (FGTS, INSS empresa…)', A.enc,
        { total: true, f: function (x) { return fVerbas([x.t], rotuloTxt(x.t)); } }) +
      quadroT('verbas', 'As verbas que mais pesam', 'Ganhos e descontos de ' + deQue + ', do maior para o menor',
        A.verbas.filter(function (x) { return x.classe !== 'e'; }).sort(function (a, b) { return Math.abs(b.q) - Math.abs(a.q); }),
        { sub: function (x) { return CLASSE[x.classe]; }, f: function (x) { return fVerbas([x.t], rotuloTxt(x.t)); } }, 'nc-cf-q--verbas') +
      '</div>';
    ligarRolos(grade);
    ajustarMeses();
  }
  /* um quadro de dados: título, ferramentas da tabela (com 2 meses ou mais) e o corpo */
  function quadroT(k, tit, dica, xs, o, cls, extra) {
    o.key = k;
    var varios = P.A.meses.length > 1, nMud = varios ? xs.filter(forte).length : 0;
    var ferr = !varios || !xs.length ? '' : '<div class="nc-cf-ferr">' +
      (P.A.pen ? '<button type="button" class="nc-cf-ferr-bt" data-cf-so="' + k + '" aria-pressed="' + !!P.so[k] + '">' + ic('filtro') + '<span>Só o que mudou · ' + nMud + '</span></button>' : '') +
      '<button type="button" class="nc-cf-ferr-bt" data-cf-copia="' + k + '" title="Copia a tabela para colar no Excel">' + ic('copiar') + '<span>Copiar para o Excel</span></button></div>';
    return quadro(tit, dica, dados(xs, o), cls, (extra || '') + ferr);
  }
  function quadro(tit, dica, corpo, cls, extra) { return '<section class="nc-af-q' + (cls ? ' ' + cls : '') + '"><h3>' + tit + '</h3>' + (dica ? '<p>' + dica + '</p>' : '') + (extra || '') + corpo + '</section>'; }
  /* um mês: barras · vários: tabela por mês */
  function dados(xs, o) { return P.A.meses.length > 1 ? tabelaMeses(xs, o) : barras(xs, o); }
  function barras(xs, o) {
    if (!xs || !xs.length) return '<p class="nc-af-vazio-q">Nada neste período.</p>';
    var total = 0; if (o.total) xs.forEach(function (x) { total += x.q; });
    var max = Math.max.apply(null, xs.map(function (x) { return Math.abs(x.q); })) || 1;
    return rolo('ol', 'nc-af-barras', xs.map(function (x, i) {
      var pc = o.total && total ? Math.round(x.q / total * 100) : null, sub = o.sub ? o.sub(x) : '', f = o.f ? fx(o.f(x)) : '';
      var miolo = '<span class="nc-af-b-nome">' + rotulo(x.t) + '</span>' +
        '<span class="nc-af-b-trilho" aria-hidden="true"><i style="width:' + Math.max(3, Math.round(Math.abs(x.q) / max * 100)) + '%"></i></span>' +
        '<span class="nc-af-b-num">' + rs(x.q) + (pc != null ? ' <small>· ' + (pc < 1 ? '&lt;1' : pc) + '%</small>' : '') + (sub ? ' <small>· ' + sub + '</small>' : '') + '</span>';
      if (f) return '<li><button type="button" class="nc-af-b' + (i === 0 ? ' is-maior' : '') + '"' + f + ' title="Ver na tabela">' + miolo +
        '<span class="nc-af-b-ir" aria-hidden="true">Ver na tabela' + ic('tabela') + '</span></button></li>';
      return '<li><div class="nc-af-b nc-af-b--fixa' + (i === 0 ? ' is-maior' : '') + '">' + miolo + '</div></li>';
    }), 6, ['linha', 'linhas']);
  }
  /* número de célula: sem "R$" (o título diz), inteiro; o que não houve no mês é um traço */
  /* célula: R$1.234,90; o que não houve no mês é um traço; "fora" = foge da média da linha */
  function cel(v, cls, dica) {
    var c = 'nc-cf-tl-v' + (cls || '');
    if (!v || Math.abs(v) < 0.005) return '<span class="' + c + ' is-nada">—</span>';
    return '<span class="' + c + (v < 0 ? ' is-neg' : '') + '"' + (dica ? ' title="' + dica + '"' : '') + '>' + rs(v) + '</span>';
  }
  /* a mudança do mês anterior para o conferido: % ou R$ (o botão "Variação em"); forte = ≥ 20%, nova ou sumiu */
  function forte(x) {
    var A = P.A, a = x.m[A.pen] || 0, b = x.m[A.ult] || 0;
    if (!A.pen || (!a && !b)) return false;
    if (!a || !b) return true;
    return Math.abs(b - a) / Math.abs(a) * 100 >= MUDOU_PCT && Math.abs(b - a) >= MUDOU_MIN;
  }
  function pctN(x) { var A = P.A, a = x.m[A.pen] || 0, b = x.m[A.ult] || 0; return !a ? (b ? 1e9 : 0) : (b - a) / Math.abs(a) * 100; }
  function variacao(b, a, x, fmt) {
    fmt = fmt || rs;
    if (!P.A.pen || (!a && !b)) return '<span class="nc-cf-var"></span>';
    var f = x ? forte(x) : (!a || !b || Math.abs(b - a) / Math.abs(a) * 100 >= MUDOU_PCT);
    if (!a) return '<span class="nc-cf-var is-forte">nova</span>';
    if (!b) return '<span class="nc-cf-var is-forte">sumiu</span>';
    var d = b - a, p = d / Math.abs(a) * 100;
    var t = P.varRS ? (Math.abs(d) < 0.005 ? '=' : (d > 0 ? '+' : '') + fmt(d)) : (Math.abs(p) < 0.05 ? '=' : pctTxt(b, a));
    return '<span class="nc-cf-var' + (f ? ' is-forte' : '') + '" title="' + mesTxt(P.A.pen) + ' → ' + mesTxt(P.A.ult) + ': ' + (d > 0 ? '+' : '') + fmt(d) + ' (' + (pctTxt(b, a) || '=') + ')">' + t + '</span>';
  }
  /* a MEDIANA da linha (o valor do meio dos meses): o mês que foge dela mais de 20% (e de R$ 500) ganha
     destaque. Mediana e não média: um mês muito fora não puxa a referência e marca só ele. */
  function foraDaMedia(x, m, ms) {
    if (ms.length < 3) return null;
    var o = ms.map(function (k) { return x.m[k] || 0; }).sort(function (a, b) { return a - b; });
    var med = o.length % 2 ? o[(o.length - 1) / 2] : (o[o.length / 2 - 1] + o[o.length / 2]) / 2, v = x.m[m] || 0;
    return Math.abs(v - med) >= Math.max(MUDOU_MIN, Math.abs(med) * MUDOU_PCT / 100) ? med : null;
  }
  function tabelaMeses(xs, o) {
    if (!xs || !xs.length) return '<p class="nc-af-vazio-q">Nada neste período.</p>';
    var A = P.A, ms = A.meses, k = o.key, ord = P.ord[k] || { c: 'm:' + A.ult, d: -1 };
    var ys = P.so[k] ? xs.filter(forte) : xs.slice();
    ys.sort(function (a, b) {
      var r = ord.c === 'n' ? comparar(rotuloTxt(a.t), rotuloTxt(b.t))
        : ord.c === 'd' ? ((a.m[A.ult] || 0) - (a.m[A.pen] || 0)) - ((b.m[A.ult] || 0) - (b.m[A.pen] || 0))
        : ord.c === 'v' ? (P.varRS ? ((a.m[A.ult] || 0) - (a.m[A.pen] || 0)) - ((b.m[A.ult] || 0) - (b.m[A.pen] || 0)) : pctN(a) - pctN(b))
        : (a.m[ord.c.slice(2)] || 0) - (b.m[ord.c.slice(2)] || 0);
      return r * ord.d;
    });
    P.tabs[k] = { ys: ys, o: o };
    function th(c, rot, cls, fala) {
      var on = ord.c === c;
      return '<button type="button" class="nc-cf-th ' + cls + (on ? ' is-ord' : '') + '" data-cf-ord="' + k + '|' + c + '" aria-label="Ordenar por ' + fala +
        (on ? (ord.d > 0 ? ' (agora: do menor para o maior)' : ' (agora: do maior para o menor)') : '') + '">' + rot +
        (on ? ic(ord.d > 0 ? 'subir' : 'descer') : '') + '</button>';
    }
    var cab = '<div class="nc-cf-tl nc-cf-tl--cab">' + th('n', 'Nome', 'nc-cf-tl-nome', 'nome') +
      ms.map(function (m, i) {
        return COMP ? th('m:' + m, '<small>Período ' + (i + 1) + '</small>' + mesTxt(m), 'nc-cf-th--2l nc-cf-tl-v' + (m === A.ult ? ' is-ref' : ''), 'Período ' + (i + 1) + ', ' + mesTxt(m))
                    : th('m:' + m, MESES[+m.slice(4, 6) - 1] + '<em>/' + m.slice(2, 4) + '</em>', 'nc-cf-tl-v' + (m === A.ult ? ' is-ref' : ''), mesTxt(m));
      }).join('') + (COMP ? th('d', 'Diferença', 'nc-cf-tl-v nc-cf-tl-dif', 'diferença em reais') : '') +
      th('v', 'Variação', 'nc-cf-var', 'variação de ' + (A.pen ? mesTxt(A.pen) + ' para ' : '') + mesTxt(A.ult)) + '</div>';
    var tot = '';
    if (o.total) {
      var t = { m: {} }; ms.forEach(function (m) { t.m[m] = 0; xs.forEach(function (x) { t.m[m] += x.m[m] || 0; }); });
      tot = '<div class="nc-cf-tl nc-cf-tl--total"><span class="nc-cf-tl-nome">' + (P.so[k] ? 'Total (todas as linhas)' : 'Total') + '</span>' +
        ms.map(function (m) { return cel(t.m[m], m === A.ult ? ' is-ref' : ''); }).join('') + difCel(t) + variacao(t.m[A.ult], t.m[A.pen]) + '</div>';
    }
    if (!ys.length) return '<div class="nc-cf-tab"><div class="nc-cf-tab-in">' + cab + tot + '</div></div><p class="nc-af-vazio-q">Nada mudou mais de ' + MUDOU_PCT + '% de ' + mesTxt(A.pen) + ' para ' + mesTxt(A.ult) + '.</p>';
    var linhas = ys.map(function (x) {
      var f = o.f ? fx(o.f(x)) : '', sub = o.sub ? o.sub(x) : '';
      var fala = rotuloTxt(x.t) + ': ' + ms.map(function (m) { return mesTxt(m) + ' ' + rs(x.m[m] || 0); }).join(', ');
      var miolo = '<span class="nc-cf-tl-nome"><span>' + rotulo(x.t) + '</span>' + (sub ? '<small>' + sub + '</small>' : '') + '</span>' +
        ms.map(function (m) {
          var med = foraDaMedia(x, m, ms);
          return cel(x.m[m], (m === A.ult ? ' is-ref' : '') + (med != null ? ' is-fora' : ''), med != null ? mesTxt(m) + ' foge do normal desta linha (o valor do meio dos meses é ' + rs(med) + ')' : '');
        }).join('') + difCel(x) + variacao(x.m[A.ult] || 0, x.m[A.pen] || 0, x);
      return f ? '<li><button type="button" class="nc-cf-tl"' + f + ' aria-label="' + esc(fala) + ' · ver na tabela">' + miolo + '</button></li>'
               : '<li><div class="nc-cf-tl" aria-label="' + esc(fala) + '">' + miolo + '</div></li>';
    });
    return '<div class="nc-cf-tab"><div class="nc-cf-tab-in">' + cab + tot + rolo('ol', 'nc-cf-tls', linhas, 8, ['linha', 'linhas'], true) + '</div></div>';
  }
  /* comparação: a diferença em R$ do Período 1 para o 2 (sem cor de "bom/ruim": subir desconto não é erro) */
  function difCel(x) {
    if (!COMP) return '';
    var d = (x.m[P.A.ult] || 0) - (x.m[P.A.pen] || 0);
    return '<span class="nc-cf-tl-v nc-cf-tl-dif">' + (Math.abs(d) < 0.005 ? '=' : (d > 0 ? '+' : '') + rs(d)) + '</span>';
  }
  /* "Copiar para o Excel": as linhas como estão na tela (ordem e filtro), números sem R$ (o Excel lê
     "17.065.059,00" como número) */
  function copiar(k, b) {
    var T = P.tabs[k]; if (!T) return;
    var A = P.A, ms = A.meses;
    var linhas = [['Nome'].concat(ms.map(function (m, i) { return (COMP ? 'Período ' + (i + 1) + ' ' : '') + mesTxt(m); }), COMP ? ['Diferença (R$)'] : [], [A.pen ? 'Variação ' + mesTxt(A.pen) + ' > ' + mesTxt(A.ult) + (P.varRS ? ' (R$)' : ' (%)') : 'Variação'])];
    T.ys.forEach(function (x) {
      var a = x.m[A.pen] || 0, z = x.m[A.ult] || 0;
      linhas.push([rotuloTxt(x.t)].concat(ms.map(function (m) { return n2(x.m[m] || 0); }), COMP ? [n2(z - a)] : [],
        [!A.pen ? '' : P.varRS ? n2(z - a) : !a ? (z ? 'nova' : '') : !z ? 'sumiu' : n2((z - a) / Math.abs(a) * 100)]));
    });
    var txt = linhas.map(function (l) { return l.join('\t'); }).join('\n');
    function feito(ok) {
      var sp = b.querySelector('span'); if (!sp) return;
      var antes = sp.textContent;
      sp.textContent = ok ? 'Copiado: ' + plural(T.ys.length, 'linha', 'linhas') + ' · cole no Excel' : 'Não deu para copiar';
      b.classList.toggle('is-ok', ok);
      setTimeout(function () { sp.textContent = antes; b.classList.remove('is-ok'); }, 2600);
    }
    function velho() {
      var ta = el('textarea'); ta.value = txt; ta.setAttribute('readonly', ''); ta.style.cssText = 'position:fixed;top:0;left:-9999px;opacity:0';
      document.body.appendChild(ta); ta.select();
      var ok = false; try { ok = document.execCommand('copy'); } catch (e) { /* sem cópia */ }
      ta.remove(); b.focus({ preventScroll: true }); feito(ok);
    }
    if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(txt).then(function () { feito(true); }, velho);
    else velho();
  }
  function verNivel() {
    var ns = P.dados.niveis || [];
    if (ns.length < 2) return '';
    return '<label class="nc-af-ver-por"><span>por</span><select data-cf-nivel aria-label="Onde está o custo: ver por">' +
      ns.map(function (n, i) { return '<option value="' + i + '"' + (i === P.nivel ? ' selected' : '') + '>' + esc(n.nome) + '</option>'; }).join('') + '</select></label>';
  }
  /* ganhos por membro do nível, mês a mês, com as pessoas do último mês */
  /* ganhos por membro do nível, mês a mês, com as pessoas do mês conferido */
  function ondeEsta(nv, deQue) {
    if (!nv) return '';
    var A = P.A, g = {};
    (nv.v || []).forEach(function (r) {
      var x = g[r[0]] || (g[r[0]] = { t: nv.membros[r[0]], m: {}, p: 0 });
      x.m[r[1]] = (x.m[r[1]] || 0) + r[2];
      if (r[1] === A.ult) x.p += r[4];
    });
    var xs = Object.keys(g).map(function (k) { var x = g[k]; x.q = x.m[A.ult] || 0; return x; })
      .filter(function (x) { return A.meses.some(function (m) { return Math.abs(x.m[m] || 0) >= 0.01; }); })
      .sort(function (a, b) { return b.q - a.q || (b.m[A.pen] || 0) - (a.m[A.pen] || 0); });
    return quadroT('onde:' + nv.nome, 'Onde está o custo', 'Ganhos de ' + deQue + ' · toque para ver na tabela', xs,
      { total: true, sub: function (x) { return x.p ? plural(x.p, 'pessoa', 'pessoas') + (A.meses.length > 1 ? ' em ' + mesTxt(A.ult) : '') : ''; },
        f: function (x) { return fMembros(nv, [x.t], rotuloTxt(x.t)); } }, A.meses.length > 1 ? '' : 'nc-af-q--largo', verNivel());
  }
  /* ═ MÊS A MÊS ═ ganhos, descontos e líquido lado a lado; a linha tracejada é a média do período;
     passar o mouse (ou o foco) num mês mostra os valores dele embaixo; tocar = conferir aquele mês */
  function graficoMeses() {
    var A = P.A, S = P.series, ms = A.meses;
    var ser = [{ k: 'g', rot: 'Ganhos', v: function (m) { return A.porMes[m].g; } },
               { k: 'd', rot: 'Descontos', v: function (m) { return A.porMes[m].d; } },
               { k: 'l', rot: 'Líquido', v: function (m) { return A.porMes[m].g - A.porMes[m].d; } }];
    var vis = ser.filter(function (x) { return S[x.k]; });
    var max = Math.max.apply(null, [1].concat(vis.map(function (x) { return Math.max.apply(null, ms.map(function (m) { return Math.max(0, x.v(m)); })); })));
    var base = vis[0], med = 0;
    if (base) { ms.forEach(function (m) { med += base.v(m); }); med /= ms.length; }
    var leg = '<div class="nc-cf-leg" role="group" aria-label="O que mostrar no gráfico">' + ser.map(function (x) {
      return '<button type="button" class="nc-cf-leg-' + x.k + '" data-cf-serie="' + x.k + '" aria-pressed="' + !!S[x.k] + '"><i aria-hidden="true"></i>' + x.rot + '</button>';
    }).join('') + '<button type="button" class="nc-cf-leg-media" data-cf-serie="media" aria-pressed="' + !!S.media + '"><i aria-hidden="true"></i>Média' + (base ? ' (' + base.rot.toLowerCase() + ')' : '') + '</button></div>';
    var corpo = '<div class="nc-cf-graf" style="--cf-n:' + ms.length + '"><div class="nc-cf-graf-area' + (COMP ? ' is-2l' : '') + '">' +
      (S.media && base ? '<i class="nc-cf-graf-med" style="bottom:' + (med / max * 100).toFixed(2) + '%" aria-hidden="true"><span>média ' + rs(med) + '</span></i>' : '') +
      '<ol>' + ms.map(function (m) {
        var fala = mesTxt(m) + ': ' + ser.map(function (x) { return x.rot.toLowerCase() + ' ' + rs(x.v(m)); }).join(', ');
        return '<li><button type="button" class="nc-cf-gm' + (m === A.ult ? ' is-ref' : '') + '" data-cf-mes="' + m + '" aria-pressed="' + (m === A.ult) + '" aria-label="' + fala + (m === A.ult ? ' (mês conferido)' : ' · conferir este mês') + '">' +
          '<span class="nc-cf-gm-b">' + vis.map(function (x) { return '<i class="is-' + x.k + '" style="height:' + Math.max(1, Math.max(0, x.v(m)) / max * 100).toFixed(2) + '%"></i>'; }).join('') + '</span>' +
          '<span class="nc-cf-gm-m">' + (COMP ? '<small>Período ' + (ms.indexOf(m) + 1) + '</small>' : '') + MESES[+m.slice(4, 6) - 1] + '<em>/' + m.slice(2, 4) + '</em></span></button></li>';
      }).join('') + '</ol></div><div class="nc-cf-graf-le"></div></div>';
    return '<section class="nc-af-q nc-cf-q--graf"><div class="nc-cf-q-cab"><div><h3>' + (COMP ? 'Período 1 × Período 2' : 'Mês a mês') + '</h3><p>' +
      (COMP ? 'Passe o mouse num período para ver os valores' : 'Passe o mouse num mês para ver os valores · toque para conferir aquele mês') + '</p></div>' + leg + '</div>' + corpo + '</section>';
  }
  /* a leitura embaixo do gráfico: o mês apontado (ou o conferido), com a mudança sobre o mês anterior */
  function leitura(m) {
    var box = P && P.caixa.querySelector('.nc-cf-graf-le'), A = P && P.A; if (!box || !A || !A.porMes[m]) return;
    var i = A.meses.indexOf(m), ant = A.porMes[A.meses[i - 1]], v = A.porMes[m];
    function item(rot, cls, a, b) {
      return '<span class="nc-cf-le-' + cls + '"><i aria-hidden="true"></i>' + rot + ' <b>' + rs(a) + '</b>' + (b != null && ant ? ' <small>' + (pctTxt(a, b) || '=') + '</small>' : '') + '</span>';
    }
    box.innerHTML = '<b class="nc-cf-le-mes">' + perTxt(m) + (m === A.ult && !COMP ? ' · mês conferido' : '') + '</b>' +
      item('Ganhos', 'g', v.g, ant && ant.g) + item('Descontos', 'd', v.d, ant && ant.d) + item('Líquido', 'l', v.g - v.d, ant && ant.g - ant.d) +
      (A.pes[m] ? '<span>' + plural(A.pes[m], 'pessoa', 'pessoas') + '</span>' : '') +
      (ant ? '<span class="nc-cf-le-obs">variação sobre ' + perTxt(A.meses[i - 1]) + '</span>' : '');
  }
  function ajustarMeses() {
    if (!P) return;
    if (P.A) leitura(P.A.ult);
    /* tabela mais larga que o quadro (celular, muitos meses): começa no FIM — o último mês e a variação
       à vista, os meses anteriores rolando para a esquerda */
    [].forEach.call(P.caixa.querySelectorAll('.nc-cf-tab'), function (t) {
      if (t.scrollWidth > t.clientWidth) {
        /* o mês conferido logo depois do nome (e o que vem depois dele à vista) */
        var r = t.querySelector('.nc-cf-tl--cab .is-ref'), n = t.querySelector('.nc-cf-tl--cab .nc-cf-tl-nome');
        t.scrollLeft = r ? r.getBoundingClientRect().left - t.getBoundingClientRect().left + t.scrollLeft - (n ? n.offsetWidth : 0) : t.scrollWidth;
      }
      rolando(t);
    });
    /* os botões de mês, quando não cabem: o escolhido no meio */
    var l = P.caixa.querySelector('.nc-cf-mesref-l'), sel = l && l.querySelector('[aria-pressed="true"]');
    if (sel && l.scrollWidth > l.clientWidth) l.scrollLeft += sel.getBoundingClientRect().left - l.getBoundingClientRect().left - (l.clientWidth - sel.offsetWidth) / 2;
    /* gráfico de muitos meses em tela estreita: os nomes dos meses não cabem todos (CSS mostra 1 a cada 3 + o conferido) */
    var go = P.caixa.querySelector('.nc-cf-graf-area ol');
    if (go && go.children.length) go.classList.toggle('is-denso', go.clientWidth / go.children.length < 44);
    var ol = P.caixa.querySelector('.nc-af-meses'); if (!ol || !ol.children.length) return;
    ol.classList.toggle('is-denso', ol.clientWidth / ol.children.length < 34);
  }
  window.addEventListener('resize', function () { clearTimeout(window.__ncCfAj); window.__ncCfAj = setTimeout(ajustarMeses, 120); });
  function rolando(t) { t.classList.toggle('is-rolando', t.scrollLeft > 0); }

  /* listas que vão aparecendo (a mesma mecânica dos outros painéis); "soBotao" = sem rolar por
     dentro (as tabelas por mês rolam de lado: o "Mostrar mais" é só o botão) */
  function rolo(tag, cls, itens, passo, unid, soBotao) {
    return '<div class="nc-af-rolo' + (soBotao ? ' nc-cf-rolo-bt' : '') + '" data-cf-unid="' + unid.join('|') + '"><' + tag + ' class="' + cls + '">' +
      itens.map(function (h, i) { return i < passo ? h : h.replace(/^<li/, '<li hidden'); }).join('') +
      '</' + tag + '><span class="nc-af-sentinela" aria-hidden="true"></span></div>' +
      (itens.length > passo ? '<button type="button" class="nc-af-mais" data-af-revela="' + passo + '"></button>' : '');
  }
  function escondidos(r) { return r.querySelectorAll('li[hidden]'); }
  function revelar(r, passo, foco) {
    var lis = [].slice.call(escondidos(r), 0, passo);
    lis.forEach(function (li) { li.hidden = false; });
    if (foco && lis[0]) { var b = lis[0].querySelector('button, a, div'); (b || lis[0]).focus && (b || lis[0]).focus({ preventScroll: true }); lis[0].scrollIntoView({ block: 'nearest', behavior: 'smooth' }); }
    contar(r);
  }
  function contar(r) {
    var bt = r.nextElementSibling; if (!bt || !bt.hasAttribute('data-af-revela')) return;
    var falta = escondidos(r).length, passo = +bt.getAttribute('data-af-revela'), u = r.getAttribute('data-cf-unid').split('|');
    bt.hidden = !falta;
    bt.textContent = 'Mostrar mais ' + Math.min(passo, falta) + ' · ' + (falta === 1 ? 'falta 1 ' + u[0] : 'faltam ' + num(falta) + ' ' + u[1]);
  }
  function ligarRolos(raiz) {
    [].forEach.call(raiz.querySelectorAll('.nc-af-rolo'), function (r) {
      contar(r);
      var bt = r.nextElementSibling, passo = bt && bt.hasAttribute('data-af-revela') ? +bt.getAttribute('data-af-revela') : 0;
      if (!passo || !window.IntersectionObserver || r.classList.contains('nc-cf-rolo-bt')) return;
      var io = new IntersectionObserver(function (es) { if (es[0].isIntersecting && escondidos(r).length) revelar(r, passo); }, { root: r, rootMargin: '0px 0px 60px 0px' });
      io.observe(r.querySelector('.nc-af-sentinela'));
    });
  }

  /* ═══ [R6] VER NA TABELA ════════════════════════════════════════════════════════════════
     O FILTRO da própria tabela, igual ao que a pessoa faria em Ações › Filtro:
       um valor      "Nome Ocorrência = SALARIO"
       vários        "Nome Ocorrência em 'SALARIO,HORAS NORMAIS,…'"  (operador "em", separado por vírgula)
     Tocar de novo noutra coisa da MESMA coluna troca o filtro que o resumo pôs (não empilha um sobre o
     outro); os filtros que a pessoa pôs à mão ficam. Sem a versão 2 do processo (nomes exatos do banco),
     cai na busca da tabela, como antes.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function idsFiltros() {
    return [].map.call(document.querySelectorAll('#' + P.ir + '_ir input[data-setting="filter"][data-filter-id]'), function (e) { return e.getAttribute('data-filter-id'); });
  }
  /* os outros filtros LIGADOS na mesma coluna do filtro "id" — o título da coluna é o começo do texto
     do filtro ("Nome Ocorrência em '…'", "Nome Filial = '…'") */
  function textoFiltro(id) { var t = document.getElementById('control_text_' + id); return t ? t.textContent.trim() : ''; }
  function mesmaColuna(id) {
    var m = /^(.+?) (=|em|in|é igual a) '/i.exec(textoFiltro(id)); if (!m) return [];
    var col = m[1] + ' ';
    return [].filter.call(document.querySelectorAll('#' + P.ir + '_ir input[data-setting="filter"][data-filter-id]'), function (e) {
      var o = e.getAttribute('data-filter-id');
      return o !== id && e.checked && textoFiltro(o).indexOf(col) === 0;
    }).map(function (e) { return e.getAttribute('data-filter-id'); });
  }
  function meusFiltros(novo) {
    var k = GUARDA_FILTROS + P.ir;
    try { if (novo) sessionStorage.setItem(k, JSON.stringify(novo)); return novo || JSON.parse(sessionStorage.getItem(k) || '{}'); } catch (e) { return novo || {}; }
  }
  function filtrar(f) {
    if (!f) return;
    var vals = [], fora = 0;
    (f.vals || []).forEach(function (v) {
      v = String(v == null ? '' : v);
      if (!v.trim() || vals.indexOf(v) >= 0) return;
      if (v.indexOf(',') >= 0) { fora++; return; }      /* a vírgula separa os valores do "em": não dá para filtrar um nome que tem vírgula */
      vals.push(v);
    });
    while (vals.join(',').length > 3900) { vals.pop(); fora++; }
    var inst = null;
    try { inst = apex.jQuery('#' + P.ir + '_ir').interactiveReport('instance'); } catch (e) { /* sem o widget */ }
    if (!P.v2 || !f.col || !vals.length || !inst || typeof inst._action !== 'function') return naTabela(f.busca || vals[0] || '', f.colBusca);
    var meus = meusFiltros(), ant = meus[f.col], antes = idsFiltros();
    if (ant && antes.indexOf(ant) < 0) ant = null;
    irParaTabela();
    P.quando.textContent = 'Filtrando a tabela…';
    var pronto = false;
    function depois() {
      if (pronto) return; pronto = true;
      var novo = idsFiltros().filter(function (id) { return antes.indexOf(id) < 0; })[0] || ant;
      if (novo) { meus[f.col] = novo; meusFiltros(meus); }
      /* um filtro posto à mão na MESMA coluna somaria com este e a tabela ficaria vazia: é DESLIGADO
         (a caixinha dele fica desmarcada na lista de filtros; marcar de novo o traz de volta) */
      var outros = novo ? mesmaColuna(novo) : [];
      P.quando.innerHTML = 'A tabela agora mostra só ' + esc(f.rot || vals.join(', ')) + (fora ? ' (' + plural(fora, 'nome ficou', 'nomes ficaram') + ' de fora: tem vírgula no nome)' : '') +
        '. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.' +
        (outros.length ? ' O outro filtro desta coluna foi desligado; para voltar a usá-lo, marque a caixinha dele.' : '');
      (function desliga() {
        var id = outros.shift(); if (!id) return;
        apex.jQuery('#' + P.ir).one('apexafterrefresh', function () { setTimeout(desliga, 0); });
        inst._action('FILTER_TOGGLE', { id: id, value: 'N' });
      })();
    }
    apex.jQuery('#' + P.ir).one('apexafterrefresh', function () { setTimeout(depois, 0); });
    setTimeout(depois, 15000);
    if (ant) inst.currentColumnId = ant;
    inst._action('FILTER', { widgetActionMod: ant ? 'UPDATE' : 'ADD', f01: ['COLUMN', f.col, vals.length > 1 ? 'in' : '=', vals.join(','), '', ''], id: ant || f.col });
  }
  /* sem o processo novo: a busca do próprio relatório, numa coluna só (o mesmo que escolher a coluna
     na lupa e digitar) */
  function naTabela(texto, col) {
    var pre = P.ir, f = document.getElementById(pre + '_search_field'), b = document.getElementById(pre + '_search_button');
    if (!f || !b || !texto) return irParaTabela();
    irParaTabela();
    P.quando.textContent = 'Filtrando a tabela…';
    var t0 = Date.now();
    (function quandoLivre() {
      if (apex.jQuery.active > 0 && Date.now() - t0 < 8000) return setTimeout(quandoLivre, 120);
      var h = document.getElementById(pre + '_column_search_current_column');
      if (h) h.value = col || '';
      f.value = texto;
      b.click();
      P.quando.innerHTML = 'A tabela abaixo agora mostra só <b>' + esc(texto) + '</b>. Para ver tudo de novo, toque no <b>×</b> do filtro, em cima da tabela.';
    })();
  }
  function irParaTabela() {
    var ir = document.getElementById(P.ir + '_ir') || document.getElementById(P.ir); if (!ir) return;
    ir.scrollIntoView({ behavior: window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth', block: 'start' });
  }

  /* ═══ [R7] O COMEÇO ═════════════════════════════════════════════════════════════════════ */
  function iniciar() {
    if (window.__ncConsolIniciou) return;
    window.__ncConsolIniciou = true;
    configurar();
    try { montarPeriodos(); } catch (e) { if (window.console) console.warn('[Natcorp comparação]', e); }
    try { montarEscolha(); } catch (e) { if (window.console) console.warn('[Natcorp consolidação]', e); }
    if (montar()) buscar();
  }
  window.__ncConsolDesenhar = function (d) { if (!ITENS.length) configurar(); if (montar()) desenhar(d, Date.now()); };   /* para conferir com dados de teste */
  if (window.apex && apex.jQuery) {
    apex.jQuery(document).one('apexreadyend', iniciar);
    if (apex.jQuery.isReady) setTimeout(iniciar, 0);
  }
})();
